extends Reference

var template
var character

var combatnode
var queuenode

var step = 0
var state_map = ['invoke_triggers', 'invoke_finish']

#real queue part
func invoke():
	call(state_map[step])


func invoke_triggers():
	var tchar = characters_pool.get_char_by_id(character)
	tchar.apply_atomic_noqueue(template)
	step += 1
	queuenode.call_deferred('invoke_resume')


func invoke_finish():
	queuenode.call_deferred('invoke_finished')
