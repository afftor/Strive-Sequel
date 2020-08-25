extends Panel


var mode = "slave_market"
var is_slave_market_opened = false
# var mode = "guild_slaves"
onready var FullSlaveInfo = get_parent().get_node("ExploreFullSlaveModule")
onready var Shop = get_parent().get_node("ExploreShopModule")
onready var Quests = get_parent().get_node("QuestBoardModule")


func _ready():
	$PurchaseButton.connect("pressed", self, "show_full_info")
	$HireMode.connect("pressed", self, "change_mode", ["hire"])
	$SellMode.connect("pressed", self, "change_mode", ["sell"])
	$HBoxContainer/EnslaveButton.connect("pressed", self, "enslave_select")
	$HBoxContainer/UpgradeButton.connect("pressed", self, "show_upgrade_window")
	for i in $factors.get_children():
		if i.name == "Exp":
			continue
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	for i in $base_stats.get_children():
		if i.name == "Exp":
			continue
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)


func show_upgrade_window():
	get_parent().StatUpgradeWindow.show()
	get_parent().StatUpgradeWindow.show_characters_panel()
	get_parent().submodules.clear()
	get_parent().submodules.append(get_parent().StatUpgradeWindow)
	self.hide()
	get_parent().City.update_buttons()


func change_mode(mode):
	get_parent().hiremode = mode
	if mode == "hire":
		hire()
	else:
		sell_slave()

func show_full_info():
	FullSlaveInfo.show()
	FullSlaveInfo.show_summary(get_parent().person_to_hire)
	FullSlaveInfo.update_purchase_btn()
	get_parent().Navigation.hide()

func open_slave_market(guild):
	get_parent().clear_submodules()
	get_parent().submodules.append(self)
	Shop.is_shop_opened = false
	Quests.is_quest_board_opened = false
	is_slave_market_opened = !is_slave_market_opened
	if !is_slave_market_opened:
		hide()
		return
	get_parent().City.Guild.hide()
	get_parent().City.get_node("GuildMenuBG").hide()
	get_parent().City.opened_guild = {code = ""}
	get_parent().City.update_buttons("slavemarket")
	mode = "slave_market"
	get_parent().active_faction = guild
	input_handler.active_faction = guild
	hire()

func hire():
	$HireMode.visible = mode != "guild_slaves"
	$SellMode.visible = mode != "guild_slaves"
	$HBoxContainer/UpgradeButton.visible = mode != "guild_slaves"
	get_parent().hiremode = 'hire'
	$RichTextLabel.bbcode_text = ""
	input_handler.ClearContainer($SlaveList/ScrollContainer/VBoxContainer)
	for i in get_parent().active_faction.slaves:
		var tchar = characters_pool.get_char_by_id(i)
		var newbutton = input_handler.DuplicateContainerTemplate(
			$SlaveList/ScrollContainer/VBoxContainer
		)
		newbutton.get_node("name").text = tchar.get_stat('name')
		newbutton.get_node("Price").text = str(tchar.calculate_price())
		#newbutton.connect('signal_RMB_release',input_handler,'ShowSlavePanel', [tchar])
		newbutton.connect("pressed", self, 'show_slave_info', [tchar])  #, self, "select_slave_in_guild", [tchar])
		newbutton.connect('gui_input', self, 'double_clicked')
		newbutton.set_meta("person", tchar)
		# globals.connectslavetooltip(newbutton, tchar)
	var person_id
	if get_parent().active_faction.slaves != []:
		person_id = get_parent().active_faction.slaves[0] 
	else: return
	var person = characters_pool.get_char_by_id(person_id)
	show_slave_info(person)
	
	# Animations
	if mode == "slave_market" && get_parent().get_node("GuildBG").is_visible():
		ResourceScripts.core_animations.FadeAnimation(get_parent().get_node("GuildBG"),0.5)
		yield(get_tree().create_timer(0.5), "timeout")
	get_parent().get_node("GuildBG").visible = (mode != "slave_market")
	var guild_buttons = get_parent().City.get_node("GuildMenu/VBoxContainer").get_children()
	if mode == "guild_slaves":
		for button in guild_buttons:
			if !button.has_meta("action"):
				continue
			if button.get_meta("action") != "Hire":
				continue
			else:
				self.visible = button.is_pressed()
	else:
		if !self.is_visible():
			self.set("modulate", Color(1,1,1,0))
			show()
			ResourceScripts.core_animations.UnfadeAnimation(self,0.5)
			yield(get_tree().create_timer(0.5), "timeout")
			self.set("modulate", Color(1,1,1,1))



func double_clicked(event):
	if event is InputEventMouseButton and event.doubleclick:
		show_full_info()

func show_slave_info(person):
	get_parent().person_to_hire = person
	$HBoxContainer/EnslaveButton.visible = person.get_stat("slave_class") != "slave" && mode != "guild_slaves" # && (!person.has_profession('master'))
	for button in $SlaveList/ScrollContainer/VBoxContainer.get_children():
		if button.name == "Button":
			continue
		button.pressed = button.get_meta("person") == get_parent().person_to_hire
	globals.connecttexttooltip($RichTextLabel, person.show_race_description())
	$exp.text = str(floor(person.get_stat('base_exp')))
	var text = person.get_short_name() + person.translate(" [race] [age]")
	input_handler.ClearContainer($TextureRect/professions)
	if person.xp_module.professions.size() > 5:
		$TextureRect/professions.columns = 10
		$TextureRect/professions/Button.rect_min_size = Vector2(45,45)
		$TextureRect/professions/Button/ProfIcon.rect_size = Vector2(34,34)
		$TextureRect/professions/Button/Label.hide()
	else:
		$TextureRect/professions.columns = 5
		$TextureRect/professions/Button.rect_min_size = Vector2(90,90)
		$TextureRect/professions/Button/ProfIcon.rect_size = Vector2(78,78)
		$TextureRect/professions/Button/Label.show()
		
	for i in person.xp_module.professions:
		var newnode = input_handler.DuplicateContainerTemplate($TextureRect/professions)
		var prof = classesdata.professions[i]
		var name = ResourceScripts.descriptions.get_class_name(prof, person)
		newnode.get_node("Label").text = name
		newnode.get_node("ProfIcon").texture = prof.icon
		newnode.connect('signal_RMB_release', get_parent().GUIWorld, 'show_class_info', [prof.code, person])
		var temptext = "[center]"+ResourceScripts.descriptions.get_class_name(prof,person) + "[/center]\n"+ResourceScripts.descriptions.get_class_bonuses(person, prof) + ResourceScripts.descriptions.get_class_traits(person, prof)
		temptext += "\n\n{color=aqua|" + tr("CLASSRIGHTCLICKDETAILS") + "}"
		globals.connecttexttooltip(newnode, temptext)
	$Portrait.texture = person.get_icon()
	$sex.texture = images.icons[person.get_stat('sex')]
	$RichTextLabel.bbcode_text = text

	for i in ['hp','mp','lust']:
		get_node("base_stats/"+ i ).max_value = person.get_stat(i+'max')
		get_node("base_stats/"+ i ).value = person.get_stat(i)
		get_node("base_stats/"+ i + '/Label').text = str(floor(person.get_stat(i))) + "/" + str(floor(person.get_stat(i+'max')))
	text = "Type: [color=yellow]" + person.translate(statdata.slave_class_names[person.get_stat('slave_class')]) + "[/color]\n"

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

	$ConsentLabel.text = "Consent: " + str(floor(person.get_stat('consent')))
	$PurchaseButton.disabled = false
	#$PurchaseButton.disabled = person.calculate_price() > ResourceScripts.game_res.money
	rebuild_traits(person)


func enslave_select():
	var person = get_parent().person_to_hire
	var price = person.calculate_price()
	var text = "Do you want to enslave " + person.get_short_name() + "?\nPrice: " + str(price)
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'enslave', text])



func enslave():
	var character = get_parent().person_to_hire
	character.set_slave_category("slave")
	input_handler.active_character = character
	var changes = [{code = 'money_change', operant = '-', value = variables.enslavement_price}]
	globals.common_effects(changes)
	globals.text_log_add('char',character.translate("[name] has been demoted to Slave."))
	globals.character_stat_change(character, {code = 'loyalty', operant = '-', value = 50})
	globals.character_stat_change(character, {code = 'submission', operant = '-', value = 25})
	input_handler.scene_characters.append(character)
	input_handler.interactive_message('enslave', '', {})
	input_handler.update_slave_list()
	show_slave_info(character)

func sell_slave():
	var slave_tooltip = get_tree().get_root().get_node_or_null("slavetooltip")
	if slave_tooltip != null:
		slave_tooltip.hide()
	$PurchaseButton.disabled = false
	get_parent().get_node("GuildBG").visible = (mode != "slave_market")
	get_parent().hiremode = 'sell'
	$HireMode.visible = mode != "guild_slaves"
	$SellMode.visible = mode != "guild_slaves"	
	show()
	$RichTextLabel.bbcode_text = ""
	input_handler.ClearContainer($SlaveList/ScrollContainer/VBoxContainer)
	var char_list = []
	for i in ResourceScripts.game_party.characters:
		var tchar = characters_pool.get_char_by_id(i)
		if (tchar.has_profession('master')): # || tchar.valuecheck({code = 'is_free', check = true}) == false):
			continue
		char_list.append(tchar)
		var newbutton = input_handler.DuplicateContainerTemplate($SlaveList/ScrollContainer/VBoxContainer)
		newbutton.get_node("name").text = tchar.get_stat('name')
		newbutton.get_node("Price").text = str(round(tchar.calculate_price() / 2))
		newbutton.connect("pressed", self, 'show_slave_info', [tchar])
		newbutton.connect('gui_input', self, 'double_clicked')
		newbutton.set_meta("person", tchar)
		globals.connectslavetooltip(newbutton, tchar)
	if char_list != []:
		var person = char_list[0]
		show_slave_info(person)
		char_list.clear()



func rebuild_traits(person):
	input_handler.ClearContainer($ScrollContainer2/traits)
	for i in person.statlist.traits:
		var trait = Traitdata.traits[i]
		if trait.visible == false:
			continue
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/traits)
		newnode.text = trait.name
	
	for i in person.statlist.sex_traits + person.statlist.negative_sex_traits:
		var trait = Traitdata.sex_traits[i]
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer2/traits)
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
	
	
	
