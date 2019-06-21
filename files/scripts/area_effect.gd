extends base_effect
class_name area_effect

#area effects stable version - may be subject to reworking
#area effects can't own sub_effects (cause those can not be linked to applied objects as one-to-one), only buffs and atomic effects
#area effects can't be initial effects

var area = []

func _init(caller).(caller):
	pass

func apply_pos(pos):
	if !is_applied_to_pos(pos): return
	var obj = state.get_character_by_pos(pos)
	for a in atomic:
		obj.apply_atomic(a)

func is_applied_to_pos(pos):
	return area.has(pos)

func remove_pos(pos):
	if !is_applied_to_pos(pos): return
	var obj = state.get_character_by_pos(pos)
	for a in atomic:
		obj.remove_atomic(a)

func apply():
	if is_applied:
		remove()
	calculate_args()
	is_applied = true
	atomic.clear()
	for a in template.atomic:
		var tmp := atomic_effect.new(a, id)
		tmp.resolve_template()
		atomic.push_back(tmp.template)
	buffs.clear()
	for e in template.buffs:
		var tmp = Buff.new(id)
		tmp.createfromtemplate(e)
		tmp.calculate_args()
		buffs.push_back(tmp)
	for pos in area:
		apply_pos(pos)
	for ch in state.heroes.values():
		ch.add_ext_area_effect(id)


func remove():
	if !is_applied: return
	for pos in area:
		remove_pos(pos)
	is_applied = false
	buffs.clear()
	atomic.clear()
	for ch in state.heroes.values():
		ch.remove_ext_area_effect(id)

func calculate_args():
	.calculate_args()
	area.clear()
	var par = effects_pool.get_effect_by_id(parent)
	var par_obj = par.get_applied_obj()
	var start_pos = par_obj.pos
	match template.area:
		'party':
			if variables.playerparty.has(start_pos):
				area = variables.playerparty.duplicate()
			else:
				area = variables.enemyparty.duplicate()
			pass
		'row':
			for r in variables.rows:
				if r.has(start_pos): area = r.duplicate()
			pass
		'column':
			for l in variables.lines:
				if l.has(start_pos): area = l.duplicate()
			pass
		'back':
			area.push_back(start_pos)
			if variables.lines[1].has(start_pos) or variables.lines[3].has(start_pos): #frontline check
				area.push_back(start_pos + 3)
			pass
	pass

func serialize():
	var tmp = .serialize()
	tmp['type'] = 'area'
	tmp['area'] = area
	return tmp


func deserialize(tmp):
	.deserialize(tmp)
	area.clear()
	for pos in tmp.area:
		area.push_back(int(pos))




