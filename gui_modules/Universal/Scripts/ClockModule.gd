extends Control

onready var sky = $Sky
onready var tw = $Tween
onready var ext_block = $TimeNode/external_block
var ext_blockers = []#{ref, act}

var locked = false

#turn processing is spread over several frames, so a heavy turn animates instead of freezing
var turn_in_progress = false
var input_locked = false
var labels_dirty = false
var turn_started_at = 0
var sky_anim_token = 0
var travel_arrival_sound_pending = false
#only escape if the turn coroutine ever dies mid-way (input is blocked while it runs).
#a 60-character turn measures ~2s, so this is ~13x the realistic worst case
const TURN_WATCHDOG_MSEC = 30000
const BUSY_MODULATE = Color(0.65, 0.65, 0.65, 1.0)

var atlas_pos = {
	0: 28,
	1: 228,
	2: 428,
	3: 628,
	4: 828,
}


func _ready():
	$TimeNode/HBoxContainer/finish_turn.connect("pressed", self, "advance_turn", [1])
	$TimeNode/HBoxContainer/x2.connect("pressed", self, "advance_turn", [2])
	$TimeNode/HBoxContainer/x4.connect("pressed", self, "advance_turn", [4])
	
	set_sky_pos()
	update_labels()
	$TimeNode/food.connect("mouse_entered", self, "show_food_tooltip")
	$TimeNode/gold.connect("mouse_entered", self, "show_gold_tooltip")
	globals.connecttexttooltip($TimeNode/timetooltip, tr("TIME_TOOLTIP"))
	globals.connect("update_clock", self, 'request_labels_update')
	globals.connect("travel_completed", self, 'queue_travel_arrival_sound')
	ext_block.connect("pressed", self, "on_ext_block_press")
#	$TimeNode/Date.text = "D: " + str(ResourceScripts.game_globals.date)
#	$TimeNode/Time.text = tr(variables.timeword[ResourceScripts.game_globals.hour])
	input_handler.register_btn_source('finish_turn', self, 'tut_get_finish_turn')


func tut_get_finish_turn():
	return $TimeNode/HBoxContainer/finish_turn


func hotkey_pressed(number):
	if input_handler.combat_node != null:
		return
	match number:
		1: advance_turn(1)
		2: advance_turn(2)
		3: advance_turn(4)


#both of these walk every character, so they are built when the player actually hovers
#rather than on every clock update - the text is only ever read from the tooltip
func show_food_tooltip():
	var resources = ResourceScripts.game_party.calculate_food_consumption()
	var text = "\n\n" + tr('CURRENT_PREFERRED_FOOD_CONSUMPTION') + ":"
	for i in resources.keys():
		text +=  "\n" + Items.materiallist[i].name + ": " + str(stepify(resources[i], 0.1))
	globals.showtexttooltip($TimeNode/food, tr("TOOLTIPFOOD") + text, false)


func show_gold_tooltip():
	var text = tr("TOOLTIPGOLD") + "\n\n" + tr("MONEYTOOLTIP") + ": " + str(ResourceScripts.game_res.money)
	var character_upkeep = ResourceScripts.game_party.get_weekly_tax()
	var total_upkeep = ResourceScripts.game_res.tax + character_upkeep
	text += "\n" + tr("UPGRADETAXTOOLTIP") + ": " + str(ResourceScripts.game_res.tax)
	text += "\n" + tr("CHARACTERUPKEEPTOOLTIP") + ": " + str(character_upkeep)
	text += "\n" + tr("TOTALUPKEEPTOOLTIP") + ": " + str(total_upkeep)

	globals.showtexttooltip($TimeNode/gold, text, false)


func set_sky_pos():
	sky.texture.region.position.x = atlas_pos[ResourceScripts.game_globals.hour]
	if gui_controller.mansion != null:
		var bghold = gui_controller.mansion.get_node('BGHolder')
		for bg in bghold.get_children():
			if bg.name == "BG%d" % int(ResourceScripts.game_globals.hour):
				bg.modulate = Color(1.0,1.0,1.0,1.0)
			else:
				bg.modulate = Color(1.0,1.0,1.0,0.0)


func move_sky(from, to, init_delay):
	locked = true
	var v1 = sky.texture.region
	v1.position.x = atlas_pos[from]
	var v2 = sky.texture.region
	v2.position.x = atlas_pos[to]
	if from < to:
		tw.interpolate_property(sky.texture, "region", v1, v2, variables.SecndsPerTransition - init_delay, 0, 2, init_delay)
	else:
		var t1 = 4 - from
		var t2 = to
		var speed = (variables.SecndsPerTransition - init_delay) / (t1 + t2)
		var v3 = sky.texture.region
		v3.position.x = atlas_pos[4]
		var v4 = sky.texture.region
		v4.position.x = 0
		tw.interpolate_property(sky.texture, "region", v1, v3, speed * t1, 0, 2, init_delay)
		tw.interpolate_property(sky.texture, "region", v4, v2, speed * t2, 0, 2, init_delay + speed * t1)
	
	if gui_controller.mansion != null:
		var bghold = gui_controller.mansion.get_node('BGHolder')
		for bg in bghold.get_children():
			if bg.name == "BG%d" % from:
				bg.modulate = Color(1.0,1.0,1.0,1.0)
			else:
				bg.modulate = Color(1.0,1.0,1.0,0.0)
		if from < to:
			var speed =  (variables.SecndsPerTransition - init_delay) / (to - from)
			for b1 in range(from, to):
				tw.interpolate_property(bghold.get_child(b1 + 1), 'modulate', Color(1.0,1.0,1.0,0.0), Color(1.0,1.0,1.0,1.0), speed, 0, 2, init_delay + (b1 - from) * speed) #increasing opacity of next bg, delay increasing for speed each time
		else:
			var t1 = 4 - from
			var t2 = to
			var speed = (variables.SecndsPerTransition - init_delay) / (t1 + t2)
			for b1 in range(from, 4): #those are taking t1 tacts
				tw.interpolate_property(bghold.get_child(b1 + 1), 'modulate', Color(1.0,1.0,1.0,0.0), Color(1.0,1.0,1.0,1.0), speed, 0, 2, init_delay + (b1 - from) * speed)
			for bg in bghold.get_children(): #resetting all bgs to default
				if bg.name == 'BG0':
					tw.interpolate_callback(bg, init_delay + speed * t1, 'set_modulate', Color(1.0,1.0,1.0,1.0))
				else:
					tw.interpolate_callback(bg, init_delay + speed * t1, 'set_modulate', Color(1.0,1.0,1.0,0.0))
			for b1 in range(0, to):
				tw.interpolate_property(bghold.get_child(b1 + 1), 'modulate', Color(1.0,1.0,1.0,0.0), Color(1.0,1.0,1.0,1.0), speed, 0, 2, init_delay + (b1 + t1) * speed)
			
	tw.start()
	#a timer instead of "tween_all_completed": remove_all() never fires that signal,
	#so an interrupted transition used to leave this coroutine (and 'locked') hanging
	sky_anim_token += 1
	var token = sky_anim_token
	yield(get_tree().create_timer(variables.SecndsPerTransition + 0.05), 'timeout')
	if token == sky_anim_token:
		locked = false
#	check_resume()


func stop_sky_anim():
	sky_anim_token += 1
	tw.remove_all()
	locked = false
	set_sky_pos()


#a single tick mutates gold/materials dozens of times and each one used to rebuild both
#tooltips (which walk every character). Coalesce to one refresh per frame instead
func request_labels_update():
	if turn_in_progress: #advance_turn refreshes the labels itself once the tick is done
		return
	labels_dirty = true


func queue_travel_arrival_sound():
	#Travel completion is processed once per character. Defer its shared cue until the
	#whole turn is done so simultaneous arrivals do not create overlapping sounds.
	if turn_in_progress:
		travel_arrival_sound_pending = true


func _process(delta): #nearly obsolete
	if labels_dirty:
		labels_dirty = false
		update_labels()
	#failsafe - never leave the viewport with input disabled if the turn coroutine died
	if turn_in_progress and OS.get_ticks_msec() - turn_started_at > TURN_WATCHDOG_MSEC:
		print("ERROR - turn processing watchdog fired, releasing input lock")
		turn_in_progress = false
	if input_locked and !turn_in_progress:
		set_input_lock(false)
	if self.visible == false:
		return
#	update_labels()
#	update_gold_tooltip()
#	update_food_tooltip()
	if input_handler.globalsettings.turn_based_time_flow == false:
		input_handler.globalsettings.turn_based_time_flow = true


func set_input_lock(state):
	if input_locked == state:
		return
	input_locked = state
	var vp = get_viewport()
	if vp != null:
		vp.gui_disable_input = state
	if state:
		$TimeNode/HBoxContainer.modulate = BUSY_MODULATE
	else:
		$TimeNode/HBoxContainer.modulate = Color(1.0, 1.0, 1.0, 1.0)


var continue_timer = false
func advance_turn(amount = 1):
	if turn_in_progress: #ignore spam clicks instead of stacking whole turns
		return
	if ResourceScripts.game_party.characters.size() > ResourceScripts.game_res.get_pop_cap() and ResourceScripts.game_party.has_nonunics():
		if ResourceScripts.game_res.get_pop_cap() < ResourceScripts.game_res.get_pop_cap_limit():
			input_handler.SystemMessage("You don't have enough rooms")
		else:
			input_handler.SystemMessage("Population limit reached")
		return
	if globals.log_node != null && weakref(globals.log_node).get_ref():
		globals.log_node.clear_log()

	turn_in_progress = true
	turn_started_at = OS.get_ticks_msec()
	travel_arrival_sound_pending = false
	set_input_lock(true)
	input_handler.PlaySound("mansion_turn_end")

	#synch setup
	var cur_time = ResourceScripts.game_globals.hour
	if cur_time == 4:
		cur_time = 0
	var start_date = ResourceScripts.game_globals.date

	var init_delay = 0.0
	if locked:
#		return
		#test variant
		stop_sky_anim()
		init_delay = 0.2

	#the transition starts before the simulation, so the wait is filled by the animation
	#instead of a frozen frame. amount is only wrong when an event cuts the turn short,
	#which is corrected below
	var ntime = cur_time + amount
	if ntime > 4:
		ntime -= 4
	move_sky(cur_time, ntime, init_delay)
	yield(get_tree(), 'idle_frame') #let the first animated frame render before working

	#gathering/farming/crafting all land as plain += on the resource pool during the tick,
	#so the only reliable way to show what came in is to diff it across the whole turn
	#TEMP disabled for freeze testing - restore together with the show_turn_gains call below
#	var materials_before = ResourceScripts.game_res.materials.duplicate()
#	var gold_before = ResourceScripts.game_res.money

	#reworked
	continue_timer = false
	var requested = amount
	var tmp = amount
	while amount > 0:
		if ResourceScripts.game_globals.autosave_due():
			yield(globals.autosave(false, true), 'completed')
		yield(ResourceScripts.game_globals.advance_hour(true), 'completed')
		amount -= 1
		yield(get_tree(), 'idle_frame') #the tick and the gui listeners it wakes get a frame each
		globals.emit_signal("hour_tick")
		if continue_timer:
			break
		if amount > 0:
			yield(get_tree(), 'idle_frame')
#	update_labels()
	tmp -= amount
#	print(tmp)

	if tmp != requested: #event interrupted the turn, the predicted transition is wrong now
		stop_sky_anim()

	yield(get_tree(), 'idle_frame')
	update_labels()
#	show_turn_gains(materials_before, gold_before) #TEMP disabled for freeze testing
	yield(get_tree(), 'idle_frame')
	if gui_controller.mansion != null and is_instance_valid(gui_controller.mansion) and !gui_controller.mansion.is_queued_for_deletion():
		var day_passed = ResourceScripts.game_globals.date != start_date
		yield(gui_controller.mansion.rebuild_after_turn(day_passed), 'completed')
	turn_in_progress = false
	set_input_lock(false)
	if travel_arrival_sound_pending:
		travel_arrival_sound_pending = false
		input_handler.PlaySound("ding")
#	set_sky_pos()


#A turn can touch a dozen resources. Show only the biggest few so the end of every turn
#stays a glance-sized "something came in" and not an itemised receipt flying across the screen.
const TURN_GAIN_ICONS = 3

func show_turn_gains(materials_before, gold_before):
	if ResourceScripts.core_animations.get_flight_overlay() == null:
		return
	var source = $TimeNode/HBoxContainer/finish_turn
	var gained = []
	var current = ResourceScripts.game_res.materials
	for res in current:
		var diff = current[res] - materials_before.get(res, 0)
		if diff > 0:
			gained.append({code = res, diff = diff})
	gained.sort_custom(self, "sort_gains_desc")

	var delay = 0.0
	for i in range(min(gained.size(), TURN_GAIN_ICONS)):
		ResourceScripts.core_animations.ItemFlightMaterial(gained[i].code, source,
			{delay = delay, amount = gained[i].diff})
		delay += 0.12
	if ResourceScripts.game_res.money > gold_before:
		ResourceScripts.core_animations.ItemFlightGold(source, {delay = delay})


func sort_gains_desc(first, second):
	return first.diff > second.diff


func update_labels():
	$TimeNode/Date.text = "W: %d, D: %d" % ResourceScripts.game_globals.get_week_and_day()
	$TimeNode/Time.text = tr(variables.timeword[ResourceScripts.game_globals.hour])
	$TimeNode/food.text = ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.get_food())
	$TimeNode/gold.text = ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.money)
#	rotate_sky()

#VERY ugly patch. Thing is: clock is a separate module, that can raise above all
#this mechanic allows to work with top windows in other modules
func ext_block_start(obj, act):
	reg_blocker(obj, act)
	ext_block.show()

func reg_blocker(new_obj, new_act):
	cleanup_blockers()
	for tab in ext_blockers:
		if tab.ref.get_ref() == new_obj:
			return
	
	ext_blockers.append({ref = weakref(new_obj), act = new_act})

func cleanup_blockers():
	for i in range(ext_blockers.size() - 1, -1, -1):
		var obj = ext_blockers[i].ref.get_ref()
		if obj == null or !is_instance_valid(obj) or !obj.is_visible_in_tree():
			ext_blockers.remove(i)
	try_ext_block_hide()

func try_ext_block_hide():
	if ext_blockers.empty():
		ext_block.hide()

func ext_block_stop(rem_obj):
	if !ext_block.is_visible():
		return
	cleanup_blockers()
	if ext_blockers.empty():
		return
	
	for i in range(ext_blockers.size() - 1, -1, -1):
		if ext_blockers[i].ref.get_ref() == rem_obj:
			ext_blockers.remove(i)
			break
	try_ext_block_hide()

func on_ext_block_press():
	cleanup_blockers()
	if !ext_blockers.empty():
		get_tree().set_input_as_handled()
		var blocker = ext_blockers.back()
		blocker.ref.get_ref().call(blocker.act)

