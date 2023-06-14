extends Node2D

export var clothes = true
export var test_mode = false

var _scale_x
var _scale_y

var __scale_x
var __scale_y

var _position
var _offset

var character
var test_template = {
	sex = 'female', 
	race = 'BeastkinWolf', 
	horns = '', 
	ears = 'elven', 
	eyeshape = 'face2', 
	eye_tex = 'eyes2', 
	eye_color = 'green', 
	eyebrows = 'style3', 
	lips = 'style3', 
	wings = '', 
	tail = 'wolf', 
	penis_type = 'furry', 
	chin = 'beastkin', 
	nose = 'default', 
	pregnancy_status = 'no', 
	tits_size = 'average_narrow', 
	skin_coverage = 'fur_orange_white', 
	body_color_skin = 'blue1', 
	body_color_wings = 'yellow3', 
	body_color_tail = 'yellow2', 
	body_color_horns = 'yellow1', 
	body_color_animal = 'red3', 
	hair_base = 'dopple', 
	hair_assist = 'bun', 
	hair_back = 'dishevel', 
	hair_back_color_1 = 'red_1',
	hair_back_color_2 = 'green_2',
	hair_assist_color_1 = 'red_2',
	hair_assist_color_2 = 'blue_3',
	hair_base_color_1 = 'red_3',
	hair_base_color_2 = 'purple_1',
	hair_base_lenght = 'short', 
	hair_back_lenght = 'short', 
	hair_assist_lenght = 'long', 
	armor_base = 'chest_base_metal', 
	armor_lower = 'legs_base_metal',
	height = 'average'
}

func _ready():
	_position = position
	if test_mode:
		position = Vector2(400, 300)
		_scale_x = 0.5
		_scale_y = 0.5
		rebuild(null)
		rebuild_cloth(clothes)
	else:
		_scale_x = scale.x
		_scale_y = scale.y


func _get_stat(stat):
	if test_mode or character == null:
		return test_template[stat]
	else:
		return character.get_stat(stat)


func rebuild(character_to_build):
	#setup
	__scale_x = _scale_x
	__scale_y = _scale_y
	position = _position
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
	scale = Vector2(__scale_x, __scale_y)
	position += _offset


func rebuild_cloth(value):
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
	for stat in ['armor_base', 'armor_lower']:
		if !GeneratorData.transforms.has(stat):
			continue
		var st_val = _get_stat(stat)
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if (transform.type in ['texture']):
				continue
			apply_transform(transform)


func apply_transform(transform):
	match transform.type:
		'texture':
			var nd = get_node(transform.node)
			if transform.texture != null:
				nd.texture = load(transform.texture)
			else:
				nd.texture = null
		'texture_set':
			var arr_tr = GeneratorData.texture_sets[transform.set]
			for sub_transform in arr_tr:
				apply_transform(sub_transform)
		'node_attr':
			var nd = get_node(transform.node)
			nd.set(transform.attr, transform.value)
		'node_group_attr': #group hide or unhide mostly
			var nodes = get_tree().get_nodes_in_group(transform.group)
			for nd in nodes:
				nd.set(transform.attr, transform.value)
		'node_group_select': #show one from group, == group hide + single show
			var nodes = get_tree().get_nodes_in_group(transform.group)
			for nd in nodes:
				if nd.name == transform.select:
					nd.visible = true
				else:
					nd.visible = false
		'import_deform':
			var nd = get_node(transform.node)
			if transform.has('ids'):
				input_handler.import_deform_parameter(nd.material, load(transform.material), transform.ids)
			else:
				input_handler.import_deform_parameter(nd.material, load(transform.material))
		'import_deform_group':
			var nodes = get_tree().get_nodes_in_group(transform.group)
			for nd in nodes:
				if transform.has('ids'):
					input_handler.import_deform_parameter(nd.material, load(transform.material), transform.ids)
				else:
					input_handler.import_deform_parameter(nd.material, load(transform.material))
		'import_recolor':
			var nd = get_node(transform.node)
			if transform.has('ids'):
				input_handler.import_recolor_parameter(nd.material, load(transform.material), transform.ids)
			else:
				input_handler.import_recolor_parameter(nd.material, load(transform.material))
		'import_recolor_group':
			var nodes = get_tree().get_nodes_in_group(transform.group)
			for nd in nodes:
				if transform.has('ids'):
					input_handler.import_recolor_parameter(nd.material, load(transform.material), transform.ids)
				else:
					input_handler.import_recolor_parameter(nd.material, load(transform.material))
		'import_mask':
			var nd = get_node(transform.node)
			if transform.has('ids'):
				input_handler.import_recolor_mask(nd.material, load(transform.material), transform.ids)
			else:
				input_handler.import_recolor_mask(nd.material, load(transform.material))
		'import_mask_group':
			var nodes = get_tree().get_nodes_in_group(transform.group)
			for nd in nodes:
				if transform.has('ids'):
					input_handler.import_recolor_mask(nd.material, load(transform.material), transform.ids)
				else:
					input_handler.import_recolor_mask(nd.material, load(transform.material))
		'import_mask_path':
			var nd = get_node(transform.node)
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
				if transform.has('ids'):
					input_handler.import_recolor_mask_path(nd.material, mat, transform.ids)
				else:
					input_handler.import_recolor_mask_path(nd.material, mat)
		'scale':
			__scale_x *= transform.value
			__scale_y *= transform.value
		'offset':
			_offset += Vector2(transform.value_x, transform.value_y)
		#reworked
		'item_recolor':
			var nd = get_node(transform.node)
			var mat = nd.material
			mat.set_hader_param(transform.part, transform.color)
		'item_recolor_group':
			var nodes = get_tree().get_nodes_in_group(transform.group)
			for nd in nodes:
				var mat = nd.material
				mat.set_hader_param(transform.part, transform.color)
