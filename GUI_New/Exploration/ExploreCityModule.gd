extends Panel
onready var City = $ScrollContainer/VBoxContainer
onready var Guild = $GuildMenu/VBoxContainer
onready var Shop = get_parent().get_node("ExploreShopModule")
onready var SlaveMarket = get_parent().get_node("ExploreHireModule")
var opened_guild = {code = ""}


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Shop:" + str(Shop))


func open_city(city):
	ResourceScripts.core_animations.BlackScreenTransition()
	yield(get_tree().create_timer(0.5), 'timeout')
	get_parent().active_area = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[city].area]
	get_parent().active_location = {}
	input_handler.active_area = get_parent().active_area
	get_parent().selected_location = city
	get_parent().get_node("TextureRect").texture = images.backgrounds[get_parent().active_area.capital_background]
	if get_parent().active_area.has('capital_background_noise'):
		input_handler.PlayBackgroundSound(get_parent().active_area.capital_background_noise)
	if get_parent().active_area.has('capital_background_music'):
		input_handler.SetMusic(get_parent().active_area.capital_background_music)
	if get_parent().active_area.has("capital_dynamic_background"):
		get_parent().get_node("VideoPlayer").open(get_parent().active_area.capital_dynamic_background)
	input_handler.ClearContainer(City)
	var array = []
	for i in get_parent().active_area.factions.values():
		array.append(i)

	array.sort_custom(self, 'sort_factions')

	var newbutton
	for i in array:
		print(i.code)
		newbutton = input_handler.DuplicateContainerTemplate(City)
		newbutton.get_node("Label").text = i.name
		if i.code == "slavemarket":
			newbutton.connect("pressed", get_parent().Hire, "open_slave_market", [i])
			newbutton.set_meta("slavemarket", true)
		else:
			newbutton.connect("pressed", self, "enter_guild", [i])
		newbutton.set_meta("guild", i)
	newbutton = input_handler.DuplicateContainerTemplate(City)
	newbutton.get_node("Label").text = "Shop"
	newbutton.connect("pressed", get_parent().Shop, "open_shop", ['area'])
	newbutton.set_meta("shop", true)
	for i in get_parent().active_area.capital_options:
		print("Capital options:" + str(i))
		newbutton = input_handler.DuplicateContainerTemplate(City)
		newbutton.get_node("Label").text = get_parent().city_options[i]
		newbutton.connect("pressed", self, i)
		newbutton.set_meta(i, true)

	for i in get_parent().active_area.events:
		if globals.checkreqs(i.reqs) == false:
			continue
		newbutton = input_handler.DuplicateContainerTemplate(City)
		newbutton.get_node("Label").text = i.text
		newbutton.connect(
			"pressed", input_handler, "interactive_message", [i.code, 'area_oneshot_event', i.args]
		)
		newbutton.connect("pressed", self, "open_city", [city])
		newbutton.modulate = Color(0.5, 0.8, 0.5)

func update_buttons(meta):
	print("meta:::", meta)
	for button in City.get_children():
		if meta == "slavemarket":
			if button.has_meta("guild") && !button.has_meta(meta):
				button.pressed = false
			if button.has_meta("quest_board"):
				button.pressed = false
		elif meta == "shop":
			if button.has_meta("guild") && !button.has_meta(meta):
				button.pressed = false
			if button.has_meta("quest_board"):
				button.pressed = false
		elif meta == "quest_board":
			if !button.has_meta(meta):
				button.pressed = false
#		if !button.has_meta(meta):
#			continue
#		if !button.get_meta(meta):
#			button.pressed = false
		

func enter_guild(guild):
	update_buttons("guild")
	Shop.is_shop_opened = false
	SlaveMarket.is_slave_market_opened = false
	get_parent().clear_submodules()
	if opened_guild.code == guild.code:
		Guild.hide()
		$GuildMenuBG.hide()
		opened_guild = {code = ""}
		return
	else:
		get_parent().Hire.mode = "guild_slaves"
		Guild.show()
		$GuildMenuBG.show()
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

