extends "res://src/combat/FxNode.gd"
#The sign of Clarity landing on a card: a band of gold light across the portrait, a gold rim, motes rising, and the
#eye of Clarity popping over the card and floating up. Winds of Hyperborea lands it on its allies on its own clock;
#the Clarity skill lets it run by itself.

const LIFE = 1.0

var card = null
var anim = null
var glow_layer = null
var portrait = Rect2(7, 27, 168, 143)
var card_size = Vector2(182, 202)
var start = 0.0
var mote_seed = 0
var drawn_tau = -1.0


#opts: `at` is when it lands, `seed` scatters the motes; `host` puts it under that node at `z` instead of over the
#card; `driven` leaves the clock to the host's advance()
func land(node, kit, opts = {}):
	card = node
	use_kit(kit)
	anim = opts.get('anim')
	start = float(opts.get('at', 0.0))
	mote_seed = int(opts.get('seed', 0))
	card_size = node.rect_size
	var icon = node.get_node_or_null('Icon')
	if icon != null: portrait = Rect2(icon.rect_position, icon.rect_size)
	var host = opts.get('host')
	(host if host != null else node).add_child(self)
	set_process(!opts.get('driven', false))
	glow_layer = add_layer(int(opts.get('z', 0)), CanvasItemMaterial.BLEND_MODE_ADD, '_draw_sign')


func _process(delta):
	var rate = 1.0
	if anim != null and is_instance_valid(anim) and anim.get('rate') != null: rate = anim.rate
	advance(t + delta * rate)


func advance(time):
	t = time
	tau = time
	if tau != drawn_tau:
		drawn_tau = tau
		glow_layer.update()
	if tau > start + LIFE: queue_free()


func _draw_sign(layer):
	var a = tau - start
	if a < 0.0 or a > LIFE or !card_ok(card): return
	card_space(layer, card)
	var q = seg(a, 0.0, 0.24)
	if q > 0.0 and q < 1.0:
		var c0 = -0.25 + 1.5 * q
		var d = Vector2(portrait.size.x, -portrait.size.y)
		var L = d.length()
		d_stripe(layer, portrait, portrait.position + Vector2(0.0, portrait.size.y), d / L, [(c0 - 0.14) * L, c0 * L, (c0 + 0.14) * L],
			[fade(GOLD[1], 0.0), fade(GOLD[0], 0.65), fade(GOLD[1], 0.0)])
	var fill = 0.28 * bump(a, 0.0, 0.05, 0.5)
	if fill > 0.004: layer.draw_rect(portrait, fade(GOLD[1], fill))
	var rim = bump(a, 0.0, 0.05, 0.6)
	if rim > 0.01:
		var box = Rect2(3.0, 3.0, card_size.x - 6.0, card_size.y - 6.0)
		layer.draw_rect(box, fade(GOLD[1], 0.5 * rim), false, 8.0)
		layer.draw_rect(box, fade(GOLD[0], 0.85 * rim), false, 2.0)
	for i in range(9):
		var aa = a - 0.03 * i
		if aa < 0.0 or aa > 0.7: continue
		var p = Vector2(12.0 + (card_size.x - 24.0) * hash01(8800 + i + mote_seed * 37), card_size.y - 30.0 - 190.0 * out_quad(aa / 0.7))
		layer.draw_circle(p, 2.2, fade(GOLD[0], (1.0 - aa / 0.7) * (0.6 + 0.4 * sin(tau * 20.0 + i))))
	var sa = a - 0.04
	if sa > 0.0:
		eye_sigil(layer, Vector2(card_size.x / 2.0, 72.0 - 44.0 * seg(sa, 0.25, 0.9)), 17.0 * out_back(clamp(sa / 0.14, 0.0, 1.0)), 1.0 - seg(sa, 0.5, 0.9))
	screen_space(layer)


func eye_sigil(layer, pos, s, a):
	if s <= 0.5 or a <= 0.01: return
	d_blob(layer, pos, s * 2.6, GOLD[1], 0.45 * a)
	var rays = PoolVector2Array()
	for i in range(8):
		var an = i * PI / 4.0 + 0.2 * tau
		var d = Vector2(cos(an), sin(an))
		rays.append(pos + d * s * 1.15)
		rays.append(pos + d * s * (1.45 if i % 2 == 1 else 1.75))
	layer.draw_multiline(rays, fade(GOLD[1], 0.8 * a), 1.6, true)
	var eye = PoolVector2Array()
	for i in range(13):
		eye.append(quad_point(pos + Vector2(-s, 0.0), pos + Vector2(0.0, -s * 0.95), pos + Vector2(s, 0.0), i / 12.0))
	for i in range(1, 12):
		eye.append(quad_point(pos + Vector2(s, 0.0), pos + Vector2(0.0, s * 0.95), pos + Vector2(-s, 0.0), i / 12.0))
	layer.draw_colored_polygon(eye, fade(GOLD[1], 0.25 * a))
	layer.draw_polyline(closed(eye), fade(GOLD[0], a), 2.2, true)
	layer.draw_circle(pos, s * 0.36, fade(GOLD[0], 0.95 * a))
	layer.draw_circle(pos, s * 0.14, fade(WHITE, a))
