extends CanvasLayer

# The frame counter in the corner.
#
# Added once at startup beside the console (`globals._ready`) and parented to the
# root, so it outlives every screen change and needs no screen to remember it.
# A CanvasLayer above the game's own layers keeps it over whatever is drawn,
# including the doll's own overlay layer, and out of every layout: nothing in the
# screens can push it around and it pushes nothing.
#
# `mouse_filter` on the label is IGNORE in the scene, so the number never eats a
# click meant for what is underneath it.

# The number is sampled rather than written every frame: at 60 fps it changes
# faster than it can be read, and a Label that rewrites itself sixty times a
# second is work the meter is supposed to be measuring, not adding.
#
# The same beat asks whether the meter is wanted at all.  Reading one setting
# four times a second is nothing, and it saves wiring a signal through to a node
# that is already awake - the options panel writes the setting and the counter
# has caught up before the panel is closed.
const SAMPLE_EVERY = 0.25

onready var _label = $Label

var _elapsed = 0.0


func _ready():
	# it is a reading of the game, so it keeps counting while the game is paused
	pause_mode = Node.PAUSE_MODE_PROCESS
	_refresh()


func _process(delta):
	_elapsed += delta
	if _elapsed < SAMPLE_EVERY:
		return
	_elapsed = 0.0
	_refresh()


func _refresh():
	if _label == null:
		return
	var handler = get_tree().get_root().get_node_or_null("input_handler")
	visible = handler == null or bool(handler.globalsettings.get("fps_meter", false))
	if !visible:
		return
	_label.text = "%d fps" % Engine.get_frames_per_second()
