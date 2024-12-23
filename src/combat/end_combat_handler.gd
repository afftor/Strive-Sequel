extends Reference

var template

var combatnode
var queuenode

#real queue part
func invoke():
	if queuenode.apply_cash():
		queuenode.call_deferred('invoke_resume')
		return
	if queuenode.check_animation():
		yield(queuenode.animationnode, 'alleffectsfinished')
	
	queuenode.call_deferred('invoke_finished')
	if template.value:
		combatnode.victory()
	else:
		combatnode.defeat()
