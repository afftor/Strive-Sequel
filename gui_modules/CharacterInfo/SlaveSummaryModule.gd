extends Control


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
	$ChangeSlaveButtons/Left.connect("pressed", self, "change_slave", ["prev"])
	$ChangeSlaveButtons/Right.connect("pressed", self, "change_slave", ["next"])
	$GridContainer/DetailsButton.connect("pressed", self, "open_details")
	$GridContainer/SkillsButton.connect("pressed", self, "open_skills")
	$GridContainer/SiblingsButton.connect("pressed", self, "open_siblings")
	$GridContainer/GearButton.connect("pressed", self, "open_gear")
	$VBoxContainer2/TextureRect2/Exp.connect("pressed", self, "open_skills")

func open_details():
	get_parent().set_state("details")
func open_skills():
	get_parent().set_state("skills")
func open_siblings():
	get_parent().set_state("siblings")
func open_gear():
	get_parent().set_state("gear")

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
	input_handler.interacted_character = selected_person
	# CharMainModule.active_person = selected_person
	CharMainModule.match_state()
	CharMainModule.ClassesModule.get_node("ClassPanel").hide()
	# CharMainModule.DetailsModule.person = selected_person
	CharMainModule.DetailsModule.custom_description_open()
	$GridContainer.visible = selected_person.get_work() != "disabled"
	if selected_person.get_work() == "disabled":
		get_parent().set_state("default")
		get_parent().get_node("TalkButton").visible = false

func update():
	if get_parent().unique_dict.has(get_parent().active_person.get_stat('unique')):
		get_parent().get_node("TalkButton").visible = selected_person.get_work() != "disabled"
	$GridContainer.visible = selected_person.get_work() != "disabled"
	if get_parent().char_module_state == "default" && gui_controller.windows_opened.size() == 0:
		return
	if gui_controller.windows_opened.size() == 0:
		get_parent().set_state("default")

func show_summary():
	# input_handler.PreviousScene = input_handler.get_spec_node(input_handler.NODE_SLAVEMODULE)
	input_handler.ClearContainer($professions)
	var person
	selected_person = input_handler.interacted_character
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
		if person == ResourceScripts.game_party.get_master() && i.name in ["tame_factor", "timid_factor"]:
			i.hide()
		else:
			i.show()
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



func set_color(value):
	var color = Color(0.98,0.88,0.51,1)
	if value > 0:
		color = Color(0.31,0.99,0.51,1)  
	elif value < 0:
		color = Color(0.99,0.31,0.36,1)
	return color
