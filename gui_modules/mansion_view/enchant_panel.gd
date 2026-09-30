extends "res://gui_modules/mansion_view/body_rites_panel.gd"

const Enchanting = preload("res://src/core/enchanting.gd")

const FILTERS = {All = 'all', Weapons = 'weapon', Armor = 'armor'}
const CURSE_BUTTONS = {None = '', Minor = 'minor', Major = 'major'}
const PIP_EMPTY = Color(0.172549, 0.145098, 0.109804, 1)
const CURSE_ROOM = Color(0.517647, 0.278431, 0.603922, 0.45)
const DIM = Color(0.62, 0.62, 0.62, 1)

var item_id = null
var targets = {}
var curse = ''
var filter = 'all'


func setup(view_node):
	view = view_node
	$CloseButton.connect("pressed", view, "close_enchanting")
	perform_button().connect("pressed", self, "perform_enchanting")
	connect_rite_drawing()
	#the body rites' photo booth renders every frame unless their setup stops it, and nothing here takes pictures
	$SexChangeBooth.queue_free()
	var items = $Body/Columns/Subjects
	for button in items.get_node("Filters").get_children():
		button.connect("pressed", self, "set_filter", [FILTERS[button.name]])
	items.get_node("Search").connect("text_changed", self, "search_changed")
	var enchantments = $Body/Columns/Upgrades
	for button in enchantments.get_node("Curse/Buttons").get_children():
		button.connect("pressed", self, "set_curse", [CURSE_BUTTONS[button.name]])
	globals.connecttexttooltip(enchantments.get_node("HeaderRow/Help"), tr("ENCHANTING_HELP"), false, tooltip_node())
	globals.connecttexttooltip(enchantments.get_node("Curse/HeaderRow/Help"), tr("ENCHANTING_CURSE_HELP"), false,
		tooltip_node())
	visible = false


func open():
	item_id = null
	targets.clear()
	curse = ''
	donor_ids.clear()
	$Body/Columns/Subjects/Search.text = ""
	visible = true
	for column in ["Subjects", "Upgrades", "Details"]:
		get_node("Body/Columns/%s/Scroll" % column).scroll_vertical = 0
	rebuild()


func selected_item():
	var item = Enchanting.item(item_id) if item_id != null else null
	if item == null or item.amount <= 0 or item.get_e_capacity_max() <= 0:
		return null
	return item


func rebuild():
	$Body/Title.text = tr("ENCHANTING_TITLE")
	var item = selected_item()
	if item == null:
		item_id = null
	else:
		var codes = Enchanting.codes_for(item)
		for code in targets.keys():
			if !codes.has(code) or int(targets[code]) <= Enchanting.level(item, code):
				targets.erase(code)
		if !Enchanting.can_curse(item):
			curse = ''
	var offered = Enchanting.donors()
	for id in donor_ids.duplicate():
		if !offered.has(id):
			donor_ids.erase(id)
	build_items()
	build_enchantments(item)
	build_details()


#### items ####

func build_items():
	var column = $Body/Columns/Subjects
	var list = column.get_node("Scroll/List")
	input_handler.ClearContainer(list, ['Button'])
	column.get_node("Header").text = tr("ENCHANTING_ITEMS")
	for button in column.get_node("Filters").get_children():
		button.text = tr("ENCHANTING_FILTER_" + button.name.to_upper())
		button.pressed = FILTERS[button.name] == filter
	var query = column.get_node("Search").text.strip_edges().to_lower()
	var shown = 0
	for id in Enchanting.items():
		var item = Enchanting.item(id)
		if filter != 'all' and item.itemtype != filter:
			continue
		if query != "" and tr(item.name).to_lower().find(query) < 0:
			continue
		shown += 1
		build_item_row(list, id, item)
	column.get_node("Empty").text = tr("ENCHANTING_NO_ITEMS")
	column.get_node("Empty").visible = shown == 0
	column.get_node("Scroll").visible = shown > 0


func build_item_row(list, id, item):
	var row = input_handler.DuplicateContainerTemplate(list, 'Button')
	row.pressed = id == item_id
	fill_item_icon(row.get_node("Quality"), item)
	row.get_node("Name").text = tr(item.name)
	row.get_node("Count").visible = item.amount > 1
	row.get_node("Count").text = str(item.amount)
	var person = Enchanting.wearer(item)
	var line = row.get_node("Points")
	if Enchanting.away(item):
		line.text = globals._report_text("ENCHANTING_AWAY", [person.get_short_name()])
		line.set("custom_colors/font_color", WARNING)
	else:
		line.text = tr("ENCHANTING_CAPACITY") + ": " + str(Enchanting.used_capacity(item)) + "/" + str(item.get_e_capacity_max())
	var wearer = row.get_node("Wearer")
	wearer.visible = person != null
	if person != null:
		wearer.texture = portrait_for(person)
		globals.connecttexttooltip(wearer, globals._report_text("ENCHANTING_WORN_BY", [person.get_short_name()]), false,
			tooltip_node())
	row.self_modulate = DIM if Enchanting.away(item) else Color(1, 1, 1, 1)
	row.connect("pressed", self, "select_item", [id])


#set_icon puts the enchanted or cursed glow on the icon's parent, the quality frame
func fill_item_icon(holder, item):
	holder.texture = variables.quality_colors.get(item.quality)
	item.set_icon(holder.get_node("Item"))
	globals.connectitemtooltip_v2(holder.get_node("Item"), item, view.get_node("Overlay/ItemTooltip"))


#### enchantments ####

func build_enchantments(item):
	var column = $Body/Columns/Upgrades
	var list = column.get_node("Scroll/List")
	input_handler.ClearContainer(list, ['Button'])
	column.get_node("HeaderRow/Title").text = tr("ENCHANTING_ENCHANTMENTS")
	column.get_node("PickSubject").text = tr("ENCHANTING_PICK_ITEM")
	column.get_node("PickSubject").visible = item == null
	for part in ["Scroll", "Curse", "HeaderRow/Left"]:
		column.get_node(part).visible = item != null
	if item == null:
		return
	var left = Enchanting.capacity(item, curse) - Enchanting.used_capacity(item) - Enchanting.cost(item, targets).capacity
	var header = column.get_node("HeaderRow/Left")
	header.text = tr("ENCHANTING_CAPACITY_LEFT") + ": " + str(left)
	header.set("custom_colors/font_color", GREY if left >= 0 else UNAFFORDABLE)
	for code in Enchanting.codes_for(item):
		build_enchantment_row(list, item, code, left)
	build_curse_buttons(item)


func build_enchantment_row(list, item, code, left):
	var data = Items.enchantments[code]
	var carried = Enchanting.level(item, code)
	var target = int(max(carried, targets.get(code, 0)))
	var top = Enchanting.top_level(code)
	var step = Enchanting.capacity_at(code, target + 1) - Enchanting.capacity_at(code, target) if target < top else 0
	var fits = target < top and step <= left
	var row = input_handler.DuplicateContainerTemplate(list, 'Button')
	row.pressed = target > carried
	row.get_node("Icon").texture = data.icon
	row.get_node("Name").text = tr(data.name)
	globals.connecttexttooltip(row, enchantment_tooltip(code, carried, target), false, tooltip_node())
	build_enchantment_price(row, code, carried, target, top, fits, step)
	build_stepper(row, code, carried, target, top, fits, step, left)
	var pips = row.get_node("Pips")
	input_handler.ClearContainer(pips, ['Pip'])
	for lvl in range(1, top + 1):
		var pip = input_handler.DuplicateContainerTemplate(pips, 'Pip')
		pip.color = POINTS_USED if lvl <= carried else (GOLD if lvl <= target else PIP_EMPTY)
	row.connect("pressed", self, "press_enchantment", [code])


func build_enchantment_price(row, code, carried, target, top, fits, step):
	var state = row.get_node("State")
	var price = row.get_node("Price")
	var open = target > carried or fits
	state.visible = !open
	price.visible = open
	if open:
		var shown = target if target > carried else carried + 1
		price.get_node("Gold").text = str(Enchanting.gold_at(code, shown))
		price.get_node("Mana").text = str(Enchanting.mana_at(code, shown) - Enchanting.mana_at(code, carried))
		price.get_node("Points").text = tr("ENCHANTING_CAPACITY") + " " \
			+ str(Enchanting.capacity_at(code, shown) - Enchanting.capacity_at(code, carried))
		connect_price_tooltips(price)
	elif carried >= top:
		state.text = tr("ENCHANTING_TOP_LEVEL")
		state.set("custom_colors/font_color", GOOD)
	else:
		state.text = globals._report_text("ENCHANTING_NEEDS_CAPACITY", [step])
		state.set("custom_colors/font_color", WARNING)


func build_stepper(row, code, carried, target, top, fits, step, left):
	var stepper = row.get_node("Stepper")
	var level = stepper.get_node("Level")
	level.text = input_handler.roman_number_converter(target) if target > 0 else "—"
	level.set("custom_colors/font_color", GOLD if target > carried else GREY)
	var lower = stepper.get_node("Lower")
	lower.disabled = target <= carried or pending_rite != null
	lower.connect("pressed", self, "set_target", [code, target - 1])
	var higher = stepper.get_node("Raise")
	higher.disabled = !fits or pending_rite != null
	higher.connect("pressed", self, "set_target", [code, target + 1])
	var hint = tr("ENCHANTING_TOP_LEVEL")
	if target < top:
		hint = globals._report_text("ENCHANTING_RAISE", [input_handler.roman_number_converter(target + 1)]) if fits \
			else globals._report_text("ENCHANTING_NO_ROOM", [step, max(0, left)])
	globals.connecttexttooltip(higher, hint, false, tooltip_node())


func enchantment_tooltip(code, carried, target):
	var data = Items.enchantments[code]
	var text = "[center]{color=k_yellow|" + tr(data.name) + "}[/center]\n" + tr(data.descript) + "\n"
	for lvl in range(1, Enchanting.top_level(code) + 1):
		var line = globals._report_text("ENCHANTING_LEVEL_LINE", [input_handler.roman_number_converter(lvl),
			Enchanting.capacity_at(code, lvl), Enchanting.gold_at(code, lvl), Enchanting.mana_at(code, lvl)])
		if lvl <= carried:
			line = "{color=k_yellow_dark|" + line + "}"
		elif lvl <= target:
			line = "{color=k_yellow|" + line + "}"
		text += "\n" + line
	return text


func build_curse_buttons(item):
	var block = $Body/Columns/Upgrades/Curse
	block.get_node("HeaderRow/Title").text = tr("ENCHANTING_CURSE")
	var open = Enchanting.can_curse(item)
	for button in block.get_node("Buttons").get_children():
		button.text = tr("ENCHANTING_CURSE_" + button.name.to_upper())
		button.pressed = open and CURSE_BUTTONS[button.name] == curse
		button.disabled = !open or pending_rite != null
		if open:
			globals.disconnect_text_tooltip(button)
		else:
			globals.connecttexttooltip(button, tr("ENCHANTING_CURSE_TAKEN"), false, tooltip_node())


#### details ####

func build_details():
	var item = selected_item()
	var details = $Body/Columns/Details
	details.get_node("PickUpgrade").text = tr("ENCHANTING_PICK_ITEM")
	details.get_node("PickUpgrade").visible = item == null
	details.get_node("Scroll").visible = item != null
	perform_button().visible = item != null
	if item == null:
		return
	if pending_rite == null:
		clear_charge()
	var content = details.get_node("Scroll/Content")
	build_head(content.get_node("UpgradeHead"), item)
	content.get_node("PriceHeader").text = tr("BODYRITE_PRICE")
	content.get_node("RequirementsHeader").text = tr("BODYRITE_REQUIREMENTS")
	content.get_node("DonorsHeader").text = tr("BODYRITE_DONORS")
	var price = Enchanting.cost(item, targets)
	donor_ids = Enchanting.valid_donors(donor_ids)
	var shares = BodyRites.mana_shares(price.mana, donor_ids)
	var problems = Enchanting.problems(item, targets, curse, donor_ids)
	build_gold_tile(price.gold)
	build_capacity_tile(item, price.capacity)
	build_mana_tile(shares, price.mana, !problems.has('mana'))
	call_deferred("refresh_mana_segments")
	build_checks(item, problems)
	build_donors(shares)
	content.get_node("DonorsEmpty").text = tr("ENCHANTING_NO_DONORS")
	perform_button().text = tr("ENCHANTING_PERFORM")
	perform_button().disabled = !problems.empty() or pending_rite != null


func build_head(head, item):
	fill_item_icon(head.get_node("Icon"), item)
	head.get_node("Words/Name").text = tr(item.name)
	head.get_node("Words/Description").text = item_summary(item)
	var after = Enchanting.preview(item, targets, curse)
	build_result_enchants(head.get_node("Result/Enchants"), item, after)
	head.get_node("Result/Stats/Title").text = tr("ENCHANTING_STATS")
	head.get_node("Result/Stats/Text").bbcode_text = stats_text(item.get_bonusstats(), after.get_bonusstats())


func item_summary(item):
	var parts = []
	if item.quality != "":
		parts.append(tr("QUALITY" + item.quality.to_upper()))
	var person = Enchanting.wearer(item)
	if person != null:
		parts.append(globals._report_text("ENCHANTING_AWAY" if Enchanting.away(item) else "ENCHANTING_WORN_BY",
			[person.get_short_name()]))
	elif item.amount > 1:
		parts.append(globals._report_text("ENCHANTING_IN_STORE", [item.amount]))
	return PoolStringArray(parts).join(" · ")


func build_result_enchants(box, item, after):
	box.get_node("Title").text = tr("ENCHANTING_ENCHANTMENTS")
	var list = box.get_node("List")
	input_handler.ClearContainer(list, ['Row'])
	for code in after.enchants:
		var carried = Enchanting.level(item, code)
		var now = int(after.enchants[code])
		var row = input_handler.DuplicateContainerTemplate(list, 'Row')
		row.get_node("Icon").texture = Items.enchantments[code].icon
		var text = tr(Items.enchantments[code].name) + " "
		if carried > 0 and now > carried:
			text += input_handler.roman_number_converter(carried) + " → "
		row.get_node("Name").text = text + input_handler.roman_number_converter(now)
		row.get_node("Name").set("custom_colors/font_color", GOLD if now > carried else GREY)
	if after.curse != null:
		var row = input_handler.DuplicateContainerTemplate(list, 'Row')
		row.get_node("Icon").texture = Items.curses[after.curse].icon
		row.get_node("Name").text = tr("ENCHANTCURSELABEL") + curse_name(item)
		row.get_node("Name").set("custom_colors/font_color", BAD)
	box.get_node("None").text = tr("ENCHANTING_NONE")
	box.get_node("None").visible = after.enchants.empty() and after.curse == null


func curse_name(item):
	if item.curse == null:
		return tr("ENCHANTCURSEUNKNOWN" + curse.to_upper())
	if item.curse_known:
		return tr(Items.curses[item.curse].name)
	return tr("ENCHANTCURSEUNKNOWNMINOR" if item.curse.ends_with('minor') else "ENCHANTCURSEUNKNOWNMAJOR")


func stats_text(before, after):
	var codes = before.keys()
	for code in after:
		if !codes.has(code):
			codes.append(code)
	var text = ""
	for code in codes:
		if code in ['enchant_capacity', 'enchant_capacity_mod']:
			continue
		var now = before.get(code)
		var then = after.get(code, now)
		if now == then or !(then is int or then is float) or !statdata.statdata.has(code):
			var one = {}
			one[code] = then
			text += globals.build_desc_for_bonusstats(one)
			continue
		var data = statdata.statdata[code]
		if data.tags.has('hidden'):
			continue
		var bonus = data.default_bonus
		text += globals.get_bonus_name_string(bonus, data, then)
		text += globals.make_bonus_value_string(bonus, data, now) if now != null else "—"
		text += " → " + globals.make_bonus_value_string(bonus, data, then) + "\n"
	return globals.TextEncoder(text.strip_edges())


#the body rites' points tile, with the room a curse adds tinted over its bar
func build_capacity_tile(item, extra):
	var tile = $Body/Columns/Details/Scroll/Content/PriceTiles/Points
	var own = item.get_e_capacity_max()
	var total = Enchanting.capacity(item, curse)
	fill_budget_tile(tile, tr("ENCHANTING_CAPACITY_TITLE"), Enchanting.used_capacity(item), extra, total)
	var room = tile.get_node("Body/Bar/Curse")
	room.visible = total > own
	room.anchor_left = clamp(own / max(float(total), 1.0), 0.0, 1.0)
	room.anchor_right = 1.0
	room.margin_left = 0
	room.margin_right = 0
	room.color = CURSE_ROOM
	globals.connecttexttooltip(tile, tr("ENCHANTING_CAPACITY_TOOLTIP"), false, tooltip_node())


func build_checks(item, problems):
	var list = $Body/Columns/Details/Scroll/Content/Requirements
	input_handler.ClearContainer(list, ['Row'])
	var person = Enchanting.wearer(item)
	if person != null:
		add_requirement(list, globals._report_text("ENCHANTING_CHECK_WEARER", [person.get_short_name()]),
			!problems.has('away'))
	add_requirement(list, tr("ENCHANTING_CHECK_CHOSEN"), !problems.has('nothing'))
	add_requirement(list, tr("ENCHANTING_CHECK_CAPACITY"), !problems.has('capacity'))
	add_requirement(list, tr("BODYRITE_CHECK_GOLD"), !problems.has('gold'))
	add_requirement(list, tr("BODYRITE_CHECK_MANA"), !problems.has('mana'))
	if person != null and !problems.has('away'):
		var cursed = item.curse != null or curse != ''
		add_requirement(list, globals._report_text("ENCHANTING_NOTE_KEPT_OFF" if cursed else "ENCHANTING_NOTE_PUT_BACK",
			[person.get_short_name()]), true, true)
	if item.amount > 1:
		add_requirement(list, globals._report_text("ENCHANTING_NOTE_STACK", [item.amount]), true, true)
	if curse != '':
		add_requirement(list, tr("ENCHANTING_NOTE_CURSE"), true, true)


func can_donate(id):
	var person = BodyRites.character(id)
	return selected_item() != null and person != null and Enchanting.donors().has(id) and BodyRites.mana_of(person) > 0


func refresh_mana_segments():
	var item = selected_item()
	if !visible or item == null or pending_rite != null:
		return
	var mana = Enchanting.cost(item, targets).mana
	build_mana_segments(BodyRites.mana_shares(mana, Enchanting.valid_donors(donor_ids)), mana)


#### choices ####

func select_item(id):
	if pending_rite != null:
		return
	if id != item_id:
		item_id = id
		targets.clear()
		curse = ''
		$Body/Columns/Details/Scroll.scroll_vertical = 0
	rebuild()


func set_filter(value):
	filter = value
	build_items()


func search_changed(_text):
	build_items()


func set_target(code, value):
	var item = selected_item()
	if item == null or pending_rite != null:
		return
	if value <= Enchanting.level(item, code):
		targets.erase(code)
	else:
		targets[code] = int(min(value, Enchanting.top_level(code)))
	rebuild()


#a toggle row flips itself on a press; the rebuild puts its look back unless a level was added
func press_enchantment(code):
	var item = selected_item()
	if item != null and pending_rite == null and !targets.has(code):
		var trial = targets.duplicate()
		trial[code] = Enchanting.level(item, code) + 1
		if trial[code] <= Enchanting.top_level(code) \
				and Enchanting.used_capacity(item) + Enchanting.cost(item, trial).capacity <= Enchanting.capacity(item, curse):
			targets = trial
	rebuild()


func set_curse(code):
	var item = selected_item()
	if item != null and pending_rite == null and Enchanting.can_curse(item):
		curse = code
	rebuild()


#### the rite ####

func perform_enchanting():
	var item = selected_item()
	if item == null or pending_rite != null:
		return
	if !Enchanting.problems(item, targets, curse, donor_ids).empty():
		rebuild()
		return
	play_enchanting(item)


func play_enchanting(item):
	pending_rite = {item = item.id}
	lock_rite_input(true)
	perform_button().disabled = true
	input_handler.PlaySound("teleport")
	yield(get_tree(), "idle_frame")
	var mana = Enchanting.cost(item, targets).mana
	var shares = BodyRites.mana_shares(mana, Enchanting.valid_donors(donor_ids))
	build_mana_segments(shares, mana)
	drain_mana(shares, mana)
	yield(get_tree().create_timer(DRAIN_TIME + MOTE_FLIGHT), "timeout")
	fade_veil(true)
	yield(get_tree().create_timer(VEIL_TIME), "timeout")
	var subtitle = raised_names(item)
	var done = Enchanting.perform(item, targets, curse, donor_ids)
	pending_rite = null
	lock_rite_input(false)
	fade_veil(false)
	if done != null:
		item_id = done.id
		targets.clear()
		curse = ''
		input_handler.play_animation("enchanted", {item = done, subtitle = subtitle})
	refresh_after_rite()


func raised_names(item):
	var names = []
	var picked = Enchanting.raises(item, targets)
	for code in picked:
		names.append(tr(Items.enchantments[code].name) + " " + input_handler.roman_number_converter(picked[code]))
	return PoolStringArray(names).join(" · ")
