extends Control

# GUI Blocks
onready var GuildPanelContainer = $NavigationModule/GuildsPanel/GuildsPanelContainer/GuildSelection
onready var AreaActions = $AreaMenu/ScrollContainer/VBoxContainer
onready var SlaveMarketList = $SlaveMarket/SlaveList/ScrollContainer/VBoxContainer
onready var nav = $NavigationModule

#var active_area
var active_faction
#var active_location

var selected_location
var selected_area

var market_mode
var hiremode
var person_to_hire
var selectedquest

var city_options = {
	#location_purchase = "EXPLORBUYDUNGEON",
	quest_board = "EXPLORENOTICEBOARD",
}

var faction_actions = {
	hire = "EXPLOREHIRE",
	sellslaves = "EXPLORESELLCHR",
	quests = "EXPLOREQUESTS",
	upgrade = "EXPLOREUPGRADES",
	services = "EXPLORESERVICE",
	guild_shop = "EXPLOREGUILDSHOP",
}


func _ready():
	# ResourceScripts.game_world.make_world()
	# open_city("aliron")
	gui_controller.add_close_button($BuyLocation)
	gui_controller.add_close_button($GuildShop)
	gui_controller.add_close_button($QuestBoard)
	
	selected_location = 'aliron'
	selected_area = ResourceScripts.game_world.areas.plains
	
	$SlaveMarket/PurchaseButton.connect("pressed", self, "show_full_info")
	$SlaveMarket/HireMode.connect("pressed", self, "change_mode", ["hire"])
	$SlaveMarket/SellMode.connect("pressed", self, "change_mode", ["sell"])
	$SlaveMarket/HBoxContainer/EnslaveButton.connect("pressed", self, "enslave_select")
	$SlaveMarket/HBoxContainer/UpgradeButton.connect("pressed", self, "show_upgrade_window")
	$SlaveMarket/HBoxContainer/UpgradeButton2.connect("pressed", self, "show_bodyupgrade_window")
	for i in $AreaShop/SellFilter.get_children():
		i.connect('pressed', self, 'selectcategory', [i, "sell"])
	for i in $AreaShop/BuyFilter.get_children():
		i.connect('pressed', self, 'selectcategory', [i, "buy"])
	
	$BuyLocation/LocationInfo/PurchaseLocation.connect("pressed", self, "purchase_location")
	$TestButton.connect("pressed", self, "test")
	$TestButton.visible = gui_controller.mansion.test_mode
	$JournalButton.connect("pressed", self, "open_journal")
	gui_controller.win_btn_connections_handler(true, $MansionJournalModule, $JournalButton)
	gui_controller.windows_opened.clear()
	var closebutton = gui_controller.add_close_button($AreaShop)
	input_handler.connect("update_itemlist", self, 'update_sell_list')


func test():
	for win in gui_controller.windows_opened:
		print(win.name)


func enslave_select():
	var character = person_to_hire
	character.reset_mastery()
	character.set_slave_category("slave")
	input_handler.active_character = character
	var changes = [{code = 'money_change', operant = '-', value = variables.enslavement_price}]
	globals.common_effects(changes)
	globals.text_log_add('char',character.translate("[name] has been demoted to Slave."))
#	globals.character_stat_change(character, {code = 'loyalty', operant = '-', value = 50})
	input_handler.scene_characters.append(character)
	input_handler.interactive_message('enslave', '', {})
	input_handler.update_slave_list()
	sell_slave()


func open_journal():
#	globals.common_effects( [{code = 'update_city'}])
	if !$MansionJournalModule.visible:
		ResourceScripts.core_animations.UnfadeAnimation($MansionJournalModule, 0.5)
		$MansionJournalModule.visible = true
		$MansionJournalModule.open()
	else:
		ResourceScripts.core_animations.FadeAnimation($MansionJournalModule, 0.5)
		yield(get_tree().create_timer(0.5), "timeout")
		$MansionJournalModule.visible = false
	
	gui_controller.windows_opened.append($MansionJournalModule) if $MansionJournalModule.visible else gui_controller.windows_opened.erase($MansionJournalModule)


func open_city(city = null):
	if gui_controller.dialogue == null or !gui_controller.dialogue.is_visible() and !gui_controller.dialogue.doing_transition:
		self.raise()
	if gui_controller.clock != null:
		gui_controller.clock.raise()
	
	input_handler.exploration_node = self
	gui_controller.nav_panel = $NavigationModule
	gui_controller.nav_panel.build_accessible_locations()
	gui_controller.nav_panel.update_buttons()
	if city != null:
		selected_location = city
		selected_area = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[selected_location].area]
	self.current_pressed_area_btn = null
	
	if selected_area.has('capital_background_noise'):
		input_handler.PlayBackgroundSound(selected_area.capital_background_noise)
	if selected_area.has('capital_background_music'):
		input_handler.SetMusic(selected_area.capital_background_music, true)
	if selected_area.has("capital_dynamic_background"):
		get_node("VideoPlayer").open(selected_area.capital_dynamic_background)
	previous_guild = ''
	var guilds = []
	var area_actions = []
	for i in selected_area.factions.values():
		if !globals.checkreqs(i.conditions): continue
		if i.code in ["slavemarket", "exotic_slave_trader","beastkin_slave_trader", "aliron_church", "elvish_slave_trader"]:
			area_actions.append(i)
		else:
			guilds.append(i)
	build_guilds_panel(guilds)
	build_area_menu(area_actions)
	if $GuildBG.is_visible():
		ResourceScripts.core_animations.FadeAnimation($GuildBG, 0.3)
		yield(get_tree().create_timer(0.3), "timeout")
		$GuildBG.hide()


func build_guilds_panel(guilds):
	input_handler.ClearContainer(GuildPanelContainer)
	var newbutton
	var counter = 0
	guilds.sort_custom(self, 'sort_factions')
	for guild in guilds:
		counter += 1
		var newseparator = $NavigationModule/GuildsPanel/VSeparator.duplicate()
		newbutton = input_handler.DuplicateContainerTemplate(GuildPanelContainer)
		newbutton.text = guild.name
		newbutton.connect("pressed", self, "enter_guild", [guild])
		newbutton.set_meta("guild_name", guild.name)
		GuildPanelContainer.add_child(newseparator)
		newseparator.visible = counter != guilds.size()


func sort_factions(first, second):
	if variables.guild_order.has(first.code):
		if variables.guild_order.has(second.code):
			return variables.guild_order.find(first.code) < variables.guild_order.find(second.code)
		else:
			return true


func build_area_menu(area_actions):
	input_handler.ClearContainer(AreaActions)
	var newbutton
	var has_exotic_slaver = false
	for option in selected_area.capital_options:
		newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
		newbutton.get_node("Label").text = tr(city_options[option])
		newbutton.connect("toggled", self, option, [newbutton])
		newbutton.connect("toggled", self, 'reset_active_location')
		var font = input_handler.font_size_calculator(newbutton.get_node("Label"))
		newbutton.get_node("Label").set("custom_fonts/font", font)
	for action in area_actions:
		if action.code == "slavemarket":
			newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
			newbutton.connect("toggled", self, "faction_hire", [newbutton, action, "city_slaves"])
			newbutton.connect("toggled", self, 'reset_active_location')
			var font = input_handler.font_size_calculator(newbutton.get_node("Label"))
			newbutton.get_node("Label").set("custom_fonts/font", font)
		elif (
			(action.code == 'exotic_slave_trader')
			&& int(ResourceScripts.game_globals.date) % 7 == 0
			&& int(ResourceScripts.game_globals.date) % 14 != 0
			&& ResourceScripts.game_globals.hour >= 1
			&& ResourceScripts.game_globals.hour <= 3
		):
			has_exotic_slaver = true
			newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
			newbutton.connect("toggled", self, "faction_hire", [newbutton, action])
			newbutton.connect("toggled", self, 'reset_active_location')
			newbutton.texture_normal = load("res://assets/Textures_v2/CITY/Buttons/buttonviolet.png")
			newbutton.texture_hover = load("res://assets/Textures_v2/CITY/Buttons/buttonviolet_hover.png")
			newbutton.texture_pressed = load("res://assets/Textures_v2/CITY/Buttons/buttonviolet_pressed.png")
		elif action.code == 'exotic_slave_trader':
			continue
		elif action.code == 'elvish_slave_trader' or action.code == 'beastkin_slave_trader':
			has_exotic_slaver = true
			newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
			newbutton.connect("toggled", self, "faction_hire", [newbutton, action])
			newbutton.connect("toggled", self, 'reset_active_location')
		# elif action.code == 'aliron_church':
		# 	newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
		# 	newbutton.connect("pressed", self, "enter_church", [newbutton, action])
		# newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
		newbutton.get_node("Label").text = tr(action.name)
		var font = input_handler.font_size_calculator(newbutton.get_node("Label"))
		newbutton.get_node("Label").set("custom_fonts/font", font)
	newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
	newbutton.get_node("Label").text = tr("EXPLORESHOP")
	newbutton.connect("toggled", self, "open_shop", [newbutton, "area"])
	newbutton.connect("toggled", self, 'reset_active_location')
	if has_exotic_slaver:
		newbutton.get_parent().move_child(newbutton, newbutton.get_position_in_parent()-1)
	if worlddata.fixed_location_options.has(selected_location):
		for i in worlddata.fixed_location_options[selected_location]:
			if globals.checkreqs(i.reqs) == false:
				continue
			newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
			newbutton.get_node("Label").text = tr(i.text)
			var font = input_handler.font_size_calculator(newbutton.get_node("Label"))
			newbutton.get_node("Label").set("custom_fonts/font", font)
			newbutton.connect("pressed", globals, 'common_effects', [i.args])
			newbutton.connect("pressed", self, 'reset_active_location')
			newbutton.connect("pressed", self, "open_city", [selected_location])
			# newbutton.modulate = Color(0.5, 0.8, 0.5)
			newbutton.texture_normal = load("res://assets/Textures_v2/CITY/Buttons/buttonviolet.png")
			newbutton.texture_hover = load("res://assets/Textures_v2/CITY/Buttons/buttonviolet_hover.png")
			newbutton.texture_pressed = load("res://assets/Textures_v2/CITY/Buttons/buttonviolet_pressed.png")
			newbutton.toggle_mode = false
	elif selected_area.has("events"):
		for i in selected_area.events:
			if globals.checkreqs(i.reqs) == false:
				continue
			newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
			newbutton.get_node("Label").text = tr(i.text)
			var font = input_handler.font_size_calculator(newbutton.get_node("Label"))
			newbutton.get_node("Label").set("custom_fonts/font", font)
			if i.args.keys().has("oneshot") && !i.args.oneshot:
				newbutton.connect("pressed", self, 'reset_active_location')
				newbutton.connect("pressed", input_handler, "interactive_message", [i.code, '', i.args])
			else:
				newbutton.connect("pressed", input_handler, "interactive_message", [i.code, 'area_oneshot_event', i.args])
				newbutton.connect("pressed", self, 'reset_active_location')
				newbutton.connect("pressed", self, "open_city", [selected_location])
			# newbutton.modulate = Color(0.5, 0.8, 0.5)
			newbutton.texture_normal = load("res://assets/Textures_v2/CITY/Buttons/buttonviolet.png")
			newbutton.texture_hover = load("res://assets/Textures_v2/CITY/Buttons/buttonviolet_hover.png")
			newbutton.texture_pressed = load("res://assets/Textures_v2/CITY/Buttons/buttonviolet_pressed.png")
			newbutton.toggle_mode = false

var action_type
var active_skill
var previous_guild = ''


func update_guild_actions(guild):
	input_handler.ClearContainer(AreaActions)
	hide_guild_panels()
	var newbutton
	if active_faction.has('events'):
		for i in active_faction.events:
			var events = scenedata.dialogue_inits[i]
			var event
			for k in events:
				if globals.checkreqs(k.reqs) == true:
					event = k
					break
			if event == null:
				continue
			newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
			newbutton.get_node("Label").text = tr(event.name)
			newbutton.connect(
				"pressed",
				input_handler,
				"interactive_dialogue_start",
				[event.target, event.target_option]
			)
			newbutton.connect(
				"pressed",
				gui_controller,
				"close_all_closeable_windows"
			)
			newbutton.texture_normal = load(
				"res://assets/Textures_v2/CITY/Buttons/buttonmagenta.png"
			)
			newbutton.texture_pressed = load(
				"res://assets/Textures_v2/CITY/Buttons/buttonmagenta_pressed.png"
			)
			newbutton.texture_hover = load(
				"res://assets/Textures_v2/CITY/Buttons/buttonmagenta_hover.png"
			)
	for i in guild.actions:
		newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
		newbutton.get_node("Label").text = tr(faction_actions[i])
		newbutton.connect("toggled", self, "faction_" + i, [newbutton, guild])
		newbutton.texture_normal = load("res://assets/Textures_v2/CITY/Buttons/buttonviolet.png")
		newbutton.texture_pressed = load(
			"res://assets/Textures_v2/CITY/Buttons/buttonviolet_pressed.png"
		)
		newbutton.texture_hover = load(
			"res://assets/Textures_v2/CITY/Buttons/buttonviolet_hover.png"
		)
	for a in guild.bonus_actions:
		var check = true
		for r in a.reqs:
			check = globals.valuecheck(r)
			if !check:
				break
		if !check:
			continue
		newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
		newbutton.get_node("Label").text = tr(a.name)
		newbutton.connect("toggled", self, "faction_" + a.code, [newbutton, guild])
		newbutton.texture_normal = load("res://assets/Textures_v2/CITY/Buttons/buttonviolet.png")
		newbutton.texture_pressed = load(
			"res://assets/Textures_v2/CITY/Buttons/buttonviolet_pressed.png"
		)
		newbutton.texture_hover = load(
			"res://assets/Textures_v2/CITY/Buttons/buttonviolet_hover.png"
		)
	newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
	newbutton.get_node("Label").text = tr("DIALOGUELEAVE")
	newbutton.connect("pressed", self, "open_city", [selected_location])


func hide_guild_panels():
	for nd in [$FactionDetails, $DisassembleModule, $GuildShop, $SlaveMarket]:
		nd.hide()


func enter_guild(guild):
	self.current_pressed_area_btn = null
	if guild != null:
		if (
			previous_guild == guild.name
			&& get_tree().get_root().get_node_or_null("dialogue")
			&& ! get_tree().get_root().get_node("dialogue").is_visible()
		):
			previous_guild = ''
			update_guild_buttons('')
			open_city(selected_location)
			return
		previous_guild = guild.name
		update_guild_buttons(guild.name)
		input_handler.active_area = ResourceScripts.game_world.areas[guild.area]
		active_faction = guild
		market_mode = "guild_slaves"
		input_handler.active_faction = guild
		update_guild_actions(guild)

		# Visuals
		$GuildBG.texture = images.get_background(guild.background)
	if get_tree().get_root().get_node_or_null("dialogue") && ! get_tree().get_root().get_node("dialogue").is_visible():
		unfade($GuildBG)
	if gui_controller.is_dialogue_just_started():
		unfade($GuildBG)


var infotext = "Upgrades effects and quest settings update after some time passed. "


func faction_disassemble(pressed, pressed_button, guild):
	hide_guild_panels()
	if $FactionDetails.is_visible():
		$FactionDetails.hide()
	gui_controller.win_btn_connections_handler(pressed, $DisassembleModule, pressed_button)
	self.current_pressed_area_btn = pressed_button

	if pressed && !$DisassembleModule.is_visible():
		unfade($DisassembleModule, 0.3)
		$DisassembleModule.open()
	elif !pressed && $DisassembleModule.is_visible():
		fade($DisassembleModule, 0.3)


func faction_guild_shop(pressed, pressed_button, guild):
	hide_guild_panels()
	$GuildShop/NumberSelection2/ItemIcon.texture = null
	$GuildShop/NumberSelection2.hide()
	gui_controller.win_btn_connections_handler(pressed, $GuildShop, pressed_button)
	active_faction = guild
	input_handler.active_faction = guild
	self.current_pressed_area_btn = pressed_button
	input_handler.ClearContainer($GuildShop/ScrollContainer/VBoxContainer)
	for item in guild.reputation_shop.items:
		if guild.reputation_shop.items[item][0] <= 0:
			continue
		var item_ref
		if Items.itemlist.has(item):
			item_ref =  Items.itemlist[item]
		else:
			item_ref = Items.materiallist[item]
		var newbutton = input_handler.DuplicateContainerTemplate($GuildShop/ScrollContainer/VBoxContainer)
		newbutton.get_node("Title").text = item_ref.name
		newbutton.get_node("Type").text = tr("ITEM_LABEL")
		newbutton.get_node("Icon").texture = item_ref.icon
		newbutton.get_node("Price").text = "x " + str(guild.reputation_shop.items[item][1])
		newbutton.get_node("Amount").show()
		newbutton.get_node("Amount").text = str(guild.reputation_shop.items[item][0])
		newbutton.connect("pressed", self, "buy_item", [item_ref, guild.reputation_shop.items[item][1], guild.reputation_shop.items[item][0]])
		newbutton.connect("pressed", self, "guild_shop_item_selected", [newbutton])
		if Items.itemlist.has(item):
			globals.connecttempitemtooltip(newbutton, item_ref, 'geartemplate')
		else:
			globals.connectmaterialtooltip(newbutton, item_ref)

	for cls in guild.reputation_shop.classes:
		if ResourceScripts.game_progress.unlocked_classes.has(cls):
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($GuildShop/ScrollContainer/VBoxContainer)
		newbutton.get_node("Title").text = str(classesdata.professions[cls].name)
		newbutton.get_node("Type").text = tr("CLASS_LABEL")
		newbutton.get_node("Price").text = "x " + str(guild.reputation_shop.classes[cls])
		newbutton.get_node("Icon").texture = classesdata.professions[cls].icon
		newbutton.connect("pressed", self, "buy_item", [cls, guild.reputation_shop.classes[cls], 1, "class"])
		newbutton.connect("pressed", self, "guild_shop_item_selected", [newbutton])
		var person = ResourceScripts.game_party.get_master()
		var prof = classesdata.professions[cls]
		var name = ResourceScripts.descriptions.get_class_name(prof, person)
		newbutton.connect('signal_RMB_release', gui_controller, 'show_class_info', [prof.code, person])
		var temptext = "[center]"+ResourceScripts.descriptions.get_class_name(prof,person) + "[/center]\n"+ResourceScripts.descriptions.get_class_bonuses(person, prof) + ResourceScripts.descriptions.get_class_traits(person, prof)
		var social_skills = ''
		var combat_skills = ''
		if classesdata.professions[cls].has("skills") && !classesdata.professions[cls].skills.empty():
			temptext += "\n" + tr("SOCIAL_SKILLS") + " - "
			for skill in classesdata.professions[cls].skills:
				social_skills += Skilldata.Skilllist[skill].name + ", "
			social_skills = social_skills.substr(0, social_skills.length() - 2)
		temptext += social_skills
		if classesdata.professions[cls].has("combatskills") && !classesdata.professions[cls].combatskills.empty():
			temptext += "\n" + tr("COMBAT_SKILLS") + " - "
			for skill in classesdata.professions[cls].combatskills:
				combat_skills += Skilldata.Skilllist[skill].name + ", "
			combat_skills = combat_skills.trim_suffix(', ')
		temptext += combat_skills
		temptext += "\n\n{color=aqua|" + tr("CLASSRIGHTCLICKDETAILS") + "}"
		globals.connecttexttooltip(newbutton, temptext, true)
	$GuildShop/FactionPoints.text = "x " + str(active_faction.reputation)
	$GuildShop/GuildName.text = str(active_faction.name)
	if pressed && !$GuildShop.is_visible():
		unfade($GuildShop, 0.3)
	elif !pressed && $GuildShop.is_visible():
		fade($GuildShop, 0.3)


func guild_shop_item_selected(button):
	for ch in $GuildShop/ScrollContainer/VBoxContainer.get_children():
		ch.pressed = button == ch


var hide_elems_arr = ["HSlider", "ItemAmount"]#, "TextureRect2","ItemPrice"]


func buy_item(item_ref, price, amount, type = "item"):
	var item_name = ''
	var item_icon = null
	if type == "class":
		item_name = classesdata.professions[item_ref].name
		if ResourceScripts.game_progress.unlocked_classes.has(item_ref):
			$GuildShop/NumberSelection2.show()
			$GuildShop/NumberSelection2/ItemPrice.text = "Unlocked"
			$GuildShop/NumberSelection2/Button.disabled = true
			return
	if type == "item":
		item_name = item_ref.name
		item_icon = item_ref.icon
	elif type == "class":
		amount = 0
		if classesdata.professions.has(item_ref):
			item_icon = classesdata.professions[item_ref].icon
	item_to_buy = item_ref
	for node in $GuildShop/NumberSelection2.get_children():
		if node.name in hide_elems_arr:
			node.visible = type == "item"
	$GuildShop/NumberSelection2.open(
		self,
		'buy_item_confirm',
		item_name,
		price,
		amount,
		10 * amount,
		true,
		item_icon
	)


func buy_item_confirm(amount):
	items_amount = amount
	var item_name = ''
	var price = 0
	if typeof(item_to_buy) == TYPE_DICTIONARY:
		item_name = item_to_buy.name
		price = active_faction.reputation_shop.items[item_to_buy.code][1] * amount
	if typeof(item_to_buy) == TYPE_STRING:
		item_name = classesdata.professions[item_to_buy].name
		price = active_faction.reputation_shop.classes[item_to_buy]
	var text = tr("SPEND_REP_QUESTION_LABEL") + " {color=yellow|" + str(price) + "} " +   tr("REP_POINTS_LABEL") + str(item_name)  + "?"
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL,
	[
		self,
		'confirm_buy_item',
		text
	])


var item_to_buy
var items_amount


func confirm_buy_item():
	if typeof(item_to_buy) == TYPE_STRING:
		globals.common_effects([{code = "unlock_class", name = item_to_buy}])
		input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
		active_faction.reputation -= active_faction.reputation_shop.classes[item_to_buy]
		faction_guild_shop(true, current_pressed_area_btn, active_faction)
		return
	if typeof(item_to_buy) == TYPE_OBJECT:
		globals.AddItemToInventory(item_to_buy)
		input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
	else:
		if Items.materiallist.has(item_to_buy.code):
			ResourceScripts.game_res.set_material(item_to_buy.code, '+', active_faction.reputation_shop.items[item_to_buy.code][0] * items_amount)
			# active_faction.reputation_shop.items[item_to_buy.code][0] -= items_amount
		elif Items.itemlist.has(item_to_buy.code):
			# active_faction.reputation_shop.items[item_to_buy.code][0] -= items_amount
			match item_to_buy.type:
				'usable':
					globals.AddItemToInventory(globals.CreateUsableItem(item_to_buy.code, items_amount))
				'gear':
					globals.AddItemToInventory(globals.CreateGearItemShop(item_to_buy.code, {}))
	active_faction.reputation -= active_faction.reputation_shop.items[item_to_buy.code][1] * items_amount
	faction_guild_shop(true, current_pressed_area_btn, active_faction)


func faction_upgrade(pressed, pressed_button, guild):
	hide_guild_panels()
	gui_controller.win_btn_connections_handler(pressed, $FactionDetails, pressed_button)
	active_faction = guild
	self.current_pressed_area_btn = pressed_button
	var text = ''
	# $FactionDetails.visible = pressed
	input_handler.ClearContainer($FactionDetails/Scroll/VBoxContainer)
	text = infotext
	$FactionDetails/RichTextLabel.text = text
	$FactionDetails/FactionPoints.text = "Faction points: " + str(active_faction.totalreputation)
	$FactionDetails/UnspentPoints.text = "Unspent points: " + str(active_faction.reputation)

	var check = true
	for i in worlddata.guild_upgrades.values():
		if i.reqs != []:
			for r in i.reqs:
				check = globals.valuecheck(r)
				if !check:
					break
		if !check:
			continue
		var newnode = input_handler.DuplicateContainerTemplate($FactionDetails/Scroll/VBoxContainer)
		text = tr(i.name) + ": " + tr(i.descript)
		var currentupgradelevel
		if active_faction.upgrades.has(i.code):
			currentupgradelevel = active_faction.upgrades[i.code]
		else:
			currentupgradelevel = 0
		if currentupgradelevel < i.maxlevel:
			# text += "\n\nPrice: " + str(i.cost[currentupgradelevel]) + " faction points."
			if active_faction.reputation < i.cost[currentupgradelevel]:
				newnode.get_node("confirm").disabled = true

		else:
			newnode.hide()
			continue
		newnode.get_node("text").bbcode_text = text
		newnode.get_node("Price").text = (
			"Cost: "
			+ str(i.cost[currentupgradelevel])
			+ " points"
		)
		newnode.get_node("confirm").connect(
			'pressed', self, "unlock_upgrade", [i, currentupgradelevel]
		)
	if pressed && !$FactionDetails.is_visible():
		unfade($FactionDetails, 0.3)
	elif pressed && $FactionDetails.is_visible():
		return
	else:
		fade($FactionDetails, 0.3)


func unlock_upgrade(upgrade, level):
	if active_faction.upgrades.has(upgrade.code):
		active_faction.upgrades[upgrade.code] += 1
	else:
		active_faction.upgrades[upgrade.code] = 1
	active_faction.reputation -= upgrade.cost[level]
	var effect = upgrade.effects
	for i in effect:
		if i.code == 'slavelevel':
			for typedata in active_faction.hireable_characters:
				typedata.slavelevel = input_handler.math(i.operant, typedata.slavelevel, i.value)
		else:
			var value = get_indexed('active_faction:' + i.code)
			value = input_handler.math(i.operant, value, i.value)
			set_indexed('active_faction:' + i.code, value)
			if i.code == 'slavenumber':
				for typedata in active_faction.hireable_characters:
					typedata.slavenumber[1] = input_handler.math(i.operant, typedata.slavenumber[1], i.value)
	update_guild_actions(active_faction)
	faction_upgrade(true, current_pressed_area_btn, active_faction)


func double_clicked(event):
	if event is InputEventMouseButton and event.doubleclick:
		show_full_info(person_to_hire)


func show_full_info(person = null):
	var FullSlaveInfo = input_handler.get_spec_node(input_handler.NODE_EXPLORE_SLAVEINFO)
	if ! gui_controller.windows_opened.has(FullSlaveInfo):
		gui_controller.windows_opened.append(FullSlaveInfo)
	gui_controller.explore_slaveinfo = FullSlaveInfo
	FullSlaveInfo.show()
	FullSlaveInfo.from_dialogue = false
	if person == null:
		FullSlaveInfo.show_summary(person_to_hire)
	else:
		FullSlaveInfo.show_summary(person)
	# FullSlaveInfo.update_purchase_btn()


func faction_hire(pressed, pressed_button, area, mode = "guild_slaves", play_anim = true):
	person_to_hire = null
	$SlaveMarket/HireMode.pressed = true
	$SlaveMarket/SellMode.pressed = false
	market_mode = mode
	hide_guild_panels()
	gui_controller.win_btn_connections_handler(pressed, $SlaveMarket, pressed_button)
	active_faction = area
	self.current_pressed_area_btn = pressed_button
	$SlaveMarket/HireMode.visible = market_mode != "guild_slaves"
	$SlaveMarket/SellMode.visible = market_mode != "guild_slaves"
	$SlaveMarket/HBoxContainer/UpgradeButton.visible = market_mode != "guild_slaves"
	hiremode = 'hire'
	$SlaveMarket/RichTextLabel.bbcode_text = ""
	input_handler.ClearContainer($SlaveMarket/SlaveList/ScrollContainer/VBoxContainer)
	for i in active_faction.slaves:
		var tchar = characters_pool.get_char_by_id(i)
		var newbutton = input_handler.DuplicateContainerTemplate(
			$SlaveMarket/SlaveList/ScrollContainer/VBoxContainer
		)
		newbutton.get_node("name").text = tchar.get_short_name() + " - " + tchar.get_short_race()
		#newbutton.get_node('name').set("custom_colors/font_color",variables.hexcolordict['factor'+str(int(floor(tchar.get_stat('growth_factor'))))])
		newbutton.get_node("Price").text = str(tchar.calculate_price(true))
		newbutton.get_node('icon').texture = tchar.get_icon_small()
		#newbutton.connect('signal_RMB_release',input_handler,'ShowSlavePanel', [tchar])
		newbutton.connect("pressed", self, 'show_slave_info', [tchar])  #, self, "select_slave_in_guild", [tchar])
		newbutton.connect('gui_input', self, 'double_clicked')
		newbutton.set_meta("person", tchar)
		globals.connectslavetooltip(newbutton, tchar)
	var person_id
	var person
	if !active_faction.slaves.empty():
		$SlaveMarket/HireMode.disabled = false
		person_id = active_faction.slaves[0]
		person = characters_pool.get_char_by_id(person_id)
		show_slave_info(person)
	else:
		$SlaveMarket/HireMode.disabled = true
		if market_mode != "guild_slaves":
			change_mode('sell')
#		current_pressed_area_btn.pressed = false
#		$SlaveMarket.hide()
#		input_handler.SystemMessage(tr("NOSLAVESINMARKET"))
#		gui_controller.win_btn_connections_handler(false, $SlaveMarket, pressed_button)
#		return
	if !play_anim:
		$SlaveMarket.visible = true
		return
	if pressed:
		unfade($SlaveMarket, 0.3)
		$JournalButton.disabled = true
	else:
		$JournalButton.disabled = false
		input_handler.get_spec_node(input_handler.NODE_SLAVETOOLTIP).hide()
		fade($SlaveMarket, 0.3)


func show_upgrade_window():
	gui_controller.close_top_window()
	$SlaveMarket.hide()
	if !gui_controller.windows_opened.has($StatsUpgrade):
		gui_controller.windows_opened.append($StatsUpgrade)
	$StatsUpgrade.show()
	$StatsUpgrade.show_characters_panel()


func show_bodyupgrade_window():
#	if person_to_hire == null:
#		return
#	if !person_to_hire.is_players_character or !person_to_hire.is_active:
#		return #should add here message
#	var person = person_to_hire
#	gui_controller.close_top_window()
#	$SlaveMarket.hide()
#	input_handler.get_spec_node(input_handler.NODE_CHAREDIT, [person])
	if !gui_controller.windows_opened.has($BodyUpgrade):
		gui_controller.windows_opened.append($BodyUpgrade)
	$BodyUpgrade.show()
	$BodyUpgrade.show_characters_panel()


func change_mode(mode):
	hiremode = mode
	if mode == "hire":
		faction_hire(true, current_pressed_area_btn, active_faction, "city_slaves", false)
	else:
		sell_slave()


func sell_slave():
	person_to_hire = null
	$SlaveMarket/HireMode.pressed = false
	$SlaveMarket/SellMode.pressed = true
	if !active_faction.slaves.empty():
		$SlaveMarket/HireMode.disabled = false
	else:
		$SlaveMarket/HireMode.disabled = true
	var slave_tooltip = get_tree().get_root().get_node_or_null("slavetooltip")
	if slave_tooltip != null:
		slave_tooltip.hide()
	$SlaveMarket/PurchaseButton.disabled = false
	# get_parent().get_node("GuildBG").visible = (mode != "slave_market")
	hiremode = 'sell'
	$SlaveMarket/HireMode.visible = market_mode != "guild_slaves"
	$SlaveMarket/SellMode.visible = market_mode != "guild_slaves"
	$SlaveMarket/RichTextLabel.bbcode_text = ""
	input_handler.ClearContainer($SlaveMarket/SlaveList/ScrollContainer/VBoxContainer)
	var char_list = []
	for i in ResourceScripts.game_party.characters:
		var tchar = characters_pool.get_char_by_id(i)
		if (tchar.has_profession('master') || tchar.get_stat('slave_class') == 'servant') || tchar.check_work_rule("lock"): # || tchar.valuecheck({code = 'is_free', check = true}) == false):
			continue
		char_list.append(tchar)
		var newbutton = input_handler.DuplicateContainerTemplate($SlaveMarket/SlaveList/ScrollContainer/VBoxContainer)
		newbutton.get_node("name").text = tchar.get_short_name() + " - " + tchar.get_short_race()
		newbutton.get_node("Price").text = str(round(tchar.calculate_price(true) / 2))
		newbutton.connect("pressed", self, 'show_slave_info', [tchar])
		newbutton.connect('gui_input', self, 'double_clicked')
		newbutton.set_meta("person", tchar)
		newbutton.get_node('icon').texture = tchar.get_icon_small()
		globals.connectslavetooltip(newbutton, tchar)
	if !char_list.empty():
		var person = char_list[0]
		show_slave_info(person)
		char_list.clear()


func show_slave_info(person):
	$SlaveMarket/HBoxContainer/UpgradeButton2.visible = true #add correct condition here
	person_to_hire = person
	$SlaveMarket/HBoxContainer/EnslaveButton.visible = !(person.get_stat("slave_class") in  ["slave", 'slave_trained']) && market_mode != "guild_slaves" && person.get_stat("unique") == null # && (!person.has_profession('master'))
	for button in SlaveMarketList.get_children():
		if button.name == "Button":
			continue
		button.pressed = button.get_meta("person") == person_to_hire
	globals.connecttexttooltip($SlaveMarket/RichTextLabel, person.show_race_description())
	$SlaveMarket/exp.text = "Exp: " + str(floor(person.get_stat('base_exp')))
	var text = "[center]" + person.get_full_name() + "[/center]"
	input_handler.ClearContainer($SlaveMarket/TextureRect/professions)
	if person.get_prof_number() > 5:
		$SlaveMarket/TextureRect/professions.columns = 10
		$SlaveMarket/TextureRect/professions/Button.rect_min_size = Vector2(45, 45)
		$SlaveMarket/TextureRect/professions/Button/ProfIcon.rect_size = Vector2(34, 34)
		$SlaveMarket/TextureRect/professions/Button/Label.hide()
	else:
		$SlaveMarket/TextureRect/professions.columns = 5
		$SlaveMarket/TextureRect/professions/Button.rect_min_size = Vector2(90, 90)
		$SlaveMarket/TextureRect/professions/Button/ProfIcon.rect_size = Vector2(78, 78)
		$SlaveMarket/TextureRect/professions/Button/Label.show()
	
	for i in person.get_professions():
		var newnode = input_handler.DuplicateContainerTemplate($SlaveMarket/TextureRect/professions)
		var prof = classesdata.professions[i]
		var name = ResourceScripts.descriptions.get_class_name(prof, person)
		newnode.get_node("Label").text = name
		newnode.get_node("ProfIcon").texture = prof.icon
		newnode.connect(
			'signal_RMB_release', gui_controller, 'show_class_info', [prof.code, person]
		)
		var temptext = (
			"[center]"
			+ ResourceScripts.descriptions.get_class_name(prof, person)
			+ "[/center]\n"
			+ ResourceScripts.descriptions.get_class_bonuses(person, prof)
			+ ResourceScripts.descriptions.get_class_traits(person, prof)
		)
		temptext += "\n\n{color=aqua|" + tr("CLASSRIGHTCLICKDETAILS") + "}"
		globals.connecttexttooltip(newnode, temptext)
	$SlaveMarket/Portrait.texture = person.get_icon()
	globals.build_attrs_for_char($SlaveMarket, person)
	$SlaveMarket/RichTextLabel.bbcode_text = text
	
	for i in ['hp', 'mp', 'lust']:
		get_node("SlaveMarket/base_stats/" + i).max_value = person.get_stat(i + 'max')
		get_node("SlaveMarket/base_stats/" + i).value = person.get_stat(i)
		get_node("SlaveMarket/base_stats/" + i + '/Label').text = (
			str(floor(person.get_stat(i)))
			+ "/"
			+ str(floor(person.get_stat(i + 'max')))
		)
	
	var slavename = "CHARTYPE" + person.get_stat('slave_class').to_upper()
	if person.get_stat('sex') != 'male':
		slavename += "F"
	text = (
		tr('TYPE_LABEL') + ': ' + "[color=yellow]"
		+ slavename
		+ "[/color]\n"
	)
	
	for i in $SlaveMarket/factors.get_children():
		# if i.name in ['food_consumption', 'base_exp']:
		if i.name in ['base_exp', 'food_consumption']:
			# i.get_node("Label").text = str(floor(person.get_stat(i.name)))
			continue
		if input_handler.globalsettings.factors_as_words:
			i.get_node("Label").text = ResourceScripts.descriptions.factor_descripts[int(
				floor(person.get_stat(i.name))
			)]
			i.get_node("Label").set(
				"custom_colors/font_color",
				variables.hexcolordict['factor' + str(int(floor(person.get_stat(i.name))))]
			)
		else:
			i.get_node("Label").text = str(floor(person.get_stat(i.name)))
			i.get_node("Label").set("custom_colors/font_color", Color(1, 1, 1))
	
#	globals.build_loyalty_traitlist(person, $SlaveMarket/scroll/traitscontainer)
	
	$SlaveMarket/ConsentLabel.text = "Consent: " + str(floor(person.get_stat('consent')))
	$SlaveMarket/PurchaseButton.disabled = false
	#$PurchaseButton.disabled = person.calculate_price() > ResourceScripts.game_res.money
	# rebuild_traits(person)


var sell_category = 'all'
var buy_category = 'all'
var active_shop


func faction_sellslaves():#obsolete
	hiremode = 'sell'
#	$HirePanel.show()
#	$HirePanel/RichTextLabel.bbcode_text = ""
	input_handler.ClearContainer($SlaveMarket/SlaveList/ScrollContainer/VBoxContainer)
	var first_char = null
	var counter = 0
	for i in ResourceScripts.game_party.character_order:
		var tchar = characters_pool.get_char_by_id(i)
		if tchar.has_profession('master') || tchar.valuecheck({code = 'is_free', check = true}) == false :
			continue
		if counter == 0:
			first_char = tchar
			counter += 1
		var newbutton = input_handler.DuplicateContainerTemplate($SlaveMarket/SlaveList/ScrollContainer/VBoxContainer)
		newbutton.get_node("name").text = tchar.get_short_name()
		newbutton.get_node("Price").text = str(round(tchar.calculate_price(true)/2))
		newbutton.connect("pressed", self, "show_slave_info", [tchar])
		newbutton.set_meta("person", tchar)
		globals.connectslavetooltip(newbutton, tchar)
	if first_char != null:
		show_slave_info(first_char)


func unfade(window, time = 0.5):
	window.set("modulate", Color(1, 1, 1, 0))
	window.show()
	ResourceScripts.core_animations.UnfadeAnimation(window, time)
	yield(get_tree().create_timer(time), "timeout")
	window.set("modulate", Color(1, 1, 1, 1))


func fade(window, time = 0.5):
	# window.set("modulate", Color(1, 1, 1, 1))
	ResourceScripts.core_animations.FadeAnimation(window, time)
	yield(get_tree().create_timer(time), "timeout")
	window.hide()
	# window.set("modulate", Color(1, 1, 1, 0))


func open_shop(pressed, pressed_button, shop):
	$AreaShop/NumberSelection.hide()
	gui_controller.win_btn_connections_handler(pressed, $AreaShop, pressed_button)
	self.current_pressed_area_btn = pressed_button
	# $AreaShop.visible = pressed
	match shop:
		'area':
			active_shop = input_handler.active_area.shop
		'location':
			if pressed:
				active_shop = input_handler.active_location.shop
	if !(active_shop is Dictionary):
		print("warning: active_shop is not a Dictionary!")
	sell_category = 'all'
	buy_category = 'all'
	$AreaShop/SellFilter.get_child(0).pressed = true
	$AreaShop/BuyFilter.get_child(0).pressed = true
	update_sell_list()
	update_buy_list()
	if pressed:
		unfade($AreaShop)
	else:
		fade($AreaShop)


func selectcategory(button, list):
	var type = button.name
	if list == "sell":
		for i in $AreaShop/SellFilter.get_children():
			i.pressed = i == button
		sell_category = type
		update_sell_list()
	else:
		for i in $AreaShop/BuyFilter.get_children():
			i.pressed = i == button
		buy_category = type
		update_buy_list()


var tempitems = []


func get_item_category(item):
	var type
	if Items.materiallist.has(item.code):
		if item.type == 'food':
			type = 'food'
		else:
			type = 'material'
	else:
		if item.itemtype == 'tool':
			type = 'tool'
		elif item.itemtype == 'weapon':
			type = 'weapon'
		elif item.itemtype == 'armor':
			if item.geartype == 'costume':
				type = 'costume'
			else:
				type = 'armor'
		else:
			type = 'usable'
	return type


func update_sell_list():
	input_handler.ClearContainer($AreaShop/SellBlock/ScrollContainer/VBoxContainer)
	tempitems.clear()
	var array = []
	
	for i in ResourceScripts.game_res.materials:
		if ResourceScripts.game_res.materials[i] <= 0 || Items.materiallist[i].type == 'quest':
			continue
		array.append(i)
	
	array.sort_custom(self, 'sort_mats')
	
	for i in array:
		var item = Items.materiallist[i]
		var type = get_item_category(item)
		var newbutton = input_handler.DuplicateContainerTemplate(
			$AreaShop/SellBlock/ScrollContainer/VBoxContainer
		)
		newbutton.get_node("name").text = item.name
		newbutton.get_node("icon").texture = item.icon
		newbutton.get_node("price").text = str(ceil(item.price * variables.material_sell_multiplier))
		newbutton.get_node("amount").visible = true
		newbutton.get_node("amount").text = str(ResourceScripts.game_res.materials[i])
		newbutton.set_meta('type', type)
		newbutton.set_meta('item', item.name)
		newbutton.set_meta('exploration', true)
		newbutton.connect("pressed", self, "item_sell", [item])
		newbutton.visible = (newbutton.get_meta("type") == sell_category) || sell_category == "all"
		globals.connectmaterialtooltip(newbutton, item)
	for item in ResourceScripts.game_res.items.values():
		if item.amount <= 0 || item.tags.has('unsellable'):
			continue
		var type = get_item_category(item)
		if item.owner != null:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate(
			$AreaShop/SellBlock/ScrollContainer/VBoxContainer
		)
		newbutton.get_node("name").text = item.name
		item.set_icon(newbutton.get_node("icon"))  #.texture = item.get_icon()
		newbutton.get_node("price").text = str(ceil(item.calculateprice() * variables.item_sell_multiplier))
		newbutton.get_node("amount").visible = true
		newbutton.get_node("amount").text = str(item.amount)
		newbutton.set_meta('type', type)
		newbutton.set_meta('item', item.name)
		newbutton.set_meta('exploration', true) #while not reqired as it is now
		newbutton.connect("pressed", self, "item_sell", [item])
		newbutton.visible = (newbutton.get_meta("type") == sell_category) || sell_category == "all"
		globals.connectitemtooltip_v2(newbutton, item)


func sort_mats(first,second):
	var material1 = Items.materiallist[first]
	var material2 = Items.materiallist[second]
	if material1.name >= material2.name:
		return false
	else:
		return true

func update_buy_list():
	input_handler.ClearContainer($AreaShop/BuyBlock/ScrollContainer/VBoxContainer)
	tempitems.clear()
	
	var array = []
	
	
	for i in active_shop:
		if Items.materiallist.has(i):
			var item = Items.materiallist[i]
			if active_shop[i] == 0:
				continue
			array.append(i)
	array.sort_custom(self,'sort_mats')
	for i in array:
		var item = Items.materiallist[i]
		var amount = active_shop[i]
		var type = get_item_category(item)
		var newbutton = input_handler.DuplicateContainerTemplate(
			$AreaShop/BuyBlock/ScrollContainer/VBoxContainer
		)
		newbutton.get_node("name").text = item.name
		newbutton.get_node("icon").texture = item.icon
		newbutton.get_node("price").text = str(item.price)
		newbutton.set_meta('type', type)
		newbutton.set_meta('item', item.name)
		newbutton.set_meta('exploration', true)
		newbutton.connect("pressed", self, "item_purchase", [item, amount])
		newbutton.visible = (
			(newbutton.get_meta("type") == buy_category)
			|| buy_category == "all"
		)
		globals.connectmaterialtooltip(newbutton, item, "", 'material')
		if amount > 0:
			newbutton.get_node("amount").text = str(amount)
			newbutton.get_node("amount").show()
	
	for i in active_shop:
		if !Items.itemlist.has(i):
			continue
		
		var item = Items.itemlist[i]
		if item.has('parts'):#means active_shop[i] is array of dicts
			Items.get_loot().try_fix_old_shop_parts(active_shop, i)#14 march 2025. Remove with time!
			for record in active_shop[i]:
				var type = get_item_category(item)
				var newbutton = input_handler.DuplicateContainerTemplate(
					$AreaShop/BuyBlock/ScrollContainer/VBoxContainer
				)
				newbutton.get_node("icon").texture = item.icon
				newbutton.set_meta('type', type)
				newbutton.set_meta('item', item.name)
				newbutton.set_meta('exploration', true) #while not reqired as it is now
				newbutton.visible = (
					(newbutton.get_meta("type") == buy_category)
					|| buy_category == "all"
				)
				var newitem
				if record.has('quality'):
					var parts = record.duplicate()
					parts.erase('quality')
					newitem = globals.CreateGearItemQuality(i, parts, record.quality)
				else:
					newitem = globals.CreateGearItemShop(i, record)
					record.quality = newitem.quality
				newitem.set_icon(newbutton.get_node('icon'))
				newbutton.get_node("name").text = newitem.name
				tempitems.append(newitem)
				globals.connectitemtooltip_v2(newbutton, newitem)
				newbutton.get_node("price").text = str(newitem.calculateprice())
				newbutton.connect('pressed', self, "item_purchase", [newitem, 1])
				newbutton.get_node("amount").text = "1"
				newbutton.get_node("amount").show()
		else:
			var amount = active_shop[i]
			if amount == 0:
				continue
			var type = get_item_category(item)
			var newbutton = input_handler.DuplicateContainerTemplate(
				$AreaShop/BuyBlock/ScrollContainer/VBoxContainer
			)
			newbutton.get_node("name").text = item.name
			newbutton.get_node("icon").texture = item.icon
			newbutton.get_node("price").text = str(item.price)
			newbutton.set_meta('type', type)
			newbutton.set_meta('item', item.name)
			newbutton.set_meta('exploration', true) #while not reqired as it is now
			newbutton.visible = (
				(newbutton.get_meta("type") == buy_category)
				|| buy_category == "all"
			)
			globals.connecttempitemtooltip(newbutton, item, 'geartemplate')
			newbutton.connect('pressed', self, "item_purchase", [item, amount])
			if amount > 0:#can 'amount' be -1?
				newbutton.get_node("amount").text = str(amount)
				newbutton.get_node("amount").show()


var purchase_item


func item_purchase(item, amount):
	for btn in $AreaShop/SellBlock/ScrollContainer/VBoxContainer.get_children():
		btn.pressed = false
	for btn in $AreaShop/BuyBlock/ScrollContainer/VBoxContainer.get_children():
		if !btn.has_meta("item"):
			continue
		btn.pressed = btn.get_meta("item") == item.name
	purchase_item = item
	if amount < 0:
		amount = 100
	var price = 0
	var icon = null
	if typeof(item) == TYPE_OBJECT:
		price = item.calculateprice()
	else:
		price = item.price
	$AreaShop/NumberSelection.open(
		self,
		'item_puchase_confirm',
		tr("BUY") + " " + str(item.name),
		price,
		1,
		amount,
		true,
		item.icon,
		item
	)



func item_puchase_confirm(value):
	input_handler.PlaySound("money_spend")
	if typeof(purchase_item) == TYPE_OBJECT:
		globals.AddItemToInventory(purchase_item)
		ResourceScripts.game_res.money -= purchase_item.calculateprice()
		input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
		for i in active_shop:
			if !(active_shop[i] is Array):#for only parts-type items are checked here
				continue
			var to_erase
			for j in range(active_shop[i].size()):
				if globals.check_shop_record(purchase_item, i, active_shop[i][j]):
					to_erase = j
					break
			if to_erase == null:
				continue
			active_shop[i].remove(to_erase)
			if active_shop[i].empty():
				active_shop.erase(i)
			break
		update_sell_list()
		update_buy_list()
	else:
		ResourceScripts.game_res.money -= purchase_item.price * value
		active_shop[purchase_item.code] -= value
		if Items.materiallist.has(purchase_item.code):
			ResourceScripts.game_res.set_material(purchase_item.code, '+', value)
		elif Items.itemlist.has(purchase_item.code):
			while value > 0:
				match purchase_item.type:
					'usable':
						globals.AddItemToInventory(globals.CreateUsableItem(purchase_item.code))
					'gear':
						globals.AddItemToInventory(globals.CreateGearItemShop(purchase_item.code, {}))
				value -= 1
		update_sell_list()
		update_buy_list()



func item_sell(item):
	for btn in $AreaShop/BuyBlock/ScrollContainer/VBoxContainer.get_children():
		btn.pressed = false
	for btn in $AreaShop/SellBlock/ScrollContainer/VBoxContainer.get_children():
		if !btn.has_meta("item"):
			continue
		btn.pressed = btn.get_meta("item") == item.name
	purchase_item = item
	var price
	if item.price:
		price = ceil(item.price * variables.material_sell_multiplier)
	else:
		price = ceil(item.calculateprice() * variables.item_sell_multiplier)
	var sellingamount
	if ! Items.materiallist.has(item.code):
		price = ceil(item.calculateprice() * variables.item_sell_multiplier)
		sellingamount = item.amount
	else:
		sellingamount = ResourceScripts.game_res.materials[item.code]
	$AreaShop/NumberSelection.open(
		self,
		'item_sell_confirm',
		tr("SELL") + " " + str(item.name),
		price,
		1,
		sellingamount,
		false,
		item.icon,
		item
	)


func item_sell_confirm(value):
	input_handler.PlaySound("money_spend")
	var price
	if purchase_item.price:
		price = ceil(purchase_item.price * variables.material_sell_multiplier) 
	else:
		price = ceil(purchase_item.calculateprice() * variables.item_sell_multiplier)
	
	if Items.materiallist.has(purchase_item.code):
		ResourceScripts.game_res.set_material(purchase_item.code, '-', value)
	else:
		price = ceil(purchase_item.calculateprice() * variables.item_sell_multiplier)
		purchase_item.amount -= value
	ResourceScripts.game_res.money += price * value
	update_sell_list()
	update_buy_list()


func quest_board(pressed, pressed_button):
	gui_controller.win_btn_connections_handler(pressed, $QuestBoard, pressed_button)
	self.current_pressed_area_btn = pressed_button
	$QuestBoard.selectcategory($QuestBoard/guildsortVScroll/all)
	if pressed:
		unfade($QuestBoard)
	else:
		fade($QuestBoard)


func change_texture(button, state):
	match state:
		"in":
			button.texture_normal = load(
				"res://assets/Textures_v2/CITY/Universal/paper_small_active.png"
			)
		"out":
			button.texture_normal = load("res://assets/Textures_v2/CITY/Universal/paper_small.png")


func location_purchase(pressed, pressed_button):
	$BuyLocation/LocationInfo.hide()
	self.current_pressed_area_btn = pressed_button
	gui_controller.win_btn_connections_handler(pressed, $BuyLocation, pressed_button)
	input_handler.ClearContainer($BuyLocation/ScrollContainer/VBoxContainer)
	for i in DungeonData.dungeons.values():
		if i.type != 'dungeon' || i.tags.has('quest'):
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($BuyLocation/ScrollContainer/VBoxContainer)
		newbutton.set_meta("location_name", i.name)
		newbutton.connect("pressed", self, "show_location_info", [i])
		newbutton.text = str(i.classname)
	if pressed:
		unfade($BuyLocation)
	else:
		fade($BuyLocation)

func show_location_info(location):
	purchasing_location = location
	$BuyLocation/LocationInfo.show()
	$BuyLocation/LocationInfo/LocationName.text = location.classname
	$BuyLocation/LocationInfo/Difficulty.text = "Difficulty: " + str(location.difficulty).capitalize()
	$BuyLocation/LocationInfo/Price.text = str(location.purchase_price)
	input_handler.ClearContainer($BuyLocation/LocationInfo/Resources/GridContainer)
	for i in location.gatherable_resources.pool:
		var item = Items.materiallist[i]
		var newbutton = input_handler.DuplicateContainerTemplate($BuyLocation/LocationInfo/Resources/GridContainer)
		newbutton.get_node("TextureRect").texture = Items.materiallist[i].icon
		globals.connectmaterialtooltip(newbutton, item)
	$BuyLocation/LocationInfo/PurchaseLocation.disabled = location.purchase_price > ResourceScripts.game_res.money
	update_location_shop_btn(location.name)


func update_location_shop_btn(location_name):
	for btn in $BuyLocation/ScrollContainer/VBoxContainer.get_children():
		if !btn.has_meta("location_name"):
			continue
		btn.pressed = btn.get_meta("location_name") == location_name


var purchasing_location

func purchase_location():
#	var active_area 
#	var active_location 
	if purchasing_location.has('purchase_area'):
		input_handler.selected_area = ResourceScripts.game_world.areas[purchasing_location.purchase_area]
	if input_handler.selected_area.locations.size() < 8:
		var randomlocation = []
		for i in input_handler.selected_area.locationpool:
			randomlocation.append(DungeonData.dungeons[i].code)
		randomlocation = ResourceScripts.world_gen.make_location(
			purchasing_location.code, input_handler.selected_area
		)
		input_handler.selected_location = randomlocation
#		input_handler.active_area = active_area
		input_handler.selected_area.locations[randomlocation.id] = randomlocation
		ResourceScripts.game_world.location_links[randomlocation.id] = {
			area = input_handler.selected_area.code, category = 'locations'
		}
		ResourceScripts.game_res.money -= purchasing_location.purchase_price
		input_handler.interactive_message(
			'purchase_dungeon_location', 'location_purchase_event', {}
		)
	else:
		input_handler.SystemMessage("Can't purchase anymore")
	location_purchase(true, current_pressed_area_btn)


var current_pressed_area_btn setget set_area_btn_pressed


func set_area_btn_pressed(value):
	if !is_instance_valid(current_pressed_area_btn):
		current_pressed_area_btn = value
		return
	if value != current_pressed_area_btn:
		current_pressed_area_btn.pressed = false
		current_pressed_area_btn = value


func update_guild_buttons(guild_name):
	for button in GuildPanelContainer.get_children():
		if ! button.has_meta("guild_name"):
			continue
		button.pressed = button.get_meta("guild_name") == guild_name


func reset_active_location(arg = null):
	if input_handler.active_location.id != selected_location:
		input_handler.active_location = ResourceScripts.world_gen.get_location_from_code(selected_location)


func add_rolled_chars(tarr):
	return
