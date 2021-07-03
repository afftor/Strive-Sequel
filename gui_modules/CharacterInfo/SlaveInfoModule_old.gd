extends Panel


var person
var authority_lines = {
	low = "Defiance",
	medium = "Respect",
	high = 'Reverence',
}

var universal_skills = ['oral','anal','petting']


func _ready():
	$DietButton.connect("pressed", get_parent(), "set_state", ["diet"])
	$RichTextLabel.connect("meta_hover_started", self, 'text_url_hover')
	$RichTextLabel.connect("meta_hover_ended", self, "text_url_hover_hide")
	for i in variables.resists_list:
		if i == 'all': continue
		var newlabel = $BaseStatsPanel/resists/Label.duplicate()
		var newvalue = $BaseStatsPanel/resists/Value.duplicate()
		$BaseStatsPanel/resists.add_child(newlabel)
		$BaseStatsPanel/resists.add_child(newvalue)
		newlabel.text = i.capitalize() + ":"
		newvalue.name = i
		newlabel.show()
		newvalue.show()
	update()


func set_color(value):
	var color = Color(0.98,0.88,0.51,1)
	if value > 0:
		color = Color(0.31,0.99,0.51,1)  
	elif value < 0:
		color = Color(0.99,0.31,0.36,1)
	return color	

func update():
	person = input_handler.interacted_character
	if person != null:
		$Panel.visible = !person.has_profession("master")
		$MasterIcon.visible = person.has_profession("master")
		var text = ""
		if person.xp_module.check_infinite_obedience() == false:
			$Panel/obedlabel.text = str(ceil(person.xp_module.predict_obed_time()))
		else:
			$Panel/obedlabel.text = "∞"
		if person.xp_module.check_infinite_obedience() == true || person.xp_module.predict_obed_time() > 0:
			$Panel/obedlabel/icon.texture = images.icons.obed_good
		else:
			$Panel/obedlabel/icon.texture = images.icons.obed_bad
	
		var authority
		if person.get_stat('authority') < person.authority_threshold()/2:
			authority = 'low'
		elif person.get_stat('authority') < person.authority_threshold():
			authority = 'medium'
		else:
			authority = 'high'
		text = authority_lines[authority]
		
		$Panel/authoritylabel.text = 'Authority: ' + text
		if authority == "low":
			$Panel/authoritylabel.set("custom_colors/font_color", Color(0.99,0.31,0.36,1))
		else:
			$Panel/authoritylabel.set("custom_colors/font_color", Color(0.98,0.88,0.51,1))
	
		$Panel/loyaltylabel.value = person.get_stat('loyalty')
		$Panel/submissionlabel.value = person.get_stat('submission')
		globals.connecttexttooltip($food_love,"[center]" + statdata.statdata.food_love.name + "[/center]\n"+  statdata.statdata.food_love.descript)
		globals.connecttexttooltip($food_hate,"[center]" + statdata.statdata.food_hate.name + "[/center]\n"+ statdata.statdata.food_hate.descript)
		globals.connecttexttooltip($Panel/obedlabel/icon, statdata.statdata.obedience.descript)
		globals.connecttexttooltip($Panel/loyaltylabel, statdata.statdata.loyalty.descript)
		globals.connecttexttooltip($Panel/authoritylabel, statdata.statdata.authority.descript)
		globals.connecttexttooltip($Panel/submissionlabel, statdata.statdata.submission.descript)	

		for i in $BaseStatsPanel/resists.get_children():
			var tmp = person.get_stat('resists')
			if variables.resists_list.has(i.name):
				i.text = str(tmp[i.name])
				if tmp[i.name] > 0:
					i.set("custom_colors/font_color", variables.hexcolordict.yellow)
				elif tmp[i.name] < 0:
					i.set("custom_colors/font_color", variables.hexcolordict.green)
				else:
					i.set("custom_colors/font_color", variables.hexcolordict.white)
	
		for i in variables.fighter_stats_list:
			if !i in ['hpmax', 'mpmax','critmod']:
				$"BaseStatsPanel/base_stats".get_node(i).text = str(floor(person.get_stat(i)))
			elif i == 'critmod':
				$"BaseStatsPanel/base_stats".get_node(i).text = str(floor(person.get_stat(i)*100))
	
	
		for i in $"BaseStatsPanel/base_stats".get_children():
			if statdata.statdata.has(i.name.replace("label_","")):
				globals.connecttexttooltip(i, statdata.statdata[i.name.replace("label_", "")].descript)
	
		$RichTextLabel.bbcode_text = person.make_description()
		
		# if person.travel.location != 'mansion':
		# 	$RichTextLabel.bbcode_text += "\n\n" + person.translate(make_location_description())
	
		$food_consumption/Label.text = str(floor(person.get_stat("food_consumption")))
		if person.food.food_love != null:
			$food_love/Button.texture = images.icons[person.food.food_love]
			$food_love/Button.hint_tooltip = tr("FOODTYPE" +person.food.food_love.to_upper())
		$food_love/Button.visible = person.food.food_love != null
		input_handler.ClearContainer($food_hate/Container)
		if person.food.food_hate != null:
			for i in person.food.food_hate:
				var newnode = input_handler.DuplicateContainerTemplate($food_hate/Container)
				newnode.texture = images.icons[i]
				newnode.hint_tooltip =  tr("FOODTYPE" +i.to_upper())
		$food_hate/Container.visible = person.food.food_hate != null

		input_handler.ClearContainer($SexSkillsControl/ScrollContainer/VBoxContainer)
		var s_skills = person.get_stat('sex_skills')
		for i in s_skills:
			if s_skills[i] == 0 && universal_skills.find(i) < 0:
				continue
			var newbutton = input_handler.DuplicateContainerTemplate($SexSkillsControl/ScrollContainer/VBoxContainer)
			newbutton.get_node("Label").text = tr("SEXSKILL"+i.to_upper())
			newbutton.get_node("ProgressBar").value = s_skills[i]
			newbutton.get_node("ProgressBar/Label").text = str(floor(s_skills[i])) + '/100'
			globals.connecttexttooltip(newbutton,  person.translate(tr("SEXSKILL"+i.to_upper()+"DESCRIPT")) + "\nCurrent level:" + str(floor(s_skills[i])))
	
		rebuild_traits()
	
		$ConsentLabel.text = "Consent: " + str(floor(person.get_stat('consent')))
		$ConsentLabel.visible = person != ResourceScripts.game_party.get_master()
		if person != ResourceScripts.game_party.get_master():
			$Panel/character_class.text = statdata.slave_class_names[person.get_stat('slave_class')]
			globals.connecttexttooltip($Panel/character_class, tr(person.get_stat('slave_class').to_upper()+"CLASSDESCRIPT"))
		else:
			$Panel/character_class.text = ""




# func make_location_description():
# 	return person.get_current_location_desc()

func rebuild_traits():
	
	input_handler.ClearContainer($ScrollContainer/traits)
	for i in person.statlist.traits:
		var trait = Traitdata.traits[i]
		if trait.visible == false:
			continue
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/traits)
		newnode.text = trait.name
	
	var traits = person.get_all_sex_traits()
	
	for i in traits:
		var trait = Traitdata.sex_traits[i]
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/traits)
		if traits[i] == true:#trait is known
			newnode.text = trait.name
			var traittext = person.translate(trait.descript)
			for j in trait.reqs:
				if j.has('code') && j.code == 'action_type':
					traittext += "\n\nDisliked actions:[color=aqua] "
					for k in j.value:
						globals.sex_actions_dict[k].givers = []
						globals.sex_actions_dict[k].takers = []
						traittext += globals.sex_actions_dict[k].getname() + ", "
					traittext = traittext.substr(0, traittext.length() - 2) + ".[/color]"
			globals.connecttexttooltip(newnode, traittext)
		else:
			newnode.text = tr("TRAITUNKNOWN")
			globals.connecttexttooltip(newnode, person.translate(tr("TRAITUNKNOWNTOOLTIP")))


func text_url_hover(meta):
	match meta:
		'race':
			var texttooltip = input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP) #input_handler.GetTextTooltip()
			texttooltip.showup($RichTextLabel, person.show_race_description())
			yield(get_tree(), 'idle_frame')
			texttooltip.rect_global_position = get_global_mouse_position()
	#globals.connecttexttooltip($RichTextLabel, person.show_race_description())

func text_url_hover_hide(meta = null):
	match meta:
		'race':
			var texttooltip = input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP) #input_handler.GetTextTooltip()
			texttooltip.hide()
