extends Reference

var parent: WeakRef

var alt_form = false
var alt_appearance = {}
var revert_appearance = {}


var thrall_master = null
var thralls = []

var all_thralls = []
#unlock points for the succubus powers, brought by her levels (Traitdata.succubus_levels.points)
var thrall_points = 0
#false in a save from when every new thrall brought a point - fix_thrall_points
var points_from_levels = false
#an elder succubus's experience, all of it from thralls - see Traitdata.succubus_levels
var succubus_exp = 0
#warnings are bad here - they are marks of _potentially_ improper rebuilding of dynamic stats
#can't reset those stats though - cause those can be rised _in_process_ of rebuilding
#internal
func _reset_thrall_master():
	if thrall_master == null:
		return
	print('warning: reset thrall master')
	thrall_master = null


func _recheck_thralls():
	for id in thralls.duplicate():
		var tmp = characters_pool.get_char_by_id(id)
		if tmp == null or !tmp.is_active:
			thralls.erase(id)
			print('warning: remove thrall')
			continue
		if !tmp.is_players_character:
			print('warning: remove thrall')
			tmp.set_stat('thrall_master', null)
			thralls.erase(id) #for the sake of stability - should be erased in the upper line


#getters
func get_thrall_master():
	if thrall_master != null:
		var tmp = characters_pool.get_char_by_id(thrall_master)
		if tmp == null or !tmp.is_active:
			_reset_thrall_master()
		elif !tmp.is_players_character:
			tmp.release_all_thralls()

	return thrall_master


func get_master_character():
	var chid = get_thrall_master()
	if chid == null:
		return null
	return characters_pool.get_char_by_id(chid)


#An elder succubus has a slot per level, a lesser one a fixed few, anybody else none.
func get_thrall_max_count():
	var person = parent.get_ref()
	if person.check_trait('succubus'):
		return get_succubus_level()
	if person.check_trait('lesser_succubus'):
		return Traitdata.succubus_levels.lesser_slots
	return 0


#1 to 6, by the experience thresholds in Traitdata.succubus_levels
func get_succubus_level():
	var level = 0
	for need in Traitdata.succubus_levels.exp:
		if succubus_exp >= need:
			level += 1
	return level


#the unlock points levels 1 to `level` bring in all
func get_level_points(level):
	var points = Traitdata.succubus_levels.points
	var res = 0
	for i in range(min(level, points.size())):
		res += points[i]
	return res


#A new succubus is level 1 at once, with level 1's points - enough for Enthrallment, her first power.
#ch_dyn_stats.add_trait calls it as the trait comes in.
func become_succubus():
	points_from_levels = true
	thrall_points += get_level_points(get_succubus_level())


#Only an elder succubus learns from her thralls; a lesser one's thralls feed nobody's level. A new
#level brings its unlock points.
func add_succubus_exp(value):
	var person = parent.get_ref()
	if value <= 0 or !person.check_trait('succubus'):
		return
	var old_level = get_succubus_level()
	succubus_exp += value
	var level = get_succubus_level()
	if level > old_level:
		var points = get_level_points(level) - get_level_points(old_level)
		thrall_points += points
		person.reset_rebuild()
		var text = person.translate(tr("SUCCUBUS_LEVEL_UP")).replace("{level}", str(level))
		if points > 0:
			text += " " + tr("SUCCUBUS_LEVEL_UP_POINTS") % points
		globals.text_log_add('char', text)


#The thrall's attachment to the one who holds them: affection when that is the Master, the
#relationship between the two otherwise (the Master has no relationship records).
func get_bond():
	var master = get_master_character()
	if master == null:
		return 0
	var person = parent.get_ref()
	if master.is_master():
		return person.get_stat('affection')
	return ResourceScripts.game_party.get_relationship_value(person.id, master.id)


func add_bond(value):
	var master = get_master_character()
	if master == null:
		return
	var person = parent.get_ref()
	if master.is_master():
		person.add_stat('affection', value)
	else:
		ResourceScripts.game_party.add_relationship_value(person.id, master.id, value, false)


#Enthralling no longer makes a lover: it only lifts a grudge to indifference, and the bond grows from there.
func bond_to_neutral():
	var master = get_master_character()
	if master == null:
		return
	var person = parent.get_ref()
	if master.is_master():
		if person.get_stat('affection') < 0:
			person.set_stat('affection', 0)
	else:
		ResourceScripts.game_party.raise_relationship_value(person.id, master.id, variables.relationship_base.default)


#A turn for the one holding thralls: each grows more attached, faster in the same place, and an
#elder succubus learns from every one of them.
func tick():
	if thralls.empty():
		return
	var person = parent.get_ref()
	var data = Traitdata.succubus_levels
	var held = get_thralls()
	for chid in held:
		var tmp = characters_pool.get_char_by_id(chid)
		if tmp.same_location_with(person):
			tmp.enthrall.add_bond(data.bond_per_tick_near)
		else:
			tmp.enthrall.add_bond(data.bond_per_tick)
	add_succubus_exp(data.exp_per_thrall_tick * held.size())


#Lust growth the thralls give their master each turn: a Lust Doll gives more.
func get_thrall_lust_tick():
	var data = Traitdata.succubus_levels
	var res = 0
	for chid in get_thralls():
		var tmp = characters_pool.get_char_by_id(chid)
		if tmp.check_trait('lust_doll'):
			res += data.lust_per_doll
		else:
			res += data.lust_per_thrall
	return res


#How many of this master's thralls hold a status - the caps in Traitdata.succubus_levels.status_caps
func count_thralls_with_trait(tr_code):
	var res = 0
	for chid in get_thralls():
		if characters_pool.get_char_by_id(chid).check_trait(tr_code):
			res += 1
	return res


#The statuses a succubus grants (tag 'thrall_status') belong to the bond and end with it. A lesser
#succubus losing hers lets her own thralls go too.
func remove_thrall_statuses():
	var dyn_stats = parent.get_ref().dyn_stats
	if dyn_stats.traits_stored.has('lesser_succubus'):
		release_all_thralls()
	for code in dyn_stats.traits_stored.keys():
		if Traitdata.traits[code].tags.has('thrall_status'):
			dyn_stats.remove_trait(code, true)


func get_thrall_count():
	_recheck_thralls()
	return thralls.size()


func get_thralls():
	_recheck_thralls()
	return thralls.duplicate()

#setters
func set_thrall_master(chid): #not totally safe
	if chid == get_thrall_master():
		return
	if thrall_master != null:
		var cmaster = characters_pool.get_char_by_id(thrall_master)
		thrall_master = null
		if cmaster != null:
			cmaster.release_thrall(parent.get_ref().id)
		remove_thrall_statuses()
	if chid != null:
		var tmp = characters_pool.get_char_by_id(chid)
		tmp.add_thrall(parent.get_ref().id)
	thrall_master = chid #for readability sake, this line can be iside if
	if chid != null:
		bond_to_neutral()


func set_alt_form(value):
	alt_form = value
	if alt_form:
		gather_alt_appearance()
		for stat in alt_appearance:
			parent.get_ref().set_stat(stat, alt_appearance[stat])
	else:
		for stat in revert_appearance:
			parent.get_ref().set_stat(stat, revert_appearance[stat])
	parent.get_ref().set_stat('portrait_update', true)


#Human form once cleared a demon's horns twice and never the wings, and left the demon ears: a demon saved
#in human form still has them.
func fix_old_save():
	fix_succubus_exp()
	fix_thrall_points()
	if !alt_form or parent.get_ref().get_stat('race') != 'Demon':
		return
	var person = parent.get_ref()
	var changed = false
	if !alt_appearance.has('wings'):
		alt_appearance.wings = ''
		person.set_stat('wings', '')
		changed = true
	if !alt_appearance.has('ears'):
		revert_appearance.ears = person.get_stat('ears')
		alt_appearance.ears = 'normal'
		person.set_stat('ears', 'normal')
		changed = true
	if changed:
		person.set_stat('portrait_update', true)

#Thrall slots once came from the factors: a succubus saved before levels starts at the level that keeps
#every thrall she already holds.
func fix_succubus_exp():
	if succubus_exp > 0 or thralls.empty() or !parent.get_ref().dyn_stats.traits_stored.has('succubus'):
		return
	var levels = Traitdata.succubus_levels.exp
	succubus_exp = levels[int(min(thralls.size(), levels.size())) - 1]


#Unlock points once came one per new thrall and powers cost more, and Enthrall, Release Thrall and
#Perverted Mind came with the trait. A succubus from then keeps those as the powers they are now, and
#has what her level has brought, less what her powers cost today.
func fix_thrall_points():
	if points_from_levels:
		return
	points_from_levels = true
	var person = parent.get_ref()
	if !person.dyn_stats.traits_stored.has('succubus'):
		thrall_points = 0
		return
	person.add_trait('enthrallment')
	person.learn_skill('perverted_mind')
	var res = get_level_points(get_succubus_level())
	for tr_id in Traitdata.succubus_trainings:
		var u_data = Traitdata.succubus_trainings[tr_id]
		var learned
		if u_data.mode == 'skill':
			learned = person.skills.social_skills.has(u_data.skill)
		else:
			learned = person.dyn_stats.traits_stored.has(u_data.trait)
		if learned:
			res -= u_data.cost.thrall_points
	thrall_points = int(max(res, 0))


#other
func can_add_thrall():
	return get_thrall_count() < get_thrall_max_count()


#release_thrall erases from the list being walked
func release_all_thralls():
	for chid in thralls.duplicate():
		release_thrall(chid)


func release_thrall(chid):
	var tmp = characters_pool.get_char_by_id(chid)
	if tmp == null:
		thralls.erase(chid)
		return
	if thralls.has(chid):
		thralls.erase(chid)
	tmp.set_stat('thrall_master', null)


func add_thrall(chid):
	if thralls.has(chid):
		return
	thralls.push_back(chid)
	if !all_thralls.has(chid):
		all_thralls.push_back(chid)
		add_succubus_exp(Traitdata.succubus_levels.exp_new_thrall)


func cleanup():
	release_all_thralls()
	set_thrall_master(null)


func gather_alt_appearance():
	match parent.get_ref().get_stat('race'):
		'Demon':
			revert_appearance.body_color_skin = parent.get_ref().get_stat('body_color_skin')
			if !alt_appearance.has('body_color_skin'):
				alt_appearance.body_color_skin = input_handler.random_from_array(['human1', 'grey2', 'human3', 'human4', 'human5'])
			revert_appearance.horns = parent.get_ref().get_stat('horns')
			if !alt_appearance.has('horns'):
				alt_appearance.horns = ''
			revert_appearance.wings = parent.get_ref().get_stat('wings')
			if !alt_appearance.has('wings'):
				alt_appearance.wings = ''
			revert_appearance.tail = parent.get_ref().get_stat('tail')
			if !alt_appearance.has('tail'):
				alt_appearance.tail = ''
			revert_appearance.ears = parent.get_ref().get_stat('ears')
			if !alt_appearance.has('ears'):
				alt_appearance.ears = 'normal'
		_:
			revert_appearance.body_color_skin = parent.get_ref().get_stat('body_color_skin')
			if !alt_appearance.has('body_color_skin'):
				alt_appearance.body_color_skin = input_handler.random_from_array(['red1', 'red2', 'red3', 'red4', 'red5'])
			if parent.get_ref().get_stat('horns') in [null, '']:
				revert_appearance.horns = ''
				if !alt_appearance.has('horns'):
					alt_appearance.horns = input_handler.random_from_array(['curved','straight'])
			if parent.get_ref().get_stat('wings') in [null, '']:
				revert_appearance.wings = ''
				if !alt_appearance.has('wings'):
					alt_appearance.wings = 'demon'
			if parent.get_ref().get_stat('tail') in [null, '']:
				revert_appearance.tail = ''
				if !alt_appearance.has('tail'):
					alt_appearance.tail = 'demon'
