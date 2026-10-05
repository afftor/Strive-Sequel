extends "res://src/combat/FxNode.gd"
#«Пустота» as the «Сфера» take of the «Тьма» mockup: a black sphere flies from the caster's hand to the middle of the
#targets' side, bending everything it passes like a lens; there it grows, then space breaks like glass - wedges of the
#picture shift, light runs down the cracks - and a ripple goes out: each target's damage lands as the ripple reaches
#it. Space bends through SpaceBend; the knobs are the VOID_SPHERE_* vars in CombatAnimations.gd.

const SpaceBend = preload("res://src/combat/SpaceBend.gd")
const NightSky = preload("res://src/combat/NightSky.gd")
const DamageCounter = preload("res://src/combat/DamageCounter.gd")
const WAVE_SPEED = 2500.0 #px/s the ripple runs out at
const WAVE_REACH = 1500.0
const WEDGES = 14
const SHATTER_SEED = 7
const SHARD = Color(0.471, 0.275, 0.824)
const PHOTON = Color(0.933, 0.886, 1.0)

var anim = null
var caster = null
var root = null
var root_home = Vector2()
var shaking = false
var view = Rect2(0, 0, 1920, 1080)
var centre = Vector2()
var hand = Vector2()
var bow = Vector2()
#target card -> {at, dir, missed, posed, icon, icon_home, seed}
var targets = {}
var flares = []
var bursts = []
var debris = []
var kicks = []
var stops = []
var cracks = []
var counter = DamageCounter.new()
var bend = null
var night = null
var ground = null
var layers = {}
var real = 0.0
var release = 0.7
var fly0 = 0.0
var fly1 = 0.0
var grow1 = 0.0
var det = 0.0
var shat1 = 0.0
var relax = 0.0
var calm = 0.0
var first_hit = 0.0
var end_t = 0.0
var shake_px = 16.0
var hold = 0.2
var event_key = 0


static func equip(kit):
	if kit.has('dark_font'): return
	var fonts = DamageCounter.make_fonts()
	kit.dark_font = fonts.font
	kit.dark_shadow = fonts.shadow


#opts: `release` when the cast lets go, `flight` how long the sphere flies, `stop` the hit-stop when space breaks,
#`shake` the most the screen shakes, `hold` how long the queue waits after a number, `root` the node shaken, `world`
#the battlefield's last node (the night, the bend and the cracks go right after it, under the interface).
#`slot_nodes` are the six places of the targets' side, whether or not anyone stands there.
func cast(new_anim, caster_node, hit_nodes, slot_nodes, kit, opts = {}):
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
	release = float(opts.get('release', 0.7))
	shake_px = float(opts.get('shake', 16.0))
	hold = float(opts.get('hold', 0.2))
	view = screen_rect()
	var field = Rect2()
	var first = true
	for node in slot_nodes:
		if node == null or !is_instance_valid(node): continue
		var r = local_rect(node)
		field = r if first else field.merge(r)
		first = false
	centre = field.position + field.size / 2.0
	var away = 1.0
	if caster != null and caster.has_method('get_attack_vector') and caster.get_attack_vector().x < 0.0: away = -1.0
	var home = centre
	if caster != null and is_instance_valid(caster):
		var cr = local_rect(caster)
		home = cr.position + cr.size / 2.0
	hand = home + Vector2(away * 70.0, -120.0)
	bow = Vector2((hand.x + centre.x) / 2.0, (hand.y + centre.y) / 2.0 + 30.0)
	for card in hit_nodes:
		if card == null or !card_ok(card): continue
		var icon = card.get_node_or_null('Icon')
		targets[card] = {missed = false, posed = false, icon = icon, icon_home = icon.rect_position if icon != null else Vector2(),
			seed = targets.size() * 7 + 3}
	plan(float(opts.get('flight', 0.67)), float(opts.get('stop', 0.12)))
	build(kit, opts.get('world'))
	set_process(true)


func target_cards():
	return targets.keys()


#the queue lets go a little before the ripple reaches the first target: the strike's sound takes a slot of its own
func lock_time():
	return max(0.05, stop_to_real(stops, first_hit) - 0.1)


#--- the plan --------------------------------------------------------------------------------------------------------

func plan(flight, stop_d):
	fly0 = release + 0.02
	fly1 = fly0 + flight
	grow1 = fly1 + 0.4
	det = grow1 + 0.15
	shat1 = det + 0.38
	relax = shat1 + 0.3
	calm = det + 0.3
	first_hit = det + 0.6
	var last = det
	for card in targets:
		var tg = targets[card]
		var r = local_rect(card)
		var cc = r.position + r.size / 2.0
		tg.dir = (cc - centre).normalized() if cc.distance_to(centre) > 1.0 else Vector2(1, 0)
		tg.at = det + cc.distance_to(centre) / WAVE_SPEED
		first_hit = min(first_hit, tg.at)
		last = max(last, tg.at)
		var ang = atan2(tg.dir.y, tg.dir.x)
		bursts.append({at = tg.at, pos = cc, n = 14, ang = ang, spread = 2.0, power = 1.0, pal = ABYSS, key = next_key()})
		debris.append({pos = cc, t0 = tg.at, n = 8, ang = ang, spread = 1.8, power = 1.0, size = 6.0, col = SHARD, key = next_key()})
	flares.append(new_flare(centre, 0.0, det, 120.0, 0.3, 9300 + next_key() * 13, 14, ABYSS, true, false))
	bursts.append({at = det, pos = centre, n = 46, ang = 0.0, spread = TAU, power = 2.1, pal = ABYSS, key = next_key()})
	kicks.append({at = det, mag = 2.6, dur = 0.8, dir = null})
	stops.append({at = det + 0.02, d = 1.2 * stop_d})
	build_cracks(560.0)
	end_t = max(relax, last) + 1.0


func next_key():
	event_key += 1
	return event_key


#space broken like glass round the middle: straight cracks along the wedges SpaceBend shifts, kinked a little and
#forking, joined by two rings of short cross cracks like a spider web
func build_cracks(R):
	var w = TAU / WEDGES
	var s0 = SHATTER_SEED
	for i in range(WEDGES):
		var an0 = i * w - PI
		var L = R * (0.7 + 0.3 * hash01(s0 + i * 5))
		var pts = [centre]
		for s in range(1, 5):
			var an = an0 + (hash01(s0 * 3 + i * 31 + s) - 0.5) * 0.08
			var p = centre + Vector2(cos(an), sin(an)) * L * s / 4.0
			pts.append(p)
			if s == 2 or (s == 3 and hash01(s0 + i * 7 + s) > 0.5):
				var b = an + (1.0 if hash01(s0 + i * 11 + s) > 0.5 else -1.0) * (0.35 + 0.3 * hash01(s0 + i * 13 + s))
				cracks.append([p, p + Vector2(cos(b), sin(b)) * L * 0.18])
		cracks.append(pts)
	for ri in range(2):
		var f = 0.3 if ri == 0 else 0.58
		for i in range(WEDGES):
			if hash01(s0 * 5 + i + ri * 17) < 0.25: continue
			var a0 = i * w - PI
			var d0 = R * f * (0.9 + 0.2 * hash01(s0 + i + ri))
			var d1 = R * f * (0.9 + 0.2 * hash01(s0 + i + 1 + ri))
			cracks.append([centre + Vector2(cos(a0), sin(a0)) * d0, centre + Vector2(cos(a0 + w * 0.5), sin(a0 + w * 0.5)) * ((d0 + d1) / 2.0 * 0.97),
				centre + Vector2(cos(a0 + w), sin(a0 + w)) * d1])


#--- where the sphere is -------------------------------------------------------------------------------------------

func sphere_pos():
	return quad_point(hand, bow, centre, 0.5 - 0.5 * cos(PI * seg(t, fly0, fly1)))


func sphere_r():
	if t < det: return 26.0 * out_back(seg(t, fly0, fly0 + 0.14)) + 30.0 * out_cubic(seg(t, fly1, grow1))
	return 56.0 * (1.0 - seg(t, det, det + 0.05))


#--- the damage --------------------------------------------------------------------------------------------------

#how long from now until the ripple reaches a target
func hit_delay(node):
	var tg = targets.get(node)
	if tg == null: return 0.0
	return max(0.0, stop_to_real(stops, tg.at) - real)


#The target's hp_update, handed over: its number shows when the ripple reaches it. Returns how long the queue waits.
func take_hit(node, args, crit):
	var tg = targets.get(node)
	if tg == null or tg.missed: return 0.2
	var c = counter.start(node, args, crit, [tg.at], [], t)
	if anim != null and is_instance_valid(anim): anim.damage_flash(node, hit_delay(node))
	return max(0.1, stop_to_real(stops, c.done) - real) + hold


#how much longer a card's number runs, in real time; its death waits for it
func counter_left(node):
	var c = counter.counters.get(node)
	if c == null or c.finished: return 0.0
	return max(0.0, stop_to_real(stops, c.done) - real)


#the target got away: the ripple still rocks it, but it takes no blow
func missed(node):
	var tg = targets.get(node)
	if tg != null: tg.missed = true


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
	night.dusk(max(0.83 * seg(t, 0.1, release) * (1.0 - seg(t, calm, calm + 0.6)), seg(t, fly1, grow1) * (1.0 - seg(t, det, det + 0.4))), t)
	for key in layers:
		layers[key].update()
	if t >= max(end_t, counter.gone_time()): queue_free()


#the sphere bends a wide ring round itself in flight and a closer one once grown; then the wedges of broken space
#shift, and the ripple runs out
func space():
	var list = []
	var r = sphere_r()
	if r > 0.5 and t < det:
		list.append({type = 'lens', pos = sphere_pos(), r = r * lerp(3.2, 2.4, seg(t, fly1, grow1)), k = 1.0, spin = 0.35})
	var sh = seg(t, det, det + 0.04) * (1.0 - inout_quad(seg(t, shat1, relax)))
	if sh > 0.005: list.append({type = 'shatter', pos = centre, r = 580.0, push = 26.0 * sh, n = WEDGES, seed = float(SHATTER_SEED)})
	var w = seg(t, det, det + WAVE_REACH / WAVE_SPEED)
	if w > 0.0 and w < 1.0: list.append({type = 'ripple', pos = centre, r = 20.0 + WAVE_REACH * w, w = 70.0, amp = 22.0 * pow(1.0 - w, 1.2)})
	var ca = 0.28 * bump(t, det, det + 0.03, det + 0.45) + (0.05 if t > fly0 and t < det else 0.0)
	bend.bends(list, ca, t)


#--- the cards ---------------------------------------------------------------------------------------------------

#the ripple throws the card away from the middle and it springs back, squashed a little, its portrait shaking
func pose_cards():
	var tick = floor(t * 60.0)
	for card in targets:
		var tg = targets[card]
		if !is_instance_valid(card): continue
		var a = t - tg.at
		if a < 0.0 or a > 0.9:
			if tg.posed: rest_card(card, tg)
			continue
		tg.posed = true
		var kb = 14.0 if tg.missed else 38.0
		var k = out_quad(a / 0.035) if a < 0.035 else exp(-(a - 0.035) * 7.0) * cos((a - 0.035) * 13.0)
		var off = tg.dir * kb * k
		var sq = 0.0 if tg.missed else 0.12 * bump(a, 0.0, 0.02, 0.14)
		var jit = (3.0 if tg.missed else 7.0) * (1.0 - seg(a, 0.0, 0.3))
		card.rect_pivot_offset = card.rect_size / 2.0
		card.rect_position = off
		card.rect_rotation = 2.2 * off.x / 30.0
		card.rect_scale = Vector2(1.0 - sq * abs(tg.dir.x) + 0.5 * sq * abs(tg.dir.y), 1.0 - sq * abs(tg.dir.y) + 0.5 * sq * abs(tg.dir.x))
		if tg.icon != null and is_instance_valid(tg.icon):
			tg.icon.rect_position = tg.icon_home + Vector2(noise(tg.seed * 7, tick, 0), noise(tg.seed * 7 + 3, tick, 0)) * jit


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

#on the ground, over the field and under the interface: the night's veil, the bend and the cracks of broken space;
#over everything: the sphere, the sparks, the flash and the numbers
func build(kit, world):
	ground = ground_after(world)
	var under = ground != self
	night = NightSky.new()
	ground.add_child(night)
	night.fall(kit, {z = 0 if under else 80, dark = 0.36, stars = 0})
	bend = SpaceBend.new()
	bend.cover(ground, kit, {z = 0 if under else 81})
	layers.cracks = add_layer(0 if under else 87, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_cracks', null, ground)
	layers.halo = add_layer(85, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_halo')
	layers.hole = add_layer(86, -1, '_draw_hole')
	layers.fx = add_layer(88, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_fx')
	layers.flash = add_layer(90, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_flash')
	layers.numbers = add_layer(96, -1, '_draw_numbers')


#the ring of light that the bent space wraps round the sphere
func _draw_halo(layer):
	var r = sphere_r()
	if t >= det or r < 0.5: return
	var k = min(1.0, r / 10.0)
	var p = sphere_pos()
	d_blob(layer, p, r * 2.2, ABYSS[1], 0.28 * k)
	layer.draw_arc(p, r * 1.06, 0.0, TAU, 64, fade(ABYSS[1], 0.55 * k), max(2.0, r * 0.16), true)
	layer.draw_arc(p, r * 1.03, 0.0, TAU, 64, fade(PHOTON, 0.95 * k), max(1.0, r * 0.035), true)


func _draw_hole(layer):
	var r = sphere_r()
	if t >= det or r < 0.5: return
	layer.draw_circle(sphere_pos(), r, Color(0, 0, 0, 1))


func _draw_cracks(layer):
	var k = seg(t, det, det + 0.03) * (1.0 - seg(t, shat1, relax + 0.1))
	if k <= 0.01: return
	b_begin(layer)
	for pts in cracks:
		b_polyline(pts, 4.5, fade(ABYSS[1], 0.4 * k))
	for pts in cracks:
		b_polyline(pts, 1.3, fade(PHOTON, 0.9 * k))
	b_flush()


func _draw_fx(layer):
	for f in flares:
		flare(layer, f)
	for b in bursts:
		burst_sparks(layer, b, b.key)
	for d in debris:
		slivers(layer, d, d.key)


func _draw_flash(layer):
	var f = 0.8 * bump(t, det, det + 0.02, det + 0.3)
	if f > 0.004: layer.draw_rect(view.grow(160.0), fade(ABYSS[1].linear_interpolate(WHITE, 0.6), 0.35 * f))


func _draw_numbers(layer):
	counter.draw(layer, t, self)
