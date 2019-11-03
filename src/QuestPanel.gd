extends "res://files/Close Panel Button/ClosingPanel.gd"
#warning-ignore-all:return_value_discarded

var selectedquest

func _ready():
	$CompleteButton.connect("pressed", self, "CompleteQuest")
	$CancelButton.connect("pressed", self, "CancelQuest")

func open():
	show()
	$CancelButton.visible = false
	$CompleteButton.visible = false
	$QuestDescript.clear()
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	$rewards.hide()
	$reqs.hide()
	$Label.hide()
	$Label2.hide()
	$Time.hide()
	for i in state.areas.values():
		for guild in i.quests.factions:
			for quest in i.quests.factions[guild].values():
				if quest.state == 'taken':
					make_quest_button(quest)
		for quest in i.quests.global.values():
			if quest.state == 'taken':
				make_quest_button(quest)

func make_quest_button(quest):
	var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = quest.name
	newbutton.connect("pressed", self, "show_quest_info", [quest])
	newbutton.set_meta("quest", quest)

func show_quest_info(quest):
	selectedquest = quest
	for i in $ScrollContainer/VBoxContainer.get_children():
		if i.has_meta('quest'):
			i.pressed = i.get_meta('quest') == quest
	#text += "\n\nArea: " + world_gen.lands[quest.area].name + ", " + quest.source
	$rewards.show()
	$reqs.show()
	$Label.show()
	$Label2.show()
	$Time.show()
	globals.ClearContainer($reqs)
	globals.ClearContainer($rewards)
	#print(quest)
	for i in quest.requirements:
		var newbutton = globals.DuplicateContainerTemplate($reqs)
		match i.code:
			'kill_monsters':
				newbutton.texture = load('res://assets/images/gui/quest_enemy.png')
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
				newbutton.hint_tooltip = "Hunt Monsters: " + Enemydata.enemies[i.type].name + " - " + str(i.curvalue) + "/" + str(i.value)
			'random_item':
				var itemtemplate = Items.itemlist[i.type]
				newbutton.texture = itemtemplate.icon
				if itemtemplate.has('parts'):
					newbutton.material = load("res://files/ItemShader.tres").duplicate()
				newbutton.get_node("amount").text = str(i.value) 
				newbutton.get_node("amount").show()
				newbutton.hint_tooltip = itemtemplate.name + ": " + str(i.value) 
			'complete_location':
				newbutton.texture = globals.quest_icons[i.code]
				newbutton.hint_tooltip = "Complete quest event"
				#print(i.location)
			'complete_dungeon':
				newbutton.texture = globals.quest_icons[i.code]
				globals.connecttexttooltip(newbutton, "Complete quest dungeon at [color=aqua]" + state.areas[i.area].name + "[/color]: [color=yellow]" + i.locationname + "[/color]")
			'random_material':
				newbutton.texture = Items.materiallist[i.type].icon
				newbutton.get_node("amount").show()
				newbutton.get_node("amount").text = str(i.value)
				globals.connectmaterialtooltip(newbutton, Items.materiallist[i.type], '\n\n[color=yellow]Required: ' + str(i.value) + "[/color]")
	
	
	for i in quest.rewards:
		var newbutton = globals.DuplicateContainerTemplate($rewards)
		match i.code:
			'gear':
				var item = globals.CreateGearItem(i.item, i.itemparts)
				item.set_icon(newbutton)
				input_handler.ghost_items.append(item)
				globals.connectitemtooltip(newbutton, item)
			'gold':
				newbutton.texture = load('res://assets/images/iconsitems/gold.png')
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
				newbutton.hint_tooltip = "Gold: " + str(i.value)
			'reputation':
				newbutton.texture = globals.quest_icons[i.code]
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
				newbutton.hint_tooltip = "Reputation (" + quest.source + "): +" + str(i.value)
			'material':
				var material = Items.materiallist[i.type]
				newbutton.texture = material.icon
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
				globals.connectmaterialtooltip(newbutton, material)
	$QuestDescript.bbcode_text = '[center]' + quest.name + '[/center]\n' + quest.descript
	$Time/Label.text = "Limit: " + str(quest.time_limit) + " days."
	
	
	$CancelButton.visible = true
	$CompleteButton.visible = true

var selectedslave

func CompleteQuest():
	var text = ''
	var check = true
	if variables.ignore_quest_requirements:
		CompleteReqs()
		return
	if selectedquest.state == 'taken':
		for i in selectedquest.requirements:
			match i.code:
				'kill_monsters':
					check = i.value <= i.curvalue
				"random_material":
					check = state.if_has_material(i.type, 'gte', i.value)
				"random_item":
					check = state.if_has_items(i.type, 'gte', i.value)
				"slavegetquest":
					select_character_for_quest()
					check = false
				'complete_dungeon','complete_location':
					check = state.completed_locations.has(i.location)
			if check == false:
				break
		if check == false:
			input_handler.SystemMessage("Requirements are no met.")
			input_handler.PlaySound("error")
			return
		else:
			CompleteReqs()

func select_character_for_quest():
	input_handler.ShowSlaveSelectPanel(self, 'character_selected', selectedquest.reqs)

func character_selected(character):
	selectedslave = character
	CompleteReqs()

func CompleteReqs():
	for i in selectedquest.requirements:
		match i.code:
			"random_material":
				state.set_material(i.type, '-', i.value)
			"random_item":
				state.remove_item(i.type, i.value)
			"slavegetquest":
				state.remove_slave(selectedslave)
	selectedquest.state = 'complete'
	state.text_log_add("quest", "Quest Complete: " + selectedquest.name)
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
			'gear':
				globals.AddItemToInventory(globals.CreateGearItem(i.item, i.itemparts))
			'material':
				state.materials[i.item] += i.value
	open()

func CancelQuest():
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'cancel_quest_confirm', "Forfeit This Quest?"])
	#input_handler.ShowConfirmPanel(self, "cancel_quest_confirm", "Forfeit This Quest?")

func cancel_quest_confirm():
	world_gen.fail_quest(selectedquest)
	open()
