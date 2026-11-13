extends "res://src/combat/FxNode.gd"
#The taunt wave drawn in code: two red pulses from the anchor, frame for frame the tauntwave sheet it replaced
#(19 frames at 30 fps). The sheet was 7170 px wide, past what phone GPUs load.

const LENGTH = 0.633
const FPS = 30.0
const CORE = Color(1.0, 0.212, 0.212)
const RIM = Color(0.92, 0.114, 0.09)
#alpha per sheet frame, sampled from the sheet's pixels
const CORE_A = [0.09, 0.31, 0.59, 0.82, 0.92, 0.85, 0.72, 0.72, 0.83, 0.91, 0.89, 0.82, 0.71, 0.59, 0.45, 0.32, 0.2, 0.09, 0.02, 0.0]
const RIM1_A = [0.0, 0.05, 0.14, 0.25, 0.31, 0.3, 0.2, 0.11, 0.04, 0.0]
const RIM2_A = [0.0, 0.16, 0.29, 0.4, 0.25, 0.23, 0.21, 0.17, 0.07, 0.05, 0.0]

var anim = null
var speed = 1.0


func play(node, opts = {}):
	anim = opts.get('anim')
	speed = float(opts.get('speed', 1.0))
	node.add_child(self)
	position = node.rect_size / 2
	z_index = 1


func _process(delta):
	var rate = 1.0
	if anim != null and is_instance_valid(anim) and anim.get('rate') != null: rate = anim.rate
	t += delta * rate * speed
	if t > LENGTH:
		queue_free()
		return
	update()


func _draw():
	var f = t * FPS
	var a = frames(CORE_A, f)
	if a > 0.004:
		radial(self, Vector2.ZERO, [0.0, 40.0, 85.0, 130.0], [fade(CORE, a), fade(CORE, 0.72 * a), fade(CORE, 0.3 * a), fade(CORE, 0.0)], 48)
	pulse(40.0 + 290.0 * pow(clamp(f / 8.0, 0.0, 1.0), 0.9), frames(RIM1_A, f))
	pulse(120.0 + 210.0 * pow(clamp((f - 9.0) / 8.0, 0.0, 1.0), 0.85), frames(RIM2_A, f - 8.0))


#a faint red disc out to the rim, the rim itself a little stronger
func pulse(r, a):
	if a <= 0.004: return
	var inner = 0.3 * a
	radial(self, Vector2.ZERO, [0.0, r * 0.5, r - 16.0, r - 5.0, r + 5.0, r + 16.0],
		[fade(RIM, 0.0), fade(RIM, inner), fade(RIM, inner), fade(RIM, a), fade(RIM, a), fade(RIM, 0.0)], 64)


static func frames(table, f):
	if f <= 0.0: return table[0]
	var i = int(f)
	if i >= table.size() - 1: return table[table.size() - 1]
	return lerp(table[i], table[i + 1], f - i)
