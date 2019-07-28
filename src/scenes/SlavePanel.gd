extends "res://files/Close Panel Button/ClosingPanel.gd"

#warning-ignore-all:return_value_discarded

var person

var type

func _input(event):
	if self.visible == false || $SkillPanel.visible == false || input_handler.text_field_input == true:
		return
	if str(event.as_text().replace("Kp ",'')) in str(range(0,9)) && event.is_pressed():
		var number = int(event.as_text().replace("Kp ",''))-1
		if $SkillPanel.get_child(number).disabled == false:
			$SkillPanel.get_child(number).emit_signal("pressed")


func _ready():
	#setting tooltips
	for i in $progress.get_children():
		i.connect("mouse_entered", self, "show_progress_tooltip", [i])
	for i in $factors.get_children():
		globals.connecttexttooltip(i, globals.statdata[i.name].descript)
		#i.hint_tooltip = tr("TOOLTIP" + i.name.replace("_", "").to_upper())
	for i in $mentality.get_children():
		globals.connecttexttooltip(i, globals.statdata[i.name].descript)
	
	for i in $base_stats.get_children():
		globals.connecttexttooltip(i, globals.statdata[i.name].descript)
		#i.hint_tooltip = tr("TOOLTIP" + i.name.to_upper())
	
	for i in ['restup', 'workup', 'joyup', 'restdown', 'workdown', 'joydown']:
		get_node("job_panel/job_details/WorkDetailsPanel/"+i).connect("pressed", self, "change_hours", [i])
	
	###############
	
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
	
	$RichTextLabel.connect("meta_clicked", self, 'show_race_descript')
	
	globals.AddPanelOpenCloseAnimation($DetailsPanel)
	$DetailsPanel/VBoxContainer/descript.connect("pressed", self, "custom_description_open")
	$DetailsPanel/VBoxContainer/icon.connect("pressed", self, "chooseimage",['portrait'])
	$DetailsPanel/VBoxContainer/body.connect("pressed", self, "chooseimage",['body'])
	$DetailsPanel/VBoxContainer/nickname.connect("pressed", self, "custom_nickname_open")
	
	input_handler.slave_panel_node = self


func open(tempperson):
	if tempperson == null:
		tempperson = person
	person = tempperson
	for i in get_tree().get_nodes_in_group("hide_master") + get_tree().get_nodes_in_group("hide_stranger") + get_tree().get_nodes_in_group("hide_traveler"):
		i.visible = true
	if state.characters.has(tempperson.id):
		type = 'slave'
		if tempperson.professions.has("master"):
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
	show()
	$name.text = person.get_short_name()
	if person.icon_image == null:
		$Portrait.texture = null
	else:
		$Portrait.texture = person.get_icon()
	$Body.texture = person.get_body_image()
	$BodyPanel.visible = $Body.texture != null
	$RichTextLabel.bbcode_text = person.make_description()
	if person.location == 'travel':
		$RichTextLabel.bbcode_text += "\n\n" + person.translate(make_location_description())
	$currentwork.text = person.work
	#$exp.text = str(person.base_exp)
	
	for i in $progress.get_children():
		i.text = str(floor(person.get(i.name) + person.get(i.name+'_bonus'))) + '/' + str(person.get(i.name +"_factor")*20)
	
	for i in $factors.get_children():
		i.get_node("Label").text = str(floor(person.get(i.name)))
	for i in $job.get_children():
		i.value = person.get(i.name)
		i.get_node("Label").text = str(floor(person.get(i.name))) + "/" + '100'
	for i in $base_stats.get_children():
		i.value = person.get(i.name)
		i.max_value = person.get(i.name+'max')
		i.get_node("Label").text = str(floor(person.get(i.name))) + "/" + str(floor(person.get(i.name+'max')))
	
	$mentality/loyal.value = person.loyal
	$mentality/loyal/Label.text = str(floor(person.loyal)) + '/' + '100'
	$mentality/obedience.value = person.obedience
	$mentality/obedience/Label.text = str(floor(person.obedience)) + '/' + '100'
	$mentality/fear.value = person.fear
	$mentality/fear/Label.text = str(floor(person.fear)) + '/' + '100'
	$mentality/lust.value = person.lust
	$mentality/lust.max_value = person.lustmax
	$mentality/lust/Label.text = str(floor(person.lust)) + '/' + str(person.lustmax)
	
	$food_love/Label.text = person.food_love
	
	$food_consume.text = "Food Consumption: " +  str(person.food_consumption)
	for i in person.food_hate:
		text += i + ", "
	text = text.substr(0, text.length()-2)
	$food_hate/Label.text =  text
	
	globals.ClearContainer($professions)
	for i in person.professions:
		var newnode = globals.DuplicateContainerTemplate($professions)
		var prof = Skilldata.professions[i]
		newnode.texture = prof.icon
		newnode.get_node("Label").text = prof.name
		globals.connecttexttooltip(newnode, "[center]" + prof.name + '[/center]\n' + person.translate(prof.descript))
	
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
	
	globals.ClearContainer($buffscontainer)
	print(person.temp_effects)
	for i in person.get_all_buffs():
		var newnode = globals.DuplicateContainerTemplate($buffscontainer)
		newnode.texture = load(i.icon)
		#newnode.get_node("Label").text = str(i.duration)
		globals.connecttexttooltip(newnode, i.description)
	

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

func show_progress_tooltip(node):
	pass

func show_race_descript(meta):
	globals.connecttexttooltip($RichTextLabel, person.show_race_description())

func open_class_selection():
	$class_learn.open(person)

func open_jobs_window():
	$job_panel.show()
	$job_panel/job_details.hide()
	globals.ClearContainer($job_panel/ScrollContainer/VBoxContainer)
	currentjob = null
	update_hours()
	for i in races.tasklist.values():
		if state.checkreqs(i.reqs) == false:
			continue
		var newbutton = globals.DuplicateContainerTemplate($job_panel/ScrollContainer/VBoxContainer)
		newbutton.text = i.name
		#newbutton.connect('pressed', self, 'select_job', [i.code])
		newbutton.connect('pressed', self, 'show_job_details', [i])

var currentjob

func show_job_details(job):
	currentjob = job
	$job_panel/job_details.show()
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
	globals.ClearContainer($job_panel/job_details/ResourceOptions)
	
	$job_panel/job_details/WorkDetailsPanel.visible = !person.work_simple
	$job_panel/job_details/SimpleBehaviorCheck.pressed = person.work_simple
	
	for i in job.production.values():
		if state.checkreqs(i.reqs) == false:
			continue
		var newbutton = globals.DuplicateContainerTemplate($job_panel/job_details/ResourceOptions)
		if Items.materiallist.has(i.item):
			var number
			if person.work_simple == true:
				number = stepify(races.get_progress_task(person, job.code, i.code)/i.progress_per_item,0.1)
				text = "\n[color=yellow]Expected gain per hour: " + str(number) + "[/color]"
			else:
				number = stepify(person.workhours*races.get_progress_task(person, job.code, i.code)/i.progress_per_item,0.1)#races.call(i.progress_function, person)/i.progress_per_item,0.1)
				text = "\n[color=yellow]Expected gain per work day: " + str(number) + "[/color]"
			newbutton.get_node("icon").texture = Items.materiallist[i.item].icon
			newbutton.get_node("number").text = str(number)
			globals.connectmaterialtooltip(newbutton, Items.materiallist[i.item], text)
		else:
			var number
			if person.work_simple == true:
				number = stepify(races.get_progress_task(person, job.code, i.code)/i.progress_per_item,0.1)
				text = "\n[color=yellow]Expected gain per hour: " + str(number) + "[/color]"
			else:
				number = stepify(person.workhours*races.get_progress_task(person, job.code, i.code)/i.progress_per_item,0.1)#races.call(i.progress_function, person)/i.progress_per_item,0.1)
				text = "\n[color=yellow]Expected gain per work day: " + str(number) + "[/color]"
			#number = stepify(person.workhours*races.get_progress_task(person, job.code, i.code)/i.progress_per_item,0.1) # stepify(person.workhours*races.call(i.progress_function, person)/i.progress_per_item,0.1)
			newbutton.get_node("number").text = str(number)
			newbutton.get_node("icon").texture = i.icon
			globals.connecttexttooltip(newbutton, i.descript + text)
			
		newbutton.connect('pressed', self, 'select_job', [job, i.code])

func select_job(job, production):
	person.assign_to_task(job.code, production)
	for i in person.current_day_spent.values():
		i = 0
	$job_panel.hide()
	open(person)

func check_simple_behavior():
	person.work_simple = $job_panel/job_details/SimpleBehaviorCheck.pressed
	show_job_details(currentjob)

func change_hours(stat):
	var freepoints = 24 - (person.workhours + person.resthours + person.joyhours)
	if stat.find('up') >= 0:
		if freepoints <= 0:
			return
		else:
			var statcode = stat.substr(0,stat.length()-2) + "hours"
			person.set(statcode, person.get(statcode) + 1)
	else:
		var statcode = stat.substr(0,stat.length()-4) + "hours"
		if person.get(statcode) == 0:
			return
		person.set(statcode, person.get(statcode) - 1)
	
	
	update_hours()

func update_hours():
	$job_panel/job_details/WorkDetailsPanel/worklabel.text = str(person.workhours)
	$job_panel/job_details/WorkDetailsPanel/restlabel.text = str(person.resthours)
	$job_panel/job_details/WorkDetailsPanel/joylabel.text = str(person.joyhours)
	$job_panel/job_details/WorkDetailsPanel/totallabel.text = "Free hours left: " + str(24 - (person.workhours + person.resthours + person.joyhours))
	if currentjob != null:
		show_job_details(currentjob)

func build_skill_panel():
	globals.ClearContainer($SkillPanel)
	for i in range(1,11):
		var text = ''
		var newbutton = globals.DuplicateContainerTemplate($SkillPanel)
		if person.social_skill_panel.has(i):
			var skill = Skilldata.Skilllist[person.social_skill_panel[i]]
			newbutton.get_node("icon").texture = skill.icon
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
			newbutton.get_node("charges").text = text
			newbutton.get_node("charges").show()
			if person.social_skills_charges.has(skill.code) && skill.charges - person.social_skills_charges[skill.code] <= 0:
				newbutton.disabled = true
			
			newbutton.connect("pressed",self,"select_skill_target", [skill.code])
			globals.connectskilltooltip(newbutton, skill.code, person)
		else:
			newbutton.connect('pressed',self,'select_skill_for_position', [i])
		
		newbutton.set_script(load("res://src/RightClickReactButton.gd"))
		newbutton.connect('signal_RMB',self,'select_skill_for_position', [i])

var active_position
var active_skill

func select_skill_for_position(position):
	active_position = position
	input_handler.ShowSkillSelectPanel(person, 'social', self, 'skill_selected')

func skill_selected(skill):
	if skill == null:
		person.social_skill_panel.erase(active_position)
	else:
		person.social_skill_panel[active_position] = skill
	build_skill_panel()

func select_skill_target(skillcode):
	active_skill = skillcode
	input_handler.ShowSlaveSelectPanel(self, 'use_skill', [{code = 'is_free'}, {code = 'is_id', operant = 'neq', value = person.id}])

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
		if i.type == 'food':
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
		active_location = state.areas[state.location_links[person.location].area][state.location_links[person.location].category][person.travel_target.location]
	
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


