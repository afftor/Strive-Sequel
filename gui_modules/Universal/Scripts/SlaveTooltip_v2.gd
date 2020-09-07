extends Panel


#onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)
var person
var authority_lines = {
	low = "Defiance",
	medium = "Respect",
	high = 'Reverence',
}

var parentnode
var shutoff = false
var prevnode


func _process(delta):
	if parentnode != null && weakref(parentnode).get_ref() != null && ( parentnode.is_visible_in_tree() == false || !parentnode.get_global_rect().has_point(get_global_mouse_position())):
		set_process(false)
		hide_tooltip()


func _init():
	set_process(false)



func showup(node, person):
	$Panel.visible = !person.has_profession("master")
	parentnode = node
	var screen = get_viewport().get_visible_rect()
	if shutoff == true && prevnode == parentnode:
		return

	if person != null:
		$exp.text = str(floor(person.get_stat('base_exp')))
#		$productivity/Label.text = str(person.get_stat('productivity')) + "%"
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
			# newnode.connect('signal_RMB_release',GUIWorld, 'show_class_info', [prof.code, person])
			# var temptext = "[center]"+ResourceScripts.descriptions.get_class_name(prof,person) + "[/center]\n"+ResourceScripts.descriptions.get_class_bonuses(person, prof) + ResourceScripts.descriptions.get_class_traits(person, prof)
			# temptext += "\n\n{color=aqua|" + tr("CLASSRIGHTCLICKDETAILS") + "}"
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

		# for i in ['physics','wits','charm','sexuals']:
		# 	if i != 'sexuals':
		# 		get_node(i).text = str(floor(person.get_stat(i))) 
		# 		get_node(i+'2').text = str(person.get_stat(i+'_factor') * 20)
		# 	else:
		# 		get_node(i).text = str(floor(person.get_stat(i)))
		# 		get_node(i+'2').text = '100'

		for i in ['physics','wits','charm','sexuals']:
			if i != 'sexuals':
				var color = set_color(person.get_stat(i+"_bonus"))
				get_node(i).text = str(floor(person.get_stat(i)))
				get_node(i).set("custom_colors/font_color", color)
				get_node(i+'2').text = str(person.get_stat(i+'_factor') * 20)
			else:
				var color = set_color(person.get_stat(i+"_bonus"))
				get_node(i).text = str(floor(person.get_stat(i)))
				get_node(i).set("custom_colors/font_color", color)
				get_node(i+'2').text = '100'

		text = "[center]" + statdata.statdata.productivity.name + "[/center]\n" + statdata.statdata.productivity.descript + "\nTotal Productivity: " + str(floor(person.get_stat('productivity'))) 
		for i in variables.productivity_mods:
			if person.get_stat(i) > 1:
				text += "\n{color=green|" + str(round(person.get_stat(i)*100)) + " - " + statdata.statdata[i].name + "}"
			elif person.get_stat(i) < 1:
				text += "\n{color=red|" + str(round(person.get_stat(i)*100)) + " - " + statdata.statdata[i].name + "}"
			else:
				text += "\n" + str(round(person.get_stat(i)*100)) + " - " + statdata.statdata[i].name
#		globals.connecttexttooltip($productivity, globals.TextEncoder(text))
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


		input_handler.ClearContainer($buffscontainer)
		for i in person.get_mansion_buffs():
			var newnode = input_handler.DuplicateContainerTemplate($buffscontainer)
			newnode.texture = i.icon
			if i.get_duration() != null and i.get_duration() >= 0:
				newnode.get_node("Label").text = str(i.get_duration())
			else:
				newnode.get_node("Label").hide()
			# newnode.hint_tooltip = person.translate(i.description)

		prevnode = parentnode

		input_handler.GetTweenNode(self).stop_all()
		self.modulate.a = 1
		
		show()
		
		var pos = node.get_global_rect()
		pos = Vector2(pos.end.x + 10, pos.position.y)
		self.set_global_position(pos)
		
		if get_rect().end.x+100 > screen.size.x:
			rect_global_position.x -= get_rect().end.x+100 - screen.size.x
		if get_rect().end.y+125 > screen.size.y:
			rect_global_position.y -= get_rect().end.y+125 - screen.size.y

		set_process(true)


func cooldown():
	shutoff = true
	yield(get_tree().create_timer(0.2), 'timeout')
	shutoff = false



func hide_tooltip():
	parentnode = null
	set_process(false)
	ResourceScripts.core_animations.FadeAnimation(self, 0.2)
	hide()
	

func set_color(value):
	var color = Color(0.87,0.87,0.87,1)
	if value > 0:
		color = Color(0.31,0.99,0.51,1)  
	elif value < 0:
		color = Color(0.99,0.31,0.36,1)
	return color
