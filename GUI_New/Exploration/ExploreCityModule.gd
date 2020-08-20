extends Panel
onready var City = $ScrollContainer/VBoxContainer
onready var Guild = $GuildMenu/VBoxContainer
onready var Shop = get_parent().get_node("ExploreShopModule")
onready var SlaveMarket = get_parent().get_node("ExploreHireModule")
var opened_guild = {code = ""}




func open_city(city):
	var expnode = get_parent()
	expnode.get_node("LocationGui").hide()
	show()

	expnode.active_area = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[city].area]
	expnode.active_location = {}
	input_handler.active_area = expnode.active_area
	expnode.selected_location = city
	expnode.get_node("TextureRect").texture = images.backgrounds[expnode.active_area.capital_background]
	if expnode.active_area.has('capital_background_noise'):
		input_handler.PlayBackgroundSound(expnode.active_area.capital_background_noise)
	if expnode.active_area.has('capital_background_music'):
		input_handler.SetMusic(expnode.active_area.capital_background_music)
	if expnode.active_area.has("capital_dynamic_background"):
		expnode.get_node("VideoPlayer").open(expnode.active_area.capital_dynamic_background)
	input_handler.ClearContainer(City)
	input_handler.ClearContainer(Guild)
	input_handler.ClearContainer($AreaEvents)
	$GuildMenuBG.hide()
	var array = []
	for i in expnode.active_area.factions.values():
		array.append(i)

	array.sort_custom(self, 'sort_factions')

	var newbutton
	for i in array:
		newbutton = input_handler.DuplicateContainerTemplate(City)
		newbutton.get_node("Label").text = i.name
		if i.code == "slavemarket":
			newbutton.connect("pressed", expnode.Hire, "open_slave_market", [i])
			newbutton.set_meta("slavemarket", true)
			newbutton.texture_normal = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city.png")
			newbutton.texture_hover = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city_hover.png")
			newbutton.texture_pressed = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city_pressed.png")
			newbutton.get_node("Label").rect_position.x = 0
			newbutton.get_node("Label").rect_size.x = 272
			newbutton.get_node("Label").get("custom_fonts/font").set_size(30)
			newbutton.get_node("Icon").hide()
		else:
			newbutton.get_node("Icon").texture = worlddata.factiondata[i.code].icon
			newbutton.connect("pressed", self, "enter_guild", [i])
		newbutton.set_meta("guild", i)
	newbutton = input_handler.DuplicateContainerTemplate(City)
	newbutton.get_node("Label").text = "Shop"
	newbutton.connect("pressed", expnode.Shop, "open_shop", ['area'])
	newbutton.set_meta("shop", true)
	newbutton.texture_normal = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city.png")
	newbutton.texture_hover = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city_hover.png")
	newbutton.texture_pressed = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city_pressed.png")
	newbutton.get_node("Label").rect_position.x = 0
	newbutton.get_node("Label").rect_size.x = 272
	newbutton.get_node("Label").get("custom_fonts/font").set_size(30)
	newbutton.get_node("Icon").hide()
	for i in expnode.active_area.capital_options:
		newbutton = input_handler.DuplicateContainerTemplate(City)
		newbutton.get_node("Label").text = expnode.city_options[i]
		newbutton.connect("pressed", self, i)
		newbutton.set_meta(i, true)
		newbutton.texture_normal = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city.png")
		newbutton.texture_hover = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city_hover.png")
		newbutton.texture_pressed = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city_pressed.png")
		newbutton.get_node("Label").rect_position.x = 0
		newbutton.get_node("Label").rect_size.x = 272
		newbutton.get_node("Label").get("custom_fonts/font").set_size(30)
		newbutton.get_node("Icon").hide()

	for i in expnode.active_area.events:
		if globals.checkreqs(i.reqs) == false:
			continue
		newbutton = input_handler.DuplicateContainerTemplate($AreaEvents)
		newbutton.get_node("Label").text = i.text
		newbutton.connect("pressed", input_handler, "interactive_message", [i.code, 'area_oneshot_event', i.args])
		newbutton.connect("pressed", self, "open_city", [city])
		# newbutton.modulate = Color(0.5, 0.8, 0.5)
		# newbutton.texture_normal = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city.png")
		# newbutton.texture_hover = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city_hover.png")
		# newbutton.texture_pressed = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city_pressed.png")
		# newbutton.get_node("Label").rect_position.x = 0
		# newbutton.get_node("Label").rect_size.x = 272
		# newbutton.get_node("Label").get("custom_fonts/font").set_size(24)

func update_buttons(meta = null):
	for button in City.get_children():
		if meta == "slavemarket":
			if button.has_meta("guild") && !button.has_meta(meta):
				button.pressed = false
			if button.has_meta("quest_board"):
				button.pressed = false
			if button.has_meta("shop"):
				button.pressed = false
		elif meta == "shop":
			if button.has_meta("guild") && !button.has_meta(meta):
				button.pressed = false
			if button.has_meta("quest_board"):
				button.pressed = false
		elif meta == "quest_board":
			if !button.has_meta(meta):
				button.pressed = false
		else:
			button.pressed = false
#		if !button.has_meta(meta):
#			continue
#		if !button.get_meta(meta):
#			button.pressed = false


func update():
	for button in Guild.get_children():
		if button.has_meta("dialogue_event"):
			continue
		if button.has_meta("action"):
			if button.get_meta("action") == "Hire":
				if get_parent().Hire.mode == "guild_slaves":
					button.pressed = false
				else:
					button.pressed = get_parent().Hire.is_visible()
			if button.get_meta("action") == "Upgrades":
				button.pressed = get_parent().FactionDetails.is_visible()

	for button in City.get_children():
		if button.has_meta("slavemarket"):
			if get_parent().Hire.mode == "guild_slaves":
				button.pressed = false
			else:
				button.pressed = get_parent().Hire.is_visible()
			get_parent().Hire.is_slave_market_opened = get_parent().Hire.is_visible()
		if button.has_meta("shop"):
			button.pressed = get_parent().Shop.is_visible()
			get_parent().Shop.is_shop_opened = get_parent().Shop.is_visible()
		if button.has_meta("quest_board"):
			button.pressed = get_parent().QuestBoard.is_visible()
			get_parent().QuestBoard.is_quest_board_opened = get_parent().QuestBoard.is_visible()
	var height = get_node("ScrollContainer/VBoxContainer").get_child(get_node("ScrollContainer/VBoxContainer").get_child_count() - 1).get_global_rect().end.y
	self.rect_size.y = height
	# get_node("ScrollContainer/VBoxContainer").rect_size.y = height - get_parent().BUTTON_HEIGHT * 2
	# self.rect_position.y = 1080 - (height - get_parent().BUTTON_HEIGHT * 2) - 15 # 15 px shift from bottom edge


func enter_guild(guild):
	update_buttons("guild")
	Shop.is_shop_opened = false
	SlaveMarket.is_slave_market_opened = false
	get_parent().QuestBoard.is_quest_board_opened = false
	get_parent().clear_submodules()
	if opened_guild.code == guild.code && get_tree().get_root().get_node_or_null("dialogue") && !get_tree().get_root().get_node("dialogue").is_visible():
		ResourceScripts.core_animations.FadeAnimation(get_parent().get_node("GuildBG"),0.5)
		Guild.hide()
		$GuildMenuBG.hide()
		yield(get_tree().create_timer(0.5), "timeout")
		get_parent().get_node("GuildBG").hide()
		opened_guild = {code = ""}
		return
	else:
		# if !get_parent().get_node("GuildBG").visible:
		var dialogue = get_tree().get_root().get_node_or_null("dialogue")
		if dialogue != null && !dialogue.is_visible():
			ResourceScripts.core_animations.UnfadeAnimation(get_parent().get_node("GuildBG"),0.5)
		get_parent().get_node("GuildBG").texture = images.backgrounds[guild.background]
		get_parent().Hire.mode = "guild_slaves"
		Guild.show()
		$GuildMenuBG.show()
		get_parent().get_node("GuildBG").show()
		opened_guild = guild
		var selected_location = get_parent().selected_location
		get_parent().active_area = ResourceScripts.game_world.areas[guild.area]
		get_parent().active_faction = guild
	#	$ShopPanel.hide()
		input_handler.active_faction = guild
		input_handler.ClearContainer(Guild)
		var newbutton
		if get_parent().active_faction.has('events'):
			for i in get_parent().active_faction.events:
				var events = scenedata.dialogue_inits[i]
				var event
				for k in events:
					if globals.checkreqs(k.reqs):
						event = k
						break
				if event == null:
					continue
				newbutton = input_handler.DuplicateContainerTemplate(Guild)
				newbutton.get_node("Label").text = event.name
				newbutton.set_meta("dialogue_event", true)
				newbutton.connect(
					"pressed",
					input_handler,
					"interactive_dialogue_start",
					[event.target, event.target_option]
				)
				newbutton.texture_normal = load("res://assets/Textures_v2/CITY/Buttons/buttonmagenta.png")
				newbutton.texture_pressed = load("res://assets/Textures_v2/CITY/Buttons/buttonmagenta_pressed.png")
				newbutton.texture_hover = load("res://assets/Textures_v2/CITY/Buttons/buttonmagenta_hover.png")
		for i in guild.actions:
			newbutton = input_handler.DuplicateContainerTemplate(Guild)
			newbutton.get_node("Label").text = get_parent().faction_actions[i]
			newbutton.set_meta("action", get_parent().faction_actions[i])
			newbutton.connect("pressed", get_parent(), "faction_" + i)
		# newbutton = input_handler.DuplicateContainerTemplate(Guild)
		# newbutton.text = "Leave"
		# newbutton.connect("pressed", self, "open_city", [selected_location])
	for button in City.get_children():
		if button.name == "Button" || !button.has_meta("guild"):
			continue
		button.pressed = button.get_meta("guild") == guild



func quest_board():
	get_parent().QuestBoard.quest_board()


func location_purchase():
	get_parent().Hire.hide()
	get_parent().QuestBoard.hide()
	get_parent().Shop.hide()
	get_parent().Upgrades.hide()
	get_parent().FactionDetails.hide()
	get_parent().FullSlaveInfo.hide()
	input_handler.ClearContainer(City)
	for i in worlddata.dungeons.values():
		if i.type != 'dungeon':
			continue
	#for i in purch_location_list.values():
		var newbutton = input_handler.DuplicateContainerTemplate(City)
		newbutton.get_node("Label").text = i.classname + ": " + str(i.puchase_price) + " gold"
		newbutton.connect("pressed", self, 'purchase_location', [i])
		newbutton.texture_normal = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city.png")
		newbutton.texture_hover = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city_hover.png")
		newbutton.texture_pressed = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city_pressed.png")
		newbutton.texture_disabled = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city_disabled.png")
		newbutton.get_node("Label").rect_position.x = 0
		newbutton.get_node("Label").rect_size.x = 272
		newbutton.get_node("Label").get("custom_fonts/font").set_size(20)
		newbutton.get_node("Icon").hide()
		if ResourceScripts.game_res.money < i.puchase_price:
			newbutton.disabled = true
	var newbutton = input_handler.DuplicateContainerTemplate(City)
	newbutton.get_node("Label").text = "Leave"
	newbutton.texture_normal = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city.png")
	newbutton.texture_hover = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city_hover.png")
	newbutton.texture_pressed = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city_pressed.png")
	newbutton.get_node("Label").rect_position.x = 0
	newbutton.get_node("Label").rect_size.x = 272
	newbutton.get_node("Label").get("custom_fonts/font").set_size(20)
	newbutton.get_node("Icon").hide()
	newbutton.connect("pressed", self, "open_city", [get_parent().selected_location])

	Guild.hide()
	$GuildMenuBG.hide()
	if get_parent().get_node("GuildBG").is_visible():
		ResourceScripts.core_animations.FadeAnimation(get_parent().get_node("GuildBG"),0.5)
		yield(get_tree().create_timer(0.5), "timeout")
	get_parent().get_node("GuildBG").hide()
	opened_guild = {code = ""}


func purchase_location(purchasing_location):
	if purchasing_location.has('purchase_area'):
		get_parent().active_area = ResourceScripts.game_world.areas[purchasing_location.purchase_area]
	if get_parent().active_area.locations.size() < 8:
		var randomlocation = []
		for i in get_parent().active_area.locationpool:
			randomlocation.append(worlddata.dungeons[i].code)
		#randomlocation = randomlocation[randi()%randomlocation.size()]
		randomlocation = ResourceScripts.world_gen.make_location(purchasing_location.code, get_parent().active_area)
		input_handler.active_location = randomlocation
		input_handler.active_area = get_parent().active_area
		get_parent().active_area.locations[randomlocation.id] = randomlocation
		ResourceScripts.game_world.location_links[randomlocation.id] = {area = get_parent().active_area.code, category = 'locations'} 
		ResourceScripts.game_res.money -= purchasing_location.puchase_price
		input_handler.interactive_message('purchase_dungeon_location', 'location_purchase_event', {})
	else:
		input_handler.SystemMessage("Can't purchase anymore")
	location_purchase()

var guild_order = ['fighters','workers','servants','mages','slavemarket']

func sort_factions(first, second):
	if guild_order.has(first.code):
		if guild_order.has(second.code):
			return  guild_order.find(first.code) < guild_order.find(second.code)
		else:
			return true
