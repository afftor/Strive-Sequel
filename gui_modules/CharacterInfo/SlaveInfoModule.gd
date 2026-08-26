extends Control


var person

var universal_skills = ['oral','anal','petting']
const TEX_FOOD_STARVING = preload("res://assets/images/iconsitems/food_old.png")

onready var traitlist = $TraitContainer/HBoxContainer
onready var traitlist2 = $TraitContainer2/HBoxContainer
onready var sextraits = $SexTraitsPanel
onready var race_label = $Panel/maininfo/Race/label
onready var race_label_font = race_label.get_font("font")


func _ready():
	$Description/RichTextLabel.connect("meta_clicked", self, 'text_url_click')
	$Description/RichTextLabel.connect("meta_hover_started", self, 'text_url_hover')
	$Description/RichTextLabel.connect("meta_hover_ended", self, "text_url_hover_hide")
	$HairChange/screen.connect("pressed", self, "close_hairstyle")
	$DescriptionButton.connect("pressed", self, 'toggle_description')
	get_node('panel4').connect('toggled', self, 'toggle_sex_traits')

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
	if person != input_handler.interacted_character:
		person = input_handler.interacted_character
	sextraits.hide()
	$panel4.pressed = false
	sextraits.build_sex_traits()
	if person != null:
		#$Panel/character_class.visible = !person.has_profession("master")
		$Panel/maininfo/price.visible = !person.has_profession("master")
		$Panel/maininfo/standing.visible = !person.is_master()
		#$Panel/MasterIcon.visible = person.has_profession("master")
		var text = ""
		if person.is_master():
			text = tr("SIBLINGMODULECONSENT") + tr("MASTER")
			globals.connecttexttooltip($ConsentLabel, person.translate(tr("INFOCONSENTMASTER")))
		else:
			text = tr("SIBLINGMODULECONSENT") + str(tr(variables.consent_dict[int(person.get_stat('consent'))]))
			globals.connecttexttooltip($ConsentLabel, tr("INFOCONSENT"))
		$ConsentLabel.text = text
		
		$Panel/maininfo/Race/icon.texture = races.racelist[person.get_stat('race')].icon
		race_label.text = races.racelist[person.get_stat('race')].name
		race_label.set("custom_fonts/font", race_label_font)
		input_handler.font_size_adjust(race_label)
		globals.connecttexttooltip($Panel/maininfo/Race, "[center]{color=green|"+ races.racelist[person.get_stat('race')].name +"}[/center]\n\n"+ person.show_race_description())
		
		var slavename = "CHARTYPE" + person.get_stat('slave_class').to_upper()
		globals.connecttexttooltip($Panel/maininfo/type, person.translate(tr(slavename + "DESCRIPT")))
		if person.get_stat('sex') != 'male':
			slavename += "F"
		
		$Panel/maininfo/type/icon.texture = person.get_class_icon()
		$Panel/maininfo/type/label.text = tr(slavename)
		
		$Panel/maininfo/price/label.text = str(person.calculate_price(false, false, true))
		var character_tax = person.get_weekly_tax()
		if character_tax > 0:
			$Panel/maininfo/price/label.text += " (%d)" % character_tax
		var value_tooltip = tr("TOOLTIPVALUE") + '\n\n' + person.get_price_composition()
		if character_tax > 0:
			value_tooltip += "\n%s: {color=yellow|%d} (%d + %d)" % [
				tr("FAMEDESC_UPKEEP"),
				character_tax,
				person.get_upkeep(),
				person.get_value_upkeep()
			]
		globals.connecttexttooltip($Panel/maininfo/price, value_tooltip)
		$Panel/maininfo/fame/label.text = tr(person.get_fame_bonus('name'))
		globals.connecttexttooltip($Panel/maininfo/fame,
			person.translate(
			tr("TOOLTIPFAME") +"\n\n"+"{color=yellow|"+tr(person.get_fame_bonus('desc'))+"}")
			+ "\n" + person.get_fame_bonus_desc()
			)
		
		$Panel/maininfo/personality/label.text = tr("PERSONALITYNAME" + person.get_stat("personality").to_upper())
		$Panel/maininfo/personality/icon.texture = personality_icons[person.get_stat('personality')]
		$Panel/maininfo/standing/label.text = person.get_character_standing()
		globals.connecttexttooltip($Panel/maininfo/standing, build_standing_tooltip())
		
		globals.connecttexttooltip($Panel/maininfo/personality, globals.get_character_personality_tooltip(person.get_stat('personality')))
		$Description/RichTextLabel.bbcode_text = person.make_description()
		
		update_food_panel()
		update_traitlist()


func update_food_panel():
	var love = person.food.food_love
	var has_love = love != null and love != ''
	$FoodPreference/Icon.visible = has_love
	$FoodPreference/Value.text = tr("FOODTYPE" + love.to_upper()) if has_love else ''
	if has_love:
		$FoodPreference/Icon.texture = images.get_icon(love)
	var preference_tooltip = "[center]" + tr("STATFOOD_LOVE") + "[/center]"
	if has_love:
		preference_tooltip += "\n" + tr("FOODTYPE" + love.to_upper())
	preference_tooltip += "\n\n" + tr("STATFOOD_LOVEDESCRIPT")
	globals.connecttexttooltip($FoodPreference, preference_tooltip)

	var state = person.food.get_state()
	$LastMeal/Icon.visible = false
	$LastMeal/Icon.modulate = Color(1, 1, 1)
	match state.state:
		'undead':
			$LastMeal/Value.text = tr("FOODSTATEUNDEAD")
		'starving':
			$LastMeal/Icon.visible = true
			$LastMeal/Icon.texture = TEX_FOOD_STARVING
			$LastMeal/Value.text = tr("FOODSTATESTARVING")
		'none':
			$LastMeal/Value.text = tr("FOODSTATENONE")
		_:
			var item = Items.materiallist[state.meal]
			$LastMeal/Icon.visible = true
			$LastMeal/Icon.texture = item.icon
			$LastMeal/Icon.modulate = Color(1, 0.5, 0.5) if state.state == 'poor' else Color(1, 1, 1)
			$LastMeal/Value.text = "%s (%d)" % [item.name, state.fed]
	globals.connecttexttooltip($LastMeal, globals.get_food_state_tooltip(person))


func build_standing_tooltip():
	var text = person.translate(tr("TOOLTIPCHARACTERSTANDING"))
	var standing_code = person.get_character_standing_code()
	var effect_code = 'e_' + standing_code
	if person.has_status(standing_code) and Effectdata.effect_table.has(effect_code):
		var effect = Effectdata.effect_table[effect_code]
		text += "\n\n[center]{color=yellow|%s}[/center]\n%s" % [
			tr('TRAIT' + standing_code.to_upper()),
			person.translate(tr('TRAIT' + standing_code.to_upper() + 'DESCRIPT')),
		]
		var bonus_text = person.translate(globals.build_desc_for_bonusstats(effect.statchanges).strip_edges())
		if bonus_text != "":
			text += "\n" + bonus_text
	return text

var personality_icons = {
	bold = load("res://assets/Textures_v2/MANSION/personality_bold.png"),
	kind = load("res://assets/Textures_v2/MANSION/personality_kind.png"),
	shy = load("res://assets/Textures_v2/MANSION/personality_shy.png"),
	serious = load("res://assets/Textures_v2/MANSION/personality_serious.png"),
	neutral = load("res://assets/Textures_v2/MANSION/personality_neutral.png"),
	
}


func update_traitlist():
	globals.build_traitlist_for_char(person, traitlist)
	globals.build_training_traitlist(person, traitlist2)


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
			$HairChange/hair_style.set_global_position(get_viewport().get_mouse_position() - Vector2($HairChange/hair_style.rect_size.x, 0))
			


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


func toggle_sex_traits(val):
	if val:
		sextraits.build_sex_traits()
	sextraits.visible = val



