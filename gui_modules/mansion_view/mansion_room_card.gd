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

#A finished improvement is lit, not greyed: grey is what a row wears when something is
#missing, which is the one thing "at its best" does not mean.  The frame is a shared
#texture - five scenes draw rows with it - so this tints the row rather than giving it a
#stylebox of its own.  The multiplier is not picked by eye: it maps the frame's own line,
#RGB(115, 99, 83), onto the gold the buttons inside it are bordered with, so the frame and
#the buttons read as the same gold.  self_modulate paints the panel alone, so the icon,
#the text and the button inside keep their own colours.
const MAXED_TINT = Color(2.16, 1.96, 0.77, 1)
#An improvement waiting on a lesson bought elsewhere. Dimmer than the frame's own colour, so
#the row reads as "not yet" rather than as "cannot afford".
const LOCKED_TINT = Color(0.55, 0.55, 0.55, 1)
const LocationTasks = preload("res://gui_modules/mansion_view/mansion_location_tasks.gd")

#The farm hand whose produce is on show, lit the way the selected panel is on the service
#screen - warm and a little brighter, so the list below plainly belongs to that face.
const SELECTED_TINT = Color(1.35, 1.22, 0.85, 1)

#what Body's own margins take off the card, top and bottom together
const BODY_MARGINS = 24
const DEFAULT_CARD_WIDTH = 460
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
var selected_autobuy_code = ''


#What the room IS - what it is for, what it gives the estate, how it may be improved, and
#whether it stays where it is at all - stands in a panel beside the card. The card itself is
#what is done in the room this turn and who is doing it, which is what the player came for.
func details():
	return view.get_node("Overlay/RoomDetails")


func detail(path):
	return details().get_node("Body/DetailsScroll/DetailsColumn/" + path)


func setup(view_node):
	view = view_node
	$CloseButton.connect("pressed", view, "close_card")
	detail("Actions/MoveButton").connect("pressed", self, "on_move")
	$Body/Columns/LeftScroll/LeftColumn/Actions/CraftButton.connect("pressed", self, "on_craft")
	$Body/Columns/LeftScroll/LeftColumn/AutobuyButton.connect(
		"pressed", self, "open_autobuy_panel")
	detail("Actions/DemolishButton").connect("pressed", self, "on_demolish")
	$Body/Columns/LeftScroll/LeftColumn/RepairButton.connect("pressed", self, "on_repair")
	$Body/Columns/LeftScroll/LeftColumn/CancelButton.connect("pressed", self, "on_cancel")
	$Body/Columns/LeftScroll/LeftColumn/SexButton.connect("pressed", self, "open_sex_selection")
	$Body/Columns/LeftScroll/LeftColumn/InventoryButton.connect("pressed", self, "on_inventory")
	$Body/Columns/LeftScroll/LeftColumn/SalvageButton.connect("pressed", self, "on_salvage")
	autobuy_panel().get_node("CloseButton").connect("pressed", self, "close_autobuy_panel")
	autobuy_panel().get_node("Body/AddRow/AddButton").connect(
		"pressed", self, "add_autobuy_rule")
	autobuy_panel().get_node("Body/ChoiceField").connect(
		"pressed", self, "toggle_autobuy_choice_list")
	autosell_panel().get_node("CloseButton").connect("pressed", self, "close_autosell_panel")
	setup_standing_order_number(autobuy_panel().get_node("Body/AddRow/Level"), 1)
	style_standing_order_scrollbar(autobuy_panel().get_node("Body/RuleScroll"))
	style_standing_order_scrollbar(autobuy_panel().get_node(
		"ChoicePopup/ListPanel/ChoiceScroll"))
	style_standing_order_scrollbar(autosell_panel().get_node("Body/RuleScroll"))
	style_standing_order_scrollbar($Body/Columns/LeftScroll)
	style_standing_order_scrollbar($Body/Columns/LeftScroll/LeftColumn/PeopleColumn/CandidateScroll)
	style_standing_order_scrollbar(details().get_node("Body/DetailsScroll"))
	register_tutorial_buttons()
	visible = false


#### the hard tutorial ####

#The card is one panel that puts on four faces, so which of these answers anything depends on
#the slot it is currently open on. A face that is not showing answers null and the tutorial
#simply keeps looking - see mansion_view.register_tutorial_buttons().
func register_tutorial_buttons():
	input_handler.register_btn_source('mansion_repair_btn', self, 'tut_get_repair_btn')
	input_handler.register_btn_source('mansion_card_craft_btn', self, 'tut_get_craft_btn')
	input_handler.register_btn_source('mansion_build_kitchen', self, 'tut_get_build_kitchen_btn')
	input_handler.register_btn_source('mansion_card_inventory_btn', self, 'tut_get_inventory_btn')


func tut_get_repair_btn():
	var button = $Body/Columns/LeftScroll/LeftColumn/RepairButton
	return button if visible and button.visible else null


func tut_get_inventory_btn():
	var button = $Body/Columns/LeftScroll/LeftColumn/InventoryButton
	return button if visible and button.visible else null


func tut_get_craft_btn():
	var button = $Body/Columns/LeftScroll/LeftColumn/Actions/CraftButton
	return button if visible and button.visible else null


#The catalogue is rebuilt row by row on every open, and each row remembers which room it
#offers (setup_build_row), so the kitchen is found by what it builds rather than by position -
#the list is filtered by what the slot will take and the order is not fixed.
func tut_get_build_kitchen_btn():
	if !visible or !$Body/BuildList.visible:
		return null
	for row in $Body/BuildList.get_children():
		if row.is_queued_for_deletion() or !row.visible:
			continue
		if row.get_meta('type', '') == 'kitchen':
			return row.get_node('Action')
	return null


func open(code, anchor_rect):
	slot_code = code
	farm_worker = null
	visible = true
	rebuild()
	settle_body()
	fit_to_body()
	position_near(anchor_rect)
	place_details()


#The card was a fixed 420x780 whatever it had to say. Floating over the whole screen rather
#than inside a panel, that meant most of it was empty board laid across the mansion, so it
#takes the height its sections actually asked for instead.
func fit_to_body():
	var body_minimum = $Body.get_combined_minimum_size().y
	var columns_minimum = $Body/Columns.get_combined_minimum_size().y
	var left_minimum = $Body/Columns/LeftScroll/LeftColumn.get_combined_minimum_size().y
	var people_minimum = 0.0
	if $Body/Columns/LeftScroll/LeftColumn/PeopleColumn.visible:
		people_minimum = $Body/Columns/LeftScroll/LeftColumn/PeopleColumn.get_combined_minimum_size().y
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
	#Parents first. A container sizes its children, so sorting a row before the column above it
	#has decided how wide that row is lays the row out against a width it is about to lose -
	#which is how the title's mark ended up sitting at the width it was drawn with in the editor
	#rather than beside the name.
	node.notification(Container.NOTIFICATION_SORT_CHILDREN)
	for child in node.get_children():
		if child is Container:
			settle_container(child)


#The card is half of a pair now - the room on the left, what the room is on the right - and
#between them they are most of the screen wide. Chasing the slot with that put one half or the
#other against an edge, so the pair opens in the middle and the plan is what stays put.
func position_near(_anchor_rect = null):
	var screen = get_viewport_rect().size
	var pair = rect_size.x
	if details().visible:
		pair += DETAILS_GAP + DETAILS_WIDTH
	var pos = Vector2()
	pos.x = (screen.x - pair) / 2.0
	pos.y = (screen.y - rect_size.y) / 2.0 if rect_size.y < screen.y else 8.0
	pos.x = clamp(pos.x, 8, max(8, screen.x - pair - 8))
	pos.y = clamp(pos.y, 8, max(8, screen.y - rect_size.y - 8))
	rect_global_position = pos


#The panel stands against the card's right edge and matches its height, so the two read as one
#thing in two halves rather than as a window that happens to be open nearby. If the screen ends
#before it does, it goes to the card's other side instead.
const DETAILS_GAP = 12
#one card's worth, so the pair reads as two halves of the same thing
const DETAILS_WIDTH = 460


func place_details():
	var panel = details()
	if !panel.visible:
		return
	var screen = get_viewport_rect().size
	#Matching the card's height squeezed a room's whole improvement list into whatever the card
	#happened to need, which for a room with two work slots is nothing at all. The panel asks
	#its own sections how tall they are, the way the card does, and stops at the screen.
	settle_container(panel.get_node("Body"))
	var body = panel.get_node("Body")
	var column = body.get_node("DetailsScroll/DetailsColumn")
	var wanted = column.get_combined_minimum_size().y + BODY_MARGINS
	panel.rect_size = Vector2(panel.rect_size.x,
		clamp(max(wanted, rect_size.y), 120, screen.y - 16))
	#the pair was centred as one; each half is settled on the middle line of its own height so
	#a tall list of improvements does not hang off the bottom beside a short card
	var x = rect_global_position.x + rect_size.x + DETAILS_GAP
	var y = clamp((screen.y - panel.rect_size.y) / 2.0, 8, max(8, screen.y - panel.rect_size.y - 8))
	panel.rect_global_position = Vector2(max(8, x), y)
	settle_container(panel.get_node("Body"))


#The room's own prose, its bonuses, what may be done to the building and how far it can be
#improved. Empty ground has none of that - the card is a catalogue there - so the panel stays
#away until there is a room to talk about.
func build_details():
	var panel = details()
	panel.visible = visible and !$Body/BuildList.visible
	if !panel.visible:
		return
	var room_data = room()
	#Moving a room and pulling it down are things done to a room. Rubble has none - it is
	#cleared out, which is the card's own button - and neither has a slot with scaffolding on
	#it and nothing underneath. Both buttons are set up in build_for_room(), so leaving the row
	#showing here would also show whatever state the last room left on them.
	detail("Actions").visible = room_data != null and (detail("Actions/MoveButton").visible
		or !detail("Actions/DemolishButton").disabled)
	var hint = "" if room_data == null else tr(RoomTypes.get_descript_key(room_data.type))
	var help = $Body/Columns/LeftScroll/LeftColumn/TitleRow/HelpButton
	#only the rooms that ask for it - see 'help' in mansion_room_types.gd
	help.visible = hint != "" and RoomTypes.shows_help(room_data.type)
	if help.visible:
		globals.connecttexttooltip(help, hint, true, view.get_node("Overlay/TextTooltip"))
	#Rubble has nothing to say here - no bonuses, nothing to move or pull down, nothing to
	#improve - and an empty panel standing beside the card is worse than no panel. Asked of the
	#sections themselves rather than of the slot's state, so a room that happens to have none
	#of the four is treated the same way.
	panel.visible = has_details()


func has_details():
	for section in details().get_node("Body/DetailsScroll/DetailsColumn").get_children():
		if section.visible:
			return true
	return false


func room():
	return view.get_room(slot_code)


func build_data():
	return MansionLayout.get_build(view.current_floor(), slot_code)


func rebuild():
	pending_demolish = ''
	$Body/Columns/LeftScroll.scroll_vertical = 0
	set_card_width(DEFAULT_CARD_WIDTH)
	$Body/Columns/LeftScroll/LeftColumn/PeopleColumn.visible = false
	$Body/Columns/LeftScroll/LeftColumn/PeopleColumn/CandidateScroll.visible = false
	$Body/Columns/LeftScroll/LeftColumn/Actions/CraftButton.visible = false
	$Body/Columns/LeftScroll/LeftColumn/AutobuyButton.visible = false
	$Body/Columns/LeftScroll/LeftColumn/InventoryButton.visible = false
	$Body/Columns/LeftScroll/LeftColumn/SalvageButton.visible = false
	#Set again by build_details() for a room that asks for it. Cleared here because that runs
	#only when there is a room to explain: on empty ground the card is a catalogue, and the
	#mark was left standing beside "Build here" from whatever was opened before it.
	$Body/Columns/LeftScroll/LeftColumn/TitleRow/HelpButton.visible = false
	$Body/Columns/LeftScroll/LeftColumn/OrderHeader.visible = false
	$Body/Columns/LeftScroll/LeftColumn/OrderList.visible = false
	$Body/Columns/LeftScroll/LeftColumn/FarmList.visible = false
	$Body/Columns/LeftScroll/LeftColumn/FarmHeader.visible = false
	$Body/Columns/LeftScroll/LeftColumn/CancelButton.visible = false
	$Body/Columns/LeftScroll/LeftColumn/YieldHeader.visible = false
	$Body/Columns/LeftScroll/LeftColumn/YieldList.visible = false
	$Body/Columns/LeftScroll/LeftColumn/ResidentsHeader.visible = false
	$Body/Columns/LeftScroll/LeftColumn/ResidentsGrid.visible = false
	$Body/Columns/LeftScroll/LeftColumn/CompanionHeader.visible = false
	$Body/Columns/LeftScroll/LeftColumn/CompanionGrid.visible = false
	detail("UpgradeHeader").visible = false
	detail("UpgradeList").visible = false
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
	#Above the catalogue the column holds nothing but the words "Build here". Told to stretch it
	#opened a band of empty board between the title and the first room on offer; told to shrink
	#it collapsed to nothing, because a ScrollContainer asks for no height of its own. So it is
	#given the height its one row actually needs - measured after the empty sections are hidden.
	var scroll = $Body/Columns/LeftScroll
	var band = 0.0
	if $Body/BuildList.visible:
		band = scroll.get_node("LeftColumn").get_combined_minimum_size().y
	scroll.rect_min_size.y = band
	build_details()


func set_card_width(width):
	rect_min_size.x = width
	rect_size.x = width


#The people side is optional. Hiding its container, rather than only its children, removes
#both its minimum width and the HBox gap, so rooms without places keep the compact card.
#The catalogue is deliberately outside Columns and therefore keeps all three rows abreast.
func update_column_layout():
	var people = $Body/Columns/LeftScroll/LeftColumn/PeopleColumn
	people.visible = $Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Occupants.visible \
		or $Body/Columns/LeftScroll/LeftColumn/PeopleColumn/CandidateScroll.visible
	set_card_width(BUILD_CARD_WIDTH if $Body/BuildList.visible else DEFAULT_CARD_WIDTH)
	#Above the catalogue the column holds nothing but the words "Build here". Left stretching,
	#it took every pixel the card had spare and opened a band of empty board between the title
	#and the first room on offer.
	$Body/Columns.size_flags_vertical = 0 if $Body/BuildList.visible else SIZE_EXPAND_FILL


#Empty card sections should take no space. The fixed minimums on the wrapped labels are
#needed when they contain text, but were leaving a large blank middle in build and repair
#cards when their strings were deliberately empty.
func update_text_sections():
	for label in [$Body/Columns/LeftScroll/LeftColumn/Subtitle, $Body/Columns/LeftScroll/LeftColumn/Descript, detail("Functions")]:
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
	$Body/Columns/LeftScroll/LeftColumn/TitleRow/Title.text = tr("MANSIONVIEW_BROKEN")
	$Body/Columns/LeftScroll/LeftColumn/Subtitle.text = ""
	$Body/Columns/LeftScroll/LeftColumn/Descript.text = tr("MANSIONVIEW_BROKENHINT")
	detail("Functions").text = ""
	$Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Occupants.visible = false
	$Body/Columns/LeftScroll/LeftColumn/Actions.visible = false
	$Body/BuildList.visible = false
	$Body/Columns/LeftScroll/LeftColumn/RepairButton.visible = true
	$Body/Columns/LeftScroll/LeftColumn/RepairButton.text = tr("MANSIONVIEW_REPAIR")


#### under construction ####

#A slot with scaffolding on it: what is going up, how far along, and the way out.
func build_for_scaffolding():
	var build = build_data()
	$Body/Columns/LeftScroll/LeftColumn/TitleRow/Title.text = view.build_label(build)
	$Body/Columns/LeftScroll/LeftColumn/Subtitle.text = view.build_eta_text(build)
	#How far along the work is belongs beside the hint about it, in the card. Left in the side
	#panel it was the only thing standing there, which made a whole second panel open to say
	#one line.
	$Body/Columns/LeftScroll/LeftColumn/Descript.text = "%s\n%s %d%%" % [
		tr("MANSIONVIEW_BUILDINGHINT"), tr("MANSIONVIEW_PROGRESS"),
		int(build.progress * 100.0 / max(1.0, build.limit))]
	detail("Functions").text = ""
	build_builder_places(build)
	$Body/Columns/LeftScroll/LeftColumn/Actions.visible = false
	$Body/BuildList.visible = false
	$Body/Columns/LeftScroll/LeftColumn/RepairButton.visible = false
	$Body/Columns/LeftScroll/LeftColumn/CancelButton.visible = true
	$Body/Columns/LeftScroll/LeftColumn/CancelButton.text = tr("MANSIONVIEW_CANCELBUILD")


#Scaffolding has places of its own - one always, more if the household's builders upgrade has
#widened it - and they were only ever drawn on the plan behind the card. A card that says
#nobody is building this should be the place to do something about it.
func build_builder_places(build):
	var section = $Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Occupants
	var places = MansionLayout.build_capacity(room(),
		ResourceScripts.game_res.extra_builder_slots())
	section.visible = places > 0
	$Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Companions.visible = false
	if !section.visible:
		return
	fill_people_group(section, tr("MANSIONVIEW_BUILDERS"), view.build_workers(build),
		places, true, false, false, true)


#### empty: what can be built here ####

func build_for_empty():
	set_card_width(BUILD_CARD_WIDTH)
	$Body/Columns/LeftScroll/LeftColumn/TitleRow/Title.text = tr("MANSIONVIEW_BUILDHERE")
	$Body/Columns/LeftScroll/LeftColumn/Subtitle.text = ""
	$Body/Columns/LeftScroll/LeftColumn/Descript.text = ""
	detail("Functions").text = ""
	$Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Occupants.visible = false
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
	build_cost_icons(row.get_node('Costs'), data.build_cost, data.get('build_progress', 0))
	var strip = cost_strip_height(row.get_node('Costs'))
	row.get_node('Costs').margin_bottom = row.get_node('Costs').margin_top + strip
	row.rect_min_size.y = max(84.0, row.get_node('Costs').margin_bottom + 4)

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
	$Body/Columns/LeftScroll/LeftColumn/TitleRow/Title.text = tr(RoomTypes.get_name_key(current.type))
	#Capacity belongs to the people section below; printing it here as well made the card
	#announce the same Beds/Workplaces count twice.
	$Body/Columns/LeftScroll/LeftColumn/Subtitle.text = ""
	$Body/Columns/LeftScroll/LeftColumn/Descript.text = tr(RoomTypes.get_descript_key(current.type))
	detail("Functions").text = upgrades_text(current)
	build_yield_list(current)
	build_craft_button(current)
	build_sex_button(current)
	build_salvage_button(current)
	build_inventory_button(current)
	build_autobuy_button(current)

	detail("Actions/DemolishButton").disabled = !MansionLayout.can_demolish(view.layout(), view.floor_index(), slot_code).ok
	build_move_button()
	build_people(current)
	build_order_list(current)
	build_upgrade_list(current)
	build_residents(current)


#Which disciplines have a craft screen is the craft screen's own list, not a copy of it kept
#here: a fifth one added there would otherwise leave its room without the button and nobody
#would think to look in this file.
func craft_screen():
	if view.get_parent() == null:
		return null
	return view.get_parent().get_node_or_null("MansionCraftModule")


func craft_category_of(current):
	var job = RoomTypes.get_craft_menu(current.type)
	if job == null:
		return null
	var screen = craft_screen()
	if screen == null or !('craftcategories' in screen):
		return null
	return job if screen.craftcategories.has(job) else null


#The trade itself rather than "open the craft menu": the room is a forge or a still, and the
#button that opens its bench should read as the thing it makes. The name is taken from the
#craft screen's own category button, so the two cannot end up calling it different things -
#their keys are not built to a pattern (BLACKSMITH, TASKCOOKING, CRAFTTAILORING...).
func craft_category_name(job):
	var screen = craft_screen()
	var path = "categories/%s/Label" % str(job)
	if screen == null or !screen.has_node(path):
		return tr("MANSIONVIEW_CRAFT")
	return tr(screen.get_node(path).text)


func build_craft_button(current):
	var button = $Body/Columns/LeftScroll/LeftColumn/Actions/CraftButton
	var job = craft_category_of(current)
	button.visible = job != null
	if button.visible:
		button.text = craft_category_name(job)


#Arranging a night is a thing done in the master's own room rather than from a rail of icons
#down the side of the screen, which is where it used to hang with no bed anywhere near it.
func build_sex_button(current):
	var button = $Body/Columns/LeftScroll/LeftColumn/SexButton
	button.visible = RoomTypes.get_type(current.type).master_only
	if button.visible:
		button.text = tr("LMMDATE")


func open_sex_selection():
	var mansion = view.get_parent()
	if mansion == null or !mansion.has_method('open_sex_selection'):
		return
	view.close_card()
	mansion.open_sex_selection()


#What the estate keeps is kept here, so the shelves are where the chest is opened from. The
#screen it opens is the one the rail opens, asked for through the rail itself rather than
#opened a second way of its own.
#The bench in the forge: taking gear apart for its materials. Only once it is built - the row
#in the improvements panel is where it comes from.
func build_salvage_button(current):
	var button = $Body/Columns/LeftScroll/LeftColumn/SalvageButton
	button.visible = MansionLayout.upgrade_level(current, 'salvage_bench') > 0
	if button.visible:
		button.text = tr("MANSIONVIEW_SALVAGE")


func on_salvage():
	var mansion = view.get_parent()
	if mansion == null or !mansion.has_method('open_disassembly'):
		return
	view.close_card()
	mansion.open_disassembly()


func build_inventory_button(current):
	var button = $Body/Columns/LeftScroll/LeftColumn/InventoryButton
	button.visible = RoomTypes.has_tag(current.type, 'storage')
	if button.visible:
		button.text = tr("LMMINVENTORY")


func on_inventory():
	var mansion = view.get_parent()
	if mansion == null or mansion.get("MenuModule") == null:
		return
	view.close_card()
	mansion.MenuModule.open_inventory()


func build_autobuy_button(current):
	var button = $Body/Columns/LeftScroll/LeftColumn/AutobuyButton
	button.visible = view.mode == 'work' and RoomTypes.has_tag(current.type, 'storage') \
		and ResourceScripts.game_res.has_autobuy()
	if button.visible:
		button.text = tr("MANSIONVIEW_AUTOBUY_BUTTON")


#### standing orders ####

func autobuy_panel():
	return view.get_node("Overlay/AutobuyPanel")


func autosell_panel():
	return view.get_node("Overlay/AutosellPanel")


func open_autobuy_panel():
	build_autobuy_panel()
	view.set_card_aside(true)
	autosell_panel().visible = false
	autobuy_panel().visible = true


func close_autobuy_panel():
	close_autobuy_choice_list()
	autobuy_panel().visible = false
	view.set_card_aside(false)


func close_autosell_panel():
	autosell_panel().visible = false
	view.set_card_aside(false)


func build_autobuy_panel():
	var panel = autobuy_panel()
	panel.get_node("Body/Title").text = tr("MANSIONVIEW_AUTOBUY_TITLE")
	panel.get_node("Body/Explanation").text = tr("MANSIONVIEW_AUTOBUY_EXPLAIN")
	panel.get_node("Body/RuleHeader/Item").text = tr("MANSIONVIEW_AUTOBUY_ITEM")
	panel.get_node("Body/RuleHeader/Held").text = tr("MANSIONVIEW_AUTOBUY_HELD")
	panel.get_node("Body/RuleHeader/Level").text = tr("MANSIONVIEW_AUTOBUY_LEVEL")
	panel.get_node("Body/RuleHeader/Price").text = tr("MANSIONVIEW_AUTOBUY_PRICE")
	panel.get_node("Body/AddTitle").text = tr("MANSIONVIEW_AUTOBUY_ADD_TITLE")
	panel.get_node("Body/AddRow/AddButton").text = tr("MANSIONVIEW_AUTOBUY_ADD")
	build_autobuy_clerk()
	build_autobuy_rules()
	build_autobuy_choices()


#Nothing opens this sketch yet; it is kept intact because standing sales are planned for a
#later pass and the panel records the intended mansion presentation for that work.
func build_autosell_panel():
	var panel = autosell_panel()
	panel.get_node("Body/Title").text = tr("MANSIONVIEW_AUTOSELL_TITLE")
	panel.get_node("Body/Explanation").text = tr("MANSIONVIEW_AUTOSELL_EXPLAIN")
	panel.get_node("Body/NotInUse").text = tr("MANSIONVIEW_AUTOSELL_NOT_IN_USE")
	panel.get_node("Body/RuleHeader/Item").text = tr("MANSIONVIEW_AUTOSELL_ITEM")
	panel.get_node("Body/RuleHeader/Held").text = tr("MANSIONVIEW_AUTOSELL_HELD")
	panel.get_node("Body/RuleHeader/Level").text = tr("MANSIONVIEW_AUTOSELL_LEVEL")
	panel.get_node("Body/RuleHeader/Price").text = tr("MANSIONVIEW_AUTOSELL_PRICE")
	panel.get_node("Body/RuleScroll/Empty").text = tr("MANSIONVIEW_AUTOSELL_EMPTY")
	panel.get_node("Body/AddTitle").text = tr("MANSIONVIEW_AUTOSELL_ADD_TITLE")
	panel.get_node("Body/AddRow/Choice").text = tr("MANSIONVIEW_AUTOSELL_UNAVAILABLE")
	panel.get_node("Body/AddRow/AddButton").text = tr("MANSIONVIEW_AUTOSELL_ADD")


func setup_standing_order_number(field, minimum, changed_method = '', changed_args = []):
	field.set_meta('minimum', int(minimum))
	field.set_meta('maximum', 999999)
	field.set_meta('ignore_change', false)
	field.get_node('Value').connect('text_changed', self,
		'standing_order_text_changed', [field, changed_method, changed_args])
	field.get_node('Decrease').connect('pressed', self,
		'nudge_standing_order_number', [field, -1, changed_method, changed_args])
	field.get_node('Increase').connect('pressed', self,
		'nudge_standing_order_number', [field, 1, changed_method, changed_args])


func standing_order_value(field):
	var text = field.get_node('Value').text
	var value = int(text) if text != '' else int(field.get_meta('minimum'))
	return clamp(value, int(field.get_meta('minimum')), int(field.get_meta('maximum')))


func set_standing_order_value(field, value):
	field.set_meta('ignore_change', true)
	field.get_node('Value').text = str(clamp(int(value),
		int(field.get_meta('minimum')), int(field.get_meta('maximum'))))
	field.set_meta('ignore_change', false)


func standing_order_text_changed(text, field, changed_method, changed_args):
	if field.get_meta('ignore_change'):
		return
	var digits = ''
	for character in text:
		if character >= '0' and character <= '9':
			digits += character
	if digits != text:
		field.set_meta('ignore_change', true)
		field.get_node('Value').text = digits
		field.set_meta('ignore_change', false)
	if digits != '' and changed_method != '':
		call_standing_order_change(field, changed_method, changed_args)


func nudge_standing_order_number(field, amount, changed_method, changed_args):
	set_standing_order_value(field, standing_order_value(field) + amount)
	if changed_method != '':
		call_standing_order_change(field, changed_method, changed_args)


func call_standing_order_change(field, changed_method, changed_args):
	var args = [standing_order_value(field)]
	args.append_array(changed_args)
	callv(changed_method, args)


#A theme on the container would replace the gold theme for every control inside it. Scoping
#the mansion's existing scroll theme to the generated bar keeps both resources in their lanes.
func style_standing_order_scrollbar(scroll):
	var source = view.get_node("LocationPanel/Rooms/Button/PeopleScroll")
	scroll.get_v_scrollbar().theme = source.theme


func build_autobuy_clerk():
	var clerk = ResourceScripts.game_res.autobuy_clerk()
	var label = autobuy_panel().get_node("Body/Clerk")
	if clerk == null:
		label.text = tr("MANSIONVIEW_AUTOBUY_NOCLERK")
		return
	var percent = int(round(ResourceScripts.game_res.autobuy_price_mod(clerk) * 100.0))
	label.text = tr("MANSIONVIEW_AUTOBUY_CLERK") % [clerk.get_short_name(), percent]


func build_autobuy_rules():
	var res = ResourceScripts.game_res
	var list = autobuy_panel().get_node("Body/RuleScroll/RuleList")
	input_handler.ClearContainer(list, ['Rule'])
	var count = 0
	for rule in res.autobuy_rules:
		var code = str(rule.get('code', ''))
		if code == '':
			continue
		var row = input_handler.DuplicateContainerTemplate(list, 'Rule')
		row.get_node("Icon").texture = autobuy_icon(code)
		row.get_node("Name").text = res.autobuy_name(code)
		row.get_node("Held").text = str(res.autobuy_held(code))
		var each = int(max(1, round(res.autobuy_price(code) * \
			res.autobuy_price_mod(res.autobuy_clerk()))))
		row.get_node("Price").text = tr("MANSIONVIEW_AUTOBUY_EACH") % each
		var level = row.get_node("Level")
		setup_standing_order_number(level, 0, "change_autobuy_level", [code])
		set_standing_order_value(level, res.autobuy_level(code))
		var remove = row.get_node("Remove")
		remove.text = tr("MANSIONVIEW_AUTOBUY_REMOVE")
		remove.connect("pressed", self, "remove_autobuy_rule", [code])
		count += 1
	var empty = autobuy_panel().get_node("Body/Empty")
	empty.visible = count == 0
	empty.text = tr("MANSIONVIEW_AUTOBUY_EMPTY")


func autobuy_icon(code):
	if Items.materiallist.has(code):
		return Items.materiallist[code].icon
	if Items.itemlist.has(code):
		return Items.itemlist[code].icon
	return null


func change_autobuy_level(value, code):
	ResourceScripts.game_res.set_autobuy_rule(code, int(value))


func remove_autobuy_rule(code):
	ResourceScripts.game_res.clear_autobuy_rule(code)
	build_autobuy_rules()
	build_autobuy_choices()


#A usable stack may be represented by several inventory entries, but it is one market order.
func autobuy_choices():
	var res = ResourceScripts.game_res
	var choices = []
	for code in res.materials:
		var free = res.autobuy_level(code) == 0 and !res.is_quest_good(code)
		if int(res.materials[code]) > 0 and free:
			choices.append([res.autobuy_name(code), code])
	for item in res.items.values():
		var code = str(item.itembase)
		if item.amount <= 0 or !Items.itemlist.has(code):
			continue
		if Items.itemlist[code].type != 'usable' or res.autobuy_level(code) > 0:
			continue
		if res.is_quest_good(code):
			continue
		var duplicate = false
		for entry in choices:
			if entry[1] == code:
				duplicate = true
				break
		if !duplicate:
			choices.append([res.autobuy_name(code), code])
	choices.sort_custom(self, "sort_autobuy_choices")
	return choices


func sort_autobuy_choices(first, second):
	return first[0].nocasecmp_to(second[0]) < 0


func build_autobuy_choices():
	var panel = autobuy_panel()
	var list = panel.get_node("ChoicePopup/ListPanel/ChoiceScroll/ChoiceList")
	input_handler.ClearContainer(list, ['Choice'])
	close_autobuy_choice_list()
	var choices = autobuy_choices()
	var selected_available = false
	for entry in choices:
		if entry[1] == selected_autobuy_code:
			selected_available = true
			break
	if !selected_available:
		selected_autobuy_code = '' if choices.empty() else str(choices[0][1])
	for entry in choices:
		var row = input_handler.DuplicateContainerTemplate(list, 'Choice')
		var code = str(entry[1])
		row.set_meta('code', code)
		row.get_node("Icon").texture = autobuy_icon(code)
		row.get_node("Name").text = entry[0]
		row.get_node("Held").text = str(ResourceScripts.game_res.autobuy_held(code))
		row.connect("pressed", self, "select_autobuy_choice", [code])
	var has_choice = !choices.empty()
	panel.get_node("Body/ChoiceField").visible = has_choice
	panel.get_node("Body/ChoiceEmpty").visible = !has_choice
	panel.get_node("Body/ChoiceEmpty").text = tr("MANSIONVIEW_AUTOBUY_NOTHING_TO_ADD")
	panel.get_node("Body/AddRow/AddButton").disabled = !has_choice
	if has_choice:
		select_autobuy_choice(selected_autobuy_code)


func select_autobuy_choice(code):
	if code == '':
		return
	selected_autobuy_code = str(code)
	var field = autobuy_panel().get_node("Body/ChoiceField")
	field.get_node("Icon").texture = autobuy_icon(selected_autobuy_code)
	field.get_node("Name").text = ResourceScripts.game_res.autobuy_name(selected_autobuy_code)
	field.get_node("Held").text = str(
		ResourceScripts.game_res.autobuy_held(selected_autobuy_code))
	set_standing_order_value(autobuy_panel().get_node("Body/AddRow/Level"), max(
		1, ResourceScripts.game_res.autobuy_held(selected_autobuy_code)))
	close_autobuy_choice_list()


func toggle_autobuy_choice_list():
	var popup = autobuy_panel().get_node("ChoicePopup")
	if popup.visible:
		close_autobuy_choice_list()
		return
	place_autobuy_choice_list()
	popup.visible = true


func place_autobuy_choice_list():
	var panel = autobuy_panel()
	var field = panel.get_node("Body/ChoiceField")
	var list_panel = panel.get_node("ChoicePopup/ListPanel")
	var field_position = field.rect_global_position - panel.rect_global_position
	var list_height = 148.0
	var list_y = field_position.y + field.rect_size.y + 2.0
	if list_y + list_height > panel.rect_size.y - 8.0:
		list_y = field_position.y - list_height - 2.0
	list_panel.rect_position = Vector2(field_position.x, max(8.0, list_y))
	list_panel.rect_size = Vector2(field.rect_size.x, list_height)


func close_autobuy_choice_list():
	autobuy_panel().get_node("ChoicePopup").visible = false


func _input(event):
	if !(event is InputEventMouseButton) or event.button_index != BUTTON_LEFT or !event.pressed:
		return
	var popup = autobuy_panel().get_node("ChoicePopup")
	if !popup.visible:
		return
	var list_panel = popup.get_node("ListPanel")
	if !Rect2(list_panel.rect_global_position, list_panel.rect_size).has_point(event.position):
		close_autobuy_choice_list()


func add_autobuy_rule():
	var row = autobuy_panel().get_node("Body/AddRow")
	if row.get_node("AddButton").disabled or selected_autobuy_code == '':
		return
	ResourceScripts.game_res.set_autobuy_rule(
		selected_autobuy_code, standing_order_value(row.get_node("Level")))
	build_autobuy_rules()
	build_autobuy_choices()


#Grounds gathering buildings show their production table on their own card. Other mansion
#rooms have no gathering entry, so both parts of the section disappear from the VBox.
func build_yield_list(current):
	input_handler.ClearContainer($Body/Columns/LeftScroll/LeftColumn/YieldList, ['Row'])
	#A workshop's yield is not a table of chances, it is the one thing on the bench right now -
	#the same section, answering the question that room actually has.
	if build_craft_row(current):
		return
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
		#What the building turns out is worth knowing about as a material - what it sells for,
		#what it is used in - so the row answers with the same tooltip the material has
		#everywhere else, given the card's own panel because this one sits on a CanvasLayer.
		globals.connectmaterialtooltip(row, material, '', null,
			view.get_node("Overlay/ItemTooltip"))


#What this room is making this turn, drawn as one row of the yields section. Answers false for
#anything that is not a craft room with work on the bench, so the section falls through to the
#gathering table it was built for.
func build_craft_row(current):
	var making = ResourceScripts.game_res.room_current_craft(current)
	if making == null:
		return false
	var name = ResourceScripts.game_res.craft_result_name(making)
	var icon = ResourceScripts.game_res.craft_result_icon(making)
	#Modular gear carries no name on its template - the one it is finally called is built out of
	#the materials it is made from - so a workshop turning out a sword has a picture and nothing
	#to write. The row is worth drawing on either of the two.
	if name == "" and icon == null:
		return false
	$Body/Columns/LeftScroll/LeftColumn/YieldHeader.visible = true
	$Body/Columns/LeftScroll/LeftColumn/YieldList.visible = true
	$Body/Columns/LeftScroll/LeftColumn/YieldHeader.text = tr("MANSIONVIEW_MAKINGNOW")
	var row = input_handler.DuplicateContainerTemplate(
		$Body/Columns/LeftScroll/LeftColumn/YieldList, 'Row')
	row.get_node('Icon').texture = icon
	row.get_node('Name').text = name
	row.get_node('Chance').text = ""
	return true


#Moving a room starts here rather than from a mode button on the top bar: the room is
#picked up from its own card, and the screen then waits for somewhere to put it.
func build_move_button():
	var button = detail("Actions/MoveButton")
	#Nothing out on the grounds is moved: a plot is a piece of ground with a building on it,
	#not a room in a plan that can trade places with another. The button is taken away rather
	#than greyed out - there is no arrangement out there for it to be part of.
	#The staircase is structure and stays where it is, so it gets no button either.
	var current = room()
	var fixed = current != null and RoomTypes.is_fixed(current.type)
	button.visible = !fixed and !MansionLayout.is_grounds(view.layout(), view.floor_index())
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
	#Shelves are bought a level at a time and each level replaces the last, so the room's own
	#figure is the only way to see what the money went on.
	if RoomTypes.has_tag(current.type, 'storage'):
		lines.append(tr("MANSIONVIEW_STORAGELIMIT") % MansionLayout.storage_capacity(current))
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
	input_handler.ClearContainer(detail("UpgradeList"), ['Row'])
	var codes = RoomTypes.get_type(current.type).upgrades
	detail("UpgradeHeader").visible = !codes.empty()
	detail("UpgradeHeader").text = tr("MANSIONVIEW_ROOMUPGRADES")
	detail("UpgradeList").visible = !codes.empty()
	for code in codes:
		var row = input_handler.DuplicateContainerTemplate(detail("UpgradeList"), 'Row')
		setup_upgrade_row(row, current, code, build)


#An improvement is information plus one action, not one wide mystery button. The row keeps
#its icon, level, effect and material cost visible; only Action is clickable.
func setup_upgrade_row(row, current, code, build):
	var level = MansionLayout.upgrade_level(current, code)
	var max_level = RoomTypes.max_level(code, current.type)
	var next_level = level + 1
	var level_data = RoomTypes.get_level_data(code, next_level, current.type)
	var upgrade_data = RoomTypes.get_upgrade(code, current.type)

	row.self_modulate = Color(1, 1, 1, 1)
	row.set_meta('type', code)
	row.get_node('Title').text = tr(RoomTypes.get_upgrade_name_key(code))
	row.get_node('Level').text = "%d/%d" % [level, max_level]
	row.get_node('Descript').text = tr(RoomTypes.get_upgrade_descript_key(code))
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
		row.get_node('Bonus').text = tr(RoomTypes.get_upgrade_bonus_key(code, level)) if level > 0 else ""
		row.self_modulate = MAXED_TINT
		build_cost_icons(row.get_node('Costs'), {}, 0)
	else:
		row.get_node('Bonus').text = tr(RoomTypes.get_upgrade_bonus_key(code, next_level))
		build_cost_icons(row.get_node('Costs'), level_data.cost,
			level_data.get('progress', 0))
		var check = MansionLayout.can_start_upgrade(view.layout(), view.floor_index(), slot_code, code)
		var locked = ResourceScripts.game_res.upgrade_locked(code)
		action.disabled = locked or !check.ok or !view.can_afford(level_data.cost)
		if locked:
			#greyed rather than hidden: the row is how the player learns the bench exists at all
			row.self_modulate = LOCKED_TINT
		if build != null and build.kind == 'upgrade' and build.target == code:
			action.text = "%d%%" % int(build.progress * 100.0 / max(1.0, build.limit))
			row.self_modulate = Color(1.15, 1.08, 0.78, 1)
		action.connect("pressed", view, "start_upgrade", [slot_code, code])
	fit_decision_row(row)

	#explained by the row, not by the button - see the note in setup_build_row().  A maxed
	#improvement gets no tooltip at all: it would only repeat the level and the bonus the
	#row is already showing, and there is no next step left to describe.
	if !maxed and ResourceScripts.game_res.upgrade_locked(code):
		globals.connecttexttooltip(row, tr("MANSIONVIEW_UPGRADELOCKED"), true,
			view.get_node("Overlay/TextTooltip"))
	elif !maxed:
		#an improvement with nothing left to add says nothing rather than opening an empty panel
		var hint = upgrade_hint(code, level, next_level, current.type)
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
	costs.margin_bottom = costs.margin_top + max(29, cost_strip_height(costs) + 3)
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
	for row in detail("UpgradeList").get_children():
		if !row.visible:
			continue
		var descript = row.get_node('Descript')
		var code = row.get_meta('type')
		if !descript.visible or descript.text != tr(RoomTypes.get_upgrade_descript_key(code)) \
				or !wrapped_label_fits(descript):
			return false
	return true


func upgrade_bonuses_fit():
	for row in detail("UpgradeList").get_children():
		if !row.visible:
			continue
		var bonus = row.get_node('Bonus')
		if !wrapped_label_fits(bonus):
			return false
	return true


#Each resource is its own small readout. A red number answers why the action is unavailable
#without making the player parse a comma-separated sentence on the button.
#The strip a room's price is written on: one cell per material, three to a line, and the work
#the job itself takes as a last cell - a cost like any other, and the one the player is paying
#in days rather than in stock.
const COST_COLUMNS = 3
const COST_ROW_HEIGHT = 26
const COST_ROW_GAP = 3
const ICON_WORK = preload("res://assets/images/gui/inventory/tool_hammer.png")


func build_cost_icons(holder, cost, work = 0):
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
	if work > 0:
		var cell = input_handler.DuplicateContainerTemplate(holder, 'Cost')
		cell.get_node('Icon').texture = ICON_WORK
		cell.get_node('Amount').text = str(int(work))
		cell.get_node('Amount').set('custom_colors/font_color', Color(0.88, 0.88, 0.88))
		globals.connecttexttooltip(cell, tr("MANSIONVIEW_WORKCOST"), true,
			view.get_node("Overlay/TextTooltip"))


#How tall the strip turned out, now that it wraps.
func cost_strip_height(holder):
	var cells = 0
	for cell in holder.get_children():
		if cell.visible:
			cells += 1
	var lines = int(max(1, ceil(float(cells) / COST_COLUMNS)))
	return lines * COST_ROW_HEIGHT + (lines - 1) * COST_ROW_GAP


#Same rule as build_hint(): the row already carries the description and the bonus the next
#level would bring, so the panel adds what it cannot show - what the room has from the level
#it is on now, and what the next one costs in work.
func upgrade_hint(code, level, next_level, room_code = null):
	var parts = []
	if level > 0:
		parts.append("%s: %s" % [tr("MANSIONVIEW_NOW"), tr(RoomTypes.get_upgrade_bonus_key(code, level))])
	var level_data = RoomTypes.get_level_data(code, next_level, room_code)
	if level_data != null:
		parts.append(tr("MANSIONVIEW_WORKUNITS") % int(level_data.progress))
	return PoolStringArray(parts).join("\n")


#Whoever is in the room, in whichever sense the current mode cares about.
func build_people(current):
	var sleeping = view.mode == 'sleep'
	var occupants = current.occupants if sleeping else view.room_workers(current)
	var capacity = MansionLayout.sleep_capacity(current) if sleeping else MansionLayout.work_capacity(current)
	#A building raised to gather something holds its hands on that job, not on a room task of
	#its own, so the card has to ask the job the same way the plot on the grounds does. Without
	#this a mine's card showed no places at all and the people in it could only be seen outside.
	var gather = null if sleeping else LocationTasks.gather_entry_for_room(current.type, slot_code)
	if gather != null:
		occupants = LocationTasks.workers_of(gather.id)
		capacity = int(gather.max_workers)
		$Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Occupants.visible = capacity > 0
	#The master's own bed is held for him however many are added beside it, so while beds are
	#being arranged his room is two groups rather than one list whose first line happens to be
	#his. The same split the card shows while work is arranged, made of real slots here: these
	#can be clicked to seat somebody or turn them out.
	var split = sleeping and capacity > 0 and RoomTypes.get_type(current.type).master_only
	#A tutor's place is not a workplace with a different name: what is done in it decides
	#whether a habit can be worked out of anybody at all, and only somebody who can teach may
	#stand there. Drawn apart for the same reason the master's own bed is.
	var tutor_places = 0 if sleeping else MansionLayout.special_work_slots(current)
	$Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Companions.visible = split or tutor_places > 0
	$Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Occupants.visible = capacity > 0
	if capacity <= 0:
		return
	if tutor_places > 0:
		var tutor = view.special_worker(current)
		var students = []
		for char_id in occupants:
			if char_id != tutor:
				students.append(char_id)
		fill_people_group($Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Occupants,
			tr("MANSIONVIEW_WORKPLACES"), students, max(0, capacity - tutor_places), true, false)
		fill_people_group($Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Companions, tr("MANSIONVIEW_TUTORSLOT"),
			[] if tutor == null else [tutor], tutor_places, false, false, true)
		return
	if split:
		var master = null
		var companions = []
		for char_id in occupants:
			var character = view.get_character(char_id)
			if master == null and character != null and character.is_master():
				master = char_id
			else:
				companions.append(char_id)
		fill_people_group($Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Occupants, tr("MANSIONVIEW_MASTERBED"),
			[] if master == null else [master], 1, false, true)
		fill_people_group($Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Companions,
			tr("MANSIONVIEW_NIGHTCOMPANIONS"), companions, max(0, capacity - 1), true, true)
		return
	$Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Occupants/Header.text = "%s %d/%d" % [
		tr("MANSIONVIEW_BEDS") if sleeping else tr("MANSIONVIEW_WORKPLACES"),
		occupants.size(), capacity]
	var job_id = null if gather == null else gather.id
	input_handler.ClearContainer($Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Occupants/List)
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
		var button = input_handler.DuplicateContainerTemplate($Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Occupants/List)
		setup_occupant_button(button, character)
		if character != null:
			globals.connectslavetooltip(button, character, slave_tooltip())
		if picking:
			if char_id == farm_worker:
				#held down rather than merely tinted: the list below belongs to whoever is
				#pressed, and a tint alone did not read as "this one"
				button.toggle_mode = true
				button.pressed = true
				button.self_modulate = SELECTED_TINT
			button.connect("pressed", self, "select_farm_worker", [char_id])
			globals.connecttexttooltip(button, tr("MANSIONVIEW_FARMPICKHINT"), true,
				view.get_node("Overlay/TextTooltip"))
			continue
		button.connect("pressed", self, "on_remove_person", [char_id, sleeping])
	for _i in range(max(0, capacity - occupants.size())):
		var button = input_handler.DuplicateContainerTemplate($Body/Columns/LeftScroll/LeftColumn/PeopleColumn/Occupants/List)
		setup_empty_occupant_button(button)
		button.connect("pressed", self, "show_candidates", [sleeping, false, job_id])
		globals.connecttexttooltip(button, tr("MANSIONVIEW_EMPTYSLOT"), true,
			view.get_node("Overlay/TextTooltip"))


#One titled group of bed slots, drawn the way the single list is: a face for everyone in a bed,
#a free slot for every bed still empty, and both clickable - out of the room, or into it.
func fill_people_group(section, title, char_ids, places, count_in_title, sleeping,
		tutor_slot = false, builder = false):
	section.get_node('Header').text = title
	if count_in_title:
		section.get_node('Header').text = "%s %d/%d" % [title, char_ids.size(), places]
	input_handler.ClearContainer(section.get_node('List'))
	for char_id in char_ids:
		var button = input_handler.DuplicateContainerTemplate(section.get_node('List'))
		var character = view.get_character(char_id)
		setup_occupant_button(button, character)
		if character != null:
			globals.connectslavetooltip(button, character, slave_tooltip())
		button.connect("pressed", self, "on_remove_person", [char_id, sleeping])
	for _i in range(max(0, places - char_ids.size())):
		var button = input_handler.DuplicateContainerTemplate(section.get_node('List'))
		setup_empty_occupant_button(button)
		button.connect("pressed", self, "show_candidates",
			[sleeping, tutor_slot, null, builder])
		var hint = "MANSIONVIEW_EMPTYSLOT"
		if tutor_slot:
			hint = "MANSIONVIEW_TUTORHINT"
		elif builder:
			hint = "MANSIONVIEW_BUILDINGHINT"
		globals.connecttexttooltip(button, tr(hint), true,
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
	button.get_node('Portrait').texture = null
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
	#its own header rather than the craft rooms' one: the list it names stands below the work
	#slots now - a farm's produce belongs to whoever is standing in it, so the people come first
	var header = $Body/Columns/LeftScroll/LeftColumn/FarmHeader
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


#### what the practice room drills ####

func practice_choice_shown(current):
	if current == null or view.mode == 'sleep':
		return false
	return RoomTypes.has_tag(current.type, 'practice')


#Every habit the pupils in this room could be rid of. Asked of the people actually standing
#there rather than of the trait list: a room is set to work a habit out of somebody, and
#offering one nobody in it has would be a turn spent on nothing.
func practice_habits(current):
	var res = []
	var tutor = view.special_worker(current)
	for char_id in view.room_workers(current):
		if char_id == tutor:
			continue
		var character = view.get_character(char_id)
		if character == null:
			continue
		var code = character.first_negative_trait()
		if code != null and !res.has(code):
			res.append(code)
	return res


func build_practice_choice(current):
	var header = $Body/Columns/LeftScroll/LeftColumn/OrderHeader
	var list = $Body/Columns/LeftScroll/LeftColumn/OrderList
	header.visible = true
	list.visible = true
	header.text = tr("MANSIONVIEW_PRACTICEHEADER")
	input_handler.ClearContainer(list)
	for code in MansionLayout.PRACTICE_STATS:
		var button = input_handler.DuplicateContainerTemplate(list)
		button.text = tr("STAT" + code.to_upper())
		button.pressed = current.practice.target == null and current.practice.stat == code
		button.connect("pressed", self, "set_practice_stat", [code])
	#One row rather than a list of habits: each pupil is worked on the first of their own, so
	#the room is set to mend manners and every one of them mends theirs. Unlearning is the
	#tutor's work, so without one the row is shown greyed rather than hidden - the room says
	#what it could do once somebody is teaching in it.
	var tutor = view.special_worker(current)
	var habits = practice_habits(current)
	var button = input_handler.DuplicateContainerTemplate(list)
	button.text = tr("MANSIONVIEW_PRACTICECORRECT")
	button.pressed = current.practice.target == ResourceScripts.game_res.PRACTICE_CORRECT
	button.disabled = tutor == null or habits.empty()
	if tutor == null:
		globals.connecttexttooltip(button, tr("MANSIONVIEW_PRACTICENOTUTOR"), true,
			view.get_node("Overlay/TextTooltip"))
	elif habits.empty():
		globals.connecttexttooltip(button, tr("MANSIONVIEW_PRACTICENOHABITS"), true,
			view.get_node("Overlay/TextTooltip"))
	else:
		globals.connecttexttooltip(button, practice_habits_text(habits), true,
			view.get_node("Overlay/TextTooltip"))
	button.connect("pressed", self, "set_practice_target",
		[ResourceScripts.game_res.PRACTICE_CORRECT])


func set_practice_stat(code):
	var current = room()
	if current == null:
		return
	current.practice.stat = code
	#a stat and a habit are two different pieces of work, and the progress belongs to the habit
	current.practice.target = null
	current.practice.progress = 0
	rebuild()


#What the room would set about mending, so the one row can name the habits behind it.
func practice_habits_text(habits):
	var names = []
	for code in habits:
		names.append(tr(Traitdata.traits[code].name) if Traitdata.traits.has(code) else code)
	return "%s\n%s" % [tr("MANSIONVIEW_PRACTICECORRECTHINT"), PoolStringArray(names).join(", ")]


func set_practice_target(code):
	var current = room()
	if current == null:
		return
	current.practice.target = null if current.practice.target == code else code
	current.practice.progress = 0
	rebuild()


#### the room's own order of work ####

#Only a craft room keeps its own list, and only once the estate has bought Ledgers - which
#happens on the master's office, not here. Everything the estate has queued for this
#room's discipline is offered; ticking a recipe puts it on the list, and the order they are
#ticked in is the order the room works them. An empty list means the estate's own order,
#which is what every craft room does without the upgrade.
func build_order_list(current):
	$Body/Columns/LeftScroll/LeftColumn/FarmList.visible = false
	$Body/Columns/LeftScroll/LeftColumn/FarmHeader.visible = false
	if farm_rules_shown(current):
		build_farm_rules(current)
		return
	if practice_choice_shown(current):
		build_practice_choice(current)
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


#### who sleeps here ####

#A bedroom has no workplaces, so while work is being arranged its card says nothing about the
#people it is actually for. Their faces go under the improvements: hovering one tells you who
#they are, and clicking opens them in the slave list.
#Beds mode already puts them in the people column, where they can be moved and turned out, so
#this stays out of its way.
func build_residents(current):
	var header = $Body/Columns/LeftScroll/LeftColumn/ResidentsHeader
	var grid = $Body/Columns/LeftScroll/LeftColumn/ResidentsGrid
	var companion_header = $Body/Columns/LeftScroll/LeftColumn/CompanionHeader
	var companion_grid = $Body/Columns/LeftScroll/LeftColumn/CompanionGrid
	var beds = MansionLayout.sleep_capacity(current)
	var shown = view.mode != 'sleep' and beds > 0
	#The master's own bed is never anybody else's, however many are added beside it, so his
	#room is drawn as two groups rather than one row where his bed is merely the first tile.
	var master_room = RoomTypes.get_type(current.type).master_only
	header.visible = shown
	grid.visible = shown
	companion_header.visible = shown and master_room
	companion_grid.visible = shown and master_room
	if !shown:
		return
	if !master_room:
		header.text = "%s %d/%d" % [tr("MANSIONVIEW_BEDS"), current.occupants.size(), beds]
		fill_beds(grid, current.occupants, beds)
		return
	var master = null
	var others = []
	for char_id in current.occupants:
		var character = view.get_character(char_id)
		if character == null:
			continue
		if master == null and character.is_master():
			master = char_id
		else:
			others.append(char_id)
	header.text = tr("MANSIONVIEW_MASTERBED")
	fill_beds(grid, [] if master == null else [master], 1)
	companion_header.text = "%s %d/%d" % [tr("MANSIONVIEW_NIGHTCOMPANIONS"), others.size(),
		max(0, beds - 1)]
	fill_beds(companion_grid, others, max(0, beds - 1))


#One row of bed tiles: a face for everyone in them, then a bare frame for every bed still free.
#The empty ones are inert - beds are arranged in beds mode, and this section is here to be read.
func fill_beds(grid, char_ids, beds):
	input_handler.ClearContainer(grid, ['Button'])
	var drawn = 0
	for char_id in char_ids:
		var character = view.get_character(char_id)
		if character == null:
			continue
		var button = input_handler.DuplicateContainerTemplate(grid, 'Button')
		var portrait = character.get_icon()
		if portrait == null:
			portrait = character.get_class_icon()
		input_handler.queue_portrait(character)
		button.get_node('Portrait').texture = portrait
		globals.connectslavetooltip(button, character, slave_tooltip())
		button.connect("pressed", self, "open_in_slave_list", [char_id])
		drawn += 1
	for _i in range(max(0, beds - drawn)):
		var free_bed = input_handler.DuplicateContainerTemplate(grid, 'Button')
		#An empty tile, not a tile with a question mark in it: the row of frames already reads
		#as beds, and a mark in every spare one made the room look full of strangers.
		free_bed.self_modulate = Color(0.62, 0.62, 0.62, 1)
		free_bed.get_node('Portrait').texture = null
		globals.connecttexttooltip(free_bed, tr("MANSIONVIEW_EMPTYSLOT"), true,
			view.get_node("Overlay/TextTooltip"))


#The shared slave tooltip is added at the tree root, and this card sits on a CanvasLayer, which
#paints over the root whatever order things were added in - the panel would come up behind the
#very card that asked for it. So the layer gets one of its own, made the first time it is
#wanted and kept afterwards.
func slave_tooltip():
	var overlay = view.get_node("Overlay")
	var node = overlay.get_node_or_null("SlaveTooltip")
	if node == null:
		node = load("res://gui_modules/Universal/Modules/SlaveTooltip.tscn").instance()
		node.name = "SlaveTooltip"
		overlay.add_child(node)
	return node


#The slave list is a screen of the mansion module, not of the floorplan, so the card asks the
#module it is embedded in. Run as its own screen there is no module and nothing happens.
func open_in_slave_list(char_id):
	var character = view.get_character(char_id)
	var mansion = view.get_parent()
	if character == null or mansion == null or !mansion.has_method('set_active_person'):
		return
	view.close_card()
	#The list shares its space with the floorplan and sits folded down to its title bar while
	#the rooms are being looked at, so naming somebody changed nothing anybody could see. It is
	#opened first, then told who to show.
	var list = mansion.get_node_or_null("MansionSlaveListModule")
	if list != null and list.has_method('set_slave_list_fold'):
		list.set_slave_list_fold(list.FOLD_FULL)
	mansion.set_active_person(character)
	if list != null:
		call_deferred("expand_in_slave_list", list, character)


#Opening the list only names the person; their own card is a separate thing the list expands.
#Deferred because the cards are built by the rebuild the line above sets going - the one to
#open does not exist yet at the moment it is asked for.
func expand_in_slave_list(list, character):
	if !is_instance_valid(list) or !list.has_method('_on_card_expand_requested'):
		return
	var container = list.get("CardContainer")
	if container == null:
		return
	for node in container.get_children():
		if node.has_meta("slave") and node.get_meta("slave") == character:
			list._on_card_expand_requested(node)
			return


#### picking somebody for a free place ####

#A bed is not work, a tutor teaches rather than produces, and a builder's place raises the room
#instead of running it - none of those three have an output to promise, so the line stays empty.
#Nor does a room whose work makes nothing countable: a store room, a practice room.
func show_candidate_yield(button, character, sleeping, tutor_slot, job_id, builder):
	if !button.has_node('Yield'):
		return
	var label = button.get_node('Yield')
	label.visible = false
	if sleeping or tutor_slot or builder:
		return
	var made = candidate_yield(character, job_id)
	if made <= 0:
		return
	label.text = "+%.1f" % made
	label.visible = true


#The turn's own arithmetic, asked one person at a time. A gather building works its job through
#the task list, so it is asked the way the task panel asks it; everything else is the room's own
#work, multiplied by whatever the room's upgrades add to it - the same two terms game_res.tick()
#multiplies when the turn is counted.
func candidate_yield(character, job_id):
	if character == null:
		return 0.0
	if job_id != null:
		return LocationTasks.production_of(job_id, character)
	var room = room()
	if room == null:
		return 0.0
	var job = RoomTypes.get_work_job(room.type)
	if job == null or job == '':
		return 0.0
	return character.get_job_value(job, false) * MansionLayout.craft_modifier(room)


func show_candidates(sleeping, tutor_slot = false, job_id = null, builder = false):
	$Body/Columns/LeftScroll/LeftColumn/PeopleColumn/CandidateScroll.visible = true
	input_handler.ClearContainer($Body/Columns/LeftScroll/LeftColumn/PeopleColumn/CandidateScroll/CandidateList)
	var offered = 0
	for char_id in view.resting_characters():
		var character = view.get_character(char_id)
		if character == null:
			continue
		if !sleeping and !character.is_worker():
			continue
		#practice_trainer() refuses anybody without the trait, so offering them here would be
		#offering a place that quietly does nothing
		if tutor_slot and !character.check_trait('trainer'):
			continue
		var button = input_handler.DuplicateContainerTemplate(
			$Body/Columns/LeftScroll/LeftColumn/PeopleColumn/CandidateScroll/CandidateList)
		#drawn the way a resident is, by the same call - a face is how the player tells them
		#apart, and a column of bare names is a column of strangers
		setup_occupant_button(button, character)
		#what they would be worth on this particular work, so the choice is made on something
		#other than the order they happen to be listed in. Written here rather than inside
		#setup_occupant_button: that call also draws the narrow rows in the slots above, which
		#have no room for it and no such question to answer
		show_candidate_yield(button, character, sleeping, tutor_slot, job_id, builder)
		button.connect("pressed", self, "pick_candidate",
			[char_id, sleeping, tutor_slot, job_id, builder])
		offered += 1
	if offered == 0:
		var button = input_handler.DuplicateContainerTemplate(
			$Body/Columns/LeftScroll/LeftColumn/PeopleColumn/CandidateScroll/CandidateList)
		button.get_node('Name').text = tr("MANSIONVIEW_NOCANDIDATES")
		button.get_node('Status').visible = false
		button.get_node('Portrait').texture = null
		if button.has_node('Yield'):
			button.get_node('Yield').visible = false
		button.disabled = true
	update_column_layout()
	settle_body()
	fit_to_body()


func pick_candidate(char_id, sleeping, tutor_slot = false, job_id = null, builder = false):
	$Body/Columns/LeftScroll/LeftColumn/PeopleColumn/CandidateScroll.visible = false
	if builder:
		if view.assign_builder(slot_code, char_id):
			rebuild()
			settle_body()
			fit_to_body()
			place_details()
		return
	if job_id != null:
		view.assign_location_worker(job_id, char_id)
		return
	if tutor_slot:
		view.assign_tutor(slot_code, char_id)
		return
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
