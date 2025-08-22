extends Reference

var parent: WeakRef

var alt_form = false
var alt_appearance = {}
var revert_appearance = {}


var thrall_master = null
var thralls = []

var all_thralls = []
var thrall_points = 0
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
		if tmp == null:
			thralls.erase(id)
			print('warning: remove thrall')
		if !tmp.is_active:
			thralls.erase(id)
			print('warning: remove thrall')
		if !tmp.is_players_character:
			print('warning: remove thrall')
			tmp.set_stat('thrall_master', null)
			thralls.erase(id) #for the sake of stability - should be erased in the upper line


#getters
func get_thrall_master():
	if thrall_master != null:
		var tmp = characters_pool.get_char_by_id(thrall_master)
		if tmp == null:
			_reset_thrall_master()
		if !tmp.is_active:
			_reset_thrall_master()
		if !tmp.is_players_character:
			tmp.release_all_thralls()
	
	return thrall_master


func get_thrall_max_count():
	return max(parent.get_ref().get_stat('charm_factor'), parent.get_ref().get_stat('magic_factor'))


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
		cmaster.release_thrall(parent.get_ref().id)
	if chid != null:
		var tmp = characters_pool.get_char_by_id(chid)
		tmp.add_thrall(parent.get_ref().id)
	thrall_master = chid #for readability sake, this line can be iside if 


func set_alt_form(value):
	alt_form = value
	if alt_form:
		gather_alt_appearance()
		for stat in alt_appearance:
			parent.get_ref().set_stat(stat, alt_appearance[stat])
	else:
		for stat in revert_appearance:
			parent.get_ref().set_stat(stat, revert_appearance[stat])

#other
func can_add_thrall():
	return get_thrall_count() < get_thrall_max_count()


func release_all_thralls():
	for chid in thralls:
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
		thrall_points += 1
		all_thralls.push_back(chid)


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
				alt_appearance.horns = ''
			revert_appearance.tail = parent.get_ref().get_stat('tail')
			if !alt_appearance.has('tail'):
				alt_appearance.tail = ''
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
