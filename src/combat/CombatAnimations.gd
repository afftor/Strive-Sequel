extends Node

signal pass_next_animation
signal cast_finished
signal predamage_finished
signal postdamage_finished
signal alleffectsfinished

var cast_timer = 0
var aftereffecttimer = 0
var postdamagetimer = 0
var aftereffectdelay = 0.1

var cur_timer
var animations_queue = {}
#format: time - node - animations (data)
#data format: time, node, slot, type, params

#delays for playing animations in zones
var hp_update_delays = {}
var buffs_update_delays = {}
var crit_display = []
var log_update_delay = 0

#main timer
var animation_delays = {}

var is_busy = false

func force_end():
	animation_delays.clear()
	animations_queue.clear()
	hp_update_delays.clear()
	buffs_update_delays.clear()
	crit_display.clear()
	log_update_delay = 0
	is_busy = false

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
	hp_update_delays.clear()
	if animations_queue.empty(): return
	cur_timer = animations_queue.keys().min()
	#print (cur_timer)
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
	else: 
		start_animation(node)

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
func sound(node, args):
	input_handler.PlaySound(args.sound)
	return 0.1

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
	hp_update_delays[node] = 0.3 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.3)
	buffs_update_delays[node] = 0.4
	ResourceScripts.core_animations.gfx_sprite(node, 'strike', 0.3, 0.1, node.get_flip())
	tween.start()
	
	return nextanimationtime + aftereffectdelay

func ranged_attack(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.2
	hp_update_delays[node] = 0.3 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.3)
	buffs_update_delays[node] = 0.2
	ResourceScripts.core_animations.gfx_sprite(node, 'arrow', 0.3, 0.4, node.get_flip())
	tween.start()
	
	return nextanimationtime + aftereffectdelay

func firebolt(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.2
	hp_update_delays[node] = 0.3 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.3)
	buffs_update_delays[node] = 0.2
	ResourceScripts.core_animations.gfx_sprite(node, 'firebolt', 0.3, 0.4, node.get_flip())
	tween.start()
	
	return nextanimationtime + aftereffectdelay

func water_attack(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.2
	hp_update_delays[node] = 0.3 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.3)
	buffs_update_delays[node] = 0.2
	ResourceScripts.core_animations.gfx_sprite(node, 'water_attack', 0.3, 0.4, node.get_flip())
	tween.start()
	
	return nextanimationtime + aftereffectdelay

func flame(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.4
	hp_update_delays[node] = 0.3 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.3)
	buffs_update_delays[node] = 0.4
	ResourceScripts.core_animations.gfx_sprite(node, 'flame', 0.3, 0.5)
	tween.start()
	
	return nextanimationtime + aftereffectdelay

func earth_spike(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.8
	hp_update_delays[node] = 0.5 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.5)
	buffs_update_delays[node] = 0.5
	ResourceScripts.core_animations.gfx_sprite(node, 'earth_spike', 0.7, 1)
	#tween.interpolate_callback(self, nextanimationtime, 'nextanimation')
	tween.start()
	
	return nextanimationtime + aftereffectdelay
	#aftereffecttimer = nextanimationtime + aftereffectdelay

func targetfire(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.2
	hp_update_delays[node] = 0.1 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.1)
	buffs_update_delays[node] = 0.2
	ResourceScripts.core_animations.gfx(node, 'fire')
	#tween.interpolate_callback(self, nextanimationtime, 'nextanimation')
	tween.start()
	
	return nextanimationtime + aftereffectdelay
	#postdamagetimer = nextanimationtime + aftereffectdelay

func decay(node, args):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 1
	hp_update_delays[node] = 0.5 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.5)
	buffs_update_delays[node] = 0.5
	ResourceScripts.core_animations.gfx_sprite(node.get_parent().get_parent().get_parent().get_parent(), 'decay', 0.5, 1.5)
	#tween.interpolate_callback(self, nextanimationtime, 'nextanimation')
	tween.start()
	
	return nextanimationtime + aftereffectdelay
	#postdamagetimer = nextanimationtime + aftereffectdelay

func heal(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.5
	hp_update_delays[node] = 0 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0)
	buffs_update_delays[node] = 0.5
	ResourceScripts.core_animations.gfx_particles(node, 'heal', 1, 1)
	tween.start()
	
	return nextanimationtime + aftereffectdelay

func miss(node, args = null):#conflicting usage of tween node!!
	var tween = input_handler.GetTweenNode(node)
	var playtime = 0.1
	var nextanimationtime = 0.0
	var delaytime = 0.4
	input_handler.PlaySound("combatmiss")
	ResourceScripts.core_animations.FloatText(node, tr("MISS"), 'miss', 75, Color(1,1,1), 1, 0.2)#, node.get_node('Icon').rect_size/2-Vector2(80,20))
	tween.interpolate_property(node, 'modulate', Color(1,1,1), Color(1,1,0), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	tween.interpolate_property(node, 'modulate', Color(1,1,0), Color(1,1,1), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delaytime)
	tween.start()
	
	return playtime * 2 + delaytime
	#aftereffecttimer = nextanimationtime + aftereffectdelay

func resist(node, args = null):#conflicting usage of tween node!!
	var tween = input_handler.GetTweenNode(node)
	var playtime = 0.1
	var nextanimationtime = 0.0
	var delaytime = 0.4
	input_handler.PlaySound("combatmiss")
	ResourceScripts.core_animations.FloatText(node, 'RESIST', 'miss', 75, Color(1,1,1), 1, 0.2) #stub
	#, node.get_node('Icon').rect_size/2-Vector2(80,20))
	tween.interpolate_property(node, 'modulate', Color(1,1,1), Color(1,1,0), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	tween.interpolate_property(node, 'modulate', Color(1,1,0), Color(1,1,1), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delaytime)
	tween.start()
	
	return playtime * 2 + delaytime

func buffs(node, args):
	var delay = 0
	if buffs_update_delays.has(node): delay = buffs_update_delays[node]
	buffs_update_delays.erase(node)
	var delaytime = 0.01
	var tween = input_handler.GetTweenNode(node)
	tween.interpolate_callback(node, delay, 'noq_rebuildbuffs', args)
	tween.start()
	return delaytime + delay

func c_log(node, args):
	var delay = log_update_delay
	log_update_delay = 0
	var delaytime = 0.01
	var tween = input_handler.GetTweenNode(node)
	tween.interpolate_callback(node, delay, 'combatlogadd_q', args.text)
	tween.start()
	return delaytime + delay

func critical(node, args = null):
	var delay = 0.01
	if !crit_display.has(node):
		crit_display.push_back(node)
	return delay

func hp_update(node, args):
	var delay = 0
	if hp_update_delays.has(node): delay = hp_update_delays[node]
	hp_update_delays.erase(node)
	
	var delaytime = 0.2
	var tween = input_handler.GetTweenNode(node)
	var hpnode = node.get_node("HP")
	#float damage
	if args.damage_float:
		if crit_display.has(node):
			args.color = Color(1,0.8,0)
			crit_display.erase(node)
			tween.interpolate_callback(ResourceScripts.core_animations, delay, 'FloatTextArgs', {node = node, text = str(ceil(args.damage)) + '!', type = args.type, size = 120, color = args.color, time = 1, fadetime = 0.5, offset = Vector2(0,0)})
		else: tween.interpolate_callback(ResourceScripts.core_animations, delay, 'FloatTextArgs', {node = node, text = str(ceil(args.damage)), type = args.type, size = 80, color = args.color, time = 1, fadetime = 0.5, offset = Vector2(0,0)})
	#input_handler.FloatText(node, str(args.damage), args.type, 150, args.color, 2, 0.2, Vector2(node.get_node('Icon').rect_position.x+25, node.get_node("Icon").rect_position.y+100))
	#update hp bar
	tween.interpolate_property(hpnode, 'value', hpnode.value, args.newhpp, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
	#update hp label
	tween.interpolate_callback (node, delay, 'update_hp_label', args.newhp, args.newhpp)
	#node.update_hp_label(args.newhp, args.newhpp)
	tween.start()
	return delaytime + delay

func mp_update(node, args):
	var delaytime = 0.1
	var tween = input_handler.GetTweenNode(node)
	var mpnode = node.get_node("MP")
	#update mp bar
	tween.interpolate_property(mpnode, 'value', mpnode.value, args.newmpp, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#update mp label
	node.update_mp_label(args.newmp, args.newmpp)
	tween.start()
	return delaytime

func test_combat_start(node, args):
	return 1.0

func shield_update(node, args):
	node.material.set_shader_param('modulate', args.color)
	return 0.1

func defeat(node, args = null):#stub, for this was not correct in FighterNode
	var delaytime = 0.3
	var tween = input_handler.GetTweenNode(node)
	tween.interpolate_callback(node, delaytime, 'noq_defeat')
	tween.start()
	#node.get_node('Icon').material = load("res://assets/sfx/bw_shader.tres")
	#input_handler.FadeAnimation(node, 0.5, 0.3)
	return delaytime


func death_animation(node):
	var tween = input_handler.GetTweenNode(node)
	var playtime = 0.1
	var nextanimationtime = 0.0
	var delaytime = 0.8
	
	ResourceScripts.core_animations.FadeAnimation(node, 1, 0.5)
	return delaytime
