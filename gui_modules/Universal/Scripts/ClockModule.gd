extends Control

onready var sky = $Sky
onready var tw = $Tween

var locked = false

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
	update_food_tooltip()
	update_gold_tooltip()
	globals.connecttexttooltip($TimeNode/timetooltip, "Current Week, Day and time. Some quests may have time limits.")
#	$TimeNode/Date.text = "D: " + str(ResourceScripts.game_globals.date)
#	$TimeNode/Time.text = tr(variables.timeword[ResourceScripts.game_globals.hour])

func hotkey_pressed(number):
	match number:
		1: advance_turn(1)
		2: advance_turn(2)
		3: advance_turn(4)

func update_food_tooltip():
	var resources = ResourceScripts.game_party.calculate_food_consumption()
	var text = "\n\nCurrent Preferred Food Consumption:"
	for i in resources.keys():
		text +=  "\n" + tr('FOODTYPE' + i.to_upper()) + ": " + str(resources[i])
	globals.connecttexttooltip($TimeNode/food, tr("TOOLTIPFOOD") + text)


func update_gold_tooltip():
	globals.connecttexttooltip($TimeNode/gold, tr("TOOLTIPGOLD") + "\n\nMoney in Posession: " +str(ResourceScripts.game_res.money))


func set_sky_pos():
	sky.texture.region.position.x = atlas_pos[ResourceScripts.game_globals.hour]


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
		tw.interpolate_property(sky.texture, "region", v4, v2, speed * t2, 0, 2, init_delay, speed * t1)
	tw.start()
	yield(tw, "tween_all_completed")
	locked = false


func _process(delta): #nearly obsolete
	if self.visible == false:
		return
	update_labels()
	update_gold_tooltip()
	update_food_tooltip()
	
	if input_handler.globalsettings.turn_based_time_flow == false:
		input_handler.globalsettings.turn_based_time_flow = true


func advance_turn(amount = 1):
	var init_delay = 0.0
	if locked: 
#		return
		#test variant
		tw.remove_all()
		set_sky_pos()
		init_delay = 0.2
	input_handler.PlaySound("button_click")
	#synch setup
	var cur_time = ResourceScripts.game_globals.hour
	if cur_time == 4: cur_time = 0
	var ntime = cur_time + amount
	if ntime > 4: 
		ntime -= 4
	move_sky(cur_time, ntime, init_delay)
	
	#asynch part
	while amount > 0:
		ResourceScripts.game_globals.advance_hour()
		amount -= 1
#	rotate_sky()
	
	gui_controller.mansion.SlaveListModule.rebuild()
	gui_controller.mansion.SkillModule.build_skill_panel()
	update_labels()
	update_food_tooltip()
	update_gold_tooltip()
#	set_sky_pos()
	globals.emit_signal("hour_tick")


func update_labels():
	$TimeNode/Date.text = "W: %d, D: %d" % [(ResourceScripts.game_globals.date / 7 + 1), (ResourceScripts.game_globals.date % 7 + 1)]
#	$TimeNode/Time.text = str(ResourceScripts.game_globals.hour) + ":00"
	$TimeNode/Time.text = tr(variables.timeword[ResourceScripts.game_globals.hour])
	$TimeNode/food.text = ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.get_food())
	$TimeNode/gold.text = ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.money)
	update_food_tooltip()
	update_gold_tooltip()
#	rotate_sky()


