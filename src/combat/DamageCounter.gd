extends Reference
#A card's damage run up as a counter over it instead of one floating number. Its hp_update is handed over, the real
#damage is shared out over ticks - equal shares, or weighted, like arrows of two sizes - the HP bar and label follow
#the running value, and the exact figures land when it is done. SupernovaEffect, ArrowRainEffect and the dark effects
#draw with it, and each share can play the animation's counter cues (`sounds`).
#It also holds the one look of every floating damage number (assets/fonts/DamageFont.tres): make_fonts and draw_number.

const COUNT = 0.14 #each share runs in over this long
const DAMAGE_FONT = preload("res://assets/fonts/DamageFont.tres")
const FONT_SIZE = 96
const GAME_RED = Color(0.8, 0.2, 0.2)
const CRIT_GOLD = Color(1.0, 0.8, 0.0)
const HOT = Color(1.0, 0.769, 0.431)

#card -> its counter
var counters = {}
var font = null
var shadow_font = null
#once done the number holds this long, then fades
var hold = 0.95
var fade_time = 0.6
#it swells a little with every share and flares when done, a ring going out from it
var pop = 0.07
var slam = 0.35
var slam_time = 0.32
var ring = true
#px it trembles by while it runs
var tremble = 1.5
#[{sound, gap}]: what plays as each share lands - the animation's sound cues with on = 'counter'
#(CombatAnimations.counter_cues). Shares landing together, on one card or on several, make one sound:
#a cue keeps quiet for `gap` seconds after it has played.
var sounds = []
var sounded = {}
#the combat lab's trace (CombatAnimations.sound_trace): every share as it lands, under the animation's code
var trace = null
var trace_code = ''


#DamageFont at `size` with its dark outline scaled along, and a shadow of the same face without the outline
static func make_fonts(size = FONT_SIZE):
	var font = DAMAGE_FONT.duplicate()
	font.outline_size = int(round(DAMAGE_FONT.outline_size * size / float(DAMAGE_FONT.size)))
	font.size = size
	var shadow = DAMAGE_FONT.duplicate()
	shadow.outline_size = 0
	shadow.size = size
	return {font = font, shadow = shadow}


#one number in fonts from make_fonts, centred on `pos` and `size_px` tall, a soft shadow under it
static func draw_number(layer, font, shadow, text, pos, size_px, color, alpha):
	if alpha <= 0.01 or size_px < 2.0 or font == null: return
	var s = size_px / float(font.size)
	var at = Vector2(-font.get_string_size(text).x / 2.0, font.get_ascent() * 0.36)
	layer.draw_set_transform(pos, 0.0, Vector2(s, s))
	layer.draw_string(shadow, at + Vector2(font.size * 0.045, font.size * 0.05), text, Color(0, 0, 0, 0.75 * alpha))
	var edge = DAMAGE_FONT.outline_color
	font.outline_color = Color(edge.r, edge.g, edge.b, alpha)
	layer.draw_string(font, at, text, Color(color.r, color.g, color.b, alpha))
	layer.draw_set_transform(Vector2(), 0.0, Vector2(1, 1))


#`ticks`: when each share lands, `weights`: how big each is, none for equal shares. `now` is the owner's clock.
func start(node, args, crit, ticks, weights, now):
	var total = abs(ceil(args.damage))
	var keyed = []
	for k in range(ticks.size()):
		keyed.append([ticks[k], k])
	keyed.sort_custom(self, '_by_time')
	var order = []
	for pair in keyed:
		order.append(pair[1])
	var times = []
	var shares = []
	var sum = 0.0
	for k in order:
		sum += float(weights[k]) if !weights.empty() else 1.0
	for k in order:
		times.append(ticks[k])
		shares.append(total * float(weights[k]) / sum if !weights.empty() else total / ticks.size())
	var hpmax = 1.0
	if node.get('fighter') != null: hpmax = max(1.0, float(node.fighter.get_stat('hpmax')))
	var hpnode = node.get_node_or_null('bars/HP')
	var old_hp = float(args.newhp) + total
	#a killing blow can be bigger than what the card had left: the bar starts from what it showed
	if hpnode != null and total > 0.0 and old_hp > float(hpnode.value) * hpmax / 100.0 + 1.0:
		old_hp = max(float(args.newhp), float(hpnode.value) * hpmax / 100.0)
	var counter = {
		ticks = times, shares = shares, total = total, value = 0.0, last = -1.0, start = now, done = times.back() + COUNT,
		newhp = args.newhp, newhpp = args.newhpp, old_hp = old_hp, drain = 1.0 if old_hp == float(args.newhp) + total else (old_hp - float(args.newhp)) / total,
		hpmax = hpmax, hpnode = hpnode, crit = crit, finished = false, heard = 0,
		text = str(ceil(args.damage)) + ('!' if crit else ''), seed = counters.size() * 37 + 5,
	}
	counters[node] = counter
	return counter


func _by_time(a, b):
	return a[0] < b[0]


func update(t):
	for node in counters:
		var c = counters[node]
		if c.finished: continue
		if !is_instance_valid(node):
			c.finished = true
			continue
		var value = 0.0
		var last = -1.0
		for k in range(c.ticks.size()):
			var at = c.ticks[k]
			if at > t: break
			value += c.shares[k] * min(1.0, (t - at) / COUNT)
			last = at
			if k >= c.heard:
				c.heard = k + 1
				hear(t)
				if trace != null: trace.append({kind = 'tick', node = node, code = trace_code})
		c.value = value
		c.last = last
		if t >= c.done:
			finish(node, c)
			continue
		var hp = max(0.0, c.old_hp - value * c.drain)
		var hpp = hp * 100.0 / c.hpmax
		if c.hpnode != null: c.hpnode.value = hpp
		node.update_hp_label(hp, hpp)


func hear(t):
	for i in range(sounds.size()):
		var cue = sounds[i]
		if sounded.has(i) and t - sounded[i] < cue.gap: continue
		sounded[i] = t
		if audio.sounds.has(cue.sound): input_handler.PlaySound(cue.sound)


func finish(node, c):
	c.finished = true
	c.value = c.total
	if !is_instance_valid(node): return
	if c.hpnode != null and is_instance_valid(c.hpnode): c.hpnode.value = c.newhpp
	node.update_hp_label(c.newhp, c.newhpp)


func finish_all():
	for node in counters:
		if !counters[node].finished: finish(node, counters[node])


#how much longer a card's number runs, in the owner's clock
func left(node, t):
	var c = counters.get(node)
	if c == null or c.finished: return 0.0
	return max(0.0, c.done - t)


#when the last number is gone
func gone_time():
	var res = 0.0
	for node in counters:
		res = max(res, counters[node].done + hold + fade_time)
	return res


#`owner.local_rect(card)` places the card in the layer's space
func draw(layer, t, owner):
	for node in counters:
		var c = counters[node]
		if !is_instance_valid(node) or c.value < 0.5: continue
		var fade = 1.0 - seg(t, c.done + hold, c.done + hold + fade_time)
		if fade <= 0.0: continue
		var rect = owner.local_rect(node)
		var anchor = Vector2(rect.position.x + rect.size.x / 2.0, rect.position.y + rect.size.y * 0.475)
		var swell = 1.0 + pop * bump(t - c.last, 0.0, 0.02, 0.1)
		var flare = 1.0
		var hot = 0.35 * bump(t - c.last, 0.0, 0.02, 0.12)
		var tick = floor(t * 60.0)
		var pos = anchor
		if t >= c.done:
			flare = 1.0 + slam * (1.0 - out_cubic(seg(t, c.done, c.done + slam_time)))
			hot = max(hot, 1.0 - seg(t, c.done, c.done + 0.5))
			if ring and t < c.done + 0.4:
				var q = seg(t, c.done, c.done + 0.4)
				layer.draw_arc(pos, 26.0 + 70.0 * out_cubic(q), 0.0, TAU, 64, c8(255, 170, 90, 0.55 * (1.0 - q) * fade), 7.0 * (1.0 - q) + 1.0, true)
		elif tremble > 0.0:
			pos += Vector2(noise(c.seed, tick, 1), noise(c.seed, tick, 2)) * tremble
		var text = c.text if t >= c.done else '-' + str(int(round(c.value)))
		var base = CRIT_GOLD if c.crit and t >= c.done else GAME_RED
		var size_px = (40.0 + 30.0 * pow(min(1.0, c.value / max(1.0, c.total)), 0.7)) * swell * flare
		number(layer, text, pos, size_px, base.linear_interpolate(HOT, hot), fade)


func number(layer, text, pos, size_px, color, alpha):
	draw_number(layer, font, shadow_font, text, pos, size_px, color, alpha)


static func c8(r, g, b, a = 1.0):
	return Color(r / 255.0, g / 255.0, b / 255.0, clamp(a, 0.0, 1.0))


static func seg(x, a, b):
	if b <= a: return 1.0 if x >= b else 0.0
	return clamp((x - a) / (b - a), 0.0, 1.0)


static func bump(x, a, b, c):
	if x <= a or x >= c: return 0.0
	if x < b: return out_quad((x - a) / (b - a))
	return 1.0 - inout_quad((x - b) / (c - b))


static func out_quad(k):
	return 1.0 - (1.0 - k) * (1.0 - k)


static func inout_quad(k):
	return 2.0 * k * k if k < 0.5 else 1.0 - pow(-2.0 * k + 2.0, 2) / 2.0


static func out_cubic(k):
	return 1.0 - pow(1.0 - k, 3)


static func noise(key, i, tick):
	var v = sin(key * 0.0137 + i * 17.171 + tick * 7.913) * 43758.5453
	return (v - floor(v)) * 2.0 - 1.0
