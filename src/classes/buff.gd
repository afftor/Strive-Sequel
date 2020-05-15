extends Reference
class_name Buff

var icon:String setget ,get_icon
var description:String = "" setget ,get_tooltip
var parent
var template
var args: = []
var self_args := []
var template_name
var name setget ,get_name

func _init(caller):
	parent = caller


func createfromtemplate(buff_t):
	if typeof(buff_t) == TYPE_STRING:
		template = Effectdata.buffs[buff_t]
	else:
		template = buff_t.duplicate()
	description = tr(template.description)
	icon = template.icon
	template_name = template.t_name
	if template.has('name'): name = template.name
	else: name = template_name

func get_tooltip():
	calculate_args()
	return description % args

func get_icon():
	return input_handler.loadimage(icon, 'icons')

func get_name():
	return tr(name)

func calculate_args():
	args.clear()
	if template.has('args'):
		for arg in template.args:
			match arg.obj:
				'self':
					args.push_back(self_args[arg.param])
					pass
				'parent':
					var par = effects_pool.get_effect_by_id(parent)
					args.push_back(par.get(arg.param))
					pass
				'template':
					args.push_back(template[arg.param])
				'parent_args':
					var par
					par = effects_pool.get_effect_by_id(parent)
					args.push_back(par.get_arg(int(arg.param)))
		pass

func get_duration():
	var par = effects_pool.get_effect_by_id(parent)
	return par.get('remains')

func set_args(arg, value):
	self_args[arg] = value

func serialize():
	var tmp:= {}
	tmp['template'] = template
	tmp['args'] = self_args
	return tmp

func deserialize(tmp):
	template = tmp['template'].duplicate()
	self_args = tmp['args'].duplicate()
	description = tr(template.description)
	icon = template.icon
	template_name = template.t_name
	if template.has('name'): name = template.name
	else: name = template_name

func set_limit(val):
	template.limit = val
