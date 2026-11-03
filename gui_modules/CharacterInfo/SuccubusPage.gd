extends Control

#The succubus page of CharacterTrainingPopup: her thralls and the type each holds, the level they raise
#her to, the powers bought with unlock points and the spells she casts. `root` is the popup.

var person
var root

#a thrall holds one type at a time (ch_dyn_stats.can_take_thrall_status); these skills grant them
const TYPE_SKILLS = {
	ascended_thrall = 'grant_ascended_thrall',
	lust_doll = 'grant_lust_doll',
	chosen_consort = 'grant_chosen_consort',
	lesser_succubus = 'grant_lesser_succubus',
}
const TYPE_CHOICES = ['ascended_thrall', 'lust_doll', 'chosen_consort']
#the power every grant skill needs (Traitdata.succubus_trainings)
const SPECIALIZATION = 'thrall_specialization'
#the order a type is read in - a save from before types were exclusive can hold several
const TYPE_ORDER = ['lesser_succubus', 'ascended_thrall', 'lust_doll', 'chosen_consort']
const TYPE_COLORS = {
	ascended_thrall = Color('#f663b6'),
	lust_doll = Color('#b07cff'),
	chosen_consort = Color('#f9e181'),
	lesser_succubus = Color('#e0525e'),
}
const GOLD = Color('#f9e181')
const HIGHLIGHT = Color('#fec852')
const MUTED = Color('#8f826a')
const LUST_COLOR = Color('#f663b6')
const MP_COLOR = Color('#81aaf9')
const SHORT_COLOR = Color('#ff5e5e')

#the slot row and the drawer that opens under it, its notch pointing at the thrall it is for
const SLOT_WIDTH = 140
const SLOT_GAP = 13
const CARD_WIDTH = 286
const CARD_HEIGHT = 440
const CARD_GAP = 12
const DRAWER_PAD = 14
const NOTE_WIDTH = 440
const NOTE_HEIGHT = 60
const DIM = 0.35

#the powers: a row per succubus level, three columns (Traitdata.succubus_trainings level and column),
#the rows of levels not reached yet dimmed as the mastery trees do
const TREE_COLUMNS = 3
const AVAILABLE_COLOR = Color('#6ee06e')
const UNREACHED_ROW = Color(0.55, 0.55, 0.55, 0.85)
#the first power: Enthrall and Release Thrall
const ENTHRALLMENT = 'enthrallment'

onready var slots = $Thralls/Slots
onready var drawer = $Drawer
onready var cards = $Drawer/Cards
onready var shade = $Shade
onready var rows_box = $Tree/Rows

#the thrall whose drawer is open, by id
var drawer_for = null


func _ready():
	shade.connect("gui_input", self, "_on_shade_input")
	#a granted type, an enthralled or released thrall all end in a report window
	input_handler.connect("EventFinished", self, "_on_event_finished")


func set_person(t_person):
	if person != t_person:
		drawer_for = null
	person = t_person
	update()


func update():
	if person == null:
		return
	build_header()
	build_thralls()
	build_trainings()
	build_spells()
	build_drawer()


#the popup redraws the whole window - the footer counts unlock points - and calls update() back
func refresh():
	if root != null:
		root.update()
	else:
		update()


func _on_event_finished():
	if person != null and is_visible_in_tree():
		refresh()


#level, experience toward the next one, and the lust the thralls bring in every turn
func build_header():
	$Thralls/Head/Count.text = "%d / %d" % [person.get_stat('thralls_amount'), person.get_stat('thralls_amount_max')]
	var center = $Thralls/Center
	var level = max(person.get_stat('succubus_level'), 1)
	var experience = person.get_stat('succubus_exp')
	var thresholds = Traitdata.succubus_levels.exp
	center.get_node('Level').text = "%s %d" % [tr("STATSUCCUBUS_LEVEL"), level]
	var bar = center.get_node('ExpBar')
	if level < thresholds.size():
		bar.min_value = thresholds[level - 1]
		bar.max_value = thresholds[level]
		bar.value = experience
		center.get_node('ExpValue').text = "%d / %d" % [experience, thresholds[level]]
	else:
		bar.min_value = 0
		bar.max_value = 1
		bar.value = 1
		center.get_node('ExpValue').text = str(experience)
	var level_text = levels_tooltip()
	for id in ['Level', 'ExpBar', 'ExpValue']:
		globals.connecttexttooltip(center.get_node(id), level_text)
	center.get_node('Lust').text = tr("SUCCUBUS_LUST_PER_TURN") % str(person.enthrall.get_thrall_lust_tick())
	globals.connecttexttooltip(center.get_node('Lust'), lust_tooltip())


#each level's thrall slots, unlock points and passive, the current one in green
func levels_tooltip():
	var text = person.translate(tr("SUCCUBUS_LEVELS_TOOLTIP")) + "\n\n"
	var level = person.get_stat('succubus_level')
	for i in range(1, Traitdata.succubus_levels.exp.size() + 1):
		var gains = "%s %d" % [tr("SUCCUBUS_LEVELS_TOOLTIP_SLOTS"), i]
		var points = Traitdata.succubus_levels.points[i - 1]
		if points > 0:
			gains += ", " + tr("SUCCUBUS_LEVELS_TOOLTIP_POINTS") % points
		var line = "%d: %s. %s" % [i, gains,
			globals.build_oneline_desc_for_bonusstats(Effectdata.effect_table['succubus_level_%d' % i].statchanges)]
		if i == level:
			text += '{color=green|' + line + '}\n'
		else:
			text += line + '\n'
	return text.trim_suffix('\n')


func lust_tooltip():
	var data = Traitdata.succubus_levels
	var text = "{color=yellow|" + tr("SUCCUBUS_LUST_FROM_THRALLS") + "}"
	for id in person.get_stat('thralls'):
		var tchar = characters_pool.get_char_by_id(id)
		var amount = data.lust_per_doll if tchar.check_trait('lust_doll') else data.lust_per_thrall
		text += "\n%s: +%d" % [tchar.get_short_name(), amount]
	return text


#One slot per level: a thrall, a free slot that casts Enthrall, or a slot a later level opens.
func build_thralls():
	input_handler.ClearContainer(slots, ['Slot'])
	var held = person.get_stat('thralls')
	var open = person.get_stat('thralls_amount_max')
	for i in range(Traitdata.succubus_levels.exp.size()):
		var slot = input_handler.DuplicateContainerTemplate(slots, 'Slot')
		if i < held.size():
			fill_thrall(slot, characters_pool.get_char_by_id(held[i]))
		elif i < open:
			fill_empty(slot)
		else:
			fill_locked(slot, i + 1)
		if drawer_for != null and !(i < held.size() and held[i] == drawer_for):
			slot.modulate.a = DIM


func fill_thrall(slot, tchar):
	var frame = slot.get_node('Frame')
	var portrait = frame.get_node('Portrait')
	var type = thrall_type(tchar)
	var bond = int(clamp(tchar.enthrall.get_bond(), 0, 100))
	portrait.texture = tchar.get_icon()
	globals.connectslavetooltip(frame, tchar)
	if tchar.is_on_quest():
		portrait.modulate = Color(0.5, 0.5, 0.5)
		frame.get_node('Quest').visible = true
	#the portrait opens the same drawer the cross does - with nothing to grant, it says why
	frame.connect('pressed', self, 'toggle_drawer', [tchar])
	if type != '':
		set_frame_border(frame, TYPE_COLORS[type], 2, ['normal', 'disabled'])
		var pip = frame.get_node('Pip')
		pip.visible = true
		pip.get_node('Icon').texture = trait_icon(type)
		var style = pip.get_stylebox('panel').duplicate()
		style.border_color = TYPE_COLORS[type]
		pip.add_stylebox_override('panel', style)
		globals.connecttexttooltip(pip, "[center]" + trait_name(type, tchar) + "[/center]\n" + tchar.translate(Traitdata.traits[type].descript))
	slot.get_node('Name').text = tchar.get_short_name()
	var bar = slot.get_node('Bond')
	var value = slot.get_node('BondValue')
	bar.visible = true
	bar.value = bond
	value.visible = true
	value.text = str(bond)
	#pink once the bond is enough for a type
	if bond >= Traitdata.succubus_levels.status_bond:
		var fill = bar.get_stylebox('fg').duplicate()
		fill.bg_color = LUST_COLOR
		bar.add_stylebox_override('fg', fill)
		value.set("custom_colors/font_color", LUST_COLOR)
	globals.connecttexttooltip(bar, bond_tooltip(tchar, bond))
	var mode = up_mode(tchar)
	var up = slot.get_node('Up')
	up.visible = mode != ''
	if mode != '':
		up.text = "×" if drawer_for == tchar.id else "+"
		up.connect('pressed', self, 'toggle_drawer', [tchar])
		if mode == 'raise':
			globals.connecttexttooltip(up, tchar.translate(tr("SUCCUBUS_RAISE_READY") % trait_name('lesser_succubus', tchar)))
		else:
			globals.connecttexttooltip(up, tchar.translate(tr("SUCCUBUS_TYPE_READY")))
	if drawer_for == tchar.id:
		set_frame_border(frame, HIGHLIGHT, 3, ['normal', 'hover', 'pressed', 'disabled'])


#a free slot casts Enthrall on the character picked next - and stays shut, saying why, while Enthrall
#is not learned or cannot be cast
func fill_empty(slot):
	var frame = slot.get_node('Frame')
	var plus = frame.get_node('Plus')
	plus.visible = true
	set_frame_border(frame, Color(0.77, 0.52, 0.26, 0.45), 2, ['normal', 'disabled'])
	var title = "[center]%s[/center]\n" % tr(Skilldata.Skilllist.enthrall.name)
	var block
	if !person.get_social_skills().has('enthrall'):
		block = tr("SUCCUBUS_SLOT_NEEDS_POWER") % tr(Traitdata.traits[ENTHRALLMENT].name)
	else:
		block = spell_block('enthrall')
	if block != '':
		frame.disabled = true
		plus.modulate.a = DIM
		globals.connecttexttooltip(frame, title + "{color=red|%s}" % block)
		return
	frame.connect('pressed', self, 'select_spell', ['enthrall'])
	var cost = Skilldata.get_template('enthrall', person).cost
	globals.connecttexttooltip(frame, title + tr("SUCCUBUS_SLOT_ENTHRALL") + "\n%s %s" % [tr("SUCCUBUS_COST"), cost_string(cost)])


func fill_locked(slot, level):
	var frame = slot.get_node('Frame')
	frame.disabled = true
	frame.get_node('Lock').visible = true
	set_frame_border(frame, Color(0.18, 0.17, 0.15), 2, ['disabled'])
	globals.connecttexttooltip(frame, tr("SUCCUBUS_SLOT_LOCKED") % [level, Traitdata.succubus_levels.exp[level - 1]])


func set_frame_border(frame, color, width, states):
	for state in states:
		var style = frame.get_stylebox(state).duplicate()
		style.border_color = color
		style.set_border_width_all(width)
		frame.add_stylebox_override(state, style)


func bond_tooltip(tchar, bond):
	var data = Traitdata.succubus_levels
	return tchar.translate(tr("SUCCUBUS_BOND_TOOLTIP") % [bond_label(), bond, data.bond_per_tick_near, data.bond_per_tick, data.status_bond])


#the bond is the thrall's affection when the Master is the succubus, their relationship otherwise
func bond_label():
	return tr("STATAFFECTION") if person.is_master() else tr("MSLMEXPANDEDRELATIONSHIP")


func thrall_type(tchar):
	for code in TYPE_ORDER:
		if tchar.check_trait(code):
			return code
	return ''


#what the cross on a portrait opens: 'type' for a thrall without one, 'raise' for an Ascended Thrall
#that can still become a Lesser Succubus, '' for none. The grant skills need Thrall Specialization and
#the thrall at hand.
func up_mode(tchar):
	if !person.check_trait(SPECIALIZATION):
		return ''
	if tchar.is_on_quest() or !person.same_location_with(tchar):
		return ''
	if tchar.enthrall.get_bond() < Traitdata.succubus_levels.status_bond:
		return ''
	match thrall_type(tchar):
		'':
			return 'type'
		'ascended_thrall':
			if cap_left('lesser_succubus'):
				return 'raise'
	return ''


func cap_left(code):
	var cap = Traitdata.succubus_levels.status_caps.get(code, -1)
	return cap < 0 or person.enthrall.count_thralls_with_trait(code) < cap


func toggle_drawer(tchar):
	if drawer_for == tchar.id:
		close_drawer()
		return
	drawer_for = tchar.id
	build_thralls()
	build_drawer()


func close_drawer():
	drawer_for = null
	build_thralls()
	build_drawer()


#the popup closing: nothing to redraw, the next open builds the page anew
func reset_drawer():
	drawer_for = null
	drawer.visible = false
	shade.visible = false


func _on_shade_input(event):
	if event is InputEventMouseButton and event.pressed:
		close_drawer()


#the drawer under the portraits, open for any thrall: what can be granted, or what stands in the way
func build_drawer():
	var tchar = null
	if drawer_for != null and person.get_stat('thralls').has(drawer_for):
		tchar = characters_pool.get_char_by_id(drawer_for)
	if tchar == null:
		if drawer_for != null:
			drawer_for = null
			build_thralls()
		drawer.visible = false
		shade.visible = false
		return
	var note = drawer_note(tchar)
	var note_label = $Drawer/Note
	cards.visible = note == ''
	note_label.visible = note != ''
	var width
	var height
	if note != '':
		note_label.bbcode_text = note
		width = NOTE_WIDTH
		height = DRAWER_PAD * 2 + NOTE_HEIGHT
	else:
		var codes = drawer_codes(tchar)
		input_handler.ClearContainer(cards, ['Card'])
		for code in codes:
			fill_card(input_handler.DuplicateContainerTemplate(cards, 'Card'), code, tchar)
		width = DRAWER_PAD * 2 + codes.size() * CARD_WIDTH + (codes.size() - 1) * CARD_GAP
		height = DRAWER_PAD * 2 + CARD_HEIGHT
	var index = person.get_stat('thralls').find(drawer_for)
	var center = $Thralls.rect_position.x + slots.rect_position.x + index * (SLOT_WIDTH + SLOT_GAP) + SLOT_WIDTH * 0.5
	var left = clamp(center - width * 0.5, 0, $Thralls.rect_size.x - width)
	drawer.rect_position = Vector2(left, $Thralls.rect_position.y + $Thralls.rect_size.y + 12)
	drawer.rect_size = Vector2(width, height)
	$Drawer/Notch.rect_position = Vector2(center - left, -13)
	drawer.visible = true
	shade.visible = true


#A thrall without a type who cannot take one yet gets a line in place of three shut cards: that roles
#need Thrall Specialization, that one opens once the bond grows, or that the thrall is not at hand.
func drawer_note(tchar):
	if thrall_type(tchar) != '':
		return ''
	if !person.check_trait(SPECIALIZATION):
		return tr("SUCCUBUS_TYPE_NEEDS_SPECIALIZATION") % tr(Traitdata.traits[SPECIALIZATION].name)
	if tchar.enthrall.get_bond() < Traitdata.succubus_levels.status_bond:
		return tchar.translate(tr("SUCCUBUS_TYPE_NOT_READY") % bond_label())
	if tchar.is_on_quest():
		return "%s: %s" % [tchar.get_short_name(), tr("SUCCUBUS_TYPE_ON_QUEST")]
	if !person.same_location_with(tchar):
		return "%s: %s" % [tchar.get_short_name(), tr("SUCCUBUS_TYPE_AWAY")]
	return ''


#The cards a thrall's drawer shows: the three types for a thrall without one; a thrall with a type gets
#only that type's details, and an Ascended Thrall the Lesser Succubus it can still grow into beside them.
func drawer_codes(tchar):
	var current = thrall_type(tchar)
	if current == '':
		return TYPE_CHOICES
	if current == 'ascended_thrall':
		return ['ascended_thrall', 'lesser_succubus']
	return [current]


#Name, what it takes, what it gives, what it costs. The thrall's own type shows only what it gives.
func fill_card(card, code, tchar):
	var skill = TYPE_SKILLS[code]
	var template = Skilldata.get_template(skill, person)
	card.get_node('Icon').texture = trait_icon(code)
	var name_label = card.get_node('Name')
	name_label.text = trait_name(code, tchar)
	name_label.set("custom_colors/font_color", TYPE_COLORS[code])
	var gives = globals.TextEncoder(tchar.translate(Traitdata.traits[code].descript))
	var body = card.get_node('Body')
	if thrall_type(tchar) == code:
		body.bbcode_text = gives
		card.get_node('Cost').visible = false
		card.get_node('Button').visible = false
		return
	var met = true
	var text = "[color=#%s]%s[/color]\n" % [MUTED.to_html(false), tr("SUCCUBUS_REQUIRES")]
	for line in requirement_lines(code, tchar):
		met = met and line[0]
		var color = variables.hexcolordict.green if line[0] else variables.hexcolordict.red
		text += "[color=%s]• %s[/color]\n" % [color, line[1]]
	text += "\n[color=#%s]%s[/color]\n%s" % [MUTED.to_html(false), tr("SUCCUBUS_GIVES"), gives]
	var note = type_note(code, tchar)
	if note != '':
		text += "\n[color=#%s]%s[/color]" % [MUTED.to_html(false), note]
	body.bbcode_text = text
	var lust = template.cost.get('lust', 0)
	var mp = template.cost.get('mp', 0)
	var lust_label = card.get_node('Cost/Lust')
	lust_label.text = "%s %s" % [cost_text(lust), tr("STATLUST")]
	lust_label.set("custom_colors/font_color", SHORT_COLOR if person.get_stat('lust') < lust else LUST_COLOR)
	var mp_label = card.get_node('Cost/Mp')
	mp_label.text = "%s %s" % [cost_text(mp), tr("STATMP")]
	mp_label.set("custom_colors/font_color", SHORT_COLOR if person.get_stat('mp') < mp else MP_COLOR)
	var button = card.get_node('Button')
	button.text = tr("SUCCUBUS_TYPE_RAISE") if code == 'lesser_succubus' else tr("SUCCUBUS_TYPE_CHOOSE")
	if !met:
		button.disabled = true
	elif person.get_stat('lust') < lust:
		button.disabled = true
		button.text = tr("SUCCUBUS_NOT_ENOUGH") % tr("STATLUST")
	elif person.get_stat('mp') < mp:
		button.disabled = true
		button.text = tr("SUCCUBUS_NOT_ENOUGH") % tr("STATMP")
	elif !person.check_skill_availability(skill, tchar).check:
		button.disabled = true
	else:
		button.connect('pressed', self, 'grant_type', [code, tchar])


#[met, text] for everything a type needs: Thrall Specialization (listed only while missing), the bond,
#an Ascended Thrall to grow from, room under the succubus's limit, the thrall at hand, the day's use of the skill
func requirement_lines(code, tchar):
	var data = Traitdata.succubus_levels
	var res = []
	if !person.check_trait(SPECIALIZATION):
		res.append([false, tr(Traitdata.traits[SPECIALIZATION].name)])
	var bond = int(clamp(tchar.enthrall.get_bond(), 0, 100))
	res.append([bond >= data.status_bond, "%d %s (%d)" % [data.status_bond, bond_label(), bond]])
	if code == 'lesser_succubus':
		res.append([thrall_type(tchar) == 'ascended_thrall', trait_name('ascended_thrall', tchar)])
	var cap = data.status_caps.get(code, -1)
	if cap > 0:
		var held = person.enthrall.count_thralls_with_trait(code)
		var limit = tr("SUCCUBUS_TYPE_ONLY_ONE") if cap == 1 else tr("SUCCUBUS_TYPE_AT_MOST") % cap
		res.append([held < cap, "%s (%d/%d)" % [limit, held, cap]])
	if tchar.is_on_quest():
		res.append([false, tr("SUCCUBUS_TYPE_ON_QUEST")])
	elif !person.same_location_with(tchar):
		res.append([false, tr("SUCCUBUS_TYPE_AWAY")])
	if !has_charge(TYPE_SKILLS[code]):
		res.append([false, tr("SUCCUBUS_TYPE_USED")])
	#a trait slot that will not take it, when nothing above explains why
	var all_met = true
	for line in res:
		all_met = all_met and line[0]
	if all_met and !tchar.dyn_stats.can_take_thrall_status(code):
		res.append([false, tr("SUCCUBUS_TYPE_CANT_TAKE")])
	return res


func type_note(code, tchar):
	match code:
		'ascended_thrall':
			return tr("SUCCUBUS_TYPE_CAN_RAISE") % trait_name('lesser_succubus', tchar)
		'lust_doll':
			return tr("SUCCUBUS_TYPE_REPLACES_SLAVE_STATUS")
	return ''


func has_charge(skill):
	var template = Skilldata.get_template(skill, person)
	return Skilldata.get_charges(template, person) - person.skills.social_skills_charges.get(skill, 0) > 0


func cost_string(cost):
	var parts = []
	if cost.get('lust', 0) > 0:
		parts.append("%s %s" % [cost_text(cost.lust), tr("STATLUST")])
	if cost.get('mp', 0) > 0:
		parts.append("%s %s" % [cost_text(cost.mp), tr("STATMP")])
	return PoolStringArray(parts).join(", ")


#The grant goes through the event window the way a dialogue skill does: the offer first, the grant
#skill on yes, then its own report (custom_effects.thrall_type_offer).
func grant_type(code, tchar):
	drawer_for = null
	build_thralls()
	build_drawer()
	var skill = TYPE_SKILLS[code]
	var template = Skilldata.get_template(skill, person)
	ResourceScripts.custom_effects.thrall_type_offer(person, tchar, skill, trait_name(code, tchar),
		tchar.translate(Traitdata.traits[code].descript), cost_string(template.cost))


#cost modifiers leave fractions (12.5 mana) - shown whole
func cost_text(value):
	return str(int(round(value)))


func trait_name(code, tchar):
	var trdata = Traitdata.traits[code]
	if trdata.has('altname') and tchar.checkreqs(trdata.altnamereqs):
		return tr(trdata.altname)
	return tr(trdata.name)


func trait_icon(code):
	return input_handler.loadimage(Traitdata.traits[code].icon, 'icons')


#The powers, a row per succubus level with its numeral, as the mastery trees have them: a card where a
#training sits, OR between two that shut each other out, an empty cell elsewhere (Genitalia Manipulation
#does not show for a man). Rows above her level are dimmed.
func build_trainings():
	input_handler.ClearContainer(rows_box, ['Row'])
	var cells = {}
	for tr_id in Traitdata.succubus_trainings:
		var u_data = Traitdata.succubus_trainings[tr_id]
		if u_data.has('showupreqs') and !person.checkreqs(u_data.showupreqs):
			continue
		cells[Vector2(u_data.level, u_data.column)] = tr_id
	var current = person.get_stat('succubus_level')
	for level in range(1, Traitdata.succubus_levels.exp.size() + 1):
		var row = input_handler.DuplicateContainerTemplate(rows_box, 'Row')
		var numeral = row.get_node('Level/Label')
		numeral.text = input_handler.roman_number_converter(level)
		if level > current:
			row.modulate = UNREACHED_ROW
			numeral.set("custom_colors/font_color", MUTED)
		var row_cells = row.get_node('Cells')
		var left = cells.get(Vector2(level, 0))
		var right = cells.get(Vector2(level, 2))
		for column in range(TREE_COLUMNS):
			var cell = Vector2(level, column)
			if cells.has(cell):
				fill_power(input_handler.DuplicateContainerTemplate(row_cells, 'Power'), cells[cell], level <= current)
			elif column == 1 and left != null and right != null and excludes(left, right):
				fill_or(input_handler.DuplicateContainerTemplate(row_cells, 'Or'), left, right)
			else:
				input_handler.DuplicateContainerTemplate(row_cells, 'Gap')


#whether the first training's reqs shut the second's trait out, as the attunements do each other
func excludes(tr_id, other_id):
	var other = Traitdata.succubus_trainings[other_id]
	for req in Traitdata.succubus_trainings[tr_id].reqs:
		if req.code == 'trait' and req.check == false and req.trait == other.trait:
			return true
	return false


#the OR between the attunements says "choose one" until one is learned, then its line to that one turns gold
func fill_or(node, left_id, right_id):
	var left = left_id != null and training_learned(left_id)
	var right = right_id != null and training_learned(right_id)
	node.get_node('Hint').visible = !(left or right)
	if left or right:
		var dim = MUTED
		dim.a = 0.3
		node.get_node('LineLeft').color = GOLD if left else dim
		node.get_node('LineRight').color = GOLD if right else dim


func training_learned(tr_id):
	var u_data = Traitdata.succubus_trainings[tr_id]
	if u_data.mode == 'skill':
		return person.get_social_skills().has(u_data.skill)
	return person.check_trait(u_data.trait)


#A power card: its icon framed in the state's colour, its name, and learned / the cost / what stops it.
#A row not reached yet says only the cost - its numeral says the level.
func fill_power(card, tr_id, reached):
	var u_data = Traitdata.succubus_trainings[tr_id]
	var cost = u_data.cost.thrall_points
	var unlocked = training_learned(tr_id)
	var name_label = card.get_node('Text/Name')
	match u_data.mode:
		'skill':
			name_label.text = tr(Skilldata.Skilllist[u_data.skill].name)
			globals.connectskilltooltip(card, u_data.skill, person)
		'trait':
			var s_data = Traitdata.traits[u_data.trait]
			name_label.text = tr(s_data.name)
			globals.connecttexttooltip(card, "[center]" + tr(s_data.name) + "[/center]\n" + tr(s_data.descript))
	#one line: a long name (Genitalia Manipulation) shrinks to fit
	input_handler.font_size_adjust(name_label, 4)
	card.get_node('Tile/Icon').texture = input_handler.loadimage(u_data.icon, 'icons')
	var state = card.get_node('Text/State')
	var color
	if unlocked:
		color = GOLD
		state.text = tr("SUCCUBUS_POWER_LEARNED")
		card.disabled = true
	#the only reqs in the data are the two attunements shutting each other out
	elif !person.checkreqs(u_data.reqs):
		color = MUTED
		state.text = tr("SUCCUBUS_POWER_EXCLUSIVE")
		card.disabled = true
	elif !reached:
		color = MUTED
		state.text = tr("SUCCUBUS_POWER_COST") % cost
		card.disabled = true
	elif person.check_cost(u_data.cost):
		color = AVAILABLE_COLOR
		state.text = tr("SUCCUBUS_POWER_UNLOCK") % cost
		card.connect('pressed', self, 'add_training', [tr_id])
	else:
		color = SHORT_COLOR
		state.text = tr("SUCCUBUS_POWER_NEEDS") % cost
		card.disabled = true
	state.set("custom_colors/font_color", color)
	card.get_node('Tile/Icon').modulate = color if !unlocked else Color(1, 1, 1)
	var tile = card.get_node('Tile')
	var style = tile.get_stylebox('panel').duplicate()
	style.border_color = color
	style.set_border_width_all(2)
	if unlocked:
		style.bg_color = color.darkened(0.55)
	tile.add_stylebox_override('panel', style)


var cashed_training = null
func add_training(tr_id):
	cashed_training = tr_id
	var u_data = Traitdata.succubus_trainings[tr_id]
	var text = tr("UPGRADELIST_UNLOCK") % [u_data.cost.thrall_points, tr('STATTHRALL_POINTS')]
	#an attunement shuts the other one out for good: its reqs name the trait it excludes
	for req in u_data.reqs:
		if req.code == 'trait' and req.check == false:
			text += "\n{color=red|%s}" % (tr("SUCCUBUS_POWER_CLOSES") % tr(Traitdata.traits[req.trait].name))
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'add_training_confirm', text])


func add_training_confirm():
	var u_data = Traitdata.succubus_trainings[cashed_training]
	person.pay_cost(u_data.cost)
	var name_key
	match u_data.mode:
		'skill':
			person.learn_skill(u_data.skill)
			name_key = Skilldata.Skilllist[u_data.skill].name
		'trait':
			person.add_trait(u_data.trait)
			name_key = Traitdata.traits[u_data.trait].name
	refresh()
	input_handler.play_animation("body_upgrade", {person = person, icon = u_data.icon, name = name_key, title = "SUCCUBUS_POWER_ANIM_TITLE"})


#the succubus's spells, mana bottom right and lust bottom left, and her Lust and Mana beside them; the
#grant skills are cast from the drawer
func build_spells():
	var bars = $Spells/Bars
	var lustmax = max(person.get_stat('lustmax'), 1)
	var mpmax = max(person.get_stat('mpmax'), 1)
	bars.get_node('LustBar').max_value = lustmax
	bars.get_node('LustBar').value = person.get_stat('lust')
	bars.get_node('LustValue').text = "%s/%s" % [cost_text(person.get_stat('lust')), cost_text(lustmax)]
	bars.get_node('MpBar').max_value = mpmax
	bars.get_node('MpBar').value = person.get_stat('mp')
	bars.get_node('MpValue').text = "%s/%s" % [cost_text(person.get_stat('mp')), cost_text(mpmax)]
	var container = $Spells/List
	input_handler.ClearContainer(container, ['Button'])
	for id in person.get_social_skills():
		if TYPE_SKILLS.values().has(id):
			continue
		var s_data = Skilldata.get_template(id, person)
		if !s_data.tags.has('succubus'):
			continue
		var panel = input_handler.DuplicateContainerTemplate(container, 'Button')
		panel.connect('pressed', self, 'select_spell', [id])
		panel.set_meta('display_only', true)
		panel.get_node('icon').texture = input_handler.loadimage(s_data.icon, 'icons')
		if s_data.has('container'):
			globals.connecttexttooltip(panel, tr(s_data.descript))
		else:
			globals.connectskilltooltip(panel, id, person)
		var mp = s_data.cost.get('mp', 0)
		var lust = s_data.cost.get('lust', 0)
		panel.get_node('value').text = cost_text(mp)
		panel.get_node('value').visible = mp > 0
		panel.get_node('value2').text = cost_text(lust)
		panel.get_node('value2').visible = lust > 0
		panel.disabled = spell_block(id) != ''
		if panel.disabled:
			panel.get_node('icon').modulate = Color(0.45, 0.45, 0.45)
		var cooldown = spell_cooldown(id)
		if cooldown > 0:
			panel.get_node('cdicon').visible = true
			panel.get_node('value3').text = str(cooldown)
			panel.get_node('value3').visible = true
			panel.get_node('value2').visible = false
			panel.get_node('value').visible = false


#why a spell cannot be cast now, '' when it can: its charges and cooldown, its cost, its own reqs
func spell_block(id):
	var s_data = Skilldata.get_template(id, person)
	if Skilldata.get_charges(s_data, person) - person.skills.social_skills_charges.get(id, 0) <= 0:
		var cooldown = spell_cooldown(id)
		if cooldown > 0:
			return tr("SUCCUBUS_SPELL_COOLDOWN") % cooldown
		return tr("SUCCUBUS_TYPE_USED")
	if person.get_stat('lust') < s_data.cost.get('lust', 0):
		return tr("SUCCUBUS_NOT_ENOUGH") % tr("STATLUST")
	if person.get_stat('mp') < s_data.cost.get('mp', 0):
		return tr("SUCCUBUS_NOT_ENOUGH") % tr("STATMP")
	if !person.checkreqs(s_data.reqs):
		return tr("REQS_NOT_MET_LABEL")
	return ''


#the turns or days left on a spell that has spent its charges, 0 when none
func spell_cooldown(id):
	if Skilldata.get_charges(Skilldata.get_template(id, person), person) - person.skills.social_skills_charges.get(id, 0) > 0:
		return 0
	for cooldowns in [person.skills.social_cooldowns, person.skills.daily_cooldowns, person.skills.social_turn_cooldowns]:
		if cooldowns.has(id):
			return cooldowns[id]
	return 0


func select_spell(sp_id):
	var s_data = Skilldata.get_template(sp_id, person)
	if s_data.tags.has('no_target'):
		person.use_social_skill(sp_id, person)
		input_handler.emit_signal("SpellUsed")
	else:
		gui_controller.spells = input_handler.get_spec_node(input_handler.NODE_SPELLS)
		ResourceScripts.core_animations.UnfadeAnimation(gui_controller.spells, 0.3)
		gui_controller.spells.show()
		gui_controller.previous_screen = gui_controller.current_screen
		gui_controller.current_screen = gui_controller.spells
		gui_controller.spells.open(person, sp_id, true)
		gui_controller.emit_signal("screen_changed")
