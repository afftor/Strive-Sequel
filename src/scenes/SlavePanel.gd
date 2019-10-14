extends "res://files/Close Panel Button/ClosingPanel.gd"

#warning-ignore-all:return_value_discarded

var person

var type

func _input(event):
	if self.visible == false || $SkillPanel.visible == false || input_handler.text_field_input == true:
		return
	if person != null and person.active_panel == variables.PANEL_COM: return
	if str(event.as_text().replace("Kp ",'')) in str(range(0,9)) && event.is_pressed():
		var number = int(event.as_text().replace("Kp ",''))-1
		if $SkillPanel.get_child(number).disabled == false:
			$SkillPanel.get_child(number).emit_signal("pressed")


func _ready():
	#setting tooltips
	
	for i in $progress.get_children():
		#i.connect("mouse_entered", self, "show_progress_tooltip", [i])
		globals.connecttexttooltip(i, globals.statdata[i.name].descript)
	for i in $factors.get_children():
		globals.connecttexttooltip(i, globals.statdata[i.name].descript)
	
	
	for i in $base_stats.get_children():
		globals.connecttexttooltip(i, globals.statdata[i.name].descript)
	
	for i in ['restup', 'workup', 'joyup', 'restdown', 'workdown', 'joydown']:

		get_node("job_panel/job_details/WorkDetailsPanel/"+i).connect("pressed", self, "change_hours", [i])
	
	
	globals.connecttexttooltip($food_love,"[center]" +globals.statdata.food_love.name + "[/center]\n"+  globals.statdata.food_love.descript)
	globals.connecttexttooltip($food_hate,"[center]" +globals.statdata.food_hate.name + "[/center]\n"+ globals.statdata.food_hate.descript)
	
	###############
	$skillpanelswitch.connect("pressed", self, "change_panel_type")
	
	$controls/ClassButton.connect("pressed",self ,'open_class_selection')
	globals.AddPanelOpenCloseAnimation($job_panel)

	globals.AddPanelOpenCloseAnimation($DietPanel)

	$job_panel.move_child($job_panel/CloseButton, 3)
	
	$job_panel/job_details/SimpleBehaviorCheck.connect("pressed", self, "check_simple_behavior")
	
	$controls/DietButton.connect("pressed", self, "open_diet_window")
	$controls/JobButton.connect("pressed", self, "open_jobs_window")
	$controls/CustmizeButton.connect('pressed', self, "open_customize_button")
	$controls/GearButton.connect("pressed", self, "show_gear_gui")
	$controls/ReturnButton.connect("pressed", self, "return_to_mansion_confirm")
	
	$RichTextLabel.connect("meta_hover_started", self, 'text_url_hover')
	$RichTextLabel.connect("meta_hover_ended", self, "text_url_hover_hide")
	
	globals.AddPanelOpenCloseAnimation($DetailsPanel)
	$DetailsPanel/VBoxContainer/descript.connect("pressed", self, "custom_description_open")
	$DetailsPanel/VBoxContainer/icon.connect("pressed", self, "chooseimage",['portrait'])
	$DetailsPanel/VBoxContainer/body.connect("pressed", self, "chooseimage",['body'])
	$DetailsPanel/VBoxContainer/nickname.connect("pressed", self, "custom_nickname_open")
	
	input_handler.slave_panel_node = self
	
	
	$testbutton.connect('pressed', self, "run_test")
	
	$BodyPanel/opacity.connect("value_changed", self, "set_body_opacity")
	$BodyPanel/StatsButton.connect("pressed", self, "stats_panel")
	
	for i in $job_panel/work_rules.get_children():
		i.connect('pressed', self, 'set_work_rule', [i.name])
		i.hint_tooltip = "WORKRULE" + i.name.to_upper() + "DESCRIPT"
	


func run_test():
	person.apply_custom_bodychange('sex', 'female')
	open(person)

func stats_panel():
	$BodyPanel/StatsPanel.open(person)
	$"BodyPanel/StatsPanel".visible = !$BodyPanel/StatsPanel.visible

func set_body_opacity(value):
	for i in [$BodyPanel, $BodyPanel/Body]:
		i.self_modulate = Color(1,1,1, value/100)

var foodicons = {
	meat = load("res://assets/images/gui/gui icons/icon_meat.png"),
	fish = load("res://assets/images/gui/gui icons/icon_fish.png"),
	vege = load("res://assets/images/gui/gui icons/icon_veg.png"),
	grain = load("res://assets/images/gui/gui icons/icon_grain.png")
	
}

func open(tempperson):
	if tempperson == null:
		tempperson = person
	person = tempperson
	$job_panel.hide()
	$class_learn.hide()
	input_handler.ActivateTutorial('slavetab')
	show()
	update()

func update():
	for i in get_tree().get_nodes_in_group("hide_master") + get_tree().get_nodes_in_group("hide_stranger") + get_tree().get_nodes_in_group("hide_traveler"):
		i.visible = true
	if state.characters.has(person.id):
		type = 'slave'
		if state.get_master() == person:
			type = 'master'
			for i in get_tree().get_nodes_in_group("hide_master"):
				i.visible = false
		if person.location != 'mansion':
			type = 'traveler'
			for i in get_tree().get_nodes_in_group("hide_traveler"):
				i.hide()
	else:
		type = 'stranger'
		for i in get_tree().get_nodes_in_group("hide_stranger"):
			i.visible = false
	for i in get_tree().get_nodes_in_group("show_traveler"):
		i.visible = type == 'traveler' && person.travel_target.location != 'mansion'
	var text = ''
	$name.text = person.get_short_name()
	$name/sex.texture = globals.sexicons[person.sex]
	if person.icon_image == null:
		$Portrait.texture = null
	else:
		$Portrait.texture = person.get_icon()
	$BodyPanel/Body.texture = person.get_body_image()
	$BodyPanel.visible = $BodyPanel/Body.texture != null
	$RichTextLabel.bbcode_text = person.make_description()
	globals.connecttexttooltip($character_class, tr(person.slave_class.to_upper()+"CLASSDESCRIPT"))
	if person.location == 'travel':
		$RichTextLabel.bbcode_text += "\n\n" + person.translate(make_location_description())
	if person.work != '':
		$currentwork.text = races.tasklist[person.work].name
	else:
		$currentwork.text = ''
	for i in $progress.get_children():
		i.text = str(floor(person.get(i.name)))
		if person.get(i.name+'_bonus') > 0:
			i.set("custom_colors/font_color", globals.hexcolordict.green) 
			i.text +=  "+"+ str(person.get(i.name+'_bonus'))
		elif person.get(i.name+'_bonus') < 0:
			i.set("custom_colors/font_color", globals.hexcolordict.red) 
			i.text += str(person.get(i.name+'_bonus'))
		else:
			i.set("custom_colors/font_color", globals.hexcolordict.white) 
		i.text +=  '/' + str(person.get(i.name +"_factor")*20)
	for i in $factors.get_children():
		if i.name in ['base_exp','food_consumption']:
			i.get_node("Label").text = str(floor(person.get(i.name)))
			continue
		if globals.globalsettings.factors_as_words:
			i.get_node("Label").text = globals.descriptions.factor_descripts[int(floor(person.get(i.name)))]
			i.get_node("Label").set("custom_colors/font_color", globals.hexcolordict['factor'+str(int(floor(person.get(i.name))))]) 
		else:
			i.get_node("Label").text = str(floor(person.get(i.name)))
			i.get_node("Label").set("custom_colors/font_color", Color(1,1,1))
	for i in $base_stats.get_children():
		i.max_value = person.get(i.name+'max')
		i.value = person.get(i.name)
		i.get_node("Label").text = str(floor(person.get(i.name))) + "/" + str(floor(person.get(i.name+'max')))
	
	var exp_color = Color(1,1,1)
	if person.get_next_class_exp() <= person.base_exp:
		exp_color = Color(0.2,1,0.2)
	$factors/base_exp/Label.set("custom_colors/font_color", exp_color)
	$factors/base_exp/Label.hint_tooltip = tr("NEXTCLASSEXP") + str(person.get_next_class_exp()) 
	
#	$mentality/loyal.value = person.loyal
#	$mentality/loyal/Label.text = str(floor(person.loyal)) + '/' + '100'
	$mentality/obedience.value = person.obedience
	$mentality/obedience/Label.text = str(floor(person.obedience)) + '/' + '100'
	$mentality/obedience/decay.text = 'Daily Decay: ' + str(round(person.get_obed_reduction()*24))
	$mentality/fear.value = person.fear
	$mentality/fear/Label.text = str(floor(person.fear)) + '/' + '100'
	$mentality/fear/decay.text = 'Daily Decay: ' + str(round(person.get_fear_reduction()*24))
	$base_stats/lust.value = person.lust
	$base_stats/lust.max_value = person.lustmax
	$base_stats/lust/Label.text = str(floor(person.lust)) + '/' + str(person.lustmax)
	$productivity/Label.text = str(person.get_stat('productivity')) + "%"
	$character_class.text = person.slave_class.capitalize()
	
	if person.obedience > 50:
		$mentality/obedience/Label.set("custom_colors/font_color",globals.hexcolordict.green)
	elif person.obedience > person.brave_factor*7:
		$mentality/obedience/Label.set("custom_colors/font_color",globals.hexcolordict.yellow)
	else:
		if person.check_escape_chance() == true:
			$mentality/obedience/Label.set("custom_colors/font_color",globals.hexcolordict.red)
		else:
			$mentality/obedience/Label.set("custom_colors/font_color",globals.hexcolordict.gray)
	$obedlabel.set("custom_colors/font_color", $mentality/obedience/Label.get("custom_colors/font_color"))
	if person.fear > 50:
		$mentality/fear/Label.set("custom_colors/font_color",globals.hexcolordict.green)
	elif person.fear > person.brave_factor*7:
		$mentality/fear/Label.set("custom_colors/font_color",globals.hexcolordict.yellow)
	else:
		if person.check_escape_chance() == true:
			$mentality/fear/Label.set("custom_colors/font_color",globals.hexcolordict.red)
		else:
			$mentality/fear/Label.set("custom_colors/font_color",globals.hexcolordict.gray)
	$fearlabel.set("custom_colors/font_color", $mentality/fear/Label.get("custom_colors/font_color"))
	
	
	text = globals.statdata.obedience.descript
	if person.has_status('no_obed_reduce'):
		text += "\n\n[color=green]No decay[/color]"
	else:
		text += '\n\n[color=yellow]Expected daily decay: ' + str(round(person.get_obed_reduction()*24)) + "[/color]"
	globals.connecttexttooltip($mentality/obedience, text)
	text = globals.statdata.fear.descript
	if person.has_status('no_fear_reduce'):
		text += "\n\n[color=green]No decay[/color]"
	else:
		text += '\n\n[color=yellow]Expected daily decay: ' + str(round(person.get_fear_reduction()*24)) + "[/color]"
	globals.connecttexttooltip($mentality/fear, text)
	
	text = ''
	$factors/food_consumption/Label.text = str(person.food_consumption)
	$food_love/Button.texture = foodicons[person.food_love]
	$food_love/Button.hint_tooltip = tr("FOODTYPE" +person.food_love.to_upper())
	$food_love/Button.visible = $food_love/Button.texture != null
	globals.ClearContainer($food_hate/Container)
	for i in person.food_hate:
		var newnode = globals.DuplicateContainerTemplate($food_hate/Container)
		newnode.texture = foodicons[i]
		newnode.hint_tooltip =  tr("FOODTYPE" +i.to_upper())
	
	globals.ClearContainer($professions)
	if person.professions.size() > 5:
		$professions/Button.rect_min_size = Vector2(50,50)
		$professions/Button/Label.hide()
	else:
		$professions/Button.rect_min_size = Vector2(100,100)
		$professions/Button/Label.show()
	for i in person.professions:
		var newnode = globals.DuplicateContainerTemplate($professions)
		var prof = Skilldata.professions[i]
		var name = prof.name
		if prof.has('altname') && person.checkreqs(prof.altnamereqs):
			name = prof.altname
		newnode.get_node("Label").text = name
		newnode.texture = prof.icon
		globals.connecttexttooltip(newnode, globals.descriptions.get_class_details(person, prof, false))
	
	if $SkillPanel.visible == true:
		build_skill_panel()
	
	globals.ClearContainer($traits)
	for i in person.traits:
		var trait = Traitdata.traits[i]
		if trait.visible == false:
			continue
		var newnode = globals.DuplicateContainerTemplate($traits)
		newnode.text = trait.name
	
	
	for i in person.sex_traits:
		var trait = Traitdata.sex_traits[i]
		var newnode = globals.DuplicateContainerTemplate($traits)
		newnode.text = trait.name
		globals.connecttexttooltip(newnode, person.translate(trait.descript))
	
	globals.ClearContainer($buffscontainer)
	for i in person.get_mansion_buffs():
		var newnode = globals.DuplicateContainerTemplate($buffscontainer)
		newnode.texture = i.icon
		if i.get_duration() != null and i.get_duration() >= 0:
			newnode.get_node("Label").text = str(i.get_duration())
		else:
			newnode.get_node("Label").hide()
		newnode.hint_tooltip = person.translate(i.description)
	
	text = "[center]" + globals.statdata.productivity.name + "[/center]\n" + globals.statdata.productivity.descript + "\nTotal Productivity: " + str(floor(person.get_stat('productivity'))) 
	for i in variables.productivity_mods:
		if person.get_stat(i) > 1:
			text += "\n{color=green|" + str(round(person.get_stat(i)*100)) + " - " + globals.statdata[i].name + "}"
		elif person.get_stat(i) < 1:
			text += "\n{color=red|" + str(round(person.get_stat(i)*100)) + " - " + globals.statdata[i].name + "}"
		else:
			text += "\n" + str(round(person.get_stat(i)*100)) + " - " + globals.statdata[i].name
		
	
	$masterlabel.visible = person.professions.has('master')
	$masterlabel.text = person.translate('[master]').capitalize()
	
	globals.connecttexttooltip($productivity, globals.TextEncoder(text))



func make_location_description():
	var text = ''
	var active_area_name
	var active_location_name
	if person.location == 'travel':
		if person.travel_target.location == 'mansion':
			active_location_name = 'Mansion'
			active_area_name = state.starting_area
		else:
			active_area_name = state.areas[state.location_links[person.travel_target.location].area].name
			active_location_name = state.areas[state.location_links[person.travel_target.location].area][state.location_links[person.travel_target.location].category][person.travel_target.location].name
	else:
		active_area_name = state.areas[state.location_links[person.location].area].name
		active_location_name = state.areas[state.location_links[person.location].area][state.location_links[person.location].category][person.travel_target.location].name
	
	if person.location == 'travel':
		text = '[name] currently relocating to [color=yellow]' + active_location_name + "[/color], which is located at [color=aqua]" + active_area_name + "[/color]. [He] will be there in " + str(round(person.travel_time / person.travel_tick())) + ' hours.'
	else:
		text = '[name] currently positioned at [color=yellow]' + active_location_name + "[/color], which is located at [color=aqua]" + active_area_name + "[/color]"
	return text


func text_url_hover(meta):
	match meta:
		'race':
			var texttooltip = input_handler.GetTextTooltip()
			texttooltip.showup($RichTextLabel, person.show_race_description())
			yield(get_tree(), 'idle_frame')
			texttooltip.rect_global_position = get_global_mouse_position()
	#globals.connecttexttooltip($RichTextLabel, person.show_race_description())

func text_url_hover_hide(meta = null):
	match meta:
		'race':
			var texttooltip = input_handler.GetTextTooltip()
			texttooltip.hide()

func open_class_selection():
	$class_learn.open(person)

func open_jobs_window():
	$job_panel.show()
	$job_panel/job_details.hide()
	globals.ClearContainer($job_panel/ScrollContainer/VBoxContainer)
	currentjob = null
	var restbutton = globals.DuplicateContainerTemplate($job_panel/ScrollContainer/VBoxContainer)
	restbutton.text = "Rest"
	restbutton.connect("pressed", self, 'set_rest')
	
	for i in races.tasklist.values():
		if state.checkreqs(i.reqs) == false:
			continue
		var newbutton = globals.DuplicateContainerTemplate($job_panel/ScrollContainer/VBoxContainer)
		newbutton.text = i.name
		newbutton.connect('pressed', self, 'show_job_details', [i])
		if person.tags.has('no_sex') && i.tags.has("sex"):
			newbutton.disabled = true
			globals.connecttexttooltip(newbutton, person.translate(tr("INTERACTIONSNOSEXTAG")))
	
	for i in person.work_rules:
		get_node("job_panel/work_rules/"+ i).pressed = person.work_rules[i]
	$job_panel/work_rules/constrain.visible = person != state.get_master()

var currentjob

func show_job_details(job):
	currentjob = job
	$job_panel/job_details.show()
	globals.ClearContainer($job_panel/job_details/ResourceOptions)
	for i in $job_panel/ScrollContainer/VBoxContainer.get_children():
		i.pressed = i.text == job.name
	var text =  "[center]" + job.name + '[/center]\n' + job.descript + "\n\n" + tr("TASKMAINSTAT") + ": [color=yellow]" + globals.statdata[job.workstat].name + "[/color]"
	if job.has("worktool"):
		text += "\n" + tr("WORKTOOL") + ": [color=aqua]" + globals.worktoolnames[job.worktool] + "[/color]. \n"
		if person.gear.rhand != null:
			var item = state.items[person.gear.rhand]
			if item.toolcategory == job.worktool:
				text += "[color=green]" + tr("CORRECTTOOLEQUIPPED") +"[/color]"
	
	$job_panel/job_details/RichTextLabel.bbcode_text = text
	

	

	for i in job.production.values():
		if state.checkreqs(i.reqs) == false:
			continue
		var newbutton = globals.DuplicateContainerTemplate($job_panel/job_details/ResourceOptions)
		if Items.materiallist.has(i.item):
			var number
			number = races.get_progress_task(person, job.code, i.code)/i.progress_per_item
			text = "\n[color=yellow]Expected gain per day: " + str(stepify(number*24,0.1)) + "[/color]"
#			else:
#				number = stepify(person.workhours*races.get_progress_task(person, job.code, i.code)/i.progress_per_item*(person.productivity*person.get_stat(job.mod)/100),0.1)
#				text = "\n[color=yellow]Expected gain per work day: " + str(number) + "[/color]"
			newbutton.get_node("icon").texture = Items.materiallist[i.item].icon
			newbutton.get_node("number").text = str(stepify(number*24,0.1))
			globals.connectmaterialtooltip(newbutton, Items.materiallist[i.item], text)
		else:
			var number
			number = races.get_progress_task(person, job.code, i.code)/i.progress_per_item
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
	person.work = ''
	$job_panel.hide()
	open(person)

func select_job(job, production):
	person.assign_to_task(job.code, production)
	$job_panel.hide()
	open(person)

func set_work_rule(rule):
	var setting = get_node("job_panel/work_rules/"+rule).pressed
	person.work_rules[rule] = setting
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
	globals.ClearContainer($SkillPanel)
	var src
	if person.active_panel == variables.PANEL_SOC: src = person.social_skill_panel
	else: src = person.combat_skill_panel
	for i in range(1,10):
		var text = ''
		var newbutton = globals.DuplicateContainerTemplate($SkillPanel)
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
			if skill.energycost > 0:
				newbutton.get_node("energycost").visible = true
				newbutton.get_node("energycost").text = str(skill.energycost)
				if person.energy < skill.energycost:
					newbutton.disabled = true
					newbutton.get_node("icon").material = load("res://assets/sfx/bw_shader.tres")
			if person.social_skills_charges.has(skill.code):
				text = str(skill.charges - person.social_skills_charges[skill.code]) + "/" + str(skill.charges)
			else:
				text = str(skill.charges) + "/" + str(skill.charges)
			
			if person.checkreqs(skill.reqs) == false:
				newbutton.disabled = true
				newbutton.get_node("icon").material = load("res://assets/sfx/bw_shader.tres")
			newbutton.get_node("charges").text = text
			newbutton.get_node("charges").show()
			if person.social_skills_charges.has(skill.code) && skill.charges - person.social_skills_charges[skill.code] <= 0:
				newbutton.disabled = true
			if person.active_panel == variables.PANEL_COM: newbutton.disabled = true
			
			newbutton.connect("pressed",self,"select_skill_target", [skill.code])
			globals.connectskilltooltip(newbutton, skill.code, person)
		else:
			newbutton.connect('pressed',self,'select_skill_for_position', [i])
		
		newbutton.set_script(load("res://src/RightClickReactButton.gd"))
		newbutton.connect('signal_RMB',self,'select_skill_for_position', [i])
		if person.active_panel == variables.PANEL_COM:
			newbutton.texture_disabled = load("res://assets/images/gui/universal/skill_frame.png")
			newbutton.get_node("charges").hide()

var active_position
var active_skill

func change_panel_type():
	if person.active_panel == variables.PANEL_SOC:
		person.active_panel = variables.PANEL_COM
	elif person.active_panel == variables.PANEL_COM: #redundant check for the case of any of future changes
		person.active_panel = variables.PANEL_SOC
	build_skill_panel()

func select_skill_for_position(position):
	active_position = position
	input_handler.ShowSkillSelectPanel(person, person.active_panel, self, 'skill_selected')

func skill_selected(skill):
	if skill == null:
		if person.active_panel == variables.PANEL_SOC:
			person.social_skill_panel.erase(active_position)
		else:
			person.combat_skill_panel.erase(active_position)
	else:
		if person.active_panel == variables.PANEL_SOC:
			person.social_skill_panel[active_position] = skill
		else:
			person.combat_skill_panel[active_position] = skill
	build_skill_panel()

func select_skill_target(skillcode):
	active_skill = skillcode
	input_handler.ShowSlaveSelectPanel(self, 'use_skill', [{code = 'is_free'}, {code = 'is_id', operant = 'neq', value = person.id}] + Skilldata.Skilllist[skillcode].targetreqs)

func use_skill(target):
	person.use_social_skill(active_skill, target)
	open(person)

func custom_description_open():
	var node = input_handler.GetTextEditNode()
	node.open(self, 'custom_description_set', person.bonus_description)

func custom_description_set(text):
	person.bonus_description = text
	open(person)

func custom_nickname_open():
	var node = input_handler.GetTextEditNode()
	node.open(self, 'custom_nickname_set', person.nickname)

func custom_nickname_set(text):
	person.nickname = text
	open(person)

func open_customize_button():
	$DetailsPanel.show()

func show_gear_gui():
	var inventory = input_handler.ShowInentory({mode = 'character', person = person})


func open_diet_window():
	$DietPanel.show()
	globals.ClearContainer($DietPanel/ScrollContainer/VBoxContainer)
	$DietPanel/RichTextLabel.bbcode_text = tr("INFOFOODFILTER")
	var array = []
	for i in Items.materiallist.values():
		if i.type == 'food' && i.tags.size() > 0:
			array.append(i)
	array.sort_custom(self, 'sort_food')
	for i in array:
		var newbutton = globals.DuplicateContainerTemplate($DietPanel/ScrollContainer/VBoxContainer)
		newbutton.get_node("Label").text = i.name
		globals.connectmaterialtooltip(newbutton, i)
		for k in ['high','med','low','disable']:
			if person.food_filter[k].has(i.code):
				newbutton.get_node("filter").text = tr("FOODFILTER" + k.to_upper())
				newbutton.get_node("filter").set("custom_colors/font_color", Color(globals.hexcolordict[categorycolors[k]]))
				break
		newbutton.connect("pressed", self, "change_food_category", [i.code])

func change_food_category(foodcode):
	var current_category
	for i in ['high','med','low','disable']:
		if person.food_filter[i].has(foodcode):
			current_category = i
			break
	person.food_filter[current_category].erase(foodcode)
	var newcategory
	if category_order.size() > category_order.find(current_category)+1:
		newcategory = category_order[category_order.find(current_category)+1]
	else:
		newcategory = category_order[0]
	person.food_filter[newcategory].append(foodcode)
	input_handler.GetItemTooltip().hide()
	open_diet_window()

var category_order = ['high','med','low','disable']
var categorycolors = {high = "green", med = 'yellow', low = 'red', disable = 'gray'}

func sort_food(first, second):
	if first.name >= second.name:
		return false
	else:
		return true


func return_to_mansion_confirm():
	input_handler.ShowConfirmPanel(self, 'return_to_mansion', person.translate(tr("RETURNCHARACTERCONFIRM")))

func return_to_mansion():
	var active_area
	var active_location
	if person.location == 'travel':
		active_area = state.areas[state.location_links[person.travel_target.location].area]
		active_location = state.areas[state.location_links[person.travel_target.location].area][state.location_links[person.travel_target.location].category][person.travel_target.location]
	else:
		active_area = state.areas[state.location_links[person.location].area]
		active_location = state.areas[state.location_links[person.location].area][state.location_links[person.location].category][person.location]
	
	if variables.instant_travel == false:
		person.location = 'travel'
		person.travel_target = {area = '', location = 'mansion'}
		person.travel_time = max(1, round(active_area.travel_time + active_location.travel_time - person.travel_time))
	else:
		person.location = 'mansion'
	open(person)
	input_handler.update_slave_list()


func chooseimage(type):
	$ImageSelect.chooseimage(person, type)


