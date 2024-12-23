extends Reference

var template

var combatnode
var queuenode

#real queue part
func invoke():
	
	queuenode.animationnode.add_new_data(template)
	queuenode.call_deferred('invoke_finished')
