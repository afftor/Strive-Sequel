extends "res://files/Close Panel Button/ClosingPanel.gd"
# warning-ignore-all:return_value_discarded

var participants = []

var limit

func _ready():
	$StartButton.connect("pressed", self, "start_scene")

func open():
	var slavelimit = 2
	if state.upgrades.has('master_bedroom'):
		slavelimit += state.upgrades.master_bedroom
	limit = slavelimit
	show()
	participants.clear()
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	for id in state.character_order:
		var i = state.characters[id]
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
	$StartButton.disabled = participants.size() < 2 || participants.size() > limit
	update_description()

func update_description():
	var text = 'Bedroom limit: ' + str(participants.size()) + "/" + str(limit)
	$RichTextLabel.bbcode_text = text

var interaction = preload("res://src/interactionpanel.tscn")

func start_scene():
	var newscene = interaction.instance()
	get_parent().add_child(newscene)
	newscene.startsequence(participants)