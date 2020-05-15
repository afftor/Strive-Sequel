extends Reference

var parent

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

func get_gear(slot):
	return gear[slot]

func equip(item, item_prev_id = null):
	var duplicate = globals.check_duplicates(item.itembase, item.parts)
	#if duplicate != null:
	if parent.checkreqs(item.reqs) == false:
		input_handler.SystemMessage(tr("INVALIDREQS"))
		if item_prev_id == null:
			return
		ResourceScripts.game_res.items[item_prev_id].amount += 1
		item.amount = 0
		return
	for i in item.multislots:
		if gear[i] != null:
			unequip(ResourceScripts.game_res.items[gear[i]])
	for i in item.slots:
		if gear[i] != null:
			unequip(ResourceScripts.game_res.items[gear[i]])
		gear[i] = item.id
	item.owner = parent.id
	#adding bonuses
	parent.add_stat_bonuses(item.bonusstats)
	for e in item.effects:
		var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table[e])
		parent.apply_effect(effects_pool.add_effect(eff))
		eff.set_args('item', item.id)
	parent.recheck_effect_tag('recheck_item')

func unequip(item):
	var duplicate = globals.check_duplicates(item.itembase, item.parts)
	if duplicate != null:
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
	parent.remove_stat_bonuses(item.bonusstats)
	
	var arr = parent.find_eff_by_item(item.id)
	for e in arr:
		var eff = effects_pool.get_effect_by_id(e)
		eff.remove()
	parent.recheck_effect_tag('recheck_item')

func clear_eqip():
	for i in gear:
		if gear[i] != null:
			unequip(ResourceScripts.game_res.items[gear[i]])

func get_weapon_element():
	#for testing
	return 'normal'
