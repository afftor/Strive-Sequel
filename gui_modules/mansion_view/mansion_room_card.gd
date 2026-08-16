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

var view = null
var slot_code = ''


func setup(view_node):
	view = view_node
	$CloseButton.connect("pressed", view, "close_card")
	$Actions/DemolishButton.connect("pressed", self, "on_demolish")
	$RepairButton.connect("pressed", self, "on_repair")
	$CancelButton.connect("pressed", self, "on_cancel")
	visible = false


func open(code, anchor_rect):
	slot_code = code
	visible = true
	rebuild()
	position_near(anchor_rect)


#Sits just right of the slot, flips to its left when it would run off the screen.
func position_near(anchor_rect):
	var screen = get_viewport_rect().size
	var pos = Vector2(anchor_rect.end.x + 12, anchor_rect.position.y)
	if pos.x + rect_size.x > screen.x - 8:
		pos.x = anchor_rect.position.x - rect_size.x - 12
	pos.x = clamp(pos.x, 8, max(8, screen.x - rect_size.x - 8))
	pos.y = clamp(pos.y, 8, max(8, screen.y - rect_size.y - 8))
	rect_global_position = pos


func room():
	return view.get_room(slot_code)


func build_data():
	return MansionLayout.get_build(view.current_floor(), slot_code)


func rebuild():
	$CandidateList.visible = false
	$CancelButton.visible = false
	match MansionLayout.slot_status(view.current_floor(), slot_code):
		'broken':
			build_for_broken()
		'empty':
			build_for_empty()
		'building':
			build_for_scaffolding()
		'built':
			build_for_room(room())


#### broken ####

func build_for_broken():
	$Title.text = tr("MANSIONVIEW_BROKEN")
	$Subtitle.text = ""
	$Descript.text = tr("MANSIONVIEW_BROKENHINT")
	$Functions.text = ""
	$Occupants.visible = false
	$Actions.visible = false
	$BuildList.visible = false
	$RepairButton.visible = true
	$RepairButton.text = tr("MANSIONVIEW_REPAIR")


#### under construction ####

#A slot with scaffolding on it: what is going up, how far along, and the way out.
func build_for_scaffolding():
	var build = build_data()
	$Title.text = view.build_label(build)
	$Subtitle.text = view.build_eta_text(build)
	$Descript.text = tr("MANSIONVIEW_BUILDINGHINT")
	$Functions.text = "%s %d%%" % [tr("MANSIONVIEW_PROGRESS"),
		int(build.progress * 100.0 / max(1.0, build.limit))]
	$Occupants.visible = false
	$Actions.visible = false
	$BuildList.visible = false
	$RepairButton.visible = false
	$CancelButton.visible = true
	$CancelButton.text = tr("MANSIONVIEW_CANCELBUILD")


#### empty: what can be built here ####

func build_for_empty():
	$Title.text = tr("MANSIONVIEW_BUILDHERE")
	$Subtitle.text = ""
	$Descript.text = ""
	$Functions.text = ""
	$Occupants.visible = false
	$Actions.visible = false
	$RepairButton.visible = false
	$BuildList.visible = true

	input_handler.ClearContainer($BuildList)
	for code in RoomTypes.get_buildable_codes():
		var check = MansionLayout.can_build(view.layout(), view.floor_index(), slot_code, code)
		var data = RoomTypes.get_type(code)
		var button = input_handler.DuplicateContainerTemplate($BuildList)
		button.set_meta('type', code)
		button.text = "%s   %s" % [tr(RoomTypes.get_name_key(code)), cost_text(data.build_cost)]
		button.disabled = !check.ok or !view.can_afford(data.build_cost)
		button.connect("pressed", view, "start_construct", [slot_code, code])
		globals.connecttexttooltip(button, build_hint(code, check), true)


func build_hint(code, check):
	var text = tr(RoomTypes.get_descript_key(code))
	text += "\n" + slots_text(code)
	text += "\n" + tr("MANSIONVIEW_WORKUNITS") % int(RoomTypes.get_type(code).build_progress)
	if !check.ok:
		text += "\n" + tr(check.reason)
	return text


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
	$BuildList.visible = false
	$RepairButton.visible = false
	$Actions.visible = true
	$Title.text = tr(RoomTypes.get_name_key(current.type))
	$Subtitle.text = room_subtitle(current)
	$Descript.text = tr(RoomTypes.get_descript_key(current.type))
	$Functions.text = upgrades_text(current)

	$Actions/DemolishButton.disabled = !MansionLayout.can_demolish(view.layout(), view.floor_index(), slot_code).ok
	build_people(current)
	build_upgrade_list(current)


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
	var data = RoomTypes.get_type(current.type)
	if data.upkeep > 0:
		lines.append("%s %d" % [tr("MANSIONVIEW_UPKEEP"), data.upkeep])
	var build = build_data()
	if build != null:
		lines.append("%s - %s" % [view.build_label(build), view.build_eta_text(build)])
	return PoolStringArray(lines).join("\n")


#One upgrade at a time per room, so once something is going up the rest are simply shut.
func build_upgrade_list(current):
	var build = build_data()
	$CancelButton.visible = build != null
	if build != null:
		$CancelButton.text = tr("MANSIONVIEW_CANCELBUILD")
	input_handler.ClearContainer($BuildList)
	var codes = RoomTypes.get_type(current.type).upgrades
	$BuildList.visible = !codes.empty()
	for code in codes:
		var level = MansionLayout.upgrade_level(current, code)
		var button = input_handler.DuplicateContainerTemplate($BuildList)
		var next_level = level + 1
		var level_data = RoomUpgrades.get_level_data(code, next_level)
		var name = tr(RoomUpgrades.get_name_key(code))
		if level_data == null:
			button.text = "%s   %s" % [name, tr("MANSIONVIEW_MAXED")]
			button.disabled = true
		else:
			button.text = "%s %d/%d   %s" % [name, level, RoomUpgrades.max_level(code),
				cost_text(level_data.cost)]
			var check = MansionLayout.can_start_upgrade(view.layout(), view.floor_index(), slot_code, code)
			button.disabled = !check.ok or !view.can_afford(level_data.cost)
			button.connect("pressed", view, "start_upgrade", [slot_code, code])
		globals.connecttexttooltip(button, upgrade_hint(code, level, next_level), true)


func upgrade_hint(code, level, next_level):
	var text = tr(RoomUpgrades.get_descript_key(code))
	if level > 0:
		text += "\n%s: %s" % [tr("MANSIONVIEW_NOW"), tr(RoomUpgrades.get_bonus_key(code, level))]
	var level_data = RoomUpgrades.get_level_data(code, next_level)
	if level_data != null:
		text += "\n%s: %s" % [tr("MANSIONVIEW_NEXT"), tr(RoomUpgrades.get_bonus_key(code, next_level))]
		text += "\n" + tr("MANSIONVIEW_WORKUNITS") % int(level_data.progress)
	return text


#Whoever is in the room, in whichever sense the current mode cares about.
func build_people(current):
	var sleeping = view.mode == 'sleep'
	var occupants = current.occupants if sleeping else view.room_workers(current)
	var capacity = MansionLayout.sleep_capacity(current) if sleeping else MansionLayout.work_capacity(current)
	$Occupants.visible = capacity > 0
	if capacity <= 0:
		return
	$Occupants/Header.text = "%s %d/%d" % [
		tr("MANSIONVIEW_BEDS") if sleeping else tr("MANSIONVIEW_WORKPLACES"),
		occupants.size(), capacity]
	input_handler.ClearContainer($Occupants/List)
	for char_id in occupants:
		var character = view.get_character(char_id)
		var button = input_handler.DuplicateContainerTemplate($Occupants/List)
		var name = character.get_short_name() if character != null else "?"
		if character != null and !view.is_present(character):
			name += "  (%s)" % tr("MANSIONVIEW_AWAY")
		button.text = name
		button.connect("pressed", self, "on_remove_person", [char_id, sleeping])
		globals.connecttexttooltip(button, tr("MANSIONVIEW_EVICTHINT"), true)
	for _i in range(max(0, capacity - occupants.size())):
		var button = input_handler.DuplicateContainerTemplate($Occupants/List)
		button.text = tr("MANSIONVIEW_EMPTYSLOT")
		button.connect("pressed", self, "show_candidates", [sleeping])


func on_remove_person(char_id, sleeping):
	if sleeping:
		view.unassign_resident(char_id)
	else:
		view.unassign_worker(char_id)


#### picking somebody for a free place ####

func show_candidates(sleeping):
	$CandidateList.visible = true
	input_handler.ClearContainer($CandidateList)
	var offered = 0
	for char_id in view.resting_characters():
		var character = view.get_character(char_id)
		if character == null:
			continue
		if !sleeping and !character.is_worker():
			continue
		var button = input_handler.DuplicateContainerTemplate($CandidateList)
		button.text = character.get_short_name()
		button.connect("pressed", self, "pick_candidate", [char_id, sleeping])
		offered += 1
	if offered == 0:
		var button = input_handler.DuplicateContainerTemplate($CandidateList)
		button.text = tr("MANSIONVIEW_NOCANDIDATES")
		button.disabled = true


func pick_candidate(char_id, sleeping):
	$CandidateList.visible = false
	if sleeping:
		view.assign_resident(slot_code, char_id)
	else:
		view.assign_worker(slot_code, char_id)


#### actions ####

func on_demolish():
	view.demolish(slot_code)


func on_repair():
	view.start_repair(slot_code)


func on_cancel():
	view.request_cancel_build(slot_code)
