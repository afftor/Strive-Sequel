extends Node

const gameversion = '0.6.6b'

#time
signal hour_tick
signal task_added
signal slave_added
signal slave_arrived
signal slave_departed
signal update_clock

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

#var current_level
#var current_stage
var current_enemy_group

var scenes = {}

var sex_actions_dict = {}

#warning-ignore:unused_signal
signal scene_changed
signal scene_change_start


func _init():
	if dir.dir_exists(variables.userfolder + 'saves') == false:
		dir.make_dir(variables.userfolder + 'saves')

	if !dir.dir_exists(variables.userfolder + 'savedcharacters'):
		dir.make_dir(variables.userfolder + 'savedcharacters')

	for i in input_handler.dir_contents('res://src/actions'):
		if i.ends_with('.gd'):
			var newaction = load(i).new()
			sex_actions_dict[newaction.code] = newaction
	
	#quit if extending
	if variables.get('globals_extend'):
		variables.set('globals_extend', false)
		return
	#for logging purposes
	print("Game Version: " + str(gameversion))
	print("OS: " +  OS.get_name())
	
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
	ResourceScripts.load_scripts()
	ResourceScripts.recreate_singletons()
	ResourceScripts.revert_gamestate()
	modding_core.load_mods()
	modding_core.process_data_mods()
	modding_core.process_translation_mods()
	races.fill_racegroups()
	modding_core.fix_main_data()

	reset_roll_data()


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

func get_duplicate_id_if_exist(item, parts):
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
		var duplicate = get_duplicate_id_if_exist(item.itembase, item.parts)
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


func disconnect_text_tooltip(node):
	if node.is_connected("mouse_entered",self,'showtexttooltip'):
		node.disconnect("mouse_entered",self,'showtexttooltip')

func connecttexttooltip(node, text, move_right = false):
	if node.is_connected("mouse_entered",self,'showtexttooltip'):
		node.disconnect("mouse_entered",self,'showtexttooltip')
	node.connect("mouse_entered",self,'showtexttooltip', [node, text, move_right])

func showtexttooltip(node, text, move_right):
	var texttooltip = input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP) #input_handler.GetTextTooltip()
	texttooltip.showup(node, text, move_right)

func connectitemtooltip(node, item):
	if node.is_connected("mouse_entered",item,'tooltip'):
		node.disconnect("mouse_entered",item,'tooltip')
	node.connect("mouse_entered",item,'tooltip', [node])


func connectitemtooltip_v2(node, item):
	for dir in node.get_signal_connection_list("mouse_entered"):
		node.disconnect(dir.signal, dir.target, dir.method)
#	if node.is_connected("mouse_entered",item,'tooltip_v2'):
#		node.disconnect("mouse_entered",item,'tooltip_v2')
	node.connect("mouse_entered",item,'tooltip_v2', [node])


func disconnect_temp_item_tooltip(node):
	if node.is_connected("mouse_entered",self,'tempitemtooltip'):
		node.disconnect("mouse_entered",self,'tempitemtooltip')

func connecttempitemtooltip(node, item, mode):
	if node.is_connected("mouse_entered",self,'tempitemtooltip'):
		node.disconnect("mouse_entered",self,'tempitemtooltip')
	node.connect("mouse_entered",self,'tempitemtooltip', [node, item, mode])
#	node.connect("mouse_entered",item,'tooltip_v2', [node])

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

func connectmaterialtooltip(node, material, bonustext = '', type = null):
	if node.is_connected("mouse_entered",self,'mattooltip'):
		node.disconnect("mouse_entered",self,'mattooltip')
	if type == null:
		node.connect("mouse_entered",self,'mattooltip', [node, material, bonustext])
	else:
		node.connect("mouse_entered",self,'mattooltip', [node, material, bonustext, type])

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
	data.type = material.type
	if ResourceScripts.game_res.materials[material.code] > 0:
		data.amount = ResourceScripts.game_res.materials[material.code]
	else:
		type = 'material'
	
	node.showup(targetnode, data, type)

#func mattooltip(targetnode, material, bonustext = '', type = 'materialowned'):
#	var image
#	var node = input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP) #input_handler.GetItemTooltip()
#	var data = {}
#	var text = '[center]' + material.name + '[/center]\n' + material.descript
#	data.text = text + bonustext
#	data.item = material
#	data.icon = material.icon
#	data.price = str(material.price)
#	data.type = material.type
#	if ResourceScripts.game_res.materials[material.code] > 0:
#		data.amount = ResourceScripts.game_res.materials[material.code]
#
#	node.showup(targetnode, data, type)



func build_traitlist_for_char(person, node):
	input_handler.ClearContainer(node, ['Button', 'Button2'])
	for b in person.get_all_buffs():
		if !b.template.has('show_in_traits'): continue
		if !b.template.show_in_traits: continue
		var button = input_handler.DuplicateContainerTemplate(node, 'Button2')
		button.texture = b.icon
		button.get_node("Label").hide()
		var text = person.translate(b.description)
		connecttexttooltip(button, text)
	for tr in person.get_traits_by_arg('visible', true):
		var trdata = Traitdata.traits[tr]
		if !trdata.has('tags'): continue
		if !trdata.tags.has('simple_icon'): continue
		var button = input_handler.DuplicateContainerTemplate(node, 'Button2')
		button.texture = trdata.icon
		button.get_node("Label").hide()
		var text = "[center]{color=yellow|" + tr(trdata.name) + '}[/center]\n' + person.translate(trdata.descript)
		connecttexttooltip(button, text)
	for tr in person.get_traits_by_arg('visible', true):
		var trdata = Traitdata.traits[tr]
		if trdata.has('tags') and trdata.tags.has('simple_icon'): continue
		var button = input_handler.DuplicateContainerTemplate(node, 'Button')
		var text = "[center]{color=yellow|" + tr(trdata.name) + '}[/center]\n' + person.translate(trdata.descript)
		connecttexttooltip(button, text)
		if trdata.has('icon') and trdata.icon != null:
			if trdata.icon is String:
				button.get_node('icon').texture = load(trdata.icon)
			else:
				button.get_node('icon').texture = trdata.icon
		if trdata.has('cross') and trdata.cross:
			button.get_node('cross').visible = true
		else:
			button.get_node('cross').visible = false
			if trdata.tags.has('positive'):
				button.texture_normal = load("res://assets/images/iconstraits/green.png")
			if trdata.tags.has('negative'):
				button.texture_normal = load("res://assets/images/iconstraits/red.png")


func build_loyalty_traitlist(person, node):
	input_handler.ClearContainer(node, ['Button'])
	for tr in person.get_traits_by_tag('loyalty'):
		var upgrade_data = Traitdata.traits[tr]
		var button = input_handler.DuplicateContainerTemplate(node, 'Button')
		var text = '[center]'+tr(upgrade_data.name)+'[/center]\n'
		text += build_desc_for_bonusstats(upgrade_data.bonusstats)
		text += tr(upgrade_data.descript)
		globals.connecttexttooltip(button, text)
#		button.self_modulate = Color(variables.hexcolordict.green)
		if upgrade_data.icon is String:
			button.get_node('icon').texture = load(upgrade_data.icon)
		else:
			button.get_node('icon').texture = upgrade_data.icon


func build_buffs_for_char(person, node, mode):
	input_handler.ClearContainer(node, ['Button'])
	var list
	match mode:
		'mansion': list = person.get_mansion_buffs()
		'combat': list = person.get_combat_buffs()
		'all': list = person.get_all_buffs()
	for i in list:
		if i.template.has('show_in_traits') and i.template.show_in_traits: continue
		var newnode = input_handler.DuplicateContainerTemplate(node, 'Button')
		newnode.texture = i.icon
		var tmp = i.get_duration()
		if tmp != null:
			newnode.get_node("Label").text = str(tmp.count)
		else:
			newnode.get_node("Label").hide()
#		match tmp.event:
#			'hours':
#				newnode.get_node("Label").set("custom_colors/font_color",Color(0,0,1))
#			'turns':
#				newnode.get_node("Label").set("custom_colors/font_color",Color(0,1,0))
#			'hits':
#				newnode.get_node("Label").set("custom_colors/font_color",Color(1,0,0))
#			'attacks':
#				newnode.get_node("Label").set("custom_colors/font_color",Color(1,0,0))
		globals.connecttexttooltip(newnode, person.translate(i.description))


func build_attrs_for_char(node, person):
	node.get_node('Portrait').texture = person.get_icon()
	node.get_node('sex').texture = images.icons[person.get_stat('sex')]
	node.get_node('race').texture = races.racelist[person.get_stat('race')].icon
	node.get_node('age').texture = images.ages[person.get_stat('age')]
	globals.connecttexttooltip(node.get_node('sex'), "Sex: " + person.get_stat('sex').capitalize())
	globals.connecttexttooltip(node.get_node('age'), "Age: " + tr("SLAVEAGE" + person.get_stat("age").to_upper()))
	globals.connecttexttooltip(node.get_node('race'), "[center]{color=green|"+ races.racelist[person.get_stat('race')].name +"}[/center]\n\n"+ person.show_race_description())


func build_desc_for_bonusstats(bonusstats):
	var text = ""
	for i in bonusstats:
		if bonusstats[i] != 0:
			var value = bonusstats[i]
			var data = statdata.statdata[i]
			if data.hidden: continue
			var change = ''
			text += data.name + ': {color='
			match data.default_bonus:
				"add":
					if data.percent:
						value = value*100
					if value > 0:
						change = '+'
					if value > 0 and !data.is_negative or value < 0 and data.is_negative:
						text += 'green|' + change
					else:
						text += 'red|' + change
					value = str(value)
					if data.percent:
						value = value + '%'
				"add_part":
					value = value*100
					if value > 0:
						change = '+'
					if value > 0 and !data.is_negative or value < 0 and data.is_negative:
						text += 'green|' + change
					else:
						text += 'red|' + change
					value = str(value)
					value = value + '%'
				"mul":
					value = value - 1.0
					value = value*100
					if value > 0:
						change = '+'
					if value > 0 and !data.is_negative or value < 0 and data.is_negative:
						text += 'green|' + change
					else:
						text += 'red|' + change
					value = str(value)
					value = value + '%'
			text += value + '}\n'
	return text

func TextEncoder(text, node = null):
	var tooltiparray = []
	var counter = 0
	while text.find("{^") >= 0:
		var temptext = text.substr(text.find("{^"), text.find("}")+1 - text.find("{^"))
		text = text.replace(temptext, temptext.split(":")[randi()%temptext.split(":").size()].replace("{^", "").replace("}",""))
	#return text

	while text.find("{") != -1:
		if text.find("}") == -1:
			print ("error in formatted text - } not found in string:")
			print (text.substr(0, 20) + "...")
			text = text + "}"
		var newtext = text.substr(text.find("{"), text.find("}") - text.find("{")+1)
		var newtextarray = newtext.split("|")
		var originaltext = newtextarray[newtextarray.size()-1].replace("}",'')
		newtextarray.remove(newtextarray.size()-1)
		var startcode = ''
		var endcode = ''
		for data1 in newtextarray:
			data1 = data1.replace('{','')
			var data = data1.split("=")
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
					if input_handler.evaluate(data1.trim_prefix('check=')) == false:
						originaltext = ''
				'random_chat':
					var character = input_handler.scene_characters[int(data[1])]
					originaltext = character.translate(input_handler.get_random_chat_line(character, originaltext))
				'random_chat_active':
					var character = input_handler.active_character
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
	elif type == 'sex_use':
		for i in ResourceScripts.game_res.items.values():
			if i.interaction_use == true:
				array.append(i)
	elif type == 'date_use':
		for i in ResourceScripts.game_res.items.values():
			if i.type == 'gear':
				continue
			if Items.itemlist[i.code].tags.has('date'):
				array.append(i)
	elif type == 'material':
		for i in ResourceScripts.game_res.materials:
			if ResourceScripts.game_res.materials[i] > 0:
				array.append(i)

	for i in array:
		var newnode = input_handler.DuplicateContainerTemplate(node.get_node("ScrollContainer/GridContainer"))
		match type:
			'gear':
				i.set_icon(newnode.get_node("icon"))
				newnode.get_node("Percent").show()
				newnode.get_node("Percent").text = str(input_handler.calculatepercent(i.durability, i.maxdurability)) + '%'
				connectitemtooltip(newnode, i)
			'sex_use', 'date_use':
				i.set_icon(newnode.get_node("icon"))
				newnode.get_node("Percent").show()
				newnode.get_node('name').text = i.name
				newnode.get_node("Percent").text = str(i.amount)
				connectitemtooltip(newnode, i)
			'material':
				newnode.get_node("icon").texture = Items.materiallist[i].icon
				newnode.get_node("Percent").show()
				newnode.get_node('name').text = Items.materiallist[i].name
				newnode.get_node("Percent").text = str(ResourceScripts.game_res.materials[i])
				connectmaterialtooltip(newnode, Items.materiallist[i])
		newnode.connect('pressed', targetscript, function, [i])
		newnode.connect('pressed',input_handler,'CloseSelection', [node])

func QuickSave():
	SaveGame('QuickSave')

func autosave(overwrite = false):
	if input_handler.globalsettings.autosave_number <= 0:
		return
	if !overwrite:
		var savedir = Directory.new()
		var path = variables.userfolder + 'saves'
		if !savedir.dir_exists(path):
			savedir.make_dir(path)
		if savedir.open(path) != OK:
			print('ERROR opening savedir')
			return
		#delete existing last save
		if savedir.file_exists('autosave_%d.sav' % input_handler.globalsettings.autosave_number):
			savedir.remove('autosave_%d.sav' % input_handler.globalsettings.autosave_number)
		if savedir.file_exists('autosave_%d.dat' % input_handler.globalsettings.autosave_number):
			savedir.remove('autosave_%d.dat' % input_handler.globalsettings.autosave_number)
		#move all other saves 1 point up
		for i in range(input_handler.globalsettings.autosave_number -1, 0, -1):
			if savedir.file_exists('autosave_%d.sav' % i):
				savedir.rename('autosave_%d.sav' % i, 'autosave_%d.sav' % (i + 1))
			if savedir.file_exists('autosave_%d.dat' % i):
				savedir.rename('autosave_%d.dat' % i, 'autosave_%d.dat' % (i + 1))
	SaveGame('autosave_1')

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

	for faction in savedict.game_world.areas.plains.factions:
		var current_faction = savedict.game_world.areas.plains.factions[faction]
		if !current_faction.has("bonus_actions"):
			savedict.game_world.areas.plains.factions[faction]["bonus_actions"] = worlddata.factiondata[faction].bonus_actions

#	state.deserialize(savedict)
	characters_pool.deserialize(savedict.charpool)
	for p in ResourceScripts.gamestate:
		ResourceScripts.set(p, dict2inst(savedict[p]))
	input_handler.connect("EnemyKilled", ResourceScripts.game_world, "quest_kill_receiver")
	ResourceScripts.game_globals.fix_serialization()
	ResourceScripts.game_res.fix_serialization()
#	ResourceScripts.game_res.fix_items_inventory(false)
	ResourceScripts.game_party.fix_serialization()
	ResourceScripts.game_world.fix_serialization()
	ResourceScripts.game_progress.fix_serialization()
	effects_pool.deserialize(savedict.effpool)
	characters_pool.cleanup()
	effects_pool.cleanup()
	ResourceScripts.game_party.fix_serialization_postload()

	if !compare_version(ResourceScripts.game_globals.original_version, '0.5.5b'):
		ResourceScripts.game_globals.hour = ResourceScripts.game_globals.hour / 6
		print(ResourceScripts.game_globals.original_version)
		print("Warning - unsafe loading")
	
	if is_instance_valid(gui_controller.mansion):
		gui_controller.mansion.queue_free()
	if is_instance_valid(gui_controller.current_screen):
		gui_controller.current_screen.queue_free()
	input_handler.ChangeScene('mansion');
	yield(self, "scene_changed")
	if is_instance_valid(gui_controller.clock):
		gui_controller.clock.update_labels()
		gui_controller.clock.set_sky_pos()
	input_handler.SystemMessage("Game Loaded")


func compare_version(v1:String, v2:String):
	var vp1 = v1.split('.')
	var vp2 = v2.split('.')
	for i in range(vp1.size()):
		if i >= vp2.size(): 
			return true
		if vp1[i].naturalnocasecmp_to(vp2[i]) != 0: 
			return vp1[i].naturalnocasecmp_to(vp2[i]) > 0
	return true


func ImportGame(filename):
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

	input_handler.connect("EnemyKilled", ResourceScripts.game_world, "quest_kill_receiver")
	ResourceScripts.game_res = dict2inst(savedict.game_res)
	ResourceScripts.game_res.fix_serialization()
	ResourceScripts.game_world.make_world()
	ResourceScripts.game_world.fix_import(savedict.game_world)
	ResourceScripts.game_party = dict2inst(savedict.game_party)
	ResourceScripts.game_party.fix_serialization()
	ResourceScripts.game_party.fix_import()
	ResourceScripts.game_globals = dict2inst(savedict.game_globals)
	ResourceScripts.game_globals.fix_import()
	#temporally removed
#	ResourceScripts.game_progress = dict2inst(savedict.game_progress)
#	ResourceScripts.game_progress.fix_import()
#	characters_pool.get_babies_from_data(savedict.charpool)
	effects_pool.deserialize(savedict.effpool)
	characters_pool.cleanup()
	effects_pool.cleanup()
	if !compare_version(savedict.game_globals.original_version, '0.5.5b'):
		effects_pool.fix_durations()
	
	ResourceScripts.game_party.fix_serialization_postload()

	if is_instance_valid(gui_controller.mansion):
		gui_controller.mansion.queue_free()
	if is_instance_valid(gui_controller.current_screen):
		gui_controller.current_screen.queue_free()
	input_handler.ChangeScene('mansion');
	yield(self, "scene_changed")
	if is_instance_valid(gui_controller.clock):
		gui_controller.clock.update_labels()
		gui_controller.clock.set_sky_pos()
	input_handler.SystemMessage("Game Imported")
	globals.common_effects([
			{code = 'add_timed_event', value = "loan_event1",
				args = [
					{type = 'fixed_date',
					date = 14,
					hour = 1}
					]
			},
			{code = 'progress_quest', value = 'main_quest_loan', stage = 'stage0'},
			{code = 'progress_quest', value = 'guilds_introduction', stage = 'start'},
			{code = 'add_timed_event', value = "ginny_visit", args = [{type = 'add_to_date', date = [5,10], hour = 1}]}
			])




func get_last_save():
	var dir = input_handler.dir_contents(variables.userfolder + 'saves')
	var dated_dir = {}
	var tmp = File.new()
	for i in dir:
		if i.ends_with('.sav') == false:
			continue
		dated_dir[i] = tmp.get_modified_time(i)
	if dated_dir.size() == 0: return null
	var b = dated_dir.keys()[0]
	for i in dated_dir.keys():
		if dated_dir[i] > dated_dir[b]:
			b = i
	return b

func datetime_comp(a, b):
	if a.year != b.year: return (a.year > b.year)
	if a.month != b.month: return (a.month > b.month)
	if a.day != b.day: return (a.day > b.day)
	if a.hour != b.hour: return (a.hour > b.hour)
	if a.minute != b.minute: return (a.minute > b.minute)
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
	gui_controller.current_screen = null
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
	if rel[person2.id] > 500 && value > 0 && ResourceScripts.game_party.checkifrelatives(person.id, person2.id):
		value = value/1.5
	elif rel[person2.id] < -500 && value < 0 && ResourceScripts.game_party.checkifrelatives(person.id, person2.id):
		value = value/1.5
	rel[person2.id] += value
	rel[person2.id] = clamp(rel[person2.id], -1000, 1000)
	rel2[person.id] = rel[person2.id]
	#for no stress attribute
#	if person.relations[person2.id] < -200 && value < 0:
#		person.stress += rand_range(4,8)
#		person2.stress += rand_range(4,8)


func getrelativename(person, person2):
	var result = null
	var data1
	var data2
	if ResourceScripts.game_party.relativesdata.has(person.id):
		data1 = ResourceScripts.game_party.relativesdata[person.id]
	else:
		ResourceScripts.game_party.createrelativesdata(person)
		data1 = ResourceScripts.game_party.relativesdata[person.id]
	if ResourceScripts.game_party.relativesdata.has(person2.id):
		data2 = ResourceScripts.game_party.relativesdata[person2.id]
	else:
		ResourceScripts.game_party.createrelativesdata(person2)
		data2 = ResourceScripts.game_party.relativesdata[person2.id]
	
	#print(data1, data2)
	for i in ['mother','father']:
		if str(data1[i]) == str(data2.id):
			result = '[father]'
		elif str(data2[i]) == str(data1.id):
			result = '[son]'
	for i in [data1, data2]:
		if i.siblings.has(data1.id) || i.siblings.has(data2.id):
			result = '[brother]'
	if result != null:
		result = person2.translate(result)
	return result


func impregnate_check(father,mother):
	var result = {value = true, preg_disabled = false, no_womb = false, male_contraceptive = false, female_contraceptive = false, mother_breeder = false, father_breeder = false, compatible = true, already_preg_visible = false, father_undead = false, mother_undead = false}

	if variables.pregenabled == false:
		result.value = false
		result.text = 'pregnancy_disabled'
		result.preg_disabled = true

	elif mother.get_stat('has_womb') == false:
		result.value = false
		result.no_womb = true

	elif mother.check_work_rule('contraceptive'):
		result.female_contraceptive = true
		result.value = false
	
	
	elif father.check_work_rule('contraceptive') == true:
		result.male_contraceptive = true
		result.value = false
	
	if father.check_trait('undead'):
		result.father_undead = true
	if mother.check_trait('undead'):
		result.mother_undead = true
	
	if father.get_stat('race') != mother.get_stat('race'):
		for i in [father, mother]:
			var race = i.get_stat('race')
			if race.find("Beastkin") >= 0:
				race = 'Beastkin'
			elif race.find('Halfkin') >= 0:
				race = "Halfkin"

			if variables.impregnation_compatibility.has(race) == false && input_handler.globalsettings.no_breed_incompatibility == false:
#				if mother.has_profession('breeder') == false:
#					result.value = false
#					result.compatible = false
#				else:
#					result.value = true
#					result.breeder = true
				if mother.has_status('breeder'):
					result.value = true
					result.mother_breeder = true
				elif father.has_status('breeder'):
					result.value = true
					result.father_breeder = true
				else:
					result.value = false
					result.compatible = false
	
	if mother.get_stat('pregnancy').duration != 0:
		result.value = false
		if variables.pregduration/1.5 > mother.get_stat('pregnancy').duration:
			result.already_preg_visible = true
	
	if result.no_womb || result.preg_disabled || result.male_contraceptive || result.female_contraceptive || result.father_undead || result.mother_undead:
		result.value = false
	
	return result

func impregnate(father, mother):
	if impregnate_check(father,mother).value == false:
		return
	mother.add_stat('metrics_pregnancy',  1)
	father.add_stat("metrics_impregnation", 1)
	var baby = ResourceScripts.scriptdict.class_slave.new("baby")
	baby.setup_baby(mother, father)

func calculate_travel_time(location1, location2):
	var travel_value1 = 0 #time to travel to location from mansion
	var travel_value2 = 0 #time to return to mansion from location
	if location1 != ResourceScripts.game_world.mansion_location:
		travel_value1 = ResourceScripts.world_gen.get_area_from_location_code(location1).travel_time + ResourceScripts.world_gen.get_location_from_code(location1).travel_time
	if location2 != ResourceScripts.game_world.mansion_location:
		travel_value2 = ResourceScripts.world_gen.get_area_from_location_code(location2).travel_time + ResourceScripts.world_gen.get_location_from_code(location2).travel_time
	var time = travel_value1 + travel_value2
	time = max(1, time - variables.stable_boost_per_level * ResourceScripts.game_res.upgrades.stables)
	return {time = time, obed_cost = travel_value1*1.5}

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
		var sum_cost = {}
		for i in temprecipe.partdict:
			if sum_cost.has(temprecipe.partdict[i]):
				 sum_cost[temprecipe.partdict[i]] += item.parts[i]
			else:
				sum_cost[temprecipe.partdict[i]] = item.parts[i]
		for i in sum_cost:
			if ResourceScripts.game_res.materials[i] < sum_cost[i]:
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


func text_log_add(label, text):
	var date = ResourceScripts.game_globals.date
	var hour = ResourceScripts.game_globals.hour
	if label == 'travel': 
		hour += 1
		if hour > 4:
			hour = 1
			date += 1
	log_storage.append({type = label, text = text, time = "%d : %d" % [date, hour]})
	if log_node != null && weakref(log_node).get_ref():
		var newfield = log_node.get_node("ScrollContainer/VBoxContainer/field").duplicate()
		newfield.show()
		newfield.get_node("label").bbcode_text = label
		newfield.get_node("text").bbcode_text = text
		newfield.get_node("date").bbcode_text = "[right]W %d D %d - %s[/right]" % [(date -1) / 7 + 1, (date -1) % 7 + 1, tr(variables.timeword[hour])]
		log_node.get_node("ScrollContainer/VBoxContainer").add_child(newfield)
		yield(get_tree(), 'idle_frame')
		var textfield = newfield.get_node('text')
		textfield.rect_size.y = textfield.get_v_scroll().get_max()
		newfield.rect_min_size.y = textfield.rect_size.y

func character_stat_change(character, data):
	var text = character.get_short_name() + ": "
	if statdata.statdata.has(data.code):
		text += statdata.statdata[data.code].name
	if data.operant == '+':
		text += " + "
		character.add_stat(data.code, data.value)
	elif data.operant == '=':
		character.set_stat(data.code, data.value)
	else:
		text += " - "
		character.add_stat(data.code, -data.value)

	text += str(data.value)
	text_log_add('char', text)
#	character.set(data.code, input_handler.math(data.operant, character.get(data.code), data.value))

func make_local_recruit(args):
	var newchar = ResourceScripts.scriptdict.class_slave.new("local_recruit")
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
				input_handler.interactive_message(i.args)
			elif i.has('args'):
				input_handler.call(i.event, i.args)
			else:
				input_handler.call(i.event)
			if i.has('oneshot') && i.oneshot == true:
				erasearray.append(i)
	for i in erasearray:
		eventarray.erase(i)
	return eventtriggered


func start_unique_event():
	var eventtriggered = false
	var location = input_handler.active_location
	var active_array = []
	for i in worlddata.random_dungeon_events:
		var event = worlddata.random_dungeon_events[i]
		if ResourceScripts.game_progress.seen_events.has(event.event): 
			continue
		if !event.dungeons.has(str(location.code)): 
			continue
		if event.has('levels') and !event.levels.has(int(location.progress.level)): 
			continue
		if event.has('stages') and !event.stages.has(int(location.progress.stage)): 
			continue
		if event.has('reqs') and !globals.checkreqs(event.reqs): 
			continue
		active_array.append(event.event)
	if active_array.size() > 0:
		var selected_event = input_handler.random_from_array(active_array)
		var eventtype = "event_selection"
		var dict = {}
		if scenedata.scenedict[selected_event].has("default_event_type"):
			eventtype = scenedata.scenedict[selected_event].default_event_type
		if scenedata.scenedict[selected_event].has('bonus_args'):
			dict = scenedata.scenedict[selected_event].bonus_args
		input_handler.interactive_message(selected_event, eventtype, dict)
		eventtriggered = true
	return eventtriggered


func start_random_event():
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
	var progress = input_handler.active_location.progress
	var check = true
	for i in reqs:
		match i.code:
			'level':
				check = input_handler.operate(i.operant, progress.level, i.value)
			'stage':
				check = input_handler.operate(i.operant, progress.stage, i.value)
			'dungeon_complete':
				check = i.value == input_handler.exploration_node.check_dungeon_end()
			'value_check':
				check = valuecheck(i)
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
	if input_handler.combat_node == null:
		input_handler.combat_node = input_handler.get_combat_node()
	var data
	if encounter != null:
		data = Enemydata.encounters[encounter]
#		if data.has('no_rnd_captured') and data.no_rnd_captured:
#			char_roll_data.no_roll = true
		input_handler.encounter_win_script = Enemydata.encounters[encounter].win_effects
		input_handler.encounter_lose_script = Enemydata.encounters[encounter].lose_effects
	else:
		input_handler.encounter_win_script = null
		input_handler.encounter_lose_script = null
	
	if ResourceScripts.game_progress.skip_combat == true:
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
	
	input_handler.combat_node.encountercode = data.unitcode
	input_handler.combat_node.set_norun_mode(true)
	input_handler.combat_node.start_combat(input_handler.active_location.group, enemies, data.bg, data.bgm, enemy_stats_mod)

func StartQuestCombat(encounter):
	pass

func StartAreaCombat():
	var enemydata
	var enemygroup = {}
	var enemies = []
	var music = 'combattheme'
	
	var progress = input_handler.active_location.progress
	
	for i in input_handler.active_location.stagedenemies:
		if i.stage == progress.stage && i.level == progress.level:
			enemydata = i.enemy#[i.enemy,1]
	if enemydata == null:
		enemydata = input_handler.active_location.enemies

	enemies = make_enemies(enemydata)

	var enemy_stats_mod = (1 - variables.difficulty_per_level) + variables.difficulty_per_level * progress.level
	
	if input_handler.combat_node == null:
		input_handler.combat_node = input_handler.get_combat_node()
	input_handler.combat_node.encountercode = enemydata
	input_handler.combat_node.set_norun_mode(false)
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
				for j in combatparty:
					if combatparty[j] != null:
						continue
					var aiposition = unit.ai_position[randi()%unit.ai_position.size()]
					if aiposition == 'melee' && j in [1,2,3]:
						temparray.append(j)
					if aiposition == 'ranged' && j in [4,5,6]:
						temparray.append(j)
					if aiposition == 'any':
						temparray.append(j)

				if temparray.size() <= 0:
					for j in combatparty:
						if combatparty[j] == null:
							temparray.append(j)
			else:
				#stupid way
				for j in combatparty:
					if combatparty[j] != null:
						temparray.append(j)

			if temparray.size() > 0:
				combatparty[temparray[randi()%temparray.size()]] = i.units
			i.number -= 1
	
	#handle rares
	var champarr = []
	for pos in combatparty:
		if combatparty[pos] == null: continue
		if rng.randf() < variables.enemy_rarechance:
			champarr.push_back(pos)
			char_roll_data.mboss = true
	while champarr.size() > 3:
		champarr.remove(rng.randi_range(0, champarr.size()-1))
	for pos in champarr:
		combatparty[pos] += "_rare"
	return combatparty

func complete_location(locationid):
	var location = ResourceScripts.world_gen.get_location_from_code(locationid)
	if location == null: return
	var area = ResourceScripts.world_gen.get_area_from_location_code(locationid)
	return_characters_from_location(locationid)
	ResourceScripts.game_progress.completed_locations[location.id] = {name = location.name, id = location.id, area = area.code}


func remove_location(locationid):
	var location = ResourceScripts.world_gen.get_location_from_code(locationid)
	if location == null: return
	if location.type == 'capital':
		print('WARNING - incorrect location removal')
		return
	var area = ResourceScripts.world_gen.get_area_from_location_code(locationid)
	ResourceScripts.game_party.clean_tasks(location.id)
	return_characters_from_location(locationid)
	if location.has('captured_characters'):
		for id in location.captured_characters:
			var tchar = characters_pool.get_char_by_id(id)
			var val = tchar.calculate_price() / 2
			ResourceScripts.game_res.money += int(val)
			tchar.is_active = false
	area.locations.erase(location.id)
	area.questlocations.erase(location.id)
	ResourceScripts.game_world.location_links.erase(location.id)
	
	
	input_handler.update_slave_list()
	gui_controller.nav_panel.build_accessible_locations()
	if gui_controller.current_screen == gui_controller.mansion:
		gui_controller.mansion.mansion_state_set("default")
		return
	if input_handler.active_location == location and gui_controller.exploration != null and gui_controller.exploration.is_visible_in_tree():
		gui_controller.nav_panel.select_location('aliron')


func unquest_location(locationid):
	var location = ResourceScripts.world_gen.get_location_from_code(locationid)
	if location == null: return
	var area = ResourceScripts.world_gen.get_area_from_location_code(locationid)
	var ldata = ResourceScripts.game_world.location_links[locationid]
	if ldata.category != "questlocations":
		print ("warning - location %s is not quest" % locationid)
		return
	if !location.has("questid"):
		print ("error - quest location %s has no associated quest" % locationid)
		return
	if ResourceScripts.game_progress.if_quest_active(location.questid):
		print ("error - quest for location %s is active" % locationid)
		return
	ldata.category = "locations"
	area.questlocations.erase(locationid)
	area.locations[locationid] = location


func return_characters_from_location(locationid):
	var location = ResourceScripts.world_gen.get_location_from_code(locationid)
	if location == null:
		#possibly not that simple
		return
	var area = ResourceScripts.world_gen.get_area_from_location_code(locationid)
	for id in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[id]
		if person.check_location(location.id, true) || person.travel.travel_target.location == location.id:
			if ResourceScripts.game_progress.instant_travel:
				person.travel.location = ResourceScripts.game_world.mansion_location
				person.return_to_task()
			else:
				person.return_to_mansion()


var char_roll_data = {}
func reset_roll_data():
	char_roll_data.no_roll = false
	char_roll_data.max_amount = 4
	char_roll_data.lvl = 0
	char_roll_data.mboss = false
	char_roll_data.uniq = false
	char_roll_data.event = false
	char_roll_data.trait_bonus = false
	char_roll_data.area = 'plains'
	match ResourceScripts.game_globals.difficulty:
		'easy':
			char_roll_data.diff = 2
		'medium':
			char_roll_data.diff = 4
		'hard':
			char_roll_data.diff = 6


func get_rolled_diff(): #excluding event bonus
	var t_diff = char_roll_data.diff
	t_diff += char_roll_data.lvl
	if char_roll_data.mboss: t_diff += 1
	if char_roll_data.uniq: t_diff += 2 
#	if char_roll_data.trait_bonus: t_diff += 2 not implemented
	
	return t_diff


func roll_characters():
	var res = []
	if char_roll_data.no_roll:
		reset_roll_data()
		return res
	var chance1 = 0.25
	var chance2 = 0.1
	
	if char_roll_data.mboss: 
		chance1 = 0.5
		chance2 = 0.15
	if char_roll_data.uniq: 
		chance1 = 1.0
#	if char_roll_data.trait_bonus: not implemented
#		chance1 = 0.5
#		chance2 = 0.15
	
	var t_diff = get_rolled_diff()
	if char_roll_data.event: t_diff += 2
	
	var t_race = 'random'
	var areadata = input_handler.active_area
	var locdata = input_handler.active_location
	var racedata = []
	if locdata.has('character_data'):
		locdata = locdata.character_data
		if locdata.has('chance_mod'):
			chance1 *= locdata.chance_mod
			chance2 *= locdata.chance_mod
		if locdata.has('races'):
			racedata = locdata.races.duplicate()
		elif areadata.has('races'):
			racedata = areadata.races.duplicate()
		 #or weight_random if data is weighted 
#		race = input_handler.weightedrandom(input_handler.active_area.races)
	
	var n = 0
	if rng.randf() < chance1:
		if racedata is Array and !racedata.empty():
			t_race = input_handler.weightedrandom(racedata)
		if t_race == 'local':
			t_race = input_handler.weightedrandom(areadata.races)
		var newslave = ResourceScripts.scriptdict.class_slave.new("random_combat")
		newslave.generate_random_character_from_data(t_race, null, t_diff)
		newslave.is_active = true
#		newslave.set_slave_category('servant')
		res.push_back(newslave.id)
		n += 1
		while rng.randf() < chance2 and n < char_roll_data.max_amount:
			if racedata is Array and !racedata.empty():
				t_race = input_handler.weightedrandom(racedata)
			if t_race == 'local':
				t_race = input_handler.weightedrandom(areadata.races)
			newslave = ResourceScripts.scriptdict.class_slave.new("random_combat")
			newslave.generate_random_character_from_data(t_race, null, t_diff)
			newslave.is_active = true
#			newslave.set_slave_category('servant')
			res.push_back(newslave.id)
			n += 1
	
	reset_roll_data()
	return res


var yes
var no
func common_effects(effects):
	for i in effects:
		match i.code:
			'money_change':
				ResourceScripts.game_res.update_money(i.operant, i.value)
			'material_change':
				ResourceScripts.game_res.update_materials(i.operant, i.material, i.value)
			'make_story_character':
				if ResourceScripts.game_party.get_unique_slave(i.value.to_lower()) != null:
					continue
				var newslave = ResourceScripts.scriptdict.class_slave.new("common_story")
				newslave.generate_predescribed_character(worlddata.pregen_characters[i.value])
				if "recruit_from_location" in i:
					newslave.travel.area = input_handler.active_area.code
					newslave.travel.location = input_handler.active_location.id
				if "send_to_mansion" in i:
					if i.send_to_mansion:
						newslave.travel.return_to_mansion()
				if "slave_category" in i:
					newslave.set_slave_category(i.slave_category)
				#newslave.set_slave_category(newslave.slave_class)
				ResourceScripts.game_party.add_slave(newslave)
			'add_timed_event':
				var newevent = {reqs = [], code = i.value}
				for k in i.args:
					match k.type:
						'add_to_date':
							var newreq = [{type = 'date', operant = 'eq', value = ResourceScripts.game_globals.date + round(rand_range(k.date[0], k.date[1]))}, {type = 'hour', operant = 'eq', value = k.hour}]
							newevent.reqs += newreq
						'fixed_date':
							var newreq = [{type = 'date', operant = 'eq', value = k.date}, {type = 'hour', operant = 'eq', value = k.hour}]
							newevent.reqs += newreq
						'add_to_hour':
							var date = ResourceScripts.game_globals.date
							var hour = ResourceScripts.game_globals.hour + round(rand_range(k.hour[0], k.hour[1]))
							if hour > 4: hour = hour-4
							if ResourceScripts.game_globals.hour == 4:
								date += 1
							var newreq = [{type = 'date', operant = 'eq', value = date}, {type = 'hour', operant = 'eq', value = hour}]
							newevent.reqs += newreq
						'action_to_date':
							var newreq = [{type = 'date', operant = 'eq', value = ResourceScripts.game_globals.date + round(rand_range(k.date[0], k.date[1]))}, {type = 'hour', operant = 'eq', value = k.hour}]
							newevent.action = k.action
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
				if character == null:
					continue
				for k in i.args:
					if k.code == 'sextrait':
						match k.operant:
							'add':
								character.add_sex_trait(k.value, k.known)
					elif k.code == 'tag':
						match k.operant:
							'remove':
								character.tags.erase(k.value)
								if k.value == 'no_sex' and !character.has_status('no_sex'):
									var text = character.get_short_name() + ": " + "Sex unlocked"
									text_log_add('char', text)
								
								#character.stats.tags.erase(k.value)
					elif k.code == 'assign_to_quest_and_make_unavalible':
						character.assign_to_quest_and_make_unavalible(k.quest, k.work_time)
					elif k.code == 'remove_character':
						ResourceScripts.game_party.remove_slave(character)
					elif k.code == 'add_profession':
						character.unlock_class(k.profession)
					elif k.code == 'add_trait':
						character.add_trait(k.trait)
					elif k.code == 'create_and_equip':
						var item = CreateGearItem(k.item, k.parts)
						AddItemToInventory(item)
						character.equip(item)
					elif k.code == 'take_virginity':
						if k.partner == 'master':
							k.partner = ResourceScripts.game_party.get_master().id
						character.take_virginity(k.type, k.partner)
					elif k.code == 'add_partner':
						if k.partner == 'master':
							k.partner = ResourceScripts.game_party.get_master().id
						character.add_partner(k.partner)
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
						k.set_stat(i.stat, i.value)
			'affect_scene_characters': #idk why it is the same as above and why it is used instead of above
				if i.type == 'all':
					for k in input_handler.scene_characters:
						k.set_stat(i.stat, i.value)
			'real_affect_scene_characters':
#				if i.type == 'all':
				for k in input_handler.scene_characters:
					k.affect_char(i)
			'change_type_scene_characters':
				if i.type == 'all':
					for k in input_handler.scene_characters:
						k.set_slave_category(i.value)
			'active_character_switch':
				input_handler.active_character = input_handler.scene_characters[i.value]
			'affect_active_character':
				input_handler.active_character.affect_char(i)
			'make_loot':
				input_handler.scene_loot = ResourceScripts.world_gen.make_chest_loot(input_handler.weightedrandom(i.pool))
			'open_loot':
				# input_handler.get_spec_node(input_handler.NODE_LOOTTABLE).open(input_handler.scene_loot, '[center]Acquired Items:[/center]')
					var loot_win = input_handler.get_spec_node(input_handler.ANIM_LOOT)
					if !gui_controller.windows_opened.has(loot_win):
						gui_controller.windows_opened.append(loot_win)
					loot_win.open(input_handler.scene_loot)
					loot_win.raise()
			'make_scene_character':
				for k in i.value:
					var newcharacter
					var number = 1
					if k.has("number"):
						number = round(rand_range(k.number[0], k.number[1]))
					while number > 0:
						match k.type:
							'raw':
								newcharacter = ResourceScripts.scriptdict.class_slave.new("common_scene_raw")
#								newcharacter.is_active = false
								newcharacter.generate_random_character_from_data(k.race, k.class, k.difficulty)
								newcharacter.set_slave_category(k.slave_type)
							'function':
								newcharacter = call(k.function, k.args)
						newcharacter.is_active = false
						input_handler.active_character = newcharacter
						input_handler.scene_characters.append(newcharacter)

						number -= 1
			'update_guild':
				if input_handler.exploration_node == null:
					input_handler.exploration_node = gui_controller.exploration
				input_handler.exploration_node.enter_guild(input_handler.active_faction)
			'update_city':
				#input_handler.exploration_node.enter_guild(input_handler.active_faction)
				if input_handler.exploration_node == null:
					input_handler.exploration_node = gui_controller.exploration
				if input_handler.exploration_node != null:
					input_handler.exploration_node.open_city(input_handler.active_location.id)
			'update_party':
				if gui_controller.exploration != null:
					gui_controller.exploration.build_location_group()
			'rewrite_save': #obsolete
				pass
#				if (int(ResourceScripts.game_globals.date) % input_handler.globalsettings.autosave_frequency == 0) and int(ResourceScripts.game_globals.hour) == 1:
#					autosave(true)
			'background_noise':
				match i.value:
					'start':
						input_handler.PlayBackgroundSound(i.sound)
					'stop':
						input_handler.StopBackgroundSound()	
					'resume':
						input_handler.ResumeBackgroundSound()
			'update_location':
				if input_handler.exploration_node == null:
					input_handler.exploration_node = gui_controller.exploration
				input_handler.exploration_node.open_location(input_handler.active_location)
			'advance_location':
				if input_handler.exploration_node == null:
					input_handler.exploration_node = gui_controller.exploration
				if input_handler.combat_explore:
					input_handler.exploration_node.advance()
			'open_location': # {code = 'open_location', location = "SETTLEMENT_PLAINS1", area = "plains"}
				gui_controller.exploration.show()
				if input_handler.exploration_node == null:
					input_handler.exploration_node = gui_controller.exploration
				var location
				for a in ResourceScripts.game_world.areas[i.area].locations.values():
					if a.code.matchn(i.location): # SETTLEMENT_PLAINS1
						location = a
				# trying to find capital
				if location == null:
					var area = null
					var data = i
					if data.has('area'):
						if ResourceScripts.game_world.areas.has(data.area): area = ResourceScripts.game_world.areas[data.area]
						else:
							print("error - no area %s" % data.area)
							continue
						if area.has('capital'):
							location = ResourceScripts.game_world.get_area_capital(area)
							area = area.code
#					location = {id = location, area = area}
					location = ResourceScripts.world_gen.get_location_from_code(location)
					input_handler.active_location = location
					input_handler.exploration_node.open_city(location.id)
					continue
				
				location = ResourceScripts.world_gen.get_location_from_code(location.id) #dont understand why it is reqired
				input_handler.active_location = location
				input_handler.exploration_node.open_location(location)
			'open_city': 
				if input_handler.exploration_node == null:
					input_handler.exploration_node = gui_controller.exploration
				input_handler.exploration_node.open_city(i.city)
			'create_character':
				#temporal solution
				var preset = starting_presets.preset_data[ResourceScripts.game_globals.starting_preset]
				if preset.has('tags') and preset.tags.has('solo'):
					continue
				input_handler.get_spec_node(input_handler.NODE_CHARCREATE, ['slave', i.type])
			'progress_quest':
				var quest_exists = false
				for k in ResourceScripts.game_progress.active_quests:
					if k.code == i.value:
						quest_exists = true
						k.stage = i.stage
						text_log_add("quests", "Quest Updated: " + tr(scenedata.quests[k.code].stages[k.stage].name) + ". ")
						var args = {}
						args["label"] = "Quest Updated"
						args["info"] =  tr(scenedata.quests[k.code].stages[k.stage].name)
						args["sound"] = "class_aquired"
						input_handler.play_animation("quest", args)
				if quest_exists == false:
					ResourceScripts.game_progress.active_quests.append({code = i.value, stage = i.stage})
					text_log_add("quests", "Quest Received: " + tr(scenedata.quests[i.value].stages[i.stage].name) + ". ")
					var args = {}
					args["label"] = "Quest Received"
					args["info"] = tr(scenedata.quests[i.value].stages[i.stage].name)
					args["sound"] = "class_aquired"
					input_handler.play_animation("quest", args)
			'complete_quest':
				for k in ResourceScripts.game_progress.active_quests:
					if k.code == i.value:
						ResourceScripts.game_progress.active_quests.erase(k)
						text_log_add("quests","Quest Completed: " + tr(scenedata.quests[k.code].stages[k.stage].name) + ". ")
						
						var args = {}
						args["label"] = "Quest Completed"
						args["name"] =  tr(scenedata.quests[k.code].stages[k.stage].name)
						#args["sound"] = "class_aquired"
						input_handler.play_animation("quest_completed", args)
						break
				ResourceScripts.game_progress.completed_quests.append(i.value)
			'complete_active_location':
				complete_location(input_handler.active_location.id)
			'set_completed_active_location':
				#input_handler.active_location.progress.level = input_handler.active_location.levels.size()
				input_handler.active_location.progress.stage = input_handler.active_location.levels["L" + str(input_handler.active_location.levels.size())].stages
				input_handler.active_location.completed = true
			'remove_active_location':
				remove_location(input_handler.active_location.id)
			'reputation':
				var data = ResourceScripts.world_gen.get_faction_from_code(i.name)
				var guild = ResourceScripts.game_world.areas[data.area].factions[data.code]
				var n1 = get_nquest_for_rep(guild.totalreputation)
				guild.reputation = input_handler.math(i.operant, guild.reputation, i.value)
				guild.totalreputation = input_handler.math(i.operant, guild.totalreputation, i.value) #guess there should be a + operant check before it
				var n = get_nquest_for_rep(guild.totalreputation) - n1
				if n > 0:
					guild.questsetting.total += n
					guild.questsetting.easy += n
					var args = {}
					args["label"] = guild.name
					args["info"] = "Reputation: +%d Total Quest" % n
					args["sound"] = "class_aquired"
					input_handler.play_animation("quest", args)
			'decision':
				if !ResourceScripts.game_progress.decisions.has(i.value):
					ResourceScripts.game_progress.decisions.append(i.value)
			'remove_decision':
				if ResourceScripts.game_progress.decisions.has(i.value):
					ResourceScripts.game_progress.decisions.erase(i.value)
			'screen_black_transition':
				ResourceScripts.core_animations.BlackScreenTransition(i.value)
			'screen_shake':
				if i.has('delay'):
					yield(get_tree().create_timer(i.delay),'timeout')
				ResourceScripts.core_animations.ShakeAnimation(gui_controller.current_screen, i.length, i.strength)
				ResourceScripts.core_animations.ShakeAnimation(gui_controller.dialogue, i.length, i.strength)
			'start_combat':
				current_enemy_group = i.value
				input_handler.get_spec_node(input_handler.NODE_COMBATPOSITIONS)
			'start_quest_combat':
				globals.StartQuestCombat(i.value)
			'make_quest_location':
				ResourceScripts.world_gen.make_quest_location(i.value)
			'remove_quest_location':
				remove_location(i.value)
			'return_characters_from_location':
				return_characters_from_location(i.value)
			'set_music':
				input_handler.SetMusic(i.value)
			'play_sound':
				input_handler.PlaySound(i.value)
			'lose_game':
				input_handler.PlaySound('transition_sound')
				globals.return_to_main_menu()
			'complete_active_location_quests':
				if input_handler.active_location.has('questid'):
					var quest = ResourceScripts.game_world.get_quest_by_id(input_handler.active_location.questid)
					for req in quest.requirements:
						if req.code in ['complete_location','complete_dungeon'] && req.area == input_handler.active_area.code && req.location == input_handler.active_location.id:
							req.completed = true
			'affect_active_party':
				for k in input_handler.get_active_party():
					k.affect_char(i)
			'affect_unique_character':
				var k = ResourceScripts.game_party.get_unique_slave(i.name.to_lower())
				if k != null:
					k.affect_char(i)
			'progress_active_location':
				gui_controller.exploration.skip_to_boss()
			'dialogue_counter':
				ResourceScripts.game_progress.operate_counter(i.name, i.op)
			'unlock_class':
				if !ResourceScripts.game_progress.unlocked_classes.has(i.name):
					ResourceScripts.game_progress.unlocked_classes.append(i.name)
					input_handler.play_unlock_class_anim(i.name)
			'reset_day_count':
				ResourceScripts.game_progress.reset_day_count(i.quest)
			#to_loc and from_loc are location-defining data dicts
			#in formats:
			#{area = area_id} - means area capital
			#{location = location_id}
			#{code = location_code} - means first id-wise existing location with given code
			'teleport_active_character':
				input_handler.active_character.teleport(i.to_loc)
				gui_controller.nav_panel.build_accessible_locations()
			'teleport_active_location':
				var location
				for a in ResourceScripts.game_world.areas[i.to_loc.area].locations.values():
					if a.code == i.to_loc.location.to_upper() || a.code == i.to_loc.location: # SETTLEMENT_PLAINS1
						location = a
				# trying to find capital
				if location == null:
					var area = null
					var data = i.to_loc
					if data.has('area'):
						if ResourceScripts.game_world.areas.has(data.area): area = ResourceScripts.game_world.areas[data.area]
						else:
							print("error - no area %s" % data.area)
							continue
						if area.has('capital'):
							location = ResourceScripts.game_world.get_area_capital(area)
							area = area.code
					location = {location = location, area = area}
				
				for pos in input_handler.active_location.group:
					var ch_id = input_handler.active_location.group[pos]
					if ch_id != null:
						characters_pool.get_char_by_id(ch_id).teleport(location)
				gui_controller.nav_panel.build_accessible_locations()
				#(i.to_loc.location)
			'teleport_location':
				var locdata = ResourceScripts.game_world.find_location_by_data(i.from_loc)
				if locdata.location == null:
					print("teleportation from %s failed" % str(i.from_loc))
					continue
				locdata = ResourceScripts.world_gen.get_location_from_code(locdata.location)
				for pos in locdata.group:
					var ch_id = locdata.group[pos]
					if ch_id != null:
						characters_pool.get_char_by_id(ch_id).teleport(i.to_loc)
				gui_controller.nav_panel.build_accessible_locations()
			'return_to_mansion':
				gui_controller.nav_panel.return_to_mansion()
			'update_mansion':
				if gui_controller.current_screen == gui_controller.mansion:
					gui_controller.nav_panel.build_accessible_locations()
					gui_controller.nav_panel.update_buttons()
					gui_controller.mansion.SlaveListModule.rebuild()
			# example:
			# location = "SETTLEMENT_PLAINS1"
			# area = "plains"
			# param = "type"
			# value = "locked"
			'set_location_param':
				var param = i.param
				var value = i.value
				var loc
				for a in ResourceScripts.game_world.areas[i.area].locations.values():
					if a.code.matchn(i.location):
						a[param] = value
						loc = a
						break
					elif ResourceScripts.world_gen.get_location_from_code(a.code) == i.location.to_upper() || a.code == i.location:
						a[param] = value
						loc = a
						break
				if param == 'captured' && value == true && loc != null:
					return_characters_from_location(loc.id)
			'yes_or_no_panel':
				yes = i.yes
				no = i.no
				input_handler.get_spec_node(input_handler.NODE_YESORNOPANEL, [self, "yes_message", "no_message", i.text])
			'close_guild_window':
				gui_controller.nav_panel.select_location("aliron")
			'add_item':
				var item = Items.itemlist[i.item]
				var counter = i.number
				if item.type == 'usable':
					while counter > 0:
						AddItemToInventory(CreateUsableItem(item.code))
						counter -= 1
				elif item.type == 'gear':
					while counter > 0:
						counter -= 1
						AddItemToInventory(CreateGearItem(item.code, {}))
			'remove_item':
				ResourceScripts.game_res.remove_item(i.name, i.number)
			'unlock_asset':
				input_handler.update_progress_data(i.dir, i.key)
			'set_spouse':
				ResourceScripts.game_progress.spouse = input_handler.active_character.id
#				input_handler.active_character.unlock_class('spouse')
			'complete_wedding':
				ResourceScripts.game_progress.marriage_completed = true
				ResourceScripts.game_party.get_spouse().unlock_class('spouse')
				ResourceScripts.game_party.get_spouse().set_stat('surname', ResourceScripts.game_party.get_master().get_stat('surname'))
			'hide_dialogue':
				gui_controller.dialogue.hide_dialogue()
			'plan_mansion_event':
				ResourceScripts.game_progress.planned_mansion_events.append(i.value)

func yes_message():
	input_handler.interactive_message(yes, '', {})

func no_message():
	input_handler.interactive_message(no, '', {})

func get_nquest_for_rep(value):
	if value >= variables.reputation_tresholds.back() :
		return variables.reputation_tresholds.size()
	var n = 0
	while value >= variables.reputation_tresholds[n]:
		n += 1
	return n

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
		'false':
			return false
		"has_money":
			return ResourceScripts.game_res.if_has_money(dict['value'])
#		"has_property":
#			return if_has_property(dict['prop'], dict['value'])
		"has_hero":
			return ResourceScripts.game_party.if_has_hero(dict['name']) == dict.check
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
		"area_progress":
			return ResourceScripts.game_progress.if_has_area_progress(dict.value, dict.operant, dict.area)
		"decision":
			return ResourceScripts.game_progress.decisions.has(dict.value) == dict.check
		"has_multiple_decisions":
			var counter = 0
			for i in dict.decisions:
				if ResourceScripts.game_progress.decisions.has(i):
					counter += 1
			return input_handler.operate(dict.operant, counter, dict.value)
		"quest_completed":
			return ResourceScripts.game_progress.completed_quests.has(dict.name) == dict.check
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
		'has_spouse':
			var spid = ResourceScripts.game_progress.spouse
			if spid == null: return !dict.check
			var spouse_char = characters_pool.get_char_by_id(spid)
			if spouse_char == null: return !dict.check
			if !spouse_char.is_active: return !dict.check
			return dict.check
		'master_check':
			var master_char = ResourceScripts.game_party.get_master()
			if master_char == null:
				return false
			return master_char.checkreqs(dict.value)
		'spouse_check':
			var spid = ResourceScripts.game_progress.spouse
			if spid == null: return false
			var spouse_char = characters_pool.get_char_by_id(spid)
			if spouse_char == null: return false
			return spouse_char.checkreqs(dict.value)
		'active_character_checks':
			var character = input_handler.active_character
			if character == null:return false
			return character.checkreqs(dict.value)
		'scene_character_checks':
			if input_handler.scene_characters.empty(): return false
			var character = input_handler.scene_characters[0]
			if character == null: return false
			return character.checkreqs(dict.value)
		'unique_character_checks':
			var character = ResourceScripts.game_party.get_unique_slave(dict.name)
			if character == null:return false
			return character.checkreqs(dict.value)
		'master_is_beast':
			return ResourceScripts.game_party.if_master_is_beast(dict.check)
		'unique_character_at_mansion':
			var character = ResourceScripts.game_party.get_unique_slave(dict.name)
			if character == null:return false
			return character.checkreqs([{code = 'is_free', check = dict.check}])
		'has_money_for_scene_slave':
			return ResourceScripts.game_res.money >= input_handler.scene_characters[dict.value].calculate_price()
		'random':
			return globals.rng.randf()*100 <= dict.value
		'dialogue_seen':
			return ResourceScripts.game_progress.seen_dialogues.has(dict.value) == dict.check
		'dialogue_selected':
			return ResourceScripts.game_progress.selected_dialogues.has(dict.value) == dict.check
		'event_seen':
			return ResourceScripts.game_progress.seen_events.has(dict.value) == dict.check
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
		'any_quest_stage':
			if ResourceScripts.game_progress.get_active_quest(dict.value) == null || dict.has('stage') == false:
				return false
			for i in dict.stages:
				if ResourceScripts.game_progress.get_active_quest(dict.value).stage == i:
					return true
			return false
		'faction_reputation':
			var data = ResourceScripts.world_gen.get_faction_from_code(dict.code)
			var guild = ResourceScripts.game_world.areas[data.area].factions[data.code]
			return input_handler.operate(dict.operant, guild.totalreputation, dict.value)
		'group_size':#not sure about this implementation instead of area - party approach
			var counter = 0
			for i in ResourceScripts.game_party.characters.values():
				if i.check_location(input_handler.active_location.id):
					counter += 1
			return input_handler.operate(dict.operant, counter, dict.value)
		'location_has_specific_slaves':
			var counter = 0
			var location = ResourceScripts.game_world.find_location_by_data({code = dict.location}).location
			for i in ResourceScripts.game_party.characters.values():
				if i.check_location(location):
					if i.checkreqs(dict.reqs) == true && !i.has_profession('master'):
						counter += 1
			if dict.has("check"):
				return dict.check == (counter >= dict.value)
			return counter >= dict.value
		'class_unlocked':
			return ResourceScripts.game_progress.if_class_unlocked(dict.class, dict.check, dict.operant)
		'timed_option':
			return ResourceScripts.game_progress.if_time_passed(dict.value, dict.quest)
		'current_guild':
			return ((dict.value == input_handler.active_faction.code) == dict.check)
		'has_faction_upgrade':
			return dict.check == input_handler.active_faction.upgrades.has(dict.value)
		'local_counter':
			var tval = dict.value
			if dict.has("add_stat"):
				var master_char = ResourceScripts.game_party.get_master()
				if master_char != null:
					tval -= master_char.get_stat(dict.add_stat)
			if dict.has("sub_stat"):
				var master_char = ResourceScripts.game_party.get_master()
				if master_char != null:
					tval += master_char.get_stat(dict.sub_stat)
			return ResourceScripts.game_progress.counter_cond(dict.name, dict.operant, tval) == dict.check
		'master_factor_check':
			var master_char = ResourceScripts.game_party.get_master()
			if master_char == null:
				return false
			else:
				var r = globals.rng.randi_range(dict.from, dict.to)
				if !master_char.statlist.statlist.has(dict.factor):
					return false #wrong factor
				var stat = dict.value * master_char.statlist.statlist.get(dict.factor)
				var result = r > stat
				return result == dict.check
		'sex_filter': # return true if master.sex == scene_sex
			# dict.scene_sex - masters gender in the next scene. If scene shows us as a male then scene_sex = male
			if !input_handler.globalsettings.sex_filter:
				return false
			var master_char = ResourceScripts.game_party.get_master()
			if master_char == null:
				return false
			var master_sex = master_char.statlist.statlist.sex
			return master_sex == dict.scene_sex
