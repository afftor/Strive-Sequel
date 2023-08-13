extends Panel


var person

var universal_skills = ['oral','anal','petting']

onready var traitlist = $ScrollContainer/HBoxContainer

func _ready():
	$RichTextLabel.connect("meta_clicked", self, 'text_url_click')
	$RichTextLabel.connect("meta_hover_started", self, 'text_url_hover')
	$RichTextLabel.connect("meta_hover_ended", self, "text_url_hover_hide")
	$HairChange/screen.connect("pressed", self, "close_hairstyle")
	globals.connecttexttooltip($Panel/loyaltylabel, tr("TOOLTIPLOYALTYOBEDIENCE"))
	globals.connecttexttooltip($Panel/valuelabel, tr("TOOLTIPVALUE"))
	
	for i in variables.resists_list:
		if i == 'all': continue
		var newlabel = $BaseStatsPanel/resists/Label.duplicate()
		var newvalue = $BaseStatsPanel/resists/Value.duplicate()
		$BaseStatsPanel/resists.add_child(newlabel)
		$BaseStatsPanel/resists.add_child(newvalue)
		newlabel.text = tr(i.to_upper() + "RESIST") + ":"
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
		if person.check_infinite_obedience() == false:
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
		if person.check_infinite_obedience() == true || person.predict_obed_time() > 0:
			$Panel/obedlabel/icon.texture = images.icons.obed_good
		else:
			$Panel/obedlabel/icon.texture = images.icons.obed_bad
	
	
		$Panel/loyaltylabel.text = tr("SIMLOYALTYGAIN") + ": " + str(stepify(person.get_stat('loyalty_gain'),0.1)) + "\n" + tr("SIMOBEDIENCEDRAIN") + ": " + str(person.get_stat("obedience_drain"))
		globals.connecttexttooltip($Panel/obedlabel/icon, statdata.statdata.obedience.descript)
		$Panel/valuelabel.text = str(person.calculate_price())
#		globals.connecttexttooltip($Panel/loyaltylabel, statdata.statdata.loyalty.descript)
		#globals.connecttexttooltip($Panel/loyaltylabel, "%.1f" % person.get_stat('loyalty'))

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
			$Panel/character_class.text = tr(statdata.slave_class_names[person.get_stat('slave_class')].to_upper())
			globals.connecttexttooltip($Panel/character_class, tr(person.get_stat('slave_class').to_upper()+"CLASSDESCRIPT"))
		else:
			$Panel/character_class.text = ""
	
	update_traitlist()


func update_traitlist():
	globals.build_traitlist_for_char(person, traitlist)


# func make_location_description():
# 	return person.get_current_location_desc()
func text_url_click(meta):
	match meta:
		'hair':
			input_handler.ClearContainer($HairChange/hair_style)
			var hairdata = ResourceScripts.descriptions.bodypartsdata.hair_style
			$HairChange.visible = true
			for i in hairdata.values():
				var panel = input_handler.DuplicateContainerTemplate($HairChange/hair_style)
				panel.text = tr(i.name)
				panel.connect('pressed', self, 'confirm_hairstyle', [i.code])
			$HairChange/screen.set_global_position(Vector2(0, 0))
			$HairChange/hair_style.set_global_position(get_viewport().get_mouse_position())
			


func confirm_hairstyle(style):
	person.set_stat('hair_style', style)
	person.set_stat('portrait_update', true)
	$HairChange.visible = false
	update()
	get_parent().update()


func close_hairstyle():
	$HairChange.visible = false


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
