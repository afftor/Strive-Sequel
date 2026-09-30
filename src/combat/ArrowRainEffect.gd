extends "res://src/combat/FxNode.gd"
#«Дождь стрел» from the mockup: the archer looses one arrow into the sky, a short hush, then arrows rain
#on the whole side - into the cards and into the floor - and a heavy arrow comes down into each target.
#Each card's damage runs up as a counter, a share for every arrow in it (DamageCounter), and the card rocks with each.
#One clock with the mockup's hit-stops; the knobs are the ARROW_RAIN_* vars in CombatAnimations.gd.

const DamageCounter = preload("res://src/combat/DamageCounter.gd")

const STEEL = [Color(1, 1, 1), Color(0.588, 0.804, 1.0)]
const AIR = [Color(1, 1, 1), Color(0.804, 0.831, 0.863)]
const SHAFT = Color(0.627, 0.486, 0.345)
const HEAVY_SHAFT = Color(0.588, 0.455, 0.322)
const HEAVY_FEATHER = Color(0.769, 0.745, 0.69)
const HEAVY_HEAD = Color(0.588, 0.612, 0.659)
const HEAVY_EDGE = Color(0.118, 0.118, 0.133)
const DUST = Color(0.408, 0.369, 0.329)
const WAVE = Color(0.863, 0.886, 0.918)
const AIR_TRAIL = [Color(0.769, 0.8, 0.831), Color(0.941, 0.953, 0.965)]
const CARD_SIZE = Vector2(182, 202)
#the order the heavy arrows come down in: middle front, middle back, then the corners
const HEAVY_ORDER = [1, 4, 0, 5, 2, 3]

var anim = null
var caster = null
var root = null
var root_home = Vector2()
var shaking = false
var view = Rect2(0, 0, 1920, 1080)
var field = Rect2()
var away = 1.0
#the six places of the targets' side: {rect, card, target}
var slots = []
#target card -> {slot, hits, ticks, weights, missed, posed, icon_home}
var targets = {}
var arrows = []
var flares = []
var bursts = []
var dusts = []
var debris = []
var rings = []
var waves = []
var kicks = []
var flashes = []
var stops = []
var glint = {}
var counter = DamageCounter.new()
var rng = RandomNumberGenerator.new()

var real = 0.0
var shot = 0.18
var shot1 = 0.0
var rain0 = 0.0
var rain1 = 0.0
var volley = 0.0
var fin = 0.0
var first_hit = 0.0
var end_t = 0.0
var shake_px = 18.0
var stop_d = 0.12
var hold = 0.15
var layers = {}
#this frame's arrows in flight and stuck in the floor; each target keeps its own stuck ones
var flying = []
var stuck_floor = []
var event_key = 0


static func equip(kit):
	if kit.has('rain_font'): return
	var fonts = DamageCounter.make_fonts()
	kit.rain_font = fonts.font
	kit.rain_shadow = fonts.shadow


#opts: `shot` is when the bow lets go, `arrows` how many fall, `time` how long they fall, `stop` the last heavy arrow's
#hit-stop, `shake` the most the screen shakes, `hold` how long the queue waits after the
#last number, `root` the node shaken, `seed` the rain's pattern. `slot_nodes` are the six places of the targets' side,
#front rows top to bottom, then back rows.
func rain(new_anim, caster_node, hit_nodes, slot_nodes, kit, opts = {}):
	anim = new_anim
	caster = caster_node
	equip(kit)
	use_kit(kit)
	counter.font = shared.rain_font
	counter.shadow_font = shared.rain_shadow
	counter.hold = 0.45
	counter.fade_time = 0.5
	counter.pop = 0.08
	counter.slam = 0.3
	counter.slam_time = 0.3
	counter.ring = false
	counter.tremble = 0.0
	root = opts.get('root')
	if root is Control: root_home = root.rect_position
	shot = max(0.05, float(opts.get('shot', 0.18)))
	shake_px = float(opts.get('shake', 18.0))
	stop_d = float(opts.get('stop', 0.12))
	hold = float(opts.get('hold', 0.15))
	rng.seed = int(opts.get('seed', 4100))
	view = screen_rect()
	if caster.has_method('get_attack_vector') and caster.get_attack_vector().x < 0.0: away = -1.0
	for node in slot_nodes:
		var card = node.get_node_or_null('Character') if node != null and is_instance_valid(node) else null
		var is_target = card != null and card in hit_nodes and card_ok(card)
		slots.append({rect = local_rect(node) if node != null and is_instance_valid(node) else Rect2(), card = card if is_target else null, target = is_target})
		if is_target:
			var icon = card.get_node_or_null('Icon')
			targets[card] = {slot = slots.back(), hits = [], ticks = [], weights = [], missed = false, posed = false,
				icon = icon, icon_home = icon.rect_position if icon != null else Vector2()}
	if slots.size() < 6:
		queue_free()
		return
	field = slots[0].rect
	for sl in slots:
		field = field.merge(sl.rect)
	plan(int(opts.get('arrows', 60)), float(opts.get('time', 0.55)))
	build()
	set_process(true)


func target_cards():
	return targets.keys()


#the queue lets go a little before the first arrow goes into a card: the strike's sound takes a slot of its own first
func lock_time():
	return max(0.05, to_real(first_hit) - 0.1)


#--- the plan: everything as a function of time ---------------------------------------------------------------------

func plan(n, rain_time):
	shot1 = shot + 0.15
	rain0 = shot1 + 0.22
	rain1 = rain0 + rain_time
	volley = rain1 + 0.03
	var tip = caster_center() + Vector2(away * 40.0, -90.0)
	var top = view.position.y
	arrows.append({from = tip, to = Vector2(tip.x + away * 60.0, top - 160.0), t0 = shot, dur = shot1 - shot, at = shot1, w = 6.0, head = 16.0,
		trail = 0.4, heavy = false, stick = false, card = null, landed = true, done = false})
	bursts.append({at = shot, pos = tip, n = 8, ang = -PI / 2.0, spread = 1.2, power = 0.7, pal = STEEL, key = next_key()})
	rings.append({pos = tip + Vector2(0, -8), t0 = shot, dur = 0.25, r0 = 6.0, r1 = 46.0, sx = 0.35, rot = -PI / 2.0, w = 3.0})
	glint = {pos = Vector2(field.position.x + field.size.x / 2.0, top + 60.0), t0 = shot1, t1 = rain0}
	first_hit = volley
	#the rain covers the whole side, so an arrow that comes down where nobody stands goes into the floor
	for i in range(n):
		var t0 = rain0 + (i + 0.4 * rng.randf()) * rain_time / n
		var on_card = rng.randf() < 0.72
		var slot = slots[int(rng.randf() * 6.0) % 6]
		var r = slot.rect
		var to = Vector2(lerp(field.position.x - 60.0, field.end.x + 60.0, rng.randf()), lerp(field.position.y, field.end.y, rng.randf()))
		if on_card: to = Vector2(r.position.x + r.size.x * (0.15 + 0.7 * rng.randf()), r.position.y + r.size.y * (0.2 + 0.6 * rng.randf()))
		var from = Vector2(to.x - away * (240.0 + 60.0 * rng.randf()), top - 80.0 - 60.0 * rng.randf())
		var dur = 0.11 + 0.03 * rng.randf()
		var card = slot.card if on_card and slot.target else null
		var ar = {from = from, to = to, t0 = t0, dur = dur, at = t0 + dur, w = 3.2, head = 11.0, trail = 0.45, heavy = false,
			stick = true, stick_dur = 0.9, card = card, landed = false, last = false, done = false}
		if card != null:
			targets[card].ticks.append(ar.at)
			targets[card].weights.append(5 + int(rng.randf() * 4.0))
			first_hit = min(first_hit, ar.at)
		arrows.append(ar)
	#the rain goes on as heavy arrows, one into every target: splinters burst out of the back of the card and the arrow stays in it
	var heavy = []
	for k in HEAVY_ORDER:
		if slots[k].target: heavy.append(slots[k])
	fin = volley
	for j in range(heavy.size()):
		var r = heavy[j].rect
		var to = Vector2(r.position.x + r.size.x * (0.35 + 0.3 * rng.randf()), r.position.y + r.size.y * (0.24 + 0.1 * rng.randf()))
		var from = Vector2(to.x - away * 300.0, top - 140.0)
		var t0 = volley + j * 0.06
		var last = j == heavy.size() - 1
		var ar = {from = from, to = to, t0 = t0, dur = 0.09, at = t0 + 0.09, w = 5.0, head = 30.0 if last else 25.0, trail = 0.4, heavy = true,
			stick = true, stick_dur = 1.1, card = heavy[j].card, landed = false, last = last, done = false}
		targets[ar.card].ticks.append(ar.at)
		targets[ar.card].weights.append(40 + int(rng.randf() * 15.0))
		first_hit = min(first_hit, ar.at)
		stops.append({at = ar.at + 0.02, d = stop_d if last else 0.35 * stop_d})
		flashes.append({at = ar.at, a = 0.35 if last else 0.15})
		fin = max(fin, ar.at)
		arrows.append(ar)
	flashes.append({at = shot, a = 0.25})
	end_t = fin + 1.25


func next_key():
	event_key += 1
	return event_key


func caster_center():
	if caster == null or !is_instance_valid(caster): return view.position + view.size / 2.0
	var r = local_rect(caster)
	return r.position + r.size / 2.0


#hit-stops: the effect's clock stands still for d real seconds at each
func to_anim(r):
	var acc = 0.0
	for s in stops:
		var rs = s.at + acc
		if r <= rs: break
		if r < rs + s.d: return s.at
		acc += s.d
	return r - acc


func to_real(a):
	var acc = 0.0
	for s in stops:
		if a <= s.at: break
		acc += s.d
	return a + acc


#--- the damage --------------------------------------------------------------------------------------------------

#The target's hp_update, handed over: its number runs up an arrow at a time. Returns how long the queue waits.
func take_hit(node, args, crit):
	var tg = targets.get(node)
	if tg == null or tg.ticks.empty(): return 0.2
	var c = counter.start(node, args, crit, tg.ticks, tg.weights, t)
	return max(0.1, to_real(c.done) - real) + hold


#how much longer a card's number runs, in real time; its death waits for it
func counter_left(node):
	var c = counter.counters.get(node)
	if c == null or c.finished: return 0.0
	return max(0.0, to_real(c.done) - real)


#The target dodged: whatever of the rain has not reached it yet goes into the floor at its feet.
func missed(node):
	var tg = targets.get(node)
	if tg == null: return
	tg.missed = true
	var bottom = tg.slot.rect.end.y
	for ar in arrows:
		if ar.card != node or ar.landed: continue
		ar.card = null
		ar.to = Vector2(ar.to.x + away * 30.0 * rng.randf(), bottom + 4.0 + 10.0 * rng.randf())


#--- the clock ---------------------------------------------------------------------------------------------------

func _process(delta):
	var rate = 1.0
	if anim != null and is_instance_valid(anim) and anim.get('rate') != null: rate = anim.rate
	real += delta * rate
	t = to_anim(real)
	tau = t
	flying.clear()
	stuck_floor.clear()
	for card in targets:
		targets[card].stuck = []
	for ar in arrows:
		if ar.done: continue
		if !ar.landed and t >= ar.at: land(ar)
		if t >= ar.t0 and t < ar.t0 + ar.dur:
			fly(ar)
			flying.append(ar)
		elif ar.landed:
			if !stuck(ar):
				if t > ar.at: ar.done = true
			elif ar.card == null: stuck_floor.append(ar)
			elif targets.has(ar.card): targets[ar.card].stuck.append(ar)
	prune()
	counter.update(t)
	pose_cards()
	apply_shake()
	for key in layers:
		layers[key].update()
	if t >= max(end_t, counter.gone_time()): queue_free()


#what has played out is dropped, so each frame walks only what is still on screen
func prune():
	for i in range(flares.size() - 1, -1, -1):
		if t - flares[i].t0 > flares[i].dur: flares.remove(i)
	for i in range(dusts.size() - 1, -1, -1):
		if t - dusts[i].t0 > dusts[i].dur: dusts.remove(i)
	for i in range(bursts.size() - 1, -1, -1):
		if t - bursts[i].at > 0.6: bursts.remove(i)
	for i in range(debris.size() - 1, -1, -1):
		if t - debris[i].t0 > 1.4: debris.remove(i)
	for i in range(kicks.size() - 1, -1, -1):
		if t - kicks[i].at > kicks[i].dur + 0.2: kicks.remove(i)


func land(ar):
	ar.landed = true
	var dir = (ar.to - ar.from).normalized()
	var ang = atan2(dir.y, dir.x)
	var card = ar.card
	if card != null and (!is_instance_valid(card) or targets[card].missed): card = null
	if card == null:
		#a miss sticks in the floor and kicks up a puff
		dusts.append({pos = ar.to + Vector2(0, 4), t0 = ar.at, dur = 0.5 if !ar.heavy else 0.7, r0 = 3.0, r1 = 24.0 if !ar.heavy else 60.0,
			n = 5, flat = 0.45, s = 0.32 if !ar.heavy else 0.45, key = next_key()})
		bursts.append({at = ar.at, pos = ar.to, n = 3 if !ar.heavy else 8, ang = -PI / 2.0, spread = 2.2, power = 0.5, pal = STEEL, key = next_key()})
		kicks.append({at = ar.at, mag = 0.05 if !ar.heavy else 0.3, dur = 0.05 if !ar.heavy else 0.2, dir = null})
		ar.card = null
		ar.spot = ar.to
		ar.base_ang = ang
		return
	var big = ar.heavy
	var pal = AIR if big else STEEL
	var size = (40.0 if ar.last else 30.0) if big else 15.0
	flares.append(new_flare(ar.to, ang, ar.at, size, 0.2 if big else 0.13, 7 + next_key() * 13, 8, pal, false, false))
	bursts.append({at = ar.at, pos = ar.to, n = 14 if big else 4, ang = ang, spread = 0.8 if big else 0.9, power = 1.3 if big else 0.8, pal = pal, key = next_key()})
	kicks.append({at = ar.at, mag = (1.1 if ar.last else 0.6) if big else 0.07, dur = 0.4 if big else 0.1, dir = dir})
	targets[card].hits.append({at = ar.at, dir = dir, kb = (34.0 if ar.last else 26.0) if big else 6.0, lift = 12.0 if big else 0.0, big = big})
	#it stays where it went in, riding the card from now on
	var into = card.get_global_transform().affine_inverse() * get_global_transform()
	ar.spot = into.xform(ar.to)
	var local_dir = into.basis_xform(dir)
	ar.base_ang = atan2(local_dir.y, local_dir.x)
	if big:
		debris.append({pos = ar.to, t0 = ar.at, n = 18 if ar.last else 12, ang = ang, spread = 0.9, power = 1.1, size = 7.0, col = HEAVY_SHAFT, key = next_key()})
		dusts.append({pos = ar.to + dir * 60.0, t0 = ar.at, dur = 0.7, r0 = 8.0, r1 = 70.0, n = 7, flat = 0.8, s = 0.45, key = next_key()})
		if ar.last: waves.append({pos = ar.to, t0 = ar.at, dur = 0.4, r0 = 20.0, r1 = 420.0, w = 44.0, a = 0.25})
		input_handler.PlaySound('combat_hit_body_warm')


#--- the cards ---------------------------------------------------------------------------------------------------

#each arrow throws the card along its flight and it springs back; a heavy one lifts it and squashes it a little
func card_pose(tg):
	var px = 0.0
	var py = 0.0
	var lift = 0.0
	var sq = 0.0
	var sqx = 0.0
	var sqy = 0.0
	var fl = 0.0
	var hot = 0.0
	var jit = 0.0
	var active = false
	for h in tg.hits:
		var a = t - h.at
		if a < 0.0 or a > 0.9: continue
		active = true
		var k = out_quad(a / 0.035) if a < 0.035 else exp(-(a - 0.035) * 7.0) * cos((a - 0.035) * 13.0)
		px += h.dir.x * h.kb * k
		py += h.dir.y * h.kb * k
		if h.lift > 0.0: lift = max(lift, h.lift * bump(a, 0.0, 0.1, 0.5))
		var s = (0.12 if h.big else 0.03) * bump(a, 0.0, 0.02, 0.14)
		if s > sq:
			sq = s
			sqx = abs(h.dir.x)
			sqy = abs(h.dir.y)
		fl = max(fl, (0.72 if h.big else 0.35) * bump(a, 0.0, 0.012, 0.28 if h.big else 0.16))
		if a < 0.04: hot = max(hot, 1.0 if h.big else 0.5)
		jit = max(jit, (7.0 if h.big else 3.0) * (1.0 - seg(a, 0.0, 0.3 if h.big else 0.18)))
	var mag = sqrt(px * px + py * py)
	if mag > 70.0:
		px *= 70.0 / mag
		py *= 70.0 / mag
	return {active = active, pos = Vector2(px, py - lift), rot = 2.2 * px / 30.0, flash = fl, hot = hot, jit = jit,
		scale = Vector2(1.0 - sq * sqx + 0.5 * sq * sqy, 1.0 - sq * sqy + 0.5 * sq * sqx)}


func pose_cards():
	var tick = floor(t * 60.0)
	for card in targets:
		var tg = targets[card]
		if !is_instance_valid(card): continue
		var m = card_pose(tg)
		tg.pose = m
		if !m.active:
			if tg.posed: rest_card(card, tg)
			continue
		tg.posed = true
		card.rect_pivot_offset = card.rect_size / 2.0
		card.rect_position = m.pos
		card.rect_rotation = m.rot
		card.rect_scale = m.scale
		if tg.icon != null and is_instance_valid(tg.icon):
			var seed_ = card.get_instance_id() % 97
			tg.icon.rect_position = tg.icon_home + Vector2(noise(seed_ * 7, tick, 0), noise(seed_ * 7 + 3, tick, 0)) * m.jit


#a card rests at zero inside its slot (CombatAnimations.card_home)
func rest_card(card, tg):
	tg.posed = false
	if !is_instance_valid(card): return
	card.rect_position = Vector2()
	card.rect_rotation = 0.0
	card.rect_scale = Vector2(1, 1)
	if tg.icon != null and is_instance_valid(tg.icon): tg.icon.rect_position = tg.icon_home


#--- the screen --------------------------------------------------------------------------------------------------

#the shake runs mostly along the blow that caused it
func apply_shake():
	if !(root is Control) or !is_instance_valid(root): return
	var best = 0.0
	var dir = null
	for k in kicks:
		var a = real - to_real(k.at)
		if a < 0.0 or a >= k.dur: continue
		var m = shake_px * k.mag * pow(1.0 - a / k.dur, 1.5)
		if m > best:
			best = m
			dir = k.dir
	if best <= 0.01:
		if shaking: root.rect_position = root_home
		shaking = false
		return
	shaking = true
	var tick = floor(real * 60.0)
	var n1 = noise(57, tick, 1)
	var n2 = noise(57, tick, 2)
	var off = Vector2(best * n1, best * n2)
	if dir != null: off = Vector2(best * (n1 * dir.x - 0.35 * n2 * dir.y), best * (n1 * dir.y + 0.35 * n2 * dir.x))
	root.rect_position = root_home + off


func _exit_tree():
	counter.finish_all()
	for card in targets:
		if targets[card].posed: rest_card(card, targets[card])
	if shaking and root is Control and is_instance_valid(root): root.rect_position = root_home


#--- layers ------------------------------------------------------------------------------------------------------

func build():
	layers.stuck = add_layer(83, -1, '_draw_stuck')
	layers.stuck_glow = add_layer(84, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_stuck_glow')
	layers.flight_glow = add_layer(85, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_flight_glow')
	layers.flight = add_layer(86, -1, '_draw_flight')
	layers.dust = add_layer(87, -1, '_draw_dust')
	layers.fx = add_layer(88, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_fx')
	layers.flash = add_layer(90, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_flash')
	layers.numbers = add_layer(96, -1, '_draw_numbers')


#an arrow stuck in a card shudders on its point for a moment, then fades; false once it is gone
func stuck(ar):
	if !ar.stick or !ar.landed: return false
	var a = t - ar.at
	if a < 0.0 or a > ar.stick_dur: return false
	ar.al = 1.0 - seg(a, 0.6 * ar.stick_dur, ar.stick_dur)
	ar.hot = 1.0 - seg(a, 0.0, 0.2)
	ar.spin = ar.base_ang + 0.15 * exp(-a * 6.0) * sin(a * 58.0)
	return true


func each_stuck(layer, method):
	b_begin(layer)
	for ar in stuck_floor:
		call(method, ar)
	b_flush()
	for card in targets:
		var list = targets[card].get('stuck', [])
		if list.empty() or !card_ok(card): continue
		card_space(layer, card)
		for ar in list:
			call(method, ar)
		b_flush()
		screen_space(layer)


func _draw_stuck(layer):
	each_stuck(layer, 'stuck_body')


func _draw_stuck_glow(layer):
	each_stuck(layer, 'stuck_glow')


func stuck_body(ar):
	if ar.heavy: heavy_arrow(ar.spot, ar.spin, ar.head, ar.al, true)
	else:
		var xf = Transform2D(ar.spin, ar.spot)
		var L = ar.head * 5.2
		fletching(xf, L, ar.head, fade(STEEL[1], 0.9 * ar.al))
		b_line(xf.xform(Vector2(-ar.head * 0.1, 0)), xf.xform(Vector2(-L, 0)), max(1.6, ar.head * 0.3), fade(SHAFT, ar.al))


func stuck_glow(ar):
	if !ar.heavy:
		var xf = Transform2D(ar.spin, ar.spot)
		var L = ar.head * 5.2
		b_line(xf.xform(Vector2(-ar.head * 0.3, -ar.head * 0.06)), xf.xform(Vector2(-L * 0.85, -ar.head * 0.06)), max(0.8, ar.head * 0.1), fade(STEEL[0], 0.4 * ar.al))
	if ar.hot > 0.01:
		blob(ar.spot, ar.head * 1.6, STEEL[1], 0.7 * ar.hot * ar.al)
		blob(ar.spot, ar.head * 0.6, STEEL[0], 0.8 * ar.hot * ar.al)


#the shaft and the fletching; the head is drawn with the glow
func _draw_flight(layer):
	b_begin(layer)
	for ar in flying:
		var xf = Transform2D(ar.fang, ar.fhead)
		if ar.heavy: heavy_arrow(ar.fhead, ar.fang, ar.head, 1.0, false)
		else:
			var L = ar.head * 5.2
			fletching(xf, L, ar.head, fade(STEEL[1], 0.9))
			b_line(xf.xform(Vector2(-L, 0)), xf.xform(Vector2(-ar.head * 0.3, 0)), max(1.6, ar.head * 0.28), SHAFT)
	b_flush()


func _draw_flight_glow(layer):
	b_begin(layer)
	for ar in flying:
		var pts = ar.fpts
		var n = pts.size() - 1
		for i in range(1, n + 1):
			var k = float(i) / n
			var col = null
			if ar.heavy: col = fade(AIR_TRAIL[1] if i > n - 3 else AIR_TRAIL[0], 0.4 * k)
			else: col = fade(STEEL[0] if i > n - 3 else STEEL[1], 0.5 * k)
			b_line(pts[i - 1], pts[i], ar.w * (0.3 + 1.8 * k), col)
		if !ar.heavy:
			var xf = Transform2D(ar.fang, ar.fhead)
			var L = ar.head * 5.2
			soft_line(xf.xform(Vector2(-L * 1.05, 0)), xf.xform(Vector2(ar.head * 1.5, 0)), ar.head * 1.3, fade(STEEL[1], 0.3))
			b_line(xf.xform(Vector2(-L * 0.92, -ar.head * 0.05)), xf.xform(Vector2(-ar.head * 0.4, -ar.head * 0.05)), max(0.8, ar.head * 0.09), fade(STEEL[0], 0.5))
			arrow_head(ar.fhead, ar.fang, ar.head, 1.0)
	b_flush()


#where a flying arrow is: its head, its heading and the trail behind it
func fly(ar):
	var u = (t - ar.t0) / ar.dur
	var u0 = max(0.0, u - ar.trail)
	if !ar.has('fpts'):
		ar.fpts = []
		ar.fpts.resize(11)
	for i in range(11):
		ar.fpts[i] = ar.from.linear_interpolate(ar.to, lerp(u0, u, i / 10.0))
	var d = ar.to - ar.from
	ar.fhead = ar.fpts[10]
	ar.fang = atan2(d.y, d.x)


func fletching(xf, L, s, col):
	for sd in [-1.0, 1.0]:
		b_quad(xf.xform(Vector2(-L + s * 1.4, 0)), xf.xform(Vector2(-L + s * 0.3, sd * s * 0.7)), xf.xform(Vector2(-L - s * 0.2, sd * s * 0.62)),
			xf.xform(Vector2(-L + s * 0.5, 0)), col, col, col, col)


func arrow_head(pos, ang, s, al):
	var xf = Transform2D(ang, pos)
	blob(pos, s * 2.2, STEEL[1], 0.45 * al)
	var c = fade(STEEL[0], al)
	b_quad(xf.xform(Vector2(s * 1.4, 0)), xf.xform(Vector2(-s * 0.6, s * 0.55)), xf.xform(Vector2(-s * 0.2, 0)), xf.xform(Vector2(-s * 0.6, -s * 0.55)), c, c, c, c)


func heavy_arrow(pos, ang, s, al, stuck):
	var xf = Transform2D(ang, pos)
	var L = s * 5.4
	var feather = fade(HEAVY_FEATHER, al)
	for sd in [-1.0, 1.0]:
		b_quad(xf.xform(Vector2(-L + s * 1.5, 0)), xf.xform(Vector2(-L + s * 0.3, sd * s * 0.62)), xf.xform(Vector2(-L - s * 0.2, sd * s * 0.55)),
			xf.xform(Vector2(-L + s * 0.5, 0)), feather, feather, feather, feather)
	b_line(xf.xform(Vector2(-L, 0)), xf.xform(Vector2(-s * 0.1 if stuck else -s * 0.3, 0)), max(2.0, s * 0.24), fade(HEAVY_SHAFT, al))
	if stuck: return
	var edge = fade(HEAVY_EDGE, al)
	var tip = [xf.xform(Vector2(s * 1.2, 0)), xf.xform(Vector2(-s * 0.4, s * 0.32)), xf.xform(Vector2(-s * 0.4, -s * 0.32))]
	b_poly(PoolVector2Array([tip[0], tip[1], tip[2]]), fade(HEAVY_HEAD, al))
	for i in range(3):
		b_line(tip[i], tip[(i + 1) % 3], 1.2, edge)
	var glint_col = fade(WHITE, 0.8 * al)
	b_quad(xf.xform(Vector2(-s * 0.1, -s * 0.12)), xf.xform(Vector2(s * 0.7, -s * 0.12)), xf.xform(Vector2(s * 0.7, -s * 0.06)),
		xf.xform(Vector2(-s * 0.1, -s * 0.06)), glint_col, glint_col, glint_col, glint_col)


#a soft glow from a to b, the atlas's soft disc drawn out along the line
func soft_line(a, b, w, col):
	var d = b - a
	var l = d.length()
	if l < 1.0 or w <= 0.05 or col.a <= 0.004: return
	var n = Vector2(-d.y, d.x) * (w * 0.5 / l)
	b_quad(a + n, b + n, b - n, a - n, col, col, col, col, UV_SOFT)


func _draw_dust(layer):
	b_begin(layer)
	for d in dusts:
		var a = t - d.t0
		if a < 0.0 or a > d.dur: continue
		var q = a / d.dur
		var k = out_cubic(q)
		for i in range(d.n):
			var b = d.key * 31 + i * 3
			var h1 = hash01(b)
			var h2 = hash01(b + 1)
			var h3 = hash01(b + 2)
			var an = TAU * (i + 0.5 * h1) / d.n
			var rr = lerp(d.r0, d.r1, k) * (0.75 + 0.5 * h2)
			blob(d.pos + Vector2(cos(an) * rr, sin(an) * rr * d.flat - 40.0 * k * h3 * d.s), lerp(18.0, 66.0, k) * d.s * (0.7 + 0.6 * h3),
				DUST, 0.36 * (1.0 - q) * seg(a, 0.0, 0.04))
	b_flush()
	for d in debris:
		slivers(layer, d, d.key)


func _draw_fx(layer):
	for f in flares:
		flare(layer, f)
	for b in bursts:
		burst_sparks(layer, b, b.key)
	for rg in rings:
		var a = t - rg.t0
		if a < 0.0 or a > rg.dur: continue
		var q = a / rg.dur
		var r = lerp(rg.r0, rg.r1, out_cubic(q))
		#squashed along its own axis, then turned: a ring of air seen edge on
		layer.draw_set_transform_matrix(Transform2D(rg.rot, rg.pos) * Transform2D(Vector2(rg.sx, 0), Vector2(0, 1), Vector2()))
		layer.draw_arc(Vector2(), r, 0.0, TAU, 40, fade(STEEL[1], 0.35 * (1.0 - q)), rg.w * 3.0 * (1.0 - q) + 2.0, true)
		layer.draw_arc(Vector2(), r, 0.0, TAU, 40, fade(STEEL[0], 0.8 * (1.0 - q)), rg.w * (1.0 - q) + 1.0, true)
		layer.draw_set_transform(Vector2(), 0.0, Vector2(1, 1))
	for wv in waves:
		var a = t - wv.t0
		if a < 0.0 or a > wv.dur: continue
		var q = a / wv.dur
		var r = lerp(wv.r0, wv.r1, q)
		var w = wv.w * (0.6 + 0.8 * q)
		var al = wv.a * (1.0 - q) * seg(a, 0.0, 0.02)
		var inner = max(0.0, r - w)
		var outer = r + w * 0.3
		if al > 0.004: radial(layer, wv.pos, [inner, inner + 0.75 * (outer - inner), outer], [fade(WAVE, 0.0), fade(WAVE, al), fade(WAVE, 0.0)], 48)
	if t >= glint.t0 and t <= glint.t1 + 0.12:
		var tw = (0.6 + 0.4 * sin(t * 22.0)) * seg(t, glint.t0, glint.t1) * (1.0 - seg(t, glint.t1, glint.t1 + 0.12))
		d_blob(layer, glint.pos, 40.0, STEEL[1], 0.5 * tw)
		layer.draw_line(glint.pos - Vector2(36, 0), glint.pos + Vector2(36, 0), fade(STEEL[0], 0.9 * tw), 2.0)
		layer.draw_line(glint.pos - Vector2(0, 36), glint.pos + Vector2(0, 36), fade(STEEL[0], 0.9 * tw), 2.0)
	#a sheen runs over the archer's card while the bow is drawn
	var sheen = seg(t, 0.3 * shot, shot)
	if sheen > 0.0 and sheen < 1.0 and card_ok(caster):
		card_space(layer, caster)
		var x = lerp(-190.0, 190.0, sheen)
		d_stripe(layer, Rect2(Vector2(4, 4), caster.rect_size - Vector2(8, 8)), caster.rect_size / 2.0, Vector2(cos(-0.6), sin(-0.6)),
			[x - 24.0, x, x + 24.0], [fade(STEEL[1], 0.0), fade(STEEL[0], 0.85 * sheen), fade(STEEL[1], 0.0)])
		screen_space(layer)
	#the portrait flashes with every arrow that goes in
	for card in targets:
		var tg = targets[card]
		if !tg.has('pose') or tg.pose.flash <= 0.004 or !card_ok(card) or tg.icon == null: continue
		card_space(layer, card)
		layer.draw_rect(Rect2(tg.icon.rect_position, tg.icon.rect_size), fade(STEEL[1].linear_interpolate(WHITE, tg.pose.hot), tg.pose.flash))
		screen_space(layer)


func _draw_flash(layer):
	var f = 0.0
	for fl in flashes:
		f = max(f, fl.a * bump(t, fl.at, fl.at + 0.015, fl.at + 0.16 if fl.a < 0.3 else fl.at + 0.2))
	if f > 0.004: layer.draw_rect(view.grow(160.0), fade(STEEL[1].linear_interpolate(WHITE, 0.6), 0.35 * f))


func _draw_numbers(layer):
	counter.draw(layer, t, self)
