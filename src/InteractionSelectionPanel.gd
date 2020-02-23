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
	$StartButton.disabled = state.daily_interactions_left < 1
	for id in state.character_order:
		var i = state.characters[id]
		if i.location != 'mansion':
			continue
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.get_node("icon").texture = i.get_icon()
		newbutton.get_node("name").text = i.get_short_name()
		newbutton.connect("pressed", self, "select_participant", [i])
		if i.tags.has('no_sex'):
			newbutton.disabled = true
			globals.connecttexttooltip(newbutton, i.translate(tr("INTERACTIONSNOSEXTAG")))
		else:
			globals.connectslavetooltip(newbutton,i)
	update_description()
	$StartButton.disabled = true


func select_participant(person):
	if participants.has(person) == false:
		participants.append(person)
	else:
		participants.erase(person)
	if state.daily_interactions_left > 0:
		$StartButton.disabled = participants.size() < 2 || participants.size() > limit
	else:
		$StartButton.disabled = true
	update_description()

func update_description():
	var text = 'Bedroom limit: ' + str(participants.size()) + "/" + str(limit)
	text += "\n" + "Interactions per day: " + str(state.daily_interactions_left) + "/1"
	$RichTextLabel.bbcode_text = text

var interaction = preload("res://src/interactionpanel.tscn")

func start_scene():
	var newscene = interaction.instance()
	state.daily_interactions_left -= 1
	get_parent().add_child(newscene)
	newscene.startsequence(participants)
	hide()
