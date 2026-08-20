extends Node2D
#A shot that actually crosses the battlefield: it starts at the caster's card, flies along a
#shallow arc and lands somewhere inside the target card rather than exactly on its centre.
#
#Two kinds so far. 'arrow' is the cheap, readable one - a shaft that keeps its nose on the
#path, a short speed streak, and a hit that sticks for a beat before fading. 'fireball' is
#the loud one - a pulsing additive core with an ember tail that bursts into a ring, a flash
#and radial sparks on contact.
#
#Everything is drawn from primitives, so there is no new art to import and every proportion
#is a number the combat lab can turn. Nodes are placed in the same absolute space
#LightningEffect uses: the effect sits at the origin and its children carry screen
#coordinates, which is what makes a caster card and a target card in different containers
#comparable at all.

const GLOW_TEX = preload("res://assets/sfx/line_glow.png")
const CORE_TEX = preload("res://assets/sfx/line_core.png")

const TRAIL_POINTS = 18

var kind = 'arrow'
var flight = 0.45
var launch_delay = 0.0
var arc = 90.0
var scatter = 28.0
var spin = 0.0
var boom_time = 0.42
var boom_size = 96.0
var effect_seed = 1

var start_point = Vector2()
var end_point = Vector2()
var control_point = Vector2()

var elapsed = 0.0
var finished = false
var body = null
var trail = null
var trail_points = []
var burst_nodes = []
var rng = RandomNumberGenerator.new()


#caster_node and target_node are the two cards. Settings come from the sfx entry and the
#tuning vars on CombatAnimations, so a skill can override any of them.
func setup(caster_node, target_node, new_kind, settings = {}):
	kind = new_kind
	for key in ['flight', 'launch_delay', 'arc', 'scatter', 'spin', 'boom_time', 'boom_size']:
		if settings.has(key): set(key, float(settings[key]))
	effect_seed = int(OS.get_ticks_msec()) ^ int(get_instance_id())
	rng.seed = effect_seed
	z_index = 90

	start_point = muzzle_point(caster_node, target_node)
	end_point = impact_point(target_node)
	#the arc bulges upward for a lob and stays shallow for a flat shot; the side it bulges
	#to follows the direction of travel so a volley does not look mirrored
	var mid = (start_point + end_point) * 0.5
	control_point = mid + Vector2(0, -arc)

	if kind == 'fireball': build_fireball()
	else: build_arrow()
	visible = false
	set_process(true)


func node_center(node):
	if node is Control:
		var rect = node.get_global_rect()
		return rect.position + rect.size * 0.5
	if node is Node2D:
		return node.global_position
	return Vector2()


#Leave from the edge of the caster's card facing the target, not from its middle: a shot
#that starts under the portrait reads as spawning out of the fighter's chest.
func muzzle_point(caster_node, target_node):
	var from = node_center(caster_node)
	var to = node_center(target_node)
	if caster_node is Control:
		var half = caster_node.get_global_rect().size * 0.5
		var direction = (to - from).normalized()
		from += Vector2(direction.x * half.x * 0.75, -half.y * 0.12)
	return from


#The scatter the request asks for: a point drawn uniformly from a disc around the centre of
#the target card, so repeated shots cluster on the portrait instead of stacking on one pixel.
func impact_point(target_node):
	var centre = node_center(target_node)
	var limit = scatter
	if target_node is Control:
		var half = target_node.get_global_rect().size * 0.5
		limit = min(scatter, min(half.x, half.y) * 0.6)
	var radius = limit * sqrt(rng.randf())
	var angle = rng.randf() * TAU
	return centre + Vector2(cos(angle), sin(angle)) * radius


func point_at(t):
	var inv = 1.0 - t
	return start_point * (inv * inv) + control_point * (2.0 * inv * t) + end_point * (t * t)


func additive():
	var material = CanvasItemMaterial.new()
	material.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	return material


func make_line(width, color, texture = null, add = false):
	var line = Line2D.new()
	line.width = width
	line.default_color = color
	line.antialiased = false
	line.joint_mode = Line2D.LINE_JOINT_ROUND
	line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	line.end_cap_mode = Line2D.LINE_CAP_ROUND
	if texture != null:
		line.texture = texture
		line.texture_mode = Line2D.LINE_TEXTURE_STRETCH
	if add: line.material = additive()
	add_child(line)
	return line


func make_disc(radius, color, add = true, points = 22):
	var poly = Polygon2D.new()
	var shape = PoolVector2Array()
	for i in range(points):
		var angle = TAU * float(i) / float(points)
		shape.append(Vector2(cos(angle), sin(angle)) * radius)
	poly.polygon = shape
	poly.color = color
	if add: poly.material = additive()
	return poly


#--- the two projectiles --------------------------------------------------------------

#Read at speed on a busy background: a dark shaft with a light rim above it, a steel head
#wide enough to survive the downscale, and the flights kept at the very tail so the whole
#thing reads as an arrow and not as a dash.
func build_arrow():
	trail = make_line(5.0, Color(1.0, 0.93, 0.78, 0.22), CORE_TEX, true)
	body = make_arrow_body()
	add_child(body)


#The same drawing is used twice: in the air, and stuck in the target afterwards. A bare
#dark shaft disappears against a dark portrait, so the light rim and the steel head are
#part of it rather than decoration.
func make_arrow_body():
	var body_node = Node2D.new()

	var shaft = Line2D.new()
	shaft.points = PoolVector2Array([Vector2(-34, 0), Vector2(17, 0)])
	shaft.width = 4.4
	shaft.default_color = Color(0.27, 0.18, 0.10, 1.0)
	shaft.antialiased = false
	body_node.add_child(shaft)

	var rim = Line2D.new()
	rim.points = PoolVector2Array([Vector2(-32, -1.4), Vector2(15, -1.4)])
	rim.width = 1.5
	rim.default_color = Color(0.78, 0.66, 0.46, 0.9)
	rim.antialiased = false
	body_node.add_child(rim)

	var head = Polygon2D.new()
	head.polygon = PoolVector2Array([Vector2(31, 0), Vector2(15, -5.6), Vector2(18, 0), Vector2(15, 5.6)])
	head.color = Color(0.90, 0.93, 0.98, 1.0)
	body_node.add_child(head)

	for side in [-1, 1]:
		var fletch = Polygon2D.new()
		fletch.polygon = PoolVector2Array([Vector2(-34, 0), Vector2(-21, 0), Vector2(-31, 6.4 * side)])
		fletch.color = Color(0.80, 0.26, 0.20, 0.95)
		body_node.add_child(fletch)
	return body_node


func build_fireball():
	trail = make_line(20.0, Color(1.0, 0.40, 0.07, 0.50), GLOW_TEX, true)
	body = Node2D.new()
	add_child(body)
	#three stacked discs: a wide soft halo, the orange body, and a small white-hot centre.
	#Additive blending saturates fast, so the halo carries the colour and the core stays
	#small - a big white middle just reads as a headlight.
	body.add_child(make_disc(30.0, Color(1.0, 0.26, 0.03, 0.34)))
	body.add_child(make_disc(17.0, Color(1.0, 0.54, 0.11, 0.62)))
	body.add_child(make_disc(7.5, Color(1.0, 0.91, 0.62, 0.90)))


#--- flight -----------------------------------------------------------------------------

func _process(delta):
	elapsed += delta
	if elapsed < launch_delay: return
	visible = true
	var t = clamp((elapsed - launch_delay) / max(0.01, flight), 0.0, 1.0)
	if !finished:
		advance(t)
		if t >= 1.0:
			finished = true
			impact()
	else:
		fade_burst(elapsed - launch_delay - flight)


func advance(t):
	var position_now = point_at(t)
	if body != null:
		body.position = position_now
		#nose on the path: sample slightly ahead so the angle is the tangent, not the chord
		var ahead = point_at(min(1.0, t + 0.02))
		var direction = ahead - position_now
		if direction.length() > 0.01:
			body.rotation = direction.angle()
		if spin != 0.0:
			body.rotation += spin * t * TAU
	trail_points.push_front(position_now)
	while trail_points.size() > TRAIL_POINTS:
		trail_points.pop_back()
	if trail != null:
		trail.points = PoolVector2Array(trail_points)
		#the streak thins out as it is left behind rather than ending in a hard stub
		trail.modulate.a = 1.0 - 0.35 * t


func impact():
	if body != null: body.visible = false
	if trail != null: trail.visible = false
	if kind == 'fireball': burst_fireball()
	else: burst_arrow()


#A hit, not an explosion: the shaft stays in the target for a beat, a little dust ring
#opens around it, and three chips fly off.
func burst_arrow():
	#the arrow itself stays in the target, buried up to the head, and only then fades
	var stuck = make_arrow_body()
	stuck.position = end_point
	stuck.rotation = (end_point - point_at(0.94)).angle()
	stuck.position -= Vector2(cos(stuck.rotation), sin(stuck.rotation)) * 14.0
	add_child(stuck)
	burst_nodes.append({node = stuck, life = boom_time * 1.8, kind = 'hold'})

	var flash = Node2D.new()
	flash.position = end_point
	add_child(flash)
	flash.add_child(make_disc(boom_size * 0.16, Color(1.0, 0.94, 0.78, 0.75)))
	burst_nodes.append({node = flash, life = boom_time * 0.35, kind = 'flash'})

	var ring = make_line(3.2, Color(1.0, 0.92, 0.80, 0.85), CORE_TEX, true)
	ring.position = end_point
	burst_nodes.append({node = ring, life = boom_time * 0.55, kind = 'ring', radius = boom_size * 0.40})

	for i in range(4):
		var angle = rng.randf() * TAU
		var reach = boom_size * (0.24 + rng.randf() * 0.22)
		var chip = make_spark(end_point, angle, reach, 2.6, Color(1.0, 0.90, 0.74, 0.9))
		burst_nodes.append({node = chip, life = boom_time * (0.35 + rng.randf() * 0.25), kind = 'fade'})


#The loud one: a flash that snaps open, a ring that keeps expanding as it thins, and eight
#sparks thrown outward at uneven lengths.
func burst_fireball():
	var flash = Node2D.new()
	flash.position = end_point
	add_child(flash)
	flash.add_child(make_disc(boom_size * 0.44, Color(1.0, 0.34, 0.05, 0.75)))
	flash.add_child(make_disc(boom_size * 0.26, Color(1.0, 0.62, 0.16, 0.80)))
	flash.add_child(make_disc(boom_size * 0.12, Color(1.0, 0.93, 0.70, 0.90)))
	burst_nodes.append({node = flash, life = boom_time * 0.55, kind = 'flash'})

	#two rings: a heavy slow one that carries the fire colour, and a thin fast one that
	#gives the burst its edge
	var ring = make_line(11.0, Color(1.0, 0.34, 0.06, 0.95), GLOW_TEX, true)
	ring.position = end_point
	burst_nodes.append({node = ring, life = boom_time, kind = 'ring', radius = boom_size})

	var edge = make_line(3.0, Color(1.0, 0.80, 0.45, 0.9), CORE_TEX, true)
	edge.position = end_point
	burst_nodes.append({node = edge, life = boom_time * 0.55, kind = 'ring', radius = boom_size * 0.8})

	var smoke = Node2D.new()
	smoke.position = end_point
	add_child(smoke)
	smoke.add_child(make_disc(boom_size * 0.30, Color(0.35, 0.20, 0.16, 0.45), false))
	burst_nodes.append({node = smoke, life = boom_time * 1.3, kind = 'smoke'})

	for i in range(7):
		var angle = TAU * float(i) / 7.0 + rng.randf() * 0.5
		var reach = boom_size * (0.40 + rng.randf() * 0.50)
		var spark = make_spark(end_point, angle, reach, 4.0 + rng.randf() * 2.0,
			Color(1.0, 0.68, 0.22, 0.95))
		burst_nodes.append({node = spark, life = boom_time * (0.5 + rng.randf() * 0.45), kind = 'fade'})


#Tapered, not a ruled line: sparks that keep the same width along their length read as a
#drawn starburst. Each one starts a little off the centre and ends in a point.
func make_spark(origin, angle, reach, thickness, color):
	var direction = Vector2(cos(angle), sin(angle))
	var normal = Vector2(-direction.y, direction.x)
	var base = direction * reach * 0.12
	var spark = Polygon2D.new()
	spark.polygon = PoolVector2Array([
		base + normal * thickness * 0.5,
		base - normal * thickness * 0.5,
		direction * reach,
	])
	spark.color = color
	spark.material = additive()
	spark.position = origin
	add_child(spark)
	return spark


func ring_points(radius):
	var points = PoolVector2Array()
	for i in range(25):
		var angle = TAU * float(i) / 24.0
		points.append(Vector2(cos(angle), sin(angle)) * radius)
	return points


func fade_burst(age):
	var alive = false
	for entry in burst_nodes:
		var node = entry.node
		if node == null or !is_instance_valid(node): continue
		var t = clamp(age / max(0.01, entry.life), 0.0, 1.0)
		if t < 1.0: alive = true
		match entry.kind:
			'ring':
				node.points = ring_points(entry.radius * (0.15 + 0.85 * t))
				node.modulate.a = 1.0 - t
				node.width = max(0.6, node.width * (1.0 - 0.06 * t))
			'flash':
				node.scale = Vector2(1, 1) * (0.4 + 1.5 * t)
				node.modulate.a = 1.0 - t
			'smoke':
				node.scale = Vector2(1, 1) * (0.6 + 1.1 * t)
				node.modulate.a = (1.0 - t) * 0.7
			'hold':
				#the arrow stays solid, then goes all at once at the end of its life
				node.modulate.a = 1.0 if t < 0.6 else (1.0 - t) / 0.4
			_:
				node.modulate.a = 1.0 - t
	if !alive:
		queue_free()
