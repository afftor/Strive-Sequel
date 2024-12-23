extends Reference

var combatnode
var animationnode

var is_active = false

var main_queue = []
var head
var tail

var cashed_handlers = []


const end_combat_handler = preload("res://src/combat/end_combat_handler.gd")
const start_combat_handler = preload("res://src/combat/start_combat_handler.gd")
const end_action_handler = preload("res://src/combat/end_action_handler.gd")
const atomic_handler = preload("res://src/combat/atomic_effect_handler.gd")
const animation_handler = preload("res://src/combat/animation_handler.gd")
const skill_iteration_handler = preload("res://src/combat/combat_skill_iteration_handler.gd")
const skill_callback_handler = preload("res://src/combat/combat_skill_callback_handler.gd")
const skill_instance_handler = preload("res://src/combat/combat_skill_instance_handler.gd") #not for usage here

signal queue_empty

func _init():
	#incomplete or should be set up from outside
	main_queue.resize(50)
	head = 40
	tail = 41


func is_empty():
#	if !cashed_handlers.empty():
#		return false
	return tail == head + 1

#manipulations

func force_clean():
	if !is_empty():
		print("warning - force clean action queue")
		#actually error - for there can be memory leak
		for i in range(head + 1, tail):
			main_queue[i] = null
		cashed_handlers.clear()


func reinit():
	force_clean()
	head = 40
	tail = 41


func add_handler_head(handler):
	if head == 0:
		print("error - queue limit exeeded")
		return
	main_queue[head] = handler
	head -= 1


func add_handler_tail(handler):
	if tail == 49:
		print("error - queue limit exeeded")
		return
	main_queue[tail] = handler
	tail += 1


func pop_head():
	head += 1
	main_queue[head] = null

#main cycle
func check_animation():
	animationnode.check_start()
	return animationnode.is_busy 
#	if animationnode.is_busy: 
#		yield(animationnode, 'alleffectsfinished')


func apply_cash():
	var res = false
	while !cashed_handlers.empty():
		res = true
		var tmp = cashed_handlers.pop_back()
		add_handler_head(tmp)
	return res


func invoke():
	if is_empty():
		print("error - invoking empty queue")
		is_active = false
		return
	
	main_queue[head + 1].invoke()


func invoke_finished():
	pop_head()
	if !is_empty():
		is_active = true
		invoke()
	else:
		is_active = false
		emit_signal("queue_empty")


func invoke_resume():
	if !is_empty():
		is_active = true
		invoke()
	else:
		is_active = false
		print("error - resuming empty queue")
		emit_signal("queue_empty")


#helpers
func add_end_combat(value):
	if !is_empty():
		var tmp = main_queue[tail - 1]
		if tmp is end_combat_handler:
			return
	var template = {code = 'end_combat', value = value}
	var handler = end_combat_handler.new()
	handler.template = template.duplicate()
	handler.combatnode = combatnode
	handler.queuenode = self
	add_handler_tail(handler)


func add_end_action(character, not_eot = false):
	if !is_empty():
		var tmp = main_queue[tail - 1]
		if tmp is end_action_handler or tmp is end_combat_handler:
			return
	var template = {code = 'end_action', person = character, not_eot = not_eot}
	var handler = end_action_handler.new()
	handler.template = template.duplicate()
	handler.combatnode = combatnode
	handler.queuenode = self
	add_handler_tail(handler)


func add_start_combat():
	var template = {code = 'start_combat'}
	var handler = start_combat_handler.new()
	handler.combatnode = combatnode
	handler.queuenode = self
	add_handler_tail(handler)


func add_atomic(template, character):
	var handler = atomic_handler.new()
	handler.template = template.duplicate(true)
	handler.combatnode = combatnode
	handler.queuenode = self
	handler.character = character
	cashed_handlers.push_back(handler)


func add_animation(template):
	var handler = animation_handler.new()
	handler.template = template.duplicate(true)
	handler.combatnode = combatnode
	handler.queuenode = self
	cashed_handlers.push_back(handler)


func add_combatlog(text):
	var template = {node = combatnode, time = combatnode.turns, type = 'c_log', slot = 'c_log', params = {text = text}}
	add_animation(template)


func add_sfx(node, code):
	var template = {node = node, time = combatnode.turns, type = code, slot = 'SFX', params = {}}
	add_animation(template)


func add_crit(node):
	var template = {node = node, time = combatnode.turns, type = 'critical', slot = 'crit', params = {}}
	add_animation(template)


func add_rebuildbuffs(node): #test version
	var template = {node = node, time = combatnode.turns, type = 'buffs', slot = 'buffs', params = {}}
	var handler = animation_handler.new()
	handler.template = template.duplicate(true)
	handler.combatnode = combatnode
	handler.queuenode = self
	add_handler_head(handler)


func add_iteration():
	var handler = skill_iteration_handler.new()
	handler.combatnode = combatnode
	handler.queuenode = self
	add_handler_head(handler)
	return handler


func add_skill_callback(add_to_tail = false):
	var handler = skill_callback_handler.new()
	handler.combatnode = combatnode
	handler.queuenode = self
	if add_to_tail:
		var tmp = main_queue[tail - 1]
		if !(tmp is end_action_handler or tmp is end_combat_handler):
			add_handler_tail(handler)
	else:
		add_handler_head(handler)
	return handler
