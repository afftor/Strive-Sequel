extends Control

var gamepaused_nonplayer = false
var gamepaused = false
var gamespeed = 0
var gametime = 0
var previouspeed = 0
onready var timebuttons = [$"TimeNode/0speed", $"TimeNode/1speed", $"TimeNode/2speed"]

func _ready():
	var speedvalues = [0,1,5]
	var tooltips = [tr('PAUSEBUTTONTOOLTIP'),tr('NORMALBUTTONTOOLTIP'),tr('FASTBUTTONTOOLTIP')]
	var counter = 0
	for i in timebuttons:
		i.hint_tooltip = tooltips[counter]
		i.connect("pressed",self,'changespeed',[i])
		i.set_meta('value', speedvalues[counter])
		counter += 1
	$TimeNode/finish_turn.connect("pressed", self, "advance_turn")
	$TimeNode/lessturn.connect("pressed", self, "decrease_turns")
	$TimeNode/moreturn.connect("pressed", self, "increase_turns")

	globals.connecttexttooltip($TimeNode/gold/TextureRect/Control, tr("TOOLTIPGOLD"))
	globals.connecttexttooltip($TimeNode/food/TextureRect/Control, tr("TOOLTIPFOOD"))

	set_time_buttons()

func _process(delta):
	if self.visible == false:
		return
	$TimeNode/gold.text = input_handler.transform_number(state.money)
	$TimeNode/food.text = input_handler.transform_number(state.get_food()) + " - " + str(state.get_food_consumption())

	if globals.globalsettings.turn_based_time_flow == false:
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
			$TimeNode/dayprogress.value = globals.calculatepercent(gametime, variables.SecondsPerHour)
			if gametime >= variables.SecondsPerHour:
				gametime -= variables.SecondsPerHour
				advance_hour()


func timeflowhotkey(hotkey):
	match hotkey:
		1: advance_turn()
		2: decrease_turns()
		3: increase_turns()

func advance_turn():
	input_handler.PlaySound("button_click")
	var number = state.hour_turns_set
	while number > 0:
		advance_hour()
		number -= 1

func decrease_turns():
	state.hour_turns_set = max(state.hour_turns_set - 1, 1)
	update_turns_label()

func increase_turns():
	state.hour_turns_set = min(state.hour_turns_set + 1, variables.hour_turn_limit)
	update_turns_label()

func update_turns_label():
	$TimeNode/turns.text = str(state.hour_turns_set)

func advance_hour():
	state.hour += 1
	if state.hour >= variables.HoursPerDay:
		advance_day()
	for i in state.characters.values():
		i.pretick()
	for i in state.characters.values():
		i.act_prepared()
	for i in state.characters.values():
		i.tick()
	$TimeNode/Date.text = "Day: " + str(state.date) + ", Hour: " + str(state.hour) + ":00"
	if globals.globalsettings.turn_based_time_flow:
		$TimeNode/dayprogress.value = state.hour
	
	# $population.text = "Population: "+ str(state.characters.size()) +"/" + str(state.get_pop_cap())
	### Should emit some signal for population node here
	get_parent().emit_signal("population_changed")
	state.emit_signal("hour_tick")

func advance_day():
	state.update_global_cooldowns()
	state.hour = 0
	state.date += 1
	state.daily_interactions_left = 1
	for i in state.characters.values():
		i.cooldown_tick()
		i.process_event(variables.TR_DAY)
	for i in state.areas.values():
		world_gen.update_guilds(i)
		if int(state.date) % variables.shop_restock_days == 0:
			world_gen.update_area_shop(i)
			for k in i.locations.values():
				if k.has('shop'):
					world_gen.update_area_shop(k)
	world_gen.update_locations()
	globals.autosave()

func set_time_buttons():
	match globals.globalsettings.turn_based_time_flow:
		true:
			$"TimeNode/0speed".visible = false
			$"TimeNode/1speed".visible = false
			$"TimeNode/2speed".visible = false
			$TimeNode/finish_turn.visible = true
			$TimeNode/dayprogress.max_value = variables.HoursPerDay
			$TimeNode/dayprogress.value = state.hour
			$TimeNode/HidePanel.hide()
			$TimeNode/turns.show()
			$TimeNode/lessturn.show()
			$TimeNode/moreturn.show()
		false:
			$"TimeNode/0speed".visible = true
			$"TimeNode/1speed".visible = true
			$"TimeNode/2speed".visible = true
			$TimeNode/finish_turn.visible = false
			$TimeNode/dayprogress.max_value = 100
			$TimeNode/turns.hide()
			$TimeNode/lessturn.hide()
			$TimeNode/moreturn.hide()

func changespeed(button, playsound = true):
	if globals.globalsettings.turn_based_time_flow == true:
		return
	var oldvalue = gamespeed
	var newvalue = button.get_meta('value')
	for i in timebuttons:
		i.pressed = i == button
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
