extends Control
#The captives panel: a portrait gallery; a captive who fits a slave market quest gets a Hand Over strip.

const CAPTIVE = 'Captive'
const CHOOSER_ROW = 'ChooserRow'
const STRIP_GAP = 3
const SCREEN_MARGIN = 40
const FLIGHT_TIME = 0.75
const FLIGHT_TRAIL = [0.3, 0.18, 0.1]
const FLIGHT_LAG = 0.06
const TRAVELERS = "PresentedSlavesPanel/ScrollContainer"
const DISMISS_ICON = "res://assets/images/gui/explore/Captured Characters/icons/icon_dismiss.png"

var found = {}
var flights = {}
var flight_location = null


func _ready():
	set_process(false)
	globals.connect("slave_added", self, '_on_slave_added')
	input_handler.connect("LocationSlavesUpdate", self, 'update')
	ResourceScripts.slave_quests.connect("quests_changed", self, '_on_slave_quests_changed')
	input_handler.connect('portrait_taken', self, '_on_portrait_taken')
	connect("visibility_changed", self, '_on_visibility_changed')
	$Button.connect("pressed", self, 'ask_sell_all')
	globals.connecttexttooltip($Button, tr("CAPTURE_QUICKSELL_TOOLTIP"))
	globals.connecttexttooltip($Hint, tr("CAPTURETOOLTIP") + "\n\n" + tr("CAPTURE_HANDOVER_HINT"))
	update()


func _node(node_name):
	if !found.has(node_name) or !is_instance_valid(found[node_name]):
		found[node_name] = find_node(node_name, true, false)
	return found[node_name]


func get_location():
	var host = get_parent().get_parent() if get_parent() != null else null
	return host.get("active_location") if host != null else null


func tut_register_first_recruit():
	input_handler.register_btn_source('first_recruit', self, 'tut_get_first_take_btn')
func tut_register_first_char():
	input_handler.register_btn_source('first_recruit_char', self, 'tut_get_first_char', self, 'tut_get_first_char_rect')
func tut_register_first_handover():
	input_handler.register_btn_source('first_handover', self, 'tut_get_first_handover')
func tut_register_first_handover_quest():
	input_handler.register_btn_source('first_handover_quest', self, 'tut_get_first_handover_quest')
func tut_get_first_handover():
	var strip = _part(first_tile(), 'HandOver')
	return strip if strip is Control and strip.is_visible_in_tree() else null
func tut_get_first_handover_quest():
	var chooser = _node("Chooser")
	var list = _node("ChooserList")
	if !(chooser is Popup) or !chooser.visible or !(list is Container):
		return null
	for row in list.get_children():
		if row.name != CHOOSER_ROW and row is BaseButton and row.visible:
			return row
	return null
func tut_get_first_take_btn():
	var tile = first_tile()
	return _part(tile, 'TakeButton') if tile != null else null
func tut_get_first_char():
	return first_tile()
func tut_get_first_char_rect():
	var tile = first_tile()
	if tile == null:
		return Rect2()
	var rect = tile.get_global_rect()
	var take = _part(tile, 'TakeButton')
	if take is Control:
		rect.end.y = take.get_global_rect().position.y
	return rect

func _part(tile, part_name):
	return tile.find_node(part_name, true, false) if tile != null else null

func first_tile():
	var list = _node("Captives")
	if !(list is Container):
		return null
	for child in list.get_children():
		if child.name != CAPTIVE and child is Control and child.visible:
			return child
	return null


func update():
	var location = get_location()
	if location == null:
		return
	if !location.has('captured_characters'):
		location.captured_characters = []
	if location != flight_location:
		for ch_id in flights.keys():
			drop_flight(ch_id)
		flight_location = location
	close_chooser()
	if location.captured_characters.empty():
		input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
		hide()
	elif location.type != 'dungeon':
		show()
	var list = _node("Captives")
	if !(list is Container) or !list.has_node(CAPTIVE):
		return
	input_handler.ClearContainer(list, [CAPTIVE])
	var base_height = list.get_node(CAPTIVE).rect_min_size.y
	for tchar in sorted_captives(location):
		fill_tile(input_handler.DuplicateContainerTemplate(list, CAPTIVE), tchar, location, base_height)
	fit_height()


#as tall as its rows of tiles, down to SCREEN_MARGIN above the screen's bottom; past that it shows whole rows only
#and the list scrolls
func fit_height():
	var list = _node("Captives")
	var scroll = _node("ScrollContainer")
	if !(scroll is Control) or !(list is GridContainer):
		return
	var rows = []
	var row = 0.0
	var count = 0
	for tile in list.get_children():
		if tile.name == CAPTIVE or !(tile is Control) or !tile.visible or tile.is_queued_for_deletion():
			continue
		row = max(row, tile.rect_min_size.y)
		count += 1
		if count % list.columns == 0:
			rows.append(row)
			row = 0.0
	if row > 0:
		rows.append(row)
	var chrome = scroll.margin_top - scroll.margin_bottom
	var room = get_viewport().get_visible_rect().size.y - SCREEN_MARGIN - rect_global_position.y - chrome
	var content = 0.0
	for i in rows.size():
		var taller = content + rows[i] + (list.get_constant("vseparation") if i > 0 else 0)
		if i > 0 and taller > room:
			break
		content = taller
	rect_size.y = chrome + content


func _on_visibility_changed():
	if visible:
		fit_height()


func sorted_captives(location):
	var sq = ResourceScripts.slave_quests
	var ready = []
	var rest = []
	for id in location.captured_characters:
		var tchar = characters_pool.get_char_by_id(id)
		if tchar == null:
			continue
		if sq.captive_quests(tchar, location).empty():
			rest.append(tchar)
		else:
			ready.append(tchar)
	return ready + rest


func fill_tile(tile, tchar, location, base_height):
	var id = tchar.id
	tile.set_meta("character_id", id)
	var icon = _part(tile, 'Icon')
	if icon is TextureRect:
		var ttex = tchar.get_icon_small()
		if ttex != null:
			icon.texture = ttex
		globals.connectslavetooltip(icon, tchar)
		input_handler.queue_portrait(tchar)
	var race = _part(tile, 'Race')
	if race is TextureRect:
		globals.build_race_icon(race, tchar)
	var sex = _part(tile, 'Sex')
	if sex is TextureRect:
		globals.build_sex_icon(sex, tchar)
	var name_label = _part(tile, 'Name')
	if name_label is Label:
		name_label.text = tchar.get_short_name()
		name_label.set("custom_colors/font_color", variables.hexcolordict['factor' + str(int(tchar.get_stat('growth_factor')))])
	var take = _part(tile, 'TakeButton')
	var sell = _part(tile, 'SellButton')
	var enslave = _part(tile, 'EnslaveButton')
	take.connect('pressed', self, 'hire_char', [id])
	sell.connect('pressed', self, 'sell_char', [id])
	enslave.connect('pressed', self, 'enslave_char', [id])
	tile.connect('pressed', self, 'show_full_info', [tchar])
	if tchar.src == 'random_combat':
		sell.get_node("Label").text = str(int(tchar.calculate_price(true) / 2))
		globals.connecttexttooltip(sell, tr("CAPTURESELLTOOLTIP") % int(tchar.calculate_price(true) / 2))
	else:
		sell.get_node("Label").visible = false
		globals.connecttexttooltip(sell, tr("CAPTUREDISMISSTOOLTIP"))
		sell.get_node("TextureRect").texture = load(DISMISS_ICON)
		enslave.visible = false
		enslave.disabled = true
	globals.connecttexttooltip(take, tr("CAPTUREADDTOOLTIP"))
	globals.connecttexttooltip(enslave, tr("CAPTUREENSLAVETOOLTIP"))
	fill_strip(tile, tchar, location, base_height)


#in the tutorial a captive who fits the chapter's order is offered that order alone
func handable_quests(tchar, location):
	var quests = ResourceScripts.slave_quests.captive_quests(tchar, location)
	if input_handler.hard_tutorial_active and input_handler.hard_tutorial != null:
		var order_id = input_handler.hard_tutorial.get("market_order_id")
		for quest in quests:
			if quest.id == order_id:
				return [quest]
	return quests


func fill_strip(tile, tchar, location, base_height):
	var strip = _part(tile, 'HandOver')
	var quests = handable_quests(tchar, location)
	var shown = strip is BaseButton and !quests.empty()
	if strip is CanvasItem:
		strip.visible = shown
	tile.rect_min_size.y = base_height + (strip_height(strip) + STRIP_GAP if shown else 0)
	if !shown:
		return
	var count = strip.find_node('Count', true, false)
	if count is Label:
		count.visible = quests.size() > 1
		count.text = str(quests.size())
	var verb = strip.find_node('Verb', true, false)
	if verb is Label:
		verb.text = tr("SQ_DELIVER")
	globals.connecttexttooltip(strip, strip_tooltip(quests))
	strip.connect('pressed', self, '_on_hand_over_pressed', [tchar.id, strip])


func strip_height(strip):
	if !(strip is Control):
		return 0.0
	return max(strip.rect_min_size.y, strip.rect_size.y)


func fill_seal(holder, faction):
	var seal = holder.find_node('Seal', true, false)
	if seal is Control:
		var box = seal.get_stylebox("panel")
		if box is StyleBoxFlat:
			box = box.duplicate()
			box.bg_color = faction.get('wax', Color(0.13, 0.13, 0.13))
			seal.add_stylebox_override("panel", box)
	var emblem = holder.find_node('Emblem', true, false)
	if emblem is TextureRect:
		emblem.texture = faction.icon


func strip_tooltip(quests):
	var sq = ResourceScripts.slave_quests
	if quests.size() == 1:
		var quest = quests[0]
		var req = quest.requirements[0]
		return globals._report_text("CAPTURE_HANDOVER_TOOLTIP", [tr(quest.name), tr(sq.get_faction(quest.faction).name), int(req.delivered_slaves), int(req.value), sq.next_payment(quest)])
	var text = globals._report_text("CAPTURE_HANDOVER_CHOOSE", [quests.size()])
	for quest in quests:
		text += "\n" + globals._report_text("CAPTURE_HANDOVER_LINE", [tr(quest.name), sq.next_payment(quest)])
	return text


func _on_hand_over_pressed(ch_id, strip):
	var tchar = characters_pool.get_char_by_id(ch_id)
	var quests = handable_quests(tchar, get_location())
	if quests.empty():
		update()
	else:
		open_chooser(tchar, quests, strip)


func hand_over(ch_id, quest_id):
	close_chooser()
	var location = get_location()
	var tchar = characters_pool.get_char_by_id(ch_id)
	var res = ResourceScripts.slave_quests.deliver_captive(quest_id, tchar, location)
	if res.paid > 0:
		input_handler.PlaySound("money_spend")
	hide_slave_tooltip()
	input_handler.emit_signal("LocationSlavesUpdate")


#--------------chooser--------------

func open_chooser(tchar, quests, strip):
	var chooser = _node("Chooser")
	var list = _node("ChooserList")
	if !(chooser is Popup) or !(list is Container) or !list.has_node(CHOOSER_ROW):
		hand_over(tchar.id, quests[0].id)
		return
	var sq = ResourceScripts.slave_quests
	var title = _node("ChooserTitle")
	if title is Label:
		title.text = globals._report_text("CAPTURE_CHOOSER_TITLE", [tchar.get_short_name()])
	input_handler.ClearContainer(list, [CHOOSER_ROW])
	for quest in quests:
		var row = input_handler.DuplicateContainerTemplate(list, CHOOSER_ROW)
		var req = quest.requirements[0]
		fill_seal(row, sq.get_faction(quest.faction))
		var quest_title = row.find_node('Title', true, false)
		if quest_title is Label:
			quest_title.text = tr(quest.name)
		var meta = row.find_node('Meta', true, false)
		if meta is Label:
			meta.text = globals._report_text("CAPTURE_CHOOSER_META", [tr(sq.get_faction(quest.faction).name), int(req.delivered_slaves), int(req.value)])
		var pay = row.find_node('Pay', true, false)
		if pay is Label:
			pay.text = "+%d" % sq.next_payment(quest)
		row.connect('pressed', self, 'hand_over', [tchar.id, quest.id])
		fit_row(row)
	var size = chooser.get_combined_minimum_size()
	var panel_rect = get_global_rect()
	var anchor = strip.get_global_rect()
	var pos = Vector2(anchor.position.x + anchor.size.x / 2 - size.x / 2, anchor.end.y + 4)
	pos.x = clamp(pos.x, panel_rect.position.x + 6, panel_rect.end.x - size.x - 6)
	if pos.y + size.y > panel_rect.end.y - 6:
		pos.y = anchor.position.y - size.y - 4
	chooser.popup(Rect2(pos.floor(), size))


#a Button does not grow with its children, and a Label's new text counts towards the layout only once drawn:
#a long house name pushed the pay out of the chooser
func fit_row(row):
	for label_name in ['Title', 'Meta', 'Pay']:
		var label = row.find_node(label_name, true, false)
		if label is Control:
			label.minimum_size_changed()
	for content in row.get_children():
		if content is Control:
			row.rect_min_size.x = content.get_combined_minimum_size().x + content.margin_left - content.margin_right
			return


func close_chooser():
	var chooser = _node("Chooser")
	if chooser is Popup and chooser.visible:
		chooser.hide()


func _on_slave_quests_changed():
	if is_inside_tree():
		update()


func _on_portrait_taken(id):
	var list = _node("Captives")
	var tchar = characters_pool.get_char_by_id(id)
	if !(list is Container) or tchar == null:
		return
	for tile in list.get_children():
		if tile.has_meta("character_id") and tile.get_meta("character_id") == id:
			var icon = _part(tile, 'Icon')
			if icon is TextureRect:
				icon.texture = tchar.get_icon_small()


func hide_slave_tooltip():
	var slave_tooltip = get_tree().get_root().get_node_or_null("slavetooltip")
	if slave_tooltip != null:
		slave_tooltip.hide()


#--------------selling--------------

func quick_sale(location):
	var sale = {kept = [], sold = [], freed = [], gold = 0}
	var sq = ResourceScripts.slave_quests
	for id in location.captured_characters:
		var tchar = characters_pool.get_char_by_id(id)
		if tchar == null:
			continue
		if !sq.captive_quests(tchar, location).empty():
			sale.kept.append(id)
		elif tchar.src == 'random_combat':
			sale.sold.append(tchar)
			sale.gold += int(tchar.calculate_price(true) / 2)
		else:
			sale.freed.append(tchar)
	return sale


func ask_sell_all():
	var location = get_location()
	if location == null or !location.has('captured_characters'):
		return
	var sale = quick_sale(location)
	var lines = []
	if !sale.sold.empty():
		lines.append(globals._report_text("CAPTURE_QUICKSELL_CONFIRM", [sale.sold.size(), sale.gold]))
	if !sale.freed.empty():
		lines.append(globals._report_text("CAPTURE_QUICKSELL_CONFIRM_FREE", [sale.freed.size()]))
	if !lines.empty():
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'sell_all', PoolStringArray(lines).join("\n")])


func sell_all():
	var location = get_location()
	if location == null or !location.has('captured_characters'):
		return
	var sale = quick_sale(location)
	for tchar in sale.sold:
		ResourceScripts.game_res.money += int(tchar.calculate_price(true) / 2)
		input_handler.PlaySound("money_spend")
	for tchar in sale.sold + sale.freed:
		tchar.is_active = false
	location.captured_characters.clear()
	for id in sale.kept:
		location.captured_characters.append(id)
	input_handler.emit_signal("LocationSlavesUpdate")
	if !sale.sold.empty():
		ResourceScripts.slave_quests.on_slave_sold(sale.sold.size(), sale.gold)


func sell_char(ch_id):
	var location = get_location()
	if location.captured_characters.has(ch_id):
		var tchar = characters_pool.get_char_by_id(ch_id)
		if tchar.src == 'random_combat':
			var val = tchar.calculate_price(true) / 2
			ResourceScripts.game_res.money += int(val)
			input_handler.PlaySound("money_spend")
			ResourceScripts.slave_quests.on_slave_sold(1, int(val))
		tchar.is_active = false
		location.captured_characters.erase(ch_id)
	hide_slave_tooltip()
	input_handler.emit_signal("LocationSlavesUpdate")


func enslave_char(ch_id):
	var location = get_location()
	var enslaved = false
	if location.captured_characters.has(ch_id):
		var tchar = characters_pool.get_char_by_id(ch_id)
		if tchar.src == 'random_combat':
			take_off(ch_id)
			tchar.set_stat('is_hirable', false)
			tchar.recruit(true)
			location.captured_characters.erase(ch_id)
			enslaved = true
	hide_slave_tooltip()
	input_handler.emit_signal("LocationSlavesUpdate")
	if enslaved:
		fly(ch_id)


func hire_char(ch_id):
	var location = get_location()
	if location.captured_characters.has(ch_id):
		var tchar = characters_pool.get_char_by_id(ch_id)
		take_off(ch_id, true)
		input_handler.active_character = tchar
		input_handler.active_location = location
		if tchar.src == 'random_combat':
			input_handler.interactive_message("recruit_captured", "story_event", {})
		else:
			input_handler.interactive_message("recruit_meet", "story_event", {})
	hide_slave_tooltip()


func show_full_info(person = null):
	if person == null: return
	var FullSlaveInfo = input_handler.get_spec_node(input_handler.NODE_EXPLORE_SLAVEINFO)
	if ! gui_controller.windows_opened.has(FullSlaveInfo):
		gui_controller.windows_opened.append(FullSlaveInfo)
	gui_controller.explore_slaveinfo = FullSlaveInfo
	FullSlaveInfo.show()
	FullSlaveInfo.from_dialogue = true
	FullSlaveInfo.show_summary(person)


#--------------flight to the Travelers list--------------

#copies of the captive's tile laid over it, to fly to the Travelers list once the character joins
func take_off(ch_id, by_dialogue = false):
	drop_flight(ch_id)
	var tile = captive_tile(ch_id)
	if tile == null:
		return
	var copies = []
	for alpha in [1.0] + FLIGHT_TRAIL:
		var copy = tile.duplicate(0)
		copy.hide()
		copy.set_as_toplevel(true)
		copy.modulate.a = alpha
		ignore_mouse(copy)
		add_child(copy)
		copy.rect_global_position = tile.rect_global_position
		copy.rect_size = tile.rect_size
		copy.rect_pivot_offset = tile.rect_size / 2
		copies.append(copy)
	flights[ch_id] = {copies = copies, from = Rect2(tile.rect_global_position, tile.rect_size), by_dialogue = by_dialogue}


func captive_tile(ch_id):
	var list = _node("Captives")
	if !(list is Container):
		return null
	for tile in list.get_children():
		if tile.name != CAPTIVE and tile is Control and tile.visible and tile.has_meta("character_id") and tile.get_meta("character_id") == ch_id:
			return tile
	return null


func ignore_mouse(node):
	if node is Control:
		node.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for child in node.get_children():
		ignore_mouse(child)


#a recruit through the dialogue joins when its last scene closes
func _on_slave_added():
	for ch_id in flights.keys():
		if flights[ch_id].by_dialogue and !flights[ch_id].has("to") and ResourceScripts.game_party.characters.has(ch_id):
			flights[ch_id].by_dialogue = false
			call_deferred("fly_after_join", ch_id)


func fly_after_join(ch_id):
	input_handler.emit_signal("LocationSlavesUpdate")
	fly(ch_id)


func travelers_row(scroll, character):
	var list = scroll.get_node_or_null("VBoxContainer") if scroll != null else null
	if list == null:
		return null
	for row in list.get_children():
		if row is Control and row.visible and !row.is_queued_for_deletion() and row.get("dragdata") == character:
			return row
	return null


#the row waits hidden, scrolled into view, while the copies fly to it
func fly(ch_id):
	yield(get_tree(), "idle_frame")
	var scroll = get_parent().get_node_or_null(TRAVELERS)
	var character = characters_pool.get_char_by_id(ch_id)
	var row = null
	for _i in range(10):
		if !flights.has(ch_id):
			return
		row = travelers_row(scroll, character)
		if row != null:
			break
		yield(get_tree(), "idle_frame")
	if row == null:
		drop_flight(ch_id)
		return
	row.modulate.a = 0
	var before = scroll.scroll_vertical
	scroll.ensure_control_visible(row)
	var after = scroll.scroll_vertical
	var flight = flights[ch_id]
	flight.row = row
	flight.to = Rect2(row.rect_global_position + Vector2(0, before - after), row.rect_size)
	flight.t = 0.0
	if after != before:
		scroll.scroll_vertical = before
		var tween = input_handler.GetTweenNode(scroll)
		tween.interpolate_property(scroll, "scroll_vertical", before, after, FLIGHT_TIME * 0.4, Tween.TRANS_SINE, Tween.EASE_OUT)
		tween.start()
	for copy in flight.copies:
		copy.show()
	set_process(true)


func _process(delta):
	var landed = []
	var flying = false
	for ch_id in flights:
		var flight = flights[ch_id]
		if !flight.has("to"):
			continue
		flying = true
		flight.t += delta / FLIGHT_TIME
		for i in flight.copies.size():
			place_copy(flight, flight.copies[i], clamp(flight.t - FLIGHT_LAG * i, 0.0, 1.0))
		if flight.t >= 1.0 + FLIGHT_LAG * (flight.copies.size() - 1):
			landed.append(ch_id)
	for ch_id in landed:
		land(ch_id)
	if !flying:
		set_process(false)


#along an S-curve from the tile to the row, shrinking to the row's size and tilting a little on the way
func place_copy(flight, copy, t):
	if !is_instance_valid(copy):
		return
	var k = t * t * (3.0 - 2.0 * t)
	var a = flight.from.position + flight.from.size / 2
	var b = flight.to.position + flight.to.size / 2
	var u = 1.0 - k
	var centre = a * u * u * u + (a + Vector2(-320, -90)) * 3.0 * u * u * k + (b + Vector2(260, 50)) * 3.0 * u * k * k + b * k * k * k
	copy.rect_scale = Vector2(lerp(1.0, flight.to.size.x / flight.from.size.x, k), lerp(1.0, flight.to.size.y / flight.from.size.y, k))
	copy.rect_rotation = -6.0 * sin(PI * k)
	copy.rect_global_position = centre - flight.from.size / 2
	copy.visible = t > 0.0 or copy == flight.copies[0]


func land(ch_id):
	var row = flights[ch_id].get("row")
	drop_flight(ch_id)
	if !(row is Control) or !is_instance_valid(row):
		return
	row.rect_pivot_offset = row.rect_size / 2
	var tween = input_handler.GetTweenNode(row)
	tween.interpolate_property(row, "rect_scale", Vector2(1.16, 1.16), Vector2.ONE, 0.26, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.interpolate_property(row, "modulate", Color(1.6, 1.5, 1.2, 1.0), Color(1, 1, 1, 1), 0.6, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()


func drop_flight(ch_id):
	if !flights.has(ch_id):
		return
	for copy in flights[ch_id].copies:
		if is_instance_valid(copy):
			copy.queue_free()
	flights.erase(ch_id)
