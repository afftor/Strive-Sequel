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
var custom_delays = {}#nodes - keys, value: {delay, cur_timer, time}
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
	custom_delays.clear()
	buffs_update_delays.clear()
	crit_display.clear()
	log_update_delay = 0
	pending_shot_delay = 0.0
	pending_shot_timer = -1
	is_busy = false

func _process(delta):
	for node in animation_delays:
		animation_delays[node] -= delta
		if animation_delays[node] <= 0:
			finish_animation(node)

func can_add_data(data):
	if animations_queue[data.time][data.node].empty(): 
		return false
	var l_anim = animations_queue[data.time][data.node].back()
	for tdata in l_anim:
		if tdata.slot == data.slot: return false
	return true

func add_new_data(data):
	if data.node == null:
		return
	var recall = false
	if !animations_queue.has(data.time): 
		animations_queue[data.time] = {}
	if !animations_queue[data.time].has(data.node): 
		animations_queue[data.time][data.node] = []
		if is_busy:
			#bad architecture, need to move all of this additions to proper interface later
			recall = true
	if can_add_data(data): 
		animations_queue[data.time][data.node].back().append(data)
	elif data.slot != 'buffs' or animations_queue[data.time][data.node].empty():
		animations_queue[data.time][data.node].push_back([])
		animations_queue[data.time][data.node].back().append(data)
	if recall:
		start_animation(data.node)

func check_start():
	if is_busy: 
		return
	if animations_queue.empty(): 
		return
	is_busy = true
	advance_timer()

func advance_timer():
	hp_update_delays.clear()
	if animations_queue.empty(): return
	cur_timer = animations_queue.keys().min()
	try_clear_custom_delays()
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
	if !animations_queue[cur_timer].has(node):#temporal fix
		return
	var f_anim = animations_queue[cur_timer][node].front()
	var delay = 0
	for data in f_anim:
		#print("%d - %d %s"%[OS.get_ticks_msec(),cur_timer, data.type])
		var true_type
		if has_method(data.type):
			true_type = data.type
		elif images.GFX_video.keys().has(data.type):
			true_type = 'gfx_video'
			data.params.video_name = data.type
		elif images.GFX_sprites.keys().has(data.type):
			true_type = 'gfx_animsprite'
			data.params.sprite_name = data.type
		elif images.GFX_particles.keys().has(data.type):#those with no own method
			true_type = 'gfx_particles'
			data.params.sprite_name = data.type
		delay = max(delay, call(true_type, data.node, data.params))
	animation_delays[node] = delay

#not used 
func nextanimation():
	emit_signal("pass_next_animation")

func cast_finished():
	emit_signal("cast_finished")

func predamage_finished():
	emit_signal("predamage_finished")
	var tween = input_handler.GetTweenNode(self)
	tween.interpolate_callback(self, 1, 'allanimationsfinished')
	tween.start()

func postdamage_finished():
	emit_signal("postdamage_finished")
	var tween = input_handler.GetTweenNode(self)
	tween.interpolate_callback(self, 1, 'allanimationsfinished')
	tween.start()

func allanimationsfinished():
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
	#the blow only lands partway into the cast sprite - see take_pending_shot().
	#Only this function's own lock carries `shot`. Do NOT add it to buffs_update_delays
	#or log_update_delay: advance_timer() clears hp_update_delays but not those two, so
	#they survive into later slots and become the lock of buffs()/c_log() - the wait
	#would then be paid three times over and the skill bar comes back a second late.
	var shot = take_pending_shot()
	hp_update_delays[node] = 0.3 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.3)
	buffs_update_delays[node] = 0.4
	if shot > 0:
		target_push(node, shot)
		tween.interpolate_callback(ResourceScripts.core_animations, shot, 'gfx_sprite',
			node, 'strike', 0.3, 0.1, get_flip_for_node(node, args))
	else:
		ResourceScripts.core_animations.gfx_sprite(node, 'strike', 0.3, 0.1, get_flip_for_node(node, args))
	tween.start()

	return shot + HIT_TAIL

func ranged_attack(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.3
	var duration = 0.4
	if args != null:
		if args.has('duration'):
			duration = args.duration
			nextanimationtime = duration
		if args.has('queue_duration'):
			nextanimationtime = args.queue_duration
	nextanimationtime -= 0.1
	#the shot only leaves the bow partway into the cast sprite, so everything the
	#target does waits for it: arrow, squash, hp and buffs all shift by this much
	var shot = take_pending_shot()
	if args != null and args.has("no_delays") and args.no_delays:
		custom_delays[node] = {delay = 0.2, cur_timer = cur_timer, time = 7}
		shot = 0.0
	else:
		hp_update_delays[node] = 0.3 #delay for hp updating during this animation
		log_update_delay = max(log_update_delay, 0.3)
		buffs_update_delays[node] = 0.2
		target_squash(node, duration, shot)
	if shot > 0:
		tween.interpolate_callback(ResourceScripts.core_animations, shot, 'gfx_sprite',
			node, 'arrow', 0.3, duration, get_flip_for_node(node, args))
	else:
		ResourceScripts.core_animations.gfx_sprite(node, 'arrow', 0.3, duration, get_flip_for_node(node, args))
	tween.start()

	return shot + HIT_TAIL


#ANIMATION SET FOR BOWS AND CROSSBOWS
#Timings picked in tools/anim_lab, see README there.
#
#The windup slot does not hold the queue: make_sfx_params sets queue_duration = 0
#for is_cast entries, so its lock is 0 and by default the hit lands immediately,
#while the bow is still being drawn. So the wait is moved onto the target side -
#ranged_attack delays the arrow, the squash and the damage by pending_shot_delay
#and extends its own lock by the same amount.
#
#RELEASE is the frame where the sheet actually looses the shot, measured by the
#peak of the trail: at_arch frame 18 of 24, at_arbalester frame 12 of 21, both 30 fps.
#CAST_SPEEDUP plays the cast sprite faster so that release comes sooner and a shot
#costs less extra time. At 1.6 the bow looses at 0.375 s instead of 0.6 s.
#CAST_RELEASE is the frame where the sheet actually connects, measured by the peak of the
#trail: at_mace 9, at_dagger 10, at_dualsword 11, at_lance 12, at_arbalester 12, at_axe 14,
#at_sword 15, at_stuff 16, at_arch 18 - all 30 fps. CAST_SPEEDUP plays the sheet faster so
#the blow comes sooner and an attack costs less extra time; raise it if combat drags.
const CAST_RELEASE = {
	at_sword = 0.50, at_dualsword = 0.37, at_lance = 0.40, at_axe = 0.47,
	at_dagger = 0.33, at_mace = 0.30, at_stuff = 0.53,
	at_arch = 0.60, at_arbalester = 0.40,
}
const CAST_SPEEDUP = {
	at_sword = 1.5, at_dualsword = 1.5, at_lance = 1.5, at_axe = 1.5,
	at_dagger = 1.5, at_mace = 1.5, at_stuff = 1.5,
	at_arch = 1.6, at_arbalester = 1.35,
}
#which motion the caster plays: 'cut' for melee, 'recoil' for bows
const CAST_MOTION = {
	at_sword = 'cut', at_dualsword = 'cut', at_lance = 'cut', at_axe = 'cut',
	at_dagger = 'cut', at_mace = 'cut', at_stuff = 'cut',
	at_arch = 'recoil', at_arbalester = 'recoil',
}
const MOTION_DIST = 110.0 #how far the card travels into the blow
const CUT_DRAW = 0.466 #share of the run-up spent pulling back
const CUT_HOLD = 0.06 #follow through before settling
const MOTION_BACK = 0.26 #settling back
const RECOIL_EXT = 0.06 #how long the straightening into the shot takes
const PUSH_OUT = 0.26 #knockback
const PUSH_IN = 0.06
const PUSH_SHARE = 0.26 #fraction of MOTION_DIST the target is knocked away
const SQUASH_IN = 0.05
const SQUASH_OUT = 0.31
const SQUASH_SCALE = 0.94
const SQUASH_SHAKE = 7
const TILT_IN = 0.11
const TILT_OUT = 0.26
const TILT_SHARE = 0.35
const TILT_ANGLE = 7.0
const TILT_LIFT = 9.0
const TILT_SCALE_X = 0.975
const TILT_SCALE_Y = 1.02

var pending_shot_delay = 0.0 #set by the cast animation, consumed by the predamage one
var pending_shot_timer = -1 #which slot set it, so a stale value cannot leak to a later skill

#the cast animation and the blow sit two `turns` apart (windup, targeting, predamage)
func take_pending_shot():
	var val = 0.0
	if pending_shot_timer >= 0 and cur_timer != null and cur_timer - pending_shot_timer <= 3:
		val = pending_shot_delay
	pending_shot_delay = 0.0
	pending_shot_timer = -1
	return val

#these intercept the generic gfx_animsprite path via has_method() in start_animation
func at_sword(node, args = null):      return cast_with_motion(node, args, 'at_sword')
func at_dualsword(node, args = null):  return cast_with_motion(node, args, 'at_dualsword')
func at_lance(node, args = null):      return cast_with_motion(node, args, 'at_lance')
func at_axe(node, args = null):        return cast_with_motion(node, args, 'at_axe')
func at_dagger(node, args = null):     return cast_with_motion(node, args, 'at_dagger')
func at_mace(node, args = null):       return cast_with_motion(node, args, 'at_mace')
func at_stuff(node, args = null):      return cast_with_motion(node, args, 'at_stuff')
func at_arch(node, args = null):       return cast_with_motion(node, args, 'at_arch')
func at_arbalester(node, args = null): return cast_with_motion(node, args, 'at_arbalester')

func cast_with_motion(node, args, sprite_name):
	if args == null: args = {}
	var speedup = CAST_SPEEDUP[sprite_name]
	var release = CAST_RELEASE[sprite_name] / speedup
	var duration = ResourceScripts.core_animations.get_gfx_sprite_time(sprite_name) / speedup
	var nextanimationtime = duration
	if args.has('queue_duration'): nextanimationtime = args.queue_duration
	nextanimationtime -= 0.1

	pending_shot_delay = release
	pending_shot_timer = cur_timer
	ResourceScripts.core_animations.gfx_sprite(node, sprite_name, 0.5, duration,
		get_flip_for_node(node, args), speedup)
	if CAST_MOTION[sprite_name] == 'cut':
		caster_cut(node, release)
	else:
		caster_recoil(node, release)

	return nextanimationtime + aftereffectdelay

#SHADOW STEP FOR ASSASSINATE
#Choreography picked in tools/anim_lab. Phases are fractions of ASSASS_LEAD, so the
#whole thing stretches from one constant. Works for either side: everything is driven
#by get_attack_vector(), and the destination is taken from the target's global position
#because caster and target live in different containers.
const ASSASS_LEAD = 0.95 #fade out, reposition, and reappear; the hit lands at the end
const ASSASS_BACK = 0.70 #return to the original position
const ASSASS_OFF = 94.0 #how far to move behind the target
const ASSASS_Y = 26.0 #vertical offset while behind the target
const ASSASS_DIST_BACK = 22.0 #step back before entering the shadows

func assassinate_step(node, args = null):
	if args == null: args = {}
	if !node.is_inside_tree() or !node.has_method('get_attack_vector'):
		return 0.0
	var L = ASSASS_LEAD
	pending_shot_delay = L
	pending_shot_timer = cur_timer

	var tween = input_handler.GetTweenNode(node)
	node.rect_pivot_offset = node.rect_size/2
	node.rect_scale = Vector2(1,1)
	node.rect_rotation = 0
	#Control has no z_index in Godot 3, so overlap is determined by tree order.
	#For an allied assassin this already works: Panel2 is drawn after Panel, so the
	#enemy card covers the assassin. An enemy assassin is drawn on top instead.

	var p = node.rect_position
	var v = node.get_attack_vector().normalized()
	var dest = p
	if args.has('foe_node') and is_instance_valid(args.foe_node):
		#The cards use different containers, so calculate the offset in global coordinates.
		var delta = args.foe_node.rect_global_position - node.rect_global_position
		dest = p + delta + Vector2(v.x * ASSASS_OFF, ASSASS_Y)
	else:
		dest = p + v * (ASSASS_OFF * 2)

	var back = p - v*(ASSASS_DIST_BACK)
	var lift = dest - v*22 - Vector2(0, 8)

	#Exit: step back and fade out.
	tween.interpolate_property(node, 'rect_position', p, back, L*0.34, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, L*0.10)
	tween.interpolate_property(node, 'rect_rotation', 0, -4, L*0.34, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, L*0.10)
	tween.interpolate_property(node, 'rect_scale', Vector2(1,1), Vector2(0.95,0.95), L*0.34, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, L*0.10)
	tween.interpolate_property(node, 'modulate:a', 1.0, 0.0, L*0.34, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, L*0.10)
	#Reposition while invisible, making the transition read as a dash through shadow.
	tween.interpolate_property(node, 'rect_position', back, lift, L*0.16, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, L*0.44)
	tween.interpolate_callback(self, L*0.44, 'assass_set_facing', node, true)
	#Reappear behind the target and carry the blade into the hit.
	tween.interpolate_property(node, 'rect_position', lift, dest, L*0.40, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, L*0.60)
	tween.interpolate_property(node, 'rect_rotation', -4, 0, L*0.40, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, L*0.60)
	tween.interpolate_property(node, 'rect_scale', Vector2(0.95,0.95), Vector2(1,1), L*0.40, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, L*0.60)
	tween.interpolate_property(node, 'modulate:a', 0.0, 1.0, L*0.40, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, L*0.60)

	#Offset the weapon swing so its own contact frame lands exactly at L.
	var wname = 'at_sword'
	if node.fighter != null and node.fighter.has_method('get_weapon_cast_animation'):
		wname = node.fighter.get_weapon_cast_animation()
	if CAST_RELEASE.has(wname):
		var sp = CAST_SPEEDUP[wname]
		var rel = CAST_RELEASE[wname]/sp
		var dur = ResourceScripts.core_animations.get_gfx_sprite_time(wname)/sp
		tween.interpolate_callback(ResourceScripts.core_animations, max(0.0, L - rel), 'gfx_sprite',
			node, wname, 0.5, dur, !get_flip_for_node(node, args))

	#Return: fade again, move home while invisible, and gently reappear.
	var B = ASSASS_BACK
	tween.interpolate_property(node, 'modulate:a', 1.0, 0.0, B*0.42, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, L + B*0.34)
	tween.interpolate_property(node, 'rect_position', dest, dest + v*14 - Vector2(0,10), B*0.42, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, L + B*0.34)
	tween.interpolate_callback(self, L + B*0.80, 'assass_set_facing', node, false)
	tween.interpolate_property(node, 'rect_position', dest + v*14 - Vector2(0,10), p, 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, L + B*0.80)
	tween.interpolate_property(node, 'modulate:a', 0.0, 1.0, B*0.85, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, L + B*0.94)
	tween.interpolate_callback(self, L + B*1.85, 'assass_cleanup', node)
	tween.start()

	var nextanimationtime = L
	if args.has('queue_duration'): nextanimationtime = args.queue_duration
	return max(0.0, nextanimationtime - 0.1) + aftereffectdelay


#Flip only the portrait; flipping the whole card would also mirror its name and bars.
func assass_set_facing(node, backwards):
	if !is_instance_valid(node) or !node.has_node('Icon'): return
	var icon = node.get_node('Icon')
	icon.rect_pivot_offset = icon.rect_size/2
	icon.rect_scale = Vector2(-1, 1) if backwards else Vector2(1, 1)

func assass_cleanup(node):
	if !is_instance_valid(node): return
	node.rect_rotation = 0
	node.rect_scale = Vector2(1,1)
	node.modulate.a = 1.0
	assass_set_facing(node, false)

#the blow itself, on the target - waits for the assassin to appear
func assassinate(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var duration = ResourceScripts.core_animations.get_gfx_sprite_time('assassinate')
	var nextanimationtime = duration - 0.1
	var shot = take_pending_shot()
	if args != null and args.has("no_delays") and args.no_delays:
		custom_delays[node] = {delay = 0.2, cur_timer = cur_timer, time = 7}
		shot = 0.0
	else:
		hp_update_delays[node] = 0.3
		log_update_delay = max(log_update_delay, 0.3)
		buffs_update_delays[node] = 0.3
		target_tilt(node, shot)
	#The hit comes from behind, so flip the sprite relative to a normal attack.
	var flip = !get_flip_for_node(node, args)
	if shot > 0:
		tween.interpolate_callback(ResourceScripts.core_animations, shot, 'gfx_sprite',
			node, 'assassinate', 0.4, duration, flip)
	else:
		ResourceScripts.core_animations.gfx_sprite(node, 'assassinate', 0.4, duration, flip)
	tween.start()

	return shot + HIT_TAIL

#target takes the hit: eases into a pronounced lean, then swings back
func target_tilt(node, delay = 0.0):
	if !node.is_inside_tree(): return
	if !node.has_method('get_attack_vector'): return
	node.rect_pivot_offset = node.rect_size/2
	node.rect_scale = Vector2(1,1)
	node.rect_rotation = 0
	var tween = input_handler.GetTweenNode(node)
	var p = node.rect_position
	var v = node.get_attack_vector().normalized() * -MOTION_DIST * TILT_SHARE
	var tilt = TILT_ANGLE * (1 if node.get_attack_vector().x < 0 else -1)
	var peak_position = p + v - Vector2(0,TILT_LIFT)
	var peak_scale = Vector2(TILT_SCALE_X, TILT_SCALE_Y)
	tween.interpolate_property(node, 'rect_rotation', 0, tilt, TILT_IN,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, delay)
	tween.interpolate_property(node, 'rect_rotation', tilt, 0, TILT_OUT,
		Tween.TRANS_ELASTIC, Tween.EASE_OUT, delay + TILT_IN)
	tween.interpolate_property(node, 'rect_position', p, peak_position, TILT_IN,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, delay)
	tween.interpolate_property(node, 'rect_position', peak_position, p, TILT_OUT,
		Tween.TRANS_BACK, Tween.EASE_OUT, delay + TILT_IN)
	tween.interpolate_property(node, 'rect_scale', Vector2(1,1), peak_scale, TILT_IN,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, delay)
	tween.interpolate_property(node, 'rect_scale', peak_scale, Vector2(1,1), TILT_OUT,
		Tween.TRANS_ELASTIC, Tween.EASE_OUT, delay + TILT_IN)
	tween.interpolate_callback(self, delay + TILT_IN + TILT_OUT, 'target_motion_cleanup', node, p)
	tween.start()

func target_motion_cleanup(node, origin):
	if !is_instance_valid(node): return
	node.rect_position = origin
	node.rect_rotation = 0
	node.rect_scale = Vector2(1,1)

#melee: pull back, drive through the blow, hold the follow through, settle
func caster_cut(node, contact):
	if !node.is_inside_tree(): return
	if !node.has_method('get_attack_vector'): return
	node.rect_pivot_offset = node.rect_size/2 #without this rotation pulls to the corner
	node.rect_scale = Vector2(1,1)
	node.rect_rotation = 0
	node.modulate.a = 1.0 #recover if a previous shadow step did not finish its return
	assass_set_facing(node, false)
	var tween = input_handler.GetTweenNode(node)
	var p = node.rect_position
	var v = node.get_attack_vector().normalized() * MOTION_DIST
	var draw = max(contact * CUT_DRAW, 0.05)
	var drive = max(contact - draw, 0.05)

	tween.interpolate_property(node, 'rect_position', p, p - v*0.18, draw, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(node, 'rect_rotation', 0, -3, draw, Tween.TRANS_QUAD, Tween.EASE_OUT)

	tween.interpolate_property(node, 'rect_position', p - v*0.18, p + v, drive, Tween.TRANS_QUAD, Tween.EASE_IN, draw)
	tween.interpolate_property(node, 'rect_rotation', -3, 4, drive, Tween.TRANS_QUAD, Tween.EASE_IN, draw)

	tween.interpolate_property(node, 'rect_position', p + v, p, MOTION_BACK, Tween.TRANS_QUAD, Tween.EASE_OUT, contact + CUT_HOLD)
	tween.interpolate_property(node, 'rect_rotation', 4, 0, MOTION_BACK, Tween.TRANS_QUAD, Tween.EASE_OUT, contact + CUT_HOLD)
	tween.start()

#target takes the hit: knocked away and springs back past its spot
#no ShakeAnimation here - it writes rect_position every frame in _process and would
#both fight this tween and snap the node back to the position it captured at its start
func target_push(node, delay = 0.0):
	if !node.is_inside_tree(): return
	if !node.has_method('get_attack_vector'): return
	var tween = input_handler.GetTweenNode(node)
	var p = node.rect_position
	#away from the target's own side, i.e. along the attacker's swing
	var v = node.get_attack_vector().normalized() * -MOTION_DIST * PUSH_SHARE
	tween.interpolate_property(node, 'rect_position', p, p + v, PUSH_IN, Tween.TRANS_QUAD, Tween.EASE_OUT, delay)
	tween.interpolate_property(node, 'rect_position', p + v, p, PUSH_OUT, Tween.TRANS_BACK, Tween.EASE_OUT, delay + PUSH_IN)
	tween.start()

#bows: caster sinks into the draw and straightens out into the shot
func caster_recoil(node, contact):
	if !node.is_inside_tree(): return
	if !node.has_method('get_attack_vector'): return
	node.rect_pivot_offset = node.rect_size/2 #without this scale and rotation pull to the corner
	node.rect_scale = Vector2(1,1)
	node.rect_rotation = 0
	node.modulate.a = 1.0
	assass_set_facing(node, false)
	var tween = input_handler.GetTweenNode(node)
	var p = node.rect_position
	var v = node.get_attack_vector().normalized() * MOTION_DIST
	var draw = max(contact - RECOIL_EXT, 0.05)

	tween.interpolate_property(node, 'rect_position', p, p - v*0.10, draw, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(node, 'rect_scale', Vector2(1,1), Vector2(0.97,1.05), draw, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(node, 'rect_rotation', 0, -2.5, draw, Tween.TRANS_QUAD, Tween.EASE_OUT)

	tween.interpolate_property(node, 'rect_position', p - v*0.10, p + v*0.38, RECOIL_EXT, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, draw)
	tween.interpolate_property(node, 'rect_scale', Vector2(0.97,1.05), Vector2(1.04,0.96), RECOIL_EXT, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, draw)
	tween.interpolate_property(node, 'rect_rotation', -2.5, 3.0, RECOIL_EXT, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, draw)

	tween.interpolate_property(node, 'rect_position', p + v*0.38, p, MOTION_BACK, Tween.TRANS_QUAD, Tween.EASE_OUT, contact)
	tween.interpolate_property(node, 'rect_scale', Vector2(1.04,0.96), Vector2(1,1), MOTION_BACK, Tween.TRANS_QUAD, Tween.EASE_OUT, contact)
	tween.interpolate_property(node, 'rect_rotation', 3.0, 0, MOTION_BACK, Tween.TRANS_QUAD, Tween.EASE_OUT, contact)
	tween.start()

#target takes the hit: sinks by scale and springs back, plus a short shake
func target_squash(node, duration = 0.4, delay = 0.0):
	if !node.is_inside_tree(): return
	var out_time = min(SQUASH_OUT, max(duration, 0.1) * 0.8)
	node.rect_pivot_offset = node.rect_size/2
	node.rect_scale = Vector2(1,1)
	var tween = input_handler.GetTweenNode(node)
	tween.interpolate_property(node, 'rect_scale', Vector2(1,1), Vector2(SQUASH_SCALE, SQUASH_SCALE),
		SQUASH_IN, Tween.TRANS_QUAD, Tween.EASE_OUT, delay)
	tween.interpolate_property(node, 'rect_scale', Vector2(SQUASH_SCALE, SQUASH_SCALE), Vector2(1,1),
		out_time, Tween.TRANS_ELASTIC, Tween.EASE_OUT, delay + SQUASH_IN)
	tween.interpolate_callback(ResourceScripts.core_animations, delay, 'ShakeAnimation',
		node, min(0.25, out_time), SQUASH_SHAKE)
	tween.start()

#Custom hit sheets opt into a reaction; unassigned damaging hits fall back to push.
func play_target_hit_motion(node, motion = 'push', duration = 0.4, delay = 0.0):
	match motion:
		'squash':
			target_squash(node, duration, delay)
		'tilt':
			target_tilt(node, delay)
		'none':
			pass
		_:
			target_push(node, delay)

#Fallback used at the damage step when a skill has no dedicated hit reaction.
func default_hit_reaction(node, args = null):
	target_push(node)
	return HIT_TAIL

func firebolt(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.2
	hp_update_delays[node] = 0.3 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.3)
	buffs_update_delays[node] = 0.2
	ResourceScripts.core_animations.gfx_sprite(node, 'firebolt', 0.3, 0.4, get_flip_for_node(node, args))
	tween.start()
	
	return nextanimationtime + aftereffectdelay

func water_attack(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.2
	hp_update_delays[node] = 0.3 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.3)
	buffs_update_delays[node] = 0.2
	ResourceScripts.core_animations.gfx_sprite(node, 'water_attack', 0.3, 0.4, get_flip_for_node(node, args))
	tween.start()
	
	return nextanimationtime + aftereffectdelay

func flame(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.4
	hp_update_delays[node] = 0.3 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.3)
	buffs_update_delays[node] = 0.4
	ResourceScripts.core_animations.gfx_sprite(node, 'flame', 0.3, 0.5, get_flip_for_node(node, args))
	tween.start()
	
	return nextanimationtime + aftereffectdelay

func earth_spike(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.8
	hp_update_delays[node] = 0.5 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.5)
	buffs_update_delays[node] = 0.5
	ResourceScripts.core_animations.gfx_sprite(node, 'earth_spike', 0.7, 1, get_flip_for_node(node, args))
	#tween.interpolate_callback(self, nextanimationtime, 'nextanimation')
	tween.start()
	
	return nextanimationtime + aftereffectdelay
	#aftereffecttimer = nextanimationtime + aftereffectdelay

func shake_target(node, args):
	var duration = 0.5
	if args.has('duration'):
		duration = args.duration
	var nextanimationtime = duration
	if args.has('queue_duration'):
		nextanimationtime = args.queue_duration
	nextanimationtime -= 0.1
	if !args.has("no_delays"):
		hp_update_delays[node] = 0.5
		log_update_delay = max(log_update_delay, 0.5)
		buffs_update_delays[node] = 0.5
	else:
		#for now it seems thet 7 turns is repeat loop duration
		custom_delays[node] = {delay = 0.2, cur_timer = cur_timer, time = 7}
	ResourceScripts.core_animations.ShakeAnimation(node, duration)#, magnitude = 5
	
	return nextanimationtime + aftereffectdelay

func gfx_video(node, args):
	var nextanimationtime = 0.8
	hp_update_delays[node] = 0.5
	log_update_delay = max(log_update_delay, 0.5)
	buffs_update_delays[node] = 0.5
	ResourceScripts.core_animations.gfx_video(node, args.video_name, 0.7, 2, get_flip_for_node(node, args))
	
	return nextanimationtime + aftereffectdelay

#Sprites are children of the card and fade themselves out, so there is no reason for the
#queue to sit through a two second buff flourish. Cap only the implicit default: an sfx
#entry that really must block longer still says so with an explicit queue_duration.
const MAX_SFX_LOCK = 0.7

#How long the queue remains locked after contact. The hp_update slot follows, showing
#the damage number, HP-bar change, and red tint. The hit sprite remains attached to the
#card and continues fading independently.
const HIT_TAIL = 0.2

func gfx_animsprite(node, args):
	var duration
	if args.has('duration'):
		duration = args.duration
	else:
		duration = ResourceScripts.core_animations.get_gfx_sprite_time(args.sprite_name)
	# Warfare hit sheets use the same cadence as a normal weapon attack: the sheet
	# appears on the cast weapon's contact frame and hp_update follows HIT_TAIL later.
	var sync_to_hit = args.has('sync_to_hit') and args.sync_to_hit
	var shot = take_pending_shot() if sync_to_hit else 0.0
	var nextanimationtime = duration
	if args.has('queue_duration'):
		nextanimationtime = args.queue_duration
	else:
		nextanimationtime = min(nextanimationtime, MAX_SFX_LOCK)
	nextanimationtime -= 0.1
	if !args.has("no_delays"):
		if sync_to_hit:
			var hit_nodes = args.hit_nodes if args.has('hit_nodes') else [node]
			for hit_node in hit_nodes:
				if hit_node != null and is_instance_valid(hit_node):
					hp_update_delays[hit_node] = 0.3
					buffs_update_delays[hit_node] = 0.4
			log_update_delay = max(log_update_delay, 0.3)
		else:
			hp_update_delays[node] = 0.5
			log_update_delay = max(log_update_delay, 0.5)
			buffs_update_delays[node] = 0.5
	else:
		#for now it seems thet 7 turns is repeat loop duration
		custom_delays[node] = {delay = 0.2, cur_timer = cur_timer, time = 7}
	if sync_to_hit:
		var hit_motion = args.hit_motion if args.has('hit_motion') else 'push'
		var motion_nodes = args.hit_nodes if args.has('hit_nodes') else [node]
		for hit_node in motion_nodes:
			if hit_node != null and is_instance_valid(hit_node):
				play_target_hit_motion(hit_node, hit_motion, duration, shot)
	if sync_to_hit and shot > 0:
		var tween = input_handler.GetTweenNode(node)
		tween.interpolate_callback(ResourceScripts.core_animations, shot, 'gfx_sprite',
			node, args.sprite_name, 0.5, duration, get_flip_for_node(node, args))
		tween.start()
	else:
		ResourceScripts.core_animations.gfx_sprite(node, args.sprite_name, 0.5, duration, get_flip_for_node(node, args))
	
	if sync_to_hit:
		return shot + HIT_TAIL
	return nextanimationtime + aftereffectdelay

func gfx_particles(node, args):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.5
	hp_update_delays[node] = 0 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0)
	buffs_update_delays[node] = 0.5
	ResourceScripts.core_animations.gfx_particles(node, args.sprite_name, 1, 1, get_flip_for_node(node, args))
	tween.start()
	
	return nextanimationtime + aftereffectdelay

func get_flip_for_node(node, args):
	if args != null and args.has("force_flip"):
		return args.force_flip
	var flip = false
	if node.has_method("get_flip"):
		flip = node.get_flip()
	elif node.has_meta("anim_flip"):
		flip = node.get_meta("anim_flip")
	if args != null and args.has("reverse_flip"):
		flip = !flip
	return flip
	

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
	ResourceScripts.core_animations.gfx_sprite(
		node.get_parent().get_parent().get_parent().get_parent(),
		'decay', 0.5, 1.5, get_flip_for_node(node, args))
	#tween.interpolate_callback(self, nextanimationtime, 'nextanimation')
	tween.start()
	
	return nextanimationtime + aftereffectdelay
	#postdamagetimer = nextanimationtime + aftereffectdelay

func heal(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.5
	var duration = 1
	if args != null:
		if args.has('duration'):
			duration = args.duration
			nextanimationtime = duration*2
		if args.has('queue_duration'):
			nextanimationtime = args.queue_duration
	hp_update_delays[node] = 0 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0)
	buffs_update_delays[node] = 0.5
	ResourceScripts.core_animations.gfx_particles(node, 'heal', duration, duration, get_flip_for_node(node, args))
	tween.start()
	
	return nextanimationtime + aftereffectdelay

func buff(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.5
	hp_update_delays[node] = 0 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0)
	buffs_update_delays[node] = 0.5
	ResourceScripts.core_animations.gfx_particles(node, 'buff', 1, 1, get_flip_for_node(node, args))
	tween.start()
	
	return nextanimationtime + aftereffectdelay

func debuff(node, args = null):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.5
	hp_update_delays[node] = 0 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0)
	buffs_update_delays[node] = 0.5
	ResourceScripts.core_animations.gfx_particles(node, 'debuff', 1, 1, get_flip_for_node(node, args))
	tween.start()
	
	return nextanimationtime + aftereffectdelay

func miss(node, args = null):#conflicting usage of tween node!!
	var tween = input_handler.GetTweenNode(node)
	var playtime = 0.1
	var nextanimationtime = 0.0
	var delaytime = 0.4
	node.modulate.g = 1.0
	node.modulate.b = 1.0
	input_handler.PlaySound("combatmiss")
	ResourceScripts.core_animations.FloatText(node, tr("MISS"), 'miss', 75, Color(1,1,1), 1, 0.2)#, node.get_node('Icon').rect_size/2-Vector2(80,20))
	tween.interpolate_property(node, 'modulate', Color(1,1,1), Color(1,1,0), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	tween.interpolate_property(node, 'modulate', Color(1,1,0), Color(1,1,1), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delaytime)
	tween.start()
	
	var overall_time = playtime * 2 + delaytime
	if custom_delays.has(node):
		overall_time = custom_delays[node].delay
	return overall_time
	#aftereffecttimer = nextanimationtime + aftereffectdelay

func resist(node, args = null):#conflicting usage of tween node!!
	var tween = input_handler.GetTweenNode(node)
	var playtime = 0.1
	var nextanimationtime = 0.0
	var delaytime = 0.4
	node.modulate.g = 1.0
	node.modulate.b = 1.0
	input_handler.PlaySound("combatmiss")
	ResourceScripts.core_animations.FloatText(node, 'RESIST', 'miss', 75, Color(1,1,1), 1, 0.2) #stub
	#, node.get_node('Icon').rect_size/2-Vector2(80,20))
	tween.interpolate_property(node, 'modulate', Color(1,1,1), Color(1,1,0), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	tween.interpolate_property(node, 'modulate', Color(1,1,0), Color(1,1,1), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delaytime)
	tween.start()
	
	var overall_time = playtime * 2 + delaytime
	if custom_delays.has(node):
		overall_time = custom_delays[node].delay
	return overall_time

func buffs(node, args):
	var delay = 0
	if buffs_update_delays.has(node): delay = buffs_update_delays[node]
	buffs_update_delays.erase(node)
	var delaytime = 0.01
	var tween = input_handler.GetTweenNode(node)
	tween.interpolate_callback(node, delay, 'noq_rebuildbuffs')
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

#func order(node, args):
#	var delay = 0
#	var delaytime = 0.1
#	var tween = input_handler.GetTweenNode(node)
#	tween.interpolate_callback(node, delay, 'update_queue', args.queue, args.next_queue, args.current)
#	tween.start()
#	return delaytime + delay

func order_move(node, args):
	var delay = 0
	var duration = max(abs(node.rect_position.x - args.new_x) * 0.002, 0.5)
	var tween = input_handler.GetTweenNode(node)
	node.raise()
	tween.interpolate_property(node, 'rect_position:x', node.rect_position.x, args.new_x, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
	tween.start()
#	return duration + delay
	return 0

func order_remove(node, args):
	var delay = 0
	var duration = 0.5
	var tween = input_handler.GetTweenNode(node)
	tween.interpolate_property(node, 'rect_position:y', 0, node.rect_size.y, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
	tween.interpolate_property(node, 'modulate:a', 1.0, 0.0, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
	tween.interpolate_callback(args.parent, duration + delay, 'remove_queue_icon', node)
	tween.start()
#	return duration + delay
	return 0

func order_add(node, args):
	var delay = 0
	var duration = 0.5
	var tween = input_handler.GetTweenNode(node)
	tween.interpolate_property(node, 'rect_position:y', node.rect_size.y, 0, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
	tween.interpolate_property(node, 'modulate:a', 0.0, 1.0, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
	tween.start()
#	return duration + delay
	return 0

func bar_val_change(node, args):
	var delay = 0
	var duration = 0.3
	var tween = input_handler.GetTweenNode(node)
	tween.interpolate_property(node, 'value', node.value, args.value, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
	tween.start()
	return duration + delay

func critical(node, args = null):
	var delay = 0.01
	if !crit_display.has(node):
		crit_display.push_back(node)
	return delay

#Red tint on taking damage. Tints only G and B so the alpha stays untouched - the
#shadow step drives modulate:a, and writing the whole colour here would pop the
#assassin back into view mid-teleport.
const HIT_TINT = 0.45 #minimum green and blue channels during the damage tint
const HIT_TINT_IN = 0.04
const HIT_TINT_OUT = 0.35

func damage_flash(node, delay = 0.0):
	if !node.is_inside_tree(): return
	var tween = input_handler.GetTweenNode(node)
	node.modulate.g = 1.0
	node.modulate.b = 1.0
	tween.interpolate_property(node, 'modulate:g', 1.0, HIT_TINT, HIT_TINT_IN, Tween.TRANS_QUAD, Tween.EASE_OUT, delay)
	tween.interpolate_property(node, 'modulate:b', 1.0, HIT_TINT, HIT_TINT_IN, Tween.TRANS_QUAD, Tween.EASE_OUT, delay)
	tween.interpolate_property(node, 'modulate:g', HIT_TINT, 1.0, HIT_TINT_OUT, Tween.TRANS_QUAD, Tween.EASE_OUT, delay + HIT_TINT_IN)
	tween.interpolate_property(node, 'modulate:b', HIT_TINT, 1.0, HIT_TINT_OUT, Tween.TRANS_QUAD, Tween.EASE_OUT, delay + HIT_TINT_IN)
	tween.start()

func hp_update(node, args):
	var delay = 0
	if hp_update_delays.has(node): delay = hp_update_delays[node]
	hp_update_delays.erase(node)
	#Every HP decrease passes through FighterNode.update_hp, including direct hits,
	#poison, and bleeding.
	if args.has('type') and (args.type == 'damageally' or args.type == 'damageenemy'):
		damage_flash(node, delay)
	
	var delaytime = 0.2
	var tween = input_handler.GetTweenNode(node)
	var hpnode = node.get_node("bars/HP")
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
	if args.has("res"):
		tween.interpolate_callback (node, delay, 'resurrect')
	tween.start()
	return delaytime + delay

func mp_update(node, args):
	var delaytime = 0.1
	var tween = input_handler.GetTweenNode(node)
	var mpnode = node.get_node("bars/MP")
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
	ResourceScripts.core_animations.gfx(node, 'slice', 0.3, delaytime)
	var tween = input_handler.GetTweenNode(node)
	tween.interpolate_callback(node, delaytime, 'noq_defeat')
	tween.start()
	#node.get_node('Icon').material = load("res://assets/sfx/bw_shader.tres")
	#input_handler.FadeAnimation(node, 0.5, 0.3)
	if custom_delays.has(node):
		delaytime = custom_delays[node].delay
	return delaytime


func death_animation(node):
	var tween = input_handler.GetTweenNode(node)
	var playtime = 0.1
	var nextanimationtime = 0.0
	var delaytime = 0.8
	
	ResourceScripts.core_animations.FadeAnimation(node, 1, 0.5)
	return delaytime

func try_clear_custom_delays():
	for node in custom_delays.keys():
		var val = custom_delays[node]
		if cur_timer > val.cur_timer + val.time:
			custom_delays.erase(node)



