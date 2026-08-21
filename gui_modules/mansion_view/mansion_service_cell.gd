extends Button
#One person on a task screen, on one of its two lists: already on the work, or free to be put
#on it. Which list decides what a click does - take them off, or put them on - so the same
#cell serves both and there is one place where either can go wrong.
#
#Service is the exception with something more to say: what its people are allowed to do. Those
#rules are the work panel's own, so clicking somebody on service opens that panel on them
#rather than a second copy of it - see mansion_service_panel.gd.

#The same yellow a picked-up room and a picked-up person wear. It has to be drawn in front of
#the button rather than behind it: the button's own style is a 92%-opaque dark box, so a mark
#behind it is a mark nobody can see - which is exactly how this shipped the first time.
const COLOR_SELECTED = Color(0.976, 0.882, 0.505, 0.20)

var view = null
var panel = null
var char_id = null
#true on the list of people already doing the work
var assigned = false


func setup(view_node, character, task_panel, on_task):
	view = view_node
	char_id = character
	panel = task_panel
	assigned = on_task
	if !is_connected("pressed", self, "on_pressed"):
		connect("pressed", self, "on_pressed")
	if !$Remove.is_connected("pressed", self, "on_remove"):
		$Remove.connect("pressed", self, "on_remove")
	refresh()


func refresh():
	var person = view.get_character(char_id)
	if person == null:
		return
	$icon.texture = person.get_icon()
	if $icon.texture == null:
		$icon.texture = person.get_class_icon()
	input_handler.queue_portrait(person)
	#What they have agreed to sits beside the name: it is the ceiling on everything the rules
	#below can ask of them, so it belongs where the name is rather than three clicks away.
	$name.text = "%s - %s" % [person.get_short_name(), consent_label(person)]
	$rules.text = subtitle(person)
	#whose rules are open, so the panel beside the list is tied to a name in it
	$bg.color = COLOR_SELECTED if panel.selected_char() == char_id else Color(1, 1, 1, 0)
	#On service the cell itself opens the rules, so taking somebody off the work needs a
	#control of its own; on every other task it is the same thing the cell already does, kept
	#so the way off a task is in one place wherever it is looked for.
	$Remove.visible = assigned
	globals.connecttexttooltip($Remove, tr("MANSIONVIEW_TASKREMOVEHINT"), true,
		view.get_node("Overlay/TextTooltip"))
	modulate = Color(1, 1, 1, 1) if blocked_reason() == "" else Color(1, 0.45, 0.45)
	globals.connecttexttooltip(self, tooltip_text(person), true,
		view.get_node("Overlay/TextTooltip"))


#On service the line under the name is what they are allowed to do; anywhere else it is what
#stands between them and the work, or nothing at all.
func consent_label(person):
	var level = int(person.get_stat('consent'))
	if !variables.consent_dict.has(level):
		level = int(clamp(level, 0, variables.consent_dict.keys().max()))
	return tr(variables.consent_dict[level])


func subtitle(person):
	if panel.is_service() and assigned:
		return rules_summary(person)
	var blocked = blocked_reason()
	return tr(blocked) if blocked != "" else ""


#What they are allowed to do, and what that is expected to be worth. Who their clients are
#is set on the rules panel but not repeated here: it is not a thing they do, and three more
#words on every line pushed the acts themselves off the end of it.
#Which acts are which is the rules panel's own list - written here as well, the two drifted
#the moment one of them gained an act.
const Rules = preload("res://gui_modules/mansion_view/mansion_service_panel.gd")


func rules_summary(person):
	var allowed = []
	for rule in variables.brothel_rules:
		if rule in Rules.SEXES:
			continue
		if person.check_brothel_rule(rule):
			allowed.append(tr("BROTHEL" + rule.to_upper()))
	if allowed.empty():
		return tr("MANSIONVIEW_SERVICENORULES")
	#Earnings first: this line is one line tall and wraps away, and what somebody is worth is
	#the thing being weighed when deciding who to put on service.
	return "%s - %s" % [earnings_line(person), PoolStringArray(allowed).join(", ")]


#The same figure the rules panel prints, on whichever of the two counts applies: somebody set
#to sexual work is paid for that, somebody waiting tables for that.
func earnings_line(person):
	var sexual = false
	for rule in Rules.SEXUAL:
		if person.check_brothel_rule(rule):
			sexual = true
	var value = person.get_estimated_service_value() if sexual 		else person.get_estimated_non_sex_service_value()
	return tr("MANSIONVIEW_SERVICEEARNS") % str(stepify(value, 0.1))


#The same question the work itself asks before refusing, asked here so the refusal is read off
#the name rather than after clicking it.
func blocked_reason():
	var person = view.get_character(char_id)
	if person == null or assigned:
		return ""
	if !person.is_worker():
		if person.get_stat('slave_class') == 'slave':
			return "MANSIONVIEW_ERR_NOTRAINER"
		return "MANSIONVIEW_ERR_NOTWORKER"
	if !view.person_is_here(person):
		return "MANSIONVIEW_ERR_AWAY"
	return ""


func tooltip_text(person):
	var blocked = blocked_reason()
	if blocked != "":
		return "%s\n%s" % [person.get_short_name(), tr(blocked)]
	if assigned:
		return "%s\n%s" % [person.get_short_name(),
			tr("MANSIONVIEW_SERVICERULESHINT" if panel.is_service() else "MANSIONVIEW_TASKREMOVEHINT")]
	return "%s\n%s" % [person.get_short_name(), tr("MANSIONVIEW_TASKADDHINT")]


func on_remove():
	panel.remove_worker(char_id)


func on_pressed():
	if !assigned:
		var blocked = blocked_reason()
		if blocked != "":
			input_handler.SystemMessage(tr(blocked))
			return
		panel.add_worker(char_id)
		return
	#already on it: service opens their rules, everything else takes them off
	if panel.is_service():
		panel.open_rules(char_id)
	else:
		panel.remove_worker(char_id)


#### the carrying protocol ####

func carry_data():
	if char_id == null:
		return null
	return {kind = 'mansion_char', char_id = char_id,
		from_slot = panel.entry.id if assigned else null, from_kind = 'work'}


func carry_refusal():
	return blocked_reason()


func carry_texture():
	return $icon.texture


func get_drag_data(_position):
	return view.begin_carry_drag(self)
