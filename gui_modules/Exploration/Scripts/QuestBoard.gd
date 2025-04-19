extends Panel

var selectedquest
var category = "all"
onready var quest_panel = $QuestDetails/QuestPanel

func _ready():
	$QuestDetails/AcceptQuest.connect("pressed", self, "accept_quest")
	
	for i in $guildsortVScroll.get_children():
		i.connect('pressed',self,'selectcategory', [i])
		
#	quest_board()




func selectcategory(button):
	category = button.name
	for i in $guildsortVScroll.get_children():
		i.pressed = (i == button)
	quest_board()

func selectquest(button):
	category = button.name
	for i in $ScrollContainer/VBoxContainer2.get_children():
		if i == button:
			i.get_node("Label").add_font_override("font",load("res://assets/Fonts_v2/FontThemes/NOTO_SANS_Bold_24px.tres"))
		else:
			i.get_node("Label").add_font_override("font", load("res://assets/Fonts_v2/FontThemes/MainMiddle.tres"))

func _show():
	quest_board()

func quest_board():
	input_handler.ActivateTutorial("TUTORIALLIST5")
	build_reputation()
	quest_panel.hide()
	$QuestDetails/AcceptQuest.hide()
#	gui_controller.win_btn_connections_handler(pressed, $QuestBoard, pressed_button)
#	self.current_pressed_area_btn = pressed_button
#	# $QuestBoard.visible = pressed
	var counter = 0
	input_handler.ClearContainer($ScrollContainer/VBoxContainer2)
	for i in input_handler.active_area.quests.factions:
		for k in input_handler.active_area.quests.factions[i].values():
			if k.state == 'free' and (k.source == category or category == "all"):
				counter += 1
				var newbutton = input_handler.DuplicateContainerTemplate(
					$ScrollContainer/VBoxContainer2
				)
				newbutton.get_node("Label").text = tr(k.name)
				newbutton.get_node("Requester").text = tr(k.difficulty)
				newbutton.get_node("ButtonOverlay").connect("pressed", self, "see_quest_info", [k])
				newbutton.set_meta("quest", k)
				newbutton.get_node("ButtonOverlay").connect('pressed',self,'selectquest', [newbutton])
	$NoQuests.visible = counter == 0

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
	var req_counter : int = 0
	for i in $ScrollContainer/VBoxContainer2.get_children():
		if i.name == 'Button':
			continue
		i.pressed = i.get_meta('quest') == quest
	quest_panel.show_info(quest)
	selectedquest = quest
	input_handler.selectedquest = quest
	$QuestDetails/AcceptQuest.show()

func accept_quest():
	ResourceScripts.game_world.take_quest(selectedquest, input_handler.active_area)
	for i in selectedquest.requirements:
		if i.code in ['complete_dungeon', 'complete_location']:
			break
	input_handler.interactive_message('quest_accept', '', {})
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
