extends Panel
var slave_classes = ['slave','servant']
func _ready():
	$descript.connect("meta_hover_started", self, 'text_url_hover')
	$descript.connect("meta_hover_ended", self, "text_url_hover_hide")
	for i in get_parent().bodypartsarray:
		$ScrollContainer/HBoxContainer/bodyparts.get_node(i).connect("item_selected", self, "select_bodypart", [i, $ScrollContainer/HBoxContainer/bodyparts.get_node(i)])

	for i in get_parent().sexbodypartsarray:
		$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).connect("item_selected", self, "select_sexbodypart", [i, $ScrollContainer/HBoxContainer/bodyparts2.get_node(i)])

	for i in ['vaginal_virgin','anal_virgin','penis_virgin']:
		$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).connect("pressed", self, "select_checkbox", [i, $ScrollContainer/HBoxContainer/bodyparts2.get_node(i)])

	$ScrollContainer/HBoxContainer/bodyparts2/diet.connect("pressed", self, 'select_diet')
	for i in variables.personality_array:
		$ScrollContainer/HBoxContainer/bodyparts2/personality.add_item(i.capitalize())
	$ScrollContainer/HBoxContainer/bodyparts2/personality.connect("item_selected", self, "select_personality")
	globals.connecttexttooltip($ScrollContainer/HBoxContainer/bodyparts2/personality, tr("SLAVEPARTPERSONALITYDESCRIPT"))
	for i in slave_classes:
		get_node("ScrollContainer/HBoxContainer/bodyparts2/slave_class").add_item(statdata.slave_class_names[i])
	get_node("ScrollContainer/HBoxContainer/bodyparts2/slave_class").connect("item_selected", self, "select_type", [$ScrollContainer/HBoxContainer/bodyparts2/slave_class])
#	$DietPanel/Button.connect("pressed", self, 'finish_diet_selection')
#	for i in $DietPanel/VBoxContainer.get_children():
#		i.get_node("OptionButton").connect("item_selected", self, "select_food_pref", [i.name])



func build_bodyparts():
	var person = get_parent().person

	var racedata
	if get_parent().preservedsettings.has('race'):
		racedata = races.racelist[get_parent().preservedsettings.race].bodyparts
	else:
		racedata = races.racelist[person.get_stat('race')].bodyparts
	for i in get_parent().bodypartsarray:
		$ScrollContainer/HBoxContainer/bodyparts.get_node(i).clear()
		var current_bodypart
		if get_parent().preservedsettings.has(i) and get_parent().valid_preservedsettings[i]:
			current_bodypart =  get_parent().preservedsettings[i]
		else:
			current_bodypart = person.get_stat(i)
		
		if get_parent().preservedsettings.has(i) == false && current_bodypart != '':
			get_parent().preservedsettings[i] = current_bodypart
			get_parent().valid_preservedsettings[i] = true
			
		# if !racedata.has(i) && get_parent().preservedsettings.has(i):
		# 	get_parent().preservedsettings[i] = ''
		# 	get_parent().person.set_stat(i, "")
		# else:
		# 	if get_parent().preservedsettings.has(i):
		# 		get_parent().preservedsettings[i] = ''
	
		var workarray = []
		if racedata.has(i):
			workarray = racedata[i]
		elif races.racelist.Human.bodyparts.has(i):
			workarray = races.racelist.Human.bodyparts[i]
		var preserved_option_exists = false
		for k in workarray:
			$ScrollContainer/HBoxContainer/bodyparts.get_node(i).add_item(k)
			if get_parent().preservedsettings.has(i) and get_parent().preservedsettings[i] == k:
				preserved_option_exists = true
				$ScrollContainer/HBoxContainer/bodyparts.get_node(i).select($ScrollContainer/HBoxContainer/bodyparts.get_node(i).get_item_count()-1)
	
		if preserved_option_exists:
			get_parent().valid_preservedsettings[i] = true
		else:
			# get_parent().preservedsettings.erase(i)
#			get_parent().preservedsettings[i] = person.get_stat(i)
			get_parent().valid_preservedsettings[i] = false
			#preservedsettings[i] = person.get(i)
			#print(i, person.get(i))
	
		$ScrollContainer/HBoxContainer/bodyparts.get_node(i).disabled = $ScrollContainer/HBoxContainer/bodyparts.get_node(i).get_item_count() == 1
	
		if $ScrollContainer/HBoxContainer/bodyparts.get_node(i).get_item_count() == 0:
			get_parent().valid_preservedsettings[i] = false
	
		$ScrollContainer/HBoxContainer/bodyparts.get_node(i).visible = $ScrollContainer/HBoxContainer/bodyparts.get_node(i).get_item_count() != 0
		$ScrollContainer/HBoxContainer/bodyparts.get_node(i+'_label').visible = $ScrollContainer/HBoxContainer/bodyparts.get_node(i).visible
	for i in get_parent().sexbodypartsarray:
		if i != 'slave_class':
			$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).clear()
		else:
			if get_parent().preservedsettings.has(i) and get_parent().valid_preservedsettings[i]:
				$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).select(slave_classes.find(get_parent().preservedsettings[i]))
		var current_bodypart = person.get_stat(i)
		
		if get_parent().preservedsettings.has(i) == false && current_bodypart != '':
			get_parent().preservedsettings[i] = current_bodypart
			get_parent().valid_preservedsettings[i] = true
		
		if i == 'penis_type' && racedata.has(i) && !racedata[i].has(get_parent().preservedsettings[i]):
			person.set_stat(i, racedata[i][randi()%racedata[i].size()])
#			get_parent().preservedsettings[i] = person.get_stat(i)
			get_parent().valid_preservedsettings[i] = false
		elif i == 'penis_type' && racedata.has(i) == false && get_parent().preservedsettings[i] != 'human':
			person.set_stat(i, 'human')
			get_parent().valid_preservedsettings[i] = false
#			get_parent().preservedsettings[i] = person.get_stat(i)
		
		match person.get_stat('sex'):
			'male':
				$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).visible = true
				$ScrollContainer/HBoxContainer/bodyparts2.get_node(i + "_label").visible = true
			'female':
				if i in ['penis_size', 'penis_type', 'balls_size']:
					$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).visible = false
					$ScrollContainer/HBoxContainer/bodyparts2.get_node(i + "_label").visible = false
					person.set_stat(i, '')
					get_parent().valid_preservedsettings[i] = false
#					get_parent().preservedsettings.erase(i)
			'futa':
				if i == 'balls_size':
					if input_handler.globalsettings.futa_balls == false:
						$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).visible = false
						$ScrollContainer/HBoxContainer/bodyparts2.get_node(i + "_label").visible = false
						get_parent().valid_preservedsettings[i] = false
#						get_parent().preservedsettings.erase(i)
					else:
						$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).visible = true
						$ScrollContainer/HBoxContainer/bodyparts2.get_node(i + "_label").visible = true
				elif i in ['penis_size', 'penis_type']:
					$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).visible = true
					$ScrollContainer/HBoxContainer/bodyparts2.get_node(i + "_label").visible = true
		
		var sel_stat
		if get_parent().preservedsettings.has(i) and get_parent().valid_preservedsettings[i]:
			sel_stat = get_parent().preservedsettings[i]
		else:
			sel_stat = person.get_stat(i)
		if person.get_stat('sex') == 'male':
			match i:
				'penis_size', 'balls_size':
					for k in get_parent().short_sizes:
						$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).add_item(k)
						if  sel_stat == k:
							$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).select($ScrollContainer/HBoxContainer/bodyparts2.get_node(i).get_item_count()-1)
				'tits_size', 'ass_size':
					for k in get_parent().malesizes:
						$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).add_item(k)
						if sel_stat == k:
							$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).select($ScrollContainer/HBoxContainer/bodyparts2.get_node(i).get_item_count()-1)
		else:
			match i:
				'penis_size', 'balls_size':
					for k in get_parent().short_sizes:
						$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).add_item(k)
						if sel_stat == k:
							$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).select($ScrollContainer/HBoxContainer/bodyparts2.get_node(i).get_item_count()-1)
	
				'tits_size', 'ass_size':
					for k in get_parent().sizes:
						$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).add_item(k)
						if sel_stat == k:
							$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).select($ScrollContainer/HBoxContainer/bodyparts2.get_node(i).get_item_count()-1)
	
		if i == 'penis_type':
			$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).add_item(person.get_stat('penis_type'))

		$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).disabled = $ScrollContainer/HBoxContainer/bodyparts2.get_node(i).get_item_count() == 1
	
	for i in ['vaginal_virgin','anal_virgin','penis_virgin']:
		$ScrollContainer/HBoxContainer/bodyparts2.get_node(i).pressed = person.get_stat(i)
	
	match person.get_stat('sex'):
		'male':
			$ScrollContainer/HBoxContainer/bodyparts2/penis_virgin.visible = true
			$ScrollContainer/HBoxContainer/bodyparts2/vaginal_virgin.visible = false
		'female':
			$ScrollContainer/HBoxContainer/bodyparts2/vaginal_virgin.visible = true
			$ScrollContainer/HBoxContainer/bodyparts2/penis_virgin.visible = false
		'futa':
			$ScrollContainer/HBoxContainer/bodyparts2/penis_virgin.visible = true
			$ScrollContainer/HBoxContainer/bodyparts2/vaginal_virgin.visible = true
	
	$ScrollContainer/HBoxContainer/bodyparts2/personality.visible = get_parent().mode != 'master'
	$ScrollContainer/HBoxContainer/bodyparts2/label_personality.visible = get_parent().mode != 'master'
	$ScrollContainer/HBoxContainer/bodyparts2/personality.select(variables.personality_array.find(person.get_stat('personality')))
	$ScrollContainer/HBoxContainer/bodyparts2/slave_class_label.visible = get_parent().mode != 'master'
	$ScrollContainer/HBoxContainer/bodyparts2/slave_class.visible = get_parent().mode != 'master'


func select_bodypart(value, bodypart, node):
	var person = get_parent().person
	get_parent().preservedsettings[bodypart] = node.get_item_text(value)
	get_parent().valid_preservedsettings[bodypart] = true

	get_parent().apply_preserved_settings()
	$descript.bbcode_text = person.make_description()

func select_sexbodypart(value, bodypart, node):
	var person = get_parent().person
	var rval = node.get_item_text(value)
	if bodypart == 'slave_class' and rval == 'peon':
		rval = 'servant'
	get_parent().preservedsettings[bodypart] = rval
	get_parent().valid_preservedsettings[bodypart] = true
	
	get_parent().apply_preserved_settings()
	$descript.bbcode_text = person.make_description()

func select_type(value, node):
	var person = get_parent().person
	get_parent().preservedsettings.slave_class = get_parent().slave_classes[value]
	get_parent().valid_preservedsettings['slave_class'] = true

func select_checkbox(bodypart, node):
	var person = get_parent().person
	get_parent().preservedsettings[bodypart] = node.pressed
	get_parent().valid_preservedsettings[bodypart] = true

	get_parent().apply_preserved_settings()
	$descript.bbcode_text = person.make_description()


func select_personality(value):
	get_parent().preservedsettings.personality = variables.personality_array[value]
	get_parent().valid_preservedsettings.personality = true


func text_url_hover(meta):
	var person = get_parent().person
	match meta:
		'race':
			var texttooltip = input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP) #input_handler.GetTextTooltip()
			texttooltip.showup($descript, person.show_race_description())
			yield(get_tree(), 'idle_frame')
			texttooltip.rect_global_position = get_global_mouse_position()
	#globals.connecttexttooltip($RichTextLabel, person.show_race_description())

func text_url_hover_hide(meta = null):
	match meta:
		'race':
			var texttooltip = input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP) #input_handler.GetTextTooltip()
			texttooltip.hide()
