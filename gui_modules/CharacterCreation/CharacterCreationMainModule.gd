extends Panel

var person
var mode
var total_stat_points
var unassigned_points

var preservedsettings = {}
var valid_preservedsettings = {}

var agearray = ['teen','adult','mature']
var sexarray = ['male','female','futa']
var malesizes = ['masculine','flat']
var sizes = ['flat','small','average','big','huge']
var short_sizes = ['small','average','big']
var guild = 'none'

var bodypartsarray = ['skin', 'hair_length', 'hair_color', 'eye_color', 'eye_shape', 'ears', 'horns', 'tail', 'wings', 'height']
var sexbodypartsarray = ['slave_class','penis_size', 'penis_type', 'balls_size','tits_size', 'ass_size']

var slave_classes = ['slave','servant']
var selected_class = ''

var introduction_text = {master = "Create your Master Character", 'slave' : 'Create your Starting Slave'}

var savefilename
var saveloadstate

var params_to_save = [
	"slave_class",
	"name",
	"surname",
	"nickname",
	"sex",
	"age",
	"race",
	"sex_traits",
	"personality",
	"skin",
	"height",
	"hair_length",
	"hair_color",
	"hair_style",
	"ears",
	"eye_color",
	"eye_shape",
	"horns",
	"wings",
	"tail",
	"arms",
	"legs",
	"lower_body",
	"body_shape",
	"penis_size",
	"penis_type",
	"balls_size",
	"tits_size",
#	"vagina",
	"ass_size",
#	"has_pussy",
	"multiple_tits",
	"multiple_tits_developed",
#	"has_womb",
	"penis_virgin",
	"vaginal_virgin",
	"anal_virgin",
	"mouth_virgin",
	"masternoun",
#	"food_filter",
	"food_hate",
	"food_love",
	"physics_factor",
	"magic_factor",
	"tame_factor",
	"timid_factor",
	"growth_factor",
	"charm_factor",
	"wits_factor",
	"sexuals_factor",
	"professions",
	"type"
]

onready var RaceSelection = $RaceSelectionModule
onready var ClassSelection = $ClassSelectionModule
onready var SlaveInfo = $SlaveCreationModule
onready var TraitSelection = $TraitSelection

func _ready():
	$SaveButton.connect("pressed", self, "SaveLoadCharPanel", ["save"])
	$LoadButton.connect("pressed", self, "SaveLoadCharPanel", ["load"])
	$SaveLoadCharPanel/LineEdit.connect("text_changed",self,'set_savefilename')
	$SaveLoadCharPanel/SaveLoadButton.connect("pressed", self, "PressSaveLoadCharacter", [savefilename])
	$SaveLoadCharPanel/SaveLoadCancel.connect("pressed", self, "hideSaveLoadPanel")
	# input_handler.AddPanelOpenCloseAnimation($RaceSelection)
	# input_handler.AddPanelOpenCloseAnimation($TraitSelection)
	# input_handler.AddPanelOpenCloseAnimation($DietPanel)
	# input_handler.AddPanelOpenCloseAnimation($ClassPanel)
	$TestButton.connect("pressed", self, "test")
	for i in agearray:
		$VBoxContainer/HBoxContainer/AgeVBox/age.add_item(i.capitalize())
	for i in sexarray:
		if input_handler.globalsettings.futa == false && i == 'futa':
			continue
		$VBoxContainer/HBoxContainer/SexVBox/sex.add_item(i.capitalize())
	$VBoxContainer/race.connect("pressed", RaceSelection, "select_race")
	$VBoxContainer/HBoxContainer/AgeVBox/age.connect("item_selected", self, "select_age")
	$VBoxContainer/HBoxContainer/SexVBox/sex.connect("item_selected", self, "select_sex")
	$VBoxContainer/sextrait.connect('pressed', self, "open_sex_traits")


	$ConfirmButton.connect("pressed", self, 'confirm_character')
#	$CancelButton.connect("pressed", self, "confirm_return")
	globals.connecttexttooltip($VBoxContainer/sextrait, tr("TOOLTIPSEXTRAITS"))

	for i in ['name','surname','nickname']:
		$VBoxContainer.get_node(i).connect("text_changed", self, 'text_changed', [i])


	$VBoxContainer/class.connect("pressed", ClassSelection, "open_class_list")
	for i in $DietPanel/VBoxContainer.get_children():
		i.get_node("OptionButton").connect("item_selected", self, "select_food_pref", [i.name])
	$BackButton.connect("pressed", self, "Exit")
	$BackButtonCheats.connect("pressed", self, "hide")
	open()

func Exit():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'MainMenu', tr('LEAVECONFIRM')])


func MainMenu():
	globals.return_to_main_menu()

func select_age(value):
	person.set_stat('age', agearray[value])
	preservedsettings['age'] = agearray[value]
	valid_preservedsettings['age'] = true
	rebuild_slave()

func select_sex(value):
	person.set_stat('sex', sexarray[value])
	preservedsettings['sex'] = sexarray[value]
	valid_preservedsettings['sex'] = true
	if preservedsettings.has("tits_size"):
		valid_preservedsettings['tits_size'] = false
#		preservedsettings.erase("tits_size")
	if preservedsettings.has("has_pussy"):
		valid_preservedsettings['has_pussy'] = false
#		preservedsettings.erase("has_pussy")
	if preservedsettings.has("has_womb"):
		valid_preservedsettings['has_womb'] = false
#		preservedsettings.erase("has_womb")
	if preservedsettings.has("vagina"):
		valid_preservedsettings['vagina'] = false
#		preservedsettings.erase("vagina")
	rebuild_slave()


func select_food_pref(selected_id, type):
	var food_hate = person.food.food_hate
	match selected_id:
		0:
			if person.food.food_love == type:
				person.food.food_love = ""
			if food_hate.has(type):
				food_hate.erase(type)
		1:
			person.food.food_love = type
			if food_hate.has(type):
				food_hate.erase(type)
		2:
			if !food_hate.has(type):
				food_hate.append(type)
			if person.food.food_love == type:
				person.food.food_love = ""
	select_diet()


func select_diet():
	var array = ['Neutral', "Like", "Hate"]
	for i in $DietPanel/VBoxContainer.get_children():
		i.get_node("OptionButton").set_item_disabled(1, person.food.food_love != '')
		if  person.food.food_love == i.name:
			i.get_node("OptionButton").selected = 1
		elif person.food.food_hate.has(i.name):
			i.get_node("OptionButton").selected = 2
		else:
			i.get_node("OptionButton").selected = 0

	finish_diet_selection()

#	$DietPanel/Button.disabled = !(person.get_stat('food_love') != '' && person.get_stat('food_hate').size() > 0)


func finish_diet_selection():
	preservedsettings['food_love'] = person.food.food_love
	valid_preservedsettings.food_love = true
	preservedsettings['food_hate'] = person.food.food_hate
	valid_preservedsettings.food_hate = true
	var text = person.food.food_love + "|"
	for i in person.food.food_hate:
		text += i + " "
#	$bodyparts2/diet.text = text

func open(type = 'slave', newguild = 'none', is_from_cheats = false):
	preservedsettings.clear()
	valid_preservedsettings.clear()
	show()
	guild = newguild
#	$CancelButton.visible = input_handler.CurrentScreen == 'mansion'
	$introduction.bbcode_text = introduction_text[type]
	if type == 'slave':
		$introduction.bbcode_text += " " + str(ResourceScripts.game_party.characters.size())
	selected_class = ''

	person = ResourceScripts.scriptdict.class_slave.new("char_creation")
	mode = type
	person.set_stat('age', 'adult')
	person.set_stat('race', 'Human')
	match mode:
		'master':
			person.set_stat('sex', 'male')
			total_stat_points = variables.master_starting_stats
		'slave':
			person.set_stat('sex', 'female')
			total_stat_points = variables.slave_starting_stats

#	$bodyparts2/type_label.visible = mode == 'slave'
#	$bodyparts2/slave_class.visible = mode == 'slave'
#	$bodyparts2/slave_class.select(0)
	globals.connecttexttooltip($SlaveCreationModule/ScrollContainer/HBoxContainer/bodyparts2/slave_class_label, "Slave&Peon:\n" + tr('SLAVECLASSDESCRIPT') + "\n\n" + tr('SERVANTCLASSDESCRIPT'))
	$BackButton.visible = type != 'slave' || is_from_cheats
	$BackButtonCheats.visible = is_from_cheats
	rebuild_slave()


func rebuild_slave():
	SlaveInfo.build_bodyparts()
	var race = person.get_stat('race')
	var sex = person.get_stat('sex')
	var age = person.get_stat('age')
	var t_person = ResourceScripts.scriptdict.class_slave.new("char_creation_rebuild")
	t_person.create(race, sex, age)
	t_person.is_active = false
	t_person.is_known_to_player = true
	if mode == 'master':
		t_person.unlock_class('master')

	$VBoxContainer/race.text = races.racelist[race].name
	$VBoxContainer/HBoxContainer/SexVBox/sex.select(sexarray.find(sex))
	$VBoxContainer/HBoxContainer/AgeVBox/age.select(agearray.find(age))
	$VBoxContainer/SelectedClass.text = selected_class.capitalize()
	if preservedsettings.has("food_love") and valid_preservedsettings.food_love:
		if preservedsettings.food_love != '':
			t_person.food.food_love = preservedsettings["food_love"]
	else:
		t_person.set_stat('food_love',  '')
	if preservedsettings.has("food_hate") and valid_preservedsettings.food_hate:
		if !preservedsettings.food_hate.empty():
			t_person.food.food_hate = preservedsettings["food_hate"]
	else:
		t_person.set_stat('food_hate', [])
	for i in ['name','surname','nickname']:
		if preservedsettings.has(i):
			$VBoxContainer.get_node(i).text = preservedsettings[i]
		else:
			$VBoxContainer.get_node(i).text = person.get_stat(i)
	
	person = t_person
	select_diet()
	if preservedsettings.has("sex_traits") && preservedsettings.sex_traits != null:
		select_sex_trait(preservedsettings.sex_traits)
	RebuildStatsContainer()
	SlaveInfo.build_bodyparts()
	SlaveInfo.get_node("descript").bbcode_text = ResourceScripts.descriptions.trim_tag(person.make_description(), 'url', 'hair')


func delete_keys_from_preservedsettings(keys):
	for key in keys:
		preservedsettings.erase(key)
		valid_preservedsettings[key] = false


func apply_preserved_settings():
	var racedata = races.racelist[person.get_stat('race')].bodyparts
	var keys_to_delete = []
	for i in bodypartsarray:
		if !races.racelist.Human.bodyparts.has(i) && preservedsettings.has(i) && preservedsettings[i] != '' && !racedata.has(i):
			keys_to_delete.append(i)
	delete_keys_from_preservedsettings(keys_to_delete)
	for i in preservedsettings:
		if !valid_preservedsettings.has(i): continue
		if !valid_preservedsettings[i]: continue
		if i == "food_love":
			person.food.food_love = preservedsettings["food_love"]
		elif i == "food_hate":
			person.food.food_hate = preservedsettings["food_hate"]
		elif i == 'slave_class':
			person.set_slave_category(preservedsettings[i])
		else:
			person.set_stat(i, preservedsettings[i])


func confirm_character():
	if check_confirm_possibility():
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'finish_character', tr('CREATECHARQUESTION')])


func finish_character():
	apply_preserved_settings()
#	$TraitSelection.hide()
#	$ClassPanel.hide()
	person.is_active = true
	person.unlock_class(selected_class)
	person.set_stat('food_consumption', 3)
	person.hp = person.get_stat('hpmax')
	person.mp = person.get_stat('mpmax')
	person.food.create() #rebuild food filter
	if mode != 'master':
		if !preservedsettings.has('slave_class'):
			preservedsettings.slave_class = 'slave'
		person.set_slave_category(preservedsettings.slave_class.to_lower())
		person.set_stat('authority', person.authority_threshold()/1.5)
		person.set_stat('obedience', 48)
	else:
		person.set_slave_category('master')
		person.set_stat('consent', 1000)
	ResourceScripts.game_party.add_slave(person)
	self.hide()
	input_handler.emit_signal("CharacterCreated")
	input_handler.add_random_chat_message(person, 'hire')

func text_changed(text, value):
	# if text != '':
	preservedsettings[value] = text
	valid_preservedsettings[value] = true
	apply_preserved_settings()
	SlaveInfo.get_node("descript").bbcode_text = ResourceScripts.descriptions.trim_tag(person.make_description(), 'url', 'hair')


func check_confirm_possibility():
	if !preservedsettings.has('food_love') or !valid_preservedsettings.food_love:
		input_handler.SystemMessage("You must select a liked food type")
		return false
	if preservedsettings['food_love'] == '' or preservedsettings['food_hate'].empty() or !valid_preservedsettings.food_hate:
		input_handler.SystemMessage("You must select one liked and at least one hated food type.")
		return false

	if selected_class == '':
		input_handler.SystemMessage("You must select a starting Class")
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
	apply_preserved_settings()
	var character_to_save = {}
	for i in params_to_save:
		character_to_save[i] = person.get_stat(i)
		if preservedsettings.has(i) and valid_preservedsettings[i] and !i in ["professions", "food_love", "food_hate"]: # && !preservedsettings in except_array:
			character_to_save[i] = preservedsettings[i]
	character_to_save.professions = selected_class
	character_to_save["tits_size"] = person.get_stat("tits_size")
	character_to_save["ass_size"] = person.get_stat("ass_size")
	character_to_save["balls_size"] = person.get_stat("balls_size")
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

var temp_character
func reset_profession():
	temp_character.professions = ''
	LoadCharacter(temp_character)


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
	temp_character = character_to_load
	# Load availability checking
	if character_to_load != null && character_to_load.type != mode:
		input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'hideSaveLoadPanel', tr("TEMPLATETYPENOTMATCH")])
		return
	if guild != "none":
		if character_to_load != null && character_to_load.professions != '' && !character_to_load.professions in variables.get(guild+'_starting_classes'):
			input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'reset_profession', tr("RESETLOADCHARPROFESSION")])
			return
	var check_stats = 0
	var stats_array = []
	for i in character_to_load:
		if i.ends_with("_factor") && !i in ['growth_factor', 'timid_factor', 'tame_factor']:
			check_stats += character_to_load[i]
			stats_array.append(i)
	if check_stats > 15:
		for i in stats_array:
			character_to_load[i] = 1
	selected_class = character_to_load.professions
	update_class_button()
	for i in character_to_load:
		if i == "food_love":
			person.food.food_love = character_to_load["food_love"]
			preservedsettings[i] = character_to_load["food_love"]
			valid_preservedsettings[i] = true
			continue
		elif i == "food_hate":
			person.food.food_hate = character_to_load["food_hate"]
			preservedsettings[i] = character_to_load["food_hate"]
			valid_preservedsettings[i] = true
			continue
		person.set_stat(i, character_to_load[i])
		preservedsettings[i] = character_to_load[i]
		valid_preservedsettings[i] = true

	for i in ['name','surname','nickname']:
		if preservedsettings.has(i):
			$VBoxContainer.get_node(i).text = preservedsettings[i]
		else:
			$VBoxContainer.get_node(i).text = person.get_stat(i)
	# apply_preserved_settings()
	SlaveInfo.build_bodyparts()
	SlaveInfo.get_node("descript").bbcode_text = ResourceScripts.descriptions.trim_tag(person.make_description(), 'url', 'hair')
	# if person.statlist.sex_traits.size() == 0:
	# 	$VBoxContainer/sextrait.text = "Select Sex Trait"
	# else:
	# 	$VBoxContainer/sextrait.text = Traitdata.sex_traits[person.statlist.sex_traits[0]].name
	for node in get_children():
		if node.get_child_count() != 0:
			for i in node.get_children():
				if i.get_name() in person:
					if i.get_class() == "CheckBox":
						i.pressed = person[i.get_name()]
					elif i.get_class() == "OptionButton":
						continue
						# for i in $DietPanel/VBoxContainer.get_children():
						# 	i.get_node("OptionButton").connect("item_selected", self, "select_food_pref", [i.name])
					else:
						i.text = person[i.get_name()].capitalize()
	RebuildStatsContainer()
	rebuild_slave()
	select_diet()
	finish_diet_selection()
	hideSaveLoadPanel()
	input_handler.SystemMessage("Character Template Loaded")
	# person.create_s_trait_select(character_to_load.sex_traits)
	temp_character = null


func DeleteCharacter():
	var deletename = $SaveLoadCharPanel/LineEdit.text + ".ch"
	var dir = Directory.new()
	dir.remove(variables.userfolder + 'savedcharacters/' + deletename)
	input_handler.SystemMessage("Character Deleted")
	SaveLoadCharPanel(saveloadstate)



func RebuildStatsContainer():
	input_handler.ClearContainer($StatsModule/StatsContainer)
	var array = []
	for i in statdata.statdata.values():
		if i.has('type') && i.type == 'factor':
			array.append(i)
			if preservedsettings.has(i.code) == false or !valid_preservedsettings[i.code]:
				preservedsettings[i.code] = 1
				valid_preservedsettings[i.code] = true
			else:
				person.set_stat(i.code, preservedsettings[i.code])
			if i.code in ['growth_factor','timid_factor','tame_factor'] && mode == 'master':
				preservedsettings[i.code] = 5
				valid_preservedsettings[i.code] = true
	
	var counter = total_stat_points
	
	if person.statlist.sex_traits.size() == 0:
		$VBoxContainer/SexTraitLabel.text = "Select Sex Trait"
	else:
		$VBoxContainer/SexTraitLabel.text = Traitdata.sex_traits[person.statlist.sex_traits.keys()[0]].name
	for i in array:
		if mode == 'master' && i.code in ["growth_factor",'timid_factor','tame_factor']:
			continue
		var newnode = input_handler.DuplicateContainerTemplate($StatsModule/StatsContainer)
		newnode.get_node("up").connect("pressed", self, 'stat_up', [i])
		newnode.get_node("down").connect("pressed", self, 'stat_down', [i])
		newnode.get_node("Label").text = str(preservedsettings[i.code])
		counter -= preservedsettings[i.code]-1
		newnode.get_node("icon").texture = i.baseicon
		var text = i.descript
		if i.code in ['physics_factor','wits_factor','charm_factor','sexuals_factor']:
			text += '\n\n' + statdata.statdata[i.code.replace('_factor', '')].descript
		globals.connecttexttooltip(newnode.get_node("icon"), text)

	unassigned_points = counter
	$StatsModule/totalstatlabel.text = 'Free points left: ' + str(counter)

	apply_preserved_settings()
	if selected_class != '' && person.checkreqs(classesdata.professions[selected_class].reqs) == false:
		selected_class = ''

func stat_up(stat):
	if preservedsettings[stat.code] >= 5 || unassigned_points == 0:
		return
	else:
		preservedsettings[stat.code] += 1
		valid_preservedsettings[stat.code] = true
		RebuildStatsContainer()
		$ClassSelectionModule.update_class_buttons()

func stat_down(stat):
	if preservedsettings[stat.code] <= 1:
		return
	else:
		preservedsettings[stat.code] -= 1
		valid_preservedsettings[stat.code] = true
		RebuildStatsContainer()
		$ClassSelectionModule.update_class_buttons()

func open_sex_traits():
	RaceSelection.hide()
	ClassSelection.hide()
	TraitSelection.show()
	input_handler.ClearContainer($TraitSelection/ScrollContainer/VBoxContainer)
	for i in Traitdata.sex_traits.values():
		if i.starting == false || person.checkreqs(i.acquire_reqs) == false:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($TraitSelection/ScrollContainer/VBoxContainer)
		newbutton.text = i.name
		if person.check_trait(i.code):
			newbutton.pressed = true
		newbutton.connect("pressed", self, "select_sex_trait", [i])
		globals.connecttexttooltip(newbutton, person.translate(i.descript))


func select_sex_trait(trait):
	person.create_s_trait_select(trait)
	preservedsettings["sex_traits"] = trait
	valid_preservedsettings["sex_traits"] = true
	$TraitSelection.hide()
	#input_handler.GetTextTooltip().hide()
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
	RebuildStatsContainer()


func confirm_return():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'cancel_creation', tr("RETURNTOMAINMENUQUESTION")])
	#input_handler.ShowConfirmPanel(self, "cancel_creation", "Return to Main Menu?")


func update_class_button():
	$VBoxContainer/SelectedClass.text = selected_class.capitalize()

func test():
#	print("Preserved Settings:", preservedsettings)
#	print(person.get_stat("sex"))
#	print(person.get_stat("age"))
#	print(person.get_stat("race"))
#	print(person.get_full_name())
	print("Sex Traits:", person.statlist.sex_traits)
