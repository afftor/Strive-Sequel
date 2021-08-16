extends Control

# VARIABLES
# Modules
onready var TravelsModule = $MansionTravelsModule
onready var UpgradesModule_ = $upgrades
onready var SlaveListModule = $MansionSlaveListModule
onready var SkillModule = $MansionSkillsModule
onready var UpgradesModule = $MansionUpgradesModule
onready var SlaveModule = $MansionSlaveModule
onready var TaskModule = $MansionTaskInfoModule
onready var MenuModule = $MansionBottomLeftModule
#onready var NavModule = $NavigationModule
onready var CraftModule = $MansionCraftModule
onready var CraftSmallModule = $MansionCraftSmallModule
onready var JobModule = $MansionJobModule
onready var SexSelect = $MansionSexSelectionModule
onready var Journal = $MansionJournalModule
onready var Locations = $MansionLocationsModule
onready var submodules = []

export var test_mode = false


signal tut_option_selected

#Skills
var skill_source
var skill_target
var chars_for_skill = []

# Travels
var travels_defaults = {code = 'default'}
var selected_travel_characters = []
var is_travel_selected
var selected_destination
var selected_location


# Upgrades
var select_chars_mode = false
var selected_upgrade
var chars_for_upgrades = []

# Craft
var is_craft_selected = false
var selected_craft_task
var persons_for_craft = []
var craft_state = "default"

# Sex
var sex_participants = []


onready var active_person = ResourceScripts.game_party.get_master()
var hovered_person = null
var is_entered = false


var mansion_state = "" setget mansion_state_set
var mansion_prev_state


var prev_selected_travel

var always_show = [
	"TestButton",
	"MansionTaskInfoModule",
	"MansionClockModule",
	"MansionBottomLeftModule",
	"MansionSlaveModule",
	"MansionSlaveListModule",
	"MansionLogModule",
	"NavigationModule",
	"MenuButton",
]


func _ready():
	if test_mode:
		test_mode()
		mansion_state_set("default")
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
		show()
		input_handler.ActivateTutorial("introduction")
		var preset =  starting_presets.preset_data[ResourceScripts.game_globals.starting_preset]
		if preset.start in ['default','default_solo']:
			input_handler.interactive_message('intro', '', {})
		elif preset.start in ['skip_prologue']:
			input_handler.interactive_message('servants_election_finish6')
		globals.common_effects([{code = 'add_timed_event', value = 'aliron_exotic_trader', args = [{type = 'fixed_date', date = 7, hour = 6}]}])
		if preset.completed_quests.has("aliron_church_quest"):
			ResourceScripts.game_progress.unlocked_classes.append('healer')
		else:
			globals.common_effects([{code = 'add_timed_event', value = "ginny_visit", args = [{type = 'add_to_date', date = [5,10], hour = 8}]}])


		SlaveListModule.rebuild()
		SlaveListModule.build_locations_list()
		mansion_state_set("default")
	input_handler.CurrentScene = self
	input_handler.CurrentScreen = 'mansion'
	yield(get_tree(),'idle_frame')
	gui_controller.mansion = self
	gui_controller.current_screen = self
	gui_controller.clock = input_handler.get_spec_node(input_handler.NODE_CLOCK)
	$MenuButton.connect("pressed", self, "show_menu")
	$TutorialButton.connect('pressed', self, 'show_tutorial')
#	$tutorialpanel/Button.connect('pressed',$tutorialpanel,'hide')
	slave_list_manager()
	globals.log_node = $MansionLogModule
	input_handler.SetMusicRandom("mansion")
	$TestButton.connect('pressed',self,'test')
	SlaveListModule.update_dislocations()
	SlaveListModule.build_locations_list()
	if !ResourceScripts.game_progress.intro_tutorial_seen:
		$TutorialIntro.show()
	set_active_person(ResourceScripts.game_party.get_master())

func test():
	pass

func show_tutorial():
	if gui_controller.mansion_tutorial_panel == null:
		gui_controller.mansion_tutorial_panel = input_handler.get_spec_node(input_handler.NODE_TUTORIAL_PANEL)
	if !gui_controller.windows_opened.has(gui_controller.mansion_tutorial_panel):
		gui_controller.windows_opened.append(gui_controller.mansion_tutorial_panel)
	gui_controller.mansion_tutorial_panel.open()
	gui_controller.mansion_tutorial_panel.raise()

func show_menu():
	gui_controller.game_menu = input_handler.get_spec_node(input_handler.NODE_GAMEMENU)
	gui_controller.game_menu.show()
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.game_menu
	gui_controller.update_modules()


func set_active_person(person):
	input_handler.interacted_character = person
	active_person = input_handler.interacted_character
	SlaveListModule.prev_selected_location = SlaveListModule.selected_location
	slave_list_manager()

func mansion_state_set(state):
	# input_handler.CurrentScene = self
	if state == mansion_state: return
	mansion_prev_state = mansion_state
	mansion_state = state
	match_state()
	slave_list_manager()
	get_node("TutorialButton").show()

func reset_vars():
#	input_handler.interacted_character = null
#	SlaveListModule.active_person = null
#	SlaveModule.person = null
	if mansion_state != mansion_prev_state:
		select_chars_mode = false
		selected_upgrade = null
		chars_for_upgrades.clear()
		submodules.clear()
	if active_person == null:
		active_person = ResourceScripts.game_party.get_master()
	Journal.hide()

# Handles Resizing and visibility
func match_state():
	if gui_controller.clock != null:
		gui_controller.clock.show()
		gui_controller.clock.raise()
	gui_controller.nav_panel = $NavigationModule
	gui_controller.nav_panel.build_accessible_locations()
	Journal.visible = MenuModule.get_node("VBoxContainer/Journal").is_pressed()
	for node in get_children():
		if node.get_class() == "Tween":
			continue
		if node.name.findn(mansion_state) == -1 && ! node.name in always_show:
			node.hide()
	var menu_buttons = MenuModule.get_node("VBoxContainer")
	for button in menu_buttons.get_children():
		button.pressed = false
	match mansion_state:
		"default":
			reset_vars()
			SlaveListModule.show()
			$MansionSlaveListModule.set_size(Vector2(1100, 845))
			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(1004, 620))
			# SlaveListModule.get_node("Background").set_size(Vector2(1100, 845))
			$MansionSkillsModule.show()
			if mansion_state != mansion_prev_state && mansion_prev_state != "skill":
				ResourceScripts.core_animations.UnfadeAnimation($MansionSkillsModule, 0.3)
				ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
				$MansionJobModule2.close_job_pannel()
				
				
		"skill":
			$MansionSlaveListModule.show()
			$MansionSlaveListModule.set_size(Vector2(1100, 845))
			# SlaveListModule.get_node("Background").set_size(Vector2(1100, 845))
			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(1004, 620))
			$MansionSlaveListModule.rebuild()
			if mansion_state != mansion_prev_state:
				ResourceScripts.core_animations.UnfadeAnimation($MansionSkillsModule, 0.3)
				ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
				$MansionJobModule2.close_job_pannel()
		"travels":
			$TravelsModule.show()
#			$MansionTravelsModule.show()
#			$MansionSlaveListModule.set_size(Vector2(1100, 580))
#			SlaveListModule.get_node("Background").set_size(Vector2(1100, 580))
#			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(1004, 360))
#			travels_manager(travels_defaults)
#			menu_buttons.get_node("TravelsButton").pressed = true
			if mansion_state != mansion_prev_state:
				ResourceScripts.core_animations.UnfadeAnimation($TravelsModule, 0.3)
#				ResourceScripts.core_animations.UnfadeAnimation($SlaveListModule, 0.3)
			else:
				$TravelsModule.update_lists()
		"upgrades":
			UpgradesModule_.show()
			if mansion_state != mansion_prev_state:
				ResourceScripts.core_animations.UnfadeAnimation(UpgradesModule_, 0.3)
#			$MansionUpgradesModule.show()
#			$MansionUpgradesModule.open()
#			$MansionUpgradesModule.open_queue()
#			$MansionSlaveListModule.set_size(Vector2(1100, 580))
#			SlaveListModule.get_node("Background").set_size(Vector2(1100, 580))
#			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(1004, 360))
#			menu_buttons.get_node("UpgradesButton").pressed = true
#			SlaveListModule.rebuild()
#			if mansion_state != mansion_prev_state:
#				ResourceScripts.core_animations.UnfadeAnimation($MansionUpgradesModule, 0.3)
#				ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
		"occupation":
			$MansionSlaveListModule.rebuild()
			$MansionJobModule.show()
			$MansionSlaveListModule.set_size(Vector2(1100, 580))
			SlaveListModule.get_node("Background").set_size(Vector2(1100, 580))
			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(1004, 360))
			# $MansionSlaveListModule/ScrollContainer.set_size($MansionSlaveListModule/ScrollContainer/VBoxContainer.get_size())
			$MansionJobModule.cancel_job_choice()
			if mansion_state != mansion_prev_state:
				ResourceScripts.core_animations.UnfadeAnimation($MansionJobModule, 0.3)
				ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
		"char_info":
			open_char_info()
		"craft":
			craft_handler()
			menu_buttons.get_node("CraftButton").pressed = true
		"sex":
			SlaveListModule.show()
			$MansionSlaveListModule.set_size(Vector2(1100, 845))
			SlaveListModule.get_node("Background").set_size(Vector2(1100, 845))
			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(1004, 650))
			if mansion_state != mansion_prev_state:
				ResourceScripts.core_animations.UnfadeAnimation(SexSelect, 0.3)
				ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
			SexSelect.show()
			sex_handler()
			menu_buttons.get_node("SexButton").pressed = true

	rebuild_task_info()
	SlaveListModule.set_hover_area()

func open_char_info():
	gui_controller.slavepanel = input_handler.get_spec_node(input_handler.NODE_SLAVEMODULE)
	gui_controller.slavepanel.set_state("default")
	gui_controller.slavepanel.SummaryModule.show_summary()
	gui_controller.slavepanel.show()
	#gui_controller.slavepanel.update()
	gui_controller.previous_screen = gui_controller.mansion
	gui_controller.previous_screen.hide()
	gui_controller.current_screen = gui_controller.slavepanel
	gui_controller.close_all_closeable_windows()
	gui_controller.emit_signal("screen_changed")
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.slavepanel, 0.3)

func rebuild_mansion():
	$MansionSlaveListModule.update()
	$MansionSkillsModule.build_skill_panel()
	CraftModule.rebuild_scheldue()
	UpgradesModule.open_queue()
	SlaveModule.show_slave_info()
	$TutorialButton.show()

func rebuild_task_info():
	var char_on_quest = false
	for ch in ResourceScripts.game_party.characters.values():
		if ch.is_on_quest():
			char_on_quest = true
			break
	if ResourceScripts.game_party.active_tasks.empty() && !char_on_quest:
		TaskModule.visible = false
		if TaskModule.is_visible():
			ResourceScripts.core_animations.FadeAnimation(TaskModule, 0.3)
		return
	for i in ResourceScripts.game_party.active_tasks:
		if !i.workers.empty() || char_on_quest:
			if !TaskModule.is_visible():
				ResourceScripts.core_animations.UnfadeAnimation(TaskModule, 0.3)
			TaskModule.visible = true
			break
		else:
			TaskModule.visible = false
			if TaskModule.is_visible():
				ResourceScripts.core_animations.FadeAnimation(TaskModule, 0.3)
	TaskModule.show_task_info()

### State Managers ###
# Action Handlers for Modules
func sex_handler():
	if mansion_prev_state != mansion_state:
		active_person = null
		sex_participants.clear()
		mansion_prev_state = mansion_state


func craft_handler():
	match craft_state:
		"default":
			selected_craft_task = null
			# is_craft_selected = false
			CraftModule.open()
			CraftModule.get_node("MaterialSetupPanel").hide()
			CraftModule.update()
			# CraftModule.get_node("filter").hide()
			ResourceScripts.core_animations.UnfadeAnimation(CraftModule, 0.3)
			ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
		"confirm":
			$MansionSlaveListModule.set_size(Vector2(1100, 580))
			SlaveListModule.get_node("Background").set_size(Vector2(1100, 580))
			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(871, 300))
			ResourceScripts.core_animations.FadeAnimation(CraftModule, 0.3)
			CraftModule.hide()
			CraftSmallModule.update()
			CraftSmallModule.show()
			SlaveListModule.rebuild()
			ResourceScripts.core_animations.UnfadeAnimation(CraftSmallModule, 0.3)
			ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)


func travels_manager(params):
	TravelsModule.open_character_dislocation()
	match params.code:
		'default':
			is_travel_selected = false
			selected_destination = null
			Locations.show()
			selected_travel_characters.clear()
			TravelsModule.get_node("Resources").hide()
			TravelsModule.get_node("SelectedLocation/Label").text = "Select Location"
			TravelsModule.get_node("LocationListButton").pressed = Locations.is_visible()
			TravelsModule.update_character_dislocation()
			# SlaveListModule.rebuild()
		'destination_selected':
			is_travel_selected = true
			selected_travel_characters.clear()
			selected_destination = params.destination
			TravelsModule.update_character_dislocation()
			SlaveListModule.rebuild()
#			TravelsModule.update_buttons()

func upgrades_manager():
	SlaveListModule.rebuild()

func skill_manager():
	mansion_state = "skill"
	SlaveListModule.rebuild()

func slave_list_manager():
	match mansion_state:
		'default':
			if mansion_prev_state == "skill" || mansion_prev_state == "sex":
				mansion_prev_state = null
				active_person = skill_source
				hovered_person = null
			else:
				skill_source = active_person
			SkillModule.build_skill_panel()
			SlaveListModule.rebuild()
			SlaveModule.show_slave_info()
		'skill':
			if active_person.is_on_quest():
				return
			if active_person in chars_for_skill:
				SkillModule.use_skill(active_person)
			set_active_person(skill_source)
			SkillModule.build_skill_panel()
			SlaveListModule.rebuild()
		'travels':
			if is_travel_selected:
				if active_person in selected_travel_characters:
					self.selected_travel_characters.erase(active_person)
				else:
					self.selected_travel_characters.append(active_person)
				TravelsModule.update_character_dislocation()
			SlaveListModule.rebuild()
#			TravelsModule.update_buttons()
		'upgrades':
			if !select_chars_mode:
				SlaveModule.show_slave_info()
				SlaveListModule.rebuild()
				return
			if chars_for_upgrades.has(active_person):
				chars_for_upgrades.erase(active_person)
			else:
				chars_for_upgrades.append(active_person)
			SlaveListModule.rebuild()
			UpgradesModule.open_queue()
		'occupation':
			#$MansionSlaveListModule.rebuild()
			$MansionJobModule.open_jobs_window()
		'craft':
			if active_person == null:
				set_active_person(SlaveListModule.visible_persons[0])
			if (active_person.get_location() == ResourceScripts.game_world.mansion_location) && !active_person in persons_for_craft:
				persons_for_craft.append(active_person)
			else:
				persons_for_craft.erase(active_person)
			SlaveListModule.rebuild()
			CraftSmallModule.update()
		'sex':
			if !sex_participants.has(active_person) && active_person != null:
				sex_participants.append(active_person)
			else:
				sex_participants.erase(active_person)
			SlaveListModule.rebuild()
			update_sex_date_buttons()
	SlaveModule.show_slave_info()

func update_sex_date_buttons():
	if ResourceScripts.game_progress.unlimited_date_sex:
		if sex_participants.has(ResourceScripts.game_party.get_master()):
			SexSelect.get_node("DateButton").disabled = true
		else:
			SexSelect.get_node("DateButton").disabled = false
		SexSelect.get_node("SexButton").disabled = false
	if ResourceScripts.game_globals.daily_sex_left > 0:
		SexSelect.get_node("SexButton").disabled = sex_participants.size() < 2 || sex_participants.size() > SlaveListModule.limit
	else:
		SexSelect.get_node("SexButton").disabled = true

	for i in sex_participants:
		if i.tags.has("no_sex"):
			SexSelect.get_node("SexButton").disabled = true
	for i in sex_participants:
		if i.tags.has("no_date"):
			SexSelect.get_node("DateButton").disabled = true

	SexSelect.get_node("DateButton").disabled = (
		sex_participants.size() > 1
		|| sex_participants.size() == 0
		|| sex_participants.has(ResourceScripts.game_party.get_master())
		|| ResourceScripts.game_globals.daily_dates_left <= 0
		|| ResourceScripts.game_party.get_master().travel.location != ResourceScripts.game_world.mansion_location
	)

func set_hovered_person(node, person):
	hovered_person = person
	SlaveModule.show_slave_info()

func remove_hovered_person():
	if SlaveListModule.is_in_area():
		return
	hovered_person = null
	SlaveModule.show_slave_info()


func _on_TestButton_pressed():
	# print(ResourceScripts.game_progress.seen_dialogues)
	print(active_person.is_on_quest())
	# print(Traitdata.get_tat_list_for_slot("arms"))
#	get_node("DisassembleModule").build_list()
#	get_node("DisassembleModule").show()


func test_mode():
	ResourceScripts.game_progress.allow_skip_fights = true
	variables.allow_remote_intereaction = true
	ResourceScripts.game_world.make_world()
	if true:
		var character = ResourceScripts.scriptdict.class_slave.new("test_main")
		character.create('Human', 'female', 'random')
		character.unlock_class("master")
		characters_pool.move_to_state(character.id)
		ResourceScripts.game_res.upgrades.resource_gather_veges = 1
		ResourceScripts.game_res.upgrades.resource_gather_grain = 1
		ResourceScripts.game_res.upgrades.resource_gather_cloth = 1
		ResourceScripts.game_res.upgrades.resource_gather_iron = 1
		ResourceScripts.game_res.upgrades.resource_gather_mithril = 1
		ResourceScripts.game_res.upgrades.resource_gather_wood = 1
		ResourceScripts.game_res.upgrades.resource_gather_wood_magic = 1
		ResourceScripts.game_res.upgrades.resource_gather_wood_iron = 1
		ResourceScripts.game_res.upgrades.resource_gather_stone = 1
		ResourceScripts.game_res.upgrades.resource_gather_obsidian = 1
		ResourceScripts.game_res.upgrades.resource_gather_cloth_silk = 1
		ResourceScripts.game_res.upgrades.alchemy = 3
		ResourceScripts.game_res.upgrades.tailor = 3
#		ResourceScripts.game_res.upgrades.luxury_rooms = 1
#		ResourceScripts.game_res.upgrades.forge = 3
		ResourceScripts.game_res.upgrades.resting = 1
		ResourceScripts.game_res.upgrades.buildertools = 3
#		ResourceScripts.game_res.upgrades.tattoo_set = 1
		var item = globals.CreateGearItem("strapon", {})
		globals.AddItemToInventory(item)
		character.equip(item)
	#	character.get_stat('pregnancy', true).duration = 2
		character.add_stat('charm', 100)
	#	character.add_stat('wits', 100)
		character.add_stat('hpmax', 100)
		character.set_stat('hair_length','bald')
		character.set_stat('wits_factor', 5)
		character.unlock_class("master")
		character.unlock_class("worker")
		character.unlock_class("apprentice")
#		character.unlock_class("assassin")
		character.unlock_class("caster")
		# character.unlock_class("ruler")
		# character.unlock_class("watchdog")
		# character.unlock_class("director")
		# character.unlock_class("trainer")
		# character.unlock_class("thief")
		# character.unlock_class("engineer")
		# character.unlock_class("scholar")
		# character.travel.location = 'L4'
		character.travel.area = 'plains'
		character.add_stat('resist_normal', 50)
		character.add_stat('resist_all', 50)
		#variables.dungeon_encounter_chance = 1
		var bow = globals.CreateGearItem("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'})
		globals.AddItemToInventory(bow)
		character.equip(bow)
		character.set_slave_category('master')
		character.statlist.negative_sex_traits = {dislike_missionary = true}
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
		character.set_stat('sexuals_factor', 5)
		#character.set_stat('wits_factor', 5)
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
		#character.get_stat('pregnancy').duration = 10
		#globals.common_effects([{code = 'unlock_class', name = 'healer', operant = 'eq', value = true}])
		character = ResourceScripts.scriptdict.class_slave.new("test_main")
		character.create('Elf', 'male', 'random')
		character.set_stat("penis_virgin", false)
		character.set_stat('consent', 100)
		# character.assign_to_quest_and_make_unavalible()
		characters_pool.move_to_state(character.id)
		#character.unlock_class("attendant")
		character.add_trait('core_trait')
		character.set_slave_category('servant')
		character.set_stat('obedience', 0)
		character.set_stat('tame_factor', 6)
		character.set_stat('lust', 50)
		character.set_stat('charm_factor', 2)
		character.is_players_character = true
#		character = ResourceScripts.scriptdict.class_slave.new("test_main")
#		character.create('HalfkinCat', 'random', 'random')
#		characters_pool.move_to_state(character.id)
#		character = ResourceScripts.scriptdict.class_slave.new("test_main")
#		character.create('HalfkinCat', 'random', 'random')
#		characters_pool.move_to_state(character.id)
#		character = ResourceScripts.scriptdict.class_slave.new("test_main")
#		character.create('HalfkinCat', 'random', 'random')
#		characters_pool.move_to_state(character.id)
#		character = ResourceScripts.scriptdict.class_slave.new("test_main")
#		character.create('HalfkinCat', 'random', 'random')
#		characters_pool.move_to_state(character.id)
#		character = ResourceScripts.scriptdict.class_slave.new("test_main")
#		character.create('HalfkinCat', 'random', 'random')
#		characters_pool.move_to_state(character.id)
#		character = ResourceScripts.scriptdict.class_slave.new("test_main")
#		character.create('HalfkinCat', 'random', 'random')
#		characters_pool.move_to_state(character.id)
#		character = ResourceScripts.scriptdict.class_slave.new("test_main")
#		character.create('HalfkinCat', 'random', 'random')
#		characters_pool.move_to_state(character.id)
#		character = ResourceScripts.scriptdict.class_slave.new("test_main")
#		character.create('HalfkinCat', 'random', 'random')
#		characters_pool.move_to_state(character.id)
#		character = ResourceScripts.scriptdict.class_slave.new("test_main")
#		character.create('HalfkinCat', 'random', 'random')
#		characters_pool.move_to_state(character.id)
#		character = ResourceScripts.scriptdict.class_slave.new("test_main")
#		character.create('HalfkinCat', 'random', 'random')
#		characters_pool.move_to_state(character.id)
#		character = ResourceScripts.scriptdict.class_slave.new("test_main")
#		character.create('HalfkinCat', 'random', 'random')
#		characters_pool.move_to_state(character.id)

		ResourceScripts.game_globals.date = 7
		ResourceScripts.game_globals.hour = 8

		character.set_stat('obedience', 0)
		#character.fear = 25
		#character.base_exp = 99
		character.set_stat('charm_factor', 5)
		character.set_stat('physics_factor', 5)
		character.set_stat('wits_factor', 5)
		character.set_stat('sexuals_factor', 5)
		character.set_stat('charm', 100)
		character.set_stat('physics', 100)
		character.set_stat('consent', 100)

		var character2 = ResourceScripts.scriptdict.class_slave.new("test_main")
		character.set_stat('food_love', "meat")
		character.set_stat('food_hate', ["grain"])
		character2.create('Elf', 'random', 'random')
		character2.set_stat('charm', 0)
		character2.set_stat('physics', 0)
		character2.set_stat('wits', 0)
		character2.set_stat('sexuals', 0)
		var text = ''
#		for i in races.tasklist.values():
#			for k in i.production.values():
#				var value = character.get_progress_task(i.code, k.code, true) / k.progress_per_item
#				if Items.materiallist.has(k.item):
#					pass
#
#				else:
#					pass

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

		character.set_stat('loyalty', 100)
		character.set_stat('authority', 100)
		character.set_stat('submission', 95)
		yield(get_tree(),'idle_frame')
		character.xp_module.base_exp = 1000
		character.mp = 10
		character.hp = 95
		#character.exhaustion = 1000
		character.add_trait('core_trait')
		character.set_slave_category('slave')
		character.add_stat('lust', 100)
		character.set_stat("tame_factor", 1)
		#character.unlock_class("dancer")
		character.is_players_character = true
		character.statlist.tattoo.face = 'ink_makeup'
		# character.assign_to_quest_and_make_unavalible()

		globals.common_effects(
			[
				{code = 'make_story_character', value = 'Daisy'},
				{
					code = 'unique_character_changes',
					value = 'daisy',
					args = [
						{code = 'sexuals_factor', value = 1, operant = "+"},
						{code = 'submission', operant = '+', value = 50},
						{code = 'sex_skills_petting', operant = '+', value = 75},
					]
				}
			]
		)

		globals.common_effects(
			[
				{code = 'make_story_character', value = 'Aire'},
			]
		)
		globals.common_effects(
			[
				{code = 'make_story_character', value = 'Anastasia'},
			]
		)
		globals.common_effects(
			[
				{code = 'make_story_character', value = 'Zephyra'},
			]
		)
		globals.common_effects(
			[
				{code = 'affect_unique_character', name = 'Zephyra', type = 'set_availability', value = false},
			]
		)

		ResourceScripts.game_res.money = 80000
		#globals.common_effects("add_money")
		for i in Items.materiallist:
			ResourceScripts.game_res.materials[i] = 1899
		globals.AddItemToInventory(globals.CreateGearItem("anastasia_bracelet", {}))
		globals.AddItemToInventory(globals.CreateGearItem("daisy_dress", {}))
		globals.AddItemToInventory(globals.CreateGearItem("animal_gloves", {}))
		globals.AddItemToInventory(globals.CreateGearItem("pet_suit", {}))
		globals.AddItemToInventory(globals.CreateGearItem("tail_plug", {}))
		globals.AddItemToInventory(globals.CreateGearItem("maid_dress", {}))
		globals.AddItemToInventory(globals.CreateGearItem("craftsman_suit", {}))
		globals.AddItemToInventory(globals.CreateGearItem("animal_gloves", {}))
		globals.AddItemToInventory(globals.CreateGearItem("lacy_underwear", {}))
		globals.AddItemToInventory(globals.CreateGearItem("seethrough_underwear", {}))
		globals.AddItemToInventory(globals.CreateGearItem("gauntlets", {}))
		globals.AddItemToInventory(globals.CreateUsableItem("sensitivity_pot"))
		globals.AddItemToInventory(globals.CreateUsableItem("exp_scroll", 4))
		globals.AddItemToInventory(globals.CreateUsableItem("writ_of_exemption", 3))
		globals.AddItemToInventory(globals.CreateUsableItem("sparklingpowder", 5))
		globals.AddItemToInventory(globals.CreateUsableItem("energyshard", 2))
		globals.AddItemToInventory(globals.CreateUsableItem("strong_pheromones", 3))
		globals.AddItemToInventory(globals.CreateUsableItem("majorus_potion", 3))
		globals.AddItemToInventory(globals.CreateUsableItem("oblivion_potion", 3))
		globals.AddItemToInventory(
			globals.CreateGearItem("axe", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
		)
		globals.AddItemToInventory(globals.CreateGearItem("club", {WeaponMace = 'stone'}))
		globals.AddItemToInventory(
			globals.CreateGearItem("dagger", {WeaponHandle = 'wood', Blade = 'obsidian'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItem("pickaxe", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItem("swordadv", {Blade = 'mithril', WeaponHandle = 'wood', WeaponEnc = 'fire_ruby'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItem("club", {WeaponMace = 'wood'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItem("club", {WeaponMace = 'stone'})
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
		print(ResourceScripts.game_party.calculate_food_consumption())
		# ResourceScripts.game_progress.show_tutorial = true
		# ResourceScripts.game_progress.active_quests.append(
		# 	{code = 'aliron_church_quest', stage = 'start'}
		# )
#		globals.common_effects(
#			[
#				{code = "make_loot", pool = [['hard_boss_chest',1]]},
#				{code = 'open_loot'}
#			]
#		)

		character.mp = 10
		var tmp = {}
		tmp.oral = 70
		tmp.anal = 90
		tmp.petting = 100
		#character.set_stat('sex_skills', tmp)
		input_handler.active_location = ResourceScripts.game_world.areas.plains.locations[ResourceScripts.game_world.areas.plains.locations.keys()[4]]  #[state.areas.plains.locations.size()-1]]
		input_handler.active_area = ResourceScripts.game_world.areas.plains
		#for i in ResourceScripts.game_world.areas['plains'].locations.values():
			#if i.classname == 'settlement_plains1'.to_upper(): # SETTLEMENT_PLAINS1
				#i.captured = true


#		var newslave = ResourceScripts.scriptdict.class_slave.new()
#		newslave.generate_predescribed_character(worlddata.pregen_characters["Zephyra"])
#		newslave.set_slave_category('servant')
#		ResourceScripts.game_party.add_slave(newslave)



#		ResourceScripts.game_res.materials.meat = 0
#		input_handler.interactive_message('celena_shrine_find', '', {})
#		input_handler.interactive_message('daisy_admirer_first_event_1', '', {})
		input_handler.interactive_message('daisy_dress_acquired_normal_1', '', {})
		#ResourceScripts.gallery.play_scene(0)

#		input_handler.interactive_message('princess_recriut_intermission_3', '', {})
		#globals.common_effects([{code = 'progress_quest', value = 'princess_search', stage = 'stage2'}])
		#ResourceScripts.game_progress.decisions.append("interrogation_success")

		#globals.common_effects([{code = 'progress_quest', value = 'civil_war_start', stage = 'stage4'}])
		#ResourceScripts.game_progress.decisions.append("fred_bribe_taken")

		for i in ResourceScripts.game_world.areas.plains.factions.values():
			i.reputation = 500
			i.totalreputation += 5000
		# globals.common_effects([{code = 'progress_quest', value = 'mages_election_quest', stage = 'start'}])
		# globals.common_effects([{code = 'reputation', name = 'fighters', operant = '+', value = 100}])

#		character = ResourceScripts.scriptdict.class_slave.new()
		yield(get_tree(), 'idle_frame')
		input_handler.add_random_chat_message(character2, 'hire')
		
