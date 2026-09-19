extends Reference
#Body upgrades performed in the ritual room once its Flesh Rites circle is built - the mansion's own
#door to Traitdata.body_upgrades, which the slave market's character editor used to be the only way
#to. A rite asks what the market asked, gold and the body's upgrade points, and mana on top, drawn from
#other residents the player picks for it; an upgrade the body already carries is taken back for that
#mana alone. The room's other rites - appearance change, sex change, form change, virginity restoration - live
#here too (see their section at the end). They open with the first level of Flesh Rites; the upgrades wait for
#the second (upgrades_unlocked).
#mansion_view's BodyRitesPanel shows everything it shows by asking here, so what the panel
#promises and what the rite does cannot drift apart.
#
#Plain script, static functions: preload("res://src/core/body_rites.gd").

const UPGRADE = 'flesh_rites'
#Mana an upgrade asks for when its data names none (see manacost in Traits.gd): twice its points.
const MANA_PER_POINT = 2
#The Flesh Rites level that opens the body upgrades. The first level opens only the rites.
const UPGRADES_LEVEL = 2


static func text(key):
	return TranslationServer.translate(key)


static func unlocked():
	return ResourceScripts.game_res.has_body_rites()


#Whether the circle is built far enough for the body upgrades. Below that they are still listed, sealed.
static func upgrades_unlocked():
	return ResourceScripts.game_res.flesh_rites_level() >= UPGRADES_LEVEL


#### what there is ####

#Every body upgrade, in the order the data lists them.
static func upgrade_codes():
	return Traitdata.body_upgrades.keys()


static func upgrade_data(code):
	return Traitdata.body_upgrades.get(code)


static func gold_cost(code):
	return int(upgrade_data(code).get('goldcost', 0))


static func point_cost(code):
	return int(upgrade_data(code).get('cost', 0))


static func mana_cost(code):
	var data = upgrade_data(code)
	return int(data.get('manacost', int(data.get('cost', 0)) * MANA_PER_POINT))


#### who ####

static func character(id):
	return ResourceScripts.game_party.characters.get(id)


#Here for a rite: at the mansion, not on a quest, not knocked out.
static func is_present(person):
	return person != null and person.is_free() and !person.is_koed()


#Whose body a rite can change: everyone of the household who is here, in the household's own order.
static func subjects():
	var res = []
	for id in ResourceScripts.game_party.character_order:
		if is_present(character(id)):
			res.append(id)
	return res


#Who can give mana for a rite on this subject: everyone else who is here, with or without mana to
#spare right now - the panel greys out those with none rather than hiding them.
static func donors_for(subject_id):
	var res = []
	for id in subjects():
		if id != subject_id:
			res.append(id)
	return res


#The donors a rite will really draw on: here, not the subject, each once, in the order given.
static func valid_donors(subject, donor_ids):
	var res = []
	for id in donor_ids:
		if id == subject.id or res.has(id):
			continue
		if is_present(character(id)):
			res.append(id)
	return res


static func mana_of(person):
	return int(max(0, floor(person.mp)))


#### points ####

#All the upgrade points a body has: its Growth Factor's worth (upgrade_points_total in ch_dyn_stats).
static func total_points(person):
	return int(person.get_stat('upgrade_points_total'))


#What the upgrades the body already carries take of them. get_upgrade_points() is the rest, so taking
#an upgrade back gives its points back by itself.
static func used_points(person):
	return total_points(person) - int(person.get_upgrade_points())


#### where an upgrade stands ####

static func requirements_met(person, code):
	return person.checkreqs(upgrade_data(code).reqs)


#The first thing that closes an upgrade off for a subject: 'sealed' (Flesh Rites is below UPGRADES_LEVEL),
#'owned', 'locked' (the body does not meet its requirements), 'no_points', or 'open'. Gold and mana are the
#player's to gather, so they do not close anything off - problems() says whether the rite can be performed now.
static func state(person, code):
	if !upgrades_unlocked():
		return 'sealed'
	if person.get_body_upgrades().has(code):
		return 'owned'
	if !requirements_met(person, code):
		return 'locked'
	if person.get_upgrade_points() < point_cost(code):
		return 'no_points'
	return 'open'


#The upgrade's body requirements as rows for the panel, {text, met}, each checked on the subject. A
#condition carrying orflag joins the row before it - "Fur or Scales", met when either is - and every
#other condition is a row of its own, so the rows read the way checkreqs() adds them up.
static func requirement_rows(person, code):
	var rows = []
	for req in upgrade_data(code).reqs:
		var plain = req.duplicate()
		plain.erase('orflag')
		var met = person.checkreqs([plain])
		var line = requirement_text(person, plain)
		if req.get('orflag', false) and !rows.empty():
			rows.back().text += text("BODYRITE_REQ_OR") + line
			rows.back().met = rows.back().met or met
		else:
			rows.append({text = line, met = met})
	return rows


#One condition in words. The body's own conditions get lines of their own; anything else is put the
#way the rest of the game puts it (CharacterClass.decipher_single), or shown raw rather than not at all.
static func requirement_text(person, req):
	match req.code:
		'has_coverage':
			return text("BODYRITE_REQ_%s%s" % ["" if req.get('check', true) else "NO_", str(req.coverage).to_upper()])
		'stat_in_set':
			return text("BODYRITE_REQ_" + str(req.stat).to_upper())
		'stat':
			if typeof(req.value) == TYPE_BOOL:
				return text("BODYRITE_REQ_" + str(req.stat).to_upper() + ("" if req.value else "_FALSE"))
	var line = person.decipher_single(req)
	return line if line != '' else str(req)


#### mana ####

#How much each donor gives towards a cost, by id: an even share from each, and whatever one of them
#cannot cover spread over those who still have mana - nobody emptied while another keeps plenty. Falls
#short of the cost when the donors together hold too little; collected() adds it up.
static func mana_shares(cost, donor_ids):
	var shares = {}
	var pool = []
	for id in donor_ids:
		var person = character(id)
		if person == null or shares.has(id):
			continue
		shares[id] = 0
		if mana_of(person) > 0:
			pool.append(person)
	var left = int(max(0, cost))
	while left > 0 and !pool.empty():
		var even = int(ceil(float(left) / pool.size()))
		var still = []
		for person in pool:
			if left <= 0:
				break
			var give = int(min(min(even, mana_of(person) - shares[person.id]), left))
			shares[person.id] += give
			left -= give
			if mana_of(person) - shares[person.id] > 0:
				still.append(person)
		pool = still
	return shares


static func collected(shares):
	var total = 0
	for id in shares:
		total += shares[id]
	return total


#### the rite ####

#Everything standing between the subject and the rite, as keys the panel marks its rows by - 'sealed',
#'owned', 'requirements', 'points', 'gold', 'mana', 'preparation' - and empty when it can be performed. The
#last is the ritual room's circle, which every rite needs full (game_res.rite_prepared).
static func problems(person, code, donor_ids):
	var res = []
	if !upgrades_unlocked():
		res.append('sealed')
	if person.get_body_upgrades().has(code):
		res.append('owned')
	if !requirements_met(person, code):
		res.append('requirements')
	if person.get_upgrade_points() < point_cost(code):
		res.append('points')
	if ResourceScripts.game_res.money < gold_cost(code):
		res.append('gold')
	if collected(mana_shares(mana_cost(code), valid_donors(person, donor_ids))) < mana_cost(code):
		res.append('mana')
	if !ResourceScripts.game_res.rite_prepared():
		res.append('preparation')
	return res


#The rite itself, if nothing stands in its way: the gold paid, each donor's share of mana drawn, the
#upgrade given. Returns whether it was performed.
static func perform(person, code, donor_ids):
	var donors = valid_donors(person, donor_ids)
	if !problems(person, code, donors).empty():
		return false
	var shares = mana_shares(mana_cost(code), donors)
	ResourceScripts.game_res.money -= gold_cost(code)
	for id in shares:
		if shares[id] > 0:
			character(id).mana_update(-shares[id])
	person.add_upgrade(code)
	person.recheck_upgrades()
	ResourceScripts.game_res.spend_rite_preparation()
	return true


#### taking an upgrade back ####

#The mana taking an upgrade back asks for: what putting it in did. Nothing else is paid.
static func removal_mana_cost(code):
	return mana_cost(code)


#Everything standing between the subject and taking the upgrade back, as problems() does for the
#rite - 'sealed', 'not_owned', 'mana', 'preparation' - and empty when it can be done.
static func removal_problems(person, code, donor_ids):
	var res = []
	if !upgrades_unlocked():
		res.append('sealed')
	if !person.get_body_upgrades().has(code):
		res.append('not_owned')
	var cost = removal_mana_cost(code)
	if collected(mana_shares(cost, valid_donors(person, donor_ids))) < cost:
		res.append('mana')
	if !ResourceScripts.game_res.rite_prepared():
		res.append('preparation')
	return res


#Takes the upgrade back if nothing stands in the way: each donor's share of mana drawn, the upgrade
#removed (its traits go with the next stat rebuild, its points are free again). Returns whether it
#was done.
static func remove(person, code, donor_ids):
	var donors = valid_donors(person, donor_ids)
	if !removal_problems(person, code, donors).empty():
		return false
	var shares = mana_shares(removal_mana_cost(code), donors)
	for id in shares:
		if shares[id] > 0:
			character(id).mana_update(-shares[id])
	person.remove_upgrade(code)
	ResourceScripts.game_res.spend_rite_preparation()
	return true


#### the rites beside the upgrades ####

#Listed in the panel above the upgrades but not upgrades: a body changed rather than improved, as often as
#the player likes, paid in gold and in donors' mana, with no upgrade points involved. Each is offered only
#to a body it can apply to (rites_for):
#- the appearance change changes nothing by itself: once it is done the panel opens the beauty parlor's Body
#  modifications on the subject, without the list of everybody else (BodyModModule.open_for_rite);
#- the sex change turns a male body female or a female one male, as the sex swap potion does
#  (custom_effects.swap_sex_of);
#- the form change turns a beastkin body halfkin or a halfkin one beastkin, as the body editor's furry
#  switch does (ch_stats.set_furry_form), a new beastkin getting the first coat its race lists; nothing of
#  the old form is kept for a change back;
#- the virginity restoration makes a woman a virgin again;
#- the personality change asks in its dialogue which personality to give (give_personality()).
const APPEARANCE = 'appearance'
const SEX_CHANGE = 'sex_change'
const FORM_CHANGE = 'form_change'
const VIRGINITY = 'virginity'
const PERSONALITY = 'personality'
const RITE_GOLD = {appearance = 500, sex_change = 1000, form_change = 1000, virginity = 500, personality = 1000}
const RITE_MANA = {appearance = 30, sex_change = 50, form_change = 50, virginity = 30, personality = 50}
const APPEARANCE_ICON = "res://assets/images/iconsitems/magic brush.png"
const SEX_CHANGE_ICON = "res://assets/images/iconsitems/sexswap_potion.png"
const VIRGINITY_ICON = "res://assets/images/iconsitems/icon_flower.png"
const PERSONALITY_ICON = "res://assets/images/iconsitems/mask2.png"
const PERSONALITIES = ['kind', 'bold', 'shy', 'serious']


static func is_rite(code):
	return code in [APPEARANCE, SEX_CHANGE, FORM_CHANGE, VIRGINITY, PERSONALITY]


static func rites_for(person):
	var res = [APPEARANCE, SEX_CHANGE, PERSONALITY]
	if form_change_target(person) != '':
		res.append(FORM_CHANGE)
	if person.get_stat('sex') == 'female':
		res.append(VIRGINITY)
	return res


#The race a form change would give, '' for a race without the other form.
static func form_change_target(person):
	return person.statlist.furry_counterpart_race()


static func rite_gold(code):
	return int(RITE_GOLD.get(code, 0))


static func rite_mana(code):
	return int(RITE_MANA.get(code, 0))


#The rite's name key for this subject - the form change is named after the form it gives. The description
#key is the name key with _DESCRIPT.
static func rite_name_key(person, code):
	match code:
		APPEARANCE:
			return "BODYRITE_APPEARANCE"
		SEX_CHANGE:
			return "BODYRITE_SEX_CHANGE"
		FORM_CHANGE:
			return "BODYRITE_HALFKIN_FORM" if person.is_furry_form() else "BODYRITE_BEASTKIN_FORM"
		VIRGINITY:
			return "BODYRITE_VIRGINITY"
		PERSONALITY:
			return "BODYRITE_PERSONALITY"
	return ""


static func rite_descript_key(person, code):
	var key = rite_name_key(person, code)
	return key + "_DESCRIPT" if key != "" else ""


#The picture on a rite's row: a brush for the appearance change, the potion for the sex change, the icon of
static func rite_icon(person, code):
	match code:
		APPEARANCE:
			return APPEARANCE_ICON
		SEX_CHANGE:
			return SEX_CHANGE_ICON
		FORM_CHANGE:
			var target = form_change_target(person)
			return races.racelist[target].get('icon', '') if target != '' else ''
		VIRGINITY:
			return VIRGINITY_ICON
		PERSONALITY:
			return PERSONALITY_ICON
	return ''


static func rite_rows(person, code):
	var not_unique = {text = text("BODYRITE_REQ_NOT_UNIQUE"), met = person.get_stat('unique') == null}
	match code:
		SEX_CHANGE:
			return [not_unique, {text = text("BODYRITE_REQ_MALE_OR_FEMALE"), met = person.get_stat('sex') in ['male', 'female']}]
		FORM_CHANGE:
			return [not_unique]
		VIRGINITY:
			return [{text = text("BODYRITE_REQ_VIRGINITY_LOST"), met = person.get_stat('vaginal_virgin_lost') != null}]
	return []


static func rite_open(person, code):
	if !rites_for(person).has(code):
		return false
	for row in rite_rows(person, code):
		if !row.met:
			return false
	return true


#Everything standing in a rite's way, as problems() does for the upgrades: 'requirements', 'gold', 'mana'.
static func rite_problems(person, code, donor_ids):
	var res = []
	if !rite_open(person, code):
		res.append('requirements')
	if ResourceScripts.game_res.money < rite_gold(code):
		res.append('gold')
	if collected(mana_shares(rite_mana(code), valid_donors(person, donor_ids))) < rite_mana(code):
		res.append('mana')
	if !ResourceScripts.game_res.rite_prepared():
		res.append('preparation')
	return res


#A rite, if nothing stands in its way: the gold paid, each donor's share of mana drawn, the body changed.
#Returns whether it was performed.
static func perform_change(person, code, donor_ids):
	var donors = valid_donors(person, donor_ids)
	if !rite_problems(person, code, donors).empty():
		return false
	var shares = mana_shares(rite_mana(code), donors)
	ResourceScripts.game_res.money -= rite_gold(code)
	for id in shares:
		if shares[id] > 0:
			character(id).mana_update(-shares[id])
	match code:
		APPEARANCE:
			#nothing changes here: the panel opens Body modifications on the subject once the rite's scene is closed
			pass
		SEX_CHANGE:
			ResourceScripts.custom_effects.swap_sex_of(person)
		FORM_CHANGE:
			person.set_furry_form(!person.is_furry_form(), true)
			input_handler.emit_signal('update_ragdoll')
			#the portrait on file shows the old form - swap_sex_of asks the same for a sex change
			input_handler.reshoot_portrait(person)
		VIRGINITY:
			person.set_stat('vaginal_virgin_lost', null)
		PERSONALITY:
			pass
	ResourceScripts.game_res.spend_rite_preparation()
	return true


static func give_personality(person, personality):
	if person == null or !(personality in PERSONALITIES):
		return false
	person.set_stat('personality', personality)
	return true


#The first name the subject goes by from now on, filed under the sex they have now: a change back brings
#the other sex's name back, a change to this sex again brings this one (custom_effects.swap_sex_of).
#An empty name keeps the current one and only files it.
static func rename_for_sex(person, new_name):
	var clean = str(new_name).strip_edges()
	if clean != '':
		person.set_stat('name', clean)
	person.remember_name_for_sex()
