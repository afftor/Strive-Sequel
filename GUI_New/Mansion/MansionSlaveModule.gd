extends Panel


onready var MansionMainModule = get_parent()
onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)
var person
var authority_lines = {
	low = "Defiance",
	medium = "Respect",
	high = 'Reverence',
}


# Called when the node enters the scene tree for the first time.
func _ready():
	$CharacterInfoButton.connect("pressed", get_parent(), "mansion_state_set", ["char_info"])
	$TextureRect2/Exp.connect("pressed", self, "open_char_class_info")
	for i in $base_stats.get_children():
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	globals.connecttexttooltip(get_node("TextureRect2/Exp"), statdata.statdata["base_exp"].descript)
	for i in $TextureRect2.get_children():
		if i.name == "Exp":
			continue
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)


func open_char_class_info():
	var slave_info = GUIWorld.gui_data["SLAVE_INFO"].main_module
	GUIWorld.set_current_scene(slave_info)
	slave_info.set_state("class")


func show_slave_info():
	var hovered_person = get_parent().hovered_person
	if hovered_person != null:
		person = hovered_person
	else:
		person = get_parent().active_person
	if person != null:
		$Panel.visible = person != ResourceScripts.game_party.get_master()
		globals.connecttexttooltip($RichTextLabel, person.show_race_description())
		$exp.text = str(floor(person.get_stat('base_exp')))
		$productivity/Label.text = str(person.get_stat('productivity')) + "%"
		var text = person.get_short_name() + person.translate(" [race] [age]")
		input_handler.ClearContainer($TextureRect/professions)
		if person.xp_module.professions.size() > 5:
			$TextureRect/professions.columns = 10
			$TextureRect/professions/Button.rect_min_size = Vector2(45,45)
			$TextureRect/professions/Button/ProfIcon.rect_size = Vector2(34,34)
			$TextureRect/professions/Button/Label.hide()
		else:
			$TextureRect/professions.columns = 5
			$TextureRect/professions/Button.rect_min_size = Vector2(90,90)
			$TextureRect/professions/Button/ProfIcon.rect_size = Vector2(78,78)
#			$TextureRect/professions/Button/Label.show()
			
		for i in person.xp_module.professions:
			var newnode = input_handler.DuplicateContainerTemplate($TextureRect/professions)
			var prof = classesdata.professions[i]
			var name = ResourceScripts.descriptions.get_class_name(prof, person)
			newnode.get_node("Label").text = name
			newnode.get_node("ProfIcon").texture = prof.icon
			newnode.connect('signal_RMB_release',GUIWorld, 'show_class_info', [prof.code, person])
			var temptext = "[center]"+ResourceScripts.descriptions.get_class_name(prof,person) + "[/center]\n"+ResourceScripts.descriptions.get_class_bonuses(person, prof) + ResourceScripts.descriptions.get_class_traits(person, prof)
			temptext += "\n\n{color=aqua|" + tr("CLASSRIGHTCLICKDETAILS") + "}"
			globals.connecttexttooltip(newnode, temptext)
		$Portrait.texture = person.get_icon()
		$sex.texture = images.icons[person.get_stat('sex')]
		$RichTextLabel.bbcode_text = text

		for i in ['hp','mp','lust']:
			get_node("base_stats/"+ i ).max_value = person.get_stat(i+'max')
			get_node("base_stats/"+ i ).value = person.get_stat(i)
			get_node("base_stats/"+ i + '/Label').text = str(floor(person.get_stat(i))) + "/" + str(floor(person.get_stat(i+'max')))
		text = "Type: [color=yellow]" + person.translate(statdata.slave_class_names[person.get_stat('slave_class')]) + "[/color]\n"
		var gatherable = Items.materiallist.has(person.get_work())
		if person.is_players_character == true:
			if person.get_work() != '':
				if !gatherable:
					text = races.tasklist[person.get_work()].name
				else:
					text = Items.materiallist[person.get_work()].progress_formula.capitalize()
			else:
				text += "Occupation: None"
			text += "\n"
			# if state.get_master() != person:
				# if person.obedience > 0 || person.loyalty >= 100 || person.submission >= 100:
				# 	text += "{color=green|Obedience: " 
				# else:
				# 	text += "{color=red|Obedience: " 
				# if person.loyalty < 100 && person.submission < 100:
				# 	text += str(ceil(person.obedience)) + "}"
				# else:
				# 	text += "∞}"
		$job.bbcode_text = globals.TextEncoder(text) 

		for i in ['physics','wits','charm','sexuals']:
			if i != 'sexuals':
				get_node(i).text = str(floor(person.get_stat(i) + person.get_stat(i+'_bonus'))) 
				get_node(i+'2').text = str(person.get_stat(i+'_factor') * 20)
			else:
				get_node(i).text = str(floor(person.get_stat(i) + person.get_stat(i+'_bonus')))
				get_node(i+'2').text = '100'

		text = "[center]" + statdata.statdata.productivity.name + "[/center]\n" + statdata.statdata.productivity.descript + "\nTotal Productivity: " + str(floor(person.get_stat('productivity'))) 
		for i in variables.productivity_mods:
			if person.get_stat(i) > 1:
				text += "\n{color=green|" + str(round(person.get_stat(i)*100)) + " - " + statdata.statdata[i].name + "}"
			elif person.get_stat(i) < 1:
				text += "\n{color=red|" + str(round(person.get_stat(i)*100)) + " - " + statdata.statdata[i].name + "}"
			else:
				text += "\n" + str(round(person.get_stat(i)*100)) + " - " + statdata.statdata[i].name
		globals.connecttexttooltip($productivity, globals.TextEncoder(text))
		var authority_text = ""
		if person.get_stat('loyalty') < 100 && person.get_stat('submission') < 100:
			$Panel/obedlabel.text = str(ceil(person.get_stat('obedience')))
		else:
			$Panel/obedlabel.text = "∞"
		if person.get_stat('obedience') > 0 || person.get_stat('loyalty') >= 100 || person.get_stat('submission') >= 100:
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
		authority_text = authority_lines[authority]
		
		$Panel/authoritylabel.text = 'Authority: ' + authority_text
	
		$Panel/loyaltylabel.value = person.get_stat('loyalty')
		$Panel/submissionlabel.value = person.get_stat('submission')

		globals.connecttexttooltip($Panel/obedlabel/icon, statdata.statdata.obedience.descript)
		globals.connecttexttooltip($Panel/loyaltylabel, statdata.statdata.loyalty.descript)
		globals.connecttexttooltip($Panel/authoritylabel, statdata.statdata.authority.descript)
		globals.connecttexttooltip($Panel/submissionlabel, statdata.statdata.submission.descript)

		input_handler.ClearContainer($buffscontainer)
		for i in person.get_mansion_buffs():
			var newnode = input_handler.DuplicateContainerTemplate($buffscontainer)
			newnode.texture = i.icon
			if i.get_duration() != null and i.get_duration() >= 0:
				newnode.get_node("Label").text = str(i.get_duration())
			else:
				newnode.get_node("Label").hide()
			newnode.hint_tooltip = person.translate(i.description)

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
