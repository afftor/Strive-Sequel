extends Panel

onready var DietModule = $SlaveDietModule

var person

var universal_skills = ['oral','anal','petting']

onready var loyalty_panel = $UpgradesPanel/ScrollContainer/UpgradesList
var loyalty_mode = true

func _ready():
	update()
	for i in $work_rules.get_children():
		i.connect('pressed', self, 'set_work_rule', [i.name])
		i.hint_tooltip = "WORKRULE" + i.name.to_upper() + "DESCRIPT"
	
	globals.connecttexttooltip($SexSkillsTooltip, tr("INFOSEX_SKILLS"))
	globals.connecttexttooltip($ConditionsTooltip, tr("INFORULES_CONDS"))
	globals.connecttexttooltip($FoodFilterTooltip, tr("INFOFOODFILTER"))
	globals.connecttexttooltip($SexTraitsTooltip, tr("INFOSEX_TRAITS"))
	$work_rules/ration.connect("button_down", self, "update")
	$work_rules/ration.connect("button_up", self, "update")
	$change_button.connect("pressed", self, 'swap_mode')
	loyalty_panel.root = get_parent()
	

func set_work_rule(rule):
	var setting = get_node("work_rules/"+rule).pressed
	person.set_work_rule(rule, setting)
	if rule == "luxury":
		luxury_room()


func luxury_room():
	person = get_parent().active_person
	var luxury_rooms_taken = 0
	for p in ResourceScripts.game_party.characters.values():
		if p.check_work_rule("luxury"):
			luxury_rooms_taken += 1
	$work_rules/luxury.text = "Luxury Rooms: " + str(luxury_rooms_taken) + "/" + str(ResourceScripts.game_res.upgrades.luxury_rooms + 1)
	$work_rules/luxury.disabled = (luxury_rooms_taken >= ResourceScripts.game_res.upgrades.luxury_rooms + 1) && person != null && !person.check_work_rule("luxury")
	$work_rules/luxury.visible = person != ResourceScripts.game_party.get_master()

func set_color(value):
	var color = Color(0.98,0.88,0.51,1)
	if value > 0:
		color = Color(0.31,0.99,0.51,1)  
	elif value < 0:
		color = Color(0.99,0.31,0.36,1)
	return color	

func update():
	person = input_handler.interacted_character
	#relatives
	$RelativesPanel.build_relatives()
	loyalty_panel.update_upgrades_tree(person)
	if person.is_master():
		$change_button.visible = false
		if loyalty_mode:
			swap_mode()
	else:
		$change_button.visible = true
		if !loyalty_mode:
			swap_mode()
	#work_rules part
	var luxury_rooms_taken = 0
	for p in ResourceScripts.game_party.characters.values():
		if p.check_work_rule("luxury"):
			luxury_rooms_taken += 1
	$work_rules/luxury.text = "Luxury Rooms: " + str(luxury_rooms_taken) + "/" + str(ResourceScripts.game_res.upgrades.luxury_rooms + 1)
	$work_rules/luxury.disabled = (luxury_rooms_taken >= ResourceScripts.game_res.upgrades.luxury_rooms + 1) && person != null && !person.check_work_rule("luxury")

	$work_rules/luxury.visible = !person.is_master()
	if person != null:
		for i in $work_rules.get_children():
			var t = person.check_work_rule(i.name)
			i.pressed = person.check_work_rule(i.name)
		$work_rules/constrain.visible = !person.is_master()
		$work_rules/contraceptive.visible = !person.check_trait('undead')
		$work_rules/ration.visible = !person.check_trait('undead')
	#SexSkillsControl part
	
	if person != null:
	
		input_handler.ClearContainer($ScrollContainer/VBoxContainer)
		var s_skills = person.get_stat('sex_skills')
		for i in s_skills:
			if s_skills[i] == 0 && universal_skills.find(i) < 0:
				continue

			var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
			newbutton.get_node("Label").text = tr("SEXSKILL"+i.to_upper())
			newbutton.get_node("ProgressBar").value = s_skills[i]
			newbutton.get_node("ProgressBar/Label").text = str(floor(s_skills[i])) + '/100'
			globals.connecttexttooltip(newbutton,  person.translate(tr("SEXSKILL"+i.to_upper()+"DESCRIPT")) + "\nCurrent level:" + str(floor(s_skills[i])))
		
		$ConsentLabel.text = "Consent: " + str(person.get_stat('consent'))
		
		globals.connecttexttooltip($food_love,"[center]" + statdata.statdata.food_love.name + "[/center]\n"+  statdata.statdata.food_love.descript)
		globals.connecttexttooltip($food_hate,"[center]" + statdata.statdata.food_hate.name + "[/center]\n"+ statdata.statdata.food_hate.descript)
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
		sex_traits_open()


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

func sex_traits_open():
	$SexTraitsPanel.show()
	person = input_handler.interacted_character
	input_handler.ClearContainer($SexTraitsPanel/ScrollContainer/VBoxContainer)
	#$SexTraitsPanel/TraitsNotLearned.bbcode_text = person.translate(tr("NOTALLTRAITSLEARNED"))
	var array = []
	array = person.get_all_sex_traits()#.keys()

	var all_traits_known = true
	for i in array:
		if !array[i]:
			all_traits_known = false
			break
	if all_traits_known:
		array = person.get_unlocked_sex_traits()#.keys()
#		array.sort_custom(self, 'sort_traits')

		for i in array:
			var newbutton = input_handler.DuplicateContainerTemplate($SexTraitsPanel/ScrollContainer/VBoxContainer)
			newbutton.pressed = person.check_trait(i)
			newbutton.text = Traitdata.sex_traits[i].name
			globals.connecttexttooltip(newbutton, person.translate(Traitdata.sex_traits[i].descript))
			newbutton.connect("toggled", self, 'toggle_trait', [i])
	#$SexTraitsPanel/TraitsNotLearned.visible = !all_traits_known
	
	update_trait_capacity()
	rebuild_traits()


func rebuild_traits():
	#input_handler.ClearContainer($SexTraitsPanel/ScrollContainer/VBoxContainer)
#	for i in person.statlist.traits:
#		var trait = Traitdata.traits[i]
#		if !trait.visible:
#			continue
#		var newnode = input_handler.DuplicateContainerTemplate($SexTraitsPanel/ScrollContainer/VBoxContainer)
#		newnode.text = trait.name
	
	var traits = person.get_all_sex_traits()
	var h1 = person.get_unlocked_sex_traits()
	var all_traits_known = true
	for i in traits:
		if !traits[i]:
			all_traits_known = false
			break
	if all_traits_known:
		for i in h1:
			if traits.keys().has(i):
				if traits[i]:
					traits.erase(i)
	for i in traits:
		var trait = Traitdata.sex_traits[i]
		var newnode = input_handler.DuplicateContainerTemplate($SexTraitsPanel/ScrollContainer/VBoxContainer)
		newnode.set_meta("always_disabled", true)
		$SexTraitsPanel/ScrollContainer/VBoxContainer.move_child(newnode, 0)
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
			if !all_traits_known and !("Dislike" in trait.name):
				newnode.disabled = false
			else:
				newnode.disabled = true
			var font = input_handler.font_size_calculator(newnode)
			newnode.set("custom_fonts/font", font)
		else:
			newnode.text = tr("TRAITUNKNOWN")
			globals.connecttexttooltip(newnode, person.translate(tr("TRAITUNKNOWNTOOLTIP")))
			newnode.disabled = true
			var font = input_handler.font_size_calculator(newnode)
			newnode.set("custom_fonts/font", font)

func update_trait_capacity():
	person = input_handler.interacted_character
	var text = 'Current Capacity: ' + str(person.statlist.sex_traits.size()) + "/" + str(person.get_stat('sexuals_factor')+1)
	$SexTraitsPanel/TraitCapacity.text = text
	for i in $SexTraitsPanel/ScrollContainer/VBoxContainer.get_children():
		if i.has_meta("always_disabled") && i.get_meta("always_disabled") == true:
			continue
		i.disabled = person.get_stat('sexuals_factor')+1 - person.statlist.sex_traits.size() <= 0 && i.pressed == false


func toggle_trait(trait_status, trait):
	match trait_status:
		true:
			if !person.check_trait(trait):
				person.add_sex_trait(trait, true)
		false:
			if person.check_trait(trait):
				person.remove_sex_trait(trait, false)
	update_trait_capacity()
	#get_parent().SlaveInfo.rebuild_traits()

func swap_mode():
	if loyalty_mode:
		loyalty_mode = false
		$UpgradesPanel.visible = false
		$RelativesPanel.visible = true
		$change_button/Label.text = "Trainings"
	else:
		loyalty_mode = true
		$UpgradesPanel.visible = true
		$RelativesPanel.visible = false
		$change_button/Label.text = "Relatives"
