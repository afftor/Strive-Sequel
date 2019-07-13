extends "res://files/Close Panel Button/ClosingPanel.gd"
#warning-ignore-all:return_value_discarded

var positiondict = {
	1 : "Positions/HBoxContainer/frontrow/1",
	2 : "Positions/HBoxContainer/frontrow/2",
	3 : "Positions/HBoxContainer/frontrow/3",
	4 : "Positions/HBoxContainer/backrow/4",
	5 : "Positions/HBoxContainer/backrow/5",
	6 : "Positions/HBoxContainer/backrow/6",
}

func _ready():
	$HirePanel/Button.connect("pressed", self, "guild_hire_slave")
	$QuestPanel/AcceptQuest.connect("pressed", self, "accept_quest")
	$SlaveSelectionPanel/ConfirmButton.connect("pressed", self, "confirm_party_selection")
	
	for i in $ShopPanel/HBoxContainer.get_children():
		i.connect('pressed', self, 'select_shop_category', [i.name])
	
	globals.AddPanelOpenCloseAnimation($FactionDetailsPanel)
	globals.AddPanelOpenCloseAnimation($SlaveSelectionPanel)
	for i in $AreaCategories.get_children():
		i.connect("pressed",self,"select_category", [i.name])
	for i in positiondict:
		get_node(positiondict[i]).connect('pressed', self, 'selectfighter', [i])
	
	for i in $FactionDetailsPanel/HBoxContainer.get_children():
		i.get_node("up").connect("pressed", self, "details_quest_up", [i.name])
		i.get_node("down").connect("pressed", self, "details_quest_down", [i.name])



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
var active_faction
var active_location


func select_area(area):
	clear_groups()
	active_area = area
	input_handler.active_area = active_area
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	if selectedcategory == null:
		selectedcategory = 'capital'
	select_category(selectedcategory)
	for i in $AreaSelection.get_children():
		i.pressed = i.text == area.name
	build_area_description()

func select_category(category):
	var newbutton
	selectedcategory = category
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	clear_groups()
	if active_area == null:
		return
	match category:
		"capital":
			for i in active_area.factions.values():
				newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
				newbutton.text = i.name
				newbutton.connect("pressed", self, "enter_guild", [i])
			newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
			newbutton.text = "Shop"
			newbutton.connect("pressed", self, "open_shop")
			
			newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
			newbutton.text = "Buy Dungeon Location"
			newbutton.connect("pressed", self, "purchase_location_list")
			
			
		"locations":
			for i in active_area.locations.values():
				newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
				newbutton.text = i.name
				var presented_characters = []
				for k in state.characters.values():
					if k.area == active_area.code && k.location == i.id && k.travel_time == 0:
						presented_characters.append(k)
				if presented_characters.size() > 0:
					newbutton.text += ' ('+str(presented_characters.size())+')'
				newbutton.connect("pressed", self, "enter_location", [i])
		"quests":
			for i in active_area.questlocations.values():
				newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
				newbutton.text = i.name
				var presented_characters = []
				for k in state.characters.values():
					if k.area == active_area.code && k.location == i.id && k.travel_time == 0:
						presented_characters.append(k)
				if presented_characters.size() > 0:
					newbutton.text += ' ('+str(presented_characters.size())+')'
				newbutton.connect("pressed", self, "enter_location", [i])

var shopcategory

func select_shop_category(category):
	for i in $ShopPanel/HBoxContainer.get_children():
		i.pressed = i.name == category
	$NumberSelection.hide()
	shopcategory = category
	update_shop_list()

func open_shop():
	$ShopPanel.show()
	shopcategory = 'buy'
	update_shop_list()

func update_shop_list():
	globals.ClearContainer($ShopPanel/ScrollContainer/VBoxContainer)
	match shopcategory:
		'buy':
			for i in active_area.capital_shop_resources:
				var item = Items.materiallist[i]
				var newbutton = globals.DuplicateContainerTemplate($ShopPanel/ScrollContainer/VBoxContainer)
				newbutton.get_node("name").text = item.name
				newbutton.get_node("icon").texture = item.icon
				newbutton.get_node("price").text = str(item.price)
				newbutton.connect("pressed",self,"item_purchase", [item])
				globals.connectmaterialtooltip(newbutton, item, 'material')
			for i in active_area.capital_shop_items:
				var item = Items.itemlist[i]
				var newbutton = globals.DuplicateContainerTemplate($ShopPanel/ScrollContainer/VBoxContainer)
				newbutton.get_node("name").text = item.name
				newbutton.get_node("icon").texture = item.icon
				newbutton.get_node("price").text = str(item.price)
				newbutton.connect('pressed', self, "item_purchase", [item])
		'sell':
			for i in state.materials:
				if state.materials[i] <= 0:
					continue
				var item = Items.materiallist[i]
				var newbutton = globals.DuplicateContainerTemplate($ShopPanel/ScrollContainer/VBoxContainer)
				newbutton.get_node("name").text = item.name
				newbutton.get_node("icon").texture = item.icon
				newbutton.get_node("price").text = str(item.price)
				newbutton.get_node("amount").visible = true
				newbutton.get_node("amount").text = str(state.materials[i])
				newbutton.connect("pressed",self,"item_sell", [item])
				globals.connectmaterialtooltip(newbutton, item)

var purchase_item

func item_purchase(item):#(targetnode = null, targetfunction = null, text = '', cost = 0, minvalue = 0, maxvalue = 100, requiregold = false)
	purchase_item = item
	$NumberSelection.open(self, 'item_puchase_confirm', "Purchase $n " + item.name + "? Total cost: $m", item.price, 0, 100, true)

func item_sell(item):
	purchase_item = item
	$NumberSelection.open(self, 'item_sell_confirm', "Sell $n " + item.name + "? Gained gold: $m", item.price, 0, state.materials[item.code], false)

func item_puchase_confirm(value):
	if Items.materiallist.has(purchase_item.code):
		state.set_material(purchase_item.code, '+', value)
		state.money -= purchase_item.price*value
		$Gold.text = str(state.money)
	elif Items.itemlist.has(purchase_item.code):
		while value > 0:
			globals.AddItemToInventory(globals.CreateUsableItem(purchase_item.code))
			value -= 1
		#state.set_material(purchase_item.code, '+', value)
		state.money -= purchase_item.price*value
		$Gold.text = str(state.money)
	update_shop_list()

func item_sell_confirm(value):
	state.set_material(purchase_item.code, '-', value)
	state.money += purchase_item.price*value
	$Gold.text = str(state.money)
	update_shop_list()


func enter_guild(guild):
	active_area = state.areas[guild.area]
	active_faction = guild
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	
	var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = "Hire"
	newbutton.connect("pressed", self, "open_slave_list")
	newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = "Quests"
	newbutton.connect("pressed", self, "open_quest_list")
	newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = "Details"
	newbutton.connect("pressed", self, "open_details")
	newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = "Leave"
	newbutton.connect("pressed", self, "select_category", [selectedcategory])

func open_slave_list():
	$HirePanel.show()
	$HirePanel/Button.hide()
	globals.ClearContainer($HirePanel/VBoxContainer)
	for i in active_faction.slaves:
		var newbutton = globals.DuplicateContainerTemplate($HirePanel/VBoxContainer)
		newbutton.get_node("name").text = i.name
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
	active_faction.slaves.erase(selectedperson)
	selectedperson.area = active_area.code
	selectedperson.location = 'mansion'
	selectedperson.is_players_character = true
	open_slave_list()

func open_slave_info(character):
	input_handler.ShowSlavePanel(character)
	#get_parent().get_node("SlavePanel").open(character)

func open_quest_list():
	$QuestPanel.show()
	selectedquest = null
	$QuestPanel/RichTextLabel.clear()
	$QuestPanel/AcceptQuest.hide()
	globals.ClearContainer($QuestPanel/VBoxContainer)
	for i in active_area.quests.factions[active_faction.code].values():
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

var infotext = "Upgrades effects and quest settings update after some time passed. "

func open_details():
	var text = ''
	$FactionDetailsPanel.show()
	globals.ClearContainer($FactionDetailsPanel/VBoxContainer)
	text = "Faction points: " + str(active_faction.totalreputation) + "\nUnspent points: " + str(active_faction.reputation) + '\n\n' +infotext
	$FactionDetailsPanel/RichTextLabel.bbcode_text = text
	
	for i in active_faction.questsetting:
		if i == 'total':
			continue
		$FactionDetailsPanel/HBoxContainer.get_node(i + "/counter").text = str(active_faction.questsetting[i])
	
	$FactionDetailsPanel/totalquestpoints.text = "Total quests: " + str(active_faction.questsetting.total - (active_faction.questsetting.easy + active_faction.questsetting.medium + active_faction.questsetting.hard)) + "/" + str(active_faction.questsetting.total)
	
	for i in world_gen.guild_upgrades.values():
		var newnode = globals.DuplicateContainerTemplate($FactionDetailsPanel/VBoxContainer)
		text = i.name + ": " + i.descript
		var currentupgradelevel
		if active_faction.upgrades.has(i.code):
			currentupgradelevel = active_faction.upgrades[i.code]
		else:
			currentupgradelevel = 0
		if currentupgradelevel < i.maxlevel:
			text += "\n\nPrice: " + str(i.cost[currentupgradelevel]) + " faction points."
			if active_faction.reputation < i.cost[currentupgradelevel]:
				newnode.get_node("confirm").disabled = true
		else:
			newnode.get_node("confirm").hide()
		
		
		newnode.get_node("text").bbcode_text = text
		newnode.get_node("confirm").connect('pressed', self, "unlock_upgrade", [i, currentupgradelevel])

func details_quest_up(difficulty):
	if active_faction.questsetting.total - (active_faction.questsetting.easy + active_faction.questsetting.medium + active_faction.questsetting.hard) > 0:
		active_faction.questsetting[difficulty] += 1
	open_details()

func details_quest_down(difficulty):
	if active_faction.questsetting[difficulty] > 0:
		active_faction.questsetting[difficulty] -= 1
	open_details()


func unlock_upgrade(upgrade, level):
	if active_faction.upgrades.has(upgrade.code):
		active_faction.upgrades[upgrade.code] += 1
	else:
		active_faction.upgrades[upgrade.code] = 1
	active_faction.reputation -= upgrade.cost[level]
	var effect = upgrade.effects
	for i in effect:
		var value = get_indexed('active_faction:' + i.code)
		value = input_handler.math(i.operant, value, i.value)
		set_indexed('active_faction:' + i.code, value)
		#print(active_faction)
	open_details()

var purch_location_list = {
	easy = {price = 100, name = 'Easy Dungeon'},
	medium = {price = 200, name = 'Medium Dungeon'},
	hard = {price = 300, name = 'Hard Dungeon'},
}

func purchase_location_list():
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	for i in purch_location_list.values():
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.text = i.name + ": " + str(i.price) + " gold"
		newbutton.connect("pressed", self, 'purchase_location', [i])
		

func purchase_location(purchasing_location):
	if active_area.locations.size() < 8:
		world_gen.make_location(purchasing_location.code, active_area)
		state.money -= purchasing_location.price
	else:
		input_handler.SystemMessage("Can't purchase anymore")

func build_location_description():
	var text = ''
	match active_location.type:
		'dungeon':
			text =  active_location.name + " (" + active_location.classname + ")\n"  + tr("DUNGEONDIFFICULTY") + ": " + tr("DUNGEONDIFFICULTY" + active_location.difficulty.to_upper())
			text += "\nProgress: Levels - " + str(current_level) + "/" + str(active_location.levels.size()) + ", "
			text += "Stage - " + str(active_location.progress.level) 
		'settlement':
			text = active_location.classname + ": " + active_location.name
		'skirmish':
			pass
	$AreaDescription.bbcode_text = text

func build_area_description():
	var text = ''
	text += active_area.name
	text += "\nDominant Race: " + active_area.lead_race
	text += "\nPopulation: " + str(active_area.population)
	$AreaDescription.bbcode_text = text

func enter_location(data):
	active_location = data
	input_handler.active_location = active_location
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	#check if anyone is present
	build_location_group()
	var presented_characters = []
	for i in state.characters.values():
		if i.area == active_area.code && i.location == active_location.id && i.travel_time == 0:
			presented_characters.append(i)
	if presented_characters.size() > 0:
		open_location_actions()
	var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = "Send characters here"
	newbutton.connect("pressed",self,"open_slave_selection_list")
	newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = 'Leave'
	newbutton.connect("pressed",self,"select_category", [selectedcategory])
	build_location_description()



var active_slave_list = []

func open_slave_selection_list():
	var text = 'Select characters to send to ' + active_location.name + '. Travel time: ' + str(active_location.travel_time + active_area.travel_time)
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
		newbutton.get_node('icon').texture = i.get_icon()
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
		if variables.instant_travel == false:
			i.work = 'travel'
			i.location = 'travel'
			i.travel_target = {area = active_area.code, location = active_location.id}
			i.travel_time = active_area.travel_time + active_location.travel_time
		else:
			i.work = 'travel'
			i.location = active_location.id
			i.area = active_area.code
	input_handler.update_slave_list()
	$SlaveSelectionPanel.hide()
	active_slave_list.clear()
	enter_location(active_location)

func open_location_actions():
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	var newbutton
	match active_location.type:
		'dungeon':
			newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
			newbutton.text = 'Explore'
			newbutton.connect("pressed",self,"enter_dungeon")
#			newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
#			newbutton.text = 'Leave'
#			newbutton.connect("pressed",self,"select_category", [selectedcategory])
		'settlement':
			pass
		'skirmish':
			newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
			newbutton.text = 'Explore'
			newbutton.connect("pressed",self,"enter_dungeon")
#			newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
#			newbutton.text = 'Leave'
#			newbutton.connect("pressed",self,"select_category", [selectedcategory])


func check_location_group():
	var counter = 0
	var cleararray = []
	for i in active_location.group:
		if state.characters.has(active_location.group[i]) && state.characters[active_location.group[i]].location == active_location.id && state.characters[active_location.group[i]].travel_time == 0:
			
			counter += 1
		else:
			cleararray.append(i)
	
	for i in cleararray:
		active_location.erase(i)
	
	if counter == 0:
		return false
	else:
		return true

func clear_groups():
	globals.ClearContainer($PresentedSlavesPanel/ScrollContainer/VBoxContainer)
	$Positions.hide()
	$PresentedSlavesPanel.hide()

func build_location_group():
	clear_groups()
	for i in positiondict:
		if active_location.group.has('pos'+str(i)) && state.characters[active_location.group['pos'+str(i)]] != null:
			var character = state.characters[active_location.group['pos'+str(i)]]
			get_node(positiondict[i]+"/Image").texture = character.get_icon()
			get_node(positiondict[i]+"/Image").show()
			get_node(positiondict[i]+"/Image/hp").text = str(character.hp) + '/' + str(character.hpmax)
			get_node(positiondict[i]+"/Image/mp").text = str(character.mp) + '/' + str(character.mpmax)
			
		else:
			get_node(positiondict[i]+"/Image").texture = null
			get_node(positiondict[i]+"/Image").hide()
	$PresentedSlavesPanel.show()
	$Positions.show()
	var newbutton# = globals.DuplicateContainerTemplate($PresentedSlavesPanel/ScrollContainer/VBoxContainer)
#	newbutton.get_node("name").text = "Send characters"
#	newbutton.connect('pressed',self,'open_slave_selection_list')
	for i in state.characters.values():
		if i.location == active_location.id && i.travel_time == 0:
			newbutton = globals.DuplicateContainerTemplate($PresentedSlavesPanel/ScrollContainer/VBoxContainer)
			newbutton.get_node("icon").texture = i.get_icon()
			newbutton.get_node("name").text = i.get_short_name()
			newbutton.connect("pressed", self, "return_character", [i])
		elif i.travel_target.location == active_location.id:
			newbutton = globals.DuplicateContainerTemplate($PresentedSlavesPanel/ScrollContainer/VBoxContainer)
			newbutton.get_node("icon").texture = i.get_icon()
			newbutton.get_node("name").text = i.get_short_name() + ": Arriving in " + str(i.travel_time) + " hours."
			newbutton.disabled = true

func return_character(character):
	selectedperson = character
	input_handler.ShowConfirmPanel(self,'return_character_confirm',character.translate("Send [name] back?"))

func return_character_confirm():
	if variables.instant_travel == false:
		selectedperson.location = 'travel'
		selectedperson.travel_target = {area = '', location = 'mansion'}
		selectedperson.travel_time = active_area.travel_time + active_location.travel_time
	else:
		selectedperson.location = 'mansion'
	for i in active_location.group:
		if active_location.group[i] == selectedperson.id:
			active_location.group.erase(i)
	build_location_group()

var pos

func selectfighter(position):
	pos = 'pos'+str(position)
	var reqs = [{code = 'is_at_location', type = active_location.id}]
	globals.CharacterSelect(self, 'slave_position_selected', reqs, true)

func slave_position_selected(character):
	if character == null:
		active_location.group.erase(pos)
		build_location_group()
		return
	
	var positiontaken = false
	var oldheroposition = null
	if active_location.group.has(pos) && state.characters[active_location.group[pos]].travel_time == 0 && state.characters[active_location.group[pos]].location == active_location.id:
		positiontaken = true
	
	for i in active_location.group:
		if active_location.group[i] == character:
			oldheroposition = i
			active_location.group.erase(i)
	
	if oldheroposition != null && positiontaken == true && oldheroposition != pos:
		active_location.group[oldheroposition] = active_location.group[pos]
	
	active_location.group[pos] = character
	build_location_group()

func UpdatePositions():
	for i in positiondict.values():
		get_node(i+'/Image').hide()
	
	for i in state.combatparty:
		if state.combatparty[i] != null:
			get_node(positiondict[i] + "/Image").texture = state.heroes[state.combatparty[i]].portrait()
			get_node(positiondict[i] + "/Image").show()
	$AreaProgress/ProceedButton.disabled = state.if_party_level('lte', 0)
	if $AreaProgress/ProceedButton.disabled:
		$AreaProgress/ProceedButton.hint_tooltip = "You must assign party before venturing"
	else:
		$AreaProgress/ProceedButton.hint_tooltip = ''

#Combat/explore functions

func enter_dungeon():
	check_events('enter')
	var completed_floors = active_location.progress.level
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	
	var newbutton
	
	while completed_floors > 0:
		newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.text = 'Level: ' + str(completed_floors)
		if active_location.progress.level > completed_floors || (active_location.progress.level == completed_floors && active_location.progress.stage >= active_location.levels[active_location.progress.level].stages):
			newbutton.text += "(completed)"
		newbutton.connect("pressed",self,"enter_level", [completed_floors])
		completed_floors -= 1
	
	newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = 'Exit'
	newbutton.connect("pressed",self,"leave_location")

var action_type
var current_level = 1
var current_stage = 0

func enter_level(level):
	current_level = level
	
	if active_location.progress.level < level:
		active_location.progress.level = level
		active_location.progress.stage = 0
	
	if check_events('enter_level') == true:
		yield(input_handler, 'EventFinished')
	
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	var newbutton
	if active_location.progress.level == level && active_location.progress.stage < active_location.levels[level].stages:
		newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.text = 'Advance'
		newbutton.connect("pressed",self,"area_advance",['advance'])
	elif active_location.progress.level == level && active_location.progress.stage >= active_location.levels[level].stages:
		if active_location.levels.has(level + 1) == true:
			newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
			newbutton.text = 'Move to the next level'
			newbutton.connect("pressed",self,"enter_level",[level+1])
		else:
			newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
			newbutton.text = 'Complete location'
			newbutton.connect("pressed",self,"clear_dungeon")
	
	
	newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = 'Roam'
	newbutton.connect("pressed",self,"area_advance",['roam'])
	
	newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = 'Return'
	newbutton.connect("pressed",self,"enter_dungeon")
	build_location_group()
	build_location_description()

func area_advance(mode):
	if check_location_group() == false:
		state.text_log_add("Select at least 1 character before advancing. ")
		return
	match mode:
		'advance':
			current_stage = active_location.progress.stage
		'roam':
			current_stage = 0
	if check_events(mode) == true:
		yield(input_handler, 'EventFinished')
	if check_random_event() == true:
		yield(input_handler, 'EventFinished')
	
	action_type = mode
	
	StartCombat()



func finish_combat():
	if check_events("finish_combat") == true:
		yield(input_handler, 'EventFinished')
	if action_type == 'advance':
		active_location.progress.stage += 1
		enter_level(active_location.progress.level)
	else:
		enter_level(current_level)

func clear_dungeon():
	input_handler.ShowConfirmPanel(self, "clear_dungeon_confirm", "Finish exploring this location? Your party will be sent back and the location will be removed from the list. ")

func clear_dungeon_confirm():
	for i in state.characters.values():
		if (i.location == active_location.id && i.travel_time == 0) || i.travel_target.location == active_location.id:
			selectedperson = i
			return_character_confirm()
	check_events('complete_location')
	active_area.locations.erase(active_location.id)
	active_area.questlocations.erase(active_location.id)
	state.completed_locations[active_location.id] = {name = active_location.name, id = active_location.id, area = active_area.code}
	leave_location()

func leave_location():
	select_category(selectedcategory)

func check_events(action):
	var eventarray = active_location.scriptedevents
	var erasearray = []
	var eventtriggered = false
	for i in eventarray:
		if i.trigger == action && check_event_reqs(i.reqs) == true:
			if i.has('args'):
				call(i.event, i.args)
			else:
				call(i.event)
			eventtriggered = true
			if i.has('oneshot') && i.oneshot == true:
				erasearray.append(i)
			break
	for i in erasearray:
		eventarray.erase(i)
	return eventtriggered

func finish_quest_dungeon(args):
	input_handler.interactive_message('finish_quest_dungeon', 'quest_finish_event', {locationname = active_location.name})

func character_boss_defeat():
	var character_race = []
	var character_class = []
	var difficulty
	if active_location.affiliation == 'local':
		character_race.append([active_area.lead_race, 1])
		for i in active_area.secondary_races:
			character_race.append([i, 0.15])
	if active_location.has("final_enemy_class"):
		for i in active_location.final_enemy_class:
			character_class.append([i, 1])
	
	character_race = input_handler.weightedrandom(character_race)
	character_class = input_handler.weightedrandom(character_class)
	difficulty = variables.power_adjustments_per_difficulty[active_location.difficulty]
	difficulty = rand_range(difficulty[0], difficulty[1])
	input_handler.interactive_message('character_boss_defeat', 'character_event', {characterdata = {race = character_race, class = character_class, difficulty = difficulty}})


func check_event_reqs(reqs):
	var check = true
	for i in reqs:
		match i.code:
			'level':
				check = input_handler.operate(i.operant, current_level, i.value)
			'stage':
				check = input_handler.operate(i.operant, current_stage, i.value)
		if check == false:
			break
	
	
	return check

func check_random_event():
	var eventarray = active_location.randomevents
	var eventtriggered = false
	for i in eventarray:
		pass
	return eventtriggered

func StartCombat():
	var enemydata
	var enemygroup = {}
	var enemies = []
	var music = 'combattheme'
	
	
	
	if variables.skip_combat == true:
		finish_combat()
		return
	
	for i in active_location.stagedenemies:
		if i.stage == current_stage && i.level == current_level:
			enemydata = i.enemy
	if enemydata == null:
		enemydata = active_location.enemies
	
	if typeof(enemydata) == TYPE_ARRAY:
		enemies = input_handler.weightedrandom(enemydata)
		enemies = makerandomgroup(Enemydata.enemygroups[enemies])
	else:
		enemies = makespecificgroup(enemydata)
	
	input_handler.emit_signal("CombatStarted", enemydata)
	input_handler.BlackScreenTransition(0.5)
	yield(get_tree().create_timer(0.5), 'timeout')
	$combat.encountercode = enemydata
	$combat.start_combat(active_location.group, enemies, 'background', music)
	$combat.show()

func makespecificgroup(group):
	var enemies = Enemydata.predeterminatedgroups[group]
	var combatparty = {1 : null, 2 : null, 3 : null, 4 : null, 5 : null, 6 : null}
	for i in enemies.group:
		combatparty[i] = enemies.group[i]
	
	return combatparty

func makerandomgroup(enemygroup):
	var array = []
	for i in enemygroup.units:
		var size = round(rand_range(enemygroup.units[i][0],enemygroup.units[i][1]))
		if size != 0:
			array.append({units = i, number = size})
	var countunits = 0
	for i in array:
		countunits += i.number
	if countunits > 6:
		#potential error
		#array[randi()%array.size()].size - (countunits-6)
		array[randi()%array.size()].number -= (countunits-6)
	
	#Assign units to rows
	var combatparty = {1 : null, 2 : null, 3 : null, 4 : null, 5 : null, 6 : null}
	for i in array:
		var unit = Enemydata.enemies[i.units]
		while i.number > 0:
			var temparray = []
			
			
			if true:
				#smart way
				for i in combatparty:
					if combatparty[i] != null:
						continue
					var aiposition = unit.ai_position[randi()%unit.ai_position.size()]
					if aiposition == 'melee' && i in [1,2,3]:
						temparray.append(i)
					if aiposition == 'ranged' && i in [4,5,6]:
						temparray.append(i)
				
				if temparray.size() <= 0:
					for i in combatparty:
						if combatparty[i] == null:
							temparray.append(i)
			else:
				#stupid way
				for i in combatparty:
					if combatparty[i] != null:
						temparray.append(i)
			
			
			
			combatparty[temparray[randi()%temparray.size()]] = i.units
			i.number -= 1
	
	
	return combatparty

