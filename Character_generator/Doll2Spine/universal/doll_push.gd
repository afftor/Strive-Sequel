extends Reference

# Parts the cursor can lean on: it pushes them out of its way, they give ground
# as far as they will, and when it asks for more they slip past it and snap back.
#
# Everything here is about a part that hangs off a bone and can be turned about
# its base - an ear today, a tail or a lock of hair the day someone lists one.
# The doll keeps the geometry, because only the doll knows where its bones have
# ended up this frame; what lives here is the table of what is pushable, the
# numbers the push is tuned by, and the little state machine each bone runs.
#
# Adding a part is one line in `PART_BONES`.  Nothing else in the doll has to
# know it happened.

# The two pairs the ear art is bound to.  A pointed ear hangs off `ear_l`/`ear_r`
# and an animal one off `ear_lt`/`ear_rt`, whatever animal it is.
const EARS_POINTED = ["ear_l", "ear_r"]
const EARS_ANIMAL = ["ear_lt", "ear_rt"]

# What a worn part hands over to the cursor.  A part that is not named here is
# simply not pushable, which is the right answer for a human ear.
#
# `ears_cat` is bound to one bone for both ears and `ears_mouse` to the other -
# that is how the art was rigged, so the pair moves together on those two.  The
# rest of the animal cuts carry a bone each.
const PART_BONES = {
	"ears_elven": EARS_POINTED,
	"ears_elven2": EARS_POINTED,
	"ears_cat": ["ear_lt"],
	"ears_fox": EARS_ANIMAL,
	"ears_fox2": EARS_ANIMAL,
	"ears_fox_n1": EARS_ANIMAL,
	"ears_fox_n2": EARS_ANIMAL,
	"ears_fox_n3": EARS_ANIMAL,
	"ears_fox_n4": EARS_ANIMAL,
}

# The group a pushable part is worn in, and the slots its art is drawn in - the
# doll reads the first to know what is worn and the second to find the pixels.
const PART_GROUP = "ears"
const PART_SLOTS = ["ears"]

# Turning the bone the other way from the screen: the mesh is built with the Y
# axis flipped, so a bone turned by +1 degree shows as a degree the other way.
const ROT_SIGN = -1.0
# How far the cursor can shove a part before it slips past and the part snaps
# back.  Small on purpose - it gives ground, it is not swung around.
const DRAG_MAX = 16.0
# What counts as the cursor being against it: on the art, or within this much of
# it as a fraction of the piece's own width.
#
# Measured against the drawn pixels rather than against the bone, because the two
# are often nowhere near each other - the fox ears hang between 12 and 100
# degrees off the bone that carries them, and the cat's pair share one bone
# between them.  A cone around the bone therefore answered the cursor above the
# head while the ear itself was off to the side.
const TOUCH_MARGIN = 0.22
# The snap: back to rest in a third of a second, hard enough to overshoot once.
const SNAP_TIME = 0.32
const SNAP_FREQ = 24.0
const SNAP_DECAY = 13.0


# The bones a worn part lends to the cursor, or an empty list for a part that
# does not move.
static func bones_for(part_id):
	return PART_BONES.get(str(part_id), [])


# One bone's worth of state.  `grab` is where the cursor lay against it the
# moment it touched, so the first contact moves nothing and only the pushing
# after it does.
static func new_state(bone_names):
	var state = {}
	for bone_name in bone_names:
		state[bone_name] = {"held": false, "angle": 0.0, "grab": 0.0, "snap": -1.0, "snap_from": 0.0}
	return state


# Whether the cursor is on a piece of art, or close enough to be leaning on it.
# `inside` is the exact answer off the mesh's own triangles; the margin is what
# lets a pointer that is a few pixels short of the outline still count, which is
# how it feels to push something with a cursor.
static func touches(inside, nearest, art_size):
	if inside:
		return true
	return art_size > 0.001 and nearest <= art_size * TOUCH_MARGIN


# How far the part would have to turn from rest for the cursor to be where it is.
#
# `base` is where the bone the art hangs from starts, `middle` where the art sits
# now, and `angle` how far the part is already turned.  Only differences between
# two of these are ever used, so it does not matter that the line from the base
# to the middle of a piece is not the line an artist would have drawn - it only
# has to be the same line from one frame to the next.
static func contact(base, middle, angle, cursor):
	var reach = middle - base
	var pull = cursor - base
	if reach.length() < 0.001 or pull.length() < 0.001:
		return null
	# Against where the part lies now, then taken back to rest by however far it
	# is already turned, so the answer is always measured from the same line.
	return wrap_degrees(rad2deg(reach.angle_to(pull))) * ROT_SIGN + float(angle)


# One frame of the cursor leaning on one bone.  `against` is what `contact` said.
# Answers whether anything moved, so the doll can skip re-posing when nothing
# did.
static func push(entry, against):
	if against == null:
		return let_go(entry, false) if bool(entry.held) else false
	if !bool(entry.held):
		# first contact moves nothing: the part is now leaning on the cursor, and
		# what it gives is measured from here
		entry.held = true
		entry.grab = against
		entry.angle = 0.0
		return false
	var shoved = float(against) - float(entry.grab)
	if abs(shoved) > DRAG_MAX:
		# pushed past what it will give: the cursor goes through and it snaps
		entry.angle = clamp(shoved, -DRAG_MAX, DRAG_MAX)
		return let_go(entry, false)
	if abs(shoved - float(entry.angle)) < 0.05:
		return false
	entry.angle = shoved
	return true


# Ends the hold: into the snap back, or straight to rest when the part is gone
# and there is nothing left to snap.
static func let_go(entry, at_once):
	var was_busy = bool(entry.held) or float(entry.snap) >= 0.0 or abs(float(entry.angle)) > 0.001
	entry.held = false
	if at_once:
		entry.snap = -1.0
		entry.snap_from = 0.0
		entry.angle = 0.0
		return was_busy
	entry.snap_from = float(entry.angle)
	entry.snap = 0.0
	entry.angle = 0.0
	return true


# Runs a snap on by one frame; answers whether it is still going.
static func advance_snap(entry, delta):
	if float(entry.snap) < 0.0:
		return false
	entry.snap = float(entry.snap) + delta
	if float(entry.snap) >= SNAP_TIME:
		let_go(entry, true)
	return true


# What the bone should be turned by right now: where it is being held, or where
# its snap has got to.
static func angle_of(entry):
	if bool(entry.held):
		return float(entry.angle)
	if float(entry.snap) < 0.0:
		return 0.0
	var elapsed = float(entry.snap)
	return float(entry.snap_from) * exp(-SNAP_DECAY * elapsed) * cos(SNAP_FREQ * elapsed)


static func wrap_degrees(value):
	while value > 180.0:
		value -= 360.0
	while value < -180.0:
		value += 360.0
	return value
