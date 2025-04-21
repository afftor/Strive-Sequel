extends base_effect
class_name temp_e_simple
#temp effect with unlimited stacking and icon for each instance
#to limit stacking use counting methods in combatant and reset duration (make sure not to use parent linkings for limited stackable temps)
#to limit one icon for all instances use corresponding counting methods with one_icon flag
#ALL TEMP EFFECTS ARE NAMED - their template has to have 'name' field (even if effect has no id in effects table)
#rem_event removes all instances of effect
var remains := -1

func _init(caller).(caller):
	pass


func createfromtemplate(tmp):
	.createfromtemplate(tmp)


func calculate_duration():
	var res = get_arg('duration')
	var skill = get_arg('skill')
	if res == null:
		res = template.duration
		if !(res is int):
			print("error in duration template")
	if skill != null:
		if template.tags.has('negative') and skill.target.get_stat('personality') == 'bold' and res > 1:
			res -= 1
		if template.tags.has('positive') and skill.caster.get_stat('personality') == 'kind' and res > 0:
			res += 1
	return res


func apply():
	.apply()
	if template.has('duration'):
		remains = calculate_duration()


func process_tick(ev):
	if !is_applied: return
	var res = variables.TE_RES_NOACT
	if template.has('tick_event') and template.tick_event.has(ev):
			res = variables.TE_RES_TICK
			remains -= 1
			for b in buffs:
				b.calculate_args()
			if remains == 0:
				remove()
				res = variables.TE_RES_REMOVE
	if template.has('rem_event') and template.rem_event.has(ev):
		remove()
		res = variables.TE_RES_REMOVE
	return res


func merge_duration(t_eff):
	if t_eff.template.has('duration'):
		t_eff.calculate_duration()
		remains = int(max(t_eff.template.duration, remains))


func serialize():
	var tmp = .serialize()
	tmp['type'] = 'temp_s'
	tmp['remains'] = remains
	return tmp


func deserialize(tmp):
	.deserialize(tmp)
	remains = int(tmp.remains)


func get_duration():
	if remains <= 0: return null
	var res = {}
	res.count = remains
	res.event = null
	if template.tick_event.has(variables.TR_TICK): 
		res.event = "hours"#2fix
		#res.count *= 6
	if template.tick_event.has(variables.TR_TURN_F) or template.tick_event.has(variables.TR_TURN_S) or template.tick_event.has(variables.TR_TURN_GET): 
		res.event = "turns"
	if template.tick_event.has(variables.TR_DEF) or template.tick_event.has(variables.TR_POST_TARG) or template.tick_event.has(variables.TR_CAST_TARGET): 
		res.event = "hits" 
	if template.tick_event.has(variables.TR_CAST) or template.tick_event.has(variables.TR_HIT) or template.tick_event.has(variables.TR_POSTDAMAGE): 
		res.event = "attacks" 
	return res

