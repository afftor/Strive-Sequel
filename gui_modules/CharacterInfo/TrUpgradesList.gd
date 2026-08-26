extends Control

#The training page. It used to be a tab in the character info window and is now the main page
#of CharacterTrainingPopup, opened off the mansion card. `root` is whoever hosts it and has to
#answer update() - the popup does.
#
#Three mutually exclusive states hang off this node, one per character situation, and hide_all()
#relies on them being its only direct children. Picking a trainer is not a state of its own: the
#picker takes over the left column while a dimmer covers the actions, so the player always sees
#who they are picking for.

var person
var root

var tr_data = {}
var tr_rewards = []

#how much room each state wants from the popup around it
const SIZE_TRAINING = Vector2(1120, 980)
const SIZE_FINISHED = Vector2(860, 860)
const SIZE_SERVANT = Vector2(760, 660)

#the greyed-out look the rest of the mansion uses for an action that cannot be taken
const DISABLED_MATERIAL = preload("res://assets/sfx/bw_shader.tres")

const DISPOSITION_COLORS = {
	weak = 'green',
	kink = 'green',
	neutral = 'yellow',
	resist = 'red',
}

onready var StatusColumn = $training/Status
#the whole trainer card is the button - clicking anywhere on it opens the picker, not just
#the little portrait in its corner
onready var TrainerCard = $training/Status/TrainerCard
onready var TraineeCard = $training/Status/Trainee
onready var LoyaltyBar = $training/Status/Loyalty/spirit
onready var PointsLabel = $training/Status/Points/label
onready var DecayLabel = $training/Status/cd
onready var DispositionList = $training/Status/Dispositions/List
onready var Picker = $training/TrainerPicker
onready var PickerList = $training/TrainerPicker/Scroll/Container
onready var ActionList = $training/Actions/List
onready var Dimmer = $training/Dimmer
onready var EarnedList = $finished/Earned
onready var RewardList = $finished/Rewards

#true while the picker is open over a character who already has a trainer, so cancelling has
#somewhere to go back to
var picking_trainer = false


func _ready():
	gather_data()
	TrainerCard.connect("pressed", self, 'open_trainer_picker')
	Picker.get_node('cancel').connect("pressed", self, 'close_trainer_picker')
	$finished/reset_button.connect("pressed", self, 'reset_training')
	$training_servant/TalkButton.connect("pressed", self, 'open_servant_unlock_dialogue')
	$training_servant/TalkButton.text = tr('SERVANTUNLOCK_TALK_BUTTON')

	globals.connecttexttooltip($training/Status/Tooltip, tr("INFOTRAINING"))
	globals.connecttexttooltip(Picker.get_node('tooltip'), tr("INFOSLAVETRAINER"))
	globals.connecttexttooltip($training/Status/Points/icon, tr("TRAININGPOINTSTOOLTIP"))
	globals.connecttexttooltip($training/Status/Loyalty/icon, tr("LOYALTYTOOLTIP"))
	globals.connecttexttooltip(LoyaltyBar, tr("LOYALTYTOOLTIP"))
	globals.connecttexttooltip(DecayLabel, tr("LOYALTYDECAYTOOLTIP"))
	globals.connecttexttooltip($finished/reset_button, tr("RESETTRAINREQ"))
	Picker.get_node('title').text = tr("TRAINERSAVAILABLE")
	Picker.get_node('cancel').text = tr('CANCEL')
	$training/Status/Dispositions/title.text = tr("TRAININGDISPOSITIONS")

	input_handler.register_btn_source("trainer_select_btn", self, "tut_get_trainer_select")
	input_handler.register_btn_source("praise_btn", self, "tut_get_praise_btn")
	input_handler.register_btn_source("training_bonus_btn", self, "tut_get_training_bonus_btn")


func tut_get_trainer_select():
	for button in PickerList.get_children():
		if button.name != 'Button' and button.visible:
			return button
	return null


#actions are grouped into a section per category, so the button has to be looked up by the code
#it was built for instead of by its place in one flat grid
func tut_get_praise_btn():
	return find_action_button('praise')


func find_action_button(code):
	for section in ActionList.get_children():
		if section.name == 'Section' or !section.has_node('Grid'):
			continue
		for button in section.get_node('Grid').get_children():
			if button.get_meta('code', "") == code:
				return button
	return null


func tut_get_training_bonus_btn():
	for btn in RewardList.get_children():
		if btn.get_meta('trait', "") == "training_productivity":
			return btn
	return null


func hide_all():
	for cat in get_children():
		cat.visible = false


#what the popup should size itself to for whatever is on screen
func desired_size():
	if person == null:
		return SIZE_TRAINING
	if person.get_stat('slave_class') in ['servant', 'servant_notax', 'heir']:
		return SIZE_SERVANT
	if !person.training.enable:
		return SIZE_FINISHED
	return SIZE_TRAINING


func gather_data():
	tr_data.clear()
	for tr in Skilldata.training_actions.values():
		if !globals.checkreqs(tr.reqs):
			continue
		if !tr_data.has(tr.type):
			tr_data[tr.type] = []
		tr_data[tr.type].push_back(tr.code)
	tr_rewards.clear()
	for tr in Traitdata.traits.values():
		if tr.code == 'untrained':
			continue
		if !tr.has('tags'):
			continue
		if tr.tags.has('training_success'):
			tr_rewards.push_back(tr.code)


func match_state():
	if person == null:
		return
	hide_all()
	picking_trainer = false
	if person.get_stat('slave_class') in ['servant', 'servant_notax', 'heir']:
		build_training_servant()
	elif person.training.enable:
		build_training()
	else:
		build_posttrain()


func build_training():
	gather_data()
	$training.visible = true
	build_status_column()
	build_training_list()
	#without a trainer there is nothing to spend a day on, so the picker opens straight away and
	#the actions behind it are dimmed out rather than shown as a wall of disabled buttons
	apply_picker_state(person.get_trainer() == null)


func apply_picker_state(open):
	if open:
		build_trainer_list()
	StatusColumn.visible = !open
	Picker.visible = open
	#the dimmer sits over the action list and swallows the clicks by itself
	Dimmer.visible = open


func open_trainer_picker():
	picking_trainer = person.get_trainer() != null
	apply_picker_state(true)


func close_trainer_picker():
	picking_trainer = false
	root.match_state()


func build_status_column():
	var trainer = person.get_trainer()
	TrainerCard.get_node('icon').texture = trainer.get_icon() if trainer != null else null
	if trainer != null:
		TrainerCard.get_node('name').text = tr("TRAINING_TRAINER_NAME") % trainer.get_full_name()
		var used = trainer.get_trainees().size()
		var amount = trainer.get_stat('trainee_amount')
		TrainerCard.get_node('slots').text = "%d/%d" % [used, amount]
		globals.connecttexttooltip(TrainerCard,
			tr("TRAINING_SLAVES_ASSIGNED") % [trainer.get_full_name(), used, amount]
			+ "\n" + tr("CLICKTOCHANGE"))

	TraineeCard.get_node('icon').texture = person.get_icon()
	TraineeCard.get_node('name').text = person.get_full_name()
	globals.connectslavetooltip(TraineeCard.get_node('icon'), person)

	LoyaltyBar.max_value = 100
	LoyaltyBar.value = person.get_stat('loyalty')
	LoyaltyBar.get_node('percent_label').text = "%d%%" % int(person.get_stat('loyalty'))
	$training/Status/Loyalty/label.text = tr(statdata.statdata.loyalty.name)

	var tp_value = person.get_stat('training_points')
	var tp_cap = person.training.get_training_points_cap()
	PointsLabel.text = tr('TRAININGLABELLOYALTY') % [floor(tp_value), tp_cap]
	PointsLabel.set("custom_colors/font_color", Color(variables.hexcolordict.yellow))

	var decay_grace = person.training.get_loyalty_decay_grace()
	var decay_amount = person.training.get_loyalty_decay_amount()
	var days_left = int(floor(decay_grace)) + 1 - person.training.days_since_training
	if days_left > 0:
		DecayLabel.text = tr('TRAININGDECAYSIN') % [days_left, decay_amount]
		DecayLabel.set("custom_colors/font_color", Color(variables.hexcolordict.yellow))
	else:
		DecayLabel.text = tr('TRAININGDECAYING') % decay_amount
		DecayLabel.set("custom_colors/font_color", Color(variables.hexcolordict.red))

	build_dispositions()


#Dispositions decide which actions are worth doing. They live here, beside the loyalty readout,
#and no longer repeat themselves in the heading of every action section.
func build_dispositions():
	input_handler.ClearContainer(DispositionList, ['record'])
	for category in Skilldata.training_categories:
		if !person.training.dispositions.has(category):
			continue
		var cat_data = Skilldata.training_categories[category]
		var record = input_handler.DuplicateContainerTemplate(DispositionList, 'record')
		record.get_node('cat').text = tr(cat_data.name)
		var label = record.get_node('value')
		if person.training.dispositions_known.get(category, false):
			var value = person.training.dispositions[category]
			label.text = person.training.get_disposition_name(value)
			label.set("custom_colors/font_color", Color(disposition_color(value)))
		else:
			label.text = tr('TRAININGDISPOSITIONUNKNOWN')
			label.set("custom_colors/font_color", Color(variables.hexcolordict.k_gray))


func disposition_color(value):
	if DISPOSITION_COLORS.has(value):
		return variables.hexcolordict[DISPOSITION_COLORS[value]]
	return variables.hexcolordict.yellow


func build_trainer_list():
	Picker.get_node('cancel').visible = picking_trainer
	input_handler.ClearContainer(PickerList, ['Button'])

	if person.get_trainer() != null:
		var panel = input_handler.DuplicateContainerTemplate(PickerList, 'Button')
		panel.get_node('icon').texture = load("res://assets/Textures_v2/MANSION/no.png")
		panel.get_node('name').text = tr('REMOVETRAINER')
		panel.get_node('desc').text = ""
		panel.connect('pressed', self, 'remove_trainer')

	for id in ResourceScripts.game_party.character_order:
		var tchar = characters_pool.get_char_by_id(id)
		if !tchar.can_be_trainer():
			continue
		var amount = tchar.get_stat('trainee_amount')
		var used = tchar.get_trainees().size()
		var panel = input_handler.DuplicateContainerTemplate(PickerList, 'Button')
		panel.get_node('icon').texture = tchar.get_icon()
		globals.connectslavetooltip(panel.get_node('icon'), tchar)
		#the title is the name on its own - the counts and the classes go underneath, or a long
		#name wraps into the line below it and paints over it
		panel.get_node('name').text = tchar.get_full_name()
		globals.connecttexttooltip(panel, tr("TRAINING_SLAVES_ASSIGNED") % [tchar.get_full_name(), used, amount])
		panel.connect('pressed', self, 'assign_trainer', [id])
		var classes = ""
		for prof in tchar.get_professions():
			var data = classesdata.professions[prof]
			if data.traits.has('trainer'):
				classes += "%s, " % tr(data.name)
		var text = tr("TRAINING_TRAINER_SLOTS") % [used, amount]
		if classes != "":
			text += " - " + classes.trim_suffix(', ')
		if used >= amount:
			panel.disabled = true
			panel.get_node('icon').material = load("res://assets/sfx/bw_shader.tres")
			text += "\n" + tr('NOTRAINSLOTS')
		if id == person.training.trainer:
			panel.disabled = true
			panel.get_node('icon').material = load("res://assets/sfx/bw_shader.tres")
			text += "\n" + tr('ALREADYTRAINER')
		panel.get_node('desc').text = text

	Picker.get_node('empty').visible = PickerList.get_child_count() <= 1
	Picker.get_node('empty').text = person.translate(tr('TRAINNOTRAINER'))


func assign_trainer(id):
	var tchar = characters_pool.get_char_by_id(id)
	tchar.add_trainee(person.id)
	root.match_state()


func remove_trainer():
	if person.get_trainer() != null:
		person.clear_training()
	root.match_state()


func build_posttrain():
	$finished.visible = true
	$finished/reset_button.disabled = (ResourceScripts.game_res.if_has_items('oblivion_potion', 'lt', 1))
	var training_points = person.get_stat('training_points')
	var training_points_cap = person.training.get_training_points_cap()
	$finished/status.text = tr('TRAININGLABELLOYALTY') % [training_points, training_points_cap]
	globals.connecttexttooltip($finished/tp_icon, tr("TRAININGPOINTSTOOLTIP"))
	$finished/list.text = tr('TRAININGFINISHHEADER')
	$finished/reset_button/reset.text = tr('TRAINING_RESET_BUTTON')

	input_handler.ClearContainer(EarnedList, ['Button'])
	for tr in person.get_traits_by_tag('training'):
		var trdata = Traitdata.traits[tr]
		var panel = input_handler.DuplicateContainerTemplate(EarnedList, 'Button')
		panel.get_node('icon').texture = load_icon(trdata.icon)
		globals.connecttexttooltip(panel, "[center]" + tr(trdata.name) + "[/center]\n" + person.translate(tr(trdata.descript)))

	$finished/select_text.text = tr('TRAININGBONUSES')
	input_handler.ClearContainer(RewardList, ['Button'])
	for tr in tr_rewards:
		var trdata = Traitdata.traits[tr]
		var panel = input_handler.DuplicateContainerTemplate(RewardList, 'Button')
		panel.get_node('Label').text = str(trdata.cost)
		panel.get_node('icon').texture = load_icon(trdata.icon)
		if person.check_trait(tr):
			panel.pressed = true
			panel.get_node('Label').visible = false
			panel.disabled = true
			panel.texture_disabled = load("res://assets/Textures_v2/CHAR_INFO/loyalty/Assigned trainer/button traits/button_traits_hover.png")
		else:
			panel.pressed = false
			if training_points < trdata.cost:
				panel.disabled = true
				panel.get_node('Label').set("custom_colors/font_color", Color(variables.hexcolordict.k_red))
			else:
				panel.set_meta('trait', tr)
				panel.connect('toggled', self, 'press_trait_post', [tr])
				panel.get_node('Label').set("custom_colors/font_color", Color(variables.hexcolordict.green))
		globals.connecttexttooltip(panel, person.translate(trdata.descript))


func reset_training():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'reset_training_confirm', tr("RESETTRAINING")])


func reset_training_confirm():
	ResourceScripts.game_res.remove_item('oblivion_potion', 1)
	person.reset_training()
	person.try_breakdown('brk_training_reset')
	root.match_state()


const SERVANT_UNLOCK_LIST = [
	{code = 'training_s_working', label = 'SERVANTUNLOCK_WORKING', node = 'working', select_code = 'negotiation_select_working'},
	{code = 'training_s_combat', label = 'SERVANTUNLOCK_COMBAT', node = 'combat', select_code = 'negotiation_select_combat'},
	{code = 'training_s_relation', label = 'SERVANTUNLOCK_DATING', node = 'dating', select_code = 'negotiation_select_dating', extra_reqs = [
		{req = {code = 'stat', stat = 'affection', operant = 'gte', value = 25}, text = 'SERVANTUNLOCK_REQ_AFFECTION'},
	]},
	{code = 'training_s_sexservice', label = 'SERVANTUNLOCK_SEX', node = 'sex', select_code = 'negotiation_select_sex', extra_reqs = [
		{req = {code = 'has_status', status = 'no_sex', check = false}, text = 'SERVANTUNLOCK_REQ_SEX_ACCESS'},
	]},
	{code = 'training_s_sexservice_adv', label = 'SERVANTUNLOCK_SEXSERVICE', node = 'sexservice', select_code = 'negotiation_select_sexservice', extra_reqs = [
		{req = {code = 'stat', stat = 'consent', operant = 'gte', value = 2}, text = 'SERVANTUNLOCK_REQ_CONSENT'},
		{req = {code = 'has_status', status = 'no_sex', check = false}, text = 'SERVANTUNLOCK_REQ_SEX_ACCESS'},
	]},
]


func get_missing_req_texts(entry):
	var texts = []
	for extra_req in entry.get('extra_reqs', []):
		if !person.checkreqs(extra_req.req):
			texts.append(tr(extra_req.text))
	return texts


func build_training_servant():
	$training_servant.visible = true
	$training_servant/title.text = tr('SIBLINGMODULETRAININGSSERVANTS')

	var all_unlocked = true
	for entry in SERVANT_UNLOCK_LIST:
		var row = $training_servant/UnlockList.get_node(entry.node)
		row.get_node('name').text = tr(entry.label)
		var status_label = row.get_node('status')
		if person.check_trait(entry.code):
			status_label.text = tr('SERVANTUNLOCK_UNLOCKED')
			status_label.set("custom_colors/font_color", Color(variables.hexcolordict.green))
		else:
			all_unlocked = false
			status_label.text = tr('SERVANTUNLOCK_LOCKED')
			status_label.set("custom_colors/font_color", Color(variables.hexcolordict.red))
			var missing_texts = get_missing_req_texts(entry)
			if !missing_texts.empty():
				globals.connecttexttooltip(row, PoolStringArray(missing_texts).join("\n"))

	if all_unlocked:
		$training_servant/TalkButton.visible = false
	else:
		$training_servant/TalkButton.visible = true
		if person.training.can_negotiate():
			$training_servant/TalkButton.disabled = false
			$training_servant/TalkButton.text = tr('SERVANTUNLOCK_TALK_BUTTON')
		else:
			$training_servant/TalkButton.disabled = true
			$training_servant/TalkButton.text = tr('SERVANTUNLOCK_TALK_BUTTON_COOLDOWN') % person.training.cooldown.negotiation


func open_servant_unlock_dialogue():
	var options = []
	for entry in SERVANT_UNLOCK_LIST:
		if person.check_trait(entry.code):
			continue
		var option_text = tr(entry.label)
		var reqs = []
		for extra_req in entry.get('extra_reqs', []):
			reqs.append({type = 'active_character_checks', value = [extra_req.req]})
		for missing_text in get_missing_req_texts(entry):
			option_text += " (%s)" % missing_text
		options.append({code = entry.select_code, text = option_text, reqs = reqs, not_hide = true})
	options.append({code = 'close', text = tr('SERVANTUNLOCK_LEAVE'), reqs = []})
	var dialogue_data = {
		text = tr('SERVANTUNLOCK_DIALOGUE_TEXT') % person.get_short_name(),
		image = 'handshake',
		tags = ['custom_effect'],
		options = options,
	}
	input_handler.active_character = person
	input_handler.interactive_message_custom(dialogue_data)


#One section per training category instead of one flat grid of every action there is - the
#categories are what the dispositions are keyed on, so grouping by them is also what the player
#is actually choosing between.
func build_training_list():
	var trainer = person.get_trainer()
	input_handler.ClearContainer(ActionList, ['Section'])
	for category in Skilldata.training_categories:
		if !tr_data.has(category):
			continue
		var codes = []
		for code in tr_data[category]:
			var trdata = Skilldata.training_actions[code]
			if trdata.has('showup_reqs') and trainer != null and !trainer.checkreqs(trdata.showup_reqs):
				continue
			codes.push_back(code)
		if codes.empty():
			continue
		var cat_data = Skilldata.training_categories[category]
		var section = input_handler.DuplicateContainerTemplate(ActionList, 'Section')
		section.get_node('Head/icon').texture = load_icon(cat_data.icon)
		section.get_node('Head/name').text = tr(cat_data.name)
		for code in codes:
			build_action_button(section.get_node('Grid'), code, cat_data, trainer)


func build_action_button(grid, code, cat_data, trainer):
	var trdata = Skilldata.training_actions[code]
	var panel = input_handler.DuplicateContainerTemplate(grid, 'Button')
	panel.set_meta('code', code)
	panel.material = null
	panel.get_node('icon').material = null
	panel.get_node('icon').texture = load_icon(cat_data.icon)
	panel.get_node('name').text = tr(trdata.name)
	panel.get_node('cost').text = cost_text(trdata)
	panel.connect('pressed', self, 'activate_training', [code])
	var text = tr(trdata.name) + "\n" + tr("CATEGORYKEYWORD") + ": {color=yellow|" + tr("ACTIONCATEGORY" + trdata.type.to_upper()) + "}\n" + person.translate(tr(trdata.descript))
	#with no trainer the whole list is dimmed anyway, so it only has to read as unavailable
	if trainer == null:
		panel.disabled = true
		grey_out(panel)
		globals.connecttexttooltip(panel, text)
		return
	#reqs check
	if !trainer.checkreqs(trdata.reqs_trainer):
		panel.disabled = true
		text = "{color=red|" + tr('ACTIONTRAINERREQSNOTMET') + "}\n\n" + text
		grey_out(panel)
		globals.connecttexttooltip(panel, text)
		panel.get_node('name').set("custom_colors/font_color", Color(variables.hexcolordict.red))
	#rebellious slave refuses training right after being acquired
	elif !in_test_mode() and person.training.is_rebel_blocked():
		panel.disabled = true
		text = "{color=red|" + tr('ACTIONREBELBLOCKED') + "}\n\n" + text
		grey_out(panel)
		globals.connecttexttooltip(panel, text)
		panel.get_node('name').set("custom_colors/font_color", Color(variables.hexcolordict.k_gray))
	#avail check
	elif day_is_spent() or (!in_test_mode() and code == 'mindread' and person.training.cooldown.mindread > 0):
		panel.disabled = true
		text = "{color=red|" + tr('ACTIONALREADYDONETODAY') + "}\n\n" + text
		grey_out(panel)
		globals.connecttexttooltip(panel, text)
		panel.get_node('name').set("custom_colors/font_color", Color(variables.hexcolordict.k_gray))
	#cost check
	else:
		var f = true
		for stat in trdata.cost:
			match stat:
				'gold':
					f = f and (ResourceScripts.game_res.money >= trdata.cost[stat])
				'mana':
					f = f and (trainer.mp >= trdata.cost[stat])
		if !f:
			panel.disabled = true
			grey_out(panel)
			globals.connecttexttooltip(panel, tr('COSTNOTMET'))
			panel.get_node('name').set("custom_colors/font_color", Color(variables.hexcolordict.red))
		else:
			globals.connecttexttooltip(panel, text)
			if person.training.dispositions_known.get(trdata.type, false):
				panel.get_node('name').set("custom_colors/font_color", Color(disposition_color(person.training.dispositions[trdata.type])))


func cost_text(trdata):
	var parts = []
	for stat in trdata.cost:
		match stat:
			'gold':
				parts.push_back("%d %s" % [trdata.cost[stat], tr("UPGRADELIST_UNLOCK_GOLD")])
			'mana':
				parts.push_back("%d %s" % [trdata.cost[stat], tr("STATMP")])
	return PoolStringArray(parts).join(", ")


#test mode lifts the daily cooldown and the rebel block. The mansion owns that flag, and this
#page is also built outside it - by the headless checks - so ask rather than dereference.
func in_test_mode():
	return gui_controller.mansion != null and gui_controller.mansion.in_test_mode


#One answer to "is today already gone", used both to grey the actions out and to write the note
#under them. Test mode lifts the limit, and it has to lift the note with it - otherwise the
#panel says the day is spent while every button still works.
func day_is_spent():
	return !in_test_mode() and person.training.cooldown.positive > 0


#Why nothing can be done right now, or "" if something can. The popup shows this in its footer.
func blocking_note():
	if person == null or !person.training.is_slave() or !person.training.enable:
		return ""
	if !in_test_mode() and person.training.is_rebel_blocked():
		return tr('ACTIONREBELBLOCKED')
	if day_is_spent():
		return tr("TRAINCOOLDOWN") % max(int(ceil(person.training.cooldown.positive)), 1)
	if person.get_trainer() == null:
		return person.translate(tr('TRAINNOTRAINER'))
	return ""


func grey_out(panel):
	panel.material = DISABLED_MATERIAL
	panel.get_node('icon').material = DISABLED_MATERIAL


func load_icon(icon):
	if icon is String:
		return load(icon)
	return icon


func activate_training(tr_code):
	var trdata = Skilldata.training_actions[tr_code]
	var trainer = person.get_trainer()
	if trainer == null:
		return
	for stat in trdata.cost:
		match stat:
			'gold':
				ResourceScripts.game_res.money -= trdata.cost[stat]
			'mana':
				trainer.mp -= trdata.cost[stat]
	person.apply_training(tr_code)
	root.update()
	match_state()


var selected_id = ""
func press_trait_post(value, tr_code):
	if !person.check_trait(tr_code):
		selected_id = tr_code
		var data = Traitdata.traits[tr_code]
		var text = tr("UPGRADELIST_UNLOCK") % [str(data.cost), tr("STATTRAINING_POINTS")]
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'learn_upgrade_post_confirmed', text])
	build_posttrain()


func learn_upgrade_post_confirmed():
	if selected_id == "":
		return
	var args = {}
	args["current_trait"] = selected_id
	args["person"] = person
	person.add_training_post(selected_id)
	selected_id = ""
	root.update()
	input_handler.play_animation("trait_aquired", args)
