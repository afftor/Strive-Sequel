extends "res://src/combat/FxNode.gd"
#«Чёрные щупальца» as the «Из глубины» take of the «Тьма» mockup: the floor under the targets turns to a skin that
#ripples, it swells under each target and bursts, and tentacles come up out of a pit and wrap the card. They squeeze -
#that is the damage - hold it for its Ensnared turn and sink back. Space bends through SpaceBend; the knobs are the
#TENDRILS_* vars in CombatAnimations.gd.

const SpaceBend = preload("res://src/combat/SpaceBend.gd")
const NightSky = preload("res://src/combat/NightSky.gd")
const DamageCounter = preload("res://src/combat/DamageCounter.gd")
const VOID_INK = Color(0.024, 0.008, 0.047)
#a target's three tentacles in fractions of its card: up out of the pit, round a side, across the face and over the far
#edge; the third only wraps the bottom
const PATHS = [
	[Vector2(0.4, 1.02), Vector2(0.16, 0.86), Vector2(-0.03, 0.62), Vector2(0.5, 0.47), Vector2(0.99, 0.34), Vector2(1.09, 0.2)],
	[Vector2(0.6, 1.02), Vector2(0.86, 0.88), Vector2(1.03, 0.68), Vector2(0.5, 0.56), Vector2(0.0, 0.44), Vector2(-0.1, 0.3)],
	[Vector2(0.5, 1.03), Vector2(0.5, 0.88), Vector2(0.3, 0.76), Vector2(0.02, 0.8), Vector2(-0.08, 0.92)]]
const WIDTHS = [15.0, 14.0, 10.0]
const LAGS = [0.0, 0.04, 0.07]

var anim = null
var caster = null
var root = null
var root_home = Vector2()
var shaking = false
var centre = Vector2()
#target card -> {rect, b, sq, hold1, back1, bulge, pit, paths, missed, posed, icon, icon_home, seed}
var targets = {}
var bursts = []
var kicks = []
var stops = []
var counter = DamageCounter.new()
var rng = RandomNumberGenerator.new()
var bend = null
var night = null
var ground = null
var layers = {}
var real = 0.0
var release = 0.5
var first_sq = 0.0
var calm = 0.0
var last_back = 0.0
var end_t = 0.0
var shake_px = 14.0
var hold = 0.15
var event_key = 0


static func equip(kit):
	if kit.has('dark_font'): return
	var fonts = DamageCounter.make_fonts()
	kit.dark_font = fonts.font
	kit.dark_shadow = fonts.shadow


#opts: `release` when the cast lets go, `stop` the hit-stop at the first squeeze, `shake` the most the screen shakes,
#`hold` how long the queue waits after a number, `root` the node shaken, `seed`, `world` the battlefield's last node (the
#night and the bend go right after it, under the interface). `slot_nodes` are the six places of the targets' side,
#whether or not anyone stands there.
func grip(new_anim, caster_node, hit_nodes, slot_nodes, kit, opts = {}):
	anim = new_anim
	caster = caster_node
	equip(kit)
	use_kit(kit)
	counter.font = shared.dark_font
	counter.shadow_font = shared.dark_shadow
	counter.hold = 0.45
	counter.fade_time = 0.5
	counter.pop = 0.08
	counter.slam = 0.3
	counter.slam_time = 0.3
	counter.ring = false
	counter.tremble = 0.0
	root = opts.get('root')
	if root is Control: root_home = root.rect_position
	release = float(opts.get('release', 0.5))
	shake_px = float(opts.get('shake', 14.0))
	hold = float(opts.get('hold', 0.15))
	rng.seed = int(opts.get('seed', 6100))
	var field = Rect2()
	var first = true
	for node in slot_nodes:
		if node == null or !is_instance_valid(node): continue
		var r = local_rect(node)
		field = r if first else field.merge(r)
		first = false
	centre = field.position + field.size / 2.0
	for card in hit_nodes:
		if card == null or !card_ok(card): continue
		var icon = card.get_node_or_null('Icon')
		targets[card] = {rect = local_rect(card), missed = false, posed = false, icon = icon,
			icon_home = icon.rect_position if icon != null else Vector2(), seed = targets.size() * 7 + 2}
	if targets.empty():
		queue_free()
		return
	plan(float(opts.get('stop', 0.12)))
	build(kit, opts.get('world'))
	set_process(true)


func target_cards():
	return targets.keys()


#the queue lets go a little before the first squeeze: the strike's sound takes a slot of its own first
func lock_time():
	return max(0.05, stop_to_real(stops, first_sq) - 0.1)


#--- the plan --------------------------------------------------------------------------------------------------------

func plan(stop_d):
	var near = INF
	var dist = {}
	for card in targets:
		var r = targets[card].rect
		dist[card] = (r.position + r.size / 2.0).distance_to(centre)
		near = min(near, dist[card])
	first_sq = INF
	var first_b = INF
	for card in targets:
		var tg = targets[card]
		var r = tg.rect
		#the nearest to the middle of the side bursts first
		tg.b = release + 0.42 + (dist[card] - near) / 3000.0 + 0.03 * rng.randf()
		tg.sq = tg.b + 0.27
		tg.hold1 = tg.sq + 0.38
		tg.back1 = tg.hold1 + 0.26
		tg.bulge = r.position + Vector2(r.size.x / 2.0, r.size.y * 0.74)
		tg.pit = r.position + Vector2(r.size.x / 2.0, r.size.y + 4.0)
		#drawn in the card's own space, so they squeeze and shake with it
		tg.paths = []
		for list in PATHS:
			var wp = []
			for q in list:
				wp.append(q * card.rect_size)
			tg.paths.append(spline_path(wp, 6))
		bursts.append({at = tg.b, pos = tg.pit, n = 14, ang = -PI / 2.0, spread = 1.6, power = 0.9, pal = ABYSS, key = next_key()})
		first_sq = min(first_sq, tg.sq)
		first_b = min(first_b, tg.b)
		calm = max(calm, tg.hold1)
		last_back = max(last_back, tg.back1)
	kicks.append({at = first_b, mag = 0.8, dur = 0.35, dir = Vector2(0, 1)})
	stops.append({at = first_sq + 0.02, d = 0.5 * stop_d})
	end_t = max(last_back + 0.6, calm + 1.0)


func next_key():
	event_key += 1
	return event_key


#--- the damage --------------------------------------------------------------------------------------------------

#how long from now until a target is squeezed: its ice bursts then
func hit_delay(node):
	var tg = targets.get(node)
	if tg == null: return 0.0
	return max(0.0, stop_to_real(stops, tg.sq) - real)


#The target's hp_update, handed over: its number shows when the tentacles squeeze. Returns how long the queue waits.
func take_hit(node, args, crit):
	var tg = targets.get(node)
	if tg == null or tg.missed: return 0.2
	var c = counter.start(node, args, crit, [tg.sq], [], t)
	if anim != null and is_instance_valid(anim): anim.damage_flash(node, hit_delay(node))
	return max(0.1, stop_to_real(stops, c.done) - real) + hold


#how much longer a card's number runs, in real time; its death waits for it
func counter_left(node):
	var c = counter.counters.get(node)
	if c == null or c.finished: return 0.0
	return max(0.0, stop_to_real(stops, c.done) - real)


#the target got away: its tentacles close on nothing and sink back at once
func missed(node):
	var tg = targets.get(node)
	if tg == null: return
	tg.missed = true
	if t < tg.sq:
		tg.hold1 = tg.sq + 0.04
		tg.back1 = tg.hold1 + 0.22


#--- the clock ---------------------------------------------------------------------------------------------------

func _process(delta):
	if bend == null: return
	var rate = 1.0
	if anim != null and is_instance_valid(anim) and anim.get('rate') != null: rate = anim.rate
	real += delta * rate
	t = stop_to_anim(stops, real)
	tau = t
	for i in range(bursts.size() - 1, -1, -1):
		if t - bursts[i].at > 0.6: bursts.remove(i)
	counter.update(t)
	pose_cards()
	apply_shake()
	space()
	night.dusk(seg(t, 0.1, release) * (1.0 - seg(t, calm, calm + 0.6)), t)
	for key in layers:
		layers[key].update()
	if t >= max(end_t, counter.gone_time()): queue_free()


#the floor ripples as a skin; under each target it swells, and once it bursts a ring runs out of the pit
func space():
	var list = []
	var k = seg(t, release, release + 0.4) * (1.0 - seg(t, calm, last_back + 0.3))
	if k > 0.01: list.append({type = 'wavy', pos = centre + Vector2(0, 40), r = 600.0, amp = 6.5 * k, wl = 66.0, speed = 5.0})
	for card in targets:
		var tg = targets[card]
		if t < tg.b:
			var swell = -0.6 * inout_quad(seg(t, release + 0.12, tg.b))
			if swell < -0.01: list.append({type = 'pinch', pos = tg.bulge, r = 128.0, k = swell})
			continue
		var q = seg(t, tg.b, tg.b + 0.5)
		if q < 1.0: list.append({type = 'ripple', pos = tg.pit, r = 8.0 + 260.0 * out_cubic(q), w = 30.0, amp = 12.0 * (1.0 - q)})
	bend.bends(list, 0.0, t)


#--- the cards ---------------------------------------------------------------------------------------------------

#a card trembles while the skin swells under it, is crushed when the tentacles squeeze, and shakes in their grip
func pose_cards():
	var tick = floor(t * 60.0)
	for card in targets:
		var tg = targets[card]
		if !is_instance_valid(card): continue
		var jit = 0.0
		if t > tg.b - 0.25 and t < tg.b: jit = 2.2 * seg(t, tg.b - 0.25, tg.b)
		var sq = 0.0
		if !tg.missed:
			sq = 0.12 * bump(t - tg.sq, 0.0, 0.02, 0.22)
			if t > tg.sq + 0.05 and t < tg.hold1: jit = max(jit, 1.6)
		if jit <= 0.0 and sq <= 0.0005:
			if tg.posed: rest_card(card, tg)
			continue
		tg.posed = true
		card.rect_pivot_offset = card.rect_size / 2.0
		card.rect_position = Vector2(noise(tg.seed * 11, tick, 1), noise(tg.seed * 11 + 5, tick, 2)) * jit
		card.rect_rotation = 0.0
		card.rect_scale = Vector2(1.0 - sq, 1.0 - sq)


#a card rests at zero inside its slot (CombatAnimations.card_home)
func rest_card(card, tg):
	tg.posed = false
	if !is_instance_valid(card): return
	card.rect_position = Vector2()
	card.rect_rotation = 0.0
	card.rect_scale = Vector2(1, 1)
	if tg.icon != null and is_instance_valid(tg.icon): tg.icon.rect_position = tg.icon_home


func apply_shake():
	if !(root is Control) or !is_instance_valid(root): return
	var off = kick_shake(kicks, stops, real, shake_px)
	if off == Vector2():
		if shaking: root.rect_position = root_home
		shaking = false
		return
	shaking = true
	root.rect_position = root_home + off


func _exit_tree():
	counter.finish_all()
	for card in targets:
		if targets[card].posed: rest_card(card, targets[card])
	if shaking and root is Control and is_instance_valid(root): root.rect_position = root_home
	if ground != null and ground != self and is_instance_valid(ground): ground.queue_free()


#--- layers ------------------------------------------------------------------------------------------------------

#on the ground, over the field and under the interface: the night's veil, then the bend; over everything: the pits,
#the tentacles, the sparks and the numbers
func build(kit, world):
	ground = ground_after(world)
	var under = ground != self
	night = NightSky.new()
	ground.add_child(night)
	night.fall(kit, {z = 0 if under else 80, dark = 0.3, stars = 0})
	bend = SpaceBend.new()
	bend.cover(ground, kit, {z = 0 if under else 81})
	layers.pit_glow = add_layer(82, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_pit_glow')
	layers.pit = add_layer(82, -1, '_draw_pits')
	layers.glow = add_layer(83, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_tentacle_glow')
	layers.body = add_layer(84, -1, '_draw_tentacles')
	layers.fx = add_layer(88, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_fx')
	layers.numbers = add_layer(96, -1, '_draw_numbers')


func grow(tg, i):
	var a = t - LAGS[i]
	var k = out_cubic(seg(a, tg.b, tg.b + 0.24)) * (1.0 - pow(seg(a, tg.hold1, tg.back1), 3))
	return 0.95 * k if i == 2 else k


func pit_k(tg):
	return out_back(seg(t, tg.b - 0.05, tg.b + 0.08)) * (1.0 - seg(t, tg.back1 - 0.05, tg.back1 + 0.2))


func each_tentacle(layer, glow):
	for card in targets:
		var tg = targets[card]
		if !card_ok(card): continue
		var started = false
		for i in range(tg.paths.size()):
			var k = grow(tg, i)
			if k <= 0.004: continue
			if !started:
				card_space(layer, card)
				b_begin(layer)
				started = true
			var thick = 1.0 if tg.missed else 1.0 + 0.4 * bump(t, tg.sq - 0.03, tg.sq, tg.sq + 0.25)
			var rows = tentacle_rows(writhe(path_part(tg.paths[i], k), 7.0 if i < 2 else 5.0, t, tg.seed + i * 3),
				WIDTHS[i] * (0.55 + 0.45 * min(1.0, k * 1.5)), thick)
			if glow: tentacle_glow(rows, 1.0)
			else: tentacle_body(rows, 1.0)
		if started:
			b_flush()
			screen_space(layer)


func _draw_tentacle_glow(layer):
	each_tentacle(layer, true)


func _draw_tentacles(layer):
	each_tentacle(layer, false)


func _draw_pit_glow(layer):
	for card in targets:
		var k = pit_k(targets[card])
		if k > 0.01: d_blob(layer, targets[card].pit, 75.0, ABYSS[1], 0.22 * min(1.0, k))


#a hole in the floor that the tentacles come up through: a dark ellipse with a lit rim
func _draw_pits(layer):
	for card in targets:
		var tg = targets[card]
		var k = pit_k(tg)
		if k <= 0.01: continue
		var pts = PoolVector2Array()
		for s in range(24):
			var a = TAU * s / 24.0
			pts.append(tg.pit + Vector2(cos(a) * 50.0 * k, sin(a) * 15.0 * k))
		layer.draw_colored_polygon(pts, fade(VOID_INK, 0.96))
		pts.append(pts[0])
		layer.draw_polyline(pts, fade(TENTACLE_RIM, 0.8 * min(1.0, k)), 1.6, true)


func _draw_fx(layer):
	for b in bursts:
		burst_sparks(layer, b, b.key)


func _draw_numbers(layer):
	counter.draw(layer, t, self)
