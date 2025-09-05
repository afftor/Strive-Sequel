extends Control

var person
var root

var tr_data = {}
var tr_traits = []
var tr_traits_s = []
var tr_rewards = []

func _ready():
	pass
#	gather_data()
#	$no_trainer/TextureButton.connect("pressed", self, 'build_trainer_list')
#	$training/trainer_frame.connect("pressed", self, 'build_trainer_list')
#	$finished/reset_button.connect("pressed", self, 'reset_training')
#	$training/complete_button.connect("pressed", self, 'build_finish')
#	$finish/cancel.connect("pressed", self, 'hide_finish_dialogue')
#	$finish/confirm.connect("pressed", self, 'confirm_finish_dialogue')
#	globals.connecttexttooltip($training/Tooltip, tr("INFOTRAINING"))
#	globals.connecttexttooltip($trainer_list/tooltip, tr("INFOSLAVETRAINER"))
#	$training/spirit.max_value = 100
#	globals.connecttexttooltip($training/TextureRect, tr("LOYALTYTOOLTIP")) 
#	globals.connecttexttooltip($training/TextureRect2, tr("SPIRITTOOLTIP")) 
#	globals.connecttexttooltip($training/spirit, tr("SPIRITTOOLTIP")) 
#	globals.connecttexttooltip($training/trainer_frame, tr("CLICKTOCHANGE"))
#	$finish/header.bbcode_text = tr("TRAINFINISHTEXT")
#
#	globals.connecttexttooltip($finished/reset_button, tr("RESETTRAINREQ"))


func set_person(t_person):
	person = t_person
	update()


func update():
	build_thralls()
	build_info()
	build_trainings()


func build_info(): 
	var container = $info/VBoxContainer
	var list = ['lustmax', 'lusttick', 'thralls_amount_max', 'thrall_points']
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
	var container = $upgrades/VBoxContainer
	input_handler.ClearContainer(container, ['Button'])
	for tr_id in Traitdata.succubus_trainings:
		var u_data = Traitdata.succubus_trainings[tr_id]
		var panel = input_handler.DuplicateContainerTemplate(container, 'Button')
		var unlocked = false
		match u_data.mode:
			'skill':
				unlocked = person.get_social_skills().has(u_data.skill)
				var s_data = Skilldata.Skilllist[u_data.skill]
				panel.get_node('name').text = tr(s_data.name)
				globals.connecttexttooltip(panel, tr(s_data.descript))
				if s_data.icon is String:
					panel.get_node('icon').texture = load(s_data.icon)
				else:
					panel.get_node('icon').texture = s_data.icon
			'trait':
				unlocked = person.check_trait(u_data.trait)
				var s_data = Traitdata.traits[u_data.trait]
				panel.get_node('name').text = tr(s_data.name)
				globals.connecttexttooltip(panel, tr(s_data.descript))
				if s_data.icon is String:
					panel.get_node('icon').texture = load(s_data.icon)
				else:
					panel.get_node('icon').texture = s_data.icon
		if unlocked:
			panel.disabled = true
			panel.get_node('cost').visible = false
			panel.texture_disabled = load("res://assets/Textures_v2/JOB_MODULE/button_job_chars_hover.png")
		else:
			if person.check_cost(u_data.cost):
				panel.connect('pressed', self, 'add_training', [tr_id])
			else:
				panel.disabled = true
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

