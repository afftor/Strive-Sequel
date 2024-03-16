extends Panel

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

var slave_classes = ['slave','servant']

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
	'hair_fringe', 
	'hair_assist', 
	'hair_back', 
#	'body_color_skin', 
#	'hair_back_color_1',
#	'hair_back_color_2',
#	'hair_assist_color_1',
#	'hair_assist_color_2',
#	'hair_base_color_1',
#	'hair_base_color_2',
#	'hair_base_lenght', 
#	'hair_fringe_lenght', 
#	'hair_back_lenght' , 
#	'hair_assist_lenght' , 
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
	"timid_factor",
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

var introduction_text = {master = "Create your Master Character", 'slave' : 'Create your Starting Slave', freemode = ""}

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
	"food_filter",
	"physics_factor",
	"magic_factor",
	"tame_factor",
	"timid_factor",
#	"growth_factor", idk why
	"charm_factor",
	"wits_factor",
	"sexuals_factor",
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
	'body_color_wings', 
	'body_color_tail', 
	'body_color_horns', 
	'body_color_animal', 
	'hair_base', 
	'hair_base_lenght', 
	'hair_fringe',
	'hair_fringe_lenght',  
	'hair_assist', 
	'hair_assist_lenght' , 
	'hair_back',
	'hair_back_lenght' ,  
	'hair_back_color_1',
	'hair_back_color_2',
	'hair_assist_color_1',
	'hair_assist_color_2',
	'hair_base_color_1',
	'hair_base_color_2',
	'beard',
	'hair_facial_color'
]

var tooltips_stat = ['personality','slave_class']

onready var RaceSelection = $RaceSelectionModule
onready var ClassSelection = $ClassSelectionModule
onready var TraitSelection = $TraitSelection
onready var ragdoll = $RagdollPanel/ragdoll

var possible_vals = {}


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
	
	$modes/Stats.connect("pressed", self, 'build_stats')
	$modes/Visuals.connect("pressed", self, 'build_visuals')
	
	$UpgradesPanel.visible = false
	$VBoxContainer.visible = true
	
	$ConfirmButton.connect("pressed", self, 'confirm_character')
	#$CancelButton.connect("pressed", self, "confirm_return")
	globals.connecttexttooltip($VBoxContainer/sextrait, tr("TOOLTIPSEXTRAITS"))
	
	for i in ['name','surname','nickname']:
		$VBoxContainer.get_node(i).connect("text_changed", self, 'text_changed', [i])
	
	$VBoxContainer/class.connect("pressed", ClassSelection, "open_class_list")
	$BackButton.connect("pressed", self, "Exit")
	$BackButtonCheats.connect("pressed", self, "hide")
	if testmode:
		open()


func build_stats():
	$modes/Stats.pressed = true
	$modes/Visuals.pressed = false
	
	$StatsModule.visible = true
	$DietPanel.visible = true
	$VisualsModule.visible = false
	if mode != 'freemode':
		$UpgradesPanel.visible = false
		$VBoxContainer.visible = true


func build_visuals():
	$modes/Stats.pressed = false
	$modes/Visuals.pressed = true
	
	$StatsModule.visible = false
	$DietPanel.visible = false
	$VisualsModule.visible = true
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


func build_possible_val_for_stat(stat):
	if person.is_unique():
		possible_vals[stat] = []
		return
	if stat.ends_with('factor'):
		possible_vals[stat] = [1, 2, 3, 4, 5, 6]
		if stat in ['timid_factor','tame_factor'] and mode == 'master':
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
		possible_vals.personality = variables.personality_array.duplicate()
		possible_vals.personality.erase('neutral')
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
	var par_node = $VisualsModule/ScrollContainer/VBoxContainer/StatsContainer
	if stat in ['sex', 'age']:
		par_node = $VBoxContainer/HBoxContainer
	if stat in [ "name", "surname", "nickname"]:
		par_node = $VBoxContainer
	if stat.ends_with('_factor'):
		par_node = $StatsModule/StatsContainer
	if stat.begins_with('food_filter_'):
		par_node = $DietPanel/VBoxContainer
		stat = stat.trim_prefix('food_filter_')
	if stat.find('color') != -1:
		par_node = $VisualsModule/ScrollContainer/VBoxContainer/StatsContainer2
	#incomplete ?
	
	return par_node.get_node(stat)


func build_selectable_node(stat):
	if stat.find('color') == -1:
		print('stat node not selectable - %s' % stat)
		return
	var node = find_node_for_stat(stat)
	if possible_vals[stat].empty():
		node.visible = false
		return
	node.visible = true
	input_handler.ClearContainer(node.get_node('GridContainer'), ['Button', 'Button2'])
	var template = 'Button2'
	if stat == 'body_color_skin':
		template = 'Button'
	for val in possible_vals[stat]:
		if !GeneratorData.transforms[stat].has(val):
			continue
		var newbutton = input_handler.DuplicateContainerTemplate(node.get_node('GridContainer'), template)
		newbutton.get_node('ColorRect').material = newbutton.get_node('ColorRect').material.duplicate()
		newbutton.set_meta('value', val)
		var transform_data = GeneratorData.transforms[stat][val]
		newbutton.connect('pressed', self, 'change_value_node_selectable', [stat, val])
		for transform in transform_data:
			if !(transform.type in ['import_recolor', 'import_recolor_group']):
				continue
			var sh = load(transform.material)
			newbutton.get_node('ColorRect').material.set_shader_param('target1color', sh.get_shader_param('target2color'))
			newbutton.get_node('ColorRect').material.set_shader_param('part1color', sh.get_shader_param('part2color'))
			break


func build_node_for_stat(stat):
	var val = person.get_stat(stat)
	if preservedsettings.has(stat) and preservedsettings[stat] != val:
		if if_can_assign(stat, preservedsettings[stat]):
			val = preservedsettings[stat]
			person.set_stat(stat, val)
	
	var node = find_node_for_stat(stat)
	
	if stat in ['food_like', 'food_hate']:
		pass
		return
	
	if stat == 'food_filter':
		build_food_filter()
		return
	
	if stat in ["name", "surname", "nickname"]:
		node.text = val
		return
	
	node.visible = possible_vals[stat].size() > 1
	
	if stat.find('color') != -1:
		for nd in node.get_node('GridContainer').get_children():
			if nd.has_meta('value') and nd.get_meta('value') == val:
				nd.pressed = true
			else:
				nd.pressed = false
		return
	
	if stat in freemode_fixed_stats and mode == 'freemode':
#		if stat.ends_with('factor'):
#			node.get_node('button/LArr').visible = false
#			node.get_node('button/RArr').visible = false
#		else:
		if !stat.ends_with('factor'):
			node.visible = false
#		node.get_node('button/LArr').visible = (mode != 'freemode')
#		node.get_node('button/RArr').visible = (mode != 'freemode')
	
	if stat in ['sex', ]:
		var id = possible_vals[stat].find(val)
		node.get_node('button/LArr').visible = (id > 0)
		node.get_node('button/RArr').visible = (id < possible_vals[stat].size() - 1)
	
	if stat in ["physics_factor", "magic_factor", "tame_factor", "timid_factor", "charm_factor", "wits_factor", "sexuals_factor"]:
		var id = possible_vals[stat].find(val)
		node.get_node('button/LArr').disabled = !(id > 0)
		node.get_node('button/RArr').disabled = !(id < possible_vals[stat].size() - 1)
		node.get_node('button/LArr').visible = (mode != 'freemode')
		node.get_node('button/RArr').visible = (mode != 'freemode')
	
	var text = ''
	if ResourceScripts.descriptions.bodypartsdata.has(stat):
		if ResourceScripts.descriptions.bodypartsdata[stat].has(val):
			text = tr(ResourceScripts.descriptions.bodypartsdata[stat][val].name)
		else:
#			print ("warning - no description record for %s - %s" % [str(stat), str(val)])
			text = str(val)
	else:
#		print ("warning - no description record for %s" % str(stat))
		text = str(val)
	node.get_node('button/Label').text = text
	#set nodes
	if !node.has_meta('signals_built'):
		node.get_node('button/LArr').connect('pressed', self, 'change_value_node', [stat, -1])
		node.get_node('button/RArr').connect('pressed', self, 'change_value_node', [stat, 1])
		if node.get_node('button') is TextureButton:
			node.get_node('button').connect('pressed', self, 'change_value_node', [stat, 1])
		node.set_meta('signals_built', true)
	node.set_meta('current_val', val)
	node.get_node('button/Label').text = text


func rebuild_ragdoll(stat = null):
	var stored_image = person.get_stored_body_image()
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


func change_value_node(stat, value): #for scrollable nodes
	if !possible_vals.has(stat):
		print('error - no stat %s' % stat)
		return
	var id = find_stat_value_id(stat, person.get_stat(stat)) 
	if stat.ends_with('factor'):
		if unassigned_points() < value:
			return
	
	id += value
	if id < 0:
		id = possible_vals[stat].size() - 1
	if id >= possible_vals[stat].size():
		id = 0
	var newval = possible_vals[stat][id]
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
	build_description()
	build_upgrades()


func change_value_node_selectable(stat, newvalue): #for selectable nodes
	if !possible_vals.has(stat):
		print('error - no stat %s' % stat)
		return
	person.set_stat(stat, newvalue)
	preservedsettings[stat] = newvalue
	rebuild_ragdoll(stat)
	build_node_for_stat(stat)
	build_description()
	build_upgrades()


func unassigned_points():
	var points
	if mode == 'freemode':
		return 0
	if mode == 'master':
		points = variables.master_starting_stats + 5
		for st in ['physics_factor','wits_factor','charm_factor','sexuals_factor', "magic_factor"]:
			points -= int(person.get_stat(st))
	
	else:
		points = variables.slave_starting_stats + 7
		for st in ['physics_factor','wits_factor','charm_factor','sexuals_factor', 'tame_factor', 'timid_factor', "magic_factor"]:
			points -= int(person.get_stat(st))
	return points


func update_points(): #visual only
	if unassigned_points() < 0: 
		reset_points()
		$ClassSelectionModule.update_class_buttons()
		FillStats()
		build_class()
	
	$StatsModule/totalstatlabel.text = "Unassigned stats: %d" % unassigned_points()
	$StatsModule/totalstatlabel.visible = (mode != 'freemode')


func reset_points():
	for st in ['physics_factor','wits_factor','charm_factor','sexuals_factor', 'tame_factor', 'timid_factor', 'magic_factor']:
		person.set_stat(st, 1)
		preservedsettings.erase(st)


#food_filter
var foods = ['meat', 'fish', 'vege', 'grain']
var food_vals = ['like', 'neutral', 'hate']

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
	if reverse_filter.hate.size() < 1:
		return false
	return true


func build_food_filter():
	var val = {}
	if mode == 'freemode':
		preservedsettings.food_filter = {}
		for food in foods:
			val[food] = 'neutral'
			preservedsettings.food_filter[food] = 'neutral'
		val[person.food.food_love] = 'like'
		preservedsettings.food_filter[person.food.food_love] = 'like'
		for food in person.food.food_hate:
			val[food] = 'hate'
			preservedsettings.food_filter[food] = 'hate'
	else: #read from preservedsettings
		for food in foods:
			val[food] = 'neutral'
			if preservedsettings.has('food_filter') and preservedsettings.food_filter.has(food):
				val[food] = preservedsettings.food_filter[food]
	
	for food in foods:
		var node = find_node_for_stat('food_filter_' + food)
		if !node.has_meta('signals_built'):
			node.get_node('button/LArr').connect('pressed', self, 'change_food_filter_value', [food, -1])
			node.get_node('button/RArr').connect('pressed', self, 'change_food_filter_value', [food, 1])
			node.get_node('button').connect('pressed', self, 'change_food_filter_value', [food, 1])
			node.set_meta('signals_built', true)
		
		node.get_node('button/LArr').visible = (mode != 'freemode')
		node.get_node('button/RArr').visible = (mode != 'freemode')
		
		node.get_node('button/Label').text = val[food]
	


func apply_food_filter():
	if !check_food_filter():
		return
	person.food.food_hate = reverse_filter.hate.duplicate()
	person.food.food_love = reverse_filter.like[0]


func change_food_filter_value(food, value):
	if !foods.has(food):
		print ('error - unknown food %s' % food)
		return
	var id
	if !preservedsettings.has('food_filter'):
		preservedsettings.food_filter = {}
		id = 1 #food_vals.find('neutral')
	elif preservedsettings.food_filter.has(food):
		id = food_vals.find(preservedsettings.food_filter[food])
	else:
		id = 1 #food_vals.find('neutral')
	
	id += value
	if id < 0:
		id = 2
	if id >= 3:
		id = 0
	
	preservedsettings.food_filter[food] = food_vals[id]
	build_food_filter()


func Exit():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'MainMenu', tr('LEAVECONFIRM')])


func MainMenu():
	globals.return_to_main_menu()


#
func open(type = 'slave', newguild = 'none', is_from_cheats = false):
	preservedsettings.clear()
	selected_class = ''
#	build_class()
#	build_race()
#	build_sex_trait()
#	build_trait()
	show()
	guild = newguild
#	$CancelButton.visible = input_handler.CurrentScreen == 'mansion'
	$introduction.bbcode_text = introduction_text[type]
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
	build_food_filter()
	rebuild_slave()
	build_stats()


func open_freemode(char_to_open):
	person = char_to_open
	preservedsettings.clear()
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



func rebuild_slave():
	if mode == 'freemode':
		print('error - invalid recreation')
		return
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
	
	build_possible_vals()
	for stat in ["physics_factor", "magic_factor", "tame_factor", "timid_factor", "charm_factor", "wits_factor", "sexuals_factor"]:
		person.set_stat(stat, 1)
	apply_preserved_settings()
	FillStats()
	build_class()
	build_sex_trait()
	build_trait()


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
				preservedsettings.slave_class = 'slave1'
			person.set_slave_category(preservedsettings.slave_class.to_lower())
			#basic slave setup
			person.set_stat('obedience', 48)
			if guild == 'fighters':
				person.add_trait('loyalty_combatant')
			if guild in ['servants', 'workers']:
				person.add_trait('loyalty_dress_work')
		else:
			person.set_slave_category('master')
			person.set_stat('consent', 1000)
			globals.equip_char(person, 'chest_base_cloth', {ArmorBaseCloth = 'cloth', ArmorTrim = 'wood'})
			globals.equip_char(person, 'legs_base_cloth', {ArmorBaseCloth = 'cloth', ArmorTrim = 'wood'})
		ResourceScripts.game_party.add_slave(person)
		
		input_handler.emit_signal("CharacterCreated")
		input_handler.add_random_chat_message(person, 'hire')
	else:
		ResourceScripts.game_res.money -= upgradecostgold
#		person.statlist.body_upgrades = cur_upgrades.duplicate()
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
			input_handler.SystemMessage("You must select one liked and at least one hated food type.")
			return false
		
		if !check_class_possibility():
			input_handler.SystemMessage("You must select a correct starting Class")
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
		$SaveLoadCharPanel/SaveLoadButton.text = "Save"
	else:
		$SaveLoadCharPanel/SaveLoadButton.text = "Load"
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
	input_handler.SystemMessage("Character Template Saved")
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
	
	# Load availability checking
	if character_to_load != null && character_to_load.type != mode:
		input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'hideSaveLoadPanel', tr("TEMPLATETYPENOTMATCH")])
		return
	if guild != "none":
		if character_to_load != null && character_to_load.professions != '' && !character_to_load.professions in variables.get(guild+'_starting_classes'):
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
	input_handler.SystemMessage("Character Template Loaded")


func DeleteCharacter():
	var deletename = $SaveLoadCharPanel/LineEdit.text + ".ch"
	var dir = Directory.new()
	dir.remove(variables.userfolder + 'savedcharacters/' + deletename)
	input_handler.SystemMessage("Character Deleted")
	SaveLoadCharPanel(saveloadstate)



func RebuildStatsContainer(): #onready scheme build, not values
	input_handler.ClearContainer($StatsModule/StatsContainer)
	input_handler.ClearContainer($VisualsModule/ScrollContainer/VBoxContainer/StatsContainer)
	input_handler.ClearContainer($VisualsModule/ScrollContainer/VBoxContainer/StatsContainer2)
	for stat in params_to_save:
		if stat in ["name", "surname", "nickname", "sex", "age", "race", "traits", "sex_traits", "professions", "food_filter"]:
			continue
		if stat.ends_with('factor'):
			var i = statdata.statdata[stat]
			var newnode = input_handler.DuplicateContainerTemplate($StatsModule/StatsContainer)
			if i.baseicon is String:
				newnode.get_node("icon").texture = load(images.icons[i.baseicon])
			else:
				newnode.get_node("icon").texture = i.baseicon
			newnode.name = i.code
			var text = i.descript
			if i.code in ['physics_factor','wits_factor','charm_factor','sexuals_factor']:
				text += '\n\n' + statdata.statdata[i.code.replace('_factor', '')].descript
			globals.connecttexttooltip(newnode.get_node("icon"), text)
		elif stat.find('color') != -1: #create selectable, not build it
			var newnode = input_handler.DuplicateContainerTemplate($VisualsModule/ScrollContainer/VBoxContainer/StatsContainer2)
			newnode.name = stat
			var text = ''
			if statdata.statdata.has(stat):
				text = tr(statdata.statdata[stat].name)
			else:
				text = stat.replace('_', ' ')
			newnode.get_node('header/Label').text = text
			newnode.get_node('header/Tooltip').visible = tooltips_stat.has(stat)
			globals.connecttexttooltip(newnode.get_node('header/Tooltip'), tr("INFO" + stat.to_upper()))
		else:
			var newnode = input_handler.DuplicateContainerTemplate($VisualsModule/ScrollContainer/VBoxContainer/StatsContainer)
			newnode.name = stat
			var text = ''
			if statdata.statdata.has(stat):
				text = tr(statdata.statdata[stat].name)
			else:
				text = stat.replace('_', ' ')
			newnode.get_node('header/Label').text = text
			newnode.get_node('header/Tooltip').visible = tooltips_stat.has(stat)
			globals.connecttexttooltip(newnode.get_node('header/Tooltip'), tr("INFO" + stat.to_upper()))


func FillStats():
#	build_possible_vals()
	for stat in params_to_save:
		if stat in ["race", "traits", "sex_traits", "professions", 'food_filter']:
			continue
		if stat.find('color') != -1:
			build_selectable_node(stat)
		build_node_for_stat(stat)
#	build_class()
	build_description()
	build_race()
	update_points()
	build_upgrades()
#	build_food_filter()



func open_sex_traits():
	hide_all_dialogues()
	TraitSelection.build_sex()


func open_traits():
	hide_all_dialogues()
	TraitSelection.build_trait()


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
		$VBoxContainer/trait/Label.text = "Trait"
	$VBoxContainer/trait.disabled = (mode == 'freemode')


func build_sex_trait():
	if preservedsettings.has("sex_traits") && preservedsettings.sex_traits != null:
		var trdata = Traitdata.sex_traits[preservedsettings.sex_traits]
		$VBoxContainer/sextrait/Label.text = tr(trdata.name)
	else:
		$VBoxContainer/sextrait/Label.text = "Sex Trait"
	$VBoxContainer/sextrait.disabled = (mode == 'freemode')


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
		$VBoxContainer/class/Label.text = "Class"
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
#	print("Sex Traits:", person.statlist.sex_traits)


func hide_all_dialogues():
	$SaveLoadCharPanel.hide()
	RaceSelection.hide()
	TraitSelection.hide()
	ClassSelection.hide()

var upgradecost = 0
var upgradecostgold = 0
var cur_upgrades = []

func init_upgrades():
	upgradecost = 0
	upgradecostgold = 0
	cur_upgrades = person.statlist.body_upgrades.duplicate()


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
		newnode.connect('pressed', self, 'toggle_upgrade', [upg])
		if upgdata.icon is String:
			newnode.get_node('icon').texture = load(upgdata.icon)
		else:
			newnode.get_node('icon').texture = upgdata.icon
		if cur_upgrades.has(upg):
			if !person.statlist.body_upgrades.has(upg):
				upgradecost += upgdata.cost
				upgradecostgold += upgdata.goldcost
			newnode.pressed = true
			if person.checkreqs(upgdata.reqs):
				newnode.get_node('UpgradeName').set("custom_colors/font_color", Color(variables.hexcolordict.k_yellow))
			else:
				newnode.get_node('UpgradeName').set("custom_colors/font_color", Color(variables.hexcolordict.k_red))
				newnode.get_node('UpgradeName').text += ' !'
				res = false
		else:
			newnode.pressed = false
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
		input_handler.SystemMessage("Too much upgrades for this character")
		return false
	if upgradecostgold > ResourceScripts.game_res.money:
		input_handler.SystemMessage("Not enough money")
		return false
	return true
