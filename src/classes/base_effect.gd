extends Reference
class_name base_effect

var parent = null
var id
var template
var args : = []
var self_args := {}
var sub_effects := []
var tags := []
var buffs := []
var atomic := []
var is_applied
var applied_pos = null
var applied_char = null

func _init(caller):
	parent = caller
	is_applied = false

func apply():
	var obj = get_applied_obj()
	is_applied = true
	atomic.clear()
	calculate_args()
	for a in template.atomic:
		var tmp := atomic_effect.new(a, id)
		tmp.resolve_template()
		#tmp.apply_template(obj)
		obj.apply_atomic(tmp.template)
		atomic.push_back(tmp.template)
	sub_effects.clear()
	for e in template.sub_effects:
		var tmp = effects_pool.e_createfromtemplate(e, id)
		#tmp.calculate_args()
		sub_effects.push_back(effects_pool.add_effect(tmp))
		pass
	setup_siblings()
	rebuild_buffs()

func reapply():
	var obj = get_applied_obj()
	for a in atomic:
		obj.remove_atomic(a)
	atomic.clear()
	for a in template.atomic:
		var tmp := atomic_effect.new(a, id)
		tmp.resolve_template()
		obj.apply_atomic(tmp.template)
		atomic.push_back(tmp.template)
	for e in sub_effects:
		var t = effects_pool.get_effect_by_id(e)
		t.remove()
	sub_effects.clear()
	for e in template.sub_effects:
		var tmp = effects_pool.e_createfromtemplate(e, id)
		sub_effects.push_back(effects_pool.add_effect(tmp))
		pass
	setup_siblings()
	rebuild_buffs()
	

func setup_siblings():
	if sub_effects.size() < 2:
		return
	for se in sub_effects:
		var eff = effects_pool.get_effect_by_id(se)
		eff.self_args['siblings'] = sub_effects.duplicate()
		eff.self_args['siblings'].erase(se)

func remove_siblings():
	if !self_args.has('siblings'):return
	for se in self_args['siblings']:
		var eff = effects_pool.get_effect_by_id(se)
		eff.remove()

func recheck(): #overriden in condition_static effect, have no meaning in other cases
	pass

func remove():
	if !is_applied: return
	var obj = get_applied_obj()
	if obj != null:
		obj.remove_effect(id)
		for a in atomic:
			obj.remove_atomic(a)
	atomic.clear()
	buffs.clear()

func get_applied_obj():
	if applied_char == null:
		if applied_pos == null: return null
		applied_char = ResourceScripts.game_party.combatparty[applied_pos] #to change after final version of parties storing in state
	return characters_pool.get_char_by_id(applied_char)

func createfromtemplate(buff_t):
	if typeof(buff_t) == TYPE_STRING:
		template = Effectdata.effect_table[buff_t].duplicate()
	else:
		template = buff_t.duplicate()
	if template.has('tags'):
		tags = template.tags.duplicate()
	if !template.has('sub_effects'):
		template['sub_effects'] = []
	if !template.has('buffs'):
		template['buffs'] = []
	if !template.has('atomic'):
		template['atomic'] = []

func calculate_args():
	args.clear()
	if template.has('args'):
		for arg in template.args:
			match arg.obj:
				'self':
					args.push_back(self_args[arg.param])
					pass
				'parent':
					var par
					if typeof(parent) == TYPE_STRING:
						par = effects_pool.get_effect_by_id(parent)
					else:
						par = parent
					if par == null:
						args.push_back(null)
					else:
						args.push_back(par.get(arg.param))
					pass
				'template':
					args.push_back(template[arg.param])
				'parent_args':
					var par
					if typeof(parent) == TYPE_STRING:
						par = effects_pool.get_effect_by_id(parent)
					else:
						par = parent
					if par == null:
						args.push_back(null)
					else:
						args.push_back(par.get_arg(int(arg.param)))
				'parent_arg_get':
					var par
					if typeof(parent) == TYPE_STRING:
						par = effects_pool.get_effect_by_id(parent)
					else:
						par = parent
					if par == null:
						args.push_back(null)
					else:
						args.push_back(par.get_arg(arg.index).get(arg.param))
				'app_obj':
					var par = get_applied_obj()
					args.push_back(par.get(arg.param))

func get_arg(index):
	var arg = template.args[index]
	if arg.has('dynamic') || args[index] == null:
		match arg.obj:
			'parent':
				var par
				if typeof(parent) == TYPE_STRING:
					par = effects_pool.get_effect_by_id(parent)
				else:
					par = parent
				if par != null:
					args[index] = par.get(arg.param)
				pass
			'parent_args':
				var par
				if typeof(parent) == TYPE_STRING:
					par = effects_pool.get_effect_by_id(parent)
				else:
					par = parent
				if par != null:
					args[index] = par.get_arg(int(arg.param))
			'parent_arg_get':
				var par
				if typeof(parent) == TYPE_STRING:
					par = effects_pool.get_effect_by_id(parent)
				else:
					par = parent
				if par != null:
					args[index] = par.get_arg(int(arg.index)).get(arg.param)
			'app_obj':
				var par = get_applied_obj()
				args[index] = par.get(arg.param)
	return args[index]

func set_args(arg, value):
	self_args[arg] = value
	#calculate_args()

func serialize():
	var tmp := {}
	tmp['is_applied'] = is_applied
	tmp['template'] = template
	tmp['args'] = self_args
	tmp['sub_effects'] = sub_effects
	tmp['type'] = 'base'
	tmp['atomic'] = atomic
	tmp['buffs'] = []
	tmp['app_pos'] = applied_pos
	tmp['app_char'] = applied_char
	for b in buffs:
		tmp['buffs'].push_back(b.serialize())
	return tmp

func deserialize(tmp):
	is_applied = tmp['is_applied']
	template = tmp['template'].duplicate()
	if template.has('tags'):
		tags = template.tags.duplicate()
	self_args = tmp['args'].duplicate()
	sub_effects = tmp['sub_effects'].duplicate()
	atomic = tmp['atomic'].duplicate()
#warning-ignore:incompatible_ternary
	applied_pos = null if (tmp['app_pos'] == null) else int(tmp['app_pos'])
	applied_char = tmp['app_char']
	buffs.clear()
	calculate_args()
	for b in tmp['buffs']:
		var t = Buff.new(id)
		t.deserialize(b)
		buffs.push_back(t)
	pass

func rebuild_buffs():
	buffs.clear()
	for e in template.buffs:
		var tmp = Buff.new(id)
		tmp.createfromtemplate(e)
		tmp.calculate_args()
		buffs.push_back(tmp)

func clear_buffs():
	buffs.clear()
