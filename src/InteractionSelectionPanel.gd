extends "res://src/scenes/ClosingPanel.gd"
# warning-ignore-all:return_value_discarded

var participants = []

var limit

func _ready():
	$StartButton.connect("pressed", self, "start_scene")

func open():
	var slavelimit = 2
	if ResourceScripts.game_res.upgrades.has('master_bedroom'):
		slavelimit += ResourceScripts.game_res.upgrades.master_bedroom
	limit = slavelimit
	show()
	participants.clear()
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	$StartButton.disabled = ResourceScripts.game_globals.daily_interactions_left < 1
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		if !i.check_location('mansion'):
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
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
	if ResourceScripts.game_globals.daily_interactions_left > 0:
		$StartButton.disabled = participants.size() < 2 || participants.size() > limit
	else:
		$StartButton.disabled = true
	update_description()

func update_description():
	var text = 'Bedroom limit: ' + str(participants.size()) + "/" + str(limit)
	text += "\n" + "Interactions per day: " + str(ResourceScripts.game_globals.daily_interactions_left) + "/1"
	$RichTextLabel.bbcode_text = text

var interaction = load(ResourceScripts.scenedict.interaction)

func start_scene():
	var newscene = interaction.instance()
	ResourceScripts.game_globals.daily_interactions_left -= 1
	get_parent().add_child(newscene)
	newscene.startsequence(participants)
	hide()
