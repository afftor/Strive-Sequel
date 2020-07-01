extends Panel
onready var City = $ScrollContainer/VBoxContainer
onready var Guild = $GuildMenu/VBoxContainer
var opened_guild = {code = ""}


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func open_city(city):
	ResourceScripts.core_animations.BlackScreenTransition()
	yield(get_tree().create_timer(0.5), 'timeout')
	get_parent().active_area = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[city].area]
	get_parent().active_location = {}
	input_handler.active_area = get_parent().active_area
	get_parent().selected_location = city
	#active_location = active_area
#	$LocationGui.hide()
#	$CityGui.show()
#	$HirePanel.hide()
#	$ServicePanel.hide()
#	$QuestPanel.hide()
#	$ShopPanel.hide()
#	$FactionDetailsPanel.hide()
#	$SlaveSelectionPanel.hide()
#	$VideoPlayer.hide()
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
		newbutton = input_handler.DuplicateContainerTemplate(City)
		newbutton.text = i.name
		newbutton.connect("pressed", self, "enter_guild", [i])
		newbutton.set_meta("guild", i)
	newbutton = input_handler.DuplicateContainerTemplate(City)
	newbutton.text = "Shop"
	newbutton.connect("pressed", self, "open_shop", ['area'])
	for i in get_parent().active_area.capital_options:
		newbutton = input_handler.DuplicateContainerTemplate(City)
		newbutton.text = get_parent().city_options[i]
		newbutton.connect("pressed", self, i)

	for i in get_parent().active_area.events:
		if globals.checkreqs(i.reqs) == false:
			continue
		newbutton = input_handler.DuplicateContainerTemplate(City)
		newbutton.text = i.text
		newbutton.connect(
			"pressed", input_handler, "interactive_message", [i.code, 'area_oneshot_event', i.args]
		)
		newbutton.connect("pressed", self, "open_city", [city])
		newbutton.modulate = Color(0.5, 0.8, 0.5)


func enter_guild(guild):
	print("Guild:" + str(guild.code))
	print("Opened:" + str(opened_guild.code))
	if opened_guild.code == guild.code:
		Guild.hide()
		$GuildMenuBG.hide()
		opened_guild = {code = ""}
		return
	else:
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
				newbutton.text = event.name

				newbutton.connect(
					"pressed",
					input_handler,
					"interactive_dialogue_start",
					[event.target, event.target_option]
				)
				newbutton.modulate = Color(0.5, 0.8, 0.5)
		for i in guild.actions:
			newbutton = input_handler.DuplicateContainerTemplate(Guild)
			newbutton.text = get_parent().faction_actions[i]
			newbutton.connect("pressed", get_parent(), "faction_" + i)
		# newbutton = input_handler.DuplicateContainerTemplate(Guild)
		# newbutton.text = "Leave"
		# newbutton.connect("pressed", self, "open_city", [selected_location])
	for button in City.get_children():
		button.pressed = button.get_meta("guild") == guild
