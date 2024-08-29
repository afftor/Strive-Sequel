extends Panel


#var person

var universal_skills = ['oral','anal','petting']
var current_person

func _ready():
	$RichTextLabel.connect("meta_hover_started", self, 'text_url_hover')
	$RichTextLabel.connect("meta_hover_ended", self, "text_url_hover_hide")
	$Panel/authoritylabel.visible = false
	$Panel/loyaltylabel.visible = false
	$Panel/submissionlabel.visible = false
	$Panel/authoritylabel2.visible = false
	$Panel/authoritylabel3.visible = false
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
#	update()


func update(person = null, from_dialogue = false):
	# get_parent().get_parent().submodules.append(self)
	if person == null:
		person = gui_controller.exploration_city.person_to_hire
		current_person = person
		from_dialogue = false
	else:
		current_person = person
	if person != null:
		var text = ""
		$Panel/personality.text = tr("PERSONALITYCURRENT") + "\n" + tr("PERSONALITYNAME" + person.get_stat('personality').to_upper())
		globals.connecttexttooltip($Panel/personality, tr("INFOPERSONALITY" + person.get_stat('personality').to_upper()))
		
#		if from_dialogue:
#			$Panel/authoritylabel.visible = person.is_known_to_player
#			$Panel/loyaltylabel.visible = person.is_known_to_player
#			$Panel/submissionlabel.visible = person.is_known_to_player
#			$Panel/authoritylabel2.visible = person.is_known_to_player
#			$Panel/authoritylabel3.visible = person.is_known_to_player
#		else:
#			var expnode = gui_controller.exploration_city
#			$Panel/authoritylabel.visible = expnode.hiremode != "hire"
#			$Panel/loyaltylabel.visible = expnode.hiremode != "hire"
#			$Panel/submissionlabel.visible = expnode.hiremode != "hire"
#			$Panel/authoritylabel2.visible = expnode.hiremode != "hire"
#			$Panel/authoritylabel3.visible = expnode.hiremode != "hire"

		globals.connecttexttooltip($food_love,"[center]" +statdata.statdata.food_love.name + "[/center]\n"+  statdata.statdata.food_love.descript)
		globals.connecttexttooltip($food_hate,"[center]" +statdata.statdata.food_hate.name + "[/center]\n"+ statdata.statdata.food_hate.descript)
		
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
	
		$RichTextLabel.bbcode_text =  ResourceScripts.descriptions.trim_tag(person.make_description(), 'url', 'hair')
		
		# if person.travel.location != 'mansion':
		# 	$RichTextLabel.bbcode_text += "\n\n" + person.translate(make_location_description())
	
		$food_consumption/Label.text = str(floor(person.get_stat("food_consumption")))
		if person.food.food_love != null:
			$food_love/Button.texture = images.icons[person.food.food_love]
			$food_love/Button.hint_tooltip = tr("FOODTYPE" +person.food.food_love.to_upper())
		$food_love/Button.visible =  person.food.food_love != null
		input_handler.ClearContainer($food_hate/Container)
		if person.food.food_hate != null:
			for i in person.food.food_hate:
				var newnode = input_handler.DuplicateContainerTemplate($food_hate/Container)
				newnode.texture = images.icons[i]
				newnode.hint_tooltip =  tr("FOODTYPE" +i.to_upper())
		$food_hate/Container.visible = person.food.food_hate != null

		input_handler.ClearContainer($SexSkills/VBoxContainer)
		var s_skills = person.get_stat('sex_skills')
		for i in s_skills:
			if s_skills[i] == 0 && universal_skills.find(i) < 0:
				continue
			var newbutton = input_handler.DuplicateContainerTemplate($SexSkills/VBoxContainer)
			newbutton.get_node("Label").text = tr("SEXSKILL"+i.to_upper())
			newbutton.get_node("ProgressBar").value = s_skills[i]
			newbutton.get_node("ProgressBar/Label").text = str(floor(s_skills[i])) + '/100'
			globals.connecttexttooltip(newbutton,  person.translate(tr("SEXSKILL"+i.to_upper()+"DESCRIPT")) + "\nCurrent level:" + str(floor(s_skills[i])))
	
		rebuild_traits()
	
		$ConsentLabel.text = "Consent: " + str(floor(person.get_stat('consent')))
		if person != ResourceScripts.game_party.get_master():
			$Panel/character_class.text = tr(statdata.slave_class_names[person.get_stat('slave_class')].to_upper())
			globals.connecttexttooltip($Panel/character_class, tr(person.get_stat('slave_class').to_upper()+"CLASSDESCRIPT"))
		else:
			$Panel/character_class.text = ""




# func make_location_description():
# 	return person.get_current_location_desc()

func rebuild_traits():
#	var person = gui_controller.exploration.person_to_hire
#	if person == null:
#		person = current_person
	input_handler.ClearContainer($ScrollContainer/traits)
#	for i in person.statlist.traits: #this is counterintuitive - for those are listed under "sex traits" ingame - and there are a lot of them here
#		var trait = Traitdata.traits[i]
#		if trait.visible == false:
#			continue
#		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/traits)
#		newnode.text = trait.name
	
	var traits = current_person.get_all_sex_traits()
	
	for i in traits:
		var trait = Traitdata.sex_traits[i]
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/traits)
		if traits[i] == true:#trait is known
			newnode.text = trait.name
			var traittext = current_person.translate(trait.descript)
			for j in trait.reqs:
				if j.has('code') && j.code == 'action_type':
					traittext += "\n\n" + tr("DISLIKED_ACTIONS_LABEL") + ":[color=aqua] "
					for k in j.value:
						globals.sex_actions_dict[k].givers = []
						globals.sex_actions_dict[k].takers = []
						traittext += globals.sex_actions_dict[k].getname() + ", "
					traittext = traittext.substr(0, traittext.length() - 2) + ".[/color]"
			globals.connecttexttooltip(newnode, traittext)
		else:
			newnode.text = tr("TRAITUNKNOWN")
			globals.connecttexttooltip(newnode, current_person.translate(tr("TRAITUNKNOWNTOOLTIP")))
	

func text_url_hover(meta):
	var person
	if current_person == null:
		person = gui_controller.exploration_city.person_to_hire
	else: 
		person = current_person
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
