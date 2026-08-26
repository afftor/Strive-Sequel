extends Node2D
# Preview harness for the garden. It owns nothing but the mansion placeholder,
# the hint line and a screenshot hook - the backdrop, the two weather overlays
# and the camera are plain instanced scenes and scripts, so what you see is what
# those scenes are.
#
#   edit the garden:    garden_backdrop.tscn
#   edit time of day:   garden_daylight.tscn  (phase is live in the editor)
#   edit the rain:      garden_rain.tscn      (intensity is live in the editor)
#   look at it:         open this scene and press F6
#
#   wheel zoom in (1.0 is the outer stop)   drag pan   0 reset view
#   1 2 3 4  day / dawn / sunset / night    R  cycle rain
#   M placeholder   V vignette   G lamp glow   S screenshot   Esc quit
#
# The weather overlays and this hint sit in CanvasLayers so the camera does not
# drag them around; only the garden itself and the placeholder are in world
# space and zoom.
#
# Headless, terminates by itself:
#   Godot_v3.5.3-stable_win64.exe --no-window --resolution 1920x1080 \
#       --path <repo> res://gui_modules/mansion_view/garden/garden_backdrop_test.tscn \
#       --garden-shot --phase=3 --rain=2 --zoom=0.5 --focus=1700,470 \
#       --shot-path=C:/somewhere/shot.png

const DEFAULT_SHOT = 'user://garden_backdrop_shot.png'
const SHOT_WARMUP = 6

onready var cam = $Camera2D
onready var placeholder = $MansionPlaceholder
onready var hint = $UI/Hint
onready var daylight = $Effects/Daylight
onready var rain = $Effects/Rain
onready var vignette = $Backdrop/Vignette
onready var glow = $Backdrop/Glow

var _shot_path = ''


func _ready():
	var shoot = false
	var zoom = 0.0
	var focus = null
	for arg in OS.get_cmdline_args():
		if arg.begins_with('--shot-path='):
			_shot_path = arg.substr('--shot-path='.length())
		elif arg.begins_with('--phase='):
			daylight.set_phase(int(arg.substr('--phase='.length())))
		elif arg.begins_with('--rain='):
			rain.set_intensity(int(arg.substr('--rain='.length())))
		elif arg.begins_with('--zoom='):
			zoom = float(arg.substr('--zoom='.length()))
		elif arg.begins_with('--focus='):
			var xy = arg.substr('--focus='.length()).split(',')
			if xy.size() == 2:
				focus = Vector2(float(xy[0]), float(xy[1]))
		elif arg == '--garden-shot':
			shoot = true
	# zoom first: how far the view can travel depends on it
	if zoom > 0.0 or focus != null:
		cam.follow_speed = 0.0
		if zoom > 0.0:
			cam.set_zoom_level(zoom)
		if focus != null:
			cam.set_focus(focus)
	_update_hint()
	if shoot:
		if _shot_path == '':
			_shot_path = DEFAULT_SHOT
		call_deferred('_shoot_and_quit')


func _update_hint():
	hint.text = '%s   |   rain: %s   |   zoom %.2fx   |   1-4 time   R rain   wheel zoom   0 reset   M placeholder   V vignette   G glow   S shot   Esc quit' % [
		daylight.phase_name(), rain.level_name(), 1.0 / cam.zoom.x]


func _process(_delta):
	_update_hint()


func _unhandled_input(event):
	if not (event is InputEventKey) or not event.pressed or event.echo:
		return
	match event.scancode:
		KEY_1, KEY_2, KEY_3, KEY_4:
			daylight.set_phase(event.scancode - KEY_1)
		KEY_R:
			rain.set_intensity((rain.intensity + 1) % rain.LEVELS.size())
		KEY_M:
			placeholder.visible = not placeholder.visible
		KEY_V:
			vignette.visible = not vignette.visible
		KEY_G:
			glow.visible = not glow.visible
		KEY_H:
			hint.visible = not hint.visible
		KEY_S:
			_shot_path = DEFAULT_SHOT
			_capture()
		KEY_ESCAPE, KEY_Q:
			get_tree().quit()


func _shoot_and_quit():
	hint.visible = false
	# let the camera settle and the particle layers run a few steps
	for _i in range(SHOT_WARMUP):
		yield(get_tree(), 'idle_frame')
	yield(_capture(), 'completed')
	get_tree().quit()


func _capture():
	yield(VisualServer, 'frame_post_draw')
	var tex = get_viewport().get_texture()
	if tex == null:
		push_error('garden shot: no viewport texture')
		return
	var img = tex.get_data()
	if img == null:
		push_error('garden shot: viewport returned no data')
		return
	img.flip_y()
	if img.save_png(_shot_path) == OK:
		print('garden shot saved: ', _shot_path)
	else:
		push_error('garden shot: could not write ' + _shot_path)
