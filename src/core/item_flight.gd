extends Control

#Global "the thing you just got flies into your inventory" effect.
#One overlay owns every sprite, so the whole effect can be capped, throttled and switched
#off from the options in a single place instead of each caller reinventing a tween.
#Call it through ResourceScripts.core_animations.ItemFlight/ItemFlightGold/ItemFlightMaterial.

const MAX_ACTIVE = 28 #hard cap on sprites in flight at once, extra requests are dropped
const MAX_PER_CALL = 8 #a single call never spawns more than this many sprites
const REPEAT_WINDOW_MSEC = 200 #the same icon asked for twice inside this window is merged away
const POOL_LIMIT = 32
const OFFSCREEN_MARGIN = 420 #how far past the bottom edge the "no inventory button" target sits
const ARRIVAL_CUE_COOLDOWN_MSEC = 300 #floor between two cues of the same sound
const POP_COOLDOWN_MSEC = 240 #a node cannot re-pop until its previous pop has finished
const GOLD_ICON = "res://assets/images/iconsitems/gold.png"

#every one of these can be overridden per call via the params dictionary
var defaults = {
	time = 0.7, #seconds of flight
	time_rng = 0.12, #+-this fraction of 'time', rolled per sprite
	delay = 0.0, #seconds before the first sprite leaves
	stagger = 0.08, #extra delay for each following sprite
	arc = 110.0, #how far the path bows away from the straight line, px - 0 flies straight
	arc_rng = 0.45, #+-this fraction of 'arc', rolled per sprite
	arc_side = 0, #-1/1 forces the side the path bows to, 0 alternates it per sprite
	lift = 70.0, #extra upward pull on the path, px - keeps flat trajectories from looking limp
	spread = 26.0, #random offset of the spawn point, px - 0 keeps sprites in a single file
	curve = 1.8, #ease() curve: >1 drifts out slowly then accelerates into the target, 1 is linear
	anticipate = 0.12, #fraction of the flight spent easing *away* from the target first
	anticipate_dist = 26.0, #how far that backswing carries, px - 0 disables it
	size = Vector2(110, 110),
	start_scale = 0.5,
	peak_scale = 1.0,
	end_scale = 0.3,
	spin = 25.0, #max degrees turned over the flight; direction and amount rolled per sprite
	fade_out = 0.78, #fraction of the flight after which it fades out; 1.0 never fades
	sound = 'itemget', #played once per call as the first sprite lands, null for silence
	pop = true, #briefly scale up whatever node the sprites landed on
	count = 1, #sprites to spawn
	amount = 0, #how many things were acquired - picks 'count' for you when count is not given
	target = null, #Vector2 / Control / null -> inventory button, or off the bottom if absent
	key = null, #throttle key, defaults to the texture path
}

var _active = [] #sprites currently flying
var _pool = [] #hidden sprites kept for reuse
var _last_spawn = {} #throttle key -> OS.get_ticks_msec() of the last accepted call
var _group_counter = 0 #one group per fly() call, so a burst only cues once
var _cued_groups = {}
var _last_cue = {} #sound name -> OS.get_ticks_msec() it last played
var _last_pop = {} #arrival node id -> OS.get_ticks_msec() it last popped
var _gold_tex = null


func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	set_anchors_and_margins_preset(Control.PRESET_WIDE)
	set_process(false)


func is_enabled():
	return !input_handler.globalsettings.get("no_item_flight", false)


#icon accepts a Texture, a resource path, a material code or an Item; start accepts a
#Vector2 in screen coordinates or a Control to launch from the center of.
func fly(icon, start, params = {}):
	if !is_enabled():
		return
	var tex = resolve_texture(icon)
	if tex == null:
		return
	var origin = resolve_point(start)
	if origin == null:
		return

	var p = defaults.duplicate()
	for k in params:
		p[k] = params[k]

	var target_node = null
	if typeof(p.target) == TYPE_OBJECT:
		target_node = p.target
	var target = resolve_point(p.target)
	if target == null:
		target_node = get_inventory_anchor()
		if target_node != null:
			target = resolve_point(target_node)
		else:
			#nothing on screen to land on, so sail well past the bottom edge and let the
			#screen clip the sprite instead of dissolving it in mid-air
			target = offscreen_target()
			if !params.has('fade_out'):
				p.fade_out = 1.0

	if !_pass_throttle(tex, p.key):
		return

	var count = p.count
	if !params.has('count') and p.amount > 1:
		count = count_for_amount(p.amount)
	count = int(clamp(count, 1, MAX_PER_CALL))
	count = int(min(count, MAX_ACTIVE - _active.size()))
	if count <= 0:
		return

	_group_counter += 1
	for i in range(count):
		var from = origin + Vector2(rand_range(-p.spread, p.spread), rand_range(-p.spread, p.spread))
		#the sprite settles back from the target before committing, so the launch reads as
		#a throw with weight behind it rather than a teleport
		var launch = from
		if p.anticipate > 0.0 and p.anticipate_dist > 0.0:
			var away = from - target
			if away.length() > 1.0:
				launch = from + away.normalized() * p.anticipate_dist
		var sprite = _take_sprite(tex, p.size)
		_active.append({
			node = sprite,
			t = 0.0,
			delay = p.delay + p.stagger * i,
			dur = max(0.05, p.time * rand_range(1.0 - p.time_rng, 1.0 + p.time_rng)),
			origin = from,
			anticipate = p.anticipate,
			p0 = launch,
			p1 = _control_point(launch, target, p, i),
			p2 = target,
			curve = p.curve,
			s0 = p.start_scale,
			s1 = p.peak_scale,
			s2 = p.end_scale,
			spin = rand_range(-p.spin, p.spin),
			size = p.size,
			fade_out = p.fade_out,
			group = _group_counter,
			sound = p.sound,
			pop = p.pop,
			target_node = target_node,
		})

	raise() #stay above whatever window was opened since the last flight
	set_process(true)


#gold reads best as a straight, evenly spaced row of coins rather than a scattered arc,
#and it heads for the counter in the clock bar instead of the inventory
func fly_gold(start, params = {}):
	var p = {
		count = 7,
		stagger = 0.055,
		time = 0.6,
		time_rng = 0.0, #even timing keeps the row evenly spaced
		arc = 0.0,
		arc_rng = 0.0,
		lift = 0.0,
		spread = 0.0, #single file
		curve = 1.0, #linear, so the spacing set by the stagger holds all the way
		spin = 0.0, #coins in a row read as one motion; tumbling breaks it up
		anticipate = 0.06, #a hint of backswing, small enough to keep the row tight
		anticipate_dist = 12.0,
		end_scale = 0.4,
		key = 'gold',
		sound = 'money_spend',
		target = get_gold_anchor(),
	}
	for k in params:
		p[k] = params[k]
	fly(gold_texture(), start, p)


func fly_material(material_code, start, params = {}):
	if !Items.materiallist.has(material_code):
		return
	var p = params.duplicate()
	if !p.has('key'):
		p.key = 'mat_' + material_code
	fly(Items.materiallist[material_code].icon, start, p)


#a stack of 30 arrows should read as "a few things arrived", not as 30 sprites
func count_for_amount(amount):
	if amount <= 1:
		return 1
	if amount <= 4:
		return 2
	if amount <= 15:
		return 3
	return 4


func gold_texture():
	if _gold_tex == null:
		_gold_tex = load(GOLD_ICON)
	return _gold_tex


func resolve_texture(icon):
	if icon == null:
		return null
	if typeof(icon) == TYPE_STRING:
		if Items.materiallist.has(icon):
			return Items.materiallist[icon].icon
		return input_handler.loadimage(icon)
	if typeof(icon) == TYPE_DICTIONARY:
		return resolve_texture(icon.get("icon")) #an itemlist/materiallist record
	if typeof(icon) != TYPE_OBJECT:
		return null
	if icon is Texture:
		return icon
	return resolve_texture(icon.get("icon")) #an Item, whose icon is a path


#null means "caller gave nothing usable", which the two call sites treat differently
func resolve_point(value):
	if value == null:
		return null
	if typeof(value) == TYPE_VECTOR2:
		return value
	if typeof(value) != TYPE_OBJECT or !is_instance_valid(value):
		return null
	if !(value is Control) or !value.is_visible_in_tree():
		return null
	var rect = value.get_global_rect()
	return rect.position + rect.size * 0.5


func default_target():
	var anchor = get_inventory_anchor()
	if anchor != null:
		return resolve_point(anchor)
	return offscreen_target()


func offscreen_target():
	var view = get_viewport_rect().size
	return Vector2(view.x * 0.5, view.y + OFFSCREEN_MARGIN)


func get_inventory_anchor():
	var mansion = gui_controller.mansion
	if mansion == null or !is_instance_valid(mansion):
		return null
	var button = mansion.get_node_or_null("MansionBottomLeftModule/VBoxContainer/InventoryButton")
	if button == null or !button.is_visible_in_tree():
		return null
	return button


func get_gold_anchor():
	var clock = gui_controller.clock
	if clock == null or !is_instance_valid(clock):
		return null
	var icon = clock.get_node_or_null("TimeNode/GoldIcon")
	if icon == null or !icon.is_visible_in_tree():
		return null
	return icon


func _control_point(from, target, p, index = 0):
	var side = p.arc_side
	if side == 0:
		#alternate rather than roll: a batch fans out instead of clumping by chance
		side = 1
		if index % 2 == 1:
			side = -1
	var arc = p.arc * side * rand_range(1.0 - p.arc_rng, 1.0 + p.arc_rng)
	var dir = target - from
	if dir.length() < 1.0:
		dir = Vector2(0, -1)
	var perpendicular = Vector2(-dir.y, dir.x).normalized()
	return from.linear_interpolate(target, 0.5) + perpendicular * arc + Vector2(0, -p.lift)


func _pass_throttle(tex, key):
	if key == null:
		key = tex.resource_path
		if key == "":
			key = str(tex.get_instance_id())
	var now = OS.get_ticks_msec()
	if _last_spawn.has(key) and now - _last_spawn[key] < REPEAT_WINDOW_MSEC:
		return false
	if _last_spawn.size() > 64:
		for old in _last_spawn.keys():
			if now - _last_spawn[old] > 5000:
				_last_spawn.erase(old)
	_last_spawn[key] = now
	return true


func _process(delta):
	for i in range(_active.size() - 1, -1, -1):
		var f = _active[i]
		var step = delta
		if f.delay > 0.0:
			f.delay -= delta
			if f.delay > 0.0:
				continue
			#the delay ran out part-way through this frame - spend the remainder on the
			#flight itself, otherwise start times snap to frame boundaries and a staggered
			#row of coins comes out unevenly spaced
			step = -f.delay
			f.delay = 0.0
		f.t += step / f.dur
		if f.t >= 1.0:
			_release_sprite(f.node)
			_announce_arrival(f)
			_active.remove(i)
			continue

		var t = f.t
		var position
		if f.anticipate > 0.0 and t < f.anticipate:
			position = f.origin.linear_interpolate(f.p0, ease(t / f.anticipate, 0.4))
		else:
			var travel = t
			if f.anticipate > 0.0:
				travel = (t - f.anticipate) / (1.0 - f.anticipate)
			position = _bezier(f.p0, f.p1, f.p2, ease(travel, f.curve))

		#pops to full size on the way out, holds it, then drops away close to the target
		var scale = f.s1
		if t < 0.25:
			scale = lerp(f.s0, f.s1, t / 0.25)
		else:
			var shrink = (t - 0.25) / 0.75
			scale = lerp(f.s1, f.s2, shrink * shrink)
		var alpha = 1.0
		if t < 0.12:
			alpha = t / 0.12
		elif t > f.fade_out:
			alpha = (1.0 - t) / (1.0 - f.fade_out)

		f.node.rect_position = position - f.size * 0.5
		f.node.rect_scale = Vector2(scale, scale)
		f.node.modulate = Color(1, 1, 1, alpha)
		if f.spin != 0.0:
			f.node.rect_rotation = f.spin * t
		f.node.visible = true

	if _active.empty():
		_cued_groups.clear()
		set_process(false)


#one cue per fly() call: a row of seven coins lands with a single chime, not seven.
#the pop is silent, so it gets its own gate rather than being suppressed with the sound.
func _announce_arrival(f):
	if _cued_groups.has(f.group):
		return
	_cued_groups[f.group] = true
	if f.pop:
		pop_node(f.target_node)
	if f.sound == null or f.sound == '':
		return
	var now = OS.get_ticks_msec()
	if _last_cue.has(f.sound) and now - _last_cue[f.sound] < ARRIVAL_CUE_COOLDOWN_MSEC:
		return
	_last_cue[f.sound] = now
	input_handler.PlaySound(f.sound)


func pop_node(node):
	if node == null or !is_instance_valid(node) or !(node is Control):
		return
	if !node.is_visible_in_tree():
		return
	#gated by its own duration so two arrivals never stack conflicting tweens on the node
	var node_key = node.get_instance_id()
	var now = OS.get_ticks_msec()
	if _last_pop.has(node_key) and now - _last_pop[node_key] < POP_COOLDOWN_MSEC:
		return
	_last_pop[node_key] = now
	node.rect_pivot_offset = node.rect_size * 0.5
	var tween = input_handler.GetTweenNode(node)
	tween.interpolate_property(node, 'rect_scale', Vector2(1, 1), Vector2(1.13, 1.13),
		0.07, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(node, 'rect_scale', Vector2(1.13, 1.13), Vector2(1, 1),
		0.15, Tween.TRANS_QUAD, Tween.EASE_IN, 0.07)
	tween.start()


func _bezier(p0, p1, p2, t):
	return p0.linear_interpolate(p1, t).linear_interpolate(p1.linear_interpolate(p2, t), t)


func _take_sprite(tex, size):
	var sprite
	if _pool.empty():
		sprite = TextureRect.new()
		sprite.expand = true
		sprite.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		sprite.mouse_filter = Control.MOUSE_FILTER_IGNORE
		add_child(sprite)
	else:
		sprite = _pool.pop_back()
	sprite.texture = tex
	sprite.rect_size = size
	sprite.rect_pivot_offset = size * 0.5
	sprite.rect_rotation = 0
	sprite.rect_scale = Vector2(1, 1)
	sprite.modulate = Color(1, 1, 1, 0)
	sprite.visible = false #stays hidden until its stagger delay is up
	return sprite


func _release_sprite(sprite):
	sprite.visible = false
	sprite.texture = null
	if _pool.size() < POOL_LIMIT:
		_pool.append(sprite)
	else:
		sprite.queue_free()
