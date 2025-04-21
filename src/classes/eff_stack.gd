extends Reference
class_name eff_stack

var id
var code
var template
var effects = {}
var owner

var buffs = []

func serialize():
	var tmp = {
		type = 'stack',
		effects = effects.duplicate(),
		id = id,
		code = code,
		owner = owner
	}
	return tmp


func deserialize(dict):
	id = dict.id
	code = dict.code
	template = Effectdata.stacks[code]
	effects = dict.effects.duplicate(true)
	owner = dict.owner


func create_from_template(t_id):
	code = t_id
	template = Effectdata.stacks[t_id]


func get_applied_object():
	return characters_pool.get_char_by_id(owner)


func process_event(ev, data = {}):
	var cash = []
	for eff in effects:
		cash.push_back([eff, effects[eff]])
	cash.sort_custom(input_handler, 'timestamp_sort')
	for rec in get_active_effects():
		var tmp = effects_pool.get_effect_by_id(rec)
		if tmp.template.type == 'trigger':
			tmp.process_act(ev, data)
	for rec in cash:
		var tmp = effects_pool.get_effect_by_id(rec[0])
		if tmp.template.type == 'temp_s':
			tmp.process_tick(ev)


func process_act(ev, data = {}):
	for rec in get_active_effects():
		var tmp = effects_pool.get_effect_by_id(rec)
		if tmp.template.type == 'trigger':
			tmp.process_act(ev, data)


func process_tick(ev):
	var cash = []
	for eff in effects:
		cash.push_back([eff, effects[eff]])
	cash.sort_custom(input_handler, 'timestamp_sort')
	for rec in cash:
		var tmp = effects_pool.get_effect_by_id(rec[0])
		if tmp.template.type == 'temp_s':
			tmp.process_tick(ev)


func add_effect(eff, timestamp):
	effects[eff] = timestamp


func remove_effect(eff):
	effects.erase(eff)


func update_buffs():
	buffs.clear()
	if !template.has('buff'):
		for eid in get_active_effects():
			var eff = effects_pool.get_effect_by_id(eid)
			eff.rebuild_buffs()
			for b in eff.buffs:
				buffs.push_back(b)
	else:
		var un_desc = ""
		for eid in get_active_effects():
			var eff = effects_pool.get_effect_by_id(eid)
			eff.rebuild_buffs()
			for b in eff.buffs:
				un_desc += tr(b.description) + '\n'
		if un_desc == "":
			return
		else:
			un_desc = un_desc.trim_suffix('\n')
		var t_buff = template.buff
		var buff = Buff.new(self)
		buff.createfromtemplate(t_buff)
#		buff.calculate_args()
		if buff.tags.has('unified_desc'):
			buff.description = un_desc
		buffs.push_back(buff) 


func get_active_effects():
	var res = {}
	for eid in effects:
		var eff = effects_pool.get_effect_by_id(eid)
		if !(eff is triggered_effect) and eff.template.has('conditions'):
			if !get_applied_object().checkreqs(eff.template.conditions):
				continue
		res[eid] = effects[eid]
	return res



