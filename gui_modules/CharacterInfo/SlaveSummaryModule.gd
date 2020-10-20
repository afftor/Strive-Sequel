extends Control

#onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)
onready var CharMainModule = get_parent()

var selected_person

func _ready():
	var base_stats_container = $VBoxContainer2/TextureRect2
	for i in $base_stats.get_children():
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	for i in $factors.get_children():
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	globals.connecttexttooltip(get_node("VBoxContainer2/TextureRect2/Exp"), statdata.statdata["base_exp"].descript)
	$VBoxContainer2/TextureRect4/NextClassExp.hint_tooltip = tr("NEXTCLASSEXP")# + str(person.get_next_class_exp())

	for i in base_stats_container.get_children():
		if i.name == "Exp":
			continue
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	$VBoxContainer/GearButton.connect("pressed", get_parent(), "set_state", ["gear"])
	$VBoxContainer/GearButton.set_meta("state", "gear")
	$VBoxContainer/ClassButton.connect("pressed", get_parent(), "set_state", ["class"])
	$VBoxContainer/ClassButton.set_meta("state", "class")
	$VBoxContainer2/TextureRect2/Exp.connect("pressed", get_parent(), "set_state", ["class"])
	$VBoxContainer/DetailsButton.connect("pressed", get_parent(), "set_state", ["details"])
	$VBoxContainer/DetailsButton.set_meta("state", "details")
	$ChangeSlaveButtons/Left.connect("pressed", self, "change_slave", ["prev"])
	$ChangeSlaveButtons/Right.connect("pressed", self, "change_slave", ["next"])


func change_slave(param):
	var chars = ResourceScripts.game_party.character_order
	var current_idx = 0
	while selected_person.id != chars[current_idx]:
		current_idx += 1
	
	match param:
		"prev":
			if current_idx == 0:
				selected_person = ResourceScripts.game_party.characters[chars[chars.size() - 1]]
			else:
				selected_person = ResourceScripts.game_party.characters[chars[current_idx - 1]]
		"next":
			if current_idx == chars.size() - 1:
				selected_person = ResourceScripts.game_party.characters[chars[0]]
			else:
				selected_person = ResourceScripts.game_party.characters[chars[current_idx + 1]]
	CharMainModule.active_person = selected_person
	CharMainModule.match_state()
	CharMainModule.ClassesModule.get_node("ClassPanel").hide()


func update_buttons():
	for button in $VBoxContainer.get_children():
		button.pressed = (button.get_meta("state") == get_parent().char_module_state)

func update():
	if gui_controller.windows_opened.size() == 0:
		get_parent().set_state("default")
	update_buttons()

func show_summary():
	# input_handler.PreviousScene = input_handler.get_spec_node(input_handler.NODE_SLAVEMODULE)
	input_handler.ClearContainer($professions)
	var person
	if selected_person == null:
		selected_person = gui_controller.mansion.active_person
	person = selected_person
	$Portrait.texture = person.get_icon()
	$sex.texture = images.icons[person.get_stat('sex')]
	$Name/name.text = person.get_full_name()
	$VBoxContainer2/TextureRect3/BaseExp.text = str(floor(person.get_stat("base_exp")))
	$VBoxContainer2/TextureRect4/NextClassExp.text = str(person.get_next_class_exp())
	
	for i in $base_stats.get_children():
		i.max_value = person.get_stat(i.name+'max')
		if i.name != 'lust': i.value = person.get_stat(i.name)
		else:i.value = person.get_stat(i.name)
		i.get_node("Label").text = str(floor(i.value)) + "/" + str(floor(i.max_value))

	for i in $factors.get_children():
		# if i.name in ['food_consumption', 'base_exp']:
		if i.name in ['base_exp']:
			# i.get_node("Label").text = str(floor(person.get_stat(i.name)))
			continue
		if input_handler.globalsettings.factors_as_words:
			i.get_node("Label").text = ResourceScripts.descriptions.factor_descripts[int(floor(person.get_stat(i.name)))]
			i.get_node("Label").set("custom_colors/font_color", variables.hexcolordict['factor'+str(int(floor(person.get_stat(i.name))))]) 
		else:
			i.get_node("Label").text = str(floor(person.get_stat(i.name)))
			i.get_node("Label").set("custom_colors/font_color", Color(1,1,1))

	for i in ['physics','wits','charm','sexuals']:
		var text = ''
		if person.get_stat(i+"_bonus") > 0:
			text += '+'
		if person.get_stat(i+"_bonus") != 0:
			text += str(floor(person.get_stat(i+"_bonus")))
		if i != 'sexuals':
			var color = set_color(person.get_stat(i+'_bonus'))

			# get_node("VBoxContainer2/TextureRect3/" + i).set("custom_colors/font_color", color)
			get_node("VBoxContainer2/TextureRect3/" + i).text = str(floor(person.statlist.statlist[i]))  + text
			get_node("VBoxContainer2/TextureRect4/" + i + '2').text = str(person.get_stat(i+'_factor') * 20)
		else:
			var color = set_color(person.get_stat(i+'_bonus'))
			# get_node("VBoxContainer2/TextureRect3/" + i).set("custom_colors/font_color", color)
			get_node("VBoxContainer2/TextureRect3/" + i).text = str(floor(person.get_stat(i)) - person.get_stat(i+"_bonus")) + text
			get_node("VBoxContainer2/TextureRect4/"+ i + '2').text = '100'
	
	# $factors/base_exp/Label.hint_tooltip = tr("NEXTCLASSEXP") + str(person.get_next_class_exp())
	# for i in person.xp_module.professions:
	# 	var newnode = input_handler.DuplicateContainerTemplate($professions)
	# 	var prof = classesdata.professions[i]
	# 	var name = ResourceScripts.descriptions.get_class_name(prof, person)
	# 	newnode.get_node("Label").text = name
	# 	newnode.get_node("TextureRect").rect_size = Vector2(86,86)
	# 	newnode.get_node("TextureRect").texture = prof.icon
	# 	newnode.connect('signal_RMB_release', GUIWorld, 'show_class_info', [prof.code, person])
	# 	var temptext = "[center]"+ResourceScripts.descriptions.get_class_name(prof,person) + "[/center]\n"+ResourceScripts.descriptions.get_class_bonuses(person, prof) + ResourceScripts.descriptions.get_class_traits(person, prof)
	# 	temptext += "\n\n{color=aqua|" + tr("CLASSRIGHTCLICKDETAILS") + "}"
	# 	globals.connecttexttooltip(newnode, temptext)



func set_color(value):
	var color = Color(0.98,0.88,0.51,1)
	if value > 0:
		color = Color(0.31,0.99,0.51,1)  
	elif value < 0:
		color = Color(0.99,0.31,0.36,1)
	return color
