extends Node

signal pass_next_animation
signal cast_finished
signal predamage_finished
signal postdamage_finished
signal alleffectsfinished

var cast_timer = 0
var aftereffecttimer = 0
var postdamagetimer = 0
var aftereffectdelay = 0.3

var cur_timer
var animations_queue = {}
#format: time - node - animations (data)
#data format: time, node, slot, type, params
var animation_delays = {}

var is_busy = false


func _process(delta):
	for node in animation_delays:
		animation_delays[node] -= delta
		if animation_delays[node] <= 0:
			finish_animation(node)

func can_add_data(data):
	if animations_queue[data.time][data.node].empty(): return false
	var l_anim = animations_queue[data.time][data.node].back()
	for tdata in l_anim:
		if tdata.slot == data.slot: return false
	return true

func add_new_data(data):
	if !animations_queue.has(data.time): 
		animations_queue[data.time] = {}
	if !animations_queue[data.time].has(data.node): 
		animations_queue[data.time][data.node] = []
	if can_add_data(data): 
		animations_queue[data.time][data.node].back().append(data)
	else:
		animations_queue[data.time][data.node].push_back([])
		animations_queue[data.time][data.node].back().append(data)

func check_start():
	if is_busy: return
	if animations_queue.empty(): return
	is_busy = true
	advance_timer()

func advance_timer():
	if animations_queue.empty(): return
	cur_timer = animations_queue.keys().min()
	for node in animations_queue[cur_timer]:
		start_animation(node)

func finish_animation(node):
	animation_delays.erase(node)
	animations_queue[cur_timer][node].pop_front()
	if animations_queue[cur_timer][node].empty(): 
		animations_queue[cur_timer].erase(node)
		if animations_queue[cur_timer].empty():
			animations_queue.erase(cur_timer)
			if animations_queue.empty():
				is_busy = false
				emit_signal("alleffectsfinished")
			else: 
				advance_timer()

func start_animation(node):
	var f_anim = animations_queue[cur_timer][node].front()
	var delay = 0
	for data in f_anim:
		#print("%d - %d %s"%[OS.get_ticks_msec(),cur_timer, data.type])
		delay = max(delay, call(data.type, data.node, data.params))
	animation_delays[node] = delay

#not used 
func nextanimation():
	#print("next_animation")
	emit_signal("pass_next_animation")

func cast_finished():
	#print("cast_finished")
	emit_signal("cast_finished")

func predamage_finished():
	#print("predamage_finished")
	emit_signal("predamage_finished")
	var tween = input_handler.GetTweenNode(self)
	tween.interpolate_callback(self, 1, 'allanimationsfinished')
	tween.start()

func postdamage_finished():
	#print("postdamage_finished")
	emit_signal("postdamage_finished")
	var tween = input_handler.GetTweenNode(self)
	tween.interpolate_callback(self, 1, 'allanimationsfinished')
	tween.start()

func allanimationsfinished():
	#print("allanims_finished")
	emit_signal("alleffectsfinished")

# ALL FUNCTIONS BELOW ARE SETUPPING ANIMATIONS AND THOUGH MUST RETURN THEIR ESTIMATING 'LOCK' TIME  
func casterattack(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var playtime = 0.2
	var delaytime = 0
	var effectdelay = 0.4
	var nextanimationtime = 0
	
	tween.interpolate_property(node, 'rect_position', node.get_position(), node.get_position() + node.get_attack_vector(), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delaytime)
	tween.interpolate_property(node, 'rect_position', node.get_position() + node.get_attack_vector(), node.get_position(), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, playtime)
	tween.start()
	
	return effectdelay
	
	#tween.interpolate_callback(input_handler, 0,'PlaySound',"slash")
	
#	tween.interpolate_callback(self, nextanimationtime, 'nextanimation')
#
#	cast_timer = effectdelay

func targetattack(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.4
	input_handler.gfx(node, 'slash')
	#tween.interpolate_callback(self, nextanimationtime, 'nextanimation')
	tween.start()
	
	return nextanimationtime + aftereffectdelay
	#aftereffecttimer = nextanimationtime + aftereffectdelay


func targetfire(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.2
	input_handler.gfx(node, 'fire')
	#tween.interpolate_callback(self, nextanimationtime, 'nextanimation')
	tween.start()
	
	return nextanimationtime + aftereffectdelay
	#postdamagetimer = nextanimationtime + aftereffectdelay


func miss(node, args = null):#conflicting usage of tween node!!
	var tween = input_handler.GetTweenNode(node)
	var playtime = 0.1
	var nextanimationtime = 0.0
	var delaytime = 0.8
	input_handler.PlaySound("combatmiss")
	input_handler.FloatText(node, tr("MISS"), 'miss', Color(1,1,1), 0.5, 0.2, node.get_node('Icon').rect_size/2-Vector2(20,20))
	tween.interpolate_property(node, 'modulate', Color(1,1,1), Color(1,1,0), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	tween.interpolate_property(node, 'modulate', Color(1,1,0), Color(1,1,1), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delaytime)
	tween.start()
	
	return playtime * 2 + delaytime
	#aftereffecttimer = nextanimationtime + aftereffectdelay

func hp_update(node, args):
	var delaytime = 0.3
	var tween = input_handler.GetTweenNode(node)
	var hpnode = node.get_node("HP")
	#float damage
	input_handler.FloatText(node, str(args.damage), args.type, args.color, 2, 0.2, node.get_node('Icon').rect_size/2)
	#update hp bar
	tween.interpolate_property(hpnode, 'value', hpnode.value, args.newhpp, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#update hp label
	node.update_hp_label(args.newhp, args.newhpp)
	tween.start()
	return delaytime

func mp_update(node, args):
	var delaytime = 0.3
	var tween = input_handler.GetTweenNode(node)
	var mpnode = node.get_node("MP")
	#update mp bar
	tween.interpolate_property(mpnode, 'value', mpnode.value, args.newmpp, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#update mp label
	node.update_mp_label(args.newmp, args.newmpp)
	tween.start()
	return delaytime

func shield_update(node, args):
	node.material.set_shader_param('modulate', args.color)
	return 0.0

func defeat(node, args = null):#stub, for this was not correct in FighterNode
	node.get_node('Icon').material = load("res://assets/sfx/bw_shader.tres")
	input_handler.FadeAnimation(node, 0.5, 0.3)
	return 0.0


func death_animation(node):
	var tween = input_handler.GetTweenNode(node)
	var playtime = 0.1
	var nextanimationtime = 0.0
	var delaytime = 0.8
	
	input_handler.FadeAnimation(node, 1, 0.5)
  return delaytime
