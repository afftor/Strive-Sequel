extends Reference
class_name base_effect

var parent = null
var owner = null
var id
var template
var template_id = null
var args  = {}
var sub_effects := []
var buffs = []
var is_applied
var is_stored = true

func _init(caller):
	parent = caller
	is_applied = false

func apply():
	is_applied = true
	sub_effects.clear()
	for e in template.sub_effects:
		var tmp = effects_pool.e_createfromtemplate(e, id)
		tmp.is_applied = true
		tmp.owner = owner
		if tmp.template.type == 'oneshot':
			tmp.applied_obj = owner
			tmp.apply(get_args_resolved())
		else:
			tmp.is_stored = false
			sub_effects.push_back(effects_pool.add_effect(tmp))
			tmp.calculate_args(get_args_resolved())


func remove():
	if !is_applied: 
		return
	for e in sub_effects:
		var tmp = effects_pool.get_effect_by_id(e)
		tmp.is_applied = false
	var obj = get_applied_obj()
	if obj != null and is_stored:
		obj.remove_effect(id)


func get_applied_obj():
	if owner is String:
		return characters_pool.get_char_by_id(owner)
	else:
		return owner


func createfromtemplate(buff_t):
	if typeof(buff_t) == TYPE_STRING:
		template_id = buff_t
		template = Effectdata.effect_table[buff_t].duplicate(true)
	else:
		template = buff_t.duplicate(true)
	if !template.has('sub_effects'):
		template['sub_effects'] = []
	if !template.has('buffs'):
		template['buffs'] = []
	if !template.has('tags'):
		template['tags'] = []
	if !template.has('statchanges'):
		template['statchanges'] = {}


func calculate_args(data = {}): #one-time BEFORE apply() with ex in oneshots and triggers
#	args.clear()
	
	if template.has('args'):
		for rec in template.args:
			var arg = template.args[rec]
			var obj = null
			var val
			match arg.obj:
				'self':
					obj = arg
				'skill':
					if data.has('skill'):
						obj = data.skill
				'caster':
					if data.has('caster'):
						obj = data.caster
				'target':
					if data.has('target'):
						obj = data.target
				'parent':
					if parent is String:
						obj = effects_pool.get_effect_by_id(parent)
					else:
						obj = parent
				'owner':
					obj = get_applied_obj()
				_:
					if data.has(arg.obj):
						obj = data[arg.obj]
			if obj == null:
				if !args.has(rec):
					args[rec] = null
				continue
			if arg.has('dynamic') and arg.dynamic:
				args[rec] = 'dynamic'
				continue
			match arg.func:
				'get':
					args[rec] = obj.get(arg.arg)
				'arg':
					args[rec] = obj.get_arg(arg.arg)
				'stat':
					args[rec] = obj.get_stat(arg.stat)
				'eq':
					args[rec] = obj
				_:
					args[rec] = obj[arg.func]


func get_arg(rec):
	if !args.has(rec):
		return null
	if !(args[rec] is String) or args[rec] != 'dynamic':
		return args[rec]
	var arg = template.args[rec]
	var obj = null
	var val
	match arg.obj:
		'parent':
			if parent is String:
				obj = effects_pool.get_effect_by_id(parent)
			else:
				obj = parent
		'owner':
			obj = get_applied_obj()
	if obj == null:
		return null
	match arg.func:
		'get':
			return obj.get(arg.arg)
		'arg':
			return obj.get_arg(arg.arg)
		'stat':
			return obj.get_stat(arg.stat)


func get_args_resolved():
	var res = {}
	for arg in args:
		if args[arg] is String and args[arg] == 'dynamic':
			res[arg] = get_arg(arg)
		else:
			res[arg] = args[arg]
	return res


func serialize():
	var tmp := {}
	tmp['is_applied'] = is_applied
	if template_id != null:
		tmp['template'] = template_id
	else:
		tmp['template'] = template
	tmp['sub_effects'] = sub_effects
	tmp['type'] = 'base'
	tmp['owner'] = owner
	tmp['args'] = args.duplicate()
	return tmp


func deserialize(tmp):
	is_applied = tmp.is_applied
	if tmp.template is String:
		template_id = tmp.template
		template = Effectdata.effect_table[tmp.template].duplicate()
	else:
		template = tmp.template.duplicate()
	sub_effects = tmp.sub_effects.duplicate()
	args = tmp.args.duplicate()
	owner = tmp.owner
	if get_applied_obj() == null: return


func rebuild_buffs():
	buffs.clear()
	if template.has('conditions'):
		if !get_applied_obj().checkreqs(template.conditions):
			return
	for e in template.buffs:
		var tmp = Buff.new(id)
		tmp.createfromtemplate(e)
		tmp.calculate_args()
		buffs.push_back(tmp)


func clear_buffs():
	buffs.clear()


func get_duration():
	return null


func has_status(status):
	var act = true
	if template.has('conditions'):
		if !get_applied_obj().checkreqs(template.conditions):
			act = false
	if act:
		return template.tags.has(status)
	else:
		return false


func resolve_value(val):
	if val is Array:
		if val[0] is Array:
			val[0] = resolve_value(val[0])
		if val[0] is String:
			match val[0]:
				'random':
					var tmp = globals.rng.randi_range(val[1], val[2])
					val.pop_front()
					val.pop_front()
					val[0] = tmp
				'arg':
					var tmp = get_arg(val[1])
					val.pop_front()
					val[0] = tmp
				'arg_get':
					var tmp = get_arg(val[1]).get(val[2])
					val.pop_front()
					val.pop_front()
					val[0] = tmp
		while val.size() > 1:
			match val[1]:
				'+':
					val[2] = val[0] + resolve_value(val[2])
					pass
				'-':
					val[2] = val[0] - resolve_value(val[2])
					pass
				'*':
					val[2] = val[0] * resolve_value(val[2])
					pass
				'/':
					val[2] = val[0] / resolve_value(val[2])
					pass
			val.pop_front()
			val.pop_front()
		return val[0]
	else:
		return val
