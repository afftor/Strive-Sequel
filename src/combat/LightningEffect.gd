extends Node2D

const REVEAL_TIME = 0.055
const FADE_TIME = 0.16
const TARGET_RANDOM_X = 22.0
const TARGET_RANDOM_Y = 16.0
const PRIMARY_SOURCE_INSET = 44.0
const SEGMENT_LENGTH = 42.0

var caster_node = null
var target_nodes = []
var rays = []
var elapsed = 0.0
var windup = 0.58
var duration = 0.76
var jitter = 25.0
var branch_stagger = 0.10
var effect_seed = 1
var max_branch_delay = 0.0
var charge_lines = []


func setup(new_caster, new_targets, settings = {}):
	caster_node = new_caster
	target_nodes = new_targets.duplicate()
	if settings.has('windup'): windup = float(settings.windup)
	if settings.has('duration'): duration = float(settings.duration)
	if settings.has('jitter'): jitter = float(settings.jitter)
	if settings.has('branch_stagger'): branch_stagger = float(settings.branch_stagger)
	effect_seed = int(OS.get_ticks_msec()) ^ int(get_instance_id())
	z_index = 80
	_make_charge()
	_make_rays()
	set_process(true)


func _make_line(line_width, color):
	var line = Line2D.new()
	line.width = line_width
	line.default_color = color
	line.antialiased = true
	var additive = CanvasItemMaterial.new()
	additive.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	line.material = additive
	add_child(line)
	return line


func _make_charge():
	charge_lines = [
		_make_line(12.0, Color(0.24, 0.68, 1.0, 0.40)),
		_make_line(4.0, Color(0.55, 0.90, 1.0, 0.92)),
		_make_line(3.0, Color(0.88, 0.98, 1.0, 0.95))
	]


func _make_rays():
	if target_nodes.empty(): return
	var primary_offset = _random_offset(effect_seed + 307)
	for index in range(target_nodes.size()):
		var target = target_nodes[index]
		if target == null or !is_instance_valid(target): continue
		var branch_delay = 0.0 if index == 0 else 0.10 + float(index - 1) * branch_stagger
		max_branch_delay = max(max_branch_delay, branch_delay)
		var glow = _make_line(24.0 if index == 0 else 19.0,
			Color(0.20, 0.58, 1.0, 0.46 if index == 0 else 0.38))
		var core = _make_line(9.0 if index == 0 else 7.0,
			Color(0.30, 0.78, 1.0, 0.95))
		var hot = _make_line(3.2 if index == 0 else 2.6,
			Color(0.94, 0.99, 1.0, 1.0))
		var fork_a = _make_line(3.0, Color(0.68, 0.93, 1.0, 0.88))
		var fork_b = _make_line(3.0, Color(0.68, 0.93, 1.0, 0.88))
		var impact = _make_line(4.0, Color(0.76, 0.95, 1.0, 0.95))
		for line in [glow, core, hot, fork_a, fork_b, impact]: line.visible = false
		rays.append({
			branch = index > 0,
			delay = branch_delay,
			noise_seed = effect_seed + index * 977,
			source = caster_node if index == 0 else target_nodes[0],
			target = target,
			source_offset = Vector2() if index == 0 else primary_offset,
			target_offset = primary_offset if index == 0 else _random_offset(effect_seed + index * 433),
			lines = [glow, core, hot],
			forks = [fork_a, fork_b],
			impact = impact,
		})


func _process(delta):
	elapsed += delta
	_update_charge()
	for ray in rays:
		_update_ray(ray)
	if elapsed >= windup + max_branch_delay + duration:
		queue_free()


func _update_charge():
	var visible = elapsed < windup and caster_node != null and is_instance_valid(caster_node)
	for line in charge_lines: line.visible = visible
	if !visible: return
	var progress = clamp(elapsed / max(windup, 0.01), 0.0, 1.0)
	var eased = progress * progress
	var fade = min(1.0, progress / 0.10) * (1.0 - clamp((elapsed - windup + 0.08) / 0.08, 0.0, 1.0))
	var center = _node_center(caster_node)
	var tick = int(floor(elapsed * 30.0))
	_set_ring(charge_lines[0], center, 27.0 + 43.0 * eased, elapsed * 3.8, tick, effect_seed + 11, fade)
	_set_ring(charge_lines[1], center, 17.0 + 31.0 * eased, -elapsed * 5.2, tick, effect_seed + 29, fade)
	_set_ring(charge_lines[2], center, 8.0 + 8.0 * sin(progress * PI), elapsed * 7.0, tick, effect_seed + 47, fade)


func _set_ring(line, center, radius, phase, tick, noise_seed, alpha):
	var points = PoolVector2Array()
	var count = 28
	for index in range(count + 1):
		var angle = phase + TAU * float(index) / float(count)
		var rough = _noise(noise_seed, index, tick) * jitter * 0.16
		points.append(center + Vector2(cos(angle), sin(angle)) * (radius + rough))
	line.points = points
	line.modulate.a = alpha


func _update_ray(ray):
	var age = elapsed - windup - ray.delay
	var all_lines = ray.lines + ray.forks + [ray.impact]
	var visible = age >= 0.0 and age <= duration and _valid_ray_nodes(ray)
	for line in all_lines: line.visible = visible
	if !visible: return
	var reveal = clamp(age / REVEAL_TIME, 0.0, 1.0)
	var fade = 1.0 - clamp((age - duration + FADE_TIME) / FADE_TIME, 0.0, 1.0)
	var tick = int(floor(age * 30.0))
	var start = _node_center(ray.source) + ray.source_offset
	var target = _node_center(ray.target) + ray.target_offset
	if !ray.branch:
		var direction = (target - start).normalized()
		start += direction * PRIMARY_SOURCE_INSET
	var points = _lightning_points(start, target, ray.noise_seed, tick, reveal, ray.branch)
	for line in ray.lines:
		line.points = points
		line.modulate.a = fade
	_update_forks(ray, points, tick, fade)
	_update_impact(ray.impact, target, age, fade)


func _lightning_points(start, target, noise_seed, tick, reveal, branch):
	var delta = target - start
	var distance = max(delta.length(), 1.0)
	var normal = Vector2(-delta.y, delta.x) / distance
	var direction = delta / distance
	var segments = int(clamp(round(distance / SEGMENT_LENGTH), 8, 28))
	var visible_segments = max(1, int(ceil(float(segments) * reveal)))
	var points = PoolVector2Array()
	for index in range(visible_segments + 1):
		var amount = min(1.0, float(index) / float(segments))
		var envelope = sin(amount * PI)
		var strength = jitter * envelope * (0.82 if branch else 1.0)
		var perpendicular = _noise(noise_seed, index, tick) * strength
		var along = _noise(noise_seed + 71, index, tick) * strength * 0.20
		points.append(start + delta * amount + normal * perpendicular + direction * along)
	if reveal >= 1.0 and points.size() > 0:
		points[points.size() - 1] = target
	return points


func _update_forks(ray, points, tick, alpha):
	for index in range(ray.forks.size()):
		var fork = ray.forks[index]
		if points.size() < 4:
			fork.visible = false
			continue
		var point_index = int(clamp(round((0.38 + index * 0.27) * (points.size() - 1)), 1, points.size() - 2))
		var before = points[point_index - 1]
		var after = points[point_index + 1]
		var direction = (after - before).normalized()
		var normal = Vector2(-direction.y, direction.x)
		var side = -1.0 if _noise(ray.noise_seed + 333, index, tick) < 0.0 else 1.0
		var reach = 14.0 + abs(_noise(ray.noise_seed + 900, index, tick)) * 24.0
		if ray.branch: reach *= 0.72
		fork.points = PoolVector2Array([points[point_index], points[point_index] + normal * reach * side + direction * reach * 0.44])
		fork.modulate.a = alpha


func _update_impact(line, center, age, alpha):
	var points = PoolVector2Array()
	var radius = 8.0 + 10.0 * sin(clamp(age / 0.09, 0.0, 1.0) * PI)
	var count = 16
	for index in range(count + 1):
		var angle = TAU * float(index) / float(count)
		points.append(center + Vector2(cos(angle), sin(angle)) * radius)
	line.points = points
	line.modulate.a = alpha


func _node_center(node):
	if node is Control:
		var rect = node.get_global_rect()
		return rect.position + rect.size * 0.5
	if node is Node2D:
		return node.global_position
	return Vector2()


func _valid_ray_nodes(ray):
	return ray.source != null and is_instance_valid(ray.source) and ray.target != null and is_instance_valid(ray.target)


func _random_offset(noise_seed):
	return Vector2(_noise(noise_seed, 0, 0) * TARGET_RANDOM_X, _noise(noise_seed + 181, 0, 0) * TARGET_RANDOM_Y)


func _noise(noise_seed, index, tick):
	var value = sin(float(noise_seed) * 0.0137 + float(index) * 17.171 + float(tick) * 7.913) * 43758.5453
	return (value - floor(value)) * 2.0 - 1.0
