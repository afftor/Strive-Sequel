extends Node2D
#Particles thrown off a fighter card at the moment it recoils from a hit. A skill opts in
#with a `hitfx` field right under its sounddata:
#
#   hitfx = {type = 'sparks', color = 'ffd27a', amount = 1.0, size = 1.0, speed = 1.0, offset = 0.0},
#
#or with an array of such layers. CombatAnimations spawns one of these per layer from the
#recoil primitives (target_push / target_squash / target_tilt), so the burst starts on the
#frame the card starts to move and sprays along the push, away from the attacker. Drawn
#from primitives like ProjectileEffect: nothing to import, every proportion a number.
#
#   type    one of ORDER
#   color   hex RGB; the preset's own colour when absent
#   amount  particle count multiplier
#   size    size multiplier
#   speed   velocity multiplier - lifetimes shrink by the same factor, so the burst covers
#           the same ground, only faster
#   offset  seconds added to the recoil moment; negative fires early

const ORDER = ['sparks', 'embers', 'shards', 'blood', 'dust', 'ring', 'stars', 'slash']

#what a layer falls back to, per type: its colour and its base particle count
const PRESETS = {
	sparks = {color = 'ffd27a', count = 14},
	embers = {color = 'ff7a1f', count = 16},
	shards = {color = 'bfe8ff', count = 9},
	blood = {color = '9e0b0b', count = 12},
	dust = {color = 'c9b79c', count = 7},
	ring = {color = '8fd3ff', count = 2},
	stars = {color = 'fff3a0', count = 5},
	slash = {color = 'ffffff', count = 1},
}

const MAX_PARTICLES = 80
#a burst that somehow never finishes still goes away
const HARD_LIFETIME = 3.0

var kind = 'sparks'
var fx_color = Color(1, 1, 1)
var fx_amount = 1.0
var fx_size = 1.0
var fx_speed = 1.0
var start_delay = 0.0
#combat fast-forward: CombatAnimations sets it the way it sets ProjectileEffect.time_rate
var time_rate = 1.0

var origin = Vector2()
var direction = Vector2(1, 0)
var elapsed = 0.0
var spawned = false
var particles = []
var rng = RandomNumberGenerator.new()


static func preset_color(preset):
	return Color(PRESETS[preset].color) if PRESETS.has(preset) else Color(1, 1, 1)


#node is the card that recoils; delay is when its recoil starts, counted from now
func setup(node, settings, delay = 0.0):
	kind = str(settings.get('type', 'sparks'))
	if !PRESETS.has(kind): kind = 'sparks'
	var hex = str(settings.get('color', PRESETS[kind].color))
	fx_color = Color(hex) if hex.is_valid_html_color() else preset_color(kind)
	fx_amount = max(0.05, float(settings.get('amount', 1.0)))
	fx_size = max(0.05, float(settings.get('size', 1.0)))
	fx_speed = max(0.05, float(settings.get('speed', 1.0)))
	start_delay = max(0.0, delay + float(settings.get('offset', 0.0)))
	rng.seed = int(OS.get_ticks_msec()) ^ int(get_instance_id())
	#one above the projectile effects (90): a fireball's burst lands on the same frame and
	#must not cover the sparks thrown with it
	z_index = 91
	global_position = Vector2()
	#aim and place now, while the card is still at rest - once the recoil starts it moves
	var rect = node.get_global_rect() if node is Control else Rect2(node.global_position, Vector2())
	var half = rect.size * 0.5
	if node.has_method('get_attack_vector'):
		#the push goes against the target's own attack vector; the burst follows the push
		direction = -node.get_attack_vector().normalized()
	#the blow lands on the side facing the attacker, a little off dead centre
	var jitter = min(half.x, half.y) * 0.18
	origin = (rect.position + half - direction * half.x * 0.18
		+ Vector2(rng.randf_range(-jitter, jitter), rng.randf_range(-jitter, jitter)))
	set_process(true)


func _process(delta):
	var step = delta * time_rate
	elapsed += step
	if elapsed > start_delay + HARD_LIFETIME:
		queue_free()
		return
	if !spawned:
		if elapsed < start_delay: return
		spawned = true
		spawn()
		return
	var alive = false
	for p in particles:
		if !is_instance_valid(p.node): continue
		p.age += step
		if p.age < 0.0:
			alive = true
			continue
		var t = p.age / p.life
		if t >= 1.0:
			p.node.visible = false
			continue
		alive = true
		p.node.visible = true
		p.velocity += Vector2(0, p.gravity) * step
		p.velocity *= max(0.0, 1.0 - p.drag * step)
		p.node.position += p.velocity * step
		var grow = lerp(p.grow_from, p.grow_to, t)
		if p.stretch:
			#streaks and drops point along their path and lengthen with their speed
			p.node.rotation = p.velocity.angle()
			p.node.scale = Vector2(clamp(p.velocity.length() / 520.0, 0.35, 1.7), 1.0) * grow
		else:
			p.node.rotation += p.spin * step
			p.node.scale = Vector2(grow, grow)
		if p.has('ring'):
			p.node.points = ring_points(lerp(p.ring[0], p.ring[1], 1.0 - (1.0 - t) * (1.0 - t)))
			p.node.width = max(0.5, p.ring[2] * (1.0 - t))
		match p.fade:
			'flicker':
				p.node.modulate.a = (1.0 - t) * (0.6 + 0.4 * sin(p.age * 38.0 + p.phase))
			'late':
				p.node.modulate.a = 1.0 if t < 0.55 else (1.0 - t) / 0.45
			'pop':
				p.node.modulate.a = min(1.0, t * 6.0) * (1.0 - t)
			_:
				p.node.modulate.a = 1.0 - t
	if !alive:
		queue_free()


func spawn():
	var base = direction.angle()
	var n = int(clamp(round(PRESETS[kind].count * fx_amount), 1, MAX_PARTICLES))
	match kind:
		'sparks': spawn_sparks(base, n)
		'embers': spawn_embers(base, n)
		'shards': spawn_shards(base, n)
		'blood': spawn_blood(base, n)
		'dust': spawn_dust(base, n)
		'ring': spawn_ring(n)
		'stars': spawn_stars(base, n)
		'slash': spawn_slash(base, n)


#--- the presets -----------------------------------------------------------------------

#hot metal: thin streaks that stretch with their speed, most thrown along the blow and a
#few kicked back, over a flash that is gone in a few frames
func spawn_sparks(base, n):
	add_particle(disc(15.0 * fx_size, fx_color.lightened(0.55), true), Vector2(), 0.09,
		{grow_from = 0.5, grow_to = 1.6})
	for i in range(n):
		var angle = base + rng.randf_range(-0.65, 0.65)
		if rng.randf() < 0.2: angle += PI + rng.randf_range(-0.5, 0.5)
		var length = rng.randf_range(12.0, 20.0) * fx_size
		var width = rng.randf_range(1.2, 2.0) * fx_size
		var streak = polygon([Vector2(-length * 0.5, 0), Vector2(0, -width), Vector2(length * 0.5, 0), Vector2(0, width)],
			fx_color.lightened(rng.randf_range(0.0, 0.4)), true)
		add_particle(streak, launch(angle, 420.0, 900.0), rng.randf_range(0.14, 0.30),
			{gravity = 380.0, drag = 3.0, stretch = true})


#glowing crumbs that drift up and flicker out - a burn rather than a blow
func spawn_embers(base, n):
	for i in range(n):
		var radius = rng.randf_range(2.2, 3.8) * fx_size
		var ember = disc(radius, tinted(0.95), true, 10)
		ember.add_child(disc(radius * 2.4, tinted(0.30), true, 12))
		var velocity = launch(base + rng.randf_range(-0.9, 0.9), 140.0, 380.0) + Vector2(0, -120.0 * fx_speed)
		add_particle(ember, velocity, rng.randf_range(0.5, 0.9),
			{gravity = -160.0, drag = 2.2, fade = 'flicker', grow_from = 1.0, grow_to = 0.4})


#brittle pieces - ice, crystal, stone: flat angular chips that spin and drop
func spawn_shards(base, n):
	for i in range(n):
		var radius = rng.randf_range(5.0, 10.0) * fx_size
		var points = []
		var corners = 3 + rng.randi() % 2
		for c in range(corners):
			var a = TAU * float(c) / float(corners) + rng.randf_range(-0.35, 0.35)
			points.append(Vector2(cos(a), sin(a)) * radius * rng.randf_range(0.55, 1.0))
		var shard = polygon(points, fx_color.lightened(rng.randf_range(0.0, 0.25)), false)
		var velocity = launch(base + rng.randf_range(-0.75, 0.75), 260.0, 560.0) + Vector2(0, -140.0 * fx_speed)
		add_particle(shard, velocity, rng.randf_range(0.45, 0.7),
			{gravity = 1100.0, drag = 0.8, spin = rng.randf_range(-14.0, 14.0), fade = 'late'})


#drops thrown along the blow that fall fast, stretched along their path, over a small
#dark burst where the blow landed
func spawn_blood(base, n):
	add_particle(disc(12.0 * fx_size, tinted(0.55), false), Vector2(), 0.12, {grow_from = 0.5, grow_to = 1.3})
	for i in range(n):
		var r = rng.randf_range(2.5, 4.5) * fx_size
		var drop = polygon([Vector2(-r * 1.6, 0), Vector2(0, -r), Vector2(r, 0), Vector2(0, r)],
			fx_color.darkened(rng.randf_range(0.0, 0.3)), false)
		var velocity = launch(base + rng.randf_range(-0.55, 0.55), 180.0, 460.0) + Vector2(0, -180.0 * fx_speed)
		add_particle(drop, velocity, rng.randf_range(0.4, 0.65),
			{gravity = 1300.0, drag = 0.6, stretch = true, fade = 'late'})


#a blunt blow: soft puffs that swell and drift off along the push
func spawn_dust(base, n):
	for i in range(n):
		var puff = disc(rng.randf_range(10.0, 18.0) * fx_size, tinted(0.42), false, 16)
		add_particle(puff, launch(base + rng.randf_range(-1.1, 1.1), 60.0, 170.0), rng.randf_range(0.55, 0.9),
			{gravity = -30.0, drag = 2.5, grow_from = 0.6, grow_to = 2.0,
			at = Vector2(rng.randf_range(-8.0, 8.0), rng.randf_range(-8.0, 8.0)) * fx_size})


#magic: a flash, then rings that snap outward one after another and thin away
func spawn_ring(n):
	add_particle(disc(18.0 * fx_size, fx_color.lightened(0.5), true), Vector2(), 0.1,
		{grow_from = 0.4, grow_to = 1.5})
	for i in range(n):
		var line = Line2D.new()
		line.width = 5.0 * fx_size
		line.default_color = tinted(0.9)
		line.material = additive()
		line.points = ring_points(4.0)
		add_particle(line, Vector2(), 0.32,
			{wait = 0.07 * i, ring = [8.0 * fx_size, (62.0 + 16.0 * i) * fx_size, 5.0 * fx_size]})


#a cartoon knock: four-point stars that pop out, spin and fall
func spawn_stars(base, n):
	for i in range(n):
		var outer = rng.randf_range(9.0, 14.0) * fx_size
		var points = []
		for c in range(8):
			var a = TAU * float(c) / 8.0
			points.append(Vector2(cos(a), sin(a)) * (outer if c % 2 == 0 else outer * 0.38))
		var star = polygon(points, fx_color.lightened(rng.randf_range(0.0, 0.3)), true)
		var velocity = launch(base + rng.randf_range(-1.2, 1.2), 120.0, 300.0) + Vector2(0, -160.0 * fx_speed)
		add_particle(star, velocity, rng.randf_range(0.45, 0.7),
			{gravity = 420.0, drag = 1.8, spin = rng.randf_range(6.0, 10.0),
			grow_from = 0.4, grow_to = 1.15, fade = 'late'})


#a blade trace: bright thin cuts across the card, drawn in and gone
func spawn_slash(base, n):
	for i in range(n):
		var length = rng.randf_range(80.0, 110.0) * fx_size
		var width = rng.randf_range(4.0, 6.0) * fx_size
		var cut = polygon([Vector2(-length * 0.5, 0), Vector2(-length * 0.1, -width),
			Vector2(length * 0.5, 0), Vector2(-length * 0.1, width * 0.4)], tinted(0.95), true)
		cut.rotation = base + PI * 0.5 + rng.randf_range(-0.6, 0.6)
		add_particle(cut, Vector2(), 0.22, {wait = 0.05 * i, grow_from = 0.25, grow_to = 1.2, fade = 'pop',
			at = Vector2(rng.randf_range(-14.0, 14.0), rng.randf_range(-14.0, 14.0)) * fx_size})


#--- plumbing ----------------------------------------------------------------------------

#velocity at a random speed in the range, scaled by the layer's speed
func launch(angle, v_min, v_max):
	return Vector2(cos(angle), sin(angle)) * rng.randf_range(v_min, v_max) * fx_speed


#Gravity, drag and spin scale with the layer speed along with the lifetime, so a faster
#burst keeps the shape of its arcs instead of flattening them.
func add_particle(node, velocity, life, settings = {}):
	if particles.size() >= MAX_PARTICLES:
		node.free()
		return
	node.position = origin + settings.get('at', Vector2())
	node.visible = false
	add_child(node)
	var p = {
		node = node,
		velocity = velocity,
		age = -float(settings.get('wait', 0.0)) / fx_speed,
		life = max(0.02, life / fx_speed),
		gravity = float(settings.get('gravity', 0.0)) * fx_speed * fx_speed,
		drag = float(settings.get('drag', 0.0)) * fx_speed,
		spin = float(settings.get('spin', 0.0)) * fx_speed,
		stretch = settings.get('stretch', false),
		grow_from = float(settings.get('grow_from', 1.0)),
		grow_to = float(settings.get('grow_to', 1.0)),
		fade = str(settings.get('fade', 'linear')),
		phase = rng.randf() * TAU,
	}
	if settings.has('ring'): p.ring = settings.ring
	particles.push_back(p)


func tinted(alpha):
	return Color(fx_color.r, fx_color.g, fx_color.b, alpha)


func additive():
	var material = CanvasItemMaterial.new()
	material.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	return material


func polygon(points, tint, add):
	var poly = Polygon2D.new()
	poly.polygon = PoolVector2Array(points)
	poly.color = tint
	if add: poly.material = additive()
	return poly


func disc(radius, tint, add, points = 14):
	var shape = []
	for i in range(points):
		var a = TAU * float(i) / float(points)
		shape.append(Vector2(cos(a), sin(a)) * radius)
	return polygon(shape, tint, add)


func ring_points(radius):
	var points = PoolVector2Array()
	for i in range(33):
		var a = TAU * float(i) / 32.0
		points.append(Vector2(cos(a), sin(a)) * radius)
	return points
