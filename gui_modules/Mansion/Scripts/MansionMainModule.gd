extends Control

# VARIABLES
# Modules
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
onready var JobModule = $MansionJobModule2
onready var SexSelect = $MansionSexSelectionModule
onready var Journal = $MansionJournalModule
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
	"BGHolder",
	"TestButton",
	"MansionTaskInfoModule",
	"MansionClockModule",
	"MansionBottomLeftModule",
	"MansionSlaveModule",
	"MansionSlaveListModule",
	"MansionLogModule",
	"NavigationModule",
	"MenuButton",
	"map_test"
]


func _ready():
#	input_handler.CurrentScene = self
	if test_mode:
		modding_core.handle_test_mode()
		test_mode()
		mansion_state_set("default")
	add_season_events()
	var is_new_game = false
#	globals.connect('slave_arrived', $NavigationModule, "build_accessible_locations")
#	globals.connect('slave_departed', $NavigationModule, "build_accessible_locations")
	if globals.start_new_game == true:
		if gui_controller.clock != null:
			gui_controller.clock.hide()
		globals.start_new_game = false
		self.visible = false
		is_new_game = true
		var newgame_node = Node.new()
#		add_child(newgame_node)
		newgame_node.set_script(ResourceScripts.scriptdict.gamestart)
		newgame_node.start()
		input_handler.GameStartNode = newgame_node
		yield(input_handler, "StartingSequenceComplete")
		input_handler.GameStartNode.queue_free()
		show()
		input_handler.ActivateTutorial("introduction")
		globals.apply_starting_preset()
		
		ResourceScripts.game_globals.reset_limits()
		SlaveListModule.rebuild()
		SlaveListModule.build_locations_list()
		mansion_state_set("default")
#		remove_child(newgame_node)
	
	input_handler.CurrentScreen = 'mansion'
	gui_controller.mansion = self
	gui_controller.current_screen = self
	yield(get_tree(),'idle_frame')
	gui_controller.clock = input_handler.get_spec_node(input_handler.NODE_CLOCK)
	gui_controller.clock.show()
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





func add_season_events():
#	if test_mode == true:
#		return
	var date = OS.get_date().day + OS.get_date().month * 30
	if OS.get_date().month == 1:
		date = OS.get_date().day + 13 * 30
	for i in scenedata.season_events_range.values():
		
		# removing all season events from timed_events
		var to_rem = []
		for e in ResourceScripts.game_progress.stored_events.timed_events:
			if e.code == i.event:
				to_rem.append(e)
		for r in to_rem:
			ResourceScripts.game_progress.stored_events.timed_events.erase(r)
		
		if !ResourceScripts.game_progress.seen_events.has(i.event) && date >= i.start[0] + i.start[1]*30 && date <= i.end[0] + i.end[1]*30:
			globals.common_effects([{code = 'add_timed_event', value = i.event, args = [{type = 'add_to_date', date = [1,1], hour = 1}]}])

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


func hide():
	.hide()
	mansion_state_set("hidden")


func mansion_state_set(state):
	# input_handler.CurrentScene = self
	if state == mansion_state:
		return
	if mansion_state != 'hidden': mansion_prev_state = mansion_state
	mansion_state = state
	if mansion_state == 'hidden': return
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
func handle_test():
	for nd in get_tree().get_nodes_in_group('test'):
		nd.visible = test_mode
	for nd in get_tree().get_nodes_in_group('test_obsolete'):
		nd.visible = false


func match_state():
	handle_test()
	if gui_controller.clock != null and visible and mansion_state != 'craft':
		gui_controller.clock.show()
		gui_controller.clock.raise()
	gui_controller.nav_panel = $NavigationModule
	gui_controller.nav_panel.build_accessible_locations()
	Journal.visible = MenuModule.get_node("VBoxContainer/Journal").is_pressed()
	for node in get_children():
		if node.get_class() == "Tween":
			continue
		if node.name.findn(mansion_state) == -1 and ! node.name in always_show:
			node.hide()
	var menu_buttons = MenuModule.get_node("VBoxContainer")
	for button in menu_buttons.get_children():
		button.pressed = false
	match mansion_state:
		"default":
			reset_vars()
			SlaveListModule.show()
			$MansionSlaveListModule.set_size(Vector2(1100, 845))
			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(1004, 700))
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
			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(1004, 700))
			$MansionSlaveListModule.rebuild()
			if mansion_state != mansion_prev_state:
				ResourceScripts.core_animations.UnfadeAnimation($MansionSkillsModule, 0.3)
				ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
				$MansionJobModule2.close_job_pannel()
		"travels":
			$map.open()
#			$TravelsModule.show()
#			$MansionTravelsModule.show()
#			$MansionSlaveListModule.set_size(Vector2(1100, 580))
#			SlaveListModule.get_node("Background").set_size(Vector2(1100, 580))
#			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(1004, 360))
#			travels_manager(travels_defaults)
#			menu_buttons.get_node("TravelsButton").pressed = true
#			if mansion_state != mansion_prev_state:
#				ResourceScripts.core_animations.UnfadeAnimation($TravelsModule, 0.3)
##				ResourceScripts.core_animations.UnfadeAnimation($SlaveListModule, 0.3)
#			else:
#				$TravelsModule.update_lists()
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
#			$MansionJobModule.show()
#			$MansionSlaveListModule.set_size(Vector2(1100, 580))
#			SlaveListModule.get_node("Background").set_size(Vector2(1100, 580))
#			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(1004, 360))
			# $MansionSlaveListModule/ScrollContainer.set_size($MansionSlaveListModule/ScrollContainer/VBoxContainer.get_size())
#			$MansionJobModule.cancel_job_choice()
			if mansion_state != mansion_prev_state:
				$MansionJobModule2.show()
				$MansionJobModule2.rebuild()
				ResourceScripts.core_animations.UnfadeAnimation($MansionJobModule2, 0.3)
				gui_controller.clock.hide()
				ResourceScripts.core_animations.FadeAnimation(gui_controller.clock, 0.3)
#				ResourceScripts.core_animations.UnfadeAnimation($MansionJobModule, 0.3)
#				ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
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


func open_char_info():
	gui_controller.slavepanel = input_handler.get_spec_node(input_handler.NODE_SLAVEMODULE)
	gui_controller.slavepanel.set_state("default")
	gui_controller.slavepanel.SummaryModule.show_summary()
	gui_controller.slavepanel.show()
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


#func travels_manager(params):
#	TravelsModule.open_character_dislocation()
#	match params.code:
#		'default':
#			is_travel_selected = false
#			selected_destination = null
#			Locations.show()
#			selected_travel_characters.clear()
#			TravelsModule.get_node("Resources").hide()
#			TravelsModule.get_node("SelectedLocation/Label").text = "Select Location"
#			TravelsModule.get_node("LocationListButton").pressed = Locations.is_visible()
#			TravelsModule.update_character_dislocation()
#			# SlaveListModule.rebuild()
#		'destination_selected':
#			is_travel_selected = true
#			selected_travel_characters.clear()
#			selected_destination = params.destination
#			TravelsModule.update_character_dislocation()
#			SlaveListModule.rebuild()
##			TravelsModule.update_buttons()

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
			#	TravelsModule.update_character_dislocation()
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
			pass
			#$MansionSlaveListModule.rebuild()
#			$MansionJobModule.open_jobs_window()
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
	SexSelect.get_node("SexButton").hint_tooltip = ""
	if ResourceScripts.game_progress.unlimited_date_sex:
		if sex_participants.has(ResourceScripts.game_party.get_master()):
			SexSelect.get_node("DateButton").disabled = true
		else:
			SexSelect.get_node("DateButton").disabled = false
		SexSelect.get_node("SexButton").disabled = false
	if ResourceScripts.game_globals.weekly_sex_left > 0:
		SexSelect.get_node("SexButton").disabled = sex_participants.size() < 2 || sex_participants.size() > SlaveListModule.limit
	else:
		SexSelect.get_node("SexButton").disabled = true
	
	for i in sex_participants:
		if i.has_status("no_sex"):
			SexSelect.get_node("SexButton").disabled = true
			SexSelect.get_node("SexButton").hint_tooltip = "One of unique characters has not proceeded their questline yet"
	
	if sex_participants.size() > 2 or sex_participants.size() == 0: 
		SexSelect.get_node("DateButton").disabled = true
	elif ResourceScripts.game_globals.weekly_dates_left <= 0: 
		SexSelect.get_node("DateButton").disabled = true
	elif ResourceScripts.game_party.get_master().travel.location != ResourceScripts.game_world.mansion_location: 
		SexSelect.get_node("DateButton").disabled = true
	elif sex_participants.size() > 1 and !sex_participants.has(ResourceScripts.game_party.get_master()):
		SexSelect.get_node("DateButton").disabled = true
	elif sex_participants.size() == 1 and sex_participants.has(ResourceScripts.game_party.get_master()):
		SexSelect.get_node("DateButton").disabled = true
	else:
		SexSelect.get_node("DateButton").disabled = false
	
	for i in sex_participants:
		if i.is_master(): continue
		if i.has_status("no_date") or !i.has_status("dating") or (i.tags.has("no_date_day") and !ResourceScripts.game_progress.unlimited_date_sex):
			SexSelect.get_node("DateButton").disabled = true

func set_hovered_person(node, person):
	hovered_person = person
	SlaveModule.show_slave_info()

func remove_hovered_person():
#	if SlaveListModule.is_in_area():
#		return
	hovered_person = null
	SlaveModule.show_slave_info()


func _on_TestButton_pressed():
	# print(ResourceScripts.game_progress.seen_dialogues)
	print(active_person.is_on_quest())
	# print(Traitdata.get_tat_list_for_slot("arms"))
#	get_node("DisassembleModule").build_list()
#	get_node("DisassembleModule").show()


func show_map():
	$map.open()


func test_mode():
	input_handler.CurrentScene = self
	gui_controller.mansion = self
	ResourceScripts.game_progress.allow_skip_fights = true
	variables.allow_remote_intereaction = true
	ResourceScripts.game_world.make_world()
	if true:
		ResourceScripts.game_progress.seen_dialogues.append("PRIESTESS_SWORD_TALK_1_1")
		ResourceScripts.game_progress.seen_dialogues.append("ALIRONCHURCHFIRSTCOME")
		var character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
		character.create('Orc', 'male', 'random')
		character.fill_boosters()
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
		ResourceScripts.game_res.upgrades.rooms = 5
		ResourceScripts.game_res.upgrades.forge = 3
		ResourceScripts.game_res.upgrades.resting = 1
		ResourceScripts.game_res.upgrades.buildertools = 3
		ResourceScripts.game_res.fix_tax()
		
#		ResourceScripts.game_res.upgrades.tattoo_set = 1
		var item = globals.CreateGearItem("strapon", {})
		globals.AddItemToInventory(item)
		character.equip(item)
	#	character.get_stat('pregnancy', true).duration = 2
		character.set_stat('charm', 100)
		character.set_stat('wits', 100)
	#	character.add_stat('wits', 100)
		character.add_stat('hpmax', 100)
		character.set_stat('eye_color','green')
		character.unlock_class("master")
		character.unlock_class("worker")
		character.unlock_class("apprentice")
#		character.unlock_class("assassin")
		character.unlock_class("rogue")
		character.set_stat('height', 'average')
		character.xp_module.base_exp = 1500
		character.add_stat('abil_exp', 1500)
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
		character.set_stat('personality_kind', 100)
		character.set_stat('personality_bold', 50)
		#variables.dungeon_encounter_chance = 1
		var bow = globals.CreateGearItemQuality("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'}, 'poor', false)
		globals.AddItemToInventory(bow)
		bow = globals.CreateGearItemQuality("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'}, 'average', false)
		globals.AddItemToInventory(bow)
		bow = globals.CreateGearItemQuality("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'}, 'legendary', false)
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
		character.get_random_traits()
		#character.armor = 135
		#character.set_stat('wits', 20)
		character.set_stat('consent', 5)
		character.set_stat('charm_factor', 2)
		character.set_stat('physics_factor', 6)
		character.set_stat('sexuals_factor', 6)
		#character.set_stat('wits_factor', 5)
		character.set_stat('food_love', "meat")
		character.set_stat('food_hate', ["grain"])
		character.set_stat('lactation', true)
		#character.unlock_class("worker")
		character.unlock_class("necromancer")
		character.hp = 1
	#		character.unlock_class("caster")
		for i in Skilldata.Skilllist:
			if Skilldata.Skilllist[i].type != 'social':
				continue
			character.skills.social_skills.append(i)
		character.is_players_character = true
#		globals.impregnate(character, character)
		character.get_stat('pregnancy', true).duration = 2
		#globals.common_effects([{code = 'unlock_class', name = 'healer', operant = 'eq', value = true}])
		character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
		character.create('Elf', 'male', 'random')
		character.fill_boosters()
		character.set_stat('height', 'tiny')
		character.set_stat('skin', 'grey')
		character.add_stat('loyalty', 95)
		characters_pool.move_to_state(character.id)
		character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
		character.create('Elf', 'female', 'random')
		character.fill_boosters()
		character.set_stat('height', 'petite')
		characters_pool.move_to_state(character.id)
		character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
		character.create('Elf', 'female', 'random')
		character.fill_boosters()
		character.set_stat('height', 'short')
		characters_pool.move_to_state(character.id)
		character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
		character.create('Goblin', 'female', 'random')
		character.fill_boosters()
		character.set_stat('height', 'average')
		character.set_slave_category('servant')
		characters_pool.move_to_state(character.id)
		character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
		character.create('Goblin', 'female', 'random')
		character.fill_boosters()
		character.set_stat('height', 'tall')
		characters_pool.move_to_state(character.id)
		character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
		character.create('Ratkin', 'female', 'random')
		character.fill_boosters()
		character.set_stat('height', 'towering')
		characters_pool.move_to_state(character.id)
		# character.assign_to_quest_and_make_unavalible()
		characters_pool.move_to_state(character.id)
		#character.unlock_class("attendant")
		character.add_trait('core_trait')
#		character.set_slave_category('heir')
#		character.set_stat('obedience', 0)
		character.set_stat('lust', 50)
		character.set_stat('charm_factor', 2)
		character.unlock_class("apprentice")
		character.get_random_traits()
		character.is_players_character = true

		ResourceScripts.game_globals.date = 7
		ResourceScripts.game_globals.hour = 1

#		character.set_stat('obedience', 50)
		character.unlock_class("apprentice")
		#character.fear = 25
		#character.base_exp = 99
		character.set_stat('charm_factor', 5)
		character.set_stat('physics_factor', 5)
		character.set_stat('wits_factor', 5)
		character.set_stat('sexuals_factor', 5)
		character.set_stat('charm', 100)
		character.set_stat('physics', 100)
		character.set_stat('wits', 100)
		character.set_stat('consent', 5)
		#globals.impregnate(ResourceScripts.game_party.get_master(), character)
		#character.get_stat('pregnancy', true).duration = 2
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

#		character.set_stat('loyalty', 100)
#		character.set_stat('authority', 100)
		character.add_stat('loyalty', 95)
		yield(get_tree(),'idle_frame')
		character.xp_module.base_exp = 1000
		character.mp = 10
		character.hp = 95
		#character.exhaustion = 1000
		character.add_trait('core_trait')
		character.add_stat('lust', 100)
		character.set_stat("tame_factor", 1)
		#character.unlock_class("dancer")
		character.is_players_character = true
		character.statlist.tattoo.face = 'ink_makeup'
#		character.affect_char({type = 'set_availability', value = false})
		
		#common_effects = [{code = 'affect_unique_character', name = 'daisy', type = 'remove_trait', value = 'coward'},
		#variables.no_obedience_drain = true
		globals.common_effects(
			[
				{code = 'make_story_character', value = 'Daisy'},
				{
					code = 'unique_character_changes',
					value = 'daisy',
					args = [
						{code = 'loyalty', value = 150, operant = "+"},
						{code = 'consent', value = 5, operant = "+"},
						{code = 'price', value = 3000, operant = "+"},
						{code = 'sexuals_factor', value = 2, operant = "+"},
						{code = 'growth_factor', value = 2, operant = "+"},
						{code = 'sex_skills_oral', operant = "+", value = 100},
						{code = 'sex_skills_petting', operant = "+", value = 100},
						{code = 'sex_skills_pussy', operant = "+", value = 100},
						{code = 'sex_skills_anal', operant = "+", value = 100},
						{code = 'add_trait', trait = 'loyalty_sex_basic'},
						{code = 'add_trait', trait = 'loyalty_sex_oral'},
						{code = 'add_trait', trait = 'loyalty_sex_anal'},
						{code = 'add_profession', profession = 'harlot'},
						{code = "add_trait", trait = 'loyalty_sex_basic'}
					]
				},
				{code = 'make_story_character', value = 'Cali'},
				{code = 'make_story_character', value = 'Aire'},
				{code = 'make_story_character', value = 'Jean'},
				{code = 'make_story_character', value = 'Zephyra'},
				{code = 'make_story_character', value = 'Anastasia'},
				{code = 'make_story_character', value = 'Lilia'},
				{code = 'affect_unique_character', name = 'lilia', type = 'turn_into_unique', value = 'Lilith'},
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
		globals.AddItemToInventory(globals.CreateGearItem("service_suit", {}))
		globals.AddItemToInventory(globals.CreateGearItem("cali_heirloom", {}))
		globals.AddItemToInventory(globals.CreateGearItem("craftsman_suit", {}))
		globals.AddItemToInventory(globals.CreateGearItem("leather_collar", {}))
		globals.AddItemToInventory(globals.CreateGearItem("lacy_underwear", {}))
		globals.AddItemToInventory(globals.CreateGearItem("seethrough_underwear", {}))
		globals.AddItemToInventory(globals.CreateGearItem("sacred_bowl", {}))
		globals.AddItemToInventory(globals.CreateUsableItem("zephyra_underwear"))
		globals.AddItemToInventory(globals.CreateUsableItem("map_bandit_fort", 4))
		globals.AddItemToInventory(globals.CreateUsableItem("writ_of_exemption", 3))
		globals.AddItemToInventory(globals.CreateUsableItem("soul_stone", 3))
		globals.AddItemToInventory(globals.CreateUsableItem("sparklingpowder", 5))
		globals.AddItemToInventory(globals.CreateUsableItem("energyshard", 2))
		globals.AddItemToInventory(globals.CreateUsableItem("strong_pheromones", 3))
		globals.AddItemToInventory(globals.CreateUsableItem("majorus_potion", 3))
		globals.AddItemToInventory(globals.CreateUsableItem("oblivion_potion", 3))
		globals.AddItemToInventory(globals.CreateUsableItem("hairdye", 3))
		globals.AddItemToInventory(
			globals.CreateGearItemShop("axe", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
		)
		globals.AddItemToInventory(globals.CreateGearItem("club", {WeaponMace = 'stone'}))
		globals.AddItemToInventory(
			globals.CreateGearItemShop("dagger", {WeaponHandle = 'wood', Blade = 'obsidian'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItemShop("pickaxe", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItemShop("staffadv", {Rod = 'mithril', WeaponHandle = 'wood', WeaponEnc = 'fire_ruby'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItemShop("club", {WeaponMace = 'wood'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItemShop("club", {WeaponMace = 'stone'})
		)

		globals.AddItemToInventory(
			globals.CreateGearItemShop("fishingtools", {ToolHandle = 'wood', ToolClothwork = 'cloth'})
		)

		globals.AddItemToInventory(
			globals.CreateGearItemShop("hunt_knife", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItemShop("legs_base_metal", {ArmorBaseHeavy = 'mithril', ArmorTrim = 'wood'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItemShop("chest_base_metal", {ArmorBaseHeavy = 'mithril', ArmorTrim = 'wood'})
		)
		globals.AddItemToInventory(
			globals.CreateGearItemShop(
				"chest_base_cloth", {ArmorBaseCloth = 'clothsilk', ArmorTrim = 'wood'}
			)
		)
		globals.AddItemToInventory(
			globals.CreateGearItemShop(
				"legs_base_cloth", {ArmorBaseCloth = 'clothsilk', ArmorTrim = 'wood'}
			)
		)
		# ResourceScripts.game_progress.show_tutorial = true
		ResourceScripts.game_progress.active_quests.append(
			{code = 'princess_search', stage = 'stage2'}
		)
#		globals.common_effects(
#			[
#				{code = "make_loot", pool = [['hard_boss_chest',1]]},
#				{code = 'open_loot'}
#			]
#		)

		character.mp = 10
		character.add_trait('talented')
		var tmp = {}
		tmp.oral = 70
		tmp.anal = 90
		tmp.petting = 100
		#character.set_stat('sex_skills', tmp)
#		yield(get_tree(),'idle_frame')
#		if gui_controller.exploration == null:
#			gui_controller.exploration = input_handler.get_spec_node(input_handler.NODE_EXPLORATION, null, false, false)
#		gui_controller.open_exploration('beastkin_capital')
#		gui_controller.mansion.hide()
#		gui_controller.exploration.open_city('beastkin_capital')
#		gui_controller.exploration.show()
#		gui_controller.nav_panel.select_location('beastkin_capital')
#		input_handler.active_location = ResourceScripts.game_world.areas.plains.locations[ResourceScripts.game_world.areas.plains.locations.keys()[4]]  #[state.areas.plains.locations.size()-1]]
#		input_handler.active_area = ResourceScripts.game_world.areas.plains
		#globals.common_effects([{code = 'update_city'},{code = 'make_quest_location', value = 'quest_erlen_location'}, ])
		#for i in ResourceScripts.game_world.areas['plains'].locations.values():
			#if i.classname == 'settlement_plains1'.to_upper(): # SETTLEMENT_PLAINS1
				#i.captured = true


#		var newslave = ResourceScripts.scriptdict.class_slave.new()
#		newslave.generate_predescribed_character(worlddata.pregen_characters["Zephyra"])
#		newslave.set_slave_category('servant')
#		ResourceScripts.game_party.add_slave(newslave)



#		ResourceScripts.game_res.materials.meat = 0
#		globals.common_effects([{code = 'progress_quest', value = 'election_global_quest', stage = 'stage1'}])

		
		#globals.common_effects([{code = 'progress_quest', value = 'daisy_clothes', stage = 'stage1'} ])
		ResourceScripts.game_progress.decisions.append("bracelet_found")
		input_handler.active_area = ResourceScripts.game_world.areas.plains

		input_handler.interactive_message('hybris_shrine_find', '', {})
#		input_handler.interactive_message('halloween_9', '', {})
#		input_handler.interactive_message('force_cali_6', '', {})
		#ResourceScripts.gallery.play_scene(0)
		
#		ResourceScripts.game_progress.decisions.append("mayor_election_finished")
		
		#never do this way - cause crash with oblivion potion!!!
#		ResourceScripts.game_party.get_master().xp_module.professions.append("rogue") 


		#ResourceScripts.game_progress.completed_quests.append("daisy_lost")
		ResourceScripts.game_progress.completed_quests.append("sword_artifact_quest")
#		input_handler.interactive_message('daisy_dress_acquired_lewd_3', '', {})

		#ResourceScripts.game_progress.decisions.append("fred_bribe_taken")
		
#		globals.common_effects([{code = 'add_timed_event', value = "aliron_exotic_trader", args = [{type = 'add_to_date', date = [1,1], hour = 1}]}])
#		globals.common_effects([{code = 'add_timed_event', value = "after_mines_message", args = [{type = 'add_to_date', date = [1,1], hour = 1}]}])
		
		for i in ResourceScripts.game_world.areas.plains.factions.values():
			i.reputation = 500
			i.totalreputation += 500
		# globals.common_effects([{code = 'progress_quest', value = 'mages_election_quest', stage = 'start'}])
		# globals.common_effects([{code = 'reputation', name = 'fighters', operant = '+', value = 100}])
		
		#example of special tasks adding
#		globals.common_effects(
#			[
#				{code = "add_special_task_for_location", location = 'aliron', amount = 5, desc = "TEST", name = "t1",
#				args = [{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage5'}]},
#				{code = "add_special_task_for_location", location = 'aliron', amount = 5, desc = "TEST2", name = "test", max_workers = 4, icon = 'res://assets/images/gui/explore/Captured Characters/icons/icon_quickly_sell.png', 
#				args = [{code = 'progress_quest', value = 'daisy_clothes', stage = 'stage1'}]},
#			]
#		)
		ResourceScripts.game_globals.reset_limits()
		yield(get_tree(), 'idle_frame')
		#input_handler.add_random_chat_message(character2, 'hire')
		
