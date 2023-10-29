extends base_effect
class_name temp_e_global
#temp effect with unlimited stacking and icon for each instance
#checks non-linked events, so do not get events from applied object directly
#can be buggy in complex constructions
#check correct applying trigger if using caster/target object tags - caster should be arg[0] and target - arg[1] as in helper function (also check a correct retrieving of skill value from arg[2] or any other)
#out-of-combat usages are not implemented
#to limit stacking use counting methods in combatant and reset duration (make sure not to use parent linkings for limited stackable temps)
#to limit one icon for all instances use corresponding counting methods with one_icon flag
#ALL TEMP EFFECTS ARE NAMED - their template has to have 'name' field (even if effect has no id in effects table)

var template_name


var timers = [] # of {events = [], objects = [ids] or group tag, timer: int}


func _init(caller).(caller):
	pass


func createfromtemplate(tmp):
	.createfromtemplate(tmp)
	template_name = template.name
	#2add
	timers = template.timers.duplicate(true)
	for timer in timers:
		if !timer.events is Array:
			timer.events = [timer.events]


func apply():
	.apply()
	#2add
	var obj = get_applied_obj()
	for timer in timers:
		if timer.objects is Array:
			for t_obj in timer.objects.duplicate():
				match t_obj:
					'owner':
						input_handler.array_replace(timer.objects, t_obj, obj.id)
					'caster':
						input_handler.array_replace(timer.objects, t_obj, effects_pool.get_effect_by_id(parent).get_arg(0).id)
					'target':
						input_handler.array_replace(timer.objects, t_obj, effects_pool.get_effect_by_id(parent).get_arg(1).id)
		else:
			match timer.objects:
				'owner':
					timer.objects = [obj.id]
				'caster':
					timer.objects = [effects_pool.get_effect_by_id(parent).get_arg(0).id]
				'target':
					timer.objects = [effects_pool.get_effect_by_id(parent).get_arg(1).id]
	for eff in sub_effects:
		obj.apply_effect(eff)


func process_event(ev, obj = null):
	if !is_applied: return
	for timer in timers:
		if !timer.events.has(ev): continue
		if timer.objects is Array:
			if !timer.objects.has(obj.id):
				continue
			timer.timer -= 1
		else:
			var check = false
			match timer.objects:
				'any_char':
					check = true
				'player_char':
					check = obj.combatgroup == 'ally'
				'enemy_char':
					check = obj.combatgroup == 'enemy'
				#mb 2add relative tags
			if check:
				timer.timer -= 1
		if timer.timer <= 0:
			remove()
			break
	if get_applied_obj().displaynode != null:
		get_applied_obj().displaynode.rebuildbuffs()


func reset_duration(): #should not be used due to setup
	#2add
	pass

func serialize():
	var tmp = .serialize()
	tmp['type'] = 'temp_global'
	tmp.timers = timers.duplicate(true)
	return tmp

func deserialize(tmp):
	.deserialize(tmp)
	timers.clear()
	for t_timer in tmp.timers:
		var temp = {}
		temp.timer = int(t_timer.timer)
		temp.events = []
		for ev in t_timer.events:
			temp.events.push_back(int(ev))
		if t_timer.objects is String:
			temp.objects = t_timer.objects
		else:
			temp.objects = t_timer.objects.duplicate()
		timers.push_back(temp)
	template_name = template.name
	pass

func soft_remove(): #remove without calling app_obj.remove_effect(), useful for recreating effect
	is_applied = false
#	var obj = get_applied_obj()
#	for a in atomic:
#		if obj != null: 
#			#tmp.remove_template(obj)
#			obj.remove_atomic(a)
#	atomic.clear()
#	buffs.clear()
#	for e in sub_effects:
#		var t = effects_pool.get_effect_by_id(e)
#		t.remove()
#	sub_effects.clear()
#	pass

func remove():
	if !is_applied: return
	.remove()
	for e in sub_effects:
		var t = effects_pool.get_effect_by_id(e)
		t.remove()
	sub_effects.clear()
	is_applied = false

func get_duration():
#	if remains <= 0: return null
	var res = {}
	#2fix
#	res.count = remains
#	res.event = null
	return res

