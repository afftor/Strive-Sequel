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
onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD)
onready var submodules = []

#Skills
var skill_source
var skill_target

# Travels
var travels_defaults = {code = 'default'}
var selected_travel_characters = []
var is_travel_selected
var selected_destination


# Upgrades
var is_upgrade_selected
var selected_upgrade

onready var active_person = ResourceScripts.game_party.get_master()
var hovered_person = null
var is_entered = false
var chars_for_skill = []

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
	"MansionLogModule"
]


func _ready():
	slave_list_manager()
	match_state()
	globals.log_node = $MansionLogModule


func set_active_person(person):
	active_person = person
	slave_list_manager()

func mansion_state_set(state):
	input_handler.CurrentScene = self
	mansion_prev_state = mansion_state
	mansion_state = state
	match_state()
	slave_list_manager()

func reset_vars():
	if mansion_state != mansion_prev_state:
		is_upgrade_selected = false
		selected_upgrade = null

# Handles Resizing and visibility
func match_state():
	for node in get_children():
		if node.name.findn(mansion_state) == -1 && ! node.name in always_show:
			node.hide()
	reset_vars()
	var menu_buttons = MenuModule.get_node("VBoxContainer")
	for button in menu_buttons.get_children():
		button.pressed = false
	match mansion_state:
		"default":
			SlaveListModule.show()
			$MansionSlaveListModule.set_size(Vector2(1100, 845))
			SlaveListModule.get_node("Background").set_size(Vector2(1100, 845))
			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(871, 480))
			$MansionSkillsModule.show()
		"skill":
			$MansionSlaveListModule.show()
			$MansionSlaveListModule.rebuild()
		"travels":
			$MansionTravelsModule.show()
			$MansionSlaveListModule.set_size(Vector2(1100, 580))
			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(871, 480))  # Needs to be checked with new assets
			travels_manager(travels_defaults)
			menu_buttons.get_node("TravelsButton").pressed = true
		"upgrades":
			$MansionUpgradesModule.show()
			$MansionUpgradesModule.open()
			SlaveListModule.rebuild()
			$MansionSlaveListModule.set_size(Vector2(1100, 580))
			$MansionSlaveListModule/ScrollContainer.set_size(Vector2(871, 480))  # Needs to be checked with new assets
			menu_buttons.get_node("UpgradesButton").pressed = true
		"occupation":
			$MansionSlaveListModule.rebuild()
			$MansionJobModule.show()
			$MansionSlaveListModule.set_size(Vector2(1100, 580))
			$MansionSlaveListModule/ScrollContainer.set_size($MansionSlaveListModule/ScrollContainer/VBoxContainer.get_size())  # Needs to be checked with new assets
			SlaveListModule.set_hover_area()
		"char_info":
			input_handler.PreviousScene = self
			open_char_info()
	SlaveListModule.set_hover_area()

func open_char_info():
	var slave_info = GUIWorld.gui_data["SLAVE_INFO"].main_module
	GUIWorld.set_current_scene(slave_info)


func rebuild_mansion():
	$MansionSlaveListModule.rebuild()
	$MansionSkillsModule.build_skill_panel()

func rebuild_task_info():
	TaskModule.show_task_info()

### State Managers ###
# Action Handlers for Modules

func travels_manager(params):
	TravelsModule.open_character_dislocation()
	match params.code:
		'default':
			is_travel_selected = false
			selected_destination = null
			selected_travel_characters.clear()
			TravelsModule.update_location_list()
			TravelsModule.update_character_dislocation() 
			SlaveListModule.rebuild()
		'destination_selected':
			is_travel_selected = true
			selected_travel_characters.clear()
			selected_destination = params.destination
			TravelsModule.update_character_dislocation() 
			SlaveListModule.rebuild()

func upgrades_manager():
	SlaveListModule.rebuild()

func skill_manager():
	mansion_state = "skill"
	SlaveListModule.rebuild()			

func slave_list_manager():
	match mansion_state:
		'default':
			if mansion_prev_state == "skill":
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
			print("ACTIVE:" +str(active_person.get_short_name()))
			print("SOURCE:" +str(skill_source.get_short_name()))
			SkillModule.build_skill_panel()
			SlaveListModule.rebuild()
		'travels':
			if is_travel_selected:
				if (active_person.get_stat('obedience') <= 0) && !active_person.is_controllable():
					return
				elif active_person in selected_travel_characters:
					self.selected_travel_characters.erase(active_person)
				else:
					self.selected_travel_characters.append(active_person)
				TravelsModule.update_character_dislocation()
			SlaveListModule.rebuild()
		'upgrades':
			if !is_upgrade_selected:
				SlaveModule.show_slave_info()
				return
			var upgrade = selected_upgrade
			if !ResourceScripts.game_res.upgrades_queue.has(upgrade.code):
				ResourceScripts.game_res.upgrades_queue.append(upgrade.code)
			active_person.assign_to_task("building", upgrade.code)
			UpgradesModule.start_upgrade()
			SlaveListModule.rebuild()
		'occupation':
			$MansionSlaveListModule.rebuild()
			$MansionJobModule.open_jobs_window()			
	SlaveModule.show_slave_info()
	
func set_hovered_person(node, person):
	hovered_person = person
	SlaveModule.show_slave_info()

func remove_hovered_person():
	if SlaveListModule.is_in_area():
		return
	hovered_person = null
	SlaveModule.show_slave_info()

func _on_TestButton_pressed():
	var current_scene = GUIWorld.CurrentScene.name
	print("Current Scene:" + str(current_scene))
	var previous_scene = GUIWorld.BaseScene.name
	print("Previous Scene:" + str(previous_scene))
	print("Subs:" + str(submodules))
	# for i in ResourceScripts.game_party.active_tasks:
	# 	print(i)
	# print("----------------------------------")
	print("Mansion State:" + str(mansion_state))
	# # print("Upgrade list:" + str(globals.upgradelist["tailor"]))
	# # print("upgrades: " + str(ResourceScripts.game_res.upgrades))
	# print("upgrades_queue: " + str(ResourceScripts.game_res.upgrades_queue))
	# print("upgrade_progresses: " + str(ResourceScripts.game_res.upgrade_progresses))
	# # print("persons_for_travel: " + str(persons_for_travel))
	# print("Active person: " + str(active_person))
	# # print("active_tasks: " + str(ResourceScripts.game_res.active_tasks))
	# print("Selected Travel: " + str(selected_destination))
	# print("Mansion Prev Travel:" + str(prev_selected_travel))
	# print("Travelers:" + str(selected_travel_characters))
	# print("Current Scene:" + str(input_handler.CurrentScene.name))
	# print("-----------------------------------")
