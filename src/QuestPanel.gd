extends "res://files/Close Panel Button/ClosingPanel.gd"
#warning-ignore-all:return_value_discarded

var selectedquest

func _ready():
	$CompleteButton.connect("pressed", self, "CompleteQuest")

func open():
	show()
	$CancelButton.visible = false
	$CompleteButton.visible = false
	$QuestDescript.clear()
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	for i in state.areas.values():
		for guild in i.quests.factions:
			for quest in i.quests.factions[guild].values():
				if quest.taken == true && quest.complete == false:
					make_quest_button(quest)
		for quest in i.quests.global.values():
			if quest.taken == true && quest.complete == false:
				make_quest_button(quest)

func make_quest_button(quest):
	var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = quest.name
	newbutton.connect("pressed", self, "show_quest_info", [quest])
	newbutton.set_meta("quest", quest)

func show_quest_info(quest):
	selectedquest = quest
	var text = world_gen.make_quest_descript(quest)
	for i in $ScrollContainer/VBoxContainer.get_children():
		if i.has_meta('quest'):
			i.pressed = i.get_meta('quest') == quest
	text += "\n\nArea: " + world_gen.lands[quest.area].name + ", " + quest.source
	
	$QuestDescript.bbcode_text = text
	$CancelButton.visible = true
	$CompleteButton.visible = true

var selectedslave

func CompleteQuest():
	var text = ''
	var check = true
	if selectedquest.complete == false:
		for i in selectedquest.requirements:
			match selectedquest.type:
				"materialsquest":
					check = state.if_has_material(i.type, 'gte', i.value)
				"itemsquest":
					check = state.if_has_items(i.type, 'gte', i.value)
				"slavegetquest":
					select_character_for_quest()
					check = false
				'dungeonquest':
					check = state.completed_locations.has(i.value)
			if check == false:
				break
		if check == false:
			return
		else:
			CompleteReqs()

func select_character_for_quest():
	globals.CharacterSelect(self, 'character_selected', selectedquest.reqs)

func character_selected(character):
	selectedslave = character
	CompleteReqs()

func CompleteReqs():
	for i in selectedquest.requirements:
		match selectedquest.type:
			"materialsquest":
				state.set_material(i.type, '-', i.value)
			"itemsquest":
				state.remove_item(i.type, i.value)
			"slavegetquest":
				state.remove_slave(selectedslave)
	selectedquest.complete = true
	Reward()

func Reward():
	input_handler.PlaySound("questcomplete")
	for i in selectedquest.rewards:
		match i.code:
			'gold':
				state.money += i.value
			'reputation':
				state.areas[selectedquest.area].factions[selectedquest.source].reputation += i.value
				state.areas[selectedquest.area].factions[selectedquest.source].totalreputation += i.value
	open()

func CancelQuest():
	pass
