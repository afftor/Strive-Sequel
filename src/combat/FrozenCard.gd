extends "res://src/combat/FxNode.gd"
#A fighter card sealed in ice. It freezes in one stroke and holds, mist sinking off it and twinkles in it, until it
#bursts off the card (cracks, pieces flung away) or thaws. Winds of Hyperborea drives it with its own clock and draws
#it over the whole field; the Frozen status lets it run on its own inside the card.

const THAW = 0.6
#a blow that landed this long before the status went is the blow that broke the ice
const HIT_WINDOW = 0.35
#how long it waits for a blow still in the queue before it thaws anyway
const WAIT_CAP = 4.0

var card = null
var anim = null
var under = null
var layers = []
var statics = []
var art = null
var tex = null
var src = Rect2()
var portrait = Rect2(7, 27, 168, 143)
#the picture inside it, as the Icon draws it
var pic = Rect2(7, 27, 168, 143)
var card_size = Vector2(182, 202)
var art_seed = 7300
var windward = 1.0
var fling = Vector2(1, 0)
var own_fx = true
var frost_key = ''
var frosted = false
var fs = null
var drawn_tau = -1.0
var freeze_t = 0.0
var break_t = INF
var thaw_t = INF
var end_t = INF
var releasing = false
var release_t = 0.0
var hit_t = -INF
var flares = []
var sparks = []
var debris = []


#opts: `seed` and `windward` shape the ice; `host` puts its layers under that node at z..z+5 instead of inside the
#card; `driven` leaves the clock to the host's advance(); `at` is when it freezes, `fling` where the pieces fly; `fx`
#gives it its own flare and sparks
func seal(node, kit, opts = {}):
	card = node
	use_kit(kit)
	art_seed = int(opts.get('seed', 7300))
	windward = float(opts.get('windward', 1.0))
	fling = opts.get('fling', Vector2(windward, 0.0))
	own_fx = opts.get('fx', true)
	anim = opts.get('anim')
	freeze_t = float(opts.get('at', 0.0))
	var icon = node.get_node_or_null('Icon')
	card_size = node.rect_size
	if icon != null:
		portrait = Rect2(icon.rect_position, icon.rect_size)
		if icon.texture != null:
			tex = icon.texture
			var shown = texture_placement(icon)
			pic = Rect2(icon.rect_position + shown.rect.position, shown.rect.size)
			src = shown.region
	art = frozen_art()
	frost_key = 'card_frost_%d_%d' % [art_seed, int(windward)]
	var host = opts.get('host')
	var back = self
	var z = int(opts.get('z', 0))
	var dz = 1 if host != null else 0
	if host == null:
		#inside the card the tint of the portrait goes between the portrait and the frame, the ice over the frame and
		#under the status icons
		under = Node2D.new()
		under.show_behind_parent = true
		node.add_child(under)
		node.move_child(under, icon.get_index() + 1 if icon != null else 0)
		node.add_child(self)
		var buffs = node.get_node_or_null('Buffs')
		if buffs != null: node.move_child(self, buffs.get_index())
		back = under
	else:
		host.add_child(self)
	set_process(!opts.get('driven', false))
	var desat = add_layer(z, -1, '_draw_warm_up', shared.desat, back)
	var bands = add_layer(z + dz, -1, '_draw_nothing', null, back)
	layers = [add_layer(z + 2 * dz, CanvasItemMaterial.BLEND_MODE_MUL, '_draw_mul', null, back),
		add_layer(z + 3 * dz, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_add', null, back),
		add_layer(z + 4 * dz, -1, '_draw_top', shared.cover, self), add_layer(z + 5 * dz, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_glow', null, self)]
	statics = [static_node(desat, '_draw_desat', null), static_node(bands, '_draw_bands', null),
		static_node(layers[2], '_draw_ice', null), static_node(layers[3], '_draw_spec', null)]
	if own_fx:
		var c = portrait.position + portrait.size / 2.0
		var gust = 0.0 if windward > 0.0 else PI
		flares.append(new_flare(c, gust, freeze_t, 34.0, 0.16, art_seed + 120, 10, ICE, false, true))
		sparks.append({at = freeze_t, pos = c, n = 14, ang = gust, spread = 2.6, power = 0.8, pal = ICE})
	bake(frost_key, Vector2(portrait.size.x * 2.0 + 16.0, portrait.size.y), false, '_bake_card')


func _process(delta):
	var rate = 1.0
	if anim != null and is_instance_valid(anim) and anim.get('rate') != null: rate = anim.rate
	advance(t + delta * rate)


func _exit_tree():
	if under != null and is_instance_valid(under): under.queue_free()
	under = null


#one step of its clock: the host's clock in the spell, its own under the status
func advance(time):
	t = time
	tau = time
	bake_step()
	if !frosted and shared.baked.has(frost_key):
		frosted = true
		statics[2].update()
	if releasing and break_t == INF and thaw_t == INF and t - release_t > WAIT_CAP: melt()
	fs = state()
	place()
	if tau != drawn_tau:
		drawn_tau = tau
		for layer in layers:
			layer.update()
	if tau >= end_t: queue_free()


func state():
	if tau < freeze_t: return null
	var t1 = break_t - 0.02
	var t2 = break_t + 0.1
	var k = out_cubic(seg(tau, freeze_t, freeze_t + 0.12))
	var o = (1.0 - seg(tau, t1, t2)) * (1.0 - seg(tau, thaw_t, thaw_t + THAW))
	return {k = k, out = o, ice = k * o, t0 = freeze_t, t1 = t1, t2 = t2}


#what is drawn once follows the card and fades with the ice
func place():
	var shown = fs != null and fs.ice > 0.01 and card_ok(card)
	for node in statics:
		node.visible = shown
		if shown:
			node.transform = node.get_parent().get_global_transform().affine_inverse() * card.get_global_transform()
			node.modulate.a = fs.ice


func burst_at(time, dir = null):
	break_t = time
	end_t = time + 1.0
	if dir != null: fling = dir
	if !own_fx: return
	var ang = fling.angle()
	flares.append(new_flare(art.crack_at, ang, time, 46.0, 0.2, art_seed + 100, 10, ICE, false, true))
	sparks.append({at = time, pos = art.crack_at, n = 22, ang = ang, spread = 2.2, power = 1.3, pal = ICE})
	debris.append({pos = art.crack_at, t0 = time, n = 16, ang = ang, spread = 1.6, power = 1.4, size = 8.0})


func melt():
	thaw_t = t
	end_t = t + THAW


#--- under a status: the queue tells it about the blows, the status tells it when to go ---------------------------

#a blow whose damage shows `delay` from now; `broken` when the status went with it
func hit(delay, broken = false):
	hit_t = max(hit_t, t + max(0.0, delay))
	if break_t < INF or (thaw_t < INF and t >= thaw_t + 0.6 * THAW): return
	if broken or releasing: burst_at(hit_t)


#the status is gone: a blow that has just landed or is still coming bursts the ice, otherwise it thaws
func release(hit_coming):
	if releasing or break_t < INF or thaw_t < INF: return
	releasing = true
	release_t = t
	if hit_t > t - HIT_WINDOW: burst_at(max(t, hit_t))
	elif !hit_coming: melt()


#the status holds on; false when the ice is already going and a new one has to take its place
func keep():
	if break_t < INF or thaw_t < INF: return false
	releasing = false
	return true


#--- the ice, rolled once ------------------------------------------------------------------------------------------

func frozen_art():
	var r = RandomNumberGenerator.new()
	r.seed = art_seed
	var W = card_size.x
	var H = card_size.y
	var cap = []
	for i in range(23):
		cap.append(Vector2(-4.0 + (W + 8.0) * i / 22.0, (4.0 + 7.0 * r.randf()) * pow(sin(PI * i / 22.0), 0.35)))
	var icicles = []
	for i in range(7):
		if r.randf() < 0.3: continue
		var big = r.randf() < 0.2
		icicles.append({x = 10.0 + (W - 20.0) * (i + 0.2 + 0.6 * r.randf()) / 7.0,
			len = 16.0 + 12.0 * r.randf() if big else 5.0 + 10.0 * r.randf(),
			w = 2.4 + 0.8 * r.randf() if big else 1.2 + r.randf(),
			lean = (r.randf() - 0.5) * 0.08, ph = TAU * r.randf()})
	var shards = []
	for i in range(12):
		var m = 3 + int(r.randf() * 3.0)
		var s = 8.0 + 14.0 * r.randf()
		var pts = []
		for k in range(m):
			var an = TAU * (k + 0.3 * r.randf()) / m
			pts.append(Vector2(cos(an) * s * (0.6 + 0.5 * r.randf()), sin(an) * s * (0.6 + 0.5 * r.randf())))
		shards.append({pos = Vector2(W * r.randf(), H * r.randf()), v = Vector2((r.randf() - 0.5) * 140.0, -40.0 - 90.0 * r.randf()),
			spin = (r.randf() - 0.5) * 8.0, pts = pts, d = 0.12 * r.randf()})
	var twinkles = []
	for i in range(5):
		twinkles.append({pos = portrait.position + Vector2(8.0 + (portrait.size.x - 16.0) * r.randf(), 8.0 + (portrait.size.y - 16.0) * r.randf()),
			t = 1.6 * r.randf(), s = 4.0 + 4.0 * r.randf()})
	var key = art_seed
	var bands = []
	for i in range(8):
		bands.append(Vector2(2.5 * sin(i * 1.3 + key), 1.5 * sin(i * 2.1 + key * 0.7)))
	var block = chipped_rect(Rect2(Vector2(), card_size), 5.0, r)
	var shade = []
	var run = []
	var outline = block.outline
	for i in range(outline.size()):
		var p = outline[i]
		var q = outline[(i + 1) % outline.size()]
		var m = (p + q) / 2.0
		if (-W - 40.0) * (m.y + 20.0) - (H + 40.0) * (m.x - W - 20.0) < 0.0:
			if run.empty(): run.append(p)
			run.append(q)
		elif !run.empty():
			shade.append(PoolVector2Array(run))
			run = []
	if !run.empty(): shade.append(PoolVector2Array(run))
	var cracks = []
	for i in range(7):
		var ang = TAU * (i + 0.6 * r.randf()) / 7.0
		var L = 95.0 * (0.5 + 0.5 * r.randf())
		var pts = [Vector2()]
		for s in range(1, 7):
			var j = (r.randf() - 0.5) * L * 0.18
			pts.append(Vector2(cos(ang), sin(ang)) * L * s / 6.0 + Vector2(-sin(ang), cos(ang)) * j)
		cracks.append(pts)
	var crack_at = portrait.position + portrait.size * Vector2(0.35 + 0.3 * r.randf(), 0.35 + 0.3 * r.randf())
	return {cap = cap, icicles = icicles, shards = shards, twinkles = twinkles, bands = bands, block = block.outline,
		inner = block.inner, shade = shade, cracks = cracks, crack_at = crack_at}


func chipped_rect(r, m, fr):
	var outline = []
	var inner = []
	var w = r.size.x
	var h = r.size.y
	var x0 = r.position.x
	var y0 = r.position.y
	var per = 2.0 * (w + h) + 8.0 * m
	var n = int(round(per / 14.0))
	var W2 = w + 2.0 * m
	var H2 = h + 2.0 * m
	for i in range(n):
		var along = per * i / n
		var out = 3.5 * fr.randf() * fr.randf()
		var p = Vector2()
		var nrm = Vector2()
		if along < W2:
			p = Vector2(x0 - m + along, y0 - m)
			nrm = Vector2(0, -1)
		elif along < W2 + H2:
			p = Vector2(x0 + w + m, y0 - m + along - W2)
			nrm = Vector2(1, 0)
		elif along < 2.0 * W2 + H2:
			p = Vector2(x0 + w + m - (along - W2 - H2), y0 + h + m)
			nrm = Vector2(0, 1)
		else:
			p = Vector2(x0 - m, y0 + h + m - (along - 2.0 * W2 - H2))
			nrm = Vector2(-1, 0)
		var cx = min(p.x - (x0 - m), x0 + w + m - p.x)
		var cy = min(p.y - (y0 - m), y0 + h + m - p.y)
		var cut = max(0.0, 5.0 - min(cx, cy)) if cx < 6.0 and cy < 6.0 else 0.0
		outline.append(p + nrm * (out - cut))
		inner.append(p + nrm * (out - cut - 2.25))
	return {outline = PoolVector2Array(outline), inner = PoolVector2Array(inner)}


#--- drawn once in the card's own frame, moved and faded with it -------------------------------------------------

func _draw_desat(node, _arg):
	if tex != null: node.draw_texture_rect_region(tex, pic, src, Color(1, 1, 1, 0.55))


func _draw_bands(node, _arg):
	if tex == null: return
	var W = pic.size.x
	var H = pic.size.y
	var col = Color(1, 1, 1, 1.0 - pow(0.4, 0.25))
	for i in range(8):
		var b = art.bands[i]
		var y0 = H * i / 8.0
		var y1 = H * (i + 1) / 8.0
		for tap in [Vector2(-0.9, -0.9), Vector2(0.9, -0.9), Vector2(-0.9, 0.9), Vector2(0.9, 0.9)]:
			var o = Vector2(-2.0, -2.0) + b + tap
			var uv0 = Vector2(-o.x / (W + 4.0), (y0 - o.y) / (H + 4.0))
			var uv1 = Vector2((W - o.x) / (W + 4.0), (y1 - o.y) / (H + 4.0))
			var region = Rect2(src.position + uv0 * src.size, (uv1 - uv0) * src.size)
			node.draw_texture_rect_region(tex, Rect2(pic.position + Vector2(0.0, y0), Vector2(W, y1 - y0)), region, col)


func _draw_ice(node, _arg):
	var size = portrait.size
	var baked = shared.baked.get(frost_key)
	if baked != null:
		node.draw_texture_rect_region(baked, portrait, Rect2(Vector2(size.x + 16.0, 0.0), size), Color(1, 1, 1, 0.9))
		node.draw_texture_rect_region(baked, portrait, Rect2(Vector2(), size), Color(0.941, 0.973, 1.0, 0.9))
	b_begin(node)
	clipped_blob(portrait.position + size * Vector2(0.22, 0.18), 95.0, portrait, fade(WHITE, 0.2))
	var diag = size.length()
	var u = size / diag
	b_stripe(portrait, portrait.position, u, [0.22 * diag, 0.245 * diag, 0.26 * diag], [fade(WHITE, 0.0), fade(WHITE, 0.28), fade(WHITE, 0.0)])
	b_stripe(portrait, portrait.position, u, [0.3 * diag, 0.315 * diag, 0.33 * diag], [fade(WHITE, 0.0), fade(WHITE, 0.16), fade(WHITE, 0.0)])
	block_fill()
	b_flush()
	node.draw_polyline(closed(art.block), c8(240, 250, 255, 0.6), 1.6, true)
	for run in art.shade:
		node.draw_polyline(run, c8(30, 70, 120, 0.45), 2.0, true)
	node.draw_polyline(closed(art.inner), c8(225, 245, 255, 0.22), 4.5, true)
	b_begin(node)
	snow_cap()
	for ic in art.icicles:
		icicle(ic, card_size.y + 4.0, ic.len)
	b_flush()


func _draw_spec(node, _arg):
	b_begin(node)
	blob(Vector2(34.0, 12.0), 46.0, WHITE, 0.45)
	b_flush()


#on a grid, so the gradient's middle stop holds
func block_fill():
	var W = card_size.x
	var H = card_size.y
	var box = Rect2(-3.0, -3.0, W + 6.0, H + 6.0)
	var len2 = W * W + H * H
	var points = []
	var colors = []
	for j in range(8):
		for i in range(7):
			var p = box.position + box.size * Vector2(i / 6.0, j / 7.0)
			points.append(p)
			colors.append(block_color(clamp((p.x * W + p.y * H) / len2, 0.0, 1.0)))
	var indices = []
	for j in range(7):
		for i in range(6):
			var a = j * 7 + i
			indices.append_array([a, a + 1, a + 8, a, a + 8, a + 7])
	b_mesh(points, colors, indices)


func block_color(s):
	var c0 = c8(230, 246, 255, 0.2)
	var c1 = c8(200, 232, 255, 0.07)
	var c2 = c8(90, 150, 210, 0.14)
	if s < 0.45: return c0.linear_interpolate(c1, s / 0.45)
	return c1.linear_interpolate(c2, (s - 0.45) / 0.55)


func snow_cap():
	var top = -5.0
	var hi_col = fade(WHITE, 0.97)
	var lo_col = c8(200, 225, 250, 0.95)
	var points = []
	var colors = []
	var indices = []
	for i in range(art.cap.size()):
		var q = art.cap[i]
		var y = top + 1.0 - q.y
		points.append(Vector2(q.x, y))
		colors.append(hi_col.linear_interpolate(lo_col, clamp((y - top + 11.0) / 14.0, 0.0, 1.0)))
		points.append(Vector2(q.x, top + 2.0))
		colors.append(hi_col.linear_interpolate(lo_col, 13.0 / 14.0))
		if i > 0:
			var a = i * 2 - 2
			indices.append_array([a, a + 2, a + 3, a, a + 3, a + 1])
	b_mesh(points, colors, indices)
	for i in range(art.cap.size()):
		if i % 3 != 1: continue
		var q = art.cap[i]
		puff(Vector2(q.x, top - q.y * 0.6), 4.0 + q.y * 0.6, WHITE, 0.5)
	b_line(Vector2(-2.0, top + 2.5), Vector2(card_size.x + 2.0, top + 2.5), 1.0, c8(120, 165, 215, 0.45))


func icicle(ic, y0, L):
	var left = []
	var right = []
	var points = []
	var colors = []
	var indices = []
	for s in range(9):
		var u = s / 8.0
		var w = ic.w * pow(1.0 - u, 0.8) * (1.0 + 0.18 * sin(u * 9.0 + ic.ph))
		var x = ic.x + ic.lean * L * u * u
		left.append(Vector2(x - w, y0 + L * u))
		right.append(Vector2(x + w, y0 + L * u))
		var col = c8(240, 250, 255, 0.7).linear_interpolate(c8(200, 235, 255, 0.35), u / 0.5) if u < 0.5 \
			else c8(200, 235, 255, 0.35).linear_interpolate(c8(215, 242, 255, 0.12), (u - 0.5) / 0.5)
		points.append(left[s])
		points.append(right[s])
		colors.append(col)
		colors.append(col)
		if s > 0:
			var b = s * 2 - 2
			indices.append_array([b, b + 1, b + 3, b, b + 3, b + 2])
	b_mesh(points, colors, indices)
	var edge = left.duplicate()
	for s in range(8, -1, -1):
		edge.append(right[s])
	b_polyline(edge, 0.6, c8(235, 248, 255, 0.3))
	var core = []
	for s in range(7):
		core.append(left[s] + Vector2(ic.w * 0.45 * (1.0 - s / 8.0), 0.0))
	b_polyline(core, 0.7, fade(WHITE, 0.5))
	var tip = Vector2(ic.x + ic.lean * L, y0 + L + 1.2)
	blob(tip, 4.0, c8(220, 240, 255), 0.25)
	b_disc(tip, 1.3, fade(WHITE, 0.8), 6)


#--- drawn every frame, in the card's own frame --------------------------------------------------------------------

func _draw_mul(layer):
	if fs == null or fs.ice <= 0.01 or !card_ok(card): return
	card_space(layer, card)
	layer.draw_rect(portrait, WHITE.linear_interpolate(c8(155, 200, 250), 0.5 * fs.ice))
	screen_space(layer)


func _draw_add(layer):
	if fs == null or fs.ice <= 0.01 or !card_ok(card): return
	card_space(layer, card)
	layer.draw_rect(portrait, c8(32, 70, 118, 0.28 * fs.ice))
	screen_space(layer)


#mist sinking off the block, the cracks and the pieces of the burst
func _draw_top(layer):
	if fs == null or !card_ok(card): return
	card_space(layer, card)
	if fs.ice > 0.01:
		for i in range(3):
			var ph = fposmod((tau - fs.t0) * 0.55 + i / 3.0, 1.0)
			d_puff(layer, Vector2(card_size.x * (0.25 + 0.25 * i) + 14.0 * sin(tau * 1.3 + i), card_size.y + 6.0 + 38.0 * ph), 26.0 + 34.0 * ph,
				c8(225, 240, 255), 0.18 * fs.ice * sin(PI * ph))
	if tau > fs.t1 and tau < fs.t2: crack_lines(layer, false)
	if tau > fs.t1: shatter(layer)
	for i in range(debris.size()):
		slivers(layer, debris[i], i)
	screen_space(layer)


func crack_lines(layer, glow):
	var cr = seg(tau, fs.t1, fs.t1 + 0.12)
	var clip = rect_points(portrait)
	for ray in art.cracks:
		var m = int(min(ray.size(), max(2, ceil(ray.size() * cr))))
		var line = PoolVector2Array()
		for i in range(m):
			line.append(art.crack_at + ray[i])
		for piece in Geometry.clip_polyline_with_polygon_2d(line, clip):
			if piece.size() < 2: continue
			if glow:
				layer.draw_polyline(piece, fade(WHITE, 0.25), 5.0)
				continue
			var shifted = PoolVector2Array()
			for p in piece:
				shifted.append(p + Vector2(1, 1))
			layer.draw_polyline(shifted, c8(20, 50, 90, 0.45), 2.2, true)
			layer.draw_polyline(piece, fade(WHITE, 0.85), 1.0, true)


func shatter(layer):
	for sd in art.shards:
		var a = tau - fs.t1 - 0.03 * sd.d
		if a < 0.0 or a > 0.7: continue
		var al = 1.0 - a / 0.7
		var v = sd.v + fling * 460.0
		var xf = Transform2D(sd.spin * a * 2.0, sd.pos + v * a + Vector2(0.0, 620.0 * a * a))
		var pts = PoolVector2Array()
		var colors = PoolColorArray()
		for q in sd.pts:
			pts.append(xf.xform(q))
			colors.append(c8(240, 250, 255, 0.6 * al).linear_interpolate(c8(150, 205, 245, 0.3 * al), clamp((q.x + q.y + 24.0) / 48.0, 0.0, 1.0)))
		layer.draw_polygon(pts, colors)
		layer.draw_polyline(closed(pts), fade(WHITE, 0.8 * al), 1.0, true)


#the flash of the freeze, the twinkles, the glow of the cracks
func _draw_glow(layer):
	if fs == null or !card_ok(card): return
	card_space(layer, card)
	var fq = 1.0 - seg(tau, fs.t0, fs.t0 + 0.2)
	if fq > 0.0 and fq < 1.0: layer.draw_rect(portrait, c8(225, 243, 255, 0.55 * fq))
	if fs.ice > 0.01:
		for tw in art.twinkles:
			var b = bump(fposmod(tau - fs.t0 + tw.t, 1.6), 0.0, 0.08, 0.3)
			if b > 0.01: d_star4(layer, tw.pos, tw.s * b, 0.4, WHITE, 0.85 * b * fs.ice)
	if tau > fs.t1 and tau < fs.t2: crack_lines(layer, true)
	for i in range(sparks.size()):
		burst_sparks(layer, sparks[i], i)
	for f in flares:
		flare(layer, f)
	screen_space(layer)


#--- its textures: frost on the glass and the inside of the ice, side by side --------------------------------------

func _bake_card(painter, _job):
	bake_card_frost(painter, portrait.size, windward, art_seed)
	painter.draw_set_transform(Vector2(portrait.size.x + 16.0, 0.0), 0.0, Vector2(1, 1))
	bake_ice(painter, portrait.size, art_seed)
	painter.draw_set_transform(Vector2(), 0.0, Vector2(1, 1))


func bake_card_frost(painter, size, wind, key):
	var W = size.x
	var H = size.y
	var r = RandomNumberGenerator.new()
	r.seed = key
	var wx = 0.0 if wind > 0 else W
	var win = 0.0 if wind > 0 else PI
	var seeds = []
	for i in range(26):
		seeds.append([Vector2(wx, H * r.randf()), win + (r.randf() - 0.5) * 1.6, 16.0 + 34.0 * r.randf()])
	for i in range(18):
		var side = int(r.randf() * 3.0)
		var s = r.randf()
		if side == 0: seeds.append([Vector2(W * s, 0.0), PI / 2.0 + (r.randf() - 0.5) * 1.4, 10.0 + 22.0 * r.randf()])
		elif side == 1: seeds.append([Vector2(W * s, H), -PI / 2.0 + (r.randf() - 0.5) * 1.4, 10.0 + 22.0 * r.randf()])
		else: seeds.append([Vector2(W - wx, H * s), win + PI + (r.randf() - 0.5) * 1.4, 10.0 + 18.0 * r.randf()])
	for i in range(8):
		seeds.append([Vector2(W * (0.2 + 0.6 * r.randf()), H * (0.15 + 0.7 * r.randf())), TAU * r.randf(), 8.0 + 16.0 * r.randf()])
	frost_lines(painter, grow_frost(seeds, r, 2), [[1.1, 0.6], [0.7, 0.5], [0.45, 0.45]], 3.0, 0.9, 0.85)
	if wind > 0:
		edge_fade(painter, Rect2(0.0, 0.0, 30.0, H), Vector2(1, 0), 0.4)
		edge_fade(painter, Rect2(W - 12.0, 0.0, 12.0, H), Vector2(-1, 0), 0.2)
	else:
		edge_fade(painter, Rect2(W - 30.0, 0.0, 30.0, H), Vector2(-1, 0), 0.4)
		edge_fade(painter, Rect2(0.0, 0.0, 12.0, H), Vector2(1, 0), 0.2)
	edge_fade(painter, Rect2(0.0, 0.0, W, 12.0), Vector2(0, 1), 0.22)
	edge_fade(painter, Rect2(0.0, H - 14.0, W, 14.0), Vector2(0, -1), 0.22)
	grains(painter, W, H, 1200, r, 22.0, 0.05, wx)


func bake_ice(painter, size, key):
	var W = size.x
	var H = size.y
	var r = RandomNumberGenerator.new()
	r.seed = key + 5
	for i in range(5):
		var c = Vector2(W * r.randf(), H * r.randf())
		radial(painter, c, [0.0, 20.0 + 40.0 * r.randf()], [Color(1, 1, 1, 0.2), Color(1, 1, 1, 0.0)], 24)
	for i in range(4):
		var p = Vector2(W * r.randf(), H * r.randf())
		var a = TAU * r.randf()
		var pts = [p]
		for s in range(8):
			a += (r.randf() - 0.5) * 0.7
			p += Vector2(cos(a), sin(a)) * (8.0 + 10.0 * r.randf())
			pts.append(p)
		var line = PoolVector2Array(pts)
		for L in [[5.0, 0.07], [2.0, 0.16], [0.8, 0.6]]:
			painter.draw_polyline(line, Color(1, 1, 1, L[1] * min(1.0, L[0])), max(1.0, L[0]), true)
		for k in range(4):
			var q = pts[1 + int(r.randf() * (pts.size() - 1))]
			var b = TAU * r.randf()
			painter.draw_line(q, q + Vector2(cos(b), sin(b)) * (6.0 + 8.0 * r.randf()), Color(1, 1, 1, 0.21), 1.0, true)
	for i in range(4):
		var c = Vector2(W * r.randf(), H * r.randf())
		for k in range(6):
			var b = c + Vector2((r.randf() - 0.5) * 18.0, (r.randf() - 0.5) * 18.0)
			var rad = 0.6 + 1.6 * r.randf()
			painter.draw_arc(b, rad, 0.0, TAU, 12, Color(1, 1, 1, 0.27), 1.0, true)
			painter.draw_circle(b - Vector2(rad, rad) * 0.3, rad * 0.35, Color(1, 1, 1, 0.8))
	for i in range(2):
		var y0 = H * (0.2 + 0.5 * r.randf())
		painter.draw_line(Vector2(0.0, y0), Vector2(W, y0 - W * (0.4 + 0.3 * r.randf())), Color(1, 1, 1, 0.22), 1.0, true)
