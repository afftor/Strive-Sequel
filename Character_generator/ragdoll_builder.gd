extends Node2D

export var clothes = true
export var test_mode = false
export var tits_interaction = true

onready var _root = $VPC/VP

#tits wobble, driven through the deform shader so it fades out at the mesh border
#and never drags the tits meshes away from the torso and the rest of an outfit
const TITS_JIGGLE_TIME = 0.9
const TITS_JIGGLE_FREQ = 3.4
const TITS_JIGGLE_DECAY = 4.0
const TITS_JIGGLE_SHIFT = 16.0 #texture pixels the nipple area travels on the first swing
const TITS_JIGGLE_RANGE = 110.0 #radius the shift fades out over, matches the shipped deform presets
const ZOOM_STEP = 0.1
const ZOOM_MIN = 0.75
const ZOOM_MAX = 1.5
const ZOOM_HOVER_HALF_WIDTH = 275.0
const ZOOM_HOVER_HALF_HEIGHT = 500.0
const DRAG_THRESHOLD = 6.0
const PAN_LIMIT_X = 220.0
const PAN_LIMIT_Y = 320.0

var _scale_x
var _scale_y

var __scale_x
var __scale_y

var _position
var _offset

var _tits_node
var _tits_outline
var _tits_searched = false
var _jiggle_mats = []
var _jiggle_time = 0.0
var _jiggle_power = 1.0
var zoom_multiplier = 1.0
var _drag_candidate = false
var _dragging = false
var _drag_start_mouse_position = Vector2.ZERO
var _drag_start_offset = Vector2.ZERO

var character
var test_template = {
	sex = 'female', 
	race = 'Kobold', 
	horns = 'short', 
	ears = 'bunny_standing', 
	eyeshape = 'face2', 
	eye_tex = 'eyes2', 
	eye_color = 'green', 
	eyebrows = 'style3', 
	lips = 'style5', 
	wings = 'demon', 
	tail = 'wolf', 
	penis_type = 'furry', 
	chin = 'thin', 
	nose = 'default', 
	pregnancy_status = 'none', 
#	pregnancy_status = 'heavy', 
	tits_size = 'huge', 
	multiple_tits_developed = false,
	skin_coverage = 'kobold', 
	body_color_skin = 'human2', 
	body_color_lips = 'green', 
	body_color_wings = 'red3', 
	body_color_tail = 'yellow1', 
	body_color_horns = 'yellow1', 
	body_color_animal = 'red3', 
	body_color_ears = 'red3', 
	hair_base = 'dopple', 
	hair_fringe = 'dopple', 
	hair_assist = 'braid', 
	hair_back = 'double_tail', 
	hair_back_color_1 = 'green_1',
	hair_back_color_2 = 'red_3',
	hair_assist_color_1 = 'yellow_1',
	hair_assist_color_2 = 'pink_3',
	hair_base_color_1 = 'red_2',
	hair_base_color_2 = 'dark_3',
	hair_fringe_color_1 = 'blue_2',
	hair_fringe_color_2 = 'white_3',
	hair_base_length = 'long', 
	hair_fringe_length = 'long', 
	hair_back_length = 'long', 
	hair_assist_length = 'long', 
#	armor_base = 'service_suit', 
	armor_base = 'chest_base_metal', 
#	armor_base = 'servant', 
#	armor_lower = 'service_suit',
	armor_lower = 'legs_base_metal',
#	armor_lower = 'servant',
	armor_collar = null,
	armor_weapon = 'battleaxeadv',
	armor_head = 'pet_suit',
	armor_color_base = 'default',
	armor_color_lower = 'default',
	armor_color_collar = 'default_leather',
	armor_color_weapon = 'default',
	height = 'towering',
	ass_size = 'small',
#	pose = 'serious',
	pose = 'pose5',
	beard = 'no',
	hair_facial_color = 'blue_2',
	
}

func _ready():
#	var shader = load("res://assets/ItemShader.tres").duplicate()
	set_process(false)
	_position = position
	if test_mode:
		_position = Vector2(400, 300)
		_scale_x = 0.5
		_scale_y = 0.5
		rebuild(null)
		rebuild_cloth(clothes)
		save_portrait('test')
	else:
		_scale_x = scale.x
		_scale_y = scale.y
	__scale_x = _scale_x
	__scale_y = _scale_y
	configure_zoom_area()


func _get_stat(stat):
	if stat == 'multiple_tits_developed':
		if !input_handler.globalsettings.furry_multiple_nipples:
			return false
	if test_mode or character == null:
		return test_template[stat]
	else:
		return character.get_stat(stat)


func rebuild(character_to_build):
	stop_tits_jiggle()
	if !is_visible_in_tree():
		return
	#setup
	__scale_x = _scale_x
	__scale_y = _scale_y
#	position = _position
	set_position(Vector2(0, 0))
	_offset = Vector2(0.0, 0.0)
	apply_settings()
	
	character = character_to_build
	#first pass - textures
	for stat in GeneratorData.stats_to_look:
		if !GeneratorData.transforms.has(stat):
			continue
		var st_val = _get_stat(stat)
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if !(transform.type in ['texture', 'texture_set']):
				continue
			apply_transform(transform)
	#second pass - all others
	for stat in GeneratorData.stats_to_look:
		if !GeneratorData.transforms.has(stat):
			continue
		var st_val = _get_stat(stat)
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if (transform.type in ['texture', 'texture_set']):
				continue
			apply_transform(transform)
	#apply scale & offset
#	scale = Vector2(__scale_x, __scale_y)
#	position += _offset
	
	scale = Vector2(1, 1)
#	_root.get_node('male_pose').scale = Vector2(__scale_x, __scale_y)
#	_root.get_node('Female_pose').scale = Vector2(__scale_x, __scale_y)
	_apply_pose_transform()

	_root.render_target_clear_mode = Viewport.CLEAR_MODE_ONLY_NEXT_FRAME
	_root.render_target_update_mode = Viewport.UPDATE_ONCE
	if character != null:
		character.update_portrait(self)


func configure_zoom_area():
	var zoom_area = get_node_or_null('ZoomArea')
	if zoom_area == null:
		return
	zoom_area.rect_position = _position - Vector2(ZOOM_HOVER_HALF_WIDTH, ZOOM_HOVER_HALF_HEIGHT)
	zoom_area.rect_size = Vector2(ZOOM_HOVER_HALF_WIDTH * 2.0, ZOOM_HOVER_HALF_HEIGHT * 2.0)


func change_zoom(direction):
	var new_zoom = clamp(zoom_multiplier + direction * ZOOM_STEP, ZOOM_MIN, ZOOM_MAX)
	if is_equal_approx(new_zoom, zoom_multiplier):
		return
	zoom_multiplier = new_zoom
	_apply_pose_transform()
	_root.render_target_clear_mode = Viewport.CLEAR_MODE_ONLY_NEXT_FRAME
	_root.render_target_update_mode = Viewport.UPDATE_ONCE


func _input(event):
	if !is_visible_in_tree():
		return
	if event is InputEventMouseMotion:
		_update_drag(event.position)
		return
	if !(event is InputEventMouseButton):
		return
	if event.button_index == BUTTON_LEFT:
		if event.pressed:
			_start_drag(event.position)
		else:
			_finish_drag()
		return
	if !event.pressed or !(event.button_index in [BUTTON_WHEEL_UP, BUTTON_WHEEL_DOWN]):
		return
	if !_is_in_zoom_area(event.position):
		return
	change_zoom(1 if event.button_index == BUTTON_WHEEL_UP else -1)
	get_tree().set_input_as_handled()


func _is_in_zoom_area(screen_position):
	var zoom_area = get_node_or_null('ZoomArea')
	if zoom_area == null:
		return false
	var mouse_position = zoom_area.get_global_transform_with_canvas().affine_inverse().xform(screen_position)
	return Rect2(Vector2.ZERO, zoom_area.rect_size).has_point(mouse_position)


func _get_zoom_area_position(screen_position):
	var zoom_area = get_node_or_null('ZoomArea')
	return zoom_area.get_global_transform_with_canvas().affine_inverse().xform(screen_position)


func _start_drag(screen_position):
	_drag_candidate = _is_in_zoom_area(screen_position)
	_dragging = false
	if !_drag_candidate:
		return
	_drag_start_mouse_position = _get_zoom_area_position(screen_position)
	_drag_start_offset = _offset


func _update_drag(screen_position):
	if !_drag_candidate:
		return
	var drag_offset = _get_zoom_area_position(screen_position) - _drag_start_mouse_position
	if !_dragging and drag_offset.length_squared() < DRAG_THRESHOLD * DRAG_THRESHOLD:
		return
	_dragging = true
	_offset = Vector2(
		clamp(_drag_start_offset.x + drag_offset.x, -PAN_LIMIT_X, PAN_LIMIT_X),
		clamp(_drag_start_offset.y + drag_offset.y, -PAN_LIMIT_Y, PAN_LIMIT_Y)
	)
	_apply_pose_transform()
	_root.render_target_clear_mode = Viewport.CLEAR_MODE_ONLY_NEXT_FRAME
	_root.render_target_update_mode = Viewport.UPDATE_ONCE
	get_tree().set_input_as_handled()


func _finish_drag():
	if _dragging:
		get_tree().set_input_as_handled()
	_drag_candidate = false
	_dragging = false


func _apply_pose_transform():
	var pose_scale = Vector2(__scale_x, __scale_y) * zoom_multiplier
	for pose_name in ['male_pose', 'Female_pose']:
		var pose = _root.get_node(pose_name)
		pose.position = _position + _offset
		pose.scale = pose_scale


func rebuild_stat(statname):
	stop_tits_jiggle()
	if !is_visible_in_tree():
		return
	
	var stats = []
	if GeneratorData.stats_links.has(statname):
		stats = GeneratorData.stats_links[statname]
	else:
		stats = [statname]
	#first pass - textures
	for stat in stats:
		if stat == 'full':
			rebuild(character)
			rebuild_cloth(null)
			return
		if !GeneratorData.transforms.has(stat):
			continue
		var st_val = _get_stat(stat)
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if !(transform.type in ['texture', 'texture_set']):
				continue
			apply_transform(transform)
	#second pass - all others
	for stat in stats:
		if !GeneratorData.transforms.has(stat):
			continue
		var st_val = _get_stat(stat)
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if (transform.type in ['texture', 'texture_set']):
				continue
			apply_transform(transform)
	
	_root.render_target_clear_mode = Viewport.CLEAR_MODE_ONLY_NEXT_FRAME
	_root.render_target_update_mode = Viewport.UPDATE_ONCE
	if character != null:
		character.update_portrait(self)


func rebuild_cloth(value):
	stop_tits_jiggle()
	if !is_visible_in_tree():
		return
	if value == null:
		value = clothes
	#first pass - textures
	for stat in ['cloth']:
		if !GeneratorData.transforms.has(stat):
			continue
		var st_val = value
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if !(transform.type in ['texture']):
				continue
			apply_transform(transform)
	for stat in ['armor_base', 'armor_lower', 'armor_collar', 'armor_weapon', 'armor_head']:
		if !value and stat != 'armor_collar':
			continue
		if !GeneratorData.transforms.has(stat):
			continue
		var st_val = _get_stat(stat)
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if !(transform.type in ['texture']):
				continue
			apply_transform(transform)
		#second pass - all others
	for stat in ['cloth']:
		if !GeneratorData.transforms.has(stat):
			continue
		var st_val = value
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if (transform.type in ['texture']):
				continue
			apply_transform(transform)
	for stat in ['armor_color_base', 'armor_color_lower', 'armor_color_collar', 'armor_color_weapon', 'armor_base', 'armor_lower', 'armor_collar', 'armor_weapon']:
		if !value and stat != 'armor_collar':
			continue
		if !GeneratorData.transforms.has(stat):
			continue
		var st_val = _get_stat(stat)
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if (transform.type in ['texture']):
				continue
			apply_transform(transform)
	
	_root.render_target_clear_mode = Viewport.CLEAR_MODE_ONLY_NEXT_FRAME
	_root.render_target_update_mode = Viewport.UPDATE_ONCE


func rebuild_underwear():
	stop_tits_jiggle()
	if !is_visible_in_tree():
		return
	#first pass - textures
	for stat in ['cloth']:
		if !GeneratorData.transforms.has(stat):
			continue
		var st_val = true
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if !(transform.type in ['texture']):
				continue
			apply_transform(transform)
	for stat in ['armor_weapon']:
		if !GeneratorData.transforms.has(stat):
			continue
		var st_val = null
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if !(transform.type in ['texture']):
				continue
			apply_transform(transform)
	for stat in [
		'armor_base_underwear', 
		'armor_lower_underwear', 'armor_collar']:
		var st_val = _get_stat(stat)
		stat = stat.trim_suffix('_underwear')
		if !GeneratorData.transforms.has(stat):
			continue
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if !(transform.type in ['texture']):
				continue
			apply_transform(transform)
	#second pass - all others
	for stat in ['cloth']:
		if !GeneratorData.transforms.has(stat):
			continue
		var st_val = true
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if (transform.type in ['texture']):
				continue
			apply_transform(transform)
	for stat in ['armor_weapon']:
		if !GeneratorData.transforms.has(stat):
			continue
		var st_val = null
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if (transform.type in ['texture']):
				continue
			apply_transform(transform)
	for stat in ['armor_color_base', 'armor_color_lower', 'armor_color_collar',
	 'armor_base_underwear', 
	'armor_lower_underwear', 'armor_collar']:
		var st_val = _get_stat(stat)
		stat = stat.trim_suffix('_underwear')
		if !GeneratorData.transforms.has(stat):
			continue
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if (transform.type in ['texture']):
				continue
			apply_transform(transform)
	
	_root.render_target_clear_mode = Viewport.CLEAR_MODE_ONLY_NEXT_FRAME
	_root.render_target_update_mode = Viewport.UPDATE_ONCE


func apply_transform(transform):
	match transform.type:
		'texture':
			var nd = _root.get_node(transform.node)
			if transform.texture != null:
				nd.texture = load(transform.texture)
			else:
				nd.texture = null
		'texture_set':
			var arr_tr = GeneratorData.texture_sets[transform.set]
			for sub_transform in arr_tr:
				apply_transform(sub_transform)
		'node_attr':
			var nd = _root.get_node(transform.node)
			nd.set(transform.attr, transform.value)
		'node_group_attr': #group hide or unhide mostly
			var nodes = get_tree().get_nodes_in_group(transform.group)
			for nd in nodes:
				if !self.is_a_parent_of(nd):
					continue
				nd.set(transform.attr, transform.value)
		'node_group_select': #show one from group, == group hide + single show
			var nodes = get_tree().get_nodes_in_group(transform.group)
			for nd in nodes:
				if !self.is_a_parent_of(nd):
					continue
				if nd.name == transform.select:
					nd.visible = true
				else:
					nd.visible = false
		'import_deform':
			var nd = _root.get_node(transform.node)
			if transform.has('ids'):
				input_handler.import_deform_parameter(nd.material, load(transform.material), transform.ids)
			else:
				input_handler.import_deform_parameter(nd.material, load(transform.material))
		'import_deform_group':
			var nodes = get_tree().get_nodes_in_group(transform.group)
			for nd in nodes:
				if !self.is_a_parent_of(nd):
					continue
				if transform.has('ids'):
					input_handler.import_deform_parameter(nd.material, load(transform.material), transform.ids)
				else:
					input_handler.import_deform_parameter(nd.material, load(transform.material))
		'import_recolor':
			var nd = _root.get_node(transform.node)
			if transform.has('ids'):
				input_handler.import_recolor_parameter(nd.material, load(transform.material), transform.ids)
			else:
				input_handler.import_recolor_parameter(nd.material, load(transform.material))
		'import_recolor_group':
			var nodes = get_tree().get_nodes_in_group(transform.group)
			for nd in nodes:
				if !self.is_a_parent_of(nd):
					continue
				if transform.has('ids'):
					input_handler.import_recolor_parameter(nd.material, load(transform.material), transform.ids)
				else:
					input_handler.import_recolor_parameter(nd.material, load(transform.material))
		'import_mask':
			var nd = _root.get_node(transform.node)
			if transform.has('ids'):
				input_handler.import_recolor_mask(nd.material, load(transform.material), transform.ids)
			else:
				input_handler.import_recolor_mask(nd.material, load(transform.material))
		'import_mask_group':
			var nodes = get_tree().get_nodes_in_group(transform.group)
			for nd in nodes:
				if !self.is_a_parent_of(nd):
					continue
				if transform.has('ids'):
					input_handler.import_recolor_mask(nd.material, load(transform.material), transform.ids)
				else:
					input_handler.import_recolor_mask(nd.material, load(transform.material))
		'import_mask_path':
			var nd = _root.get_node(transform.node)
			var mat = null
			if transform.material != null: #if else - effectively block slot
				mat = load(transform.material)
			if transform.has('ids'):
				input_handler.import_recolor_mask_path(nd.material, mat, transform.ids)
			else:
				input_handler.import_recolor_mask_path(nd.material, mat)
		'import_mask_group_path':
			var nodes = get_tree().get_nodes_in_group(transform.group)
			var mat = null
			if transform.material != null:
				mat = load(transform.material)
			for nd in nodes:
				if !self.is_a_parent_of(nd):
					continue
				if transform.has('ids'):
					input_handler.import_recolor_mask_path(nd.material, mat, transform.ids)
				else:
					input_handler.import_recolor_mask_path(nd.material, mat)
		'scale':
			__scale_x *= transform.value
			__scale_y *= transform.value
		'offset':
			_offset += Vector2(transform.value_x, transform.value_y)
		'item_recolor':
			var nd = _root.get_node(transform.node)
			var mat = nd.material
			mat.set_shader_param(transform.part, transform.color)
		'item_recolor_group':
			var nodes = get_tree().get_nodes_in_group(transform.group)
			for nd in nodes:
				if !self.is_a_parent_of(nd):
					continue
				var mat = nd.material
				mat.set_shader_param(transform.part, transform.color)


func save_portrait(name):
	var dir = Directory.new()
	if !dir.dir_exists(variables.portraits_folder):
		dir.make_dir(variables.portraits_folder)
	var path = variables.portraits_folder + name + '.png'
	
	yield(get_tree(), 'idle_frame')
	yield(get_tree(), 'idle_frame')
#	yield(get_tree().create_timer(0.3), "timeout")
	var texture = $VPC/VP.get_texture()
#	var texture = get_tree().get_root().get_texture()
	var image = texture.get_data()
#	image.resize(ProjectSettings.get("display/window/size/width"), ProjectSettings.get("display/window/size/height"), 3)
	image.flip_y()
#	image.save_png(path)

	for nd in get_tree().get_nodes_in_group('portrait'):
		if !self.is_a_parent_of(nd) or !nd.is_visible_in_tree():
			continue
#		print(input_handler.get_real_global_rect(nd))
		image = image.get_rect(input_handler.get_real_global_rect(nd))
#		nd.texture = texture
#		image.flip_y()
#		image.resize(variables.portrait_width, variables.portrait_height)
		image.save_png(path)
	input_handler.emit_signal("PortraitUpdate")


func get_tits_node(): #currently shown female tits bone, null when there is nothing to wobble
	if !_tits_searched:
		_tits_searched = true
		_tits_node = null
		_tits_outline = null
		if _root.get_node('Female_pose').visible:
			for nd in get_tree().get_nodes_in_group('tits'):
				if !is_a_parent_of(nd) or !nd.visible:
					continue
				if nd.get_node_or_null('Tits_mesh') == null: #flat chest has no mesh of its own
					continue
				_tits_node = nd
				break
	return _tits_node


func get_tits_mesh():
	var nd = get_tits_node()
	if nd == null:
		return null
	return nd.get_node('Tits_mesh')


func get_tits_outline(): #border of the tits polygon, without its inner deform vertices
	if _tits_outline == null:
		_tits_outline = PoolVector2Array()
		var mesh = get_tits_mesh()
		if mesh != null:
			var points = mesh.polygon
			for i in max(points.size() - mesh.internal_vertex_count, 0):
				_tits_outline.append(points[i])
	return _tits_outline


func jiggle_tits(power = 1.0):
	if !is_visible_in_tree():
		return
	var nd = get_tits_node()
	if nd == null:
		return
	stop_tits_jiggle()
	var seen = []
	for mesh in nd.get_children():
		if !(mesh is CanvasItem):
			continue
		var mat = mesh.material
		if !(mat is ShaderMaterial) or mat in seen: #huge and big share an armor material
			continue
		if mat.get_shader_param('anchor2') == null:
			continue
		seen.append(mat)
		#null means the parameter was never imported, the shader defaults are zero
		var base2 = mat.get_shader_param('move2')
		var base3 = mat.get_shader_param('move3')
		var range2 = mat.get_shader_param('range2')
		var range3 = mat.get_shader_param('range3')
		if base2 == null:
			base2 = Vector2(0, 0)
		if base3 == null:
			base3 = Vector2(0, 0)
		if range2 == null:
			range2 = 0.0
		if range3 == null:
			range3 = 0.0
		_jiggle_mats.append({mat = mat, move2 = base2, move3 = base3, range2 = range2, range3 = range3})
	if _jiggle_mats.empty():
		return
	#some presets ship with a zero range, which would swallow the shift entirely
	for entry in _jiggle_mats:
		entry.mat.set_shader_param('range2', max(entry.range2, TITS_JIGGLE_RANGE))
		entry.mat.set_shader_param('range3', max(entry.range3, TITS_JIGGLE_RANGE))
	_jiggle_time = 0.0
	_jiggle_power = clamp(power, 0.1, 2.0)
	_root.render_target_clear_mode = Viewport.CLEAR_MODE_ALWAYS
	_root.render_target_update_mode = Viewport.UPDATE_ALWAYS
	set_process(true)


func stop_tits_jiggle(): #also drops the cached lookup, rebuilds may swap the tits node
	_tits_searched = false
	if _jiggle_mats.empty():
		return
	for entry in _jiggle_mats:
		entry.mat.set_shader_param('move2', entry.move2)
		entry.mat.set_shader_param('move3', entry.move3)
		entry.mat.set_shader_param('range2', entry.range2)
		entry.mat.set_shader_param('range3', entry.range3)
	_jiggle_mats = []
	set_process(false)
	_root.render_target_clear_mode = Viewport.CLEAR_MODE_ONLY_NEXT_FRAME
	_root.render_target_update_mode = Viewport.UPDATE_ONCE


func _process(delta):
	if _jiggle_mats.empty() or !is_visible_in_tree():
		stop_tits_jiggle()
		return
	_jiggle_time += delta
	if _jiggle_time >= TITS_JIGGLE_TIME:
		stop_tits_jiggle()
		return
	var wave = sin(_jiggle_time * TAU * TITS_JIGGLE_FREQ) * TITS_JIGGLE_SHIFT * _jiggle_power
	wave *= exp(-_jiggle_time * TITS_JIGGLE_DECAY)
	#mesh space is axis aligned with the screen here, positive y pulls the nipples down
	var shift = Vector2(0, wave)
	for entry in _jiggle_mats:
		entry.mat.set_shader_param('move2', entry.move2 + shift)
		entry.mat.set_shader_param('move3', entry.move3 + shift)


func apply_settings():
	$VPC/VP/Female_pose/HumanF1/Spine/Taz/Dick/Testicles_tex.visible = input_handler.globalsettings.futa_balls
#	$VPC/VP/Female_pose/HumanF1/Spine/Taz/Dick/.visible = input_handler.globalsettings.furry_multiple_nipples
