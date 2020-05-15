extends Node

const gameversion = '0.2.1'

#time
signal hour_tick
signal task_added
signal slave_added
signal slave_arrived

var hour_turns_set = 1

#guistate maybe for removing
var CurrentTextScene
var CurrentScreen
var CurrentLine = 0
var log_node
var log_storage = []

var start_new_game = false

#var SpriteDict = {}
var EventList 

var rng := RandomNumberGenerator.new()
var file = File.new()
var dir = Directory.new()

var workersdict
var randomgroups

var enemylist
var upgradelist
var skills
var effects
var combateffects
var explorationares 

var current_level
var current_stage
var current_enemy_group

var scenes = {}

var sex_actions_dict = {}

#warning-ignore:unused_signal
signal scene_changed

func _init():
	#for logging purposes
	print("Game Version: " + str(gameversion))
	print("OS: " +  OS.get_name()) 
	
	if dir.dir_exists(variables.userfolder + 'saves') == false:
		dir.make_dir(variables.userfolder + 'saves')
	
	for i in input_handler.dir_contents('res://src/actions'):
		if i.find('.remap') >= 0:
			continue
		var newaction = load(i).new()
		sex_actions_dict[newaction.code] = newaction
	
	for i in input_handler.dir_contents("res://assets/data/events"):
		if i.find('.gd') < 0:
			continue
		var newscript  = load(i).new()
		for k in newscript.data:
			if scenedata.scenedict.has(k) == false:
				scenedata.scenedict[k] = newscript.data[k]
			else:
				print("Error: Scene data key already exists: " + k)


func _ready():
	randomize() #for legacy code sake
	rng.randomize()
	ResourceScripts.recreate_singletons()
	ResourceScripts.revert_gamestate()
	for i in variables.resists_list:
		statdata.statdata['resist'+i] = {code = "resist"+i}
	
	for i in statdata.statdata.values():
		i.name = tr("STAT" + i.code.to_upper())
		i.descript = tr("STAT" + i.code.to_upper() + "DESCRIPT")
	
	for i in upgradedata.upgradelist.values():
		i.name = tr("UPGRADE" + i.code.to_upper())
		i.descript = tr("UPGRADE" + i.code.to_upper() + "DESCRIPT")
	
	for i in statdata.worktoolnames:
		statdata.worktoolnames[i] = tr("WORKTOOL" + i.to_upper())
	
	for i in ResourceScripts.descriptions.bodypartsdata:
		for k in ResourceScripts.descriptions.bodypartsdata[i].values():
			k.name = tr("BODYPART" + i.to_upper() + k.code.to_upper())
#			text += k.name + ' = "' + k.code + '",\n'
			k.chardescript = tr("BODYPART" + i.to_upper() + k.code.to_upper() + "DESCRIPT")
	
	modding_core.fix_main_data_preload()
	modding_core.process_data_mods()
	modding_core.fix_main_data_postload()


#not used
#func EventCheck():
#	if state.CurEvent != "": return;
#	for s in get_tree().get_nodes_in_group('char_sprite'):
#		s.set_active_val();
#	for event in EventList.keys():
#		if SimpleEventCheck(event, false):
#			StartEventScene(event);
#			break;
#
#func SimpleEventCheck(event, skip = true):
#	#var tmp_d = {global = 'skip'};
#	if state.OldEvents.has(event):
#		return false
#	for check in EventList[event]:
#		if check.size() == 0:
#			if skip:
#				continue
#			else:
#				return false
#		if !globals.valuecheck(check): 
#			return false
#	return true
#
#func LoadEvent(name):
#	var dict
#
#	if file.file_exists("res://assets/data/events/"+ name + '.json'):
#		file.open("res://assets/data/events/"+ name + '.json', File.READ)
#		dict = parse_json(file.get_as_text())
#		file.close()
#	else:
#		print('Event not found: ' + name)
#	return dict
#
#func StartEventScene(name, debug = false, line = 0):
#	state.CurEvent = name;
#	scenes[name] = LoadEvent(name)
#	var scene = input_handler.get_spec_node(input_handler.NODE_EVENT) #input_handler.GetEventNode()
#	scene.visible = true
#	scene.Start(scenes[name], debug, line)

func check_duplicates(item, parts):
	for i in ResourceScripts.game_res.items.values():
		if str(i.itembase) == str(item) && str(i.parts) == str(parts) && i.owner == null:
			return i.id

func CreateGearItem(item, parts, bonus = {}, newname = null):
	var newitem = Item.new()
	newitem.CreateGear(item, parts, bonus)
	if newname != null:
		newitem.name = newname
	return newitem

func CreateUsableItem(item, amount = 1):
	var newitem = Item.new()
	newitem.CreateUsable(item, amount)
	return newitem

func AddItemToInventory(item, dont_duplicate = true):
#	item.inventory = ResourceScripts.game_res.items
	if dont_duplicate && item.stackable == false:
		var duplicate = check_duplicates(item.itembase, item.parts)
		if duplicate != null:
			ResourceScripts.game_res.items[duplicate].amount += 1
			item.amount = 0
			return
	if item.stackable == false:
		item.id = "i" + str(ResourceScripts.game_res.itemcounter)
		ResourceScripts.game_res.items[item.id] = item
		ResourceScripts.game_res.itemcounter += 1
	else:
		var id = get_item_id_by_code(item.itembase)
		if id != null:
			ResourceScripts.game_res.items[id].amount += item.amount
		else:
			item.id = "i" + str(ResourceScripts.game_res.itemcounter)
			ResourceScripts.game_res.items[item.id] = item
			ResourceScripts.game_res.itemcounter += 1

func get_item_id_by_code(itembase):
	return ResourceScripts.game_res.get_item_id_by_code(itembase)

func connecttexttooltip(node, text):
	if node.is_connected("mouse_entered",self,'showtexttooltip'):
		node.disconnect("mouse_entered",self,'showtexttooltip')
	node.connect("mouse_entered",self,'showtexttooltip', [node, text])

func showtexttooltip(node, text):
	var texttooltip = input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP) #input_handler.GetTextTooltip()
	texttooltip.showup(node, text)

func connectitemtooltip(node, item):
	if node.is_connected("mouse_entered",item,'tooltip'):
		node.disconnect("mouse_entered",item,'tooltip')
	node.connect("mouse_entered",item,'tooltip', [node])

func connecttempitemtooltip(node, item, mode):
	if node.is_connected("mouse_entered",self,'tempitemtooltip'):
		node.disconnect("mouse_entered",self,'tempitemtooltip')
	node.connect("mouse_entered",self,'tempitemtooltip', [node, item, mode])

func tempitemtooltip(targetnode, item, mode):
	var node = input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP) #input_handler.GetItemTooltip()
	var data = {}
	var text = '[center]' + item.name + '[/center]\n' + item.descript
	data.text = text
	data.item = item
	data.icon = item.icon
	data.price = str(item.price)
	node.showup(targetnode, data, mode)

func connectskilltooltip(node, skill, character):
	if node.is_connected("mouse_entered",self,'showskilltooltip'):
		node.disconnect("mouse_entered",self,'showskilltooltip')
	node.connect("mouse_entered",self,'showskilltooltip', [skill,node,character])

func showskilltooltip(skill, node, character):
	var skilltooltip = input_handler.get_spec_node(input_handler.NODE_SKILLTOOLTIP) #input_handler.GetSkillTooltip()
	skilltooltip.character = character
	skilltooltip.showup(node, skill)

func closeskilltooltip():
	var skilltooltip = input_handler.get_spec_node(input_handler.NODE_SKILLTOOLTIP) #input_handler.GetSkillTooltip()
	skilltooltip.set_process(false)
	skilltooltip.hide()

#func disconnectitemtooltip(node, item):
#	if node.is_connected("mouse_entered",item,'tooltip'):
#		node.disconnect("mouse_entered",item,'tooltip')

func connectmaterialtooltip(node, material, bonustext = ''):
	if node.is_connected("mouse_entered",self,'mattooltip'):
		node.disconnect("mouse_entered",self,'mattooltip')
	node.connect("mouse_entered",self,'mattooltip', [node, material, bonustext])

func connectslavetooltip(node, person):
	if node.is_connected("mouse_entered",self,'slavetooltip'):
		node.disconnect("mouse_entered",self,'slavetooltip')
	node.connect("mouse_entered",self,'slavetooltip', [node, person])

func slavetooltip(targetnode, person):
	var node = input_handler.get_spec_node(input_handler.NODE_SLAVETOOLTIP) #input_handler.GetSlaveTooltip()
	node.showup(targetnode, person)

func mattooltip(targetnode, material, bonustext = '', type = 'materialowned'):
	var image
	var node = input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP) #input_handler.GetItemTooltip()
	var data = {}
	var text = '[center]' + material.name + '[/center]\n' + material.descript
	data.text = text + bonustext
	data.item = material
	data.icon = material.icon
	data.price = str(material.price)
	if ResourceScripts.game_res.materials[material.code] > 0:
		data.amount = ResourceScripts.game_res.materials[material.code]
	
	node.showup(targetnode, data, type)


func TextEncoder(text, node = null):
	var tooltiparray = []
	var counter = 0
	while text.find("{") != -1:
		var newtext = text.substr(text.find("{"), text.find("}") - text.find("{")+1)
		var newtextarray = newtext.split("|")
		var originaltext = newtextarray[newtextarray.size()-1].replace("}",'')
		newtextarray.remove(newtextarray.size()-1)
		var startcode = ''
		var endcode = ''
		for data in newtextarray:
			data = data.replace('{','').split("=")
			match data[0]:
				'color':
					startcode += '[color=' + variables.hexcolordict[data[1]] + ']'
					endcode = '[/color]' + endcode
				'url':
					tooltiparray.append(data[1])
					startcode += '[url=' + str(counter) + ']'
					endcode = '[/url]' + endcode
					counter += 1
				'check':
					if input_handler.evaluate(data[1]) == false:
						originaltext = ''
				'random_chat':
					var character = input_handler.scene_characters[int(data[1])]
					originaltext = character.translate(input_handler.get_random_chat_line(character, originaltext))
				'custom_text_function':
					originaltext = originaltext + ResourceScripts.custom_text.get_custom_text(data[1])
		
		text = text.replace(newtext, startcode + originaltext + endcode)
	if node != null:
		node.bbcode_text = text
		if tooltiparray.size() != 0:
			node.set_meta('tooltips', tooltiparray)
			if node.is_connected("meta_hover_started", self, "BBCodeTooltip") == false:
				node.connect("meta_hover_started", self, "BBCodeTooltip", [node])
				node.connect("meta_hover_ended",self, 'hidetooltip')
	else:
		return input_handler.text_cut_excessive_lines(text)

func BBCodeTooltip(meta, node):
	var text = node.get_meta('tooltips')[int(meta)]
	#showtooltip(text, node)

func ItemSelect(targetscript, type, function, requirements = true):
	var node 
	if get_tree().get_root().has_node("ItemSelect"):
		node = get_tree().get_root().get_node("ItemSelect")
		get_tree().get_root().remove_child(node)
		get_tree().get_root().add_child(node)
	else:
		node = load(ResourceScripts.scenedict.itemselect).instance()
		get_tree().get_root().add_child(node)
		input_handler.AddPanelOpenCloseAnimation(node)
		node.name = 'ItemSelect'
	
	node.show()
	
	input_handler.ClearContainer(node.get_node("ScrollContainer/GridContainer"))
	var array = []
	if type == 'gear':
		for i in ResourceScripts.game_res.items.values():
			if i.geartype == requirements && i.task == null && i.owner == null && i.durability > 0:
				array.append(i)
	elif type == 'repairable':
		for i in ResourceScripts.game_res.items.values():
			if i.durability < i.maxdurability:
				array.append(i)
	elif type == 'sex_use':
		for i in ResourceScripts.game_res.items.values():
			if i.interaction_use == true:
				array.append(i)
	
	for i in array:
		var newnode = input_handler.DuplicateContainerTemplate(node.get_node("ScrollContainer/GridContainer"))
		match type:
			'gear':
				i.set_icon(newnode.get_node("icon"))
				newnode.get_node("Percent").show()
				newnode.get_node("Percent").text = str(input_handler.calculatepercent(i.durability, i.maxdurability)) + '%'
				connectitemtooltip(newnode, i)
			'sex_use':
				i.set_icon(newnode.get_node("icon"))
				newnode.get_node("Percent").show()
				newnode.get_node('name').text = i.name
				newnode.get_node("Percent").text = str(i.amount)
				connectitemtooltip(newnode, i)
		newnode.connect('pressed', targetscript, function, [i])
		newnode.connect('pressed',input_handler,'CloseSelection', [node])

func QuickSave():
	SaveGame('QuickSave')

func autosave():
#	var maxcounter = globalsettings.autosave_number
#	var counter = 1
#	var savegame = File.new()
#	var dir = Directory.new()
#	var savesdir = dir_contents(userfolder + 'saves')
#	var filearray = globals.dir_contents()
#	var path = 'user://saves/'
#	if filearray.has(path+"autosave2"):
#		dir.rename(path+'autosave2',path+'autosave3')
#		if globals.savelist.has(path + 'autosave2'):
#			globals.savelist[path+'autosave3'] = globals.savelist[path + 'autosave2']
#		else:
#			globals.savelist[path+'autosave3'] = globals.savelistentry(path+'autosave3')
#	if filearray.has(path+"autosave1"):
#		dir.rename(path+'autosave1',path+'autosave2')
#		if globals.savelist.has(path + 'autosave1'):
#			globals.savelist[path+'autosave2'] = globals.savelist[path + 'autosave1']
#		else:
#			globals.savelist[path+'autosave2'] = globals.savelistentry(path+'autosave2')
	#var thread = 
# warning-ignore:return_value_discarded
	SaveGame('autosave')
#	var thread = Thread.new()
#	thread.start(globals,"SaveGame",'autosave')
#	thread.wait_to_finish()

func SaveGame(name):
	var savedict = {}#state.serialize(); 
	savedict.charpool = characters_pool.serialize()
	savedict.effpool = effects_pool.serialize()
	
#	ResourceScripts.game_res.fix_items_inventory(true)
	for p in ResourceScripts.gamestate:
		savedict[p] = ResourceScripts.get(p).serialize()
#	ResourceScripts.game_res.fix_items_inventory(false)
	
	file.open(variables.userfolder + 'saves/' + name + '.sav', File.WRITE)
	file.store_line(to_json(savedict))
	file.close()
	var metadata = ConfigFile.new()
	var config_data = {version = gameversion, time = OS.get_datetime(), master_name = ResourceScripts.game_party.get_master().get_stat('name'), day = ResourceScripts.game_globals.date, hour = ResourceScripts.game_globals.hour, population = ResourceScripts.game_party.characters.size(), gold = ResourceScripts.game_res.money, master_icon = ResourceScripts.game_party.get_master().get_icon(true), preset = ResourceScripts.game_globals.starting_preset}
	for i in config_data:
		metadata.set_value('details', i, config_data[i])
	metadata.save(variables.userfolder + "saves/" + name + ".dat")
	input_handler.SystemMessage("Game saved as " + name + ".sav")

func LoadGame(filename):
	if !file.file_exists(variables.userfolder+'saves/'+ filename + '.sav') :
		print("no file %s" % (variables.userfolder+'saves/'+ filename + '.sav'))
		return
	
	ResourceScripts.core_animations.BlackScreenTransition(1)
	yield(get_tree().create_timer(1), 'timeout')
	input_handler.CloseableWindowsArray.clear()
	ResourceScripts.revert_gamestate()
	
	file.open(variables.userfolder+'saves/'+ filename + '.sav', File.READ)
	var savedict = parse_json(file.get_as_text())
	file.close()
	
#	state.deserialize(savedict)
	characters_pool.deserialize(savedict.charpool)
	for p in ResourceScripts.gamestate:
		ResourceScripts.set(p, dict2inst(savedict[p]))
	ResourceScripts.game_res.fix_serialization()
#	ResourceScripts.game_res.fix_items_inventory(false)
	ResourceScripts.game_party.fix_serialization()
	effects_pool.deserialize(savedict.effpool)
	characters_pool.cleanup()
	effects_pool.cleanup()
	
	#current approach
	input_handler.CurrentScene.queue_free()
	input_handler.ChangeScene('mansion');
	yield(self, "scene_changed")
	input_handler.SystemMessage("Game Loaded")


func get_last_save():
	var dir = input_handler.dir_contents(variables.userfolder + 'saves')
	var dated_dir = {}
	var tmp = File.new()
	for i in dir:
		if i.ends_with('.sav') == false:
			continue
		dated_dir[i] = OS.get_datetime_from_unix_time(tmp.get_modified_time(i))
	if dated_dir.size() == 0: return null
	var b = dated_dir.keys()[0]
	for i in range(dated_dir.keys().size()):
		if datetime_comp(dated_dir[dated_dir.keys()[i]], dated_dir[b]):
			b = dated_dir.keys()[i]
	return b

func datetime_comp(a, b):
	if a.year > b.year: return true
	if a.month > b.month: return true
	if a.day > b.day: return true
	if a.hour > b.hour: return true
	if a.minute > b.minute: return true
	if a.second > b.second: return true
	return false

func fastif(value, result1, result2):
	if value:
		return result1
	else:
		return result2

func return_to_main_menu():
	input_handler.CurrentScene.queue_free()
	input_handler.ChangeScene('menu')
	ResourceScripts.revert_gamestate()
#	ResourceScripts.recreate_singletons()

func addrelations(person, person2, value):
	var rel = person.get_stat('relations', true)
	var rel2 = person2.get_stat('relations', true)
	if person.has_profession("master") || person2.has_profession("master") || person == person2:
		return
	if rel.has(person2.id) == false:
		rel[person2.id] = 0
	if rel2.has(person.id) == false:
		rel2[person.id] = 0
	if rel[person2.id] > 500 && value > 0 && checkifrelatives(person, person2):
		value = value/1.5
	elif rel[person2.id] < -500 && value < 0 && checkifrelatives(person,person2):
		value = value/1.5
	rel[person2.id] += value
	rel[person2.id] = clamp(rel[person2.id], -1000, 1000)
	rel2[person.id] = rel[person2.id]
	#for no stress attribute
#	if person.relations[person2.id] < -200 && value < 0:
#		person.stress += rand_range(4,8)
#		person2.stress += rand_range(4,8)

func connectrelatives(person1, person2, way):
	if person1 == null || person2 == null:
		return
	if ResourceScripts.game_party.relativesdata.has(person1.id) == false:
		createrelativesdata(person1)
	if ResourceScripts.game_party.relativesdata.has(person2.id) == false:
		createrelativesdata(person2)
	if way in ['mother','father']:
		var entry = ResourceScripts.game_party.relativesdata[person1.id]
		entry.children.append(person2.id)
		for i in entry.children:
			if i != person2.id:
				var entry2 = ResourceScripts.game_party.relativesdata[i]
				connectrelatives(person2, entry2, 'sibling')
		entry = ResourceScripts.game_party.relativesdata[person2.id]
		entry[way] = person1.id
		if typeof(person1) != TYPE_DICTIONARY && typeof(person2) != TYPE_DICTIONARY:
			addrelations(person1, person2, 200)
	elif way == 'sibling':
		var entry = ResourceScripts.game_party.relativesdata[person1.id]
		var entry2 = ResourceScripts.game_party.relativesdata[person2.id]
		if entry.siblings.has(entry2.id) == false: entry.siblings.append(entry2.id)
		if entry2.siblings.has(entry.id) == false: entry2.siblings.append(entry.id)
		for i in entry.siblings + entry2.siblings:
			if !ResourceScripts.game_party.relativesdata[i].siblings.has(entry.id) && i != entry.id:
				ResourceScripts.game_party.relativesdata[i].siblings.append(entry.id)
			if !ResourceScripts.game_party.relativesdata[i].siblings.has(entry2.id) && i != entry2.id:
				ResourceScripts.game_party.relativesdata[i].siblings.append(entry2.id)
			if !entry.siblings.has(i) && i != entry.id:
				entry.siblings.append(i)
			if !entry2.siblings.has(i) && i != entry2.id:
				entry2.siblings.append(i)
		
		if typeof(person1) != TYPE_DICTIONARY && typeof(person2) != TYPE_DICTIONARY:
			addrelations(person1, person2, 0)


func createrelativesdata(person):
	var newdata = {name = person.get_full_name(), id = person.id, race = person.get_stat('race'), sex = person.get_stat('sex'), mother = -1, father = -1, siblings = [], halfsiblings = [], children = []}
	ResourceScripts.game_party.relativesdata[person.id] = newdata

func clearrelativesdata(id):
	var entry
	if ResourceScripts.game_party.relativesdata.has(id):
		entry = ResourceScripts.game_party.relativesdata[id]
		
		for i in ['mother','father']:
			if ResourceScripts.game_party.relativesdata.has(entry[i]):
				var entry2 = ResourceScripts.game_party.relativesdata[entry[i]]
				entry2.children.erase(id)
		for i in entry.siblings:
			if ResourceScripts.game_party.relativesdata.has(i):
				var entry2 = ResourceScripts.game_party.relativesdata[i]
				entry2.siblings.erase(id)
	
	ResourceScripts.game_party.relativesdata.erase(id)

func checkifrelatives(person, person2):
	var result = false
	var data1 
	var data2
	if ResourceScripts.game_party.relativesdata.has(person.id):
		data1 = ResourceScripts.game_party.relativesdata[person.id]
	else:
		createrelativesdata(person)
		data1 = ResourceScripts.game_party.relativesdata[person.id]
	if ResourceScripts.game_party.relativesdata.has(person2.id):
		data2 = ResourceScripts.game_party.relativesdata[person2.id]
	else:
		createrelativesdata(person2)
		data2 = ResourceScripts.game_party.relativesdata[person2.id]
	for i in ['mother','father']:
		if str(data1[i]) == str(data2.id) || str(data2[i]) == str(data1.id):
			result = true
	for i in [data1, data2]:
		if i.siblings.has(data1.id) || i.siblings.has(data2.id):
			result = true
	
	return result

func getrelativename(person, person2):
	var result = null
	var data1 
	var data2
	if ResourceScripts.game_party.relativesdata.has(person.id):
		data1 = ResourceScripts.game_party.relativesdata[person.id]
	else:
		createrelativesdata(person)
		data1 = ResourceScripts.game_party.relativesdata[person.id]
	if ResourceScripts.game_party.relativesdata.has(person2.id):
		data2 = ResourceScripts.game_party.relativesdata[person2.id]
	else:
		createrelativesdata(person2)
		data2 = ResourceScripts.game_party.relativesdata[person2.id]
	
	#print(data1, data2)
	for i in ['mother','father']:
		if str(data1[i]) == str(data2.id):
			result = '$parent'
		elif str(data2[i]) == str(data1.id):
			result = '$son'
	for i in [data1, data2]:
		if i.siblings.has(data1.id) || i.siblings.has(data2.id):
			result = '$sibling'
	if result != null:
		result = person2.dictionary(result)
	return result

func impregnate(father, mother):
	if mother.get_stat('has_womb') == false || mother.get_stat('pregnancy').duration != 0:
		return
	var check = true
	if father.get_stat('race') != mother.get_stat('race'):
		for i in [father, mother]:
			var race = i.get_stat('race')
			if race.find("Beastkin") >= 0:
				race = 'Beastkin'
			elif race.find('Halfkin') >= 0:
				race = "Halfkin"
			
			if variables.impregnation_compatibility.has(race) == false:
				print("Impregnation incompatibility")
				check = false
	if (check == false) && (mother.has_profession('breeder') == false):
		print("Impregnation check failed")
		return #incompatible races
	var baby = ResourceScripts.scriptdict.class_slave.new()
	baby.setup_baby(mother, father)

func calculate_travel_time(location1, location2):
	var travel_value1 = 0 #time to travel to location from mansion
	var travel_value2 = 0 #time to return to mansion from location
	if location1 != 'mansion':
		travel_value1 = ResourceScripts.world_gen.get_area_from_location_code(location1).travel_time + ResourceScripts.world_gen.get_location_from_code(location1).travel_time
	if location2 != 'mansion':
		travel_value2 = ResourceScripts.world_gen.get_area_from_location_code(location2).travel_time + ResourceScripts.world_gen.get_location_from_code(location2).travel_time
	
	return {time = travel_value1 + travel_value2, obed_cost = travel_value1*1.5}

func check_recipe_resources(temprecipe):
	var recipe = Items.recipes[temprecipe.code]
	if recipe.crafttype == 'basic':
		var check = true
		for i in recipe.materials:
			if ResourceScripts.game_res.materials[i] < recipe.materials[i]:
				check = false
		for i in recipe.items:
			if ResourceScripts.game_res.if_has_free_items(i, 'gte', recipe.items[i]) == false:
				check = false
		if check == false:
			return false
	else:
		var item = Items.itemlist[recipe.resultitem]
		var check = true
		for i in temprecipe.partdict:
			if ResourceScripts.game_res.materials[temprecipe.partdict[i]] < item.parts[i]:
				check = false
		if check == false:
			return false
	return true

func spend_resources(temprecipe):
	var recipe = Items.recipes[temprecipe.code]
	if recipe.crafttype == 'basic':
		for i in recipe.materials:
			ResourceScripts.game_res.materials[i] -= recipe.materials[i]
		for i in recipe.items:
			ResourceScripts.game_res.remove_item(i, recipe.items[i])
	else:
		var item = Items.itemlist[recipe.resultitem]
		for i in temprecipe.partdict:
			ResourceScripts.game_res.materials[temprecipe.partdict[i]] -= item.parts[i]
	temprecipe.resources_taken = true

func make_item(temprecipe):
	var recipe = Items.recipes[temprecipe.code]
	temprecipe.resources_taken = false
	if recipe.resultitemtype == 'material':
		ResourceScripts.game_res.materials[recipe.resultitem] += recipe.resultamount
	else:
		var item = Items.itemlist[recipe.resultitem]
		text_log_add("crafting", "Item created: " + item.name)
		if item.type == 'usable':
			AddItemToInventory(CreateUsableItem(item.code))
		elif item.type == 'gear':
			if recipe.crafttype == 'modular':
				AddItemToInventory(CreateGearItem(item.code, temprecipe.partdict))
			else:
				AddItemToInventory(CreateGearItem(item.code, {}))
	
	if temprecipe.repeats > 0:
		temprecipe.repeats -= 1
		if temprecipe.repeats == 0:
			ResourceScripts.game_res.craftinglists[Items.recipes[temprecipe.code].worktype].erase(temprecipe)

func text_log_add(label, text):
	log_storage.append({type = label, text = text, time = str(ResourceScripts.game_globals.date) + ":" + str(round(ResourceScripts.game_globals.hour))})
	if log_node != null && weakref(log_node) != null:
		var newfield = log_node.get_node("ScrollContainer/VBoxContainer/field").duplicate()
		newfield.show()
		newfield.get_node("label").bbcode_text = label
		newfield.get_node("text").bbcode_text = text
		newfield.get_node("date").bbcode_text = '[right]'+ str(ResourceScripts.game_globals.date) + " - " + str(round(ResourceScripts.game_globals.hour)) + ":00[/right]"
		log_node.get_node("ScrollContainer/VBoxContainer").add_child(newfield)
		yield(get_tree(), 'idle_frame')
		var textfield = newfield.get_node('text')
		textfield.rect_size.y = textfield.get_v_scroll().get_max()
		newfield.rect_min_size.y = textfield.rect_size.y

func character_stat_change(character, data):
	var text = character.get_short_name() + ": " + statdata.statdata[data.code].name 
	if data.operant == '+':
		text += " + "
		character.add_stat(data.code, data.value)
	else:
		text += " - "
		character.add_stat(data.code, -data.value)
	text += str(data.value)
	text_log_add('char', text)
#	character.set(data.code, input_handler.math(data.operant, character.get(data.code), data.value))

func make_local_recruit(args):
	var newchar = ResourceScripts.scriptdict.class_slave.new()
	if args == null:
		newchar.generate_random_character_from_data(input_handler.weightedrandom(input_handler.active_location.races))
	else:
		var race = 'random'
		var des_class = null
		var difficulty = 0
		if args.has('races'):
			race = input_handler.weightedrandom(args.races)
			if race == 'local':
				race = input_handler.weightedrandom(input_handler.active_area.races)
			elif race == 'beast':
				var racearray = []
				for i in races.racelist.values():
					if i.tags.has('beast') == true:
						racearray.append(i.code)
				race = racearray[randi()%racearray.size()]
		if args.has('difficulty'):
			difficulty = round(rand_range(args.difficulty[0], args.difficulty[1]))
		newchar.generate_random_character_from_data(race, des_class, difficulty)
		if args.has("bonuses"):
			newchar.add_stat_bonuses(args.bonuses)
		if args.has("type"):
			newchar.set_slave_category(args.type)
	if newchar.get_stat('slave_class') == '': newchar.set_slave_category('servant')
	if args.has("is_hirable"): newchar.is_hirable = args.is_hirable
	return newchar


func check_events(action):
	var eventarray = input_handler.active_location.scriptedevents
	var erasearray = []
	var eventtriggered = false
	for i in eventarray:
		if i.trigger == action && check_event_reqs(i.reqs) == true:
			if i.event == 'custom_event':
				input_handler.interactive_message_custom(scenedata.scenedict[i.args])
			elif i.has('args'):
				input_handler.call(i.event, i.args)
			else:
				input_handler.call(i.event)
			eventtriggered = true
			if i.has('oneshot') && i.oneshot == true:
				erasearray.append(i)
			break
	for i in erasearray:
		eventarray.erase(i)
	return eventtriggered

func check_random_event():
	if randf() > variables.dungeon_encounter_chance:
		return false
	var eventarray = input_handler.active_location.randomevents
	var eventtriggered = false
	var active_array = []
	for i in eventarray:
		var event = scenedata.scenedict[i[0]]
		if event.has('reqs'):
			if globals.checkreqs(event.reqs):
				active_array.append(i)
		else:
			active_array.append(i)
	if active_array.size() > 0:
		active_array = input_handler.weightedrandom(active_array)
		var eventtype = "event_selection"
		var dict = {}
		if scenedata.scenedict[active_array].has("default_event_type"):
			eventtype = scenedata.scenedict[active_array].default_event_type
		if scenedata.scenedict[active_array].has('bonus_args'):
			dict = scenedata.scenedict[active_array].bonus_args
		input_handler.interactive_message(active_array, eventtype, dict)
		eventtriggered = true
	return eventtriggered

func check_event_reqs(reqs):
	var check = true
	for i in reqs:
		match i.code:
			'level':
				check = input_handler.operate(i.operant, current_level, i.value)
			'stage':
				check = input_handler.operate(i.operant, current_stage, i.value)
		if check == false:
			break
	return check

func check_location_group():
	var counter = 0
	var cleararray = []
	for i in input_handler.active_location.group:
		if ResourceScripts.game_party.characters.has(input_handler.active_location.group[i]): 
			counter += 1
		else:
			cleararray.append(i)
	for i in cleararray:
		input_handler.active_location.erase(i)
	if counter == 0:
		return false
	else:
		return true

func StartCombat(encounter = null):
	var data
	if encounter != null:
		data = Enemydata.encounters[encounter]
		input_handler.encounter_win_script = Enemydata.encounters[encounter].win_effects
	
	if variables.skip_combat == true:
		input_handler.finish_combat()
		return
	
	if encounter == null:
		StartAreaCombat()
		return
	
	var enemies
	var enemy_stats_mod = 1
	match data.unittype:
		'randomgroup':
			enemies = make_enemies(data.unitcode)
#	var combat = get_combat_node()
#	combat.encountercode = data.unitcode
	if input_handler.combat_node == null:
		input_handler.combat_node = input_handler.get_combat_node()
	input_handler.combat_node.encountercode = data.unitcode
	
	input_handler.combat_node.start_combat(input_handler.active_location.group, enemies, data.bg, data.bgm, enemy_stats_mod)

func StartQuestCombat(encounter):
	pass

func StartAreaCombat():
	var enemydata
	var enemygroup = {}
	var enemies = []
	var music = 'combattheme'
	
	for i in input_handler.active_location.stagedenemies:
		if i.stage == current_stage && i.level == current_level:
			enemydata = i.enemy#[i.enemy,1]
	if enemydata == null:
		enemydata = input_handler.active_location.enemies
	
	enemies = make_enemies(enemydata)
	
	var enemy_stats_mod = (1 - variables.difficulty_per_level) + variables.difficulty_per_level * current_level
	
	if input_handler.combat_node == null:
		input_handler.combat_node = input_handler.get_combat_node()
	input_handler.combat_node.encountercode = enemydata
	input_handler.combat_node.start_combat(input_handler.active_location.group, enemies, 'background', music, enemy_stats_mod)

func make_enemies(enemydata):
	var enemies
	if typeof(enemydata) == TYPE_ARRAY:
		enemies = input_handler.weightedrandom(enemydata)
		enemies = makerandomgroup(Enemydata.enemygroups[enemies])
	elif Enemydata.enemygroups.has(enemydata):
		enemies = makerandomgroup(Enemydata.enemygroups[enemydata])
	else:
		enemies = makespecificgroup(enemydata)
	return enemies

func makespecificgroup(group):
	var enemies = Enemydata.predeterminatedgroups[group]
	var combatparty = {1 : null, 2 : null, 3 : null, 4 : null, 5 : null, 6 : null}
	for i in enemies.group:
		combatparty[i] = enemies.group[i]
	
	return combatparty

func makerandomgroup(enemygroup):
	var array = []
	for i in enemygroup.units:
		var size = round(rand_range(enemygroup.units[i][0],enemygroup.units[i][1]))
		if size != 0:
			array.append({units = i, number = size})
	var countunits = 0
	for i in array:
		countunits += i.number
	if countunits > 6:
		array[randi()%array.size()].number -= (countunits-6)
	
	#Assign units to rows
	var combatparty = {1 : null, 2 : null, 3 : null, 4 : null, 5 : null, 6 : null}
	for i in array:
		var unit = Enemydata.enemies[i.units]
		while i.number > 0:
			var temparray = []
			
			if true:
				#smart way
				for i in combatparty:
					if combatparty[i] != null:
						continue
					var aiposition = unit.ai_position[randi()%unit.ai_position.size()]
					if aiposition == 'melee' && i in [1,2,3]:
						temparray.append(i)
					if aiposition == 'ranged' && i in [4,5,6]:
						temparray.append(i)
				
				if temparray.size() <= 0:
					for i in combatparty:
						if combatparty[i] == null:
							temparray.append(i)
			else:
				#stupid way
				for i in combatparty:
					if combatparty[i] != null:
						temparray.append(i)
			
			if temparray.size() > 0:
				combatparty[temparray[randi()%temparray.size()]] = i.units
			i.number -= 1
	
	return combatparty

func remove_location(locationid):
	var location = ResourceScripts.world_gen.get_location_from_code(locationid)
	var area = ResourceScripts.world_gen.get_area_from_location_code(locationid)
	return_characters_from_location(locationid)
	area.locations.erase(location.id)
	area.questlocations.erase(location.id)
	ResourceScripts.game_progress.completed_locations[location.id] = {name = location.name, id = location.id, area = area.code}
	input_handler.update_slave_list()
	if input_handler.active_location == location && input_handler.CurrentScene.get_node("Exploration").is_visible_in_tree():
		input_handler.CurrentScene.get_node("Exploration").select_location('Aliron')
		input_handler.CurrentScene.get_node("Exploration").build_accessible_locations()

func return_characters_from_location(locationid):
	var location = ResourceScripts.world_gen.get_location_from_code(locationid)
	var area = ResourceScripts.world_gen.get_area_from_location_code(locationid)
	for id in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[id]
		if person.check_location(location.id, true) || person.travel.travel_target.location == location.id:
			if variables.instant_travel == false:
				person.trave.location = 'travel'
				person.trave.travel_target = {area = '', location = 'mansion'}
				person.trave.travel_time = area.travel_time + location.travel_time
			else:
				person.trave.location = 'mansion'
				person.return_to_task()

func make_story_character(args):
	var newchar = ResourceScripts.scriptdict.class_slave.new()
	newchar.generate_predescribed_character(ResourceScripts.world_gen.pregen_characters[args])
	return newchar

func common_effects(effects):
	for i in effects:
		match i.code:
			'money_change':
				ResourceScripts.game_res.update_money(i.operant, i.value)
			'material_change':
				ResourceScripts.game_res.update_materials(i.operant, i.material, i.value)
			'make_story_character':
				var newslave = ResourceScripts.scriptdict.class_slave.new()
				newslave.generate_predescribed_character(worlddata.pregen_characters[i.value])
				#newslave.set_slave_category(newslave.slave_class)
				ResourceScripts.game_party.add_slave(newslave)
			'add_timed_event':
				var newevent = {reqs = [], code = i.value}
				for k in i.args:
					match k.type:
						'add_to_date':
							var newreq = [{type = 'date', operant = 'eq', value = self.date + round(rand_range(k.date[0], k.date[1]))}, {type = 'hour', operant = 'eq', value = k.hour}]
							newevent.reqs += newreq
						'fixed_date':
							var newreq = [{type = 'date', operant = 'eq', value = k.date}, {type = 'hour', operant = 'eq', value = k.hour}]
							newevent.reqs += newreq
				ResourceScripts.game_progress.stored_events.timed_events.append(newevent)
			'remove_timed_events':
				var array = []
				for k in ResourceScripts.game_progress.stored_events.timed_events:
					if k.code in i.value:
						array.append(k)
				for k in array:
					ResourceScripts.game_progress.stored_events.timed_events.erase(k)
			'unique_character_changes':
				var character = ResourceScripts.game_party.get_unique_slave(i.value)
				for k in i.args:
					if k.code == 'sextrait':
						match k.operant:
							'add':
								character.add_sex_trait(k.value)
					elif k.code == 'tag':
						match k.operant:
							'remove':
								if k.value == 'no_sex':
									var text = character.get_short_name() + ": " + "Sex unlocked"
									text_log_add('char', text)
								character.tags.erase(k.value)
					else:
						character_stat_change(character, k)
			'start_event':
				input_handler.interactive_message(i.data, 'start_event', i.args)
			'spend_money_for_scene_character':
				ResourceScripts.game_res.update_money('-', input_handler.scene_characters[i.value].calculate_price())
#				money -= input_handler.scene_characters[i.value].calculate_price()
#				text_log_add('money',"Gold used: " + str(input_handler.scene_characters[i.value].calculate_price()))
			'mod_scene_characters':
				if i.type == 'all':
					for k in input_handler.scene_characters:
						k.add_stat_bonuses(i.value)
			'bool_scene_characters':
				if i.type == 'all':
					for k in input_handler.scene_characters:
						k.set_stat(i.name, i.value)
			'affect_scene_characters':
				if i.type == 'all':
					for k in input_handler.scene_characters:
						k.set_stat(i.name, i.value)
			'change_type_scene_characters':
				if i.type == 'all':
					for k in input_handler.scene_characters:
						k.set_slave_category(i.value)
			'active_character_switch':
				input_handler.active_character = input_handler.scene_characters[i.value]
			'affect_active_character':
				match i.type:
					'damage':
						input_handler.active_character.deal_damage(i.value)
					'stat':
						input_handler.active_character.add_stat(i.name, i.value)
			'make_loot':
				input_handler.scene_loot = ResourceScripts.world_gen.make_chest_loot(input_handler.weightedrandom(i.pool))
			'open_loot':
				input_handler.get_spec_node(input_handler.NODE_LOOTTABLE).open(input_handler.scene_loot, '[center]Acquired Items:[/center]')
			'make_scene_character':
				for k in i.value:
					var newcharacter
					var number = 1
					if k.has("number"):
						number = round(rand_range(k.number[0], k.number[1]))
					while number > 0:
						match k.type:
							'raw':
								newcharacter #= Slave.new()
								newcharacter.is_active = false
								newcharacter.generate_random_character_from_data(k.race, k.class, k.difficulty)
								newcharacter.set_slave_category(k.slave_type)
							'function':
								newcharacter = call(k.function, k.args)
						input_handler.active_character = newcharacter
						input_handler.scene_characters.append(newcharacter)

						number -= 1
			'update_guild':
				input_handler.exploration_node.enter_guild(input_handler.active_faction)
			'create_character':
				input_handler.get_spec_node(input_handler.NODE_CHARCREATE, ['slave', i.type])
			'main_progress':
				ResourceScripts.game_progress.update_progress(i.operant, i.value)
			'progress_quest':
				var quest_exists = false
				for k in ResourceScripts.game_progress.active_quests:
					if k.code == i.value:
						quest_exists = true
						k.stage = i.stage
						text_log_add("quests", "Quest Updated: " + tr(scenedata.quests[k.code].stages[k.stage].name) + ". ")
				if quest_exists == false:
					ResourceScripts.game_progress.active_quests.append({code = i.value, stage = i.stage})
					text_log_add("quests", "Quest Received: " + tr(scenedata.quests[i.value].stages[i.stage].name) + ". ")
			'complete_quest':
				for k in ResourceScripts.game_progress.active_quests:
					if k.code == i.value:
						ResourceScripts.game_progress.active_quests.erase(k)
						text_log_add("quests","Quest Completed: " + tr(scenedata.quests[k.code].stages[k.stage].name) + ". ")
						break
				ResourceScripts.game_progress.completed_quests.append(i.value)
			'complete_active_location':
				input_handler.remove_location(input_handler.active_location.id)
			'complete_event':
				pass
			'reputation':
				var data = ResourceScripts.world_gen.get_faction_from_code(i.name)
				var guild = ResourceScripts.game_world.areas[data.area].factions[data.code]
				guild.reputation = input_handler.math(i.operant, guild.reputation, i.value)
				guild.totalreputation = input_handler.math(i.operant, guild.totalreputation, i.value)
			'decision':
				if !ResourceScripts.game_progress.decisions.has(i.value):
					ResourceScripts.game_progress.decisions.append(i.value)
			'screen_black_transition':
				ResourceScripts.core_animations.BlackScreenTransition(i.value)
			'start_combat':
				input_handler.current_enemy_group = i.value
				input_handler.get_spec_node(input_handler.NODE_COMBATPOSITIONS)
			'start_quest_combat':
				globals.StartQuestCombat(i.value)
			'make_quest_location':
				ResourceScripts.world_gen.make_quest_location(i.value)
			'remove_quest_location':
				input_handler.remove_location(i.value)
			'set_music':
				input_handler.SetMusic(i.value)
			'lose_game':
				input_handler.PlaySound('transition_sound')
				globals.return_to_main_menu()

func checkreqs(array):
	var check = true
	for i in array:
		if i.has('orflag'):
			check = check or valuecheck(i)
		else:
			check = check and valuecheck(i)
	return check

func valuecheck(dict):
	if !dict.has('type'): return true
	match dict['type']:
		"no_check":
			return true
		"has_money":
			return ResourceScripts.game_res.if_has_money(dict['value'])
#		"has_property":
#			return if_has_property(dict['prop'], dict['value'])
		"has_hero":
			return ResourceScripts.game_party.if_has_hero(dict['name'])
		"has_material":
			return ResourceScripts.game_res.if_has_material(dict['material'], dict.operant, dict['value'])
		"date":
			if variables.no_event_wait_time: return true
			return input_handler.operate(dict.operant, ResourceScripts.game_globals.date, dict.value)
		'hour':
			if variables.no_event_wait_time: return true
			return input_handler.operate(dict.operant, ResourceScripts.game_globals.hour, dict.value)
		"gamestart":
			return ResourceScripts.game_globals.newgame
		"has_upgrade":
			return ResourceScripts.game_res.if_has_upgrade(dict.name, dict.value)
		"main_progress":
			return ResourceScripts.game_progress.if_has_progress(dict.value, dict.operant)
		"area_progress":
			return ResourceScripts.game_progress.if_has_area_progress(dict.value, dict.operant, dict.area)
		"decision":
			return ResourceScripts.game_progress.decisions.has(dict.name) == dict.value
		"has_multiple_decisions": 
			var counter = 0
			for i in dict.decisions:
				if ResourceScripts.game_progress.decisions.has(i):
					counter += 1
			return input_handler.operate(dict.operant, counter, dict.value)
		"quest_stage":
			return ResourceScripts.game_progress.if_quest_stage(dict.name, dict.value, dict.operant)
		"quest_completed":
			return ResourceScripts.game_progress.completed_quests.has(dict.name)
		"party_level":
			return ResourceScripts.game_party.if_party_level(dict.operant, dict.value)
		"hero_level":
			if ResourceScripts.game_party.if_has_hero(dict.name) == false:
				return false
			else:
				return ResourceScripts.game_party.if_hero_level(dict.name, dict.operant, dict.value)
		"has_items":
			return ResourceScripts.game_res.if_has_items(dict.name, dict.operant, dict.value)
		"has_free_items":
			return ResourceScripts.game_res.if_has_free_items(dict.name, dict.operant, dict.value)
		'disabled':
			return false
		'master_check':
			var master_char = ResourceScripts.game_party.get_master()
			if master_char == null:
				return false
			else:
				return master_char.checkreqs(dict.value)
		'active_character_checks':
			var character = input_handler.active_character
			if character == null:return false
			return character.checkreqs(dict.value)
		'master_is_beast':
			return ResourceScripts.game_party.if_master_is_beast(dict.value)
		'unique_character_at_mansion':
			var character = ResourceScripts.game_party.get_unique_slave(dict.value)
			if character == null:return false
			return character.checkreqs([{code = 'is_free', check = true}])
		'has_money_for_scene_slave':
			return ResourceScripts.game_res.money >= input_handler.scene_characters[dict.value].calculate_price()
		'random':
			return globals.rng.randf()*100 <= dict.value
		'dialogue_seen':
			return input_handler.operate(dict.operant, ResourceScripts.game_progress.seen_dialogues.has(dict.value), true)
		'dialogue_selected':
			return input_handler.operate(dict.operant, ResourceScripts.game_progress.selected_dialogues.has(dict.value), true)
		'active_quest_stage':
			if ResourceScripts.game_progress.get_active_quest(dict.value) == null || dict.has('stage') == false:
				if dict.has('state') && dict.state == false:
					return true
				else:
					return false
			if dict.has('state') && dict.state == false:
				return ResourceScripts.game_progress.get_active_quest(dict.value).stage != dict.stage
			else:
				return ResourceScripts.game_progress.get_active_quest(dict.value).stage == dict.stage
		'faction_reputation':
			var data = ResourceScripts.world_gen.get_faction_from_code(dict.code)
			var guild = ResourceScripts.game_world.areas[data.area].factions[data.code]
			return input_handler.operate(dict.operant, guild.totalreputation, dict.value)
		'group_size':#not sure about this implementation instead of area - party approach
			var counter = 0
			for i in ResourceScripts.game_party.characters.values():
				if i.location == input_handler.active_location.id:
					counter += 1
			return input_handler.operate(dict.operant, counter, dict.value)
		'location_has_specific_slaves': 
			var counter = 0
			for i in ResourceScripts.game_party.characters.values():
				if i.check_location(dict.location) && i.checkreqs(dict.reqs) == true && !i.has_profession('master'):
					counter += 1
			return counter >= dict.value
