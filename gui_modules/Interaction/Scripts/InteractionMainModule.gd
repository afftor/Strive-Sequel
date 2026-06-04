extends Control
#warning-ignore-all:function_conflicts_variable

onready var parser = ResourceScripts.scriptdict.sexinteraction_parser.new()
onready var member = ResourceScripts.scriptdict.sexinteraction_member
onready var sexdict = ResourceScripts.scriptdict.sexinteraction_sexdict.new()

var participants = [] #members
var givers = [] #members
var takers = [] #members
var turns = 0
var actions = []
var ongoingactions = []
var location
var selectmode = 'normal'
var npcs = []
var aiobserve = false #True - player will not be picked by AI

var takercategories = ['cunnilingus','rimjob','handjob','titjob','tailjob','blowjob']
var analcategories = ['assfingering','rimjob','missionaryanal','doggyanal','lotusanal','revlotusanal','ontopanal','doubledildoass','inserttaila','analvibrator','enemaplug','insertinturnsass']
var punishcategories = []#globals.punishcategories
var penetratecategories = ['missionary','missionaryanal','doggy','doggyanal','lotus','lotusanal','revlotus','revlotusanal','doubledildo','doubledildoass','inserttailv','inserttaila','tribadism','frottage']


var filter = ['nosehook','relaxinginsense','facesit','afacesit','grovel','enemaplug']

var statuseffects = ['tied', 'subdued', 'drunk', 'tipsy', 'resist', 'sexcrazed','pheromones']

var selectedcategory = 'caress'
var categories = {caress = [], fucking = [], tools = [], SM = [], humiliation = [], other = []}

var secondactorcounter = {}

var submodules = []

var last_action_dict_id = 0
var sex_minigame_points = 0
var sex_minigame_orgasm_points_awarded = []
var enthusiasm_mark_wrong_used = 0
var enthusiasm_all_options_correct = false
var enthusiasm_revealed_wrong_choices = []
var enthusiasm_choice_buttons = []
const ENTHUSIASM_MARK_WRONG_COSTS = [1, 1, 2]
const ENTHUSIASM_ALL_CORRECT_COST = 5


#not used
#func dog():
#	var person = globals.newslave(globals.allracesarray[rand_range(0,globals.allracesarray.size())], 'adult', 'male')
#	var newmember = member.new()
#	newmember.sceneref = self
#	person.obedience = 90
#	person.lewdness = 70
#	person.penistype = 'canine'
#	person.name = "Dog " + str(secondactorcounter.dog)
#	person.penis_size = input_handler.weightedrandom([['average',1],['big',1]])
#	person.asser = rand_range(65, 100)
#	person.unique = 'dog'
#	person.imageportait = null
#	for i in categories.fucking:
#		person.sexexp.actions[i.code] = 15
#	newmember.setup_person(person)
#	newmember.limbs = false
#	newmember.consent = 100
#	participants.append(newmember)
#
#func horse():
#	var person = globals.newslave(globals.allracesarray[rand_range(0,globals.allracesarray.size())], 'adult', 'male')
#	var newmember = member.new()
#	newmember.sceneref = self
#	person.obedience = 90
#	person.lewdness = 70
#	person.penistype = 'equine'
#	person.asser = rand_range(65, 100)
#	person.name = "Horse " + str(secondactorcounter.horse)
#	person.height = 'tall'
#	person.penis_size = 'big'
#	person.unique = 'horse'
#	person.imageportait = null
#	for i in categories.fucking:
#		person.sexexp.actions[i.code] = 15
#	newmember.setup_person(person)
#	newmember.limbs = false
#	newmember.consent = 100
#	participants.append(newmember)

# warning-ignore-all:return_value_discarded

func _ready():
#	for i in globals.dir_contents('res://src/actions'):
#		if i.find('.remap') >= 0:
#			continue
#		var newaction = load(i).new()
	$Panel/stopbutton.text = tr("INTERACTION_STOP")
	$Panel/blacklist.text = tr("INTERACTION_ACTION_VIS")
	$Panel/aiallow.text = tr("INTERACTION_ONLY_WATCH")
	$Panel/givetakepanel/Label.text = tr("INTERACTION_ACTORS")
	$Panel/givetakepanel/Label2.text = tr("INTERACTION_RECEIVERS")
	$Control/Panel/finishbutton.text = tr("INTERACTION_FINISH")
	$blacklist/closeblacklist.text = tr("DIALOGUECLOSE")
	$blacklist/RichTextLabel.bbcode_text = tr("INTERACTION_HIDE_ACTIONS_HINT")
	$ItemSelectSex/Label.text = tr("SELECTITEM")
	globals.connecttexttooltip($TextureFrame, tr("INTERACTION_CONNECTION_POINTS_TOOLTIP"))
	globals.connecttexttooltip($TextureFrame/Label, tr("INTERACTION_CONNECTION_POINTS_TOOLTIP"))
	$Panel/sceneeffects1.connect("meta_clicked", self, '_on_sceneeffects1_meta_clicked')
	for i in globals.sex_actions_dict.values():
		categories[i.category].append(i)
	for i in get_node("Panel/HBoxContainer").get_children():
		i.connect("pressed",self,'changecategory',[i.get_name()])

	filter = []#globals.state.actionblacklist

	$OrgasmDenial/ScrollContainer/VBoxContainer/Cum.connect('pressed', self, "OrgasmDenialCum")
	$OrgasmDenial/ScrollContainer/VBoxContainer/Beg.connect('pressed', self, "OrgasmDenialBeg")
	$OrgasmDenial/ScrollContainer/VBoxContainer/Deny.connect('pressed', self, "OrgasmDenialDeny")
	$EnthusiasmSelect/MarkWrongButton.connect("pressed", self, "EnthusiasmMarkWrong")
	$EnthusiasmSelect/AllCorrectButton.connect("pressed", self, "EnthusiasmAllCorrect")

	var i = 4
	if input_handler.CurrentScene == null:
		modding_core.handle_test_mode()
		gui_controller.sex_panel = self
		globals.AddItemToInventory(globals.CreateUsableItem("alcohol"))
		globals.AddItemToInventory(globals.CreateUsableItem("aphrodisiac"))
		globals.AddItemToInventory(globals.CreateUsableItem("strong_pheromones", 10))
		ResourceScripts.game_res.materials.rope = 1
		while i > 0:
			i -= 1
			createtestdummy()
		# createtestdummy('resist')
		sex_minigame_points = 10
		changecategory('caress')
		clearstate()

		rebuildparticipantslist()


var OrgasmDenyVictim
var OrgasmDenyPlayer
var pending_turn_text = ""
var pending_turn_scenescript = null
var pending_turn_dict_consents = null
var pending_turn_request_pool = []
var OrgasmDenyStage = 0

var enthusiasm_pending_member = null
var enthusiasm_pending_takers = []
var enthusiasm_pending_scene = null
var enthusiasm_pending_data = null
var enthusiasm_pending_upgrades = []
var enthusiasm_pending_action_ids = null
var enthusiasm_pending_consents = {}

var OrgasmDenyTextButtons = {
	cum = 'INTERACTION_ORGASM_DENY_BTN_CUM',
	beg = 'INTERACTION_ORGASM_DENY_BTN_BEG',
	deny = 'INTERACTION_ORGASM_DENY_BTN_DENY'
}
var OrgasmDenyText = {
	initiate = "INTERACTION_ORGASM_DENY_INITIATE",
	cum_female_petting = "INTERACTION_ORGASM_DENY_CUM_FEMALE_PETTING",
	cum_male_petting = "INTERACTION_ORGASM_DENY_CUM_MALE_PETTING",
	cum_female_fucking = "INTERACTION_ORGASM_DENY_CUM_FEMALE_FUCKING",
	cum_male_fucking =  "INTERACTION_ORGASM_DENY_CUM_MALE_FUCKING",
	beg = "INTERACTION_ORGASM_DENY_BEG",
	beg_success = "INTERACTION_ORGASM_DENY_BEG_SUCCESS",
	beg_failure = "INTERACTION_ORGASM_DENY_BEG_FAILURE",
	deny = "INTERACTION_ORGASM_DENY_DENY",
}

func OrgasmDenyInitiate(player, victim):
	OrgasmDenyPlayer = player
	OrgasmDenyVictim = victim
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
	$OrgasmDenial.show()
	$OrgasmDenial/RichTextLabel.bbcode_text = decoder(tr(OrgasmDenyText.initiate), [OrgasmDenyPlayer], [OrgasmDenyVictim])
	$OrgasmDenial/ScrollContainer/VBoxContainer/Cum.text = decoder(tr(OrgasmDenyTextButtons.cum),[OrgasmDenyPlayer], [OrgasmDenyVictim])
	$OrgasmDenial/ScrollContainer/VBoxContainer/Beg.text = decoder(tr(OrgasmDenyTextButtons.beg),[OrgasmDenyPlayer], [OrgasmDenyVictim])
	$OrgasmDenial/ScrollContainer/VBoxContainer/Deny.text = decoder(tr(OrgasmDenyTextButtons.deny),[OrgasmDenyPlayer], [OrgasmDenyVictim])
	OrgasmDenyStage = 0

func OrgasmDenialCum():
	var text = 'cum'
	if OrgasmDenyVictim.sex == 'female':
		text += '_female'
	else:
		text += '_male'
	if OrgasmDenyVictim.get_lastaction_ref_scene().category == 'fucking':
		text += '_fucking'
	else:
		text += '_petting'
	#$Panel/sceneeffects.bbcode_text +="\n" +
	$OrgasmDenial/ScrollContainer/VBoxContainer/Beg.show()
	OrgasmDenyVictim.orgasm(decoder(tr(OrgasmDenyText[text]), [OrgasmDenyPlayer], [OrgasmDenyVictim]))
	$OrgasmDenial.hide()
	rebuildparticipantslist()

func OrgasmDenialBeg():
	var text
	if OrgasmDenyVictim.consent < 2 && randf() >= 0.5:
		text = tr(OrgasmDenyText.beg_failure)
		OrgasmDenyStage = 1
	else:
		text = tr(OrgasmDenyText.beg_success)
		OrgasmDenyStage = 2
		OrgasmDenyVictim.begged_for_orgasm = true
	$OrgasmDenial/RichTextLabel.bbcode_text = decoder(text, [OrgasmDenyPlayer], [OrgasmDenyVictim])
	$OrgasmDenial/ScrollContainer/VBoxContainer/Beg.hide()

func OrgasmDenialDeny():
	OrgasmDenyVictim.sens -= 250
	#OrgasmDenyVictim.person.add_stat('submission' ,10 + OrgasmDenyVictim.person.get_stat('sexuals_factor')) #todo add new effect
	$OrgasmDenial.hide()
	$Panel/sceneeffects.bbcode_text +="\n" + decoder(tr(OrgasmDenyText.deny), [OrgasmDenyPlayer], [OrgasmDenyVictim])
	rebuildparticipantslist()

var cumdict = {
face = {reqs = [], name = "INTERACTION_CUM_TARGET_FACE", text = "INTERACTION_CUM_TEXT_FACE", specreqs = [], spectext = ''},
mouth = {reqs = [], name = "INTERACTION_CUM_TARGET_MOUTH", text = "INTERACTION_CUM_TEXT_MOUTH", specreqs = [], spectext = ''},
hair = {reqs = [{code = 'stat', stat = 'hair_length', operant = 'neq', value = 'bald'}], name = "INTERACTION_CUM_TARGET_HAIR", text = "INTERACTION_CUM_TEXT_HAIR", specreqs = [], spectext = ''},
chest = {reqs = [], name = "INTERACTION_CUM_TARGET_CHEST", text = "INTERACTION_CUM_TEXT_CHEST", specreqs = [], spectext = ''},
belly = {reqs = [], name = "INTERACTION_CUM_TARGET_BELLY", text = "INTERACTION_CUM_TEXT_BELLY", specreqs = [], spectext = ''},
pubis = {reqs = [], name = "INTERACTION_CUM_TARGET_PUBIS", text = "INTERACTION_CUM_TEXT_PUBIS", specreqs = [], spectext = ''},
pussy = {reqs = [{code = 'stat', stat = 'has_pussy', operant = 'eq', value = true}], name = "INTERACTION_CUM_TARGET_PUSSY", text = "INTERACTION_CUM_TEXT_PUSSY", specreqs = [], spectext = ''},
ass = {reqs = [], name = "INTERACTION_CUM_TARGET_ASS", text = "INTERACTION_CUM_TEXT_ASS", specreqs = [], spectext = ''},
back = {reqs = [], name = "INTERACTION_CUM_TARGET_BACK", text = "INTERACTION_CUM_TEXT_BACK", specreqs = [], spectext = ''},
feet = {reqs = [{code = 'stat', stat = 'body_shape', operant = 'in', value = ['humanoid','shortstack']}], name = "INTERACTION_CUM_TARGET_FEET", text = "INTERACTION_CUM_TEXT_FEET", specreqs = [], spectext = ''},
tail = {reqs = [{code = 'stat', stat = 'tail', operant = 'neq', value = ''}], name = "INTERACTION_CUM_TARGET_TAIL", text = "INTERACTION_CUM_TEXT_TAIL", specreqs = [], spectext = ''},
hands = {reqs = [{code = 'stat', stat = 'arms', operant = 'neq', value = 'wings'}], name = "INTERACTION_CUM_TARGET_HANDS", text = "INTERACTION_CUM_TEXT_HANDS", specreqs = [], spectext = ''},
}

func SelectCum(player, victim):
	OrgasmDenyPlayer = player
	OrgasmDenyVictim = victim
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
	$CumSelect.show()
	var text = tr("INTERACTION_CUM_SELECT_TEXT")
	$CumSelect/RichTextLabel.bbcode_text = decoder(text, [OrgasmDenyPlayer], [OrgasmDenyVictim])
	
	input_handler.ClearContainer($CumSelect/ScrollContainer/VBoxContainer)
	for part in cumdict.values():
		if victim.person.checkreqs(part.reqs) == false:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($CumSelect/ScrollContainer/VBoxContainer)
		newbutton.text = tr(part.name)
		newbutton.connect('pressed',self,'SelectCumTarget',[part])
		
		

var pending_bonus_action = null
var pending_bonus_fixed = null
var pending_bonus_fixed_is_giver = false

func show_bonus_partner_popup(action, partners, fixed_member, fixed_is_giver):
	if partners.size() == 1:
		_fire_bonus_action(action, fixed_member, fixed_is_giver, partners[0])
		return
	pending_bonus_action = action
	pending_bonus_fixed = fixed_member
	pending_bonus_fixed_is_giver = fixed_is_giver
	var prompt = ''
	if action.code == 'deny_orgasm':
		prompt = decoder(tr("INTERACTION_BONUS_DENY_PROMPT"), [fixed_member], [fixed_member])
	elif action.code == 'cum_select':
		prompt = decoder(tr("INTERACTION_BONUS_CUM_PROMPT"), [fixed_member], [fixed_member])
	var fixed_id = pending_bonus_fixed.person.id
	ResourceScripts.game_party.characters.erase(fixed_id)
	ResourceScripts.game_party.character_order.erase(fixed_id)
	input_handler.ShowSlaveSelectPanel(self, "_on_bonus_partner_selected", [], false, null, prompt)

func _on_bonus_partner_selected(character):
	var fixed_id = pending_bonus_fixed.person.id
	if !ResourceScripts.game_party.characters.has(fixed_id):
		ResourceScripts.game_party.characters[fixed_id] = pending_bonus_fixed.person
		ResourceScripts.game_party.character_order.append(fixed_id)
	if character == null:
		return
	for p in participants:
		if p.person.id == character.id:
			_fire_bonus_action(pending_bonus_action, pending_bonus_fixed, pending_bonus_fixed_is_giver, p)
			return

func _fire_bonus_action(action, fixed_member, fixed_is_giver, partner):
	if fixed_is_giver:
		trigger_bonus_action(action, fixed_member, partner)
	else:
		trigger_bonus_action(action, partner, fixed_member)

func trigger_bonus_action(action, giver_member, taker_member):
	givers = [giver_member]
	takers = [taker_member]
	startscene(action)

func SelectCumTarget(part):
	var orgasm_text = decoder(tr(part.text), [OrgasmDenyPlayer], [OrgasmDenyVictim])
	OrgasmDenyPlayer.orgasm(orgasm_text)
	$CumSelect.hide()
	get_node("Panel/sceneeffects").bbcode_text += '\n' + pending_turn_text
	if randf() < 0.15 && pending_turn_request_pool.size() > 0:
		generaterequest(pending_turn_request_pool[randi()%pending_turn_request_pool.size()])
	record_actions(pending_turn_scenescript, pending_turn_dict_consents)
	rebuildparticipantslist()

func EnthusiasmInitiate():
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
	$EnthusiasmSelect.show()
	$EnthusiasmSelect/RichTextLabel.bbcode_text = decoder(tr("INTERACTION_ENTHUSIASM_SELECT_TEXT"), [enthusiasm_pending_member], enthusiasm_pending_takers)
	input_handler.ClearContainer($EnthusiasmSelect/ScrollContainer/VBoxContainer)
	enthusiasm_mark_wrong_used = 0
	enthusiasm_all_options_correct = false
	enthusiasm_revealed_wrong_choices.clear()
	enthusiasm_choice_buttons.clear()
	var choices = enthusiasm_pending_data.choices
	for i in choices.size():
		var btn = input_handler.DuplicateContainerTemplate($EnthusiasmSelect/ScrollContainer/VBoxContainer)
		btn.text = decoder(tr(choices[i].name_key), [enthusiasm_pending_member], enthusiasm_pending_takers)
		_apply_enthusiasm_choice_color(btn, choices[i].personality)
		btn.connect("pressed", self, "EnthusiasmChoose", [i])
		enthusiasm_choice_buttons.append(btn)
	_update_enthusiasm_meta_buttons()

func EnthusiasmMarkWrong():
	var cost = _get_enthusiasm_mark_wrong_cost()
	if cost <= 0 || sex_minigame_points < cost:
		return
	var options = _get_enthusiasm_unrevealed_wrong_choices()
	if options.size() == 0:
		return
	_spend_sex_minigame_points(cost)
	enthusiasm_mark_wrong_used += 1
	var choice_idx = options[randi() % options.size()]
	enthusiasm_revealed_wrong_choices.append(choice_idx)
	_apply_enthusiasm_wrong_choice_color(enthusiasm_choice_buttons[choice_idx])
	_update_enthusiasm_meta_buttons()

func EnthusiasmAllCorrect():
	if enthusiasm_all_options_correct || !_spend_sex_minigame_points(ENTHUSIASM_ALL_CORRECT_COST):
		return
	enthusiasm_all_options_correct = true
	enthusiasm_revealed_wrong_choices.clear()
	for btn in enthusiasm_choice_buttons:
		_apply_enthusiasm_corrected_choice_color(btn)
	_update_enthusiasm_meta_buttons()

func EnthusiasmChoose(choice_idx):
	$EnthusiasmSelect.hide()
	var result
	if enthusiasm_pending_scene.has_method('enthusiasm_check_choice'):
		result = enthusiasm_pending_scene.enthusiasm_check_choice(enthusiasm_pending_member, choice_idx)
	else:
		result = _enthusiasm_default_check_choice(enthusiasm_pending_data, enthusiasm_pending_member, choice_idx)
	if enthusiasm_all_options_correct:
		result = _enthusiasm_get_loved_choice_result(choice_idx)
	var text = decoder(tr(result.text_key), [enthusiasm_pending_member], enthusiasm_pending_takers)
	if result.loves_it:
		text = globals.TextEncoder("{color=green|" + text + "}")
		var improvement_lines = []
		for training_entry in enthusiasm_pending_upgrades:
			var key = 'sex_training_' + training_entry.skill
			var current = enthusiasm_pending_member.person.statlist.sex_training.get(key, 'novice')
			var levels = ['novice', 'skilled', 'mastered']
			var current_idx = levels.find(current)
			var target_idx = levels.find(training_entry.target)
			if target_idx > current_idx:
				enthusiasm_pending_member.person.statlist.sex_training[key] = training_entry.target
				enthusiasm_pending_member.person.statlist.sex_mastery_progress[training_entry.skill] = []
				var skill_label = tr("CHARINFO_SEX_TRAINING_" + training_entry.skill.to_upper())
				if training_entry.target == 'skilled':
					enthusiasm_pending_member.skill_xp_bonus += 25
					_add_sex_minigame_points(1, tr("INTERACTION_CONNECTION_POINTS_REASON_SKILLED") % skill_label)
				elif training_entry.target == 'mastered':
					enthusiasm_pending_member.skill_xp_bonus += 50
				var line = decoder(tr("INTERACTION_ENTHUSIASM_SKILL_IMPROVED") % skill_label, [enthusiasm_pending_member], enthusiasm_pending_takers)
				improvement_lines.append(line)
		$Panel/sceneeffects.bbcode_text += '\n' + text
		var orgasm_member = _get_enthusiasm_orgasm_member()
		if enthusiasm_pending_action_ids != null:
			orgasm_member.set_lastaction(enthusiasm_pending_action_ids)
		_ensure_late_enthusiasm_impregnation(orgasm_member)
		var action_ref = null
		if enthusiasm_pending_action_ids != null:
			action_ref = make_ref_dict(enthusiasm_pending_action_ids)
		if action_ref == null:
			var member_is_giver = enthusiasm_pending_scene.givers.has(orgasm_member)
			action_ref = {
				scene = enthusiasm_pending_scene,
				givers = [orgasm_member] if member_is_giver else enthusiasm_pending_takers,
				takers = enthusiasm_pending_takers if member_is_giver else [orgasm_member],
				consents = enthusiasm_pending_consents
			}
		orgasm_member.orgasm(null, false)
		var orgasm_text = _get_enthusiasm_orgasm_followup(orgasm_member)
		if orgasm_text != "":
			$Panel/sceneeffects.bbcode_text += '\n[color=#ff5df8]' + orgasm_text + '[/color]'
		var charspeech = characterspeech(action_ref)
		if charspeech.text != '':
			$Panel/sceneeffects.bbcode_text += '\n' + charspeech.character.name + ': ' + decoder(charspeech.text, [charspeech.character], [charspeech.partner])
		_record_late_enthusiasm_orgasm(orgasm_member, action_ref)
		if $Panel/sceneeffects.bbcode_text.length() > 0 && !$Panel/sceneeffects.bbcode_text.ends_with("\n"):
			$Panel/sceneeffects.bbcode_text += "\n"
		for line in improvement_lines:
			$Panel/sceneeffects.bbcode_text += '\n' + line
	else:
		text = globals.TextEncoder("{color=red|" + text + "}")
		enthusiasm_pending_member.sens /= 2
		$Panel/sceneeffects.bbcode_text += '\n' + text
	enthusiasm_pending_member = null
	enthusiasm_pending_takers = []
	enthusiasm_pending_scene = null
	enthusiasm_pending_data = null
	enthusiasm_pending_upgrades = []
	enthusiasm_pending_action_ids = null
	enthusiasm_pending_consents = {}
	enthusiasm_all_options_correct = false
	enthusiasm_revealed_wrong_choices.clear()
	enthusiasm_choice_buttons.clear()
	rebuildparticipantslist()


func _enthusiasm_get_threshold(member):
	var factor = int(member.person.get_stat('sexuals_factor'))
	var threshold = 6 - factor / 2
	if member.person.check_trait('bedroom_prodidgy'):
		threshold -= 1
	return threshold

func _enthusiasm_get_counter_key(scenescript, member, consents = {}):
	var consent_gap = consents.get(member.id, 0)
	if consent_gap <= 2 || member.sex_traits.has("pushover"):
		return scenescript.code
	return _enthusiasm_get_skill_counter_key(scenescript, member)

func _enthusiasm_get_skill_counter_key(scenescript, member):
	var skills = []
	if scenescript.givers.has(member):
		skills = scenescript.get('giver_skill')
	elif scenescript.takers.has(member):
		skills = scenescript.get('taker_skill')
	if skills != null && skills.size() > 0:
		return "skill:" + PoolStringArray(skills).join('+')
	return "category:" + scenescript.category

func _enthusiasm_get_count(member, scenescript, consents = {}):
	return member.actionshad.actions.get(_enthusiasm_get_counter_key(scenescript, member, consents), 0)

func _apply_enthusiasm_choice_color(btn, personality):
	var color = _enthusiasm_get_personality_color(personality)
	btn.set("custom_colors/font_color", color)
	btn.set("custom_colors/font_color_hover", color.lightened(0.25))
	btn.set("custom_colors/font_color_pressed", color.darkened(0.15))

func _enthusiasm_get_personality_color(personality):
	match personality:
		'bold':
			return Color(1.0, 0.25, 0.25)
		'kind':
			return Color(0.35, 1.0, 0.35)
		'serious':
			return Color(0.75, 0.45, 1.0)
		'shy':
			return Color(0.35, 1.0, 1.0)
	return Color(0.96, 0.87, 0.49)

func _apply_enthusiasm_wrong_choice_color(btn):
	var color = Color(0.45, 0.45, 0.45)
	btn.set("custom_colors/font_color", color)
	btn.set("custom_colors/font_color_hover", color.lightened(0.2))
	btn.set("custom_colors/font_color_pressed", color.darkened(0.15))
	globals.connecttexttooltip(btn, tr("INTERACTION_ENTHUSIASM_INCORRECT_TOOLTIP"))

func _apply_enthusiasm_corrected_choice_color(btn):
	var color = Color(1.0, 0.9, 0.25)
	btn.set("custom_colors/font_color", color)
	btn.set("custom_colors/font_color_hover", color.lightened(0.15))
	btn.set("custom_colors/font_color_pressed", color.darkened(0.15))
	globals.connecttexttooltip(btn, tr("INTERACTION_ENTHUSIASM_CORRECT_TOOLTIP"))

func _get_enthusiasm_mark_wrong_cost():
	if enthusiasm_mark_wrong_used >= ENTHUSIASM_MARK_WRONG_COSTS.size():
		return -1
	return ENTHUSIASM_MARK_WRONG_COSTS[enthusiasm_mark_wrong_used]

func _spend_sex_minigame_points(value):
	if value <= 0:
		return false
	if sex_minigame_points < value:
		return false
	sex_minigame_points -= value
	_update_sex_minigame_points_label()
	return true

func _update_enthusiasm_meta_buttons():
	var cost = _get_enthusiasm_mark_wrong_cost()
	var btn = $EnthusiasmSelect/MarkWrongButton
	if cost <= 0 || enthusiasm_all_options_correct:
		btn.text = tr("INTERACTION_ENTHUSIASM_MARK_WRONG_USED")
		btn.disabled = true
	else:
		btn.text = tr("INTERACTION_ENTHUSIASM_MARK_WRONG_BTN") % cost
		btn.disabled = sex_minigame_points < cost || _get_enthusiasm_unrevealed_wrong_choices().size() == 0
	var all_correct_btn = $EnthusiasmSelect/AllCorrectButton
	if enthusiasm_all_options_correct:
		all_correct_btn.text = tr("INTERACTION_ENTHUSIASM_ALL_CORRECT_USED")
		all_correct_btn.disabled = true
	else:
		all_correct_btn.text = tr("INTERACTION_ENTHUSIASM_ALL_CORRECT_BTN") % ENTHUSIASM_ALL_CORRECT_COST
		all_correct_btn.disabled = sex_minigame_points < ENTHUSIASM_ALL_CORRECT_COST

func _get_enthusiasm_unrevealed_wrong_choices():
	var result = []
	if enthusiasm_pending_data == null || enthusiasm_pending_member == null:
		return result
	var choices = enthusiasm_pending_data.choices
	for i in choices.size():
		if enthusiasm_revealed_wrong_choices.has(i):
			continue
		if !_enthusiasm_choice_is_liked(choices[i], enthusiasm_pending_member):
			result.append(i)
	return result

func _enthusiasm_choice_is_liked(choice, member):
	if enthusiasm_all_options_correct:
		return true
	return member.person.statlist.get_personality() == choice.personality

func _enthusiasm_get_loved_choice_result(choice_idx):
	var choices = enthusiasm_pending_data.choices
	if choice_idx >= choices.size():
		return {loves_it = false, text_key = ""}
	var keys = choices[choice_idx].love_keys
	return {loves_it = true, text_key = keys[randi() % keys.size()]}

func _get_enthusiasm_orgasm_member():
	var target = enthusiasm_pending_data.get('orgasm_target', 'self')
	if target == 'partner' && enthusiasm_pending_takers.size() > 0:
		return enthusiasm_pending_takers[0]
	return enthusiasm_pending_member

func _get_enthusiasm_orgasm_followup(member):
	if enthusiasm_pending_scene == null:
		return ""
	var scene = enthusiasm_pending_scene
	var text = ""
	if scene.givers.has(member):
		if member.person.get_stat('penis_size') != '':
			text = _get_enthusiasm_orgasm_intro("INTERACTION_ORGASM_PENIS_GIVER_FEEL", "INTERACTION_ORGASM_PENIS_GIVER_THRUST")
			if ['anus','vagina','mouth'].has(scene.takerpart):
				text += tr("INTERACTION_ORGASM_PENIS_GIVER_INTO") % scene.takerpart.replace('anus', '[anus2]').replace('vagina','[pussy2]')
			elif scene.takerpart == 'nipples':
				text += tr("INTERACTION_ORGASM_PENIS_GIVER_NIPPLES")
			elif scene.takerpart == 'penis':
				text += tr("INTERACTION_ORGASM_PENIS_GIVER_ON_PENIS")
			else:
				text += tr("INTERACTION_ORGASM_PENIS_GIVER_FLOOR")
			return decoder(text, scene.givers, scene.takers)
		if member.person.get_stat('has_pussy') && scene.giverpart == 'vagina':
			text = _get_enthusiasm_orgasm_intro("INTERACTION_ORGASM_PUSSY_GIVER_FEEL", "INTERACTION_ORGASM_GIVER_NAME")
			if scene.takerpart == 'penis':
				text += tr("INTERACTION_ORGASM_PUSSY_GIVER_PENIS")
			else:
				text += tr("INTERACTION_ORGASM_PUSSY_GIVER_BODY")
			return decoder(text, scene.givers, scene.takers)
		text = _get_enthusiasm_orgasm_intro("INTERACTION_ORGASM_BODY_GIVER_FEEL", "INTERACTION_ORGASM_GIVER_NAME") + tr("INTERACTION_ORGASM_BODY_GIVER_RELEASE")
		return decoder(text, scene.givers, scene.takers)
	if member.person.get_stat('penis_size') != '' && !scene.takertags.has('vagina') && !scene.takertags.has('anal'):
		text = _get_enthusiasm_orgasm_intro("INTERACTION_ORGASM_PENIS_TAKER_FEEL", "INTERACTION_ORGASM_PENIS_TAKER_THRUST")
		match scene.code:
			'tailjob':
				text += tr("INTERACTION_ORGASM_PENIS_TAKER_TAIL")
			'handjob', 'titjob':
				text += tr("INTERACTION_ORGASM_PENIS_TAKER_FACE")
			_:
				if ['anus','vagina','mouth'].has(scene.giverpart):
					text += tr("INTERACTION_ORGASM_PENIS_TAKER_INTO") % scene.giverpart.replace('anus', '[anus1]').replace('vagina','[pussy1]')
				elif scene.giverpart == 'penis':
					text += tr("INTERACTION_ORGASM_PENIS_TAKER_ON_PENIS")
				else:
					text += tr("INTERACTION_ORGASM_PENIS_TAKER_FLOOR")
		return decoder(text, scene.givers, scene.takers)
	if scene.takertags.has('vagina') || scene.takerpart == 'vagina' || scene.takerpart == 'clit':
		text = _get_enthusiasm_orgasm_intro("INTERACTION_ORGASM_PUSSY_TAKER_FEEL", "INTERACTION_ORGASM_TAKER_NAME")
		if scene.giverpart == 'penis':
			text += tr("INTERACTION_ORGASM_PUSSY_TAKER_PENIS")
		else:
			text += tr("INTERACTION_ORGASM_PUSSY_TAKER_BODY")
		return decoder(text, scene.givers, scene.takers)
	if scene.takertags.has('anal') || scene.takerpart == 'anus':
		text = _get_enthusiasm_orgasm_intro("INTERACTION_ORGASM_ANUS_TAKER_FEEL", "INTERACTION_ORGASM_TAKER_NAME")
		if scene.giverpart == 'penis':
			text += tr("INTERACTION_ORGASM_ANUS_TAKER_PENIS")
		else:
			text += tr("INTERACTION_ORGASM_ANUS_TAKER_BODY")
		return decoder(text, scene.givers, scene.takers)
	text = _get_enthusiasm_orgasm_intro("INTERACTION_ORGASM_BODY_FEEL", "INTERACTION_ORGASM_TAKER_NAME") + tr("INTERACTION_ORGASM_BODY_RELEASE")
	return decoder(text, scene.givers, scene.takers)

func _get_enthusiasm_orgasm_intro(feel_key, name_key):
	if randf() < 0.4:
		return tr(feel_key)
	return tr(name_key)

func _ensure_late_enthusiasm_impregnation(member):
	if enthusiasm_pending_scene == null || member.person.get_stat('penis_size') == '':
		return
	if member.get_part_id_dict('penis') != null:
		return
	var scene = enthusiasm_pending_scene
	if scene.givers.has(member) && scene.giverpart == 'penis' && scene.takerpart == 'vagina':
		for taker in scene.takers:
			if impregnationcheck(member.person, taker.person):
				globals.impregnate(member.person, taker.person)
	elif scene.takers.has(member) && scene.takerpart == 'penis' && scene.giverpart == 'vagina':
		for giver in scene.givers:
			if impregnationcheck(member.person, giver.person):
				globals.impregnate(member.person, giver.person)

func _record_late_enthusiasm_orgasm(member, action_ref):
	if enthusiasm_pending_scene == null:
		return
	var scenescript = action_ref.scene
	var action_givers = action_ref.givers
	var action_takers = action_ref.takers
	var consents = action_ref.consents
	_award_first_orgasm_points(member)
	member.orgasm_actions.append(scenescript.code)
	if member.effects.has("aphrodisiac") && !scenescript.code in member.aphrodisiac_orgasms:
		member.aphrodisiac_orgasms.append(scenescript.code)
	for watcher in participants:
		if action_givers.has(watcher) || action_takers.has(watcher):
			continue
		watcher.orgasm_with_watcher += 1
		if !member in watcher.seen_orgasms:
			watcher.seen_orgasms.append(member)
	if action_takers.has(member):
		for giver in action_givers:
			if giver.person.check_trait("undead") || giver.person.check_trait("animal"):
				member.deviant_orgasms += 1
			if member.person.get_stat('body_shape') != giver.person.get_stat('body_shape'):
				member.diff_body_orgasm += 1
			for tag in scenescript.takertags:
				if !tag in member.orgasm_tags:
					member.orgasm_tags.append(tag)
			for effect in member.effects:
				if effect in ["tipsy", "drunk"]:
					member.drunk_orgasm += 1
				if !effect in member.orgasm_effects:
					member.orgasm_effects.append(effect)
			if !giver in member.orgasm_partners:
				member.orgasm_partners.append(giver)
			if !giver in member.diff_partners_orgasms:
				member.diff_partners_orgasms.append(giver)
			if !member in giver.satisfied_partners:
				giver.satisfied_partners.append(member)
			if consents.get(member.id, 0) > 0:
				member.unconsented_orgasm += 1
		for giver in action_givers:
			giver.gave_orgasm = true
			for skill in scenescript.giver_skill:
				if giver.person.statlist.sex_training.get('sex_training_' + skill, 'novice') == 'skilled':
					var progress = giver.person.statlist.sex_mastery_progress
					if progress.has(skill) && !scenescript.code in progress[skill]:
						progress[skill].append(scenescript.code)
	elif action_givers.has(member):
		for taker in action_takers:
			if scenescript.givertags.has("dom"):
				member.dominant += 1
			if taker.person.check_trait("undead") || taker.person.check_trait("animal"):
				member.deviant_orgasms += 1
			if member.person.get_stat('body_shape') != taker.person.get_stat('body_shape'):
				member.diff_body_orgasm += 1
			if consents.get(member.id, 0) > 0:
				member.unconsented_orgasm += 1
			for tag in scenescript.givertags:
				if !tag in member.orgasm_tags:
					member.orgasm_tags.append(tag)
			for effect in member.effects:
				if effect in ["tipsy", "drunk"]:
					member.drunk_orgasm += 1
				if !effect in member.orgasm_effects:
					member.orgasm_effects.append(effect)
		for taker in action_takers:
			taker.gave_orgasm = true
			for skill in scenescript.taker_skill:
				if taker.person.statlist.sex_training.get('sex_training_' + skill, 'novice') == 'skilled':
					var progress = taker.person.statlist.sex_mastery_progress
					if progress.has(skill) && !scenescript.code in progress[skill]:
						progress[skill].append(scenescript.code)

func _add_sex_minigame_points(value, reason):
	if value <= 0:
		return
	sex_minigame_points += value
	_update_sex_minigame_points_label()
	$Panel/sceneeffects.bbcode_text += tr("INTERACTION_SEX_MINIGAME_POINTS_GAINED") % [str(value), reason, str(sex_minigame_points)] + "\n"

func _update_sex_minigame_points_label():
	get_node("TextureFrame/Label").set_text("x" + str(sex_minigame_points))

func _award_first_orgasm_points(member):
	if member.orgasms <= 0 || sex_minigame_orgasm_points_awarded.has(member.id):
		return
	sex_minigame_orgasm_points_awarded.append(member.id)
	_add_sex_minigame_points(1, decoder(tr("INTERACTION_CONNECTION_POINTS_REASON_FIRST_ORGASM"), [member], [member]))

func _has_available_taker(excluded_member = null):
	for member in participants:
		if member != excluded_member && !givers.has(member) && member.actions_remaining > 0:
			return true
	return false

func _enthusiasm_default_check_choice(data, member, choice_idx):
	var choices = data.choices
	if choice_idx >= choices.size():
		return {loves_it = false, text_key = ""}
	var choice = choices[choice_idx]
	var personality = member.person.statlist.get_personality()
	var loves = (personality == choice.personality) || randf() < 0.25
	var keys = choice.love_keys if loves else choice.hate_keys
	return {loves_it = loves, text_key = keys[randi() % keys.size()]}

func _input(event):
	if !event is InputEventKey || is_visible_in_tree() == false:
		return
	var dict = {49 : 1, 50 : 2, 51 : 3, 52 : 4,53 : 5,54 : 6,55 : 7,56 : 8, 16777351 :1, 16777352 : 2, 16777353 : 3, 16777354 : 4, 16777355 : 5, 16777356: 6, 16777357: 7, 16777358: 8}
	if event.scancode in dict:
		var key = dict[event.scancode]
		if event.is_action_pressed(str(key)) == true && participants.size() >= key:
			if !givers.has(participants[key-1]) && !takers.has(participants[key-1]):
				$Panel/givetakepanel/givercontainer.get_child(key).emit_signal("pressed")
			else:
				$Panel/givetakepanel/receivercontainer.get_child(key).emit_signal("pressed")
	if event.is_action_pressed("F") && $Panel/passbutton.disabled == false && !$Control.is_visible():
		_on_passbutton_pressed()

# var dummycounter = 0

var test_dummy_ids = []

func createtestdummy(type = 'normal'):
	var person = ResourceScripts.scriptdict.class_slave.new("local_recruit")
	
	if participants.size() == 0:
		person.create('random', 'male', 'random')
	else:
		person.create('random', 'female', 'random')
	var newmember = member.new()
	newmember.sceneref = self
	#bad solution. need replacing
	person.set_stat('vaginal_virgin_lost', null)
	person.is_players_character = true
	person.set_stat('consent', globals.rng.randi_range(2,5))
	for i in Statlist_init.sex_skills:
		person.add_stat(i, 100)
#	if type == 'resist':
#		person.set_stat('consent', false)
		#globals.connectrelatives(participants[0].person, person, 'father')

	newmember.setup_person(person, true)
	newmember.consent = round(rand_range(0,3))
	#dummycounter += 1

#	if person.consent == false && person.professions.has("master"):
#		newmember.effects.append('forced')
#	if person.obedience < 80 && person.professions.has("master"):
#		newmember.effects.append('resist')

	ResourceScripts.game_party.characters[person.id] = person
	ResourceScripts.game_party.character_order.append(person.id)
	test_dummy_ids.append(person.id)
	participants.append(newmember)


func startsequence(actors):
	set_process_input(true)
	gui_controller.clock.visible = false
	hidebody()
	participants.clear()
	sex_minigame_points = 1
	sex_minigame_orgasm_points_awarded.clear()
	enthusiasm_all_options_correct = false
	enthusiasm_pending_action_ids = null
	enthusiasm_pending_consents = {}
	enthusiasm_revealed_wrong_choices.clear()
	enthusiasm_choice_buttons.clear()
	_update_sex_minigame_points_label()
	show()
	secondactorcounter.clear()
	$Panel/sceneeffects.clear()
	get_node("Control").hide()
	for person in actors:
		var newmember = member.new()
		newmember.sceneref = self
#		for i in actors:
#			if person != i:
#				if person.sexexp.watchers.has(i.id):
#					person.sexexp.watchers[i.id] += 1
#				else:
#					person.sexexp.watchers[i.id] = 1
		newmember.setup_person(person)
		participants.append(newmember)
		if person.check_trait("Sex-crazed"):
			newmember.effects.append("sexcrazed")
	$Panel/aiallow.pressed = aiobserve
	var temparray = []
	for i in actors:
		if i.has_profession("master") == true:
			temparray.append("{color=yellow|You}")
		else:
			temparray.append("{color=yellow|"+i.get_short_name()+"}")
	var text = tr("INTERACTION_START_ROOM") % input_handler.text_form_recitation(temparray)

	var counter = 0
	for i in participants:
		i.number = counter
		counter += 1
	changecategory('caress')
	clearstate()
	rebuildparticipantslist()
	for i in actors:
		if i.has_profession("master"):
			continue
		text += "\n{color=aqua|" + i.get_short_name() + "}: " + i.translate(input_handler.get_random_chat_line(i, 'sex_start'))
	#input_handler.get_person_for_chat(array, 'sex_start', args)

	get_node("Panel/sceneeffects").set_bbcode(globals.TextEncoder(text))


func clearstate():
	givers.clear()
	takers.clear()
	if givers.size() >= 1:
		givers.append(participants[0])

func changecategory(name):
	selectedcategory = name
	for i in get_node("Panel/HBoxContainer").get_children():
		if i.get_name() != name: i.set_pressed(false)
		else: i.set_pressed(true)
	rebuildparticipantslist()

func _update_character_resource_bars(node, member):
	var container = node.get_node("Panel/HBoxContainer")
	if container.has_node("mana"):
		var mana_node = container.get_node("mana")
		var mana_tooltip = tr("STATMP") + ": " + str(round(member.person.mp)) + "/" + str(round(member.person.get_stat('mpmax')))
		mana_node.visible = true
		mana_node.get_node("Label").text = str(round(member.person.mp))
		globals.connecttexttooltip(mana_node, mana_tooltip)
		globals.connecttexttooltip(mana_node.get_node("Label"), mana_tooltip)
	if container.has_node("lust"):
		var lust_node = container.get_node("lust")
		if member.person.check_trait("succubus"):
			var lust_tooltip = tr("STATLUST") + ": " + str(round(member.person.get_stat('lust'))) + "/" + str(round(member.person.get_stat('lustmax')))
			lust_node.visible = true
			lust_node.get_node("Label").text = str(round(member.person.get_stat('lust')))
			globals.connecttexttooltip(lust_node, lust_tooltip)
			globals.connecttexttooltip(lust_node.get_node("Label"), lust_tooltip)
		else:
			lust_node.visible = false

func _get_final_lack_consent(member):
	if member.lack_consent <= 0 || member.person.get_stat('unique') == 'rouge':
		return 0.0
	var final_lack = float(member.lack_consent)
	if member.horny >= 75:
		final_lack *= 0.66
	final_lack -= (member.orgasms * 3) + member.requestsdone
	return max(final_lack, 0.0)

func _apply_lack_consent_name_color(label, member):
	var final_lack = _get_final_lack_consent(member)
	if final_lack <= 5:
		return
	var ratio = clamp((final_lack - 6.0) / 14.0, 0.0, 1.0)
	var color = Color(1.0, 0.95, 0.45).linear_interpolate(Color(1.0, 0.05, 0.05), ratio)
	label.set('custom_colors/font_color', color)

func rebuildparticipantslist():
	var newnode
	var effects
	for _m in participants:
		if _m.actions_remaining <= 0:
			givers.erase(_m)
	if selectmode == 'ai':
		clearstate()
	for i in get_node("Panel/CharList/ScrollContainer/VBoxContainer").get_children() + get_node("Panel/GridContainer/GridContainer").get_children() + get_node("Panel/givetakepanel/givercontainer").get_children() + get_node("Panel/givetakepanel/receivercontainer").get_children() + $Panel/GridContainer2/GridContainer.get_children():
		if !i.get_name() in ['VBoxContainerMain', 'Button']:
			i.visible = false
			i.queue_free()
	for i in participants:
		newnode = get_node("Panel/CharList/ScrollContainer/VBoxContainer/VBoxContainerMain").duplicate()
		newnode.visible = true
		get_node("Panel/CharList/ScrollContainer/VBoxContainer").add_child(newnode)
		newnode.get_node("Panel/name").set_text("[" + str(i.actions_remaining) + "] " + i.person.get_short_name())
		newnode.get_node("Panel").set_meta("person", i)
		newnode.get_node("Panel/portrait").texture = i.person.get_icon_small()
		newnode.get_node("Panel/sex").set_texture(images.get_icon(i.sex))
		var sex_tooltip = "PRONOUNSEX"
		if i.sex == "female":
			sex_tooltip = "PRONOUNSEXF"
		elif i.sex == "futa":
			sex_tooltip = "PRONOUNSEXH"
		newnode.get_node("Panel/sex").set_tooltip(tr(sex_tooltip))
		newnode.get_node("Panel/HBoxContainer/arousal").value = i.horny
		globals.connecttexttooltip(newnode.get_node("Panel/HBoxContainer/arousal"), i.person.translate(tr("TOOLTIPHORNY")))
		_update_character_resource_bars(newnode, i)
		newnode.get_node("arousal").value = i.sens
		globals.connecttexttooltip(newnode.get_node("arousal"), i.person.translate(tr("TOOLTIPAROUSAL")))
		newnode.get_node("Panel").connect("mouse_entered", self, 'showbody', [i])
		newnode.get_node("Panel/items").connect("pressed", self, "open_item_list", [i])

		if i.request != null:
			newnode.get_node("Panel/HBoxContainer/desire").show()
			globals.connecttexttooltip(newnode.get_node("Panel/HBoxContainer/desire"), i.person.translate(tr(requests[i.request])))

		for k in i.effects:
			if newnode.get_node("Panel/HBoxContainer").has_node(k):
				newnode.get_node("Panel/HBoxContainer/" + k).visible = true

		if ai.has(i):
			newnode.get_node("Panel/name").set('custom_colors/font_color', Color(1,0.2,0.8))
			newnode.get_node("Panel/name").hint_tooltip = tr("INTERACTION_LEADS")
		_apply_lack_consent_name_color(newnode.get_node("Panel/name"), i)

		var bonus_container = newnode.get_node("BonusActions")
		var others = participants.duplicate()
		others.erase(i)
		if i.sens >= 800:
			var deny_action = globals.sex_actions_dict['deny_orgasm']
			var deny_btn = bonus_container.get_node("deny")
			deny_btn.visible = true
			globals.connecttexttooltip(deny_btn, deny_action.getname())
			deny_btn.connect("pressed", self, "show_bonus_partner_popup", [deny_action, others, i, false])
		if i.sens >= 800 && i.person.get_stat('penis_size') != '':
			var cum_action = globals.sex_actions_dict['cum_select']
			var cum_btn = bonus_container.get_node("cum")
			cum_btn.visible = true
			globals.connecttexttooltip(cum_btn, cum_action.getname())
			cum_btn.connect("pressed", self, "show_bonus_partner_popup", [cum_action, others, i, true])
		if i == enthusiasm_pending_member && enthusiasm_pending_data != null:
			var train_btn = bonus_container.get_node("train")
			train_btn.visible = true
			globals.connecttexttooltip(train_btn, tr(enthusiasm_pending_data.btn_text))
			train_btn.connect("pressed", self, "EnthusiasmInitiate")
		newnode = get_node("Panel/givetakepanel/givercontainer/Button").duplicate()
		get_node("Panel/givetakepanel/givercontainer").add_child(newnode)
		if givers.find(i) >= 0:
			newnode.set_pressed(true)
		newnode.visible = true
		newnode.get_node('icon').texture = i.person.get_icon_small()
		newnode.get_node("Label").text = i.person.get_short_name()
		newnode.set_meta("person", i)
		newnode.connect("pressed",self,'switchsides',[newnode, 'give'])
		newnode = get_node("Panel/givetakepanel/receivercontainer/Button").duplicate()
		get_node("Panel/givetakepanel/receivercontainer").add_child(newnode)
		if takers.find(i) >= 0:
			newnode.set_pressed(true)
		newnode.visible = true
		newnode.get_node("Label").text = i.person.translate('[name]')
		newnode.set_meta("person", i)
		newnode.get_node('icon').texture = i.person.get_icon_small()
		newnode.connect("pressed",self,'switchsides',[newnode, 'take'])

	var text = ''

	#check for double dildo scenes between participants
	var doubledildo = doubledildocheck()
	var actionarray = []

	for i in categories:
		for k in categories[i]:
			actionarray.append(k)

	actionarray.sort_custom(self, 'sortactions')

	var showactions = true
	var actionreplacetext = ''

	for i in givers:
		if i.effects.has('tied') :
			showactions = false
			actionreplacetext = i.person.translate(tr("INTERACTION_ACT_BLOCK_TIED"))
		elif i.subduedby.size() > 0:
			showactions = false
			actionreplacetext = i.person.translate(tr("INTERACTION_ACT_BLOCK_STRUGGLING"))
		elif i.effects.has('resist'):
			showactions = false
			actionreplacetext = i.person.translate(tr("INTERACTION_ACT_BLOCK_RESIST"))
		elif i.subduing != null && ((takers.size() > 0 && takers[0] != i.subduing) || takers.size() > 1 ) :
			showactions = false
			actionreplacetext = i.person.translate(tr("INTERACTION_ACT_BLOCK_HOLDING_1")) + i.subduing.person.translate(tr("INTERACTION_ACT_BLOCK_HOLDING_2"))

	var array = []
	var bottomrow =  ['rope', 'subdue']

	if showactions == true:
		for i in actionarray:
			i.givers = givers
			i.takers = takers

			var result = checkaction(i, doubledildo)
			if result[0] == 'false' || i.code in ['wait'] || (selectedcategory != i.category && !i.code in bottomrow ):
				continue

			#find lowest consent possible for each participant
			var giver_consent
			var giver_name
			var giver_text
			var taker_consent
			var taker_name
			var taker_text
			for j in givers:
				for k in takers:
					var consent = count_action_consent(i, j, k)
					if giver_consent == null:
						giver_consent = consent.giver_consent
						giver_name = j.name
						giver_text = consent.giver_text
					if giver_consent > consent.giver_consent:
						giver_name = j.name
						giver_consent = consent.giver_consent
						giver_text = consent.giver_text

					if taker_consent == null:
						taker_consent = consent.taker_consent
						taker_name = k.name
						taker_text = consent.taker_text
					if taker_consent > consent.taker_consent:
						taker_consent = consent.taker_consent
						taker_name = k.name
						taker_text = consent.taker_text

			# if i.code in bottomrow :
			# 	newnode = get_node("Panel/GridContainer2/GridContainer/Button").duplicate()
			# 	get_node("Panel/GridContainer2/GridContainer").add_child(newnode)
			# else:
			newnode = get_node("Panel/GridContainer/GridContainer/Button").duplicate()
			get_node("Panel/GridContainer/GridContainer").add_child(newnode)
			newnode.visible = true
			newnode.get_node("ActionName").set_text(i.getname())
			var missing_consent = max(i.consent_giver - giver_consent, i.consent_taker - taker_consent)
			if missing_consent > 0:
				if missing_consent == 1:
					newnode.modulate = Color(1,1,0.45)
				else:
					newnode.modulate = Color(1,0.7,0.7)

			var tooltiptext
			if input_handler.globalsettings.show_full_consent || true:
				
				tooltiptext = i.getname() + "\n"+giver_name + ": "
				
				if i.consent_giver <= giver_consent:
					tooltiptext += tr("INTERACTION_CONSENT_WILLING")
				else:
					tooltiptext += tr("INTERACTION_CONSENT_REFUSING")
				
				tooltiptext +=  "\n" + giver_text + "\n" + taker_name + ": "
				
				if i.consent_taker <= taker_consent:
					tooltiptext += tr("INTERACTION_CONSENT_WILLING")
				else:
					tooltiptext += tr("INTERACTION_CONSENT_REFUSING")
				
				tooltiptext +=  "\n" + taker_text
				
				#tooltiptext = giver_name + "\n" + giver_text + taker_name + "\n" + taker_text
				
#				tooltiptext = ("[color=aqua]Giver - " + str(i.consent_giver) + 
#				", Receiver - " + str(i.consent_taker) + 
#				"[/color]\nActor Consent: [color=aqua]"+ str(giver_consent) +"[/color] (" + giver_name + ") "  +"\n" + giver_text + 
#				"\nReceiver Consent: [color=aqua]" + str(taker_consent) + "[/color] ("+ taker_name + ') '  + "\n" + taker_text)
			else:
				tooltiptext = i.getname()
				if giver_consent < i.consent_giver:
					tooltiptext += "\n{color=red|" + giver_name + " does not wish to engage into this action}"
				if taker_consent < i.consent_taker:
					tooltiptext += "\n{color=red|" + taker_name + " does not wish to engage into this action}"
			globals.connecttexttooltip(newnode, tooltiptext)
			if result[0] == 'disabled':
				newnode.disabled = true
				newnode.hint_tooltip += ' - ' + result[1]

			newnode.connect("pressed",self,'startscene',[i])
			if i.canlast == true && newnode.disabled == false:
				newnode.get_node("continue").visible = true
				newnode.get_node("continue").connect("pressed",self,'startscenecontinue',[i])
			for j in ongoingactions:
				if j.scene.code == i.code && j.givers == i.givers && j.takers == i.takers:
					newnode.get_node("continue").pressed = true
		if selectedcategory == 'caress' && givers.size() >= 1 && !givers[0].person.has_profession("master") && selectmode != 'ai':
			# newnode = get_node("Panel/GridContainer2/GridContainer/Button").duplicate()
			newnode = get_node("Panel/GridContainer/GridContainer/Button").duplicate()
			# get_node("Panel/GridContainer2/GridContainer").add_child(newnode)
			get_node("Panel/GridContainer/GridContainer").add_child(newnode)
			newnode.visible = true
			if givers.size() < 2:
				newnode.get_node("ActionName").text = (givers[0].person.translate(tr("INTERACTION_LET_NAME_LEAD")))
			else:
				newnode.get_node("ActionName").set_text(tr("INTERACTION_LET_SELECTED_LEAD"))
			newnode.connect("pressed",self,'activateai')
		elif selectmode == 'ai':
			newnode = get_node("Panel/GridContainer/GridContainer/Button").duplicate()
			get_node("Panel/GridContainer/GridContainer").add_child(newnode)
			newnode.visible = true
			newnode.set_text(tr("INTERACTION_STOP"))
			newnode.connect("pressed",self,'activateai')
	else:
			newnode = Label.new()
			get_node("Panel/GridContainer/GridContainer").add_child(newnode)
			newnode.visible = true
			#newnode.disabled = true
			newnode.set_text(actionreplacetext)
	$Panel/GridContainer/GridContainer.move_child($Panel/GridContainer/GridContainer/Button, $Panel/GridContainer/GridContainer.get_child_count()-1)
	$Panel/GridContainer2/GridContainer.move_child($Panel/GridContainer2/GridContainer/Button, $Panel/GridContainer2/GridContainer.get_child_count()-1)
	for i in givers:
		text += '[color=yellow]' + i.name + '[/color], '
	if givers.size() == 0:
		text += '[...] '
	text += tr("INTERACTION_SELECTION_TO")
	for i in takers:
		text += '[color=aqua]' + i.name + '[/color], '
	if takers.size() == 0:
		text += "[...]"
	else:
		text = text.substr(0, text.length() -2)+ '. '
	text += "\n\n"
	for i in ongoingactions:
		text += decoder(i.scene.getongoingname(i.givers,i.takers), i.givers, i.takers) + ' [url='+str(ongoingactions.find(i))+']' + tr("INTERACTION_INTERRUPT") + '[/url]\n'

	if givers.size() == 0 && selectmode != 'ai':
		get_node("Panel/passbutton").set_disabled(true)
	else:
		get_node("Panel/passbutton").set_disabled(false)

	if selectmode == 'ai':
		$Panel/passbutton.set_text(tr("INTERACTION_OBSERVE"))
	else:
		$Panel/passbutton.set_text(tr("INTERACTION_PASS"))

	_update_sex_minigame_points_label()

	get_node("Panel/sceneeffects1").set_bbcode(text)

	#globals.state.actionblacklist = filter

	var _all_exhausted = true
	for _m in participants:
		if _m.actions_remaining > 0:
			_all_exhausted = false
			break
	if _all_exhausted && participants.size() > 0:
		endencounter()

var itemusemember

func count_action_consent(action, giver, taker):
	var giver_value = action.consent_giver
	var taker_value = action.consent_taker
	var giver_consent = giver.consent
	var taker_consent = taker.consent
	var giver_text = ''
	var taker_text = ''

	for i in giver.sex_traits:
		var trait = Traitdata.sex_traits[i]
		if !giver.checkreqs(trait.reqs, 'giver', {scene = action, givers = action.givers, takers = action.takers}):
			continue
		for k in trait.effects:
			match k.trigger:
				'consent_check':
					if k.effect == 'consent':
						if k.operant == '*':
							giver_consent -= giver_value * k.value
							giver_text += "{color=red|" + trait.name + "}"+"\n"
							
							#giver_text += trait.name + ": -"+ str(value)+"\n"
						elif k.operant == "+":
							giver_consent += k.value
							giver_text += "{color=green|" + trait.name + "}"+"\n"
							#giver_text += trait.name + ": +"+ str(k.value)+"\n"
				'consent_check_partner':
					if k.effect == 'consent':
						if k.operant == '*':
							taker_consent -= taker_value * k.value
							giver_text += "{color=red|" + trait.name + "}"+"\n"
						#	taker_text += trait.name + ": -"+ str(value)+"\n"
						elif k.operant == '+':
							taker_consent += k.value
							giver_text += "{color=green|" + trait.name + "}"+"\n"
							#taker_text += trait.name + ": +"+ str(k.value)+"\n"

	for i in taker.sex_traits:
		var trait = Traitdata.sex_traits[i]
		if !taker.checkreqs(trait.reqs, 'taker', {scene = action, givers = action.givers, takers = action.takers}):
			continue
		for k in trait.effects:
			match k.trigger:
				'consent_check':
					if k.effect == 'consent':
						if k.operant == '*':
							taker_consent -= taker_value * k.value
							taker_text += "{color=red|" + trait.name + "}"+"\n"
							#taker_text += trait.name + ": -"+ str(value)+"\n"
						elif k.operant == "+":
							taker_consent += k.value
							taker_text += "{color=green|" + trait.name + "}"+"\n"
							#taker_text += trait.name + ": +"+ str(k.value)+"\n"
				'consent_check_partner':
					if k.effect == 'consent':
						if k.operant == '*':
							giver_consent -= giver_value * k.value
							giver_text += "{color=red|" + trait.name + "}"+"\n"
							#giver_text += trait.name + ": -"+ str(value)+"\n"
						elif k.operant == '+':
							giver_consent += k.value
							giver_text += "{color=green|" + trait.name + "}"+"\n"
							#giver_text += trait.name + ": +"+ str(k.value)+"\n"

	if participants.size() > 2 && action.givers.size() + action.takers.size() < participants.size() && !action.code in ['subdue','rope','orgasm_denial']:
		if giver.sex_traits.has("shameless"):
			pass
		elif giver.sex_traits.has("exhibitionist"):
			giver_consent += 1
			giver_text += tr("INTERACTION_CONSENT_OBSERVED_EXHIBITIONIST")
		else:
			giver_consent -= 1
			giver_text += tr("INTERACTION_CONSENT_OBSERVED")

		if taker.sex_traits.has("shameless"):
			pass
		elif taker.sex_traits.has("exhibitionist"):
			taker_consent += 1
			taker_text += tr("INTERACTION_CONSENT_OBSERVED_EXHIBITIONIST")
		else:
			taker_consent -= 1
			taker_text += tr("INTERACTION_CONSENT_OBSERVED")
			#taker_text += "Is being observed: -\n"

	if (action.givers.size() > 1 || action.takers.size() > 1) && !action.code in ['subdue','rope','orgasm_denial']:
		if giver.sex_traits.has("group"):
			giver_consent += 1
			giver_text += tr("INTERACTION_CONSENT_MULTIPLE_LIKES")
		else:
			giver_consent -= 1
			giver_text += tr("INTERACTION_CONSENT_MULTIPLE")

		if taker.sex_traits.has("group"):
			taker_consent += 1
			taker_text += tr("INTERACTION_CONSENT_MULTIPLE_LIKES")
		else:
			taker_consent -= 1
			taker_text += tr("INTERACTION_CONSENT_MULTIPLE")

	if giver.sex == taker.sex && !action.code in ['subdue','rope','orgasm_denial'] :
		if giver.sex_traits.has("bisexual") == false:
			giver_consent -= 1
			giver_text += tr("INTERACTION_CONSENT_SAME_SEX")
		if taker.sex_traits.has("bisexual") == false:
			taker_consent -= 1
			taker_text += tr("INTERACTION_CONSENT_SAME_SEX")

	if action.givertags.has("anal"):
		if giver.sex_traits.has("anal"):
			pass
		elif giver.sex_traits.has('anal_like'):
			giver_consent += 1
			giver_text += tr("INTERACTION_CONSENT_ANAL_LIKES")
		else:
			giver_consent -= 1
			giver_text += tr("INTERACTION_CONSENT_ANAL")

	if action.takertags.has("anal"):
		if taker.sex_traits.has("anal"):
			pass
		elif taker.sex_traits.has('anal_like'):
			taker_consent += 1
			taker_text += tr("INTERACTION_CONSENT_ANAL_LIKES")
		else:
			taker_consent -= 1
			taker_text += tr("INTERACTION_CONSENT_ANAL")

	if giver.person.check_trait('undead') || giver.person.get_stat('unique') in ['dog','horse'] :
		if !taker.sex_traits.has('deviant'):
			taker_consent -= 2
			taker_text += tr("INTERACTION_CONSENT_REPULSIVE_PARTNER")
	if taker.person.check_trait('undead') || taker.person.get_stat('unique') in ['dog','horse'] :
		if !giver.sex_traits.has('deviant'):
			giver_consent -= 2
			giver_text += tr("INTERACTION_CONSENT_REPULSIVE_PARTNER")

	if giver.effects.has('tipsy'):
		giver_consent += 1
		giver_text += tr("INTERACTION_CONSENT_TIPSY")
	if giver.effects.has('drunk') :
		giver_consent += 2
		giver_text += tr("INTERACTION_CONSENT_DRUNK")
	if taker.effects.has('tipsy'):
		taker_consent += 1
		taker_text += tr("INTERACTION_CONSENT_TIPSY")
	if taker.effects.has('drunk'):
		taker_consent += 2
		taker_text += tr("INTERACTION_CONSENT_DRUNK")

#	if giver.horny >= 100:
#		giver_consent += 1
#		giver_text += "{color=green|Horny}\n"
#	if taker.horny >= 100:
#		taker_consent += 1
#		taker_text += "{color=green|Horny}\n"
	
	if givers.size() > 0 && takers.size() > 0 && !giver.person.is_master() && !taker.person.is_master():
		var reldata = ResourceScripts.game_party._get_data(giver.id, taker.id)
		if reldata != null:
			var relationship = reldata.status
			match relationship:
				'rivals':
					giver_consent -= 1
					taker_consent -= 1
					giver_text += tr("INTERACTION_CONSENT_REL_RIVAL")
					taker_text += tr("INTERACTION_CONSENT_REL_RIVAL")
				'freelovers':
					giver_consent += 1
					taker_consent += 1
					giver_text += tr("INTERACTION_CONSENT_REL_PARAMOUR")
					taker_text += tr("INTERACTION_CONSENT_REL_PARAMOUR")
				'lovers':
					giver_consent += 2
					taker_consent += 2
					giver_text += tr("INTERACTION_CONSENT_REL_LOVER")
					taker_text += tr("INTERACTION_CONSENT_REL_LOVER")
		
		var relatives = ResourceScripts.game_party.checkifrelatives(giver.id, taker.id)
		if relatives == true:
			if giver.sex_traits.has("family_first"):
				giver_consent += 1
				giver_text += tr("INTERACTION_CONSENT_RELATED_GOOD")
			else:
				giver_consent -= 1
				giver_text += tr("INTERACTION_CONSENT_RELATED_BAD")
			if taker.sex_traits.has("family_first"):
				taker_consent += 1
				taker_text += tr("INTERACTION_CONSENT_RELATED_GOOD")
			else:
				taker_consent -= 1
				taker_text += tr("INTERACTION_CONSENT_RELATED_BAD")
#	if taker.person_relations.has(giver.id):
#		var rel_value = taker.person_relations[giver.id]
#		if rel_value >= 350:
#			taker_consent += 1
#			taker_text += "{color=green|Likes partner}\n"
#		elif rel_value >= 800:
#			taker_consent += 2
#			taker_text += "{color=green|Loves partner}\n"
#		elif rel_value <= -800:
#			taker_consent -= 2
#			taker_text += "{color=red|Dislikes partner}\n"
#		elif rel_value <= -350:
#			taker_consent -= 1
#			taker_text += "{color=red|Hates partner}\n"

	if giver.person.get_stat('body_shape') != taker.person.get_stat('body_shape') && !action.code in ['subdue','rope','orgasm_denial']:
		if !giver.sex_traits.has("open_minded"):
			giver_consent -= 1
			giver_text += tr("INTERACTION_CONSENT_DIFFERENT_SPECIES")
		if !taker.sex_traits.has("open_minded"):
			taker_consent -= 1
			taker_text += tr("INTERACTION_CONSENT_DIFFERENT_SPECIES")

	if action.givertags.has('vagina') && action.givertags.has('penetration') && giver.person.get_stat('vaginal_virgin'):
		giver_consent -= 1
		giver_text += tr("INTERACTION_CONSENT_VIRGIN")
	if action.takertags.has('vagina') && action.takertags.has('penetration') && taker.person.get_stat('vaginal_virgin'):
		taker_consent -= 1
		taker_text += tr("INTERACTION_CONSENT_VIRGIN")


	if giver.person.has_profession('master'):
		giver_consent = 100
		giver_text = tr("INTERACTION_CONSENT_MAXIMUM")
#		taker_consent += 1
#		taker_text += "Partner is " + taker.person.translate("[master]") + ": +\n"
	if taker.person.has_profession('master'):
		taker_consent = 100
		taker_text = tr("INTERACTION_CONSENT_MAXIMUM")
#		giver_consent += 1
#		giver_text += "Partner is " + giver.person.translate("[master]") + ": +\n"
#	if giver.person.get_stat('slave_class') == 'slave':
#		giver_consent += 1
#		giver_text += "Is a Slave: +1\n"
#	if taker.person.get_stat('slave_class') == 'slave':
#		taker_consent += 1
#		taker_text += "Is a Slave: +1\n"
	if action.code == 'subdue':
		taker_consent = 25
		taker_text = tr("INTERACTION_CONSENT_SUBDUE")

	if giver_value == 0:
		giver_consent = 0
		giver_text = tr("INTERACTION_CONSENT_NOT_REQUIRED")
	if taker_value == 0:
		taker_consent = 0
		taker_text = tr("INTERACTION_CONSENT_NOT_REQUIRED")
	
	return {giver_consent = giver_consent, taker_consent = taker_consent, giver_text = giver_text, taker_text = taker_text}
#	var dict = {value = action.consent, giver_consent = giver.consent, taker_consent = taker.consent}
#	return dict

func open_item_list(member):
	itemusemember = member
	if !gui_controller.windows_opened.has($ItemSelectSex):
		gui_controller.windows_opened.append($ItemSelectSex)
	$ItemSelectSex.visible = !$ItemSelectSex.is_visible()
	var array = []
	for i in ResourceScripts.game_res.items.values():
		if i.interaction_use == true:
			array.append(i)
	input_handler.ClearContainer($ItemSelectSex/ScrollContainer/GridContainer)
	for item in array:
		var newbutton = input_handler.DuplicateContainerTemplate($ItemSelectSex/ScrollContainer/GridContainer)
		newbutton.get_node("icon").texture = load(item.icon)
		newbutton.get_node("name").text = tr(item.name)
		newbutton.get_node("Percent").text = str(ResourceScripts.game_res.items[item.id].amount)
		globals.connectitemtooltip_v2(newbutton, item)
		newbutton.connect("pressed", self, "use_item", [item])
	# globals.ItemSelect(self, 'sex_use', 'use_item')

func use_item(item):
	var effect = Items.itemlist[item.itembase].interaction_effect
	item.amount -= 1
	call(effect, itemusemember)
	open_item_list(itemusemember)
	rebuildparticipantslist()


var categoriesorder = ['caress', 'fucking', 'tools', 'SM', 'humiliation']

func sortactions(first, second):

	if categoriesorder.find(first.category) == categoriesorder.find(second.category):
		if first.get('order') != null:
			if second.get('order') != null:
#				if first.order >= second.order:
				if first.order > second.order:
					return false
				else:
					return true
			else:
				return true

		return false
	else:
		return categoriesorder.find(first.category) < categoriesorder.find(second.category)

var requests = {
pet = "INTERACTION_REQUEST_PET",
petgive = "INTERACTION_REQUEST_PETGIVE",
fuck = "INTERACTION_REQUEST_FUCK",
fuckgive = "INTERACTION_REQUEST_FUCKGIVE",
pussy = "INTERACTION_REQUEST_PUSSY",
penis = "INTERACTION_REQUEST_PENIS",
anal = "INTERACTION_REQUEST_ANAL",
punish = "INTERACTION_REQUEST_PUNISH",
humiliate = "INTERACTION_REQUEST_HUMILIATE",
group = "INTERACTION_REQUEST_GROUP"

}



func generaterequest(member):
	var rval = []

	for i in requests:
		rval.append(i)

	if member.person.get_stat('vaginal_virgin') == true:
		rval.erase('fuck')
	if member.person.get_stat('penis_size') == '':
		rval.erase('penis')
	if member.person.get_stat('penis_size') == '' && member.strapon == false:
		rval.erase('fuckgive')
	if member.person.get_stat('vagina') == '':
		rval.erase('pussy')
	if member.person.check_trait('Dominant'):
		rval.erase('humiliate')
	if !member.person.check_trait('Likes it rough') && !member.person.check_trait('Masochist'):
		rval.erase('punish')
	if member.person.check_trait('Monogamous') || participants.size() == 2 || (!member.person.check_trait('Fickle') && member.lewd < 50):
		rval.erase('group')



	rval = rval[randi()%rval.size()]

	$Panel/sceneeffects.bbcode_text += (tr("INTERACTION_DESIRE_LABEL") % member.person.translate(tr(requests[rval])))

	member.request = rval

func checkrequest(member):

	if member.request == null:
		return false

	var conditionsatisfied = false

	var lastaction = member.get_lastaction_ref_dict()

	match member.request:
		'pet':
			if lastaction.takers.has(member) && lastaction.scene.get('takertags') != null && lastaction.scene.takertags.has('pet'):
				conditionsatisfied = true
		'petgive':
			if lastaction.givers.has(member) && lastaction.scene.get('givertags') != null && lastaction.scene.givertags.has('pet'):
				conditionsatisfied = true
		'fuck':
			if lastaction.takers.has(member) && lastaction.scene.get('takertags') != null && lastaction.scene.takertags.has('penetration'):
				conditionsatisfied = true
		'fuckgive':
			if lastaction.givers.has(member) && lastaction.scene.get('takertags') != null && lastaction.scene.takertags.has('penetration'):
				conditionsatisfied = true
		'pussy':
			if lastaction.scene.get('givertags') != null && (lastaction.scene.givertags.has('vagina') || lastaction.scene.takertags.has('vagina')) :
				conditionsatisfied = true
		'penis':
			if lastaction.scene.get('givertags') != null && (lastaction.scene.givertags.has('penis') || lastaction.scene.takertags.has('penis')) :
				conditionsatisfied = true
		'anal':
			if lastaction.scene.get('givertags') != null && (lastaction.scene.givertags.has('anal') || lastaction.scene.takertags.has('anal')) :
				conditionsatisfied = true
		'punish':
			if lastaction.takers.has(member) && lastaction.scene.get('takertags') != null && lastaction.scene.takertags.has('punish'):
				conditionsatisfied = true
		'humiliate':
			if lastaction.takers.has(member) && lastaction.scene.get('takertags') != null && lastaction.scene.takertags.has('shame'):
				conditionsatisfied = true
		'group':
			if (lastaction.givers.has(member) && lastaction.takers.size() > 1) || (lastaction.takers.has(member) && lastaction.givers.size() > 1):
				conditionsatisfied = true

	if conditionsatisfied == true:
		member.request = null
		member.requestsdone += 1
		_add_sex_minigame_points(2, decoder(tr("INTERACTION_CONNECTION_POINTS_REASON_DESIRE"), [member], [member]))
		member.actions_remaining += 2
		#$Panel/sceneeffects.bbcode_text += '[color=green]Wish satisfied.[/color]\n'
		member.sens += 125
	return conditionsatisfied

var ai = []

func activateai():
	for i in givers:
#		if i.submission < 10 || i.consent == false:
#			$Control/Panel/RichTextLabel.bbcode_text = i.person.translate('[name] refuses to participate. ')
#			return
		if i.effects.has('tied') || i.subduedby.size() > 0:
			$Control/Panel/RichTextLabel.bbcode_text = i.person.translate(tr("INTERACTION_ACT_BLOCK_IMMOBILE"))
	ai.clear()
	if selectmode != 'ai':
		selectmode = 'ai'
		for i in givers:
			if !i.person.has_profession('master'):
				ai.append(i)
	else:
		selectmode = 'normal'
	rebuildparticipantslist()


func doubledildocheck():
	var doubledildo = false
	var givercheck = false
	var takercheck = false

	for scene in ongoingactions:
		if scene.scene.code in ['doubledildo','doubledildoass','tribadism','frottage']:
			for i in givers:
				if scene.givers.has(i) || scene.takers.has(i):
					givercheck = true
			for i in takers:
				if scene.givers.has(i) || scene.takers.has(i):
					takercheck = true
		if givercheck && takercheck:
			doubledildo = true
			break
		else:
			givercheck = false
			takercheck = false
	return doubledildo

func checkaction(action, doubledildo):
	action.givers = givers
	action.takers = takers
	var disabled = false
	var hint_tooltip = ''
	if action.requirements() == false || filter.has(action.code):
		return ['false']
	elif doubledildo == true && action.category in ['caress','fucking'] && !action.code in ['doubledildo','doubledildoass','tribadism','frottage']:
		return ['false']
	if action.category in ['SM','tools','humiliation']:
		var valid = true
		for k in givers+takers:
			if k.limbs == false:
				valid = false
				break
		if valid == false:
			return ['false']
	if disabled == true:
		return ['disabled',hint_tooltip]
	else:
		return ['allowed']


func slavedescription(member):
	return
	if !member.person.get_stat('unique') in ['dog','horse']:
		get_parent().popup(ResourceScripts.descriptions.trim_tag(member.person.make_description(), 'url', 'hair'))

var nakedspritesdict = [] #globals.gallery.nakedsprites

func get_unique_nude_body_image(person):
	if person == null || !person.has_status('sexservice'):
		return null
	var unique = person.get_stat('unique')
	if unique == null:
		return null
	if unique == 'AnastasiaBroken':
		unique = 'anastasia'
	if !worlddata.pregen_character_sprites.has(unique):
		return null
	var sprite_data = worlddata.pregen_character_sprites[unique]
	if !sprite_data.has('nude') || !sprite_data.nude.has('path'):
		return null
	return images.get_sprite(sprite_data.nude.path)

func showbody(i):
	var nude_image = get_unique_nude_body_image(i.person)
	if nude_image != null:
		$Panel/bodyimage.texture = nude_image
		$Panel/bodyimage.visible = true
		$Panel/BodyDisplay.visible = false
		return
	var stored_image = i.person.get_stored_body_image()
	if stored_image != null:
		$Panel/bodyimage.texture = stored_image
		$Panel/bodyimage.visible = true
		$Panel/BodyDisplay.visible = false
	elif !input_handler.globalsettings.disable_paperdoll:
		$Panel/bodyimage.visible = false
		$Panel/BodyDisplay.visible = true
		$Panel/BodyDisplay/ragdoll.test_mode = false
		$Panel/BodyDisplay/ragdoll.rebuild(i.person)
		$Panel/BodyDisplay/ragdoll.rebuild_cloth(false)
#		$Panel/BodyDisplay/ragdoll.rebuild_underwear()
	else:
		$Panel/bodyimage.texture = i.person.get_body_image()
		$Panel/bodyimage.visible = true
		$Panel/BodyDisplay.visible = false
#	if i.person.get_body_image() != null:
#		$Panel/bodyimage.visible = true
#		$Panel/bodyimage.texture = i.person.get_body_image()

func hidebody():
	$Panel/bodyimage.visible = false
	$Panel/BodyDisplay.visible = false


func switchsides(panel, side):
	var person = panel.get_meta('person') #member, not charclass!
	givers.erase(person)
	takers.erase(person)
	if person.role == side:
		person.role = 'none'
	elif person.actions_remaining > 0 || side == 'take':
		if side == 'take' && person.actions_remaining <= 0 && _has_available_taker(person):
			person.role = 'none'
			$Panel/sceneeffects.bbcode_text += '\n[color=gray]' + person.name + ': ' + tr("INTERACTION_NO_ACTIONS_LEFT") + '[/color]'
		else:
			person.role = side
	else:
		person.role = 'none'
		$Panel/sceneeffects.bbcode_text += '\n[color=gray]' + person.name + ': ' + tr("INTERACTION_NO_ACTIONS_LEFT") + '[/color]'
	if person.role == 'give':
		givers.append(person)
	elif person.role == 'take':
		takers.append(person)
	rebuildparticipantslist()

func startscene(scenescript, cont = false, pretext = ''):
	var textdict = {mainevent = pretext, repeats = '', orgasms = '', speech = ''}
	var effects
	enthusiasm_pending_member = null
	enthusiasm_pending_takers = []
	enthusiasm_pending_scene = null
	enthusiasm_pending_data = null
	enthusiasm_pending_upgrades = []
	enthusiasm_pending_action_ids = null
	enthusiasm_pending_consents = {}

	var mandatoryspeech = false
	var mandatoryspeechdict
	scenescript.givers = givers
	scenescript.takers = takers
	var exhausted_takers = []
	for _m in takers:
		if _m.actions_remaining <= 0:
			exhausted_takers.append(_m)
	for _m in givers + takers:
		if _m.actions_remaining > 0:
			_m.actions_remaining -= 1

	var dict = {
		id = get_action_dict_id(),
		scene = scenescript,
		takers = [] + takers,
		givers = [] + givers,
		consents = {}}
	var enthusiasm_consents = {}
	var resists = []
	
	
	for i in givers:
		dict.consents[i.id] = 0
		enthusiasm_consents[i.id] = 0
		var lowest_consent = 10
		for j in takers:
			var consent = count_action_consent(scenescript, i, j)
			if scenescript.consent_giver > consent.giver_consent && resists.find(i.id) < 0:
				resists.append(i.id)
			if consent.giver_consent < lowest_consent:
				lowest_consent = consent.giver_consent
		if lowest_consent < scenescript.consent_giver:
			var resist = scenescript.consent_giver - lowest_consent
			dict.consents[i.id] = resist
			enthusiasm_consents[i.id] = resist
			i.lack_consent += resist
			if resist == 1:
				i.low_actions_resisted += 1
		

	for j in takers:
		dict.consents[j.id] = 0
		enthusiasm_consents[j.id] = 0
		var lowest_consent = 10
		for i in givers:
			var consent = count_action_consent(scenescript, i, j)
			if scenescript.consent_taker > consent.taker_consent && resists.find(j.id) < 0:
				resists.append(j.id)
			if consent.taker_consent < lowest_consent:
				lowest_consent = consent.taker_consent
		#dict.consents[j.id] = lowest_consent
		if lowest_consent < scenescript.consent_taker:
			var resist = scenescript.consent_taker - lowest_consent
			dict.consents[j.id] = resist
			enthusiasm_consents[j.id] = resist
			j.lack_consent += resist
			if resist == 1:
				j.low_actions_resisted += 1
		if exhausted_takers.has(j):
			dict.consents[j.id] += 1
			j.lack_consent += 1
	
	
	
#	for i in givers + takers:
#		if dict.consents[i.id] < scenescript.consent_level:
#			var result = resistattempt(i)
#			textdict.mainevent += result.text
#			if result.consent == false:
#				get_node("Panel/sceneeffects").bbcode_text += (textdict.mainevent + "\n" + textdict.repeats)
#				rebuildparticipantslist()
#
#				return

	for i in givers + takers:
		if isencountersamesex(givers,takers,i) == true:
			i.actionshad.samesex += 1
		else:
			i.actionshad.oppositesex += 1
		if i.person_sexexp.sexexp_actions.has(scenescript.code):
			i.person_sexexp.sexexp_actions[scenescript.code] += 1
		else:
			i.person_sexexp.sexexp_actions[scenescript.code] = 1
			i.new_action_performed = true
		for k in givers + takers:
			if k != i:
				if i.person_sexexp.sexexp_partners.has(k.id):
					i.person_sexexp.sexexp_partners[k.id] += 1
				else:
					i.person_sexexp.sexexp_partners[k.id] = 1
					i.person.add_partner(k.id)
					if resists.find(i.id) < 0:
						k.new_consented_partners += 1


	for i in participants:
		i.orgasm = false
		if !givers.has(i) && !takers.has(i):
			if i.person_sexexp.sexexp_seenactions.has(scenescript.code):
				i.person_sexexp.sexexp_seenactions[scenescript.code] += 1
			else:
				i.person_sexexp.sexexp_seenactions[scenescript.code] = 1

	#temporary support for scenes converted to centralized output and those not
	#should be unified in the future
	var centralized = false
	if scenescript.has_method('initiate'):
		textdict.mainevent += decoder(scenescript.initiate(), givers, takers)
	else:
		centralized = true
		textdict.mainevent += output(scenescript, scenescript.initiate, givers, takers)
		if scenescript.category != 'caress':
			textdict.mainevent += output(scenescript, scenescript.ongoing, givers, takers)

	if centralized == false:
		if scenescript.has_method('reaction'):
			for i in takers:
				textdict.mainevent += '\n' + decoder(scenescript.reaction(i), givers, [i])
	elif scenescript.reaction != null:
			for i in takers:
				textdict.mainevent += '\n' + output(scenescript, scenescript.reaction, givers, [i])
	
	
	#this part likely will need full optional description of resist for each action
#	for i in givers:
#		if (resists.has(i.id) || i.sex_traits.has("pushover")) && randf() >= variables.resist_text_chancce:
#			textdict.mainevent += "\n" + decoder(resist_text('giver',100-i.horny, i), [i], takers)
#			#textdict.mainevent += '\n' + decoder(scenescript.giver_resist(), i, [takers])
#
#	for i in takers:
#		if (resists.has(i.id) || i.sex_traits.has("pushover")) && randf() >= variables.resist_text_chancce:
#			textdict.mainevent += "\n" + decoder(resist_text('taker',100-i.horny, i), givers, [i])
			#textdict.mainevent += '\n' + decoder(scenescript.taker_resist(), givers, [i])
	
	
	
	var virgin = {type = null, character = null}

	#remove virginity if relevant
	if scenescript.virginloss == true:
		for i in givers:
			if scenescript.giverpart == 'vagina' && i.person.get_stat('vaginal_virgin') == true:
				i.person.take_virginity("vaginal",takers[0].person.id, true)
				_add_sex_minigame_points(1, decoder(tr("INTERACTION_CONNECTION_POINTS_REASON_VAGINAL_VIRGINITY"), [i], [i]))
				virgin.type = 'vaginal'
				virgin.character = i
				i.lack_consent += 5
#				if takers.size() == 1 && takers[0].person.has_profession('master'):
#					i.person.add_stat('loyalty', 20)
			elif scenescript.giverpart == 'anus' && i.person.get_stat('anal_virgin') == true:
				i.person.take_virginity("anal",takers[0].person.id, true)
				_add_sex_minigame_points(1, decoder(tr("INTERACTION_CONNECTION_POINTS_REASON_ANAL_VIRGINITY"), [i], [i]))
				virgin.type = 'anal'
				virgin.character = i
#				if takers.size() == 1 && takers[0].person.has_profession('master'):
#					i.person.add_stat('loyalty', 10)
		for i in takers:
			if scenescript.takerpart == 'vagina' && i.person.get_stat('vaginal_virgin') == true:
				i.person.take_virginity("vaginal",givers[0].person.id, true)
				_add_sex_minigame_points(1, decoder(tr("INTERACTION_CONNECTION_POINTS_REASON_VAGINAL_VIRGINITY"), [i], [i]))
				virgin.type = 'vaginal'
				virgin.character = i
				i.lack_consent += 5
#				if givers.size() == 1 && givers[0].person.has_profession('master'):
#					i.person.add_stat('loyalty', 20)
			elif scenescript.takerpart == 'anus' && i.person.get_stat('anal_virgin') == true:
				i.person.take_virginity("anal",givers[0].person.id, true)
				_add_sex_minigame_points(1, decoder(tr("INTERACTION_CONNECTION_POINTS_REASON_ANAL_VIRGINITY"), [i], [i]))
				virgin.type = 'anal'
				virgin.character = i
#				if givers.size() == 1 && givers[0].person.has_profession('master'):
#					i.person.add_stat('loyalty', 10)
		if scenescript.giverpart == 'penis':
			for i in givers:
				i.person.take_virginity('penis', takers[0].person.id, true)
		elif scenescript.takerpart == 'penis':
			for i in takers:
				i.person.take_virginity('penis', givers[0].person.id, true)

	var id_dict = make_id_dict(dict)
	for i in givers:
		if scenescript.giverpart != '':
			if i.get_part_id_dict(scenescript.giverpart) != null:
				stopongoingaction(i.get_part_ref_dict(scenescript.giverpart))
			i.set_part(scenescript.giverpart, id_dict)

	for i in takers:
		if scenescript.takerpart != '':
			if i.get_part_id_dict(scenescript.takerpart) != null:
				stopongoingaction(i.get_part_ref_dict(scenescript.takerpart))
			i.set_part(scenescript.takerpart, id_dict)

	if scenescript.get('takerpart2'):
		givers[1].set_part(scenescript.giverpart, id_dict)
		for i in takers:
			if i.get_part_id_dict(scenescript.takerpart2) != null:
				stopongoingaction(i.get_part_ref_dict(scenescript.takerpart2))
			i.set_part(scenescript.takerpart2, id_dict)

	for i in givers:
		if scenescript.has_method('givereffect'):
			effects = scenescript.givereffect(i)
			i.actioneffect(effects, id_dict)

	for i in takers:
		if scenescript.has_method('takereffect'):
			effects = scenescript.takereffect(i)
			i.actioneffect(effects, id_dict)

	if scenescript.code in ['rope', 'subdue']:
		cont = true
		if scenescript.code == 'rope':
			mandatoryspeech = true
			mandatoryspeechdict = {character = takers[0], line = 'rope'}

	#to make action switch on that hole even if they comes from another body part
	if scenescript.code in ['doubledildo','doubledildoass','tribadism']:
		for i in ongoingactions.duplicate():
			if i.scene.category == 'fucking' && (i.givers.has(givers[0]) || i.takers.has(givers[0]) || i.givers.has(takers[0]) || i.takers.has(takers[0])):
				if i.givers == givers && i.takers == takers:
					stopongoingaction(i)
	if scenescript.code in ['cunnilingus','rimjob','facesit','afacesit','massagefoot','lickfeet']:
		for i in ongoingactions.duplicate():
			if i.scene.category == 'fucking' && (i.givers.has(givers[0]) || i.takers.has(givers[0]) || i.givers.has(takers[0]) || i.takers.has(takers[0])):
				if i.givers == givers && i.takers == takers:
					stopongoingaction(i)
	if scenescript.category == 'fucking':
		for i in ongoingactions.duplicate():
			if i.scene.code in ['cunnilingus','rimjob','facesit','afacesit','massagefoot','lickfeet'] && (i.givers.has(givers[0]) || i.takers.has(givers[0]) || i.givers.has(takers[0]) || i.takers.has(takers[0])):
				if i.givers == givers && i.takers == takers:
					stopongoingaction(i)
	if scenescript.code == 'grovel':
		for i in ongoingactions.duplicate():
			if i.scene.code in ['facesit','afacesit'] && (i.givers.has(givers[0]) || i.takers.has(givers[0]) || i.givers.has(takers[0]) || i.takers.has(takers[0])):
				if i.givers == givers && i.takers == takers:
					stopongoingaction(i)
	if scenescript.code in ['facesit','afacesit']:
		for i in ongoingactions.duplicate():
			if i.scene.code == 'grovel' && (i.givers.has(givers[0]) || i.takers.has(givers[0]) || i.givers.has(takers[0]) || i.takers.has(takers[0])):
				if i.givers == givers && i.takers == takers:
					stopongoingaction(i)
	if scenescript.code == 'rope':
		for i in takers:
			var cleararray = []
			for k in i.activeactions:
				if k.scene_code == 'subdue':
					cleararray.append(k)
			for k in cleararray:
				stopongoingaction(make_ref_dict(k))
	if scenescript.code == 'deny_orgasm':
		OrgasmDenyInitiate(givers[0], takers[0])
	if scenescript.code == 'cum_select':
		SelectCum(givers[0], takers[0])
	for i in givers + takers:
		i.actionshad.actions[scenescript.code] = i.actionshad.actions.get(scenescript.code, 0) + 1
		var enthusiasm_key = _enthusiasm_get_counter_key(scenescript, i, enthusiasm_consents)
		if enthusiasm_key != scenescript.code:
			i.actionshad.actions[enthusiasm_key] = i.actionshad.actions.get(enthusiasm_key, 0) + 1
	var _enth_giver_data = scenescript.get('enthusiasm_giver')
	if _enth_giver_data == null:
		_enth_giver_data = scenescript.get('enthusiasm')
	var _enth_taker_data = scenescript.get('enthusiasm_taker')
	if (_enth_giver_data != null || _enth_taker_data != null) && givers.size() > 0 && takers.size() > 0:
		var enth_member = null
		var enth_data = null
		if scenescript.has_method('enthusiasm_check_trigger'):
			enth_member = scenescript.enthusiasm_check_trigger(givers[0], takers[0])
			if enth_member != null:
				enth_data = _enth_giver_data if givers.has(enth_member) else _enth_taker_data
		else:
			var giver_ready = _enth_giver_data != null && _enthusiasm_get_count(givers[0], scenescript, enthusiasm_consents) >= _enthusiasm_get_threshold(givers[0])
			var taker_ready = _enth_taker_data != null && _enthusiasm_get_count(takers[0], scenescript, enthusiasm_consents) >= _enthusiasm_get_threshold(takers[0])
			if giver_ready && taker_ready:
				if randf() < 0.5:
					enth_member = givers[0]; enth_data = _enth_giver_data
				else:
					enth_member = takers[0]; enth_data = _enth_taker_data
			elif giver_ready:
				enth_member = givers[0]; enth_data = _enth_giver_data
			elif taker_ready:
				enth_member = takers[0]; enth_data = _enth_taker_data
		if enth_member != null:
			var _upgrades = enth_data.get('training_upgrades', [])
			for _u in _upgrades:
				if enth_member.person.statlist.sex_training.get('sex_training_' + _u.skill, 'novice') != 'novice':
					enth_member = null
					break
		if enth_member != null:
			enthusiasm_pending_member = enth_member
			enthusiasm_pending_takers = takers if givers.has(enth_member) else givers
			enthusiasm_pending_scene = scenescript
			enthusiasm_pending_data = enth_data
			enthusiasm_pending_upgrades = enth_data.get('training_upgrades', [])
			textdict.mainevent += '\n[color=yellow]' + decoder(tr(enth_data.get('trigger_text', '')), [enthusiasm_pending_member], enthusiasm_pending_takers) + '[/color]'
			input_handler.PlaySound('button_clank')

	var sceneexists = false
	var temptext = ''
	for i in ongoingactions:
		temptext = ''
		if i.givers == givers && i.takers == takers && i.scene == scenescript:
			sceneexists = true
		elif i.scene.has_method('getongoingdescription'):
			temptext = decoder(i.scene.getongoingdescription(i.givers, i.takers), i.givers, i.takers)
		else:
			temptext = output(i.scene, i.scene.ongoing, i.givers, i.takers)
		if temptext != '':
			textdict.repeats += '\n' + temptext
	textdict.repeats = textdict.repeats.replace("[color=yellow]", '').replace('[color=aqua]', '').replace('[/color]','')

	for i in ongoingactions:
		for k in i.givers + i.takers:
			k.person_sexexp.sexexp_actions[i.scene.code] += 1
			for j in i.givers + i.takers:
				if j != k:
					if k.person_sexexp.sexexp_partners.has(j.id):
						k.person_sexexp.sexexp_partners[j.id] += 1
					else:
						k.person_sexexp.sexexp_partners[j.id] = 1
		for k in participants:
			if !i.givers.has(k) && !i.takers.has(k):
				if k.person_sexexp.sexexp_seenactions.has(i.scene.code):
					k.person_sexexp.sexexp_seenactions[i.scene.code] += 1
				else:
					k.person_sexexp.sexexp_seenactions[i.scene.code] = 1
		var i_ids = make_id_dict(i)
		if i.scene.has_method("givereffect"):
			for member in i.givers:
				effects = i.scene.givereffect(member)
				for effect in effects:
					if effect in ['sens','horny']:
						effects[effect] = effects[effect]/2
				member.actioneffect(effects, i_ids)
		if i.scene.has_method("takereffect"):
			for member in i.takers:
				effects = i.scene.takereffect(member)
				for effect in effects:
					if effect in ['sens','horny']:
						effects[effect] = effects[effect]/2
				member.actioneffect(effects, i_ids)

	var request

	id_dict = make_id_dict(dict)#update just in case
	if enthusiasm_pending_member != null && enthusiasm_pending_scene == scenescript:
		enthusiasm_pending_action_ids = id_dict
		enthusiasm_pending_consents = dict.consents.duplicate()
	for i in participants:
		if i in givers+takers:
			if !scenescript.code == 'deny_orgasm':
				i.set_lastaction(id_dict)
			request = checkrequest(i)
			if request == true:
				textdict.orgasms += decoder(tr("INTERACTION_DESIRE_FULFILLED"), [i], [i])
		else:
			for j in ongoingactions:
				if i in j.givers + j.takers:
					i.set_lastaction(make_id_dict(j))
#		if not i.lastaction in ongoingactions:
#			i.lastaction = null
		for k in i.sex_traits:
			var trait = Traitdata.sex_traits[k]
			for j in trait.effects:
				if j.trigger == 'end_turn':
					call(j.effect, i)

	if cont == true && sceneexists == false:
		ongoingactions.append(dict)
		for i in givers + takers:
			i.activeactions.append(id_dict)
	else:
		for i in givers:
			if scenescript.giverpart != '':
				i.set_part(scenescript.giverpart, null)
		for i in takers:
			if scenescript.takerpart != '':
				i.set_part(scenescript.takerpart, null)

	var x = (givers.size()+takers.size())/2

	if virgin.type != null && !virgin.character.person.has_profession('master'):
		mandatoryspeech = true
		mandatoryspeechdict = {character = virgin.character, line = "virgin_" + virgin.type}

	while x > 0:
		if mandatoryspeech == true:
			var charspeech = forced_character_speech(dict, mandatoryspeechdict.character, mandatoryspeechdict.line)
			if charspeech.text != '':
				textdict.speech += charspeech.character.name + ': ' + decoder(charspeech.text, [charspeech.character], [charspeech.partner]) + '\n'
		elif randf() < 0.3 || _any_orgasming(dict):
			var charspeech = characterspeech(dict)
			if charspeech.text != '':
				textdict.speech += charspeech.character.name + ': ' + decoder(charspeech.text, [charspeech.character], [charspeech.partner]) + '\n'
		x -= 1
	var text = textdict.mainevent + "\n" + textdict.repeats + '\n' + textdict.speech + textdict.orgasms

	var temparray = []
	for i in participants:
		if i.person.has_profession("master") || i.person.get_stat('unique') in ['dog','horse'] || i.effects.has('forced'):
			continue
		temparray.append(i)

	if scenescript.code == 'cum_select':
		pending_turn_text = text
		pending_turn_scenescript = scenescript
		pending_turn_dict_consents = dict.consents
		pending_turn_request_pool = temparray
		return

	get_node("Panel/sceneeffects").bbcode_text += '\n' + text

	if randf() < 0.15 && temparray.size() > 0:
		generaterequest(temparray[randi()%temparray.size()])

	for _m in participants:
		if _m.actions_remaining == 0 && !exhausted_takers.has(_m):
			for _act in ongoingactions.duplicate():
				if (_act.givers.has(_m) || _act.takers.has(_m)) && !_act.scene.code in ['rope', 'subdue']:
					stopongoingaction(_act)

	record_actions(scenescript, dict.consents)
	rebuildparticipantslist()

func resist_text(side, stamina, character):
	var temparray = []
	
	if character.sex_traits.has("pushover"):
		temparray += ["INTERACTION_RESIST_PUSHOVER_1"]
		temparray += ["INTERACTION_RESIST_PUSHOVER_2"]
		temparray += ["INTERACTION_RESIST_PUSHOVER_3"]
	else:
		if stamina > 30:
			temparray += ["INTERACTION_RESIST_HIGH_1"]
			temparray += ["INTERACTION_RESIST_HIGH_2"]
			temparray += ["INTERACTION_RESIST_HIGH_3"]
		elif stamina > 0:
			temparray += ["INTERACTION_RESIST_LOW_1"]
			temparray += ["INTERACTION_RESIST_LOW_2"]
			temparray += ["INTERACTION_RESIST_LOW_3"]
		else:
			temparray += ["INTERACTION_RESIST_BROKEN_1"]
			temparray += ["INTERACTION_RESIST_BROKEN_2"]
	
	
	var replace = globals.fastif(side == 'giver', '1]', '2]')
	var selected_text = tr(temparray[randi()%temparray.size()]).replace(']', replace)
	
	if character.sex_traits.has("pushover"):
		return globals.TextEncoder("{color=yellow|" + selected_text + "}")
	else:
		return globals.TextEncoder("{color=red|" + selected_text + "}")

func lewdness_aura(caster):
	for i in participants:
		if i != caster:
			i.horny += 5
			i.sens += 50

func life_power(caster):
	caster.person.hp += caster.orgasms*8

func forced_character_speech(scene, character, textdict):
	var text = ''
	var partnerside
	var partner

	if character in scene.takers:
		partnerside = 'givers'
	else:
		partnerside = 'takers'
	partner = scene[partnerside][0]

	match textdict:
		'virgin_vaginal', 'virgin_anal':
			var resist = false
			if character.horny < 100: resist = true
			if resist == false: textdict += "_like"
			else: textdict += "_dislike"
		'rope':
			var like = false
			if character.sex_traits.has("submissive"): like = true
			if like == true: textdict += "_like"
			else: textdict += "_dislike"

	text = tr(speechdict[textdict][randi()%speechdict[textdict].size()])

	return show_charcter_speech(character, partner, text)

func _any_orgasming(scene):
	for i in scene.takers + scene.givers:
		if i.orgasm == true:
			return true
	return false

func characterspeech(scene):
	var character
	var partner
	var text = ''

	#who speaks

	var array = []
	var orgasming = []
	for i in scene.takers+scene.givers:
		if !i.person.has_profession('master'):
			array.append(i)
			if i.orgasm == true:
				orgasming.append(i)

	var partnerside

	if orgasming.size() > 0:
		character = orgasming[randi()%orgasming.size()]
	else:
		character = array[randi()%array.size()]

	if character in scene.takers:
		partnerside = 'givers'
	else:
		partnerside = 'takers'

	partner = scene[partnerside][0]

	array.clear() #array will serve as speech selector
	var dict = {}
	var prevailing_lines = ['mute', 'silence', 'orgasm', 'resistorgasm', 'pain', 'painlike', 'resisthorny', 'resist', 'blowjob']

	if character.person.check_trait('Mute'):
		dict.mute = [speechdict.mute, 1]
	if character.person.check_trait('Sex-crazed'):
		dict.sexcrazed = [speechdict.sexcrazed, 1]
	if character.sex_traits.has('anal'):
		dict.enjoysanal = [speechdict.enjoysanal, 1]
	if character.sex_traits.has('submissive'):
		dict.rough = [speechdict.rough, 1]
#	if character.person.rules.silence == true:
#		dict.silence = [speechdict.silence, 1]
	var consent = count_action_consent(scene.scene, partner, character)
	var lacks_consent = false
	if character in scene.takers:
		if consent.taker_consent < scene.scene.consent_taker:
			lacks_consent = true
			if character.horny >= 100:
				dict.resisthorny = [speechdict.resisthorny, 1]
			else:
				dict.resist = [speechdict.resist, 1]
			if scene.scene.code in ['missionaryanal', 'doggyanal', 'lotusanal','revlotusanal', 'inserttaila', 'insertinturnsass']:
				dict.analrape = [speechdict.analrape, 1]
	elif character in scene.givers:
		if consent.giver_consent < scene.scene.consent_giver:
			lacks_consent = true
			dict.resist = [speechdict.resist, 1]
	if character.orgasm == true:
		if lacks_consent:
			dict.resistorgasm = [speechdict.resistorgasm, 1]
		else:
			dict.orgasm = [speechdict.orgasm, 1]
	if scene.scene.code in ['blowjob'] && partnerside == 'takers':
		dict.blowjob = [speechdict.blowjob, 1]
	if scene.scene.code in ['blowjob','spitroast'] && partnerside == 'givers':
		dict.blowjobtake = [speechdict.blowjobtake, 1]
	if scene.scene.code in ['missionary', 'doggy', 'lotus', 'revlotus', 'inserttailv', 'insertinturns'] && partnerside == 'givers':
		dict.vagina = [speechdict.vagina, 1]
	if scene.scene.code in ['missionaryanal', 'doggyanal', 'lotusanal','revlotusanal', 'inserttaila', 'insertinturnsass'] && partnerside == 'givers':
		dict.anal = [speechdict.anal, 1]
	if (!character.person.check_trait('Lesbian') && !character.sex_traits.has("bisexual")) && character.sex != 'male' && partner.sex != 'male' && partnerside == 'givers':
		dict.nonlesbian = [speechdict.nonlesbian, 1]
	if scene.scene.get("takertags") && scene.scene.takertags.has("pain") && partnerside == 'givers' && !character.person.check_trait('Likes it rough') && !character.person.check_trait("Masochist"):
		dict.pain = [speechdict.pain, 2.5]
	if scene.scene.get("takertags") && scene.scene.takertags.has("pain") && partnerside == 'givers' && (character.person.check_trait('Likes it rough') || character.person.check_trait("Masochist")) && !character.effects.has('resist'):
		dict.painlike = [speechdict.painlike, 2.5]

	if character.person_sexexp.sexexp_actions.get(scene.scene.code, 0) == 1:
		dict.inexperienced = [speechdict.inexperienced, 5]
	dict.moans = [speechdict.moans, 0.25]
	for i in prevailing_lines:
		if dict.has(i):
			var temp = dict[i].duplicate()
			dict.clear()
			dict[i] = temp
			break
	for i in dict.values():
		array.append(i)
	text = input_handler.weightedrandom(array)
	if text != null:
		text = tr(text[randi()%text.size()])

	if text == null:
		text = ''
	return show_charcter_speech(character, partner, text)

func show_charcter_speech(character, partner, text):
	if partner.person.has_profession("master") || character.person.check_trait("Monogamous"):
		text = text.replace('[name2]', character.person.get_stat('masternoun'))
	else:
		text = text.replace('[name2]', partner.name)

	return {text = '[color=lime]' + text + '[/color]', character = character, partner = partner}

var speechdict = {
resist = ["INTERACTION_SPEECH_RESIST_1", "INTERACTION_SPEECH_RESIST_2", "INTERACTION_SPEECH_RESIST_3", "INTERACTION_SPEECH_RESIST_4", "INTERACTION_SPEECH_RESIST_5"],
resisthorny = ["INTERACTION_SPEECH_RESISTHORNY_1", "INTERACTION_SPEECH_RESISTHORNY_2", "INTERACTION_SPEECH_RESISTHORNY_3", "INTERACTION_SPEECH_RESISTHORNY_4", "INTERACTION_SPEECH_RESISTHORNY_5"],
resistorgasm = ["INTERACTION_SPEECH_RESISTORGASM_1", "INTERACTION_SPEECH_RESISTORGASM_2", "INTERACTION_SPEECH_RESISTORGASM_3"],
mute = ["INTERACTION_SPEECH_MUTE_1", "INTERACTION_SPEECH_MUTE_2", "INTERACTION_SPEECH_MUTE_3", "INTERACTION_SPEECH_MUTE_4"],
blowjob = ["INTERACTION_SPEECH_BLOWJOB_1", "INTERACTION_SPEECH_BLOWJOB_2", "INTERACTION_SPEECH_BLOWJOB_3", "INTERACTION_SPEECH_BLOWJOB_4"],
blowjobtake = ["INTERACTION_SPEECH_BLOWJOBTAKE_1", "INTERACTION_SPEECH_BLOWJOBTAKE_2", "INTERACTION_SPEECH_BLOWJOBTAKE_3"],
inexperienced = ["INTERACTION_SPEECH_INEXPERIENCED_1", "INTERACTION_SPEECH_INEXPERIENCED_2", "INTERACTION_SPEECH_INEXPERIENCED_3"],
vagina = ["INTERACTION_SPEECH_VAGINA_1", "INTERACTION_SPEECH_VAGINA_2", "INTERACTION_SPEECH_VAGINA_3", "INTERACTION_SPEECH_VAGINA_4"],
anal = ["INTERACTION_SPEECH_ANAL_1", "INTERACTION_SPEECH_ANAL_2", "INTERACTION_SPEECH_ANAL_3"],
orgasm = ["INTERACTION_SPEECH_ORGASM_1", "INTERACTION_SPEECH_ORGASM_2", "INTERACTION_SPEECH_ORGASM_3","INTERACTION_SPEECH_ORGASM_4","INTERACTION_SPEECH_ORGASM_5"],
analrape = ["INTERACTION_SPEECH_ANALRAPE_1", "INTERACTION_SPEECH_ANALRAPE_2", "INTERACTION_SPEECH_ANALRAPE_3"],
sexcrazed = ["INTERACTION_SPEECH_SEXCRAZED_1", "INTERACTION_SPEECH_SEXCRAZED_2", "INTERACTION_SPEECH_SEXCRAZED_3"],
nonlesbian = ["INTERACTION_SPEECH_NONLESBIAN_1", "INTERACTION_SPEECH_NONLESBIAN_2", "INTERACTION_SPEECH_NONLESBIAN_3"],
enjoysanal = ["INTERACTION_SPEECH_ENJOYSANAL_1", "INTERACTION_SPEECH_ENJOYSANAL_2"],
rough = ["INTERACTION_SPEECH_ROUGH_1", "INTERACTION_SPEECH_ROUGH_2"],
pain = ["INTERACTION_SPEECH_PAIN_1", "INTERACTION_SPEECH_PAIN_2", "INTERACTION_SPEECH_PAIN_3", "INTERACTION_SPEECH_PAIN_4", "INTERACTION_SPEECH_PAIN_5"],
painlike = ["INTERACTION_SPEECH_PAINLIKE_1", "INTERACTION_SPEECH_PAINLIKE_2", "INTERACTION_SPEECH_PAINLIKE_3"],
silence = ["INTERACTION_SPEECH_SILENCE_1", "INTERACTION_SPEECH_SILENCE_2", "INTERACTION_SPEECH_SILENCE_3"],
moans = ["INTERACTION_SPEECH_MOANS_1", "INTERACTION_SPEECH_MOANS_2", "INTERACTION_SPEECH_MOANS_3", "INTERACTION_SPEECH_MOANS_4"],

virgin_vaginal_like = ["INTERACTION_SPEECH_VIRGIN_VAGINAL_LIKE_1", "INTERACTION_SPEECH_VIRGIN_VAGINAL_LIKE_2", "INTERACTION_SPEECH_VIRGIN_VAGINAL_LIKE_3"],
virgin_vaginal_dislike = ["INTERACTION_SPEECH_VIRGIN_VAGINAL_DISLIKE_1", "INTERACTION_SPEECH_VIRGIN_VAGINAL_DISLIKE_2", "INTERACTION_SPEECH_VIRGIN_VAGINAL_DISLIKE_3"],
virgin_anal_like = ["INTERACTION_SPEECH_VIRGIN_ANAL_LIKE_1", "INTERACTION_SPEECH_VIRGIN_ANAL_LIKE_2"],
virgin_anal_dislike = ["INTERACTION_SPEECH_VIRGIN_ANAL_DISLIKE_1", "INTERACTION_SPEECH_VIRGIN_ANAL_DISLIKE_2"],
rope_like = ["INTERACTION_SPEECH_ROPE_LIKE_1", "INTERACTION_SPEECH_ROPE_LIKE_2", "INTERACTION_SPEECH_ROPE_LIKE_3"],
rope_dislike = ["INTERACTION_SPEECH_ROPE_DISLIKE_1", "INTERACTION_SPEECH_ROPE_DISLIKE_2", "INTERACTION_SPEECH_ROPE_DISLIKE_3"],

}


func startscenecontinue(scenescript):
	startscene(scenescript, true)


#centralized output processing
#category currently assumed to be 'fucking', will expland with further conversions
func output(scenescript, valid_lines, givers, takers):
	var shared_lines = sexdict.shared_lines
	var giverpart = scenescript.giverpart
	var takerpart = scenescript.takerpart
	var act_lines = scenescript.act_lines
	var links = sexdict.linksets[scenescript.linkset]
	#internal
	var linearray = []
	var output = ''
	var virginpart = null
	var virginsource = null
	var link = null
	#checks
	var giver_skill_level = 'novice'
	if scenescript.giver_skill.size() > 0:
		var t = givers[0].person.statlist.sex_training.get('sex_training_' + scenescript.giver_skill[0], 'novice')
		giver_skill_level = t

	var taker_skill_level = 'novice'
	if scenescript.taker_skill.size() > 0:
		var t = takers[0].person.statlist.sex_training.get('sex_training_' + scenescript.taker_skill[0], 'novice')
		taker_skill_level = t

	var giver_tail_type = 'none'
	var giver_tits_size = 'default'
	if givers.size() > 0:
		var _tail = givers[0].person.get_stat('tail')
		if _tail in ['fox', 'cat', 'wolf', 'tanuki']:
			giver_tail_type = 'furry'
		elif _tail in ['dragon', 'demon', 'fish', 'lizard', 'kobold', 'rat']:
			giver_tail_type = 'scaly'
		var has_small_tits = false
		for giver in givers:
			match giver.person.get_stat('tits_size'):
				'small':
					has_small_tits = true
				'flat', 'masculine':
					pass
				_:
					giver_tits_size = 'default'
					break
			giver_tits_size = 'small' if has_small_tits else 'flat'

	var checks = {
		code = scenescript.code,
		link = null,
		link_facing = null,
		orifice = 'insert',
		consent = true,
		virgin = true,
		parallel = true if scenescript.get("parallel") else false,
		facing = true if scenescript.get("facing") else false,
		arousal = 1,
		lust = 1,
		giver_skill_level = giver_skill_level,
		taker_skill_level = taker_skill_level,
		taker_part_occupied = false,
		taker_fingering_ongoing = false,
		taker_vaginal_ongoing = false,
		giver_tail_type = giver_tail_type,
		giver_tits_size = giver_tits_size,
	}

	#link with ongoingactions
	var givers0_part_dict = givers[0].get_part_id_dict(giverpart)
	if givers0_part_dict != null:
		if givers0_part_dict.scene_code in links:
			link = givers[0].get_part_ref_scene(giverpart)
			for i in givers:
				if !is_id_dicts_equal(i.get_part_id_dict(giverpart), givers0_part_dict):
					link = null
					break
			for i in takers:
				if !is_id_dicts_equal(i.get_part_id_dict(takerpart), givers0_part_dict):
					link = null
					break
	#link with lastaction if ongoing fails
	var givers0_lastaction = givers[0].get_lastaction_id_dict()
	if link == null && givers0_lastaction != null:
		if givers0_lastaction.scene_code in links:
			link = givers[0].get_lastaction_ref_scene()
			for i in givers+takers:
				if !is_id_dicts_equal(i.get_lastaction_id_dict(), givers0_lastaction):
					link = null
					break
	#gather orifice info from link
	if link != null:
		checks.link = link.code
		checks.link_facing = true if link.get("facing") else false
		if scenescript.virginloss == true && link.virginloss == true:
			if checks.code == link.code:
				checks.orifice = 'same'
			elif 'vagina' in [scenescript.giverpart] + [scenescript.takerpart] && 'vagina' in [link.giverpart] + [link.takerpart]:
				checks.orifice = 'shift'
			elif 'anus' in [scenescript.giverpart] + [scenescript.takerpart] && 'anus' in [link.giverpart] + [link.takerpart]:
				checks.orifice = 'shift'
			else:
				checks.orifice = 'swap'
	#virginity assignments
	if giverpart == 'penis':
		if takerpart == 'vagina':
			virginpart = 'vaginal_virgin'
			virginsource = takers
		elif takerpart == 'anus':
			virginpart = 'anal_virgin'
			virginsource = takers
	elif takerpart == 'penis':
		if giverpart == 'vagina':
			virginpart = 'vaginal_virgin'
			virginsource = givers
		elif giverpart == 'anus':
			virginpart = 'anal_virgin'
			virginsource = givers
	#assign virginity check
	if virginsource != null:
		for i in virginsource:
			if i.person.get_stat(virginpart) == false:
				checks.virgin = false
	#assign consent
	for j in takers:
		var lowest_consent = 100
		for i in givers:
			var consent = count_action_consent(scenescript, i, j)
			if consent.taker_consent < lowest_consent:
				lowest_consent = consent.taker_consent
		if lowest_consent < scenescript.consent_taker:
			checks.consent = false
			break
	#based on screen values, subject to adjustment
	if takers.size() == 1:
		checks.arousal = int(clamp(ceil(takers[0].sens/200), 1, 5))
		checks.lust = int(clamp(ceil(takers[0].lust/200), 1, 5))
	#true only when another action already occupies the taker's part (not this action itself)
	var occ_check_part = takerpart
	if scenescript.get('occupied_check_part') != null && scenescript.occupied_check_part != '':
		occ_check_part = scenescript.occupied_check_part
	if occ_check_part != '' && takers.size() > 0:
		var occ = takers[0].get_part_id_dict(occ_check_part)
		if occ != null && occ.scene_code != scenescript.code:
			checks.taker_part_occupied = true
	#true when any ongoing action is fingering targeting the same taker
	if takers.size() > 0:
		for oa in ongoingactions:
			if oa.scene.code == 'fingering' && takers[0] in oa.takers:
				checks.taker_fingering_ongoing = true
				break
	#true when any ongoing action occupies the taker's vagina, or vagina part slot is currently set
	if takers.size() > 0:
		for oa in ongoingactions:
			if oa.scene.takerpart == 'vagina' && takers[0] in oa.takers:
				checks.taker_vaginal_ongoing = true
				break
		if !checks.taker_vaginal_ongoing:
			var vagina_occ = takers[0].get_part_id_dict('vagina')
			if vagina_occ != null && vagina_occ.scene_code != scenescript.code:
				checks.taker_vaginal_ongoing = true

	#build the output
	var drop = false
	for i in valid_lines:
		linearray = []
		if i in act_lines:
			var has_matching_giver_tits_size = false
			for j in act_lines[i]:
				if act_lines[i][j].conditions.has('giver_tits_size') && act_lines[i][j].conditions.giver_tits_size.has(checks.giver_tits_size):
					has_matching_giver_tits_size = true
					break
			for j in act_lines[i]:
				drop = false
				if has_matching_giver_tits_size && !act_lines[i][j].conditions.has('giver_tits_size'):
					drop = true
				for k in act_lines[i][j].conditions:
					if checks.has(k) && !act_lines[i][j].conditions[k].has(checks[k]):
						drop = true
						break
				if drop == false:
					linearray += act_lines[i][j].lines
		if i in shared_lines:
			for j in shared_lines[i]:
				drop = false
				for k in shared_lines[i][j].conditions:
					if checks.has(k) && !shared_lines[i][j].conditions[k].has(checks[k]):
						drop = true
						break
				if drop == false:
					linearray += shared_lines[i][j].lines
		if linearray.size() > 0:
			var picked = linearray[randi()%linearray.size()]
			#print("[output] section=", i, " picked=", picked)
			output += tr(picked)

	return decoder(output, givers, takers)

func impregnationcheck(person1, person2):
	var valid = true
	if person1.get_stat('unique') in ['dog','horse'] || person2.get_stat('unique') in ['dog','horse']:
		valid = false
	return valid


func isencountersamesex(givers, takers, actor = null):
	var actorpos = ''
	var samesex = false
	if givers.size() == 0 || takers.size() == 0:
		return false
	var giverssex = givers[0].sex
	var takerssex = takers[0].sex
	if givers.has(actor):
		actorpos = 'giver'
	elif takers.has(actor):
		actorpos = 'taker'

	if (actorpos == 'giver' && ((actor.sex == 'male' && takerssex == 'male') || (actor.sex in ['female','futa'] && takerssex in ['female','futa']))) || (actorpos == 'taker' && ((actor.sex == 'male' && giverssex == 'male') || (actor.sex in ['female','futa'] && giverssex in ['female','futa']))) :
		samesex = true
	return samesex


func decoder(text, tempgivers, temptakers):
	return parser.decoder(text, tempgivers, temptakers)


func _on_sceneeffects1_meta_clicked( meta ):
	stopongoingaction(meta, true)

func stopongoingaction(meta, rebuild = false):
	var action
	if typeof(meta) == TYPE_STRING:
		action = ongoingactions[int(meta)]
	elif typeof(meta) == TYPE_DICTIONARY:
		action = meta
	for i in action.givers:
		if action.scene.giverpart != '':
			i.set_part(action.scene.giverpart, null)
	for i in action.takers:
		if action.scene.takerpart != '':
			i.set_part(action.scene.takerpart, null)
		if action.scene.get("takerpart2"):
			i.set_part(action.scene.takerpart2, null)
	if action.scene.code == 'rope':
		for i in action.takers:
			i.effects.erase('tied')
	if action.scene.code == 'subdue':
		var erasearray = []
		for taker in action.takers:
			for giver in action.givers:
				giver.subduing = null
				erasearray.append(giver)
			for giver in erasearray:
				taker.subduedby.erase(giver)
	var action_ids = make_id_dict(action)
	for i in action.givers + action.takers:
		for act_num in range(i.activeactions.size()-1, -1, -1):
			if is_id_dicts_equal(i.activeactions[act_num], action_ids):
				i.activeactions.remove(act_num)
	for act in ongoingactions:
		if act.id == action.id:
			ongoingactions.erase(act)
	if rebuild == true:
		rebuildparticipantslist()



func _on_passbutton_pressed():
	var _no_actions = true
	for _m in participants:
		if _m.actions_remaining > 0:
			_no_actions = false
			break
	if _no_actions:
		$Panel/passbutton.disabled = true
		return
	if selectmode == 'normal':
		startscene(categories.other[0])
	else:
		askslaveforaction(ai[rand_range(0, ai.size())])

func _on_stopbutton_pressed():
	endencounter()

func endencounter():
	for id in test_dummy_ids:
		ResourceScripts.game_party.characters.erase(id)
		ResourceScripts.game_party.character_order.erase(id)
	test_dummy_ids.clear()
	var text = ''
	var consenttext = {}
	set_process_input(false)
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()

	var mastery_required = {
		penetration = [["missionary", "missionaryanal"], ["doggy", "doggyanal"], ["lotus", "lotusanal"], ["revlotus", "revlotusanal"], ["ontop", "ontopanal"]],
		pussy = [["missionary"], ["doggy"], ["lotus"], ["revlotus"], ["ontop"]],
		anal = [["missionaryanal"], ["doggyanal"], ["lotusanal"], ["revlotusanal"], ["ontopanal"]],
		petting = [["fondletits", "titjob"], ["handjob", "fingering", "assfingering"], ["footjob", "massagefoot"], ["fisting", "analfisting"]],
		oral = [["rimjob"], ["cunnilingus", "blowjob"], ["kiss"], ["sucknipples"]],
		tail = [["tailjob"], ["inserttailv"], ["inserttaila"]],
	}
	for p in participants:
		for skill in mastery_required:
			if p.person.statlist.sex_training.get('sex_training_' + skill, 'novice') != 'skilled':
				continue
			var progress = p.person.statlist.sex_mastery_progress.get(skill, [])
			var has_all = true
			for group in mastery_required[skill]:
				var group_done = false
				for action in group:
					if action in progress:
						group_done = true
						break
				if !group_done:
					has_all = false
					break
			if has_all:
				p.person.statlist.sex_training['sex_training_' + skill] = 'mastered'
				p.skill_xp_bonus += 50
				text += tr("INTERACTION_END_SKILL_MASTERED") % [p.name, tr("CHARINFO_SEX_TRAINING_" + skill.to_upper())]

	for i in participants:
		
		i.person.set_stat('lastsexday', ResourceScripts.game_globals.date)
		
		
		if i.low_actions_resisted > 7 - i.person.get_stat('sexuals_factor')/1.5 && i.person.get_stat('consent') < 6:
			i.person.add_stat('consent', 1)
			i.skill_xp_bonus += 20
			text += i.person.translate(tr("INTERACTION_END_CONSENT_GAIN")) % tr(variables.consent_dict[int(i.person.get_stat('consent'))])

		if i.lack_consent > 0 && i.person.get_stat('unique') != 'rouge':
			var final_lack = _get_final_lack_consent(i)
			var hate_chance = 0.0
			if final_lack <= 5:
				hate_chance = 0.0
			elif final_lack >= 20:
				hate_chance = 1.0
			else:
				hate_chance = clamp(final_lack * 0.03, 0.01, 1.0)
			if randf() < hate_chance:
				if i.person.training.is_slave():
					i.person.training.set_resistance(100)
					var loyalty_loss = round(rand_range(5, 10))
					i.person.training.add_stat('loyalty', -loyalty_loss)
					text += i.person.translate(tr("INTERACTION_END_LACK_CONSENT_SLAVE") % [str(loyalty_loss)])
				elif i.person.training.is_servant():
					var servant_traits = i.person.get_traits_by_tag('servant_training')
					if servant_traits.size() > 0:
						var lost_trait = servant_traits[randi() % servant_traits.size()]
						i.person.remove_trait(lost_trait)
						text += i.person.translate(tr("INTERACTION_END_LACK_CONSENT_SERVANT") % [Traitdata.traits[lost_trait].name])
		
#		if i.new_action_performed == true:
#			i.consentgain += 1
#			consenttext[i.id] += '\nTried new action: +1'
#		if i.new_consented_partners > 0:
#			i.consentgain += i.new_consented_partners*2
#			consenttext[i.id] += '\nConsented to new partners: +' + str(i.new_consented_partners*2)

#		if floor(i.consented_actions.keys().size()/3) > 0:
#			i.consentgain += floor(i.consented_actions.keys().size())/3
#			consenttext[i.id] += "\nAccepted Variety: +" + str(floor(i.consented_actions.keys().size())/3)

#		if i.effects.has("pheromones"):
#			consenttext[i.id] += "\nWas drugged with pheromones: -" + str(floor(i.consentgain/2))
#			i.consentgain = floor(i.consentgain/2)
		text += i.person.translate(tr("INTERACTION_END_ORGASMS")) % str(i.orgasms)
		if i.orgasms > 0 && i.gave_orgasm:
			var _cur_stamina = i.person.get_stat('sex_stamina')
			if _cur_stamina < 10:
				i.person.add_stat('sex_stamina', 1, true)
				text += i.person.translate(tr("INTERACTION_END_STAMINA_GAINED"))
#		i.person.sexuals += i.orgasms not relevant
		var expgain = 0
		if i.orgasms > 0:
			expgain += 10
		expgain += i.orgasms * 5
		if i.gave_orgasm:
			expgain += 10
		expgain += i.skill_xp_bonus
		var bonus = 1
		if i.person.check_trait("succubus"):
			bonus += 0.5

		for t in i.sex_traits:
			var trait = Traitdata.sex_traits[t]
			for j in trait.effects:
				if j.trigger == 'encounter_end':
					if j.effect == 'exp_bonus':
						bonus = input_handler.math(j.operant, bonus, j.value)
#					elif j.effect == 'consent_gain':
#						i.consentgain = input_handler.math(j.operant, i.consentgain, j.value)
					else: call(j.effect, i)

		expgain = round(expgain * bonus)

		i.person.add_stat('base_exp', expgain)
		text += tr("INTERACTION_END_EXP_GAINED") % str(expgain)
		if i.orgasms > 0:
			var effect = 'satisfaction_1'
			if i.orgasms >= 3:
				effect = 'satisfaction_2'
			i.person.apply_effect_code(effect)
#		var temptext = consenttext[i.id]
#		consenttext[i.id] = "Total: "

#		if i.consentgain > 0:
#			consenttext[i.id] += '+'
#		else:
#			consenttext[i.id] += '-'
		#consenttext[i.id] += str(i.consentgain) + temptext
		#i.person.add_stat('consent', i.consentgain)
		text += "\n"

	ongoingactions.clear()

	var array = []
	var has_master = true
	var args = []
	for i in participants:
		array.append(i.id)
		if i.person.has_profession('master'):
			args.append("partner_is_master")
	input_handler.get_person_for_chat(array, 'sex_finish', args)

	var sex_traits = Traitdata.sex_traits
	var check = false
	var chance = false
	### Adding traits
	text += "\n"
	for p in participants:
		for i in sex_traits:
			check = check_acquire_reqs(p, sex_traits[i].acquire_reqs)
			chance = (randf()*100 < (5 + 5 * p.person.get_stat('sexuals_factor')))
			if chance && check && !p.person.get_unlocked_sex_traits().has(i):
				p.person.unlock_sex_trait(i)
				text += tr("INTERACTION_END_TRAIT_LEARNED") % [p.name, Traitdata.sex_traits[i].name]
	### Removing Dislikes
	var dislikes = []
	for p in participants:
		for diz in p.person.get_negative_sex_traits():
			if diz.begins_with("dislike"):
				dislikes.append(diz)
			if dislikes.size() != 0:
				for i in sex_traits:
					if !i.begins_with("dislike"):
						continue
					if !i in dislikes:
						continue
					check = check_acquire_reqs(p, sex_traits[i].reqs)
					chance = (randf()*100 < (5 + 5 * p.person.get_stat('sexuals_factor')))
					if (chance && check) :
						p.person.get_negative_sex_traits().erase(i) #bad practice still
						text += tr("INTERACTION_END_TRAIT_LOST") % [p.name, Traitdata.sex_traits[i].name]

	get_node("Control").show()
	get_node("Control/Panel/RichTextLabel").set_bbcode(globals.TextEncoder(text))

func mformula(gain, mana):
	return mana + gain * max(0, mana/(mana-300)+1)



func askslaveforaction(chosen):
	#choosing target
	var targets = []
	clearstate()
	var chosensex = chosen.sex
	var debug = ""
	var group = false
	var target

	debug += 'Chosing targets... \n'

	var has_available_taker = _has_available_taker(chosen)
	for i in participants:
		if i != chosen:
			if i.actions_remaining <= 0 && has_available_taker:
				continue
			if i.person.has_profession("master") && aiobserve == true:
				continue
			debug += i.name
			var value = 10
			if chosen.person.check_trait("Monogamous") && !i.person.has_profession('master'):
				value = 0
			elif chosen.person.check_trait("Fickle") || chosen.person.check_trait('Slutty'):
				value = 25
			if chosen.person.check_trait('Devoted') && i.person.has_profession("master"):
				value += 50

			if i.npc == true && chosen.npc == true:
				value -= 50

			if chosen.person_sexexp.sexexp_orgasms.has(i.id):
				value += chosen.person_sexexp.sexexp_orgasms[i.id]*4
			if chosen.person_sexexp.sexexp_watchers.has(i.id):
				value += (chosen.person_sexexp.sexexp_watchers[i.id]-1)*2
			if chosen.person_sexexp.sexexp_partners.has(i.id):
				value += chosen.person_sexexp.sexexp_partners[i.id]/0.2
			if isencountersamesex([chosen], [i], chosen) && !chosen.person.check_trait('Bisexual') && !chosen.person.check_trait('Homosexual'):
				value = max(value/5,1)
			elif isencountersamesex([chosen], [i], chosen) == false && chosen.person.check_trait('Homosexual'):
				value = max(value/5,1)
			debug += " - " + str(value) + '\n'
			value = min(value, 120)
			if value > 0:
				targets.append([i, value])

	target = input_handler.weightedrandom(targets)
	debug += 'final target - ' + target.name

	debug += '\nChosing dom: \n'
	var dom = [['giver',40],['taker', 10]]

	if target.sex != chosen.sex && chosen.sex == 'female' && (chosen.person.get_stat('asser') < 75 || !chosen.person.check_trait("Dominant")):
		dom[0][1] = 0

	if chosen.person.get_stat('asser') >= 75:
		dom[1][1] = 0
	elif chosen.person.get_stat('asser') <= 25:
		dom[0][1] = 0
	debug += str(dom) + "\n"
	dom = input_handler.weightedrandom(dom)

	debug += 'final dom: ' + dom + '\n'

	var groupchosen = [chosen]
	var grouptarget = [target]

	if participants.size() >= 3:
		if randf() >= 0.5 && !chosen.person.check_trait("Monogamous"):
			group = true
	var freeparticipants = []

	if group == true:
		debug += "Group action attempt:\n"
		for i in participants:
			if i.person.has_profession("master") && aiobserve == true:
				continue
			if i != chosen && i != target && randf() >= 0.5:
				freeparticipants.append(i)

		while freeparticipants.size() > 0:
			var targetgroup
			var newparticipant = freeparticipants[randi()%freeparticipants.size()]
			var samesex = isencountersamesex([newparticipant], [chosen], chosen)
			if chosen.person.check_trait("Bisexual"):
				targetgroup = 'any'
			elif (chosen.person.check_trait("Homosexual") && samesex) || !samesex:
				targetgroup = 'target'
			elif chosen.person.check_trait("Homosexual"):
				targetgroup = 'any'
			else:
				targetgroup = 'chosen'
			if (targetgroup == 'any' && randf() >= 0.5) || targetgroup == 'chosen':
				groupchosen.append(newparticipant)
			else:
				grouptarget.append(newparticipant)

			freeparticipants.erase(newparticipant)

	#choosing action
	var chosenpos = ''
	var actions = []
	var chosenaction = null
	debug += 'chosing action: \n'
	for i in categories:
		for j in categories[i]:
			clearstate()
			debug += j.code + ": "
			if j.code == 'wait':
				continue
			if j.code in takercategories:
				if dom == 'taker':
					givers += groupchosen
					takers += grouptarget
				else:
					takers += groupchosen
					givers += grouptarget
			else:
				if dom == 'taker':
					takers += groupchosen
					givers += grouptarget
				else:
					givers += groupchosen
					takers += grouptarget
			var result = checkaction(j, doubledildocheck())
			if result[0] == 'allowed':
				var value = 0
				if chosen.person_sexexp.sexexp_actions.has(j.code):
					value += chosen.person_sexexp.sexexp_actions[j.code]/2
				if chosen.person_sexexp.sexexp_orgasms.has(j.code):
					value += chosen.person_sexexp.sexexp_orgasms[j.code]*4
				if chosen.person_sexexp.sexexp_seenactions.has(j.code):
					value += chosen.person_sexexp.sexexp_seenactions[j.code]/10

				if i in ['caress','fucking']:
					value += 10

				if !chosen.person.check_trait("Enjoys Anal") && j.code in analcategories:
					if chosenpos == 'giver' && !takercategories.has(j.code):
						value -= 5
					elif chosenpos == 'taker' && takercategories.has(j.code):
						value -= 5



				if chosen.person.check_trait('Masochist') && j.code in punishcategories && chosenpos == 'taker':
					value *= 2.5
				if chosen.person.check_trait('Dominant') && j.code in punishcategories && chosenpos == 'giver':
					value *= 2.5
#				if target.submission < 20  && j.code in punishcategories && chosenpos == 'giver':
#					value *= 3
				if chosen.person.get_stat('penis_size') == 'none' && dom == 'giver' && j.code == 'strapon':
					value *= 10
				if chosen.person.check_trait("Pervert") && ((givers.has(chosen) && j.giverconsent == 'advanced') || (takers.has(chosen) && j.takerconsent == 'advanced')):
					value += 15

				if chosen.person.get_stat('vaginal_virgin') == true && j.category == 'fucking' && !j.code in analcategories:
					value -= 25
				if chosen.person.get_stat('anal_virgin') == true && j.category == 'fucking' && j.code in analcategories:
					value -= 25

				if j.category == 'fucking':
					value += max(turns, 15)

				if j.code in ['tribadism','doubledildo','doubledildoass','frottage'] && (chosen.strapon == true || target.strapon == true):
					value = 0

				debug += str(value) + '\n'
				if value >= 0:
					actions.append([j, value])
	if actions.size() == 0:
		actions.append([categories.other[0], 1])
	chosenaction = input_handler.weightedrandom(actions)
	clearstate()
	if chosenaction.code in takercategories:
		if dom == 'taker':
			givers = groupchosen
			takers = grouptarget
		else:
			takers = groupchosen
			givers = grouptarget
	else:
		if dom == 'taker':
			takers = groupchosen
			givers = grouptarget
		else:
			givers = groupchosen
			takers = grouptarget
	var cont = false
	chosenaction.givers = givers
	chosenaction.takers = takers
	var text = tr("INTERACTION_AI_INITIATES") % chosenaction.getname()
	if chosenaction.canlast == true && randf() >= 0.2:
		cont = true
	$PopupPanel/RichTextLabel.bbcode_text = debug
	#$PopupPanel.popup()
	startscene(chosenaction, cont, decoder(text, groupchosen, grouptarget))

func _on_finishbutton_pressed():
	if ResourceScripts.core_animations.BeingAnimated.has(self):
		return
	gui_controller.clock.visible = true
	ai.clear()
	for i in participants:
		if i.npc == false:
			for k in participants:
				if k.npc == true:
					i.person_sexexp.sexexp_watchers.erase(k.id)
					i.person_sexexp.sexexp_partners.erase(k.id)
					i.person_sexexp.sexexp_orgasms.erase(k.id)
	selectmode = 'normal'
	last_action_dict_id = 0
	yield(ResourceScripts.core_animations.CloseAnimation(self, 0.3), "completed")
	gui_controller.current_screen = gui_controller.previous_screen
	gui_controller.current_screen.raise()
	gui_controller.current_screen.show()
	if gui_controller.current_screen == gui_controller.mansion:
		gui_controller.current_screen.mansion_state_set("default")
		gui_controller.clock.raise()
	# input_handler.update_slave_list()


func _on_blacklist_pressed():
	$blacklist.visible = true
	for i in $blacklist/ScrollContainer/VBoxContainer.get_children():
		if i.get_name() != 'CheckBox':
			i.visible = false
			i.queue_free()
	for i in categories.values():
		for j in i:
			if j.code == 'wait':
				continue
			var node = $blacklist/ScrollContainer/VBoxContainer/CheckBox.duplicate()
			j.givers = [participants[0]]
			$blacklist/ScrollContainer/VBoxContainer.add_child(node)
			node.visible = true
			node.text = j.getname(1)
			node.set_pressed(!filter.has(j.code))
			node.set_meta("action", j)
			node.connect("toggled", self, 'toggleaction', [node])

func toggleaction(button, node):
	var action = node.get_meta('action')
	if filter.has(action.code):
		filter.erase(action.code)
	else:
		filter.append(action.code)
	node.set_pressed(!filter.has(action.code))

func _on_closeblacklist_pressed():
	$blacklist.visible = false
	rebuildparticipantslist()




func _on_debug_pressed():
	$PopupPanel.popup()


func _on_aiallow_pressed():
	aiobserve = $Panel/aiallow.pressed



func resistattempt(member, strength):
	var result = {text = '', consent = true}
	var subdue = 0
	var resist_chance = 0



	if !member.sex_traits.has("doormat") || randf() >= 0.5:
		pass
	
	
	result.text = tr("INTERACTION_RESIST_ATTEMPT")

#	if resiststrength > subdue && resiststrength != 0:
#		result.consent = true
#		result.text += '[name1] resists the attempt with brute force.\n'
#	else:
#		if member.subduedby.size() == 0:
#			result.text += '[name1] tries to struggle, but [his1] strength is not enough to fight back...\n'
#		else:
#			result.text += "[name1]'s attempts to resist are stopped by being held by [name2]. \n"


	result.text = decoder(result.text, [member], member.subduedby)
	return result

#func resistattempt(member):
#	var result = {text = '', consent = true}
#	var resiststrength = member.person.get_stat('physics_factor')
#	var subdue = 0
#	var resist_chance = 0
#
#	if member.sex_traits.has('doormat') == false:
#		member.person.add_stat('obedience', -1)
#
#	match member.person.get_stat('personality'):
#		'kind':
#			resist_chance = 0.2
#		'bold':
#			resist_chance = 0.9
#		'shy':
#			resist_chance = 0.05
#		'serious':
#			resist_chance = 0.5
#	if member.sex_traits.has("doormat"):
#		resist_chance = 0
#
#	if member.effects.has('tied'):
#		resiststrength = 0
#
#		result.text += '[name1] is powerless to resist, as [his1] limbs are restricted by rope.\n'
#
#	for i in member.subduedby:
#		subdue += i.person.get_stat('physics_factor')
#
#	if resiststrength > subdue && resiststrength != 0:
#		result.consent = false
#		result.text += '[name1] resists the attempt with brute force.\n'
#	else:
#		if member.subduedby.size() == 0:
#			result.text += '[name1] tries to struggle, but [his1] strength is not enough to fight back...\n'
#		else:
#			result.text += "[name1]'s attempts to resist are stopped by being held by [name2]. \n"
#
#
#	result.text = decoder(result.text, [member], member.subduedby)
#	return result


func alcohol(member):
	var text = tr("INTERACTION_ITEM_ALCOHOL") % member.name
	if member.effects.has("drunk") == false && member.effects.has('tipsy') == false:
		member.sensmod += 0.2
		member.hornymod += 0.5
		member.horny += 25
		member.effects.append('drunk')
		text += tr("INTERACTION_ITEM_AROUSAL_EFFECT")
	else:
		text += tr("INTERACTION_ITEM_ALREADY_DRUNK")
	$Panel/sceneeffects.bbcode_text += member.person.translate(text)
	givers = [member]
	_on_passbutton_pressed()

func beer(member):
	var text = tr("INTERACTION_ITEM_BEER") % member.name
	if member.effects.has("drunk") == false && member.effects.has("tipsy") == false:
		member.sensmod += 0.1
		member.hornymod += 0.3
		member.horny += 10
		member.effects.append('tipsy')
		text += tr("INTERACTION_ITEM_AROUSAL_EFFECT")
	else:
		text += tr("INTERACTION_ITEM_ALREADY_DRUNK")
	$Panel/sceneeffects.bbcode_text += member.person.translate(text)
	_on_passbutton_pressed()

func aphrodisiac(member):
	member.horny += 100
	var text = tr("INTERACTION_ITEM_APHRODISIAC") % member.name
	member.effects.append("aphrodisiac")
	input_handler.scene_characters = [member.person]
	$Panel/sceneeffects.bbcode_text += member.person.translate(globals.TextEncoder(text))
	givers = [member]
	_on_passbutton_pressed()


func sensitivity_pot(member):
	member.sensmod += 1
	member.lewdmod += 0.2
	var text = tr("INTERACTION_ITEM_SENSITIVITY_POT") % member.name

	input_handler.scene_characters = [member.person]
	$Panel/sceneeffects.bbcode_text += member.person.translate(globals.TextEncoder(text))
	_on_passbutton_pressed()

func pheromones(member):
	var text = ''
	if member.effects.has('pheromones'):
		text = tr("INTERACTION_ITEM_PHEROMONES_ALREADY") % member.name
	else:
		if member.person.get_stat('race') in races.race_groups.halfbeast + races.race_groups.beast:
			member.effects.append("pheromones")
			member.lewdmod += 1
			member.consent = max(member.consent, 4)
			input_handler.scene_characters = [member.person]
			text = tr("INTERACTION_ITEM_PHEROMONES_SUCCESS") % member.name
		else:
			text = tr("INTERACTION_ITEM_PHEROMONES_FAIL") % member.name

	givers = [member]
	$Panel/sceneeffects.bbcode_text += member.person.translate(text)
	_on_passbutton_pressed()


func record_actions(scenescript, consents):
	scenescript.givers = givers
	scenescript.takers = takers
	for p in participants:
		p.max_ongoing_actions = max(p.max_ongoing_actions, ongoingactions.size())
		if p.orgasm:
			_award_first_orgasm_points(p)
			p.orgasm_actions.append(scenescript.code)
		if p.orgasm && !scenescript.code in p.aphrodisiac_orgasms && p.effects.has("aphrodisiac"):
			p.aphrodisiac_orgasms.append(scenescript.code)
		if p.role == null or p.role == 'none':
			for i in takers + givers:
				if i.orgasm:
					i.orgasm_with_watcher += 1
				if i.orgasm && !i in p.seen_orgasms:
					p.seen_orgasms.append(i)
		if p.role == "give":
			if scenescript.takertags.has("punish"):
				p.punish_actions.append(scenescript.code)
			for t in takers:
				if t.orgasm:
					if p.person.check_trait("undead") || p.person.check_trait("animal"):
						t.deviant_orgasms += 1
					if t.person.get_stat('body_shape') != p.person.get_stat('body_shape'):
						t.diff_body_orgasm += 1
					for tag in scenescript.takertags:
						if !tag in t.orgasm_tags:
							t.orgasm_tags.append(tag)
					for e in t.effects:
						if e in ["tipsy", "drunk"]:
							t.drunk_orgasm += 1
						if !e in t.orgasm_effects:
							t.orgasm_effects.append(e)
					if !p in t.orgasm_partners:
						t.orgasm_partners.append(p)
				if t.orgasm && !p in t.diff_partners_orgasms:
					t.diff_partners_orgasms.append(p)
				if t.orgasm && !t in p.satisfied_partners:
					p.satisfied_partners.append(t)
				if consents[t.id] > 0:
					if t.orgasm:
						t.unconsented_orgasm += 1
				else:
					if scenescript.takertags.has("punish"):
						t.mazo_actions.append(scenescript.code)
					if !scenescript.code in p.single_partner_consents:
						p.single_partner_consents.append(scenescript.code)
#					if p.person.get_stat('sexuals') >= 100 && !scenescript.code in t.bedroom_prodigy:
#						t.bedroom_prodigy.append(scenescript.code)
		if p.role == "take":
			for g in givers:
				if g.orgasm:
					if scenescript.givertags.has("dom"):
						g.dominant += 1
					if p.person.check_trait("undead") || p.person.check_trait("animal"):
						g.deviant_orgasms += 1
					if g.person.get_stat('body_shape') != p.person.get_stat('body_shape'):
						g.diff_body_orgasm += 1
					
					if consents[g.id] > 0:
						if g.orgasm:
							g.unconsented_orgasm += 1
					for tag in scenescript.givertags:
						if !tag in g.orgasm_tags:
							g.orgasm_tags.append(tag)
					for e in g.effects:
						if e in ["tipsy", "drunk"]:
							g.drunk_orgasm += 1
						if !e in g.orgasm_effects:
							g.orgasm_effects.append(e)

	var any_taker_orgasm = false
	for t in takers:
		if t.orgasm:
			any_taker_orgasm = true
			break
	var any_giver_orgasm = false
	for g in givers:
		if g.orgasm:
			any_giver_orgasm = true
			break

	if any_taker_orgasm:
		for g in givers:
			g.gave_orgasm = true
			for skill in scenescript.giver_skill:
				if g.person.statlist.sex_training.get('sex_training_' + skill, 'novice') == 'skilled':
					var progress = g.person.statlist.sex_mastery_progress
					if progress.has(skill) && !scenescript.code in progress[skill]:
						progress[skill].append(scenescript.code)

	if any_giver_orgasm:
		for t in takers:
			t.gave_orgasm = true
			for skill in scenescript.taker_skill:
				if t.person.statlist.sex_training.get('sex_training_' + skill, 'novice') == 'skilled':
					var progress = t.person.statlist.sex_mastery_progress
					if progress.has(skill) && !scenescript.code in progress[skill]:
						progress[skill].append(scenescript.code)

func operate_flag(flag, input1, input2, actor):
	var check = true
	match flag:
		"any":
			for i in input2:
				if i in actor[input1]:
					return check
		"only":
			check = actor[input1].has(input2)
			return check



func check_acquire_reqs(actor, arr):
	if arr.empty():
		var check = false
		return check
	var check = true
	for i in arr:
		if i.has('flag'):
			check =	operate_flag(i.flag, i.type, i.value, actor)
			return check
		if i.has('orflag'):
			check = check or acquire_valuecheck(i, actor)
		else:
			check = check and acquire_valuecheck(i, actor)
	return check

func acquire_valuecheck(r, actor):
	var check = true
	var actor_value
	match r.code:
		'stat':
			if typeof(actor[r.type]) == TYPE_ARRAY:
				actor_value = len(actor[r.type])
			else:
				actor_value = actor[r.type]
			check = input_handler.operate(r.operant, actor_value, r.value)
		'actor_check':
			check = check_acquire_reqs(actor, r.value)
		'same_sex_orgasms':
			actor_value = actor.actionshad.samesexorgasms
			check = input_handler.operate(r.operant, actor_value, r.value)
		'action_type':
			var condition = 0
			for action in actor.orgasm_actions:
				if action in r.value:
					condition += 1
			if condition < 3:
				check = false
	return check

func has_master():
	for i in participants:
		if i.person.has_profession('master'):
			return true

	return false

func get_participant(id):
	for member in participants:
		if member.id == id:
			return member
	assert(false, "no such participant! (%s)" % id)
	print("no such participant! (%s)" % id)
	return null

func make_id_dict(ref_dict):
	var id_dict = {
		id = ref_dict.id,
		scene_code = ref_dict.scene.code,
		takers_ids = [],
		givers_ids = [],
		consents = ref_dict.consents}
	for taker in ref_dict.takers:
		id_dict.takers_ids.append(taker.id)
	for giver in ref_dict.givers:
		id_dict.givers_ids.append(giver.id)
	return id_dict

func make_ref_dict(id_dict):
	var ref_dict = {
		id = id_dict.id,
		scene = globals.get_sex_action(id_dict.scene_code),
		takers = [], givers = [],
		consents = id_dict.consents}
	for member_id in id_dict.takers_ids:
		ref_dict.takers.append(get_participant(member_id))
	for member_id in id_dict.givers_ids:
		ref_dict.givers.append(get_participant(member_id))
	return ref_dict

func is_id_dicts_equal(dist1, dist2):
	if dist1 == null or dist2 == null:
		return false
	return dist1.id == dist2.id

func get_action_dict_id():
	last_action_dict_id += 1
	return last_action_dict_id
