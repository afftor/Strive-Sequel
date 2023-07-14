extends Panel


onready var Info = $ExploreSlaveInfoModule
onready var SummaryModule = $ExploreSlaveSummaryModule
onready var BodyModule = $SlaveBodyModule
onready var traitlist = $ScrollContainer/HBoxContainer
onready var traitlist2 = $ScrollContainer2/HBoxContainer
var submodules = []

var selected_char

func _ready():
	gui_controller.add_close_button(self)
	$PurchaseButton.connect("pressed", self, "hire_sell")
	var base_stats_container = SummaryModule.get_node("VBoxContainer2/TextureRect2")
	for i in SummaryModule.get_node("base_stats").get_children():
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	for i in SummaryModule.get_node("factors").get_children():
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	globals.connecttexttooltip(SummaryModule.get_node("VBoxContainer2/TextureRect2/Exp"), statdata.statdata["base_exp"].descript)
	SummaryModule.get_node("VBoxContainer2/TextureRect4/NextClassExp").hint_tooltip = tr("NEXTCLASSEXP")# + str(person.get_next_class_exp())
	input_handler.connect('PortraitUpdate', self, 'show_summary')

	for i in base_stats_container.get_children():
		if i.name == "Exp":
			continue
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)


func update_purchase_btn():
	$PurchaseButton/Label.text = gui_controller.exploration.hiremode.capitalize()
	if gui_controller.exploration.hiremode == "sell":
		$PurchaseButton.disabled = false
	else:
		$PurchaseButton.disabled = ((gui_controller.exploration.person_to_hire.calculate_price()) > ResourceScripts.game_res.money)


func hire_sell():
	if gui_controller.exploration.hiremode == "hire":
		hire_character()
	else:
		sell_slave()


func show_summary(person = selected_char, from_dialogue = false):
	selected_char = person
	if !from_dialogue:
		$PurchaseButton.visible = true
		$Price.visible = true
		$TextureRect.visible = true
		if gui_controller.exploration.hiremode == "sell":
			$Price.text = str(round(person.calculate_price() / 2))
			$ExploreSlaveInfoModule/Panel/obedlabel.visible = true
		else:
			$Price.text = str(round(person.calculate_price()))
			$ExploreSlaveInfoModule/Panel/obedlabel.visible = false
		update_purchase_btn()
	else:
		$PurchaseButton.visible = false
		$Price.visible = false
		$TextureRect.visible = false
#	get_parent().submodules.append(self)
	# input_handler.ClearContainer(BodyModule.get_node("professions"))
	globals.build_attrs_for_char($ExploreSlaveSummaryModule, person)
	SummaryModule.get_node("Name/name").text = person.get_short_name()
	SummaryModule.get_node("VBoxContainer2/TextureRect3/BaseExp").text = str(floor(person.get_stat("base_exp")))
	SummaryModule.get_node("VBoxContainer2/TextureRect4/NextClassExp").text = str(person.get_next_class_exp())

	for i in SummaryModule.get_node("base_stats").get_children():
		i.max_value = person.get_stat(i.name+'max')
		if i.name != 'lust': i.value = person.get_stat(i.name)
		else:i.value = person.get_stat(i.name)
		i.get_node("Label").text = str(floor(i.value)) + "/" + str(floor(i.max_value))
	
	for i in SummaryModule.get_node("factors").get_children():
		# if i.name in ['food_consumption', 'base_exp']:
		if i.name in ['base_exp', 'food_consumption']:
			# i.get_node("Label").text = str(floor(person.get_stat(i.name)))
			continue
		if input_handler.globalsettings.factors_as_words:
			i.get_node("Label").text = ResourceScripts.descriptions.factor_descripts[int(floor(person.get_stat(i.name)))]
			i.get_node("Label").set("custom_colors/font_color", variables.hexcolordict['factor'+str(int(floor(person.get_stat(i.name))))])
		else:
			i.get_node("Label").text = str(floor(person.get_stat(i.name)))
			i.get_node("Label").set("custom_colors/font_color", Color(1,1,1))
	
	for i in ['physics','wits','charm','sexuals']:
		if i != 'sexuals':
			var color = set_color(person.get_stat(i+'_bonus'))
			SummaryModule.get_node("VBoxContainer2/TextureRect3/" + i).set("custom_colors/font_color", color)
			SummaryModule.get_node("VBoxContainer2/TextureRect3/" + i).text = str(floor(person.get_stat(i)))
			SummaryModule.get_node("VBoxContainer2/TextureRect4/" + i + '2').text = str(person.get_stat(i+'_cap') + person.get_stat(i+"_bonus"))
		else:
			var color = set_color(person.get_stat(i+'_bonus'))
			SummaryModule.get_node("VBoxContainer2/TextureRect3/" + i).set("custom_colors/font_color", color)
			SummaryModule.get_node("VBoxContainer2/TextureRect3/" + i).text = str(floor(person.get_stat(i)))
			SummaryModule.get_node("VBoxContainer2/TextureRect4/"+ i + '2').text = '100'
	
	# $factors/base_exp/Label.hint_tooltip = tr("NEXTCLASSEXP") + str(person.get_next_class_exp())
	# for i in person.xp_module.professions:
	# 	var newnode = input_handler.DuplicateContainerTemplate(BodyModule.get_node("professions"))
	# 	var prof = classesdata.professions[i]
	# 	var name = ResourceScripts.descriptions.get_class_name(prof, person)
	# 	newnode.get_node("Label").text = name
	# 	newnode.get_node("TextureRect").rect_size = Vector2(86,86)
	# 	newnode.get_node("TextureRect").texture = prof.icon
	# 	var temptext = "[center]"+ResourceScripts.descriptions.get_class_name(prof,person) + "[/center]\n"+ResourceScripts.descriptions.get_class_bonuses(person, prof) + ResourceScripts.descriptions.get_class_traits(person, prof)
	# 	temptext += "\n\n{color=aqua|" + tr("CLASSRIGHTCLICKDETAILS") + "}"
	# 	globals.connecttexttooltip(newnode, temptext)
	Info.update(person, from_dialogue)
	BodyModule.update(person)
	update_traitlist(person)


func update_traitlist(person):
	globals.build_traitlist_for_char(person, traitlist)
	globals.build_loyalty_traitlist(person, traitlist2)



func set_color(value):
	var color = Color(0.98,0.88,0.51,1)
	if value > 0:
		color = Color(0.31,0.99,0.51,1)
	elif value < 0:
		color = Color(0.99,0.31,0.36,1)
	return color


func _on_Button_pressed():
	# var person = get_parent().person_to_hire
	for i in get_parent().submodules:
		print(i.name)


func hire_character():
	input_handler.active_location = ResourceScripts.world_gen.get_location_from_code(gui_controller.exploration.selected_location)
	var person = gui_controller.exploration.person_to_hire
	if ResourceScripts.game_party.characters.size() >= ResourceScripts.game_res.get_pop_cap():
		if ResourceScripts.game_res.get_pop_cap() < variables.max_population_cap:
			input_handler.SystemMessage("You don't have enough rooms")
		else:
			input_handler.SystemMessage("Population limit reached")
		return
	if ResourceScripts.game_res.money < person.calculate_price():
		input_handler.SystemMessage("Not enough money")
		return
	ResourceScripts.game_res.money -= person.calculate_price()
	input_handler.PlaySound("money_spend")
	person.set_stat('is_hirable', false)
	person.recruit() #ResourceScripts.game_party.add_slave(person)
	person.travel.location = gui_controller.exploration.selected_location
	person.remove_from_task()
	hide()

	if input_handler.scene_characters.has(person):
		input_handler.scene_characters.erase(person)
		input_handler.get_spec_node(input_handler.NODE_DIALOGUE).update_scene_characters()

	if input_handler.active_faction.has('slaves'):
		input_handler.active_faction.slaves.erase(person.id)
	if gui_controller.exploration.active_faction.slaves.has(person.id):
		gui_controller.exploration.active_faction.slaves.erase(person.id)


	# if input_handler.exploration_node.get_node("ExploreHireModule").is_visible_in_tree() == true:
	# 	input_handler.exploration_node.faction_hire()

	if person.get_stat('hire_scene') != '':
		input_handler.active_character = person
		input_handler.scene_characters.append(person)
		input_handler.interactive_message(person.get_stat('hire_scene'), '', {})
	gui_controller.exploration.faction_hire(true, gui_controller.exploration.current_pressed_area_btn, gui_controller.exploration.active_faction, gui_controller.exploration.market_mode)

func sell_slave():
	var selectedperson = gui_controller.exploration.person_to_hire
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'sell_slave_confirm', selectedperson.translate(tr("SELL") + " [name]?")])


func sell_slave_confirm():
	var selectedperson = gui_controller.exploration.person_to_hire
	ResourceScripts.game_res.money += int(round(selectedperson.calculate_price()/2))
	ResourceScripts.game_party.add_fate(selectedperson.id, tr("SOLD"))
	ResourceScripts.game_party.remove_slave(selectedperson)
	gui_controller.exploration.active_faction.slaves.append(selectedperson.id)
#	selectedperson.is_players_character = false
	input_handler.PlaySound("money_spend")
#	input_handler.slave_list_node.rebuild()
	gui_controller.exploration.sell_slave() #2test 
	self.hide()

