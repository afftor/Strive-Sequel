extends Reference
#Body upgrades performed in the ritual room once its Flesh Rites circle is built - the mansion's own
#door to Traitdata.body_upgrades, which the slave market's character editor used to be the only way
#to. A rite asks what the market asked, gold and the body's upgrade points, and mana on top, drawn from
#other residents the player picks for it; an upgrade the body already carries is taken back for that
#mana alone. mansion_view's BodyRitesPanel shows everything it shows by asking here, so what the panel
#promises and what the rite does cannot drift apart.
#
#Plain script, static functions: preload("res://src/core/body_rites.gd").

const UPGRADE = 'flesh_rites'
#Mana an upgrade asks for when its data names none (see manacost in Traits.gd): twice its points.
const MANA_PER_POINT = 2


static func text(key):
	return TranslationServer.translate(key)


static func unlocked():
	return ResourceScripts.game_res.has_body_rites()


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


#The first thing that closes an upgrade off for a subject: 'owned', 'locked' (the body does not meet
#its requirements), 'no_points', or 'open'. Gold and mana are the player's to gather, so they do not
#close anything off - problems() says whether the rite can be performed now.
static func state(person, code):
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

#Everything standing between the subject and the rite, as keys the panel marks its rows by - 'owned',
#'requirements', 'points', 'gold', 'mana' - and empty when it can be performed.
static func problems(person, code, donor_ids):
	var res = []
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
	return true


#### taking an upgrade back ####

#The mana taking an upgrade back asks for: what putting it in did. Nothing else is paid.
static func removal_mana_cost(code):
	return mana_cost(code)


#Everything standing between the subject and taking the upgrade back, as problems() does for the
#rite - 'not_owned', 'mana' - and empty when it can be done.
static func removal_problems(person, code, donor_ids):
	var res = []
	if !person.get_body_upgrades().has(code):
		res.append('not_owned')
	var cost = removal_mana_cost(code)
	if collected(mana_shares(cost, valid_donors(person, donor_ids))) < cost:
		res.append('mana')
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
	return true
