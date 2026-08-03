extends Reference

#turns a freshly acquired rebellious (untrained) slave refuses any training
const REBEL_BLOCK_TURNS = 1

var parent: WeakRef

var trainer = null
var trainees = []

var dispositions = {}
var dispositions_known = {}

var loyalty = 0
var training_points = 0
var training_metrics = {}
var days_since_training = 0
var resist_fail_counter = 0
var acquired_turn = -1 #absolute turn the character joined the party, -1 for old saves

var stored_reqs = {}

var enable = true
var cooldown = {
#	main = 0,
	positive = 0,
	mindread = 0,
	negotiation = 0,
}


func cooldown_tick():
#	if cooldown.main > 0:
#		cooldown.main -= 1
	if cooldown.positive > 0:
		cooldown.positive -= 1
	if cooldown.mindread > 0:
		cooldown.mindread -= 1
	if cooldown.negotiation > 0:
		cooldown.negotiation -= 1

#a rebellious slave refuses training until a turn has passed since being brought in
func is_rebel_blocked():
	if acquired_turn < 0 or !parent.get_ref().check_trait('untrained'):
		return false
	return ResourceScripts.game_globals.get_turn() - acquired_turn < REBEL_BLOCK_TURNS


func can_negotiate():
	return cooldown.negotiation <= 0

func day_tick():
	if is_slave() and is_in_training():
		days_since_training += 1
		if days_since_training > get_loyalty_decay_grace():
			loyalty = clamp(loyalty - get_loyalty_decay_amount(), 0, 100)

func get_loyalty_decay_grace():
	return 5 - parent.get_ref().get_stat('authority_factor') / 2.0

func get_loyalty_decay_amount():
	return 10 + 2 * parent.get_ref().get_stat('authority_factor')

func get_training_points_cap():
	return 50 + 10 * parent.get_ref().get_stat('tame_factor')

func is_broke_in():
	return parent.get_ref().check_trait('training_broke_in')

func get_loyalty_cap():
	if is_broke_in():
		return 100
	return 50

func add_stat(statname, value):
	if is_slave() and !enable:#not realy sure if it's necessary at all
		return
	if statname == 'loyalty':
		if !parent.get_ref().has_status('no_loyalty_growth'):
			loyalty += value
			if is_slave():
				loyalty = clamp(loyalty, 0, get_loyalty_cap())
				if is_in_training() and loyalty >= 100:
					finish_training()
	elif statname == 'training_points':
		training_points = clamp(training_points + value, 0, get_training_points_cap())
	else:
		set(statname, get(statname) + value)


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
		text += "\n"
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


func is_in_training():
	return enable and trainer != null

func has_category_not_in_cd():
	for cat in cooldown:
		if cooldown[cat] < 1:
			return true
	return false


func can_be_trained():
#	return enable and trainer != null and cooldown.main < 1
	return is_in_training() and has_category_not_in_cd() and !is_rebel_blocked()

func get_disposition_name(value):
	return tr('DISPOSITION' + value.to_upper())


#not sure for the classification, but it corresponds to conditions in SlaveSiblingsModule.gd
func is_slave():
	return parent.get_ref().get_stat('slave_class') in ['slave', 'slave_trained']
func is_servant():
	return parent.get_ref().get_stat('slave_class') in ['servant', 'servant_notax', 'heir']

func clear_training():
	var res = false
	if trainer != null:
		var tchar = characters_pool.get_char_by_id(trainer)
		tchar.get_trainees().erase(parent.get_ref().id)
		trainer = null
		res = true
#		parent.get_ref().remove_from_task()
	for id in trainees:
		var tchar = characters_pool.get_char_by_id(id)
#		tchar.training.trainer = null
		tchar.clear_training()
	trainees.clear()
	return res


func reset_training():
	loyalty = 0
	training_points = 0
	days_since_training = 0
	resist_fail_counter = 0
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
	parent.get_ref().set_slave_category('slave')
	parent.get_ref().add_trait('untrained')


func get_trainings_amount(tag = 'training'):
	var tmp = parent.get_ref().get_traits_by_tag(tag)
	tmp.erase('untrained')
	return tmp.size()


func get_training_cost(tag = 'training'):
	var cost = variables.training_costs[0]
	var tr_a = get_trainings_amount(tag)
	if tr_a > 0:
		cost = variables.training_costs[1]
	if tr_a > 1:
		cost = variables.training_costs[2]
	return cost

func get_servant_training_cost():
	return get_training_cost('servant_training')

#obsolete
#func get_training_cost_gold():
#	var val = parent.get_ref().calculate_price()
#	var cost = val * 0.25
#	var tr_a = get_trainings_amount('servant_training')
#	if tr_a > 0:
#		cost = val * 0.66
#	if tr_a > 1:
#		cost = val
#	return int(cost * (1.0 - 0.07 * parent.get_ref().get_stat('tame_factor')))


func add_training(id):
	var cost = get_training_cost()
	if !is_servant():
		training_points -= cost
	parent.get_ref().add_trait(id)


func add_training_post(id):
	var data = Traitdata.traits[id]
	training_points -= data.cost
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
		enable = false
		if trainer != null:
			var tchar = characters_pool.get_char_by_id(trainer)
			tchar.get_trainees().erase(parent.get_ref().id)
			trainer = null
		parent.get_ref().set_slave_category('slave_trained')


func format_chance_diff(before, after):
	var parts = []
	for key in ['fail', 'resist', 'success', 'crit_success']:
		if after[key] != before[key]:
			parts.push_back("%s %+.0f" % [tr('CHANCELOG_' + key.to_upper()), after[key] - before[key]])
	return PoolStringArray(parts).join(", ")


func format_chance_entry(changes):
	var parts = []
	for key in changes:
		if key.ends_with('_add'):
			parts.push_back("%s %+.0f" % [tr('CHANCELOG_' + key.trim_suffix('_add').to_upper()), changes[key]])
		else:
			parts.push_back("%s x%.2f" % [tr('CHANCELOG_' + key.trim_suffix('_mul').to_upper()), changes[key]])
	return PoolStringArray(parts).join(", ")


func gather_chance_entries(data, cat_data, ch_trainer, disposition):
	var entries = []
	for src in [{list = data.bonus_changes, label = tr(data.name)}, {list = cat_data.bonus_changes, label = tr(cat_data.name)}]:
		for eff in src.list:
			if !eff.has('chance'):
				continue
			var label = ""
			var applies = false
			match eff.type:
				'always':
					applies = true
					label = src.label
				'trainer_class':
					if ch_trainer.has_profession(eff.check):
						applies = true
						label = tr('CHANCELOG_SRC_TRAINERCLASS') % tr(classesdata.professions[eff.check].name)
				'disposition':
					if disposition in eff.check:
						applies = true
						label = tr('CHANCELOG_SRC_DISPOSITION') % tr('DISPOSITION' + disposition.to_upper())
			if !applies:
				continue
			var resolved = {}
			for key in eff.chance:
				var tmp = eff.chance[key]
				if tmp is Array:
					if key.ends_with('_add'):
						tmp = globals.rng.randi_range(tmp[0], tmp[1])
					else:
						tmp = globals.rng.randf_range(tmp[0], tmp[1])
				resolved[key] = tmp
			entries.push_back({label = label, changes = resolved})
	return entries


func apply_chance_entries(entries, suffix, chance_data):
	for entry in entries:
		for key in entry.changes:
			if key.ends_with(suffix):
				var ch = key.trim_suffix(suffix)
				if suffix == '_add':
					chance_data[ch] += entry.changes[key]
				else:
					chance_data[ch] *= entry.changes[key]


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
	var was_disposition_known = dispositions_known[cat]
	
#	if !training_metrics.has(code):
#		training_metrics[code] = 0
#	training_metrics[code] += 1
	if !training_metrics.has(cat):
		training_metrics[cat] = 0
	training_metrics[cat] += 1
	#gather chance effects, each resolved once (random ranges rolled here) and labeled with its source
	var chance_entries = gather_chance_entries(data, cat_data, ch_trainer, disposition)

	var chance_data = variables.disposition_results[disposition].duplicate(true)
	var chance_log = []
#	chance_log.append(tr('CHANCELOG_BASE') % [tr('DISPOSITION' + disposition.to_upper()), chance_data.fail, chance_data.resist, chance_data.success, chance_data.crit_success])
	var chance_stage = chance_data.duplicate(true)
	#modify chances
	chance_data.fail -= 3 * parent.get_ref().get_stat('tame_factor')
	chance_data.crit_success += 3 * parent.get_ref().get_stat('tame_factor')
	var tame_diff = format_chance_diff(chance_stage, chance_data)
	if tame_diff != "":
		chance_log.append(tr('CHANCELOG_TAMEFACTOR') % [parent.get_ref().get_stat('tame_factor'), tame_diff])
	apply_chance_entries(chance_entries, '_add', chance_data)
	apply_chance_entries(chance_entries, '_mul', chance_data)
	for entry in chance_entries:
		var entry_text = format_chance_entry(entry.changes)
		if entry_text != "":
			chance_log.append("%s: %s" % [entry.label, entry_text])
	for res in chance_data:
		if chance_data[res] < 0:
			chance_data[res] = 0
	var chance_total = float(chance_data.fail + chance_data.resist + chance_data.success + chance_data.crit_success)
	var chance_percent = {fail = 0, resist = 0, success = 0, crit_success = 0}
	if chance_total > 0:
		for key in chance_percent:
			chance_percent[key] = float(chance_data[key]) / chance_total * 100.0
	chance_log.append(tr('CHANCELOG_FINAL') % [chance_percent.fail, chance_percent.resist, chance_percent.success, chance_percent.crit_success])
	#roll result
	var result = input_handler.weightedrandom_dict(chance_data)
	if ResourceScripts.game_globals.easytrain:
		result = 'crit_success'
	if !is_broke_in() and code != 'mindread' and result in ['success', 'crit_success']:
		parent.get_ref().add_trait('training_broke_in')
		effect_text += "{color=yellow|" + (tr('TRAININGBROKENINANNOUNCE') % parent.get_ref().get_short_name()) + "}\n"
	if result in ['fail', 'resist']:
		resist_fail_counter += 1
		if resist_fail_counter >= parent.get_ref().get_stat('tame_factor') + 2:
			resist_fail_counter = 0
			var neg_trait = parent.get_ref().get_random_trait_tag('negative')
			parent.get_ref().add_trait(neg_trait)
			if neg_trait != null:
				effect_text += "{color=red|" + (tr('TRAININGNEGATIVETRAITGAINED') % [parent.get_ref().get_short_name(), tr(Traitdata.traits[neg_trait].name)]) + "}\n"
	var result_data = variables.training_results_base[result].duplicate(true)
	for st in result_data:
		if result_data[st] is Array:
			result_data[st] = globals.rng.randi_range(result_data[st][0], result_data[st][1])
	#gather result effects
	var effects = []
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
		result_data.training_points += 1
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
		#trainer_loyalty_bonus and fame's loyalty_bonus works the same way
		#For now fame works separately, but maybe it should influence trainer_loyalty_bonus
		var trainers_bonus = ch_trainer.get_stat('trainer_loyalty_bonus') + ch_trainer.get_fame_bonus('loyalty_bonus')
		result_data.loyalty += result_data.loyalty * trainers_bonus
		if result_data.loyalty < 0:
			result_data.loyalty = 0
	if result_data.training_points != 0:
		result_data.training_points += parent.get_ref().get_stat('training_points_bonus')
		result_data.training_points += result_data.training_points * ch_trainer.get_stat('trainer_training_points_bonus')
		if result_data.training_points < 0:
			result_data.training_points = 0
		if !is_broke_in():
			result_data.training_points = floor(result_data.training_points * 0.5)
	#other effects
	if code == 'dayoff':
#		parent.get_ref().apply_effect_code('e_s_dayoff')
		parent.get_ref().affect_char({type = 'set_availability', value = false, duration = 1})
	if code in ['rape', 'publicuse']:
		if parent.get_ref().get_stat('vaginal_virgin'):
			effect_text += tr('TRAININGVIRGINITYTAKEN') % [ch_trainer.get_short_name(), parent.get_ref().get_short_name()]
			parent.get_ref().take_virginity('vaginal', trainer) #add finetune for bodypart checking
	if code == 'mindcontrol':
		for rec in ['positive', 'physical', 'humiliation', 'social', 'sexual']:
			if !training_metrics.has(rec):
				training_metrics[rec] = 0
			training_metrics[rec] += 1
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
				var ddata = Skilldata.training_categories[dis]
				effect_text += "%s - %s \n" % [tr(ddata.name), get_disposition_name(dispositions[dis])]
	else:
#		cooldown.main = 3
		cooldown.positive = 1
		if cat == 'positive':
			ResourceScripts.game_party.add_relationship_value(parent.get_ref().id, trainer, globals.rng.randi_range(1, 2))
		else:
			if parent.get_ref().has_status('likes_training'):
				ResourceScripts.game_party.add_relationship_value(parent.get_ref().id, trainer, 3)
			else:
				ResourceScripts.game_party.add_relationship_value(parent.get_ref().id, trainer, -3)
	if globals.rng.randf() < 0.1 + 0.15 * ch_trainer.get_stat('wits_factor'):
		if !dispositions_known[cat]: # and result in ['success', 'crit_success']:
			effect_text += tr('WITSREVEALDISPOSITION')
			dispositions_known[cat] = true  
			effect_text += "%s - %s \n" % [tr(cat_data.name), get_disposition_name(dispositions[cat])]
	#apply
	if parent.get_ref().has_status('no_loyalty_training'):
		result_data.loyalty = 0
	days_since_training = 0
	add_stat('training_points', result_data.training_points)
	add_stat('loyalty', result_data.loyalty)
	var training_finished_now = !enable
	if randf() >= 0.6 && cat != 'positive' && code != 'mindread':
		effect_text += "\n({color=aqua|" + parent.get_ref().get_short_name() + "}: " + parent.get_ref().translate(input_handler.get_random_chat_line(parent.get_ref(), 'train_'+result)) + ")\n"
	if result_data.loyalty != 0:
		effect_text += statdata.statdata.loyalty.name + " + " + str(result_data.loyalty) + "\n"
	if result_data.training_points != 0:
		effect_text += statdata.statdata.training_points.name + " + " + str(result_data.training_points) + "\n"

	#affection/respect adjustments from training outcome
	var trainer_is_master = ch_trainer.has_profession('master')
	var affection_delta = 0
	if cat == 'positive':
		if result in ['success', 'crit_success']:
			if trainer_is_master:
				affection_delta += globals.rng.randi_range(7, 10)
		else:
			var respect_loss = globals.rng.randi_range(5, 7)
			parent.get_ref().add_stat('respect', -respect_loss)
			effect_text += statdata.statdata.respect.name + " - " + str(respect_loss) + "\n"
	if disposition == 'kink' and result in ['success', 'crit_success']:
		if trainer_is_master:
			affection_delta += globals.rng.randi_range(5, 10)
		else:
			ResourceScripts.game_party.add_relationship_value(parent.get_ref().id, trainer, globals.rng.randi_range(5, 8))
	if cat in ['physical', 'humiliation', 'sexual', 'social']:
		if result in ['success', 'crit_success']:
			var respect_gain = globals.rng.randi_range(3, 6)
			if trainer_is_master:
				respect_gain = int(round(respect_gain * 1.5))
			parent.get_ref().add_stat('respect', respect_gain)
			effect_text += statdata.statdata.respect.name + " + " + str(respect_gain) + "\n"
		elif trainer_is_master:
			affection_delta -= globals.rng.randi_range(5, 8)
	if affection_delta != 0:
		parent.get_ref().add_stat('affection', affection_delta)
		var affection_sign = "+" if affection_delta > 0 else "-"
		effect_text += statdata.statdata.affection.name + " " + affection_sign + " " + str(abs(affection_delta)) + "\n"

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

	#display
	var dialogue_data = {text = '', tags = ['skill_report_event'], options = []}
	var text = tr(data.scene_text)
	#chars can now translate() text by numbered tags. Refactor advised
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
	var chance_text = ""
	if was_disposition_known:
		chance_text = "{color=gray_text_dialogue|" + PoolStringArray(chance_log).join("\n") + "}\n"
#	elif gui_controller.mansion.in_test_mode:
#		chance_text = "{color=gray_text_dialogue|" + tr('CHANCELOG_DEBUG_NOTE') + "\n" + PoolStringArray(chance_log).join("\n") + "}\n"
	var result_colors = {fail = 'red', resist = 'yellow', success = 'green', crit_success = 'green'}
	var result_header = "[center]{color=%s|%s}[/center]\n" % [result_colors[result], tr('TRAININGRESULT_' + result.to_upper())]
	dialogue_data.text = chance_text + result_header + text + "\n" + effect_text

	input_handler.active_character = parent.get_ref()

	dialogue_data.options.append({code = 'close', text = tr("DIALOGUECLOSE"), reqs = []})

	input_handler.interactive_message_custom(dialogue_data)

	if training_finished_now:
		var announce_data = {
			text = tr('TRAININGCOMPLETEDANNOUNCE') % parent.get_ref().get_short_name(),
			image = 'praise',
			tags = [],
			options = [{code = 'close', text = tr("DIALOGUECONTINUE"), reqs = []}]
		}
		input_handler.interactive_message(announce_data, 'direct', {})


func get_dispositions_text():
	var text = tr('TRAININGDISPOSITIONS') + "\n"
	for dis in dispositions_known:
		var ddata = Skilldata.training_categories[dis]
		if dispositions_known[dis]:
			text += "%s : %s\n" % [tr(ddata.name), get_disposition_name(dispositions[dis])]
		else:
			text += "%s : %s\n" % [tr(ddata.name), tr('TRAININGDISPOSITIONUNKNOWN')]
	return text

#not used
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
	if ResourceScripts.game_globals.easytrain:
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
				text += "\n" + parent.get_ref().translate(tr('TRAININGNOTAVAILABLE'))
		elif reqs is Array:
			var f = false
			for decision in reqs:
				if ResourceScripts.game_progress.decisions.has(decision):
					f = true
			if !f:
				text += "\n" + parent.get_ref().translate(tr('TRAININGNOTAVAILABLEUNIQUE'))
		elif !ResourceScripts.game_globals.easytrain:
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


func process_chardata(chardata):
	if chardata.has('training_disposition'):
		process_disposition_data(chardata.training_disposition, true)
	if chardata.has('blocked_training_traits'):
		process_traits_availability_data(chardata.blocked_training_traits)
	if chardata.has('training_points'):
		training_points = chardata.training_points

#needed only for old saves. Remove with time
func fix_old_save():
	if !cooldown.has('positive'):
		if cooldown.has('main') and cooldown.main > 0:
			cooldown.positive = 1
		else:
			cooldown.positive = 0
	if cooldown.has('main'):
		cooldown.erase('main')
	if !cooldown.has('negotiation'):
		cooldown.negotiation = 0
	if parent.get_ref().get_stat('slave_class') == 'heir':
		for tr in variables.servant_unlock_traits:
			parent.get_ref().add_trait(tr)
