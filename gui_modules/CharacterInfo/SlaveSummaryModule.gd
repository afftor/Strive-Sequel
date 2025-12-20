extends Control


onready var CharMainModule = get_parent()
onready var name_button = $Name/name

var selected_person
var actions = ['leveling','relations','customization','expel','inventory','occupation','date','chat']

var chat_button
var date_button
var expel_button
var leveling_button
var relations_button
var customization_button
var inventory_button
var occupation_button


func _ready():
	
	for i in actions:
		var newbutton = input_handler.DuplicateContainerTemplate($Actions/GridContainer)
		newbutton.get_node("Label").text = tr('BTN' + i.to_upper())
		if i in ['inventory','occupation','date','chat']:
			newbutton.texture_normal = load("res://assets/Textures_v2/CITY/Buttons/buttonviolet.png")
			newbutton.texture_pressed = load("res://assets/Textures_v2/CITY/Buttons/buttonviolet_pressed.png")
			newbutton.texture_hover = load("res://assets/Textures_v2/CITY/Buttons/buttonviolet_hover.png")
		newbutton.connect('pressed',self,i)
		self[i+'_button'] = newbutton
	#$Actions/GridContainer/Buttonleveling.connect("pressed", self, 'open_skills')
	var base_stats_container = $VBoxContainer2/TextureRect2
	for i in $base_stats.get_children():
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
#	for i in $factors.get_children():
#		globals.connecttexttooltip(i, ResourceScripts.game_party.get_master().translate(statdata.statdata[i.name].descript))
	globals.connecttexttooltip(get_node("VBoxContainer2/TextureRect2/Exp"), statdata.statdata["base_exp"].descript)
	$VBoxContainer2/TextureRect4/NextClassExp.hint_tooltip = tr("NEXTCLASSEXP")# + str(person.get_next_class_exp())
#	globals.connecttexttooltip($GridContainer/SkillsButton, tr("BUTTONCLASS"))#"Class and Skills")
#	globals.connecttexttooltip($GridContainer/SiblingsButton, tr("BUTTONTRAINING"))#"Training and Rules")
#	globals.connecttexttooltip($GridContainer/GearButton, tr("BUTTONGEAR"))#"Gear")
#	globals.connecttexttooltip($GridContainer/DetailsButton, tr("BUTTONCUSTOMIZATION"))#"Customization")
	
	
	for i in base_stats_container.get_children():
		if i.name == "Exp":
			continue
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	$ChangeSlaveButtons/Left.connect("pressed", self, "change_slave", ["prev"])
	$ChangeSlaveButtons/Right.connect("pressed", self, "change_slave", ["next"])
	name_button.connect("pressed", self, "open_character_select_menu")
#	$GridContainer/DetailsButton.connect("pressed", self, "open_details")
#	$GridContainer/SkillsButton.connect("pressed", self, "open_skills")
#	$GridContainer/SiblingsButton.connect("pressed", self, "open_siblings")
#	$GridContainer/GearButton.connect("pressed", self, "open_gear")
	$VBoxContainer2/TextureRect2/Exp.connect("pressed", self, "open_skills")

func leveling():
	open_skills()

func chat():
	input_handler.active_character = selected_person
	var unique = selected_person.get_stat('unique')
	if unique_dict.has(unique):
		gui_controller.close_scene(get_parent())
		var scene 
		for i in unique_dict[unique].scenes:
			if globals.checkreqs(i.reqs):
				scene = i.code
				break
				
		if scene != null:
			input_handler.interactive_message(scene)


func date():
	var person = selected_person
	person.add_stat('metrics_dates', 1)
	if !ResourceScripts.game_globals.unlimited_date_sex:
		ResourceScripts.game_globals.weekly_dates_left -= 1
	person.tags.push_back("no_date_day")
	ResourceScripts.core_animations.BlackScreenTransition()
	yield(get_tree().create_timer(0.5), "timeout")
	update_buttons()
	gui_controller.date_panel = input_handler.get_spec_node(input_handler.NODE_DATE)
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.date_panel
	gui_controller.date_panel.raise()
	gui_controller.date_panel.initiate(person)
	gui_controller.date_panel.show()

func expel():
	input_handler.active_character = selected_person
	gui_controller.close_scene(get_parent())
	input_handler.interactive_message('slave_remove')

func customization():
	get_parent().set_state("details")

func open_skills():
	get_parent().set_state("skills")

func relations():
	get_parent().set_state("siblings")

func occupation():
	input_handler.ActivateTutorial('TUTORIALLIST4')
	if selected_person != null:
		gui_controller.mansion.get_node("MansionJobModule2").selected_location = selected_person.get_location()
	gui_controller.close_scene(get_parent())
	gui_controller.mansion.mansion_state_set("occupation")

func inventory():
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
	update_buttons()
	if selected_person.get_work() == 'learning':
		change_slave(param)

func open_character_select_menu():
	input_handler.ShowSlaveSelectPanel(self, "select_slave_from_menu")

func select_slave_from_menu(person):
	if person == null:
		return
	selected_person = person
	input_handler.interacted_character = selected_person
	CharMainModule.match_state()
	CharMainModule.ClassesModule.get_node("ClassPanel").hide()
	CharMainModule.DetailsModule.custom_description_open()
	update_buttons()

func check_date_button():
	var value = true
	var descript = ''
	if selected_person.is_master():
		value = false
		descript = 'NODATEMASTER'
	elif selected_person.has_status("no_date"):
		value = false
		descript = "NODATEUNIQUE"
	elif !selected_person.has_status("relation"):
		value = false
		descript = "NODATERELATION"
	elif selected_person.tags.has("no_date_day") && !ResourceScripts.game_globals.unlimited_date_sex:
		value = false
		descript = "NODATETODAY"
	elif ResourceScripts.game_globals.weekly_dates_left <= 0:
		value = false
		descript = "NODATEWEEK"
	
	
	return [value, descript]



func update_buttons():
	for i in $Actions/GridContainer.get_children():
		if i.name != 'Button':
			i.visible = !selected_person.is_on_quest()
	$Actions/RichTextLabel.bbcode_text = selected_person.translate(tr("ONQUESTLABEL"))
	$Actions/RichTextLabel.visible = selected_person.is_on_quest()
	
	
	
	chat_button.disabled = !unique_dict.has(selected_person.get_stat('unique'))
	
	var date_button_data = check_date_button()
	date_button.disabled = !date_button_data[0]
	globals.connecttexttooltip(date_button, selected_person.translate(tr(date_button_data[1])))
	if date_button.disabled == false:
		globals.disconnect_text_tooltip(date_button)
	
	
	date_button.get_node("Label").text = tr("BTNDATE") + " (%d/%d)" % [ResourceScripts.game_globals.weekly_dates_left, ResourceScripts.game_globals.weekly_dates_max]
	expel_button.disabled = selected_person.is_master()

func update():
	update_buttons()
	if selected_person == null:
		return
#	if get_parent().unique_dict.has(get_parent().active_person.get_stat('unique')):
#		get_parent().get_node("TalkButton").visible = selected_person.get_work() != "disabled"
	#$GridContainer.visible = selected_person.get_work() != "disabled"
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
	globals.build_attrs_for_char(self, person)
	$Name/name.text = person.get_full_name()
	$VBoxContainer2/TextureRect3/BaseExp.text = str(floor(person.get_stat("base_exp")))
	$VBoxContainer2/TextureRect4/NextClassExp.text = str(person.get_next_class_exp())
	
	for i in $base_stats.get_children():
		i.max_value = person.get_stat(i.name+'max')
		if i.name == 'lust':
			i.visible = person.check_trait('succubus')
		i.value = person.get_stat(i.name)
		i.get_node("Label").text = str(floor(i.value)) + "/" + str(floor(i.max_value))

	for i in $factors.get_children():
		if person.is_master() && i.name in ["tame_factor", "authority_factor"]:
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
			i.get_node("Label").set("custom_colors/font_color", variables.hexcolordict['factor'+str(int(floor(person.get_stat(i.name))))])
		globals.connecttexttooltip(i, person.translate(statdata.statdata[i.name].descript))

	for i in ['physics','wits','charm','sexuals']:
		var text = ''
		if person.get_stat(i+"_bonus") > 0:
			text += '+'
		if person.get_stat(i+"_bonus") != 0:
			text += str(floor(person.get_stat(i+"_bonus")))
		if i != 'sexuals':
			var color = set_color(person.get_stat(i+'_bonus'))

			# get_node("VBoxContainer2/TextureRect3/" + i).set("custom_colors/font_color", color)
			get_node("VBoxContainer2/TextureRect3/" + i).text = str(floor(person.statlist.get_stat(i)))  + text #extremely bad
			get_node("VBoxContainer2/TextureRect4/" + i + '2').text = str(person.get_stat(i+'_cap') + person.get_stat(i+"_bonus"))
		else:
			var color = set_color(person.get_stat(i+'_bonus'))
			# get_node("VBoxContainer2/TextureRect3/" + i).set("custom_colors/font_color", color)
			get_node("VBoxContainer2/TextureRect3/" + i).text = str(floor(person.statlist.get_stat(i))) + text
			get_node("VBoxContainer2/TextureRect4/"+ i + '2').text = '100'



func set_color(value):
	var color = Color(0.98,0.88,0.51,1)
	if value > 0:
		color = Color(0.31,0.99,0.51,1)  
	elif value < 0:
		color = Color(0.99,0.31,0.36,1)
	return color


var unique_dict = { #shows available talk characters. Scenes go in order from higher priority and reqs to lower. No scenes isn't supported yet
	kurdan = {
		code = 'kurdan', 
		scenes = [
			{code = 'kurdan_dialogue_start', reqs = []}
		]
	},
	
	zephyra = {
		code = 'zephyra', 
		scenes = [
			{
				code = 'zephyra_quest_1', 
				reqs = [
					{type = 'decision', value = 'mayor_election_finished', check = true},
					{type = 'dialogue_seen', check = false, value = 'ZEPHYRA_QUEST_2'}
					]
			},
			{code = 'zephyra_dialogue_start', reqs = []}
		]
	},
	
	anastasia = {
		code = 'anastasia', 
		scenes = [
			{
				code = 'ana_travel_initiate', 
				reqs = [
					{type = "active_quest_stage", value = "anastasia_quest_2", stage = "stage9"}
					]
			},
			{
				code = 'anastasia_return_1', 
				reqs = [
					{type = "active_quest_stage", value = "anastasia_quest", stage = "stage6"},
					{type = 'decision', value = 'ana_liora_lie', check = true},
					]
			},
			{
				code = 'anastasia_return_3', 
				reqs = [
					{type = "active_quest_stage", value = "anastasia_quest", stage = "stage6"},
					{type = 'decision', value = 'ana_liora_lie', check = false},
					]
			},
			{code = 'anastasia_dialogue_start', reqs = []}
		]
	},
	
	daisy = {
		code = 'daisy', 
		scenes = [
			{code = 'daisy_dialogue_start', reqs = []}
		]
	},
	
	
	aire = {
		code = 'aire', 
		scenes = [
			{code = 'gryphon_aire_start', reqs = [
					{type = 'decision', value = 'mindbreak_completed', check = false},
					{code = 'value_check', type = 'dialogue_seen', check = false, value = 'GRYPHON_AIRE_START'},
					{type = 'unique_character_checks', name = 'anastasia', value = [{code = 'is_dead', check = false}]}
				]
			},
			{code = 'aire_dialogue_start', reqs = []}
		]
	},
	cali = {
		code = 'cali', 
		scenes = [
			{code = 'cali_dialogue_start', reqs = []}
		]
	},
	
	lilia = {
		code = 'lilia', 
		scenes = [
			{code = 'lilia_dialogue_start', reqs = []}
		]
	},
	
	lilith = {
		code = 'lilith', 
		scenes = [
			{code = 'lilith_dialogue_start', reqs = []}
		]
	},
	
	
	jean = {
		code = 'jean', 
		scenes = [
			{code = 'jean_dialogue_start', reqs = []}
		]
	},
	
	amelia = {
		code = 'amelia',
		scenes = [
			{code = 'amelia_final_1', reqs = [{type = 'dialogue_seen', check = false, value = 'AMELIA_FINAL_1'},{type = "active_quest_stage", value = "amelia_main_quest", stage = "stage11"}]}, 
			{code = 'amelia_sex_1', reqs = [{type = 'dialogue_seen', check = false, value = 'AMELIA_SEX_1'},{type = 'quest_completed', name = 'amelia_main_quest', check = true}]}, 
			{code = 'amelia_dialogue_start', reqs = []}, #needs adding  
		]
	},
	
	kuro = {
		code = 'kuro',
		scenes = [
			{code = 'kuro3_init_3', reqs = [
				{type = "active_quest_stage", value = "kuro_quest_3", stage = "craft"},
				{type = 'has_material', operant = 'eq', value = 1, material = 'vesperine_cage'}
			]},
			{code = 'kuro_tome_sex', reqs = [{type = "active_quest_stage", value = "kuro_tome_quest", stage = "talk"}]},
			{code = 'kuro_after_tome', reqs = [
				{type = "quest_completed", check = true, name = "kuro_tome_quest"},
				{type = "event_seen", check = false, value = "kuro_after_tome"}
			]},
			{code = 'kuro_dialogue_start', reqs = []}
		]
	},
}
