extends Panel
#The beauty parlor's body modifications, opened from the room's card once that improvement is
#built. The tattoo bench is a different job behind a different button and has its own window.
#
#The rows, the sliders, the colour swatches and the panel of picture tiles are the character
#creation screen's, copied so that choosing a look here is the same act as choosing one there
#- the same templates in the scene, the same builders below. The one difference is what may
#be chosen: creation offers what a race and a sex allow, and this room offers everything the
#doll can be given.
#
#Registered as an open window the way SexSelectMenu is: ESC and the close button both end at
#hide(), and _custom_gui_controller_close keeps gui_controller.close_scene() from putting the
#mansion back to its default state underneath.

#the creation screen's own tables: which control an option deserves, which colour paints which
#part, and which colours have a rule behind them
const LAYOUT = preload("res://gui_modules/CharacterCreation/creation_layout.gd")
const DOLL_COLORS = preload("res://Character_generator/Doll2Spine/universal/doll_colors.gd")
#what the doll reads, what it maps a value to, and what art it actually has - the three
#questions behind "does this option change anything"
const DOLL_VIEW = preload("res://Character_generator/Doll2Spine/doll2_view.gd")
const CHARACTER_MAP = preload("res://Character_generator/Doll2Spine/universal/doll_character_map.gd")
const CATALOGUE = preload("res://Character_generator/Doll2Spine/doll2_catalogue.gd")
const COVERAGE = preload("res://Character_generator/Doll2Spine/universal/doll_coverage.gd")

#A coat is painted in as many colours as its pattern has masks, so its rows are not stats of
#their own: they are numbered and read and write `body_color_coat` by index.
const COAT_PREFIX = 'coat_colour_'
#and the colours it is offered are the ones the fur already uses elsewhere - the same family
#the tail and the ears are painted from
const COAT_PALETTE_STAT = 'body_color_tail'

#What the room offers, in the order it offers it. A stat that belongs to one of the submenus is
#drawn as a panel of pictures instead of a row, and every colour is drawn under the part it
#paints - both are decided by LAYOUT, as on the creation screen. The body shape and the eye
#shape are not on it: the room leaves those two as they are.
const BODY_STATS = ['height', 'head_size', 'skin_coverage', 'ears', 'horns',
	'tail', 'wings', 'eyeshape', 'eye_tex', 'eyebrows', 'nose', 'lips', 'chin',
	'beard', 'hair_base', 'hair_base_length', 'hair_back', 'hair_back_length', 'hair_assist',
	'hair_assist_length', 'tits_size', 'multiple_tits', 'multiple_tits_developed', 'ass_size',
	'penis_type', 'penis_size', 'balls_size']

#The panels of pictures are the creation screen's, and one of the room's own: wings are picked
#off pictures here, the way horns are.
const EXTRA_SUBMENUS = [
	{"id": "wings", "label": "CHARCREATE_MENU_WINGS", "stats": ["wings"]},
]

#What the written description is built from - descriptions.descriptionorder - less the two
#shapes above. These are worth offering even to a character the doll never draws: they still
#change what is said about them.
const DESCRIBED_STATS = ['horns', 'ears', 'skin_coverage', 'wings', 'tail',
	'height', 'tits_size', 'multiple_tits', 'ass_size', 'penis_type', 'penis_size',
	'balls_size', 'eye_color', 'body_color_skin']

#With dolls switched off in the options there is no doll to show and none to photograph, so the room
#offers only what the written description is made of, as plain rows, and the description itself stands
#over the silhouette. The hair is the description's own length and style (the doll's cuts are derived
#from them), the eyes are picked by the colour's name, which is what the text prints; the skin is left
#out, since the doll's shades have no words in the description.
const DESCRIPTION_ONLY_STATS = ['height', 'hair_length', 'hair_style', 'hair_color', 'eye_color', 'ears', 'horns',
	'wings', 'tail', 'skin_coverage', 'tits_size', 'multiple_tits', 'multiple_tits_developed', 'ass_size',
	'penis_type', 'penis_size', 'balls_size']

#yes or no, so a box to tick
const CHECK_STATS = ['multiple_tits_developed']

#A colour is only worth asking about while the thing it paints is worn: a human is not asked
#what shade her wings are.
const PART_BEHIND_COLOUR = {
	body_color_wings = 'wings', body_color_tail = 'tail', body_color_horns = 'horns',
	body_color_animal = 'body_lower', hair_facial_color = 'beard',
}
#and a length has nothing to lengthen while its layer is not worn
const PART_BEHIND_SLIDER = {
	hair_base_length = 'hair_base', hair_back_length = 'hair_back',
	hair_assist_length = 'hair_assist',
}
#the sizes' own ladder. The descriptions file keys penis_size by type as well
#(`human_small` ...) - that is prose about the pair, not a value the stat may hold.
const SIZE_LADDER = ['small', 'average', 'big']
const ABSENT_PART = ['', 'no', 'none']
#parts a character may just as well not have: taking them off is a choice on their list
const REMOVABLE_PARTS = ['horns', 'wings']

var person = null
var possible_vals = {}
var visual_stat_nodes = {}
var visual_submenu_buttons = {}
var visual_submenu_tiles = []
var open_visual_submenu = ""
var updating_visual_controls = false
var visual_insert_index = 0
#a look that has been changed is written down when the chair is given up, not on every click
var looks_changed = false
#Opened by the ritual room's appearance change for the one character it has just readied, with no list to
#pick anybody else from (open_for_rite); whoever sent them is called back as the window goes.
var rite_subject_only = false
var closed_target = null
var closed_method = ''

# Whether the picture tiles carry their value's name under them - a part code out of the data
# files, which is what a developer needs and a player never should read.
onready var show_option_names = OS.has_feature('editor')
onready var character_list = $Characters/Scroll/List
onready var visual_options = $Visuals/ScrollContainer/VBoxContainer/StatsContainer
onready var visual_submenu = $VisualSubmenu
onready var visual_submenu_rows = $VisualSubmenu/ScrollContainer/Rows
onready var preview_booth = $DollOptionPreviews
onready var preview = $Preview


func _ready():
	gui_controller.add_close_button(self)
	$Title.text = tr("BODYMOD_TITLE")
	$Characters/Header.text = tr("BEAUTYPARLOR_CHARACTERS")
	$VisualSubmenu/Title/Close.connect("pressed", self, "_close_visual_submenu")
	#The plain way out. Every change is already on the character, so Done only gives up the chair - the same
	#as the close button in the corner, which is easy to miss. Looked for rather than assumed, as the node
	#lands in the scene separately from this script.
	if has_node("DoneButton"):
		$DoneButton.text = tr("BODYMOD_DONE")
		$DoneButton.connect("pressed", self, "hide")
	preview_booth.connect("preview_ready", self, "_on_visual_preview_ready")
	input_handler.connect("PortraitUpdate", self, "_refresh_row_icons")


#### the window ####

func open():
	rite_subject_only = false
	closed_target = null
	closed_method = ''
	_open_window()


#The ritual room's appearance change sends its character here to settle the new look: the same menu,
#without the list of everybody else. `method` is called on `target` when the window goes.
func open_for_rite(subject, target, method):
	rite_subject_only = true
	closed_target = target
	closed_method = method
	if subject != person:
		#the tiles were shot on the old head
		preview_booth.forget()
	person = subject
	_open_window()


func _open_window():
	_close_visual_submenu()
	if person != null and (!ResourceScripts.game_party.characters.has(person.id) \
			or _block_reason(person) != ''):
		person = null
	$Characters.visible = !rite_subject_only
	#shown before it is filled: the doll only stands itself up once it has a rect to stand in
	show()
	raise()
	if !rite_subject_only:
		rebuild_characters()
	refresh_subject_card()
	refresh_all()
	input_handler.append_not_duplicate(gui_controller.windows_opened, self)
	_hide_clock()


#the estate's clock is drawn over everything on this screen, this window included, so it steps
#aside while the room is open and comes back with it - the same thing the progression and
#training popups do
var clock_was_visible = false


func _hide_clock():
	clock_was_visible = gui_controller.clock != null and gui_controller.clock.visible
	if gui_controller.clock != null:
		gui_controller.clock.hide()
	set_process(true)


func _restore_clock():
	if clock_was_visible and gui_controller.clock != null:
		gui_controller.clock.show()
	clock_was_visible = false


#gui_controller.clock_visibility() puts the clock back whenever the screen underneath is judged
#again, so keeping it away is a standing job, not a one-off
func _process(_delta):
	if visible and gui_controller.clock != null and gui_controller.clock.visible:
		gui_controller.clock.hide()


func hide():
	_commit_looks()
	_close_visual_submenu()
	gui_controller.windows_opened.erase(self)
	_restore_clock()
	.hide()
	#the ritual room's panel that sent the character here comes back
	if closed_target != null and is_instance_valid(closed_target) and closed_method != '':
		var target = closed_target
		var method = closed_method
		closed_target = null
		closed_method = ''
		target.call(method)


func _custom_gui_controller_close():
	hide()


func refresh_all():
	$Visuals.visible = person != null
	$Empty.visible = person == null
	if person == null:
		$Empty.text = tr("BEAUTYPARLOR_PICKCHAR")
		_close_visual_submenu()
		preview.hide_band()
		refresh_description()
		return
	#which options this character has at all depends on the character, so the rows are built
	#for them rather than once for everybody
	build_possible_vals()
	RebuildStatsContainer()
	fill_all()
	refresh_preview(true)
	refresh_description()


#### the people ####

func _block_reason(candidate):
	if candidate.is_on_quest():
		return tr("BEAUTYPARLOR_AWAY")
	if !candidate.is_free():
		return tr("BEAUTYPARLOR_NOTHERE")
	return ''


#Whether a doll is what this character is drawn with. A story character with painted artwork,
#or a game with paperdolls switched off, is still described in words - so the room still has
#something to offer them, just less of it.
func _uses_doll():
	if person == null or _dolls_off():
		return false
	return !person.is_unique() or person.uses_paperdoll()


#Dolls switched off in the options: nothing here draws or photographs one - see DESCRIPTION_ONLY_STATS.
func _dolls_off():
	return input_handler.globalsettings.disable_paperdoll


#The rows the room builds, in the order it builds them.
func _row_stats():
	return DESCRIPTION_ONLY_STATS if _dolls_off() else BODY_STATS


#What is worth putting in front of the player: everything the doll actually draws, plus
#everything the written description is built from.
func _stat_is_offered(stat):
	if person == null:
		return false
	if _dolls_off():
		return DESCRIPTION_ONLY_STATS.has(stat)
	if DESCRIBED_STATS.has(stat):
		return true
	#the colours are the doll's own; the description names only the skin and the eyes
	if LAYOUT.COLOUR_FOLLOWS.has(stat):
		return _uses_doll()
	return _uses_doll() and DOLL_VIEW.STATS.has(stat)


func _is_beastkin():
	return CHARACTER_MAP.draws_beastkin(person.get_stat('race'))


#the animal a beastkin race is drawn from, which is what decides its muzzle
func _beast():
	var race = str(person.get_stat('race')).to_lower()
	for animal in ['cat', 'fox', 'wolf', 'rabbit', 'bunny', 'tanuki', 'rat']:
		if race.find(animal) >= 0:
			return animal
	return 'cat'


#The piece of art a value ends up drawn as, or null when the doll would draw nothing for it.
#Two values that come out as the same piece are the same choice wearing two names.
func _drawn_part(stat, value):
	var group = str(CHARACTER_MAP.FEEDS.get(stat, ''))
	if group == '':
		return str(value)
	if CHARACTER_MAP.is_absent(value):
		return ''  #"none" is a choice of its own: no horns, no tail
	CATALOGUE.use('male' if str(person.get_stat('sex')) == 'male' else 'female')
	var stats = {beast = _beast()}
	var part = str(CHARACTER_MAP.resolve(stat, value, stats))
	#a beastkin's head, face, mouth and nose are the muzzle's, whatever the stat says
	if _is_beastkin() and group in CHARACTER_MAP.BEASTKIN_GROUPS:
		part = str(CHARACTER_MAP.beastkin_variant(group, part, stats))
	if part == '' or !CATALOGUE.parts(group).has(part):
		return null
	return part


func rebuild_characters():
	input_handler.ClearContainer(character_list)
	for id in ResourceScripts.game_party.character_order:
		var candidate = ResourceScripts.game_party.characters[id]
		var row = input_handler.DuplicateContainerTemplate(character_list)
		row.set_meta('slave', candidate)
		row.get_node('Label').text = candidate.get_short_name()
		row.get_node('Icon').texture = candidate.get_icon()
		input_handler.queue_portrait(candidate)
		var reason = _block_reason(candidate)
		row.disabled = reason != ''
		row.pressed = candidate == person
		if reason != '':
			globals.connecttexttooltip(row, reason)
		else:
			globals.connectslavetooltip(row, candidate)
		row.connect("pressed", self, "_on_person_pressed", [candidate])


func _refresh_row_icons(_who = null):
	if !visible:
		return
	for row in character_list.get_children():
		if row.has_meta('slave') and !row.is_queued_for_deletion():
			row.get_node('Icon').texture = row.get_meta('slave').get_icon()
	refresh_subject_card()


#In place of the list, the one character a rite brought here. The card is the scene's `Subject`, shown only
#then; looked for rather than assumed, as the node lands in the scene separately from this script.
func refresh_subject_card():
	if !has_node("Subject"):
		return
	$Subject.visible = rite_subject_only and person != null
	if $Subject.visible:
		$Subject/Portrait.texture = person.get_icon()
		$Subject/Name.text = person.get_short_name()


func _on_person_pressed(candidate):
	if candidate == person:
		return
	#the last one's new look is written down before the chair is given to somebody else
	_commit_looks()
	_close_visual_submenu()
	#the tiles were shot on the old head
	preview_booth.forget()
	person = candidate
	for row in character_list.get_children():
		if row.has_meta('slave'):
			row.pressed = row.get_meta('slave') == person
	refresh_all()


#### what may be chosen ####

#Everything the doll can be given, with no race and no sex filter - that is what the room is
#for. Only what the character does not have at all is left out, because there is nothing there
#to change: no wings, no wing colour.
func _values_for(stat):
	if LAYOUT.COLOUR_FOLLOWS.has(stat):
		return _colour_values(stat)
	#a body the sex tables left without a penis has no shape to pick for it either
	if str(stat) == 'penis_type' and str(person.get_stat('penis_size')) == '':
		return []
	match stat:
		'penis_size', 'balls_size':
			#the sex tables give '' to anyone without the part, and the row goes with it
			if str(person.get_stat(stat)) == '':
				return []
			return SIZE_LADDER.duplicate()
		'skin_coverage':
			#the fur masks are only drawn on the beastkin body, so a coat is offered to a
			#beastkin (the ritual room's form change is how anybody else becomes one) and
			#every other race keeps the overlay its own data names
			if str(person.get_stat('race')).begins_with('Beastkin'):
				var coats = []
				for value in ResourceScripts.descriptions.bodypartsdata.skin_coverage:
					if str(value).begins_with('fur'):
						coats.append(value)
				return coats
			return _race_values(str(person.get_stat('race')), 'skin_coverage')
		'multiple_tits':
			if races.racelist[person.get_stat('race')].get('tags', []).has('multibreasts'):
				#the doll draws one or two extra pairs, so a doll-drawn character is offered no step
				#that changes nothing - a third pair already there stays on the list until it goes
				if !_uses_doll():
					return [0, 1, 2, 3]
				var pairs = [0, 1, 2]
				if int(person.get_stat('multiple_tits')) > 2:
					pairs.append(int(person.get_stat('multiple_tits')))
				return pairs
			return []
		'multiple_tits_developed':
			if int(person.get_stat('multiple_tits')) > 0:
				return [false, true]
			return []
		'hair_color':
			#the description's own names for hair, which no one table lists whole: every race's list together
			var colours = []
			for race in races.racelist.values():
				for entry in race.get('bodyparts', {}).get('hair_color', []):
					var value = entry[0] if entry is Array else entry
					if !colours.has(value):
						colours.append(value)
			return colours
	if PART_BEHIND_SLIDER.has(stat) \
			and str(person.get_stat(PART_BEHIND_SLIDER[stat])) in ABSENT_PART:
		return []
	var res = []
	#Two tables name the same parts and neither one is complete. The description data is the
	#game's own vocabulary and carries everything the art has been given a name for - all four
	#of the new fox ears, for one; the transform table is the old doll's and still holds a few
	#names the descriptions never got, such as `normal` ears and a plain `bunny`. The room
	#offers both, descriptions first, so that where two names share one drawing the one the
	#rest of the game uses is the one kept below.
	var sources = []
	if ResourceScripts.descriptions.bodypartsdata.has(stat):
		sources.append(ResourceScripts.descriptions.bodypartsdata[stat])
	if GeneratorData.transforms.has(stat):
		sources.append(GeneratorData.transforms[stat])
	var worn = str(person.get_stat(stat))
	for source in sources:
		for value in source:
			#a null or empty key is the table's own "unset", not something to hand a player
			if value == null or str(value) == '':
				continue
			#what nobody may pick stays off the list - except what this character already is,
			#or a slider would print a value its own knob can never reach
			if !LAYOUT.offered(stat, value) and str(value) != worn:
				continue
			if !res.has(value):
				res.append(value)
	#Neither table knows the cuts the export gained after it was written - the monofringe cuts, hime - so the
	#hair layers also offer every piece the art has that no name above reaches yet.
	if stat in ['hair_base', 'hair_back', 'hair_assist']:
		CATALOGUE.use('male' if str(person.get_stat('sex')) == 'male' else 'female')
		var pieces = CATALOGUE.parts(str(CHARACTER_MAP.FEEDS[stat]))
		for value in CHARACTER_MAP.values_for_unlisted_parts(stat, res, pieces):
			if LAYOUT.offered(stat, value) and !res.has(value):
				res.append(value)
	#the tables' own unset is kept off every other list; for these it is "none", and it goes first
	if stat in REMOVABLE_PARTS:
		res.push_front('')
	#A value the art cannot draw, or one that comes out as the very piece another value
	#already gives, is not a choice: it is a row entry that does nothing. A beastkin's face
	#is the muzzle's whatever the stat says, so those rows empty themselves here.
	if _uses_doll() and CHARACTER_MAP.FEEDS.has(stat):
		var drawn = []
		var seen = {}
		for value in res:
			#a chin is for the head this body has: a muzzle on a human face, or a human chin the
			#muzzle would only be painted over, is not a choice
			if stat == 'chin' and !CHARACTER_MAP.chin_fits_body(value, _is_beastkin(), _beast()):
				continue
			var part = _drawn_part(stat, value)
			if part == null or seen.has(part):
				continue
			seen[part] = true
			drawn.append(value)
		#whatever they wear now stays on the list, or the row would show a value it does not
		#offer - unless another name on the list draws that very piece (`beastkin` on a fox is
		#its first muzzle), which then stands for it and is the tile lit for it
		var current = person.get_stat(stat)
		if res.has(current) and !drawn.has(current):
			var twin = _drawn_part(stat, current)
			if twin == null or !seen.has(twin):
				drawn.push_front(current)
		res = drawn
	return res


func _race_values(race, stat):
	var res = []
	var parts = races.racelist.get(race, {}).get('bodyparts', {})
	for entry in parts.get(stat, []):
		var value = entry[0] if entry is Array else entry
		if !res.has(value):
			res.append(value)
	return res


#The whole palette, and for a colour with a rule behind it the rule itself first - an empty
#value, which is what makes the lips follow the skin and the brows the hair.
func _colour_values(stat):
	#ears and a tail get a colour whenever the doll draws them - skin, fur, hide or fin: Auto
	#still follows the rule, and a pick paints the part whatever it is made of
	if stat == 'body_color_ears' and !person.statlist.has_ear_art():
		return []
	if stat == 'body_color_tail' and !person.statlist.has_tail_art():
		return []
	if PART_BEHIND_COLOUR.has(stat) \
			and str(person.get_stat(PART_BEHIND_COLOUR[stat])) in ABSENT_PART:
		return []
	#a colour the game works out on its own is not a colour to offer
	if person.statlist.derives_colour(stat):
		return []
	var res = []
	if LAYOUT.DEFAULT_COLOUR_FROM.has(stat):
		res.append('')
	for value in DOLL_COLORS.values_for(stat):
		if !res.has(value):
			res.append(value)
	return res


#The value a colour stat holds as it was written down, rather than the colour it ends up
#drawn in: an empty one means "follow the rule", and that is what the frame has to land on.
func _raw_value(stat):
	var stats = person.statlist
	if stats.statlist.has(stat):
		return str(stats.statlist[stat])
	if stats.exterior.has(stat):
		return str(stats.exterior[stat])
	return str(person.get_stat(stat))


func build_possible_vals():
	possible_vals.clear()
	for stat in _row_stats():
		if _stat_is_offered(stat):
			possible_vals[stat] = _values_for(stat)
	for colour in LAYOUT.COLOUR_FOLLOWS:
		if _stat_is_offered(colour):
			possible_vals[colour] = _values_for(colour)
	#the coat's colours are picked off the wheel, so the list is only what tells a row it has
	#something to offer at all
	for i in range(_coat_count()):
		possible_vals[COAT_PREFIX + str(i)] = ['']


#The coat the doll paints on this body, or '' for one that wears none: a pattern belongs to
#the beastkin body, so a halfkin with a coat in their stats still has nothing to repaint.
func _coat_pattern():
	if person == null or !_uses_doll() or !_is_beastkin():
		return ''
	return str(DOLL_VIEW.COVERAGE_PATTERNS.get(str(person.get_stat('skin_coverage')), ''))


func _coat_count():
	var pattern = _coat_pattern()
	if pattern == '':
		return 0
	return COVERAGE.color_count(pattern)


#### the rows, as the creation screen builds them ####

func duplicate_visual_template(template):
	var node = input_handler.DuplicateContainerTemplate(visual_options, template)
	visual_options.move_child(node, visual_insert_index)
	visual_insert_index += 1
	return node


func setup_visual_stat_node(node, stat, template):
	node.name = stat
	visual_stat_nodes[stat] = node
	if template == 'Checkbox':
		node.text = visual_stat_name(stat)
		return
	if template == 'SubmenuButton':
		return
	node.get_node('header/Label').text = visual_stat_name(stat)
	if node.get_node('header').has_node('Tooltip'):
		node.get_node('header/Tooltip').visible = false


func colours_following(stat):
	var result = []
	for colour in LAYOUT.COLOUR_FOLLOWS:
		if str(LAYOUT.COLOUR_FOLLOWS[colour]) == str(stat):
			result.append(colour)
	return result


func _append_coat_colour_rows():
	for i in range(_coat_count()):
		var key = COAT_PREFIX + str(i)
		if !possible_vals.has(key):
			continue
		var node = duplicate_visual_template('Colour')
		setup_visual_stat_node(node, key, 'Colour')


#A colour row is built for every colour the character is offered, the ones whose part is not
#worn yet included: such a row stays hidden until the part goes on, which is what lets picking
#horns or wings bring their palette along.
func append_following_colour_rows(stat):
	for colour in colours_following(stat):
		if !possible_vals.has(colour):
			continue
		var colour_node = duplicate_visual_template('Colour')
		setup_visual_stat_node(colour_node, colour, 'Colour')


func visual_stat_name(stat):
	#the coat's rows are numbered rather than named: the pattern decides how many there are,
	#and one pattern's second colour is another's only one
	if str(stat).begins_with(COAT_PREFIX):
		return "%s %d" % [tr("BODYMOD_COAT_COLOUR"),
			int(str(stat).substr(COAT_PREFIX.length())) + 1]
	if statdata.statdata.has(stat) and statdata.statdata[stat].has('name') \
			and str(statdata.statdata[stat].name) != '':
		return tr(statdata.statdata[stat].name)
	return tr("STAT" + str(stat).to_upper())


func visual_value_name(stat, value):
	#the old hair colours have names of their own, the ones the description prints
	if stat == 'hair_color':
		return tr("HAIRCOLOR_" + str(value).to_upper())
	#a part taken off reads the same on its row as on its button
	if stat in REMOVABLE_PARTS and (value == null or str(value) in ABSENT_PART):
		return tr("NONE")
	if ResourceScripts.descriptions.bodypartsdata.has(stat):
		var descriptions = ResourceScripts.descriptions.bodypartsdata[stat]
		if descriptions.has(value) and str(descriptions[value].name) != '':
			return tr(descriptions[value].name)
	return tr(str(value))


#a row with one value or none is a row with nothing to choose, and it takes itself away
func visual_option_is_shown(stat):
	return possible_vals.has(stat) and possible_vals[stat].size() > 1


#The scaffolding: one row per option, in LAYOUT's order, built once. The values in them are
#filled per character by fill_all().
func RebuildStatsContainer():
	input_handler.ClearContainer(visual_options,
		['Button', 'Slider', 'Checkbox', 'SubmenuButton', 'Colour'])
	input_handler.ClearContainer(visual_submenu_rows, ['StatRow'])
	visual_stat_nodes.clear()
	visual_submenu_buttons.clear()
	visual_submenu_tiles.clear()
	visual_insert_index = 0
	#First, for a character with artwork of their own, the switch between that artwork and the
	#doll - the same one the character screen's customization carries. It decides what else is
	#on the list, so it stands above all of it.
	paperdoll_switch = null
	#with dolls switched off everyone is described in words, and the switch has nothing to switch to
	if person.is_unique() and !_dolls_off():
		paperdoll_switch = duplicate_visual_template('Checkbox')
		paperdoll_switch.text = tr("UPAPERDOLL_BUTTON_TEXT")
		paperdoll_switch.pressed = bool(person.get_stat('use_paperdoll'))
		globals.connecttexttooltip(paperdoll_switch, tr("UPAPERDOLL_BUTTON_TOOLTIP"))
		paperdoll_switch.connect('toggled', self, '_on_paperdoll_toggled')
	# A colour with no owner (the skin) gets its own row at the top. All the others are
	# inserted immediately after the option they paint.
	for colour in LAYOUT.COLOUR_FOLLOWS:
		if str(LAYOUT.COLOUR_FOLLOWS[colour]) == '' \
				and possible_vals.has(colour) and !possible_vals[colour].empty():
			var skin_node = duplicate_visual_template('Colour')
			setup_visual_stat_node(skin_node, colour, 'Colour')
	for menu in _submenus():
		if !_menu_is_offered(menu):
			continue
		var menu_button = duplicate_visual_template('SubmenuButton')
		menu_button.name = 'submenu_' + str(menu.id)
		menu_button.text = tr(menu.label)
		menu_button.connect('pressed', self, 'open_visual_submenu_panel', [str(menu.id)])
		visual_submenu_buttons[str(menu.id)] = menu_button
		for stat in menu.stats:
			append_following_colour_rows(stat)
			#the coat's own colours belong under the coat, the way every other colour
			#sits under the part it paints
			if str(stat) == 'skin_coverage':
				_append_coat_colour_rows()
	for stat in _row_stats():
		#a colour gets a row of its own only where there is no wheel for it - see build_node_for_stat
		if (LAYOUT.COLOUR_FOLLOWS.has(stat) and !_dolls_off()) or _submenu_of(stat) != '':
			continue
		if !visual_option_is_shown(stat):
			continue
		var template = 'Button'
		if stat in LAYOUT.SLIDERS:
			template = 'Slider'
		elif stat in CHECK_STATS:
			template = 'Checkbox'
		var newnode = duplicate_visual_template(template)
		setup_visual_stat_node(newnode, stat, template)
		append_following_colour_rows(stat)


#a submenu with nothing to choose in it gets no button
func _menu_is_offered(menu):
	for stat in menu.get('stats', []):
		if visual_option_is_shown(stat):
			return true
	return false


func fill_all():
	for stat in possible_vals:
		build_node_for_stat(stat)


#The doll's own colour control, the one the estate's character screen puts under its Customize
#menu: a swatch that opens the wheel. `Auto` is what puts a colour back under its rule - the
#lips following the skin, the brows the hair.
func build_selectable_node(stat):
	if str(stat).begins_with(COAT_PREFIX):
		_build_coat_colour_node(stat)
		return
	if !LAYOUT.COLOUR_FOLLOWS.has(stat):
		return
	var node = visual_stat_nodes.get(str(stat))
	if node == null:
		return
	node.visible = possible_vals.has(stat) and !possible_vals[stat].empty()
	if !node.visible:
		return
	var swatch = node.get_node('Picker/Swatch')
	var auto = node.get_node('Picker/Auto')
	auto.visible = LAYOUT.DEFAULT_COLOUR_FROM.has(stat)
	if auto.visible:
		auto.text = tr("BODYMOD_COLOUR_AUTO")
		auto.pressed = str(_raw_value(stat)) == ''
	updating_visual_controls = true
	swatch.color = _drawn_colour(stat)
	updating_visual_controls = false
	if !node.has_meta('signals_built'):
		_wire_colour_picker(swatch)
		swatch.connect('color_changed', self, '_on_colour_picked', [stat])
		auto.connect('pressed', self, '_on_colour_auto', [stat])
		node.set_meta('signals_built', true)


#The colour a row's swatch shows, which is what the doll paints. Mostly that is the stat read
#through its getter. The nipples have none - on Auto they are the deeper shade worked out from
#the skin - and a shaped ear left on Auto is the skin itself, which its getter answers with
#nothing at all.
func _drawn_colour(stat):
	var raw = str(_raw_value(stat))
	if str(stat) == 'body_color_nipples' and raw == '':
		return DOLL_COLORS.nipples_of(person.get_stat('body_color_skin'))
	if str(stat) == 'body_color_ears' and raw == '' and str(person.get_stat(stat)) == '':
		return DOLL_COLORS.colour_of('body_color_skin', person.get_stat('body_color_skin'))
	return DOLL_COLORS.colour_of(stat, person.get_stat(stat))


#One row per colour the coat pattern carries. There is no stat behind a row: the value lives at
#its own index of `body_color_coat`, and `Auto` hands that index back to the artist's colour.
func _build_coat_colour_node(key):
	var node = visual_stat_nodes.get(str(key))
	if node == null:
		return
	var index = int(str(key).substr(COAT_PREFIX.length()))
	var defaults = COVERAGE.default_colors(_coat_pattern())
	node.visible = index >= 0 and index < defaults.size()
	if !node.visible:
		return
	var swatch = node.get_node('Picker/Swatch')
	var auto = node.get_node('Picker/Auto')
	auto.visible = true
	auto.text = tr("BODYMOD_COLOUR_AUTO")
	var painted = str(person.statlist.get_coat_colour(index))
	auto.pressed = painted == ''
	updating_visual_controls = true
	swatch.color = _coat_swatch_colour(painted, defaults[index])
	updating_visual_controls = false
	if !node.has_meta('signals_built'):
		_wire_colour_picker(swatch)
		swatch.connect('color_changed', self, '_on_coat_colour_picked', [key])
		auto.connect('pressed', self, '_on_coat_colour_auto', [key])
		node.set_meta('signals_built', true)


#What the coat's swatch shows: the colour that was painted there, or the artist's own while
#nothing was. Older paint is spelled as a palette name, newer as the wheel's own "#rrggbb".
func _coat_swatch_colour(painted, artists):
	if painted == '':
		return artists
	if painted.begins_with('#'):
		return Color(painted)
	return DOLL_COLORS.colour_of(COAT_PALETTE_STAT, painted)


#The wheel opens where the engine last left it, which is the top-left corner of the screen, so
#it is placed by hand under the swatch - the doll's menu does the same, see
#doll2_view._place_colour_popup.
func _wire_colour_picker(swatch):
	swatch.get_popup().connect('about_to_show', self, '_place_colour_popup', [swatch])


#how far under the swatch the wheel opens
const COLOUR_POPUP_GAP = 6.0


func _place_colour_popup(swatch):
	var popup = swatch.get_popup()
	var wheel = popup.rect_size
	#before its first showing a popup has no size yet, and what it will ask for is the only
	#thing there is to place
	if wheel.x <= 0.0 or wheel.y <= 0.0:
		wheel = popup.get_combined_minimum_size()
	var square = Rect2(swatch.rect_global_position, swatch.rect_size)
	var room = get_viewport().get_visible_rect().size
	#under the swatch, or over it when the screen has no room below: a wheel hanging off the
	#bottom is one whose sliders cannot be reached
	var below = square.end.y + COLOUR_POPUP_GAP
	var above = square.position.y - wheel.y - COLOUR_POPUP_GAP
	var y = below
	if below + wheel.y > room.y and above >= 0.0:
		y = above
	popup.rect_global_position = Vector2(
		clamp(square.position.x, 0, max(0, room.x - wheel.x)),
		clamp(y, 0, max(0, room.y - wheel.y)))


func _on_colour_picked(colour, stat):
	if updating_visual_controls or person == null:
		return
	_write_stat(stat, "#" + colour.to_html(false))


func _on_colour_auto(stat):
	if person == null:
		return
	_write_stat(stat, '')


func _on_coat_colour_picked(colour, key):
	if updating_visual_controls or person == null:
		return
	_write_coat_colour(key, "#" + colour.to_html(false))


func _on_coat_colour_auto(key):
	if person == null:
		return
	_write_coat_colour(key, '')


func _write_coat_colour(key, value):
	person.statlist.set_coat_colour(int(str(key).substr(COAT_PREFIX.length())), value)
	looks_changed = true
	_apply_to_doll('skin_coverage')
	build_selectable_node(key)
	#the ears, the tail and a beastkin's mouth take after the coat while they are on Auto themselves
	refresh_following_colours('ears')
	refresh_following_colours('tail')
	refresh_following_colours('lips')
	refresh_visual_submenu_previews()


func build_node_for_stat(stat):
	if person == null or !possible_vals.has(stat):
		return
	#a coat colour is an index of one stat rather than a stat, so it never asks for its own
	if str(stat).begins_with(COAT_PREFIX):
		build_selectable_node(stat)
		return
	var val = person.get_stat(stat)
	var node = visual_stat_nodes.get(str(stat))
	#With dolls switched off a colour is picked by its name on an arrow row: the description prints the
	#stored value, and a wheel's "#rrggbb" would read as exactly that in the text.
	if LAYOUT.COLOUR_FOLLOWS.has(stat) and !_dolls_off():
		build_selectable_node(stat)
		return
	var submenu_id = _submenu_of(stat)
	if submenu_id != '':
		refresh_visual_submenu_button(submenu_id)
		if node != null:
			node.visible = visual_option_is_shown(stat)
			refresh_visual_tile_selection(stat)
		return
	if node == null:
		return
	node.visible = visual_option_is_shown(stat)
	if !node.visible:
		return
	if stat in LAYOUT.SLIDERS:
		var values = LAYOUT.ladder(stat, possible_vals[stat])
		var slider = node.get_node('Control/Slider')
		#the wheel belongs to the list it sits in: a slider that answers it too changes the
		#character while the player is only scrolling past
		slider.scrollable = false
		updating_visual_controls = true
		slider.min_value = 0
		slider.max_value = max(values.size() - 1, 0)
		slider.step = 1
		slider.value = max(values.find(val), 0)
		node.get_node('header/Label').text = '%s - %s' % [visual_stat_name(stat), visual_value_name(stat, val)]
		node.get_node('Control/Value').visible = false
		updating_visual_controls = false
		if !node.has_meta('signals_built'):
			slider.connect('value_changed', self, 'change_slider_value', [stat])
			node.set_meta('signals_built', true)
		return
	if stat in CHECK_STATS:
		updating_visual_controls = true
		node.pressed = bool(val)
		updating_visual_controls = false
		if !node.has_meta('signals_built'):
			node.connect('toggled', self, 'change_checkbox_value', [stat])
			node.set_meta('signals_built', true)
		return
	node.get_node('button/Label').text = visual_value_name(stat, val)
	if !node.has_meta('signals_built'):
		node.get_node('button/LArr').connect('pressed', self, 'change_value_node', [stat, -1])
		node.get_node('button/RArr').connect('pressed', self, 'change_value_node', [stat, 1])
		if node.get_node('button') is TextureButton:
			node.get_node('button').connect('pressed', self, 'change_value_node', [stat, 1])
		node.set_meta('signals_built', true)


#### changing a value ####

func change_slider_value(value, stat):
	if updating_visual_controls or !possible_vals.has(stat):
		return
	var values = LAYOUT.ladder(stat, possible_vals[stat])
	var current = values.find(person.get_stat(stat))
	var target = int(round(value))
	if current != -1 and target != current:
		change_value_node(stat, target - current)


func change_checkbox_value(pressed, stat):
	if updating_visual_controls or person.get_stat(stat) == pressed:
		return
	change_value_node_selectable(stat, pressed)


func change_value_node(stat, step): #for the arrow rows and the sliders
	if person == null or !possible_vals.has(stat):
		return
	var values = possible_vals[stat]
	if stat in LAYOUT.SLIDERS:
		values = LAYOUT.ladder(stat, possible_vals[stat])
	if values.empty():
		return
	var id = values.find(person.get_stat(stat))
	if id == -1:
		id = 0
	id += step
	if id < 0:
		id = values.size() - 1
	if id >= values.size():
		id = 0
	#the description's hair: several of its names come out as the same hair, and the step goes on past them -
	#see ch_stats.step_described_hair; when no name changes anything, the row stays as it was
	if stat in ['hair_length', 'hair_style', 'hair_color']:
		id = person.statlist.step_described_hair(stat, values, id, step)
		if id == -1:
			return
	_write_stat(stat, values[id])


func change_value_node_selectable(stat, newvalue): #for the swatches and the tick boxes
	if person == null or !possible_vals.has(stat):
		return
	_write_stat(stat, newvalue)


#Everything a change touches: the stat itself, the doll, the rows whose lists it decides, and
#the pictures in an open submenu, which are of this character's own head.
func _write_stat(stat, value):
	person.set_stat(stat, value)
	#neither the parts nor the colours carry the update_portrait tag, so the shot on file is
	#retired by hand and reshot when the window is left
	person.set_stat('portrait_update', true)
	looks_changed = true
	_apply_to_doll(stat)
	build_node_for_stat(stat)
	refresh_following_colours(stat)
	refresh_dependent_sliders(stat)
	if stat == 'body_color_skin':
		#the nipples, the lips, a shaped ear, a kobold's tail and horns follow the skin while they
		#are on Auto, so their swatches move with it
		for colour in ['body_color_nipples', 'body_color_lips', 'body_color_ears', 'body_color_tail', 'body_color_horns']:
			if possible_vals.has(colour):
				build_selectable_node(colour)
	if stat == 'multiple_tits':
		#the extra pair cannot be developed once there is none
		if int(value) == 0 and bool(person.get_stat('multiple_tits_developed')):
			person.set_stat('multiple_tits_developed', false)
		if possible_vals.has('multiple_tits_developed'):
			possible_vals['multiple_tits_developed'] = _values_for('multiple_tits_developed')
			build_node_for_stat('multiple_tits_developed')
	if stat == 'skin_coverage':
		#the paint belonged to the coat that was just taken off, and the new one carries a
		#different number of colours: the rows under it are built again from scratch
		person.statlist.clear_coat_colours()
		refresh_all()
		return
	refresh_visual_submenu_previews()
	refresh_description()


func refresh_following_colours(stat):
	for colour in colours_following(stat):
		if !possible_vals.has(colour):
			continue
		possible_vals[colour] = _values_for(colour)
		build_selectable_node(colour)


# A hair layer that has just been put on or taken off decides whether its length slider
# belongs on the screen, so the slider is rebuilt along with it.
func refresh_dependent_sliders(stat):
	for slider in PART_BEHIND_SLIDER:
		if PART_BEHIND_SLIDER[slider] != stat:
			continue
		possible_vals[slider] = _values_for(slider)
		build_node_for_stat(slider)


#### the panel of pictures ####

func open_visual_submenu_panel(menu_id):
	if open_visual_submenu == menu_id and visual_submenu.visible:
		_close_visual_submenu()
		return
	var menu = get_visual_submenu_data(menu_id)
	if menu.empty() or person == null:
		return
	open_visual_submenu = menu_id
	visual_submenu.visible = true
	$VisualSubmenu/Title/Label.text = tr(menu.label)
	input_handler.ClearContainer(visual_submenu_rows, ['StatRow'])
	visual_submenu_tiles.clear()
	for submenu_data in _submenus():
		for submenu_stat in submenu_data.stats:
			visual_stat_nodes.erase(submenu_stat)
	for stat in menu.stats:
		if !possible_vals.has(stat):
			continue
		var row = input_handler.DuplicateContainerTemplate(visual_submenu_rows, 'StatRow')
		row.name = stat
		row.get_node('Header').text = visual_stat_name(stat)
		visual_stat_nodes[stat] = row
		input_handler.ClearContainer(row.get_node('Options'), ['Tile'])
		build_visual_submenu_stat(stat, row)


func build_visual_submenu_stat(stat, row):
	row.visible = visual_option_is_shown(stat)
	if !row.visible:
		return
	for value in possible_vals[stat]:
		var tile = input_handler.DuplicateContainerTemplate(row.get_node('Options'), 'Tile')
		tile.set_meta('stat', stat)
		tile.set_meta('value', value)
		tile.get_node('Label').text = visual_value_name(stat, value)
		#the tile keeps its size either way - the label is anchored to its bottom edge
		tile.get_node('Label').visible = show_option_names
		tile.connect('pressed', self, 'select_visual_submenu_value', [stat, value])
		var ready_texture = preview_booth.taken_for_stat(stat, value)
		if ready_texture != null:
			tile.get_node('Preview').texture = ready_texture
		visual_submenu_tiles.append(tile)
	refresh_visual_tile_selection(stat)
	preview_booth.request_for_stat(person, stat, possible_vals[stat])


func select_visual_submenu_value(stat, value):
	change_value_node_selectable(stat, value)
	_close_visual_submenu()


func refresh_visual_tile_selection(stat):
	if person == null:
		return
	for tile in visual_submenu_tiles:
		if !is_instance_valid(tile) or tile.get_meta('stat') != stat:
			continue
		var value = tile.get_meta('value')
		var selected = value == person.get_stat(stat)
		if !selected and _uses_doll() and CHARACTER_MAP.FEEDS.has(stat):
			#worn under another name that draws the same piece - `beastkin` on a fox is `muzzle1`
			var part = _drawn_part(stat, value)
			selected = part != null and part == _drawn_part(stat, person.get_stat(stat))
		tile.pressed = selected
		tile.get_node('Frame').visible = selected


# The pictures in an open panel are of this character's head, so a change to the head - a
# hair colour, a chin, the fur going on or off - leaves them showing somebody else.
func refresh_visual_submenu_previews():
	if open_visual_submenu == '' or person == null:
		return
	var menu = get_visual_submenu_data(open_visual_submenu)
	for stat in menu.get('stats', []):
		if possible_vals.has(stat) and possible_vals[stat].size() > 0:
			preview_booth.request_for_stat(person, stat, possible_vals[stat])


func refresh_visual_submenu_button(menu_id):
	if !visual_submenu_buttons.has(menu_id):
		return
	var menu = get_visual_submenu_data(menu_id)
	var has_options = false
	for stat in menu.stats:
		if visual_option_is_shown(stat):
			has_options = true
			break
	visual_submenu_buttons[menu_id].visible = has_options
	#a part a character may do without says on its button what is worn - the button alone cannot
	#tell horns from none
	var stat = str(menu.stats[0]) if menu.stats.size() == 1 else ''
	if stat in REMOVABLE_PARTS:
		visual_submenu_buttons[menu_id].text = '%s - %s' % [tr(menu.label), visual_value_name(stat, person.get_stat(stat))]


func _on_visual_preview_ready(_group_id, _part_id, texture):
	for tile in visual_submenu_tiles:
		if !is_instance_valid(tile):
			continue
		if preview_booth.taken_for_stat(tile.get_meta('stat'), tile.get_meta('value')) == texture:
			tile.get_node('Preview').texture = texture


func _close_visual_submenu():
	visual_submenu.hide()
	open_visual_submenu = ''


func get_visual_submenu_data(menu_id):
	for menu in _submenus():
		if str(menu.id) == str(menu_id):
			return menu
	return {}


#Every panel of pictures the room has: the creation screen's, then its own.
func _submenus():
	#with dolls switched off there is nothing to take the pictures with, so every option is a plain row
	if _dolls_off():
		return []
	return LAYOUT.SUBMENUS + EXTRA_SUBMENUS


#Which panel an option belongs to, or '' when it stays on the main list.
func _submenu_of(stat):
	for menu in _submenus():
		if str(stat) in menu.stats:
			return str(menu.id)
	return ''


#### the doll, and writing a new look down ####

#One stat changed, so the doll re-reads itself where it stands: a full rebuild would throw
#away the zoom and the drag the player set on it.
func _apply_to_doll(_stat):
	var doll = preview.get_node('Paperdoll')
	if doll.visible:
		doll.rebuild_stat(_stat)


func refresh_preview(force):
	if person == null:
		preview.hide_band()
		return
	if force:
		#the band skips the rebuild while nothing it knows of has changed, and a body just
		#remade in this chair is exactly such a change
		preview.cached_person_id = ''
	preview.show_for(person)


#With dolls switched off the character is a silhouette, and what the room changes is what is said about
#them, so the description stands over the silhouette and is written again after every change. The node is
#the scene's Preview/Description, looked for rather than assumed.
func refresh_description():
	if !preview.has_node("Description"):
		return
	var description = preview.get_node("Description")
	description.visible = person != null and _dolls_off()
	if description.visible:
		description.bbcode_text = ResourceScripts.descriptions.trim_tag(person.make_description(), 'url', 'hair')


#The portrait on file was taken before the change, and every other screen showing this
#character is holding the old doll. Done when the chair is given up rather than on every
#click: a reshoot builds the booth and costs a few frames.
func _commit_looks():
	if !looks_changed or person == null:
		return
	looks_changed = false
	input_handler.reshoot_portrait(person)
	input_handler.emit_signal('update_ragdoll')
	_rebuild_slave_list()


func _rebuild_slave_list():
	var mansion = get_parent()
	if mansion != null and mansion.get('SlaveListModule') != null:
		mansion.SlaveListModule.rebuild()


#### the doll or the artwork ####

#the switch at the top of a unique character's list, while there is one
var paperdoll_switch = null


#The same switch as the character screen's: it is written on the character, so every screen
#that draws them follows it and it survives a save. What the room offers changes with it - the
#doll's parts, or only what the description is built from - so the list is built again.
func _on_paperdoll_toggled(pressed):
	if person == null or bool(person.get_stat('use_paperdoll')) == pressed:
		return
	person.set_use_paperdoll(pressed)
	_close_visual_submenu()
	refresh_all()
	_rebuild_slave_list()
