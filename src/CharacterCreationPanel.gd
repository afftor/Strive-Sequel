extends Panel
#warning-ignore-all:return_value_discarded

var person
var mode
var total_stat_points
var unassigned_points

var preservedsettings = {}

var agearray = ['teen','adult','mature']
var sexarray = ['male','female','futa']
var malesizes = ['masculine','flat']
var sizes = ['flat','small','average','big','huge']
var short_sizes = ['small','average','big']
var guild = 'none'

var bodypartsarray = ['skin', 'hair_length', 'hair_color', 'eye_color', 'eye_shape', 'ears', 'horns', 'tail', 'wings', 'height']
var sexbodypartsarray = ['penis_size', 'penis_type', 'balls_size','tits_size', 'ass_size']

var slave_classes = ['slave','servant']
var selected_class = ''

var introduction_text = {master = "Create your Master Character", 'slave' : 'Create your Starting Slave'}

func _ready():
	globals.AddPanelOpenCloseAnimation($RaceSelection)
	globals.AddPanelOpenCloseAnimation($TraitSelection)
	globals.AddPanelOpenCloseAnimation($DietPanel)
	globals.AddPanelOpenCloseAnimation($ClassPanel)
	for i in agearray:
		$VBoxContainer/age.add_item(i.capitalize())
	for i in sexarray:
		if globals.globalsettings.futa == false && i == 'futa':
			continue
		$VBoxContainer/sex.add_item(i.capitalize())
	$VBoxContainer/race.connect("pressed", self, "select_race")
	$VBoxContainer/age.connect("item_selected", self, "select_age")
	$VBoxContainer/sex.connect("item_selected", self, "select_sex")
	$VBoxContainer/sextrait.connect('pressed', self, "open_sex_traits")
	for i in variables.personality_array:
		$VBoxContainer/personality.add_item(i.capitalize())
	$VBoxContainer/personality.connect("item_selected", self, "select_personality")
	globals.connecttexttooltip($VBoxContainer/personality, tr("SLAVEPARTPERSONALITYDESCRIPT"))
	
	$ConfirmButton.connect("pressed", self, 'confirm_character')
	$CancelButton.connect("pressed", self, "confirm_return")
	globals.connecttexttooltip($VBoxContainer/sextrait, tr("TOOLTIPSEXTRAITS"))
	
	for i in ['name','surname','nickname']:
		$VBoxContainer.get_node(i).connect("text_changed", self, 'text_changed', [i])
	
	for i in bodypartsarray:
		$bodyparts.get_node(i).connect("item_selected", self, "select_bodypart", [i, $bodyparts.get_node(i)])
	
	for i in sexbodypartsarray:
		$bodyparts2.get_node(i).connect("item_selected", self, "select_sexbodypart", [i, $bodyparts2.get_node(i)])
	
	for i in ['vaginal_virgin','anal_virgin','penis_virgin']:
		$bodyparts2.get_node(i).connect("pressed", self, "select_checkbox", [i, $bodyparts2.get_node(i)])
	
	$bodyparts2/diet.connect("pressed", self, 'select_diet')
	$DietPanel/Button.connect("pressed", self, 'finish_diet_selection')
	for i in $DietPanel/VBoxContainer.get_children():
		i.get_node("OptionButton").connect("item_selected", self, "select_food_pref", [i.name])
	
	$bodyparts2/class.connect("pressed", self, "open_class_list")
	
	for i in slave_classes:
		$bodyparts2/slave_class.add_item(globals.slave_class_names[i])
	$bodyparts2/slave_class.connect("item_selected", self, "select_type", [$bodyparts2/slave_class])
	
	open()

func open_class_list():
	$ClassPanel.show()
	globals.ClearContainer($ClassPanel/ScrollContainer/VBoxContainer)
	var array
	if mode == 'master':
		array = variables.master_starting_classes
	elif mode == 'slave':
		if guild == 'none':
			array = variables.slave_starting_classes
		else:
			array = variables[guild+'_starting_classes']
	for i in array:
		var tempclass = Skilldata.professions[i]
		if person.checkreqs(tempclass.showupreqs) == false:
			continue
		var newbutton = globals.DuplicateContainerTemplate($ClassPanel/ScrollContainer/VBoxContainer)
		newbutton.get_node("icon").texture = tempclass.icon
		newbutton.get_node("name").text = tempclass.name
		newbutton.connect('pressed', self, "select_class", [tempclass.code])
		newbutton.connect('signal_RMB_release',input_handler,'show_class_info', [tempclass.code, person])
		var text = globals.descriptions.get_class_details(person, tempclass, true, true) + "\n\n{color=aqua|" + tr("CLASSRIGHTCLICKDETAILS") + "}"
		globals.connecttexttooltip(newbutton, text)
		if person.checkreqs(tempclass.reqs) == false:
			newbutton.disabled = true
	input_handler.active_character = person

func select_class(tempclass):
	selected_class = tempclass
	$ClassPanel.hide()
	check_confirm_possibility()

func text_changed(text, value):
	if text != '':
		preservedsettings[value] = text
	
	apply_preserved_settings()
	$descript.bbcode_text = person.make_description()

func select_bodypart(value, bodypart, node):
	preservedsettings[bodypart] = node.get_item_text(value)
	
	apply_preserved_settings()
	$descript.bbcode_text = person.make_description()

func select_sexbodypart(value, bodypart, node):
	preservedsettings[bodypart] = node.get_item_text(value)
	
	apply_preserved_settings()
	$descript.bbcode_text = person.make_description()

func select_type(value, node):
	preservedsettings.slave_class = slave_classes[value]

func select_checkbox(bodypart, node):
	preservedsettings[bodypart] = node.pressed
	
	apply_preserved_settings()
	$descript.bbcode_text = person.make_description()

func select_diet():
	$DietPanel.show()
	var array = ['Neutral', "Like", "Hate"]
	for i in $DietPanel/VBoxContainer.get_children():
		i.get_node("OptionButton").set_item_disabled(1, person.food_love != '')
		if  person.food_love == i.name:
			i.get_node("OptionButton").selected = 1
		elif person.food_hate.has(i.name):
			i.get_node("OptionButton").selected = 2
		else:
			i.get_node("OptionButton").selected = 0
	
	$DietPanel/Button.disabled = !(person.food_love != '' && person.food_hate.size() > 0)

func select_food_pref(selected_id, type):
	match selected_id:
		0:
			if person.food_love == type:
				person.food_love = ''
			if person.food_hate.has(type):
				person.food_hate.erase(type)
		1:
			person.food_love = type
			if person.food_hate.has(type):
				person.food_hate.erase(type)
		2:
			if !person.food_hate.has(type):
				person.food_hate.append(type)
			if person.food_love == type:
				person.food_love = ''
	select_diet()

func finish_diet_selection():
	$DietPanel.hide()
	preservedsettings['food_love'] = person.food_love
	preservedsettings['food_hate'] = person.food_hate
	var text = person.food_love + "|"
	for i in person.food_hate:
		text += i + " "
	$bodyparts2/diet.text = text
	check_confirm_possibility()

func open(type = 'slave', newguild = 'none'):
	preservedsettings.clear()
	show()
	guild = newguild
	$CancelButton.visible = input_handler.CurrentScreen == 'mansion'
	$introduction.bbcode_text = introduction_text[type]
	if type == 'slave':
		$introduction.bbcode_text += " " + str(state.characters.size())
	selected_class = ''
	
	person = Slave.new()
	mode = type
	match mode:
		'master':
			person.sex = 'male'
			person.age = 'adult'
			person.race = 'Human'
			total_stat_points = variables.master_starting_stats
		'slave':
			person.sex = 'female'
			person.age = 'adult'
			person.race = 'Human'
			total_stat_points = variables.slave_starting_stats
	
	$bodyparts2/type_label.visible = mode == 'slave'
	$bodyparts2/slave_class.visible = mode == 'slave'
	$bodyparts2/slave_class.select(0)
	globals.connecttexttooltip($bodyparts2/type_label, "Slave&Peon:\n" + tr('SLAVECLASSDESCRIPT') + "\n\n" + tr('SERVANTCLASSDESCRIPT'))
	
	rebuild_slave()

func rebuild_slave():
	var race = person.race
	var sex = person.sex
	var age = person.age
	person = Slave.new()
	person.create(race, sex, age)
	person.is_active = false
	person.is_known_to_player = true
	if mode == 'master':
		person.unlock_class('master')
	
	$VBoxContainer/race.text = races.racelist[person.race].name
	$VBoxContainer/sex.select(sexarray.find(person.sex))
	$VBoxContainer/age.select(agearray.find(person.age))
	$VBoxContainer/personality.visible = mode != 'master'
	$VBoxContainer/personality.select(variables.personality_array.find(person.personality))
	person.food_love = ''
	person.food_hate.clear()
	
	for i in ['name','surname','nickname']:
		if preservedsettings.has(i):
			$VBoxContainer.get_node(i).text = preservedsettings[i]
		else:
			$VBoxContainer.get_node(i).text = person.get(i)
	RebuildStatsContainer()
	build_bodyparts()
	apply_preserved_settings()
	$descript.bbcode_text = person.make_description()
	
	
	check_confirm_possibility()

func check_confirm_possibility():
	var can_confirm = true
	
	if preservedsettings.has('food_love') == false:
		$bodyparts2/diet.text = "Select"
		can_confirm = false
	else:
		var text = person.food_love + "|"
		for i in person.food_hate:
			text += i + " "
		$bodyparts2/diet.text = text
	
	
	if selected_class == '':
		$bodyparts2/class.text = "Select"
		can_confirm = false
	else:
		$bodyparts2/class.text = Skilldata.professions[selected_class].name
	
	if !can_confirm:
		$ConfirmButton.disabled = true
		$ConfirmButton.hint_tooltip = 'Select starting Class and Diet'
	else:
		$ConfirmButton.disabled = false
		$ConfirmButton.hint_tooltip = ""

func select_age(value):
	person.age = agearray[value]
	rebuild_slave()

func select_sex(value):
	person.sex = sexarray[value]
	rebuild_slave()

func select_personality(value):
	preservedsettings.personality = variables.personality_array[value]

func select_race():
	$RaceSelection.show()
	globals.ClearContainer($RaceSelection/ScrollContainer/VBoxContainer)
	for i in races.racelist.values():
		var newbutton = globals.DuplicateContainerTemplate($RaceSelection/ScrollContainer/VBoxContainer)
		if person.race == i.code: newbutton.pressed = true
		newbutton.text = i.name
		newbutton.connect("mouse_entered", self, 'show_race_info',[i.code])
		newbutton.connect("pressed", self, "select_character_race", [i.code])


func show_race_info(temprace):
	var race = races.racelist[temprace]
	var image
	var text = race.descript
	
	text += "\n\nRace bonuses: "
	for i in race.race_bonus:
		if (i as String).begins_with('resist'):
			text += i.replace("resist","").capitalize() + " Resist: " + str(race.race_bonus[i]) + "%, "
			continue
		if globals.statdata[i].has("percent") && globals.statdata[i].percent == true:
			text += globals.statdata[i].name + ": " + str(race.race_bonus[i]*100) + '%, '
		else:
			text += globals.statdata[i].name + ": " + str(race.race_bonus[i]) + ', '
	text = text.substr(0, text.length() - 2) + "."
	
	
	
	$RaceSelection/RichTextLabel.bbcode_text = globals.TextEncoder(text)
	text = race.code.to_lower().replace('halfkin','beastkin')
	if person.sex != null:
		if person.sex == 'male':
			text += "_m"
		else:
			text += "_f"
		
		if images.shades.has(text):
			image = images.shades[text]
	
	
	
	$RaceSelection/TextureRect.texture = image

func select_character_race(temprace):
	person.race = temprace
	$RaceSelection.hide()
	rebuild_slave()

func RebuildStatsContainer():
	globals.ClearContainer($StatsContainer)
	var array = []
	for i in globals.statdata.values():
		if i.has('type') && i.type == 'factor':
			array.append(i)
			if preservedsettings.has(i.code) == false:
				preservedsettings[i.code] = 1
			else:
				person[i.code] = preservedsettings[i.code]
			if i.code in ['growth_factor','timid_factor','tame_factor'] && mode == 'master':
				preservedsettings[i.code] = 5
			
	
	var counter = total_stat_points
	
	if person.sex_traits.size() == 0:
		$VBoxContainer/sextrait.text = "Select Sex Trait"
	else:
		$VBoxContainer/sextrait.text = Traitdata.sex_traits[person.sex_traits[0]].name
	
	
	for i in array:
		if mode == 'master' && i.code in ["growth_factor",'timid_factor','tame_factor']:
			continue
		var newnode = globals.DuplicateContainerTemplate($StatsContainer)
		newnode.get_node("up").connect("pressed", self, 'stat_up', [i])
		newnode.get_node("down").connect("pressed", self, 'stat_down', [i])
		newnode.get_node("Label").text = str(preservedsettings[i.code])
		counter -= preservedsettings[i.code]-1
		newnode.get_node("icon").texture = i.baseicon
		var text = i.descript
		if i.code in ['physics_factor','wits_factor','charm_factor','sexuals_factor']:
			text += '\n\n' + globals.statdata[i.code.replace('_factor', '')].descript
		globals.connecttexttooltip(newnode.get_node("icon"), text)
	
	unassigned_points = counter
	$totalstatlabel.text = 'Free points left: ' + str(counter)
	
	#apply_preserved_settings()
	if selected_class != '' && person.checkreqs(Skilldata.professions[selected_class].reqs) == false:
		selected_class = ''
		check_confirm_possibility()

func stat_up(stat):
	if preservedsettings[stat.code] >= 5 || unassigned_points == 0:
		return
	else:
		preservedsettings[stat.code] += 1
		RebuildStatsContainer()

func stat_down(stat):
	if preservedsettings[stat.code] <= 1:
		return
	else:
		preservedsettings[stat.code] -= 1
		RebuildStatsContainer()

func build_bodyparts():
	var racedata = races.racelist[person.race].bodyparts
	for i in bodypartsarray:
		$bodyparts.get_node(i).clear()
		var current_bodypart = person.get(i)
		
		if preservedsettings.has(i) == false && current_bodypart != '':
			preservedsettings[i] = current_bodypart
		
		var workarray = []
		if racedata.has(i):
			workarray = racedata[i]
		elif races.racelist.Human.bodyparts.has(i):
			workarray = races.racelist.Human.bodyparts[i]
		
		
		var preserved_option_exists = false
		for k in workarray:
			$bodyparts.get_node(i).add_item(k)
			if preservedsettings[i] == k:
				preserved_option_exists = true
				$bodyparts.get_node(i).select($bodyparts.get_node(i).get_item_count()-1)
		
		if preserved_option_exists == false:
			preservedsettings.erase(i)
			#preservedsettings[i] = person.get(i)
			#print(i, person.get(i))
		
		
		
		$bodyparts.get_node(i).disabled = $bodyparts.get_node(i).get_item_count() == 1
		
		if $bodyparts.get_node(i).get_item_count() == 0:
			preservedsettings.erase(i)
		
		$bodyparts.get_node(i).visible = $bodyparts.get_node(i).get_item_count() != 0
		$bodyparts.get_node(i+'_label').visible = $bodyparts.get_node(i).visible
	for i in sexbodypartsarray:
		$bodyparts2.get_node(i).clear()
		var current_bodypart = person.get(i)
		
		if preservedsettings.has(i) == false && current_bodypart != '':
			preservedsettings[i] = current_bodypart
		
		
		if i == 'penis_type' && racedata.has(i) && !racedata[i].has(preservedsettings[i]):
			person.set(i, racedata[i][randi()%racedata[i].size()])
			preservedsettings[i] = person[i]
		elif i == 'penis_type' && racedata.has(i) == false && preservedsettings[i] != 'human':
			person.set(i, 'human')
			preservedsettings[i] = person[i]
		
		
		match person.sex:
			'male':
				$bodyparts2.get_node(i).visible = true
				$bodyparts2.get_node(i + "_label").visible = true
			'female':
				if i in ['penis_size', 'penis_type', 'balls_size']:
					$bodyparts2.get_node(i).visible = false
					$bodyparts2.get_node(i + "_label").visible = false
					person[i] = ''
					preservedsettings.erase(i)
			'futa':
				if i == 'balls_size':
					if globals.globalsettings.futa_balls == false:
						$bodyparts2.get_node(i).visible = false
						$bodyparts2.get_node(i + "_label").visible = false
						preservedsettings.erase(i)
					else:
						$bodyparts2.get_node(i).visible = true
						$bodyparts2.get_node(i + "_label").visible = true
				elif i in ['penis_size', 'penis_type']:
					$bodyparts2.get_node(i).visible = true
					$bodyparts2.get_node(i + "_label").visible = true
		
		if person.sex == 'male':
			match i:
				'penis_size', 'balls_size':
					for k in short_sizes:
						$bodyparts2.get_node(i).add_item(k)
						if preservedsettings.has(i) && preservedsettings[i] == k:
							$bodyparts2.get_node(i).select($bodyparts2.get_node(i).get_item_count()-1)
				'tits_size', 'ass_size':
					for k in malesizes:
						$bodyparts2.get_node(i).add_item(k)
						if preservedsettings.has(i) && preservedsettings[i] == k:
							$bodyparts2.get_node(i).select($bodyparts2.get_node(i).get_item_count()-1)
		else:
			match i:
				'penis_size', 'balls_size':
					for k in short_sizes:
						$bodyparts2.get_node(i).add_item(k)
						if preservedsettings.has(i) && preservedsettings[i] == k:
							$bodyparts2.get_node(i).select($bodyparts2.get_node(i).get_item_count()-1)
							
				'tits_size', 'ass_size':
					for k in sizes:
						$bodyparts2.get_node(i).add_item(k)
						if preservedsettings.has(i) && preservedsettings[i] == k:
							$bodyparts2.get_node(i).select($bodyparts2.get_node(i).get_item_count()-1)
		
		if i == 'penis_type':
			$bodyparts2.get_node(i).add_item(person.penis_type)
		
		$bodyparts2.get_node(i).disabled = $bodyparts2.get_node(i).get_item_count() == 1
	
	for i in ['vaginal_virgin','anal_virgin','penis_virgin']:
		$bodyparts2.get_node(i).pressed = person.get(i)
	
	match person.sex:
		'male':
			$bodyparts2/penis_virgin.visible = true
			$bodyparts2/vaginal_virgin.visible = false
		'female':
			$bodyparts2/vaginal_virgin.visible = true
			$bodyparts2/penis_virgin.visible = false
		'futa':
			$bodyparts2/penis_virgin.visible = true
			$bodyparts2/vaginal_virgin.visible = true
	
	

func apply_preserved_settings():
	for i in preservedsettings:
		person.set(i, preservedsettings[i])

func confirm_character():
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'finish_character', 'Create this character?'])
	#input_handler.ShowConfirmPanel(self, 'finish_character', 'Create this character?')

func confirm_return():
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'cancel_creation', "Return to Main Menu?"])
	#input_handler.ShowConfirmPanel(self, "cancel_creation", "Return to Main Menu?")

func cancel_creation():
	globals.CurrentScene.queue_free()
	input_handler.GameStartNode.queue_free()
	state.revert()
	globals.ChangeScene('menu')
	#get_parent().queue_free()

func finish_character():
	apply_preserved_settings()
	$TraitSelection.hide()
	$ClassPanel.hide()
	person.is_active = true
	person.unlock_class(selected_class)
	person.food_consumption = 3
	person.hp = person.get_stat('hpmax')
	person.mp = person.get_stat('mpmax')
	if mode != 'master':
		if preservedsettings.has('slave_class') == false:
			preservedsettings.slave_class = 'slave'
		person.set_slave_category(preservedsettings.slave_class.to_lower())
		person.authority = person.authority_threshold()/1.5
		person.obedience = 48
	else:
		person.slave_class = 'master'
		person.consent = 1000
	state.add_slave(person)
	self.hide()
	input_handler.emit_signal("CharacterCreated")

func open_sex_traits():
	$TraitSelection.show()
	globals.ClearContainer($TraitSelection/ScrollContainer/VBoxContainer)
	for i in Traitdata.sex_traits.values():
		if i.starting == false || person.checkreqs(i.acquire_reqs) == false:
			continue
		var newbutton = globals.DuplicateContainerTemplate($TraitSelection/ScrollContainer/VBoxContainer)
		newbutton.text = i.name
		if person.sex_traits.has(i.code):
			newbutton.pressed = true
		newbutton.connect("pressed", self, "select_sex_trait", [i])
		globals.connecttexttooltip(newbutton, person.translate(i.descript))

func select_sex_trait(trait):
	if person.sex_traits.has(trait.code):
		person.sex_traits.erase(trait.code)
		person.unlocked_sex_traits.erase(trait.code)
	else:
		person.sex_traits.clear()
		person.unlocked_sex_traits.clear()
		person.sex_traits.append(trait.code)
	$TraitSelection.hide()
	#input_handler.GetTextTooltip().hide()
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
	RebuildStatsContainer()

