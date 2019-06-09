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

var bodypartsarray = ['skin', 'hair_length', 'hair_color', 'eye_color', 'eye_shape', 'ears', 'horns', 'tail', 'wings', 'height']
var sexbodypartsarray = ['penis_size', 'penis_type', 'balls_size','tits_size', 'ass_size']


func _ready():
	globals.AddPanelOpenCloseAnimation($RaceSelection)
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
	
	$ConfirmButton.connect("pressed", self, 'confirm_character')
	globals.connecttexttooltip($VBoxContainer/sextrait, tr("TOOLTIPSEXTRAITS"))
	
	for i in ['name','surname','nickname']:
		$VBoxContainer.get_node(i).connect("text_changed", self, 'text_changed', [i])
	
	for i in bodypartsarray:
		$bodyparts.get_node(i).connect("item_selected", self, "select_bodypart", [i, $bodyparts.get_node(i)])
	
	for i in sexbodypartsarray:
		$bodyparts2.get_node(i).connect("item_selected", self, "select_sexbodypart", [i, $bodyparts2.get_node(i)])
	
	for i in ['vaginal_virgin','anal_virgin','penis_virgin']:
		$bodyparts2.get_node(i).connect("pressed", self, "select_checkbox", [i, $bodyparts2.get_node(i)])
	
	open()

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

func select_checkbox(bodypart, node):
	preservedsettings[bodypart] = node.pressed
	
	apply_preserved_settings()
	$descript.bbcode_text = person.make_description()


func open(type = 'slave'):
	preservedsettings.clear()
	
	
	person = globals.characterdata.new()
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
	
	rebuild_slave()

func rebuild_slave():
	var race = person.race
	var sex = person.sex
	var age = person.age
	person = globals.characterdata.new()
	person.create(race, sex, age)
	if mode == 'master':
		person.unlock_class('master')
	
	
	$VBoxContainer/race.text = races.racelist[person.race].name
	$VBoxContainer/sex.select(sexarray.find(person.sex))
	$VBoxContainer/age.select(agearray.find(person.age))
	
	for i in ['name','surname','nickname']:
		if preservedsettings.has(i):
			$VBoxContainer.get_node(i).text = preservedsettings[i]
		else:
			$VBoxContainer.get_node(i).text = person.get(i)
	
	RebuildStatsContainer()
	build_bodyparts()
	apply_preserved_settings()
	$descript.bbcode_text = person.make_description()

func select_age(value):
	person.age = agearray[value]
	rebuild_slave()

func select_sex(value):
	person.sex = sexarray[value]
	rebuild_slave()

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
	$RaceSelection/RichTextLabel.bbcode_text = race.descript
	var text = race.code.to_lower().replace('halfkin','beastkin')
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
		if i.type == 'factor':
			array.append(i)
			if preservedsettings.has(i.code) == false:
				preservedsettings[i.code] = 1
			if i.code in ['growth_factor','brave_factor','tame_factor'] && mode == 'master':
				preservedsettings[i.code] = 5
	
	var counter = total_stat_points
	
	if person.sex_traits.size() == 0:
		$VBoxContainer/sextrait.text = "Select Sex Trait"
	else:
		$VBoxContainer/sextrait.text = Traitdata.sex_traits[person.sex_traits[0]].name
	
	
	for i in array:
		if mode == 'master' && i.code in ["growth_factor",'brave_factor','tame_factor']:
			continue
		var newnode = globals.DuplicateContainerTemplate($StatsContainer)
		newnode.get_node("up").connect("pressed", self, 'stat_up', [i])
		newnode.get_node("down").connect("pressed", self, 'stat_down', [i])
		newnode.get_node("name").text = i.name
		newnode.get_node("Label").text = str(preservedsettings[i.code])
		counter -= preservedsettings[i.code]-1
		newnode.get_node("icon").texture = i.baseicon
		var text = i.descript
		if i.code in ['physics_factor','wits_factor','charm_factor','sexuals_factor']:
			text += '\n\n' + globals.statdata[i.code.replace('_factor', '')].descript
		globals.connecttexttooltip(newnode.get_node("icon"), text)
	
	unassigned_points = counter
	$totalstatlabel.text = 'Free points left: ' + str(counter)

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
			preservedsettings[i] = person.get(i)
		
		
		
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
		
		match person.sex:
			'male':
				$bodyparts2.get_node(i).visible = true
				$bodyparts2.get_node(i + "_label").visible = true
			'female':
				if i in ['penis_size', 'penis_type', 'balls_size']:
					$bodyparts2.get_node(i).visible = false
					$bodyparts2.get_node(i + "_label").visible = false
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
		
		if i in ['vaginal_virgin','anal_virgin','penis_virgin']:
			$bodyparts2.get_node(i).pressed = preservedsettings[i]
		
		$bodyparts2.get_node(i).disabled = $bodyparts2.get_node(i).get_item_count() == 1
	
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
	input_handler.ShowConfirmPanel(self, 'finish_character', 'Create this character?')

func finish_character():
	apply_preserved_settings()
	state.add_slave(person)
	input_handler.emit_signal("CharacterCreated")
	
	self.hide()

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
	else:
		person.sex_traits.clear()
		person.sex_traits.append(trait.code)
	$TraitSelection.hide()
	RebuildStatsContainer()

