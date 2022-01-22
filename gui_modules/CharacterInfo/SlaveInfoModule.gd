extends Panel


var person
var authority_lines = {
	low = "Defiance",
	medium = "Respect",
	high = 'Reverence',
}

var universal_skills = ['oral','anal','petting']


func _ready():
	$RichTextLabel.connect("meta_clicked", self, 'text_url_click')
	$RichTextLabel.connect("meta_hover_started", self, 'text_url_hover')
	$RichTextLabel.connect("meta_hover_ended", self, "text_url_hover_hide")
	$HairChange/confirm.connect("pressed", self, "confirm_hairstyle")
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
#			$Panel/obedlabel.text = str(ceil(person.xp_module.predict_obed_time()))
			var obed_val = person.get_obed_percent_value()
			$Panel/obedlabel.text = "%d%%" % obed_val
			if obed_val > 40:
				$Panel/obedlabel.set("custom_colors/font_color", variables.hexcolordict.green)
			elif obed_val > 15:
				$Panel/obedlabel.set("custom_colors/font_color", variables.hexcolordict.yellow)
			else:
				$Panel/obedlabel.set("custom_colors/font_color", variables.hexcolordict.red)
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
		
		if person != ResourceScripts.game_party.get_master():
			$Panel/character_class.text = statdata.slave_class_names[person.get_stat('slave_class')]
			globals.connecttexttooltip($Panel/character_class, tr(person.get_stat('slave_class').to_upper()+"CLASSDESCRIPT"))
		else:
			$Panel/character_class.text = ""
		




# func make_location_description():
# 	return person.get_current_location_desc()
func text_url_click(meta):
	match meta:
		'hair':
			$HairChange/hair_style.clear()
			var hairdata = ResourceScripts.descriptions.bodypartsdata.hair_style
			for i in hairdata.values():
				$HairChange/hair_style.add_item(i.name)
				$HairChange/hair_style.set_item_metadata($HairChange/hair_style.get_item_count() - 1, i.code)
				if i.code == person.get_stat('hair_style'):
					$HairChange/hair_style.select($HairChange/hair_style.get_item_count() - 1)
			$HairChange.show()


func confirm_hairstyle():
	person.set_stat('hair_style', $HairChange/hair_style.get_selected_metadata())
	$HairChange.hide()
	update()


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
