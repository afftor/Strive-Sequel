extends "res://src/scenes/ClosingPanel.gd"

#warning-ignore-all:return_value_discarded

var person

var type

func _input(event):
	if self.visible == false || $SkillPanel.visible == false || input_handler.text_field_input == true:
		return
	if person != null and person.skills.active_panel == variables.PANEL_COM: return
	if str(event.as_text().replace("Kp ",'')) in str(range(0,9)) && event.is_pressed():
		var number = int(event.as_text().replace("Kp ",''))-1
		if $SkillPanel.get_child(number).disabled == false:
			$SkillPanel.get_child(number).emit_signal("pressed")


func _ready():
	#setting tooltips
	
	for i in $progress.get_children():
		#i.connect("mouse_entered", self, "show_progress_tooltip", [i])
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	for i in $factors.get_children():
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	
	
	for i in $base_stats.get_children():
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	
	for i in ['restup', 'workup', 'joyup', 'restdown', 'workdown', 'joydown']:

		get_node("job_panel/job_details/WorkDetailsPanel/"+i).connect("pressed", self, "change_hours", [i])
	
	
	globals.connecttexttooltip($food_love,"[center]" +statdata.statdata.food_love.name + "[/center]\n"+  statdata.statdata.food_love.descript)
	globals.connecttexttooltip($food_hate,"[center]" +statdata.statdata.food_hate.name + "[/center]\n"+ statdata.statdata.food_hate.descript)
	
	###############
	$skillpanelswitch.connect("pressed", self, "change_panel_type")
	
	$controls/ClassButton.connect("pressed",self ,'open_class_selection')
	input_handler.AddPanelOpenCloseAnimation($job_panel)

	input_handler.AddPanelOpenCloseAnimation($DietPanel)
	input_handler.AddPanelOpenCloseAnimation($SexTraitsPanel)

	$job_panel.move_child($job_panel/CloseButton, 3)
	
	$job_panel/job_details/SimpleBehaviorCheck.connect("pressed", self, "check_simple_behavior")
	
	$controls/DietButton.connect("pressed", self, "open_diet_window")
	$controls/JobButton.connect("pressed", self, "open_jobs_window")
	$controls/CustmizeButton.connect('pressed', self, "open_customize_button")
	$controls/GearButton.connect("pressed", self, "show_gear_gui")
	$controls/ReturnButton.connect("pressed", self, "return_to_mansion_confirm")
	
	$RichTextLabel.connect("meta_hover_started", self, 'text_url_hover')
	$RichTextLabel.connect("meta_hover_ended", self, "text_url_hover_hide")
	
	input_handler.AddPanelOpenCloseAnimation($DetailsPanel)
	$DetailsPanel/VBoxContainer/descript.connect("pressed", self, "custom_description_open")
	$DetailsPanel/VBoxContainer/icon.connect("pressed", self, "chooseimage",['portrait'])
	$DetailsPanel/VBoxContainer/body.connect("pressed", self, "chooseimage",['body'])
	$DetailsPanel/VBoxContainer/nickname.connect("pressed", self, "custom_nickname_open")
	$DetailsPanel/VBoxContainer/masternoun.connect("pressed", self, "custom_masternoun_open")
	$DetailsPanel/VBoxContainer/traits.connect("pressed", self, "sex_traits_open")
	
	globals.connecttexttooltip($obedlabel/icon, statdata.statdata.obedience.descript)
	globals.connecttexttooltip($loyaltylabel, statdata.statdata.loyalty.descript)
	globals.connecttexttooltip($authoritylabel, statdata.statdata.authority.descript)
	globals.connecttexttooltip($submissionlabel, statdata.statdata.submission.descript)
	globals.connecttexttooltip($SexTraitsPanel/TraitHelp, tr("SEXTRAITHELP") + tr("SEXTRAITDISLIKES"))
	
	$testbutton.connect('pressed', self, "run_test")
	
	$BodyPanel/opacity.connect("value_changed", self, "set_body_opacity")
	$BodyPanel/StatsButton.connect("pressed", self, "stats_panel")
	
	globals.connecttexttooltip($DetailsPanel/ConsentLabel, tr("STATCONSENTDESCRIPT"))
	
	for i in $job_panel/work_rules.get_children():
		i.connect('pressed', self, 'set_work_rule', [i.name])
		i.hint_tooltip = "WORKRULE" + i.name.to_upper() + "DESCRIPT"
	
	$HirePanel/HireButton.connect("pressed", self, "hire_character")

func hire_character():
	if ResourceScripts.game_party.characters.size() >= ResourceScripts.game_party.get_pop_cap():
		if ResourceScripts.game_party.get_pop_cap() < variables.max_population_cap:
			input_handler.SystemMessage("You don't have enough rooms")
		else:
			input_handler.SystemMessage("Population limit reached")
		return
	ResourceScripts.game_res.money -= person.calculate_price()
	input_handler.PlaySound("money_spend")
	person.set_stat('is_hirable', false)
	ResourceScripts.game_party.add_slave(person)
	hide()
	
	if input_handler.scene_characters.has(person):
		input_handler.scene_characters.erase(person)
		input_handler.get_spec_node(input_handler.NODE_DIALOGUE).update_scene_characters()
	
	if input_handler.active_faction.has('slaves'):
		input_handler.active_faction.slaves.erase(person.id)
	
	if input_handler.exploration_node.get_node("HirePanel").is_visible_in_tree() == true:
		input_handler.exploration_node.faction_hire()
	
	if person.get_stat('hire_scene') != '':
		input_handler.active_character = person
		input_handler.scene_characters.append(person)
		input_handler.interactive_message(person.get_stat('hire_scene'), '', {})
	
	


func run_test():
	person.apply_custom_bodychange('sex', 'female')
	open(person)

func stats_panel():
	$BodyPanel/StatsPanel.open(person)
	$"BodyPanel/StatsPanel".visible = !$BodyPanel/StatsPanel.visible

func set_body_opacity(value):
	for i in [$BodyPanel, $BodyPanel/Body]:
		i.self_modulate = Color(1,1,1, value/100)

func open(tempperson):
	if tempperson == null:
		tempperson = person
	person = tempperson
	$job_panel.hide()
	$class_learn.hide()
	input_handler.ActivateTutorial('slavetab')
	input_handler.ActivateTutorial('skills')
	show()
	update()
	
#	yield(get_tree().create_timer(0.5), "timeout")
#	var temp = get_tree().get_root().get_child(get_tree().get_root().get_children().size()-1)
#	print(temp)

func hide():
	.hide()
	if ResourceScripts.game_party.active_tasks.size() > 0:
		input_handler.ActivateTutorial('tasklist')

var authority_lines = {
	low = "Defiance",
	medium = "Respect",
	high = 'Reverence',
}


func update():
	if person == null:return
	for i in get_tree().get_nodes_in_group("hide_master") + get_tree().get_nodes_in_group("hide_stranger") + get_tree().get_nodes_in_group("hide_traveler")+ get_tree().get_nodes_in_group("hide_servant"):
		i.visible = true
	if ResourceScripts.game_party.characters.has(person.id):
		type = 'slave'
		if person.has_profession('master'):
			type = 'master'
			for i in get_tree().get_nodes_in_group("hide_master"):
				i.visible = false
		if !person.check_location('mansion'):
			type = 'traveler'
			for i in get_tree().get_nodes_in_group("hide_traveler"):
				i.hide()
		for i in get_tree().get_nodes_in_group("hide_servant"):
			i.hide()
	else:
		type = 'stranger'
		for i in get_tree().get_nodes_in_group("hide_stranger"):
			i.visible = false
	for i in get_tree().get_nodes_in_group("show_traveler"):
		i.visible = type == 'traveler' && person.travel_target.location != 'mansion'
	var text = ''
	$name.text = person.get_short_name()
	$name/sex.texture = images.icons[person.get_stat('sex')]
#	if person.icon_image == null:
#		$Portrait.texture = null
#	else:
	$Portrait.texture = person.get_icon()
	$BodyPanel/Body.texture = person.get_body_image()
	$BodyPanel.visible = $BodyPanel/Body.texture != null
	$RichTextLabel.bbcode_text = person.make_description()
	globals.connecttexttooltip($character_class, tr(person.get_stat('slave_class').to_upper()+"CLASSDESCRIPT"))
	if person.travel.location != 'mansion':
		$RichTextLabel.bbcode_text += "\n\n" + person.translate(make_location_description())
	if person.get_work() != '':
		$currentwork.text = races.tasklist[person.get_work()].name
	else:
		$currentwork.text = tr('TASKREST')
	for i in $progress.get_children():
		i.text = str(floor(person.get_stat(i.name)))
		if person.get_stat(i.name+'_bonus') > 0:
			i.set("custom_colors/font_color", variables.hexcolordict.green) 
			i.text +=  "+"+ str(person.get_stat(i.name+'_bonus'))
		elif person.get_stat(i.name+'_bonus') < 0:
			i.set("custom_colors/font_color", variables.hexcolordict.red) 
			i.text += str(person.get_stat(i.name+'_bonus'))
		else:
			i.set("custom_colors/font_color", variables.hexcolordict.white) 
		if i.name != 'sexuals':
			i.text +=  '/' + str(person.get_stat(i.name +"_factor")*20)
		else:
			i.text += "/100"
	for i in $factors.get_children():
#		if i.name in ['base_exp']:
#			i.get_node("Label").text = str(floor(person.xp_module.get(i.name)))
#			continue
		if i.name in ['food_consumption', 'base_exp']:
			i.get_node("Label").text = str(floor(person.get_stat(i.name)))
			continue
		if input_handler.globalsettings.factors_as_words:
			i.get_node("Label").text = ResourceScripts.descriptions.factor_descripts[int(floor(person.get_stat(i.name)))]
			i.get_node("Label").set("custom_colors/font_color", variables.hexcolordict['factor'+str(int(floor(person.get_stat(i.name))))]) 
		else:
			i.get_node("Label").text = str(floor(person.get_stat(i.name)))
			i.get_node("Label").set("custom_colors/font_color", Color(1,1,1))
	for i in $base_stats.get_children():
		i.max_value = person.get_stat(i.name+'max')
		if i.name != 'lust': i.value = person.get_stat(i.name)
		else:i.value = person.get_stat(i.name)
		i.get_node("Label").text = str(floor(i.value)) + "/" + str(floor(i.max_value))
	
	var exp_color = Color(1,1,1)
	if person.get_next_class_exp() <= person.get_stat('base_exp'):
		exp_color = Color(0.2,1,0.2)
	$factors/base_exp/Label.set("custom_colors/font_color", exp_color)
	$factors/base_exp/Label.hint_tooltip = tr("NEXTCLASSEXP") + str(person.get_next_class_exp()) 
	
	if person.get_stat('loyalty') < 100 && person.get_stat('submission') < 100:
		$obedlabel.text = str(ceil(person.get_stat('obedience')))
	else:
		$obedlabel.text = "∞"
	if person.get_stat('obedience') > 0 || person.get_stat('loyalty') >= 100 || person.get_stat('submission') >= 100:
		$obedlabel/icon.texture = images.icons.obed_good
	else:
		$obedlabel/icon.texture = images.icons.obed_bad
	
	#$loyaltylabel.text = str(person.loyalty) + "/100"
	#$submissionlabel.text = str(person.submission) + "/100"
	$loyaltylabel.value = person.get_stat('loyalty')
	$submissionlabel.value = person.get_stat('submission')
	var authority
	if person.get_stat('authority') < person.authority_threshold()/2:
		authority = 'low'
	elif person.get_stat('authority') < person.authority_threshold():
		authority = 'medium'
	else:
		authority = 'high'
	text = authority_lines[authority]
	
	$authoritylabel.text = 'Authority: ' + text
#	$base_stats/lust.value = person.get_stat('lust')
#	$base_stats/lust.max_value = person.get_stat('lustmax')
#	$base_stats/lust/Label.text = str(floor(person.get_stat('lust'))) + '/' + str(person.get_stat('lustmax'))
	$productivity/Label.text = str(person.get_stat('productivity')) + "%"
	$character_class.text = statdata.slave_class_names[person.get_stat('slave_class')]
	
	
	text = statdata.statdata.obedience.descript
	
	text = ''
	$factors/food_consumption/Label.text = str(person.get_stat('food_consumption'))
	$food_love/Button.texture = images.icons[person.food.food_love]
	$food_love/Button.hint_tooltip = tr("FOODTYPE" +person.food.food_love.to_upper())
	$food_love/Button.visible = $food_love/Button.texture != null
	input_handler.ClearContainer($food_hate/Container)
	for i in person.food.food_hate:
		var newnode = input_handler.DuplicateContainerTemplate($food_hate/Container)
		newnode.texture = images.icons[i]
		newnode.hint_tooltip =  tr("FOODTYPE" +i.to_upper())
	
	input_handler.ClearContainer($professions)
	if person.xp_module.professions.size() > 5:
		$professions/Button.rect_min_size = Vector2(50,50)
		$professions/Button/Label.hide()
	else:
		$professions/Button.rect_min_size = Vector2(100,100)
		$professions/Button/Label.show()
	for i in person.xp_module.professions:
		var newnode = input_handler.DuplicateContainerTemplate($professions)
		var prof = classesdata.professions[i]
		var name = ResourceScripts.descriptions.get_class_name(prof, person)
		newnode.get_node("Label").text = name
		newnode.texture = prof.icon
		newnode.connect('signal_RMB_release',input_handler, 'show_class_info', [prof.code, person])
		var temptext = "[center]"+ResourceScripts.descriptions.get_class_name(prof,person) + "[/center]\n"+ResourceScripts.descriptions.get_class_bonuses(person, prof) + ResourceScripts.descriptions.get_class_traits(person, prof)
		temptext += "\n\n{color=aqua|" + tr("CLASSRIGHTCLICKDETAILS") + "}"
		globals.connecttexttooltip(newnode, temptext)
	#input_handler.active_character = person
	if $SkillPanel.visible == true:
		build_skill_panel()
	
	rebuild_traits()
	
	input_handler.ClearContainer($buffscontainer)
	for i in person.get_mansion_buffs():
		var newnode = input_handler.DuplicateContainerTemplate($buffscontainer)
		newnode.texture = i.icon
		if i.get_duration() != null and i.get_duration() >= 0:
			newnode.get_node("Label").text = str(i.get_duration())
		else:
			newnode.get_node("Label").hide()
		newnode.hint_tooltip = person.translate(i.description)
	
	text = "[center]" + statdata.statdata.productivity.name + "[/center]\n" + statdata.statdata.productivity.descript + "\nTotal Productivity: " + str(floor(person.get_stat('productivity'))) 
	for i in variables.productivity_mods:
		if person.get_stat(i) > 1:
			text += "\n{color=green|" + str(round(person.get_stat(i)*100)) + " - " + statdata.statdata[i].name + "}"
		elif person.get_stat(i) < 1:
			text += "\n{color=red|" + str(round(person.get_stat(i)*100)) + " - " + statdata.statdata[i].name + "}"
		else:
			text += "\n" + str(round(person.get_stat(i)*100)) + " - " + statdata.statdata[i].name
		
	
	$masterlabel.visible = person.has_profession('master')
	$masterlabel.text = person.translate('[master]').capitalize()
	
	$HirePanel/RichTextLabel.bbcode_text = person.translate("[center]You can hire [name] for [price] gold.[/center]") 
	$HirePanel/HireButton.disabled = person.calculate_price() > ResourceScripts.game_res.money
	$HirePanel.visible = person.get_stat('is_hirable')
	$HirePanel/Gold/Label.text = str(ResourceScripts.game_res.money)
	
	
	globals.connecttexttooltip($productivity, globals.TextEncoder(text))



func rebuild_traits():
	
	input_handler.ClearContainer($ScrollContainer/traits)
	for i in person.statlist.traits:
		var trait = Traitdata.traits[i]
		if trait.visible == false:
			continue
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/traits)
		newnode.text = trait.name
	
	for i in person.statlist.sex_traits + person.statlist.negative_sex_traits:
		var trait = Traitdata.sex_traits[i]
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/traits)
		newnode.text = trait.name
		var traittext = person.translate(trait.descript)
		for j in trait.reqs:
			if j.has('code') && j.code == 'action_type':
				traittext += "\n\nDisliked actions:[color=aqua] "
				for k in j.value:
					#print(globals.sex_actions_dict[k].getname())
					globals.sex_actions_dict[k].givers = []
					globals.sex_actions_dict[k].takers = []
					traittext += globals.sex_actions_dict[k].getname() + ", "
				traittext = traittext.substr(0, traittext.length() - 2) + ".[/color]"
		globals.connecttexttooltip(newnode, traittext)

func make_location_description():
	return person.get_current_location_desc()


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

func open_class_selection():
	$class_learn.open(person)

func open_jobs_window():
	$job_panel.show()
	$job_panel/job_details.hide()
	input_handler.ClearContainer($job_panel/ScrollContainer/VBoxContainer)
	currentjob = null
	var restbutton = input_handler.DuplicateContainerTemplate($job_panel/ScrollContainer/VBoxContainer)
	restbutton.text = tr("TASKREST")
	restbutton.connect("pressed", self, 'set_rest')
	
	for i in races.tasklist.values():
		if globals.checkreqs(i.reqs) == false:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($job_panel/ScrollContainer/VBoxContainer)
		newbutton.text = i.name
		newbutton.connect('pressed', self, 'show_job_details', [i])
		if person.tags.has('no_sex') && i.tags.has("sex"):
			newbutton.disabled = true
			globals.connecttexttooltip(newbutton, person.translate(tr("INTERACTIONSNOSEXTAG")))
	
	for i in person.xp_module.work_rules:
		get_node("job_panel/work_rules/"+ i).pressed = person.xp_module.work_rules[i]
	$job_panel/work_rules/constrain.visible = !person.has_profession('master')

var currentjob

func show_job_details(job):
	currentjob = job
	$job_panel/job_details.show()
	input_handler.ClearContainer($job_panel/job_details/ResourceOptions)
	for i in $job_panel/ScrollContainer/VBoxContainer.get_children():
		i.pressed = i.text == job.name
	var text =  "[center]" + job.name + '[/center]\n' + job.descript + "\n\n" + tr("TASKMAINSTAT") + ": [color=yellow]" + statdata.statdata[job.workstat].name + "[/color]"
	if job.has("worktool"):
		text += "\n" + tr("WORKTOOL") + ": [color=aqua]" + statdata.worktoolnames[job.worktool] + "[/color]. \n"
		if person.equipment.gear.tool != null:
			var item = ResourceScripts.game_res.items[person.equipment.gear.tool]
			if item.toolcategory.has(job.worktool):
				text += "[color=green]" + tr("CORRECTTOOLEQUIPPED") +"[/color]"
	
	$job_panel/job_details/RichTextLabel.bbcode_text = text
	
	for i in job.production.values():
		if globals.checkreqs(i.reqs) == false:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($job_panel/job_details/ResourceOptions)
		if Items.materiallist.has(i.item):
			var number
			number = person.get_progress_task(job.code, i.code)/i.progress_per_item
			text = "\n[color=yellow]Expected gain per day: " + str(stepify(number*24,0.1)) + "[/color]"
#			else:
#				number = stepify(person.workhours*races.get_progress_task(person, job.code, i.code)/i.progress_per_item*(person.productivity*person.get_stat(job.mod)/100),0.1)
#				text = "\n[color=yellow]Expected gain per work day: " + str(number) + "[/color]"
			newbutton.get_node("icon").texture = Items.materiallist[i.item].icon
			newbutton.get_node("number").text = str(stepify(number*24,0.1))
			globals.connectmaterialtooltip(newbutton, Items.materiallist[i.item], text)
		else:
			var number
			number = person.get_progress_task(job.code, i.code)/i.progress_per_item
			text = "\n[color=yellow]Expected gain per day: " + str(stepify(number*24,0.1)) + "[/color]"
#			else:
#				number = stepify(person.workhours*races.get_progress_task(person, job.code, i.code)/i.progress_per_item*(person.productivity*person.get_stat(job.mod)/100),0.1)
#				text = "\n[color=yellow]Expected gain per work day: " + str(number) + "[/color]"
			newbutton.get_node("number").text = str(stepify(number*24,0.1))
			newbutton.get_node("icon").texture = i.icon
			globals.connecttexttooltip(newbutton, i.descript + text)
			
		newbutton.connect('pressed', self, 'select_job', [job, i.code])

func set_rest():
	person.remove_from_task()
	$job_panel.hide()
	update()

func select_job(job, production):
	person.assign_to_task(job.code, production)
	$job_panel.hide()
	update()
	input_handler.slave_list_node.update()

func set_work_rule(rule):
	var setting = get_node("job_panel/work_rules/"+rule).pressed
	person.xp_module.work_rules[rule] = setting
	match setting:
		true:
			var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table["work_rule_" + rule])
			person.apply_effect(effects_pool.add_effect(eff))
		false:
			person.remove_static_effect_by_code("work_rule_" + rule)
	
	
	if currentjob != null:
		show_job_details(currentjob)
	update()


func build_skill_panel():
	input_handler.ClearContainer($SkillPanel)
	var src
	if person.skills.active_panel == variables.PANEL_SOC:
		src = person.skills.social_skill_panel
		$skillpanelswitch.pressed = false
	else:
		src = person.skills.combat_skill_panel
		$skillpanelswitch.pressed = true
	for i in range(1,10):
		var text = ''
		var newbutton = input_handler.DuplicateContainerTemplate($SkillPanel)
		if src.has(i):
			var skill = Skilldata.Skilllist[src[i]]
			newbutton.get_node("icon").texture = skill.icon
			if skill.icon == null:
				newbutton.get_node("icon").texture = load("res://assets/images/gui/panels/noimage.png")
			newbutton.get_node("icon").show()
			if skill.manacost > 0:
				newbutton.get_node("manacost").visible = true
				newbutton.get_node("manacost").text = str(skill.manacost)
				if person.mp < skill.manacost:
					newbutton.disabled = true
					newbutton.get_node("icon").material = load("res://assets/sfx/bw_shader.tres")
#			if skill.energycost > 0:
#				newbutton.get_node("energycost").visible = true
#				newbutton.get_node("energycost").text = str(skill.energycost)
#				if person.get_stat('energy') < skill.energycost:
#					newbutton.disabled = true
#					newbutton.get_node("icon").material = load("res://assets/sfx/bw_shader.tres")
			var charges = Skilldata.get_charges(skill, person)
			var used_charges = 0
			if person.skills.social_skills_charges.has(skill.code):
				used_charges = person.skills.social_skills_charges[skill.code]
			if skill.has('custom_used_charges'):
				#stub - for i'm haiting to use injections and functors this way
				#additional functional can be added here
				if skill.custom_used_charges[0] == 'call':
					used_charges = person.call(skill.custom_used_charges[1], skill.custom_used_charges[2])
			text = str(charges - used_charges) + "/" + str(charges)
			
			if person.checkreqs(skill.reqs) == false:
				newbutton.disabled = true
				newbutton.get_node("icon").material = load("res://assets/sfx/bw_shader.tres")
			newbutton.get_node("charges").text = text
			newbutton.get_node("charges").show()
			if charges - used_charges <= 0:
				newbutton.disabled = true
			if person.skills.active_panel == variables.PANEL_COM: newbutton.disabled = true
			
			newbutton.connect("pressed",self,"select_skill_target", [skill.code])
			globals.connectskilltooltip(newbutton, skill.code, person)
		else:
			newbutton.connect('pressed',self,'select_skill_for_position', [i])
		
		newbutton.set_script(ResourceScripts.scriptdict.rclickbutton)
		newbutton.connect('signal_RMB_release',self,'select_skill_for_position', [i])
		if person.skills.active_panel == variables.PANEL_COM:
			newbutton.texture_disabled = load("res://assets/images/gui/universal/skill_frame.png")
			newbutton.get_node("charges").hide()

var active_position
var active_skill

func change_panel_type():
	if person.skills.active_panel == variables.PANEL_SOC:
		person.skills.active_panel = variables.PANEL_COM
	elif person.skills.active_panel == variables.PANEL_COM: #redundant check for the case of any of future changes
		person.skills.active_panel = variables.PANEL_SOC
	build_skill_panel()

func select_skill_for_position(position):
	active_position = position
	input_handler.ShowSkillSelectPanel(person, person.skills.active_panel, self, 'skill_selected')

func skill_selected(skill):
	if skill == null:
		if person.skills.active_panel == variables.PANEL_SOC:
			person.skills.social_skill_panel.erase(active_position)
		else:
			person.skills.combat_skill_panel.erase(active_position)
	else:
		if person.skills.active_panel == variables.PANEL_SOC:
			person.skills.social_skill_panel[active_position] = skill
		else:
			person.skills.combat_skill_panel[active_position] = skill
	build_skill_panel()

func select_skill_target(skillcode):
	active_skill = skillcode
	input_handler.ShowSlaveSelectPanel(self, 'use_skill', [{code = 'is_free', check = true}, {code = 'is_id', operant = 'neq', value = person.id}] + Skilldata.Skilllist[skillcode].targetreqs)

func use_skill(target):
	person.use_social_skill(active_skill, target)
	update()

func custom_description_open():
	var node = input_handler.get_spec_node(input_handler.NODE_TEXTEDIT) #input_handler.GetTextEditNode()
	node.open(self, 'custom_description_set', person.get_stat('bonus_description'))

func custom_description_set(text):
	person.set_stat('bonus_description', text)
	update()

func custom_nickname_open():
	var node = input_handler.get_spec_node(input_handler.NODE_TEXTEDIT) #input_handler.GetTextEditNode()
	node.open(self, 'custom_nickname_set', person.get_stat('nickname'))

func custom_nickname_set(text):
	person.set_stat('nickname', text)
	update()

func custom_masternoun_open():
	var node = input_handler.get_spec_node(input_handler.NODE_TEXTEDIT) #input_handler.GetTextEditNode()
	node.open(self, 'custom_masternoun_set', person.get_stat('masternoun'))

func custom_masternoun_set(text):
	person.set_stat('masternoun', text)
	update()

var universal_skills = ['oral','anal','petting']

func open_customize_button():
	$DetailsPanel.show()
	input_handler.ClearContainer($DetailsPanel/SexSkills)
	$DetailsPanel/ConsentLabel.text = "Consent: " + str(floor(person.get_stat('consent')))
	var s_skills = person.get_stat('sex_skills')
	for i in s_skills:
		if s_skills[i] == 0 && universal_skills.find(i) < 0:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($DetailsPanel/SexSkills)
		newbutton.get_node("Label").text = tr("SEXSKILL"+i.to_upper())
		newbutton.get_node("ProgressBar").value = s_skills[i]
		newbutton.get_node("ProgressBar/Label").text = str(floor(s_skills[i])) + '/100'
		globals.connecttexttooltip(newbutton,  person.translate(tr("SEXSKILL"+i.to_upper()+"DESCRIPT")) + "\nCurrent level:" + str(floor(s_skills[i])))

func show_gear_gui():
	var inventory = input_handler.get_spec_node(input_handler.NODE_INVENTORY, [{mode = 'character', person = person}]) #input_handler.ShowInentory({mode = 'character', person = person})


func open_diet_window():
	$DietPanel.show()
	input_handler.ClearContainer($DietPanel/ScrollContainer/VBoxContainer)
	$DietPanel/RichTextLabel.bbcode_text = tr("INFOFOODFILTER")
	var array = []
	for i in Items.materiallist.values():
		if i.type == 'food' && i.tags.size() > 0:
			array.append(i)
	array.sort_custom(self, 'sort_food')
	for i in array:
		var newbutton = input_handler.DuplicateContainerTemplate($DietPanel/ScrollContainer/VBoxContainer)
		newbutton.get_node("Label").text = i.name
		globals.connectmaterialtooltip(newbutton, i)
		for k in ['high','med','low','disable']:
			if person.food.food_filter[k].has(i.code):
				newbutton.get_node("filter").text = tr("FOODFILTER" + k.to_upper())
				newbutton.get_node("filter").set("custom_colors/font_color", Color(variables.hexcolordict[categorycolors[k]]))
				break
		newbutton.connect("pressed", self, "change_food_category", [i.code])

func change_food_category(foodcode):
	var current_category
	for i in ['high','med','low','disable']:
		if person.food.food_filter[i].has(foodcode):
			current_category = i
			break
	person.food.food_filter[current_category].erase(foodcode)
	var newcategory
	if category_order.size() > category_order.find(current_category)+1:
		newcategory = category_order[category_order.find(current_category)+1]
	else:
		newcategory = category_order[0]
	person.food.food_filter[newcategory].append(foodcode)
	#input_handler.GetItemTooltip().hide()
	input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
	open_diet_window()

var category_order = ['high','med','low','disable']
var categorycolors = {high = "green", med = 'yellow', low = 'red', disable = 'gray'}

func sort_food(first, second):
	if first.name >= second.name:
		return false
	else:
		return true


func return_to_mansion_confirm():
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'return_to_mansion', person.translate(tr("RETURNCHARACTERCONFIRM"))])
	#input_handler.ShowConfirmPanel(self, 'return_to_mansion', person.translate(tr("RETURNCHARACTERCONFIRM")))

func return_to_mansion():
	person.return_to_mansion()
	update()
	input_handler.update_slave_list()


func chooseimage(type):
	$ImageSelect.chooseimage(person, type)

func sex_traits_open():
	$SexTraitsPanel.show()
	input_handler.ClearContainer($SexTraitsPanel/ScrollContainer/VBoxContainer)
	var array = person.statlist.unlocked_sex_traits.duplicate()
	array.sort_custom(self, 'sort_traits')
	for i in array:
		var newbutton = input_handler.DuplicateContainerTemplate($SexTraitsPanel/ScrollContainer/VBoxContainer)
		newbutton.pressed = person.check_trait(i)
		newbutton.text = Traitdata.sex_traits[i].name
		globals.connecttexttooltip(newbutton, person.translate(Traitdata.sex_traits[i].descript))
		newbutton.connect("toggled", self, 'toggle_trait', [i])
	update_trait_capacity()

func update_trait_capacity():
	var text = 'Current Capacity: ' + str(person.statlist.sex_traits.size()) + "/" + str(person.get_stat('sexuals_factor')+1)
	$SexTraitsPanel/TraitCapacity.text = text
	for i in $SexTraitsPanel/ScrollContainer/VBoxContainer.get_children():
		i.disabled = person.get_stat('sexuals_factor')+1 - person.statlist.sex_traits.size() <= 0 && i.pressed == false

func sort_traits(first,second):
	if Traitdata.sex_traits[first].name >= Traitdata.sex_traits[second].name:
		return false
	else:
		return true

func toggle_trait(trait_status, trait):
	match trait_status:
		true:
			if !person.check_trait(trait):
				person.add_sex_trait(trait)
		false:
			if person.check_trait(trait):
				person.remove_sex_trait(trait, false)
	update_trait_capacity()
	rebuild_traits()
