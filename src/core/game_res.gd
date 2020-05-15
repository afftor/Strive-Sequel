extends Reference
#extends Node

var itemcounter = 0
var money = 0
var upgrades = {}
var upgrade_progresses = {}
var selected_upgrade = {code = '', level = 0}#not sure
var items = {}
var craftinglists = {alchemy = [], smith = [], cooking = [], tailor = []}
var materials = {} setget materials_set
var oldmaterials = {}

func _init():
	for i in upgradedata.upgradelist.keys():
		upgrades[i] = 0
	for i in Items.materiallist:
		materials[i] = 0


func fix_serialization():
	for i in items:
		items[i] = dict2inst(items[i])
#	fix_items_inventory(false)

func serialize():
#	fix_items_inventory(true)
	var res = inst2dict(self)
	res.items = {}
	for i in items:
		res.items[i] = inst2dict(items[i])
#	fix_items_inventory(false)
	return res

#inventory
func materials_set(value):
	var text = ''
	for i in value:
		if oldmaterials.has(i) == false || oldmaterials[i] != value[i]:
			if oldmaterials.has(i) == false:
				oldmaterials[i] = 0
			else:
				if oldmaterials[i] - value[i] < 0:
					text += 'Gained '
					input_handler.emit_signal("MaterialObtained", i)
				else:
					text += "Lost "
				text += str(value[i] - oldmaterials[i]) + ' {color=yellow|' + Items.materiallist[i].name + '}'
				#logupdate(text)
	materials = value
	oldmaterials = materials.duplicate()

func remove_item(itemcode, number):
	while number > 0:
		var item
		for i in items.values():
			if i.itembase == itemcode && i.owner == null:
				item = i
				break
		if item != null:
			item.amount -= 1
		number -= 1

func set_material(material, operant, value):
	match operant:
		'+':
			materials[material] += value
		'-':
			materials[material] -= value
		'*':
			materials[material] *= value
		"/":
			materials[material] /= value
		'=':
			materials[material] = value

func get_food():
	var counter = 0
	for i in materials:
		if Items.materiallist[i].type == 'food' && i != 'grain':
			counter += materials[i]
	return counter

#mansion
func get_pop_cap():
	return variables.base_population_cap + variables.population_cap_per_room_upgrade * upgrades.rooms

#checks
func if_has_money(value):
	return (money >= value)

func if_has_material(mat, operant, val):
	if !materials.has(mat): return false
	return input_handler.operate(operant, materials[mat], val)

func if_has_items(name, operant, value):
	var counter = 0
	for i in items.values():
		if i.itembase == name:
			counter += i.amount
	return input_handler.operate(operant, counter, value)

func if_has_free_items(name, operant, value):
	var counter = 0
	for i in items.values():
		if i.itembase == name && i.owner == null:
			counter += i.amount
	return input_handler.operate(operant, counter, value)

func if_has_upgrade(upgrade, level):
	if !upgrades.has(upgrade): return false
	else: return upgrades[upgrade] >= level

func update_money(operant, value):
	match operant:
		'+':
			money += value
			globals.text_log_add('money',"Gold get: " + str(value))
		'-':
			money -= value
			globals.text_log_add('money',"Gold used: " + str(value))
		'=':
			money = value

func update_materials(operant, material, value):
	match operant:
		'+':
			materials[material] += value
#			globals.text_log_add('money',"Gold get: " + str(value))
		'-':
			materials[material] -= value
#			globals.text_log_add('money',"Gold used: " + str(value))
		'=':
			materials[material] = value

func get_item_id_by_code(itembase):
	for item in items.values():
		if item.itembase == itembase:
			return item.id
	return null
