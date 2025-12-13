extends Control

var person
var root

var tr_data = {}
var tr_traits = []
var tr_traits_s = []
var tr_rewards = []

var offset_x = 120
var offset_y = 190



func set_person(t_person):
	person = t_person
	update()


func update():
	build_thralls()
	build_info()
	build_trainings()
	build_spells()
	build_thralls_tooltip()
#	basic_tooltip()


func build_info(): 
	var container = $info/VBoxContainer
	var list = ['lusttick', 'thralls_amount_max','thrall_points']
	input_handler.ClearContainer(container, ['record'])
	for id in list:
		var stdata = statdata.statdata[id]
		var panel = input_handler.DuplicateContainerTemplate(container, 'record')
		var value = person.get_stat(id)
		panel.get_node('stat').text = tr(stdata.name) + ":"
		panel.get_node('value').text = str(value)
	#add more info


func build_thralls(): 
	var container = $thralls/HBoxContainer
	var list = person.get_stat('thralls')
	input_handler.ClearContainer(container, ['Button'])
	for id in list:
		var tchar = characters_pool.get_char_by_id(id)
		var panel = input_handler.DuplicateContainerTemplate(container, 'Button')
		panel.get_node('icon').texture = tchar.get_icon()
		globals.connectslavetooltip(panel.get_node('icon'), tchar)
		if tchar.is_on_quest():
			panel.disabled = true
		else:
			panel.connect('pressed', self, 'change_slave', [tchar])


func change_slave(newchar):
	input_handler.get_spec_node(input_handler.NODE_SLAVETOOLTIP).hide()
	input_handler.interacted_character = newchar 
	root.match_state()
	root.ClassesModule.get_node("ClassPanel").hide()
	root.DetailsModule.custom_description_open()


func build_trainings():
	var container = $upgrades
	input_handler.ClearContainer(container, ['Button'])
	for tr_id in Traitdata.succubus_trainings:
		var u_data = Traitdata.succubus_trainings[tr_id]
		var panel = input_handler.DuplicateContainerTemplate(container, 'Button')
		panel.rect_position = Vector2(u_data.position[1] * offset_x, u_data.position[0] * offset_y)
		var unlocked = false
		match u_data.mode:
			'skill':
				unlocked = person.get_social_skills().has(u_data.skill)
				var s_data = Skilldata.Skilllist[u_data.skill]
				panel.get_node('name').text = tr(s_data.name)
				globals.connecttexttooltip(panel, "[center]" + tr(s_data.name) + "[/center]\n" + tr(s_data.descript))
				if s_data.icon is String:
					panel.get_node('icon').texture = load(s_data.icon)
				else:
					panel.get_node('icon').texture = s_data.icon
			'trait':
				unlocked = person.check_trait(u_data.trait)
				var s_data = Traitdata.traits[u_data.trait]
				panel.get_node('name').text = tr(s_data.name)
				globals.connecttexttooltip(panel, "[center]" + tr(s_data.name) + "[/center]\n" + tr(s_data.descript))
				if s_data.icon is String:
					panel.get_node('icon').texture = load(s_data.icon)
				else:
					panel.get_node('icon').texture = s_data.icon
		if u_data.has('icon') and u_data.icon != null:
			if u_data.icon is String:
				panel.get_node('icon').texture = load(u_data.icon)
			else:
				panel.get_node('icon').texture = u_data.icon
		if unlocked:
			panel.disabled = true
			panel.get_node('cost').visible = false
			panel.get_node('bg').modulate = Color(variables.hexcolordict.yellow)
		else:
			if person.check_cost(u_data.cost) and person.checkreqs(u_data.reqs):
				panel.connect('pressed', self, 'add_training', [tr_id])
				panel.get_node('bg').modulate = Color(variables.hexcolordict.green)
			else:
				panel.disabled = true
				panel.get_node('bg').modulate = Color(variables.hexcolordict.red)
		panel.get_node('cost').text = "%d pt" % u_data.cost.thrall_points
		


var cashed_training = null
func add_training(tr_id):
	cashed_training = tr_id
	var u_data = Traitdata.succubus_trainings[tr_id]
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'add_training_confirm', tr("UPGRADELIST_UNLOCK") % [u_data.cost.thrall_points, tr('STATTHRALL_POINTS')]])


func add_training_confirm():
	var u_data = Traitdata.succubus_trainings[cashed_training]
	person.pay_cost(u_data.cost)
	match u_data.mode:
		'skill':
			person.learn_skill(u_data.skill)
		'trait':
			person.add_trait(u_data.trait)
	update()


func build_spells():
	var container = $spells
	var list = person.get_social_skills()
	input_handler.ClearContainer(container, ['Button'])
	for id in list:
		var s_data = Skilldata.get_template(id, person)
		if !s_data.tags.has('succubus'):
			continue
		var panel = input_handler.DuplicateContainerTemplate(container, 'Button') 
		panel.connect('pressed', self, 'select_spell', [id])
		panel.set_meta('display_only', true)
		if s_data.icon is String:
			panel.get_node('icon').texture = load(s_data.icon)
		else:
			panel.get_node('icon').texture = s_data.icon
		globals.connectskilltooltip(panel, id, person)
		if s_data.cost.has('mp'):
			panel.get_node('value').text = str(s_data.cost.mp)
		else:
			panel.get_node('value').text = '0'
		if s_data.cost.has('lust'):
			panel.get_node('value2').text = str(s_data.cost.lust)
		else:
			panel.get_node('value2').text = '0'
		var charges = Skilldata.get_charges(s_data, person)
		var used_charges = 0
		if person.skills.social_skills_charges.has(id):
			used_charges = person.skills.social_skills_charges[id]
#		panel.get_node('charges').text = str(charges - used_charges) + "/" + str(charges)
		if !person.check_cost(s_data.cost):
			panel.disabled = true
		if (person.checkreqs(s_data.reqs) == false):# or (person.has_status('no_social_skills') and person.skills.active_panel == variables.PANEL_SOC) or person.get_work() == 'disabled':
			panel.disabled = true
		if charges - used_charges <= 0:
			panel.disabled = true
			if person.skills.social_cooldowns.has(id):
				panel.get_node('cdicon').visible = true
				panel.get_node('value3').text = str(person.skills.social_cooldowns[id])
				panel.get_node('value3').visible = true
				panel.get_node('value2').visible = false
				panel.get_node('value').visible = false
			if person.skills.daily_cooldowns.has(id):
				panel.get_node('cdicon').visible = true
				panel.get_node('value3').text = str(person.skills.daily_cooldowns[id])
				panel.get_node('value3').visible = true
				panel.get_node('value2').visible = false
				panel.get_node('value').visible = false


func select_spell(sp_id):
	var s_data = Skilldata.get_template(sp_id, person)
	if s_data.tags.has('no_target'):
		person.use_social_skill(sp_id, person)
		input_handler.emit_signal("SpellUsed")
	else:
		gui_controller.spells = input_handler.get_spec_node(input_handler.NODE_SPELLS)
		ResourceScripts.core_animations.UnfadeAnimation(gui_controller.spells, 0.3)
		gui_controller.spells.show()
		gui_controller.previous_screen = gui_controller.current_screen
		gui_controller.current_screen = gui_controller.spells
		gui_controller.spells.open(person, sp_id, true)
		gui_controller.emit_signal("screen_changed")


func open_spells():
	gui_controller.spells = input_handler.get_spec_node(input_handler.NODE_SPELLS)
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.spells, 0.3)
	gui_controller.spells.show()
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.spells
	gui_controller.spells.open(person)
	gui_controller.emit_signal("screen_changed")


func build_thralls_tooltip():
	var text = person.translate("[name] gains more powers based on the number of thralls [he] controls.\n\n")
	for i in range(7):
		var text2 = globals.build_oneline_desc_for_bonusstats(Effectdata.effect_table['succubus_thralls_%d' % i].statchanges) 
		if i == person.get_stat('thralls_amount'):
			text += '{color=green|' + str(i) + ": " + text2 + '}\n'
		else:
			text +=  str(i) + ': '+text2 + '\n'
	globals.connecttexttooltip($thralls/ThrallsTooltip, text.trim_suffix('\n'))
#
#func basic_tooltip():
#	globals.connecttexttooltip($SuccubusTrainingTooltip, person.translate(tr(("TOOLTIPSUCCUBUS"))))
