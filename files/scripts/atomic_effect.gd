extends Reference
class_name atomic_effect

var template := {}
var parent


func _init(buff_ta, obj):
	if typeof(buff_ta) == TYPE_STRING:
		template = Effectdata.atomic[buff_ta]
	else:
		template = buff_ta.duplicate()
	parent = obj

func calculate_property(prop): #updated version. copy this to displaced
	if typeof(prop) != TYPE_ARRAY:
		return prop
	var res = 0
	var par = effects_pool.get_effect_by_id(parent)
	if typeof(prop[0]) == TYPE_ARRAY:
		prop[0] = calculate_property(prop[0])
	if typeof(prop[0]) == TYPE_STRING:
		match prop[0]:
			'parent':
				var value = par.get(prop[1])
				prop.pop_front()
				prop[0] = value
			'parent_args':
				var value = par.get_arg(prop[1])
				prop.pop_front()
				prop[0] = value
			'parent_arg_get':
				var value = par.get_arg(prop[1]).get(prop[2])
				prop.pop_front()
				prop.pop_front()
				prop[0] = value
			'random':
				var value = globals.rng.randi_range(prop[1], prop[2])
				prop.pop_front()
				prop.pop_front()
				prop[0] = value
				pass
	while prop.size() > 1:
		match prop[1]:
			'+':
				prop[2] = prop[0] + calculate_property(prop[2])
				pass
			'-':
				prop[2] = prop[0] - calculate_property(prop[2])
				pass
			'*':
				prop[2] = prop[0] * calculate_property(prop[2])
				pass
			'/':
				prop[2] = prop[0] / calculate_property(prop[2])
				pass
		prop.pop_front()
		prop.pop_front()
	return prop[0]

func resolve_template():
	for e in template.keys():
		if e == 'stats': continue
		if typeof(template[e]) == TYPE_ARRAY:
			template[e] = calculate_property(template[e])

#to move 
#func apply_template(obj):
#	match template.type:
#		'damage':
#			obj.deal_damage(template.value, template.source)
#			pass
#		'heal':
#			obj.heal(template.value)
#			pass
#		'mana':
#			obj.mana(template.value)
#			pass
#		'stat_set', 'stat_set_revert':
#			template.buffer = obj.get(template.stat)
#			obj.set(template.stat, template.value)
#			pass
#		'stat_add':
#			obj.set(template.stat, obj.get(template.stat) + template.value)
#			pass
#		'stat_mul':
#			obj.set(template.stat, obj.get(template.stat) * template.value)
#			pass
#		'signal':
#			#stub for signal emitting
#			globals.emit_signal(template.value)
#		'remove_effect': #stub
#			pass
#	pass

#func remove_template(obj):#to move
#	match template.type:
#		'stat_set_revert':
#			obj.set(template.stat, template.buffer)
#			pass
#		'stat_add':
#			obj.set(template.stat, obj.get(template.stat) - template.value)
#			pass
#		'stat_mul':
#			obj.set(template.stat, obj.get(template.stat) / template.value)
#			pass
#	pass
