extends Control


var closebuttonoffset = [0,0]
var closebutton
var open_sound = 'menu_open'
var close_sound = 'menu_close'
var close_played = false
export var test_mode = false

# Main Modules
onready var MAIN_MODULES = {
	MANSION = preload("res://GUI_New/Mansion/MansionMainModule.tscn"),
	SLAVE_INFO = load("res://GUI_New/CharacterInfo/CharInfoMainModule.tscn"),
	INVENTORY = preload("res://GUI_New/Inventory/InventoryMainModule.tscn"),
	EXPLORATION = preload("res://GUI_New/Exploration/ExplorationMainModule.tscn"),
	INTERACTION = preload("res://GUI_New/Mansion/InteractionMainModule.tscn"),
	DATE = preload("res://src/date.tscn"),
	GAMEMENU = preload("res://GUI_New/GameMenuPanel.tscn"),
	CLOCK = preload("res://GUI_New/Mansion/MansionClockModule.tscn"),
}

# GUI Dict
onready var gui_data = {}

# Variables
var CurrentScene
var PreviousScene
var BaseScene
var menu_opened = false


func _ready():
	# OS.window_fullscreen = true
	# queue_free()
	# return
	input_handler.CurrentScene = self
	if test_mode:
		test_mode()
	var is_new_game = false
	if globals.start_new_game == true:
		globals.start_new_game = false
		self.visible = false
		is_new_game = true
		var newgame_node = Node.new()
		newgame_node.set_script(ResourceScripts.scriptdict.gamestart)
		newgame_node.start()
		input_handler.GameStartNode = newgame_node
		yield(input_handler, "StartingSequenceComplete")
		input_handler.GameStartNode.queue_free()
		#globals.AddItemToInventory(globals.CreateGearItem("axe", {ToolHandle = 'wood', ToolBlade = 'stone'}))
		show()
		input_handler.ActivateTutorial("introduction")
		if starting_presets.preset_data[ResourceScripts.game_globals.starting_preset].story == true:
			input_handler.interactive_message('intro', '', {})

	for scene in MAIN_MODULES:
		var main_module = MAIN_MODULES[scene].instance()
		add_child(main_module)
		gui_data[scene] = {"main_module": main_module}

	CurrentScene = gui_data["MANSION"].main_module
	BaseScene = gui_data["MANSION"].main_module
	input_handler.get_spec_node(input_handler.NODE_CLASSINFO, null, false, false)
	visibility_handler()
	if is_new_game:
		yield(input_handler, 'EventFinished')
		input_handler.get_spec_node(input_handler.NODE_GUI_WORLD).gui_data.MANSION.main_module.show_tutorial()


func _input(event):
	var dialogue = get_tree().get_root().get_node_or_null("dialogue")
	if CurrentScene == null:
		return
	if dialogue != null && dialogue.is_visible() && str(event.as_text().replace("Kp ",'')) in str(range(1,9)):
		dialogue.select_option(int(event.as_text()))
	if (event.is_action_released("ESC") || event.is_action_released("RMB")) && CurrentScene.name == "date":
		return
	if event.is_action_released("F1"):
		input_handler.get_spec_node(input_handler.NODE_MANSION_NEW).show_tutorial()
	if (event.is_action_released("ESC") || event.is_action_released("RMB")):
		if menu_opened:
			var has_submodules_opened = (gui_data["GAMEMENU"].main_module.submodules.size() > 0)
			if has_submodules_opened:
				submodules_handler()
				return
			else:
				gui_data["GAMEMENU"].main_module.hide()
				menu_opened = !menu_opened
				return
		if CurrentScene == gui_data.INVENTORY.main_module && !PreviousScene == gui_data.SLAVE_INFO.main_module:
			PreviousScene = CurrentScene
			visibility_handler()
			PreviousScene = null
			return
		if CurrentScene == gui_data.SLAVE_INFO.main_module:# && !PreviousScene == gui_data.SLAVE_INFO.main_module:
			if CurrentScene.get_node("SlaveBodyModule/professions").get_global_rect().has_point(get_global_mouse_position()):
				return
			PreviousScene = CurrentScene
			visibility_handler()
			PreviousScene = null
			return
	if (event.is_action_released("ESC") && CurrentScene != null && CurrentScene.name != "InteractionMainModule") && !input_handler.get_spec_node(input_handler.NODE_CLASSINFO).is_visible():
		if menu_opened:
			var has_submodules_opened = (gui_data["GAMEMENU"].main_module.submodules.size() > 0)
			if has_submodules_opened:
				submodules_handler()
				return
			gui_data["GAMEMENU"].main_module.hide()
			CurrentScene.get_node("MansionClockModule").set_time_buttons()
			menu_opened = !menu_opened
			return
		if get_tree().get_root().has_node("classinfo"):
			if (CurrentScene == gui_data["MANSION"].main_module 
				&& CurrentScene.mansion_state in ["default", "skills"] 
				&& !get_tree().get_root().get_node("classinfo").is_visible()):
				if (get_tree().get_root().get_node("classinfo").is_visible()
					|| CurrentScene.submodules != []):
					return
				else:
					menu_opened = !menu_opened
		elif (CurrentScene == gui_data["MANSION"].main_module 
			&& CurrentScene.mansion_state in ["default", "skills"]
			&& !CurrentScene.get_node("MansionJournalModule").is_visible()):
			menu_opened = !menu_opened
	if (event.is_action_released("ESC") || event.is_action_released("RMB")) && CurrentScene != null && CurrentScene.name != "InteractionMainModule":
		var ignore_rightclick = false
		for i in get_tree().get_nodes_in_group("ignore_rightclicks"):
			if i.is_visible() && i.get_global_rect().has_point(get_global_mouse_position()):
				ignore_rightclick = true
				continue
		if !ignore_rightclick:
			visibility_handler()
	if CurrentScene == gui_data["MANSION"].main_module && str(event.as_text().replace("Kp ",'')) in str(range(1,9)):# && !text_field_input: ### Find Solution
		if str(int(event.as_text())) in str(range(1,4)) && !event.is_pressed():
			if input_handler.globalsettings.turn_based_time_flow == false:
				gui_data.CLOCK.main_module.changespeed(gui_data.CLOCK.main_module.timebuttons[int(event.as_text())-1])
			else:
				CurrentScene.get_node("MansionClockModule").timeflowhotkey(int(event.as_text()))
		



func clock_visibility():
	if CurrentScene == gui_data.MANSION.main_module:
		gui_data.CLOCK.main_module.show()
	else:
		if CurrentScene == gui_data.EXPLORATION.main_module && !CurrentScene.get_node("ExploreFullSlaveModule").is_visible() && !CurrentScene.get_node("LocationGui").is_visible():
			gui_data.CLOCK.main_module.show()
		else:
			gui_data.CLOCK.main_module.hide()


func visibility_handler():
	var has_submodules_opened = (CurrentScene.submodules.size() > 0)
	if has_submodules_opened:
		submodules_handler()
	if CurrentScene == gui_data["INVENTORY"].main_module && PreviousScene == gui_data["SLAVE_INFO"].main_module && CurrentScene.is_visible():
		ResourceScripts.core_animations.UnfadeAnimation(PreviousScene, 0.3)
		CurrentScene.hide()
		CurrentScene = PreviousScene
	# if BaseScene == gui_data.MANSION.main_module && gui_data.INVENTORY.main_module.is_visible():
	# 	ResourceScripts.core_animations.UnfadeAnimation(BaseScene, 0.3)
	# 	# yield(get_tree().create_timer(0.3), "timeout")
	# 	CurrentScene = BaseScene
	if menu_opened:
		gui_data["GAMEMENU"].main_module.open()
		return
	if BaseScene == gui_data["MANSION"].main_module && !has_submodules_opened:
		BaseScene.mansion_state = "default"
	if !has_submodules_opened && CurrentScene.is_visible():
		# ResourceScripts.core_animations.FadeAnimation(CurrentScene, 0.3)
		# yield(get_tree().create_timer(0.3), "timeout")
		CurrentScene = BaseScene
	for scene in gui_data.values():
		if scene.main_module.get_class() == "Tween":
			continue
		scene.main_module.visible = (scene.main_module == CurrentScene)
		if CurrentScene != PreviousScene && PreviousScene != null:
			ResourceScripts.core_animations.UnfadeAnimation(CurrentScene, 0.3)
	CurrentScene.update()
	for subscene in CurrentScene.get_children():
		if subscene.get_class() == "Tween":
			continue
		subscene.update()
	gui_data.MANSION.main_module.get_node("TutorialButton").show()
	clock_visibility()



func submodules_handler():
	var last_opened_id
	var last_opened
	var classinfo = get_tree().get_root().get_node_or_null("classinfo")
	if classinfo && menu_opened && !classinfo.is_visible():
		last_opened_id = (gui_data["GAMEMENU"].main_module.submodules.size() - 1)
		last_opened = gui_data["GAMEMENU"].main_module.submodules[last_opened_id]
		gui_data["GAMEMENU"].main_module.submodules[last_opened_id].hide()
		gui_data["GAMEMENU"].main_module.submodules.erase(last_opened)
	else:
		last_opened_id = (CurrentScene.submodules.size() - 1)
		last_opened = CurrentScene.submodules[last_opened_id]
		CurrentScene.submodules[last_opened_id].hide()
		CurrentScene.submodules.erase(last_opened)
	gui_data.MANSION.main_module.get_node("TutorialButton").show()



func close_scene(scene):
	scene.hide()
	var classinfo = get_tree().get_root().get_node_or_null("classinfo")
	if classinfo && CurrentScene == gui_data.SLAVE_INFO.main_module && classinfo == scene:
		CurrentScene.submodules.erase(scene)
		return
	if scene in gui_data.EXPLORATION.main_module.submodules:
		gui_data.EXPLORATION.main_module.submodules.erase(scene)
		gui_data.EXPLORATION.main_module.Navigation.show()
	if scene == gui_data.GAMEMENU.main_module:
		menu_opened = false
		return
	if BaseScene == gui_data["MANSION"].main_module:
		if BaseScene.mansion_state == "travels":
			BaseScene.TravelsModule.open_character_dislocation()
			return
		BaseScene.mansion_state = "default"
		# for module in BaseScene.submodules:
		# 	# ResourceScripts.core_animations.FadeAnimation(module, 0.3)
		# 	# yield(get_tree().create_timer(0.3), "timeout")
		# CurrentScene.hide()
		set_current_scene(BaseScene)
		return
	for module in CurrentScene.submodules:
		# ResourceScripts.core_animations.FadeAnimation(module, 0.3)
		# yield(get_tree().create_timer(0.3), "timeout")
		module.hide()
	CurrentScene.submodules.clear()
	if CurrentScene == gui_data["SLAVE_INFO"].main_module:
		return


func set_current_scene(scene):
	if CurrentScene == gui_data["SLAVE_INFO"].main_module:
		PreviousScene = CurrentScene
	CurrentScene = scene
	visibility_handler()


func add_close_button(scene, position = "snap"):
	var closebuttonoffset = [0,0]
	if position == "add_offset":
		closebuttonoffset = [15,15]
	var pos_in_tree = scene.get_child_count()
	rect_pivot_offset = Vector2(rect_size.x/2, rect_size.y/2)
	closebutton = load(ResourceScripts.scenedict.close).instance()
	scene.add_child(closebutton)
	scene.move_child(closebutton, pos_in_tree)
	closebutton.connect("pressed", self, 'close_scene', [scene])
	var rect = scene.get_global_rect()
	var pos = Vector2(rect.end.x - closebutton.rect_size.x - closebuttonoffset[0], rect.position.y + closebuttonoffset[1])
	closebutton.rect_global_position = pos



func show_class_info(classcode, person = null):
	if person == null:
		person = gui_data["MANSION"].main_module.active_person
	var node = input_handler.get_spec_node(input_handler.NODE_CLASSINFO) #get_class_info_panel()
	node.open(classcode, person)
	if !CurrentScene.submodules.has(node):
		CurrentScene.submodules.append(node)



func test_mode():
	variables.allow_skip_fights = true
	ResourceScripts.game_world.make_world()
	
	var character = ResourceScripts.scriptdict.class_slave.new()
	character.create('HalfkinCat', 'futa', 'random')
	character.unlock_class("master")
	characters_pool.move_to_state(character.id)
	ResourceScripts.game_res.upgrades.forge = 3
	ResourceScripts.game_res.upgrades.tailor = 1
#	character = ResourceScripts.scriptdict.class_slave.new()
#	character.create('HalfkinCat', 'random', 'random')
#	characters_pool.move_to_state(character.id)
#	character = ResourceScripts.scriptdict.class_slave.new()
#	character.create('HalfkinCat', 'random', 'random')
#	characters_pool.move_to_state(character.id)
#	character = ResourceScripts.scriptdict.class_slave.new()
#	character.create('HalfkinCat', 'random', 'random')
#	characters_pool.move_to_state(character.id)
#	character = ResourceScripts.scriptdict.class_slave.new()
#	character.create('HalfkinCat', 'random', 'random')
#	characters_pool.move_to_state(character.id)
#	character = ResourceScripts.scriptdict.class_slave.new()
#	character.create('HalfkinCat', 'random', 'random')
#	characters_pool.move_to_state(character.id)
#	character = ResourceScripts.scriptdict.class_slave.new()
#	character.create('HalfkinCat', 'random', 'random')
#	characters_pool.move_to_state(character.id)
#	character = ResourceScripts.scriptdict.class_slave.new()
#	character.create('HalfkinCat', 'random', 'random')
#	characters_pool.move_to_state(character.id)
#	character = ResourceScripts.scriptdict.class_slave.new()
#	character.create('HalfkinCat', 'random', 'random')
#	characters_pool.move_to_state(character.id)
#	character = ResourceScripts.scriptdict.class_slave.new()
#	character.create('HalfkinCat', 'random', 'random')
#	characters_pool.move_to_state(character.id)

#	character.create('HalfkinCat', 'futa', 'random')
#	characters_pool.move_to_state(character.id)
	
	globals.impregnate(character, character)
	character.get_stat('pregnancy', true).duration = 2
	character.statlist.statlist.sex_skills.anal = 100
	character.unlock_class("master")
	character.unlock_class("caster")
	character.unlock_class("apprentice")
	character.unlock_class("rogue")
	character.unlock_class("druid")
	character.unlock_class("souleater")
	character.travel.location = 'L4'
	character.travel.area = 'plains'
	var bow = globals.CreateGearItem("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'})
	globals.AddItemToInventory(bow)
	character.equip(bow)
	character.set_slave_category('master')
	character.statlist.negative_sex_traits = ['dislike_missionary']
	character.statlist.unlocked_sex_traits = [
		'submissive',
		'pushover',
		'bottle_fairy',
		'dominant',
		'sadist',
		'desired',
		'curious',
		'life_power'
	]
	#character.armor = 135
	#character.set_stat('wits', 20)
	character.set_stat('consent', 100)
	character.set_stat('charm_factor', 5)
	character.set_stat('physics_factor', 5)
	character.set_stat('wits_factor', 5)
	character.set_stat('food_love', "meat")
	character.set_stat('food_hate', ["grain"])
	#character.unlock_class("worker")
	character.mp = 50
	character.unlock_class("sadist")
#		character.unlock_class("caster")
	for i in Skilldata.Skilllist:
		if Skilldata.Skilllist[i].type != 'social':
			continue
		character.skills.social_skills.append(i)
	character.is_players_character = true
	globals.impregnate(character, character)
	#character.get_stat('pregnancy').duration = 2

	character = ResourceScripts.scriptdict.class_slave.new()
	character.create('HalfkinCat', 'random', 'random')
	character.set_stat('consent', 100)
	character.statlist.negative_sex_traits = ['dislike_missionary']
	characters_pool.move_to_state(character.id)
	#character.unlock_class("attendant")
	character.add_trait('core_trait')
	character.set_slave_category('servant')
	character.set_stat('obedience', 100)
	character.set_stat('lust', 50)
	character.is_players_character = true
	character = ResourceScripts.scriptdict.class_slave.new()
	character.create('HalfkinCat', 'random', 'random')
	characters_pool.move_to_state(character.id)
	#character.set_stat('base_exp', 1000)



	character.set_stat('obedience', 100)
	#character.fear = 25
	#character.base_exp = 99
	character.set_stat('charm_factor', 5)
	character.set_stat('physics_factor', 5)
	character.set_stat('wits_factor', 5)
	character.set_stat('sexuals_factor', 5)
	character.set_stat('charm', 100)
	character.set_stat('physics', 100)
	character.set_stat('consent', 100)

	var character2 = ResourceScripts.scriptdict.class_slave.new()
	character.set_stat('food_love', "meat")
	character.set_stat('food_hate', ["grain"])
	character2.create('HalfkinCat', 'random', 'random')
	character2.set_stat('charm', 0)
	character2.set_stat('physics', 0)
	character2.set_stat('wits', 0)
	character2.set_stat('sexuals', 0)
	var text = ''
	for i in races.tasklist.values():
		for k in i.production.values():
			var value = character.get_progress_task(i.code, k.code, true) / k.progress_per_item
			if Items.materiallist.has(k.item):
				pass

			else:
				pass

	var base_price = 0
	var output_price = 0
	for i in Items.recipes.values():
		base_price = 0
		output_price = 0
		for k in i.materials:
			base_price += Items.materiallist[k].price * i.materials[k]
		for k in i.items:
			base_price += Items.itemlist[k].price * i.items[k]

		if Items.materiallist.has(i.resultitem):
			output_price = Items.materiallist[i.resultitem].price * i.resultamount
			if base_price != 0:
				text += (
					Items.materiallist[i.resultitem].name
					+ ": Cost - "
					+ str(base_price)
					+ ", Return - "
					+ str(output_price)
					+ "\n"
				)
		else:
			output_price = Items.itemlist[i.resultitem].price * i.resultamount
			if base_price != 0:
				text += (
					Items.itemlist[i.resultitem].name
					+ ": Cost - "
					+ str(base_price)
					+ ", Return - "
					+ str(output_price)
					+ "\n"
				)

	character.set_stat('loyalty', 95)
	character.set_stat('authority', 100)
	character.set_stat('submission', 95)
	character.mp = 10
	character.hp = 95
	#character.exhaustion = 1000
	character.add_trait('core_trait')
	character.set_slave_category('slave')
	character.is_players_character = true

	globals.common_effects(
		[
			{code = 'make_story_character', value = 'Daisy'},
			{
				code = 'unique_character_changes',
				value = 'daisy',
				args = [
					{code = 'sexuals_factor', value = 1, operant = "+"},
					{code = 'sextrait', value = 'submissive', operant = 'add'},  #for sextrait/add setting, trait is appended to character's traits
					{code = 'submission', operant = '+', value = 50},
					{code = 'obedience', operant = '+', value = 30},
					{code = 'tag', operant = 'remove', value = 'no_sex'},
				]
			}
		]
	)
	ResourceScripts.game_res.money = 80000
	for i in Items.materiallist:
		ResourceScripts.game_res.materials[i] = 200
	ResourceScripts.game_res.materials.bandage = 0
	globals.AddItemToInventory(globals.CreateGearItem("handcuffs", {}))
	globals.AddItemToInventory(globals.CreateGearItem("pet_suit", {}))
	globals.AddItemToInventory(globals.CreateGearItem("tail_plug", {}))
	globals.AddItemToInventory(globals.CreateGearItem("maid_dress", {}))
	globals.AddItemToInventory(globals.CreateGearItem("craftsman_suit", {}))
	globals.AddItemToInventory(globals.CreateGearItem("worker_outfit", {}))
	globals.AddItemToInventory(globals.CreateGearItem("lacy_underwear", {}))
	globals.AddItemToInventory(globals.CreateGearItem("animal_gloves", {}))
	globals.AddItemToInventory(globals.CreateGearItem("amulet_of_recognition", {}))
	globals.AddItemToInventory(globals.CreateUsableItem("alcohol"))
	globals.AddItemToInventory(globals.CreateUsableItem("exp_scroll", 4))
	globals.AddItemToInventory(globals.CreateUsableItem("writ_of_exemption", 3))
	globals.AddItemToInventory(globals.CreateUsableItem("lifegem", 5))
	globals.AddItemToInventory(globals.CreateUsableItem("energyshard", 2))
	globals.AddItemToInventory(globals.CreateUsableItem("strong_pheromones", 3))
	globals.AddItemToInventory(globals.CreateUsableItem("majorus_potion", 3))
	globals.AddItemToInventory(globals.CreateUsableItem("majorus_potion", 3))
	globals.AddItemToInventory(
		globals.CreateGearItem("axe", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
	)
	globals.AddItemToInventory(globals.CreateGearItem("club", {WeaponMace = 'stone'}))
	globals.AddItemToInventory(
		globals.CreateGearItem("spear", {WeaponHandle = 'wood', Blade = 'obsidian'})
	)
	globals.AddItemToInventory(
		globals.CreateGearItem("pickaxe", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
	)
	globals.AddItemToInventory(
		globals.CreateGearItem("hammer", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
	)
	
	
	globals.AddItemToInventory(
		globals.CreateGearItem("fishingtools", {ToolHandle = 'wood', ToolClothwork = 'cloth'})
	)
	
	globals.AddItemToInventory(
		globals.CreateGearItem("hunt_knife", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
	)
	globals.AddItemToInventory(
		globals.CreateGearItem("legs_base_metal", {ArmorBaseHeavy = 'mithril', ArmorTrim = 'wood'})
	)
	globals.AddItemToInventory(
		globals.CreateGearItem("chest_base_metal", {ArmorBaseHeavy = 'mithril', ArmorTrim = 'wood'})
	)
	globals.AddItemToInventory(
		globals.CreateGearItem(
			"chest_base_cloth", {ArmorBaseCloth = 'clothsilk', ArmorTrim = 'wood'}
		)
	)
	ResourceScripts.game_progress.show_tutorial = true
	ResourceScripts.game_progress.active_quests.append(
		{code = 'election_global_quest', stage = 'stage1'}
	)
	for i in ResourceScripts.game_world.areas.plains.factions.values():
		i.totalreputation += 500
	character.unlock_class("pet")
	character.unlock_class("souleater")
	character.mp = 10
	var tmp = {}
	tmp.oral = 70
	tmp.anal = 90
	tmp.petting = 100
	#character.set_stat('sex_skills', tmp)
	input_handler.active_location = ResourceScripts.game_world.areas.plains.locations[ResourceScripts.game_world.areas.plains.locations.keys()[4]]  #[state.areas.plains.locations.size()-1]]
	input_handler.active_area = ResourceScripts.game_world.areas.plains

	for i in ResourceScripts.game_world.areas.plains.factions.values():
		i.reputation = 500

	for c in ResourceScripts.game_party.characters.values():
		if c.get_location() == "mansion": c.travel.location = "Aliron"
	yield(get_tree(), 'idle_frame')
	input_handler.ActivateTutorial("introduction")
	input_handler.add_random_chat_message(character2, 'hire')
	# input_handler.interactive_message('loan_event1', '', {})
	
	
	character = ResourceScripts.scriptdict.class_slave.new()
