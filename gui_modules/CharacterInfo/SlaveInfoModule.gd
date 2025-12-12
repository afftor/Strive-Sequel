extends Control


var person

var universal_skills = ['oral','anal','petting']

onready var traitlist = $TraitContainer/HBoxContainer
onready var upgrades = $UpgradesPanel
onready var sextraits = $SexTraitsPanel
onready var trainings_selector = $tr_selector
var curr_tab


func _ready():
	$Description/RichTextLabel.connect("meta_clicked", self, 'text_url_click')
	$Description/RichTextLabel.connect("meta_hover_started", self, 'text_url_hover')
	$Description/RichTextLabel.connect("meta_hover_ended", self, "text_url_hover_hide")
	$HairChange/screen.connect("pressed", self, "close_hairstyle")
	$DescriptionButton.connect("pressed", self, 'toggle_description')
	for nd in trainings_selector.get_children():
		nd.connect('pressed', self, 'open_upgrade_tab', [nd.name])
	get_node('panel4').connect('toggled', self, 'toggle_sex_traits')
	
	upgrades.get_node("ScrollContainer2/UpgradesList2").root = get_parent()
	upgrades.get_node("MinorUpgradesCont/UpgradesList3").root = get_parent()
	upgrades.get_node("UpgradesList").root = get_parent()
	upgrades.get_node("SuccubUpgradesList").root = get_parent()
	
	globals.connecttexttooltip($Panel/maininfo/food/fooddisliked, "[center]"+ tr("STATFOOD_HATE") + "[/center]\n"+tr("STATFOOD_HATEDESCRIPT"))
	globals.connecttexttooltip($Panel/maininfo/food/foodliked,"[center]"+ tr("STATFOOD_LOVE") + "[/center]\n"+tr("STATFOOD_LOVEDESCRIPT"))
	
	globals.connecttexttooltip($tr_selector/master_upg, tr("SIBLINGMODULETRAININGSMASTER"))
	globals.connecttexttooltip($tr_selector/succubus, tr("SIBLINGMODULESUCCUBUS"))
	globals.connecttexttooltip($tr_selector/trainings, tr("SIBLINGMODULETRAININGS"))
	globals.connecttexttooltip($tr_selector/minor_upg, tr("SIBLINGMODULEMINORTRAINING"))
	
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
		curr_tab = null
	sextraits.hide()
	$panel4.pressed = false
	sextraits.build_sex_traits()
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
		
		$Panel/maininfo/personality/label.text = tr("PERSONALITYNAME" + person.get_stat("personality").to_upper())
		$Panel/maininfo/personality/icon.texture = personality_icons[person.get_stat('personality')]
		
		globals.connecttexttooltip($Panel/maininfo/personality, tr('INFOPERSONALITY'))
		$Panel/maininfo/food/foodlikedicon.texture = load(images.icons[person.food.food_love])
		globals.connecttexttooltip($Panel/maininfo/food/foodlikedicon, tr("FOODTYPE" + person.food.food_love.to_upper()))
		input_handler.ClearContainer($Panel/maininfo/food/fooddislikedicons)
		for i in person.food.food_hate:
			var newicon = input_handler.DuplicateContainerTemplate($Panel/maininfo/food/fooddislikedicons)
			newicon.texture = load(images.icons[i])
			globals.connecttexttooltip(newicon, tr("FOODTYPE" + i.to_upper()))
		$Description/RichTextLabel.bbcode_text = person.make_description()
		
		update_traitlist()
		update_trainings_selector()
		open_upgrade_tab()

var personality_icons = {
	bold = load("res://assets/Textures_v2/MANSION/personality_bold.png"),
	kind = load("res://assets/Textures_v2/MANSION/personality_kind.png"),
	shy = load("res://assets/Textures_v2/MANSION/personality_shy.png"),
	serious = load("res://assets/Textures_v2/MANSION/personality_serious.png"),
	neutral = load("res://assets/Textures_v2/MANSION/personality_neutral.png"),
	
}


func update_traitlist():
	globals.build_traitlist_for_char(person, traitlist)


func update_trainings_selector():
	trainings_selector.get_node("master_upg").visible = person.is_master()
	trainings_selector.get_node("succubus").visible = person.check_trait('succubus')
	trainings_selector.get_node("trainings").visible = !person.is_master()
	trainings_selector.get_node("minor_upg").visible = true


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


func open_upgrade_tab(id = null):
	var _update = true
	if person == null:
		return
	if curr_tab != null:
		if id != null:
			if curr_tab == id:
				_update = false
			curr_tab = id
	else:
		if id == null:
			if person.is_master():
				id = 'master_upg'
			elif person.check_trait('succubus'):
				id = 'succubus'
			else:
				id = 'trainings'
		curr_tab = id
	for i in trainings_selector.get_children():
		i.pressed = (i.name == curr_tab)
	if _update:
		for nd in upgrades.get_children():
			nd.visible = false
		call('open_' + curr_tab)


func open_master_upg():
	upgrades.get_node("Label").visible = true
	upgrades.get_node("Label").text = tr("MASTER_POINTS") + ": " + str(ResourceScripts.game_progress.master_points)
	upgrades.get_node("ScrollContainer2").visible = true
	upgrades.get_node("ScrollContainer2/UpgradesList2").update_upgrades_tree()
	get_node("Label2").text = tr('SIBLINGMODULETRAININGSMASTER')


func open_minor_upg():
	upgrades.get_node("Label").visible = true
	upgrades.get_node("MinorUpgradesCont/UpgradesList3").set_person(person)
	upgrades.get_node("MinorUpgradesCont").visible = true
	upgrades.get_node("MinorUpgradesCont/UpgradesList3").update_upgrades_tree()
	get_node("Label2").text = tr('SIBLINGMODULEMINORTRAIN')
	upgrades.get_node("Label").text = "%s: %d/%d %s: %d" % [
		tr("SIBLINGMODULEAVAILABLE"),
		person.get_minor_training_count(), person.get_minor_training_max(),
		tr("UPGRADELIST_UNLOCK_GOLD"), ResourceScripts.game_res.money
	]
	globals.connecttexttooltip(upgrades.get_node("Label"), tr("SIBLINGMODULEAVAILABLETOOLTIP"))


func open_trainings():
	upgrades.get_node("UpgradesList").visible = true
	upgrades.get_node("UpgradesList").person = person
	upgrades.get_node("UpgradesList").match_state()
	if person.get_stat('slave_class') in ['slave', 'slave_trained']:
		get_node("Label2").text = tr('SIBLINGMODULETRAININGS')
	else:
		get_node("Label2").text = tr('SIBLINGMODULETRAININGSSERVANTS')


func open_succubus():
	upgrades.get_node("SuccubUpgradesList").set_person(person)
	upgrades.get_node("SuccubUpgradesList").visible = true
	get_node("Label2").text = tr('SIBLINGMODULESUCCUBUS')


func toggle_sex_traits(val):
	if val:
		sextraits.build_sex_traits()
	sextraits.visible = val



