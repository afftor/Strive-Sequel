extends "res://files/Close Panel Button/ClosingPanel.gd"

func _ready():
	$HirePanel/Button.connect("pressed", self, "guild_hire_slave")

func open():
	globals.AddPanelOpenCloseAnimation($QuestPanel)
	globals.AddPanelOpenCloseAnimation($HirePanel)
	globals.AddPanelOpenCloseAnimation($ShopPanel)
	show()
	enter_location(state.startingcity)

func enter_location(data):
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	
	for i in state.areas[0].guilds:
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.text = i.name
		newbutton.connect("pressed", self, "enter_guild", [i])

var active_location

func enter_guild(guild):
	active_location = guild
	
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
	newbutton.connect("pressed", self, "enter_location", [null])
	

func open_slave_list():
	$HirePanel.show()
	$HirePanel/Button.hide()
	globals.ClearContainer($HirePanel/VBoxContainer)
	for i in active_location.slaves:
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
	active_location.slaves.erase(selectedperson)
	open_slave_list()

func open_slave_info(character):
	get_parent().get_node("SlavePanel").open(character)

func see_quest_info(quest):
	print(quest)

func open_quest_list():
	$QuestPanel.show()
	globals.ClearContainer($QuestPanel/VBoxContainer)
	for i in active_location.quests.values():
		for k in i:
			var newbutton = globals.DuplicateContainerTemplate($QuestPanel/VBoxContainer)
			newbutton.text = k.name
			newbutton.connect("pressed",self,"see_quest_info", [k])
