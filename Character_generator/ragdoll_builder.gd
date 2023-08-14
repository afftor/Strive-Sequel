extends Node2D

export var clothes = true
export var test_mode = false

onready var _root = $VPC/VP

var _scale_x
var _scale_y

var __scale_x
var __scale_y

var _position
var _offset

var character
var test_template = {
	sex = 'female', 
	race = 'Lamia', 
	horns = 'short', 
	ears = 'bunny_standing', 
	eyeshape = 'face2', 
	eye_tex = 'eyes2', 
	eye_color = 'green', 
	eyebrows = 'style3', 
	lips = 'style3', 
	wings = 'demon', 
	tail = 'wolf', 
	penis_type = 'furry', 
	chin = 'thin', 
	nose = 'default', 
	pregnancy_status = 'no', 
	tits_size = 'huge', 
	skin_coverage = 'fur_white', 
	body_color_skin = 'blue5', 
	body_color_wings = 'red3', 
	body_color_tail = 'yellow1', 
	body_color_horns = 'yellow1', 
	body_color_animal = 'red3', 
	body_color_ears = 'red3', 
	hair_base = 'dopple', 
	hair_fringe = 'dopple', 
	hair_assist = 'braid', 
	hair_back = 'very_long', 
	hair_back_color_1 = 'green_1',
	hair_back_color_2 = 'red_3',
	hair_assist_color_1 = 'yellow_1',
	hair_assist_color_2 = 'pink_3',
	hair_base_color_1 = 'red_2',
	hair_base_color_2 = 'dark_3',
	hair_fringe_color_1 = 'blue_2',
	hair_fringe_color_2 = 'white_3',
	hair_base_lenght = 'long', 
	hair_fringe_lenght = 'long', 
	hair_back_lenght = 'long', 
	hair_assist_lenght = 'long', 
#	armor_base = 'chest_adv_metal', 
	armor_base = 'servant', 
#	armor_lower = 'legs_adv_metal',
	armor_lower = 'servant',
	armor_color_base = 'default',
	armor_color_lower = 'default',
	height = 'towering',
	ass_size = 'small',
	pose = 'pose4',
}

func _ready():
#	var shader = load("res://assets/ItemShader.tres").duplicate()
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


func _get_stat(stat):
	if test_mode or character == null:
		return test_template[stat]
	else:
		return character.get_stat(stat)


func rebuild(character_to_build):
	if !is_visible_in_tree():
		return
	#setup
	__scale_x = _scale_x
	__scale_y = _scale_y
#	position = _position
	set_position(Vector2(0, 0))
	_offset = Vector2(0.0, 0.0)
	
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
	_root.get_node('male_pose').position = _position + _offset
	_root.get_node('Female_pose').position = _position + _offset
	_root.get_node('male_pose').scale = Vector2(__scale_x, __scale_y)
	_root.get_node('Female_pose').scale = Vector2(__scale_x, __scale_y)

	_root.render_target_clear_mode = Viewport.CLEAR_MODE_ONLY_NEXT_FRAME
	_root.render_target_update_mode = Viewport.UPDATE_ONCE
	if character != null:
		character.update_portrait(self)


func rebuild_stat(statname):
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
	for stat in ['armor_base', 'armor_lower']:
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
	for stat in ['armor_color_base', 'armor_color_lower', 'armor_base', 'armor_lower']:
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
