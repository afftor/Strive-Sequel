extends Control

func _ready():
	input_handler.connect("LocationSlavesUpdate", self, 'update')
	$Button.connect("pressed", self, 'sell_all')
	globals.connecttexttooltip($Hint, tr("CAPTURETOOLTIP"))
	update()


func update():
	if input_handler.active_location != null:
		if !input_handler.active_location.has('captured_characters'):
			input_handler.active_location.captured_characters = []
	else:
		return
	if input_handler.active_location.captured_characters.empty():
		input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
		hide()
	else:
		show()
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	for id in input_handler.active_location.captured_characters:
		var tchar = characters_pool.get_char_by_id(id)
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		var ttex = tchar.get_icon_small()
		if ttex != null: 
			newbutton.get_node('Icon').texture = ttex
		newbutton.get_node('Label').text = tchar.get_full_name()
		newbutton.get_node('Label').set("custom_colors/font_color", variables.hexcolordict['factor'+str(int(tchar.get_stat('growth_factor')))])
		newbutton.get_node('TakeButton').connect('pressed', self, 'hire_char', [id])
		newbutton.get_node('SellButton').connect('pressed', self, 'sell_char', [id])
		newbutton.connect('pressed', self, 'show_full_info', [tchar])
		globals.connectslavetooltip(newbutton.get_node('Icon'), tchar)
		if tchar.src == 'random_combat':
			newbutton.get_node("SellButton/Label").text = str(int(tchar.calculate_price(true) / 2))
			globals.connecttexttooltip(newbutton.get_node('SellButton'), tr("CAPTURESELLTOOLTIP") % int(tchar.calculate_price(true) / 2))
		else:
			newbutton.get_node("SellButton/Label").visible = false
			globals.connecttexttooltip(newbutton.get_node('SellButton'), tr("CAPTUREDISMISSTOOLTIP")) #2change
			newbutton.get_node("SellButton/TextureRect").texture = load("res://assets/images/gui/explore/Captured Characters/icons/icon_dismiss.png")
			newbutton.get_node("TakeButton/TextureRect").texture = load("res://assets/images/gui/explore/Captured Characters/icons/icon_recruit.png")
		globals.connecttexttooltip(newbutton.get_node("TakeButton"), tr("CAPTUREADDTOOLTIP"))


func sell_all():
	for id in input_handler.active_location.captured_characters:
		var tchar = characters_pool.get_char_by_id(id)
		if tchar.src == 'random_combat':
			var val = tchar.calculate_price(true) / 2
			ResourceScripts.game_res.money += int(val)
			input_handler.PlaySound("money_spend")
		tchar.is_active = false
	input_handler.active_location.captured_characters.clear()
	input_handler.emit_signal("LocationSlavesUpdate")


func sell_char(ch_id):
	if input_handler.active_location.captured_characters.has(ch_id):
		var tchar = characters_pool.get_char_by_id(ch_id)
		if tchar.src == 'random_combat':
			var val = tchar.calculate_price(true) / 2
			ResourceScripts.game_res.money += int(val)
			input_handler.PlaySound("money_spend")
		tchar.is_active = false
		input_handler.active_location.captured_characters.erase(ch_id)
	var slave_tooltip = get_tree().get_root().get_node_or_null("slavetooltip")
	if slave_tooltip != null:
		slave_tooltip.hide()
	input_handler.emit_signal("LocationSlavesUpdate")


func hire_char(ch_id):
	if input_handler.active_location.captured_characters.has(ch_id):
#		if ResourceScripts.game_party.characters.size() >= ResourceScripts.game_res.get_pop_cap():
#			if ResourceScripts.game_res.get_pop_cap() < variables.max_population_cap:
#				input_handler.SystemMessage("You don't have enough rooms")
#			else:
#				input_handler.SystemMessage("Population limit reached")
#			return
		var tchar = characters_pool.get_char_by_id(ch_id)
		input_handler.active_character = tchar
		if tchar.src == 'random_combat':
			input_handler.interactive_message("recruit_captured", "story_event", {})
		else:
			input_handler.interactive_message("recruit_meet", "story_event", {})
#		tchar.set_stat('is_hirable', false)
#		tchar.recruit() 
#		tchar.travel.location = gui_controller.exploration.selected_location
#		tchar.remove_from_task()
#		input_handler.PlaySound("money_spend")
#		input_handler.active_location.captured_characters.erase(ch_id)
	var slave_tooltip = get_tree().get_root().get_node_or_null("slavetooltip")
	if slave_tooltip != null:
		slave_tooltip.hide()
#	input_handler.emit_signal("LocationSlavesUpdate")


func show_full_info(person = null):
	if person == null: return
	var FullSlaveInfo = input_handler.get_spec_node(input_handler.NODE_EXPLORE_SLAVEINFO)
	if ! gui_controller.windows_opened.has(FullSlaveInfo):
		gui_controller.windows_opened.append(FullSlaveInfo)
	gui_controller.explore_slaveinfo = FullSlaveInfo
	FullSlaveInfo.show()
	FullSlaveInfo.show_summary(person, true)
