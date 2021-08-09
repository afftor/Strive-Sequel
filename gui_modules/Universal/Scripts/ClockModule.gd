extends Control

var gamepaused_nonplayer = false
var gamepaused = false
var gamespeed = 0
var gametime = 0
var previouspeed = 0
const DEGREES_PER_HOUR = 15
onready var sky = $Sky
onready var timebuttons = [$"TimeNode/0speed", $"TimeNode/1speed", $"TimeNode/2speed"]


func _ready():
	var speedvalues = [0, 1, 5]
	var tooltips = [tr('PAUSEBUTTONTOOLTIP'), tr('NORMALBUTTONTOOLTIP'), tr('FASTBUTTONTOOLTIP')]
	var counter = 0
	for i in timebuttons:
		i.hint_tooltip = tooltips[counter]
		i.connect("pressed", self, 'changespeed', [i])
		i.set_meta('value', speedvalues[counter])
		counter += 1
	$TimeNode/finish_turn.connect("pressed", self, "advance_turn")
	$TimeNode/lessturn.connect("pressed", self, "decrease_turns")
	$TimeNode/moreturn.connect("pressed", self, "increase_turns")

	globals.connecttexttooltip($TimeNode/gold/Control, tr("TOOLTIPGOLD") + "\n\nMoney in Posession: " +str(ResourceScripts.game_res.money))
	
	
	globals.connecttexttooltip($TimeNode/food/Control, tr("TOOLTIPFOOD"))
	
	$TimeNode/Date.text = "D: " + str(ResourceScripts.game_globals.date)
	$TimeNode/Time.text = str(ResourceScripts.game_globals.hour) + ":00"
	sky.rect_rotation = ResourceScripts.game_globals.hour * DEGREES_PER_HOUR
	set_time_buttons()


func _process(delta):
	if self.visible == false:
		return
	$TimeNode/gold.text = ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.money)
	$TimeNode/food.text = ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.get_food())
	globals.connecttexttooltip($TimeNode/gold/Control, tr("TOOLTIPGOLD") + "\n\nMoney in Posession: " +str(ResourceScripts.game_res.money))
		# + " - "
		# + str(ResourceScripts.game_party.get_food_consumption())
	# )

	if input_handler.globalsettings.turn_based_time_flow == false:
		$TimeNode/HidePanel.visible = gamepaused_nonplayer
		if gamepaused == false:
			for i in get_tree().get_nodes_in_group("pauseprocess"):
				if i.visible == true:
					previouspeed = gamespeed
					changespeed(timebuttons[0], false)
					gamepaused = true
					gamepaused_nonplayer = true
		else:
			var allnodeshidden = true
			for i in get_tree().get_nodes_in_group("pauseprocess"):
				if i.visible == true:
					allnodeshidden = false
					break

			if allnodeshidden == true && gamepaused_nonplayer == true:
				restoreoldspeed(previouspeed)
				gamepaused_nonplayer = false
				gamepaused = false

		if gamespeed != 0:
			gametime += delta * gamespeed
			rotate_sky(gametime)
			if gametime >= variables.SecondsPerHour:
				gametime -= variables.SecondsPerHour
				advance_hour()
				gui_controller.mansion.SlaveListModule.rebuild()


func timeflowhotkey(hotkey):
	match hotkey:
		1:
			advance_turn()
		2:
			decrease_turns()
		3:
			increase_turns()


func advance_turn():
	input_handler.PlaySound("button_click")
	var number = globals.hour_turns_set
	while number > 0:
		advance_hour()
		number -= 1
	rotate_sky()
	gui_controller.mansion.SlaveListModule.rebuild()


func update_labels():
	$TimeNode/Date.text = "D: " + str(ResourceScripts.game_globals.date)
	$TimeNode/Time.text = str(ResourceScripts.game_globals.hour) + ":00"
	rotate_sky()


func rotate_sky(gametime = 0):
	if input_handler.globalsettings.turn_based_time_flow:
		sky.rect_rotation = ResourceScripts.game_globals.hour * DEGREES_PER_HOUR
	else:
		sky.rect_rotation = ((ResourceScripts.game_globals.hour - 1) * DEGREES_PER_HOUR) + (DEGREES_PER_HOUR / variables.SecondsPerHour * gametime)

func decrease_turns():
	globals.hour_turns_set = max(globals.hour_turns_set - 1, 1)
	input_handler.PlaySound("button_click")
	update_turns_label()

func increase_turns():
	globals.hour_turns_set = min(globals.hour_turns_set + 1, variables.hour_turn_limit)
	input_handler.PlaySound("button_click")
	update_turns_label()


func update_turns_label():
	$TimeNode/turns.text = str(globals.hour_turns_set)


func advance_hour():
	ResourceScripts.game_globals.hour += 1
	if ResourceScripts.game_globals.hour >= variables.HoursPerDay:
		advance_day()
	for i in ResourceScripts.game_party.characters.values():
		i.pretick()
	for i in ResourceScripts.game_party.characters.values():
		i.act_prepared()
	for i in ResourceScripts.game_party.characters.values():
		i.tick()
	$TimeNode/Date.text = "D: " + str(ResourceScripts.game_globals.date)
	$TimeNode/Time.text = str(ResourceScripts.game_globals.hour) + ":00"
	if input_handler.globalsettings.turn_based_time_flow:
		pass
	
	
	
	var text = "\n\nCurrent Preferred Food Consumption:"
	var resources = ResourceScripts.game_party.calculate_food_consumption()
	for i in resources.keys():
		text +=  "\n" + tr('FOODTYPE' + i.to_upper()) + ": " + str(resources[i])
	globals.connecttexttooltip($TimeNode/food/Control, tr("TOOLTIPFOOD") + text)
	
#	$gold.text = str(state.money)
#	$food.text = str(state.get_food()) + " - " + str(state.get_food_consumption())
	globals.emit_signal("hour_tick")


func advance_day():
	ResourceScripts.game_party.update_global_cooldowns()
	ResourceScripts.game_globals.hour = 0
	ResourceScripts.game_globals.date += 1
	ResourceScripts.game_progress.days_from_last_church_quest += 1
	ResourceScripts.game_globals.daily_sex_left = 1 + ResourceScripts.game_res.upgrades.sex_times
	ResourceScripts.game_globals.daily_dates_left = 1
	for i in ResourceScripts.game_party.characters.values():
		i.cooldown_tick()
		i.process_event(variables.TR_DAY)
		i.quest_day_tick()
	for i in ResourceScripts.game_world.areas.values():
		ResourceScripts.game_world.update_guilds(i)
		if int(ResourceScripts.game_globals.date) % variables.shop_restock_days == 0:
			ResourceScripts.world_gen.update_area_shop(i)
			for k in i.locations.values():
				if k.has('shop'):
					ResourceScripts.world_gen.update_area_shop(k)
	ResourceScripts.game_world.update_locations()
	globals.autosave()
	if gui_controller.current_screen == gui_controller.mansion:
		gui_controller.mansion.rebuild_mansion()


func set_time_buttons():
	match input_handler.globalsettings.turn_based_time_flow:
		true:
			$"TimeNode/0speed".visible = false
			$"TimeNode/1speed".visible = false
			$"TimeNode/2speed".visible = false
			$TimeNode/finish_turn.visible = true
			$TimeNode/HidePanel.hide()
			$TimeNode/turns.show()
			$TimeNode/lessturn.show()
			$TimeNode/moreturn.show()
		false:
			$"TimeNode/0speed".visible = true
			$"TimeNode/1speed".visible = true
			$"TimeNode/2speed".visible = true
			$TimeNode/finish_turn.visible = false
			$TimeNode/turns.hide()
			$TimeNode/lessturn.hide()
			$TimeNode/moreturn.hide()


func changespeed(button, playsound = true):
	if input_handler.globalsettings.turn_based_time_flow == true:
		return
	var oldvalue = gamespeed
	var newvalue = button.get_meta('value')
	for i in [$"TimeNode/0speed", $"TimeNode/1speed"]:
		i.visible = i != button
	gamespeed = newvalue
	var soundarray = ['time_stop', 'time_start', 'time_up']
	if oldvalue != newvalue && playsound:
		input_handler.PlaySound(soundarray[int(button.name[0])])

	gamepaused = newvalue == 0
	input_handler.emit_signal("SpeedChanged", gamespeed)


func restoreoldspeed(value):
	for i in timebuttons:
		if i.get_meta("value") == value:
			changespeed(i, false)
