extends Reference
#extends Node

var itemcounter = 0
var money = 0 setget set_money
var upgrades = {}
var upgrade_progresses = {}
var selected_upgrade = {code = '', level = 0}#not sure
var items = {}
var craftinglists = {alchemy = [], smith = [], cooking = [], tailor = []}
var materials = {} setget materials_set
var oldmaterials = {}
var upgrades_queue = []
var tax = 0

func _init():
	for i in upgradedata.upgradelist.keys():
		upgrades[i] = 0
	for i in Items.materiallist:
		materials[i] = 0


func fix_serialization():
	var clear_array = []
	for i in items:
		if items[i].itembase == 'sensetivity_pot':
			clear_array.append(i)
			continue
		if items[i].amount <= 0:
			clear_array.append(i)
			continue
		items[i] = dict2inst(items[i])
		if items[i].type == 'gear':
			items[i].fix_gear()
	for i in clear_array:
		items.erase(i)
	clear_array.clear()
	for i in materials:
		if !Items.materiallist.has(i):
			clear_array.push_back(i)
	for i in clear_array:
		materials.erase(i)
	oldmaterials = materials.duplicate()
	for i in upgradedata.upgradelist.keys():
		if !upgrades.has(i):
			upgrades[i] = 0
	fix_tax()
	
	for item in Items.materiallist:
		if !ResourceScripts.game_res.materials.keys().has(item):
			ResourceScripts.game_res.materials[item] = 0
			print_debug("Added res on load: " + item)
#	fix_items_inventory(false)

func serialize():
#	fix_items_inventory(true)
	var res = inst2dict(self)
	res.items = {}
	for i in items:
		res.items[i] = inst2dict(items[i])
#	fix_items_inventory(false)
	return res


func fix_tax():
	tax = 0
	for upgrade in upgrades:
		if upgrades[upgrade] <= 0: continue
		var udata = upgradedata.upgradelist[upgrade]
		if udata.has('tax'): #not used but may be needed later
			tax += udata.tax
		if udata.has('levels'):
			for lv in range(upgrades[upgrade]):
				var ldata = udata.levels[lv + 1]
				if ldata.has('tax'):
					tax += ldata.tax


func subtract_taxes():
	ResourceScripts.game_party.subtract_taxes()
	money -= tax
	if money < 0:
		input_handler.interactive_message('money_lose_scene', '', {})


#inventory
func set_money(value):
	money = value
	globals.emit_signal("update_clock")

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
			if (i.code == itemcode or i.itembase == itemcode) and i.owner == null:
				item = i
				break
		if item != null:
			item.amount -= 1
		number -= 1
#

func remove_item_id(id):
	items.erase(id)


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
	globals.emit_signal("update_clock")

func update_materials(operant, material, value):
	match operant:
		'+':
			materials[material] += value
		'-':
			materials[material] -= value
		'=':
			materials[material] = value
	globals.emit_signal("update_clock")

func get_item_id_by_code(itembase):
	for item in items.values():
		if item.itembase == itembase:
			return item.id
	return null


func findupgradelevel(upgrade_code):
	var rval = 0
	if upgrades.has(upgrade_code):
		rval = upgrades[upgrade_code]
	return int(rval)


func add_upgrade_to_queue(upgrade_id):
	var upgrade_data = upgradedata.upgradelist[upgrade_id]
	var upgrade_lv = findupgradelevel(upgrade_id)
	var upgrade_next_state = null
	if upgrade_data.levels.has(upgrade_lv + 1):
		upgrade_next_state = upgrade_data.levels[upgrade_lv + 1]

	if upgrades_queue.has(upgrade_id):
		input_handler.SystemMessage("Upgrade already in the queue.")
		#something goes wrong for confirm button shoul be disabled in this case
		return
	if ResourceScripts.game_progress.free_upgrades == false and !upgrade_progresses.has(upgrade_id):
		for i in upgrade_next_state.cost:
			if i == 'gold':
				money -= int(upgrade_next_state.cost[i])
			else:
				materials[i] -= int(upgrade_next_state.cost[i])

	if ResourceScripts.game_progress.instant_upgrades == false:
		upgrades_queue.append(upgrade_id)
		if !upgrade_progresses.has(upgrade_id):
			upgrade_progresses[upgrade_id] = {level = upgrade_lv + 1, progress = 0}
	else:
		if upgrades.has(upgrade_id):
			upgrades[upgrade_id] += 1
		else:
			upgrades[upgrade_id] = 1


func make_item(temprecipe, character):
	var recipe = Items.recipes[temprecipe.code]
	temprecipe.resources_taken = false
	if recipe.resultitemtype == 'material':
		materials[recipe.resultitem] += recipe.resultamount
	else:
		var item = Items.itemlist[recipe.resultitem]
		globals.text_log_add("crafting", "Item created: " + item.name)
		if item.type == 'usable':
			globals.AddItemToInventory(globals.CreateUsableItem(item.code))
		elif item.type == 'gear':
			if recipe.crafttype == 'modular':
				globals.AddItemToInventory(globals.CreateGearItemCraft(item.code, temprecipe.partdict, character))
			else:
				globals.AddItemToInventory(globals.CreateGearItem(item.code, {}))


func make_item_sequence(currenttask, craftingitem, character):
	if craftingitem.workunits >= craftingitem.workunits_needed:
		make_item(craftingitem, character)
		if craftingitem.repeats > 0:
			craftingitem.repeats -= 1
		craftingitem.workunits -= craftingitem.workunits_needed
		if Items.recipes[craftingitem.code].resultitemtype != 'material' && randf() < 0.25:
			input_handler.get_person_for_chat(currenttask.workers, 'item_created')
		return craftingitem.workunits
	else:
		return 0


func add_craft_value(currenttask, value, character, _tres = false): #bad rework, but it should work for now
	var tres = false
	while true: #2rewrite with proper condition
		if craftinglists[currenttask.product].empty():
			if currenttask.messages.has('notask') == false and !tres:
				globals.text_log_add('crafting', character.get_short_name() + ": No craft task for " + currenttask.product.capitalize() + ". ")
				currenttask.messages.append('notask')
			break #empty queue
		var craftingitem = craftinglists[currenttask.product].front()
		currenttask.messages.erase("notask")
		if craftingitem.resources_taken == false:
			if globals.check_recipe_resources(craftingitem) == false:
				if currenttask.messages.has('noresources') == false:
					globals.text_log_add('crafting', character.get_short_name() + ": Not Enough Resources for craft. ")
					currenttask.messages.append("noresources")
				break #no res
			else:
				globals.spend_resources(craftingitem)
				currenttask.messages.erase("noresources")
		
		tres = true
		craftingitem.workunits += value #bad and counterintuitive way, 2rework
		
		value = make_item_sequence(currenttask, craftingitem, character)
		if value <= 0:
			break #task incomplete, all value spent
		if craftingitem.repeats == 0:
			var recipe = Items.recipes[craftingitem.code]
			var item
			if Items.recipes[craftingitem.code].resultitemtype != 'material':
				item = Items.itemlist[recipe.resultitem]
			else:
				item = Items.materiallist[recipe.resultitem]
			globals.text_log_add("crafting", "Task completed: " + item.name)
			craftinglists[currenttask.product].pop_front()
		else:
			value = 0
	
	return tres
	
#	if craftinglists[currenttask.product].empty():
#		if currenttask.messages.has('notask') == false and !tres:
#			globals.text_log_add('crafting', character.get_short_name() + ": No craft task for " + currenttask.product.capitalize() + ". ")
#			currenttask.messages.append('notask')
#		return tres
#	else:
#		
#		var newval = make_item_sequence(currenttask, craftingitem, character)
#		var repeat = newval > 0
#		if craftingitem.repeats == 0:
#			var recipe = Items.recipes[craftingitem.code]
#			var item
#			if Items.recipes[craftingitem.code].resultitemtype != 'material':
#				item = Items.itemlist[recipe.resultitem]
#			else:
#				item = Items.materiallist[recipe.resultitem]
#			globals.text_log_add("crafting", "Task completed: " + item.name)
#			craftinglists[currenttask.product].pop_front()
#		else:
#			newval = 0
#		if repeat:
#			return add_craft_value(currenttask, newval, character, true)
#		else: 
#			return true

func unlock_upgrade():
	pass

func add_build_value(currenttask, value, character, tres = false):
	if upgrades_queue.empty():
		if currenttask.messages.has("noupgrade") == false:
			globals.text_log_add('upgrades', character.get_short_name() + ": No task or upgrade selected for building. ")
			currenttask.messages.append("noupgrade")
		return tres
	else:
		currenttask.messages.erase('noupgrade')
		var curupgrade = upgrades_queue.front()
		if !upgrade_progresses.has(curupgrade):
			var currentupgradelevel
			if upgrades.has(curupgrade):
				currentupgradelevel = upgrades[curupgrade] + 1
				upgrade_progresses[curupgrade] = {level = currentupgradelevel, progress = 0}
		upgrade_progresses[curupgrade].progress += value
		var tdata = upgradedata.upgradelist[curupgrade]
		if upgrade_progresses[curupgrade].progress >= tdata.levels[int(upgrade_progresses[curupgrade].level)].taskprogress:
			var newval = upgrade_progresses[curupgrade].progress - tdata.levels[int(upgrade_progresses[curupgrade].level)].taskprogress
			if upgrades.has(curupgrade):
				upgrades[curupgrade] += 1
			else:
				upgrades[curupgrade] = 1
			
			if tdata.levels[int(upgrade_progresses[curupgrade].level)].has('tax'):
				tax += tdata.levels[int(upgrade_progresses[curupgrade].level)].tax
			
			input_handler.emit_signal("UpgradeUnlocked", upgradedata.upgradelist[curupgrade])
			globals.text_log_add('upgrades',"Upgrade finished: " + tdata.name)
			if curupgrade == "tattoo_set":
				input_handler.ActivateTutorial("tattoo")
			upgrade_progresses.erase(curupgrade)
			upgrades_queue.erase(curupgrade)
			return add_build_value(currenttask, newval, character, true)
		return true

func get_farm_slots():
	return variables.farm_produce_slots + variables.farm_produce_slots_per_upgrade*upgrades['farm_slots']
