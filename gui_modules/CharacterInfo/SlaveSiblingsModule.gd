extends Control

onready var DietModule = $SlaveDietModule

var person

var universal_skills = ['oral','anal','petting']

onready var loyalty_panel = $UpgradesPanel/UpgradesList
onready var loyalty_panel_master = $UpgradesPanel/ScrollContainer2/UpgradesList2
onready var loyalty_panel_minor = $UpgradesPanel/MinorUpgradesCont/UpgradesList3
onready var btn_relations = $change_buttons/rel_button
onready var btn_training = $change_buttons/tr_button
onready var btn_minor_training = $change_buttons/minor_tr_button
#var loyalty_mode = true
#var relations_mode = true
#var loyalty_tab = 3
enum tab_nums {all, food, mastery, training, relations, kin, minor}
var cur_tab
var last_tab

func _ready():
	update()
	
	globals.connecttexttooltip($SexSkillsTooltip, tr("INFOSEX_SKILLS"))
	globals.connecttexttooltip($ConditionsTooltip, tr("INFORULES_CONDS"))
	globals.connecttexttooltip($SlaveDietModule/FoodFilterTooltip, tr("INFOFOODFILTER"))
	globals.connecttexttooltip($SexTraitsTooltip, tr("INFOSEX_TRAITS"))
	globals.connecttexttooltip($personality/PersonalityTooltip, tr("INFOPERSONALITY"))
	
	globals.connecttexttooltip($personality/bold, tr("INFOPERSONALITYBOLD"))
	globals.connecttexttooltip($personality/shy, tr("INFOPERSONALITYSHY"))
	globals.connecttexttooltip($personality/kind, tr("INFOPERSONALITYKIND"))
	globals.connecttexttooltip($personality/serious, tr("INFOPERSONALITYSERIOUS"))
	
	
	for i in $work_rules.get_children():
		i.connect('pressed', self, 'set_work_rule', [i.name])
	$work_rules/ration.connect("button_down", self, "update")
	$work_rules/ration.connect("button_up", self, "update")
	btn_training.connect("pressed", self, 'on_btn_training')
	btn_relations.connect("pressed", self, 'open_tab', [tab_nums.kin])
	btn_minor_training.connect("pressed", self, 'open_tab', [tab_nums.minor])
	$RelationsButton.connect("pressed", self, 'swap_rel_mode')
#	$change_button2.connect("pressed", self, 'swap_tab', [1])
#	$change_button3.connect("pressed", self, 'swap_tab', [2])
	$FF.connect("pressed", self, 'show_food_filter')
	$SlaveDietModule/close.connect("pressed", self, 'hide_food_filter')
	loyalty_panel.root = get_parent()
	loyalty_panel_master.root = get_parent()
	loyalty_panel_minor.root = get_parent()
	

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
	$work_rules/luxury.text = tr("UPGRADELUXURY_ROOMS") + ": " + str(luxury_rooms_taken) + "/" + str(ResourceScripts.game_res.upgrades.luxury_rooms + 1)
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
	#show and hide here is just to get ready, open_valid_tab() makes it all right
	$SlaveDietModule.visible = false
	btn_minor_show()
	btn_training_show()
	#relatives
	$RelativesPanel.build_relatives()
	build_relations()
	#handling tabs
	open_valid_tab()
#	if person.is_master():
#		$change_button.visible = true
#		loyalty_tab = 3
#		loyalty_panel.visible = false
#		loyalty_panel_master.get_parent().visible = true
#		loyalty_panel_master.update_upgrades_tree()
#		$UpgradesPanel/Label2.text = tr('SIBLINGMODULETRAININGSMASTER')
##		setup_tab()
#		if !loyalty_mode:
#			swap_mode()
#	elif person.get_stat('slave_class') in ['slave', 'slave_trained', 'servant', 'servant_notax', 'heir']:
#		$change_button.visible = true
#		loyalty_panel.visible = true
#		loyalty_panel_master.get_parent().visible = false
#		loyalty_panel.person = person
#		loyalty_panel.match_state()
#		if person.get_stat('slave_class') in ['slave', 'slave_trained']:
#			$UpgradesPanel/Label2.text = tr('SIBLINGMODULETRAININGS')
#		else:
#			$UpgradesPanel/Label2.text = tr('SIBLINGMODULETRAININGSSERVANTS')
#		if !loyalty_mode:
#			swap_mode()
#	else:
#		$change_button.visible = false
#		if loyalty_mode:
#			swap_mode()
#	if person.is_master():
#		$change_button.visible = false
#		if loyalty_mode:
#			swap_mode()
#	else:
#		$change_button.visible = true
#		if !loyalty_mode:
#			swap_mode()
#		input_handler.ActivateTutorial("training")
#	$change_button.visible = true
	
	input_handler.ActivateTutorial("TUTORIALLIST9")
	
	for i in $work_rules.get_children():
		globals.disconnect_text_tooltip(i)
		globals.connecttexttooltip(i,person.translate(tr("WORKRULE" + i.name.to_upper() + "DESCRIPT")))
	
#	if person.is_master():
#		$UpgradesPanel/Label.text = tr("MASTER_POINTS") + ": " + str(ResourceScripts.game_progress.master_points)
#	else:
##		$UpgradesPanel/Label.text = tr("SLAVE_LOYALTY") + ": " + str(floor(person.get_stat("loyalty")))
#		$UpgradesPanel/Label.text = ""
	#globals.connecttexttooltip($UpgradesPanel/Label, "")
	#work_rules part
	var luxury_rooms_taken = 0
	for p in ResourceScripts.game_party.characters.values():
		if p.check_work_rule("luxury"):
			luxury_rooms_taken += 1
	$work_rules/luxury.text = tr("UPGRADELUXURY_ROOMS") + ": " + str(luxury_rooms_taken) + "/" + str(ResourceScripts.game_res.upgrades.luxury_rooms + 1)
	$work_rules/luxury.disabled = (luxury_rooms_taken >= ResourceScripts.game_res.upgrades.luxury_rooms + 1) && person != null && !person.check_work_rule("luxury")

	$work_rules/luxury.visible = !person.is_master()
	$work_rules/relationship.visible = !person.is_master()
	$work_rules/nudity.disabled = !person.has_status('sexservice') #or another
	if person != null:
		for i in $work_rules.get_children():
			var t = person.check_work_rule(i.name)
			i.pressed = person.check_work_rule(i.name)
#		$work_rules/constrain.visible = !person.is_master()
		$work_rules/contraceptive.visible = !person.check_trait('undead')
		$work_rules/ration.visible = !person.check_trait('undead')
	#SexSkillsControl part
	
	if person != null:
		input_handler.ClearContainer($ScrollContainer/VBoxContainer)
		var s_skills = person.get_sex_skills()
		for ii in s_skills: #bad way, need to move to using proper statdata (and proper translation keys) instead of stubs
			var i = ii.trim_prefix('sex_skills_')
			if s_skills[ii] <= 0 && !universal_skills.has(i):
				continue
			var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
			newbutton.get_node("Label").text = tr("SEXSKILL"+i.to_upper())
			newbutton.get_node("ProgressBar").value = s_skills[ii]
			newbutton.get_node("ProgressBar/Label").text = str(floor(s_skills[ii])) + '/100'
			globals.connecttexttooltip(newbutton,  person.translate(tr("SEXSKILL"+i.to_upper()+"DESCRIPT")) + "\n" + tr("CUR_LEVEL_LABEL") + ":" + str(floor(s_skills[ii])))
		var text = ''
		if person.is_master():
			text = tr("SIBLINGMODULECONSENT") + tr("MASTER")
			globals.connecttexttooltip($ConsentLabel, person.translate(tr("INFOCONSENTMASTER")))
		else:
			text = tr("SIBLINGMODULECONSENT") + str(tr(variables.consent_dict[int(person.get_stat('consent'))]))
			globals.connecttexttooltip($ConsentLabel, tr("INFOCONSENT"))
		$ConsentLabel.text = text
		
		globals.connecttexttooltip($SlaveDietModule/food_love,"[center]" + statdata.statdata.food_love.name + "[/center]\n"+  statdata.statdata.food_love.descript)
		globals.connecttexttooltip($SlaveDietModule/food_hate,"[center]" + statdata.statdata.food_hate.name + "[/center]\n"+ statdata.statdata.food_hate.descript)
		$SlaveDietModule/food_consumption/Label.text = str(floor(person.get_stat("food_consumption")))
		if person.food.food_love != null:
			$SlaveDietModule/food_love/Button.texture = images.get_icon(person.food.food_love)
			$SlaveDietModule/food_love/Button.hint_tooltip = tr("FOODTYPE" +person.food.food_love.to_upper())
		$SlaveDietModule/food_love/Button.visible = person.food.food_love != null
		input_handler.ClearContainer($SlaveDietModule/food_hate/Container)
		if person.food.food_hate != null:
			for i in person.food.food_hate:
				var newnode = input_handler.DuplicateContainerTemplate($SlaveDietModule/food_hate/Container)
				newnode.texture = images.get_icon(i)
				newnode.hint_tooltip =  tr("FOODTYPE" +i.to_upper())
		$SlaveDietModule/food_hate/Container.visible = person.food.food_hate != null
		sex_traits_open()
		
		build_personality()


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
					traittext += "\n\n" + tr("DISLIKED_ACTIONS_LABEL") + ":[color=aqua] "
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
	var text = tr("SIBLINGMODULECURRENTCAPACITY")+': ' + str(person.get_sex_traits().size()) + "/" + str(person.get_stat('sexuals_factor') + 1)
	$SexTraitsPanel/TraitCapacity.text = text
	for i in $SexTraitsPanel/ScrollContainer/VBoxContainer.get_children():
		if i.has_meta("always_disabled") && i.get_meta("always_disabled") == true:
			continue
		i.disabled = person.get_stat('sexuals_factor') + 1 - person.get_sex_traits().size() <= 0 && i.pressed == false


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


func show_food_filter():
	if cur_tab == tab_nums.food:
		hide_food_filter()
		return
	
	last_tab = cur_tab
	open_tab(tab_nums.food)
#	$UpgradesPanel.visible = false
#	$RelativesPanel.visible = false
#	$SlaveDietModule.visible = true
#	$change_button.visible = false
#	$change_button2.visible = false
#	$change_button3.visible = false


func hide_food_filter():
	close_tab(tab_nums.food)
	if last_tab:
		#be careful with cur_tab outside open_/close_tab()
		cur_tab = last_tab
		last_tab = null
	open_valid_tab()
#	$SlaveDietModule.visible = false
#	$change_button.visible = !person.is_master()
#	loyalty_mode = !loyalty_mode
#	swap_mode()


#func swap_mode():
#	if loyalty_mode:
#		loyalty_mode = false
#		$UpgradesPanel.visible = false
#		relations_mode = false
#		swap_rel_mode()
##		$RelativesPanel.visible = true
#		$change_button/Label.text = tr("SIBLINGMODULETRAININGS")
#	else:
#		loyalty_mode = true
#		$UpgradesPanel.visible = true
#		$RelativesPanel.visible = false
#		$Relations.visible = false
#		$change_button/Label.text = tr("SIBLINGMODULERELATIVES")


func swap_rel_mode():
	if cur_tab == tab_nums.kin:
		open_tab(tab_nums.relations)
	elif cur_tab == tab_nums.relations:
		open_tab(tab_nums.kin)
#	if relations_mode:
#		relations_mode = false
#		$Relations.visible = false
#		$RelativesPanel.visible = true
#		$RelationsButton/Label.text = tr("SIBLINGMODULERELATIONS")
#	else:
#		if person.is_master():
#			$RelationsButton.visible = false
#		else:
#			$RelationsButton.visible = true
#			relations_mode = true
#			$Relations.visible = true
#			$RelativesPanel.visible = false
#			$RelationsButton/Label.text = tr("SIBLINGMODULERELATIVES")



#func swap_tab(tab): #obsolete
#	if loyalty_tab != tab:
#		loyalty_tab = tab
#		setup_tab(true)
#	else:
#		setup_tab(false)


#func setup_tab(rebuild = true): #obsolete
#	if loyalty_tab == 3:
#		$change_button2.visible = false
#		$change_button3.visible = false
#		if rebuild:
#			loyalty_panel_master.update_upgrades_tree()
#	else:
#		$change_button2.visible = true
#		$change_button3.visible = true
#		if loyalty_tab == 2:
#			$change_button2.pressed = false
#			$change_button3.pressed = true
#		else:
#			$change_button2.pressed = true
#			$change_button3.pressed = false
#		if rebuild:
#			loyalty_panel.update_upgrades_tree(person, loyalty_tab)


func build_personality():
	var limit = 100
	limit = max(limit, abs(person.get_stat('personality_bold')))
	limit = max(limit, abs(person.get_stat('personality_kind')))
	
	var tmp = Vector2(-person.get_stat('personality_kind') , -person.get_stat('personality_bold'))
	tmp /= limit
	tmp = input_handler.rect2rombus(tmp)
	tmp /= 2.0
	
	$personality/current.rect_position = Vector2($personality.rect_size.x * (0.5 + tmp.x),  $personality.rect_size.y * (0.5 + tmp.y)) - $personality/current.rect_size * 0.5
	
	$personality/PersonalityLabel.text = tr("PERSONALITYCURRENT") +"\n" + tr("PERSONALITYNAME"+person.get_stat('personality').to_upper())
	#2add
	#$personality/desc.bbcode_text = ""


func build_relations():
	var text = ''
	
	var array = ResourceScripts.game_party.find_all_relationship(person.id)
	for i in array:
		var character = characters_pool.get_char_by_id(i['char'])
		#stub
		if character.get_full_name().begins_with('Child of'):
			continue
		
		text += character.get_full_name() + ": " + i.relationship + "\n"
	$Relations.bbcode_text = text


func close_tab(tab):
	if tab == tab_nums.food or tab == tab_nums.all:
		$SlaveDietModule.visible = false
	if tab == tab_nums.mastery or tab == tab_nums.all:
		$UpgradesPanel.visible = false
		loyalty_panel_master.get_parent().visible = false
		$UpgradesPanel/Label.text = ""
		btn_training_show()
	if tab == tab_nums.training or tab == tab_nums.all:
		$UpgradesPanel.visible = false
		loyalty_panel.visible = false
		btn_training_show()
	if tab == tab_nums.relations or tab == tab_nums.all:
		$Relations.visible = false
		$RelationsButton.visible = false
		btn_relations.visible = true
	if tab == tab_nums.kin or tab == tab_nums.all:
		$RelativesPanel.visible = false
		$RelationsButton.visible = false
		btn_relations.visible = true
	if tab == tab_nums.minor or tab == tab_nums.all:
		$UpgradesPanel.visible = false
		loyalty_panel_minor.get_parent().visible = false
		$UpgradesPanel/Label.text = ""
		globals.disconnect_text_tooltip($UpgradesPanel/Label)
		btn_minor_show()
	cur_tab = null

func open_tab(tab):
	if cur_tab:
		close_tab(cur_tab)
	else:
		close_tab(tab_nums.all)
	cur_tab = tab
	if tab == tab_nums.food:
		$SlaveDietModule.visible = true
	elif tab == tab_nums.mastery:
		$UpgradesPanel.visible = true
		loyalty_panel_master.get_parent().visible = true
		loyalty_panel_master.update_upgrades_tree()
		$UpgradesPanel/Label2.text = tr('SIBLINGMODULETRAININGSMASTER')
		$UpgradesPanel/Label.text = tr("MASTER_POINTS") + ": " + str(ResourceScripts.game_progress.master_points)
		btn_training.visible = false
	elif tab == tab_nums.training:
		$UpgradesPanel.visible = true
		loyalty_panel.visible = true
		loyalty_panel.person = person
		loyalty_panel.match_state()
		if person.get_stat('slave_class') in ['slave', 'slave_trained']:
			$UpgradesPanel/Label2.text = tr('SIBLINGMODULETRAININGS')
		else:
			$UpgradesPanel/Label2.text = tr('SIBLINGMODULETRAININGSSERVANTS')
		btn_training.visible = false
	elif tab == tab_nums.relations:
		$Relations.visible = true
		$RelationsButton.visible = true
		$RelationsButton/Label.text = tr("SIBLINGMODULERELATIVES")
		btn_relations.visible = false
	elif tab == tab_nums.kin:
		$RelativesPanel.visible = true
		$RelationsButton.visible = !person.is_master()
		$RelationsButton/Label.text = tr("SIBLINGMODULERELATIONS")
		btn_relations.visible = false
	elif tab == tab_nums.minor:
		$UpgradesPanel.visible = true
		loyalty_panel_minor.set_person(person)
		loyalty_panel_minor.get_parent().visible = true
		loyalty_panel_minor.update_upgrades_tree()
		$UpgradesPanel/Label2.text = tr('SIBLINGMODULEMINORTRAIN')
		$UpgradesPanel/Label.text = "%s: %d/%d %s: %d" % [
			tr("SIBLINGMODULEAVAILABLE"),
			person.get_minor_training_count(), person.get_minor_training_max(),
			tr("UPGRADELIST_UNLOCK_GOLD"), ResourceScripts.game_res.money
		]
		globals.connecttexttooltip($UpgradesPanel/Label, tr("SIBLINGMODULEAVAILABLETOOLTIP"))
		btn_minor_training.visible = false

func on_btn_training():
	if person.is_master():
		open_tab(tab_nums.mastery)
	else:
		open_tab(tab_nums.training)

func btn_training_show():
	btn_training.visible = true
	if person.is_master():
		btn_training.get_node('Label').text = tr("SIBLINGMODULETRAININGSMASTER")
	else:
		btn_training.get_node('Label').text = tr("SIBLINGMODULETRAININGS")

func btn_minor_show():
	btn_minor_training.visible = person.get_stat('slave_class') != 'slave'

func open_valid_tab():
	var training_classes = ['slave', 'slave_trained', 'servant', 'servant_notax', 'heir']
	if cur_tab:
		var keep_tab = true
		#tab restrictions
		if cur_tab == tab_nums.mastery:
			keep_tab = person.is_master()
		elif cur_tab == tab_nums.training:
			keep_tab = person.get_stat('slave_class') in training_classes
		elif cur_tab == tab_nums.relations:
			keep_tab = !person.is_master()
		elif cur_tab == tab_nums.minor:
			keep_tab = person.get_stat('slave_class') != 'slave'
		
		if keep_tab:
			open_tab(cur_tab)
			return
	
	#defaults
	if person.is_master():
		open_tab(tab_nums.mastery)
	elif person.get_stat('slave_class') in training_classes:
		open_tab(tab_nums.training)
	else:
		open_tab(tab_nums.relations)


