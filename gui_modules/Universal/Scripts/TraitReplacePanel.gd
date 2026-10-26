extends Control

const NEW_CARD_BORDER = Color(0.906, 0.78, 0.435)
const PICKED_CARD_BORDER = Color(0.85, 0.33, 0.27)
const LOCKED_TINT = Color(0.6, 0.6, 0.6)

onready var title_before = $Center/Window/VBox/Title/Before
onready var title_name = $Center/Window/VBox/Title/Name
onready var title_after = $Center/Window/VBox/Title/After
onready var lead = $Center/Window/VBox/Body/Lead
onready var new_col = $Center/Window/VBox/Body/Choice/NewCol
onready var replace_button = $Center/Window/VBox/Body/Choice/NewCol/Replace
onready var cat_head = $Center/Window/VBox/Body/Choice/CurCol/CatHead
onready var cards = $Center/Window/VBox/Body/Choice/CurCol/Cards
onready var keep_button = $Center/Window/VBox/Body/Choice/CurCol/Keep

var queue = []
var current = {}
var person
var new_code
var free_slot = '' #the category's stand-in (Worldly) put up as the slot a confirm_first trait takes
var picked = '' #the current trait Replace writes over
var pick_cards = {} #code: card, for the current traits the player clicks between when more than one can give way
var card_style
var picked_style
var is_set_up = false


func _ready():
	hide()
	keep_button.connect("pressed", self, "keep")
	replace_button.connect("pressed", self, "replace")
	card_style = cards.get_node("Card").get_stylebox("panel")
	picked_style = card_style.duplicate()
	picked_style.border_color = PICKED_CARD_BORDER
	picked_style.set_border_width_all(2)
	is_set_up = true
	if !queue.empty():
		show_next()


#One offer on screen at a time, the rest wait their turn.
func offer(t_person, code):
	queue.append({id = t_person.id, trait = code})
	if is_set_up and !visible:
		show_next()


#The same choice, put before the skill or item that brings the trait is paid for (ch_skills.ask_offered_trait_first):
#a pick calls obj.method(old_code, args...), keeping the current trait calls nothing and nothing is spent.
func ask_first(t_person, code, obj, method, args = []):
	queue.append({id = t_person.id, trait = code, callback = [obj, method, args]})
	if is_set_up and !visible:
		show_next()


#A trait the player asked for (a temple's conversion): the choice is put up even when a slot is free, and that
#free slot is the one card to pick. texts may name title, lead and keep keys of the offer's own.
func confirm_first(t_person, code, obj, method, args = [], texts = {}):
	queue.append({id = t_person.id, trait = code, callback = [obj, method, args], confirm = true, texts = texts})
	if is_set_up and !visible:
		show_next()


#An offer that waited may have gone stale: a slot freed meanwhile just takes the trait.
func show_next():
	while !queue.empty():
		var rec = queue.pop_front()
		var p = characters_pool.get_char_by_id(rec.id)
		if p == null:
			continue
		match p.preview_trait_offer(rec.trait):
			'ask':
				current = rec
				open_for(p, rec.trait)
				return
			'add':
				if rec.get('confirm', false):
					current = rec
					open_for(p, rec.trait)
					return
				if rec.has('callback'):
					run_callback(rec, '')
				else:
					p.add_trait(rec.trait)
	current = {}
	person = null
	hide()
	gui_controller.request_screen_refresh()


func run_callback(rec, old_code):
	var cb = rec.callback
	cb[0].callv(cb[1], [old_code] + cb[2])


func open_for(p, code):
	person = p
	new_code = code
	var texts = current.get('texts', {})
	var category = person.get_trait_category(code)
	free_slot = ''
	if current.get('confirm', false) and person.dyn_stats.get_free_trait_slots(category) > 0:
		free_slot = Traitdata.catalogue.defaults.get(category, '')
	var shown = []
	if free_slot != '':
		shown.append(free_slot)
	else:
		for item in person.get_category_traits(category):
			if Traitdata.traits[item].get('visible', true):
				shown.append(item)
	var title = tr(texts.get('title', "TRAITREPLACE_TITLE")).split("{name}")
	title_before.text = title[0]
	title_name.text = person.get_short_name()
	title_after.text = title[1] if title.size() > 1 else ""
	var many = shown.size() > 1
	var category_name = tr("TRAITCATEGORYNAME_" + category.to_upper()).to_lower()
	var lead_key = texts.get('lead', "TRAITREPLACE_LEAD_MANY" if many else "TRAITREPLACE_LEAD_ONE")
	lead.text = person.translate(tr(lead_key)).replace("{category}", category_name)
	var color = globals.get_trait_category_color(category)
	cat_head.get_node("LineL").color = color
	cat_head.get_node("LineR").color = color
	cat_head.get_node("Icon").texture = load(Traitdata.catalogue.categories[category].icon)
	cat_head.get_node("Icon").self_modulate = color

	input_handler.ClearContainer(new_col, ['Kicker', 'Replace'])
	var new_card = cards.get_node("Card").duplicate()
	new_card.name = "NewCard"
	new_card.size_flags_vertical = SIZE_EXPAND_FILL
	var style = new_card.get_stylebox("panel").duplicate()
	style.border_color = NEW_CARD_BORDER
	style.set_border_width_all(2)
	new_card.add_stylebox_override("panel", style)
	new_col.add_child(new_card)
	new_col.move_child(new_card, replace_button.get_index())
	new_card.show()
	fill_card(new_card, code, false)

	var replaceable = []
	for item in shown:
		if can_give_way(item):
			replaceable.append(item)
	#a single trait that can give way is the one Replace takes; with several the player clicks one first
	picked = replaceable[0] if replaceable.size() == 1 else ''
	pick_cards.clear()
	input_handler.ClearContainer(cards, ['Card'])
	for item in shown:
		var card = input_handler.DuplicateContainerTemplate(cards, 'Card')
		fill_card(card, item, true)
		if replaceable.size() > 1 and replaceable.has(item):
			card.mouse_filter = MOUSE_FILTER_STOP
			card.mouse_default_cursor_shape = CURSOR_POINTING_HAND
			card.connect("gui_input", self, "card_input", [item])
			pick_cards[item] = card
	show_picked()

	keep_button.get_node("Label").text = tr(texts.get('keep', "TRAITREPLACE_KEEP"))
	show()
	if gui_controller.dialogue != null and gui_controller.dialogue.is_visible():
		gui_controller.dialogue.add_select_blocking_node(self)


func fill_card(card, code, is_current):
	var data = Traitdata.traits[code]
	var hidden = person.is_trait_hidden(code)
	var entry = globals.get_trait_entry(person, code)
	var box = card.get_node("VBox")
	globals.fill_trait_button(box.get_node("Tile"), entry)
	box.get_node("Name").text = entry.name
	box.get_node("Tags").bbcode_text = "[center]" + globals.TextEncoder(globals.get_trait_tag_line(data.category, [] if hidden else data.tags)) + "[/center]"
	var effects = box.get_node("Fx")
	var flavor = box.get_node("Flavor")
	if hidden:
		effects.hide()
		flavor.bbcode_text = "[center]" + person.translate(tr("TRAITHIDDENTOOLTIP")) + "[/center]"
	else:
		effects.bbcode_text = "[center]" + globals.TextEncoder(globals.get_trait_effects_text(person, code)) + "[/center]"
		var text = globals.get_trait_flavor(person, code)
		flavor.visible = text != ''
		flavor.bbcode_text = "[center]" + text + "[/center]"
	var reason = box.get_node("Reason")
	reason.hide()
	if !is_current or can_give_way(code):
		return
	reason.show()
	var lock_key = "TRAITREPLACE_LOCK_INNATE"
	if data.tags.has('permanent'):
		lock_key = "TRAITREPLACE_LOCK_PERMANENT"
	elif data.tags.has('bondage'):
		lock_key = "TRAITREPLACE_LOCK_STATUS"
	reason.get_node("Text").text = tr(lock_key)
	box.modulate = LOCKED_TINT


#an empty slot beside a held trait (Split Mind) shows as the stand-in, which the character does not hold
func can_give_way(code):
	return code == free_slot or !person.is_trait_locked(code)


func card_input(event, code):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		picked = code
		show_picked()


func show_picked():
	replace_button.disabled = picked == ''
	replace_button.modulate = LOCKED_TINT if picked == '' else Color(1, 1, 1)
	for code in pick_cards:
		pick_cards[code].add_stylebox_override("panel", picked_style if code == picked else card_style)


func replace():
	if person == null or picked == '':
		return
	var old_code = picked
	if !current.has('callback'):
		person.replace_trait(old_code, new_code)
		show_next()
		return
	#the use is paid for only now; the panel goes first so the use's own dialogue is not opened under it
	var rec = current
	current = {}
	person = null
	hide()
	run_callback(rec, old_code)
	if !visible:
		show_next()


func keep():
	if person == null:
		return
	show_next()


#While a choice is up, keys and right clicks wait: they would reach the screen under it.
func _input(event):
	if !visible:
		return
	if event is InputEventKey or (event is InputEventMouseButton and event.button_index == BUTTON_RIGHT):
		get_tree().set_input_as_handled()
