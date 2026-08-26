extends Node

var person

var negotiation_category = ''
var negotiation_cost = 0

const NEGOTIATION_DATA = {
	training_s_working = {
		percent = 0.10,
		hesitation_charge = 'NEGOTIATION_HESITATION_WORKING_CHARGE',
		hesitation_force = 'NEGOTIATION_HESITATION_WORKING_FORCE',
		persuade_force = 'NEGOTIATION_PERSUADE_FORCE_WORKING',
		log_paid = 'NEGOTIATION_LOG_PAID_WORKING',
		log_charge = 'NEGOTIATION_LOG_CHARGE_WORKING',
		log_force = 'NEGOTIATION_LOG_FORCE_WORKING',
	},
	training_s_combat = {
		percent = 0.15,
		hesitation_charge = 'NEGOTIATION_HESITATION_COMBAT_CHARGE',
		hesitation_force = 'NEGOTIATION_HESITATION_COMBAT_FORCE',
		persuade_force = 'NEGOTIATION_PERSUADE_FORCE_COMBAT',
		log_paid = 'NEGOTIATION_LOG_PAID_COMBAT',
		log_charge = 'NEGOTIATION_LOG_CHARGE_COMBAT',
		log_force = 'NEGOTIATION_LOG_FORCE_COMBAT',
	},
	training_s_relation = {
		percent = 0.10,
		hesitation_charge = 'NEGOTIATION_HESITATION_DATING_CHARGE',
		hesitation_force = 'NEGOTIATION_HESITATION_DATING_FORCE',
		persuade_force = 'NEGOTIATION_PERSUADE_FORCE_DATING',
		log_paid = 'NEGOTIATION_LOG_PAID_DATING',
		log_charge = 'NEGOTIATION_LOG_CHARGE_DATING',
		log_force = 'NEGOTIATION_LOG_FORCE_DATING',
	},
	training_s_sexservice = {
		percent = 0.20,
		hesitation_charge = 'NEGOTIATION_HESITATION_SEX_CHARGE',
		hesitation_force = 'NEGOTIATION_HESITATION_SEX_FORCE',
		persuade_force = 'NEGOTIATION_PERSUADE_FORCE_SEX',
		log_paid = 'NEGOTIATION_LOG_PAID_SEX',
		log_charge = 'NEGOTIATION_LOG_CHARGE_SEX',
		log_force = 'NEGOTIATION_LOG_FORCE_SEX',
	},
	training_s_sexservice_adv = {
		percent = 0.25,
		hesitation_charge = 'NEGOTIATION_HESITATION_SEXSERVICE_CHARGE',
		hesitation_force = 'NEGOTIATION_HESITATION_SEXSERVICE_FORCE',
		persuade_force = 'NEGOTIATION_PERSUADE_FORCE_SEXSERVICE',
		log_paid = 'NEGOTIATION_LOG_PAID_SEXSERVICE',
		log_charge = 'NEGOTIATION_LOG_CHARGE_SEXSERVICE',
		log_force = 'NEGOTIATION_LOG_FORCE_SEXSERVICE',
	},
}

const NEGOTIATION_FORCE_RESPECT_LOSS = 30
const NEGOTIATION_FORCE_AFFECTION_LOSS = 15
const NEGOTIATION_INSTANT_AGREE_THRESHOLD = 60
const NEGOTIATION_INSTANT_AGREE_CHANCE = 0.20
const NEGOTIATION_TAME_INSTANT_AGREE_CHANCE = 0.50

func negotiation_select_working():
	negotiation_open('training_s_working')

func negotiation_select_combat():
	negotiation_open('training_s_combat')

func negotiation_select_dating():
	negotiation_open('training_s_relation')

func negotiation_select_sex():
	negotiation_open('training_s_sexservice')

func negotiation_select_sexservice():
	negotiation_open('training_s_sexservice_adv')

func negotiation_open(category):
	var character = input_handler.active_character
	person = character
	negotiation_category = category

	var instant_agree_chance = NEGOTIATION_INSTANT_AGREE_CHANCE
	if character.get_stat('tame_factor') >= 6:
		instant_agree_chance = NEGOTIATION_TAME_INSTANT_AGREE_CHANCE

	if (character.get_stat('respect') >= NEGOTIATION_INSTANT_AGREE_THRESHOLD or character.get_stat('affection') >= NEGOTIATION_INSTANT_AGREE_THRESHOLD) and randf() < instant_agree_chance:
		negotiation_finish(tr('NEGOTIATION_LOG_INSTANT'))
		return

	character.training.cooldown.negotiation = 3
	negotiation_refresh_panel()
	var text_data = NEGOTIATION_DATA[category]

	var value = character.calculate_price()
	var cost = value * text_data.percent * (1.0 - 0.05 * character.get_stat('tame_factor'))
	negotiation_cost = int(max(0, round(cost)))

	var persuade_pool = ['break', 'force']
	var master = ResourceScripts.game_party.get_master()
	if master.get_stat('chg_persuasion') < master.get_stat('chg_persuasion_max'):
		persuade_pool.append('charge')
	var persuade_type = input_handler.random_from_array(persuade_pool)

	var options = []
	options.append({code = 'negotiation_pay', text = tr('NEGOTIATION_PAY') % negotiation_cost, reqs = [{type = 'has_money', value = negotiation_cost}], not_hide = true, active_char_translate = true})

	var hesitation_key = 'NEGOTIATION_HESITATION_BREAK'
	match persuade_type:
		'break':
			options.append({code = 'negotiation_persuade_break', text = tr('NEGOTIATION_PERSUADE_BREAK'), reqs = [], active_char_translate = true})
		'charge':
			options.append({code = 'negotiation_persuade_charge', text = tr('NEGOTIATION_PERSUADE_CHARGE'), reqs = [], active_char_translate = true})
			hesitation_key = text_data.hesitation_charge
		'force':
			options.append({code = 'negotiation_persuade_force', text = tr(text_data.persuade_force), reqs = [], active_char_translate = true})
			hesitation_key = text_data.hesitation_force

	options.append({code = 'close', text = tr('NEGOTIATION_CANCEL'), reqs = []})

	var dialogue_data = {
		text = tr(hesitation_key) % character.get_short_name(),
		image = 'praise',
		tags = ['custom_effect', 'active_character_translate'],
		options = options,
	}
	input_handler.active_character = character
	input_handler.interactive_message_custom(dialogue_data)


func negotiation_pay():
	ResourceScripts.game_res.money -= negotiation_cost
	person.training.cooldown.negotiation = 0
	negotiation_finish(tr(NEGOTIATION_DATA[negotiation_category].log_paid) % negotiation_cost)

func negotiation_persuade_break():
	person.affect_char({type = 'set_availability', value = false, duration = 2})
	negotiation_finish(tr('NEGOTIATION_LOG_BREAK'))

func negotiation_persuade_charge():
	var master = ResourceScripts.game_party.get_master()
	master.add_stat('chg_persuasion', 1)
	negotiation_finish(tr(NEGOTIATION_DATA[negotiation_category].log_charge))

func negotiation_persuade_force():
	person.add_stat('respect', -NEGOTIATION_FORCE_RESPECT_LOSS)
	person.add_stat('affection', -NEGOTIATION_FORCE_AFFECTION_LOSS)
	var breakdown_note = ''
	if randf() < 0.1:
		person.affect_char({type = 'set_availability', value = false, duration = 1})
		breakdown_note = " " + tr('NEGOTIATION_LOG_FORCE_BREAKDOWN')
	var log_text = tr(NEGOTIATION_DATA[negotiation_category].log_force) % [NEGOTIATION_FORCE_RESPECT_LOSS, NEGOTIATION_FORCE_AFFECTION_LOSS]
	negotiation_finish(log_text + breakdown_note)

func negotiation_finish(log_text):
	person.add_trait(negotiation_category)
	person.log_me(person.translate(log_text))
	negotiation_refresh_panel()

	var category_label = Traitdata.traits[negotiation_category].name
	var closing_text = log_text + "\n\n" + tr('NEGOTIATION_UNLOCKED_TEXT') % [person.get_short_name(), category_label]
	var dialogue_data = {
		text = closing_text,
		image = 'praise',
		tags = ['active_character_translate'],
		options = [{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []}],
	}
	input_handler.active_character = person
	input_handler.interactive_message_custom(dialogue_data)


func negotiation_refresh_panel():
	if gui_controller.mansion == null:
		return
	var popup = gui_controller.mansion.get_node_or_null("CharacterTrainingPopup")
	if popup != null:
		popup.match_state()


func hairdye(character):
	person = character
	input_handler.active_character = person
	var node = input_handler.get_spec_node(input_handler.NODE_TEXTEDIT) #input_handler.GetTextEditNode()
	node.open(self, 'set_hair_color', person.get_stat('hair_color'), person.translate("Select new hair color for [name]"))

func set_hair_color(text):
	person.set_stat('hair_color', text)
	person.set_stat('portrait_update', true)
	input_handler.emit_signal('update_ragdoll')

func minorus_potion(character):
	person = character
	input_handler.active_character = person
	input_handler.interactive_message("minorus_potion_select",'custom_effect', {})

func majorus_potion(character):
	person = character
	input_handler.active_character = person
	input_handler.interactive_message("majorus_potion_select",'custom_effect', {})

func minorus_tits():
	var character = person
	if !character.get_stat('tits_size') in ['masculine','flat']:
		character.set_stat('tits_size', variables.slave_basic_sizes[variables.slave_basic_sizes.find(character.get_stat('tits_size')) - 1])
		input_handler.interactive_message_follow("minorus_potion_tits",'char_translate',{ch = character})
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})

func minorus_ass():
	var character = person
	if !character.get_stat('ass_size') in ['masculine','flat']:
		character.set_stat('ass_size', variables.slave_basic_sizes[variables.slave_basic_sizes.find(character.get_stat('ass_size')) - 1])
		input_handler.interactive_message_follow("minorus_potion_ass",'char_translate',{ch = character})
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})

func minorus_balls():
	var character = person
	if !character.get_stat('balls_size') in ['small']:
		character.set_stat('balls_size', variables.slave_genital_sizes[variables.slave_genital_sizes.find(character.get_stat('balls_size')) - 1])
		input_handler.interactive_message_follow("minorus_potion_balls",'char_translate',{ch = character})
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})

func minorus_penis():
	var character = person
	if !character.get_stat('penis_size') in ['small']:
		character.set_stat('penis_size', variables.slave_genital_sizes[variables.slave_genital_sizes.find(character.get_stat('penis_size')) - 1])
		input_handler.interactive_message_follow("minorus_potion_penis",'char_translate',character)
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})

func majorus_tits():
	var character = person
	if !character.get_stat('tits_size') in ['huge']:
		character.set_stat('tits_size', variables.slave_basic_sizes[variables.slave_basic_sizes.find(character.get_stat('tits_size')) + 1])
		input_handler.interactive_message_follow("majorus_potion_tits",'char_translate',{ch = character})
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})

func majorus_ass():
	var character = person
	if !character.get_stat('ass_size') in ['huge']:
		character.set_stat('ass_size', variables.slave_basic_sizes[variables.slave_basic_sizes.find(character.get_stat('ass_size')) + 1])
		input_handler.interactive_message_follow("majorus_potion_ass",'char_translate',{ch = character})
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})

func majorus_balls():
	var character = person
	if !character.get_stat('balls_size') in ['big']:
		character.set_stat('balls_size', variables.slave_genital_sizes[variables.slave_genital_sizes.find(character.get_stat('balls_size')) + 1])
		input_handler.interactive_message_follow("majorus_potion_balls",'char_translate',{ch = character})
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})

func majorus_penis():
	var character = person
	if !character.get_stat('penis_size') in ['big']:
		character.set_stat('penis_size', variables.slave_genital_sizes[variables.slave_genital_sizes.find(character.get_stat('penis_size')) + 1])
		input_handler.interactive_message_follow("majorus_potion_penis",'char_translate',{ch = character})
	else:
		input_handler.interactive_message_follow("potion_no_effect", '', {})
	#input_handler.update_slave_panel()

func writ_of_exemption(character):
	person = character
	input_handler.active_character = person
	input_handler.interactive_message_follow("writ_of_exemption",'custom_effect', {})



func writ_of_exemption_use(): #possibly rework
	var character = person
	var acceptance_req = 100
	var acceptance_chance = 100
	ResourceScripts.game_res.remove_item("writ_of_exemption", 1)
	input_handler.scene_characters = [person]
	if gui_controller.inventory.visible:
		gui_controller.close_scene(gui_controller.inventory)
	if gui_controller.slavepanel != null && gui_controller.slavepanel.visible:
		gui_controller.close_scene(gui_controller.slavepanel)
#	if character.get_stat('loyalty') == 100:
#		acceptance_chance = 100
#	else:
#		acceptance_chance = character.get_stat('loyalty')
#		acceptance_chance = acceptance_chance - acceptance_chance * variables.personality_conversion_rates[character.get_stat('personality')]
	if acceptance_chance >= randf()*acceptance_req:
		input_handler.interactive_message_follow("writ_of_exemption_success",'char_translate',{ch = character})
		character.set_slave_category('servant')
		character.add_trait('training_s_combat')
		character.add_trait('training_s_working')
		if character.has_status('relation'):
			character.add_trait('training_s_relation')
#		character.add_stat('loyalty', 25)
	else:
		input_handler.interactive_message_follow("writ_of_exemption_failure",'char_translate',{ch = character})
		ResourceScripts.game_party.add_fate(character.id, tr("SIBLINGMODULEFATEREMOVED"))
		ResourceScripts.game_party.remove_slave(character, true)
	input_handler.rebuild_slave_list()

func oblivionpot(character):
	var refundable_classes = []
	for prof in character.get_professions():
		if prof in ['master', 'spouse']:
			continue
		if !classesdata.professions.has(prof):
			continue
		if classesdata.professions[prof].tags.has('permanent'):
			continue
		refundable_classes.append(prof)
	var refund_exp = 0
	var current_class_count = character.get_prof_number()
	for idx in range(refundable_classes.size()):
		var class_count = max(0, current_class_count - 1 - idx)
		var exp_reqs = variables.hard_level_reqs
		if class_count >= exp_reqs.size():
			refund_exp += exp_reqs[exp_reqs.size() - 1]
		else:
			refund_exp += exp_reqs[class_count]
	if refund_exp > 0:
		refund_exp = floor(refund_exp * 0.9)
		character.add_stat('base_exp_direct', refund_exp)
	character.reset_mastery()
	character.reset_minor_training()
	character.remove_all_classes()
	character.process_event(variables.TR_OBLIVION)
	input_handler.active_character = character
	input_handler.interactive_message("oblivion_potion_use")
	character.try_breakdown('brk_oblivion')


func sex_swap(character):
	input_handler.active_character = character
	match character.get_stat('sex'):
		'male':
			character.set_stat('sex', 'female')
			input_handler.interactive_message_follow("sex_swap_potion_female",'char_translate', {ch = character})
		'female':
			character.set_stat('sex', 'male')
			input_handler.interactive_message_follow("sex_swap_potion_male",'char_translate', {ch = character})
	character.swap_alternate_exterior()
	character.set_stat('portrait_update', true)
	input_handler.emit_signal('update_ragdoll')
	


func zephyra_underwear(character):
	if gui_controller.inventory.visible:
		gui_controller.close_scene(gui_controller.inventory)
	input_handler.active_character = ResourceScripts.game_party.get_unique_slave('zephyra')
	input_handler.interactive_message_follow("zephyra_underwear",'custom_effect', {})

func zephyra_underwear_use():
	input_handler.interactive_message_follow("zephyra_underwear_use",'custom_effect', {})


func trait_removal(character):
	input_handler.get_spec_node(input_handler.NODE_TRAIREM_PANEL).open(character)


func pheromones(character):
	input_handler.active_character = character
	if character.get_stat('race') in races.race_groups.halfbeast + races.race_groups.beast:
		character.add_stat("lust", character.get_stat("lustmax"))
	input_handler.interactive_message("pheromones_use",'char_translate',{ch = character})

func sensitivity_pot(character):
	input_handler.active_character = character
	character.add_stat("lust", character.get_stat("lustmax"))
	input_handler.interactive_message("sensitivity_pot_use",'char_translate',{ch = character})

func lactation_pot(character):
	input_handler.active_character = character
	character.set_stat('lactation', !character.get_stat('lactation'))
	if character.get_stat('lactation') == true:
		input_handler.interactive_message_follow("lactation_potion_success",'char_translate',{ch = character})
	else:
		input_handler.interactive_message_follow("lactation_potion_reverse",'char_translate',{ch = character})

func close():#for the cancel function
	input_handler.get_spec_node(input_handler.NODE_DIALOGUE).close()

func map(dungeon_code):
	var dungeon = DungeonData.dungeons[dungeon_code]
	if dungeon.has('purchase_area'):
		input_handler.selected_area = ResourceScripts.game_world.areas[dungeon.purchase_area]
	if input_handler.selected_area.locations.size() < 8:
		var randomlocation = []
		for i in input_handler.selected_area.locationpool:
			randomlocation.append(DungeonData.dungeons[i].code)
		randomlocation = ResourceScripts.world_gen.make_location(
			dungeon.code, input_handler.selected_area
		)
		input_handler.selected_location = randomlocation.id
#		input_handler.active_area = active_area
		input_handler.selected_area.locations[randomlocation.id] = randomlocation
		ResourceScripts.game_world.location_links[randomlocation.id] = {
			area = input_handler.selected_area.code, category = 'locations'
		}
#		ResourceScripts.game_res.money -= dungeon.purchase_price
		input_handler.interactive_message(
			'purchase_dungeon_location', 'location_purchase_event', {}
		)


func skill_grant(character, skill):
	character.learn_c_skill(skill)


func class_copy(character, target):
	var data = {text = '', tags = ['skill_report_event'], options = []}
	var text
	var has_option = false
	var unavailable_classes = []
	for prof in target.get_professions():
		if character.has_profession(prof):
			continue
		if prof in ['master', 'spouse']:
			continue
		if !classesdata.professions.has(prof):
			continue
		var profdata = classesdata.professions[prof]
		var is_racial = false
		var can_obtain = true
		var unmet_reqs = []
		for req in profdata.reqs:
			if req.code in ['race', 'one_of_races']:
				is_racial = true
				continue
			if !character.valuecheck(req):
				can_obtain = false
				unmet_reqs.append(req)
		if is_racial and can_obtain:
			has_option = true
			var op_text = tr(ResourceScripts.descriptions.get_class_name(profdata, character))
			var op_bonus = []
			op_bonus.push_back({code = 'affect_active_character', type = 'remove_soc_skill', skill = 'class_copy'})
			op_bonus.push_back({code = 'affect_active_character', type = 'add_class', class = prof})
			data.options.append({code = 'close', text = op_text, reqs = [], bonus_effects = op_bonus})
		elif is_racial and !unmet_reqs.empty():
			var unavailable_class_name = tr(ResourceScripts.descriptions.get_class_name(profdata, character))
			var req_text = character.decipher_reqs(unmet_reqs, true)
			unavailable_classes.append("{color=yellow|%s}\n%s" % [unavailable_class_name, req_text])
	
	data.options.append({code = 'close', text = tr("DIALOGUECLOSE"), reqs = []})
	if has_option:
		text = tr("DIALOGUECLASS_COPYREPORT")
	else:
		text = tr("DIALOGUECLASS_COPYREPORT_FAILED")
	if !unavailable_classes.empty():
		text += "\n\n" + tr("REQUIREMENTS_TOOLTIP") + ":\n"
		text += PoolStringArray(unavailable_classes).join("\n\n")
	
	text = character.translate(text)
	text = target.translate(text.replace("[target", "["))
	data.text = text
	input_handler.active_character = character
	input_handler.interactive_message_custom(data)
	
