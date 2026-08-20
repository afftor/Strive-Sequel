extends Panel
#The screen behind a piece of work: everybody on it on the left, everybody who could be on it
#on the right, and a click to move somebody either way.
#
#It started as the service trade's own screen, because service takes as many as you send and
#the interesting part is what each of them is allowed to do. It turned out to be the better
#way to fill anything: a row of 34px places on a card is a small target to drag onto and says
#nothing about who is available, while this names them.
#
#Service keeps one thing of its own - the rules. Those live in the work panel
#(Mansion/Scripts/MansionJobModule.gd show_brothel_options), a hundred and fifty lines of
#per-character conditions about consent, training and boosters, and a second copy would be
#wrong within a week. Clicking somebody on service opens that panel on them.

const LocationTasks = preload("res://gui_modules/mansion_view/mansion_location_tasks.gd")

var view = null
var entry = null


func setup(view_node):
	view = view_node
	visible = false
	$CloseButton.connect("pressed", self, "close")
	rules_setup(view_node)


func open(task_entry):
	entry = task_entry
	visible = true
	rebuild()


func close():
	visible = false
	entry = null
	rules_close()


func is_service():
	return entry != null and entry.own_screen


#Whose rules are open, so the list can show which of them is being looked at.
func selected_char():
	return char_id if $Rules.visible else null


func workers():
	return LocationTasks.workers_of(entry.id) if entry != null else []


func rebuild():
	if !visible or entry == null:
		return
	$Title.text = tr(entry.name)
	#the list is under the screen's own title and needs no second heading over it
	$OnTaskLabel.visible = false
	var ids = workers()
	$Empty.text = tr("MANSIONVIEW_TASKEMPTY")
	$Empty.visible = ids.empty()
	input_handler.ClearContainer($Scroll/List)
	for char_id in ids:
		var cell = input_handler.DuplicateContainerTemplate($Scroll/List)
		cell.setup(view, char_id, self, true)
	rules_rebuild()


func add_worker(char_id):
	view.place_character('task', entry.id, char_id, null)
	rebuild()


func remove_worker(char_id):
	view.release_character(char_id, 'work')
	rules_close()
	rebuild()


#Clicking somebody opens what they are allowed to do, beside the list rather than instead of
#it - the point of the screen is setting one person's rules while seeing the rest.
func open_rules(char_id):
	rules_open(char_id)
	rebuild()


#### the carrying protocol ####

#Somebody let go over the screen joins the work, the same as dropping them on its card.
func refusal_for(data):
	if entry == null or !(data is Dictionary) or data.get('kind', '') != 'mansion_char':
		return 'MANSIONVIEW_ERR_VOID'
	#already on it: nothing to do, and nothing worth saying about it either
	if workers().has(data.char_id):
		return 'MANSIONVIEW_ERR_VOID'
	return ''


func take_carried(data):
	add_worker(data.char_id)
	return true


func can_drop_data(_position, data):
	return refusal_for(data) == ''


func drop_data(_position, data):
	take_carried(data)


#### what one person on service is allowed to do ####

const NON_SEX = ['waitress', 'hostess', 'dancer', 'stripper']
const SEXUAL = ['petting', 'oral', 'anal', 'pussy', 'penetration', 'group', 'sextoy']
const SEXES = ['males', 'females', 'futa']

#whose rules are open, or null when the rules half is shut
var char_id = null


func rules_setup(_view_node):
	$Rules.visible = false
	#No close button of its own: the rules open beside the list rather than over it, so the
	#screen's own close is the only one that means anything - a second one on the inner panel
	#read as "close the screen" and shut the wrong thing.
	#the two explanations the work panel carries beside the same two blocks
	#(Mansion/Scripts/MansionJobModule.gd:17 and :28), on the same keys
	globals.connecttexttooltip($Rules/RulesTip, tr("BROTHELTOOLTIP"), false,
		view.get_node("Overlay/TextTooltip"))
	globals.connecttexttooltip($Rules/Boosters/BoostersTip, tr("SERVICEBOOSTTOOLTIP"), false,
		view.get_node("Overlay/TextTooltip"))


func rules_open(character):
	char_id = character
	$Rules.visible = true
	rules_rebuild()


func rules_close():
	$Rules.visible = false
	char_id = null


func rules_person():
	return view.get_character(char_id) if char_id != null else null


func rules_rebuild():
	var who = rules_person()
	if !$Rules.visible or who == null:
		$Rules.visible = false
		return
	$Rules/Title.text = who.get_short_name()
	input_handler.ClearContainer($Rules/Scroll/Content/Rules)
	for rule in NON_SEX:
		add_rule(who, rule, false)
	for rule in SEXUAL:
		if !offers_rule(who, rule):
			continue
		add_rule(who, rule, true)
	for rule in SEXES:
		add_rule(who, rule, false)
	build_boosters(who)
	update_summary(who)


#The acts this person is not asked about at all: nothing to buy them with, or nothing to do
#it with. Same conditions the work panel hides them under.
func offers_rule(who, rule):
	if rule == 'sextoy' and !who.has_profession('sextoy'):
		return false
	if rule == 'pussy' and who.get_stat('has_womb') == false:
		return false
	if rule == 'penetration' and who.get_stat('penis_size') == '':
		return false
	return true


func add_rule(who, rule, sexual):
	var button = input_handler.DuplicateContainerTemplate($Rules/Scroll/Content/Rules)
	button.text = rule_label(who, rule)
	button.pressed = who.check_brothel_rule(rule)
	button.connect('pressed', self, 'switch_rule', [button, rule])
	var text = tr("BROTHEL" + rule.to_upper() + "DESCRIPT")
	if !sexual:
		#marked so the summary can grey these out once sexual work is on
		if rule in NON_SEX:
			button.set_meta('non_sex', true)
		set_rule_tooltip(button, who, text)
		return
	text += "\n" + tr("BROTHELMINCONSENT") % tr(variables.consent_dict[
		tasks.gold_tasks_data[rule].min_consent])
	#refusals first: somebody who will not do it at all is not asked to
	if who.has_status('no_sex'):
		button.disabled = true
		text = "[name] " + tr("REFUSE_TO_WHORE_LABEL")
	elif who.has_status('no_whoring'):
		button.disabled = true
		text = "[name] " + tr("REFUSE_THIS_TASK_LABEL")
	elif !who.has_status('sexservice'):
		button.disabled = true
		text += "\n" + tr("LACKSEXTRAINING")
	elif who.get_stat('consent') < tasks.gold_tasks_data[rule].min_consent:
		#allowed to set it, but they are being pushed past what they have agreed to
		for state in ['font_color', 'font_color_pressed', 'font_color_hover',
				'font_color_hover_pressed', 'font_color_disabled']:
			button.set("custom_colors/" + state, variables.hexcolordict['red'])
	set_rule_tooltip(button, who, text)


#Every one of these strings carries the game's own [name]/[his] tags, and the pieces added
#last carried them furthest: LACKSEXTRAINING has "[name]" written into the localization and
#reached the screen with the brackets still on it. Standing one substitution at the door,
#after the text is finished, is the only arrangement nobody can forget half of.
func set_rule_tooltip(button, who, text):
	globals.connecttexttooltip(button, who.translate(text), false,
		view.get_node("Overlay/TextTooltip"))


#Trained acts wear their level as stars, the way the work panel writes them.
func rule_label(who, rule):
	var label = tr("BROTHEL" + rule.to_upper())
	if who.get_stat('sex') == "male" and tasks.gold_tasks_data.has(rule) \
			and tasks.gold_tasks_data[rule].tags.has('has_alt_name'):
		label = tr("BROTHEL" + rule.to_upper() + "ALT")
	if rule in ['petting', 'oral', 'pussy', 'anal', 'penetration']:
		match who.get_stat('sex_training_' + rule):
			'skilled':
				label += " ★"
			'mastered':
				label += " ★★"
	return label


func switch_rule(button, rule):
	rules_person().set_brothel_rule(rule, button.pressed)
	update_summary(rules_person())
	#the list behind shows what everyone is allowed to do, and one of them just changed
	rules_rebuild()


#What all the ticks add up to, in the same words and the same order the work panel says it -
#including the warning about sex work with no clients chosen, which is the mistake worth
#catching. The markup is the game's own, so it goes through TextEncoder like everywhere else.
func update_summary(who):
	var sexual = false
	var penetrative = false
	var pregnancy = false
	for rule in SEXUAL:
		if !who.check_brothel_rule(rule):
			continue
		sexual = true
		if rule in ['anal', 'pussy', 'group', 'sextoy']:
			penetrative = true
			if rule != 'anal' and who.get_stat('has_womb') == true:
				pregnancy = true
	var text = ""
	if who.get_work() == '':
		text = "{color=yellow|" + tr("SERVICEREST") + "}"
	elif sexual and penetrative:
		text = "{color=pink|" + tr("SERVICESEXUALPENETRATIVE") + "}"
		if pregnancy:
			text += "\n{color=pink|" + tr("SERVICEPREGNANT") + "}"
	elif sexual:
		text = "{color=pink|" + tr("SERVICESEXUALNONPENETRATIVE") + "}"
	else:
		text = "{color=green|" + tr("SERVICENOSEX") + "}"
	if sexual:
		var has_clients = false
		for sex in SEXES:
			if who.check_brothel_rule(sex):
				has_clients = true
		if !has_clients:
			text += "\n\n{color=red|" + tr("BROTHELWARNING") + "}"
		text += "\n\n{color=aqua|" + tr("SERVICEDESIRABILITY") \
			% str(round(who.get_service_desirability())) + "}"
		text += "\n{color=aqua|" + tr("SERVICEESTVALUE") \
			% str(stepify(who.get_estimated_service_value(), 0.1)) + "}"
	else:
		var any_non_sex = false
		for rule in NON_SEX:
			if who.check_brothel_rule(rule):
				any_non_sex = true
		if any_non_sex:
			text += "\n\n{color=aqua|" + tr("SERVICEDESIRABILITYVALUE") \
				% str(round(who.get_stat('desirability'))) + "}"
			text += "\n{color=aqua|" + tr("SERVICEESTVALUE") \
				% str(stepify(who.get_estimated_non_sex_service_value(), 0.1)) + "}"
	$Rules/Scroll/Content/Summary.bbcode_text = globals.TextEncoder(who.translate(text))
	#serving and sleeping with clients are not done at once, the way the work panel has it
	for box in $Rules/Scroll/Content/Rules.get_children():
		if box.visible and box.has_meta('non_sex') and !box.disabled:
			box.disabled = sexual


#Three tiers of booster, each a material spent per turn for a share more work. Buying one
#implies the cheaper ones and dropping one drops the dearer, which is the rule the work panel
#enforces and the reason these are not three independent switches.
func build_boosters(who):
	input_handler.ClearContainer($Rules/Boosters/List)
	var boosters = who.xp_module.service_boosters
	for id in range(1, 4):
		var button = input_handler.DuplicateContainerTemplate($Rules/Boosters/List)
		var boost = boosters['boost%d' % id]
		var material = Items.materiallist[boost.res]
		button.get_node('icon').texture = material.icon
		var text = "%s (%d): %d00%%" % [tr(material.name),
			int(ResourceScripts.game_res.materials[boost.res]), variables.booster_value[id - 1]]
		if boost.value:
			text += " - " + tr("FARMACTIVATED")
		button.get_node('Label').text = text
		button.pressed = boost.value
		globals.connectmaterialtooltip(button, material, '', null,
			view.get_node("Overlay/ItemTooltip"))
		button.connect('pressed', self, 'switch_booster', [id, !boost.value])


func switch_booster(id, value, rebuild = true):
	var boosters = rules_person().xp_module.service_boosters
	boosters['boost%d' % id].value = value
	if value and id > 1:
		switch_booster(id - 1, true, false)
	if !value and id < 3:
		switch_booster(id + 1, false, false)
	if rebuild:
		build_boosters(rules_person())
