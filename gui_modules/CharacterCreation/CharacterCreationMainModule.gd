extends Panel

const DOLL_COLORS = preload("res://Character_generator/Doll2Spine/universal/doll_colors.gd")
const DOLL_SOURCE = preload("res://Character_generator/Doll2Spine/doll2_source.gd")
const DOLL_LIST = preload("res://Character_generator/Doll2Spine/doll2_dolls.gd")
const LAYOUT = preload("res://gui_modules/CharacterCreation/creation_layout.gd")

export var testmode = false

var person
var mode #added freemode - to EDIT existing chars
var total_stat_points
var unassigned_points

var preservedsettings = {}
#var valid_preservedsettings = {}

var agearray = ['teen','adult','mature']
var sexarray = ['male','female','futa']
#var malesizes = ['masculine','flat']
#var sizes = ['flat','small','average','big','huge']
#var short_sizes = ['small','average','big']
var guild = 'none'

#var bodypartsarray = ['skin', 'hair_length', 'hair_color', 'eye_color', 'eye_shape', 'ears', 'horns', 'tail', 'wings', 'height']
#var sexbodypartsarray = ['slave_class','penis_size', 'penis_type', 'balls_size','tits_size', 'ass_size']

#var slave_classes = ['slave','servant']
var slave_classes = ['servant']

var critical_stats = ["body_lower", "body_shape",
 "penis_size", # should be filtered by sex
#"penis_type", 4testing, possible bugs
"balls_size", # should be filtered by sex
"tits_size", # should be filtered by sex, visuals not affected, but descryptions will, lyckily races with tits filterinsg are rare
 "multiple_tits", "multiple_tits_developed", "skin_coverage"] #those stats will be always filtered by race and sex filters
var free_stats = [
#	'personality',
#	'body_color_skin', 
#	'body_color_wings', #don't forget to add proper data in corresponding races data - i only add empty lines for humans!!! 
#	'body_color_tail', 
#	'body_color_horns', 
#	'body_color_animal', 
	'hair_base', 
	'hair_assist', 
	'hair_back', 
#	'body_color_skin', 
#	'hair_back_color_1',
#	'hair_back_color_2',
#	'hair_assist_color_1',
#	'hair_assist_color_2',
#	'hair_base_color_1',
#	'hair_base_color_2',
#	'hair_base_length', 
#	'hair_fringe_length', 
#	'hair_back_length' , 
#	'hair_assist_length' , 
	] #for testing, remove those after filling racedata


var freemode_fixed_stats = [
	"slave_class",
#	"name", or not
#	"surname",
#	"nickname",
	"sex",
	"age",
	"body_lower",
	"personality", 
	"physics_factor",
	"magic_factor",
	"tame_factor",
	"authority_factor",
	"growth_factor",
	"charm_factor",
	"wits_factor",
	"sexuals_factor",
	"penis_virgin",
	"vaginal_virgin",
	"anal_virgin",
	"mouth_virgin",
]

var selected_class = ''
var selected_master_relation = 'none'
var age_order = ['teen', 'adult', 'mature']

var introduction_text = {master = "CHARCREATE_INTRO_MASTER", 'slave' : 'CHARCREATE_INTRO_SLAVE', freemode = ""}

var savefilename
var saveloadstate

var params_to_save = [ #memo mostly
	"slave_class",
	"name",
	"surname",
	"nickname",
	"sex",
	"age",
	"race",
	"traits",
	"sex_traits",
	"personality",
	"height",
	"head_size",
	"ears",
	"eye_color",
	"eye_shape",
	"horns",
	"wings",
	"tail",
#	"arms",
#	"legs",
	"body_lower",
	"body_shape",
	"food_filter",
	"physics_factor",
	"wits_factor",
	"charm_factor",
	"sexuals_factor",
	"magic_factor",
	"tame_factor",
	"authority_factor",
	"professions",
	#added
	"skin_coverage",
	'eyeshape' , 
	'eye_tex', 
	'eyebrows', 
	'lips' , 
	'chin', 
	'nose', 
	'body_color_skin', 
	'body_color_lips', 
	'body_color_eyebrows', 
	'body_color_wings', 
	'body_color_tail', 
	'body_color_horns', 
	'body_color_animal', 
	'body_color_ears', 
	'hair_base', 
	'hair_base_length', 
	'hair_assist', 
	'hair_assist_length' , 
	'hair_back',
	'hair_back_length' ,  
	'hair_back_color_1',
	'hair_back_color_2',
	'hair_assist_color_1',
	'hair_assist_color_2',
	'hair_base_color_1',
	'hair_base_color_2',
	'beard',
	'hair_facial_color',
	"penis_size",
	"penis_type",
	"balls_size",
	"tits_size",
	"ass_size",
	"multiple_tits",
	"multiple_tits_developed",
	"penis_virgin",
	"vaginal_virgin",
	"anal_virgin",
	"mouth_virgin",
]

var tooltips_stat = ['slave_class']

# Whether the picture tiles carry their value's name under them.  The pictures
# are the choice - the character's own head wearing each option - and the caption
# under one is a part code out of the data files, which is what a developer needs
# and a player never should read.  So it is shown when the game is run from the
# editor and nowhere else.
onready var show_option_names = OS.has_feature('editor')

onready var RaceSelection = $RaceSelectionModule
onready var ClassSelection = $ClassSelectionModule
onready var TraitSelection = $TraitSelection
onready var RelationshipSelect = $RelationshipSelect
onready var ragdoll = $RagdollPanel/ragdoll
onready var preview_booth = $DollOptionPreviews
onready var visual_options = $VisualsModule/ScrollContainer/VBoxContainer/StatsContainer
onready var visual_submenu = $VisualSubmenu
onready var visual_submenu_rows = $VisualSubmenu/ScrollContainer/Rows

var possible_vals = {}
var visual_stat_nodes = {}
var visual_submenu_buttons = {}
var visual_submenu_tiles = []
var open_visual_submenu = ""
var updating_visual_controls = false
var visual_insert_index = 0
var personality_icons = {
	bold = load("res://assets/Textures_v2/MANSION/personality_bold.png"),
	kind = load("res://assets/Textures_v2/MANSION/personality_kind.png"),
	shy = load("res://assets/Textures_v2/MANSION/personality_shy.png"),
	serious = load("res://assets/Textures_v2/MANSION/personality_serious.png"),
}


func _ready():
	if testmode:
		modding_core.handle_test_mode() #for test
	RebuildStatsContainer()
	$SaveButton.connect("pressed", self, "SaveLoadCharPanel", ["save"])
	$LoadButton.connect("pressed", self, "SaveLoadCharPanel", ["load"])
	$SaveLoadCharPanel/LineEdit.connect("text_changed",self,'set_savefilename')
	$SaveLoadCharPanel/SaveLoadButton.connect("pressed", self, "PressSaveLoadCharacter", [savefilename])
	$SaveLoadCharPanel/SaveLoadCancel.connect("pressed", self, "hideSaveLoadPanel")
	# input_handler.AddPanelOpenCloseAnimation($RaceSelection)
	# input_handler.AddPanelOpenCloseAnimation($TraitSelection)
	# input_handler.AddPanelOpenCloseAnimation($DietPanel)
	# input_handler.AddPanelOpenCloseAnimation($ClassPanel)
#	$TestButton.connect("pressed", self, "test")
	
	$VBoxContainer/race.connect("pressed", RaceSelection, "select_race")
	$VBoxContainer/sextrait.connect('pressed', self, "open_sex_traits")
	$VBoxContainer/trait.connect('pressed', self, "open_traits")
	$VBoxContainer/personality.connect('pressed', self, "open_personality_selection")
	$VBoxContainer/master_relation.connect('pressed', self, "open_master_relation_selection")
	$RelationshipSelect/Cancel.connect("pressed", self, "hide_relationship_selection")
	globals.connecttexttooltip($VBoxContainer/personality, tr("INFOPERSONALITY"))
	globals.connecttexttooltip($NameReroll, tr("CHARCREATE_TOOLTIP_REROLL_NAME"))
	globals.connecttexttooltip($RaceReroll, tr("CHARCREATE_TOOLTIP_RANDOM_RACE"))
	globals.connecttexttooltip($AppearanceReroll, tr("CHARCREATE_TOOLTIP_REROLL_APPEARANCE"))
	globals.connecttexttooltip($SaveButton, tr("TOOLTIPSAVECHARACTER"))
	globals.connecttexttooltip($LoadButton, tr("TOOLTIPLOADCHARACTER"))
	# the relation tooltip is rebuilt per character in build_master_relation(),
	# because it now carries the sentence the old panel used to print under itself
	$DietPanel/Title.text = tr("CHARCREATE_DIET_TITLE")
	$DietPanel/RichTextLabel.bbcode_text = "[center]" + tr("CHARCREATE_DIET_HELP") + "[/center]"
	$RaceReroll.connect("pressed", self, "reroll_race")
	
	$modes/Stats.connect("pressed", self, 'build_stats')
	$modes/Visuals.connect("pressed", self, 'build_visuals')
	$AppearanceReroll.connect("pressed", self, "reroll_appearance")
	preview_booth.connect('preview_ready', self, '_on_visual_preview_ready')
	$VisualSubmenu/Title/Close.connect('pressed', self, '_close_visual_submenu')
	
	$UpgradesPanel.visible = false
	$VBoxContainer.visible = true
	
	$ConfirmButton.connect("pressed", self, 'confirm_character')
	#$CancelButton.connect("pressed", self, "confirm_return")
	globals.connecttexttooltip($VBoxContainer/sextrait, tr("TOOLTIPSEXTRAITS"))
	
	for i in ['name','surname','nickname']:
		$VBoxContainer.get_node(i).connect("text_changed", self, 'text_changed', [i])
	$NameReroll.connect("pressed", self, "reroll_name")
	
	$VBoxContainer/class.connect("pressed", ClassSelection, "open_class_list")
	$BackButton.connect("pressed", self, "Exit")
	$BackButtonCheats.connect("pressed", self, "hide")
	if testmode:
		open()


func reroll_name():
	person.get_random_name()
	preservedsettings['name'] = person.get_stat('name')
	preservedsettings['surname'] = person.get_stat('surname')
	build_node_for_stat('name')
	build_node_for_stat('surname')
	build_description()


func reroll_race():
	if mode == 'freemode':
		return
	var available_races = get_available_races()
	if available_races.empty():
		return
	var current_race = person.get_stat('race')
	var new_race = input_handler.random_from_array(available_races)
	if available_races.size() > 1:
		while new_race == current_race:
			new_race = input_handler.random_from_array(available_races)
	if current_race != new_race:
		person.set_stat('race', new_race)
		preservedsettings["race"] = new_race
		preservedsettings.erase('surname')
		rebuild_slave()
	build_race()


func get_available_races():
	if mode == 'freemode' or ResourceScripts.game_globals.all_starting_races or OS.has_feature('editor'):
		return races.racelist.keys()
	var res = []
	for race_id in variables.player_starting_races_array:
		if races.racelist.has(race_id):
			res.append(race_id)
	return res


func reroll_appearance():
	_close_visual_submenu()
	preview_booth.forget()
	build_possible_vals()
	var updated_stats = []
	for stat in params_to_save:
		if stat in ["name", "surname", "nickname", "sex", "age", "race", "traits", "sex_traits", "professions", "food_filter", "personality", "slave_class"]:
			continue
		if stat.ends_with('_virgin'):
			continue
		if stat.ends_with('_factor'):
			continue
		if !possible_vals.has(stat):
			continue
		if possible_vals[stat].empty():
			continue
		var new_val = input_handler.random_from_array(possible_vals[stat])
		if LAYOUT.DEFAULT_COLOUR_FROM.has(stat):
			new_val = '' # a rolled character follows the rule; the player need not
		person.set_stat(stat, new_val)
		preservedsettings[stat] = new_val
		updated_stats.append(stat)
	if input_handler.globalsettings.generate_portraits:
		person.make_random_portrait()
	rebuild_ragdoll()
	for stat in updated_stats:
		if LAYOUT.COLOUR_FOLLOWS.has(stat):
			build_selectable_node(stat)
		build_node_for_stat(stat)
	build_description()
	build_upgrades()


func apply_default_personality():
	preservedsettings.erase('personality')
	person.set_stat('personality', 'neutral')
	build_personality()


func build_stats():
	$modes/Stats.pressed = true
	$modes/Visuals.pressed = false

	$StatsModule.visible = true
	$DietPanel.visible = true
	$VisualsModule.visible = false
	_close_visual_submenu()
	build_master_relation()
	if mode != 'freemode':
		$UpgradesPanel.visible = false
		$VBoxContainer.visible = true


func build_visuals():
	$modes/Stats.pressed = false
	$modes/Visuals.pressed = true

	$StatsModule.visible = false
	$DietPanel.visible = false
	$VisualsModule.visible = true
	# the relation button lives in the left column with the other choices now, so
	# it stays put when the tab changes - only the open list has to be dismissed
	RelationshipSelect.hide()
	if mode == 'freemode':
		$UpgradesPanel.visible = true
		$VBoxContainer.visible = false



func if_can_assign(stat, value):
	if stat in ["name", "surname", "nickname"]:
		return true
	if !possible_vals.has(stat):
		print ("warning - assigning of unknown stat %s" % stat)
		return false
	return possible_vals[stat].has(value)


func apply_preserved_settings(): #on regenerating char
	for i in preservedsettings:
#		if i == "food_love":
#			person.food.food_love = preservedsettings["food_love"]
#			build_node_for_stat('food')
#		elif i == "food_hate":
#			person.food.food_hate = preservedsettings["food_hate"]
#			build_node_for_stat('food')
		if i in ['food_filter', 'sex', 'race', 'professions', 'sex_traits', 'traits']:
			continue
		if i == 'slave_class':
			continue
		elif if_can_assign(i, preservedsettings[i]):
			person.set_stat(i, preservedsettings[i])
			build_node_for_stat(i)
	rebuild_ragdoll()


func build_possible_vals():
	for stat in params_to_save:
		if stat in ['food_like', 'food_hate', 'food_filter']:
			continue
		if stat in ["name", "surname", "nickname", "race", "traits", "sex_traits", "professions",]:
			continue
		build_possible_val_for_stat(stat)


func get_personality_options():
	var options = []
	for code in variables.personality_array:
		if code == 'neutral':
			continue
		options.push_back(code)
	return options


func has_selected_personality():
	var personality = person.get_stat('personality')
	if personality == null or personality == '' or personality == 'neutral':
		return false
	return get_personality_options().has(personality)


# The values a stat may be given on this screen, minus the ones nobody is allowed
# to pick - see LAYOUT.NEVER_OFFERED.  The list is filtered here, once, rather
# than in each of the four places below that build one.
func build_possible_val_for_stat(stat):
	_collect_possible_vals(stat)
	if !possible_vals.has(stat) or !LAYOUT.NEVER_OFFERED.has(stat):
		return
	var offered = []
	for value in possible_vals[stat]:
		if LAYOUT.offered(stat, value):
			offered.append(value)
	possible_vals[stat] = offered


func _collect_possible_vals(stat):
	if person.is_unique():
		possible_vals[stat] = []
		return
	if stat.ends_with('factor'):
		possible_vals[stat] = [1, 2, 3, 4, 5, 6]
		if stat in ['authority_factor','tame_factor'] and mode == 'master':
			possible_vals[stat] = []
		return
	if stat == 'slave_class':
		possible_vals[stat] = slave_classes
		if mode == 'master':
			possible_vals[stat] = []
		return
	if possible_vals.has(stat):
		possible_vals[stat].clear()
	else:
		possible_vals[stat] = []
	if PART_BEHIND_SLIDER.has(stat) and str(person.get_stat(PART_BEHIND_SLIDER[stat])) in ['', 'no', 'none']:
		return #the hair this one lengthens is not there, so neither is the row
	if stat == 'sex':
		for val in sexarray:
			if input_handler.globalsettings.futa == false and val == 'futa':
				continue
			possible_vals.sex.push_back(val)
		return
	if stat == 'age':
		possible_vals.age = agearray.duplicate()
		return
	if stat == 'personality':
		possible_vals.personality = get_personality_options()
		return
	# Colours come from the palette the doll paints with rather than from the old
	# transform tables, but a character is still only offered what their race
	# wears: the race's own list, kept to the values the palette knows.
	if !DOLL_COLORS.values_for(stat).empty():
		possible_vals[stat] = colours_allowed_to_race(stat)
		return
	if mode == 'freemode' and !critical_stats.has(stat) or free_stats.has(stat):
		if GeneratorData.transforms.has(stat):
			for val in GeneratorData.transforms[stat]:
				if val == "":
					continue #can't set default value
				possible_vals[stat].push_back(val)
		else:
#			print ('warninig - possible obsolete stat %s' % stat)
			if ResourceScripts.descriptions.bodypartsdata.has(stat):
				for val in ResourceScripts.descriptions.bodypartsdata[stat]:
					possible_vals[stat].push_back(val)
			else:
				print ('error - unknown stat %s' % stat)
	else:
		var t_stat = stat
		if stat.begins_with('hair_') and stat.find('color') != -1:
			t_stat = 'hair_base_color_1' #stub
		var race = person.get_stat('race')
		var sex = person.get_stat('sex')
		#race filter
		var race_vals = []
		var racedata = races.racelist[race] #if this is unsafe - than we REALLY need to fill data. i won't add a check here for sanity reasons
		if racedata.has('bodyparts') and racedata.bodyparts.has(stat):
			for val in racedata.bodyparts[stat]:
				if val is Array:
					race_vals.push_back(val[0])
				else:
					race_vals.push_back(val)
		elif racedata.has('bodyparts') and racedata.bodyparts.has(t_stat):
			for val in racedata.bodyparts[t_stat]:
				if val is Array:
					race_vals.push_back(val[0])
				else:
					race_vals.push_back(val)
		else:
			racedata = races.racelist['Human'] #we should definitely move this data to isolated record
			if racedata.bodyparts.has(t_stat):
				for val in racedata.bodyparts[t_stat]:
					if val is Array:
						race_vals.push_back(val[0])
					else:
						race_vals.push_back(val)
		if race_vals.empty(): #no need to filter more
			return
		#sex filter
		var sexdata = ResourceScripts.descriptions.bodypartsdata.sex[sex] #same assumption
		var sex_vals = []
		if sexdata.has('bodychanges'):
			for change in sexdata.bodychanges:
				if change.code != t_stat and change.code != stat:
					continue
				if change.has('reqs') and !person.checkreqs(change.reqs):
					continue
				sex_vals.clear()
				for val in change.value:
					if val is Array:
						sex_vals.push_back(val[0])
					else:
						sex_vals.push_back(val)
		#merge
		for val in race_vals:
			if !sex_vals.empty() and !sex_vals.has(val):
				continue
			#there shoud be possible check for having transform in ragdoll builder - but it's not critical
			possible_vals[stat].push_back(val)


func find_stat_value_id(stat, value):
	if !possible_vals.has(stat):
		print('error - no stat %s' % stat)
		return 0
	var res = possible_vals[stat].find(value)
	if res == -1:
		print('error - no value %s for stat %s' % [str(value), stat])
		return 0
	return res


func find_node_for_stat(stat):
	if stat in ['sex', 'age']:
		return $VBoxContainer/HBoxContainer.get_node(stat)
	if stat in [ "name", "surname", "nickname"]:
		return $VBoxContainer.get_node(stat)
	if stat.ends_with('_factor'):
		return $StatsModule/StatsContainer.get_node(stat)
	if stat.begins_with('food_filter_'):
		return $DietPanel/Cards.get_node(stat.trim_prefix('food_filter_'))
	return visual_stat_nodes.get(str(stat))


func visual_stat_name(stat):
	if statdata.statdata.has(stat) and statdata.statdata[stat].has('name') and str(statdata.statdata[stat].name) != '':
		return tr(statdata.statdata[stat].name)
	return tr("STAT" + str(stat).to_upper())


func visual_value_name(stat, value):
	if ResourceScripts.descriptions.bodypartsdata.has(stat):
		var descriptions = ResourceScripts.descriptions.bodypartsdata[stat]
		if descriptions.has(value) and str(descriptions[value].name) != '':
			return tr(descriptions[value].name)
	return tr(str(value))


func visual_option_is_shown(stat):
	if !possible_vals.has(stat) or possible_vals[stat].size() <= 1:
		return false
	if stat in freemode_fixed_stats and mode == 'freemode':
		return false
	return true


func colours_following(stat):
	var result = []
	for colour in LAYOUT.COLOUR_FOLLOWS:
		if LAYOUT.COLOUR_FOLLOWS[colour] == stat and colour in params_to_save:
			result.append(colour)
	return result


# What this race may wear of a colour stat.  The race's own list wins, minus
# anything the palette no longer has; a race that lists nothing falls back to the
# shades named after it - a dark elf to `darkelf1..4`, a demon to the demon ones -
# so a part nobody wrote a list for still offers something of its own instead of
# the whole palette.
# A length has nothing to lengthen when the layer it belongs to is not worn: no
# back hair, no back-hair length.  Same shape as the colours below and read in
# the same place, so a row whose part is missing simply has no values and takes
# itself off the screen.
const PART_BEHIND_SLIDER = {
	"hair_base_length": "hair_base",
	"hair_back_length": "hair_back",
	"hair_assist_length": "hair_assist",
	"hair_fringe_length": "hair_fringe",
}


const PART_BEHIND_COLOUR = {
	"body_color_wings": "wings",
	"body_color_tail": "tail",
	"body_color_horns": "horns",
	"body_color_animal": "body_lower",
	# a clean-shaven character is not asked what shade his beard is, and most of
	# the cast has no beard art at all
	"hair_facial_color": "beard",
}


func colours_allowed_to_race(stat):
	# A pointed or plain ear is shaped skin, drawn in skin tone by the art itself;
	# only an ear the art grows fur on has a colour to be asked about.  Asked here,
	# above the rule below, which answers with the whole palette and returns.
	if stat == 'body_color_ears' and !person.statlist.has_animal_ears():
		return []
	# Same for the tail: a hide, a fin or a scaled tail answers to something else,
	# and a tail the art never draws answers to nothing.
	if stat == 'body_color_tail' and !person.statlist.has_fur_tail():
		return []
	var race = person.get_stat('race')
	# A colour with a rule behind it offers the rule first - an empty value,
	# which is what makes the lips follow the skin and the brows the hair - and
	# then the whole palette, because a painted mouth is a choice rather than a
	# birthright.
	if LAYOUT.DEFAULT_COLOUR_FROM.has(stat):
		var offered = ['']
		for value in DOLL_COLORS.values_for(stat):
			offered.append(value)
		return offered
	# A part the character does not have has no colour to pick: a human is not
	# asked what shade her wings are.
	if PART_BEHIND_COLOUR.has(stat) and str(person.get_stat(PART_BEHIND_COLOUR[stat])) in ['', 'no', 'none']:
		return []
	# Neither is a colour the game works out on its own - the lips take the skin's,
	# a fur tail the hair's.  Creation rolls whatever it offers, and a roll would
	# overwrite the rule with any old colour.
	if person.statlist.derives_colour(stat):
		return []
	var t_stat = stat
	if stat.begins_with('hair_') and stat.find('color') != -1:
		t_stat = 'hair_base_color_1'
	var listed = []
	var spoken_for = false
	var racedata = races.racelist[race]
	if racedata.has('bodyparts'):
		if racedata.bodyparts.has(stat):
			listed = racedata.bodyparts[stat]
			spoken_for = true
		elif racedata.bodyparts.has(t_stat):
			listed = racedata.bodyparts[t_stat]
			spoken_for = true
	var allowed = []
	for entry in listed:
		var value = entry[0] if entry is Array else entry
		if DOLL_COLORS.knows(value) and !(value in allowed):
			allowed.append(value)
	# An empty list is the race saying it wears none - a human has no wings to
	# colour - and that hides the row.  Saying nothing at all is what falls back.
	if allowed.empty() and !spoken_for:
		allowed = DOLL_COLORS.values_for_race(stat, race)
	return allowed


func build_selectable_node(stat):
	if !LAYOUT.COLOUR_FOLLOWS.has(stat):
		print('stat node not selectable - %s' % stat)
		return
	var node = find_node_for_stat(stat)
	if node == null:
		return
	var painted_option = LAYOUT.COLOUR_FOLLOWS[stat]
	var colour_is_shown = possible_vals.has(stat) and possible_vals[stat].size() > 1
	# Deliberately not "is the option row on screen".  A row hides itself when the
	# race leaves nothing to choose - a fairy has exactly one pair of wings - and
	# that is not a reason to take her nine wing colours away with it.  Whether
	# the character has the part at all is already answered upstream: the colour
	# comes back empty for anyone whose part is `''`, `no` or `none`, and a colour
	# the game works out on its own is not offered here in the first place.
	if painted_option != '' and painted_option in freemode_fixed_stats and mode == 'freemode':
		colour_is_shown = false
	if stat in freemode_fixed_stats and mode == 'freemode':
		colour_is_shown = false
	if !colour_is_shown:
		node.visible = false
		return
	node.visible = true
	input_handler.ClearContainer(node.get_node('GridContainer'), ['Button', 'Button2'])
	var template = 'Button2'
	if stat == 'body_color_skin':
		template = 'Button'
	for val in possible_vals[stat]:
		var newbutton = input_handler.DuplicateContainerTemplate(node.get_node('GridContainer'), template)
		newbutton.set_meta('value', val)
		newbutton.connect('pressed', self, 'change_value_node_selectable', [stat, val])
		# The swatch is the colour itself, taken from the table the doll paints
		# from.  It used to be read out of the old paperdoll's recolour materials,
		# which meant a colour the doll no longer had simply showed no swatch at
		# all - an orc had none to pick from.
		var square = newbutton.get_node('ColorRect')
		square.material = null
		square.color = DOLL_COLORS.colour_of(stat, val)
		# no tooltip: a swatch is its own label, and a name over every square
		# only got in the way of picking one
		if str(val) == '' and LAYOUT.DEFAULT_COLOUR_FROM.has(stat):
			# the swatch shows what following the rule looks like right now
			var source = str(LAYOUT.DEFAULT_COLOUR_FROM[stat])
			square.color = DOLL_COLORS.colour_of(source, person.get_stat(source))


func build_node_for_stat(stat):
	var val = person.get_stat(stat)
	if preservedsettings.has(stat) and preservedsettings[stat] != val:
		if if_can_assign(stat, preservedsettings[stat]):
			val = preservedsettings[stat]
			person.set_stat(stat, val)
	
	if stat in ['food_like', 'food_hate']:
		return
	
	if stat == 'food_filter':
		build_food_filter()
		return

	var node = find_node_for_stat(stat)
	
	if stat in ["name", "surname", "nickname"]:
		node.text = val
		return

	if !possible_vals.has(stat):
		return

	if LAYOUT.COLOUR_FOLLOWS.has(stat):
		if LAYOUT.DEFAULT_COLOUR_FROM.has(stat):
			# the getter answers with the colour this one follows, so "follow it" -
			# the empty value - has to be read off the stat itself or the frame
			# would never land on the default swatch
			val = str(person.statlist.get(stat))
		if node == null:
			return
		for nd in node.get_node('GridContainer').get_children():
			var selected = nd.has_meta('value') and nd.get_meta('value') == val
			nd.pressed = selected
			if nd.has_node('Frame'):
				nd.get_node('Frame').visible = selected
		return

	var submenu_id = LAYOUT.submenu_of(stat)
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
		# the wheel belongs to the list it sits in: a slider that answers it too
		# changes the character while the player is only scrolling past
		slider.scrollable = false
		updating_visual_controls = true
		slider.min_value = 0
		slider.max_value = max(values.size() - 1, 0)
		slider.step = 1
		slider.value = max(values.find(val), 0)
		# the name and the value read as one line - "Hair assist length - short" -
		# instead of a caption stacked over a second caption saying what it is set to
		node.get_node('header/Label').text = '%s - %s' % [visual_stat_name(stat), visual_value_name(stat, val)]
		node.get_node('Control/Value').visible = false
		updating_visual_controls = false
		if !node.has_meta('signals_built'):
			slider.connect('value_changed', self, 'change_slider_value', [stat])
			node.set_meta('signals_built', true)
		node.set_meta('current_val', val)
		return

	if stat in LAYOUT.CHECKBOXES:
		updating_visual_controls = true
		node.pressed = bool(val)
		updating_visual_controls = false
		if !node.has_meta('signals_built'):
			node.connect('toggled', self, 'change_checkbox_value', [stat])
			node.set_meta('signals_built', true)
		node.set_meta('current_val', val)
		return
	
	if stat in ['sex', ]:
		var id = possible_vals[stat].find(val)
		node.get_node('button/LArr').visible = (id > 0)
		node.get_node('button/RArr').visible = (id < possible_vals[stat].size() - 1)
	
	# a factor row is nothing like the arrow-and-label rows below it, so it draws
	# itself and stops here rather than falling through to them
	if LAYOUT.factor_row(stat) != null:
		build_factor_row_value(node, stat, val)
		return

	var text = visual_value_name(stat, val)
	node.get_node('button/Label').text = text
	if !node.has_meta('signals_built'):
		node.get_node('button/LArr').connect('pressed', self, 'change_value_node', [stat, -1])
		node.get_node('button/RArr').connect('pressed', self, 'change_value_node', [stat, 1])
		if node.get_node('button') is TextureButton:
			node.get_node('button').connect('pressed', self, 'change_value_node', [stat, 1])
		node.set_meta('signals_built', true)
	node.set_meta('current_val', val)


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


func rebuild_ragdoll(stat = null):
	refresh_visual_submenu_previews()
	var stored_image = person.get_stored_body_image()
	if input_handler.globalsettings.disable_paperdoll and stored_image == null:
		stored_image = person.get_body_image()
	if stored_image != null:
		$RagdollPanel/TextureRect.texture = stored_image
		$RagdollPanel/TextureRect.visible = true
		ragdoll.visible = false
		return
	else:
		$RagdollPanel/TextureRect.visible = false
		ragdoll.visible = true
	#temp
	if stat == null:
		ragdoll.rebuild(person)
		ragdoll.rebuild_cloth(true)
	else:
		ragdoll.rebuild_stat(stat)
	if stat == 'tits_size':
		ragdoll.jiggle_tits()


func change_value_node(stat, value): #for scrollable nodes
	if !possible_vals.has(stat):
		print('error - no stat %s' % stat)
		return
	var values = possible_vals[stat]
	if stat in LAYOUT.SLIDERS:
		values = LAYOUT.ladder(stat, possible_vals[stat])
	var id = values.find(person.get_stat(stat))
	if id == -1:
		id = 0
	if stat.ends_with('factor'):
		if unassigned_points() < value:
			return
	
	id += value
	if id < 0:
		id = values.size() - 1
	if id >= values.size():
		id = 0
	var newval = values[id]
	if stat != 'slave_class':
		person.set_stat(stat, newval)
	preservedsettings[stat] = newval
	if stat.ends_with('factor'):
		$ClassSelectionModule.update_class_buttons()
		build_class()
		update_points()
	
	if stat == 'sex':
		#recreate char
		preservedsettings.erase('name') #think it is right
		rebuild_slave()
		FillStats()
		return
	rebuild_ragdoll(stat)
	build_node_for_stat(stat)
	refresh_following_colours(stat)
	refresh_dependent_sliders(stat)
	build_description()
	build_master_relation()
	if RelationshipSelect.visible:
		build_master_relation_selection()
	build_upgrades()


func change_value_node_selectable(stat, newvalue): #for selectable nodes
	if !possible_vals.has(stat):
		print('error - no stat %s' % stat)
		return
	person.set_stat(stat, newvalue)
	preservedsettings[stat] = newvalue
	rebuild_ragdoll(stat)
	build_node_for_stat(stat)
	refresh_following_colours(stat)
	refresh_dependent_sliders(stat)
	build_description()
	build_master_relation()
	build_upgrades()


func refresh_following_colours(stat):
	for colour in colours_following(stat):
		build_possible_val_for_stat(colour)
		build_selectable_node(colour)
		build_node_for_stat(colour)


# A hair layer that has just been put on or taken off decides whether its length
# slider belongs on the screen, so the slider is rebuilt along with it.
func refresh_dependent_sliders(stat):
	for slider in PART_BEHIND_SLIDER:
		if PART_BEHIND_SLIDER[slider] != stat or !(slider in params_to_save):
			continue
		build_possible_val_for_stat(slider)
		build_node_for_stat(slider)


func unassigned_points():
	var points
	if mode == 'freemode':
		return 0
	if mode == 'master':
		points = variables.master_starting_stats + 5 + ResourceScripts.game_progress.master_starting_factor_bonus
		for st in ['physics_factor','wits_factor','charm_factor','sexuals_factor', "magic_factor"]:
			points -= int(person.get_stat(st))
	
	else:
		points = variables.slave_starting_stats + 7
		for st in ['physics_factor','wits_factor','charm_factor','sexuals_factor', 'tame_factor', 'authority_factor', "magic_factor"]:
			points -= int(person.get_stat(st))
	return points


func update_points(): #visual only
	if unassigned_points() < 0: 
		reset_points()
		$ClassSelectionModule.update_class_buttons()
		FillStats()
		build_class()
	
	$StatsModule/totalstatlabel.text = tr("CHARCREATE_UNASSIGNED_STATS") % unassigned_points()
	$StatsModule/totalstatlabel.visible = (mode != 'freemode')
	refresh_factor_arrows()


func reset_points():
	for st in ['physics_factor','wits_factor','charm_factor','sexuals_factor', 'tame_factor', 'authority_factor', 'magic_factor']:
		person.set_stat(st, 1)
		preservedsettings.erase(st)


#food_filter
onready var foods = variables.food_types
#disliked food no longer exists - a character just picks the one type they like
var food_vals = ['like', 'neutral']
#the grid under the staple dish is 3x2
const food_examples_shown = 6

var reverse_filter = {}

func clear_food_filter():
	preservedsettings.erase('food_filter')


func check_food_filter():
	reverse_filter.clear()
	for val in food_vals:
		reverse_filter[val] = []
	if preservedsettings.has('food_filter'):
		for food in foods:
			if preservedsettings.food_filter.has(food):
				if !food_vals.has(preservedsettings.food_filter[food]):
					print ('warning - wrong value for food filter $s - %s removed' % [food, preservedsettings.food_filter[food]])
					preservedsettings.food_filter.erase(food)
					continue
				reverse_filter[preservedsettings.food_filter[food]].push_back(food)
	if reverse_filter.like.size() != 1:
		return false
	return true


func build_food_filter():
	var val = {}
	if mode == 'freemode':
		preservedsettings.food_filter = {}
		for food in foods:
			val[food] = 'neutral'
			preservedsettings.food_filter[food] = 'neutral'
		if foods.has(person.food.food_love):
			val[person.food.food_love] = 'like'
			preservedsettings.food_filter[person.food.food_love] = 'like'
	else: #read from preservedsettings
		for food in foods:
			val[food] = 'neutral'
			if preservedsettings.has('food_filter') and preservedsettings.food_filter.has(food):
				val[food] = preservedsettings.food_filter[food]

	var liked_count = 0
	for food in foods:
		if val[food] == 'like':
			liked_count += 1
	var help_text = tr("CHARCREATE_DIET_HELP")
	if liked_count > 1:
		help_text = tr("CHARCREATE_DIET_HELP_TOO_MANY_LIKED")
	elif liked_count < 1:
		help_text = tr("CHARCREATE_DIET_HELP_NO_LIKED")
	$DietPanel/Title.text = tr("CHARCREATE_DIET_TITLE")
	$DietPanel/RichTextLabel.bbcode_text = "[center]" + help_text + "[/center]"

	#the cards themselves never change, only which one is picked - so they are built
	#from the template once and the rebuild just moves the highlight
	if $DietPanel/Cards.get_child_count() <= 1: #only the template is there
		build_food_cards()
	for food in foods:
		build_food_card(food, val[food] == 'like')


func build_food_cards():
	var container = $DietPanel/Cards
	input_handler.ClearContainer(container, ['Card'])
	for food in foods:
		var node = input_handler.DuplicateContainerTemplate(container, 'Card')
		node.name = food
		node.connect('pressed', self, 'change_food_filter_value', [food])
		node.get_node('Name').text = tr("FOODTYPE" + food.to_upper())
		node.get_node('ExamplesLabel').text = tr("CHARCREATE_DIET_DISHES")
		build_food_dishes(node, food)


func build_food_card(food, is_liked):
	var node = find_node_for_stat('food_filter_' + food)
	node.pressed = is_liked
	node.get_node('Mark').visible = is_liked


#the dishes a character with this liked type actually benefits from - ch_food.is_liked()
#matches the item tags, so a mixed dish counts for every type it is tagged with
func get_foods_of_type(food):
	var res = []
	for item in Items.materiallist.values():
		if item.type == 'food' and item.tags.has(food):
			res.push_back(item.code)
	res.sort_custom(self, 'sort_foods_by_demand')
	return res


#cheapest of the lowest demand tier first - that is the staple the type is known by, and
#the one the card shows big. grains have no edible raw form, so theirs comes out as bread
func sort_foods_by_demand(first, second):
	var first_item = Items.materiallist[first]
	var second_item = Items.materiallist[second]
	var first_rank = variables.food_demand_order.find(first_item.demand)
	var second_rank = variables.food_demand_order.find(second_item.demand)
	if first_rank != second_rank:
		return first_rank < second_rank
	if first_item.price != second_item.price:
		return first_item.price < second_item.price
	return first < second


func build_food_dishes(card, food):
	var container = card.get_node('Examples')
	input_handler.ClearContainer(container, ['Slot'])
	var codes = get_foods_of_type(food)
	if codes.empty():
		return
	#the staple gets the big frame, the rest go into the grid below it
	var staple = codes.pop_front()
	card.get_node('IconFrame/Icon').texture = Items.materiallist[staple].icon
	globals.connectmaterialtooltip(card.get_node('IconFrame'), Items.materiallist[staple])
	if codes.size() > food_examples_shown:
		codes.resize(food_examples_shown)
	for code in codes:
		var slot = input_handler.DuplicateContainerTemplate(container, 'Slot')
		slot.get_node('Icon').texture = Items.materiallist[code].icon
		globals.connectmaterialtooltip(slot, Items.materiallist[code])


func apply_food_filter():
	if !check_food_filter():
		return
	person.food.food_love = reverse_filter.like[0]


func change_food_filter_value(food):
	#in freemode the liked type is whatever the character already has
	if mode == 'freemode':
		build_food_filter()
		return
	if !foods.has(food):
		print ('error - unknown food %s' % food)
		return
	if !preservedsettings.has('food_filter'):
		preservedsettings.food_filter = {}
	#only one type can be liked at a time
	for other in foods:
		preservedsettings.food_filter[other] = 'neutral'
	preservedsettings.food_filter[food] = 'like'
	build_food_filter()


func Exit():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'MainMenu', tr('LEAVECONFIRM')])


func MainMenu():
	#GameStartNode should be not null here, otherwise need another solution
	input_handler.GameStartNode.got_back = true
	input_handler.emit_signal("CharacterCreated")#for GameStartNode
	globals.return_to_main_menu()


#
# Reading a Spine export costs about a fifth of a second, and the sex buttons
# switch the doll from one rig to the other - so the first man a player made
# paid for the male export under their finger.  The screen asks for every rig
# while it is still settling instead, one per frame.  The parse is shared, so
# this is paid once for the session and every other screen gets it for free.
func warm_doll_rigs():
	yield(get_tree(), 'idle_frame')
	yield(get_tree(), 'idle_frame') # let the screen paint before the read
	for doll_id in DOLL_LIST.DOLLS.keys():
		if DOLL_SOURCE.is_loaded(doll_id):
			continue
		DOLL_SOURCE.of(doll_id)
		yield(get_tree(), 'idle_frame') # one rig per frame, never both in one


func open(type = 'slave', newguild = 'none', is_from_cheats = false):
	preservedsettings.clear()
	selected_class = ''
	selected_master_relation = 'none'
#	build_class()
#	build_race()
#	build_sex_trait()
#	build_trait()
	warm_doll_rigs()
	show()
	guild = newguild
#	$CancelButton.visible = input_handler.CurrentScreen == 'mansion'
	$introduction.bbcode_text = tr(introduction_text[type])
	if type == 'slave':
		$introduction.bbcode_text += " " + str(ResourceScripts.game_party.characters.size())
	mode = type
	if type == 'freemode':
		return
	person = ResourceScripts.scriptdict.class_slave.new("char_creation")
	person.set_stat('age', 'adult')
	person.set_stat('race', 'Human')
	init_upgrades()
	match mode:
		'master':
			person.set_stat('sex', 'male')
		'slave':
			person.set_stat('sex', 'female')

#	globals.connecttexttooltip($SlaveCreationModule/ScrollContainer/HBoxContainer/bodyparts2/slave_class_label, "Slave&Peon:\n" + tr('SLAVECLASSDESCRIPT') + "\n\n" + tr('SERVANTCLASSDESCRIPT'))
	$BackButton.visible = type != 'slave' || is_from_cheats
	$BackButtonCheats.visible = is_from_cheats
	$SaveButton.visible = !is_from_cheats
	$LoadButton.visible = !is_from_cheats
	$VBoxContainer/master_relation.visible = (type != 'master')
	$modes.visible = true
	build_food_filter()
	rebuild_slave()
	build_stats()


func open_freemode(char_to_open, flag = false):
	person = char_to_open
	if person.get_upgrade_points() < 0:
		flag = true
	upgrades_removal = flag
	preservedsettings.clear()
	selected_master_relation = 'none'
	warm_doll_rigs()
	show()
	$introduction.bbcode_text = introduction_text['freemode']
	mode = 'freemode'
	build_visuals()
	build_possible_vals()
	init_upgrades()
	FillStats()
	build_class()
	build_food_filter()
	build_race()
	build_trait()
	build_sex_trait()
	rebuild_ragdoll()
	$SaveButton.visible = false
	$LoadButton.visible = false
	$BackButton.visible = false
	$BackButtonCheats.visible = false
	$VBoxContainer/master_relation.visible = false
	$modes.visible = false



func rebuild_slave():
	if mode == 'freemode':
		print('error - invalid recreation')
		return
	_close_visual_submenu()
	var race = person.get_stat('race')
	var sex = person.get_stat('sex')
	var age = person.get_stat('age')
	var t_person = ResourceScripts.scriptdict.class_slave.new("char_creation_rebuild")
	t_person.create(race, sex, age)
	t_person.fill_boosters()
	t_person.is_active = false
	t_person.is_known_to_player = true
	if mode == 'master':
		t_person.unlock_class('master')
	
	person = t_person
	
	apply_default_personality()
	build_possible_vals()
	for stat in ["physics_factor", "magic_factor", "tame_factor", "authority_factor", "charm_factor", "wits_factor", "sexuals_factor"]:
		person.set_stat(stat, 1)
	apply_preserved_settings()
	FillStats()
	build_class()
	build_sex_trait()
	build_trait()
	build_master_relation()


func confirm_character():
	if check_confirm_possibility():
		if mode == 'master' && person.get_stat('sex') == 'female':
			confirm_female()
		elif mode == 'freemode' and !build_upgrades():
			confirm_upgrades()
		else:
			confirm_final()


func confirm_female():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'confirm_final', tr('CREATECHARACTERFEMALE')])


func confirm_final():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'finish_character', tr('CREATECHARQUESTION')])


func confirm_upgrades():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'finish_character', tr('UPDATECHARBROKENUPGRAES')])


func finish_character():
#	apply_preserved_settings()
#	$TraitSelection.hide()
#	$ClassPanel.hide()
	person.set_stat('portrait_update', true)
	rebuild_ragdoll()
	if mode != 'freemode':
		person.is_active = true
		
		#apply delayed preservedsettings
		apply_food_filter()
		person.unlock_class(selected_class)
		if preservedsettings.has("sex_traits") && preservedsettings.sex_traits != null:
			person.create_s_trait_select(preservedsettings.sex_traits)
		if preservedsettings.has("traits") && preservedsettings.traits != null:
			person.add_trait(preservedsettings.traits)
		#basic setup
		person.set_stat('food_consumption', 3)
		person.hp = person.get_stat('hpmax')
		person.mp = person.get_stat('mpmax')
		person.food.create() #rebuild food filter
		#i don't like handle starting eqipment here. but this is the only point where newly created characters are accessible - and we need to do this for the characters created during prologue
		globals.equip_char(person, 'club', {WeaponMace = 'wood'})
		person.set_stat('growth_factor', 5)
		if mode != 'master':
			#apply delayed slave class
			if !preservedsettings.has('slave_class'):
				preservedsettings.slave_class = 'servant'
			person.set_slave_category(preservedsettings.slave_class.to_lower())
			#basic slave setup
#			if guild == 'fighters':
#				person.add_trait('loyalty_combatant')
			if guild in ['servants']:
				person.add_trait('training_s_sexservice')
			person.add_trait('training_s_combat')
			person.add_trait('training_s_working')
			person.add_trait('training_s_relation')
		else:
			person.set_slave_category('master')
			person.set_stat('consent', 100)
			person.set_stat('authority_factor', 5)
			person.set_stat('fame', 1)
			globals.equip_char(person, 'chest_base_cloth', {ArmorBaseCloth = 'cloth', ArmorTrim = 'wood'})
			globals.equip_char(person, 'legs_base_cloth', {ArmorBaseCloth = 'cloth', ArmorTrim = 'wood'})
		ResourceScripts.game_party.add_slave(person)
		apply_master_relationship()
		
		input_handler.emit_signal("CharacterCreated")
		input_handler.add_random_chat_message(person, 'hire')
	else:
		ResourceScripts.game_res.money -= upgradecostgold
		if upgrades_removal :
			for upg in person.get_body_upgrades():
				if !cur_upgrades.has(upg):
					person.remove_upgrade(upg)
		for upg in cur_upgrades:
			person.add_upgrade(upg)
		person.recheck_upgrades()
		input_handler.emit_signal("CharacterUpdated")
	self.hide()


func text_changed(text, value):
	# if text != '':
	preservedsettings[value] = text
	person.set_stat(value, text)
#	apply_preserved_settings()
	build_description()


func check_confirm_possibility():
	if mode != 'freemode':
		if !check_food_filter():
			input_handler.SystemMessage(tr("CHARCREATE_SYS_FOOD_REQUIRED"))
			return false
		
		if !check_class_possibility():
			input_handler.SystemMessage(tr("CHARCREATE_SYS_CLASS_REQUIRED"))
			return false
		
		if !has_selected_personality():
			input_handler.SystemMessage(tr("CHARCREATE_SYS_PERSONALITY_REQUIRED"))
			return false
	
	elif !check_upgrades():
		return false
	
	return true

func set_savefilename(text):
	savefilename = text + ".ch"

func hideSaveLoadPanel():
	ResourceScripts.core_animations.FadeAnimation($SaveLoadCharPanel, 0.5)
	yield(get_tree().create_timer(0.5), "timeout")
	$SaveLoadCharPanel.hide()
	# $SaveLoadCharPanel/SaveLoadButton.disconnect("pressed", self, "PressSaveCharacter")
	# $SaveLoadCharPanel/SaveLoadButton.disconnect("pressed", self, "PressLoadCharacter")
	savefilename = null
	saveloadstate = null

func SaveLoadCharPanel(saveloadmode):
	if saveloadmode == "save":
		$SaveLoadCharPanel/SaveLoadButton.text = tr("CHARCREATE_TEMPLATE_SAVE_BUTTON")
	else:
		$SaveLoadCharPanel/SaveLoadButton.text = tr("CHARCREATE_TEMPLATE_LOAD_BUTTON")
	$SaveLoadCharPanel.show()
	ResourceScripts.core_animations.UnfadeAnimation($SaveLoadCharPanel, 0.5)
	yield(get_tree().create_timer(0.5), "timeout")
	saveloadstate = saveloadmode
	$SaveLoadCharPanel/RichTextLabel.bbcode_text = tr('SAVETEMPLATEDESCRIPT')
	$SaveLoadCharPanel/LineEdit.clear()
	input_handler.ClearContainerForced($SaveLoadCharPanel/ScrollContainer/VBoxContainer)
	# if saveloadmode == "save":
	for i in input_handler.dir_contents(variables.userfolder + 'savedcharacters'):
		var savename = i.replace(variables.userfolder + 'savedcharacters/',"").replace('.ch', '')
		var newbutton = input_handler.DuplicateContainerTemplate($SaveLoadCharPanel/ScrollContainer/VBoxContainer)

		newbutton.get_node("Delete").connect("pressed", self, 'PressDeleteCharacter', [savename])
		newbutton.get_node("Label").text = savename
		newbutton.connect('pressed', self, 'PressSaveLoadCharacter', [savename])


func PressSaveLoadCharacter(savename):
	if saveloadstate == "save":
		PressSaveCharacter(savename)
	else:
		PressLoadCharacter(savename)


func PressSaveCharacter(savename = null):
	if savename != null:
		$SaveLoadCharPanel/LineEdit.text = savename
		savefilename = savename + ".ch"
	if savefilename == '.ch' or savefilename == '':
		return

	var file = File.new()
	if file.file_exists(variables.userfolder + 'savedcharacters/' + savefilename):
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'SaveCharacter', tr("OVERWRITETEMPLATECONFIRM")])
	else:
		SaveCharacter()


func SaveCharacter():
#	apply_preserved_settings()
	var character_to_save = {}
	for i in params_to_save:
		if i in ["traits", "sex_traits", "professions", 'food_filter', 'slave_class']:
			if preservedsettings.has(i):
				character_to_save[i] = preservedsettings[i]
		else:
			character_to_save[i] = person.get_stat(i)
	character_to_save.type = str(mode)
	var file = File.new()
	file.open(variables.userfolder + 'savedcharacters/' + savefilename, file.WRITE)

	var text = JSON.print(character_to_save)
	file.store_string(text)
	file.close()
	input_handler.SystemMessage(tr("CHARCREATE_SYS_TEMPLATE_SAVED"))
	hideSaveLoadPanel()


func PressDeleteCharacter(savename):
	$SaveLoadCharPanel/LineEdit.text = savename
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'DeleteCharacter', tr("DELETETEMPLATECONFIRM")])

func PressLoadCharacter(savename = null):
	if savename == null:
		hideSaveLoadPanel()
	else:
		$SaveLoadCharPanel/LineEdit.text = savename
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'LoadCharacter', tr("LOADTEMPLATECONFIRM")])


func LoadCharacter(updated_char_to_load = null):
	var character_to_load
	if updated_char_to_load == null:
		var loadfilename = $SaveLoadCharPanel/LineEdit.text + ".ch"
		var file = File.new()
		file.open(variables.userfolder + "savedcharacters/" + loadfilename, file.READ)
		var text = file.get_as_text()
		var parse_result
		parse_result = JSON.parse(text)
		character_to_load = parse_result.result
	else:
		character_to_load = updated_char_to_load
	
	if character_to_load == null:
		return
	# Load availability checking
	if  character_to_load.type != mode:
		input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'hideSaveLoadPanel', tr("TEMPLATETYPENOTMATCH")])
		return
	if guild != "none":
		if character_to_load.has('professions') and character_to_load.professions != '' and !(character_to_load.professions in variables.get(guild + '_starting_classes')):
			input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'reset_profession', tr("RESETLOADCHARPROFESSION")])
			return
	
	preservedsettings.clear()
	for i in character_to_load:
		if !(i in params_to_save): 
			continue
		preservedsettings[i] = character_to_load[i]
	
	#setup rebuild
	if preservedsettings.has('race'):
		person.set_stat('race', preservedsettings.race)
	if preservedsettings.has('sex'):
		person.set_stat('sex', preservedsettings.sex)
	if preservedsettings.has('age'):
		person.set_stat('age', preservedsettings.age)
	
	rebuild_slave()
	build_food_filter()
	build_class()
	build_sex_trait()
	build_trait()
	
	hideSaveLoadPanel()
	input_handler.SystemMessage(tr("CHARCREATE_SYS_TEMPLATE_LOADED"))


func DeleteCharacter():
	var deletename = $SaveLoadCharPanel/LineEdit.text + ".ch"
	var dir = Directory.new()
	dir.remove(variables.userfolder + 'savedcharacters/' + deletename)
	input_handler.SystemMessage(tr("CHARCREATE_SYS_TEMPLATE_DELETED"))
	SaveLoadCharPanel(saveloadstate)



func RebuildStatsContainer(): #onready scheme build, not values
	input_handler.ClearContainer($StatsModule/StatsContainer, ['FactorRow'])
	input_handler.ClearContainer(visual_options, ['Button', 'Slider', 'Checkbox', 'SubmenuButton', 'Colour'])
	input_handler.ClearContainer(visual_submenu_rows, ['StatRow'])
	visual_stat_nodes.clear()
	visual_submenu_buttons.clear()
	visual_submenu_tiles.clear()
	visual_insert_index = 0
	# the order of the rows is the order of LAYOUT.FACTOR_ROWS, which is also
	# where their colour and picture come from
	for row in LAYOUT.FACTOR_ROWS:
		var newnode = input_handler.DuplicateContainerTemplate($StatsModule/StatsContainer, 'FactorRow')
		newnode.name = row.stat
		build_factor_row_look(newnode, row)

	# A colour with no owner (skin) gets its own row at the top.  All other
	# colours are inserted immediately after the option they paint.
	for colour in LAYOUT.COLOUR_FOLLOWS:
		if str(LAYOUT.COLOUR_FOLLOWS[colour]) == '' and colour in params_to_save:
			append_visual_colour_row(colour)

	for menu in LAYOUT.SUBMENUS:
		var menu_button = duplicate_visual_template('SubmenuButton')
		menu_button.name = 'submenu_' + str(menu.id)
		menu_button.text = tr(menu.label)
		menu_button.connect('pressed', self, 'open_visual_submenu_panel', [str(menu.id)])
		visual_submenu_buttons[str(menu.id)] = menu_button
		for stat in menu.stats:
			append_following_colour_rows(stat)

	for stat in params_to_save:
		if stat in ["name", "surname", "nickname", "sex", "age", "race", "traits", "sex_traits", "professions", "food_filter", "personality"]:
			continue
		if stat.ends_with('factor') or LAYOUT.COLOUR_FOLLOWS.has(stat) or LAYOUT.submenu_of(stat) != '':
			continue
		var template = 'Button'
		if stat in LAYOUT.SLIDERS:
			template = 'Slider'
		elif stat in LAYOUT.CHECKBOXES:
			template = 'Checkbox'
		var newnode = duplicate_visual_template(template)
		setup_visual_stat_node(newnode, stat, template)
		append_following_colour_rows(stat)


# The half of a factor row that is settled the moment it is built: its colour,
# its picture, its name, the hint under it and its row of empty pips.  The value,
# the lit pips and the arrows change as the player spends points and live in
# build_factor_row_value() instead.
func build_factor_row_look(node, row):
	var info = statdata.statdata[row.stat]
	var colour = Color(row.colour)

	# the plate is a dark panel bordered in the row's own colour.  duplicate()
	# hands every row the same stylebox resource, so it has to be copied before
	# it is painted or all seven rows end up the last colour written
	var plate = node.get_stylebox('panel').duplicate()
	plate.border_color = Color(colour.r, colour.g, colour.b, LAYOUT.FACTOR_BORDER_ALPHA)
	node.add_stylebox_override('panel', plate)

	# one shared white-to-nothing gradient, tinted per row rather than one
	# gradient resource per colour
	node.get_node('Grad').modulate = Color(colour.r, colour.g, colour.b, LAYOUT.FACTOR_WASH_ALPHA)

	# the medallion is already painted in the row's colour, so it is dropped in
	# as it is - modulating it would flatten the gold and the shading out of it
	node.get_node('Icon').texture = load(LAYOUT.FACTOR_ICON_DIR + row.stat + '.png')
	node.get_node('Abb').text = info.abb
	node.get_node('Abb').set('custom_colors/font_color', colour)
	node.get_node('Sub').text = tr(LAYOUT.factor_hint_key(row.stat))

	build_factor_pips(node.get_node('Pips'), colour)

	# The tooltip belongs to the reading half of the row - the medallion and the
	# two lines of text.  HoverZone is an invisible Control over exactly that, and
	# the plate itself ignores the mouse, so drifting across the pips or resting
	# on the arrows while spending points does not keep flinging the panel open.
	var text = info.descript
	if row.stat in ['physics_factor', 'wits_factor', 'charm_factor']:
		text += '\n\n' + statdata.statdata[row.stat.replace('_factor', '')].descript
	globals.connecttexttooltip(node.get_node('HoverZone'), text)


# One pip per point the factor can hold.  Each keeps its lit and unlit stylebox
# on itself, so changing the value later is a swap rather than a repaint.
func build_factor_pips(pips, colour):
	var template = pips.get_child(0)
	for k in range(variables.maximum_factor_value):
		var pip = template
		if k > 0:
			pip = template.duplicate()
			pips.add_child(pip)
		pip.name = 'Pip' + str(k)
		var lit = template.get_stylebox('panel').duplicate()
		lit.bg_color = colour
		lit.border_color = Color(1, 0.94, 0.86, 0.85)
		var unlit = template.get_stylebox('panel').duplicate()
		unlit.bg_color = Color(0.08, 0.04, 0.07, 0.85)
		unlit.border_color = Color(colour.r, colour.g, colour.b, LAYOUT.FACTOR_PIP_EMPTY_ALPHA)
		pip.set_meta('sb_lit', lit)
		pip.set_meta('sb_unlit', unlit)


# The changing half of a factor row: how much of the bar is lit and what the
# number beside it reads.
func build_factor_row_value(node, stat, val):
	var value = int(val)
	var pips = node.get_node('Pips')
	for k in range(pips.get_child_count()):
		var pip = pips.get_child(k)
		pip.add_stylebox_override('panel', pip.get_meta('sb_lit' if k < value else 'sb_unlit'))

	# a factor reads as a word wherever the player asked for words, and this
	# screen is no exception
	# freemode edits characters that already exist, and both the word and the
	# colour are only defined for 1..6 - a stat outside that range must not take
	# the panel down with it
	var step = int(clamp(value, variables.minimum_factor_value, variables.maximum_factor_value))
	var label = node.get_node('Value')
	if input_handler.globalsettings.factors_as_words:
		label.text = ResourceScripts.descriptions.factor_descripts[step]
	else:
		label.text = str(value)
	label.set('custom_colors/font_color', Color(variables.hexcolordict['factor' + str(step)]))

	set_factor_arrows(node, stat, unassigned_points())
	if !node.has_meta('signals_built'):
		node.get_node('LArr').connect('pressed', self, 'change_value_node', [stat, -1])
		node.get_node('RArr').connect('pressed', self, 'change_value_node', [stat, 1])
		node.set_meta('signals_built', true)
	node.set_meta('current_val', val)


# Which of a row's two arrows can still be pressed.  A full bar stops the plus
# arrow and so does an empty pool - the old panel only greyed it out for the
# first and let the player press the second into a silent refusal.
func set_factor_arrows(node, stat, spare):
	var vals = possible_vals.get(stat, [])
	var id = vals.find(person.get_stat(stat))
	var larr = node.get_node('LArr')
	var rarr = node.get_node('RArr')
	larr.visible = (mode != 'freemode')
	rarr.visible = (mode != 'freemode')
	larr.disabled = !(id > 0)
	rarr.disabled = !(id > -1 and id < vals.size() - 1) or spare < 1


# The pool is shared, so spending on one row can grey out the plus arrow on all
# the others.  Every row has to be re-judged whenever the pool moves, not just
# the row that was clicked.
func refresh_factor_arrows():
	var spare = unassigned_points()
	for row in LAYOUT.FACTOR_ROWS:
		var node = $StatsModule/StatsContainer.get_node_or_null(row.stat)
		if node != null and node.visible:
			set_factor_arrows(node, row.stat, spare)


# The panel is only as tall as it has rows.  A master spends points on five
# factors, not seven, and a box built for seven left the five floating in it with
# a hole underneath.  The food panel sits directly below and moves with it.
func fit_stats_panel():
	var shown = 0
	for row in LAYOUT.FACTOR_ROWS:
		var node = $StatsModule/StatsContainer.get_node_or_null(row.stat)
		if node != null and node.visible:
			shown += 1
	if shown == 0:
		return
	var height = LAYOUT.STATS_PANEL_CHROME + shown * LAYOUT.FACTOR_ROW_HEIGHT \
		+ (shown - 1) * LAYOUT.FACTOR_ROW_SEPARATION
	$StatsModule.margin_bottom = $StatsModule.margin_top + height
	# read the food panel's own height before moving it, so repeated calls do not
	# let it creep
	var diet_height = $DietPanel.margin_bottom - $DietPanel.margin_top
	$DietPanel.margin_top = $StatsModule.margin_bottom + LAYOUT.STATS_PANEL_GAP
	$DietPanel.margin_bottom = $DietPanel.margin_top + diet_height


func append_following_colour_rows(stat):
	for colour in colours_following(stat):
		append_visual_colour_row(colour)


func append_visual_colour_row(colour):
	var colour_node = duplicate_visual_template('Colour')
	setup_visual_stat_node(colour_node, colour, 'Colour')


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
		var tooltip = node.get_node('header/Tooltip')
		tooltip.visible = tooltips_stat.has(stat)
		if tooltip.visible:
			globals.connecttexttooltip(tooltip, tr("INFO" + stat.to_upper()))


func get_visual_submenu_data(menu_id):
	for menu in LAYOUT.SUBMENUS:
		if str(menu.id) == str(menu_id):
			return menu
	return {}


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
	for submenu_data in LAYOUT.SUBMENUS:
		for submenu_stat in submenu_data.stats:
			visual_stat_nodes.erase(submenu_stat)
	for stat in menu.stats:
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
		# the tile keeps its size either way - the label is anchored to its bottom
		# edge rather than stacked under the picture
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
		var selected = tile.get_meta('value') == person.get_stat(stat)
		tile.pressed = selected
		tile.get_node('Frame').visible = selected


func _on_visual_preview_ready(_group_id, _part_id, texture):
	for tile in visual_submenu_tiles:
		if !is_instance_valid(tile):
			continue
		var stat = tile.get_meta('stat')
		var value = tile.get_meta('value')
		if preview_booth.taken_for_stat(stat, value) == texture:
			tile.get_node('Preview').texture = texture


# The pictures in an open panel are of this character's head, so a change to the
# head - a hair colour, a chin, a race - leaves them showing somebody else.  The
# booth throws its own stale shots away; this is what asks it for new ones while
# the player is still looking at the panel.
func refresh_visual_submenu_previews():
	if open_visual_submenu == '' or person == null:
		return
	var menu = get_visual_submenu_data(open_visual_submenu)
	for stat in menu.get('stats', []):
		if possible_vals.has(stat) and possible_vals[stat].size() > 0:
			preview_booth.request_for_stat(person, stat, possible_vals[stat])


func _close_visual_submenu():
	visual_submenu.hide()
	open_visual_submenu = ''



func FillStats():
#	build_possible_vals()
	for stat in params_to_save:
		if stat in ["race", "traits", "sex_traits", "professions", 'food_filter']:
			continue
		if stat == 'personality':
			continue
		if LAYOUT.COLOUR_FOLLOWS.has(stat):
			build_selectable_node(stat)
		build_node_for_stat(stat)
#	build_class()
	build_description()
	build_race()
	build_personality()
	build_master_relation()
	update_points()
	build_upgrades()
	# every row's visibility has just been decided, so the panel can be cut to fit
	fit_stats_panel()
#	build_food_filter()



func open_sex_traits():
	hide_all_dialogues()
	TraitSelection.build_sex()


func open_traits():
	hide_all_dialogues()
	TraitSelection.build_trait()


func open_personality_selection():
	hide_all_dialogues()
	TraitSelection.build_personality()


func open_master_relation_selection():
	if !is_master_relation_panel_available():
		return
	hide_all_dialogues()
	build_master_relation_selection()


func select_sex_trait(trait_id):
	preservedsettings["sex_traits"] = trait_id
	$TraitSelection.hide()
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
#	RebuildStatsContainer()
	build_sex_trait()


func select_trait(trait_id):
	preservedsettings["traits"] = trait_id
	$TraitSelection.hide()
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
#	RebuildStatsContainer()
	build_trait()


func select_personality(code):
	preservedsettings['personality'] = code
	person.set_stat('personality', code)
	TraitSelection.hide()
	build_personality()
	build_description()
	update_points()


func get_master_relation_options():
	return ['none', 'child', 'parent', 'sibling']


func get_master_relation_display(code):
	match str(code):
		'none':
			return tr("NONE")
		'child':
			return tr("CHARCREATE_MASTER_RELATION_CHILD")
		'parent':
			return tr("CHARCREATE_MASTER_RELATION_PARENT")
		'sibling':
			return tr("CHARCREATE_MASTER_RELATION_SIBLING")
	return str(code)


func get_master_relation_target():
	if ResourceScripts.game_party == null:
		return null
	return ResourceScripts.game_party.get_master()


func get_master_relation_block_reason(code):
	if code == 'none':
		return ""
	var master_char = get_master_relation_target()
	if master_char == null:
		return tr("CHARCREATE_MASTER_RELATION_BLOCKED_NO_MASTER")
	var self_age = age_order.find(person.get_stat('age'))
	var master_age = age_order.find(master_char.get_stat('age'))
	if self_age == -1 or master_age == -1:
		return ""
	match code:
		'child':
			if master_age < self_age:
				return tr("CHARCREATE_MASTER_RELATION_BLOCKED_CHILD")
		'parent':
			if master_age > self_age:
				return tr("CHARCREATE_MASTER_RELATION_BLOCKED_PARENT")
	return ""


func is_master_relation_available(code):
	return get_master_relation_block_reason(code) == ""


func hide_relationship_selection():
	RelationshipSelect.hide()


func is_master_relation_panel_available():
	# the button used to hang off the stats tab and had to hide with it.  It sits
	# in the left column now, which stands on both tabs, so only the mode decides
	return mode != 'master' and mode != 'freemode'


func build_master_relation_selection():
	if !is_master_relation_panel_available():
		RelationshipSelect.hide()
		return
	input_handler.ClearContainer($RelationshipSelect/ScrollContainer/VBoxContainer, ['Button'])
	for code in get_master_relation_options():
		var newbutton = input_handler.DuplicateContainerTemplate($RelationshipSelect/ScrollContainer/VBoxContainer)
		newbutton.text = get_master_relation_display(code)
		newbutton.pressed = selected_master_relation == code
		var lock_reason = get_master_relation_block_reason(code)
		if lock_reason != "":
			newbutton.disabled = true
			globals.connecttexttooltip(newbutton, lock_reason)
		else:
			newbutton.connect("pressed", self, "select_master_relation", [code])
	RelationshipSelect.show()


func select_master_relation(code):
	selected_master_relation = code
	hide_relationship_selection()
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
	build_master_relation()


func build_master_relation():
	var button = $VBoxContainer/master_relation
	var is_visible = is_master_relation_panel_available()
	button.visible = is_visible
	if !is_visible:
		RelationshipSelect.hide()
		return
	if !is_master_relation_available(selected_master_relation):
		selected_master_relation = 'none'
	var master_char = get_master_relation_target()
	# a bare "None" would say nothing in a column of buttons that each name the
	# thing they choose, so the button names the choice as well as its value
	button.get_node('Label').text = tr("CHARCREATE_MASTER_RELATION_BUTTON") % get_master_relation_display(selected_master_relation)
	button.disabled = (master_char == null)
	# the sentence the old panel printed under itself has nowhere to stand in a row
	# of buttons, so it joins the tooltip.  That tooltip opens to the right: the
	# button sits against the left edge of the screen and would otherwise open off it
	var tooltip = tr("CHARCREATE_MASTER_RELATION_TOOLTIP")
	if master_char == null:
		tooltip += "\n\n" + tr("CHARCREATE_MASTER_RELATION_NO_MASTER")
	else:
		tooltip += "\n\n" + tr("CHARCREATE_MASTER_RELATION_PANEL_TEXT") % [person.get_short_name(), tr("MASTER"), master_char.get_short_name()]
	globals.connecttexttooltip(button, tooltip, true)


func apply_master_relationship():
	if mode == 'master' or selected_master_relation == 'none':
		return
	var master_char = get_master_relation_target()
	if master_char == null:
		return
	person.make_relative_of(master_char, selected_master_relation, false, false)


func build_trait():
	if preservedsettings.has("traits") && preservedsettings.traits != null:
		var trdata = Traitdata.traits[preservedsettings.traits]
		$VBoxContainer/trait/Label.text = tr(trdata.name)
		if trdata.has('icon') and trdata.icon != null:
			if trdata.icon is String:
				$VBoxContainer/trait/icon.texture = load(trdata.icon)
			else:
				$VBoxContainer/trait/icon.texture = trdata.icon
			if trdata.tags.has('simple_icon'):
				$VBoxContainer/trait/bg.texture = null
			else:
				if trdata.tags.has('positive'):
					$VBoxContainer/trait/bg.texture = load("res://assets/images/iconstraits/green.png")
				elif trdata.tags.has('negative'):
					$VBoxContainer/trait/bg.texture = load("res://assets/images/iconstraits/red.png")
				else:
					$VBoxContainer/trait/bg.texture = load("res://assets/images/iconstraits/grey.png")
		else:
			$VBoxContainer/trait/bg.texture = null
			$VBoxContainer/trait/icon.texture = null
	else:
		$VBoxContainer/trait/bg.texture = null
		$VBoxContainer/trait/icon.texture = null
		$VBoxContainer/trait/Label.text = tr("TRAITS")
	$VBoxContainer/trait.disabled = (mode == 'freemode')


func build_sex_trait():
	if preservedsettings.has("sex_traits") && preservedsettings.sex_traits != null:
		var trdata = Traitdata.sex_traits[preservedsettings.sex_traits]
		$VBoxContainer/sextrait/Label.text = tr(trdata.name)
	else:
		$VBoxContainer/sextrait/Label.text = tr("STATSEXTRAIT")
	$VBoxContainer/sextrait.disabled = (mode == 'freemode')


func build_personality():
	var personality = person.get_stat('personality')
	var has_selection = personality != null and personality != '' and personality != 'neutral'
	if has_selection:
		$VBoxContainer/personality/Label.text = tr("PERSONALITYNAME" + personality.to_upper())
		if personality_icons.has(personality):
			$VBoxContainer/personality/icon.texture = personality_icons[personality]
		else:
			$VBoxContainer/personality/icon.texture = null
	else:
		$VBoxContainer/personality/Label.text = tr("STATPERSONALITY")
		$VBoxContainer/personality/icon.texture = null
	$VBoxContainer/personality.disabled = (mode == 'freemode')


func build_race():
#	if preservedsettings.has("race") && preservedsettings.race != null:
#		var rdata = races.racelist[preservedsettings.race]
#		$VBoxContainer/race/Label.text = tr(rdata.name)
#		if rdata.icon is String:
#			$VBoxContainer/race/icon.texture = load(rdata.icon)
#		else:
#			$VBoxContainer/race/icon.texture = rdata.icon
#	else:
#		if !preservedsettings.empty():
#			print('warn - race selection not valid')
#		$VBoxContainer/race/Label.text = "Race"
#		$VBoxContainer/race/icon.texture = null
	var rdata = races.racelist[person.get_stat('race')]
	$VBoxContainer/race/Label.text = tr(rdata.name)
	if rdata.icon is String:
		$VBoxContainer/race/icon.texture = load(rdata.icon)
	else:
		$VBoxContainer/race/icon.texture = rdata.icon
	$VBoxContainer/race.disabled = (mode == 'freemode')
	$RaceReroll.disabled = (mode == 'freemode')


func check_class_possibility():
	if selected_class == "":
		return false
	var data = classesdata.professions[selected_class]
	return person.checkreqs(data.reqs)


func build_class():
	if preservedsettings.has('professions'):
		var trdata = classesdata.professions[preservedsettings.professions]
		if person.checkreqs(trdata.reqs):
			selected_class = preservedsettings.professions
		else: selected_class = ""
	if !check_class_possibility():
		selected_class = ""
	if selected_class != "":
		var trdata = classesdata.professions[selected_class]
		$VBoxContainer/class/Label.text = tr(trdata.name)
		if trdata.has('icon') and trdata.icon != null:
			if trdata.icon is String:
				$VBoxContainer/class/icon.texture = load(trdata.icon)
			else:
				$VBoxContainer/class/icon.texture = trdata.icon
		else:
			$VBoxContainer/class/icon.texture = null
	else:
		$VBoxContainer/class/icon.texture = null
		$VBoxContainer/class/Label.text = tr("CLASS_LABEL")
	$VBoxContainer/class.disabled = (mode == 'freemode')


func build_description():
	$VisualsModule/Desc.bbcode_text = ResourceScripts.descriptions.trim_tag(person.make_description(), 'url', 'hair')


func confirm_return():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'cancel_creation', tr("RETURNTOMAINMENUQUESTION")])
	#input_handler.ShowConfirmPanel(self, "cancel_creation", "Return to Main Menu?")


#func test():
##	print("Preserved Settings:", preservedsettings)
##	print(person.get_stat("sex"))
##	print(person.get_stat("age"))
##	print(person.get_stat("race"))
##	print(person.get_full_name())


func hide_all_dialogues():
	$SaveLoadCharPanel.hide()
	RaceSelection.hide()
	TraitSelection.hide()
	ClassSelection.hide()
	RelationshipSelect.hide()

var upgradecost = 0
var upgradecostgold = 0
var cur_upgrades = []
var upgrades_removal = false

func init_upgrades():
	upgradecost = 0
	upgradecostgold = 0
	cur_upgrades = person.get_body_upgrades()


func build_upgrades(): #check confirmation at the same time
	var res = true
	upgradecost = 0
	upgradecostgold = 0
	input_handler.ClearContainer($UpgradesPanel/scroll/VBoxContainer, ['Button'])
	for upg in Traitdata.body_upgrades:
		var upgdata = Traitdata.body_upgrades[upg]
		var newnode = input_handler.DuplicateContainerTemplate($UpgradesPanel/scroll/VBoxContainer, 'Button')
		
		var text = person.translate(tr(upgdata.descript)) + "\nPrice: " + str(upgdata.goldcost) + "\nUpgrade Points: " + str(upgdata.cost) 
		globals.connecttexttooltip(newnode, text)
		newnode.get_node('UpgradeName').text = tr(upgdata.name)
		if upgdata.icon is String:
			newnode.get_node('icon').texture = load(upgdata.icon)
		else:
			newnode.get_node('icon').texture = upgdata.icon
		if cur_upgrades.has(upg):
			if person.get_body_upgrades().has(upg):
				if upgrades_removal:
					newnode.connect('pressed', self, 'toggle_upgrade', [upg])
				else:
					newnode.connect('pressed', self, 'build_upgrades')
			else:
				upgradecost += upgdata.cost
				upgradecostgold += upgdata.goldcost
				newnode.connect('pressed', self, 'toggle_upgrade', [upg])
			newnode.pressed = true
			if person.checkreqs(upgdata.reqs):
				newnode.get_node('UpgradeName').set("custom_colors/font_color", Color(variables.hexcolordict.k_yellow))
			else:
				newnode.get_node('UpgradeName').set("custom_colors/font_color", Color(variables.hexcolordict.k_red))
				newnode.get_node('UpgradeName').text += ' !'
				res = false
		else:
			newnode.pressed = false
			newnode.connect('pressed', self, 'toggle_upgrade', [upg])
			if person.has_body_upgrade(upg): 
				upgradecost -= upgdata.cost
			if !person.checkreqs(upgdata.reqs):
				newnode.disabled = true
	$UpgradesPanel/HBoxContainer/Label2.text = "%d/%d" % [upgradecost, person.get_upgrade_points()]
	$UpgradesPanel/HBoxContainer2/Label2.text = "%d/%d" % [upgradecostgold, ResourceScripts.game_res.money]
	return res


func toggle_upgrade(upg):
	if cur_upgrades.has(upg):
		cur_upgrades.erase(upg)
	else:
		cur_upgrades.push_back(upg)
	build_upgrades()


func check_upgrades():
	if upgradecost > person.get_upgrade_points():
		input_handler.SystemMessage(tr("CHARCREATE_SYS_TOO_MANY_UPGRADES"))
		return false
	if upgradecostgold > ResourceScripts.game_res.money:
		input_handler.SystemMessage(tr("CHARCREATE_SYS_NOT_ENOUGH_MONEY"))
		return false
	return true
