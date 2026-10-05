extends Control

#Character creation's starting traits. Physical, Mental and Magic have a slot each (Unnatural Constitution
#opens a second Physical one). Negative traits are always open; positive ones are one free plus one for
#each negative trait taken. The pool is every trait of those kinds that can roll at generation.

const CATS = ['physical', 'mental', 'magic']
const LOCKED_TILE = Color(0.45, 0.45, 0.45)
const NAME_COLOR = Color(1, 1, 0)
const EMPTY_COLOR = Color(0.42, 0.4, 0.36)
const SLOT_EDGE = Color(0.172549, 0.133333, 0.188235)
const NOT_READY = Color(0.55, 0.55, 0.55)

onready var rules = $Center/Window/VBox/Body/Rules
onready var slots = $Center/Window/VBox/Body/Slots
onready var drawer = $Center/Window/VBox/Body/Drawer
onready var pos_grid = $Center/Window/VBox/Body/Drawer/VBox/PosGrid
onready var neg_grid = $Center/Window/VBox/Body/Drawer/VBox/NegGrid
onready var clear_button = $Center/Window/VBox/Body/Foot/Clear
onready var confirm_button = $Center/Window/VBox/Body/Foot/Confirm

var creator
var person
var picks = []
var open_cat = 'physical'
var pool = {}


func _ready():
	hide()
	clear_button.connect("pressed", self, "clear")
	confirm_button.connect("pressed", self, "confirm")
	$Dim.connect("gui_input", self, "on_dim_input")
	rules.bbcode_text = "[center]" + globals.TextEncoder(tr("STARTTRAITS_RULES")) + "[/center]"


#creator: the character creation panel, which keeps the choice in its preserved settings
func open(creator_node):
	creator = creator_node
	person = creator.person
	build_pool()
	picks = []
	for code in creator.get_starting_traits():
		if in_pool(code) and !picks.has(code):
			picks.append(code)
	picks = trim(picks)
	open_cat = Traitdata.traits[picks[0]].category if !picks.empty() else 'physical'
	refresh()
	show()


func close():
	hide_tooltip()
	hide()


func build_pool():
	pool.clear()
	for cat in CATS:
		pool[cat] = {pos = [], neg = []}
	for code in Traitdata.traits:
		var data = Traitdata.traits[code]
		if !data.has('weight') or !CATS.has(data.get('category', '')) or data.tags.has('bondage'):
			continue
		var pol = polarity(code)
		if pol != '':
			pool[data.category][pol].append(code)
	for cat in CATS:
		for pol in ['pos', 'neg']:
			pool[cat][pol].sort_custom(self, "by_name")


func by_name(a, b):
	return tr(Traitdata.traits[a].name) < tr(Traitdata.traits[b].name)


func polarity(code):
	var tags = Traitdata.traits[code].tags
	if tags.has('positive'):
		return 'pos'
	if tags.has('negative'):
		return 'neg'
	return ''


func in_pool(code):
	if !Traitdata.traits.has(code) or polarity(code) == '':
		return false
	var cat = Traitdata.traits[code].get('category', '')
	return pool.has(cat) and pool[cat][polarity(code)].has(code)


# ---------- the rules ----------

func capacity(list, cat):
	var res = 1
	for code in list:
		res += int(Traitdata.traits[code].bonusstats.get('trait_slots_' + cat, 0))
	return res


func in_category(list, cat):
	var res = []
	for code in list:
		if Traitdata.traits[code].category == cat:
			res.append(code)
	return res


#A full category gives up the newest pick of the newcomer's kind, else its newest; a category that lost
#a slot (Unnatural Constitution gone) drops its newest, as ch_dyn_stats.trim_trait_category does.
func trim(list, keep = ''):
	var res = list.duplicate()
	while true:
		var cut = ''
		for cat in CATS:
			var here = in_category(res, cat)
			if here.size() <= capacity(res, cat):
				continue
			var others = []
			var same = []
			for code in here:
				if code == keep:
					continue
				others.append(code)
				if keep != '' and Traitdata.traits[keep].category == cat and polarity(code) == polarity(keep):
					same.append(code)
			var choice = same if !same.empty() else (others if !others.empty() else here)
			cut = choice[choice.size() - 1]
			break
		if cut == '':
			return res
		res.erase(cut)
	return res


func toggled(list, code):
	var res = list.duplicate()
	if res.has(code):
		res.erase(code)
		return trim(res)
	res.append(code)
	return trim(res, code)


func count(list, pol):
	var res = 0
	for code in list:
		if polarity(code) == pol:
			res += 1
	return res


func block_reason(code):
	if picks.has(code) or polarity(code) == 'neg':
		return ''
	var next = toggled(picks, code)
	if count(next, 'pos') > 1 + count(next, 'neg'):
		return tr("STARTTRAITS_LOCKED")
	return ''


#positive traits past one free and one per negative trait, newest first: what removing a negative left unpaid
func unpaid_codes():
	var over = count(picks, 'pos') - (1 + count(picks, 'neg'))
	if over <= 0:
		return []
	var positives = []
	for code in picks:
		if polarity(code) == 'pos':
			positives.append(code)
	return positives.slice(positives.size() - over, positives.size() - 1)


# ---------- drawing ----------

func refresh():
	hide_tooltip()
	fill_slots()
	fill_drawer()
	var ready = unpaid_codes().empty()
	confirm_button.disabled = !ready
	confirm_button.modulate = Color(1, 1, 1) if ready else NOT_READY


func fill_slots():
	input_handler.ClearContainer(slots, ['Slot'])
	var unpaid = unpaid_codes()
	for cat in CATS:
		var slot = input_handler.DuplicateContainerTemplate(slots, 'Slot')
		var color = globals.get_trait_category_color(cat)
		var style = slot.get_stylebox("panel").duplicate()
		style.border_color = color if cat == open_cat else SLOT_EDGE
		style.set_border_width_all(2 if cat == open_cat else 1)
		slot.add_stylebox_override("panel", style)
		var head = slot.get_node("VBox/Head")
		head.get_node("LineL").color = color
		head.get_node("LineR").color = color
		head.get_node("Icon").texture = load(Traitdata.catalogue.categories[cat].icon)
		head.get_node("Icon").self_modulate = color
		head.get_node("Name").text = tr("TRAITCATEGORYNAME_" + cat.to_upper())
		head.get_node("Name").add_color_override("font_color", color)
		var cap = capacity(picks, cat)
		head.get_node("Cap").visible = cap > 1
		head.get_node("Cap").text = tr("STARTTRAITS_SLOTS").replace("{n}", str(cap))
		var tiles = slot.get_node("VBox/Tiles")
		var mine = in_category(picks, cat)
		var names = []
		for i in range(cap):
			var cell = input_handler.DuplicateContainerTemplate(tiles, 'SlotTile')
			var tile = cell.get_node("Tile")
			tile.connect("pressed", self, "open_category", [cat])
			if i < mine.size():
				var code = mine[i]
				globals.fill_trait_button(tile, globals.get_trait_entry(person, code))
				globals.connecttexttooltip(tile, tip_text(code, false))
				cell.get_node("Unpaid").visible = unpaid.has(code)
				var remove = cell.get_node("Remove")
				remove.show()
				remove.connect("pressed", self, "remove_pick", [code])
				globals.connecttexttooltip(remove, tr("REMOVE"))
				names.append(tr(Traitdata.traits[code].name))
			else:
				globals.fill_trait_button(tile, {category = cat, empty = true})
		var label = slot.get_node("VBox/Names")
		label.text = PoolStringArray(names).join(", ") if !names.empty() else tr("TRAITSLOT_EMPTY")
		label.add_color_override("font_color", NAME_COLOR if !names.empty() else EMPTY_COLOR)
		slot.connect("gui_input", self, "on_slot_input", [cat])


func fill_drawer():
	var style = drawer.get_stylebox("panel").duplicate()
	style.border_color = globals.get_trait_category_color(open_cat)
	drawer.add_stylebox_override("panel", style)
	fill_grid(pos_grid, pool[open_cat].pos)
	fill_grid(neg_grid, pool[open_cat].neg)


func fill_grid(grid, codes):
	input_handler.ClearContainer(grid, ['Pick'])
	for code in codes:
		var pick = input_handler.DuplicateContainerTemplate(grid, 'Pick')
		var tile = pick.get_node("Tile")
		globals.fill_trait_button(tile, globals.get_trait_entry(person, code))
		var locked = block_reason(code) != ''
		pick.get_node("Sel").visible = picks.has(code)
		pick.get_node("Lock").visible = locked
		tile.modulate = LOCKED_TILE if locked else Color(1, 1, 1)
		tile.mouse_default_cursor_shape = CURSOR_FORBIDDEN if locked else CURSOR_POINTING_HAND
		globals.connecttexttooltip(tile, tip_text(code, true))
		tile.connect("pressed", self, "toggle", [code])


#The trait's own tooltip, with what this window adds: the negative's bargain, why a positive is locked,
#which positive is left unpaid. The flavor stays last, as everywhere else.
func tip_text(code, in_list):
	var data = Traitdata.traits[code]
	var text = globals.get_trait_tooltip_head(tr(data.name), globals.get_trait_tag_line(data.category, data.tags))
	text += globals.get_trait_effects_text(person, code)
	if polarity(code) == 'neg':
		text += "\n{color=green|" + tr("STARTTRAITS_NEG_RULE") + "}"
	var why = block_reason(code)
	if why != '':
		text += "\n{color=red|" + why + "}"
	if unpaid_codes().has(code):
		text += "\n{color=red|" + tr("STARTTRAITS_UNPAID") + "}"
	var flavor = globals.get_trait_flavor(person, code)
	if flavor != '':
		text += "\n" + globals.get_trait_flavor_text(flavor)
	if in_list and picks.has(code):
		text += "\n" + globals.get_trait_flavor_text(tr("STARTTRAITS_REMOVE_HINT"))
	return text


func hide_tooltip():
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP, null, false, false).hide()


# ---------- input ----------

func toggle(code):
	if block_reason(code) != '':
		return
	picks = toggled(picks, code)
	refresh()


func remove_pick(code):
	picks = toggled(picks, code)
	refresh()


func open_category(cat):
	if cat == open_cat:
		return
	open_cat = cat
	refresh()


func on_slot_input(event, cat):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		open_category(cat)


func on_dim_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		close()


func clear():
	picks = []
	refresh()


func confirm():
	if !unpaid_codes().empty():
		return
	creator.set_starting_traits(picks.duplicate())
	close()


#While open, keys stay here; Escape or a right click closes it without changes.
func _input(event):
	if !visible:
		return
	if event.is_action_pressed("ui_cancel") or (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT):
		close()
		get_tree().set_input_as_handled()
	elif event is InputEventKey:
		get_tree().set_input_as_handled()
