extends Control

#Soul stone: draws a magic trait out of the character the stone was used on and binds it to someone else
#at home. The household is a small portrait grid, best fits first. A trait the move would overwrite is
#crossed out, the incoming one shows half there, and the move itself is a violet dissolve.

const DOT_GOOD = Color(0.56, 0.86, 0.44)
const DOT_MID = Color(0.91, 0.82, 0.48)
const DOT_OFF = Color(0.42, 0.4, 0.36)
const PICK_EDGE = Color(0.42, 0.31, 0.26)
const PICK_CHOSEN = Color(1, 1, 0)
const SELECTED_BORDER = Color(1, 1, 0)
const HAZE = Color(0.8, 0.6, 1.0)
const NOT_READY = Color(0.55, 0.55, 0.55)

onready var from_col = $Center/Window/VBox/Body/Columns/From
onready var to_col = $Center/Window/VBox/Body/Columns/To
onready var from_cards = $Center/Window/VBox/Body/Columns/From/Cards
onready var to_cards = $Center/Window/VBox/Body/Columns/To/Cards
onready var scroll = $Center/Window/VBox/Body/Recipients
onready var grid = $Center/Window/VBox/Body/Recipients/Grid
onready var transfer_button = $Center/Window/VBox/Body/Foot/Transfer
onready var cancel_button = $Center/Window/VBox/Body/Foot/Cancel
onready var cost_label = $Center/Window/VBox/Body/Foot/Cost/Label
onready var tween = $Tween

var donor
var recipient
var pick = ''
var replace_code = ''
var busy = false
var selected_card
var incoming_card
var lost_cards = []


func _ready():
	hide()
	transfer_button.connect("pressed", self, "transfer")
	cancel_button.connect("pressed", self, "close")
	var color = globals.get_trait_category_color('magic')
	for col in [from_col, to_col]:
		var head = col.get_node("CatHead")
		head.get_node("LineL").color = color
		head.get_node("LineR").color = color
		head.get_node("Icon").texture = load(Traitdata.catalogue.categories.magic.icon)
		head.get_node("Icon").self_modulate = color


func open(character):
	donor = character
	busy = false
	var traits = donor.get_transferable_traits()
	pick = traits[0] if !traits.empty() else ''
	replace_code = ''
	recipient = null
	for entry in ranked_recipients():
		if !entry.fit.off:
			recipient = entry.person
			break
	refresh()
	show()


func close():
	if busy:
		return
	hide()


func refresh():
	fill_head(from_col, donor)
	fill_head(to_col, recipient)
	fill_from()
	fill_to()
	fill_grid()
	fill_foot()


func fill_head(col, person):
	col.get_node("Portrait/Image").texture = person.get_icon() if person != null else null
	col.get_node("Name").text = person.get_short_name() if person != null else ""


#How well someone takes the selected trait: rank orders the grid, the dot shows what the move does.
func fit(person):
	var res = {rank = 0, dot = DOT_GOOD, text = tr("SOULSTONE_FIT_FREE"), off = false}
	if pick == '':
		res.rank = 5
		res.dot = DOT_OFF
		res.text = person.get_short_name()
		return res
	var plan = person.preview_trait_binding(pick)
	if plan.blocked != '':
		res.rank = 9
		res.dot = DOT_OFF
		res.off = true
		res.text = tr("SOULSTONE_FIT_OWNED" if plan.blocked == 'owned' else "SOULSTONE_FIT_NO_ROOM")
	elif !plan.free:
		var lost = plan.lose[0]
		var good = Traitdata.traits[lost].tags.has('negative') and !person.is_trait_hidden(lost)
		res.rank = 1 if good else 2
		res.dot = DOT_GOOD if good else DOT_MID
		res.text = tr("SOULSTONE_FIT_REPLACES").replace("{trait}", globals.get_trait_entry(person, lost).name)
	res.text = person.get_short_name() + " — " + res.text
	return res


func ranked_recipients():
	var res = []
	for person in donor.get_transfer_recipients():
		res.append({person = person, fit = fit(person)})
	res.sort_custom(self, "by_fit")
	return res


func by_fit(a, b):
	if a.fit.rank != b.fit.rank:
		return a.fit.rank < b.fit.rank
	return a.person.get_short_name() < b.person.get_short_name()


func fill_card(card, person, code):
	var data = Traitdata.traits[code]
	var hidden = person.is_trait_hidden(code)
	var entry = globals.get_trait_entry(person, code)
	var box = card.get_node("VBox")
	globals.fill_trait_button(box.get_node("Tile"), entry)
	box.get_node("Name").text = entry.name
	box.get_node("Tags").bbcode_text = "[center]" + globals.TextEncoder(globals.get_trait_tag_line(data.category, [] if hidden else data.tags)) + "[/center]"
	var effects = person.translate(tr("TRAITHIDDENTOOLTIP")) if hidden else globals.get_trait_effects_text(person, code)
	box.get_node("Fx").bbcode_text = "[center]" + globals.TextEncoder(effects) + "[/center]"


func fill_from():
	input_handler.ClearContainer(from_cards, ['Card'])
	selected_card = null
	var traits = donor.get_transferable_traits()
	var empty = from_col.get_node("Empty")
	empty.visible = traits.empty()
	empty.text = donor.translate(tr("SOULSTONE_NOTHING"))
	for code in traits:
		var card = input_handler.DuplicateContainerTemplate(from_cards, 'Card')
		fill_card(card, donor, code)
		if code == pick:
			selected_card = card
			card.get_node("VBox/Chip").text = tr("SOULSTONE_SELECTED")
			var style = card.get_stylebox("panel").duplicate()
			style.border_color = SELECTED_BORDER
			style.set_border_width_all(2)
			card.add_stylebox_override("panel", style)
		card.mouse_default_cursor_shape = CURSOR_POINTING_HAND
		card.connect("gui_input", self, "on_from_card_input", [code])


#An opposite element is overwritten by the move itself, so then there is nothing to choose.
func clashes(codes):
	for code in codes:
		if Traitdata.traits[pick].get('conflicts', []).has(code) or Traitdata.traits[code].get('conflicts', []).has(pick):
			return true
	return false


func fill_to():
	input_handler.ClearContainer(to_cards, ['Card', 'Free'])
	incoming_card = null
	lost_cards = []
	var empty = to_col.get_node("Empty")
	empty.visible = recipient == null
	empty.text = tr("SOULSTONE_NOBODY")
	if recipient == null:
		return
	var plan = {lose = [], free = false, blocked = 'none'}
	if pick != '':
		plan = recipient.preview_trait_binding(pick, replace_code)
	var open = recipient.dyn_stats.get_replaceable_traits('magic')
	var choosable = plan.blocked == '' and !plan.free and open.size() > 1 and !clashes(plan.lose)
	for code in recipient.get_category_traits('magic'):
		if !Traitdata.traits[code].get('visible', true):
			continue
		var card = input_handler.DuplicateContainerTemplate(to_cards, 'Card')
		fill_card(card, recipient, code)
		var lost = plan.lose.has(code)
		card.get_node("Cross").visible = lost
		card.get_node("VBox").modulate.a = 0.6 if lost else 1.0
		if lost:
			lost_cards.append(card)
		if choosable and open.has(code):
			card.mouse_default_cursor_shape = CURSOR_POINTING_HAND
			card.connect("gui_input", self, "on_to_card_input", [code])
	if pick != '' and plan.blocked == '':
		incoming_card = input_handler.DuplicateContainerTemplate(to_cards, 'Card')
		fill_card(incoming_card, donor, pick)
		incoming_card.modulate.a = 0.55
	elif recipient.dyn_stats.get_free_trait_slots('magic') > 0:
		input_handler.DuplicateContainerTemplate(to_cards, 'Free')


#Rebuilt only when the trait changes, which reorders it; picking someone just moves the highlight.
func fill_grid():
	input_handler.ClearContainer(grid, ['Pick'])
	for entry in ranked_recipients():
		var button = input_handler.DuplicateContainerTemplate(grid, 'Pick')
		button.set_meta("person", entry.person.id)
		button.get_node("Image").texture = entry.person.get_icon()
		var border = button.get_node("Border").get_stylebox("panel").duplicate()
		button.get_node("Border").add_stylebox_override("panel", border)
		var dot = button.get_node("Dot").get_stylebox("panel").duplicate()
		dot.bg_color = entry.fit.dot
		button.get_node("Dot").add_stylebox_override("panel", dot)
		button.get_node("Dot").visible = pick != ''
		button.disabled = entry.fit.off
		button.modulate.a = 0.35 if entry.fit.off else 1.0
		globals.connecttexttooltip(button, entry.fit.text)
		button.connect("pressed", self, "choose", [entry.person])
	mark_grid()
	scroll.scroll_vertical = 0


func mark_grid():
	for button in grid.get_children():
		if !button.has_meta("person"):
			continue
		var chosen = recipient != null and button.get_meta("person") == recipient.id
		button.get_node("Border").get_stylebox("panel").border_color = PICK_CHOSEN if chosen else PICK_EDGE
		button.get_node("Border").update()


func fill_foot():
	var stones = ResourceScripts.game_res.get_item_amount('soul_stone')
	var ready = !busy and stones > 0 and recipient != null and pick != '' and recipient.preview_trait_binding(pick, replace_code).blocked == ''
	transfer_button.disabled = !ready
	transfer_button.modulate = Color(1, 1, 1) if ready else NOT_READY
	cost_label.text = tr("SOULSTONE_COST").replace("{count}", str(stones)) if stones > 0 else tr("SOULSTONE_NO_STONES")


func choose(person):
	if busy:
		return
	recipient = person
	replace_code = ''
	fill_head(to_col, recipient)
	fill_to()
	mark_grid()
	fill_foot()


func on_from_card_input(event, code):
	if busy or !(event is InputEventMouseButton) or !event.pressed or event.button_index != BUTTON_LEFT:
		return
	if code == pick:
		return
	pick = code
	replace_code = ''
	if recipient != null and fit(recipient).off:
		recipient = null
		for entry in ranked_recipients():
			if !entry.fit.off:
				recipient = entry.person
				break
	refresh()


func on_to_card_input(event, code):
	if busy or !(event is InputEventMouseButton) or !event.pressed or event.button_index != BUTTON_LEFT:
		return
	replace_code = code
	fill_to()
	fill_foot()


func transfer():
	if busy or recipient == null or pick == '':
		return
	if recipient.preview_trait_binding(pick, replace_code).blocked != '' or ResourceScripts.game_res.get_item_amount('soul_stone') < 1:
		return
	busy = true
	fill_foot()
	tween.remove_all()
	if selected_card != null:
		tween.interpolate_property(selected_card, "modulate", Color(1, 1, 1, 1), Color(HAZE.r, HAZE.g, HAZE.b, 0), 0.7, Tween.TRANS_SINE, Tween.EASE_IN)
	if incoming_card != null:
		tween.interpolate_property(incoming_card, "modulate", Color(HAZE.r, HAZE.g, HAZE.b, 0.55), Color(1, 1, 1, 1), 0.8, Tween.TRANS_SINE, Tween.EASE_OUT, 0.35)
	for card in lost_cards:
		tween.interpolate_property(card, "modulate:a", 1.0, 0.0, 0.6, Tween.TRANS_SINE, Tween.EASE_IN, 0.2)
	tween.start()
	yield(tween, "tween_all_completed")
	var code = pick
	var person = recipient
	var moved = donor.transfer_trait(code, person, replace_code)
	if moved:
		ResourceScripts.game_res.remove_item("soul_stone", 1)
		globals.mansion_activity_log_add('stat_change', tr("SOULSTONE_LOG").replace("{donor}", donor.get_short_name()).replace("{trait}", Traitdata.traits[code].name).replace("{recipient}", person.get_short_name()))
	if gui_controller.inventory != null and gui_controller.inventory.is_visible():
		gui_controller.inventory.set_active_hero(donor)
	busy = false
	hide()
	#a breakdown opens its own scene and takes the donor away, so the window is gone first
	if moved:
		donor.try_breakdown('brk_soul_stone')


#While open, keys stay here; Escape or a right click closes it.
func _input(event):
	if !visible:
		return
	if event.is_action_pressed("ui_cancel") or (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT):
		close()
		get_tree().set_input_as_handled()
	elif event is InputEventKey:
		get_tree().set_input_as_handled()
