extends "res://files/Close Panel Button/ClosingPanel.gd"
#warning-ignore-all:return_value_discarded

func _ready():
	$HirePanel/Button.connect("pressed", self, "guild_hire_slave")
	$QuestPanel/AcceptQuest.connect("pressed", self, "accept_quest")
	$SlaveSelectionPanel/ConfirmButton.connect("pressed", self, "confirm_party_selection")
	globals.AddPanelOpenCloseAnimation($SlaveSelectionPanel)
	for i in $AreaCategories.get_children():
		i.connect("pressed",self,"select_category", [i.name])

func open():
	globals.AddPanelOpenCloseAnimation($QuestPanel)
	globals.AddPanelOpenCloseAnimation($HirePanel)
	globals.AddPanelOpenCloseAnimation($ShopPanel)
	show()
	
	globals.ClearContainer($AreaSelection)
	for i in state.areas.values():
		var newbutton = globals.DuplicateContainerTemplate($AreaSelection)
		newbutton.text = i.name
		newbutton.connect("pressed",self,"select_area",[i])

var selectedcategory

var active_area
var active_guild
var active_location


func select_area(area):
	active_area = area
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	for i in $AreaSelection.get_children():
		i.pressed = i.text == area.name

func select_category(category):
	var newbutton
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	if active_area == null:
		return
	match category:
		"capital":
			for i in active_area.factions.values():
				newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
				newbutton.text = i.name
				newbutton.connect("pressed", self, "enter_guild", [i])
		"locations":
			for i in active_area.locations:
				newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
				newbutton.text = i.name
				newbutton.connect("pressed", self, "enter_location", [i])
		"quests":
			for i in active_area.questlocations:
				newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
				newbutton.text = i.name
				newbutton.connect("pressed", self, "enter_location", [i])


func enter_guild(guild):
	active_area = state.areas[guild.area]
	active_guild = guild 
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	
	var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = "Hire"
	newbutton.connect("pressed", self, "open_slave_list")
	newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = "Quests"
	newbutton.connect("pressed", self, "open_quest_list")
	newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = "Shop"
	newbutton.connect("pressed", self, "open_shop_list")
	newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = "Details"
	newbutton.connect("pressed", self, "open_guild_details")
	newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = "Leave"
	newbutton.connect("pressed", self, "select_category", [selectedcategory])

func enter_location(data):
	active_location = data
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	#check if anyone is present
	var presented_characters = []
	for i in state.characters.values():
		if i.area == active_area.code && i.location == active_location.code:
			presented_characters.append(i)
	if presented_characters.size() == 0:
		open_slave_selection_list()
	else:
		open_location_actions()


func open_slave_list():
	$HirePanel.show()
	$HirePanel/Button.hide()
	globals.ClearContainer($HirePanel/VBoxContainer)
	for i in active_guild.slaves:
		var newbutton = globals.DuplicateContainerTemplate($HirePanel/VBoxContainer)
		newbutton.text = i.name
		newbutton.get_node("Price").text = str(i.calculate_price())
		newbutton.connect('signal_RMB',self,'open_slave_info', [i])
		newbutton.connect("pressed", self, "select_slave_in_guild", [i])
		globals.connectslavetooltip(newbutton, i)

var selectedperson

func select_slave_in_guild(person):
	selectedperson = person
	$HirePanel/Button.show()
	$HirePanel/Button.disabled = state.money < person.calculate_price()

func guild_hire_slave():
	state.money -= selectedperson.calculate_price()
	state.add_slave(selectedperson)
	active_guild.slaves.erase(selectedperson)
	selectedperson.area = active_area.code
	selectedperson.location = 'mansion'
	open_slave_list()

func open_slave_info(character):
	get_parent().get_node("SlavePanel").open(character)

func open_quest_list():
	$QuestPanel.show()
	selectedquest = null
	$QuestPanel/RichTextLabel.clear()
	$QuestPanel/AcceptQuest.hide()
	globals.ClearContainer($QuestPanel/VBoxContainer)
	for i in active_area.quests.factions[active_guild.code]:
		if i.taken == false:
			var newbutton = globals.DuplicateContainerTemplate($QuestPanel/VBoxContainer)
			newbutton.text = i.name
			newbutton.connect("pressed",self,"see_quest_info", [i])

var selectedquest

func see_quest_info(quest):
	var text = world_gen.make_quest_descript(quest)
	selectedquest = quest
	$QuestPanel/AcceptQuest.show()
	$QuestPanel/RichTextLabel.bbcode_text = text

func accept_quest():
	world_gen.take_quest(selectedquest, active_area)
	open_quest_list()

var active_slave_list = []

func open_slave_selection_list():
	var text = 'You have no characters at ' + active_location.name + '. Assemble team to send there. Travel time: ' + str(active_location.travel_time + active_area.travel_time)
	$SlaveSelectionPanel.show()
	active_slave_list.clear()
	$SlaveSelectionPanel/RichTextLabel.bbcode_text = text
	for i in state.characters.values():
		i.tags.erase('selected')
	update_slave_list()

func update_slave_list():
	globals.ClearContainer($SlaveSelectionPanel/ScrollContainer/VBoxContainer)
	var newbutton
	newbutton = globals.DuplicateContainerTemplate($SlaveSelectionPanel/ScrollContainer/VBoxContainer)
	newbutton.text = "Add character"
	newbutton.connect("pressed", self, "select_slave_for_group")
	for i in active_slave_list:
		newbutton = globals.DuplicateContainerTemplate($SlaveSelectionPanel/ScrollContainer/VBoxContainer)
		newbutton.text = i.get_short_name()
		newbutton.get_node('icon').texture = load(i.icon)
		newbutton.connect("pressed",self,"remove_slave_selection", [i])
	

func select_slave_for_group():
	var reqs = [{code = 'is_free'}]
	globals.CharacterSelect(self, 'slave_selected', reqs)

func slave_selected(character):
	active_slave_list.append(state.characters[character])
	state.characters[character].tags.append("selected")
	update_slave_list()

func remove_slave_selection(character):
	active_slave_list.erase(character)
	character.tags.erase("selected")
	update_slave_list()


func confirm_party_selection():
	for i in active_slave_list:
		i.remove_from_task()
		i.work = 'travel'
		i.location = 'travel'
		i.travel_target = {area = active_area.code, location = active_location.code}
		i.travel_time = active_area.travel_time + active_location.travel_time
	
	$SlaveSelectionPanel.hide()
	active_slave_list.clear()

func open_location_actions():
	pass