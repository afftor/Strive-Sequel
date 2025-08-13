extends Reference

var parent: WeakRef

var alt_form = false

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
