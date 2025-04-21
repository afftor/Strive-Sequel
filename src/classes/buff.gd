extends Reference
class_name Buff

var icon:String setget ,get_icon
var description:String = "" setget ,get_tooltip
var parent
var template
var args: = []
var self_args := []
var tags = []

func _init(caller):
	parent = caller


func createfromtemplate(buff_t):
	if typeof(buff_t) == TYPE_STRING:
		template = Effectdata.buffs[buff_t]
	else:
		template = buff_t.duplicate()
	description = tr(template.description)
	icon = template.icon
	if template.has('tags'): 
		tags = template.tags.duplicate(true)

func get_tooltip():
	if tags.has('unified_desc') or args.empty():
		return description
	else:
		calculate_args()
		return description % args

func get_icon():
	return input_handler.loadimage(icon, 'icons')


func calculate_args():
	args.clear()
	if template.has('args'):
		for arg in template.args:
			match arg:
				'parent':
					args.push_back(parent.get(arg.param))
				'template':
					args.push_back(template[arg.param])
				'parent_args':
					args.push_back(parent.get_arg(int(arg.param)))
				'duration':
					args.push_back(parent.remains)
				'stacks':
					args.push_back(parent.get_active_effects().size())
		pass

func get_duration():
	if parent == null: return null
	var par = effects_pool.get_effect_by_id(parent)
	return par.get_duration()

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
	if template.has('tags'): 
		tags = template.tags.duplicate(true)

