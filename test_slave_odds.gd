extends Control
#Temporary tool - delete this and test_slave_odds.tscn when the numbers have been read. It answers one
#question: how often does clearing a dungeon turn up a captive who already fits an open slave-market quest.
#Nothing here re-implements the rules. Dungeons are built with world_gen.make_location, captives are rolled
#by globals.roll_characters, quests come out of slave_quests.generate_quest and the verdict is
#slave_quests.quest_match - so any change to the dungeon, race or quest data shows up here on the next run.

const RANKS = ['D', 'C', 'B', 'A', 'S']
const KINDS = ['basic', 'advanced']
const FIGHT_TYPES = ['combat', 'combat_boss']

var sq
var dungeons = []
var busy = false


func _ready():
	sq = ResourceScripts.slave_quests
	ResourceScripts.revert_gamestate()
	_unlock_classes()
	_collect_dungeons()
	var strays = 0
	for entry in dungeons:
		$dungeon.add_item("%s   -   %s%s, %s" % [entry.code.replace("dungeon_", ""), entry.area,
			"" if entry.placed else "*", entry.difficulty])
		if !entry.placed:
			strays += 1
	for code in RANKS:
		$rank.add_item(code)
	$run.connect("pressed", self, "_run_one")
	$sweep.connect("pressed", self, "_run_sweep")
	$status.text = "%d dungeons, %d ranks. Pick and calculate." % [dungeons.size(), RANKS.size()]
	if strays > 0:
		$status.text += "  (* %d of them are in no land's pool and are measured in %s)" % [strays, dungeons[0].area]


#A quest may ask for an advanced class, and one still locked is skipped when the quest is built. A slaver
#who has reached these ranks would have them, so they are opened rather than left to skew every roll.
func _unlock_classes():
	var progress = ResourceScripts.game_progress
	for code in sq.quest_data.advanced_classes:
		if !progress.unlocked_classes.has(code):
			progress.unlocked_classes.append(code)


#Every ordinary dungeon template, not only the ones a land starts with. The area matters only where the
#dungeon's own race table says 'local', so a template no land claims is measured against the first land.
func _collect_dungeons():
	dungeons.clear()
	var home = {}
	var fallback = ''
	for land in worlddata.lands.values():
		if !land.get('enabled', false):
			continue
		if fallback == '':
			fallback = land.code
		for code in land.get('locationpool', []) + land.get('starting_locations', []):
			if !home.has(code):
				home[code] = land.code
	for code in DungeonData.dungeons:
		var template = DungeonData.dungeons[code]
		if template.get('type', '') != 'dungeon':
			continue
		#a questline's own location is not somewhere the player farms, and the tower is a different shape
		if template.get('tags', []).has('quest') or template.get('tags', []).has('infinite'):
			continue
		dungeons.append({
			code = code,
			area = home.get(code, fallback),
			placed = home.has(code),
			difficulty = template.get('difficulty', '?'),
			chance_mod = template.get('character_data', {}).get('chance_mod', 1.0),
		})
	dungeons.sort_custom(self, "_by_code")


func _by_code(a, b):
	return a.code < b.code


#### sampling ####

#A quest pool exactly as the rank would hold it: basic_slots basic and advanced_slots advanced, each one's
#difficulty rolled by the rank's own weights.
func _make_pool(rank):
	var progress = sq.get_progress()
	var was = progress.rank
	progress.rank = rank
	var data = sq.get_rank_data(rank)
	var res = []
	for kind in KINDS:
		for _i in range(int(data[kind + '_slots'])):
			res.append(sq.generate_quest(kind, sq.roll_difficulty()))
	progress.rank = was
	return res


#One full clear. Every combat room rolls its captives the way victory does, with the same rare / miniboss /
#boss context the real fight would arm. Returns {fights, captives, by_fight} - captives are ids in
#characters_pool, and by_fight keeps one list per fight so a per-fight chance can be counted.
func _clear_dungeon(entry, manhunt):
	var location = ResourceScripts.world_gen.make_location(entry.code, {code = entry.area})
	#manhunt reaches the roll only as 0.1 per point of the best two scouts, added to chance_mod, and only
	#where the dungeon declares a chance_mod at all - the same gate globals.roll_characters uses
	if manhunt > 0 and location.has('character_data') and location.character_data.has('chance_mod'):
		location.character_data = location.character_data.duplicate(true)
		location.character_data.chance_mod += manhunt * 0.1
	input_handler.active_area = {code = entry.area}
	input_handler.active_location = location
	var res = {fights = 0, captives = [], by_fight = [], from_boss = 0}
	var boss_fight = -1
	for level in range(location.dungeon.size()):
		var floor_data = ResourceScripts.game_world.dungeons[location.dungeon[level]]
		for room_name in floor_data.rooms:
			var room = ResourceScripts.game_world.rooms[room_name]
			if !FIGHT_TYPES.has(room.get('type', '')):
				continue
			if room.type == 'combat_boss':
				boss_fight = res.by_fight.size()
			res.fights += 1
			globals.reset_roll_data()
			globals.char_roll_data.diff = location.difficulty
			globals.char_roll_data.lvl = level
			globals.char_roll_data.rare = room.get('rare', false)
			globals.char_roll_data.mboss = room.get('miniboss', false)
			globals.char_roll_data.uniq = _has_boss_unit(room)
			var taken = globals.roll_characters()
			res.by_fight.append(taken)
			res.captives.append_array(taken)
	#a boss who is a person ends the dungeon in character_boss_defeat: one more slave on top of the rolls,
	#kept with capture_from_scene. He joins the household rather than the captives list, so unlike a captive
	#he may be trained before being handed over.
	if location.get('final_enemy_type', '') == 'character' and boss_fight >= 0:
		var prize = globals.make_local_recruit({races = [['dungeon', 1]], difficulty = [1, 2], type = 'slave'})
		res.by_fight[boss_fight].append(prize.id)
		res.captives.append(prize.id)
		res.from_boss = 1
	_drop_location(location)
	return res


#Only a story boss template carries the 'boss' tag, and only that flips char_roll_data.uniq - an ordinary
#dungeon boss room rolls captives on the plain odds.
func _has_boss_unit(room):
	for code in room.get('enemies', {}).values():
		if code == null:
			continue
		var base = str(code).trim_suffix("_rare").trim_suffix("_miniboss")
		if Enemydata.enemies.has(base) and Enemydata.enemies[base].get('tags', []).has('boss'):
			return true
	return false


func _drop_location(location):
	for floor_name in location.dungeon:
		if !ResourceScripts.game_world.dungeons.has(floor_name):
			continue
		for room_name in ResourceScripts.game_world.dungeons[floor_name].rooms:
			ResourceScripts.game_world.rooms.erase(room_name)
		ResourceScripts.game_world.dungeons.erase(floor_name)
	ResourceScripts.game_world.dungeon_events_assigned.clear()


#### measuring ####

func _blank_cell():
	return {
		runs = 0, fights = 0, captives = 0, from_boss = 0,
		green_captives = 0, yellow_captives = 0,
		runs_green = 0, runs_yellow = 0,
		green_total = 0, yellow_total = 0,
		by_type = {},
		by_req = {},
		show_pool = null,
	}


#One row per kind of demand, not per exact wording: the race list differs every time, but "one of three
#races" is the shape that decides how hard it is to answer.
func _req_key(req):
	match req.code:
		'race':
			return "race: one exact"
		'one_of_races':
			return "race: one of %d" % req.value.size()
		'sex':
			return "sex: %s" % str(req.value)
		'slave_type':
			return "trained slave"
		'base_stat':
			return "%s (base) at least %s" % [req.stat, str(req.value)]
		'stat_in_set':
			return "%s: %s or better" % [str(req.stat).replace("sex_training_", ""), str(req.value[0])]
		'has_profession':
			return "class: %s" % req.profession
		'stat':
			if req.stat == 'personality':
				if req.get('operant', 'eq') == 'in':
					return "personality: one of %d" % req.value.size()
				return "personality: one exact"
			return "%s at least %s" % [str(req.stat).replace("_factor", " factor"), str(req.value)]
	return str(req.code)


func _req_row(cell, req):
	var key = _req_key(req)
	if !cell.by_req.has(key):
		cell.by_req[key] = {quests = 0, pairs = 0, passed = 0}
	return cell.by_req[key]


#Counted per quest of this type, not per pool: how often ONE such quest is answered by a fight, and how
#often by a whole clear. fight_of / clear_of are the number of (fight, quest) and (clear, quest) pairs seen.
func _type_row(cell, quest):
	var key = "%s %s" % [quest.kind, quest.difficulty]
	if !cell.by_type.has(key):
		cell.by_type[key] = {quests = 0,
			fight_of = 0, fight_green = 0, fight_yellow = 0,
			clear_of = 0, clear_green = 0, clear_yellow = 0}
	return cell.by_type[key]


#Every rank asked for is judged on the SAME clears, so comparing two ranks is not a comparison of two
#different runs of luck. Returns {rank: cell}.
func _measure(entry, ranks, runs, manhunt):
	yield(get_tree(), "idle_frame")#always a coroutine, however early it returns
	var cells = {}
	#one pool drawn up front and held for the whole measurement, so every quest in it can be counted against
	#every captive of every clear. The odds on the left still come from a pool rolled fresh each clear, or a
	#single unlucky draw would decide them.
	var show = {}
	var show_marks = {}
	for rank in ranks:
		cells[rank] = _blank_cell()
		show[rank] = _make_pool(rank)
		show_marks[rank] = []
		for _q in range(show[rank].size()):
			show_marks[rank].append({green = 0, yellow = 0})
	for run in range(runs):
		var pools = {}
		var marks = {}
		for rank in ranks:
			pools[rank] = _make_pool(rank)
			marks[rank] = []
			for quest in pools[rank]:
				_type_row(cells[rank], quest).quests += 1
				for req in quest.requirements[0].statreqs:
					_req_row(cells[rank], req).quests += 1
				marks[rank].append({green = 0, yellow = 0})
		var trip = _clear_dungeon(entry, manhunt)
		var run_green = {}
		var run_yellow = {}
		for rank in ranks:
			cells[rank].runs += 1
			cells[rank].fights += trip.fights
			cells[rank].captives += trip.captives.size()
			cells[rank].from_boss += trip.from_boss
			run_green[rank] = 0
			run_yellow[rank] = 0
		for fight_ids in trip.by_fight:
			var fight_hit = {}
			for rank in ranks:
				fight_hit[rank] = []
				for _q in range(pools[rank].size()):
					fight_hit[rank].append('')
			for id in fight_ids:
				var person = characters_pool.get_char_by_id(id)
				for rank in ranks:
					var cell = cells[rank]
					var best = ''
					for q in range(pools[rank].size()):
						var status = sq.quest_match(pools[rank][q], person).status
						for req in pools[rank][q].requirements[0].statreqs:
							var req_row = _req_row(cell, req)
							req_row.pairs += 1
							if person.checkreqs(req):
								req_row.passed += 1
						if status == 'green':
							marks[rank][q].green += 1
							fight_hit[rank][q] = 'green'
							best = 'green'
						elif status == 'yellow':
							marks[rank][q].yellow += 1
							if fight_hit[rank][q] == '':
								fight_hit[rank][q] = 'yellow'
							if best == '':
								best = 'yellow'
					for q in range(show[rank].size()):
						var shown = sq.quest_match(show[rank][q], person).status
						if shown == 'green':
							show_marks[rank][q].green += 1
						elif shown == 'yellow':
							show_marks[rank][q].yellow += 1
					if best == 'green':
						cell.green_captives += 1
						run_green[rank] += 1
					elif best == 'yellow':
						cell.yellow_captives += 1
						run_yellow[rank] += 1
				characters_pool.remove_id(id)
			for rank in ranks:
				for q in range(pools[rank].size()):
					var row = _type_row(cells[rank], pools[rank][q])
					row.fight_of += 1
					if fight_hit[rank][q] == 'green':
						row.fight_green += 1
					elif fight_hit[rank][q] == 'yellow':
						row.fight_yellow += 1
		for rank in ranks:
			for q in range(pools[rank].size()):
				var row = _type_row(cells[rank], pools[rank][q])
				row.clear_of += 1
				if marks[rank][q].green > 0:
					row.clear_green += 1
				elif marks[rank][q].yellow > 0:
					row.clear_yellow += 1
			cells[rank].green_total += run_green[rank]
			cells[rank].yellow_total += run_yellow[rank]
			if run_green[rank] > 0:
				cells[rank].runs_green += 1
			if run_yellow[rank] > 0:
				cells[rank].runs_yellow += 1
		if run % 4 == 3:
			$status.text = "%s: clear %d of %d" % [entry.code, run + 1, runs]
			yield(get_tree(), "idle_frame")
	for rank in ranks:
		cells[rank].show_pool = {quests = show[rank], marks = show_marks[rank]}
	return cells


#### output ####

func _pc(part, whole):
	if whole <= 0:
		return "-"
	return "%.1f%%" % (100.0 * part / whole)


func _per(part, whole):
	if whole <= 0:
		return "-"
	return "%.2f" % (float(part) / whole)


#what fits as captured, and in brackets what only training would fit
func _both(green, yellow, whole):
	if whole <= 0:
		return "-"
	return "%s  (%s)" % [_pc(green, whole), _pc(yellow, whole)]


func _run_one():
	if busy:
		return
	busy = true
	var entry = dungeons[$dungeon.selected]
	var rank = RANKS[$rank.selected]
	var runs = int($runs.value)
	var manhunt = float($manhunt.value)
	var cells = yield(_measure(entry, [rank], runs, manhunt), "completed")
	var cell = cells[rank]
	$results/report.bbcode_text = _format_one(entry, rank, cell, manhunt)
	$quests/list.bbcode_text = _format_quests(rank, cell)
	$status.text = "done: %d clears, %d fights, %d captives" % [cell.runs, cell.fights, cell.captives]
	busy = false


#One pool spelled out, each quest counted against every captive of every clear, and below it every demand
#the freshly rolled pools made - which is where a low match rate is explained.
func _format_quests(rank, cell):
	if cell.show_pool == null:
		return "nothing sampled yet"
	var pool = cell.show_pool
	var text = "[b]A pool at rank %s against all %d captives[/b] of the %d clears.\n" % [
		rank, cell.captives, cell.runs]
	text += "These %d quests were drawn once and held, so the counts below share one denominator.\n\n" % pool.quests.size()
	for q in range(pool.quests.size()):
		var quest = pool.quests[q]
		var mark = pool.marks[q]
		var count = int(quest.requirements[0].value)
		text += "[b]%s %s[/b]  %s  -  %d gold%s\n" % [
			quest.kind, quest.difficulty, tr(quest.name), int(quest.rewards.gold),
			("  x%d slaves" % count) if count > 1 else ""]
		var lines = sq.requirement_lines(quest)
		for line in lines.basic:
			text += "    %s\n" % line
		for line in lines.advanced:
			text += "    %s   [i](trainable)[/i]\n" % line
		if mark.green > 0:
			text += "    [color=#7fd67f]%d of %d captives fit as captured  (%s)[/color]\n\n" % [
				mark.green, cell.captives, _pc(mark.green, cell.captives)]
		elif mark.yellow > 0:
			text += "    [color=#d6c47f]%d of %d captives would fit after training  (%s)[/color]\n\n" % [
				mark.yellow, cell.captives, _pc(mark.yellow, cell.captives)]
		else:
			text += "    [color=#9aa3b0]none of the %d captives fit[/color]\n\n" % cell.captives

	var quests_total = 0
	for row in cell.by_type.values():
		quests_total += row.quests
	text += "\n[b]Every demand the %d rolled quests made[/b], and how often a captive already met it.\n" % quests_total
	text += "[table=3][cell][b]demand[/b][/cell][cell][b]share of quests[/b][/cell]"
	text += "[cell][b]captives who meet it[/b][/cell]"
	for key in _sorted_reqs(cell):
		var row = cell.by_req[key]
		text += "[cell]%s[/cell][cell]%s[/cell][cell]%s[/cell]" % [
			key, _pc(row.quests, quests_total), _pc(row.passed, row.pairs)]
	return text + "[/table]"


func _sorted_reqs(cell):
	var pairs = []
	for key in cell.by_req:
		pairs.append([key, cell.by_req[key].quests])
	pairs.sort_custom(self, "_by_count")
	var res = []
	for pair in pairs:
		res.append(pair[0])
	return res


func _by_count(a, b):
	if a[1] == b[1]:
		return a[0] < b[0]
	return a[1] > b[1]


func _format_one(entry, rank, cell, manhunt):
	var data = sq.get_rank_data(rank)
	var text = "[b]%s[/b]  -  %s, difficulty %s, chance_mod %.2f%s\n" % [
		entry.code, entry.area, entry.difficulty, entry.chance_mod,
		("  +%.2f from manhunt %d" % [manhunt * 0.1, int(manhunt)]) if manhunt > 0 else ""]
	text += "rank [b]%s[/b]: %d basic + %d advanced open, weights %s\n\n" % [
		rank, int(data.basic_slots), int(data.advanced_slots), str(data.weights)]

	text += "[b]For ONE open quest of each type: the chance of turning up someone who fits it[/b]\n"
	text += "[table=4][cell][b]quest type[/b][/cell][cell][b]share of pool[/b][/cell]"
	text += "[cell][b]after 1 fight[/b][/cell][cell][b]in 1 clear[/b][/cell]"
	var quests_total = 0
	for row in cell.by_type.values():
		quests_total += row.quests
	for key in _sorted_types(cell):
		var row = cell.by_type[key]
		text += "[cell]%s[/cell][cell]%s[/cell][cell]%s[/cell][cell]%s[/cell]" % [
			key, _pc(row.quests, quests_total),
			_both(row.fight_green, row.fight_yellow, row.fight_of),
			_both(row.clear_green, row.clear_yellow, row.clear_of)]
	text += "[/table]\n"
	text += "[i]each cell: fits as captured, and in brackets the ones only training would fit[/i]\n\n"

	text += "[b]Against the whole open pool[/b]\n"
	text += "[table=3][cell][b] [/b][/cell][cell][b]green[/b][/cell][cell][b]yellow only[/b][/cell]"
	text += "[cell]a captive fits a quest[/cell][cell]%s[/cell][cell]%s[/cell]" % [
		_pc(cell.green_captives, cell.captives), _pc(cell.yellow_captives, cell.captives)]
	text += "[cell]after 1 fight[/cell][cell]%s[/cell][cell]%s[/cell]" % [
		_pc(cell.green_total, cell.fights), _pc(cell.yellow_total, cell.fights)]
	text += "[cell]in 1 clear[/cell][cell]%s[/cell][cell]%s[/cell]" % [
		_pc(cell.runs_green, cell.runs), _pc(cell.runs_yellow, cell.runs)]
	text += "[cell]expected per clear[/cell][cell]%s[/cell][cell]%s[/cell]" % [
		_per(cell.green_total, cell.runs), _per(cell.yellow_total, cell.runs)]
	text += "[/table]\n\n"

	if cell.from_boss > 0:
		text += "One of those each clear is the boss himself, who becomes a slave when the dungeon ends. "
		text += "He joins the household, not the captives list, so he may be trained before handing over.\n"
	text += "%d clears sampled: %s fights and %s people each.\n" % [
		cell.runs, _per(cell.fights, cell.runs), _per(cell.captives, cell.runs)]
	text += "green = fits as captured, which is what handing a captive over needs. "
	text += "yellow = would fit after training, so only if he is brought home first."
	return text


func _sorted_types(cell):
	var res = []
	for kind in KINDS:
		for difficulty in sq.DIFFICULTIES:
			var key = "%s %s" % [kind, difficulty]
			if cell.by_type.has(key):
				res.append(key)
	return res


func _run_sweep():
	if busy:
		return
	busy = true
	var runs = int($runs.value)
	var manhunt = float($manhunt.value)
	var rows = []
	for entry in dungeons:
		var cells = yield(_measure(entry, RANKS, runs, manhunt), "completed")
		var row = {code = entry.code, difficulty = entry.difficulty, cells = [],
			captives = _per(cells[RANKS[0]].captives, cells[RANKS[0]].runs)}
		for rank in RANKS:
			var cell = cells[rank]
			row.cells.append("%s (%s)" % [_pc(cell.runs_green, cell.runs), _per(cell.green_total, cell.runs)])
		rows.append(row)
		$results/report.bbcode_text = _format_sweep(rows, runs, manhunt)
		var shown = RANKS[$rank.selected]
		$quests/list.bbcode_text = "[i]%s, rank %s[/i]\n\n" % [entry.code, shown] + _format_quests(shown, cells[shown])
	$status.text = "sweep done: %d dungeons x %d ranks" % [dungeons.size(), RANKS.size()]
	busy = false


func _format_sweep(rows, runs, manhunt):
	var text = "[b]Every dungeon against every rank[/b] - the chance that one full clear yields a captive who "
	text += "already fits an open quest, with the expected number of them in brackets. "
	text += "%d clears each%s.\n\n" % [runs, (", manhunt %d" % int(manhunt)) if manhunt > 0 else ""]
	text += "[table=%d][cell][b]dungeon[/b][/cell][cell][b]diff[/b][/cell][cell][b]captives[/b][/cell]" % (RANKS.size() + 3)
	for rank in RANKS:
		text += "[cell][b]rank %s[/b][/cell]" % rank
	for row in rows:
		text += "[cell]%s[/cell][cell]%s[/cell][cell]%s[/cell]" % [row.code, row.difficulty, row.captives]
		for value in row.cells:
			text += "[cell]%s[/cell]" % value
	return text + "[/table]"
