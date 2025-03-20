extends Reference

var parent: WeakRef

var trainer = null
var trainees = []

var dispositions = {}
var dispositions_known = {}

var spirit = 100
var loyalty = 0
var training_metrics = {}

var stored_reqs = {}

var enable = true
var cooldown = {
	main = 0,
	mindread = 0,
}


func cooldown_tick():
	if cooldown.main > 0:
		cooldown.main -= 1
	if cooldown.mindread > 0:
		cooldown.mindread -= 1


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
	process_disposition_data(data, true)


func process_disposition_data(data, setup = false):
	for cat in data:
		if setup:
			dispositions_known[cat] = false
		if data[cat] is Array:
			dispositions[cat] = input_handler.weightedrandom(data[cat])
		else:
			dispositions[cat] = data[cat]


func disposition_change_report(type, value):
	var cval = dispositions[type]
	var data = Skilldata.training_categories[type]
	var val_list = variables.disposition_results.keys()
	cval = val_list.find(cval)
	cval += value
	cval = int(clamp(cval, 0, val_list.size() - 1))
	cval = val_list[cval]
	if dispositions[type] == cval:
		return ""
	else:
		dispositions[type] = cval
		var text = ""
		if dispositions_known[type]:
			text += "{color=yellow|" + tr('DISPOSITIONSET' + cval.to_upper()) % tr(data.name) + "}"
		else:
			text += "{color=yellow|" +tr('DISPOSITIONCHANGE') % tr(data.name) +  "}"
		return text


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
	if trainees.has(id):
		return
	trainees.push_back(id)
	var tchar = characters_pool.get_char_by_id(id)
	if tchar.training.trainer == parent.get_ref().id:
		print ('warning - error in trainee setup')
	else:
		tchar.clear_training()
		tchar.training.trainer = parent.get_ref().id


func can_be_trained():
	return cooldown.main < 1 and enable and trainer != null


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
	training_metrics.clear()
	
	#remove traits
	var tarr = parent.get_ref().get_traits_by_tag('training')
	for tr in tarr:
		parent.get_ref().remove_trait(tr)
	tarr = parent.get_ref().get_traits_by_tag('training_final')
	for tr in tarr:
		parent.get_ref().remove_trait(tr)
	
	#regenerate dispositions
	var race = parent.get_ref().get_stat('race')
	setup_dispositions(race)
	if parent.get_ref().get_stat('unique') != null:
		#huge stub here - better fix pregen chars data properly
		var name = parent.get_ref().get_stat('unique')
		var h = name.substr(0, 1).to_upper()
		name = h + name.substr(1)
		var udata = worlddata.pregen_characters[name]
		if udata.has('training_disposition'):
			process_disposition_data(udata.training_disposition)
	tarr = parent.get_ref().get_traits_by_tag('disposition_change')
	for tr in tarr:
		var trdata = Traitdata.traits[tr].disposition_change
		process_disposition_data(trdata)
	#reset slavetype
	parent.get_ref().set_slave_category('slave1')
	parent.get_ref().add_trait('untrained')


func get_trainings_amount(tag = 'training'):
	var tmp = parent.get_ref().get_traits_by_tag(tag)
	tmp.erase('untrained')
	return tmp.size()


func get_training_cost():
	var cost = variables.training_costs[0]
	var tr_a = get_trainings_amount()
	if tr_a > 0:
		cost = variables.training_costs[1]
	if tr_a > 1:
		cost = variables.training_costs[2]
	return cost


func get_training_cost_gold():
	var val = parent.get_ref().calculate_price()
	var cost = val * 0.25
	var tr_a = get_trainings_amount('servant_training')
	if tr_a > 0:
		cost = val * 0.66
	if tr_a > 1:
		cost = val
	return int(cost * (1.0 - 0.07 * parent.get_ref().get_stat('tame_factor')))


func add_training(id):
	loyalty -= get_training_cost()
	parent.get_ref().add_trait(id)


func finish_training(internal = false):
	if internal:
		enable = false
		parent.get_ref().remove_trait('untrained')
		if trainer != null:
			var tchar = characters_pool.get_char_by_id(trainer)
			tchar.get_trainees().erase(parent.get_ref().id)
			trainer = null
	else:
		if !parent.get_ref().has_status('callmaster'):
			return
		enable = false
		if trainer != null:
			var tchar = characters_pool.get_char_by_id(trainer)
			tchar.get_trainees().erase(parent.get_ref().id)
			trainer = null
		parent.get_ref().set_slave_category('slave_trained')


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
	
#	if !training_metrics.has(code):
#		training_metrics[code] = 0
#	training_metrics[code] += 1
	if !training_metrics.has(cat):
		training_metrics[cat] = 0
	training_metrics[cat] += 1
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
	if input_handler.globalsettings.easytrain:
		result = 'crit_success'
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
			'trainer_trait':
				if ch_trainer.check_trait(eff.check):
					effects.push_back(eff.effect)
			'trainer_status':
				if ch_trainer.has_status(eff.check):
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
	if ResourceScripts.game_res.upgrades.has('resting') and ResourceScripts.game_res.upgrades.resting > 0:
		result_data.spirit += 1
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
	if code == 'dayoff':
		var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table['e_s_dayoff'])
		parent.get_ref().apply_effect(effects_pool.add_effect(eff))
	if code in ['rape', 'publicuse']:
		if parent.get_ref().get_stat('vaginal_virgin'):
			effect_text += "%s takes virginity of %s" % [ch_trainer.get_short_name(), parent.get_ref().get_short_name()]
			parent.get_ref().take_virginity('vaginal', trainer) #add finetune for bodypart checking
	if code == 'mindread':
		cooldown.mindread = 1
		var pool = []
		for dis in dispositions_known:
			if !dispositions_known[dis]:
				pool.push_back(dis)
		if pool.size() > 0 and result in ['success', 'crit_success']:
			effect_text += tr('MINDREADREVEALDISPOSITION')
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
	else:
		cooldown.main = 3
		if cat == 'positive':
			ResourceScripts.game_party.add_relationship_value(parent.get_ref().id, trainer, globals.rng.randi_range(1, 2))
		else:
			if parent.has_status('likes_training'):
				ResourceScripts.game_party.add_relationship_value(parent.get_ref().id, trainer, 3)
			else:
				ResourceScripts.game_party.add_relationship_value(parent.get_ref().id, trainer, -3)
	if globals.rng.randf() < 0.1 + 0.15 * ch_trainer.get_stat('wits_factor'):
		if !dispositions_known[cat]: # and result in ['success', 'crit_success']:
			effect_text += tr('WITSREVEALDISPOSITION')
			dispositions_known[cat] = true  
			effect_text += "%s - %s \n" % [tr(cat_data.name), dispositions[cat]] 
	#apply
	loyalty += result_data.loyalty
	spirit += result_data.spirit
	if randf() >= 0.6 && cat != 'positive' && code != 'mindread':
		effect_text += "\n({color=aqua|" + parent.get_ref().get_short_name() + "}: " + parent.get_ref().translate(input_handler.get_random_chat_line(parent.get_ref(), 'train_'+result)) + ")\n"
	if result_data.loyalty != 0:
		effect_text += statdata.statdata.loyalty.name + " + " + str(result_data.loyalty) + "\n"
#	if result_data.spirit != 0:
#		effect_text += statdata.statdata.spirit.name + " - " + str(- result_data.spirit)  + "\n"
	for rec in variables.spirit_changes:
		if result_data.spirit >= rec.min and result_data.spirit <= rec.max:
			effect_text += "{color=yellow|" + parent.get_ref().translate(tr(rec.desc)) + "}\n"
			break
	
	if data.has('disposition_affects'):
		for tag in data.disposition_affects:
			if tag is Array:
				var newtag = input_handler.random_from_array(tag)
				if globals.rng.randf() < 0.25:
					effect_text += disposition_change_report(newtag, 2)
				else:
					effect_text += disposition_change_report(newtag, 1)
			else:
				if globals.rng.randf() < 0.25:
					effect_text += disposition_change_report(tag, 2)
				else:
					effect_text += disposition_change_report(tag, 1)
	
	if spirit < 0:
		spirit = 0
	if spirit < variables.spirit_limits[0]:
		if !parent.get_ref().check_trait('training_broken'):
			effect_text += tr('TRAININGSTATUS1') + "\n"
			parent.get_ref().remove_trait('training_damaged')
			parent.get_ref().add_trait('training_broken')
	elif spirit < variables.spirit_limits[1]:
		if !parent.get_ref().check_trait('training_damaged'):
			effect_text += tr('TRAININGSTATUS2') + "\n"
			parent.get_ref().add_trait('training_damaged')
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
	var text = "Dispositions: \n"
	for dis in dispositions_known:
		var ddata = Skilldata.training_categories[dis]
		if dispositions_known[dis]:
			text += "%s : %s\n" % [tr(ddata.name), dispositions[dis]]
		else:
			 text += "%s : unknown\n" % tr(ddata.name)
	return text


func build_stored_reqs():
	#do not clear stored reqs, only overwrite
	for tr in Traitdata.traits:
		var data = Traitdata.traits[tr]
		if !data.has('tags'):
			continue
		if data.tags.has('training_success'):
			#roll reqs
			var tres = {}
			var req_data = data.custom_reqs
			for cat in req_data:
				var newcat = cat
				if cat == 'random':
					newcat = input_handler.random_from_array(['positive', 'social', 'sexual', 'humiliation', 'physical'])
				if tres.has(newcat):
					tres[newcat] += req_data[cat]
				else:
					tres[newcat] = req_data[cat]
			stored_reqs[tr] = tres
#		if data.tags.has('servant_training') or data.tags.has('training'):
#			pass


func process_traits_availability_data(data):
	for id in data:
		stored_reqs[id] = data[id]


func unlock_trait(arr):
	if arr is String:
		arr = [arr]
	for id in arr:
		stored_reqs[id] = true


func check_stored_reqs(id):
	if !stored_reqs.has(id):
		return true
	var reqs = stored_reqs[id]
	if reqs is bool:
		#reqs is value
		return reqs
	if reqs is Array:
		for decision in reqs:
			if ResourceScripts.game_progress.decisions.has(decision):
				return true
		return false
	if input_handler.globalsettings.easytrain:
		return true
	#reqs is dict of training categories
	for cat in reqs:
		if !training_metrics.has(cat):
			return false
		if training_metrics[cat] < reqs[cat]:
			return false
	return true


func build_stored_req_desc(id):
	var text = ''
	if stored_reqs.has(id):
		var reqs = stored_reqs[id]
		if reqs is bool:
			if !reqs:
				text += tr('NOTAVAILABLE')
		elif reqs is Array:
			var f = false
			for decision in reqs:
				if ResourceScripts.game_progress.decisions.has(decision):
					f = true
			if !f:
				text += tr('NOTAVAILABLE')
		elif !input_handler.globalsettings.easytrain:
			text += tr('TRIANINGREQUIRES')
			for cat in reqs:
				var cdata = Skilldata.training_categories[cat] 
				var line = ""
				var amount = 0
				if training_metrics.has(cat):
					amount = training_metrics[cat]
				line = "%s - " % [tr(cdata.name)] 
				if amount >= reqs[cat]:
					line = line + ('{color=green|' + "%d/%d" + "}") % [int(amount),int(reqs[cat])]
				else:
					line = line + ('{color=red|' + "%d/%d" + "}") % [int(amount),int(reqs[cat])]
				line += ', '
				text += line
			text = globals.TextEncoder(text.trim_suffix(", ") + ".")
	return text


func process_training_metrics(value):
	for cat in value:
		training_metrics[cat] = value[cat] 
