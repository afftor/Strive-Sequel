extends Node
#The slave market's delivery quests and the slaver rank; numbers in slave_quests_data.gd, state in game_progress.slave_quests.
#statreqs are ordinary checkreqs lists; each entry also carries tier ('basic'/'advanced') and rq.

var quest_data = load("res://assets/data/slave_quests_data.gd").new()
var states = {
	active = 'taken',
	failed = 'failed',
	complete = 'complete',
}

signal quests_changed
signal rank_changed

const KINDS = ['basic', 'advanced']
const DIFFICULTIES = ['easy', 'medium', 'hard']
const BASIC_POOL = ['race', 'personality', 'factor', 'sex']
const ADVANCED_POOL = ['sex_skill', 'base_stat', 'consent', 'class', 'training']
const SEX_SKILLS_ANY = ['sex_training_petting', 'sex_training_oral', 'sex_training_anal']
const SEX_TRAINING_LEVELS = ['novice', 'skilled', 'mastered']
const CLASS_DEPTH = 4


#--------------state--------------

func get_progress():
	return ResourceScripts.game_progress.slave_quests

func get_quest_pool():
	return get_progress().quest_pool

func has_quest(quest_id):
	return quest_id != null and get_quest_pool().has(quest_id)

func get_quest(quest_id):
	return get_quest_pool()[quest_id]

func get_sorted_quests():
	var res = []
	for quest in get_quest_pool().values():
		if quest.has('kind'):
			res.append(quest)
	res.sort_custom(self, '_sort_quests')
	return res

func _sort_quests(a, b):
	var key_a = _quest_sort_key(a)
	var key_b = _quest_sort_key(b)
	for i in range(key_a.size()):
		if key_a[i] != key_b[i]:
			return key_a[i] < key_b[i]
	return false

func _quest_sort_key(quest):
	return [
		0 if quest.state == states.active else 1,
		KINDS.find(quest.kind),
		DIFFICULTIES.find(quest.difficulty),
		int(quest.id),
	]

func is_quest_open_for_delivery(quest):
	if quest == null or !quest.has('kind') or quest.state != states.active:
		return false
	var req = quest.requirements[0]
	return int(req.delivered_slaves) < int(req.value)


#--------------factions--------------

func get_faction(fact_id):
	return quest_data.factions[fact_id]

func get_faction_dynamic_data(fact_id):
	var progress = get_progress().factions
	if !progress.has(fact_id):#reinsurance, should not happen
		if !quest_data.factions.has(fact_id):
			push_error("get_faction_dynamic_data requests nonexisting faction %s" % fact_id)
		else:
			progress[fact_id] = quest_data.faction_dynamic_data_template.duplicate()
	return progress[fact_id]

func set_faction_factor(faction_id, value):
	get_faction_dynamic_data(faction_id).price_factor = float(value)

func process_faction_icon(node, fact_id):
	var faction = get_faction(fact_id)
	node.texture = faction.icon
	globals.connecttexttooltip(node, "%s\n%s" % [
		'[center]' + tr(faction.name) + '[/center]', tr(faction.description)])


#--------------rank--------------

func get_rank():
	return get_progress().rank

func get_rank_index(rank = null):
	if rank == null:
		rank = get_rank()
	for i in range(quest_data.ranks.size()):
		if quest_data.ranks[i].code == rank:
			return i
	return 0

func get_rank_data(rank = null):
	return quest_data.ranks[get_rank_index(rank)]

func is_max_rank():
	return get_rank_index() >= quest_data.ranks.size() - 1

func get_rank_xp():
	return int(get_progress().rank_xp)

func get_rank_sales():
	return int(get_progress().rank_sales)

func xp_threshold():
	if is_max_rank():
		return 0
	return int(get_rank_data().xp)

func sales_target():
	if is_max_rank():
		return 0
	return int(get_rank_data().sales)

func factor_upgrade_cap():
	return int(get_rank_data().factor_upgrade_cap)

func quest_xp(quest):
	var value = float(quest_data.xp[quest.kind])
	if quest_data.xp_decay.has(quest.difficulty):
		var decay = quest_data.xp_decay[quest.difficulty]
		if get_rank_index() >= get_rank_index(decay.from_rank):
			value *= decay.mult
	return int(round(value))

func add_rank_xp(amount):
	if is_max_rank():
		return
	var progress = get_progress()
	progress.rank_xp = int(min(int(progress.rank_xp) + int(amount), xp_threshold()))

func can_rank_up():
	return !is_max_rank() and get_rank_xp() >= xp_threshold() and get_rank_sales() >= sales_target()

#quest deliveries and captives sold off with a closing location do not count; `bought` matters at the top rank only
func on_slave_sold(count = 1, gold = 0, bought = 0):
	if count <= 0:
		return
	if is_max_rank():
		_on_top_rank_sale(count - bought, gold)
		return
	var progress = get_progress()
	var rank = get_rank()
	var target = sales_target()
	var before = int(progress.rank_sales)
	progress.rank_sales = int(min(before + count, target))
	var after = int(progress.rank_sales)
	var tokens = 0
	if before < target and after >= target:
		tokens += int(quest_data.tokens.sales_target)
		add_tokens(tokens)
	var rank_up = try_rank_up()
	if rank_up:
		tokens += rank_up_tokens(get_rank())
	var caption = globals._report_text("SQ_POPUP_RANK_CAPTION", [rank])
	if !rank_up and after >= target:
		caption = tr("SQ_SALE_TARGET_MET")
	show_rank_popup({
		title = tr("SQ_POPUP_SALE_TITLE"),
		caption = caption, icon = _icon(RANK_ICON), label = tr("SQ_POPUP_LABEL_SOLD"), count = "",
		max = target, from = before, to = after,
		gold = int(gold), tokens = tokens, rank = rank, new_rank = get_rank(), rank_up = rank_up,
	})

func _on_top_rank_sale(counted, gold):
	if counted <= 0:
		return
	var progress = get_progress()
	var cfg = quest_data.tokens.top_sales
	var every = int(cfg.every)
	var before = int(progress.get('top_sales', 0))
	var total = before + counted
	var rounds = int(total / every)
	progress.top_sales = total % every
	var tokens = rounds * int(cfg.tokens)
	add_tokens(tokens)
	var rank = get_rank()
	show_rank_popup({
		title = tr("SQ_POPUP_SALE_TITLE"),
		caption = tr("SQ_TOP_SALES_MET") if rounds > 0 else globals._report_text("SQ_POPUP_RANK_CAPTION", [rank]),
		icon = _icon(RANK_ICON), label = tr("SQ_POPUP_LABEL_SOLD"), count = "",
		max = every, from = before, to = every if rounds > 0 else int(progress.top_sales),
		gold = int(gold), tokens = tokens, rank = rank, new_rank = rank, rank_up = false,
	})

func try_rank_up():
	if !can_rank_up():
		return false
	var progress = get_progress()
	progress.rank = quest_data.ranks[get_rank_index() + 1].code
	progress.rank_xp = 0
	progress.rank_sales = 0
	add_tokens(rank_up_tokens(get_rank()))
	fill_quests()
	globals.mansion_activity_log_add("slaver_rank", globals._report_text("SQ_RANK_UP_LOG", [get_rank()]))
	emit_signal("rank_changed")
	return true


#--------------tokens of recognition--------------

signal tokens_changed
const TOKEN_ICON = "res://assets/Textures_v2/CITY/Icons/icon_reputationshop_reputation.png"

func get_tokens():
	return int(get_progress().get('tokens', 0))

func token_icon():
	return _icon(TOKEN_ICON)

func add_tokens(amount):
	if int(amount) <= 0:
		return
	get_progress().tokens = get_tokens() + int(amount)
	emit_signal("tokens_changed")

func quest_tokens(quest):
	var cfg = quest_data.tokens
	return int(cfg.quest[quest.kind]) + int(max(0, DIFFICULTIES.find(quest.difficulty))) * int(cfg.per_difficulty)

func rank_up_tokens(rank):
	var index = get_rank_index(rank)
	if index <= 0:
		return 0
	var cfg = quest_data.tokens.rank_up
	return int(cfg.first) + (index - 1) * int(cfg.step)

func mark_bought(character):
	var ids = get_progress().bought
	if !ids.has(character.id):
		ids.append(character.id)

func was_bought(character):
	return get_progress().bought.has(character.id)

func forget_bought(character):
	get_progress().bought.erase(character.id)


#--------------factor upgrades--------------


func can_upgrade_character(character):
	return (character != null and ResourceScripts.game_party.characters.has(character.id)
		and !character.is_on_quest())

func upgradable_factors(character):
	var res = []
	for code in quest_data.factor_upgrade.factors:
		if ResourceScripts.game_globals.diff_gf_only_upg and code != 'growth_factor':
			continue
		if character.is_master() and code in ['tame_factor', 'authority_factor']:
			continue
		res.append(code)
	return res

func factor_level(character, code):
	return int(floor(character.get_stat(code)))

func factor_upgrade_limit():
	return int(min(factor_upgrade_cap(), int(quest_data.factor_upgrade.top_level)))

func factor_step_cost(level):
	var cfg = quest_data.factor_upgrade
	if level >= int(cfg.top_level):
		return {tokens = int(cfg.top_tokens), gold = int(cfg.top_gold)}
	return {tokens = int(level), gold = int(cfg.gold_step)}

func upgrade_plan_cost(character, plan):
	var res = {tokens = 0, gold = 0, steps = 0}
	for code in plan:
		for level in range(factor_level(character, code) + 1, int(plan[code]) + 1):
			var cost = factor_step_cost(level)
			res.tokens += cost.tokens
			res.gold += cost.gold
			res.steps += 1
	return res

func upgrade_plan_problem(character, plan):
	if !can_upgrade_character(character):
		return tr("SQ_UPGRADE_NOT_HERE")
	var allowed = upgradable_factors(character)
	var cost = upgrade_plan_cost(character, plan)
	if cost.steps == 0:
		return tr("SQ_UPGRADE_NOTHING")
	for code in plan:
		if int(plan[code]) <= factor_level(character, code):
			continue
		if !allowed.has(code) or int(plan[code]) > factor_upgrade_limit():
			return tr("SQ_UPGRADE_PAST_LIMIT")
	if cost.tokens > get_tokens():
		return tr("SQ_UPGRADE_SHORT_TOKENS")
	if cost.gold > ResourceScripts.game_res.money:
		return tr("SQ_UPGRADE_SHORT_GOLD")
	return ''

func upgrade_plan_raises(character, plan):
	var res = []
	for code in quest_data.factor_upgrade.factors:
		if !plan.has(code):
			continue
		var from = factor_level(character, code)
		if int(plan[code]) > from:
			res.append({code = code, from = from, to = int(plan[code])})
	return res

func apply_upgrade_plan(character, plan, area = null):
	if upgrade_plan_problem(character, plan) != '':
		return false
	var cost = upgrade_plan_cost(character, plan)
	var raised = upgrade_plan_raises(character, plan)
	get_progress().tokens = get_tokens() - cost.tokens
	ResourceScripts.game_res.money -= cost.gold
	for step in raised:
		character.add_stat(step.code, step.to - step.from, true)
	input_handler.play_animation('factor_upgrade', {character = character, raised = raised, area = area})
	emit_signal("tokens_changed")
	return true


#--------------rank popup--------------

const POPUP_SCENE = "res://gui_modules/Exploration/Modules/SlaverRankPopup.tscn"
const RANK_ICON = "res://assets/Textures_v2/slave_quests/scales.png"
const POPUP_LAYER = 6 #over the reward animations (5), under the game menu (10) and dialogs (15)
var popup = null

func show_rank_popup(data):
	#a reward animation goes first: both sit at the top centre
	if !input_handler.animations_queue.empty():
		pending_popup = data
		if !input_handler.is_connected("animations_compleated", self, "_show_pending_popup"):
			input_handler.connect("animations_compleated", self, "_show_pending_popup", [], CONNECT_ONESHOT)
		return
	var node = get_rank_popup()
	if node == null:
		input_handler.SystemMessage("%s: %d/%d, +%d" % [data.title, data.to, data.max, data.gold])
		return
	node.show_progress(data)

var pending_popup = null

func _show_pending_popup():
	var data = pending_popup
	pending_popup = null
	if data != null:
		show_rank_popup(data)

func get_rank_popup():
	if popup != null and is_instance_valid(popup):
		return popup
	if !is_inside_tree() or !ResourceLoader.exists(POPUP_SCENE):
		return null
	var root = get_tree().get_root()
	var layer = root.get_node_or_null("SlaverRankPopupLayer")
	if layer == null:
		layer = CanvasLayer.new()
		layer.name = "SlaverRankPopupLayer"
		layer.layer = POPUP_LAYER
		root.add_child(layer)
	if layer.get_child_count() > 0:
		popup = layer.get_child(0)
	else:
		popup = load(POPUP_SCENE).instance()
		layer.add_child(popup)
	return popup

func set_rank(rank):
	var progress = get_progress()
	progress.rank = quest_data.ranks[get_rank_index(rank)].code
	progress.rank_xp = 0
	progress.rank_sales = 0
	fill_quests()
	emit_signal("rank_changed")

func rank_help_text():
	var text = tr("SQ_RANK_HELP")
	return text


#--------------lifecycle--------------

func fill_quests():
	if ResourceScripts.game_progress == null:
		return 0
	var rank_data = get_rank_data()
	var have = {basic = 0, advanced = 0}
	for quest in get_quest_pool().values():
		if !quest.has('kind') or quest.state == states.failed:
			continue
		have[quest.kind] += 1
	var added = 0
	for kind in KINDS:
		var slots = int(rank_data[kind + '_slots'])
		while have[kind] < slots:
			var quest = generate_quest(kind, roll_difficulty())
			get_quest_pool()[quest.id] = quest
			have[kind] += 1
			added += 1
	if added > 0:
		emit_signal("quests_changed")
	return added

func tick_quests():
	var pool = get_quest_pool()
	for quest_id in pool.keys():
		var quest = pool[quest_id]
		if !quest.has('kind'):
			pool.erase(quest_id)
			continue
		if quest.state == states.active:
			quest.time_limit = int(quest.time_limit) - 1
			if quest.time_limit <= 0:
				quest.state = states.failed
		if quest.state != states.active:
			pool.erase(quest_id)
	fill_quests()
	emit_signal("quests_changed")

#ids only count up: the market panel and the slave picker hold on to the id they were opened with
func make_quest_id():
	var progress = get_progress()
	var new_id = int(progress.next_id)
	while get_quest_pool().has(new_id):
		new_id += 1
	progress.next_id = new_id + 1
	return new_id

func roll_difficulty():
	var weights = get_rank_data().weights
	var array = []
	for difficulty in DIFFICULTIES:
		#a zero weight must not be offered at all: weightedrandom can still land on it
		if weights.get(difficulty, 0) > 0:
			array.append([difficulty, weights[difficulty]])
	if array.empty():
		return DIFFICULTIES[0]
	return input_handler.weightedrandom(array, globals.rng)

func generate_quest(kind, difficulty):
	var cfg = quest_data.basic[difficulty]
	var statreqs = []
	var count = 1

	var pool = BASIC_POOL.duplicate()
	if !cfg.count.empty():
		pool.append('count')
	var num
	if kind == 'advanced':
		num = _roll(quest_data.advanced[difficulty].basic_reqs)
	else:
		num = _roll(cfg.reqs)
	for rq in _draw(pool, num):
		if rq == 'count':
			count = _roll(cfg.count)
			continue
		_add_reqs(statreqs, [_make_basic_req(rq, cfg)], 'basic', rq)

	var gold = cfg.gold
	if kind == 'advanced':
		var adv = quest_data.advanced[difficulty]
		gold = adv.gold
		var adv_pool = ADVANCED_POOL.duplicate()
		var picks = []
		if adv.training == 'mandatory':
			adv_pool.erase('training')
			if count <= 1:
				picks.append('training')
		picks.append_array(_draw(adv_pool, int(adv.adv_reqs) - picks.size()))
		for rq in picks:
			_add_reqs(statreqs, _make_advanced_reqs(rq, adv, statreqs), 'advanced', rq)
	_apply_class_altnames(statreqs)
	_narrow_sole_personality(statreqs)

	return {
		id = make_quest_id(),
		kind = kind,
		difficulty = difficulty,
		faction = _roll_faction(),
		name = _random_unused(quest_data.namepool[kind], 'name'),
		descript = _random_from(quest_data.descpool[kind]),
		state = states.active,
		time_limit = _roll(quest_data.deadline),
		requirements = [{
			code = 'slave_delivery',
			value = count,
			delivered_slaves = 0,
			statreqs = statreqs,
		}],
		rewards = {gold = _roll_gold(gold)},
		paid = 0,
	}


#--------------requirement builders--------------

func _narrow_sole_personality(statreqs):
	if statreqs.size() != 1:
		return
	var req = statreqs[0]
	if req.get('code') == 'stat' and req.get('stat') == 'personality' and req.value is Array and req.value.size() > 1:
		req.value = _random_from(req.value)
		req.operant = 'eq'

func _add_reqs(statreqs, reqs, tier, rq):
	for req in reqs:
		req.tier = tier
		req.rq = rq
		statreqs.append(req)

func _make_basic_req(rq, cfg):
	match rq:
		'race':
			return _req_race(cfg.races)
		'personality':
			var picked = _draw(quest_data.personalities, _roll([1, 2]))
			if picked.size() == 1:
				return {code = 'stat', stat = 'personality', operant = 'eq', value = picked[0]}
			return {code = 'stat', stat = 'personality', operant = 'in', value = picked}
		'factor':
			return {code = 'stat', stat = _random_from(quest_data.factor_stats), operant = 'gte',
				value = _roll(cfg.factor)}
		'sex':
			return getreq_sex_by_ratio()
	push_error("slave_quests: unknown basic requirement %s" % rq)
	return {code = 'false'}

func _make_advanced_reqs(rq, adv, statreqs):
	match rq:
		'sex_skill':
			return _reqs_sex_skills(statreqs, adv.sex_skills)
		'base_stat':
			return [{code = 'base_stat', stat = _random_from(quest_data.base_stats), operant = 'gte',
				value = _roll(adv.stat)}]
		'consent':
			return [{code = 'stat', stat = 'consent', operant = 'gte', value = _roll(adv.consent)}]
		'class':
			return _reqs_classes(adv.classes)
		'training':
			return [{code = 'slave_type', operant = 'eq', value = 'slave_trained'}]
	push_error("slave_quests: unknown advanced requirement %s" % rq)
	return []

func _req_race(race_cfg):
	var picked = _draw(_race_pool(race_cfg.tags), int(race_cfg.num))
	if picked.empty():
		picked = ['Human']
	var accepted = _with_kin(picked)
	if accepted.size() == 1:
		return {code = 'race', race = accepted[0], check = true}
	return {code = 'one_of_races', value = accepted}

func _race_pool(tags):
	var res = []
	for tag in tags:
		if !races.race_groups.has(tag):
			continue
		for race in races.race_groups[tag]:
			if res.has(race) or res.has(_kin_counterpart(race)):
				continue
			if !input_handler.globalsettings.furry and races.racelist[race].race_tags.has('beast'):
				continue
			res.append(race)
	return res

func _kin_counterpart(race):
	var other = ''
	if race.begins_with('Beastkin'):
		other = race.replace('Beastkin', 'Halfkin')
	elif race.begins_with('Halfkin'):
		other = race.replace('Halfkin', 'Beastkin')
	return other if races.racelist.has(other) else ''

func _kin_races(race):
	var other = _kin_counterpart(race)
	if other == '' or !input_handler.globalsettings.furry:
		return [race]
	return [race, other] if race.begins_with('Beastkin') else [other, race]

func _with_kin(race_list):
	var res = []
	for race in race_list:
		for kin in _kin_races(race):
			if !res.has(kin):
				res.append(kin)
	return res

func _pair_kin_races(statreq):
	var accepted = []
	match statreq.get('code'):
		'race':
			if !statreq.get('check', true):
				return
			accepted = [statreq.race]
		'one_of_races':
			accepted = statreq.value
		_:
			return
	var paired = _with_kin(accepted)
	if paired.size() == accepted.size():
		return
	statreq.erase('race')
	statreq.erase('check')
	statreq.code = 'one_of_races'
	statreq.value = paired

#it is different from get_random_sex()
func getreq_sex_by_ratio():
	var sex
	if input_handler.globalsettings.futa and randf() <= input_handler.globalsettings.futachance * 0.01:
		sex = 'futa'
	elif randf() <= input_handler.globalsettings.malechance * 0.01:
		sex = 'male'
	else:
		sex = 'female'
	return {code = "sex", operant = "eq", value = sex}

func getreq_roll_sex_training(stat, level, operant):
	var levels = SEX_TRAINING_LEVELS
	if operant == 'gte':
		return {code = "stat_in_set", stat = stat, value = levels.slice(levels.find(level), levels.size() - 1)}
	if operant == 'lte':
		return {code = "stat_in_set", stat = stat, value = levels.slice(0, levels.find(level))}
	return {code = "stat", stat = stat, operant = 'eq', value = level}

func _reqs_sex_skills(statreqs, patterns):
	var pattern = _random_from(patterns)
	var pool = _sex_skill_pool(statreqs)
	var res = []
	for level in ['mastered', 'skilled']:
		for i in range(int(pattern.get(level, 0))):
			if pool.empty():
				break
			var idx = globals.rng.randi_range(0, pool.size() - 1)
			res.append(getreq_roll_sex_training(pool[idx], level, 'gte'))
			pool.remove(idx)
	return res

func _sex_skill_pool(statreqs):
	var pool = SEX_SKILLS_ANY.duplicate()
	var sex = _sex_req_value(statreqs)
	if sex in ['female', 'futa']:
		pool.append('sex_training_pussy')
	if sex in ['male', 'futa']:
		pool.append('sex_training_penetration')
	if _race_req_all_long_tail(statreqs):
		pool.append('sex_training_tail')
	return pool

func _sex_req_value(statreqs):
	for req in statreqs:
		if req.code == 'sex' and req.operant == 'eq':
			return req.value
	return null

func _race_req_all_long_tail(statreqs):
	for req in statreqs:
		if req.code == 'race' and req.check:
			return _race_always_long_tail(req.race)
		if req.code == 'one_of_races':
			for race in req.value:
				if !_race_always_long_tail(race):
					return false
			return true
	return false

func _race_always_long_tail(race):
	var bodyparts = races.racelist[race].bodyparts
	if !bodyparts.has('tail') or bodyparts.tail.empty():
		return false
	for tail in bodyparts.tail:
		if !(tail in variables.longtails):
			return false
	return true

func _reqs_classes(patterns):
	var pattern = _random_from(patterns)
	var need_advanced = int(pattern.get('advanced', 0))
	var need_basic = int(pattern.get('basic', 0))
	var picked = []
	for prof in _draw_classes(_advanced_class_pool(), need_advanced, picked):
		picked.append(prof)
	need_basic += need_advanced - picked.size()
	for prof in _draw_classes(_basic_class_pool(), need_basic, picked):
		picked.append(prof)
	var res = []
	for prof in picked:
		res.append({code = 'has_profession', profession = prof, check = true})
	return res

func _draw_classes(pool, num, taken):
	var res = []
	var candidates = pool.duplicate()
	while res.size() < num:
		var usable = []
		for prof in candidates:
			if taken.has(prof) or res.has(prof):
				continue
			var clash = false
			for other in taken + res:
				if _classes_conflict(prof, other):
					clash = true
					break
			if !clash:
				usable.append(prof)
		if usable.empty():
			break
		res.append(_random_from(usable))
	return res

func _classes_conflict(a, b):
	for pair in [[a, b], [b, a]]:
		var data = classesdata.professions[pair[0]]
		if data.has('conflict_classes') and data.conflict_classes.has(pair[1]):
			return true
		for req in data.get('reqs', []):
			if (req.code == 'has_profession' and !req.get('check', true)
					and req.get('profession', req.get('value')) == pair[1]):
				return true
	return false

func _basic_class_pool():
	var res = []
	for prof in variables.master_starting_classes + variables.slave_starting_classes:
		if !res.has(prof) and _class_available(prof):
			res.append(prof)
	return res

func _advanced_class_pool():
	var res = []
	for prof in quest_data.advanced_classes:
		if _class_available(prof):
			res.append(prof)
	return res

func _class_available(prof, depth = 0):
	if depth > CLASS_DEPTH or !classesdata.professions.has(prof):
		return false
	var data = classesdata.professions[prof]
	for req in data.get('showupreqs', []):
		if req.code == 'class_unlocked' and !ResourceScripts.game_progress.if_class_unlocked(
				req['class'], req.get('check', true), req.get('operant', 'eq')):
			return false
	for req in data.get('reqs', []):
		if req.code == 'has_profession' and req.get('check', true):
			var base_prof = req.get('profession', req.get('value'))
			if base_prof != prof and !_class_available(base_prof, depth + 1):
				return false
	return true

func _apply_class_altnames(statreqs):
	var sex = _sex_req_value(statreqs)
	if sex == null:
		return
	for req in statreqs:
		if req.code != 'has_profession':
			continue
		var data = classesdata.professions[req.profession]
		if !data.has('altname') or !data.has('altnamereqs'):
			continue
		var alt = true
		for alt_req in data.altnamereqs:
			if alt_req.code != 'sex' or !input_handler.operate(alt_req.operant, sex, alt_req.value):
				alt = false
				break
		if alt:
			req.altname = true

func _roll_faction():
	var pool = []
	for fact_id in quest_data.factions:
		var faction = quest_data.factions[fact_id]
		if faction.has('gen_req') and !globals.checkreqs(faction.gen_req):
			continue
		pool.append(fact_id)
	if pool.empty():
		return quest_data.factions.keys()[0]
	return _random_unused(pool, 'faction')

func _random_unused(options, field):
	var used = []
	if ResourceScripts.game_progress != null:
		for quest in get_quest_pool().values():
			if quest.has(field):
				used.append(quest[field])
	var unused = []
	for option in options:
		if !used.has(option):
			unused.append(option)
	if unused.empty():
		return _random_from(options)
	return _random_from(unused)

func _roll_gold(gold_cfg):
	var value = int(gold_cfg[0]) + globals.rng.randi_range(-int(gold_cfg[1]), int(gold_cfg[1]))
	return int(round(value / 10.0) * 10)

func _roll(val_range):
	return globals.rng.randi_range(int(val_range[0]), int(val_range[1]))

func _draw(pool, num):
	var array = pool.duplicate()
	var res = []
	for i in range(min(num, array.size())):
		var idx = globals.rng.randi_range(0, array.size() - 1)
		res.append(array[idx])
		array.remove(idx)
	return res

func _random_from(array):
	return input_handler.random_from_array(array, globals.rng)


#--------------matching--------------

#How a character fits a quest: 'green' as they are, 'yellow' after work, '' not at all.
func quest_match(quest, character):
	var res = {status = '', failed_basic = [], failed_advanced = [], unreachable = []}
	for req in quest.requirements[0].statreqs:
		if character.checkreqs(req):
			continue
		if req.get('tier', 'basic') != 'advanced':
			res.failed_basic.append(req)
		elif _advanced_req_reachable(req, character):
			res.failed_advanced.append(req)
		else:
			res.unreachable.append(req)
	if res.failed_basic.empty() and res.unreachable.empty():
		if res.failed_advanced.empty():
			res.status = 'green'
		else:
			res.status = 'yellow'
	return res

func _advanced_req_reachable(req, character):
	match req.get('rq', ''):
		'class':
			return _class_reachable(req.profession, character)
		'base_stat':
			var cap = character.get_stat(req.stat + '_cap')
			return !(cap is int or cap is float) or cap >= req.value
	return true

func _class_reachable(prof, character, depth = 0):
	if character.has_profession(prof):
		return true
	if depth > CLASS_DEPTH or !classesdata.professions.has(prof):
		return false
	var data = classesdata.professions[prof]
	var own = []
	for req in data.get('showupreqs', []) + data.get('reqs', []):
		if req.code == 'class_unlocked':
			continue
		if req.code == 'has_profession' and req.get('check', true):
			var base_prof = req.get('profession', req.get('value'))
			if base_prof == prof:
				continue
			if !_class_reachable(base_prof, character, depth + 1):
				return false
			continue
		own.append(req)
	return character.checkreqs(own, true)

func best_match_for(character):
	var res = {status = '', green = [], yellow = []}
	if character == null or character.is_unique():
		return res
	for quest in get_sorted_quests():
		if !is_quest_open_for_delivery(quest):
			continue
		var fit = quest_match(quest, character)
		if fit.status == 'green':
			res.green.append(quest)
		elif fit.status == 'yellow':
			res.yellow.append(quest)
	if !res.green.empty():
		res.status = 'green'
	elif !res.yellow.empty():
		res.status = 'yellow'
	return res

func star_tooltip(fit):
	var text = ''
	if !fit.green.empty():
		text += tr("SQ_STAR_GREEN")
		for quest in fit.green:
			text += "\n  " + quest_title(quest)
	if !fit.yellow.empty():
		if text != '':
			text += "\n"
		text += tr("SQ_STAR_YELLOW")
		for quest in fit.yellow:
			text += "\n  " + quest_title(quest)
	return text

func quest_title(quest):
	return tr(quest.name)

func quest_list_info(quest):
	if quest.state == states.complete:
		return tr("SQ_STATE_COMPLETE")
	var text = "%s %s" % [int(quest.time_limit), tr("QUESTDAYSLEFT")]
	var req = quest.requirements[0]
	if int(req.value) > 1:
		text += ", %s/%s" % [int(req.delivered_slaves), int(req.value)]
	return text

func requirement_lines(quest):
	var res = {basic = [], advanced = []}
	for statreq in quest.requirements[0].statreqs:
		var line = ResourceScripts.descriptions.make_slave_statreq_text(statreq)
		if statreq.get('tier', 'basic') == 'advanced':
			res.advanced.append(line)
		else:
			res.basic.append(line)
	return res


const REQ_ICON_PATHS = {
	personality_kind = "res://assets/Textures_v2/MANSION/personality_kind.png",
	personality_bold = "res://assets/Textures_v2/MANSION/personality_bold.png",
	personality_shy = "res://assets/Textures_v2/MANSION/personality_shy.png",
	personality_serious = "res://assets/Textures_v2/MANSION/personality_serious.png",
	base_physics = "res://assets/images/gui/gui icons/icon_physics.png",
	base_wits = "res://assets/images/gui/gui icons/icon_wits.png",
	base_charm = "res://assets/images/gui/gui icons/icon_charm.png",
	consent = "res://assets/images/gui/gui icons/icon_twohearts.png",
	sex_training_petting = "res://assets/images/iconstraits/l_hand.png",
	sex_training_oral = "res://assets/images/iconstraits/l_oral.png",
	sex_training_anal = "res://assets/images/iconstraits/l_anal.png",
	sex_training_pussy = "res://assets/images/iconstraits/l_sex.png",
	sex_training_penetration = "res://assets/images/iconstraits/l_doggy.png",
	sex_training_tail = "res://assets/images/iconsgear/tailplug.png",
	trained = "res://assets/Textures_v2/MANSION/trained_slave.png",
}
const FACTOR_ICON_PATH = "res://assets/images/iconsfactors/%s.png"
var icon_cache = {}

func requirement_icons(quest):
	var res = []
	for req in quest.requirements[0].statreqs:
		var tooltip = ResourceScripts.descriptions.make_slave_statreq_text(req)
		if req.code == 'one_of_races':
			var entries = _race_entries(req.value)
			if entries.size() == 1 and entries[0].size() == 2:
				tooltip = kin_pair_text(entries[0])
		var textures = []
		for texture in _req_textures(req):
			if texture != null:
				textures.append(texture)
		if !textures.empty():
			res.append({texture = textures[0], textures = textures, tooltip = tooltip})
	return res

func _req_textures(req):
	match req.code:
		'race':
			return [_race_icon(req.race)]
		'one_of_races':
			var res = []
			for entry in _race_entries(req.value):
				res.append(_race_icon(entry[0]) if entry.size() == 1 else _kin_pair_icon(entry[0]))
			return res
		'sex':
			return [images.get_icon(req.value)]
		'stat':
			if req.stat == 'personality':
				var res = []
				for value in (req.value if req.value is Array else [req.value]):
					res.append(_icon(REQ_ICON_PATHS.get('personality_' + value, '')))
				return res
			if req.stat == 'consent':
				return [_icon(REQ_ICON_PATHS.consent)]
			if req.stat.ends_with('_factor'):
				var medallion = _icon(FACTOR_ICON_PATH % req.stat)
				if medallion != null:
					return [medallion]
			if statdata.statdata.has(req.stat):
				return [_as_texture(statdata.statdata[req.stat].get('baseicon'))]
		'base_stat':
			return [_icon(REQ_ICON_PATHS.get('base_' + req.stat, ''))]
		'stat_in_set':
			return [_icon(REQ_ICON_PATHS.get(req.stat, ''))]
		'has_profession':
			if classesdata.professions.has(req.profession):
				return [_as_texture(classesdata.professions[req.profession].icon)]
		'slave_type':
			return [_icon(REQ_ICON_PATHS.trained)]
	return []

func _race_icon(race):
	if !races.racelist.has(race):
		return null
	return _as_texture(races.racelist[race].get('icon'))

const KIN_PAIR_ICONS = {
	BeastkinCat = "res://assets/images/iconsraces/cat_halfcat.png",
	BeastkinWolf = "res://assets/images/iconsraces/wolf_halfwolf.png",
	BeastkinFox = "res://assets/images/iconsraces/fox_halffox.png",
	BeastkinBunny = "res://assets/images/iconsraces/bunny_halfbunny.png",
	BeastkinTanuki = "res://assets/images/iconsraces/tanuki_halftanuki.png",
}

func _race_entries(race_list):
	var res = []
	for race in race_list:
		var other = _kin_counterpart(race)
		if other == '' or !race_list.has(other):
			res.append([race])
		elif race.begins_with('Beastkin'):
			res.append([race, other])
	return res

func _kin_pair_icon(beastkin):
	var texture = _icon(KIN_PAIR_ICONS.get(beastkin, ''))
	return texture if texture != null else _race_icon(beastkin)

func kin_pair_text(pair):
	return globals._report_text("SQ_RACE_KIN_PAIR", [tr("RACE" + pair[0].to_upper()), tr("RACE" + pair[1].to_upper())])

func _as_texture(icon):
	if icon is Texture:
		return icon
	if icon is String and icon != '':
		if icon.begins_with('res://'):
			return _icon(icon)
		return images.get_icon(icon)
	return null

func _icon(path):
	if path == '':
		return null
	if !icon_cache.has(path):
		icon_cache[path] = load(path) if ResourceLoader.exists(path) else null
	return icon_cache[path]

func can_deliver(character):
	if character == null or !ResourceScripts.game_party.characters.has(character.id):
		return false
	if character.has_profession('master') or character.is_unique():
		return false
	if character.get_stat('slave_class') == 'servant' or character.check_work_rule('lock'):
		return false
	return !character.is_on_quest()

const CANDIDATE_ORDER = ['green', 'yellow', 'red']

func has_ready_candidate(quest):
	if !is_quest_open_for_delivery(quest):
		return false
	for id in ResourceScripts.game_party.character_order:
		var character = ResourceScripts.game_party.characters.get(id)
		if can_deliver(character) and quest_match(quest, character).status == 'green':
			return true
	return false

func delivery_candidates(quest):
	var res = []
	if quest == null or !quest.has('requirements'):
		return res
	for id in ResourceScripts.game_party.character_order:
		var character = ResourceScripts.game_party.characters.get(id)
		if !can_deliver(character):
			continue
		var fit = quest_match(quest, character)
		var entry = {
			character = character,
			status = fit.status if fit.status != '' else 'red',
			icons = [],
		}
		for req in quest.requirements[0].statreqs:
			if req.get('silent', false):
				continue
			var state = 'met'
			if req in fit.failed_advanced:
				state = 'train'
			elif req in fit.failed_basic or req in fit.unreachable:
				state = 'no'
			var texture = _candidate_texture(req, character)
			if texture == null:
				continue
			entry.icons.append({
				texture = texture,
				state = state,
				tooltip = _candidate_tooltip(req, state),
			})
		res.append(entry)
	res.sort_custom(self, '_sort_candidates')
	return res

func _sort_candidates(a, b):
	var rank_a = CANDIDATE_ORDER.find(a.status)
	var rank_b = CANDIDATE_ORDER.find(b.status)
	if rank_a != rank_b:
		return rank_a < rank_b
	return a.character.get_short_name() < b.character.get_short_name()

func _candidate_texture(req, character):
	match req.code:
		'race', 'one_of_races':
			var own = _race_icon(character.get_stat('race'))
			if own != null:
				return own
		'sex':
			var own = images.get_icon(character.get_stat('sex'))
			if own != null:
				return own
		'stat':
			if req.stat == 'personality':
				var own = _icon(REQ_ICON_PATHS.get('personality_' + str(character.get_stat('personality')), ''))
				if own != null:
					return own
	var textures = _req_textures(req)
	return textures[0] if !textures.empty() else null

const CANDIDATE_STATE_KEYS = {met = "SQ_CAND_MET", train = "SQ_CAND_TRAIN", no = "SQ_CAND_NO"}
const CANDIDATE_STATE_COLORS = {met = 'green', train = 'yellow', no = 'red'}

func _candidate_tooltip(req, state):
	var verdict = "[color=%s]%s[/color]" % [variables.hexcolordict[CANDIDATE_STATE_COLORS[state]], tr(CANDIDATE_STATE_KEYS[state])]
	return ResourceScripts.descriptions.make_slave_statreq_text(req) + "\n" + verdict


#--------------delivery--------------

func quest_total_gold(quest):
	var bonus = 0.0
	var master = ResourceScripts.game_party.get_master()
	if master != null:
		bonus = variables.master_charm_quests_gold_bonus[int(master.get_stat('charm_factor'))]
	return int(round(quest.rewards.gold * (1.0 + bonus)))

func next_payment(quest):
	var req = quest.requirements[0]
	var total = quest_total_gold(quest)
	var count = int(req.value)
	if count <= 1 or int(req.delivered_slaves) + 1 >= count:
		return int(max(0, total - int(quest.paid)))
	return int(floor(total / float(count)))

func deliver(quest_id, character):
	if !can_deliver(character) or !has_quest(quest_id):
		return _no_delivery()
	var quest = get_quest(quest_id)
	if !is_quest_open_for_delivery(quest):
		return _no_delivery()
	var paid = _count_delivery(quest)
	ResourceScripts.game_party.add_fate(character.id, tr("SIBLINGMODULEFATEREMOVED"))
	ResourceScripts.game_party.remove_slave(character, true)
	return _pay_delivery(quest, paid)

func can_deliver_captive(character, location):
	if character == null or location == null or !location.has('captured_characters'):
		return false
	if !location.captured_characters.has(character.id):
		return false
	return character.src == 'random_combat' and !character.is_unique()

func captive_quests(character, location):
	var res = []
	if !can_deliver_captive(character, location):
		return res
	for quest in get_sorted_quests():
		if is_quest_open_for_delivery(quest) and quest_match(quest, character).status == 'green':
			res.append(quest)
	res.sort_custom(self, '_pays_more')
	return res

func _pays_more(a, b):
	return next_payment(a) > next_payment(b)

func deliver_captive(quest_id, character, location):
	if !can_deliver_captive(character, location) or !has_quest(quest_id):
		return _no_delivery()
	var quest = get_quest(quest_id)
	if !is_quest_open_for_delivery(quest) or quest_match(quest, character).status != 'green':
		return _no_delivery()
	var paid = _count_delivery(quest)
	location.captured_characters.erase(character.id)
	character.is_active = false
	return _pay_delivery(quest, paid)

func _no_delivery():
	return {paid = 0, complete = false, xp = 0, tokens = 0, rank_up = false}

func _count_delivery(quest):
	var req = quest.requirements[0]
	var paid = next_payment(quest)
	req.delivered_slaves = int(req.delivered_slaves) + 1
	quest.paid = int(quest.paid) + paid
	return paid

func _pay_delivery(quest, paid):
	var res = _no_delivery()
	res.paid = paid
	var req = quest.requirements[0]
	ResourceScripts.game_res.money += res.paid
	var rank = get_rank()
	var count = int(req.value)
	var popup_data = {
		title = tr("SQ_POPUP_DELIVERY_TITLE"),
		caption = tr(quest.name), icon = get_faction(quest.faction).icon,
		label = tr("SQ_POPUP_LABEL_DELIVERED"), count = "%d / %d" % [int(req.delivered_slaves), count],
		max = count, from = req.delivered_slaves - 1, to = req.delivered_slaves,
		gold = res.paid, tokens = 0, rank = rank, new_rank = rank, rank_up = false,
	}
	var shows_xp = false
	if req.delivered_slaves >= count:
		quest.state = states.complete
		res.complete = true
		res.xp = quest_xp(quest)
		res.tokens = quest_tokens(quest)
		add_tokens(res.tokens)
		popup_data.tokens = res.tokens
		if !is_max_rank():
			var threshold = xp_threshold()
			var xp_before = get_rank_xp()
			add_rank_xp(res.xp)
			var xp_after = get_rank_xp()
			popup_data.label = tr("SQ_POPUP_LABEL_XP")
			popup_data.count = ""
			popup_data.max = threshold
			popup_data.from = xp_before
			popup_data.to = xp_after
			shows_xp = true
		input_handler.play_animation("repeatable_quest_completed", {quest = quest})
		res.rank_up = try_rank_up()
		popup_data.rank_up = res.rank_up
		popup_data.new_rank = get_rank()
		if res.rank_up:
			popup_data.tokens += rank_up_tokens(get_rank())
		if !res.rank_up and !is_max_rank() and shows_xp and popup_data.to >= popup_data.max:
			popup_data.caption = globals._report_text("SQ_POPUP_NEED_SALES", [sales_target() - get_rank_sales()])
			popup_data.icon = _icon(RANK_ICON)
	show_rank_popup(popup_data)
	emit_signal("quests_changed")
	return res


#--------------save--------------

#JSON brings numbers back as floats and the pool's keys as strings; quests without 'kind' are dropped.
func fix_serialization():
	var progress = get_progress()
	var rank_known = false
	for data in quest_data.ranks:
		if data.code == progress.get('rank'):
			rank_known = true
	if !rank_known:
		progress.rank = quest_data.ranks[0].code
	progress.rank_xp = int(progress.get('rank_xp', 0))
	progress.rank_sales = int(progress.get('rank_sales', 0))
	progress.next_id = int(progress.get('next_id', 0))
	progress.tokens = int(progress.get('tokens', 0))
	progress.top_sales = int(progress.get('top_sales', 0))
	var bought = progress.get('bought', [])
	progress.bought = bought if bought is Array else []

	var old_pool = progress.get('quest_pool', {})
	var pool = {}
	if old_pool is Dictionary:
		for key in old_pool:
			var quest = old_pool[key]
			if !(quest is Dictionary) or !quest.has('kind'):
				continue
			quest.id = int(quest.id)
			quest.time_limit = int(quest.time_limit)
			if !quest_data.factions.has(quest.get('faction')):
				quest.faction = _roll_faction()
			quest.paid = int(quest.get('paid', 0))
			quest.rewards.gold = int(quest.rewards.gold)
			var req = quest.requirements[0]
			req.value = int(req.value)
			req.delivered_slaves = int(req.delivered_slaves)
			for statreq in req.statreqs:
				if statreq.has('value') and typeof(statreq.value) == TYPE_REAL:
					statreq.value = int(statreq.value)
				_pair_kin_races(statreq)
			pool[quest.id] = quest
			progress.next_id = int(max(progress.next_id, quest.id + 1))
	progress.quest_pool = pool

	var existing_factions = quest_data.factions.keys()
	var dynamic_data_template = quest_data.faction_dynamic_data_template
	for fact_id in progress.factions.keys():
		if existing_factions.has(fact_id):
			existing_factions.erase(fact_id)
			var existing_params = dynamic_data_template.keys()
			for param in progress.factions[fact_id].keys():
				if existing_params.has(param):
					existing_params.erase(param)
				else:
					progress.factions[fact_id].erase(param)
			for param in existing_params:
				progress.factions[fact_id][param] = dynamic_data_template[param]
		else:
			progress.factions.erase(fact_id)
	for fact_id in existing_factions:
		progress.factions[fact_id] = dynamic_data_template.duplicate()

	fill_quests()
