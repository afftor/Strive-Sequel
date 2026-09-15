extends Panel

const BodyRites = preload("res://src/core/body_rites.gd")

const GOLD = Color(0.976471, 0.882353, 0.505882, 1)
const GREY = Color(0.752941, 0.72549, 0.67451, 1)
const GOOD = Color(0.541176, 0.85098, 0.541176, 1)
const WARNING = Color(0.976471, 0.670588, 0.352941, 1)
const BAD = Color(0.85098, 0.505882, 0.458824, 1)
const UNAFFORDABLE = Color(0.95, 0.35, 0.35, 1)
const MANA_A = Color(0.270588, 0.568627, 0.929412, 1)
const MANA_B = Color(0.352941, 0.690196, 0.968627, 1)
#The part of the points bar the body's upgrades already take, dimmer than this rite's own share.
const POINTS_USED = Color(0.568627, 0.439216, 0.270588, 1)

var view = null
var subject_id = null
var upgrade_code = null
var donor_ids = []
var picker_open = false


func setup(view_node):
	view = view_node
	$CloseButton.connect("pressed", view, "close_body_rites")
	$Body/Columns/Details/Scroll/Content/AddDonor.connect("pressed", self, "toggle_donor_picker")
	$Body/Columns/Details/Scroll/Content/Perform.connect("pressed", self, "perform_rite")
	visible = false


func open():
	subject_id = null
	upgrade_code = null
	donor_ids.clear()
	picker_open = false
	visible = true
	$Body/Columns/Subjects/Scroll.scroll_vertical = 0
	$Body/Columns/Upgrades/Scroll.scroll_vertical = 0
	$Body/Columns/Details/Scroll.scroll_vertical = 0
	rebuild()


func close():
	visible = false
	picker_open = false


func subject():
	return BodyRites.character(subject_id) if subject_id != null else null


#Tooltips go through the view's own Overlay/TextTooltip: this panel sits on the Overlay CanvasLayer,
#and the game's root tooltip would be drawn underneath it.
func tooltip_node():
	return view.get_node("Overlay/TextTooltip")


#An upgrade the subject already carries is not bought again: the details offer to take it back,
#for mana alone, instead of the rite.
func removing(person):
	return person != null and upgrade_code != null and person.get_body_upgrades().has(upgrade_code)


func mana_needed(person):
	if removing(person):
		return BodyRites.removal_mana_cost(upgrade_code)
	return BodyRites.mana_cost(upgrade_code)


func rebuild():
	$Body/Title.text = tr("BODYRITE_TITLE")
	var ids = BodyRites.subjects()
	if subject_id != null and !ids.has(subject_id):
		subject_id = null
	if subject_id != null:
		var offered = BodyRites.donors_for(subject_id)
		for id in donor_ids.duplicate():
			if !offered.has(id):
				donor_ids.erase(id)
	if upgrade_code != null and !BodyRites.upgrade_codes().has(upgrade_code):
		upgrade_code = null
	build_subjects(ids)
	build_upgrades()
	build_details()


func build_subjects(ids):
	var list = $Body/Columns/Subjects/Scroll/List
	input_handler.ClearContainer(list, ['Button'])
	$Body/Columns/Subjects/Header.text = tr("BODYRITE_SUBJECTS")
	$Body/Columns/Subjects/Empty.text = tr("BODYRITE_NO_SUBJECTS")
	$Body/Columns/Subjects/Empty.visible = ids.empty()
	$Body/Columns/Subjects/Scroll.visible = !ids.empty()
	for id in ids:
		var person = BodyRites.character(id)
		if person == null:
			continue
		var row = input_handler.DuplicateContainerTemplate(list, 'Button')
		row.pressed = id == subject_id
		row.get_node("Portrait").texture = portrait_for(person)
		row.get_node("Name").text = person.get_short_name()
		#points in use of the body's whole allowance
		row.get_node("Points").text = tr("BODYRITE_POINTS") + ": " + str(BodyRites.used_points(person)) \
			+ "/" + str(BodyRites.total_points(person))
		row.connect("pressed", self, "select_subject", [id])


func build_upgrades():
	var list = $Body/Columns/Upgrades/Scroll/List
	input_handler.ClearContainer(list, ['Button'])
	$Body/Columns/Upgrades/Header.text = tr("BODYRITE_UPGRADES")
	$Body/Columns/Upgrades/PickSubject.text = tr("BODYRITE_PICK_SUBJECT")
	var person = subject()
	$Body/Columns/Upgrades/PickSubject.visible = person == null
	$Body/Columns/Upgrades/Scroll.visible = person != null
	if person == null:
		return
	for code in BodyRites.upgrade_codes():
		var data = BodyRites.upgrade_data(code)
		var state = BodyRites.state(person, code)
		var row = input_handler.DuplicateContainerTemplate(list, 'Button')
		row.pressed = code == upgrade_code
		row.get_node("Icon").texture = load(data.get('icon', ''))
		row.get_node("Name").text = tr(data.name)
		var state_label = row.get_node("State")
		var price = row.get_node("Price")
		state_label.visible = state != 'open'
		price.visible = state == 'open'
		if state == 'open':
			build_row_price(price, code)
		else:
			state_label.text = upgrade_state_text(state)
			state_label.set("custom_colors/font_color", upgrade_state_color(state))
		row.self_modulate = Color(0.62, 0.62, 0.62, 1) if state in ['owned', 'locked'] \
			else Color(1, 1, 1, 1)
		row.connect("pressed", self, "select_upgrade", [code])


#An open upgrade's price on its row. Gold and mana are shown by their icons, which name themselves
#on hover; the icons pass clicks on to the row.
func build_row_price(price, code):
	price.get_node("Gold").text = str(BodyRites.gold_cost(code))
	price.get_node("Points").text = tr("BODYRITE_POINTS") + " " + str(BodyRites.point_cost(code))
	price.get_node("Mana").text = str(BodyRites.mana_cost(code))
	globals.connecttexttooltip(price.get_node("GoldIcon"), tr("BODYRITE_GOLD"), false, tooltip_node())
	globals.connecttexttooltip(price.get_node("ManaIcon"), tr("BODYRITE_MANA"), false, tooltip_node())


func upgrade_state_text(state):
	match state:
		'owned':
			return tr("BODYRITE_STATE_OWNED")
		'locked':
			return tr("BODYRITE_STATE_LOCKED")
		'no_points':
			return tr("BODYRITE_STATE_NO_POINTS")
	return ""


func upgrade_state_color(state):
	match state:
		'owned':
			return GOOD
		'locked':
			return BAD
		'no_points':
			return WARNING
	return GREY


func build_details():
	var person = subject()
	var valid = person != null and upgrade_code != null
	$Body/Columns/Details/PickUpgrade.text = tr("BODYRITE_PICK_UPGRADE")
	$Body/Columns/Details/PickUpgrade.visible = !valid
	$Body/Columns/Details/Scroll.visible = valid
	if !valid:
		return
	var data = BodyRites.upgrade_data(upgrade_code)
	var taking_back = removing(person)
	var head = $Body/Columns/Details/Scroll/Content/UpgradeHead
	head.get_node("Icon").texture = load(data.get('icon', ''))
	head.get_node("Words/Name").text = tr(data.name)
	head.get_node("Words/Description").text = person.translate(tr(data.descript))
	$Body/Columns/Details/Scroll/Content/PriceHeader.text = tr("BODYRITE_PRICE")
	$Body/Columns/Details/Scroll/Content/RequirementsHeader.text = tr("BODYRITE_REQUIREMENTS")
	$Body/Columns/Details/Scroll/Content/DonorsHeader.text = tr("BODYRITE_DONORS")
	$Body/Columns/Details/Scroll/Content/AddDonor.text = tr("BODYRITE_ADD_DONOR")
	$Body/Columns/Details/Scroll/Content/Perform.text = tr("BODYRITE_REMOVE" if taking_back else "BODYRITE_PERFORM")
	#"Unshape" says on hover what it undoes; the rite's own button needs no hint.
	if taking_back:
		globals.connecttexttooltip($Body/Columns/Details/Scroll/Content/Perform, tr("BODYRITE_REMOVE_TOOLTIP"),
			false, tooltip_node())
	else:
		globals.disconnect_text_tooltip($Body/Columns/Details/Scroll/Content/Perform)
	var valid_donors = BodyRites.valid_donors(person, donor_ids)
	donor_ids = valid_donors
	var mana = mana_needed(person)
	var shares = BodyRites.mana_shares(mana, valid_donors)
	var problems
	if taking_back:
		problems = BodyRites.removal_problems(person, upgrade_code, valid_donors)
	else:
		problems = BodyRites.problems(person, upgrade_code, valid_donors)
	build_price(person, shares, mana, problems, taking_back)
	#The price row has only just become visible on the first selection, so its container width
	#is settled on the following frame. Rebuild the donor segments once more at that width.
	call_deferred("refresh_mana_segments")
	build_requirements(person, problems, taking_back)
	build_donors(shares)
	build_picker()
	$Body/Columns/Details/Scroll/Content/Perform.disabled = !problems.empty()


func build_price(person, shares, mana, problems, taking_back):
	var tiles = $Body/Columns/Details/Scroll/Content/PriceTiles
	#Taking an upgrade back is paid in mana alone, so gold and points have no tile then.
	tiles.get_node("Gold").visible = !taking_back
	tiles.get_node("Points").visible = !taking_back

	var gold = BodyRites.gold_cost(upgrade_code)
	var money = int(ResourceScripts.game_res.money)
	var gold_tile = tiles.get_node("Gold/Body")
	gold_tile.get_node("Title").text = tr("BODYRITE_GOLD")
	gold_tile.get_node("CostRow/Cost").text = str(gold)
	gold_tile.get_node("Available").text = tr("BODYRITE_GOLD") + ": " + str(money)
	gold_tile.get_node("Available").set("custom_colors/font_color", GOOD if money >= gold else UNAFFORDABLE)

	#The bar is the body's whole allowance: first what its upgrades already take, then this rite's cost.
	var cost = BodyRites.point_cost(upgrade_code)
	var total = BodyRites.total_points(person)
	var used = BodyRites.used_points(person)
	var fits = used + cost <= total
	var point_tile = tiles.get_node("Points/Body")
	point_tile.get_node("Title").text = tr("BODYRITE_POINTS")
	point_tile.get_node("Figures").text = str(used + cost) + " / " + str(total)
	point_tile.get_node("Figures").set("custom_colors/font_color", GOOD if fits else UNAFFORDABLE)
	point_tile.get_node("Left").text = tr("BODYRITE_POINTS_LEFT") + ": " + str(total - used - cost)
	point_tile.get_node("Left").set("custom_colors/font_color", GREY if fits else UNAFFORDABLE)
	var whole = max(float(total), 1.0)
	var used_fill = point_tile.get_node("Bar/Used")
	used_fill.anchor_left = 0.0
	used_fill.anchor_right = clamp(used / whole, 0.0, 1.0)
	used_fill.margin_left = 0
	used_fill.margin_right = 0
	used_fill.color = POINTS_USED
	var point_fill = point_tile.get_node("Bar/Fill")
	point_fill.anchor_right = clamp((used + cost) / whole, 0.0, 1.0)
	point_fill.anchor_left = used_fill.anchor_right
	point_fill.margin_left = 0
	point_fill.margin_right = 0
	point_fill.color = WARNING if fits else UNAFFORDABLE
	globals.connecttexttooltip(tiles.get_node("Points"),
		globals._report_text("BODYRITE_POINTS_TOOLTIP", [variables.body_upgrade_points_per_growth_factor]),
		false, tooltip_node())

	var gathered = BodyRites.collected(shares)
	var mana_tile = tiles.get_node("Mana/Body")
	mana_tile.get_node("Title").text = tr("BODYRITE_MANA")
	mana_tile.get_node("Figures").text = tr("BODYRITE_MANA_AVAILABLE") + ": " + str(gathered) + " / " + str(mana)
	mana_tile.get_node("Figures").set("custom_colors/font_color", GOOD if !problems.has('mana') else UNAFFORDABLE)
	mana_tile.get_node("Status").text = tr("BODYRITE_MANA") + ": " + str(mana)
	mana_tile.get_node("Status").set("custom_colors/font_color", GOOD if !problems.has('mana') else BAD)
	build_mana_segments(shares, mana)


func build_mana_segments(shares, cost):
	var segments = $Body/Columns/Details/Scroll/Content/PriceTiles/Mana/Body/Bar/Segments
	input_handler.ClearContainer(segments, ['Segment'])
	var positive = []
	for id in donor_ids:
		if int(shares.get(id, 0)) > 0:
			positive.append(id)
	if positive.empty() or cost <= 0:
		return
	var width = max(1.0, segments.rect_size.x - max(0, positive.size() - 1) * 2.0)
	for index in range(positive.size()):
		var id = positive[index]
		var segment = input_handler.DuplicateContainerTemplate(segments, 'Segment')
		segment.rect_min_size.x = width * float(shares[id]) / float(cost)
		segment.color = MANA_A if index % 2 == 0 else MANA_B


func refresh_mana_segments():
	var person = subject()
	if !visible or person == null or upgrade_code == null:
		return
	var valid_donors = BodyRites.valid_donors(person, donor_ids)
	var cost = mana_needed(person)
	build_mana_segments(BodyRites.mana_shares(cost, valid_donors), cost)


func build_requirements(person, problems, taking_back):
	var list = $Body/Columns/Details/Scroll/Content/Requirements
	input_handler.ClearContainer(list, ['Row'])
	#Taking an upgrade back asks nothing of the body, the points or the gold - only the mana.
	if !taking_back:
		for entry in BodyRites.requirement_rows(person, upgrade_code):
			add_requirement(list, entry.text, entry.met)
		add_requirement(list, tr("BODYRITE_CHECK_POINTS"), !problems.has('points'))
		add_requirement(list, tr("BODYRITE_CHECK_GOLD"), !problems.has('gold'))
	add_requirement(list, tr("BODYRITE_CHECK_MANA"), !problems.has('mana'))


func add_requirement(list, text, met):
	var row = input_handler.DuplicateContainerTemplate(list, 'Row')
	row.get_node("Mark").text = "✓" if met else "×"
	row.get_node("Mark").set("custom_colors/font_color", GOOD if met else BAD)
	row.get_node("Text").text = text
	row.get_node("Text").set("custom_colors/font_color", GOOD if met else BAD)


func build_donors(shares):
	var list = $Body/Columns/Details/Scroll/Content/Donors
	input_handler.ClearContainer(list, ['Row'])
	for id in donor_ids:
		var person = BodyRites.character(id)
		if person == null:
			continue
		var row = input_handler.DuplicateContainerTemplate(list, 'Row')
		var current = BodyRites.mana_of(person)
		var maximum = int(person.get_stat('mpmax'))
		row.get_node("Portrait").texture = portrait_for(person)
		row.get_node("Name").text = person.get_short_name()
		row.get_node("Mana").text = str(current) + " / " + str(maximum)
		row.get_node("Gives").text = tr("BODYRITE_DONOR_GIVES") + ": " + str(shares.get(id, 0))
		var fill = row.get_node("Bar/Fill")
		fill.anchor_right = clamp(float(current) / max(float(maximum), 1.0), 0.0, 1.0)
		fill.margin_right = 0
		row.get_node("Remove").connect("pressed", self, "remove_donor", [id])


func build_picker():
	var picker = $Body/Columns/Details/Scroll/Content/Picker
	var list = picker.get_node("Scroll/List")
	input_handler.ClearContainer(list, ['Button'])
	picker.visible = picker_open
	if !picker_open:
		return
	var offered = 0
	for id in BodyRites.donors_for(subject_id):
		if donor_ids.has(id):
			continue
		var person = BodyRites.character(id)
		if person == null:
			continue
		var row = input_handler.DuplicateContainerTemplate(list, 'Button')
		var current = BodyRites.mana_of(person)
		var maximum = int(person.get_stat('mpmax'))
		row.get_node("Portrait").texture = portrait_for(person)
		row.get_node("Name").text = person.get_short_name()
		row.get_node("Mana").text = str(current) + " / " + str(maximum)
		row.disabled = current <= 0
		row.self_modulate = Color(0.45, 0.45, 0.45, 1) if row.disabled else Color(1, 1, 1, 1)
		if !row.disabled:
			row.connect("pressed", self, "add_donor", [id])
		offered += 1
	picker.get_node("Empty").text = tr("BODYRITE_NO_DONORS")
	picker.get_node("Empty").visible = offered == 0
	picker.get_node("Scroll").visible = offered > 0


func portrait_for(person):
	var portrait = person.get_icon()
	if portrait == null:
		portrait = person.get_class_icon()
	input_handler.queue_portrait(person)
	return portrait


func select_subject(id):
	if !BodyRites.subjects().has(id):
		return
	subject_id = id
	donor_ids.erase(id)
	picker_open = false
	rebuild()


func select_upgrade(code):
	if subject() == null or !BodyRites.upgrade_codes().has(code):
		return
	upgrade_code = code
	picker_open = false
	rebuild()


func toggle_donor_picker():
	if subject() == null or upgrade_code == null:
		return
	picker_open = !picker_open
	rebuild()


func add_donor(id):
	if subject() == null or donor_ids.has(id) or !BodyRites.donors_for(subject_id).has(id):
		return
	var person = BodyRites.character(id)
	if person == null or BodyRites.mana_of(person) <= 0:
		return
	donor_ids.append(id)
	rebuild()


func remove_donor(id):
	donor_ids.erase(id)
	rebuild()


#The rite, or taking the upgrade back when the subject already carries it. A rite that went through
#plays the upgrade animation (on a layer above this panel - see ANIM_CLASS_ACHIEVED in ResourceScripts).
func perform_rite():
	var person = subject()
	if person == null or upgrade_code == null:
		return
	var code = upgrade_code
	if removing(person):
		if !BodyRites.remove(person, code, donor_ids):
			rebuild()
			return
		input_handler.SystemMessage(tr("BODYRITE_REMOVED"))
	else:
		if !BodyRites.perform(person, code, donor_ids):
			rebuild()
			return
		input_handler.play_animation("body_upgrade", {upgrade = code, person = person})
	if input_handler.has_method("update_slave_list"):
		input_handler.update_slave_list()
	rebuild()
