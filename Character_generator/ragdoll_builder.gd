extends Node

func _ready():
	pass # Replace with function body.


var clothes = true


func rebuild(character):
	#first pass - textures
	for stat in GeneratorData.stats_to_look:
		if !GeneratorData.transforms.has(stat):
			continue
		var st_val = character.get_stat(stat)
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
		var st_val = character.get_stat(stat)
		if !GeneratorData.transforms[stat].has(st_val):
			continue
		for transform in GeneratorData.transforms[stat][st_val]:
			if (transform.type in ['texture', 'texture_set']):
				continue
			apply_transform(transform)


func rebuild_cloth(value):
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


func apply_transform(transform):
	match transform.type:
		'texture':
			var nd = get_node(transform.node)
			nd.texture = load(transform.texture)
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
