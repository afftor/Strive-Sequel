extends Reference

var parent
var social_skills = []
var social_cooldowns = {}
var social_skills_charges = {}
var combat_skills = []
var combat_skill_charges = {}
var combat_cooldowns = {}
var daily_cooldowns = {}
var social_skill_panel = {}
var combat_skill_panel = {}
var active_panel = variables.PANEL_SOC
var skills_received_today = []

var items_used_global = {}
var items_used_today = {}

var prepared_act = []

func setup_skills(data):
	combat_skills = data.skills.duplicate() 
	if !data.skills.has("ranged_attack") and !combat_skills.has('attack'):
		combat_skills.push_back('attack')

func get_damage_mod(skill:Dictionary):
	#stub. needs filling
	var damage_mods = parent.get_stat('damage_mods')
	if skill.type == 'social': return 1
	var res = damage_mods['all']
	if skill.target_range == 'melee' and damage_mods.has('melee'): res *= damage_mods['melee']
	if skill.target_range == 'weapon' and parent.get_weapon_range() == 'melee' and damage_mods.has('melee'): res *= damage_mods['melee']
	if skill.target_range == 'any' and damage_mods.has('ranged'): res *= damage_mods['ranged']
	if skill.target_range == 'weapon' and parent.get_weapon_range() == 'any' and damage_mods.has('ranged'): res *= damage_mods['ranged']
	return res

func learn_skill(skill):
	if !social_skills.has(skill):
		social_skills.append(skill)
		if social_skill_panel.size() < 11:
			for i in range(1,12):
				if social_skill_panel.has(i) == false:
					social_skill_panel[i] = skill
					break

func learn_c_skill(skill):
	if !combat_skills.has(skill):
		combat_skills.append(skill)
		if combat_skill_panel.size() < 11:
			for i in range(1,12):
				if combat_skill_panel.has(i) == false:
					combat_skill_panel[i] = skill
					break

func unlearn_skill(skill):
	if !parent.xp_module.check_skill_prof(skill):
		social_skills.erase(skill)
		social_cooldowns.erase(skill)
		daily_cooldowns.erase(skill)
		social_skills_charges.erase(skill)
		for i in range(1,12):
			if social_skill_panel.has(i) and social_skill_panel[i] == skill: social_skill_panel.erase(i)

func unlearn_c_skill(skill):
	if !parent.xp_module.check_skill_prof(skill):
		combat_skills.erase(skill)
		combat_cooldowns.erase(skill)
		daily_cooldowns.erase(skill)
#		combat_skills_charges.erase(skill)
		for i in range(1,12):
			if combat_skill_panel.has(i) and combat_skill_panel[i] == skill: combat_skill_panel.erase(i)
func cooldown_tick():
	items_used_today.clear()
	skills_received_today.clear()
	
	var cleararray = []
	for i in social_cooldowns:
		social_cooldowns[i] -= 1
		if social_cooldowns[i] <= 0:
			social_skills_charges.erase(i)
			cleararray.append(i)
	
	for i in cleararray:
		social_cooldowns.erase(i)
	
	for i in daily_cooldowns:
		daily_cooldowns[i] -= 1
		if daily_cooldowns[i] <= 0:
			cleararray.append(i)
			combat_skill_charges.erase(i)
	
	for i in cleararray:
		daily_cooldowns.erase(i)

func skill_tooltip(skillcode):
	var text = ''
	var skill = Skilldata.Skilllist[skillcode]
	text += "[center]" + skill.name + "[/center]\n" + skill.descript
	var manacost = skill.manacost
	var energycost = skill.energycost
	return text

func get_skill_by_tag(tg):
	for s in combat_skills:
		var s_f = Skilldata.Skilllist[s]
		if s_f.tags.has(tg): return s

func restore_skill_charge(code):
	if social_skills_charges.has(code):
		social_skills_charges[code] -= 1
		if social_skills_charges[code] <= 0:
			social_cooldowns.erase(code)
			social_skills_charges.erase(code)
	if ResourceScripts.game_party.global_skills_used.has(code):
		ResourceScripts.game_party.global_skills_used[code] -= 1
		if ResourceScripts.game_party.global_skills_used[code] <= 0:
			ResourceScripts.game_party.global_skills_used.erase(code)

func use_social_skill(s_code, target):
	var template = Skilldata.Skilllist[s_code]
	if template.has('special'):
		ResourceScripts.custom_effects.call(template.special, parent)
		return
	if target != null:
		var check = parent.check_skill_availability(s_code, target)
		if check.check == false:
			#input_handler.SystemMessage(check.descript)
			globals.text_log_add('skill',check.descript)
			return
	
	social_cooldowns[s_code] = template.cooldown
	
	if template.has('social_skill_stats'):
		for i in template.social_skill_stats:
			parent.set_stat(i, min(parent.get_stat(i) + rand_range(0.4,0.8), parent.get_stat(i+ "_factor")*20))
	if template.tags.has("dialogue_skill"):
		var data = {text = '', image = template.dialogue_image, tags = ['skill_event'], options = []}
		var text = parent.translate(template.dialogue_text)
		text = target.translate(text.replace("[target", "["))
		data.text = text
		
		var charges = Skilldata.get_charges(template, parent)
		if charges > 0 && variables.social_skill_unlimited_charges == false && !template.has('custom_used_charges'):
			if social_skills_charges.has(s_code):
				social_skills_charges[s_code] += 1
			else:
				social_skills_charges[s_code] = 1
		
		if template.has("globallimit"):
			if ResourceScripts.game_party.global_skills_used.has(template.code):
				ResourceScripts.game_party.global_skills_used[template.code] += 1
			else:
				ResourceScripts.game_party.global_skills_used[template.code] = 1
		
		input_handler.active_character = parent
		input_handler.target_character = target
		input_handler.activated_skill = s_code
		for i in template.dialogue_options:
			data.options.append(i)
		data.options.append({code = 'cancel_skill_usage', text = "Cancel", reqs = []})
		input_handler.scene_characters.append(target)
		input_handler.interactive_message_custom(data)
		return
	input_handler.last_action_data = {code = 'social_skill', skill = s_code, caster = parent, target = target}
	
	input_handler.PlaySound('page')
	
	#paying costs
	if template.has('goldcost'):
		ResourceScripts.game_res.money -= template.goldcost
	parent.mp -= template.manacost
	
	if typeof(template.charges) == TYPE_INT && template.charges > 0 && variables.social_skill_unlimited_charges == false:
		if social_skills_charges.has(s_code):
			social_skills_charges[s_code] += 1
		else:
			social_skills_charges[s_code] = 1
	
	if template.has("globallimit"):
		if ResourceScripts.game_party.global_skills_used.has(template.code):
			ResourceScripts.game_party.global_skills_used[template.code] += 1
		else:
			ResourceScripts.game_party.global_skills_used[template.code] = 1
	
	#calcuate 'all' receviers
	var targ_targ = [target]
	var targ_cast = [parent]
	var targ_all = []
	for h_id in ResourceScripts.game_party.characters:
		if parent.id == h_id || target != null and target.id == h_id: continue
		if ResourceScripts.game_party.characters[h_id].get_work() == 'travel':continue
		if !parent.same_location_with(ResourceScripts.game_party.characters[h_id]): continue
		targ_all.push_back(ResourceScripts.game_party.characters[h_id])
	
	#create s_skill and process triggers
	var s_skill = ResourceScripts.scriptdict.class_sskill.new()
	s_skill.createfromskill(s_code)
	s_skill.setup_caster(parent)
	s_skill.setup_target(target)
	s_skill.process_event(variables.TR_CAST)
	s_skill.setup_final()
	s_skill.hit_roll()
	s_skill.resolve_value(true)
	s_skill.apply_random()
	s_skill.setup_effects_final()
	parent.process_event(variables.TR_S_CAST, s_skill)
	if target != null:
		target.process_event(variables.TR_S_TARGET, s_skill)
	#assumption that no social skill will have more than 1 repeat or target_number 
	#s_skill.calculate_dmg() not really needed
	#to implement not fully described social chance-to-success system 
	
	var effect_text = '\n'
	#applying values
	for i in s_skill.value:
		var targ_fin
		match i.receiver:
			'caster': targ_fin = targ_cast
			'target': targ_fin = targ_targ
			'all': targ_fin = targ_all
		if i.damagestat == 'no_stat':
			if template.has('process_no_stat'):
				for h in targ_fin:
					for e in s_skill.effects:
						var eff:triggered_effect = effects_pool.get_effect_by_id(e)
						eff.set_args('receiver', h)
						eff.process_event(variables.TR_SOC_SPEC)
						eff.set_args('receiver', null)
			continue
		var detail_tags = []
		for h in targ_fin:
			var mod = i.dmgf
			var stat = i.damagestat
			
			match stat:
				'loyalty':
					if mod == 0:
						if target.authority_threshold()/2 > target.get_stat('authority'):
							i.value = 0
							detail_tags.append('noauthority')
						elif target.get_stat('loyalty') >= 100:
							i.value = 0
							detail_tags.append('loyaltymaxed')
						else:
							if template.tags.has("repeated_effect_reduce_loyalty") && target.skills.skills_received_today.has(s_code):
								i.value /= 2.5
								detail_tags.append("loyalty_repeat")
							i.value = (i.value * (0.75 + target.get_stat('tame_factor')*0.25)) * (1 - (target.authority_threshold() - target.get_stat('authority'))/100)
				
				'submission':
					if target.get_stat('submission') >= 100:
						i.value = 0
						detail_tags.append('submissionmaxed')
					else:
						if template.tags.has("repeated_effect_reduce_submission") && target.skills.skills_received_today.has(s_code):
							i.value /= 2.5
							detail_tags.append("submission_repeat")
						i.value = (i.value * (0.75 + target.get_stat('timid_factor')*0.25))
				
				'obedience':
					var skill_stat_type
					if template.tags.has('positive'): skill_stat_type = target.get_stat('tame_factor')
					if template.tags.has('negative'): skill_stat_type = target.get_stat('timid_factor')
					i.value = round(i.value * (0.9 + skill_stat_type*0.1))
			
			var bonusspeech = []
			var tmp
			match mod:
				0:
					if stat == 'loyalty' && h.get_stat(stat) < 100 && h.get_stat(stat) + i.value >= 100:
						bonusspeech.append('loyalty')
					elif stat == 'submission' && h.get_stat(stat) < 100 && h.get_stat(stat) + i.value >= 100:
						if h.get_stat('loyalty') < 100:
							bonusspeech.append("submission")
							if h.get_stat('growth_factor') > h.get_stat('sexuals_factor'):
								h.add_stat('growth_factor', -1)
							elif h.get_stat('sexuals_factor') > 1:
								h.add_stat('sexuals_factor', -1)
						else:
							bonusspeech.append("submission_loyalty")
					tmp = h.stat_update(stat, i.value)
					if i.is_drain: parent.stat_update(stat, -tmp)
				1:
					tmp = h.stat_update(stat, -i.value)
					if i.is_drain: parent.stat_update(stat, -tmp)
				2:
					tmp = h.stat_update(stat, i.value, true)
					if i.is_drain: parent.stat_update(stat, -tmp)

			effect_text += "\n" + h.get_short_name() + ", " + statdata.statdata[stat].name
			var maxstat = 100
			if h.get_stat(stat+'max') != null:
				maxstat = h.get_stat(stat + "max")
			elif i.damagestat.find("factor")>=0:
				maxstat = 0
			var change = '+'
			if tmp < 0:
				change = ''
			effect_text += ": "
			if maxstat != 0 && !stat in ['obedience','loyalty','authority','submission','consent']:
				effect_text += str(floor(h.get_stat(stat))) +"/" + str(floor(maxstat)) +  " (" + change + "" + str(floor(tmp)) + ")"
			else:
				effect_text += change + str(floor(tmp))
			if detail_tags.has("noauthority") && stat == 'loyalty':
				effect_text += " - Not enough Authority"
			if detail_tags.has("loyalty_repeat") && !detail_tags.has("noauthority") && stat == 'loyalty':
				effect_text += "(lowered effect)"
			if detail_tags.has("submission_repeat") && stat == 'submission':
				effect_text += "(lowered effect)"
			if detail_tags.has("loyaltymaxed") && stat == 'loyalty':
				effect_text += " - Maxed"
			if detail_tags.has("submissionmaxed") && stat == 'submission':
				effect_text += ' - Maxed'
			for i in bonusspeech:
				effect_text += "\n\n{color=aqua|"+ h.get_short_name() + "} - {random_chat=0|"+ i +"}\n"
	
	if target.skills.skills_received_today.has(s_code) == false: target.skills.skills_received_today.append(s_code)
	
	if template.has("dialogue_report"):
		var data = {text = '', tags = ['skill_report_event'], options = []}
		var text = parent.translate(template.dialogue_report)
		if template.has('dialogue_image'):
			data.image = template.dialogue_image
		else:
			data.image = 'noevent'
		text = target.translate(text.replace("[target", "["))
		data.text = text + effect_text
		
		if template.dialogue_show_repeat == true:
			data.options.append({code ='repeat', text = tr('DIALOGUEREPEATACTION'), disabled = true, reqs = []})
			if parent.check_skill_availability(s_code, target).check == true:
				data.options[0].disabled = false
		
		input_handler.active_character = parent
		input_handler.target_character = target
		input_handler.activated_skill = s_code
		if input_handler.scene_characters.has(target) == false: input_handler.scene_characters.append(target)
		
		data.options.append({code = 'close', text = tr("DIALOGUECLOSE"), reqs = []})
		
		input_handler.interactive_message_custom(data)
		
	#postdamage triggers
	s_skill.process_event(variables.TR_POSTDAMAGE)
	parent.process_event(variables.TR_POSTDAMAGE, s_skill)
	if target != null:
		target.process_event(variables.TR_POSTDAMAGE, s_skill)
	
	input_handler.update_slave_list()
	input_handler.update_slave_panel()

func use_mansion_item(item):
	var itembase = Items.itemlist[item.itembase]
	var skill = itembase.mansion_effect
	if parent.checkreqs(itembase.reqs) == false:
		input_handler.SystemMessage(itembase.reqs_fail_message)
		return
	if itembase.has("uses_per_target") && items_used_global.has(itembase.code) && items_used_global[itembase.code] >= itembase.uses_per_target:
		input_handler.SystemMessage(parent.translate("[name] can't use this item anymore."))
		return
	elif itembase.has("uses_per_target"):
		if items_used_global.has(itembase.code):
			items_used_global[itembase.code] += 1
		else:
			items_used_global[itembase.code] = 1
	if itembase.tags.has("save_on_use") == false:
		item.amount -= 1
	use_social_skill(skill, parent)

func act_prepared():
	for prep in prepared_act:
		use_social_skill(prep, null)
	prepared_act.clear()

func repair_skill_panels():
	var ssp = social_skill_panel.duplicate()
	social_skill_panel.clear()
	for i in ssp:
		if Skilldata.Skilllist.has(ssp[i]):
			social_skill_panel[int(i)] = ssp[i]
	ssp = combat_skill_panel.duplicate()
	combat_skill_panel.clear()
	for i in ssp:
		if Skilldata.Skilllist.has(ssp[i]):
			combat_skill_panel[int(i)] = ssp[i]
	var cleararray = []
	for i in [social_skills, combat_skills]:
		for k in i:
			if Skilldata.Skilllist.has(k) == false:
				cleararray.append(k)
	for i in cleararray:
		for k in [social_skills, combat_skills]:
			k.erase(i)
