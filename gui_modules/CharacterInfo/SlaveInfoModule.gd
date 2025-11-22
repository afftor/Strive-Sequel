extends Panel


var person

var universal_skills = ['oral','anal','petting']

onready var traitlist = $TraitContainer/HBoxContainer

func _ready():
	$Description/RichTextLabel.connect("meta_clicked", self, 'text_url_click')
	$Description/RichTextLabel.connect("meta_hover_started", self, 'text_url_hover')
	$Description/RichTextLabel.connect("meta_hover_ended", self, "text_url_hover_hide")
	$HairChange/screen.connect("pressed", self, "close_hairstyle")
	$DescriptionButton.connect("pressed", self, 'toggle_description')
	
	
	update()

func toggle_description():
	$Description.visible = !$Description.visible

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
		#$Panel/character_class.visible = !person.has_profession("master")
		$Panel/maininfo/price.visible = !person.has_profession("master")
		#$Panel/MasterIcon.visible = person.has_profession("master")
		var text = ""
		if person.is_master():
			text = tr("SIBLINGMODULECONSENT") + tr("MASTER")
			globals.connecttexttooltip($ConsentLabel, person.translate(tr("INFOCONSENTMASTER")))
		else:
			text = tr("SIBLINGMODULECONSENT") + str(tr(variables.consent_dict[int(person.get_stat('consent'))]))
			globals.connecttexttooltip($ConsentLabel, tr("INFOCONSENT"))
		$ConsentLabel.text = text
		
		
		
		#$Panel/character_class.text = tr(slavename)
		
		
		
		$Panel/maininfo/Race/icon.texture = races.racelist[person.get_stat('race')].icon
		$Panel/maininfo/Race/label.text = races.racelist[person.get_stat('race')].name
		globals.connecttexttooltip($Panel/maininfo/Race, "[center]{color=green|"+ races.racelist[person.get_stat('race')].name +"}[/center]\n\n"+ person.show_race_description())
		
		var slavename = "CHARTYPE" + person.get_stat('slave_class').to_upper()
		globals.connecttexttooltip($Panel/maininfo/type, person.translate(tr(slavename + "DESCRIPT")))
		if person.get_stat('sex') != 'male':
			slavename += "F"
		
		$Panel/maininfo/type/icon.texture = person.get_class_icon()
		$Panel/maininfo/type/label.text = tr(slavename)
		
		
		
		$Panel/maininfo/price/label.text = str(person.calculate_price(false, false, true))
		globals.connecttexttooltip($Panel/maininfo/price,
			tr("TOOLTIPVALUE") + '\n\n' + person.get_price_composition())
		$Panel/maininfo/fame/label.text = tr(person.get_fame_bonus('name'))
		globals.connecttexttooltip($Panel/maininfo/fame,
			person.translate(
			tr("TOOLTIPFAME") +"\n\n"+"{color=yellow|"+tr(person.get_fame_bonus('desc'))+"}")
			+ "\n" + person.get_fame_bonus_desc()
			)
#		globals.connecttexttooltip($Panel/loyaltylabel, statdata.statdata.loyalty.descript)
		#globals.connecttexttooltip($Panel/loyaltylabel, "%.1f" % person.get_stat('loyalty'))
#
#		for i in $BaseStatsPanel/resists.get_children():
#			if !statdata.statdata.has('resist_' + i.name):
#				continue
#			var tmp = person.get_stat('resist_' + i.name)
#			i.text = str(tmp)
#			if tmp > 0:
#				i.set("custom_colors/font_color", variables.hexcolordict.yellow)
#			elif tmp < 0:
#				i.set("custom_colors/font_color", variables.hexcolordict.green)
#			else:
#				i.set("custom_colors/font_color", variables.hexcolordict.white)
#
#		for i in variables.fighter_stats_list:
#			if !i in ['hpmax', 'mpmax','critmod']:
#				$"BaseStatsPanel/base_stats".get_node(i).text = str(floor(person.get_stat(i)))
#			elif i == 'critmod':
#				$"BaseStatsPanel/base_stats".get_node(i).text = str(floor(person.get_stat(i)*100))
#
#
#		for i in $"BaseStatsPanel/base_stats".get_children():
#			if statdata.statdata.has(i.name.replace("label_","")):
#				globals.connecttexttooltip(i, statdata.statdata[i.name.replace("label_", "")].descript)
	
		$Description/RichTextLabel.bbcode_text = person.make_description()
		
		# if person.travel.location != 'mansion':
		# 	$RichTextLabel.bbcode_text += "\n\n" + person.translate(make_location_description())
		
		
		
		
		
#		if !person.is_master():
#			$Panel/character_class.text = tr(statdata.slave_class_names[person.get_stat('slave_class')].to_upper())
#			globals.connecttexttooltip($Panel/character_class, tr(person.get_stat('slave_class').to_upper()+"CLASSDESCRIPT"))
#		else:
#			$Panel/character_class.text = ""
	
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
			texttooltip.showup($Description/RichTextLabel, person.show_race_description())
			yield(get_tree(), 'idle_frame')
			texttooltip.rect_global_position = get_global_mouse_position()
	#globals.connecttexttooltip($RichTextLabel, person.show_race_description())

func text_url_hover_hide(meta = null):
	match meta:
		'race':
			var texttooltip = input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP) #input_handler.GetTextTooltip()
			texttooltip.hide()
