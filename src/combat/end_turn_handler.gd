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
	combatnode.call_deferred('force_newturn')

