extends Control#"res://src/Close Panel Button/ClosingPanel.gd"
#warning-ignore-all:return_value_discarded

var positiondict = {
	1 : "LocationGui/Positions/HBoxContainer/frontrow/1",
	2 : "LocationGui/Positions/HBoxContainer/frontrow/2",
	3 : "LocationGui/Positions/HBoxContainer/frontrow/3",
	4 : "LocationGui/Positions/HBoxContainer/backrow/4",
	5 : "LocationGui/Positions/HBoxContainer/backrow/5",
	6 : "LocationGui/Positions/HBoxContainer/backrow/6",
}


func _ready():
	input_handler.exploration_node = self
	input_handler.AddPanelOpenCloseAnimation($QuestPanel)
	input_handler.AddPanelOpenCloseAnimation($HirePanel)
	input_handler.AddPanelOpenCloseAnimation($ShopPanel)
	input_handler.AddPanelOpenCloseAnimation($ServicePanel)
	$QuestPanel/AcceptQuest.connect("pressed", self, "accept_quest")
	$SlaveSelectionPanel/ConfirmButton.connect("pressed", self, "confirm_party_selection")
	
	for i in $ShopPanel/HBoxContainer.get_children():
		i.connect('pressed', self, 'select_shop_category', [i.name])
	
	input_handler.AddPanelOpenCloseAnimation($FactionDetailsPanel)
	input_handler.AddPanelOpenCloseAnimation($SlaveSelectionPanel)
	for i in positiondict:
		get_node(positiondict[i]).metadata = i
		get_node(positiondict[i]).target_node = self
		get_node(positiondict[i]).target_function = 'slave_position_selected'
	
	for i in $FactionDetailsPanel/HBoxContainer.get_children():
		i.get_node("up").connect("pressed", self, "details_quest_up", [i.name])
		i.get_node("down").connect("pressed", self, "details_quest_down", [i.name])
	$NavigationPanel/MansionButton.connect("pressed", self, "return_to_mansion")
	$LocationGui.target_node = self
	$LocationGui.target_function = 'slave_position_deselect'
	$LocationGui/PresentedSlavesPanel/ScrollContainer.target_node = self
	$LocationGui/PresentedSlavesPanel/ScrollContainer.target_function = 'slave_position_deselect'
	$LocationGui/ItemUsePanel/Button.connect("pressed", self, "switch_panel")

func return_to_mansion():
	input_handler.PlaySound("door_open")
	ResourceScripts.core_animations.BlackScreenTransition()
	yield(get_tree().create_timer(0.5), 'timeout')
	hide()
	ResourceScripts.core_animations.StopBackgroundSound()
	input_handler.SetMusicRandom("mansion")
	input_handler.CurrentScreen = 'mansion'

func testcombat():
	current_level = 1
	current_stage = 1
	input_handler.active_location = {stagedenemies = []}
	#input_handler.active_location.stagedenemies = [{stage = 1, level = 1, enemy = 'rats_easy'}]
	var test_slave = ResourceScripts.scriptdict.class_slave.new()
	test_slave.create('BeastkinWolf', 'male', 'random')
	test_slave.unlock_class("smith")
	test_slave.unlock_class("apprentice")
	test_slave.unlock_class("attendant")
	test_slave.unlock_class("archer")
	test_slave.unlock_class("ruler")
	var newitem = globals.CreateGearItem("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'})
	globals.AddItemToInventory(newitem)
	test_slave.equip(newitem)
	ResourceScripts.game_res.materials.unstable_concoction = 5
	ResourceScripts.game_res.materials.bandage = 2
	globals.AddItemToInventory(globals.CreateUsableItem("lifegem", 3))
	globals.AddItemToInventory(globals.CreateUsableItem("lifeshard", 3))
	ResourceScripts.game_party.add_slave(test_slave)
	test_slave.speed = 100
	test_slave.wits = 100.0
	var test_slave2 = ResourceScripts.scriptdict.class_slave.new()
	test_slave2.create('BeastkinWolf', 'male', 'random')
	ResourceScripts.game_party.add_slave(test_slave2)
	input_handler.active_location.group = {1:test_slave.id, 4:test_slave2.id}
	globals.StartCombat('wolves_skirmish')



func show_explore_spells(position):
	if get_node(positiondict[position] + "/Image").visible == true:
		input_handler.MousePositionScripts.append({nodes = [$Positions/itemusepanel, get_node(positiondict[position] + "/Image")], targetnode = self, script = 'hide_heal_items'})
		$Positions/itemusepanel.show()
		$Positions/itemusepanel.rect_global_position.y = get_node(positiondict[position] + "/Image").rect_global_position.y - $Positions/itemusepanel.rect_size.y
		input_handler.ClearContainer($LocationGui/Positions/itemusepanel/GridContainer)
		var character = ResourceScripts.game_party.characters[active_location.group['pos'+str(position)]]
		for i in character.combat_skills:
			var skill = Skilldata.Skilllist[i]
			if skill.tags.has('exploration') == false:
				continue
			var newbutton = input_handler.DuplicateContainerTemplate($LocationGui/Positions/itemusepanel/GridContainer)
			#newbutton.get_node("Label").text = str(i.amount)
			newbutton.texture_normal = skill.icon
			newbutton.hint_tooltip = skill.descript
			if skill.manacost > 0:
				newbutton.hint_tooltip += "\nMana Cost: " + str(skill.manacost)
			for k in skill.catalysts:
				if ResourceScripts.game_res.materials[k] < skill.catalysts[k]:
					newbutton.disabled = true
					newbutton.material = load("res://assets/sfx/bw_shader.tres")
					newbutton.hint_tooltip += "\nMissing catalyst: " + Items.materiallist[k].name
				elif i.mp < skill.manacost:
					newbutton.disabled = true
					newbutton.material = load("res://assets/sfx/bw_shader.tres")
					newbutton.hint_tooltip += "\nNot enough mana: " + Items.materiallist[k].name
			newbutton.connect("pressed", self, "use_skill_explore", [character, skill])
			#newbutton.connect("pressed", self, "use_e_combat_skill", [skill, character, character])

func use_item_on_character(character, item):
	item.use_explore(character)#item.use_explore(state.characters[active_location.group['pos'+str(position)]])
	item.amount -= 1
	#show_heal_items(position)
	build_location_group()

func hide_heal_items():
	$LocationGui/Positions/itemusepanel.hide()

var active_character
var active_skill

func use_skill_explore(character, skill):
	var reqs = [{code = 'is_at_location', value = active_location.id, check = true}]
	active_character = character
	active_skill = skill
	input_handler.ShowSlaveSelectPanel(self, 'use_e_combat_skill', reqs)

func use_skill_confirm(target):
	active_character.use_social_skill(active_skill.code, target)

func open():
	input_handler.CloseAllCloseableWindows()
	
	input_handler.PlaySound("door_open")
	input_handler.CurrentScreen = 'exploration'
	build_accessible_locations()
	
	if selected_location == null:
		select_location('Aliron')
	else:
		select_location(selected_location)
	
	yield(get_tree().create_timer(0.5), 'timeout')
	show()

var selected_location

var active_area
var active_faction
var active_location


func build_accessible_locations():
	input_handler.ClearContainer($NavigationPanel/NavigationContainer/AreaSelection)
	
	var location_array = []
	var travelers = []
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		if !person.travel.location in ['mansion','travel'] && location_array.has(person.travel.location) == false:
			location_array.append(person.travel.location)
	
	var newbutton = input_handler.DuplicateContainerTemplate($NavigationPanel/NavigationContainer/AreaSelection)
	newbutton.text = "Aliron"
	newbutton.connect("pressed",self,"select_location",['Aliron'])
	newbutton.set_meta("data", 'Aliron')
	
	for i in location_array:
		newbutton = input_handler.DuplicateContainerTemplate($NavigationPanel/NavigationContainer/AreaSelection)
		newbutton.text = ResourceScripts.world_gen.get_location_from_code(i).name
		newbutton.connect("pressed",self,"select_location",[i])
		newbutton.set_meta("data", i)
	
	if selected_location != null:
		for i in $NavigationPanel/NavigationContainer/AreaSelection.get_children():
			if i.has_meta("data"):
				i.pressed = i.get_meta('data') == selected_location
#		for i in state.area_order:
#		var area = state.areas[i]
#		if area.unlocked == false:
#			continue
#		var newbutton = input_handler.DuplicateContainerTemplate($NavigationPanel/NavigationContainer/AreaSelection)
#		newbutton.text = area.name
#		newbutton.connect("pressed",self,"select_area",[area])

func select_location(location):
	selected_location = location
	for i in $NavigationPanel/NavigationContainer/AreaSelection.get_children():
		if i.has_meta("data"):
			i.pressed = i.get_meta('data') == location
	if location in ResourceScripts.game_world.capitals:
		open_city(location)
	else:
		var data = ResourceScripts.world_gen.get_location_from_code(location)
		var presented_characters = []
		for id in ResourceScripts.game_party.character_order:
			var i = ResourceScripts.game_party.characters[id]
			if i.check_location(data.id, true):
				presented_characters.append(i)
		if presented_characters.size() == 0:
			select_location('Aliron')
		else:
			open_location(data)

var city_options = {
	location_purchase = "Buy Dungeon Location",
	quest_board = "Notice Board",
}

func open_city(city):
	ResourceScripts.core_animations.BlackScreenTransition()
	yield(get_tree().create_timer(0.5), 'timeout')
	active_area = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[city].area]
	active_location = {}
	input_handler.active_area = active_area
	selected_location = city
	#active_location = active_area
	$LocationGui.hide()
	$CityGui.show()
	$HirePanel.hide()
	$ServicePanel.hide()
	$QuestPanel.hide()
	$ShopPanel.hide()
	$FactionDetailsPanel.hide()
	$SlaveSelectionPanel.hide()
	$VideoPlayer.hide()
	$TextureRect.texture = images.backgrounds[active_area.capital_background]
	if active_area.has('capital_background_noise'):
		input_handler.PlayBackgroundSound(active_area.capital_background_noise)
	if active_area.has('capital_background_music'):
		input_handler.SetMusic(active_area.capital_background_music)
	if active_area.has("capital_dynamic_background"):
		$VideoPlayer.open(active_area.capital_dynamic_background)
	input_handler.ClearContainer($CityGui/ScrollContainer/VBoxContainer)
	var array = []
	for i in active_area.factions.values():
		array.append(i)
	
	array.sort_custom(self, 'sort_factions')
	
	
	var newbutton
	for i in array:
		newbutton = input_handler.DuplicateContainerTemplate($CityGui/ScrollContainer/VBoxContainer)
		newbutton.text = i.name
		newbutton.connect("pressed", self, "enter_guild", [i])
	newbutton = input_handler.DuplicateContainerTemplate($CityGui/ScrollContainer/VBoxContainer)
	newbutton.text = "Shop"
	newbutton.connect("pressed", self, "open_shop", ['area'])
	for i in active_area.capital_options:
		newbutton = input_handler.DuplicateContainerTemplate($CityGui/ScrollContainer/VBoxContainer)
		newbutton.text = city_options[i]
		newbutton.connect("pressed", self, i)
	
	for i in active_area.events:
		if globals.checkreqs(i.reqs) == false:
			continue
		newbutton = input_handler.DuplicateContainerTemplate($CityGui/ScrollContainer/VBoxContainer)
		newbutton.text = i.text
		newbutton.connect("pressed", input_handler, "interactive_message", [i.code,'area_oneshot_event',i.args])
		newbutton.connect("pressed", self, "open_city", [city])
		newbutton.modulate = Color(0.5,0.8,0.5)

var guild_order = ['fighters','workers','servants','mages','slavemarket']

func sort_factions(first, second):
	if guild_order.has(first.code):
		if guild_order.has(second.code):
			if guild_order.find(first.code) < guild_order.find(second.code):
				return true
			else:
				return false
		else:
			return true

var faction_actions = {
	hire = 'Hire',
	sellslaves = "Sell Characters",
	quests = 'Quests',
	upgrade = "Upgrades",
	services = "Service",
}

func enter_guild(guild):
	active_area = ResourceScripts.game_world.areas[guild.area]
	active_faction = guild
	$ShopPanel.hide()
	input_handler.active_faction = guild
	input_handler.ClearContainer($CityGui/ScrollContainer/VBoxContainer)
	var newbutton
	if active_faction.has('events'):
		for i in active_faction.events:
			var events = scenedata.dialogue_inits[i]
			var event
			for k in events:
				if globals.checkreqs(k.reqs) == true:
					event = k
					break 
			if event == null: 
				continue
			newbutton = input_handler.DuplicateContainerTemplate($CityGui/ScrollContainer/VBoxContainer)
			newbutton.text = event.name
			
			newbutton.connect("pressed", input_handler, "interactive_dialogue_start", [event.target, event.target_option])
			newbutton.modulate = Color(0.5,0.8,0.5)
	for i in guild.actions:
		newbutton = input_handler.DuplicateContainerTemplate($CityGui/ScrollContainer/VBoxContainer)
		newbutton.text = faction_actions[i]
		newbutton.connect("pressed", self, "faction_"+i)
	newbutton = input_handler.DuplicateContainerTemplate($CityGui/ScrollContainer/VBoxContainer)
	newbutton.text = "Leave"
	newbutton.connect("pressed", self, "open_city", [selected_location])

#func select_area(area):
#	clear_groups()
#	active_area = area
#	input_handler.active_area = active_area
#	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
#	$AreaCategories.show()
##	if selectedcategory == null:
##		selectedcategory = 'capital'
##	select_category(selectedcategory)
#	update_categories()
#	for i in $AreaSelection.get_children():
#		i.pressed = i.text == area.name
#
#
#	build_area_description()

#func update_categories():
#	$AreaCategories/quests.disabled = active_area.questlocations.size() <= 0

func select_category(category):
	var newbutton
#	selectedcategory = category
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	build_area_description()
	#clear_groups()
	if active_area == null:
		return
	match category:
		"capital":
			for i in active_area.factions.values():
				newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
				newbutton.text = i.name
				newbutton.connect("pressed", self, "enter_guild", [i])
			newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
			newbutton.text = "Shop"
			newbutton.connect("pressed", self, "open_shop", ['area'])
			
			newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
			newbutton.text = "Buy Dungeon Location"
			newbutton.connect("pressed", self, "purchase_location_list")
			
			for i in active_area.events:
				if globals.checkreqs(i.reqs) == false:
					continue
				newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
				newbutton.text = i.text
				newbutton.connect("pressed", input_handler, "interactive_message", [i.code,'area_oneshot_event',i.args])
				#newbutton.connect("pressed", self, "select_category", [selectedcategory])
			
		"locations":
			for i in active_area.locations.values():
				newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
				newbutton.text = i.name
				var presented_characters = []
				for k in ResourceScripts.game_party.characters.values():
					if k.travel.area == active_area.code && k.check_location(i.id, true):
						presented_characters.append(k)
				if presented_characters.size() > 0:
					newbutton.text += ' ('+str(presented_characters.size())+')'
				newbutton.connect("pressed", self, "enter_location", [i])
		"quests":
			for i in active_area.questlocations.values():
				newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
				newbutton.text = i.name
				var presented_characters = []
				for k in ResourceScripts.game_party.characters.values():
					if k.travel.area == active_area.code && k.check_location(i.id, true):
						presented_characters.append(k)
				if presented_characters.size() > 0:
					newbutton.text += ' ('+str(presented_characters.size())+')'
				newbutton.connect("pressed", self, "enter_location", [i])

var active_shop
var shopcategory

func select_shop_category(category):
	for i in $ShopPanel/HBoxContainer.get_children():
		i.pressed = i.name == category
	$NumberSelection.hide()
	shopcategory = category
	update_shop_list()

func open_shop(shop):
	$ShopPanel.show()
	match shop:
		'area':
			active_shop = active_area.shop
		'location':
			active_shop = active_location.shop
	shopcategory = 'buy'
	$ShopPanel/HBoxContainer/buy.pressed = true
	$ShopPanel/HBoxContainer/sell.pressed = false
	update_shop_list()

var tempitems = []

func update_shop_list():
	$ShopPanel/Gold.text = str(ResourceScripts.game_res.money)
	input_handler.ClearContainer($ShopPanel/ScrollContainer/VBoxContainer)
	tempitems.clear()
	match shopcategory:
		'buy':
			for i in active_shop:
				if Items.materiallist.has(i):
					var item = Items.materiallist[i]
					var amount = -1
					if typeof(active_shop) == TYPE_DICTIONARY:
						amount = active_shop[i]
					if amount == 0:
						continue
					var newbutton = input_handler.DuplicateContainerTemplate($ShopPanel/ScrollContainer/VBoxContainer)
					newbutton.get_node("name").text = item.name
					newbutton.get_node("icon").texture = item.icon
					newbutton.get_node("price").text = str(item.price)
					newbutton.connect("pressed",self,"item_purchase", [item, amount])
					globals.connectmaterialtooltip(newbutton, item, 'material')
					if amount > 0:
						newbutton.get_node("amount").text = str(amount)
						newbutton.get_node("amount").show()
				elif Items.itemlist.has(i):
					var item = Items.itemlist[i]
					var amount = -1
					if item.has('parts'):
						amount = 1
					else:
						amount = active_shop[i]
						if amount == 0:
							continue
					var newbutton = input_handler.DuplicateContainerTemplate($ShopPanel/ScrollContainer/VBoxContainer)
					newbutton.get_node("name").text = item.name
					newbutton.get_node("icon").texture = item.icon
					newbutton.get_node("price").text = str(item.price)
					if item.has('parts'):
						var newitem = globals.CreateGearItem(i, active_shop[i], {}, null)
						newitem.set_icon(newbutton.get_node('icon'))
						newbutton.get_node("name").text = newitem.name
						tempitems.append(newitem)
						globals.connectitemtooltip(newbutton, newitem)
						newbutton.get_node("price").text = str(newitem.calculateprice())
						newbutton.connect('pressed', self, "item_purchase", [newitem, amount])
					else:
						globals.connecttempitemtooltip(newbutton, item, 'geartemplate')
						newbutton.connect('pressed', self, "item_purchase", [item, amount])
					if amount > 0:
						newbutton.get_node("amount").text = str(amount)
						newbutton.get_node("amount").show()
		'sell':
			for i in ResourceScripts.game_res.materials:
				if ResourceScripts.game_res.materials[i] <= 0:
					continue
				var item = Items.materiallist[i]
				var newbutton = input_handler.DuplicateContainerTemplate($ShopPanel/ScrollContainer/VBoxContainer)
				newbutton.get_node("name").text = item.name
				newbutton.get_node("icon").texture = item.icon
				newbutton.get_node("price").text = str(item.price)
				newbutton.get_node("amount").visible = true
				newbutton.get_node("amount").text = str(ResourceScripts.game_res.materials[i])
				newbutton.connect("pressed",self,"item_sell", [item])
				globals.connectmaterialtooltip(newbutton, item)
			for item in ResourceScripts.game_res.items.values():
				if item.owner != null:
					continue
				var newbutton = input_handler.DuplicateContainerTemplate($ShopPanel/ScrollContainer/VBoxContainer)
				newbutton.get_node("name").text = item.name
				item.set_icon(newbutton.get_node("icon"))#.texture = item.get_icon()
				newbutton.get_node("price").text = str(item.calculateprice()/2)
				newbutton.get_node("amount").visible = true
				newbutton.get_node("amount").text = str(item.amount)
				newbutton.connect("pressed",self,"item_sell", [item])
				globals.connectitemtooltip(newbutton, item)

var purchase_item

func item_purchase(item, amount):#(targetnode = null, targetfunction = null, text = '', cost = 0, minvalue = 0, maxvalue = 100, requiregold = false)
	purchase_item = item
	if amount < 0:
		amount = 100
	var price = 0
	if typeof(item) == TYPE_OBJECT:
		price = item.calculateprice()
	else:
		price = item.price
	$NumberSelection.open(self, 'item_puchase_confirm', "Purchase $n " + item.name + "? Total cost: $m", price, 0, amount, true)

func item_sell(item):
	purchase_item = item
	var price = item.price
	var sellingamount
	if Items.materiallist.has(item.code) == false:
		price = item.calculateprice()/2
		sellingamount = item.amount
	else:
		sellingamount = ResourceScripts.game_res.materials[item.code]
	$NumberSelection.open(self, 'item_sell_confirm', "Sell $n " + item.name + "? Gained gold: $m", price, 0, sellingamount, false)

func item_puchase_confirm(value):
	input_handler.PlaySound("money_spend")
	if typeof(purchase_item) == TYPE_OBJECT:
		globals.AddItemToInventory(purchase_item)
		ResourceScripts.game_res.money -= purchase_item.calculateprice()
		$ShopPanel/Gold.text = str(ResourceScripts.game_res.money)
		input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
		for i in active_shop:
			if purchase_item.itembase == i && str(purchase_item.parts) == str(active_shop[i]):
				active_shop.erase(i)
				break
		update_shop_list()
	else:
		if Items.materiallist.has(purchase_item.code):
			ResourceScripts.game_res.set_material(purchase_item.code, '+', value)
			ResourceScripts.game_res.money -= purchase_item.price*value
			$ShopPanel/Gold.text = str(ResourceScripts.game_res.money)
			if typeof(active_shop) == TYPE_DICTIONARY:
				active_shop[purchase_item.code] -= value
		elif Items.itemlist.has(purchase_item.code):
			ResourceScripts.game_res.money -= purchase_item.price*value
			if typeof(active_shop) == TYPE_DICTIONARY:
				active_shop[purchase_item.code] -= value
			while value > 0:
				match purchase_item.type:
					'usable':
						globals.AddItemToInventory(globals.CreateUsableItem(purchase_item.code))
					'gear':
						globals.AddItemToInventory(globals.CreateGearItem(purchase_item.code, {}))
				
				value -= 1
			$ShopPanel/Gold.text = str(ResourceScripts.game_res.money)
		update_shop_list()

func item_sell_confirm(value):
	input_handler.PlaySound("money_spend")
	var price = purchase_item.price
	if Items.materiallist.has(purchase_item.code):
		ResourceScripts.game_res.set_material(purchase_item.code, '-', value)
	else:
		price = round(purchase_item.calculateprice()/2)
		purchase_item.amount -= value
	ResourceScripts.game_res.money += price*value
	$ShopPanel/Gold.text = str(ResourceScripts.game_res.money)
	update_shop_list()

func faction_hire():
	hiremode = 'hire'
	$HirePanel.show()
	$HirePanel/RichTextLabel.bbcode_text = ""
	input_handler.ClearContainer($HirePanel/ScrollContainer/VBoxContainer)
	for i in active_faction.slaves:
		var tchar = characters_pool.get_char_by_id(i)
		var newbutton = input_handler.DuplicateContainerTemplate($HirePanel/ScrollContainer/VBoxContainer)
		newbutton.get_node("name").text = tchar.get_stat('name')
		newbutton.get_node("Price").text = str(tchar.calculate_price())
		#newbutton.connect('signal_RMB_release',input_handler,'ShowSlavePanel', [tchar])
		newbutton.connect("pressed",input_handler,'ShowSlavePanel', [tchar])#, self, "select_slave_in_guild", [tchar])
		newbutton.set_meta("person", tchar)
		globals.connectslavetooltip(newbutton, tchar)

var selectedperson
var hiremode = ''

func faction_sellslaves():
	hiremode = 'sell'
	$HirePanel.show()
	$HirePanel/RichTextLabel.bbcode_text = ""
	input_handler.ClearContainer($HirePanel/ScrollContainer/VBoxContainer)
	for i in ResourceScripts.game_party.characters:
		var tchar = characters_pool.get_char_by_id(i)
		if tchar.has_profession('master') || tchar.valuecheck({code = 'is_free'}) == false:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($HirePanel/ScrollContainer/VBoxContainer)
		newbutton.get_node("name").text = tchar.get_stat('name')
		newbutton.get_node("Price").text = str(round(tchar.calculate_price()/2))
		newbutton.connect("pressed", self, "sell_slave", [tchar])
		newbutton.set_meta("person", tchar)
		globals.connectslavetooltip(newbutton, tchar)

func select_slave_in_guild(person):
	selectedperson = person
	match hiremode:
		'hire':
			for i in $HirePanel/VBoxContainer.get_children():
				if i.name == "Button":
					continue
				i.pressed = i.get_meta("person") == person
			var text = 'Hire ' + person.get_stat('name') + " for " + str(person.calculate_price()) + " gold? "
			$HirePanel/RichTextLabel.bbcode_text = text
			$HirePanel/Button.show()
			$HirePanel/Button.disabled = (ResourceScripts.game_res.money < person.calculate_price())
		'sell':
			for i in $HirePanel/ScrollContainer/VBoxContainer.get_children():
				if i.name == "Button":
					continue
				i.pressed = i.get_meta("person") == person
			var text = 'Sell ' + person.get_stat('name') + " for " + str(round(person.calculate_price()/2)) + " gold? "
			$HirePanel/RichTextLabel.bbcode_text = text
			$HirePanel/Button.show()
			$HirePanel/Button.disabled = false

func guild_hire_slave():
	match hiremode:
#		'hire':
#			if state.characters.size() >= state.get_pop_cap():
#				if state.get_pop_cap() < variables.max_population_cap:
#					input_handler.SystemMessage("You don't have enough rooms")
#				else:
#					input_handler.SystemMessage("Population limit reached")
#				return
#
#			state.money -= selectedperson.calculate_price()
#			state.add_slave(selectedperson)
#			active_faction.slaves.erase(selectedperson.id)
#			selectedperson.area = active_area.code
#			selectedperson.location = 'mansion'
#			selectedperson.is_players_character = true
#			input_handler.active_character = selectedperson
#			input_handler.scene_characters.append(selectedperson)
#			input_handler.interactive_message('hire', '', {})
#			input_handler.PlaySound("money_spend")
#			faction_hire()
		'sell':
			ResourceScripts.game_res.money += round(selectedperson.calculate_price()/2)
			ResourceScripts.game_party.remove_slave(selectedperson)
			active_faction.slaves.append(selectedperson.id)
			selectedperson.is_players_character = false
			input_handler.PlaySound("money_spend")
			input_handler.slave_list_node.rebuild()
			faction_sellslaves()

func sell_slave(person):
	selectedperson = person
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'sell_slave_confirm', selectedperson.translate("Sell [name]?")])

func sell_slave_confirm():
	ResourceScripts.game_res.money += round(selectedperson.calculate_price()/2)
	ResourceScripts.game_party.remove_slave(selectedperson)
	active_faction.slaves.append(selectedperson.id)
	selectedperson.is_players_character = false
	input_handler.PlaySound("money_spend")
	input_handler.slave_list_node.rebuild()
	faction_sellslaves()

func quest_board():
	$QuestPanel.show()
	selectedquest = null
	$QuestPanel/Label.hide()
	$QuestPanel/Label2.hide()
	$QuestPanel/questrewards.hide()
	$QuestPanel/questreqs.hide()
	$QuestPanel/RichTextLabel.clear()
	$QuestPanel/AcceptQuest.hide()
	$QuestPanel/time.hide()
	input_handler.ClearContainer($QuestPanel/ScrollContainer/VBoxContainer)
	for i in active_area.quests.factions:
		for k in active_area.quests.factions[i].values():
			if k.state == 'free':
				var newbutton = input_handler.DuplicateContainerTemplate($QuestPanel/ScrollContainer/VBoxContainer)
				newbutton.text = k.name
				newbutton.connect("pressed",self,"see_quest_info", [k])
				newbutton.set_meta("quest", k)



var selectedquest

func see_quest_info(quest):
	for i in $QuestPanel/ScrollContainer/VBoxContainer.get_children():
		if i.name == 'Button':
			continue
		i.pressed = i.get_meta('quest') == quest
	input_handler.ghost_items.clear()
	selectedquest = quest
	$QuestPanel/Label.show()
	$QuestPanel/Label2.show()
	$QuestPanel/AcceptQuest.show()
	$QuestPanel/questrewards.show()
	$QuestPanel/questreqs.show()
	$QuestPanel/time.show()
	input_handler.ClearContainer($QuestPanel/questreqs)
	input_handler.ClearContainer($QuestPanel/questrewards)
	var text = '[center]' + quest.name + '[/center]\n' + quest.descript
	#print(quest.requirements)
	for i in quest.requirements:
		var newbutton = input_handler.DuplicateContainerTemplate($QuestPanel/questreqs)
		match i.code:
			'kill_monsters':
				newbutton.texture = images.icons.quest_enemy
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
				newbutton.texture = images.icons.quest_enemy
				newbutton.hint_tooltip = "Hunt Monsters: " + Enemydata.enemies[i.type].name + " - " + str(i.value)
			'random_item':
				var itemtemplate = Items.itemlist[i.type]
				newbutton.texture = itemtemplate.icon
				newbutton.hint_tooltip = itemtemplate.name + ": " + str(i.value) 
				if itemtemplate.has('parts'):
					#newbutton.material = load("res://src/ItemShader.tres").duplicate()
					var showcase_item = globals.CreateGearItem(i.type, i.parts)
					input_handler.itemshadeimage(newbutton, showcase_item)
					globals.connectitemtooltip(newbutton, showcase_item)
					if i.has('parts'):
						newbutton.hint_tooltip += "\nPart Requirements: "
						for k in i.parts:
							newbutton.hint_tooltip += "\n"+ tr(Items.Parts[k].name)  + ": " +str(Items.materiallist[i.parts[k]].name)
				newbutton.get_node("amount").text = str(i.value) 
				newbutton.get_node("amount").show()
			'complete_location':
				newbutton.texture = images.icons.quest_encounter
				newbutton.hint_tooltip = "Complete quest location: " + ResourceScripts.world_gen.dungeons[i.type].name
				text += "\n" + ResourceScripts.world_gen.dungeons[i.type].name + ": " + ResourceScripts.world_gen.dungeons[i.type].descript
			'complete_dungeon':
				newbutton.texture = images.icons.quest_dungeon
				newbutton.hint_tooltip = "Complete quest dungeon: "
			'random_material':
				newbutton.texture = Items.materiallist[i.type].icon
				newbutton.get_node("amount").show()
				newbutton.get_node("amount").text = str(i.value)
				globals.connectmaterialtooltip(newbutton, Items.materiallist[i.type], '\n\n[color=yellow]Required: ' + str(i.value) + "[/color]")
			'slave_delivery':
				newbutton.texture = images.icons.quest_slave_delivery
				var tooltiptext = "Slave Required:\n"
				for k in i.statreqs:
					if k.code in ['is_master', 'is_free']:
						continue
					match k.code:
						'stat':
							tooltiptext += statdata.statdata[k.type].name +": "+ input_handler.operant_translation(k.operant) + " " + str(k.value) + " "  + "\n"
						'sex':
							tooltiptext += "Sex: " + tr('SLAVESEX'+k.value.to_upper()) + "\n"
				globals.connecttexttooltip(newbutton,tooltiptext)
	
	for i in quest.rewards:
		var newbutton = input_handler.DuplicateContainerTemplate($QuestPanel/questrewards)
		match i.code:
			'gear':
				var item = globals.CreateGearItem(i.item, i.itemparts)
				item.set_icon(newbutton)
				input_handler.ghost_items.append(item)
				globals.connectitemtooltip(newbutton, item)
			'gear_static':
				newbutton.texture = Items.itemlist[i.item].icon
				globals.connecttempitemtooltip(newbutton, Items.itemlist[i.item], 'geartemplate')
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
			'usable':
				var item = Items.itemlist[i.item]
				newbutton.texture = item.icon
				globals.connecttempitemtooltip(newbutton, item, 'geartemplate')
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
			'material':
				var material = Items.materiallist[i.item]
				newbutton.texture = material.icon
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
				globals.connectmaterialtooltip(newbutton, material)
			'gold':
				var value = round(i.value + i.value * variables.master_charm_quests_gold_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])
				newbutton.texture = images.icons.quest_gold
				newbutton.get_node("amount").text = str(value)
				newbutton.get_node("amount").show()
				newbutton.hint_tooltip = "Gold: " + str(i.value) + " + " + str(round(i.value * variables.master_charm_quests_gold_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])) + "(Master Charm Bonus)"
			'reputation':
				var value = round(i.value + i.value * variables.master_charm_quests_rep_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])
				newbutton.texture = images.icons[i.code]
				newbutton.get_node("amount").text = str(value)
				newbutton.get_node("amount").show()
				newbutton.hint_tooltip = "Reputation (" + quest.source + "): " + str(i.value) + " + " + str(round(i.value * variables.master_charm_quests_rep_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))]))+ "(Master Charm Bonus)"
	
	text += "\n\n{color=yellow|Requester: " + active_area.factions[quest.source].name + "}"
	
	$QuestPanel/RichTextLabel.bbcode_text = globals.TextEncoder(text)
	$QuestPanel/time/Label.text = "Limit: " + str(quest.time_limit) + " days."

func accept_quest():
	ResourceScripts.game_world.take_quest(selectedquest, active_area)
	for i in selectedquest.requirements:
		if i.code in ['complete_dungeon','complete_location']:
			#input_handler.get_spec_node(input_handler.NODE_POPUP, ["You've received a new quest location.", 'Confirm'])
			#input_handler.ShowPopupPanel("You've received a new quest location.")
			#update_categories()
			break
	input_handler.interactive_message('quest_accept','',{})
	quest_board()

var infotext = "Upgrades effects and quest settings update after some time passed. "

func faction_upgrade():
	var text = ''
	$FactionDetailsPanel.show()
	input_handler.ClearContainer($FactionDetailsPanel/VBoxContainer)
	text = "Faction points: " + str(active_faction.totalreputation) + "\nUnspent points: " + str(active_faction.reputation) + '\n\n' +infotext
	$FactionDetailsPanel/RichTextLabel.bbcode_text = text
	
	for i in active_faction.questsetting:
		if i == 'total':
			continue
		$FactionDetailsPanel/HBoxContainer.get_node(i + "/counter").text = str(active_faction.questsetting[i])
	
	$FactionDetailsPanel/totalquestpoints.text = "Total quests: " + str(active_faction.questsetting.total - (active_faction.questsetting.easy + active_faction.questsetting.medium + active_faction.questsetting.hard)) + "/" + str(active_faction.questsetting.total)
	
	for i in worlddata.guild_upgrades.values():
		var newnode = input_handler.DuplicateContainerTemplate($FactionDetailsPanel/VBoxContainer)
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
	faction_upgrade()

func details_quest_down(difficulty):
	if active_faction.questsetting[difficulty] > 0:
		active_faction.questsetting[difficulty] -= 1
	faction_upgrade()


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
	faction_upgrade()


var service_actions = {
	enslave = {code = 'enslave', text = 'SERVICEENSLAVE', descript = 'SERVICEENSLAVEDESCRIPT', function = 'enslave', reqs = [{type = 'has_money', value = variables.enslavement_price}], costvalue = variables.enslavement_price},
	#free = {code = 'free', text = "Make Free", descript = '', function = 'free'}
	
}

func faction_services():
	$ServicePanel.show()
	input_handler.ClearContainer($ServicePanel/VBoxContainer)
	for i in service_actions.values():
		var newbutton = input_handler.DuplicateContainerTemplate($ServicePanel/VBoxContainer)
		newbutton.text = tr(i.text)
		newbutton.connect("pressed", self, i.function)
		newbutton.get_node("Label").text = str(i.costvalue)
		globals.connecttexttooltip(newbutton, tr(i.descript))

func enslave():
	var reqs = [{code = 'slave_type', value = 'slave', operant = 'neq'}, {code = "is_master", check = false}]
	input_handler.ShowSlaveSelectPanel(self, 'enslave_select', reqs)
	

func enslave_select(character):
	character.set_slave_category("slave")
	input_handler.active_character = character
	var changes = [{code = 'money_change', operant = '-', value = variables.enslavement_price}]
	globals.common_effects(changes)
	globals.text_log_add('char',character.translate("[name] has been demoted to Slave."))
	globals.character_stat_change(character, {code = 'loyalty', operant = '-', value = 50})
	globals.character_stat_change(character, {code = 'submission', operant = '-', value = 25})
	input_handler.scene_characters.append(character)
	input_handler.interactive_message('enslave', '', {})
	input_handler.update_slave_list()

func free():
	pass



func location_purchase():
	input_handler.ClearContainer($CityGui/ScrollContainer/VBoxContainer)
	for i in ResourceScripts.world_gen.dungeons.values():
		if i.type != 'dungeon':
			continue
	#for i in purch_location_list.values():
		var newbutton = input_handler.DuplicateContainerTemplate($CityGui/ScrollContainer/VBoxContainer)
		newbutton.text = i.classname + ": " + str(i.puchase_price) + " gold"
		newbutton.connect("pressed", self, 'purchase_location', [i])
		if ResourceScripts.game_res.money < i.puchase_price:
			newbutton.disabled = true
	var newbutton = input_handler.DuplicateContainerTemplate($CityGui/ScrollContainer/VBoxContainer)
	newbutton.text = "Leave"
	newbutton.connect("pressed", self, "open_city", [selected_location])

func purchase_location(purchasing_location):
	if purchasing_location.has('purchase_area'):
		active_area = ResourceScripts.game_world.areas[purchasing_location.purchase_area]
	if active_area.locations.size() < 8:
		var randomlocation = []
		for i in active_area.locationpool:
			randomlocation.append(ResourceScripts.world_gen.dungeons[i].code)
		#randomlocation = randomlocation[randi()%randomlocation.size()]
		randomlocation = ResourceScripts.world_gen.make_location(purchasing_location.code, active_area)
		input_handler.active_location = randomlocation
		input_handler.active_area = active_area
		active_area.locations[randomlocation.id] = randomlocation
		ResourceScripts.game_world.location_links[randomlocation.id] = {area = active_area.code, category = 'locations'} 
		ResourceScripts.game_res.money -= purchasing_location.puchase_price
		input_handler.interactive_message('purchase_dungeon_location', 'location_purchase_event', {})
	else:
		input_handler.SystemMessage("Can't purchase anymore")
	location_purchase()

func build_location_description():
	var text = ''
	match active_location.type:
		'dungeon':
			text =  active_location.name + " (" + active_location.classname + ")\n"  + tr("DUNGEONDIFFICULTY") + ": " + tr("DUNGEONDIFFICULTY" + active_location.difficulty.to_upper())
			text += "\nProgress: Levels - " + str(current_level) + "/" + str(active_location.levels.size()) + ", "
			text += "Stage - " + str(active_location.progress.stage) 
		'settlement':
			text = active_location.classname + ": " + active_location.name
		'skirmish':
			pass
		'quest_location':
			text = active_location.name +"\n" + active_location.descript
	$LocationGui/Image/RichTextLabel.bbcode_text = '[center]' + text + "[/center]"

func build_area_description():
	var text = ''
	text += active_area.name
	#text += "\nLocal Races: " + str(active_area.races)
	text += "\nPopulation: " + str(active_area.population)
	$AreaDescription.bbcode_text = text

func open_location(data):
	if active_location != data:
		ResourceScripts.core_animations.BlackScreenTransition(0.7)
		yield(get_tree().create_timer(0.7), 'timeout')
	input_handler.StopBackgroundSound()
	$LocationGui.show()
	$CityGui.hide()
	$HirePanel.hide()
	$ServicePanel.hide()
	$QuestPanel.hide()
	$ShopPanel.hide()
	$FactionDetailsPanel.hide()
	$SlaveSelectionPanel.hide()
	active_location = data
	active_area = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[data.id].area]
	input_handler.active_area = active_area
	input_handler.active_location = active_location
	if active_location.has('progress'):
		current_level = active_location.progress.level
		current_stage = active_location.progress.stage
	
	if active_location.has('background'):
		$LocationGui/Image/TextureRect.texture = images.backgrounds[active_location.background]
	if active_location.has('bgm'):
		input_handler.SetMusic(active_location.bgm)
	
	
	input_handler.ActivateTutorial("exploration")
	
	#check if anyone is present
	build_location_group()
	var presented_characters = []
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		if i.travel.area == active_area.code && i.check_location(active_location.id, true):
			presented_characters.append(i)
	if presented_characters.size() > 0 || variables.allow_remote_intereaction == true:
		open_location_actions()
#	var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
#	newbutton.text = "Send characters here"
#	newbutton.connect("pressed",self,"open_slave_selection_list")
#	newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
#	newbutton.text = 'Leave'
	#newbutton.connect("pressed",self,"select_category", [selectedcategory])
	build_location_description()




func open_location_actions():
	input_handler.ClearContainer($LocationGui/ScrollContainer/VBoxContainer)
	var newbutton
	match active_location.type:
		'dungeon':
			enter_dungeon()
#			newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
#			newbutton.text = 'Explore'
#			newbutton.connect("pressed",self,"enter_dungeon")
		'settlement':
			for i in active_location.actions:
				newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
				newbutton.text = tr(i.to_upper())
				newbutton.connect("pressed", self, i)
		'encounter':
#			newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
#			newbutton.text = 'Initiate'
#			newbutton.connect("pressed",self,"start_skirmish")
			for i in active_location.options:
				if globals.checkreqs(i.reqs) == true:
					newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
					newbutton.text = tr(i.text)
					newbutton.connect("pressed", globals, 'common_effects', [i.args])
		'quest_location':
			for i in active_location.options:
				if globals.checkreqs(i.reqs) == true:
					newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
					newbutton.text = tr(i.text)
					newbutton.connect("pressed", globals, 'common_effects', [i.args])

func local_shop():
	open_shop('location')


func local_events_search():
	if input_handler.active_location.events.has('search') && input_handler.active_location.events.search > 0:
		input_handler.SystemMessage("Already searched this location today")
	else:
		input_handler.active_location.events.search = 1
		input_handler.interactive_message('location_event_search', 'event_selection', {})

func build_location_group():
	#clear_groups()
	for i in positiondict:
		if active_location.group.has('pos'+str(i)) && ResourceScripts.game_party.characters.has(active_location.group['pos'+str(i)]) == false:
			active_location.group.erase('pos'+str(i))
			get_node(positiondict[i]+"/Image").dragdata = null
			get_node(positiondict[i]+"/Image").texture = null
			get_node(positiondict[i]+"/Image").hide()
			get_node(positiondict[i]).self_modulate.a = 1
			get_node(positiondict[i]).character = null
			continue
		if active_location.group.has('pos'+str(i)) && ResourceScripts.game_party.characters[active_location.group['pos'+str(i)]] != null &&  ResourceScripts.game_party.characters[active_location.group['pos'+str(i)]].check_location(active_location.id):
			var character = ResourceScripts.game_party.characters[active_location.group['pos'+str(i)]]
			get_node(positiondict[i]+"/Image").texture = character.get_icon()
			if get_node(positiondict[i]+"/Image").texture == null:
				if character.has_profession('master'):
					get_node(positiondict[i]+"/Image").texture = images.icons.class_master
				elif character.get_stat('slave_class') == 'servant':
					get_node(positiondict[i]+"/Image").texture = images.icons.class_servant
				else:
					get_node(positiondict[i]+"/Image").texture = images.icons.class_slave
			get_node(positiondict[i]+"/Image").show()
			get_node(positiondict[i]+"/Image/TextureRect").hint_tooltip = "HP: " + str(floor(character.hp)) + '/' + str(floor(character.get_stat('hpmax')))+ "\nMP: " +str(floor(character.mp)) + '/' + str(floor(character.get_stat('mpmax')))
			get_node(positiondict[i]+"/Image/TextureRect/hp").max_value = character.get_stat('hpmax')
			get_node(positiondict[i]+"/Image/TextureRect/hp").value = character.hp
			get_node(positiondict[i]+"/Image/TextureRect/mp").max_value = character.get_stat('mpmax')
			get_node(positiondict[i]+"/Image/TextureRect/mp").value = character.mp
			
			get_node(positiondict[i]+"/Image").dragdata = character
			get_node(positiondict[i]+"/Image/Label").text = character.get_short_name()
			get_node(positiondict[i]).self_modulate.a = 0
			get_node(positiondict[i]).character = character
		else:
			get_node(positiondict[i]+"/Image").dragdata = null
			get_node(positiondict[i]+"/Image").texture = null
			get_node(positiondict[i]+"/Image").hide()
			get_node(positiondict[i]).self_modulate.a = 1
			get_node(positiondict[i]).character = null
	var newbutton
	input_handler.ClearContainer($LocationGui/PresentedSlavesPanel/ScrollContainer/VBoxContainer)
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		if i.check_location(active_location.id, true):
			newbutton = input_handler.DuplicateContainerTemplate($LocationGui/PresentedSlavesPanel/ScrollContainer/VBoxContainer)
			newbutton.dragdata = i
			newbutton.get_node("icon").texture = i.get_icon()
			if newbutton.get_node('icon').texture == null:
				if i.has_profession('master'):
					newbutton.get_node('icon').texture = images.icons.class_master
				elif i.get_stat('slave_class') == 'servant':
					newbutton.get_node('icon').texture = images.icons.class_servant
				else:
					newbutton.get_node('icon').texture = images.icons.class_slave
			newbutton.get_node("Label").text = i.get_short_name()
			newbutton.connect("pressed", self, "return_character", [i])
			if active_location.group.values().has(i.id):
				newbutton.get_node("icon").modulate = Color(0.3,0.3,0.3)
			globals.connectslavetooltip(newbutton, i)
	
	build_item_panel()
	build_spell_panel()

var panelmode = 'items'
var panelmodes = {item = {name = "Items", code = 'items'}, spells = {name = 'Spells', code = 'spells'}}
var panelmodesarray = ['items','spells']

func switch_panel():
	match panelmode:
		'spells':
			$LocationGui/ItemUsePanel/Button.text = panelmodes.item.name
			$LocationGui/ItemUsePanel/ScrollContainer.show()
			$LocationGui/ItemUsePanel/SpellContainer.hide()
			panelmode = 'items'
		'items':
			$LocationGui/ItemUsePanel/Button.text = panelmodes.spells.name
			$LocationGui/ItemUsePanel/ScrollContainer.hide()
			$LocationGui/ItemUsePanel/SpellContainer.show()
			panelmode = 'spells'

func build_item_panel():
	input_handler.ClearContainer($LocationGui/ItemUsePanel/ScrollContainer/VBoxContainer)
	var tutorial_items = false
	for i in ResourceScripts.game_res.items.values():
		if Items.itemlist[i.itembase].has('explor_effect') == false:
			continue
		var newnode = input_handler.DuplicateContainerTemplate($LocationGui/ItemUsePanel/ScrollContainer/VBoxContainer)
		i.set_icon(newnode.get_node("Icon"))
		#newnode.get_node("Label").text = i.name
		newnode.get_node("amount").text = str(i.amount)
		newnode.dragdata = i
		globals.connectitemtooltip(newnode, i)
		tutorial_items = true
	if tutorial_items == true:
		input_handler.ActivateTutorial("exploration_items")

func build_spell_panel():
	input_handler.ClearContainer($LocationGui/ItemUsePanel/SpellContainer/VBoxContainer)
	for id in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[id]
		if person.check_location(active_location.id, true):
			for i in person.skills.combat_skills:
				var skill = Skilldata.Skilllist[i]
				if skill.tags.has('exploration') == false:
					continue
				var newnode = input_handler.DuplicateContainerTemplate($LocationGui/ItemUsePanel/SpellContainer/VBoxContainer)
				newnode.get_node('Icon').texture = skill.icon
				newnode.get_node("name").text = skill.name
				newnode.get_node("castername").text = person.get_short_name()
				var text = skill.descript
				var disabled = false
				if skill.manacost > 0:
					text += "\n\nMana cost: " + str(skill.manacost) + " (" + str(floor(person.mp)) + ")"
				if skill.catalysts.empty() == false:
					text += '\n\nRequired Catalysts: '
					for k in skill.catalysts:
						text += "\n"+ Items.materiallist[k].name + ": " + str(skill.catalysts[k]) + " (" + str(ResourceScripts.game_res.materials[k]) + ")"
						if ResourceScripts.game_res.materials[k] < skill.catalysts[k]:
							disabled = true
				globals.connecttexttooltip(newnode, text)
				newnode.dragdata = {skill = skill, caster = person}
				if person.mp < skill.manacost:
					disabled = true
					
				if disabled == true:
					#newnode.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
					newnode.get_node("name").set("custom_colors/font_color", Color(1,0.5,0.5))
					newnode.script = null
				#globals.connectskilltooltip(newnode, skill.code, person)


func show_heal_items(position):
	if get_node(positiondict[position] + "/Image").visible == true:
		input_handler.MousePositionScripts.append({nodes = [$LocationGui/Positions/itemusepanel, get_node(positiondict[position] + "/Image")], targetnode = self, script = 'hide_heal_items'})
		$LocationGui/Positions/itemusepanel.show()
		$LocationGui/Positions/itemusepanel.rect_global_position.y = get_node(positiondict[position] + "/Image").rect_global_position.y - $LocationGui/Positions/itemusepanel.rect_size.y
		input_handler.ClearContainer($LocationGui/Positions/itemusepanel/GridContainer)
		for i in ResourceScripts.game_res.items.values():
			if Items.itemlist[i.itembase].has('explor_effect') == false:
				continue
			var newbutton = input_handler.DuplicateContainerTemplate($LocationGui/Positions/itemusepanel/GridContainer)
			newbutton.get_node("Label").text = str(i.amount)
			i.set_icon(newbutton)
			newbutton.hint_tooltip = i.description
			#globals.connectitemtooltip(newbutton, i)
			newbutton.connect("pressed", self, "use_item_on_character", [position, i])
		
		var character = ResourceScripts.game_party.characters[active_location.group['pos'+str(position)]]
		for i in character.combat_skills:
			var skill = Skilldata.Skilllist[i]
			if skill.tags.has('exploration') == false:
				continue
			var newbutton = input_handler.DuplicateContainerTemplate($LocationGui/LocationGui/Positions/itemusepanel/GridContainer)
			#newbutton.get_node("Label").text = str(i.amount)
			newbutton.texture_normal = skill.icon
			newbutton.hint_tooltip = skill.descript
			if skill.manacost > 0:
				newbutton.hint_tooltip += "\nMana Cost: " + str(skill.manacost)
			for k in skill.catalysts:
				if ResourceScripts.game_res.materials[k] < skill.catalysts[k]:
					newbutton.disabled = true
					newbutton.material = load("res://assets/sfx/bw_shader.tres")
					newbutton.hint_tooltip += "\nMissing catalyst: " + Items.materiallist[k].name
				elif i.mp < skill.manacost:
					newbutton.disabled = true
					newbutton.material = load("res://assets/sfx/bw_shader.tres")
					newbutton.hint_tooltip += "\nNot enough mana: " + Items.materiallist[k].name
			newbutton.connect("pressed", self, "use_skill_explore", [character, skill])

#		elif i.travel_target.location == active_location.id:
#			newbutton = input_handler.DuplicateContainerTemplate($LocationGui/PresentedSlavesPanel/ScrollContainer/VBoxContainer)
#			newbutton.get_node("icon").texture = i.get_icon()
#			newbutton.get_node("Label").text = i.get_short_name() + ": Arriving in " + str(round(i.travel_time / i.travel_tick())) + " hours."
#			newbutton.disabled = true

#func return_character(character):
#	selectedperson = character
#	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'return_character_confirm', character.translate("Send [name] back?")])
	#input_handler.ShowConfirmPanel(self,'return_character_confirm',character.translate("Send [name] back?"))

#func return_character_confirm():
#	if variables.instant_travel == false:
#		selectedperson.location = 'travel'
#		selectedperson.travel_target = {area = '', location = 'mansion'}
#		selectedperson.travel_time = active_area.travel_time + active_location.travel_time
#	else:
#		selectedperson.location = 'mansion'
#		selectedperson.return_to_task()
#	for i in active_location.group:
#		if active_location.group[i] == selectedperson.id:
#			active_location.group.erase(i)
#	build_location_group()


#func selectfighter(position):
#	pos = 'pos'+str(position)
#	var reqs = [{code = 'is_at_location', value = active_location.id}]
#	if variables.allow_remote_intereaction == true: reqs = []
#	input_handler.ShowSlaveSelectPanel(self, 'slave_position_selected', reqs, true)

func slave_position_selected(pos, character):
	pos = 'pos'+str(pos)
	if character == null:
		active_location.group.erase(pos)
		build_location_group()
		return
	character = character.id
	var positiontaken = false
	var oldheroposition = null
	if active_location.group.has(pos) && ResourceScripts.game_party.characters[active_location.group[pos]].check_location(active_location.id, true):
		positiontaken = true
	
	for i in active_location.group:
		if active_location.group[i] == character:
			oldheroposition = i
			active_location.group.erase(i)
	
	if oldheroposition != null && positiontaken == true && oldheroposition != pos:
		active_location.group[oldheroposition] = active_location.group[pos]
	
	active_location.group[pos] = character
	build_location_group()

func slave_position_deselect(character):
#	if !character is Slave:
#		return
	for i in active_location.group:
		if active_location.group[i] == character.id:
			active_location.group.erase(i)
			break
	build_location_group()

#func UpdatePositions():
#	for i in positiondict.values():
#		get_node(i+'/Image').hide()
#
#	for i in ResourceScripts.game_party.combatparty:
#		if ResourceScripts.game_party.combatparty[i] != null:
#			get_node(positiondict[i] + "/Image").texture = state.heroes[state.combatparty[i]].portrait()
#			get_node(positiondict[i] + "/Image").show()
#	$AreaProgress/ProceedButton.disabled = state.if_party_level('lte', 0)
#	if $AreaProgress/ProceedButton.disabled:
#		$AreaProgress/ProceedButton.hint_tooltip = "You must assign party before venturing"
#	else:
#		$AreaProgress/ProceedButton.hint_tooltip = ''

#Combat/explore functions

func start_skirmish():
	if globals.check_location_group() == false:
		input_handler.SystemMessage("Select at least 1 character before proceeding.")
		return
	check_events('skirmish_initiate')
	

func enter_dungeon():
	check_events('enter')
	var completed_floors = active_location.progress.level
	input_handler.ClearContainer($LocationGui/ScrollContainer/VBoxContainer)
	
	var newbutton
	
	while completed_floors > 0:
		newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
		newbutton.text = 'Level: ' + str(completed_floors)
		if active_location.progress.level > completed_floors || (active_location.progress.level == completed_floors && active_location.progress.stage >= active_location.levels["L"+str(active_location.progress.level)].stages):
			newbutton.text += "(completed)"
		newbutton.connect("pressed",self,"enter_level", [completed_floors])
		completed_floors -= 1
	
#	newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
#	newbutton.text = 'Test'
#	newbutton.connect("pressed",self,"testshow")

func testshow():
	print(active_location.group)
	build_location_group()

var action_type
var current_level = 1
var current_stage = 0

func enter_level(level, skip_to_end = false):
	current_level = level
	if skip_to_end == true:
		current_level = active_location.levels.size()
		active_location.progress.level = current_level
		current_stage = active_location.levels["L" + str(active_location.levels.size())].stages-1
		active_location.progress.stage = current_stage
	if active_location.progress.level < level:
		active_location.progress.level = level
		active_location.progress.stage = 0
	
	if check_events('enter_level') == true:
		yield(input_handler, 'EventFinished')
	
	input_handler.ClearContainer($LocationGui/ScrollContainer/VBoxContainer)
	var newbutton
	if active_location.progress.level == level && active_location.progress.stage < active_location.levels["L"+str(level)].stages:
		newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
		newbutton.text = 'Advance'
		newbutton.connect("pressed",self,"area_advance",['advance'])
	elif active_location.progress.level == level && active_location.progress.stage >= active_location.levels["L"+str(level)].stages:
		if active_location.levels.has("L"+str(level + 1)) == true:
			newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
			newbutton.text = 'Move to the next level'
			newbutton.connect("pressed",self,"enter_level",[level+1])
		else:
			newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
			newbutton.text = 'Complete location'
			newbutton.connect("pressed",self,"clear_dungeon")
	
	if variables.allow_skip_fights:
		newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
		newbutton.text = 'Skip to last room'
		newbutton.connect("pressed",self,"enter_level", [level, true])
	
	newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
	newbutton.text = 'Roam'
	newbutton.connect("pressed",self,"area_advance",['roam'])
	
	newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
	newbutton.text = 'Return'
	newbutton.connect("pressed",self,"enter_dungeon")
	build_location_group()
	build_location_description()

func area_advance(mode):
	if globals.check_location_group() == false:
		input_handler.SystemMessage("Select at least 1 character before advancing. ")
		return
	match mode:
		'advance':
			current_stage = active_location.progress.stage
		'roam':
			current_stage = 0
	if check_events(mode) == true:
		yield(input_handler, 'EventFinished')
	
	action_type = mode
	
	StartCombat()



func finish_combat():
	if action_type == 'advance':
		active_location.progress.stage += 1
		enter_level(active_location.progress.level)
	elif action_type == 'location_finish':
#		leave_location()
		#update_categories()
		build_accessible_locations()
		select_location("Aliron")
	else:
		enter_level(current_level)

func clear_dungeon():
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'clear_dungeon_confirm', "Finish exploring this location? Your party will be sent back and the location will be removed from the list. "])
	#input_handler.ShowConfirmPanel(self, "clear_dungeon_confirm", "Finish exploring this location? Your party will be sent back and the location will be removed from the list. ")

func clear_dungeon_confirm():
	input_handler.remove_location(active_location.id)
	check_events('complete_location')
	action_type = 'location_finish'
	select_location('Aliron')
	build_accessible_locations()
#	leave_location()
	

#func leave_location():
#	select_category(selectedcategory)

func check_events(action):
	return globals.check_events(action)

func start_scene(scene):
	input_handler.interactive_message(scene.code, 'event_selection', scene.args)

func finish_quest_dungeon(args):
	input_handler.interactive_message('finish_quest_dungeon', 'quest_finish_event', {locationname = active_location.name})

func check_event_reqs(reqs):
	return globals.check_event_reqs(reqs)

func check_random_event():
	return globals.check_random_event()

func StartCombat():
	globals.current_level = current_level
	globals.current_stage = current_stage
	globals.StartCombat()

func combat_defeat():
	for i in active_location.group:
		if ResourceScripts.game_party.characters.has(active_location.group[i]) && ResourceScripts.game_party.characters[active_location.group[i]].hp <= 0:
			ResourceScripts.game_party.characters[active_location.group[i]].hp = 1
			ResourceScripts.game_party.characters[active_location.group[i]].defeated = false
			ResourceScripts.game_party.characters[active_location.group[i]].is_active = true
	enter_level(current_level)

func get_party():
	var res = []
	for ch in active_location.group.values():
		if ResourceScripts.game_party.characters[ch] != null: res.push_back(ResourceScripts.game_party.characters[ch])
	return res



func use_e_combat_skill(caster, target, skill):
#	var skill = active_skill
#	var caster = active_character
	#allowaction = false

#	if activeitem:
#		combatlogadd("\n" + caster.name + ' uses ' + activeitem.name + ". ")
#	else:
#		combatlogadd("\n" + caster.name + ' uses ' + skill.name + ". ")
	caster.mp -= skill.manacost
	
#	if skill.combatcooldown > 0:
#		caster.combat_cooldowns[skill_code] = skill.combatcooldown
	
	for i in skill.catalysts:
		ResourceScripts.game_res.materials[i] -= skill.catalysts[i]
#	if skill.charges > 0:
#		if caster.combat_skill_charges.has(skill.code):
#			caster.combat_skill_charges[skill.code] += 1
#		else:
#			caster.combat_skill_charges[skill.code] = 1
#		caster.daily_cooldowns[skill_code] = skill.cooldown
#not sure about potential of those in explore
#	if skill.ability_type == 'skill':
#		caster.physics += rand_range(0.3,0.5)
#	elif skill.ability_type == 'spell':
#		caster.wits += rand_range(0.3,0.5)
	#caster part of setup
	var s_skill1 = ResourceScripts.scriptdict.class_sskill.new()
	s_skill1.createfromskill(skill.code)
	s_skill1.setup_caster(caster)
	#s_skill1.setup_target(target)
	s_skill1.process_event(variables.TR_CAST)
	caster.process_event(variables.TR_CAST)
	for e in caster.triggered_effects:
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if eff.req_skill:
			eff.set_args('skill', s_skill1)
			eff.process_event(variables.TR_CAST)
			eff.set_args('skill', null)

	#preparing animations
#	var animations = skill.sfx
#	var animationdict = {windup = [], predamage = [], postdamage = []}
	#sort animations
#	for i in animations:
#		animationdict[i.period].append(i)
	#casteranimations
	#for sure at windup there should not be real_target-related animations
#	if skill.has('sounddata') and !skill.sounddata.empty() and skill.sounddata.initiate != null:
#		caster.displaynode.process_sound(skill.sounddata.initiate)
#	for i in animationdict.windup:
#		var sfxtarget = ProcessSfxTarget(i.target, caster, target)
#		sfxtarget.process_sfx(i.code)
	#skill's repeat cycle of predamage-damage-postdamage
	var targets
	for n in range(s_skill1.repeat):
		#get all affected targets
		#simplified version
		match skill.target_number:
			'single':
				targets = [target]
			'all':
				targets = get_party()
		#targets = CalculateTargets(skill, target) 
		#preparing real_target processing, predamage animations
		var s_skill2_list = []
		for i in targets:
#			if skill.has('sounddata') and !skill.sounddata.empty() and skill.sounddata.strike != null:
#				if skill.sounddata.strike == 'weapon':
#					caster.displaynode.process_sound(get_weapon_sound(caster))
#				else:
#					caster.displaynode.process_sound(skill.sounddata.strike)
#			for j in animationdict.predamage:
#				var sfxtarget = ProcessSfxTarget(j.target, caster, i)
#				sfxtarget.process_sfx(j.code)
#			#special results
#			if skill.damage_type == 'summon':
#				summon(skill.value[0], skill.value[1]);
			if skill.has('damage_type') and skill.damage_type == 'resurrect':
				i.resurrect(input_handler.calculate_number_from_string_array(skill.value[0], caster, target)) #not sure
			else: 
				#default skill result
				var s_skill2 = s_skill1.clone()
				s_skill2.setup_target(i)
				#place for non-existing another trigger
				s_skill2.setup_final()
				s_skill2.hit_roll()
				s_skill2.resolve_value(true)
				s_skill2_list.push_back(s_skill2)
		#predamage triggers
		for s_skill2 in s_skill2_list:
			s_skill2.process_event(variables.TR_HIT)
			s_skill2.caster.process_event(variables.TR_HIT)
			for e in s_skill2.caster.triggered_effects:
				var eff:triggered_effect = effects_pool.get_effect_by_id(e)
				if eff.req_skill:
					eff.set_args('skill', s_skill2)
					eff.process_event(variables.TR_HIT)
					eff.set_args('skill', null)
			s_skill2.target.process_event(variables.TR_DEF)
			for e in s_skill2.target.triggered_effects:
				var eff:triggered_effect = effects_pool.get_effect_by_id(e)
				if eff.req_skill:
					eff.set_args('skill', s_skill2)
					eff.process_event(variables.TR_DEF) 
					eff.set_args('skill', null)
			s_skill2.setup_effects_final()
		#damage
		for s_skill2 in s_skill2_list:
			#check miss
			if s_skill2.hit_res == variables.RES_MISS:
#				s_skill2.target.play_sfx('miss')
#				combatlogadd(target.name + " evades the damage.")
				pass
			else:
				#hit landed animation
#				if skill.has('sounddata') and !skill.sounddata.empty() and skill.sounddata.hit != null:
#					if skill.sounddata.hittype == 'absolute':
#						s_skill2.target.displaynode.process_sound(skill.sounddata.hit)
#					elif skill.sounddata.hittype == 'bodyarmor':
#						s_skill2.target.displaynode.process_sound(calculate_hit_sound(skill, caster, s_skill2.target))
#				for j in animationdict.postdamage:
#					var sfxtarget = ProcessSfxTarget(j.target, caster, s_skill2.target)
#					sfxtarget.process_sfx(j.code)
				#applying resists
				s_skill2.calculate_dmg()
				#logging result & dealing damage
				execute_skill(s_skill2)
		#postdamage triggers and cleanup real_target s_skills
		for s_skill2 in s_skill2_list:
			s_skill2.process_event(variables.TR_POSTDAMAGE)
			s_skill2.caster.process_event(variables.TR_POSTDAMAGE)
			for e in s_skill2.caster.triggered_effects:
				var eff:triggered_effect = effects_pool.get_effect_by_id(e)
				if eff.req_skill:
					eff.set_args('skill', s_skill2)
					eff.process_event(variables.TR_POSTDAMAGE)
					eff.set_args('skill', null)
			if s_skill2.target.hp <= 0:
				s_skill2.process_event(variables.TR_KILL)
				if typeof(caster) != TYPE_DICTIONARY: s_skill2.caster.process_event(variables.TR_KILL)
				for e in s_skill2.caster.triggered_effects:
					var eff:triggered_effect = effects_pool.get_effect_by_id(e)
					if eff.req_skill:
						eff.set_args('skill', s_skill2)
						eff.process_event(variables.TR_KILL)
						eff.set_args('skill', null)
			#s_skill2.target.displaynode.rebuildbuffs()
#			checkdeaths()
#			if s_skill2.target.displaynode != null:
#				s_skill2.target.displaynode.rebuildbuffs()
			s_skill2.remove_effects()
	s_skill1.process_event(variables.TR_SKILL_FINISH)
	caster.process_event(variables.TR_SKILL_FINISH)
	for e in caster.triggered_effects:
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if eff.req_skill:
			eff.set_args('skill', s_skill1)
			eff.process_event(variables.TR_SKILL_FINISH)
			eff.set_args('skill', null)
	s_skill1.remove_effects()
	for i in skill.sounddata.values():
		if i != null: input_handler.PlaySound(i)
	#follow-up
	if skill.has('follow_up'):
		active_skill = skill.followup
		use_e_combat_skill(caster, target, skill)
	build_location_group()


func execute_skill(s_skill2): #to update to exploration version
	var text = ''
	if s_skill2.hit_res == variables.RES_CRIT:
		text += "[color=yellow]Critical!![/color] "
		#s_skill2.target.displaynode.process_critical()
	for i in s_skill2.value:
		if i.damagestat == 'no_stat': continue #for skill values that directly process into effects
		if i.damagestat == 'damage_hp' and i.dmgf == 0: #drain, damage, damage no log, drain no log
			if i.is_drain && s_skill2.tags.has('no_log'):
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
				var rval2 = s_skill2.caster.heal(rval)
			elif i.is_drain:
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
				var rval2 = s_skill2.caster.heal(rval)
				text += "%s drained %d health from %s and gained %d health." %[s_skill2.caster.get_stat('name'), rval, s_skill2.target.get_stat('name'), rval2]
			elif s_skill2.tags.has('no_log') && !i.is_drain:
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
			else:
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
				text += "%s is hit for %d damage. " %[s_skill2.target.get_stat('name'), rval]#, s_skill2.value[i]] 
		elif i.damagestat == 'damage_hp' and i.dmgf == 1: #heal, heal no log
			if s_skill2.tags.has('no_log'):
				var rval = s_skill2.target.heal(i.value)
			else:
				var rval = s_skill2.target.heal(i.value)
				text += "%s is healed for %d health." %[s_skill2.target.get_stat('name'), rval]
		elif i.damagestat == 'restore_mana' and i.dmgf == 0: #heal, heal no log
			if !s_skill2.tags.has('no log'):
				var rval = s_skill2.target.mana_update(i.value)
				text += "%s restored %d mana." %[s_skill2.target.get_stat('name'), rval] 
			else:
				s_skill2.target.mana_update(i.value)
		elif i.damagestat == 'restore_mana' and i.dmgf == 1: #drain, damage, damage no log, drain no log
			var rval = s_skill2.target.mana_update(-i.value)
			if i.is_drain:
				var rval2 = s_skill2.caster.mana_update(rval)
				if !s_skill2.tags.has('no log'):
					text += "%s drained %d mana from %s and gained %d mana." %[s_skill2.caster.get_stat('name'), rval, s_skill2.target.name, rval2]
			if !s_skill2.tags.has('no log'):
				text += "%s lost %d mana." %[s_skill2.target.get_stat('name'), rval] 
		else: 
			var mod = i.dmgf
			var stat = i.damagestat
			if mod == 0:
				var rval = s_skill2.target.stat_update(stat, i.value)
				if !s_skill2.tags.has('no log'):
					text += "%s restored %d %s." %[s_skill2.target.get_stat('name'), rval, tr(stat)] 
			elif mod == 1:
				var rval = s_skill2.target.stat_update(stat, -i.value)
				if i.is_drain:
					var rval2 = s_skill2.caster.stat_update(stat, -rval)
					if !s_skill2.tags.has('no log'):
						text += "%s drained %d %s from %s." %[s_skill2.caster.get_stat('name'), i.value, tr(stat),  s_skill2.target.get_stat('name')]
				elif !s_skill2.tags.has('no log'):
					text += "%s loses %d %s." %[s_skill2.target.get_stat('name'), -rval, tr(stat)]
			elif mod == 2:
				var rval = s_skill2.target.stat_update(stat, i.value, true)
				if i.is_drain:# use this on your own risk
					var rval2 = s_skill2.caster.stat_update(stat, -rval)
					if !s_skill2.tags.has('no log'):
						text += "%s drained %d %s from %s." %[s_skill2.caster.get_stat('name'), i.value, tr(stat),  s_skill2.target.get_stat('name')]
				elif !s_skill2.tags.has('no log'):
					text += "%s's %s is now %d." %[s_skill2.target.get_stat('name'), tr(stat), i.value] 
			else: print('error in damagestat %s' % i.damagestat) #obsolete in new format

