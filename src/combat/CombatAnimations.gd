extends Node

const LightningEffect = preload("res://src/combat/LightningEffect.gd")
const ProjectileEffect = preload("res://src/combat/ProjectileEffect.gd")

#The tuning numbers below (cast tables, motion distances, hit reactions, per-skill beats)
#are `var` rather than `const` on purpose: the combat lab in ../ConquestCombatTesting binds
#spin boxes to them so a timing can be tried without a restart. Values and behaviour are
#exactly what they were as constants - nothing in the game writes to them.

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
var devastation_states = {}
var devastation_arcs = []
var devastation_hp_delays = {}
var lightning_effects = []
var lightning_timing_plan = {}
var lightning_hp_delays = {}
var lightning_caster_states = {}

func force_end():
	for key in devastation_states.keys():
		devastation_restore(key)
	for arc in devastation_arcs.duplicate():
		devastation_arc_cleanup(arc)
	devastation_hp_delays.clear()
	for effect in lightning_effects.duplicate():
		if is_instance_valid(effect): effect.queue_free()
	lightning_effects.clear()
	lightning_timing_plan.clear()
	lightning_hp_delays.clear()
	for key in lightning_caster_states.keys():
		lightning_caster_restore(key, true)
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

#---------------------------------------------------------------------------
#Trace mode. Prints the queue and the per-frame transforms of every card to
#stdout so timings can be read as numbers instead of guessed at by eye.
#Switched on by the checkbox in test_combat; costs nothing while off.
const TRACE_TAIL = 3.0 #seconds of sampling after the queue drains
var trace_clock = 0.0
var trace_tail = 0.0

func tracing():
	return variables.anim_trace

func trace(text):
	if variables.anim_trace:
		print('[anim %7.3f] %s' % [trace_clock, text])

func node_label(node):
	if node == null or !is_instance_valid(node): return 'null'
	if node.get('fighter') != null and node.fighter != null:
		return '%s@%s' % [node.fighter.get_short_name(), str(node.fighter.position)]
	return node.name

func trace_frame():
	var combat = input_handler.combat_node
	if combat == null or combat.get('battlefieldpositions') == null: return
	for pos in combat.battlefieldpositions:
		var slot = combat.battlefieldpositions[pos]
		if !slot.has_node('Character'): continue
		trace_node(slot.get_node('Character'))
	#the execution leap animates a duplicate that lives outside the slots
	trace_flight(combat)

func trace_flight(root):
	for child in root.get_children():
		if child is Control and child.name == 'ExecutionFlight':
			trace_node(child)
		if child.get_child_count() > 0:
			trace_flight(child)

func trace_node(node):
	if node.rect_position == Vector2(0,0) and node.rect_rotation == 0 \
			and node.rect_scale == Vector2(1,1) and node.modulate.a == 1.0:
		return #resting card, nothing worth a line
	trace('%s pos=(%6.1f,%6.1f) rot=%6.2f scale=(%.3f,%.3f) a=%.2f' % [
		node_label(node), node.rect_position.x, node.rect_position.y,
		node.rect_rotation, node.rect_scale.x, node.rect_scale.y, node.modulate.a])

func _process(delta):
	#Tweens outlive the queue - the execution return runs for two seconds after
	#the last slot drains - so keep sampling for a while past the end.
	if variables.anim_trace:
		if is_busy:
			trace_tail = TRACE_TAIL
		if is_busy or trace_tail > 0:
			if !is_busy: trace_tail -= delta
			trace_clock += delta
			trace_frame()
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
	trace_clock = 0.0
	trace('=== queue start, %d slot(s)' % animations_queue.size())
	advance_timer()

func advance_timer():
	hp_update_delays.clear()
	if animations_queue.empty(): return
	cur_timer = animations_queue.keys().min()
	trace('--- slot %s, %d node(s)' % [str(cur_timer), animations_queue[cur_timer].size()])
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
				trace('=== queue drained')
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
		var lock = call(true_type, data.node, data.params)
		trace('  play %-18s on %-18s slot=%-10s lock=%.3f' % [
			str(data.type), node_label(node), str(data.slot), float(lock)])
		delay = max(delay, lock)
	animation_delays[node] = delay
	trace('  -> %s holds the slot for %.3f' % [node_label(node), float(delay)])

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
	if args == null: args = {}
	var tween = input_handler.GetTweenNode(node)
	var speed = max(0.01, float(args.speed)) if args.has('speed') else 1.0
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
			node, 'strike', 0.3, 0.1 / speed, get_flip_for_node(node, args), speed)
	else:
		ResourceScripts.core_animations.gfx_sprite(node, 'strike', 0.3, 0.1 / speed,
			get_flip_for_node(node, args), speed)
	tween.start()

	return shot + HIT_TAIL

func ranged_attack(node, args = null):
	if args == null: args = {}
	var tween = input_handler.GetTweenNode(node)
	var speed = max(0.01, float(args.speed)) if args.has('speed') else 1.0
	var nextanimationtime = 0.3
	var duration = 0.4
	if args.has('duration'):
		duration = args.duration
		nextanimationtime = duration
	if args.has('queue_duration'):
		nextanimationtime = args.queue_duration
	duration /= speed
	nextanimationtime /= speed
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
			node, 'arrow', 0.3, duration, get_flip_for_node(node, args), speed)
	else:
		ResourceScripts.core_animations.gfx_sprite(node, 'arrow', 0.3, duration,
			get_flip_for_node(node, args), speed)
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
var CAST_RELEASE = {
	at_sword = 0.50, at_dualsword = 0.37, at_lance = 0.40, at_axe = 0.47,
	at_dagger = 0.33, at_mace = 0.30, at_stuff = 0.53,
	at_arch = 0.60, at_arbalester = 0.40,
	at_bite = 0.10,
}
var CAST_SPEEDUP = {
	at_sword = 1.5, at_dualsword = 1.5, at_lance = 1.5, at_axe = 1.5,
	at_dagger = 1.5, at_mace = 1.5, at_stuff = 1.5,
	at_arch = 1.6, at_arbalester = 1.35,
	at_bite = 1.0,
}
#which motion the caster plays: 'cut' for melee, 'recoil' for bows, 'maw' for a bite
var CAST_MOTION = {
	at_sword = 'cut', at_dualsword = 'cut', at_lance = 'cut', at_axe = 'cut',
	at_dagger = 'cut', at_mace = 'cut', at_stuff = 'cut',
	at_arch = 'recoil', at_arbalester = 'recoil',
	at_bite = 'maw',
}
var MOTION_DIST = 110.0 #how far the card travels into the blow
var CUT_DRAW = 0.466 #share of the run-up spent pulling back
var CUT_HOLD = 0.06 #follow through before settling
var MOTION_BACK = 0.26 #settling back
var RECOIL_EXT = 0.06 #how long the straightening into the shot takes
var PUSH_OUT = 0.26 #knockback
var PUSH_IN = 0.06
var PUSH_SHARE = 0.26 #fraction of MOTION_DIST the target is knocked away
var SQUASH_IN = 0.05
var SQUASH_OUT = 0.31
var SQUASH_SCALE = 0.94
var SQUASH_SHAKE = 7
var TILT_IN = 0.11
var TILT_OUT = 0.26
var TILT_SHARE = 0.35
var TILT_ANGLE = 7.0
var TILT_LIFT = 9.0
var TILT_SCALE_X = 0.975
var TILT_SCALE_Y = 1.02

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
func at_bite(node, args = null):       return cast_with_motion(node, args, 'at_bite')

func cast_with_motion(node, args, sprite_name):
	if args == null: args = {}
	var motion = args.motion if args.has('motion') else CAST_MOTION[sprite_name]
	var followup_speed = max(0.01, float(args.speed)) if args.has('speed') else 1.0
	var speedup = CAST_SPEEDUP[sprite_name] * followup_speed
	#Execution is a finisher, so it plays its weapon sheet slower than a plain
	#swing. Everything downstream reads off the release, so the landing and the
	#target's reaction stretch with it and stay in sync.
	if motion == 'execution_leap': speedup *= EXEC_CAST_SLOW
	var release = CAST_RELEASE[sprite_name] / speedup
	var duration = ResourceScripts.core_animations.get_gfx_sprite_time(sprite_name) / speedup
	var nextanimationtime = duration
	if args.has('queue_duration'): nextanimationtime = args.queue_duration
	nextanimationtime -= 0.1

	#A bite is the one sheet whose contact frame comes far too early: the jaws
	#close at 0.10 s while the pounce needs four times that. Stretching the sheet
	#to fit would turn it into a slideshow, so the sprite is released late instead -
	#the same trick assassinate_step uses - and the pounce itself decides when the
	#blow lands. Everything downstream reads pending_shot_delay, so the damage,
	#the HP bar and the target's reaction all follow the jaws.
	if motion == 'maw':
		var sheet_hit = release
		release = MAW_LEAD / followup_speed
		var maw_tween = input_handler.GetTweenNode(node)
		maw_tween.interpolate_callback(self, max(0.0, release - sheet_hit), 'maw_sprite',
			node, sprite_name, duration, get_flip_for_node(node, args), speedup)
		maw_tween.start()
		caster_maw(node, release, followup_speed)
		pending_shot_delay = release
		pending_shot_timer = cur_timer
		return nextanimationtime + aftereffectdelay

	pending_shot_delay = release
	pending_shot_timer = cur_timer
	var visual_node = node
	if motion == 'execution_leap':
		visual_node = caster_execution_leap(node, args, release)
	ResourceScripts.core_animations.gfx_sprite(visual_node, sprite_name, 0.5, duration,
		get_flip_for_node(node, args), speedup)
	if motion == 'cut':
		caster_cut(node, release, followup_speed)
	elif motion != 'execution_leap':
		caster_recoil(node, release, followup_speed)

	return nextanimationtime + aftereffectdelay

#interpolate_callback takes at most five arguments, one short of gfx_sprite, so the
#call goes through here; it also drops the sprite if the card died while pouncing
func maw_sprite(node, sprite_name, duration, flip, speedup):
	if node == null or !is_instance_valid(node) or !node.is_inside_tree():
		return
	ResourceScripts.core_animations.gfx_sprite(node, sprite_name, 0.5, duration, flip, speedup)

#FIELD-WIDE WEATHER
#These scenes emit in a 1000 px ring, so a single instance centred on the
#battlefield covers the whole screen. It is parented to the combat node, not to a
#fighter card: the effect belongs to the scene, not to anybody's portrait, and a
#card can move or be freed while it plays.
const FIELD_SCENES = {
	rainfall_field = "res://assets/sfx/rainfall_particle_effect.tscn",
}
#Emission is a 1000 px disc, so the origin sits in the top-left corner and the
#gravity of (180, 100) carries everything down and across the field.
const FIELD_ORIGIN = Vector2(0, 0)
#Emission window. The "played twice" look came from explosiveness 0.4 releasing
#in pulses, not from the length itself - with even emission the stream simply
#refreshes and can run as long as we like.
var FIELD_HOLD = 1.4
var FIELD_DENSITY = 1.6 #more particles, so the flow reads as steady rain
var FIELD_FADE = 0.9 #then stops emitting and fades what is still in the air
#How long the windup slot is held. Everything after it - predamage, the damage
#numbers, the HP bars - waits this out, so this is the knob that decides how long
#the weather builds before it bites. The particles themselves outlive the lock.
var FIELD_LOCK = 1.3

#one interceptor per scene; add a line here and to FIELD_SCENES for the others
func rainfall_field(node, args = null):
	return field_particles('rainfall_field')

func field_particles(key):
	if !FIELD_SCENES.has(key): return 0.0
	var combat = input_handler.combat_node
	if combat == null or !is_instance_valid(combat): return 0.0
	var scene = load(FIELD_SCENES[key])
	if scene == null: return 0.0
	var fx = scene.instance()
	combat.add_child(fx)
	fx.position = FIELD_ORIGIN
	fx.z_index = 90
	var tween = input_handler.GetTweenNode(fx)
	#stop emitting first, then fade what is left, so nothing pops out mid-air
	for child in fx.get_children():
		if child is Particles2D:
			#The scene ships with explosiveness 0.4, which releases in pulses - that
			#is what read as the effect playing twice. Even emission removes the
			#seam between cycles, so the length is free to choose.
			child.explosiveness = 0.0
			child.amount = int(child.amount * FIELD_DENSITY)
			child.emitting = true
			tween.interpolate_callback(child, FIELD_HOLD, 'set_emitting', false)
	tween.interpolate_property(fx, 'modulate:a', 1.0, 0.0, FIELD_FADE,
		Tween.TRANS_SINE, Tween.EASE_IN, FIELD_HOLD)
	tween.interpolate_callback(fx, FIELD_HOLD + FIELD_FADE, 'queue_free')
	tween.start()
	return FIELD_LOCK


#SHADOW STEP FOR ASSASSINATE
#Choreography picked in tools/anim_lab. Phases are fractions of ASSASS_LEAD, so the
#whole thing stretches from one constant. Works for either side: everything is driven
#by get_attack_vector(), and the destination is taken from the target's global position
#because caster and target live in different containers.
var ASSASS_LEAD = 0.95 #fade out, reposition, and reappear; the hit lands at the end
var ASSASS_BACK = 1.15 #return to the original position
var ASSASS_OFF = 94.0 #how far to move behind the target
var ASSASS_Y = 26.0 #vertical offset while behind the target
var ASSASS_DIST_BACK = 22.0 #step back before entering the shadows

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
func caster_cut(node, contact, speed = 1.0):
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

	var hold = CUT_HOLD / speed
	var back = MOTION_BACK / speed
	tween.interpolate_property(node, 'rect_position', p + v, p, back, Tween.TRANS_QUAD, Tween.EASE_OUT, contact + hold)
	tween.interpolate_property(node, 'rect_rotation', 4, 0, back, Tween.TRANS_QUAD, Tween.EASE_OUT, contact + hold)
	tween.start()

#BITE
#What separates a bite from any weapon blow is that it does not bounce off: the
#animal crouches, pounces, and then stays clamped on the target worrying it before
#it tears away. The pounce uses EXPO rather than the QUAD of caster_cut - a beast
#launches harder than a sword arm swings.
var MAW_LEAD = 0.42 #from the start of the crouch to the jaws closing
var MAW_DIST = 125.0 #closer than MOTION_DIST: teeth are a contact weapon
#Share of the lead spent on the pounce itself. EXPO was the obvious choice for
#"launches harder than a sword swing" and it is wrong: over a fifth of a second it
#stays flat and then covers 60 px in a single frame, which reads as a teleport, not
#a leap. CUBIC over a longer window keeps the last frame near 30 px and still
#accelerates visibly harder than caster_cut's QUAD.
var MAW_POUNCE = 0.55
var MAW_COIL = 0.14 #how far back it settles before launching
var MAW_WORRY = 0.20 #held clamped on the target
var MAW_SHAKES = 3 #head shakes inside the worry
var MAW_BACK = 0.30 #tearing off

func caster_maw(node, contact, speed = 1.0):
	if !node.is_inside_tree(): return
	if !node.has_method('get_attack_vector'): return
	node.rect_pivot_offset = node.rect_size/2 #without this rotation pulls to the corner
	node.rect_scale = Vector2(1,1)
	node.rect_rotation = 0
	node.modulate.a = 1.0
	assass_set_facing(node, false)
	var tween = input_handler.GetTweenNode(node)
	var p = node.rect_position
	var v = node.get_attack_vector().normalized() * MAW_DIST
	var pounce = max(contact * MAW_POUNCE, 0.06)
	var coil = max(contact - pounce, 0.05)

	tween.interpolate_property(node, 'rect_position', p, p - v*MAW_COIL, coil, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(node, 'rect_rotation', 0, -4, coil, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(node, 'rect_scale', Vector2(1,1), Vector2(1.03,0.97), coil, Tween.TRANS_QUAD, Tween.EASE_OUT)

	tween.interpolate_property(node, 'rect_position', p - v*MAW_COIL, p + v, pounce, Tween.TRANS_CUBIC, Tween.EASE_IN, coil)
	tween.interpolate_property(node, 'rect_rotation', -4, 6, pounce, Tween.TRANS_CUBIC, Tween.EASE_IN, coil)
	tween.interpolate_property(node, 'rect_scale', Vector2(1.03,0.97), Vector2(1,1), pounce, Tween.TRANS_QUAD, Tween.EASE_OUT, coil)

	#Worry: short alternating segments rather than one shake, so the head visibly
	#wrenches back and forth while the jaws stay where they landed.
	var worry = MAW_WORRY / speed
	var seg = worry / (MAW_SHAKES*2)
	var prev_rot = 6.0
	var prev_pos = p + v
	for i in range(MAW_SHAKES*2):
		var up = i % 2 == 0
		var to_rot = 10.0 if up else 2.0
		var to_pos = p + v - v.normalized()*(5.0 if up else 0.0) + Vector2(0, -3.0 if up else 3.0)
		tween.interpolate_property(node, 'rect_rotation', prev_rot, to_rot, seg, Tween.TRANS_SINE, Tween.EASE_IN_OUT, contact + seg*i)
		tween.interpolate_property(node, 'rect_position', prev_pos, to_pos, seg, Tween.TRANS_SINE, Tween.EASE_IN_OUT, contact + seg*i)
		prev_rot = to_rot
		prev_pos = to_pos

	var back = MAW_BACK / speed
	tween.interpolate_property(node, 'rect_position', prev_pos, p, back, Tween.TRANS_BACK, Tween.EASE_OUT, contact + worry)
	tween.interpolate_property(node, 'rect_rotation', prev_rot, 0, back, Tween.TRANS_QUAD, Tween.EASE_OUT, contact + worry)
	tween.start()

#Execution: leap into the target on the weapon sheet's contact frame, settle into
#the landing, then ease out before returning. It shares the normal cast release,
#so the existing synced target_tilt reaction starts on the exact same frame.
var EXEC_LEAP_HOLD = 0.40 #beat held at the impact point before pulling out
var EXEC_LEAP_BACK = 0.70
var EXEC_LEAP_OFFSET = 28.0
var EXEC_CAST_SLOW = 0.35 #weapon sheet plays at this fraction of the usual speedup
#The flight is three explicit phases whose shares add up to 1: climb, hang, drop.
#The apex sits almost over the target, so the drop is nearly vertical.
var EXEC_LEAP_RISE = 0.52
var EXEC_LEAP_HANG = 0.26
var EXEC_LEAP_APEX_X = 0.88 #how far along the way the apex sits
#Landing: the card drives into the ground, squashes and springs back out.
const EXEC_LAND_SQUASH = Vector2(1.16, 0.84)
var EXEC_LAND_IN = 0.05 #compression on contact
var EXEC_LAND_OUT = 0.22 #elastic recovery
var EXEC_LAND_DIP = 10.0 #how far it drives past the landing point
var EXEC_LAND_TILT = 4.0 #forward jolt on impact

func caster_execution_leap(node, args, contact):
	if !node.is_inside_tree() or !node.has_method('get_attack_vector'): return node
	var original_parent = node.get_parent()
	var original_position = node.rect_position
	var original_global_position = node.rect_global_position
	var flight_parent = original_parent
	if args.has('foe_node') and is_instance_valid(args.foe_node):
		flight_parent = execution_flight_parent(node, args.foe_node)
	var visual_node = node
	var original_alpha = node.modulate.a
	if flight_parent != null and flight_parent != original_parent:
		#Keep the real card in its slot: target clearing and turn highlighting look it up
		#there. Only its visual copy crosses into the shared top-level combat layer.
		visual_node = node.duplicate()
		visual_node.set_script(null)
		visual_node.name = 'ExecutionFlight'
		visual_node.mouse_filter = Control.MOUSE_FILTER_IGNORE
		flight_parent.add_child(visual_node)
		visual_node.rect_global_position = original_global_position
		node.modulate.a = 0.0
	visual_node.rect_pivot_offset = visual_node.rect_size/2
	visual_node.rect_scale = Vector2(1,1)
	visual_node.rect_rotation = 0
	visual_node.modulate.a = 1.0
	assass_set_facing(visual_node, false)
	var tween = input_handler.GetTweenNode(visual_node)
	var p = visual_node.rect_position
	var v = node.get_attack_vector().normalized()
	var dest = p + v*MOTION_DIST
	var distance = MOTION_DIST
	if args.has('foe_node') and is_instance_valid(args.foe_node):
		var delta = args.foe_node.rect_global_position - node.rect_global_position
		dest = p + delta - v*EXEC_LEAP_OFFSET
		distance = delta.length()
	var air = max(contact, 0.10)
	var rise = air*EXEC_LEAP_RISE
	var hang = air*EXEC_LEAP_HANG
	var drop = air - rise - hang
	var apex = p.linear_interpolate(dest, EXEC_LEAP_APEX_X) - Vector2(0, min(190.0, 105.0 + distance*0.07))

	#Climb almost the whole way across and up, decelerating into the apex. Sine
	#rather than quad: quad left at full speed on frame one, which read as light
	#and flicky. Sine ramps in and carries more weight.
	tween.interpolate_property(visual_node, 'rect_position', p, apex, rise,
		Tween.TRANS_SINE, Tween.EASE_OUT)
	#Nothing is tweened during `hang` - the card simply holds the apex.
	#Then it drops. The apex is nearly over the target, so this is close to a
	#straight fall, and the landing still lands on the weapon's contact frame.
	tween.interpolate_property(visual_node, 'rect_position', apex, dest, drop,
		Tween.TRANS_QUART, Tween.EASE_IN, rise + hang)
	tween.interpolate_property(visual_node, 'rect_rotation', 0, -8, rise,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(visual_node, 'rect_rotation', -8, 0, drop,
		Tween.TRANS_QUART, Tween.EASE_IN, rise + hang)

	#Impact: drive past the landing point, compress, then spring back. Scaling is
	#centred on the card, so the dip keeps the feet on the ground while it squashes.
	var landed = dest + Vector2(0, EXEC_LAND_DIP)
	tween.interpolate_property(visual_node, 'rect_position', dest, landed, EXEC_LAND_IN,
		Tween.TRANS_QUAD, Tween.EASE_OUT, air)
	tween.interpolate_property(visual_node, 'rect_position', landed, dest, EXEC_LAND_OUT,
		Tween.TRANS_BACK, Tween.EASE_OUT, air + EXEC_LAND_IN)
	tween.interpolate_property(visual_node, 'rect_scale', Vector2(1,1), EXEC_LAND_SQUASH,
		EXEC_LAND_IN, Tween.TRANS_QUAD, Tween.EASE_OUT, air)
	tween.interpolate_property(visual_node, 'rect_scale', EXEC_LAND_SQUASH, Vector2(1,1),
		EXEC_LAND_OUT, Tween.TRANS_ELASTIC, Tween.EASE_OUT, air + EXEC_LAND_IN)
	tween.interpolate_property(visual_node, 'rect_rotation', 0, EXEC_LAND_TILT,
		EXEC_LAND_IN, Tween.TRANS_QUAD, Tween.EASE_OUT, air)
	tween.interpolate_property(visual_node, 'rect_rotation', EXEC_LAND_TILT, 0,
		EXEC_LAND_OUT, Tween.TRANS_BACK, Tween.EASE_OUT, air + EXEC_LAND_IN)

	#Hold at the impact point, then return using the values from the animation lab.
	tween.interpolate_property(visual_node, 'rect_position', dest, p, EXEC_LEAP_BACK,
		Tween.TRANS_QUAD, Tween.EASE_OUT, air + EXEC_LEAP_HOLD)
	tween.interpolate_property(visual_node, 'rect_rotation', 0, 0, EXEC_LEAP_BACK,
		Tween.TRANS_QUAD, Tween.EASE_OUT, air + EXEC_LEAP_HOLD)
	tween.interpolate_callback(self, air + EXEC_LEAP_HOLD + EXEC_LEAP_BACK,
		'execution_leap_cleanup', node, visual_node, original_alpha, original_position)
	tween.start()
	return visual_node

func execution_flight_parent(caster, foe):
	var candidate = foe.get_parent()
	while candidate != null:
		var cursor = caster.get_parent()
		while cursor != null:
			if cursor == candidate: return candidate
			cursor = cursor.get_parent()
		candidate = candidate.get_parent()
	return caster.get_parent()

func execution_leap_cleanup(node, visual_node, original_alpha, original_position):
	if is_instance_valid(visual_node) and visual_node != node:
		visual_node.queue_free()
	if !is_instance_valid(node): return
	if visual_node == node:
		node.rect_position = original_position
	node.modulate.a = original_alpha
	node.rect_rotation = 0
	#insurance: an interrupted landing must not leave the card squashed
	node.rect_scale = Vector2(1,1)
	node.rect_scale = Vector2(1,1)

# Holy Lance: orbit the spear, cross both cells in the selected row, hold the
# piercing pose through the damage frame, and then restore the caster exactly.
var HOLY_LANCE_SPIN = 0.72
var HOLY_LANCE_DASH = 0.24
var HOLY_LANCE_HOLD = 0.20
var HOLY_LANCE_BACK = 0.42
var HOLY_LANCE_ROW_STEP = 218.0
var HOLY_LANCE_PIERCE = 42.0

func holy_lance_step(node, args = null):
	if args == null: args = {}
	if !node.is_inside_tree() or !node.has_method('get_attack_vector'):
		return 0.0

	var origin = {
		position = node.rect_position,
		rotation = node.rect_rotation,
		scale = node.rect_scale,
		pivot = node.rect_pivot_offset,
		modulate = node.modulate,
	}
	var visual_node = holy_lance_flight_copy(node, args)
	visual_node.rect_pivot_offset = visual_node.rect_size/2
	var p = visual_node.rect_position
	var v = node.get_attack_vector().normalized()
	var dest = p + v*(HOLY_LANCE_ROW_STEP*2.0)
	if args.has('foe_node') and is_instance_valid(args.foe_node):
		var delta = args.foe_node.rect_global_position - node.rect_global_position
		if args.has('foe_position') and int(args.foe_position) in [1, 2, 3, 7, 8, 9]:
			delta += v*HOLY_LANCE_ROW_STEP
		dest = p + delta + v*HOLY_LANCE_PIERCE

	var spear = holy_lance_spear(visual_node, v)
	ResourceScripts.core_animations.gfx_sprite(visual_node, 'cast_light', 0.25,
		HOLY_LANCE_SPIN + HOLY_LANCE_DASH, get_flip_for_node(node, args))

	var tween = input_handler.GetTweenNode(visual_node)
	var spin_end = HOLY_LANCE_SPIN
	var contact = spin_end + HOLY_LANCE_DASH
	var return_start = contact + HOLY_LANCE_HOLD
	var finish = return_start + HOLY_LANCE_BACK

	# The card only gathers momentum during the orbit; contact remains at the end
	# of the dash so the row hit and damage numbers start on the same frame.
	tween.interpolate_property(visual_node, 'rect_scale', origin.scale,
		origin.scale*1.035, HOLY_LANCE_SPIN, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_property(visual_node, 'rect_rotation', origin.rotation,
		origin.rotation - 2.0*(1 if v.x > 0 else -1), HOLY_LANCE_SPIN,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_property(visual_node, 'rect_position', p, dest,
		HOLY_LANCE_DASH, Tween.TRANS_QUART, Tween.EASE_IN, spin_end)
	tween.interpolate_property(visual_node, 'rect_rotation',
		origin.rotation - 2.0*(1 if v.x > 0 else -1),
		origin.rotation + 4.0*(1 if v.x > 0 else -1), HOLY_LANCE_DASH,
		Tween.TRANS_QUART, Tween.EASE_IN, spin_end)
	tween.interpolate_property(visual_node, 'rect_scale', origin.scale*1.035,
		origin.scale*1.06, HOLY_LANCE_DASH, Tween.TRANS_QUART, Tween.EASE_IN, spin_end)

	tween.interpolate_property(visual_node, 'rect_position', dest, p,
		HOLY_LANCE_BACK, Tween.TRANS_QUAD, Tween.EASE_OUT, return_start)
	tween.interpolate_property(visual_node, 'rect_rotation',
		origin.rotation + 4.0*(1 if v.x > 0 else -1), origin.rotation,
		HOLY_LANCE_BACK, Tween.TRANS_BACK, Tween.EASE_OUT, return_start)
	tween.interpolate_property(visual_node, 'rect_scale', origin.scale*1.06,
		origin.scale, HOLY_LANCE_BACK, Tween.TRANS_QUAD, Tween.EASE_OUT, return_start)
	if is_instance_valid(spear):
		var facing = 0.0 if v.x > 0 else 180.0
		spear.rotation_degrees = facing
		tween.interpolate_property(spear, 'rotation_degrees', facing, facing + 720.0,
			HOLY_LANCE_SPIN, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		tween.interpolate_property(spear, 'modulate:a', 1.0, 0.0, 0.14,
			Tween.TRANS_QUAD, Tween.EASE_IN, contact + 0.06)
	tween.interpolate_callback(self, finish, 'holy_lance_cleanup', node, visual_node, origin)
	tween.start()
	return contact

func holy_lance_flight_copy(node, args):
	var original_parent = node.get_parent()
	var flight_parent = original_parent
	if args.has('foe_node') and is_instance_valid(args.foe_node):
		flight_parent = execution_flight_parent(node, args.foe_node)
	if flight_parent == null or flight_parent == original_parent:
		return node
	var visual_node = node.duplicate()
	visual_node.set_script(null)
	visual_node.name = 'HolyLanceFlight'
	visual_node.mouse_filter = Control.MOUSE_FILTER_IGNORE
	flight_parent.add_child(visual_node)
	visual_node.rect_global_position = node.rect_global_position
	node.modulate.a = 0.0
	return visual_node

func holy_lance_spear(visual_node, direction):
	var hub = Node2D.new()
	hub.name = 'HolyLanceSpear'
	hub.position = visual_node.rect_size/2
	hub.modulate = Color(1.0, 0.88, 0.32, 1.0)
	visual_node.add_child(hub)
	var spear_scene = load('res://assets/sfx/hit_animation/at_lance.tscn')
	var glow = spear_scene.instance()
	glow.stop()
	glow.frame = 6
	glow.scale = Vector2(1.7, 1.7)
	glow.modulate = Color(1.0, 0.72, 0.16, 0.24)
	glow.z_index = 1
	hub.add_child(glow)
	var blade = spear_scene.instance()
	blade.stop()
	blade.frame = 6
	blade.scale = Vector2(1.35, 1.35)
	blade.modulate = Color(1.0, 0.95, 0.64, 1.0)
	blade.z_index = 2
	hub.add_child(blade)
	return hub

func holy_lance_cleanup(node, visual_node, origin):
	if is_instance_valid(visual_node) and visual_node != node:
		visual_node.queue_free()
	if !is_instance_valid(node): return
	node.rect_position = origin.position
	node.rect_rotation = origin.rotation
	node.rect_scale = origin.scale
	node.rect_pivot_offset = origin.pivot
	node.modulate = origin.modulate

# Devastation keeps a visual copy of the caster in the common combat layer while
# the normal repeat pipeline continues to choose and damage a target per strike.
var DEVASTATION_DASH = 0.34
var DEVASTATION_STRIKE = 0.34
var DEVASTATION_QUEUE_LEAD = 0.14
var DEVASTATION_RELEASE = 0.116
var DEVASTATION_ARC = 0.19
var DEVASTATION_RETURN = 0.48
var DEVASTATION_WEAPON_SPEED = 2.35

func devastation_dash(node, args = null):
	if args == null: args = {}
	if !node.is_inside_tree() or !node.has_method('get_attack_vector'):
		return 0.0
	var key = node.get_instance_id()
	if devastation_states.has(key):
		devastation_restore(key)

	var origin = {
		position = node.rect_position,
		rotation = node.rect_rotation,
		scale = node.rect_scale,
		pivot = node.rect_pivot_offset,
		modulate = node.modulate,
	}
	var visual_node = devastation_flight_copy(node, args)
	visual_node.rect_pivot_offset = visual_node.rect_size/2
	visual_node.rect_rotation = origin.rotation
	visual_node.rect_scale = origin.scale
	var p = visual_node.rect_position
	var flight_parent = visual_node.get_parent()
	var dest = p
	if flight_parent is Control:
		dest = flight_parent.rect_size*0.5 - visual_node.rect_size*0.5
	elif args.has('foe_node') and is_instance_valid(args.foe_node):
		var midpoint = (node.rect_global_position + args.foe_node.rect_global_position)*0.5
		dest = p + midpoint - node.rect_global_position

	var direction = node.get_attack_vector().normalized()
	var brace_time = DEVASTATION_DASH*0.18
	var brace_position = p - direction*18.0
	var brace_scale = Vector2(origin.scale.x*0.98, origin.scale.y*1.02)
	var tween = input_handler.GetTweenNode(visual_node)
	tween.interpolate_property(visual_node, 'rect_position', p, brace_position,
		brace_time, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.interpolate_property(visual_node, 'rect_scale', origin.scale, brace_scale,
		brace_time, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.interpolate_property(visual_node, 'rect_rotation', origin.rotation,
		origin.rotation - 2.0*(1 if direction.x > 0 else -1), brace_time,
		Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.interpolate_property(visual_node, 'rect_position', brace_position, dest,
		DEVASTATION_DASH - brace_time, Tween.TRANS_QUART, Tween.EASE_IN, brace_time)
	tween.interpolate_property(visual_node, 'rect_scale', brace_scale, origin.scale,
		DEVASTATION_DASH - brace_time, Tween.TRANS_QUAD, Tween.EASE_OUT, brace_time)
	tween.interpolate_property(visual_node, 'rect_rotation',
		origin.rotation - 2.0*(1 if direction.x > 0 else -1), origin.rotation,
		DEVASTATION_DASH - brace_time, Tween.TRANS_QUAD, Tween.EASE_OUT, brace_time)
	tween.start()

	devastation_states[key] = {
		node = node,
		visual = visual_node,
		origin = origin,
		visual_origin = p,
		center_position = dest,
	}
	return DEVASTATION_DASH

func devastation_flight_copy(node, args):
	var original_parent = node.get_parent()
	var flight_parent = original_parent
	if args.has('foe_node') and is_instance_valid(args.foe_node):
		flight_parent = execution_flight_parent(node, args.foe_node)
	if flight_parent == null or flight_parent == original_parent:
		return node
	var visual_node = node.duplicate()
	visual_node.set_script(null)
	visual_node.name = 'DevastationFlight'
	visual_node.mouse_filter = Control.MOUSE_FILTER_IGNORE
	flight_parent.add_child(visual_node)
	visual_node.rect_global_position = node.rect_global_position
	node.modulate.a = 0.0
	return visual_node

func devastation_strike(node, args = null):
	if args == null: args = {}
	var caster_node = args.caster_node if args.has('caster_node') else null
	if caster_node == null or !is_instance_valid(caster_node):
		target_squash(node, DEVASTATION_STRIKE)
		return DEVASTATION_STRIKE
	var key = caster_node.get_instance_id()
	if !devastation_states.has(key):
		target_squash(node, DEVASTATION_STRIKE)
		return DEVASTATION_STRIKE
	var state = devastation_states[key]
	var visual_node = state.visual
	if !is_instance_valid(visual_node):
		target_squash(node, DEVASTATION_STRIKE)
		return DEVASTATION_STRIKE

	var iteration = int(args.iteration) if args.has('iteration') else 1
	var weapon_sprite = args.weapon_sprite if args.has('weapon_sprite') else 'at_sword'
	devastation_strike_motion(visual_node, state, caster_node, iteration)
	ResourceScripts.core_animations.gfx_sprite(visual_node, weapon_sprite, 0.10,
		DEVASTATION_STRIKE, !get_flip_for_node(caster_node, args), DEVASTATION_WEAPON_SPEED)
	var tween = input_handler.GetTweenNode(visual_node)
	tween.interpolate_callback(self, DEVASTATION_RELEASE, 'devastation_launch_arc',
		visual_node, node, iteration)
	tween.interpolate_callback(self, DEVASTATION_RELEASE + DEVASTATION_ARC,
		'target_squash', node, DEVASTATION_STRIKE, 0.0)
	tween.interpolate_callback(self, 0.75, 'devastation_clear_hp_delay', node, iteration)
	tween.start()
	return DEVASTATION_QUEUE_LEAD

func devastation_strike_motion(visual_node, state, caster_node, iteration):
	if !is_instance_valid(visual_node): return
	var center_position = state.center_position
	var base_rotation = state.origin.rotation
	var base_scale = state.origin.scale
	var direction = caster_node.get_attack_vector().normalized() if caster_node.has_method('get_attack_vector') else Vector2.RIGHT
	var vertical = Vector2(0.0, -7.0 if iteration % 2 == 0 else 7.0)
	var brace = center_position - direction*12.0 - vertical*0.35
	var impact = center_position + direction*20.0 + vertical
	var sign_value = 1.0 if direction.x > 0 else -1.0
	visual_node.rect_pivot_offset = visual_node.rect_size/2
	var tween = Tween.new()
	tween.name = 'DevastationStrikeMotion%d' % iteration
	visual_node.add_child(tween)
	tween.interpolate_property(visual_node, 'rect_position', center_position, brace,
		0.035, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(visual_node, 'rect_position', brace, impact,
		0.050, Tween.TRANS_QUART, Tween.EASE_IN, 0.035)
	tween.interpolate_property(visual_node, 'rect_position', impact, center_position,
		0.055, Tween.TRANS_BACK, Tween.EASE_OUT, 0.085)
	tween.interpolate_property(visual_node, 'rect_rotation', base_rotation, base_rotation - 4.0*sign_value,
		0.035, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(visual_node, 'rect_rotation', base_rotation - 4.0*sign_value, base_rotation + 6.0*sign_value,
		0.050, Tween.TRANS_QUART, Tween.EASE_IN, 0.035)
	tween.interpolate_property(visual_node, 'rect_rotation', base_rotation + 6.0*sign_value, base_rotation,
		0.055, Tween.TRANS_BACK, Tween.EASE_OUT, 0.085)
	tween.interpolate_property(visual_node, 'rect_scale', base_scale, Vector2(base_scale.x*0.97, base_scale.y*1.04),
		0.035, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(visual_node, 'rect_scale', Vector2(base_scale.x*0.97, base_scale.y*1.04), Vector2(base_scale.x*1.05, base_scale.y*0.96),
		0.050, Tween.TRANS_QUART, Tween.EASE_IN, 0.035)
	tween.interpolate_property(visual_node, 'rect_scale', Vector2(base_scale.x*1.05, base_scale.y*0.96), base_scale,
		0.055, Tween.TRANS_BACK, Tween.EASE_OUT, 0.085)
	tween.interpolate_callback(tween, 0.141, 'queue_free')
	tween.start()

func devastation_launch_arc(visual_node, target_node, iteration):
	if !is_instance_valid(visual_node) or !is_instance_valid(target_node): return
	var flight_parent = visual_node.get_parent()
	if flight_parent == null: return
	var start = visual_node.rect_position + visual_node.rect_size/2
	start += Vector2(12.0 if iteration%2 == 0 else -12.0, (iteration%3 - 1)*18.0)
	var finish = devastation_control_center_in_parent(flight_parent, target_node)
	var direction = finish - start
	if direction.length() < 1.0: direction = Vector2.RIGHT
	var perpendicular = Vector2(-direction.y, direction.x).normalized()
	var curve = (55.0 + (iteration%3)*14.0) * (1.0 if iteration%2 == 0 else -1.0)
	var midpoint = start.linear_interpolate(finish, 0.5) + perpendicular*curve

	var carrier = Node2D.new()
	carrier.name = 'DevastationArc'
	carrier.position = start
	carrier.rotation = direction.angle()
	carrier.z_index = 25
	flight_parent.add_child(carrier)
	devastation_arcs.append(carrier)
	var effect = 'devastation_%d' % clamp(iteration, 1, 6)
	var arc = load(images.GFX_sprites[effect]).instance()
	arc.scale = Vector2(0.44, 0.44)
	arc.speed_scale = 10.0/(30.0*DEVASTATION_ARC)
	carrier.add_child(arc)
	arc.play()

	var tween = input_handler.GetTweenNode(carrier)
	var half = DEVASTATION_ARC*0.5
	tween.interpolate_property(carrier, 'position', start, midpoint, half,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(carrier, 'position', midpoint, finish, half,
		Tween.TRANS_QUAD, Tween.EASE_IN, half)
	tween.interpolate_property(arc, 'scale', Vector2(0.44, 0.44), Vector2(0.54, 0.42),
		0.04, Tween.TRANS_QUAD, Tween.EASE_OUT, DEVASTATION_ARC - 0.04)
	tween.interpolate_property(arc, 'modulate:a', 1.0, 0.0, 0.10,
		Tween.TRANS_QUAD, Tween.EASE_IN, DEVASTATION_ARC)
	tween.interpolate_callback(self, DEVASTATION_ARC + 0.10,
		'devastation_arc_cleanup', carrier)
	tween.start()

func devastation_control_center_in_parent(parent, control):
	var global_center = control.rect_global_position + control.rect_size/2
	if parent is Control:
		return global_center - parent.rect_global_position
	return parent.get_global_transform_with_canvas().affine_inverse().xform(global_center)

func devastation_arc_cleanup(arc):
	devastation_arcs.erase(arc)
	if is_instance_valid(arc): arc.queue_free()

func prepare_devastation_hp_update(node, iteration):
	devastation_hp_delays[node] = {
		delay = DEVASTATION_RELEASE + DEVASTATION_ARC - DEVASTATION_QUEUE_LEAD,
		iteration = iteration,
	}

func devastation_clear_hp_delay(node, iteration):
	if devastation_hp_delays.has(node) and devastation_hp_delays[node].iteration == iteration:
		devastation_hp_delays.erase(node)

func devastation_return(node, args = null):
	if !is_instance_valid(node): return 0.0
	var key = node.get_instance_id()
	if !devastation_states.has(key): return 0.0
	var state = devastation_states[key]
	var visual_node = state.visual
	if !is_instance_valid(visual_node):
		devastation_restore(key)
		return 0.0
	var tween = input_handler.GetTweenNode(visual_node)
	tween.interpolate_property(visual_node, 'rect_position', visual_node.rect_position,
		state.visual_origin, DEVASTATION_RETURN, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(visual_node, 'rect_rotation', visual_node.rect_rotation,
		state.origin.rotation, DEVASTATION_RETURN, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.interpolate_property(visual_node, 'rect_scale', visual_node.rect_scale,
		state.origin.scale, DEVASTATION_RETURN, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_callback(self, DEVASTATION_RETURN, 'devastation_restore', key)
	tween.start()
	return DEVASTATION_RETURN

func devastation_restore(key):
	if !devastation_states.has(key): return
	var state = devastation_states[key]
	devastation_states.erase(key)
	var visual_node = state.visual
	if is_instance_valid(visual_node) and visual_node.has_node('tween'):
		visual_node.get_node('tween').stop_all()
	if is_instance_valid(visual_node) and visual_node != state.node:
		visual_node.queue_free()
	var node = state.node
	if !is_instance_valid(node): return
	node.rect_position = state.origin.position
	node.rect_rotation = state.origin.rotation
	node.rect_scale = state.origin.scale
	node.rect_pivot_offset = state.origin.pivot
	node.modulate = state.origin.modulate

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
func caster_recoil(node, contact, speed = 1.0):
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
	var recoil_ext = RECOIL_EXT / speed
	var back = MOTION_BACK / speed
	var draw = max(contact - recoil_ext, 0.05)

	tween.interpolate_property(node, 'rect_position', p, p - v*0.10, draw, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(node, 'rect_scale', Vector2(1,1), Vector2(0.97,1.05), draw, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(node, 'rect_rotation', 0, -2.5, draw, Tween.TRANS_QUAD, Tween.EASE_OUT)

	tween.interpolate_property(node, 'rect_position', p - v*0.10, p + v*0.38, recoil_ext, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, draw)
	tween.interpolate_property(node, 'rect_scale', Vector2(0.97,1.05), Vector2(1.04,0.96), recoil_ext, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, draw)
	tween.interpolate_property(node, 'rect_rotation', -2.5, 3.0, recoil_ext, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, draw)

	tween.interpolate_property(node, 'rect_position', p + v*0.38, p, back, Tween.TRANS_QUAD, Tween.EASE_OUT, contact)
	tween.interpolate_property(node, 'rect_scale', Vector2(1.04,0.96), Vector2(1,1), back, Tween.TRANS_QUAD, Tween.EASE_OUT, contact)
	tween.interpolate_property(node, 'rect_rotation', 3.0, 0, back, Tween.TRANS_QUAD, Tween.EASE_OUT, contact)
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
	if args == null: args = {}
	var tween = input_handler.GetTweenNode(node)
	var speed = max(0.01, float(args.speed)) if args.has('speed') else 1.0
	var duration = 0.4 / speed
	var nextanimationtime = 0.2 / speed
	var sync_to_hit = args.has('sync_to_hit') and args.sync_to_hit
	var shot = take_pending_shot() if sync_to_hit else 0.0
	hp_update_delays[node] = 0.3 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.3)
	buffs_update_delays[node] = 0.2
	if shot > 0:
		target_push(node, shot)
		tween.interpolate_callback(ResourceScripts.core_animations, shot, 'gfx_sprite',
			node, 'firebolt', 0.3, duration, get_flip_for_node(node, args), speed)
	else:
		ResourceScripts.core_animations.gfx_sprite(node, 'firebolt', 0.3, duration,
			get_flip_for_node(node, args), speed)
	tween.start()
	
	if sync_to_hit:
		return shot + HIT_TAIL
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
	if args == null: args = {}
	var tween = input_handler.GetTweenNode(node)
	var speed = max(0.01, float(args.speed)) if args.has('speed') else 1.0
	var duration = 0.5 / speed
	var nextanimationtime = 0.4 / speed
	hp_update_delays[node] = 0.3 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.3)
	buffs_update_delays[node] = 0.4
	ResourceScripts.core_animations.gfx_sprite(node, 'flame', 0.3, duration,
		get_flip_for_node(node, args), speed)
	tween.start()
	
	return nextanimationtime + aftereffectdelay

func earth_spike(node, args = null):
	if args == null: args = {}
	var tween = input_handler.GetTweenNode(node)
	var speed = max(0.01, float(args.speed)) if args.has('speed') else 1.0
	var duration = 1.0 / speed
	var nextanimationtime = 0.8 / speed
	var sync_to_hit = args.has('sync_to_hit') and args.sync_to_hit
	var shot = take_pending_shot() if sync_to_hit else 0.0
	hp_update_delays[node] = 0.5 #delay for hp updating during this animation
	log_update_delay = max(log_update_delay, 0.5)
	buffs_update_delays[node] = 0.5
	if shot > 0:
		target_push(node, shot)
		tween.interpolate_callback(ResourceScripts.core_animations, shot, 'gfx_sprite',
			node, 'earth_spike', 0.7, duration, get_flip_for_node(node, args), speed)
	else:
		ResourceScripts.core_animations.gfx_sprite(node, 'earth_spike', 0.7, duration,
			get_flip_for_node(node, args), speed)
	#tween.interpolate_callback(self, nextanimationtime, 'nextanimation')
	tween.start()
	
	if sync_to_hit:
		return shot + HIT_TAIL
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
var MAX_SFX_LOCK = 0.7

#How long the queue remains locked after contact. The hp_update slot follows, showing
#the damage number, HP-bar change, and red tint. The hit sprite remains attached to the
#card and continues fading independently.
var HIT_TAIL = 0.2

#--- projectiles that cross the battlefield --------------------------------------------
#'arrow' and 'fireball' fly from the caster's card to the target's, land on a random point
#inside the target rather than on its exact centre, and hold the queue until they arrive,
#so the number and the HP bar follow the hit and not the launch. The drawing lives in
#ProjectileEffect.gd; everything below is timing.
#
#Flight time comes from distance, so a shot at the far row takes longer than one at the
#front - unless the skill states a duration of its own.

var PROJ_ARROW_SPEED = 1900.0 #px per second
var PROJ_FIRE_SPEED = 1150.0
var PROJ_MIN_FLIGHT = 0.18
var PROJ_MAX_FLIGHT = 0.80
var PROJ_ARROW_ARC = 42.0 #height of the flight arc in px, 0 is a flat shot
var PROJ_FIRE_ARC = 105.0
var PROJ_SCATTER = 30.0 #radius of the landing spread around the centre of the card
var PROJ_ARROW_STICK = 0.34 #how long the arrow stays in the target before fading
var PROJ_FIRE_BOOM = 110.0 #radius the explosion reaches
var PROJ_FIRE_BOOM_TIME = 0.42

#Delays are set by several animations on the same node; the later one must never shorten
#what an earlier one asked for.
func bump_delay(dict, node, value):
	dict[node] = max(dict[node] if dict.has(node) else 0.0, value)

func projectile_arrow(node, args = null):
	return fly_projectile(node, args, 'arrow')

func projectile_fireball(node, args = null):
	return fly_projectile(node, args, 'fireball')

func card_center(node):
	if node is Control:
		var rect = node.get_global_rect()
		return rect.position + rect.size * 0.5
	if node is Node2D: return node.global_position
	return Vector2()

func fly_projectile(node, args, kind):
	if args == null: args = {}
	if node == null or !is_instance_valid(node): return HIT_TAIL
	#the shot needs both ends; without a caster there is nothing to fly from
	var caster_node = args.caster_node if args.has('caster_node') else null
	if caster_node == null or !is_instance_valid(caster_node): return HIT_TAIL

	var speed = max(0.01, float(args.speed)) if args.has('speed') else 1.0
	var distance = card_center(node).distance_to(card_center(caster_node))
	var base_speed = PROJ_FIRE_SPEED if kind == 'fireball' else PROJ_ARROW_SPEED
	var flight = clamp(distance / max(1.0, base_speed), PROJ_MIN_FLIGHT, PROJ_MAX_FLIGHT)
	if args.has('duration'): flight = float(args.duration)
	flight /= speed

	#a weapon cast in the windup slot releases partway through its sheet: wait for that
	#moment before the shot leaves, the way ranged_attack does
	var shot = take_pending_shot()
	var boom = PROJ_FIRE_BOOM_TIME if kind == 'fireball' else PROJ_ARROW_STICK

	if args.has('no_delays') and args.no_delays:
		custom_delays[node] = {delay = 0.2, cur_timer = cur_timer, time = 7}
	else:
		#everything the target does happens on contact, not on release
		bump_delay(hp_update_delays, node, shot + flight)
		bump_delay(buffs_update_delays, node, shot + flight)
		log_update_delay = max(log_update_delay, shot + flight)
		var motion = args.hit_motion if args.has('hit_motion') else 'push'
		play_target_hit_motion(node, motion, max(0.2, boom), shot + flight)

	var effect = ProjectileEffect.new()
	#Not a child of this node: CombatAnimations is a plain Node, and a Node2D under it ends
	#up ordered against the combat window rather than inside it, which puts the impact
	#behind the opaque portraits. As the last child of the combat scene it draws over every
	#card, which is where a hit has to be seen.
	var layer = get_parent()
	if layer == null: layer = self
	layer.add_child(effect)
	effect.setup(caster_node, node, kind, {
		flight = flight,
		launch_delay = shot,
		arc = float(args.arc) if args.has('arc') else (PROJ_FIRE_ARC if kind == 'fireball' else PROJ_ARROW_ARC),
		scatter = float(args.scatter) if args.has('scatter') else PROJ_SCATTER,
		spin = float(args.spin) if args.has('spin') else 0.0,
		boom_time = boom,
		boom_size = float(args.boom_size) if args.has('boom_size') else (PROJ_FIRE_BOOM if kind == 'fireball' else PROJ_FIRE_BOOM * 0.5),
	})

	if args.has('queue_duration'): return float(args.queue_duration)
	return shot + flight + HIT_TAIL


var LIGHTNING_WINDUP = 0.58
var LIGHTNING_DURATION = 0.76
var LIGHTNING_JITTER = 25.0
var CHAIN_LIGHTNING_STAGGER = 0.10
var LIGHTNING_IMPACT_DELAY = 0.055
var LIGHTNING_SHAKE = 8

func lightning(node, args = null):
	if args == null: args = {}
	var caster_node = args.caster_node if args.has('caster_node') else null
	var settings = get_lightning_settings(args, false)
	if args.has('sync_to_hit') and args.sync_to_hit:
		var shot = take_pending_shot()
		if shot > 0: settings.windup = shot
	start_lightning_effect(caster_node, [node], settings)
	prepare_lightning_impacts([node], settings)
	return settings.windup + HIT_TAIL

func chain_lightning(node, args = null):
	if args == null: args = {}
	var caster_node = args.caster_node if args.has('caster_node') else null
	var hit_nodes = args.hit_nodes if args.has('hit_nodes') else []
	if hit_nodes.empty() and args.has('primary_node'): hit_nodes = [args.primary_node]
	var settings = get_lightning_settings(args, true)
	start_lightning_effect(caster_node, hit_nodes, settings)
	prepare_lightning_impacts(hit_nodes, settings)
	return settings.windup + HIT_TAIL

func get_lightning_settings(args, chained):
	var speed = max(0.01, float(args.speed)) if args.has('speed') else 1.0
	return {
		windup = (float(args.windup) if args.has('windup') else LIGHTNING_WINDUP) / speed,
		duration = (float(args.duration) if args.has('duration') else LIGHTNING_DURATION) / speed,
		jitter = float(args.jitter) if args.has('jitter') else LIGHTNING_JITTER,
		branch_stagger = (float(args.branch_stagger) if chained and args.has('branch_stagger') else (CHAIN_LIGHTNING_STAGGER if chained else 0.0)) / speed,
		chained = chained,
	}

func start_lightning_effect(caster_node, hit_nodes, settings):
	if caster_node == null or !is_instance_valid(caster_node) or hit_nodes.empty(): return
	lightning_caster_charge(caster_node, settings.windup)
	var effect = LightningEffect.new()
	add_child(effect)
	effect.setup(caster_node, hit_nodes, {
		windup = settings.windup,
		duration = settings.duration,
		jitter = settings.jitter,
		branch_stagger = settings.branch_stagger,
	})
	lightning_effects.append(effect)
	effect.connect('tree_exited', self, '_on_lightning_effect_exited', [effect], CONNECT_ONESHOT)

func lightning_caster_charge(node, windup):
	if node == null or !is_instance_valid(node) or !node.is_inside_tree(): return
	var key = node.get_instance_id()
	if lightning_caster_states.has(key): lightning_caster_restore(key, true)
	var origin = {
		node = node,
		position = node.rect_position,
		rotation = node.rect_rotation,
		scale = node.rect_scale,
		pivot = node.rect_pivot_offset,
	}
	lightning_caster_states[key] = origin
	node.rect_pivot_offset = node.rect_size/2
	var direction = node.get_attack_vector().normalized() if node.has_method('get_attack_vector') else Vector2.RIGHT
	var gather_time = max(0.12, windup*0.65)
	var focus_time = max(0.06, windup - gather_time)
	var gather_position = origin.position - direction*14.0 + Vector2(0.0, -6.0)
	var focus_position = origin.position - direction*7.0 + Vector2(0.0, -12.0)
	var release_position = origin.position + direction*11.0 + Vector2(0.0, -4.0)
	var sign_value = 1.0 if direction.x > 0 else -1.0
	var tween = input_handler.GetTweenNode(node)
	tween.interpolate_property(node, 'rect_position', origin.position, gather_position,
		gather_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_property(node, 'rect_position', gather_position, focus_position,
		focus_time, Tween.TRANS_QUAD, Tween.EASE_IN, gather_time)
	tween.interpolate_property(node, 'rect_position', focus_position, release_position,
		0.06, Tween.TRANS_QUART, Tween.EASE_OUT, windup)
	tween.interpolate_property(node, 'rect_position', release_position, origin.position,
		0.12, Tween.TRANS_BACK, Tween.EASE_OUT, windup + 0.06)
	tween.interpolate_property(node, 'rect_rotation', origin.rotation, origin.rotation - 3.0*sign_value,
		gather_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_property(node, 'rect_rotation', origin.rotation - 3.0*sign_value, origin.rotation + 2.0*sign_value,
		focus_time, Tween.TRANS_QUAD, Tween.EASE_IN, gather_time)
	tween.interpolate_property(node, 'rect_rotation', origin.rotation + 2.0*sign_value, origin.rotation,
		0.18, Tween.TRANS_BACK, Tween.EASE_OUT, windup)
	tween.interpolate_property(node, 'rect_scale', origin.scale,
		Vector2(origin.scale.x*0.97, origin.scale.y*1.04), gather_time,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_property(node, 'rect_scale', Vector2(origin.scale.x*0.97, origin.scale.y*1.04),
		Vector2(origin.scale.x*1.03, origin.scale.y*0.98), focus_time,
		Tween.TRANS_QUAD, Tween.EASE_IN, gather_time)
	tween.interpolate_property(node, 'rect_scale', Vector2(origin.scale.x*1.03, origin.scale.y*0.98),
		origin.scale, 0.18, Tween.TRANS_BACK, Tween.EASE_OUT, windup)
	tween.interpolate_callback(self, windup + 0.18, 'lightning_caster_restore', key)
	tween.start()

func lightning_caster_restore(key, stop_tween = false):
	if !lightning_caster_states.has(key): return
	var origin = lightning_caster_states[key]
	lightning_caster_states.erase(key)
	var node = origin.node
	if node == null or !is_instance_valid(node): return
	if stop_tween and node.has_node('tween'): node.get_node('tween').stop_all()
	node.rect_position = origin.position
	node.rect_rotation = origin.rotation
	node.rect_scale = origin.scale
	node.rect_pivot_offset = origin.pivot

func _on_lightning_effect_exited(effect):
	lightning_effects.erase(effect)

func prepare_lightning_impacts(hit_nodes, settings):
	var queue_release = settings.windup + HIT_TAIL
	var tween = input_handler.GetTweenNode(self)
	for index in range(hit_nodes.size()):
		var hit_node = hit_nodes[index]
		if hit_node == null or !is_instance_valid(hit_node): continue
		var branch_delay = 0.0 if index == 0 or !settings.chained else 0.10 + float(index - 1) * settings.branch_stagger
		var impact_time = settings.windup + branch_delay + LIGHTNING_IMPACT_DELAY
		lightning_timing_plan[hit_node] = max(0.0, impact_time - queue_release)
		tween.interpolate_callback(self, impact_time, 'lightning_target_hit', hit_node)
	tween.start()

func lightning_target_hit(node):
	if node == null or !is_instance_valid(node) or !node.is_inside_tree(): return
	target_push(node)
	if node.has_node('Icon'):
		ResourceScripts.core_animations.ShakeAnimation(node.get_node('Icon'), 0.22, LIGHTNING_SHAKE)

func prepare_lightning_hp_update(node):
	if lightning_timing_plan.has(node):
		lightning_hp_delays[node] = lightning_timing_plan[node]

func clear_lightning_timing():
	lightning_timing_plan.clear()

func gfx_animsprite(node, args):
	var speed = max(0.01, float(args.speed)) if args.has('speed') else 1.0
	var duration
	if args.has('duration'):
		duration = args.duration / speed
	else:
		duration = ResourceScripts.core_animations.get_gfx_sprite_time(args.sprite_name) / speed
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
					bump_delay(hp_update_delays, hit_node, 0.3)
					bump_delay(buffs_update_delays, hit_node, 0.4)
			log_update_delay = max(log_update_delay, 0.3)
		else:
			bump_delay(hp_update_delays, node, 0.5)
			log_update_delay = max(log_update_delay, 0.5)
			bump_delay(buffs_update_delays, node, 0.5)
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
			node, args.sprite_name, 0.5, duration, get_flip_for_node(node, args), speed)
		tween.start()
	else:
		ResourceScripts.core_animations.gfx_sprite(node, args.sprite_name, 0.5, duration,
			get_flip_for_node(node, args), speed)
	
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
var HIT_TINT = 0.45 #minimum green and blue channels during the damage tint
var HIT_TINT_IN = 0.04
var HIT_TINT_OUT = 0.35

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
	var nonblocking_delay = false
	if hp_update_delays.has(node): delay = hp_update_delays[node]
	hp_update_delays.erase(node)
	if lightning_hp_delays.has(node):
		delay = max(delay, lightning_hp_delays[node])
		lightning_hp_delays.erase(node)
	if devastation_hp_delays.has(node):
		delay = devastation_hp_delays[node].delay
		devastation_hp_delays.erase(node)
		nonblocking_delay = true
	#Every HP decrease passes through FighterNode.update_hp, including direct hits,
	#poison, and bleeding. A follow-up that lands for nothing - hyperborea_1 only
	#applies a status - still queues an hp_update, and flashing the card for it
	#reads as the whole animation playing a second time.
	#damage arrives signed - a hit is negative, healing positive - so the test is
	#on the magnitude. Comparing the raw value against zero silently swallowed
	#every real hit.
	var real_damage = !args.has('damage') or abs(ceil(args.damage)) > 0
	if args.has('type') and (args.type == 'damageally' or args.type == 'damageenemy') and real_damage:
		damage_flash(node, delay)
	
	var delaytime = 0.2
	var tween = input_handler.GetTweenNode(node)
	var hpnode = node.get_node("bars/HP")
	#float damage
	if args.damage_float and real_damage:
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
	return delaytime if nonblocking_delay else delaytime + delay

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
