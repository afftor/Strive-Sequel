extends Panel
#The only floating panel on the mansion screen. It opens against the clicked slot and has
#one shape per slot state:
#	broken - what is wrong and the button that clears it out into an empty slot
#	empty  - the list of room types that can be built here
#	built  - the room, its places, whoever is in them, and its actions
#
#The list of people follows the screen mode, so the card never disagrees with the grid
#behind it: beds while beds are being arranged, workplaces otherwise.

const MansionLayout = preload("res://src/core/mansion_layout.gd")
const RoomTypes = preload("res://assets/data/mansion_room_types.gd")
const RoomUpgrades = preload("res://assets/data/mansion_room_upgrades.gd")

#A finished improvement is lit, not greyed: grey is what a row wears when something is
#missing, which is the one thing "at its best" does not mean.  The frame is a shared
#texture - five scenes draw rows with it - so this tints the row rather than giving it a
#stylebox of its own.  The multiplier is not picked by eye: it maps the frame's own line,
#RGB(115, 99, 83), onto the gold the buttons inside it are bordered with, so the frame and
#the buttons read as the same gold.  self_modulate paints the panel alone, so the icon,
#the text and the button inside keep their own colours.
const MAXED_TINT = Color(2.16, 1.96, 0.77, 1)
const LocationTasks = preload("res://gui_modules/mansion_view/mansion_location_tasks.gd")

#The farm hand whose produce is on show, lit the way the selected panel is on the service
#screen - warm and a little brighter, so the list below plainly belongs to that face.
const SELECTED_TINT = Color(1.35, 1.22, 0.85, 1)

#what Body's own margins take off the card, top and bottom together
const BODY_MARGINS = 24
const DEFAULT_CARD_WIDTH = 460
#Two ordinary card columns plus Body's side margins and the gap between the columns.
const PEOPLE_CARD_WIDTH = 900
#Three catalogue rows side by side leave enough width for the full room prose while keeping
#all eleven indoor choices comfortably inside the screen.
const BUILD_CARD_WIDTH = 1332

var view = null
var slot_code = ''
#Which slot the open demolish question is about.  The card belongs to whichever room is
#selected, and that can be a different one by the time the answer comes back, so the
#answer acts on the room that was asked about rather than on whatever is on screen.
var pending_demolish = ''
#Which farm hand's produce list is on show. A farm's yield comes out of the people rather
#than the building, so the card picks one of them and shows what that body can give.
var farm_worker = null


func setup(view_node):
	view = view_node
	$CloseButton.connect("pressed", view, "close_card")
	$Body/Columns/LeftScroll/LeftColumn/Actions/MoveButton.connect("pressed", self, "on_move")
	$Body/Columns/LeftScroll/LeftColumn/Actions/CraftButton.connect("pressed", self, "on_craft")
	$Body/Columns/LeftScroll/LeftColumn/Actions/DemolishButton.connect("pressed", self, "on_demolish")
	$Body/Columns/LeftScroll/LeftColumn/RepairButton.connect("pressed", self, "on_repair")
	$Body/Columns/LeftScroll/LeftColumn/CancelButton.connect("pressed", self, "on_cancel")
	visible = false


func open(code, anchor_rect):
	slot_code = code
	farm_worker = null
	visible = true
	rebuild()
	settle_body()
	fit_to_body()
	position_near(anchor_rect)


#The card was a fixed 420x780 whatever it had to say. Floating over the whole screen rather
#than inside a panel, that meant most of it was empty board laid across the mansion, so it
#takes the height its sections actually asked for instead.
func fit_to_body():
	var body_minimum = $Body.get_combined_minimum_size().y
	var columns_minimum = $Body/Columns.get_combined_minimum_size().y
	var left_minimum = $Body/Columns/LeftScroll/LeftColumn.get_combined_minimum_size().y
	var people_minimum = 0.0
	if $Body/Columns/PeopleColumn.visible:
		people_minimum = $Body/Columns/PeopleColumn.get_combined_minimum_size().y
	var content_minimum = max(left_minimum, people_minimum)
	var wanted = body_minimum + max(0.0, content_minimum - columns_minimum) + BODY_MARGINS
	rect_size = Vector2(rect_size.x, min(wanted, get_viewport_rect().size.y - 16))
	#the sections were measured against the old height; lay them out again at the new one
	settle_body()


#Rebuilding changes what the sections say and which of them are shown, and a Container answers
#that with a re-sort on the next frame rather than now. Everything after this point - where the
#card is put, how tall it turned out - is asking about a layout that has not happened yet, so
#it is made to happen here. Godot 3 has no public "lay out now", but the notification the
#container itself listens for is the whole of what queue_sort() eventually sends.
func settle_body():
	settle_container($Body)


func settle_container(node):
	for child in node.get_children():
		if child is Container:
			settle_container(child)
	node.notification(Container.NOTIFICATION_SORT_CHILDREN)


#The narrow card stays tied to its slot. Wide cards cover enough of the mansion that following
#an edge slot makes them look stranded against the screen edge, so those use the viewport itself.
func position_near(anchor_rect):
	var screen = get_viewport_rect().size
	var pos = Vector2()
	var wide = $Body/BuildList.visible or $Body/Columns/PeopleColumn.visible
	if wide:
		pos.x = (screen.x - rect_size.x) / 2.0
		pos.y = (screen.y - rect_size.y) / 2.0 if rect_size.y < screen.y else 8.0
	else:
		pos = Vector2(anchor_rect.end.x + 12, anchor_rect.position.y)
		if pos.x + rect_size.x > screen.x - 8:
			pos.x = anchor_rect.position.x - rect_size.x - 12
		#A card is nearly as tall as the screen, so top-aligning it to a slot in the bottom row
		#would clamp it all the way back up to the top - the far end of the screen from the room
		#it is describing. Aligning its bottom to the slot's keeps the two together instead.
		if pos.y + rect_size.y > screen.y - 8:
			pos.y = anchor_rect.end.y - rect_size.y
	pos.x = clamp(pos.x, 8, max(8, screen.x - rect_size.x - 8))
	pos.y = clamp(pos.y, 8, max(8, screen.y - rect_size.y - 8))
	rect_global_position = pos


func room():
	return view.get_room(slot_code)


func build_data():
	return MansionLayout.get_build(view.current_floor(), slot_code)


func rebuild():
	pending_demolish = ''
	$Body/Columns/LeftScroll.scroll_vertical = 0
	set_card_width(DEFAULT_CARD_WIDTH)
	$Body/Columns/PeopleColumn.visible = false
	$Body/Columns/PeopleColumn/CandidateScroll.visible = false
	$Body/Columns/LeftScroll/LeftColumn/Actions/CraftButton.visible = false
	$Body/Columns/LeftScroll/LeftColumn/OrderHeader.visible = false
	$Body/Columns/LeftScroll/LeftColumn/OrderList.visible = false
	$Body/Columns/LeftScroll/LeftColumn/FarmList.visible = false
	$Body/Columns/LeftScroll/LeftColumn/CancelButton.visible = false
	$Body/Columns/LeftScroll/LeftColumn/YieldHeader.visible = false
	$Body/Columns/LeftScroll/LeftColumn/YieldList.visible = false
	$Body/Columns/LeftScroll/LeftColumn/UpgradeHeader.visible = false
	$Body/Columns/LeftScroll/LeftColumn/UpgradeList.visible = false
	match MansionLayout.slot_status(view.current_floor(), slot_code):
		'broken':
			build_for_broken()
		'empty':
			build_for_empty()
		'building':
			build_for_scaffolding()
		'built':
			build_for_room(room())
	update_column_layout()
	update_text_sections()


func set_card_width(width):
	rect_min_size.x = width
	rect_size.x = width


#The people side is optional. Hiding its container, rather than only its children, removes
#both its minimum width and the HBox gap, so rooms without places keep the compact card.
#The catalogue is deliberately outside Columns and therefore keeps all three rows abreast.
func update_column_layout():
	var people = $Body/Columns/PeopleColumn
	people.visible = $Body/Columns/PeopleColumn/Occupants.visible \
		or $Body/Columns/PeopleColumn/CandidateScroll.visible
	if $Body/BuildList.visible:
		set_card_width(BUILD_CARD_WIDTH)
	elif people.visible:
		set_card_width(PEOPLE_CARD_WIDTH)
	else:
		set_card_width(DEFAULT_CARD_WIDTH)


#Empty card sections should take no space. The fixed minimums on the wrapped labels are
#needed when they contain text, but were leaving a large blank middle in build and repair
#cards when their strings were deliberately empty.
func update_text_sections():
	for path in ['Subtitle', 'Descript', 'Functions']:
		var label = $Body/Columns/LeftScroll/LeftColumn.get_node(path)
		label.visible = label.text.strip_edges() != ''
	fit_wrapped_label($Body/Columns/LeftScroll/LeftColumn/Descript)


#The ordinary room card is narrow, and several descriptions take more than the three lines
#the scene used to reserve. Measure the actual wrapped text at the card's current width so a
#long room or grounds description pushes the sections below it down instead of disappearing
#under them.
func fit_wrapped_label(label):
	label.rect_min_size.y = 0
	if !label.visible:
		return
	#The column's own minimum is the floor: on the first pass the label has not been laid out
	#yet, and measuring against a width of nothing asks for a height of everything.
	var width = max(label.rect_size.x, $Body/Columns/LeftScroll/LeftColumn.rect_min_size.x)
	width = max(1.0, width)
	label.rect_min_size.y = ceil(label.get_font("font").get_wordwrap_string_size(
		label.text, width).y)


func description_fits():
	var label = $Body/Columns/LeftScroll/LeftColumn/Descript
	if !label.visible:
		return true
	var needed = label.get_font("font").get_wordwrap_string_size(
		label.text, max(1.0, label.rect_size.x)).y
	return label.rect_size.y + 1.0 >= needed


func content_fits_card():
	var needed = $Body.get_combined_minimum_size()
	return $Body.rect_size.x + 1.0 >= needed.x and $Body.rect_size.y + 1.0 >= needed.y


#### broken ####

func build_for_broken():
	$Body/Columns/LeftScroll/LeftColumn/Title.text = tr("MANSIONVIEW_BROKEN")
	$Body/Columns/LeftScroll/LeftColumn/Subtitle.text = ""
	$Body/Columns/LeftScroll/LeftColumn/Descript.text = tr("MANSIONVIEW_BROKENHINT")
	$Body/Columns/LeftScroll/LeftColumn/Functions.text = ""
	$Body/Columns/PeopleColumn/Occupants.visible = false
	$Body/Columns/LeftScroll/LeftColumn/Actions.visible = false
	$Body/BuildList.visible = false
	$Body/Columns/LeftScroll/LeftColumn/RepairButton.visible = true
	$Body/Columns/LeftScroll/LeftColumn/RepairButton.text = tr("MANSIONVIEW_REPAIR")


#### under construction ####

#A slot with scaffolding on it: what is going up, how far along, and the way out.
func build_for_scaffolding():
	var build = build_data()
	$Body/Columns/LeftScroll/LeftColumn/Title.text = view.build_label(build)
	$Body/Columns/LeftScroll/LeftColumn/Subtitle.text = view.build_eta_text(build)
	$Body/Columns/LeftScroll/LeftColumn/Descript.text = tr("MANSIONVIEW_BUILDINGHINT")
	$Body/Columns/LeftScroll/LeftColumn/Functions.text = "%s %d%%" % [tr("MANSIONVIEW_PROGRESS"),
		int(build.progress * 100.0 / max(1.0, build.limit))]
	$Body/Columns/PeopleColumn/Occupants.visible = false
	$Body/Columns/LeftScroll/LeftColumn/Actions.visible = false
	$Body/BuildList.visible = false
	$Body/Columns/LeftScroll/LeftColumn/RepairButton.visible = false
	$Body/Columns/LeftScroll/LeftColumn/CancelButton.visible = true
	$Body/Columns/LeftScroll/LeftColumn/CancelButton.text = tr("MANSIONVIEW_CANCELBUILD")


#### empty: what can be built here ####

func build_for_empty():
	set_card_width(BUILD_CARD_WIDTH)
	$Body/Columns/LeftScroll/LeftColumn/Title.text = tr("MANSIONVIEW_BUILDHERE")
	$Body/Columns/LeftScroll/LeftColumn/Subtitle.text = ""
	$Body/Columns/LeftScroll/LeftColumn/Descript.text = ""
	$Body/Columns/LeftScroll/LeftColumn/Functions.text = ""
	$Body/Columns/PeopleColumn/Occupants.visible = false
	#an empty slot is somewhere a room is moved to, not a thing that gets moved: it has
	#nothing to carry, so there is nothing here to act on either
	$Body/Columns/LeftScroll/LeftColumn/Actions.visible = false
	$Body/Columns/LeftScroll/LeftColumn/RepairButton.visible = false
	$Body/BuildList.visible = true

	input_handler.ClearContainer($Body/BuildList, ['Row'])
	for code in RoomTypes.get_buildable_codes(MansionLayout.is_grounds(view.layout(), view.floor_index())):
		var check = MansionLayout.can_build(view.layout(), view.floor_index(), slot_code, code)
		#A room the estate already has as many of as it may is not a choice, it is a fact.
		#Offering it greyed out only asks the player to work out why they cannot press it.
		if !check.ok and check.reason in ['MANSIONVIEW_ERR_UNIQUE', 'MANSIONVIEW_ERR_ENOUGH']:
			continue
		var data = RoomTypes.get_type(code)
		var row = input_handler.DuplicateContainerTemplate($Body/BuildList, 'Row')
		setup_build_row(row, code, data, check)


#Build choices and improvements are the same kind of decision, so they use the same visual
#grammar: identity and effect on the left, material readouts below, one explicit action.
func setup_build_row(row, code, data, check):
	row.set_meta('type', code)
	row.get_node('Title').text = tr(RoomTypes.get_name_key(code))
	row.get_node('Descript').text = tr(RoomTypes.get_descript_key(code))
	row.get_node('Descript').visible = true
	#The description says what the room does, in words and figures. The bare slot count under
	#it repeated a piece of that in a second colour and read as a second, competing fact.
	row.get_node('Bonus').text = ""
	row.get_node('Bonus').visible = false
	row.get_node('Icon').texture = images.upgrade_icons[data.icon] \
		if images.upgrade_icons.has(data.icon) else load("res://assets/Textures_v2/icon_question_small.png")
	build_cost_icons(row.get_node('Costs'), data.build_cost)

	var affordable = view.can_afford(data.build_cost)
	var action = row.get_node('Action')
	action.text = tr("MANSIONVIEW_BUILDHERE")
	action.disabled = !check.ok or !affordable
	action.connect("pressed", view, "start_construct", [slot_code, code])
	#Rule-blocked rooms recede as a whole. Resource-blocked rooms stay readable so their red
	#cost figures can say exactly what is missing.
	row.self_modulate = Color(0.55, 0.55, 0.55, 1) if !check.ok else \
		(Color(0.82, 0.82, 0.82, 1) if !affordable else Color(1, 1, 1, 1))
	#The row explains itself, the button does not. The tooltip opens to the right of whatever
	#the cursor is on and is wider than the button, so summoning it from the button laid it
	#across the very thing being aimed at - and the row underneath keeps it reachable anyway:
	#a button with STOP takes the mouse off its parent, so this closes as the cursor arrives.
	globals.connecttexttooltip(row, build_hint(code, check), true,
		view.get_node("Overlay/TextTooltip"), self)
	fit_decision_row(row)


#What the row does not already say. The description is printed right there under the name, so
#repeating it in a panel that covers the neighbouring rows was noise standing in front of the
#thing it described.
func build_hint(code, check):
	var parts = [slots_text(code),
		tr("MANSIONVIEW_WORKUNITS") % int(RoomTypes.get_type(code).build_progress)]
	if !check.ok:
		parts.append(tr(check.reason))
	return PoolStringArray(parts).join("\n")


func slots_text(code):
	var parts = []
	var beds = RoomTypes.base_slots(code, 'sleep')
	if beds > 0:
		parts.append("%s %d" % [tr("MANSIONVIEW_BEDS"), beds])
	var places = RoomTypes.base_slots(code, 'work')
	if places > 0:
		parts.append("%s %d" % [tr("MANSIONVIEW_WORKPLACES"), places])
	if parts.empty():
		parts.append(tr("MANSIONVIEW_NOSLOTS"))
	return PoolStringArray(parts).join("   ")


#Material names are already localized onto Items.materiallist by modding_core, and gold
#has its own key - the same sources the upgrades panel uses.
func cost_text(cost):
	if cost.empty():
		return "-"
	var parts = []
	for res in cost:
		var label = tr('GOLD') if res == 'gold' else Items.materiallist[res].name
		parts.append("%s %d" % [label, int(cost[res])])
	return PoolStringArray(parts).join(", ")


#### built ####

func build_for_room(current):
	$Body/BuildList.visible = false
	$Body/Columns/LeftScroll/LeftColumn/RepairButton.visible = false
	$Body/Columns/LeftScroll/LeftColumn/Actions.visible = true
	$Body/Columns/LeftScroll/LeftColumn/Title.text = tr(RoomTypes.get_name_key(current.type))
	#Capacity belongs to the people section below; printing it here as well made the card
	#announce the same Beds/Workplaces count twice.
	$Body/Columns/LeftScroll/LeftColumn/Subtitle.text = ""
	$Body/Columns/LeftScroll/LeftColumn/Descript.text = tr(RoomTypes.get_descript_key(current.type))
	$Body/Columns/LeftScroll/LeftColumn/Functions.text = upgrades_text(current)
	build_yield_list(current)
	build_craft_button(current)

	$Body/Columns/LeftScroll/LeftColumn/Actions/DemolishButton.disabled = !MansionLayout.can_demolish(view.layout(), view.floor_index(), slot_code).ok
	build_move_button()
	build_people(current)
	build_order_list(current)
	build_upgrade_list(current)


#Which disciplines have a craft screen is the craft screen's own list, not a copy of it kept
#here: a fifth one added there would otherwise leave its room without the button and nobody
#would think to look in this file.
func craft_screen():
	if view.get_parent() == null:
		return null
	return view.get_parent().get_node_or_null("MansionCraftModule")


func craft_category_of(current):
	var job = RoomTypes.get_work_job(current.type)
	if job == null:
		return null
	var screen = craft_screen()
	if screen == null or !('craftcategories' in screen):
		return null
	return job if screen.craftcategories.has(job) else null


func build_craft_button(current):
	var button = $Body/Columns/LeftScroll/LeftColumn/Actions/CraftButton
	button.visible = craft_category_of(current) != null
	if button.visible:
		button.text = tr("MANSIONVIEW_CRAFT")


#Grounds gathering buildings show their production table on their own card. Other mansion
#rooms have no gathering entry, so both parts of the section disappear from the VBox.
func build_yield_list(current):
	input_handler.ClearContainer($Body/Columns/LeftScroll/LeftColumn/YieldList, ['Row'])
	var gather = LocationTasks.gather_entry_for_room(current.type, slot_code)
	var rows = LocationTasks.production_table(gather.id) if gather != null else []
	$Body/Columns/LeftScroll/LeftColumn/YieldHeader.visible = !rows.empty()
	$Body/Columns/LeftScroll/LeftColumn/YieldList.visible = !rows.empty()
	if rows.empty():
		return
	$Body/Columns/LeftScroll/LeftColumn/YieldHeader.text = tr("MANSIONVIEW_ROOMYIELDS")
	for entry in rows:
		var row = input_handler.DuplicateContainerTemplate($Body/Columns/LeftScroll/LeftColumn/YieldList, 'Row')
		var material = Items.materiallist[entry[0]]
		row.get_node('Icon').texture = material.icon
		row.get_node('Name').text = tr(material.name)
		row.get_node('Chance').text = "" if entry[1] >= 1.0 else \
			tr("MANSIONVIEW_YIELDCHANCE") % int(round(entry[1] * 100.0))


#Moving a room starts here rather than from a mode button on the top bar: the room is
#picked up from its own card, and the screen then waits for somewhere to put it.
func build_move_button():
	var button = $Body/Columns/LeftScroll/LeftColumn/Actions/MoveButton
	#Nothing out on the grounds is moved: a plot is a piece of ground with a building on it,
	#not a room in a plan that can trade places with another. The button is taken away rather
	#than greyed out - there is no arrangement out there for it to be part of.
	button.visible = !MansionLayout.is_grounds(view.layout(), view.floor_index())
	if !button.visible:
		return
	button.text = tr("MANSIONVIEW_MOVE")
	button.disabled = !view.has_any_swap_target(slot_code)
	globals.connecttexttooltip(button, tr("MANSIONVIEW_MOVEHINT" if !button.disabled
		else view.pick_refusal(slot_code)), true, view.get_node("Overlay/TextTooltip"))


func room_subtitle(current):
	var parts = []
	var beds = MansionLayout.sleep_capacity(current)
	if beds > 0:
		parts.append("%s %d/%d" % [tr("MANSIONVIEW_BEDS"), current.occupants.size(), beds])
	var places = MansionLayout.work_capacity(current)
	if places > 0:
		parts.append("%s %d/%d" % [tr("MANSIONVIEW_WORKPLACES"), view.room_workers(current).size(), places])
	return PoolStringArray(parts).join("   ")


func upgrades_text(current):
	var lines = []
	var build = build_data()
	if build != null:
		lines.append("%s - %s" % [view.build_label(build), view.build_eta_text(build)])
	return PoolStringArray(lines).join("\n")


#One upgrade at a time per room, so once something is going up the rest are simply shut.
func build_upgrade_list(current):
	var build = build_data()
	$Body/Columns/LeftScroll/LeftColumn/CancelButton.visible = build != null
	if build != null:
		$Body/Columns/LeftScroll/LeftColumn/CancelButton.text = tr("MANSIONVIEW_CANCELBUILD")
	input_handler.ClearContainer($Body/Columns/LeftScroll/LeftColumn/UpgradeList, ['Row'])
	var codes = RoomTypes.get_type(current.type).upgrades
	$Body/Columns/LeftScroll/LeftColumn/UpgradeHeader.visible = !codes.empty()
	$Body/Columns/LeftScroll/LeftColumn/UpgradeHeader.text = tr("MANSIONVIEW_ROOMUPGRADES")
	$Body/Columns/LeftScroll/LeftColumn/UpgradeList.visible = !codes.empty()
	for code in codes:
		var row = input_handler.DuplicateContainerTemplate($Body/Columns/LeftScroll/LeftColumn/UpgradeList, 'Row')
		setup_upgrade_row(row, current, code, build)


#An improvement is information plus one action, not one wide mystery button. The row keeps
#its icon, level, effect and material cost visible; only Action is clickable.
func setup_upgrade_row(row, current, code, build):
	var level = MansionLayout.upgrade_level(current, code)
	var max_level = RoomUpgrades.max_level(code)
	var next_level = level + 1
	var level_data = RoomUpgrades.get_level_data(code, next_level)
	var upgrade_data = RoomUpgrades.get_upgrade(code)

	row.self_modulate = Color(1, 1, 1, 1)
	row.set_meta('type', code)
	row.get_node('Title').text = tr(RoomUpgrades.get_name_key(code))
	row.get_node('Level').text = "%d/%d" % [level, max_level]
	row.get_node('Descript').text = tr(RoomUpgrades.get_descript_key(code))
	var icon_code = upgrade_data.get('icon', RoomTypes.get_type(current.type).icon)
	row.get_node('Icon').texture = images.upgrade_icons[icon_code] \
		if images.upgrade_icons.has(icon_code) else null

	var action = row.get_node('Action')
	action.text = tr("MANSIONVIEW_UPGRADE")
	action.disabled = true
	var maxed = level_data == null
	#An improvement at its best has no button: there is nothing left to press, and a greyed
	#one reads as something the player cannot afford rather than as something finished. The
	#level beside the title already says 3/3, and the row is tinted for it besides.
	action.visible = !maxed
	if maxed:
		row.get_node('Bonus').text = tr(RoomUpgrades.get_bonus_key(code, level)) if level > 0 else ""
		row.self_modulate = MAXED_TINT
		build_cost_icons(row.get_node('Costs'), {})
	else:
		row.get_node('Bonus').text = tr(RoomUpgrades.get_bonus_key(code, next_level))
		build_cost_icons(row.get_node('Costs'), level_data.cost)
		var check = MansionLayout.can_start_upgrade(view.layout(), view.floor_index(), slot_code, code)
		action.disabled = !check.ok or !view.can_afford(level_data.cost)
		if build != null and build.kind == 'upgrade' and build.target == code:
			action.text = "%d%%" % int(build.progress * 100.0 / max(1.0, build.limit))
			row.self_modulate = Color(1.15, 1.08, 0.78, 1)
		action.connect("pressed", view, "start_upgrade", [slot_code, code])
	fit_decision_row(row)

	#explained by the row, not by the button - see the note in setup_build_row().  A maxed
	#improvement gets no tooltip at all: it would only repeat the level and the bonus the
	#row is already showing, and there is no next step left to describe.
	if !maxed:
		#an improvement with nothing left to add says nothing rather than opening an empty panel
		var hint = upgrade_hint(code, level, next_level)
		if hint != "":
			globals.connecttexttooltip(row, hint, true,
				view.get_node("Overlay/TextTooltip"), self)


#Room choices and improvements both carry prose and a separate mechanical summary. Measure
#each wrapped label at its real width, then put the bonus and costs below it. Different prose
#therefore makes deliberately different row heights without losing a line.
func fit_decision_row(row):
	var descript = row.get_node('Descript')
	var descript_needed = wrapped_height(descript)
	descript.margin_bottom = descript.margin_top + descript_needed
	var bonus = row.get_node('Bonus')
	bonus.margin_top = descript.margin_bottom + 4
	bonus.margin_bottom = bonus.margin_top + wrapped_height(bonus)
	var costs = row.get_node('Costs')
	costs.margin_top = bonus.margin_bottom + 2
	costs.margin_bottom = costs.margin_top + 29
	var action = row.get_node('Action')
	action.margin_top = costs.margin_top
	action.margin_bottom = costs.margin_bottom
	row.rect_min_size.y = max(88.0, costs.margin_bottom + 4)


func wrapped_height(label):
	if label.text.empty():
		return 0.0
	return ceil(label.get_font("font").get_wordwrap_string_size(
		label.text, max(1.0, label.rect_size.x)).y)


func wrapped_label_fits(label):
	return label.rect_size.y + 1.0 >= wrapped_height(label)


func catalogue_descriptions_fit():
	for row in $Body/BuildList.get_children():
		if !row.visible:
			continue
		var descript = row.get_node('Descript')
		var code = row.get_meta('type')
		if !descript.visible or descript.text != tr(RoomTypes.get_descript_key(code)) \
				or !wrapped_label_fits(descript):
			return false
	return true


func upgrade_descriptions_fit():
	for row in $Body/Columns/LeftScroll/LeftColumn/UpgradeList.get_children():
		if !row.visible:
			continue
		var descript = row.get_node('Descript')
		var code = row.get_meta('type')
		if !descript.visible or descript.text != tr(RoomUpgrades.get_descript_key(code)) \
				or !wrapped_label_fits(descript):
			return false
	return true


func upgrade_bonuses_fit():
	for row in $Body/Columns/LeftScroll/LeftColumn/UpgradeList.get_children():
		if !row.visible:
			continue
		var bonus = row.get_node('Bonus')
		if !wrapped_label_fits(bonus):
			return false
	return true


#Each resource is its own small readout. A red number answers why the action is unavailable
#without making the player parse a comma-separated sentence on the button.
func build_cost_icons(holder, cost):
	input_handler.ClearContainer(holder, ['Cost'])
	for resource_code in cost:
		var cell = input_handler.DuplicateContainerTemplate(holder, 'Cost')
		var needed = int(cost[resource_code])
		var icon = null
		var owned = 0
		if resource_code == 'gold':
			icon = load("res://assets/images/iconsitems/gold.png")
			owned = int(ResourceScripts.game_res.money)
			globals.connecttexttooltip(cell, tr("GOLD"), true,
				view.get_node("Overlay/TextTooltip"))
		elif Items.materiallist.has(resource_code):
			icon = Items.materiallist[resource_code].icon
			owned = int(ResourceScripts.game_res.materials.get(resource_code, 0))
			globals.connectmaterialtooltip(cell, Items.materiallist[resource_code], '', null,
				view.get_node("Overlay/ItemTooltip"))
		cell.get_node('Icon').texture = icon
		cell.get_node('Amount').text = str(needed)
		cell.get_node('Amount').set('custom_colors/font_color',
			Color(0.95, 0.35, 0.35) if owned < needed else Color(0.88, 0.88, 0.88))


#Same rule as build_hint(): the row already carries the description and the bonus the next
#level would bring, so the panel adds what it cannot show - what the room has from the level
#it is on now, and what the next one costs in work.
func upgrade_hint(code, level, next_level):
	var parts = []
	if level > 0:
		parts.append("%s: %s" % [tr("MANSIONVIEW_NOW"), tr(RoomUpgrades.get_bonus_key(code, level))])
	var level_data = RoomUpgrades.get_level_data(code, next_level)
	if level_data != null:
		parts.append(tr("MANSIONVIEW_WORKUNITS") % int(level_data.progress))
	return PoolStringArray(parts).join("\n")


#Whoever is in the room, in whichever sense the current mode cares about.
func build_people(current):
	var sleeping = view.mode == 'sleep'
	var occupants = current.occupants if sleeping else view.room_workers(current)
	var capacity = MansionLayout.sleep_capacity(current) if sleeping else MansionLayout.work_capacity(current)
	$Body/Columns/PeopleColumn/Occupants.visible = capacity > 0
	if capacity <= 0:
		return
	$Body/Columns/PeopleColumn/Occupants/Header.text = "%s %d/%d" % [
		tr("MANSIONVIEW_BEDS") if sleeping else tr("MANSIONVIEW_WORKPLACES"),
		occupants.size(), capacity]
	input_handler.ClearContainer($Body/Columns/PeopleColumn/Occupants/List)
	#On a farm a click picks the person whose produce is being set rather than turning them
	#out; the list itself carries the button that sends them away, so nobody loses their
	#place by going to look at what they make.
	var picking = !sleeping and farm_rules_shown(current)
	if picking:
		#settled before the faces are drawn rather than when the list below is built, or the
		#first look at a farm would show a produce list belonging to nobody lit up
		ensure_farm_worker(occupants)
	for char_id in occupants:
		var character = view.get_character(char_id)
		var button = input_handler.DuplicateContainerTemplate($Body/Columns/PeopleColumn/Occupants/List)
		setup_occupant_button(button, character)
		if picking:
			if char_id == farm_worker:
				button.self_modulate = SELECTED_TINT
			button.connect("pressed", self, "select_farm_worker", [char_id])
			globals.connecttexttooltip(button, tr("MANSIONVIEW_FARMPICKHINT"), true,
				view.get_node("Overlay/TextTooltip"))
			continue
		button.connect("pressed", self, "on_remove_person", [char_id, sleeping])
		globals.connecttexttooltip(button, tr("MANSIONVIEW_EVICTHINT"), true,
			view.get_node("Overlay/TextTooltip"))
	for _i in range(max(0, capacity - occupants.size())):
		var button = input_handler.DuplicateContainerTemplate($Body/Columns/PeopleColumn/Occupants/List)
		setup_empty_occupant_button(button)
		button.connect("pressed", self, "show_candidates", [sleeping])
		globals.connecttexttooltip(button, tr("MANSIONVIEW_EMPTYSLOT"), true,
			view.get_node("Overlay/TextTooltip"))


func setup_occupant_button(button, character):
	button.self_modulate = Color(1, 1, 1, 1)
	button.get_node('Name').text = character.get_short_name() if character != null else "?"
	button.get_node('Status').visible = character != null and !view.is_present(character)
	button.get_node('Status').text = tr("MANSIONVIEW_AWAY")
	var portrait = null
	if character != null:
		portrait = character.get_icon()
		if portrait == null:
			portrait = character.get_class_icon()
		input_handler.queue_portrait(character)
	button.get_node('Portrait').texture = portrait
	button.get_node('Portrait').self_modulate = Color(1, 1, 1, 1)


func setup_empty_occupant_button(button):
	button.self_modulate = Color(0.62, 0.62, 0.62, 1)
	button.get_node('Portrait').texture = load("res://assets/Textures_v2/icon_question_small.png")
	button.get_node('Portrait').self_modulate = Color(0.78, 0.7, 0.45, 0.72)
	button.get_node('Name').text = tr("MANSIONVIEW_EMPTYSLOT")
	button.get_node('Status').visible = false


func on_remove_person(char_id, sleeping):
	if sleeping:
		view.unassign_resident(char_id)
	else:
		view.unassign_worker(char_id)


#### the farm's produce ####

#Only a farm has one, and only while people are being put to work: in bed-arranging mode the
#card is about who sleeps here and the produce list would be answering a question nobody asked.
func farm_rules_shown(current):
	if current == null or view.mode == 'sleep':
		return false
	return RoomTypes.get_work_job(current.type) == 'farming'


#Whoever the card was showing, as long as they are still on the farms; otherwise the first
#hand there, so the list always belongs to a face on the card.
func ensure_farm_worker(workers):
	if farm_worker != null and workers.has(farm_worker):
		return
	farm_worker = workers[0] if !workers.empty() else null


func select_farm_worker(char_id):
	farm_worker = char_id
	rebuild()


#What a body can give is decided by the body: a rule whose requirement the character does not
#meet is not offered, and one they used to meet is dropped rather than left quietly paying out.
func build_farm_rules(current):
	var header = $Body/Columns/LeftScroll/LeftColumn/OrderHeader
	var list = $Body/Columns/LeftScroll/LeftColumn/FarmList
	header.visible = true
	$Body/Columns/LeftScroll/LeftColumn/OrderList.visible = false
	list.visible = true
	input_handler.ClearContainer(list, ['Row'])
	ensure_farm_worker(view.room_workers(current))
	var character = view.get_character(farm_worker) if farm_worker != null else null
	if character == null:
		header.text = tr("MANSIONVIEW_FARMHEADEREMPTY")
		return
	var chosen = 0
	var offered = 0
	for res in variables.farming_rules:
		if !character.checkreqs(tasks.farm_tasks[res].reqs):
			#a body that has changed since the rule was set no longer gives this
			character.set_farm_res(res, false)
			continue
		offered += 1
		var on = character.get_farm_res(res)
		if on:
			chosen += 1
		var material = Items.materiallist[res]
		var button = input_handler.DuplicateContainerTemplate(list, 'Row')
		button.get_node('Icon').texture = material.icon
		button.get_node('Name').text = tr(material.name)
		var rate = character.get_progress_farm(res)
		#The column is a strip at the end of the row - the sentence it used to hold was cut
		#off after a word. The figure is what the player is reading it for; the sentence
		#that says what the figure means is in the tooltip.
		button.get_node('Amount').text = "+%.1f" % rate
		button.pressed = on
		#Their growth factor says how many things at once, so a full list greys out what is
		#not already ticked instead of quietly refusing the click.
		button.disabled = !on and !character.can_add_farming()
		button.connect("pressed", self, "toggle_farm_rule", [farm_worker, res, !on])
		if button.disabled:
			globals.connecttexttooltip(button, tr("FARMGROWTHFACTORLOW"), true,
				view.get_node("Overlay/TextTooltip"))
		else:
			globals.connectmaterialtooltip(button, material,
				"\n" + tr("FARMPROGRESSTURN") % rate, null,
				view.get_node("Overlay/ItemTooltip"))
	header.text = tr("MANSIONVIEW_FARMHEADER") % [character.get_short_name(),
		chosen, character.get_farming_limit()]
	if offered == 0:
		var button = input_handler.DuplicateContainerTemplate(list, 'Row')
		button.get_node('Icon').texture = null
		button.get_node('Name').text = tr("MANSIONVIEW_FARMNOTHING")
		button.get_node('Amount').text = ''
		button.disabled = true
	#last, so it sits under the produce rather than above it - this is the way out, not the
	#first thing to reach for
	var leave = input_handler.DuplicateContainerTemplate(list, 'Row')
	leave.toggle_mode = false
	leave.get_node('Icon').texture = null
	leave.get_node('Name').text = tr("MANSIONVIEW_FARMLEAVE") % character.get_short_name()
	leave.get_node('Name').margin_right = 0.0
	leave.get_node('Amount').visible = false
	leave.connect("pressed", self, "on_remove_person", [farm_worker, false])


func toggle_farm_rule(char_id, res, value):
	var character = view.get_character(char_id)
	if character == null:
		return
	character.set_farm_res(res, value)
	rebuild()


#### the room's own order of work ####

#Only a craft room keeps its own list, and only once the estate has bought Ledgers - which
#happens on the master's office, not here. Everything the estate has queued for this
#room's discipline is offered; ticking a recipe puts it on the list, and the order they are
#ticked in is the order the room works them. An empty list means the estate's own order,
#which is what every craft room does without the upgrade.
func build_order_list(current):
	$Body/Columns/LeftScroll/LeftColumn/FarmList.visible = false
	if farm_rules_shown(current):
		build_farm_rules(current)
		return
	var job = RoomTypes.get_work_job(current.type)
	#bought once on the master's office, spent on every craft room the estate has
	var owned = ResourceScripts.game_res.has_ledgers()
	#a real craft discipline, not one of the jobs that only name a room - the estate's recipe
	#queues are the test, since those are what an order would be drawn from
	var crafts = job != null and ResourceScripts.game_res.crafting_lists.has(job + '_material')
	$Body/Columns/LeftScroll/LeftColumn/OrderList.visible = owned and crafts
	$Body/Columns/LeftScroll/LeftColumn/OrderHeader.visible = $Body/Columns/LeftScroll/LeftColumn/OrderList.visible
	if !$Body/Columns/LeftScroll/LeftColumn/OrderList.visible:
		return
	$Body/Columns/LeftScroll/LeftColumn/OrderHeader.text = tr("MANSIONVIEW_ORDERHEADER")
	input_handler.ClearContainer($Body/Columns/LeftScroll/LeftColumn/OrderList)
	var offered = 0
	for queue in [job + '_item', job + '_material']:
		for task_id in ResourceScripts.game_res.crafting_lists[queue]:
			var button = input_handler.DuplicateContainerTemplate($Body/Columns/LeftScroll/LeftColumn/OrderList)
			button.text = order_label(current, task_id)
			button.pressed = current.craft_rules.has(task_id)
			button.connect("pressed", self, "toggle_order", [task_id])
			offered += 1
	if offered == 0:
		var button = input_handler.DuplicateContainerTemplate($Body/Columns/LeftScroll/LeftColumn/OrderList)
		button.text = tr("MANSIONVIEW_NOORDERS")
		button.disabled = true


#The recipe's name, with its place in this room's list in front of it when it is on one.
func order_label(current, task_id):
	var task = ResourceScripts.game_res.tasks_progresses.get(task_id, null)
	var name = tr(task.name) if task != null and task.has('name') else task_id
	var place = current.craft_rules.find(task_id)
	if place < 0:
		return "  %s" % name
	return "%d. %s" % [place + 1, name]


func toggle_order(task_id):
	var current = room()
	if current == null:
		return
	if current.craft_rules.has(task_id):
		current.craft_rules.erase(task_id)
	else:
		current.craft_rules.append(task_id)
	rebuild()


#### picking somebody for a free place ####

func show_candidates(sleeping):
	$Body/Columns/PeopleColumn/CandidateScroll.visible = true
	input_handler.ClearContainer($Body/Columns/PeopleColumn/CandidateScroll/CandidateList)
	var offered = 0
	for char_id in view.resting_characters():
		var character = view.get_character(char_id)
		if character == null:
			continue
		if !sleeping and !character.is_worker():
			continue
		var button = input_handler.DuplicateContainerTemplate(
			$Body/Columns/PeopleColumn/CandidateScroll/CandidateList)
		#drawn the way a resident is, by the same call - a face is how the player tells them
		#apart, and a column of bare names is a column of strangers
		setup_occupant_button(button, character)
		button.connect("pressed", self, "pick_candidate", [char_id, sleeping])
		offered += 1
	if offered == 0:
		var button = input_handler.DuplicateContainerTemplate(
			$Body/Columns/PeopleColumn/CandidateScroll/CandidateList)
		button.get_node('Name').text = tr("MANSIONVIEW_NOCANDIDATES")
		button.get_node('Status').visible = false
		button.get_node('Portrait').texture = null
		button.disabled = true
	update_column_layout()
	settle_body()
	fit_to_body()


func pick_candidate(char_id, sleeping):
	$Body/Columns/PeopleColumn/CandidateScroll.visible = false
	if sleeping:
		view.assign_resident(slot_code, char_id)
	else:
		view.assign_worker(slot_code, char_id)


#### actions ####

func on_move():
	view.start_move(slot_code)


#The floorplan can also be run as its own screen, where its parent has no mansion modules.
#Only the embedded mansion copy follows the same state setter used by the left navigation.
func on_craft():
	var current = room()
	if current == null:
		return
	var job = craft_category_of(current)
	var mansion = view.get_parent()
	#the plan is also used on its own, with no mansion above it - there the button does nothing
	if job == null or mansion == null or !mansion.has_method("mansion_state_set"):
		return
	var screen = craft_screen()
	if screen == null or !screen.has_method("select_category"):
		return
	view.close_card()
	mansion.mansion_state_set('craft')
	screen.select_category(job)


#Demolition is the one action here that cannot be taken back - the room, its improvements
#and its places all go, and the slot comes back empty - so it is asked about first.  The
#room is named in the question, because the card can be opened on any of them.
func on_demolish():
	pending_demolish = slot_code
	var current = room()
	var room_name = tr(RoomTypes.get_name_key(current.type)) if current != null else ""
	view.set_card_aside(true)
	var question = input_handler.get_spec_node(input_handler.NODE_YESORNOPANEL,
		[self, 'confirm_demolish', 'cancel_demolish',
		tr("MANSIONVIEW_DEMOLISHCONFIRM") % room_name])
	#The card comes back up when the question goes away by any route.  Answering is not the
	#only one - the panel also closes on a click beside it, and then neither answer runs.
	if !question.is_connected("popup_hide", self, "on_question_closed"):
		question.connect("popup_hide", self, "on_question_closed")


func confirm_demolish():
	view.set_card_aside(false)
	if pending_demolish == '':
		return
	var slot = pending_demolish
	pending_demolish = ''
	view.demolish(slot)


func cancel_demolish():
	pending_demolish = ''
	view.set_card_aside(false)


#The panel hides itself before it calls back, so this only brings the card back - clearing
#the pending slot here would drop the answer on its way in.
func on_question_closed():
	view.set_card_aside(false)


func on_repair():
	view.start_repair(slot_code)


func on_cancel():
	view.request_cancel_build(slot_code)
