extends "res://files/Close Panel Button/ClosingPanel.gd"

var participants = []

func _ready():
	$StartButton.connect("pressed", self, "start_scene")

func open():
	show()
	participants.clear()
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	for i in state.characters.values():
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.get_node("icon").texture = i.get_icon()
		newbutton.get_node("name").text = i.get_short_name()
		globals.connectslavetooltip(newbutton,i)
		newbutton.connect("pressed", self, "select_participant", [i])


func select_participant(person):
	if participants.has(person) == false:
		participants.append(person)
	else:
		participants.erase(person)
	$StartButton.disabled = participants.size() < 2

var interaction = preload("res://src/interactionpanel.tscn")

func start_scene():
	var newscene = interaction.instance()
	get_parent().add_child(newscene)
	newscene.startsequence(participants)