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
#Air left around the two bodies when the before-and-after shots are cut down to them.
const SHOT_MARGIN = 12
const CLEAR = Color(1, 1, 1, 0)
const WHITE = Color(1, 1, 1, 1)
#The new body comes out of a flash brighter than white, at this many seconds into the entrance.
const FLASH = Color(2.2, 2.2, 2.2, 1)
const FLASH_AT = 1.1
#How a rite plays out (play_rite): the rite's mana drains out of its bar over DRAIN_TIME, then the veil fades
#in over VEIL_TIME.
const VEIL_TIME = 0.5
const DRAIN_TIME = 1.2
#Motes of the mana fly from the donors' tiles into the rite's head while it drains (plan_motes): how long one flies,
#how far its curve bows out, its radius, how many fading echoes trail it and how far apart in its flight, and how
#many a donor sends - so many per point of mana it gives, never fewer than MOTES_MIN nor more than MOTES_MAX.
const MOTE_FLIGHT = 0.55
const MOTE_BOW = 90.0
const MOTE_RADIUS = 5.0
const MOTE_TRAIL = 2
const MOTE_TRAIL_STEP = 0.05
const MOTES_PER_MANA = 1.0
const MOTES_MIN = 8
const MOTES_MAX = 24
#The head's gold as the motes land (draw_head_charge): how strong it lies under the words, and how wide the bright
#edge where it is rising.
const CHARGE_ALPHA = 0.38
const CHARGE_EDGE = 3.0
#The dialogue scenes telling what a rite did (scenedata.gd); an upgrade, or one taken back, gets the common one.
const UPGRADE_SCENE = 'body_rite_upgrade'
const RITE_SCENES = {sex_change = 'body_rite_sex_change', form_change = 'body_rite_form_change', virginity = 'body_rite_virginity',
	personality = 'body_rite_personality'}

var view = null
var subject_id = null
var upgrade_code = null
var donor_ids = []
#whose name the before-and-after window offers to change - only after a sex change
var renaming_id = null
#who Body modifications opens on once the appearance change's scene is closed - that rite alone opens it
var customizing_id = null
#that appearance change while Body modifications is open - its old body's shot and its title - for the
#before-and-after window shown when that window closes (customization_closed)
var customizing_rite = null
#the rite being played out, from the press until its dialogue scene is closed - see play_rite()
var pending_rite = null
var rite_input_locked = false
#what a rite's drain moves, per donor in the order it goes - see drain_mana()
var drain_plan = []
var drain_cost = 0
#the motes that drain sends, how far it has got, and how full of gold the rite's head is - see plan_motes()
var motes = []
var drain_elapsed = 0.0
var head_charge = 0.0


func setup(view_node):
	view = view_node
	$CloseButton.connect("pressed", view, "close_body_rites")
	perform_button().connect("pressed", self, "perform_rite")
	$SexChangeResult/Window/Body/CloseButton.connect("pressed", self, "offer_new_name")
	$SexChangeResult/NamePrompt/Body/Buttons/Rename.connect("pressed", self, "confirm_new_name")
	$SexChangeResult/NamePrompt/Body/Buttons/Keep.connect("pressed", self, "keep_name")
	$SexChangeResult/NamePrompt/Body/NameEdit.connect("text_entered", self, "confirm_new_name")
	#the booth renders only while a shot is taken - see sprite_of()
	$SexChangeBooth.render_target_update_mode = Viewport.UPDATE_DISABLED
	#and its doll never moves: inside a Viewport it counts as seen, so an idling doll would solve its skin
	#every frame for a picture nobody is taking
	$SexChangeBooth/Doll.animated = false
	#while a rite drains, its head fills with gold and motes of its mana fly into it - see drain_step()
	$Body/Columns/Details/Scroll/Content/UpgradeHead.connect("draw", self, "draw_head_charge")
	if has_node("RiteParticles"):
		$RiteParticles.connect("draw", self, "draw_motes")
	visible = false


func open():
	subject_id = null
	upgrade_code = null
	donor_ids.clear()
	$SexChangeResult.visible = false
	visible = true
	$Body/Columns/Subjects/Scroll.scroll_vertical = 0
	$Body/Columns/Upgrades/Scroll.scroll_vertical = 0
	$Body/Columns/Details/Scroll.scroll_vertical = 0
	rebuild()


func close():
	visible = false
	customizing_id = null
	customizing_rite = null
	clear_charge()
	$SexChangeResult.visible = false


#A rite cut off half-way - the game loaded or left for the menu while its scene was up - must not leave the
#controls locked, nor the dialogue parked where the next event would not find it (park_dialogue).
func _exit_tree():
	lock_rite_input(false)
	var dialogue = gui_controller.dialogue
	if pending_rite != null and dialogue != null and is_instance_valid(dialogue):
		var layer = input_handler.get_spec_node_parent(input_handler.ANIM_CLASS_ACHIEVED)
		if dialogue.get_parent() == layer:
			layer.call_deferred("remove_child", dialogue)
			get_tree().get_root().call_deferred("add_child", dialogue)
	pending_rite = null



func subject():
	return BodyRites.character(subject_id) if subject_id != null else null


#Tooltips go through the view's own Overlay/TextTooltip: this panel sits on the Overlay CanvasLayer,
#and the game's root tooltip would be drawn underneath it.
func tooltip_node():
	return view.get_node("Overlay/TextTooltip")


#Perform stands under the details' scroll rather than in it, so a long list of donors cannot push it out of
#sight.
func perform_button():
	return $Body/Columns/Details/Perform


#The appearance, sex and form changes and the virginity restoration are listed above the upgrades, but they
#are rites of their own (see body_rites.gd).
func rite_chosen():
	return BodyRites.is_rite(upgrade_code)


#What can be chosen in the middle column: one of the rites or one of the body upgrades.
func known_code(code):
	return BodyRites.is_rite(code) or BodyRites.upgrade_codes().has(code)


#An upgrade the subject already carries is not bought again: the details offer to take it back,
#for mana alone, instead of the rite.
func removing(person):
	return person != null and upgrade_code != null and person.get_body_upgrades().has(upgrade_code)


func mana_needed(person):
	if rite_chosen():
		return BodyRites.rite_mana(upgrade_code)
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
	if upgrade_code != null and !known_code(upgrade_code):
		upgrade_code = null
	#a rite this subject is not offered - the virginity restoration of somebody just made male - is let go
	if rite_chosen() and (subject() == null or !BodyRites.rites_for(subject()).has(upgrade_code)):
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
	for code in BodyRites.rites_for(person):
		build_rite_row(list, person, code)
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
		row.self_modulate = Color(0.62, 0.62, 0.62, 1) if state in ['sealed', 'owned', 'locked'] \
			else Color(1, 1, 1, 1)
		row.connect("pressed", self, "select_upgrade", [code])


#The rites head the list: never owned, locked only when the body does not meet what they ask. Their price
#row has gold and mana but no upgrade points.
func build_rite_row(list, person, code):
	var allowed = BodyRites.rite_open(person, code)
	var row = input_handler.DuplicateContainerTemplate(list, 'Button')
	row.pressed = code == upgrade_code
	row.get_node("Icon").texture = rite_icon(person, code)
	row.get_node("Name").text = tr(BodyRites.rite_name_key(person, code))
	var state_label = row.get_node("State")
	var price = row.get_node("Price")
	state_label.visible = !allowed
	price.visible = allowed
	if allowed:
		price.get_node("Gold").text = str(BodyRites.rite_gold(code))
		price.get_node("Mana").text = str(BodyRites.rite_mana(code))
		price.get_node("Dot2").visible = false
		price.get_node("Points").visible = false
		connect_price_tooltips(price)
	else:
		state_label.text = tr("BODYRITE_STATE_LOCKED")
		state_label.set("custom_colors/font_color", BAD)
	row.self_modulate = Color(1, 1, 1, 1) if allowed else Color(0.62, 0.62, 0.62, 1)
	row.connect("pressed", self, "select_upgrade", [code])


func rite_icon(person, code):
	var icon = BodyRites.rite_icon(person, code)
	if icon is String:
		return load(icon) if icon != '' else null
	return icon


#An open upgrade's price on its row.
func build_row_price(price, code):
	price.get_node("Gold").text = str(BodyRites.gold_cost(code))
	price.get_node("Points").text = tr("BODYRITE_POINTS") + " " + str(BodyRites.point_cost(code))
	price.get_node("Mana").text = str(BodyRites.mana_cost(code))
	connect_price_tooltips(price)


#Gold and mana are shown by their icons, which name themselves on hover; the icons pass clicks on
#to the row.
func connect_price_tooltips(price):
	globals.connecttexttooltip(price.get_node("GoldIcon"), tr("BODYRITE_GOLD"), false, tooltip_node())
	globals.connecttexttooltip(price.get_node("ManaIcon"), tr("BODYRITE_MANA"), false, tooltip_node())


func upgrade_state_text(state):
	match state:
		'sealed':
			return tr("BODYRITE_STATE_SEALED")
		'owned':
			return tr("BODYRITE_STATE_OWNED")
		'locked':
			return tr("BODYRITE_STATE_LOCKED")
		'no_points':
			return tr("BODYRITE_STATE_NO_POINTS")
	return ""


func upgrade_state_color(state):
	match state:
		'sealed':
			return BAD
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
	perform_button().visible = valid
	if !valid:
		return
	var rite = rite_chosen()
	var taking_back = removing(person)
	var head = $Body/Columns/Details/Scroll/Content/UpgradeHead
	#a rite played out leaves the head full of gold until the panel is built again after it
	if pending_rite == null:
		clear_charge()
	if rite:
		head.get_node("Icon").texture = rite_icon(person, upgrade_code)
		head.get_node("Words/Name").text = tr(BodyRites.rite_name_key(person, upgrade_code))
		head.get_node("Words/Description").text = person.translate(tr(BodyRites.rite_descript_key(person, upgrade_code)))
	else:
		var data = BodyRites.upgrade_data(upgrade_code)
		head.get_node("Icon").texture = load(data.get('icon', ''))
		head.get_node("Words/Name").text = tr(data.name)
		head.get_node("Words/Description").text = person.translate(tr(data.descript))
	$Body/Columns/Details/Scroll/Content/PriceHeader.text = tr("BODYRITE_PRICE")
	$Body/Columns/Details/Scroll/Content/RequirementsHeader.text = tr("BODYRITE_REQUIREMENTS")
	$Body/Columns/Details/Scroll/Content/DonorsHeader.text = tr("BODYRITE_DONORS")
	var perform = perform_button()
	perform.text = tr("BODYRITE_REMOVE" if taking_back else "BODYRITE_PERFORM")
	#"Unshape" says on hover what it undoes; the rite's own button needs no hint.
	if taking_back:
		globals.connecttexttooltip(perform, person.translate(tr("BODYRITE_REMOVE_TOOLTIP")), false, tooltip_node())
	else:
		globals.disconnect_text_tooltip(perform)
	var valid_donors = BodyRites.valid_donors(person, donor_ids)
	donor_ids = valid_donors
	var mana = mana_needed(person)
	var shares = BodyRites.mana_shares(mana, valid_donors)
	var problems
	if rite:
		problems = BodyRites.rite_problems(person, upgrade_code, valid_donors)
	elif taking_back:
		problems = BodyRites.removal_problems(person, upgrade_code, valid_donors)
	else:
		problems = BodyRites.problems(person, upgrade_code, valid_donors)
	build_price(person, shares, mana, problems, taking_back, rite)
	#The price row has only just become visible on the first selection, so its container width
	#is settled on the following frame. Rebuild the donor segments once more at that width.
	call_deferred("refresh_mana_segments")
	build_requirements(person, problems, taking_back, rite)
	build_donors(shares)
	perform.disabled = !problems.empty()


func build_price(person, shares, mana, problems, taking_back, rite):
	var tiles = $Body/Columns/Details/Scroll/Content/PriceTiles
	#Taking an upgrade back is paid in mana alone, and the rites take no upgrade points.
	tiles.get_node("Gold").visible = !taking_back
	tiles.get_node("Points").visible = !taking_back and !rite

	var gold = BodyRites.rite_gold(upgrade_code) if rite else BodyRites.gold_cost(upgrade_code)
	var money = int(ResourceScripts.game_res.money)
	var gold_tile = tiles.get_node("Gold/Body")
	gold_tile.get_node("Title").text = tr("BODYRITE_GOLD")
	gold_tile.get_node("CostRow/Cost").text = str(gold)
	gold_tile.get_node("Available").text = tr("BODYRITE_GOLD") + ": " + str(money)
	gold_tile.get_node("Available").set("custom_colors/font_color", GOOD if money >= gold else UNAFFORDABLE)

	if tiles.get_node("Points").visible:
		build_points_tile(person, tiles.get_node("Points"))

	var gathered = BodyRites.collected(shares)
	var mana_tile = tiles.get_node("Mana/Body")
	mana_tile.get_node("Title").text = tr("BODYRITE_MANA")
	mana_tile.get_node("Figures").text = tr("BODYRITE_MANA_AVAILABLE") + ": " + str(gathered) + " / " + str(mana)
	mana_tile.get_node("Figures").set("custom_colors/font_color", GOOD if !problems.has('mana') else UNAFFORDABLE)
	mana_tile.get_node("Status").text = tr("BODYRITE_MANA") + ": " + str(mana)
	mana_tile.get_node("Status").set("custom_colors/font_color", GOOD if !problems.has('mana') else BAD)
	build_mana_segments(shares, mana)


#The bar is the body's whole allowance: first what its upgrades already take, then this rite's cost.
func build_points_tile(person, tile):
	var cost = BodyRites.point_cost(upgrade_code)
	var total = BodyRites.total_points(person)
	var used = BodyRites.used_points(person)
	var fits = used + cost <= total
	var point_tile = tile.get_node("Body")
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
	globals.connecttexttooltip(tile,
		globals._report_text("BODYRITE_POINTS_TOOLTIP", [variables.body_upgrade_points_per_growth_factor]),
		false, tooltip_node())


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
		segment.set_meta('donor', id)
		segment.rect_min_size.x = width * float(shares[id]) / float(cost)
		segment.color = MANA_A if index % 2 == 0 else MANA_B


func refresh_mana_segments():
	var person = subject()
	#a rite draining the bar keeps its segments until it ends - see drain_mana()
	if !visible or person == null or upgrade_code == null or pending_rite != null:
		return
	var valid_donors = BodyRites.valid_donors(person, donor_ids)
	var cost = mana_needed(person)
	build_mana_segments(BodyRites.mana_shares(cost, valid_donors), cost)


func build_requirements(person, problems, taking_back, rite):
	var list = $Body/Columns/Details/Scroll/Content/Requirements
	input_handler.ClearContainer(list, ['Row'])
	#Two conditions are checked but not listed: the circle's preparation, since the card opens the panel only
	#on a prepared circle, and Flesh Rites' second level, which a sealed upgrade names on its own row.
	if rite:
		for entry in BodyRites.rite_rows(person, upgrade_code):
			add_requirement(list, entry.text, entry.met)
		add_requirement(list, tr("BODYRITE_CHECK_GOLD"), !problems.has('gold'))
	#Taking an upgrade back asks nothing of the body, the points or the gold - only the mana.
	elif !taking_back:
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


#Everybody who can give mana for this subject, as a grid of tiles: a press chooses a resident as a donor or lets
#them go (toggle_donor). A chosen tile shows what its donor gives. A resident with no mana to spare is dimmed
#and cannot be chosen, though one already chosen can still be let go.
func build_donors(shares):
	var content = $Body/Columns/Details/Scroll/Content
	var grid = content.get_node("Donors")
	input_handler.ClearContainer(grid, ['Tile'])
	var offered = BodyRites.donors_for(subject_id)
	content.get_node("DonorsEmpty").text = tr("BODYRITE_NO_DONORS")
	content.get_node("DonorsEmpty").visible = offered.empty()
	grid.visible = !offered.empty()
	for id in offered:
		var person = BodyRites.character(id)
		if person == null:
			continue
		var chosen = donor_ids.has(id)
		var current = BodyRites.mana_of(person)
		var maximum = int(person.get_stat('mpmax'))
		var tile = input_handler.DuplicateContainerTemplate(grid, 'Tile')
		tile.set_meta('donor', id)
		tile.pressed = chosen
		tile.disabled = !chosen and current <= 0
		tile.modulate = Color(0.5, 0.5, 0.5, 1) if tile.disabled else Color(1, 1, 1, 1)
		tile.get_node("Portrait").texture = portrait_for(person)
		tile.get_node("Name").text = person.get_short_name()
		tile.get_node("Mana").text = str(current) + " / " + str(maximum)
		var fill = tile.get_node("Bar/Fill")
		fill.anchor_right = clamp(float(current) / max(float(maximum), 1.0), 0.0, 1.0)
		fill.margin_right = 0
		tile.get_node("Gives").visible = chosen
		tile.get_node("Gives").text = tr("BODYRITE_DONOR_GIVES") + ": " + str(shares.get(id, 0))
		tile.connect("pressed", self, "toggle_donor", [id])


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
	rebuild()


func select_upgrade(code):
	if subject() == null or !known_code(code):
		return
	upgrade_code = code
	rebuild()


#A press on a resident's tile in the donors' grid: a donor is let go, anyone else gives if they have mana to
#give. The grid is built again either way, since the press has already flipped the tile.
func toggle_donor(id):
	if donor_ids.has(id):
		donor_ids.erase(id)
	elif can_donate(id):
		donor_ids.append(id)
	rebuild()


func can_donate(id):
	var person = BodyRites.character(id)
	return subject() != null and person != null and BodyRites.donors_for(subject_id).has(id) and BodyRites.mana_of(person) > 0


func add_donor(id):
	if !donor_ids.has(id) and can_donate(id):
		donor_ids.append(id)
		rebuild()


func remove_donor(id):
	donor_ids.erase(id)
	rebuild()


#The rite, taking an upgrade back when the subject already carries it, or one of the rites above the
#upgrades - each played out by play_rite().
func perform_rite():
	var person = subject()
	if person == null or upgrade_code == null or pending_rite != null:
		return
	var code = upgrade_code
	var problems
	if BodyRites.is_rite(code):
		problems = BodyRites.rite_problems(person, code, donor_ids)
	elif removing(person):
		problems = BodyRites.removal_problems(person, code, donor_ids)
	else:
		problems = BodyRites.problems(person, code, donor_ids)
	if !problems.empty():
		rebuild()
		return
	play_rite(person, code)


func refresh_after_rite():
	if input_handler.has_method("update_slave_list"):
		input_handler.update_slave_list()
	rebuild()


#A rite performed ends the visit: the preparation it took is spent, so the panel lets the player out rather
#than sit on a Perform nothing can press, and the room card comes back (mansion_view.close_body_rites).
func leave_after_rite():
	if view != null:
		view.close_body_rites()


#How a rite goes: the controls lock, the rite's mana drains out of its bar, the veil dims the panel and the
#screen around it, the rite is performed, and a dialogue scene tells what happened. Its Close brings the
#before-and-after window of a sex or form change, Body modifications and then that window after an
#appearance change, or the upgrade animation for the rest (rite_scene_closed).
#A sex, form or appearance change photographs the old body before anything changes. The new one is shot after
#the rite, or for the appearance change once Body modifications has closed (customization_closed).
func play_rite(person, code):
	var rite = {id = person.id, code = code, taking_back = !BodyRites.is_rite(code) and removing(person),
		mana = mana_needed(person)}
	pending_rite = rite
	lock_rite_input(true)
	perform_button().disabled = true
	#the circle answers the press at once, before the drain begins
	input_handler.PlaySound("teleport")
	if code in [BodyRites.SEX_CHANGE, BodyRites.FORM_CHANGE, BodyRites.APPEARANCE]:
		#named before the change: the form change is called after the form it is about to give
		rite.title = tr(BodyRites.rite_name_key(person, code))
		rite.old_label = body_label(person, code)
		var before = sprite_of(person)
		if before is GDScriptFunctionState:
			before = yield(before, "completed")
		rite.before = before
	#a rebuild in the same frame as the press sizes the bar for the layout before it; a frame later the tiles
	#have settled, and the bar is laid out again to drain from its real width
	yield(get_tree(), "idle_frame")
	var shares = BodyRites.mana_shares(rite.mana, BodyRites.valid_donors(person, donor_ids))
	build_mana_segments(shares, rite.mana)
	drain_mana(shares, rite.mana)
	#the last motes leave as the drain ends and land MOTE_FLIGHT later
	yield(get_tree().create_timer(DRAIN_TIME + MOTE_FLIGHT), "timeout")
	fade_veil(true)
	yield(get_tree().create_timer(VEIL_TIME), "timeout")
	var done
	if BodyRites.is_rite(code):
		done = BodyRites.perform_change(person, code, donor_ids)
	elif rite.taking_back:
		done = BodyRites.remove(person, code, donor_ids)
	else:
		done = BodyRites.perform(person, code, donor_ids)
	if !done:
		pending_rite = null
		lock_rite_input(false)
		fade_veil(false)
		rebuild()
		return
	#the appearance change's new body is only settled in Body modifications, so its second shot waits for that
	if rite.has('before') and code != BodyRites.APPEARANCE:
		var after = sprite_of(person)
		if after is GDScriptFunctionState:
			after = yield(after, "completed")
		rite.after = after
	lock_rite_input(false)
	open_rite_scene(person, rite)


func lock_rite_input(on):
	if on == rite_input_locked:
		return
	rite_input_locked = on
	if on:
		input_handler.lock_input()
	else:
		input_handler.unlock_input()


#RiteVeil covers the panel and the screen around it; the scene sets how dark, the script only fades it.
func fade_veil(on):
	var veil = $RiteVeil
	var tween = input_handler.GetTweenNode(veil)
	tween.remove_all()
	if on:
		veil.modulate = CLEAR
		veil.visible = true
		tween.interpolate_property(veil, 'modulate', CLEAR, WHITE, VEIL_TIME, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	else:
		tween.interpolate_property(veil, 'modulate', veil.modulate, CLEAR, VEIL_TIME, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.interpolate_callback(veil, VEIL_TIME, "hide")
	tween.start()


#The rite's mana leaves the bar right to left, the last donor's share first. That donor's own bar and figures
#on their tile in the grid below count down with their share, and the Mana tile's figures with the whole
#(drain_step). Motes of it fly from each tile into the rite's head as it goes, and the head fills with gold as
#they land.
func drain_mana(shares, cost):
	drain_plan.clear()
	drain_cost = cost
	var content = $Body/Columns/Details/Scroll/Content
	var segments = {}
	for segment in content.get_node("PriceTiles/Mana/Body/Bar/Segments").get_children():
		if segment is Control and segment.visible and segment.has_meta('donor'):
			segments[segment.get_meta('donor')] = segment
	var rows = {}
	for row in content.get_node("Donors").get_children():
		if row is Control and row.visible and row.has_meta('donor'):
			rows[row.get_meta('donor')] = row
	var order = donor_ids.duplicate()
	order.invert()
	var start = 0.0
	for id in order:
		var share = int(shares.get(id, 0))
		var person = BodyRites.character(id)
		if share <= 0 or cost <= 0 or person == null:
			continue
		var time = DRAIN_TIME * float(share) / float(cost)
		var segment = segments.get(id)
		var width = 0.0
		if segment != null:
			width = segment.rect_min_size.x
		drain_plan.append({segment = segment, width = width, row = rows.get(id), share = share,
			current = BodyRites.mana_of(person), maximum = int(person.get_stat('mpmax')), start = start, time = time})
		start += time
	plan_motes()
	var tween = input_handler.GetTweenNode(content.get_node("PriceTiles/Mana/Body/Bar"))
	tween.remove_all()
	tween.interpolate_method(self, "drain_step", 0.0, DRAIN_TIME + MOTE_FLIGHT, DRAIN_TIME + MOTE_FLIGHT,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func drain_step(elapsed):
	drain_elapsed = elapsed
	launch_motes(elapsed)
	#the head holds what has landed: the drain as it stood MOTE_FLIGHT ago
	head_charge = clamp((elapsed - MOTE_FLIGHT) / DRAIN_TIME, 0.0, 1.0)
	$Body/Columns/Details/Scroll/Content/UpgradeHead.update()
	if has_node("RiteParticles"):
		$RiteParticles.update()
	for step in drain_plan:
		var gone = clamp((elapsed - step.start) / max(step.time, 0.001), 0.0, 1.0)
		if is_instance_valid(step.segment):
			step.segment.rect_min_size.x = step.width * (1.0 - gone)
			step.segment.visible = gone < 1.0
		if is_instance_valid(step.row):
			var left = step.current - step.share * gone
			step.row.get_node("Bar/Fill").anchor_right = clamp(left / max(float(step.maximum), 1.0), 0.0, 1.0)
			step.row.get_node("Mana").text = str(int(ceil(left))) + " / " + str(step.maximum)
	var remaining = drain_cost * (1.0 - clamp(elapsed / DRAIN_TIME, 0.0, 1.0))
	var figures = $Body/Columns/Details/Scroll/Content/PriceTiles/Mana/Body/Figures
	figures.text = tr("BODYRITE_MANA_AVAILABLE") + ": " + str(int(ceil(remaining))) + " / " + str(drain_cost)


#The motes a drain sends: from each donor's tile, so many for the mana it gives, leaving while that donor's share
#drains, each on a curve of its own. Where one starts is only known as it leaves - the edge of the tile's bar by
#then - so launch_motes() fills that in.
func plan_motes():
	motes.clear()
	var pick = RandomNumberGenerator.new()
	pick.randomize()
	for step in drain_plan:
		if !is_instance_valid(step.row):
			continue
		var count = int(clamp(round(step.share * MOTES_PER_MANA), MOTES_MIN, MOTES_MAX))
		for i in range(count):
			motes.append({step = step, launch = step.start + step.time * (i + pick.randf()) / count,
				bend = pick.randf_range(-1.0, 1.0), size = pick.randf_range(0.7, 1.3)})


func launch_motes(elapsed):
	for mote in motes:
		if mote.has('from') or elapsed < mote.launch or !is_instance_valid(mote.step.row):
			continue
		var step = mote.step
		var gone = clamp((mote.launch - step.start) / max(step.time, 0.001), 0.0, 1.0)
		var left = (step.current - step.share * gone) / max(float(step.maximum), 1.0)
		var bar = step.row.get_node("Bar").get_global_rect()
		mote.from = Vector2(bar.position.x + bar.size.x * clamp(left, 0.0, 1.0), bar.position.y + bar.size.y * 0.5)


#The motes in the air, drawn on RiteParticles: each flies from its tile to the head's icon on a curve, turning from
#the mana's blue to gold as it nears, with a short fading tail, and fades as it lands.
func draw_motes():
	if motes.empty():
		return
	var layer = $RiteParticles
	var into = layer.get_global_transform().affine_inverse()
	var icon = $Body/Columns/Details/Scroll/Content/UpgradeHead/Icon.get_global_rect()
	var target = icon.position + icon.size * 0.5
	for mote in motes:
		if !mote.has('from'):
			continue
		var t = (drain_elapsed - mote.launch) / MOTE_FLIGHT
		if t < 0.0 or t > 1.0:
			continue
		var fade = clamp(t / 0.15, 0.0, 1.0) * clamp((1.0 - t) / 0.2, 0.0, 1.0)
		#the tail first, so the mote itself is drawn over it
		for back in range(MOTE_TRAIL, -1, -1):
			var along = t - back * MOTE_TRAIL_STEP
			if along < 0.0:
				continue
			var eased = along * along * (3.0 - 2.0 * along)
			var colour = MANA_B.linear_interpolate(GOLD, eased * eased)
			var radius = MOTE_RADIUS * mote.size * (1.0 - 0.4 * eased) * (1.0 - 0.25 * back)
			var strength = fade / (1.0 + back)
			var point = into.xform(mote_point(mote, eased, target))
			layer.draw_circle(point, radius * 2.4, Color(colour.r, colour.g, colour.b, 0.25 * strength))
			layer.draw_circle(point, radius, Color(colour.r, colour.g, colour.b, 0.9 * strength))


#Where a mote is, this far along its flight (eased): on a curve from its tile to the target, bowed out to one side.
func mote_point(mote, eased, target):
	var from = mote.from
	var bow = from.linear_interpolate(target, 0.5) + (target - from).tangent().normalized() * mote.bend * MOTE_BOW
	return from.linear_interpolate(bow, eased).linear_interpolate(bow.linear_interpolate(target, eased), eased)


#The head's gold, filling from the left under the icon and the words, with a brighter edge where it is rising.
func draw_head_charge():
	if head_charge <= 0.0:
		return
	var head = $Body/Columns/Details/Scroll/Content/UpgradeHead
	var width = head.rect_size.x * head_charge
	head.draw_rect(Rect2(Vector2.ZERO, Vector2(width, head.rect_size.y)), Color(GOLD.r, GOLD.g, GOLD.b, CHARGE_ALPHA))
	if head_charge < 1.0:
		head.draw_rect(Rect2(Vector2(max(0.0, width - CHARGE_EDGE), 0.0), Vector2(min(CHARGE_EDGE, width), head.rect_size.y)),
			Color(GOLD.r, GOLD.g, GOLD.b, 0.75))


func clear_charge():
	head_charge = 0.0
	drain_elapsed = 0.0
	motes.clear()
	$Body/Columns/Details/Scroll/Content/UpgradeHead.update()
	if has_node("RiteParticles"):
		$RiteParticles.update()


#The rite's dialogue scene. The game's dialogue node lives on the tree root, which draws under the mansion
#view's Overlay layer this panel sits on, so while the scene is up the node is parked in the layer the game
#keeps above the Overlay for the class-achieved animation (see ResourceScripts.node_data). It is back on the
#root before anything else can ask for it: rite_scene_closed runs inside the dialogue's own close(), ahead of
#input_handler.event_finished() opening whatever event waits next.
func open_rite_scene(person, rite):
	rite.scene = RITE_SCENES.get(rite.code, UPGRADE_SCENE)
	input_handler.connect("EventFinished", self, "rite_scene_closed", [], CONNECT_ONESHOT)
	input_handler.interactive_message_follow(rite.scene, 'char_translate', {ch = person})
	if input_handler.event_is_active and input_handler.active_event_code == rite.scene:
		park_dialogue(true)
	elif input_handler.is_connected("EventFinished", self, "rite_scene_closed"):
		#the scene never came up; the rite still ends the way it should
		input_handler.disconnect("EventFinished", self, "rite_scene_closed")
		rite_scene_closed()


#Moves the dialogue between the root and that layer. A Tween that leaves the tree stops and stays stopped, and
#the dialogue is still fading itself and its options in when it is parked (and itself out when it comes back),
#so the Tweens that were running under it are started again once it is in its new place.
func park_dialogue(up):
	var dialogue = gui_controller.dialogue
	if dialogue == null or !is_instance_valid(dialogue):
		return
	var layer = input_handler.get_spec_node_parent(input_handler.ANIM_CLASS_ACHIEVED)
	var root = get_tree().get_root()
	var parent = dialogue.get_parent()
	var target = null
	if up and parent == root:
		target = layer
	elif !up and parent == layer:
		target = root
	if target == null:
		return
	var running = []
	collect_running_tweens(dialogue, running)
	parent.remove_child(dialogue)
	target.add_child(dialogue)
	for tween in running:
		tween.resume_all()


func collect_running_tweens(node, running):
	if node is Tween and node.is_active():
		running.append(node)
	for child in node.get_children():
		collect_running_tweens(child, running)


#The rite's scene is closed: the dialogue goes back to the root, the panel shows everyone as they are now,
#and the rite ends on its before-and-after window, on Body modifications or on the upgrade animation.
func rite_scene_closed():
	park_dialogue(false)
	var rite = pending_rite
	pending_rite = null
	if rite == null or !is_inside_tree():
		return
	refresh_after_rite()
	var person = BodyRites.character(rite.id)
	if !visible or person == null:
		fade_veil(false)
		return
	if rite.has('after'):
		var shots = framed_pair(rite.before, rite.after)
		show_change_result(person, rite.code, rite.title, rite.old_label, shots[0], shots[1])
		#the window's own Dim takes over from the veil as it fades in
		var tween = input_handler.GetTweenNode($RiteVeil)
		tween.remove_all()
		tween.interpolate_callback($RiteVeil, 0.3, "hide")
		tween.start()
	elif rite.code == BodyRites.APPEARANCE:
		#the rite only readied the body: Body modifications opens on it to settle the new look, once the
		#dialogue has finished closing
		fade_veil(false)
		customizing_id = person.id
		customizing_rite = rite
		call_deferred("open_customization")
	else:
		fade_veil(false)
		play_rite_animation(person, rite)
		leave_after_rite()


#The upgrade animation: an upgrade's own icon and name, or the rite's, under "Unshaped" for one taken back
#and "Flesh Rite" for a rite.
func play_rite_animation(person, rite):
	var args = {person = person}
	if BodyRites.is_rite(rite.code):
		args.icon = BodyRites.rite_icon(person, rite.code)
		args.name = BodyRites.rite_name_key(person, rite.code)
		args.title = "BODYRITE_ANIM_RITE_TITLE"
		if rite.code == BodyRites.PERSONALITY:
			args.name = "PERSONALITYNAME" + str(person.get_stat('personality')).to_upper()
	else:
		args.upgrade = rite.code
		if rite.taking_back:
			args.title = "BODYRITE_ANIM_UNSHAPED_TITLE"
	input_handler.play_animation("body_upgrade", args)


#What the window writes under a body: the sex after a sex change, the race after a form change, and nothing after
#an appearance change, whose pictures say it.
func body_label(person, code):
	if code == BodyRites.APPEARANCE:
		return ""
	if code == BodyRites.FORM_CHANGE:
		return tr(str(races.racelist[str(person.get_stat('race'))].name))
	return tr("SLAVESEX" + str(person.get_stat('sex')).to_upper())


func result_text_key(person, code):
	if code == BodyRites.APPEARANCE:
		return "BODYRITE_APPEARANCE_DONE"
	if code == BodyRites.FORM_CHANGE:
		return "BODYRITE_BEASTKIN_FORM_DONE" if person.is_furry_form() else "BODYRITE_HALFKIN_FORM_DONE"
	return "DIALOGUESEXSWAP_" + str(person.get_stat('sex')).to_upper()


#The character's body for the before-and-after window: an Image of the doll, which framed_pair() cuts
#down, or the texture itself for a drawn body.
#A drawn body is its own picture;
#anyone the doll draws is photographed in SexChangeBooth, an off-screen viewport holding a doll framed
#on the whole figure and dressed the way their nudity rule has them, like the portrait booth's. The
#booth renders only for the shot, and its doll lets go of the character afterwards: a Viewport breaks
#visibility inheritance, so a doll left holding someone would rebuild on every later update_ragdoll.
func sprite_of(person):
	var drawn = person.get_stored_body_image()
	if drawn != null:
		return drawn
	#with dolls switched off in the options the body is the silhouette every other screen shows
	if input_handler.globalsettings.disable_paperdoll:
		return person.get_body_image()
	var booth = $SexChangeBooth
	var doll = booth.get_node("Doll")
	booth.render_target_update_mode = Viewport.UPDATE_ALWAYS
	doll.rebuild(person)
	doll.rebuild_cloth(!person.has_work_rule('nudity'))
	#the render has to land before it can be read
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	var image = booth.get_texture().get_data()
	booth.render_target_update_mode = Viewport.UPDATE_DISABLED
	doll.rebuild(null)
	image.flip_y() #a render target hands its picture back upside down
	return image


#The booth leaves room around a body for any height, so a figure takes only part of its shot. Both
#shots are cut to the space the two bodies take together, plus SHOT_MARGIN: each fills its frame at full
#height, and the two still stand at the same scale - a change of height stays visible.
func framed_pair(before, after):
	if before is Image and after is Image:
		var area = before.get_used_rect().merge(after.get_used_rect())
		if area.size.x > 0 and area.size.y > 0:
			area = area.grow(SHOT_MARGIN).clip(Rect2(Vector2.ZERO, before.get_size()))
			before = before.get_rect(area)
			after = after.get_rect(area)
	return [as_texture(before), as_texture(after)]


func as_texture(picture):
	if picture is Image:
		var texture = ImageTexture.new()
		texture.create_from_image(picture, Texture.FLAG_FILTER)
		return texture
	return picture


#Only a sex change goes on to the name prompt: the name is bound to the sex, not to the form.
func show_change_result(person, code, title, old_label, before, after):
	var body = $SexChangeResult/Window/Body
	body.get_node("Title").text = title
	for side in [["Before", "BODYRITE_BEFORE", before, old_label], ["After", "BODYRITE_AFTER", after, body_label(person, code)]]:
		var column = body.get_node("Pictures/" + side[0])
		column.get_node("Caption").text = tr(side[1])
		column.get_node("Sprite").texture = side[2]
		column.get_node("Sex").text = side[3]
	body.get_node("Text").text = person.translate(tr(result_text_key(person, code)))
	body.get_node("CloseButton").text = tr("DIALOGUECLOSE")
	renaming_id = person.id if code == BodyRites.SEX_CHANGE else null
	play_result_entrance()


#How the before-and-after window comes up: the screen darkens as the window swells out of the middle,
#the old body appears, then the arrow, then the new body out of a white flash with the rite's chime -
#and only then the words and the button. Pressing the button early skips to the end.
func play_result_entrance():
	var result = $SexChangeResult
	var window = result.get_node("Window")
	finish_result_entrance()
	result.get_node("NamePrompt").visible = false
	window.visible = true
	window.rect_pivot_offset = window.rect_size / 2
	window.rect_scale = Vector2(0.92, 0.92)
	result.modulate = CLEAR
	var parts = entrance_parts()
	for part in parts:
		part.modulate = CLEAR
	result.visible = true
	animate(result, 'modulate', CLEAR, WHITE, 0.3)
	animate(window, 'rect_scale', Vector2(0.92, 0.92), Vector2.ONE, 0.45, 0.0, Tween.TRANS_BACK, Tween.EASE_OUT)
	animate(parts[0], 'modulate', CLEAR, WHITE, 0.4, 0.35)
	animate(parts[1], 'modulate', CLEAR, WHITE, 0.3, 0.8)
	animate(parts[2], 'modulate', Color(FLASH.r, FLASH.g, FLASH.b, 0), FLASH, 0.2, FLASH_AT)
	animate(parts[2], 'modulate', FLASH, WHITE, 0.6, FLASH_AT + 0.2)
	animate(parts[3], 'modulate', CLEAR, WHITE, 0.4, FLASH_AT + 0.5)
	animate(parts[4], 'modulate', CLEAR, WHITE, 0.4, FLASH_AT + 0.7)
	get_tree().create_timer(FLASH_AT).connect("timeout", self, "play_flash_sound")


#The before body, the arrow, the after body, the words and the button, in the order they come up.
func entrance_parts():
	var body = $SexChangeResult/Window/Body
	return [body.get_node("Pictures/Before"), body.get_node("Pictures/Arrow"), body.get_node("Pictures/After"),
		body.get_node("Text"), body.get_node("CloseButton")]


func animate(node, property, from, to, time, delay = 0.0, transition = Tween.TRANS_LINEAR, easing = Tween.EASE_IN_OUT):
	var tween = input_handler.GetTweenNode(node)
	tween.interpolate_property(node, property, from, to, time, transition, easing, delay)
	tween.start()


#Everything on the window as it stands at the end of the entrance, with the running tweens dropped.
func finish_result_entrance():
	var result = $SexChangeResult
	var window = result.get_node("Window")
	for node in entrance_parts() + [result, window]:
		input_handler.GetTweenNode(node).remove_all()
		node.modulate = WHITE
	window.rect_scale = Vector2.ONE


func play_flash_sound():
	if $SexChangeResult.visible and $SexChangeResult/Window.visible:
		input_handler.PlaySound("class_aquired")


#Closing the window after a sex change asks for a new first name. It belongs to the body the character
#has now: changed back, they go by their old name again (body_rites.rename_for_sex,
#custom_effects.swap_sex_of). After a form or an appearance change the window simply goes.
func offer_new_name():
	var person = BodyRites.character(renaming_id) if renaming_id != null else null
	if person == null:
		close_sex_change_result()
		leave_after_rite()
		return
	finish_result_entrance()
	var prompt = $SexChangeResult/NamePrompt
	var body = prompt.get_node("Body")
	body.get_node("Title").text = person.translate(tr("BODYRITE_NEW_NAME"))
	body.get_node("Hint").text = person.translate(tr("BODYRITE_NEW_NAME_HINT"))
	body.get_node("NameEdit").text = tr(str(person.get_stat('name')))
	body.get_node("Buttons/Rename").text = tr("BODYRITE_RENAME")
	body.get_node("Buttons/Keep").text = tr("BODYRITE_KEEP_NAME")
	var window = $SexChangeResult/Window
	animate(window, 'modulate', WHITE, CLEAR, 0.2)
	input_handler.GetTweenNode(window).interpolate_callback(window, 0.2, "hide")
	prompt.modulate = CLEAR
	prompt.visible = true
	animate(prompt, 'modulate', CLEAR, WHITE, 0.25, 0.15)
	body.get_node("NameEdit").grab_focus()
	body.get_node("NameEdit").select_all()


func confirm_new_name(_submitted = ""):
	name_chosen($SexChangeResult/NamePrompt/Body/NameEdit.text)


func keep_name():
	name_chosen("")


#Files the name under the body the character has now and lets the window go.
func name_chosen(new_name):
	var person = BodyRites.character(renaming_id) if renaming_id != null else null
	if person != null:
		BodyRites.rename_for_sex(person, new_name)
		refresh_after_rite()
	close_sex_change_result()
	leave_after_rite()


#The appearance change opens the beauty parlor's Body modifications for its character straight from the rite's
#scene, so the new look can be settled at once; the sex and form changes do not open it. The mansion draws that
#window under this panel's Overlay layer, so the panel steps aside, and comes back when that window closes only
#to show the old body beside the new one (customization_closed).
func open_customization():
	var person = BodyRites.character(customizing_id) if customizing_id != null else null
	customizing_id = null
	var mansion = view.get_parent() if view != null else null
	if person == null or mansion == null or !mansion.has_method("open_body_mod_for_rite"):
		leave_after_rite()
		return
	visible = false
	mansion.open_body_mod_for_rite(person, self, "customization_closed")


#Body modifications has closed on the appearance change's character: the body as the rite found it and the one it
#has now, side by side in the before-and-after window, whose Close ends the visit (offer_new_name - there is no
#name to offer after this rite).
func customization_closed():
	if input_handler.has_method("update_slave_list"):
		input_handler.update_slave_list()
	var rite = customizing_rite
	customizing_rite = null
	var person = BodyRites.character(rite.id) if rite != null else null
	if person == null or !rite.has('before') or !is_inside_tree():
		leave_after_rite()
		return
	#the panel is back first: the booth the new body is photographed in is its own
	visible = true
	var after = sprite_of(person)
	if after is GDScriptFunctionState:
		after = yield(after, "completed")
	#closed meanwhile, with the view or a load
	if !visible or !is_inside_tree():
		return
	var shots = framed_pair(rite.before, after)
	show_change_result(person, rite.code, rite.title, rite.old_label, shots[0], shots[1])


#The window fades away.
func close_sex_change_result():
	renaming_id = null
	var result = $SexChangeResult
	if !result.visible:
		return
	var tween = input_handler.GetTweenNode(result)
	tween.remove_all()
	tween.interpolate_property(result, 'modulate', result.modulate, CLEAR, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_callback(result, 0.25, "hide")
	tween.start()
