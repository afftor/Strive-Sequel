extends Reference

var template

var combatnode
var queuenode

var step = 0
var state_map = ['invoke_triggers', 'invoke_finish']

#real queue part
func invoke():
	if queuenode.apply_cash():
		queuenode.call_deferred('invoke_resume')
		return
	if queuenode.check_animation():
		yield(queuenode.animationnode, 'alleffectsfinished')
	
	call(state_map[step])


func invoke_triggers():
	combatnode.turns += 1
	template.person.process_event(variables.TR_TURN_F)
	effects_pool.process_event(variables.TR_TURN_F, template.person)
	queuenode.add_rebuildbuffs(template.person.displaynode)
	step += 1
	queuenode.call_deferred('invoke_resume')


func invoke_finish():
	queuenode.call_deferred('invoke_finished')
	if template.not_eot:
		combatnode.call_deferred('current_turn')
	else:
		combatnode.call_deferred('select_actor')
