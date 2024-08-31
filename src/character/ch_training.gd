extends Reference

var parent: WeakRef

var trainer = null
var trainees = []

var dispositions = {}
var dispositions_known = {}

var spirit = 100
var loyalty = 0

var enable = true
var available = true

func add_stat(statname, value, revert = false):
	if !enable:
		return
	var k = 1
	if revert:
		k = -1
	set(statname, get(statname) + k * value)
	if spirit < 0:
		spirit = 0


func setup_dispositions(race_id):
	var data = races.racelist.Human.training_disposition
	if races.racelist[race_id].has('training_disposition'):
		data = races.racelist[race_id].training_disposition
	for cat in data:
		dispositions_known[cat] = false
		dispositions[cat] = input_handler.weightedrandom(data[cat])


func unlock_disposition(cat):
	if !dispositions_known.has(cat):
		return
	dispositions_known[cat] = true


func get_trainer():
	if trainer == null:
		return null
	else:
		return characters_pool.get_char_by_id(trainer)


func get_trainees(): #unsafe - returns array, not copy, but it's for a reason
	return trainees


func add_trainee(id): #unsafe - no limit check
	trainees.push_back(id)
	var tchar = characters_pool.get_char_by_id(id)
	tchar.training.trainer = parent.get_ref().id


func clear_training():
	if trainer != null:
		var tchar = characters_pool.get_char_by_id(trainer)
		tchar.get_trainees().erase(parent.get_ref().id)
		trainer = null
		parent.get_ref().remove_from_task()
	for id in trainees:
		var tchar = characters_pool.get_char_by_id(id)
		tchar.training.trainer = null
		tchar.remove_from_task()
	trainees.clear()


func reset_training():
	spirit = 100
	loyalty = 0
	enable = true
	var tarr = parent.get_ref().get_traits_by_tag('training')
	for tr in tarr:
		parent.get_ref().remove_trait(tr)
	tarr = parent.get_ref().get_traits_by_tag('training_final')
	for tr in tarr:
		parent.get_ref().remove_trait(tr)
	parent.get_ref().add_trait('untrained')


func get_trainings_amount():
	return parent.get_ref().get_traits_by_tag('training').size()


func get_training_cost():
	var cost = variables.training_costs[0]
	var tr_a = get_trainings_amount()
	if tr_a > 0:
		cost = variables.training_costs[1]
	if tr_a > 1:
		cost = variables.training_costs[2]
	return cost


func add_training(id):
	loyalty -= get_training_cost()
	parent.get_ref().add_trait(id)


func finish_training(internal = false):
	if internal:
		enable = false
		parent.get_ref().remove_trait('untrained')
	else:
		if !parent.get_ref().has_status('callmaster'):
			return
		enable = false
		if spirit < variables.spirit_limits[0]:
			parent.get_ref().add_trait('training_broken')
		elif spirit < variables.spirit_limits[1]:
			parent.get_ref().add_trait('training_damaged')
		if trainer != null:
			var tchar = characters_pool.get_char_by_id(trainer)
			tchar.get_trainees().erase(parent.get_ref().id)
			trainer = null


func apply_training(code):
	var ch_trainer = get_trainer()
	if ch_trainer == null:
		return
	if !Skilldata.training_actions.has(code):
		print("no training data %s" % code)
		return
	var effect_text = ""
	var result_tags = []
	var data = Skilldata.training_actions[code]
	var cat = data.type
	var cat_data = Skilldata.training_categories[cat]
	var disposition = dispositions[cat]
	#gather chance effects
	var effects = []
	for eff in data.bonus_changes + cat_data.bonus_changes:
		if !eff.has('chance'):
			continue
		match eff.type:
			'always':
				effects.push_back(eff.chance)
			'trainer_class':
				if ch_trainer.has_profession(eff.check):
					effects.push_back(eff.chance)
			'disposition':
				if disposition in eff.check:
					effects.push_back(eff.chance)
	
	var chance_data = variables.disposition_results[disposition].duplicate(true)
	#modify chances
	chance_data.fail -= 5 * parent.get_ref().get_stat('tame_factor')
	chance_data.crit_success += 5 * parent.get_ref().get_stat('tame_factor')
	for eff_dict in effects:
		for eff in eff_dict:
			if eff.ends_with('_add'):
				var tmp = eff_dict[eff]
				if tmp is Array:
					tmp = globals.rng.randi_range(tmp[0], tmp[1])
				var ch = eff.trim_suffix('_add')
				chance_data[ch] += tmp
	for eff_dict in effects:
		for eff in eff_dict:
			if eff.ends_with('_mul'):
				var tmp = eff_dict[eff]
				if tmp is Array:
					tmp = globals.rng.randf_range(tmp[0], tmp[1])
				var ch = eff.trim_suffix('_mul')
				chance_data[ch] *= tmp
	for res in chance_data:
		if chance_data[res] < 0:
			chance_data[res] = 0
	#roll result
	var result = input_handler.weightedrandom_dict(chance_data)
	var result_data = variables.training_results_base[result].duplicate(true)
	for st in result_data:
		if result_data[st] is Array:
			result_data[st] = globals.rng.randi_range(result_data[st][0], result_data[st][1])
	#gather result effects
	effects.clear()
	for eff in data.bonus_changes + cat_data.bonus_changes:
		if !eff.has('effect'):
			continue
		if eff.has('result'):
			if !(result in eff.result):
				continue
		match eff.type:
			'always':
				effects.push_back(eff.effect)
			'trainer_class':
				if ch_trainer.has_profession(eff.check):
					effects.push_back(eff.effect)
			'disposition':
				if disposition in eff.check:
					effects.push_back(eff.effect)
			'result':
				if result in eff.check:
					effects.push_back(eff.effect)
			'stat':
				if input_handler.operate(eff.operant, parent.get_ref().get_stat(eff.stat), eff.check):
					effects.push_back(eff.effect)
	#modify result
	for eff_dict in effects:
		for eff in eff_dict:
			if eff.ends_with('_mul'):
				var tmp = eff_dict[eff]
				if tmp is Array:
					tmp = globals.rng.randf_range(tmp[0], tmp[1])
				var ch = eff.trim_suffix('_mul')
				result_data[ch] *= tmp
	for eff_dict in effects:
		for eff in eff_dict:
			if eff.ends_with('_add'):
				var tmp = eff_dict[eff]
				if tmp is Array:
					tmp = globals.rng.randi_range(tmp[0], tmp[1])
				var ch = eff.trim_suffix('_add')
				if result_data[ch] != 0:
					result_data[ch] += tmp
	if result_data.loyalty != 0:
		result_data.loyalty += parent.get_ref().get_stat('training_loyalty')
		if result_data.loyalty < 0:
			result_data.loyalty = 0 
	if result_data.spirit != 0:
		result_data.spirit += parent.get_ref().get_stat('training_spirit')
		if result_data.spirit > 0:
			result_data.spirit = 0 
	#other effects
	if code != 'influence' or !trainer.has_profession('caster'):
		available = false
	if code == 'dayoff':
		var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table['e_s_dayoff'])
		parent.get_ref().apply_effect(effects_pool.add_effect(eff))
	if code in ['rape', 'publicuse']:
		if parent.get_ref().get_stat('vaginal_virgin'):
			effect_text += "%s takes virginity of %s" % [ch_trainer.get_short_name(), parent.get_ref().get_short_name()]
			parent.get_ref().take_virginity('vaginal', trainer) #add finetune for bodypart checking
	if code == 'mindread':
		var pool = []
		for dis in dispositions_known:
			if !dispositions_known[dis]:
				pool.push_back(dis)
		if pool.size() > 0 and result in ['success', 'crit_success']:
			effect_text += "Dispositions revealed:\n"
			var max_amount = pool.size()
#			if max_amount > 3:
#				max_amount = 3
#			var amount = globals.rng.randi_range(1, max_amount)
			var amount = 3
			if result == 'success':
				amount = 1
			if amount > max_amount:
				amount = max_amount
			for i in range(amount):
				var dis = input_handler.random_from_array(pool)
				pool.erase(dis)
				dispositions_known[dis] = true  
				effect_text += "%s - %s \n" % [dis, dispositions[dis]] 
	#apply
	loyalty += result_data.loyalty
	spirit += result_data.spirit
	effect_text += tr(result)  + "\n" #fix
	if result_data.loyalty != 0:
		effect_text += statdata.statdata.loyalty.name + " + " + str(result_data.loyalty) + "\n"
	if result_data.spirit != 0:
		effect_text += statdata.statdata.spirit.name + " - " + str(- result_data.spirit)  + "\n"
	if spirit < 0:
		spirit = 0
	#display
	var dialogue_data = {text = '', tags = ['skill_report_event'], options = []}
	var text = tr(data.scene_text)
	for tag in variables.dynamic_text_vars:
		text = text.replace('[%s1]' % tag, ch_trainer.translate('[%s]' % tag))
		text = text.replace('[%s2]' % tag, parent.get_ref().translate('[%s]' % tag))
	if data.result_text.has(result):
		text += "\n"
		text += tr(data.result_text[result])
	#add custom placeholder translation
	if data.has('scene_image') and data.scene_image != '':
		dialogue_data.image = data.scene_image
	else:
		dialogue_data.image = 'noevent'
	dialogue_data.text = text + "\n" + effect_text
	input_handler.active_character = parent.get_ref()
	
	dialogue_data.options.append({code = 'close', text = tr("DIALOGUECLOSE"), reqs = []})
	
	input_handler.interactive_message_custom(dialogue_data)


func get_dispositions_text():
	var text = "Training dispositions: \n"
	for dis in dispositions_known:
		var ddata = Skilldata.training_categories[dis]
		if dispositions_known[dis]:
			text += "%s : %s\n" % [tr(ddata.name), dispositions[dis]]
		else:
			 text += "%s : unknown\n" % tr(ddata.name)
	return text
