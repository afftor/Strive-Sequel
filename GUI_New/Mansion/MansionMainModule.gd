extends Control

# VARIABLES
# Modules
onready var TravelsModule = $MansionTravelsModule
onready var SlaveListModule = $MansionSlaveListModule
onready var SkillModule = $MansionSkillsModule
onready var UpgradesModule = $MansionUpgradesModule
onready var SlaveModule = $MansionSlaveModule
onready var TaskModule = $MansionTaskInfoModule
onready var MenuModule = $MansionBottomLeftModule
onready var NavModule = $NavigationModule
onready var CraftModule = $MansionCraftModule
onready var CraftSmallModule = $MansionCraftSmallModule
onready var JobModule = $MansionJobModule
onready var SexSelect = $MansionSexSelectionModule
onready var Journal = $MansionJournalModule
onready var Locations = $MansionLocationsModule
onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)
onready var submodules = []

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


var mansion_state = "default" setget mansion_state_set
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
	# input_handler.CurrentScene = self
	# input_handler.CurrentScreen = 'mansion'
	GUIWorld.BaseScene == self
	$MenuButton.connect("pressed", self, "show_menu")
	$TutorialButton.connect('pressed', self, 'show_tutorial')
	$tutorialpanel/Button.connect('pressed',$tutorialpanel,'hide')
	slave_list_manager()
	match_state()
	globals.log_node = $MansionLogModule
	input_handler.SetMusicRandom("mansion")
#	if globals.start_new_game == true:
#		yield(input_handler, 'EventFinished')
#		input_handler.get_spec_node(input_handler.NODE_MANSION_NEW).show_tutorial()

func show_tutorial():
	$tutorialpanel.show()

func show_menu():
	GUIWorld.menu_opened = true
	GUIWorld.gui_data["GAMEMENU"].main_module.open()


func set_active_person(person):
	active_person = person
	SlaveListModule.prev_selected_location = SlaveListModule.selected_location
	slave_list_manager()

func mansion_state_set(state):
	# input_handler.CurrentScene = self
	mansion_prev_state = mansion_state
	mansion_state = state
	match_state()
	slave_list_manager()
	get_node("TutorialButton").show()

func reset_vars():
	if mansion_state != mansion_prev_state:
		select_chars_mode = false
		selected_upgrade = null
		chars_for_upgrades.clear()
		submodules.clear()
	if active_person == null:
		active_person = ResourceScripts.game_party.get_master()
	Journal.hide()
		# sex_participants.clear()

# Handles Resizing and visibility
func match_state():
	NavModule.build_accessible_locations()
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
			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(1004, 550))
			# SlaveListModule.get_node("Background").set_size(Vector2(1100, 845))
			$MansionSkillsModule.show()
			if mansion_state != mansion_prev_state:
				ResourceScripts.core_animations.UnfadeAnimation($MansionSkillsModule, 0.3)
				ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
		"skill":
			$MansionSlaveListModule.show()
			$MansionSlaveListModule.set_size(Vector2(1100, 845))
			# SlaveListModule.get_node("Background").set_size(Vector2(1100, 845))
			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(1004, 550))
			$MansionSlaveListModule.rebuild()
			if mansion_state != mansion_prev_state:
				ResourceScripts.core_animations.UnfadeAnimation($MansionSkillsModule, 0.3)
				ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
		"travels":
			$MansionTravelsModule.show()
			$MansionSlaveListModule.set_size(Vector2(1100, 580))
			SlaveListModule.get_node("Background").set_size(Vector2(1100, 580))
			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(1004, 300)) 
			travels_manager(travels_defaults)
			menu_buttons.get_node("TravelsButton").pressed = true
			if mansion_state != mansion_prev_state:
				ResourceScripts.core_animations.UnfadeAnimation($MansionTravelsModule, 0.3)
				ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
		"upgrades":
			$MansionUpgradesModule.show()
			$MansionUpgradesModule.open()
			$MansionUpgradesModule.open_queue()
			$MansionSlaveListModule.set_size(Vector2(1100, 580))
			SlaveListModule.get_node("Background").set_size(Vector2(1100, 580))
			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(871, 300))  
			menu_buttons.get_node("UpgradesButton").pressed = true
			SlaveListModule.rebuild()
			if mansion_state != mansion_prev_state:
				ResourceScripts.core_animations.UnfadeAnimation($MansionUpgradesModule, 0.3)
				ResourceScripts.core_animations.UnfadeAnimation($MansionSlaveListModule, 0.3)
		"occupation":
			$MansionSlaveListModule.rebuild()
			$MansionJobModule.show()
			$MansionSlaveListModule.set_size(Vector2(1100, 580))
			SlaveListModule.get_node("Background").set_size(Vector2(1100, 580))
			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(871, 300))
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
	var slave_info = GUIWorld.gui_data["SLAVE_INFO"].main_module
	GUIWorld.set_current_scene(slave_info)
	ResourceScripts.core_animations.UnfadeAnimation(slave_info, 0.3)

func rebuild_mansion():
	$MansionSlaveListModule.update()
	$MansionSkillsModule.build_skill_panel()
	CraftModule.rebuild_scheldue()
	UpgradesModule.open_queue()
	SlaveModule.show_slave_info()
	$TutorialButton.show()

func rebuild_task_info():
	if ResourceScripts.game_party.active_tasks == []:
		TaskModule.visible = false
		if TaskModule.is_visible():
			ResourceScripts.core_animations.FadeAnimation(TaskModule, 0.3)
		return
	for i in ResourceScripts.game_party.active_tasks:
		if i.workers != []:
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
			$MansionSlaveListModule.rebuild()
			$MansionJobModule.open_jobs_window()
		'craft':
			# if !is_craft_selected:
			# 	return
			if !active_person in persons_for_craft:
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
	if ResourceScripts.game_globals.daily_sex_left > 0:
		SexSelect.get_node("SexButton").disabled = sex_participants.size() < 2 || sex_participants.size() > SlaveListModule.limit
	else:
		SexSelect.get_node("SexButton").disabled = true
	
	SexSelect.get_node("DateButton").disabled = sex_participants.size() > 1 || sex_participants.size() == 0 || sex_participants.has(ResourceScripts.game_party.get_master()) || ResourceScripts.game_globals.daily_dates_left <= 0

func set_hovered_person(node, person):
	hovered_person = person
	SlaveModule.show_slave_info()

func remove_hovered_person():
	if SlaveListModule.is_in_area():
		return
	hovered_person = null
	SlaveModule.show_slave_info()


func _on_TestButton_pressed():
	Locations.show()
	Locations.open()
	input_handler.emit_signal("EnemyKilled","wolf")
	# print("LocaLinks:" +str(ResourceScripts.game_world.location_links))
	# for person in ResourceScripts.game_party.characters.values():
	# 	var loca = person.travel.location
	# 	print(loca)
	# var info = ResourceScripts.game_world.areas["plains"].keys()[11]
	# print(info)
	# for i in ResourceScripts.game_world.areas["plains"].keys():
	# 	if !i in ["locations"]:
	# 		continue
	# for l in ResourceScripts.game_world.areas.plains.locations.values():
	# 	print("-----------------------------------------------")
	# 	for i in l:
	# 		# var string = 
	# 		print(i, '--->', l[i])
	# 	print("-----------------------------------------------")

	# GUIWorld.set_current_scene(GUIWorld.gui_data["EXPLORATION"].main_module)
	# GUIWorld.gui_data["EXPLORATION"].main_module.open()
	# print("Craft State:" + str(craft_state))
	# print("Mansion State:" + str(mansion_state))
	# print("Active Task")
	# print(ResourceScripts.game_party.active_tasks) 
	# print("Upgrade Progresses")
	# print(ResourceScripts.game_res.upgrade_progresses)
	# print("Selected Upgrade:" + str(selected_upgrade))
	# print("Upgrades Queue:" + str(ResourceScripts.game_res.upgrades_queue))
	# print("Locations:" + str(ResourceScripts.game_world.areas))
