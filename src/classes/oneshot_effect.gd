extends base_effect
class_name oneshot_effect
#non-reverecible effects that exist in effect_pool only inbetween stable states
#only one effects that can modify skill handlers
#usage is more limited then before - for a number of them were hardcoded
#have no additional args data due to being sub-only

var applied_obj = null
var atomic = []

func _init(caller).(caller):
	pass


func get_applied_obj():
	return applied_obj


func apply(data = {}):
	var tres = true
	if template.has('conditions'):
		for cond in template.conditions:
			tres = tres && applied_obj.process_check(cond)
	if !tres: return
	atomic.clear()
	calculate_args(data)
	for a in template.atomic:
		var tmp := atomic_effect.new(a, self)
		tmp.resolve_template()
		applied_obj.apply_atomic(tmp.template)
		atomic.push_back(tmp.template)
	sub_effects.clear()
	for e in template.sub_effects:
		var tmp = effects_pool.e_createfromtemplate(e)
		#tmp.calculate_args()
		tmp.calculate_args({})
		sub_effects.push_back(effects_pool.add_effect(tmp))
		applied_obj.apply_effect(tmp, get_args_resolved())

