extends Panel

var selectedquest
var category = "all"
onready var quest_panel = $QuestDetails/QuestPanel
onready var quest_container = $ScrollContainer
onready var quest_list = $ScrollContainer/VBoxContainer2
onready var slave_quest_container = $ScrollContainer2
onready var slave_quest_list = $ScrollContainer2/VBoxContainer
onready var accept_button = $QuestDetails/AcceptQuest

var quest_mode = "guild"
var slave_selected_quest_id
var slave_pressed_btn

func _ready():
	accept_button.connect("pressed", self, "accept_quest")
	slave_quest_container.show()
	ResourceScripts.slave_quests.connect("quests_regened", self, "build_slave_quest_list")

	for i in $guildsortVScroll.get_children():
		i.connect('pressed', self, 'selectcategory', [i])

	$slave_quests.connect("pressed", self, "open_slave_quests")
#	quest_board()
	input_handler.register_btn_source('quest_btn', self, 'tut_get_quest')
	input_handler.register_btn_source('quest_accept', self, 'tut_get_AcceptQuest')


func tut_get_quest():
	for btn in $ScrollContainer/VBoxContainer2.get_children():
		if btn.get_meta("quest", {code = ""}).code == 'tutorial_threat_easy':
			return btn.get_node("ButtonOverlay")
func tut_get_AcceptQuest():
	return $QuestDetails/AcceptQuest

func selectcategory(button):
	quest_mode = "guild"
	quest_container.show()
	slave_quest_container.show()
	category = button.name
	for i in $guildsortVScroll.get_children():
		i.pressed = (i == button)
	quest_board()

func selectquest(button):
	category = button.name
#	for i in $ScrollContainer/VBoxContainer2.get_children():
#		if i == button:
#			i.get_node("Label").add_font_override("font",load("res://assets/Fonts_v2/FontThemes/NOTO_SANS_Bold_24px.tres"))
#		else:
#			i.get_node("Label").add_font_override("font", load("res://assets/Fonts_v2/FontThemes/MainMiddle.tres"))

func _show():
	quest_board()

func quest_board():
	reset_board_state()
	quest_container.show()
	slave_quest_container.show()
	input_handler.ActivateTutorial("TUTORIALLIST5")
	build_reputation()
	quest_panel.hide()
	accept_button.hide()
#	gui_controller.win_btn_connections_handler(pressed, $QuestBoard, pressed_button)
#	self.current_pressed_area_btn = pressed_button
#	# $QuestBoard.visible = pressed
	var guild_counter = build_standard_quests()
	var slave_counter = build_slave_quest_list(false, false)
	$NoQuests.visible = guild_counter == 0 and slave_counter == 0

func build_standard_quests():
	var counter = 0
	input_handler.ClearContainer(quest_list)
	for i in input_handler.active_area.quests.factions:
		for k in input_handler.active_area.quests.factions[i].values():
			if k.state == 'free' and (k.source == category or category == "all"):
				counter += 1
				var newbutton = input_handler.DuplicateContainerTemplate(
					quest_list
				)
				newbutton.get_node("Label").text = tr(k.name)
				newbutton.get_node("Requester").text = tr(k.difficulty)
				newbutton.get_node("ButtonOverlay").connect("pressed", self, "see_quest_info", [k])
				newbutton.set_meta("quest", k)
				newbutton.get_node("ButtonOverlay").connect('pressed',self,'selectquest', [newbutton])
	return counter

func build_reputation():
	input_handler.ClearContainer($QuestDetails/VBoxContainer)
	for i in ResourceScripts.game_world.areas.plains.factions:
		if !i in ['servants','fighters','mages','workers']:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($QuestDetails/VBoxContainer)
		var text = i.capitalize() + ": "+  str(ResourceScripts.game_world.areas.plains.factions[i].reputation)
		newbutton.get_node('Label').text = text
		newbutton.get_node("TextureRect").texture = images.get_icon("guilds_" + i)

func see_quest_info(quest):
	if slave_pressed_btn != null and is_instance_valid(slave_pressed_btn):
		slave_pressed_btn.pressed = false
	for i in quest_list.get_children():
		if i.name == 'Button':
			continue
		i.pressed = i.get_meta('quest') == quest
	quest_mode = "guild"
	quest_panel.show_info(quest)
	selectedquest = quest
	input_handler.selectedquest = quest
	accept_button.show()

func accept_quest():
	if quest_mode == "slave":
		var slave_quests = ResourceScripts.slave_quests
		if !slave_quests.if_can_take_quest():
			return
		slave_quests.activate_quest(slave_selected_quest_id)
		var quest = slave_quests.get_quest(slave_selected_quest_id)
		var args = {}
		args["label"] = tr("QUESTTASKACQ")
		args["info"] = tr(quest.name)
		args["sound"] = "quest_aquired"
		input_handler.play_animation("quest", args)
		build_slave_quest_list()
		return

	ResourceScripts.game_world.take_quest(selectedquest, input_handler.active_area)
	for i in selectedquest.requirements:
		if i.code in ['complete_dungeon', 'complete_location']:
			break
	#input_handler.interactive_message('quest_accept', '', {})
	var args = {}
	args["label"] = tr("QUESTTASKACQ")
	args["info"] = selectedquest.name
	args["sound"] = "quest_aquired"
	input_handler.play_animation("quest", args)
	category = "all"
	quest_board()

func _on_Button_pressed():
	var newbutton = input_handler.DuplicateContainerTemplate(quest_panel.get_req_container())
	pass # Replace with function body.

func open_slave_quests():
	quest_mode = "slave"
	quest_container.show()
	slave_quest_container.show()
	for i in $guildsortVScroll.get_children():
		i.pressed = false
	reset_board_state()
	build_slave_quest_list()

func build_slave_quest_list(reset_state := true, update_no_quests := true):
	var slave_quests = ResourceScripts.slave_quests
	var quest_pool = slave_quests.get_quest_pool()
	if quest_pool.empty():
		slave_quests.regen_quests()
		quest_pool = slave_quests.get_quest_pool()
		if quest_pool.empty():
			quest_panel.hide_all()
			accept_button.hide()
			if update_no_quests:
				$NoQuests.visible = true
			return 0
	if reset_state:
		reset_board_state()
	input_handler.ClearContainer(slave_quest_list)
	slave_pressed_btn = null
	slave_selected_quest_id = null
	var counter = 0
	for quest_id in quest_pool:
		if !slave_quests.is_quest_open(quest_id):
			continue
		var quest = quest_pool[quest_id]
		var new_node = input_handler.DuplicateContainerTemplate(slave_quest_list)
		slave_quests.process_faction_icon(new_node.get_node('fact'), quest.faction)
		var btn = new_node.get_node('btn')
		btn.text = tr(quest.name)
		btn.connect("pressed", self, "_on_slave_quest_pressed", [quest_id, btn])
		counter += 1
	if update_no_quests:
		$NoQuests.visible = counter == 0
	return counter

func _on_slave_quest_pressed(quest_id, btn):
	for i in quest_list.get_children():
		i.pressed = false
	if slave_pressed_btn != null and is_instance_valid(slave_pressed_btn):
		slave_pressed_btn.pressed = false
	slave_pressed_btn = btn
	slave_pressed_btn.pressed = true
	quest_mode = "slave"
	slave_selected_quest_id = quest_id
	var slave_quests = ResourceScripts.slave_quests
	selectedquest = slave_quests.get_quest(quest_id)
	input_handler.selectedquest = selectedquest
	quest_panel.show_info(selectedquest)
	accept_button.visible = slave_quests.is_quest_open(quest_id)

func reset_board_state():
	quest_panel.hide_all()
	accept_button.hide()
