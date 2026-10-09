extends "res://src/combat/FxNode.gd"
#The swordsman's ults, the «Меч» entry of the «Арсенал ульт» mockup, one choreography each:
#  sheath - «Ножны»: a vanishing dash, the enemies' side fills with cuts, the swordsman is back, sheathes the blade,
#           and every cut goes off at once
#  chain  - «Цепь рывков»: from enemy to enemy with a blow at each, then a leap over the field and a giant cross
#  rend   - «Разлом»: a wind-up on the spot and one cut across the screen; time stops, cuts spread over the field, the
#           picture breaks along them and snaps back
#Each target takes one hit. The sheath and the rend show it at the final blow; the chain shows it in shares, a part at
#each dash and the rest at the cross, adding up to the real damage. The swordsman's card flies as a copy while the
#real one waits hidden in its slot. Only the rend zooms the screen in, as its mockup did.
#Knobs: the SWORD_* vars in CombatAnimations.gd.

const ScreenSlice = preload("res://src/combat/ScreenSlice.gd")
const DamageCounter = preload("res://src/combat/DamageCounter.gd")
#core, glow, deep: the mockup's steel
const STEEL = [Color(1, 1, 1), Color(0.588, 0.804, 1.0), Color(0.235, 0.431, 0.863)]
#the chain's way through the six places: zigzag between the front and the back
const CHAIN_ORDER = [0, 4, 2, 3, 1, 5]
const MAX_SHADOWS = 16

var anim = null
var variant = 'sheath'
var caster = null
var caster_alpha = 1.0
var root = null
var root_home = Vector2()
var shaking = false
var zooming = false
var root_pivot = Vector2()
var view = Rect2(0, 0, 1920, 1080)
var field = Rect2()
var home = Vector2()
var away = 1.0
#target card -> {ti, blows [{at, big}], flinch [times], shares [{at, w}] (its damage, shown in parts), missed, posed,
#icon, icon_home, seed, flash, hot}
var targets = {}
var order = []
var cuts = []
var swooshes = []
var ghosts = []
var streaks = []
var bursts = []
var kicks = []
var stops = []
var counter = DamageCounter.new()
var rng = RandomNumberGenerator.new()
var slice = null
var ground = null
var layers = {}
var real = 0.0
var hit_at = 1.0
var pose_end = 1.0
var end_t = 2.0
var stop = 0.12
var shake_px = 18.0
var hold = 0.2
var event_key = 0
#the timings of the choreography the plan_* function set
var k = {}
var steps = []
var lines = []
#the flying copy of the swordsman's card, the faded copies behind it (motion blur and afterimages), and how each is lit;
#`flying` while this effect keeps the real card hidden
var flying = false
var flyer = null
var flyer_base = Vector2()
var shadows = []
var looks = {}


static func equip(kit):
	if kit.has('sword_font'): return
	var fonts = DamageCounter.make_fonts()
	kit.sword_font = fonts.font
	kit.sword_shadow = fonts.shadow


#opts: `variant` sheath / chain / rend, `cuts` how many the sheath and the rend spread, `stop` the hit-stop at the final
#blow, `shake` the most the screen shakes, `hold` how long the queue waits after a number, `root` the node shaken,
#`world` the battlefield's last node (the dim, the broken picture and the trails go right after it, under the
#interface), `seed`. `slot_nodes` are the six places of the targets' side, whether or not anyone stands there.
func cast(new_anim, caster_node, hit_nodes, slot_nodes, kit, opts = {}):
	anim = new_anim
	caster = caster_node
	variant = str(opts.get('variant', 'sheath'))
	equip(kit)
	use_kit(kit)
	counter.font = shared.sword_font
	counter.shadow_font = shared.sword_shadow
	counter.hold = 0.45
	counter.fade_time = 0.5
	counter.pop = 0.08
	counter.slam = 0.3
	counter.slam_time = 0.3
	counter.ring = false
	counter.tremble = 0.0
	root = opts.get('root')
	if root is Control: root_home = shake_home(root)
	stop = float(opts.get('stop', 0.12))
	shake_px = float(opts.get('shake', 18.0))
	hold = float(opts.get('hold', 0.2))
	rng.seed = int(opts.get('seed', 4100))
	view = screen_rect()
	var first = true
	for node in slot_nodes:
		if node == null or !is_instance_valid(node): continue
		var r = local_rect(node)
		field = r if first else field.merge(r)
		first = false
	if first: field = view
	var cr = local_rect(caster)
	home = cr.position + cr.size / 2.0
	if caster.has_method('get_attack_vector') and caster.get_attack_vector().x < 0.0: away = -1.0
	for card in hit_nodes:
		if card == null or !card_ok(card) or targets.has(card): continue
		var icon = card.get_node_or_null('Icon')
		targets[card] = {ti = order.size(), blows = [], flinch = [], shares = [], missed = false, posed = false, icon = icon,
			icon_home = icon.rect_position if icon != null else Vector2(), seed = order.size() * 7 + 3, flash = 0.0, hot = 0.0}
		order.append(card)
	match variant:
		'chain': plan_chain(slot_nodes)
		'rend': plan_rend(int(opts.get('cuts', 14)))
		_: plan_sheath(int(opts.get('cuts', 14)))
	build(kit, opts.get('world'))
	take_off()
	set_process(true)


func target_cards():
	return targets.keys()


#the queue lets go a little before the first share of damage: the strike's sound takes a slot of its own, and the
#hp_update must be handed over before that number shows
func lock_time():
	return max(0.05, stop_to_real(stops, first_share()) - 0.1)


func first_share():
	var res = hit_at
	for card in targets:
		for s in targets[card].shares:
			res = min(res, s.at)
	return res


#--- the plans ---------------------------------------------------------------------------------------------------

func rnd():
	return rng.randf()


func next_key():
	event_key += 1
	return event_key


func centre_of(card):
	var r = local_rect(card)
	return r.position + r.size / 2.0


func field_centre():
	return field.position + field.size / 2.0


#mostly a slant of 20-65°, sometimes level, now and then nearly upright
func pick_angle():
	var r = rnd()
	if r < 0.7: return (-1.0 if rnd() < 0.5 else 1.0) * deg2rad(20.0 + 45.0 * rnd())
	if r < 0.9: return deg2rad((rnd() - 0.5) * 16.0)
	return (-1.0 if rnd() < 0.5 else 1.0) * deg2rad(75.0 + 15.0 * rnd())


#a cut through `p`: it opens from one end over `rev`, holds, and fades; or, with `det` set, dims to a `scar` and flares
#up at det
func cut_through(p, ang, length, w, t0, rev, hold_, fade_):
	var d = Vector2(cos(ang), sin(ang)) * length / 2.0
	var s = 1.0 if rnd() < 0.5 else -1.0
	return {a = p - s * d, b = p + s * d, w = w, t0 = t0, rev = rev, hold = hold_, fade = fade_, det = -1.0, scar = 1.0}


func burst(at, pos, n, ang, spread, power):
	bursts.append({at = at, pos = pos, n = n, ang = ang, spread = spread, power = power, pal = STEEL, key = next_key()})


func arc_side(a):
	return a if away > 0 else PI - a


#«Ножны»
func plan_sheath(n):
	n = max(1, n)
	var wind = 0.35
	var dash1 = wind + 0.1
	var flur0 = dash1
	var flur_dur = 0.9
	var flur1 = flur0 + flur_dur
	var back0 = flur1 + 0.04
	var back1 = back0 + 0.14
	var det = back1 + 0.42
	var dash_to = (field.position.x + 40.0 if away > 0 else field.end.x - 40.0) - home.x
	k = {wind = wind, dash1 = dash1, flur0 = flur0, flur1 = flur1, back0 = back0, back1 = back1, det = det, dash_to = dash_to}
	for i in range(n):
		var t0 = flur0 + (i + 0.3 * rnd()) * flur_dur / n
		var card = order[i % order.size()] if i < 12 and !order.empty() else null
		var p = Vector2()
		if card != null: p = centre_of(card) + Vector2((rnd() - 0.5) * 110.0, (rnd() - 0.5) * 120.0)
		else: p = Vector2(lerp(field.position.x, field.end.x, rnd()), lerp(field.position.y, field.end.y, rnd()))
		var cu = cut_through(p, pick_angle(), 300.0 + 280.0 * rnd(), 5.0 + 3.0 * rnd(), t0, 0.045, 0.05, 0.55)
		cu.det = det
		cu.scar = 0.3
		cuts.append(cu)
		ghosts.append({pos = cu.a, rot = away * (rnd() - 0.5) * 16.0, t0 = t0 - 0.03, t1 = t0 + 0.09, alpha = 0.5})
		kicks.append({at = t0, mag = 0.12, dur = 0.1})
		if card != null: targets[card].flinch.append(t0 + 0.02)
	for card in order:
		targets[card].blows.append({at = det, big = true})
		targets[card].shares.append({at = det, w = 1.0})
		burst(det, centre_of(card), 14, 0.0 if away > 0 else PI, 2.6, 1.0)
	for cu in cuts:
		burst(det, (cu.a + cu.b) / 2.0, 6, (cu.b - cu.a).angle() + PI / 2.0, 3.1, 0.7)
	kicks.append({at = det, mag = 1.4, dur = 0.6})
	streaks.append({t0 = wind + 0.02, dur = 0.2, a = home, b = home + Vector2(dash_to, 0.0)})
	stops.append({at = det + 0.03, d = stop})
	hit_at = det
	pose_end = det + 0.05
	end_t = det + 1.5


#«Цепь рывков»
func plan_chain(slot_nodes):
	var wind = 0.25
	var step = 0.17
	for s in CHAIN_ORDER:
		if s >= slot_nodes.size() or slot_nodes[s] == null or !is_instance_valid(slot_nodes[s]): continue
		var card = slot_nodes[s].get_node_or_null('Character')
		if card == null or !targets.has(card): continue
		var r = local_rect(card)
		var i = steps.size()
		steps.append({card = card, t = wind + i * step, rot = away * (7.0 if i % 2 == 1 else -7.0),
			pos = Vector2(r.position.x + r.size.x / 2.0 - away * r.size.x * 0.62, r.position.y + r.size.y / 2.0 + (rnd() - 0.5) * 36.0)})
	var n = steps.size()
	var c = field_centre()
	var leap0 = wind + n * step
	var leap1 = leap0 + 0.12
	var top = Vector2(c.x - away * 30.0, field.position.y - 30.0)
	var xcut = leap1 + 0.18
	var dive1 = xcut + 0.08
	var low = Vector2(c.x + away * 10.0, c.y + 90.0)
	var home0 = xcut + 0.3
	var home1 = home0 + 0.16
	var fin = xcut + 0.06
	k = {wind = wind, step = step, leap0 = leap0, leap1 = leap1, top = top, xcut = xcut, dive1 = dive1, low = low, home0 = home0,
		home1 = home1, fin = fin}
	for i in range(n):
		var st = steps[i]
		var cc = centre_of(st.card)
		var down = i % 2 == 0
		swooshes.append({c = Vector2(cc.x - away * 150.0, cc.y), r = 220.0, a0 = arc_side(-1.1 if down else 1.1), a1 = arc_side(1.1 if down else -1.1),
			th = 70.0, t0 = st.t + 0.02, dur = 0.07, fade = 0.22})
		for j in range(2):
			cuts.append(cut_through(cc + Vector2((rnd() - 0.5) * 60.0, (rnd() - 0.5) * 70.0), pick_angle(), 240.0 + 120.0 * rnd(), 5.0 + 2.0 * rnd(),
				st.t + 0.03 + 0.03 * j, 0.035, 0.04, 0.3))
		targets[st.card].blows.append({at = st.t + 0.05, big = false})
		#the mockup's dash blows did about 50 and the cross about 130: the real damage is split the same way
		targets[st.card].shares.append({at = st.t + 0.05, w = 0.3})
		burst(st.t + 0.05, cc, 10, 0.0 if away > 0 else PI, 2.2, 0.8)
		kicks.append({at = st.t + 0.05, mag = 0.35, dur = 0.18})
		var prev = steps[i - 1] if i > 0 else {pos = home, rot = 0.0}
		streaks.append({t0 = st.t, dur = 0.14, a = prev.pos, b = st.pos})
		if i > 0: ghosts.append({pos = prev.pos, rot = prev.rot, t0 = st.t - 0.001, t1 = st.t + 0.26, alpha = 0.55})
	var X = 470.0
	var Y = 330.0
	cuts.append({a = Vector2(c.x - away * X, c.y - Y), b = Vector2(c.x + away * X, c.y + Y), w = 13.0, t0 = xcut, rev = 0.06, hold = 0.12,
		fade = 0.5, det = -1.0, scar = 1.0})
	cuts.append({a = Vector2(c.x + away * X, c.y - Y), b = Vector2(c.x - away * X, c.y + Y), w = 13.0, t0 = xcut + 0.05, rev = 0.06, hold = 0.1,
		fade = 0.5, det = -1.0, scar = 1.0})
	swooshes.append({c = Vector2(c.x - away * 380.0, c.y), r = 560.0, a0 = arc_side(-0.9), a1 = arc_side(0.9), th = 150.0, t0 = xcut, dur = 0.1, fade = 0.35})
	for card in order:
		var tg = targets[card]
		tg.blows.append({at = fin, big = true})
		tg.shares.append({at = fin, w = 1.0 if tg.shares.empty() else 0.7})
		burst(fin, centre_of(card), 14, PI / 2.0, 3.2, 1.0)
	kicks.append({at = fin, mag = 1.3, dur = 0.55})
	var last = steps.back() if n > 0 else {pos = home, rot = 0.0}
	streaks.append({t0 = leap0, dur = 0.16, a = last.pos, b = top})
	if n > 0: ghosts.append({pos = last.pos, rot = last.rot, t0 = leap0, t1 = leap0 + 0.26, alpha = 0.55})
	streaks.append({t0 = home0, dur = 0.2, a = low, b = home})
	stops.append({at = fin + 0.03, d = stop})
	hit_at = fin
	pose_end = home1 + 0.2
	end_t = home1 + 1.2


#«Разлом»
func plan_rend(n):
	var wind = 0.55
	var strike = wind
	var freeze0 = strike + 0.06
	var extra_n = max(0, n - 1)
	var cut_gap = 0.03
	var extra0 = freeze0 + 0.06
	var split0 = extra0 + extra_n * cut_gap + 0.1
	var snap = split0 + 0.45
	var back1 = snap + 0.35
	var c = field_centre()
	k = {wind = wind, strike = strike, freeze0 = freeze0, split0 = split0, snap = snap, back1 = back1}
	var y_l = c.y + 80.0
	var y_r = c.y - 90.0
	var x_near = view.position.x - 60.0
	var x_far = view.end.x + 60.0
	var main = {w = 14.0, t0 = strike, rev = 0.07, hold = 99.0, fade = 0.45, det = snap, scar = 0.85}
	main.a = Vector2(x_near if away > 0 else x_far, y_l)
	main.b = Vector2(x_far if away > 0 else x_near, y_r)
	cuts.append(main)
	swooshes.append({c = Vector2(view.position.x + view.size.x / 2.0, c.y + 2400.0), r = 2450.0, a0 = -PI / 2.0 - away * 0.47,
		a1 = -PI / 2.0 + away * 0.47, th = 120.0, t0 = strike, dur = 0.08, fade = 0.4})
	lines = [main]
	for j in range(extra_n):
		var p = Vector2(lerp(field.position.x, field.end.x, 0.1 + 0.8 * rnd()), lerp(field.position.y, field.end.y, 0.1 + 0.8 * rnd()))
		var cu = cut_through(p, pick_angle(), 360.0 + 280.0 * rnd(), 6.0, extra0 + j * cut_gap, 0.03, 99.0, 0.45)
		cu.det = snap
		cu.scar = 0.85
		cuts.append(cu)
		if lines.size() < ScreenSlice.MAX_LINES: lines.append(cu)
	for card in order:
		targets[card].blows.append({at = snap, big = true})
		targets[card].shares.append({at = snap, w = 1.0})
		burst(snap, centre_of(card), 14, 0.0 if away > 0 else PI, 2.8, 1.0)
	for cu in cuts:
		burst(snap, cu.a.linear_interpolate(cu.b, 0.5), 5, (cu.b - cu.a).angle() + PI / 2.0, 3.1, 0.7)
	kicks.append({at = strike, mag = 0.6, dur = 0.3})
	kicks.append({at = snap, mag = 1.5, dur = 0.65})
	stops.append({at = snap + 0.03, d = stop})
	hit_at = snap
	pose_end = back1
	end_t = back1 + 1.1


#--- the curves of each plan -------------------------------------------------------------------------------------

#where the swordsman's card is at `tau`, from its own place: {x, y, rot, sx, sy, alpha, flash, glint, glint_k, blur, blur_n}
func pose_at(tau):
	var m = {x = 0.0, y = 0.0, rot = 0.0, sx = 1.0, sy = 1.0, alpha = 1.0, flash = 0.0, glint = 0.0, glint_k = 0.5, blur = Vector2(), blur_n = 0}
	match variant:
		'chain': pose_chain(m, tau)
		'rend': pose_rend(m, tau)
		_: pose_sheath(m, tau)
	return m


func pose_sheath(m, tau):
	if tau < k.wind:
		var q = out_quad(tau / k.wind)
		m.x = -18.0 * away * q
		m.y = 4.0 * q
		m.rot = -4.0 * away * q
		m.glint = seg(tau, 0.3 * k.wind, k.wind)
		m.glint_k = m.glint
	elif tau < k.dash1:
		var q = seg(tau, k.wind, k.dash1)
		q *= q
		m.x = lerp(-18.0 * away, k.dash_to, q)
		m.y = 4.0 * (1.0 - q)
		m.sx = 1.0 + 0.25 * q
		m.sy = 1.0 - 0.08 * q
		m.alpha = 1.0 - seg(q, 0.6, 1.0)
		m.blur = Vector2(away * 160.0 * q, 0.0)
		m.blur_n = 5
	elif tau < k.back0:
		m.alpha = 0.0
	elif tau < k.back1:
		var q = out_cubic(seg(tau, k.back0, k.back1))
		m.x = 70.0 * away * (1.0 - q)
		m.rot = 3.0 * away * (1.0 - q)
		m.alpha = q
		m.flash = 0.7 * (1.0 - q)
		m.blur = Vector2(-away * 90.0 * (1.0 - q), 0.0)
		m.blur_n = 4
	else:
		m.rot = -1.5 * away * (1.0 - seg(tau, k.back1, k.det))
		m.glint = bump(tau, k.det - 0.14, k.det - 0.05, k.det + 0.02)
		m.glint_k = seg(tau, k.det - 0.14, k.det)


func pose_chain(m, tau):
	var off = Vector2()
	if tau < k.wind:
		var q = out_quad(tau / k.wind)
		m.x = -14.0 * away * q
		m.rot = -3.0 * away * q
		m.glint = seg(tau, 0.3 * k.wind, k.wind)
		m.glint_k = m.glint
		return
	if tau < k.leap0 and !steps.empty():
		var st = steps[int(clamp(floor((tau - k.wind) / k.step), 0, steps.size() - 1))]
		var loc = tau - st.t
		var arrive = out_cubic(seg(loc, 0.0, 0.05))
		off = Vector2(st.pos.x + away * 16.0 * (1.0 - arrive), st.pos.y) - home
		m.rot = st.rot * (0.6 + 0.4 * bump(loc, 0.02, 0.06, 0.14))
		m.sx = 1.08 - 0.08 * arrive
		m.sy = m.sx
		m.flash = 0.35 * (1.0 - arrive)
	elif tau < k.leap1:
		var last = steps.back() if !steps.empty() else {pos = home, rot = 0.0}
		var q = out_cubic(seg(tau, max(k.leap0, k.wind), k.leap1))
		off = Vector2(lerp(last.pos.x, k.top.x, q), lerp(last.pos.y, k.top.y, q) - 60.0 * sin(PI * q)) - home
		m.rot = lerp(last.rot, -away * 12.0, q)
		m.blur = (k.top - last.pos) * 0.25
		m.blur_n = 4
	elif tau < k.xcut:
		off = Vector2(k.top.x, k.top.y + 3.0 * sin((tau - k.leap1) * 30.0)) - home
		m.rot = -away * 12.0
		m.glint = seg(tau, k.leap1, k.xcut)
		m.glint_k = m.glint
	elif tau < k.dive1:
		var q = seg(tau, k.xcut, k.dive1)
		q *= q
		off = k.top.linear_interpolate(k.low, q) - home
		m.rot = -away * 12.0 + away * 30.0 * q
		m.blur = (k.low - k.top) * 0.3
		m.blur_n = 5
	elif tau < k.home0:
		off = k.low - home
		m.rot = away * 18.0 * (1.0 - seg(tau, k.dive1, k.home0))
	elif tau < k.home1:
		var q = inout_quad(seg(tau, k.home0, k.home1))
		off = k.low.linear_interpolate(home, q) - home
		m.alpha = 1.0 - 0.4 * sin(PI * q)
		m.blur = (home - k.low) * 0.2
		m.blur_n = 4
	else:
		m.y = -3.0 * bump(tau, k.home1, k.home1 + 0.05, k.home1 + 0.2)
		return
	m.x = off.x
	m.y = off.y


func pose_rend(m, tau):
	if tau < k.wind:
		var q = inout_quad(tau / k.wind)
		m.x = -34.0 * away * q
		m.y = 3.0 * q
		m.rot = -6.0 * away * q
		m.glint = seg(tau, 0.35 * k.wind, k.wind)
		m.glint_k = 0.82
	elif tau < k.snap:
		var q = out_cubic(seg(tau, k.strike, k.strike + 0.06))
		m.x = lerp(-34.0, 70.0, q) * away
		m.rot = lerp(-6.0, 5.0, q) * away
		if tau < k.strike + 0.08:
			m.blur = Vector2(away * 110.0, 0.0)
			m.blur_n = 4
	else:
		var q = inout_quad(seg(tau, k.snap, k.back1))
		m.x = 70.0 * away * (1.0 - q)
		m.rot = 5.0 * away * (1.0 - q)


#how fast the swordsman is moving (the speed lines), and which way
func speed_at(tau):
	match variant:
		'chain':
			return max(max(0.35 * seg(tau, k.wind, k.wind + 0.05) * (1.0 - seg(tau, k.leap0, k.leap0 + 0.05)), bump(tau, k.leap0, k.leap0 + 0.04, k.leap1 + 0.05)),
				max(bump(tau, k.xcut, k.xcut + 0.03, k.dive1 + 0.1), 0.7 * bump(tau, k.home0, k.home0 + 0.04, k.home1 + 0.05)))
		'rend':
			return bump(tau, k.strike - 0.02, k.strike + 0.03, k.strike + 0.22)
	return max(bump(tau, k.wind, k.wind + 0.05, k.dash1 + 0.12), 0.55 * bump(tau, k.back0, k.back0 + 0.03, k.back1))


func speed_dir(tau):
	match variant:
		'chain': return away if tau < k.home0 else -away
		'rend': return away
	return away if tau < k.flur1 else -away


func flash_at(tau):
	match variant:
		'chain':
			var f = 0.9 * bump(tau, k.fin, k.fin + 0.015, k.fin + 0.22)
			for st in steps:
				f = max(f, 0.14 * bump(tau, st.t + 0.05, st.t + 0.06, st.t + 0.16))
			return f
		'rend':
			return max(0.55 * bump(tau, k.strike, k.strike + 0.02, k.strike + 0.18), bump(tau, k.snap, k.snap + 0.015, k.snap + 0.24))
	return max(0.9 * bump(tau, k.det, k.det + 0.015, k.det + 0.2), 0.12 * bump(tau, k.wind, k.dash1, k.dash1 + 0.1))


func dim_at(tau):
	match variant:
		'chain': return 0.25 * seg(tau, k.leap1, k.leap1 + 0.06) * (1.0 - seg(tau, k.xcut, k.xcut + 0.05))
		'rend': return 0.3 * seg(tau, 0.2 * k.wind, k.wind) * (1.0 - seg(tau, k.strike, k.strike + 0.1))
	return 0.32 * seg(tau, k.back1, k.back1 + 0.12) * (1.0 - seg(tau, k.det, k.det + 0.04))


#the rend's stopped time and broken picture
func desat_at(tau):
	if variant != 'rend': return 0.0
	return seg(tau, k.freeze0, k.freeze0 + 0.08) * (1.0 - seg(tau, k.snap, k.snap + 0.04))


func split_at(tau):
	if variant != 'rend' or tau < k.split0 or tau >= k.snap: return null
	var q = out_cubic(seg(tau, k.split0, k.split0 + 0.2))
	return {slide = 38.0 * q, gap = 10.0 * q, glow = q}


#the rend's screen pushes in on the targets' side during the wind-up and kicks in further on the snap; the sheath and
#the chain keep the camera still
func zoom_at(tau):
	if variant != 'rend': return 1.0
	return 1.0 + 0.02 * seg(tau, 0.0, k.wind) * (1.0 - seg(tau, k.strike, k.strike + 0.1)) + 0.04 * bump(tau, k.snap, k.snap + 0.03, k.snap + 0.45)


#--- the damage --------------------------------------------------------------------------------------------------

#how long from now until the target's first share of damage lands
func hit_delay(node):
	var tg = targets.get(node)
	if tg == null: return 0.0
	return max(0.0, stop_to_real(stops, tg.shares[0].at if !tg.shares.empty() else hit_at) - real)


#The target's hp_update, handed over: its number runs up share by share. Returns how long the queue waits - for the
#number, and for the swordsman to be home: nothing else may play on his card while a copy of it is out.
func take_hit(node, args, crit):
	var tg = targets.get(node)
	if tg == null or tg.missed: return 0.2
	var ticks = []
	var weights = []
	for s in tg.shares:
		ticks.append(s.at)
		weights.append(s.w)
	if ticks.empty():
		ticks.append(hit_at)
		weights.append(1.0)
	var c = counter.start(node, args, crit, ticks, weights, t)
	if anim != null and is_instance_valid(anim): anim.damage_flash(node, hit_delay(node))
	return max(0.1, max(stop_to_real(stops, c.done) + hold, stop_to_real(stops, pose_end)) - real)


#how much longer a card's number runs, in real time; its death waits for it
func counter_left(node):
	var c = counter.counters.get(node)
	if c == null or c.finished: return 0.0
	return max(0.0, stop_to_real(stops, c.done) - real)


#the target got away: the final blow only rocks it
func missed(node):
	var tg = targets.get(node)
	if tg != null: tg.missed = true


#--- the clock ---------------------------------------------------------------------------------------------------

func _process(delta):
	var rate = 1.0
	if anim != null and is_instance_valid(anim) and anim.get('rate') != null: rate = anim.rate
	real += delta * rate
	t = stop_to_anim(stops, real)
	tau = t
	counter.update(t)
	fly()
	pose_targets()
	apply_shake()
	apply_zoom()
	if slice != null:
		var sp = split_at(t)
		if sp == null: slice.levels(desat_at(t))
		else: slice.levels(desat_at(t), lines, sp.slide, sp.gap, sp.glow, STEEL[1])
	for key in layers:
		layers[key].update()
	if t >= max(end_t, counter.gone_time()): queue_free()


func apply_shake():
	if !(root is Control) or !is_instance_valid(root): return
	var off = kick_shake(kicks, stops, real, shake_px)
	if off == Vector2():
		if shaking: root.rect_position = root_home
		shaking = false
		return
	shaking = true
	root.rect_position = root_home + off


#the whole combat screen scales round the middle of the targets' side, the way the mockup's view did
func apply_zoom():
	if !(root is Control) or !is_instance_valid(root): return
	var z = zoom_at(t)
	if abs(z - 1.0) < 0.0005:
		if zooming: unzoom()
		return
	if !zooming:
		zooming = true
		root_pivot = root.rect_pivot_offset
		root.rect_pivot_offset = field_centre()
	root.rect_scale = Vector2(z, z)


func unzoom():
	zooming = false
	if !(root is Control) or !is_instance_valid(root): return
	root.rect_scale = Vector2(1, 1)
	root.rect_pivot_offset = root_pivot


func _exit_tree():
	counter.finish_all()
	for card in targets:
		if targets[card].posed: rest_card(card, targets[card])
	land()
	if shaking and root is Control and is_instance_valid(root): root.rect_position = root_home
	if zooming: unzoom()
	if ground != null and ground != self and is_instance_valid(ground): ground.queue_free()


#--- the swordsman's card ----------------------------------------------------------------------------------------

#The real card stays in its slot, hidden - target picking and turn highlighting look for it there - and a copy of it
#flies, under the interface, with the afterimages behind it
func take_off():
	if caster == null or !is_instance_valid(caster): return
	var host = caster_host()
	if host == null: return
	#a flight of the same swordsman still on its way home lands now: two flights would hide and show his card in
	#turn, and the later one would take the hidden card for its rest look
	for other in get_parent().get_children():
		if other != self and other.get('flying') == true and other.get('caster') == caster: other.land()
	caster_alpha = caster.modulate.a
	#the card rests at zero inside its slot (CombatAnimations.card_home), so its home is the slot's corner
	var slot = caster.get_parent()
	var at = slot.get_global_transform().xform(Vector2()) if slot is Control else caster.rect_global_position
	flyer_base = host.get_global_transform().affine_inverse().xform(at)
	flyer = copy_card(host)
	caster.modulate.a = 0.0
	flying = true
	fly()


func caster_host():
	if root != null and is_instance_valid(root) and root is Control: return root
	return get_parent() if get_parent() is Control else null


func copy_card(host):
	var copy = caster.duplicate(0)
	copy.name = 'SwordFlight'
	quiet(copy)
	if ground != null and ground != self and is_instance_valid(ground) and ground.get_parent() == host: host.add_child_below_node(ground, copy)
	else: host.add_child(copy)
	copy.rect_pivot_offset = copy.rect_size / 2.0
	copy.rect_position = flyer_base
	copy.rect_scale = Vector2(1, 1)
	copy.rect_rotation = 0.0
	copy.modulate = Color(1, 1, 1, 1)
	var over = Node2D.new()
	over.material = blend(CanvasItemMaterial.BLEND_MODE_ADD)
	copy.add_child(over)
	over.connect('draw', self, '_draw_over', [over, copy])
	looks[copy] = {flash = 0.0, glint = 0.0, glint_k = 0.5, over = over}
	return copy


func quiet(node):
	if node is Control: node.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for child in node.get_children():
		quiet(child)


#the faded copies: copy_card puts each right after the ground, so behind the flying one
func shadow(i):
	while shadows.size() <= i:
		if shadows.size() >= MAX_SHADOWS: return null
		var host = caster_host()
		if host == null: return null
		shadows.append(copy_card(host))
	return shadows[i]


func fly():
	if flyer == null or !is_instance_valid(flyer): return
	if t >= pose_end:
		land()
		return
	var m = pose_at(t)
	var used = 0
	for gh in ghosts:
		if t < gh.t0 or t > gh.t1: continue
		var a = bump(t, gh.t0, gh.t0 + (gh.t1 - gh.t0) * 0.25, gh.t1) * gh.alpha
		if a <= 0.01: continue
		place(shadow(used), gh.pos - home, gh.rot, Vector2(1, 1), a, 0.55, 0.0, 0.5)
		used += 1
	if m.alpha > 0.01:
		for i in range(m.blur_n, 0, -1):
			var back = m.blur * float(i) / m.blur_n
			place(shadow(used), Vector2(m.x, m.y) - back, m.rot, Vector2(m.sx, m.sy), m.alpha * 0.18 * (1.0 - float(i) / (m.blur_n + 1)), 0.5, 0.0, 0.5)
			used += 1
	for j in range(used, shadows.size()):
		if is_instance_valid(shadows[j]): shadows[j].visible = false
	place(flyer, Vector2(m.x, m.y), m.rot, Vector2(m.sx, m.sy), m.alpha, m.flash, m.glint, m.glint_k)


func place(copy, off, rot, scale, alpha, flash, glint, glint_k):
	if copy == null or !is_instance_valid(copy): return
	copy.visible = alpha > 0.01
	copy.rect_position = flyer_base + off
	copy.rect_rotation = rot
	copy.rect_scale = scale
	copy.modulate = Color(1, 1, 1, clamp(alpha, 0.0, 1.0))
	var look = looks.get(copy)
	if look == null: return
	look.flash = flash
	look.glint = glint
	look.glint_k = glint_k
	look.over.update()


#back in its slot: the real card shows again, the copies go; only once, and only by the flight that hid it
func land():
	if flying and caster != null and is_instance_valid(caster): caster.modulate.a = caster_alpha
	flying = false
	for copy in [flyer] + shadows:
		if copy != null and is_instance_valid(copy): copy.queue_free()
	flyer = null
	shadows.clear()
	looks.clear()


#a copy's light: the white-hot flash over the whole card, and the sheen running along a drawn blade
func _draw_over(over, copy):
	var look = looks.get(copy)
	if look == null or !is_instance_valid(copy): return
	var size = copy.rect_size
	if look.flash > 0.01: over.draw_rect(Rect2(Vector2(), size), fade(STEEL[1].linear_interpolate(WHITE, 0.3), 0.8 * look.flash))
	if look.glint <= 0.01: return
	var turn = Transform2D(-0.6, size / 2.0)
	var x = lerp(-190.0, 190.0, look.glint_k)
	var clip = rect_points(Rect2(Vector2(4, 4), size - Vector2(8, 8)))
	for half in [[x - 24.0, x], [x, x + 24.0]]:
		var band = PoolVector2Array([turn.xform(Vector2(half[0], -220.0)), turn.xform(Vector2(half[1], -220.0)),
			turn.xform(Vector2(half[1], 220.0)), turn.xform(Vector2(half[0], 220.0))])
		for poly in Geometry.intersect_polygons_2d(band, clip):
			var cols = PoolColorArray()
			for p in poly:
				var u = min(1.0, abs(turn.affine_inverse().xform(p).x - x) / 24.0)
				cols.append(fade(STEEL[0].linear_interpolate(STEEL[1], u), 0.85 * look.glint * (1.0 - u)))
			over.draw_polygon(poly, cols)


#--- the targets -------------------------------------------------------------------------------------------------

#each blow throws the card along it with an elastic rebound, squashed a little and flashing white-hot; a cut over the
#card only makes it flinch
func pose_targets():
	var tick = floor(t * 60.0)
	for card in targets:
		var tg = targets[card]
		if !is_instance_valid(card): continue
		var off = Vector2()
		var sq = 0.0
		var fl = 0.0
		var hot = 0.0
		var jit = 0.0
		var busy = false
		for b in tg.blows:
			var a = t - b.at
			if a < 0.0 or a > 0.9: continue
			busy = true
			var soft = tg.missed
			var kb = 10.0 if soft else (30.0 if b.big else 16.0)
			var spring = out_quad(a / 0.035) if a < 0.035 else exp(-(a - 0.035) * 7.0) * cos((a - 0.035) * 13.0)
			off += Vector2(away, 0.0) * kb * spring
			jit = max(jit, (3.0 if soft else (7.0 if b.big else 4.0)) * (1.0 - seg(a, 0.0, 0.3 if b.big else 0.18)))
			if soft: continue
			sq = max(sq, (0.12 if b.big else 0.07) * bump(a, 0.0, 0.02, 0.14))
			fl = max(fl, (0.72 if b.big else 0.55) * bump(a, 0.0, 0.012, 0.28 if b.big else 0.16))
			if a < 0.04: hot = max(hot, 1.0 if b.big else 0.8)
		for f in tg.flinch:
			var a = t - f
			if a < 0.0 or a >= 0.14: continue
			busy = true
			fl = max(fl, 0.25 * (1.0 - a / 0.14))
			jit = max(jit, 3.0)
		tg.flash = fl
		tg.hot = hot
		if !busy:
			if tg.posed: rest_card(card, tg)
			continue
		tg.posed = true
		if off.length() > 70.0: off = off.normalized() * 70.0
		card.rect_pivot_offset = card.rect_size / 2.0
		card.rect_position = off
		card.rect_rotation = 2.2 * off.x / 30.0
		card.rect_scale = Vector2(1.0 - sq, 1.0 + 0.5 * sq)
		if tg.icon != null and is_instance_valid(tg.icon):
			tg.icon.rect_position = tg.icon_home + Vector2(noise(tg.seed * 7, tick, 0), noise(tg.seed * 7 + 3, tick, 0)) * jit


#a card rests at zero inside its slot (CombatAnimations.card_home)
func rest_card(card, tg):
	tg.posed = false
	tg.flash = 0.0
	if !is_instance_valid(card): return
	card.rect_position = Vector2()
	card.rect_rotation = 0.0
	card.rect_scale = Vector2(1, 1)
	if tg.icon != null and is_instance_valid(tg.icon): tg.icon.rect_position = tg.icon_home


#--- layers ------------------------------------------------------------------------------------------------------

#on the ground, over the field and under the interface: the dim, the drained and broken picture, the speed lines and
#the dash trails, with the flying card right after them; over everything: the swings, the cuts, the sparks, the flash
#and the numbers
func build(kit, world):
	ground = ground_after(world)
	var under = ground != self
	layers.dim = add_layer(0 if under else 79, -1, '_draw_dim', null, ground)
	if variant == 'rend':
		slice = ScreenSlice.new()
		slice.cover(ground, kit, {z = 0 if under else 80})
	layers.trail = add_layer(0 if under else 81, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_trail', null, ground)
	layers.fx = add_layer(88, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_fx')
	layers.flash = add_layer(90, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_flash')
	layers.numbers = add_layer(96, -1, '_draw_numbers')


func _draw_dim(layer):
	var a = dim_at(t)
	if a > 0.005: layer.draw_rect(view.grow(160.0), Color(0, 0, 0, a))


func _draw_trail(layer):
	b_begin(layer)
	var level = speed_at(t)
	if level > 0.01:
		var dir = speed_dir(t)
		for i in range(28):
			var y = view.position.y + 20.0 + (view.size.y - 40.0) * hash01(i + 1200)
			var length = 220.0 + 420.0 * hash01(i + 1201)
			var run = fposmod(hash01(i + 1203) + real * (2600.0 + 1800.0 * hash01(i + 1202)) / 2600.0, 1.0) * 2600.0
			var x = view.position.x + (run - 340.0 if dir > 0 else 2260.0 - run)
			b_line(Vector2(x, y), Vector2(x - dir * length, y), 1.0 + 2.0 * hash01(i + 1205), fade(STEEL[0], 0.16 * level * (0.5 + 0.5 * hash01(i + 1204))))
	for s in streaks:
		var a = t - s.t0
		if a < 0.0 or a > s.dur: continue
		var q = a / s.dur
		b_line(s.a, s.b, 26.0 * (1.0 - q) + 1.0, fade(STEEL[1], 0.35 * (1.0 - q)))
		b_line(s.a, s.b, 3.0 * (1.0 - q) + 0.5, fade(STEEL[0], 0.8 * (1.0 - q)))
	b_flush()


func _draw_fx(layer):
	for card in targets:
		var tg = targets[card]
		if tg.flash <= 0.01 or !is_instance_valid(card): continue
		card_space(layer, card)
		layer.draw_rect(Rect2(Vector2(), card.rect_size), fade(STEEL[1].linear_interpolate(WHITE, tg.hot), 0.8 * tg.flash))
	screen_space(layer)
	b_begin(layer)
	for s in swooshes:
		var a = t - s.t0
		if a < 0.0 or a > s.dur + s.fade: continue
		var head = out_cubic(clamp(a / s.dur, 0.0, 1.0))
		var life = 1.0 - seg(a, s.dur, s.dur + s.fade)
		b_crescent(s.c, s.r, s.a0, s.a1, max(0.0, head - 0.8 + 0.6 * (1.0 - life)), head, s.th, life, STEEL)
	for cu in cuts:
		draw_cut(cu)
	b_flush()
	for b in bursts:
		burst_sparks(layer, b, b.key)


func draw_cut(cu):
	var a = t - cu.t0
	if a < 0.0: return
	var head = cu.a.linear_interpolate(cu.b, out_cubic(clamp(a / cu.rev, 0.0, 1.0)))
	var life = 0.0
	var tail = 0.0
	if cu.det >= 0.0:
		if t < cu.det: life = lerp(1.0, cu.scar, seg(a, cu.rev + 0.09, cu.rev + 0.29))
		else:
			var q = t - cu.det
			life = lerp(cu.scar, 1.8, q / 0.06) if q < 0.06 else 1.8 * (1.0 - seg(q, 0.06, cu.fade))
	else:
		var q = seg(a, cu.rev + cu.hold, cu.rev + cu.hold + cu.fade)
		life = 1.0 - q
		tail = q * q
	if life <= 0.01: return
	#a dying cut retracts from its start, so it thins out towards the tip
	var from = cu.a.linear_interpolate(head, tail * 0.7)
	var w = cu.w * min(1.8, life)
	var al = min(1.0, life)
	b_needle(from, head, w * 7.0, fade(STEEL[1], 0.1 * al))
	b_needle(from, head, w * 2.6, fade(STEEL[1], 0.5 * al))
	b_needle(from, head, w, fade(STEEL[0], al))


func _draw_flash(layer):
	var f = flash_at(t)
	if f > 0.004: layer.draw_rect(view.grow(160.0), fade(STEEL[1].linear_interpolate(WHITE, 0.6), 0.35 * f))


func _draw_numbers(layer):
	counter.draw(layer, t, self)
