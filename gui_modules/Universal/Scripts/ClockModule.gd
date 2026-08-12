extends Control

onready var sky = $Sky
onready var tw = $Tween
onready var turn_gain_tw = $TurnGainTween
onready var ext_block = $TimeNode/external_block
onready var turn_shine_clip = $TimeNode/TurnShineClip
onready var turn_shine = $TimeNode/TurnShineClip/Shine
var ext_blockers = []#{ref, act}

var locked = false

#turn processing is spread over several frames, so a heavy turn animates instead of freezing
var turn_in_progress = false
var input_locked = false
var labels_dirty = false
var turn_started_at = 0
var sky_anim_token = 0
var travel_arrival_sound_pending = false
var turn_production_events = []
var turn_production_layout_locked = false
var turn_shine_progress = 0.0
var turn_progress_hour_index = 0
var turn_progress_hour_total = 1
#only escape if the turn coroutine ever dies mid-way (input is blocked while it runs).
#a 60-character turn measures ~2s, so this is ~13x the realistic worst case
const TURN_WATCHDOG_MSEC = 30000
const BUSY_MODULATE = Color(0.65, 0.65, 0.65, 1.0)
const TURN_GAIN_DURATION = 1.35
const TURN_GAIN_HOLD = 1.5
const TURN_GAIN_COUNTER_RATIO = 0.72
const TURN_GAIN_LABEL_RATIO = 0.82
const TURN_SHINE_START_X = -36.0
const TURN_SHINE_END_X = 144.0
const TURN_SIMULATION_PROGRESS_SHARE = 0.94

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
	hotkeys.connect("bindings_changed", self, "build_turn_tooltips")
	build_turn_tooltips()
	globals.connect("update_clock", self, 'request_labels_update')
	globals.connect("travel_completed", self, 'queue_travel_arrival_sound')
	globals.connect("work_produced", self, "queue_turn_production_event")
	ext_block.connect("pressed", self, "on_ext_block_press")
#	$TimeNode/Date.text = "D: " + str(ResourceScripts.game_globals.date)
#	$TimeNode/Time.text = tr(variables.timeword[ResourceScripts.game_globals.hour])
	input_handler.register_btn_source('finish_turn', self, 'tut_get_finish_turn')


func tut_get_finish_turn():
	return $TimeNode/HBoxContainer/finish_turn


#the key is printed in the tooltip, so it has to be read from the binding rather than
#baked into the translation
func build_turn_tooltips():
	var buttons = {finish_turn = ['mansion_time_1', 'TOOLTIP_CLOCK1'],
		x2 = ['mansion_time_2', 'TOOLTIP_CLOCK2'],
		x4 = ['mansion_time_3', 'TOOLTIP_CLOCK3']}
	for btn_name in buttons:
		var data = buttons[btn_name]
		globals.connecttexttooltip($TimeNode/HBoxContainer.get_node(btn_name), hotkeys.get_tooltip_text(data[1], data[0]))


#both of these walk every character, so they are built when the player actually hovers
#rather than on every clock update - the text is only ever read from the tooltip
func show_food_tooltip():
	var stock = {}
	var requirements = {}
	for tier in variables.food_demand_order:
		stock[tier] = 0
		requirements[tier] = 0.0

	for code in ResourceScripts.game_res.materials:
		if !Items.materiallist.has(code):
			continue
		var item = Items.materiallist[code]
		if item.type == 'food' and stock.has(item.demand):
			stock[item.demand] += ResourceScripts.game_res.materials[code]

	#calculate_food_consumption() predicts items used per day. Convert it to one turn,
	#then collect the preferred items under their demand tiers.
	var consumption = ResourceScripts.game_party.calculate_food_consumption()
	for code in consumption:
		if !Items.materiallist.has(code):
			continue
		var item_demand = Items.materiallist[code].demand
		if requirements.has(item_demand):
			requirements[item_demand] += consumption[code] / float(variables.HoursPerDay)

	var text = "\n\n" + tr('CURRENT_PREFERRED_FOOD_CONSUMPTION') + ":"
	for tier in variables.food_demand_order:
		text += "\n%s: %s / %s" % [tr("FOODDEMAND" + tier.to_upper()),
			ResourceScripts.custom_text.transform_number(stock[tier]),
			str(stepify(requirements[tier], 0.1))]
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


func queue_turn_production_event(person_id, task_id, texture):
	if !turn_in_progress or texture == null or !input_handler.globalsettings.get("item_flight_animation", false):
		return
	for event in turn_production_events:
		if str(event.person_id) == str(person_id) and str(event.task_id) == str(task_id) and event.texture == texture:
			return
	turn_production_events.append({person_id = person_id, task_id = task_id, texture = texture})


func _process(delta): #nearly obsolete
	if labels_dirty:
		labels_dirty = false
		update_labels()
	#failsafe - never leave the viewport with input disabled if the turn coroutine died
	if turn_in_progress and OS.get_ticks_msec() - turn_started_at > TURN_WATCHDOG_MSEC:
		print("ERROR - turn processing watchdog fired, releasing input lock")
		turn_in_progress = false
		turn_production_layout_locked = false
		hide_turn_shine()
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


func show_turn_shine(turn_count):
	turn_progress_hour_index = 0
	turn_progress_hour_total = max(int(turn_count), 1)
	turn_shine_progress = 0.0
	turn_shine.rect_position.x = TURN_SHINE_START_X
	turn_shine_clip.show()


func set_turn_simulation_progress(hour_fraction):
	var completed = turn_progress_hour_index + clamp(float(hour_fraction), 0.0, 1.0)
	set_turn_shine_progress(100.0 * TURN_SIMULATION_PROGRESS_SHARE * completed / turn_progress_hour_total)


func set_turn_shine_progress(value):
	turn_shine_progress = max(turn_shine_progress, clamp(float(value), 0.0, 100.0))
	turn_shine.rect_position.x = lerp(TURN_SHINE_START_X, TURN_SHINE_END_X, turn_shine_progress / 100.0)


func hide_turn_shine():
	turn_shine_clip.hide()
	turn_shine_progress = 0.0


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
	turn_in_progress = true
	turn_started_at = OS.get_ticks_msec()
	travel_arrival_sound_pending = false
	show_turn_shine(amount)
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
	var food_before = ResourceScripts.game_res.get_food()
	var gold_before = ResourceScripts.game_res.money

	#reworked
	continue_timer = false
	var requested = amount
	var tmp = amount
	while amount > 0:
		turn_progress_hour_index = requested - amount
		set_turn_simulation_progress(0.01)
		if ResourceScripts.game_globals.autosave_due():
			yield(globals.autosave(false, true), 'completed')
		turn_production_events.clear()
		var production_animation_enabled = input_handler.globalsettings.get("item_flight_animation", false)
		turn_production_layout_locked = production_animation_enabled
		var production_layout = {sources = {}, targets = {}}
		if production_animation_enabled and gui_controller.mansion != null and is_instance_valid(gui_controller.mansion) and gui_controller.mansion.has_method("capture_turn_production_layout"):
			production_layout = gui_controller.mansion.capture_turn_production_layout()
		yield(ResourceScripts.game_globals.advance_hour(true, self), 'completed')
		if production_animation_enabled and gui_controller.mansion != null and is_instance_valid(gui_controller.mansion) and gui_controller.mansion.has_method("play_turn_production_animations"):
			yield(gui_controller.mansion.play_turn_production_animations(production_layout, turn_production_events.duplicate()), 'completed')
		turn_production_layout_locked = false
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

	set_turn_shine_progress(94.0)
	yield(get_tree(), 'idle_frame')
	update_labels()
	show_turn_gains(food_before, gold_before)
	set_turn_shine_progress(96.0)
	yield(get_tree(), 'idle_frame')
	var day_passed = ResourceScripts.game_globals.date != start_date
	if gui_controller.mansion != null and is_instance_valid(gui_controller.mansion) and !gui_controller.mansion.is_queued_for_deletion():
		yield(gui_controller.mansion.rebuild_after_turn(day_passed), 'completed')
	set_turn_shine_progress(100.0)
	yield(get_tree(), 'idle_frame')
	hide_turn_shine()
	turn_production_layout_locked = false
	turn_in_progress = false
	set_input_lock(false)
	if travel_arrival_sound_pending:
		travel_arrival_sound_pending = false
		input_handler.PlaySound("ding")
#	set_sky_pos()


#The final value already exists by this point. Briefly restore the old value and roll it
#forward so the player can read the gain without delaying the turn simulation itself.
func show_turn_gains(food_before, gold_before):
	turn_gain_tw.remove_all()
	_reset_turn_gain_nodes()
	var food_after = ResourceScripts.game_res.get_food()
	var gold_after = ResourceScripts.game_res.money
	var has_gain = false
	if gold_after > gold_before:
		_animate_gain_counter($TimeNode/gold, "_set_gold_counter", gold_before, gold_after, 0.21)
		_animate_gain_label($TimeNode/GoldGain, gold_after - gold_before, 0.12)
		has_gain = true
	if food_after > food_before:
		_animate_gain_counter($TimeNode/food, "_set_food_counter", food_before, food_after, 0.30)
		_animate_gain_label($TimeNode/FoodGain, food_after - food_before, 0.21)
		has_gain = true
	if has_gain:
		turn_gain_tw.start()


func _reset_turn_gain_nodes():
	$TimeNode/gold.rect_scale = Vector2.ONE
	$TimeNode/food.rect_scale = Vector2.ONE
	for label in [$TimeNode/GoldGain, $TimeNode/FoodGain]:
		label.hide()
		label.modulate = Color(1.0, 1.0, 1.0, 0.0)
		label.rect_position.y = 12.0
		label.rect_scale = Vector2(0.78, 0.78)


func _animate_gain_counter(label, setter, from_value, to_value, delay):
	call(setter, from_value)
	var count_duration = TURN_GAIN_DURATION * TURN_GAIN_COUNTER_RATIO
	turn_gain_tw.interpolate_method(self, setter, float(from_value), float(to_value),
		count_duration, Tween.TRANS_CUBIC, Tween.EASE_OUT, delay)
	turn_gain_tw.interpolate_property(label, "rect_scale", Vector2.ONE, Vector2(1.18, 1.18),
		0.14, Tween.TRANS_QUAD, Tween.EASE_OUT, delay + count_duration)
	turn_gain_tw.interpolate_property(label, "rect_scale", Vector2(1.18, 1.18), Vector2.ONE,
		0.18, Tween.TRANS_QUAD, Tween.EASE_IN, delay + count_duration + 0.14)


func _animate_gain_label(label, amount, delay):
	var motion_duration = TURN_GAIN_DURATION * TURN_GAIN_LABEL_RATIO
	var enter_duration = motion_duration * 0.28
	var travel_duration = motion_duration * 0.78
	var fade_duration = motion_duration * 0.22
	var start_pos = Vector2(label.rect_position.x, 12.0)
	var hold_pos = Vector2(label.rect_position.x, -22.0)
	var exit_pos = Vector2(label.rect_position.x, -34.0)
	label.text = "+" + ResourceScripts.custom_text.transform_number(amount)
	label.rect_position = start_pos
	label.rect_scale = Vector2(0.78, 0.78)
	label.modulate = Color(1.0, 1.0, 1.0, 0.0)
	label.show()
	turn_gain_tw.interpolate_property(label, "modulate", Color(1.0, 1.0, 1.0, 0.0),
		Color(1.0, 1.0, 1.0, 1.0), enter_duration, Tween.TRANS_CUBIC, Tween.EASE_OUT, delay)
	turn_gain_tw.interpolate_property(label, "rect_position", start_pos, hold_pos,
		travel_duration, Tween.TRANS_CUBIC, Tween.EASE_OUT, delay)
	turn_gain_tw.interpolate_property(label, "rect_scale", Vector2(0.78, 0.78), Vector2(1.12, 1.12),
		enter_duration, Tween.TRANS_BACK, Tween.EASE_OUT, delay)
	turn_gain_tw.interpolate_property(label, "rect_scale", Vector2(1.12, 1.12), Vector2.ONE,
		motion_duration * 0.5, Tween.TRANS_QUAD, Tween.EASE_OUT, delay + enter_duration)
	var fade_delay = delay + travel_duration + TURN_GAIN_HOLD
	turn_gain_tw.interpolate_property(label, "modulate", Color(1.0, 1.0, 1.0, 1.0),
		Color(1.0, 1.0, 1.0, 0.0), fade_duration, Tween.TRANS_QUAD, Tween.EASE_IN, fade_delay)
	turn_gain_tw.interpolate_property(label, "rect_position", hold_pos, exit_pos,
		fade_duration, Tween.TRANS_QUAD, Tween.EASE_IN, fade_delay)
	turn_gain_tw.interpolate_callback(label, fade_delay + fade_duration, "hide")


func _set_gold_counter(value):
	$TimeNode/gold.text = ResourceScripts.custom_text.transform_number(value)


func _set_food_counter(value):
	$TimeNode/food.text = ResourceScripts.custom_text.transform_number(value)


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

