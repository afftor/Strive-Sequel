extends tooltip_main

var person

func _init():
	init_timer = 0.01

func showup(node, t_person):
	if _setup(node):
		person = t_person


func update():
	var screen = get_viewport().get_visible_rect()

	if person != null:
		$exp.text = str(floor(person.get_stat('base_exp')))
#		$productivity/Label.text = str(person.get_stat('productivity')) + "%"
		var text = "[center]" + person.get_full_name() + "[/center]"
		input_handler.ClearContainer($TextureRect/professions)
		if person.get_prof_number() > 5:
			$TextureRect/professions.columns = 10
			$TextureRect/professions/Button.rect_min_size = Vector2(45,45)
			$TextureRect/professions/Button/ProfIcon.rect_size = Vector2(34,34)
			$TextureRect/professions/Button/Label.hide()
		else:
			$TextureRect/professions.columns = 5
			$TextureRect/professions/Button.rect_min_size = Vector2(90,90)
			$TextureRect/professions/Button/ProfIcon.rect_size = Vector2(78,78)
#			$TextureRect/professions/Button/Label.show()

		for i in person.get_professions():
			var newnode = input_handler.DuplicateContainerTemplate($TextureRect/professions)
			var prof = classesdata.professions[i]
			var name = ResourceScripts.descriptions.get_class_name(prof, person)
			newnode.get_node("Label").text = name
			newnode.get_node("ProfIcon").texture = prof.icon
		globals.build_attrs_for_char(self, person)
		$RichTextLabel.bbcode_text = text

		for i in ['hp','mp','lust']:
			get_node("base_stats/"+ i ).max_value = person.get_stat(i+'max')
			get_node("base_stats/"+ i ).value = person.get_stat(i)
			get_node("base_stats/"+ i + '/Label').text = str(floor(person.get_stat(i))) + "/" + str(floor(person.get_stat(i+'max')))
		get_node("base_stats/lust").visible = person.check_trait('succubus')
		
		var slavename = "CHARTYPE" + person.get_stat('slave_class').to_upper()
		if person.get_stat('sex') != 'male':
			slavename += "F"
		text = tr('TYPE_LABEL' + ': ' + "[color=yellow]") + person.translate(slavename) + "[/color]\n"
		var gatherable = Items.materiallist.has(person.get_work())
		if person.is_players_character == true:
			if person.get_work() != 'disabled' and person.get_work() != '' and person.get_work() != 'Assignment' and person.get_work() != 'learning':
				if !gatherable:
					text = tasks.tasklist[person.get_work()].name
				else:
					text = Items.materiallist[person.get_work()].progress_formula.capitalize()
			else:
				text += "Occupation: None"
			text += "\n"

		$growth.text = ResourceScripts.descriptions.factor_descripts[int(floor(person.get_stat('growth_factor')))]
		$growth.set("custom_colors/font_color", variables.hexcolordict['factor'+str(int(floor(person.get_stat('growth_factor'))))])
		for i in ['physics','wits','charm']:
			var color = set_color(person.get_stat(i+"_bonus"))
			get_node(i).text = str(floor(person.get_stat(i)))
			get_node(i).set("custom_colors/font_color", color)
			get_node(i+'2').text = str(person.get_stat(i+'_cap') + person.get_stat(i+"_bonus"))
			get_node(i+'2').set("custom_colors/font_color", color)

		text = "[center]" + statdata.statdata.productivity.name + "[/center]\n" + statdata.statdata.productivity.descript + "\nTotal Productivity: " + str(floor(person.get_stat('productivity')))
		for i in variables.productivity_mods:
			if person.get_stat(i) > 1:
				text += "\n{color=green|" + str(round(person.get_stat(i)*100)) + " - " + statdata.statdata[i].name + "}"
			elif person.get_stat(i) < 1:
				text += "\n{color=red|" + str(round(person.get_stat(i)*100)) + " - " + statdata.statdata[i].name + "}"
			else:
				text += "\n" + str(round(person.get_stat(i)*100)) + " - " + statdata.statdata[i].name
#		globals.connecttexttooltip($productivity, globals.TextEncoder(text))
		
		globals.build_buffs_for_char(person, $buffscontainer, 'mansion')
		#idk about showing buffs here - where this scene is shown anyway? 
		input_handler.GetTweenNode(self).stop_all()
		self.modulate.a = 1
#		show()
		var pos = parentnode.get_global_rect()
		pos = Vector2(pos.end.x + 10, pos.position.y)
		self.set_global_position(pos)
		if get_rect().end.x+100 > screen.size.x:
			rect_global_position.x -= get_rect().end.x+100 - screen.size.x
		if get_rect().end.y+125 > screen.size.y:
			rect_global_position.y -= get_rect().end.y+125 - screen.size.y
		set_process(true)
		for i in $factors.get_children():
			if person == ResourceScripts.game_party.get_master() && i.name in ["tame_factor", "authority_factor"]:
				i.hide()
			else:
				i.show()
			if i.name in ['base_exp']:
				# i.get_node("Label").text = str(floor(person.get_stat(i.name)))
				continue
			if input_handler.globalsettings.factors_as_words:
				i.get_node("Label").text = ResourceScripts.descriptions.factor_descripts[int(floor(person.get_stat(i.name)))]
				i.get_node("Label").set("custom_colors/font_color", variables.hexcolordict['factor'+str(int(floor(person.get_stat(i.name))))]) 
			else:
				i.get_node("Label").text = str(floor(person.get_stat(i.name)))
				i.get_node("Label").set("custom_colors/font_color", variables.hexcolordict['factor'+str(int(floor(person.get_stat(i.name))))])
	
		text = ''
		for i in ['chg_strength','chg_dexterity','chg_persuasion','chg_wisdom']:
			if person.get_stat(i + "_max") == 0: continue
			text += statdata.statdata[i].name + ": " +  str(person.get_stat(i+"_max") - person.get_stat(i)) + "/" + str(person.get_stat(i+"_max")) + '\n'
		$Panel2.visible = text != ''
		$Panel2/RichTextLabel.bbcode_text = text
	else:
		hide()
	emit_signal("update_completed")


func set_color(value):
	var color = Color(0.87,0.87,0.87,1)
	if value > 0:
		color = Color(0.31,0.99,0.51,1)
	elif value < 0:
		color = Color(0.99,0.31,0.36,1)
	return color
