extends Control

const NEW_CARD_BORDER = Color(0.906, 0.78, 0.435)
const LOCKED_TINT = Color(0.6, 0.6, 0.6)

onready var title_before = $Center/Window/VBox/Title/Before
onready var title_name = $Center/Window/VBox/Title/Name
onready var title_after = $Center/Window/VBox/Title/After
onready var lead = $Center/Window/VBox/Body/Lead
onready var new_col = $Center/Window/VBox/Body/Choice/NewCol
onready var cat_head = $Center/Window/VBox/Body/Choice/CurCol/CatHead
onready var cards = $Center/Window/VBox/Body/Choice/CurCol/Cards
onready var keep_button = $Center/Window/VBox/Body/Foot/Keep

var queue = []
var person
var new_code
var is_set_up = false


func _ready():
	hide()
	keep_button.connect("pressed", self, "keep")
	is_set_up = true
	if !queue.empty():
		show_next()


#One offer on screen at a time, the rest wait their turn.
func offer(t_person, code):
	queue.append({id = t_person.id, trait = code})
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
				open_for(p, rec.trait)
				return
			'add':
				p.add_trait(rec.trait)
	person = null
	hide()
	gui_controller.request_screen_refresh()


func open_for(p, code):
	person = p
	new_code = code
	var category = person.get_trait_category(code)
	var current = []
	for item in person.get_category_traits(category):
		if Traitdata.traits[item].get('visible', true):
			current.append(item)
	var title = tr("TRAITREPLACE_TITLE").split("{name}")
	title_before.text = title[0]
	title_name.text = person.get_short_name()
	title_after.text = title[1] if title.size() > 1 else ""
	var many = current.size() > 1
	var category_name = tr("TRAITCATEGORYNAME_" + category.to_upper()).to_lower()
	lead.text = person.translate(tr("TRAITREPLACE_LEAD_MANY" if many else "TRAITREPLACE_LEAD_ONE")).replace("{category}", category_name)
	var color = globals.get_trait_category_color(category)
	cat_head.get_node("LineL").color = color
	cat_head.get_node("LineR").color = color
	cat_head.get_node("Icon").texture = load(Traitdata.catalogue.categories[category].icon)
	cat_head.get_node("Icon").self_modulate = color

	input_handler.ClearContainer(new_col, ['Kicker'])
	var new_card = cards.get_node("Card").duplicate()
	new_card.name = "NewCard"
	new_card.size_flags_vertical = SIZE_EXPAND_FILL
	var style = new_card.get_stylebox("panel").duplicate()
	style.border_color = NEW_CARD_BORDER
	style.set_border_width_all(2)
	new_card.add_stylebox_override("panel", style)
	new_col.add_child(new_card)
	new_card.show()
	fill_card(new_card, code, false)

	input_handler.ClearContainer(cards, ['Card'])
	for item in current:
		fill_card(input_handler.DuplicateContainerTemplate(cards, 'Card'), item, true)

	keep_button.text = tr("TRAITREPLACE_KEEP_MANY" if many else "TRAITREPLACE_KEEP_ONE")
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
	var replace_button = box.get_node("Replace")
	var reason = box.get_node("Reason")
	replace_button.hide()
	reason.hide()
	if !is_current:
		return
	if person.is_trait_locked(code):
		reason.show()
		var lock_key = "TRAITREPLACE_LOCK_INNATE"
		if data.tags.has('permanent'):
			lock_key = "TRAITREPLACE_LOCK_PERMANENT"
		elif data.tags.has('bondage'):
			lock_key = "TRAITREPLACE_LOCK_STATUS"
		reason.get_node("Text").text = tr(lock_key)
		box.modulate = LOCKED_TINT
	else:
		replace_button.show()
		replace_button.connect("pressed", self, "replace", [code])


func replace(old_code):
	if person == null:
		return
	person.replace_trait(old_code, new_code)
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
