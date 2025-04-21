extends Reference

var parent: WeakRef

#gear
var gear = {
	chest = null,
	rhand = null,
	lhand = null,
	hands = null,
	legs = null,
	'tool' : null,
	#cosmetics&lewds
	neck = null,
	head = null,
	ass = null,
	crotch = null,
	underwear = null,
}


func get_weapon_range():
	if gear.rhand == null:
		return 'melee'
	else:
		var weapon = ResourceScripts.game_res.items[gear.rhand]
		return weapon.weaponrange


func check_gear_equipped(gearname, param = 'itembase'):
	for i in gear.values():
		if i == null:
			continue
		var tempgear = ResourceScripts.game_res.items[i]
		if tempgear.get(param) == gearname:
			return true
	return false


func check_wooden_gear_equipped():
	for i in gear.values():
		if i == null:
			continue
		var tempgear = ResourceScripts.game_res.items[i]
		if tempgear.parts.empty() != true:
			for k in tempgear.parts.values():
				if Items.materiallist[k].type == 'wood':
					return true
	return false


func get_gear(slot):
	return gear[slot]


func get_gear_type(slot):
	var item = get_gear(slot)
	if item == null:
		return null
	item = ResourceScripts.game_res.items[item]
	return item.itembase


func equip(item, item_prev_id = null): 
	if item.amount != 1:
		print('warning - equip non-isolated item')
	if item.id == null:
		print('error - equip non-inventory item')
#	var duplicate = globals.get_duplicate_id_if_exist(item)
	#if duplicate != null:
	if parent.get_ref().checkreqs(item.reqs) == false:
		input_handler.SystemMessage(tr("INVALIDREQS"))
		if item_prev_id == null:
			return
		ResourceScripts.game_res.items[item_prev_id].amount += 1
		item.amount = 0
		return
	if item.curse != null:
		item.curse_known = true
	for i in item.multislots:
		if gear[i] != null:
			unequip(ResourceScripts.game_res.items[gear[i]])
	for i in item.slots:
		if i == 'lhand' and item.slots.has('rhand'):
			if parent.get_ref().has_status('strongarm') and item.geartype != 'bow':
				continue
		if gear[i] != null:
			unequip(ResourceScripts.game_res.items[gear[i]])
		gear[i] = item.id
	item.owner = parent.get_ref().id
	item.timestamp = parent.get_ref().get_timestamp()




func unequip(item, hard = true):
	#shuold be reworked due to new mechanics
	#probably fixed
	var duplicate = globals.get_duplicate_id_if_exist(item)
	
	if duplicate != null and hard:
		var duplicate_item = ResourceScripts.game_res.items[duplicate]
		if duplicate_item.owner == null:
			if duplicate != item.id:
				duplicate_item.amount += 1
				item.amount = 0
				item.owner = null
			else:
				item.amount += 1
		duplicate_item.owner = null
	else:
		item.owner = null
	for i in gear:
		if gear[i] == item.id:
			gear[i] = null
	#removing bonuses
	if item.curse!= null and hard:
		item.destroy()



func clear_equip(hard = true):
	for i in gear:
		if gear[i] != null:
			unequip(ResourceScripts.game_res.items[gear[i]], hard)


func get_weapon_element():
	if gear.rhand != null:
		var item = ResourceScripts.game_res.items[gear.rhand] 
		return item.get_weapon_element()
	return 'normal'


func get_weapon_animation():
	var res = 'targetattack'
	var weapon = gear.rhand
	if weapon != null:
		var item = ResourceScripts.game_res.items[weapon]
		match item.itembase: #add proper animations here
			'bow', 'bowadv':
				res = 'ranged_attack'
			'crossbow', 'crossbowadv':
				res = 'ranged_attack'
	return res


func get_weapon_sound():
	var item = gear.rhand
	if ResourceScripts.game_res.items.has(item):
		item = ResourceScripts.game_res.items[item]
	else:
		item = null
	if item == null:
		return 'dodge'
	else:
		return item.hitsound

func recheck_equip():
	#check hands for conflict
	if gear.rhand != null:
		if gear.lhand != gear.rhand: 
			var item = ResourceScripts.game_res.items[gear.rhand]
			if item.slots.has('lhand') and !parent.get_ref().has_status('strongarm') or item.geartype == 'bow':
				var item2 = ResourceScripts.game_res.items[gear.lhand]
				unequip(item2)
				gear.lhand = gear.rhand


func get_equiped_items():
	var res = []
	for id in gear.values():
		if id == null:
			continue
		var item = ResourceScripts.game_res.items[id]
		res.push_back(item)
	return res
