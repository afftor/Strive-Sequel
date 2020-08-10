extends Control

onready var City = $ExploreCityModule
onready var Navigation = $NavigationModule
onready var Hire = $ExploreHireModule
onready var QuestBoard = $QuestBoardModule
onready var Shop = $ExploreShopModule
onready var Upgrades = $StatUpgradeModule
onready var FactionDetails = $FactionDetailsModule
onready var FullSlaveInfo = $ExploreFullSlaveModule
onready var StatUpgradeWindow = $StatUpgradeModule
onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)

const BUTTON_HEIGHT = 58

var selected_location
var shopcategory
var active_shop
var selectedquest
var active_area
var active_faction
var active_location
var action_type
var person_to_hire
var current_level = 1 #should get rid of eventually
var current_stage = 0 #should get rid of eventually
var submodules = []
var dialogue_opened = false
var city_options = {
	location_purchase = "Buy Dungeon",
	quest_board = "Notice Board",
}
var positiondict = {
	1: "LocationGui/Positions/HBoxContainer/frontrow/1",
	2: "LocationGui/Positions/HBoxContainer/frontrow/2",
	3: "LocationGui/Positions/HBoxContainer/frontrow/3",
	4: "LocationGui/Positions/HBoxContainer/backrow/4",
	5: "LocationGui/Positions/HBoxContainer/backrow/5",
	6: "LocationGui/Positions/HBoxContainer/backrow/6",
}

var faction_actions = {
	hire = 'Hire',
	sellslaves = "Sell Characters",
	quests = 'Quests',
	upgrade = "Upgrades",
	services = "Service",
}


func _ready():
	input_handler.exploration_node = self
	$Stat.connect("ready", $StatUpgradeModule, "show")
	FactionDetails.get_node("QuestGen").connect("pressed", self, "show_quest_gen")
	FactionDetails.get_node("QuestGenPanel/Apply").connect("pressed", self, "show_quest_gen", ["hide"])
	FactionDetails.get_node("QuestGenPanel").hide()

	for i in FactionDetails.get_node("QuestGenPanel/HBoxContainer").get_children():
		i.get_node("up").connect("pressed", self, "details_quest_up", [i.name])
		i.get_node("down").connect("pressed", self, "details_quest_down", [i.name])
		
	for i in positiondict:
		get_node(positiondict[i]).metadata = i
		get_node(positiondict[i]).target_node = self
		get_node(positiondict[i]).target_function = 'slave_position_selected'

	$LocationGui.target_node = self
	$LocationGui.target_function = 'slave_position_deselect'
	$LocationGui/PresentedSlavesPanel/ScrollContainer.target_node = self
	$LocationGui/PresentedSlavesPanel/ScrollContainer.target_function = 'slave_position_deselect'
	$LocationGui/ItemUsePanel/Button.connect("pressed", self, "switch_panel")

func show_quest_gen(action = "show"):
	if action == "show":
		FactionDetails.get_node("QuestGenPanel").visible = FactionDetails.get_node("QuestGen").is_pressed()
	else:
		FactionDetails.get_node("QuestGenPanel").hide()
		FactionDetails.get_node("QuestGen").pressed = false

func clear_submodules():
	for module in submodules:
		module.hide()
	submodules.clear()

func ShowSlavePanel(person):
	var dialogue = input_handler.get_spec_node(input_handler.NODE_DIALOGUE)#get_tree().get_root().get_node("dialogue")
	if dialogue.is_visible():
		dialogue_opened = true
		dialogue.hide()
	FullSlaveInfo.show()
	FullSlaveInfo.show_summary(person)

func update():
	var dialogue = input_handler.get_spec_node(input_handler.NODE_DIALOGUE)#get_tree().get_root().get_node("dialogue")
	if dialogue_opened && !FullSlaveInfo.is_visible():
		dialogue.show()
		dialogue_opened = false
	Navigation.visible = !FullSlaveInfo.is_visible()




func open():
	# input_handler.CloseAllCloseableWindows()
	Navigation.build_accessible_locations()
	selected_location = GUIWorld.gui_data["MANSION"].main_module.selected_location
	var location = ResourceScripts.world_gen.get_location_from_code(selected_location)
	Navigation.select_location(selected_location)
	


func local_shop():
	Shop.open_shop('location')

func open_location(data):
	input_handler.StopBackgroundSound()
	$LocationGui.show()
	City.hide()
	Hire.hide()
#	$ServicePanel.hide()
	QuestBoard.hide()
	Shop.hide()
#	$FactionDetailsPanel.hide()
#	$SlaveSelectionPanel.hide()
	active_location = data
	active_area = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[data.id].area]
	input_handler.active_area = active_area
	input_handler.active_location = active_location
	if active_location.has('progress'):
		current_level = active_location.progress.level
		current_stage = active_location.progress.stage

	if active_location.has('background'):
		$LocationGui/Image/TextureRect.texture = images.backgrounds[active_location.background]
	if active_location.has('bgm'):
		input_handler.SetMusic(active_location.bgm)

	input_handler.ActivateTutorial("exploration")

	#check if anyone is present
	build_location_group()
	var presented_characters = []
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		if i.travel.area == active_area.code && i.check_location(active_location.id, true):
			presented_characters.append(i)
	if presented_characters.size() > 0 || variables.allow_remote_intereaction == true:
		open_location_actions()
	build_location_description()


func build_location_group():
	#clear_groups()
	for i in positiondict:
		if (
			active_location.group.has('pos' + str(i))
			&& (
				ResourceScripts.game_party.characters.has(active_location.group['pos' + str(i)])
				== false
			)
		):
			active_location.group.erase('pos' + str(i))
			get_node(positiondict[i] + "/Image").dragdata = null
			get_node(positiondict[i] + "/Image").texture = null
			get_node(positiondict[i] + "/Image").hide()
			get_node(positiondict[i]).self_modulate.a = 1
			get_node(positiondict[i]).character = null
			continue
		if (
			active_location.group.has('pos' + str(i))
			&& ResourceScripts.game_party.characters[active_location.group['pos' + str(i)]] != null
			&& ResourceScripts.game_party.characters[active_location.group['pos' + str(i)]].check_location(
				active_location.id
			)
		):
			var character = ResourceScripts.game_party.characters[active_location.group[(
				'pos'
				+ str(i)
			)]]
			get_node(positiondict[i] + "/Image").texture = character.get_icon()
			if get_node(positiondict[i] + "/Image").texture == null:
				if character.has_profession('master'):
					get_node(positiondict[i] + "/Image").texture = images.icons.class_master
				elif character.get_stat('slave_class') == 'servant':
					get_node(positiondict[i] + "/Image").texture = images.icons.class_servant
				else:
					get_node(positiondict[i] + "/Image").texture = images.icons.class_slave
			get_node(positiondict[i] + "/Image").show()
			get_node(positiondict[i] + "/Image/TextureRect").hint_tooltip = (
				"HP: "
				+ str(floor(character.hp))
				+ '/'
				+ str(floor(character.get_stat('hpmax')))
				+ "\nMP: "
				+ str(floor(character.mp))
				+ '/'
				+ str(floor(character.get_stat('mpmax')))
			)
			get_node(positiondict[i] + "/Image/TextureRect/hp").max_value = character.get_stat(
				'hpmax'
			)
			get_node(positiondict[i] + "/Image/TextureRect/hp").value = character.hp
			get_node(positiondict[i] + "/Image/TextureRect/mp").max_value = character.get_stat(
				'mpmax'
			)
			get_node(positiondict[i] + "/Image/TextureRect/mp").value = character.mp

			get_node(positiondict[i] + "/Image").dragdata = character
			get_node(positiondict[i] + "/Image/Label").text = character.get_short_name()
			get_node(positiondict[i]).self_modulate.a = 0
			get_node(positiondict[i]).character = character
		else:
			get_node(positiondict[i] + "/Image").dragdata = null
			get_node(positiondict[i] + "/Image").texture = null
			get_node(positiondict[i] + "/Image").hide()
			get_node(positiondict[i]).self_modulate.a = 1
			get_node(positiondict[i]).character = null
	var newbutton
	input_handler.ClearContainer($LocationGui/PresentedSlavesPanel/ScrollContainer/VBoxContainer)
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		if i.check_location(active_location.id, true):
			newbutton = input_handler.DuplicateContainerTemplate(
				$LocationGui/PresentedSlavesPanel/ScrollContainer/VBoxContainer
			)
			newbutton.dragdata = i
			newbutton.get_node("icon").texture = i.get_icon()
			if newbutton.get_node('icon').texture == null:
				if i.has_profession('master'):
					newbutton.get_node('icon').texture = images.icons.class_master
				elif i.get_stat('slave_class') == 'servant':
					newbutton.get_node('icon').texture = images.icons.class_servant
				else:
					newbutton.get_node('icon').texture = images.icons.class_slave
			newbutton.get_node("Label").text = i.get_short_name()
			newbutton.connect("pressed", self, "return_character", [i])
			if active_location.group.values().has(i.id):
				newbutton.get_node("icon").modulate = Color(0.3, 0.3, 0.3)
			globals.connectslavetooltip(newbutton, i)

	build_item_panel()
	build_spell_panel()


func build_location_description():
	var text = ''
	match active_location.type:
		'dungeon':
			text = (
				active_location.name
				+ " ("
				+ active_location.classname
				+ ")\n"
				+ tr("DUNGEONDIFFICULTY")
				+ ": "
				+ tr("DUNGEONDIFFICULTY" + active_location.difficulty.to_upper())
			)
			if active_location.completed == false:
				text += "\nProgress: Levels - " + str(current_level) + "/" +str(active_location.levels.size()) + ", "
				text += "Stage - " + str(active_location.progress.stage)
			else:
				text += "\n{color=aqua|Location complete}"
		'settlement':
			text = tr(active_location.classname) + ": " + active_location.name
		'skirmish':
			pass
		'quest_location':
			text = active_location.name + "\n" + active_location.descript
	$LocationGui/Image/RichTextLabel.bbcode_text = '[center]' + globals.TextEncoder(text) + "[/center]"


func open_location_actions():
	input_handler.ClearContainer($LocationGui/ScrollContainer/VBoxContainer)
	var newbutton
	match active_location.type:
		'dungeon':
			enter_dungeon()
		'settlement':
			for i in active_location.actions:
				newbutton = input_handler.DuplicateContainerTemplate(
					$LocationGui/ScrollContainer/VBoxContainer
				)
				newbutton.text = tr(i.to_upper())
				newbutton.connect("pressed", self, i)
		'encounter':
			for i in active_location.options:
				if globals.checkreqs(i.reqs) == true:
					newbutton = input_handler.DuplicateContainerTemplate(
						$LocationGui/ScrollContainer/VBoxContainer
					)
					newbutton.text = tr(i.text)
					newbutton.connect("pressed", globals, 'common_effects', [i.args])
		'quest_location':
			for i in active_location.options:
				if globals.checkreqs(i.reqs) == true:
					newbutton = input_handler.DuplicateContainerTemplate(
						$LocationGui/ScrollContainer/VBoxContainer
					)
					newbutton.text = tr(i.text)
					newbutton.connect("pressed", globals, 'common_effects', [i.args])


func build_item_panel():
	input_handler.ClearContainer($LocationGui/ItemUsePanel/ScrollContainer/VBoxContainer)
	var tutorial_items = false
	for i in ResourceScripts.game_res.items.values():
		if Items.itemlist[i.itembase].has('explor_effect') == false:
			continue
		var newnode = input_handler.DuplicateContainerTemplate(
			$LocationGui/ItemUsePanel/ScrollContainer/VBoxContainer
		)
		i.set_icon(newnode.get_node("Icon"))
		#newnode.get_node("Label").text = i.name
		newnode.get_node("amount").text = str(i.amount)
		newnode.dragdata = i
		globals.connectitemtooltip(newnode, i)
		tutorial_items = true
	if tutorial_items == true:
		input_handler.ActivateTutorial("exploration_items")


func build_spell_panel():
	input_handler.ClearContainer($LocationGui/ItemUsePanel/SpellContainer/VBoxContainer)
	for id in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[id]
		if person.check_location(active_location.id, true):
			for i in person.skills.combat_skills:
				var skill = Skilldata.Skilllist[i]
				if skill.tags.has('exploration') == false:
					continue
				var newnode = input_handler.DuplicateContainerTemplate(
					$LocationGui/ItemUsePanel/SpellContainer/VBoxContainer
				)
				newnode.get_node('Icon').texture = skill.icon
				newnode.get_node("name").text = skill.name
				newnode.get_node("castername").text = person.get_short_name()
				var text = skill.descript
				var disabled = false
				if skill.manacost > 0:
					text += (
						"\n\nMana cost: "
						+ str(skill.manacost)
						+ " ("
						+ str(floor(person.mp))
						+ ")"
					)
				if skill.catalysts.empty() == false:
					text += '\n\nRequired Catalysts: '
					for k in skill.catalysts:
						text += (
							"\n"
							+ Items.materiallist[k].name
							+ ": "
							+ str(skill.catalysts[k])
							+ " ("
							+ str(ResourceScripts.game_res.materials[k])
							+ ")"
						)
						if ResourceScripts.game_res.materials[k] < skill.catalysts[k]:
							disabled = true
				globals.connecttexttooltip(newnode, text)
				newnode.dragdata = {skill = skill, caster = person}
				if person.mp < skill.manacost:
					disabled = true

				if disabled == true:
					newnode.get_node("name").set("custom_colors/font_color", Color(1, 0.5, 0.5))
					newnode.script = null



func clear_dungeon():
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'clear_dungeon_confirm', "Forget this location? All present characters will be sent back to Mansion. This action can't be undone."])

func clear_dungeon_confirm():
	globals.remove_location(active_location.id)
	action_type = 'location_finish'

func use_item_on_character(character, item):
	item.use_explore(character)#item.use_explore(state.characters[active_location.group['pos'+str(position)]])
	item.amount -= 1
	#show_heal_items(position)
	build_location_group()

func check_events(action):
	return globals.check_events(action)


var hiremode = ''


func faction_hire():
	submodules.append(Hire)
	Hire.hire()


func faction_sellslaves():
	Hire.sell_slave()


var infotext = "Upgrades effects and quest settings update after some time passed. "


func faction_upgrade():
	submodules.append($FactionDetailsModule)
	var guild_buttons = City.get_node("GuildMenu/VBoxContainer").get_children()
	for button in guild_buttons:
		if button.name == "Button":
			continue
		if !button.has_meta("action"):
			continue
		if button.get_meta("action") != "Upgrades":
			continue
		else:
			$FactionDetailsModule.visible = button.is_pressed()
	var text = ''
	# $FactionDetailsModule.show()
	input_handler.ClearContainer($FactionDetailsModule/VBoxContainer)
	text = infotext
	$FactionDetailsModule/RichTextLabel.text = text
	$FactionDetailsModule/FactionPoints.text = 	"Faction points: " + str(active_faction.totalreputation)
	$FactionDetailsModule/UnspentPoints.text = 	"Unspent points: " + str(active_faction.reputation)

	for i in active_faction.questsetting:
		if i == 'total':
			continue
		$FactionDetailsModule/QuestGenPanel/HBoxContainer.get_node(i + "/counter").text = str(
			active_faction.questsetting[i]
		)

	$FactionDetailsModule/QuestGenPanel/totalquestpoints.text = (
		"Total quests: "
		+ str(
			(
				active_faction.questsetting.total
				- (
					active_faction.questsetting.easy
					+ active_faction.questsetting.medium
					+ active_faction.questsetting.hard
				)
			)
		)
		+ "/"
		+ str(active_faction.questsetting.total)
	)

	for i in worlddata.guild_upgrades.values():
		var newnode = input_handler.DuplicateContainerTemplate($FactionDetailsModule/VBoxContainer)
		text = i.name + ": " + i.descript
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
			newnode.get_node("confirm").hide()

		newnode.get_node("text").bbcode_text = text
		newnode.get_node("Price").text = "Price: " + str(i.cost[currentupgradelevel]) + " faction points."
		newnode.get_node("confirm").connect('pressed', self, "unlock_upgrade", [i, currentupgradelevel]
		)


var service_actions = {
	enslave = {
		code = 'enslave',
		text = 'SERVICEENSLAVE',
		descript = 'SERVICEENSLAVEDESCRIPT',
		function = 'enslave',
		reqs = [{type = 'has_money', value = variables.enslavement_price}],
		costvalue = variables.enslavement_price
	},
}


func faction_services():
	$ServicePanel.show()
	input_handler.ClearContainer($ServicePanel/VBoxContainer)
	for i in service_actions.values():
		var newbutton = input_handler.DuplicateContainerTemplate($ServicePanel/VBoxContainer)
		newbutton.text = tr(i.text)
		newbutton.connect("pressed", self, i.function)
		newbutton.get_node("Label").text = str(i.costvalue)
		globals.connecttexttooltip(newbutton, tr(i.descript))


func unlock_upgrade(upgrade, level):
	if active_faction.upgrades.has(upgrade.code):
		active_faction.upgrades[upgrade.code] += 1
	else:
		active_faction.upgrades[upgrade.code] = 1
	active_faction.reputation -= upgrade.cost[level]
	var effect = upgrade.effects
	for i in effect:
		var value = get_indexed('active_faction:' + i.code)
		value = input_handler.math(i.operant, value, i.value)
		set_indexed('active_faction:' + i.code, value)
	faction_upgrade()



func enter_dungeon():
	check_events('enter')
	build_location_group()
	build_location_description()
	current_level = active_location.progress.level
	current_stage = active_location.progress.stage
#	print(current_level, " ", current_stage)
#	print(active_location.levels.size(), active_location.levels["L"+str(active_location.levels.size())].stages)
	
	var is_last_level = active_location.progress.level >= active_location.levels.size() && active_location.progress.stage >= active_location.levels["L"+str(active_location.levels.size())].stages
	
	input_handler.ClearContainer($LocationGui/ScrollContainer/VBoxContainer)
	var newbutton
	if !is_last_level:
		newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
		newbutton.text = 'Advance'
		newbutton.connect("pressed",self,"area_advance",['advance'])
		if variables.allow_skip_fights:
			newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
			newbutton.text = 'Skip to last room'
			newbutton.connect("pressed",self,"skip_to_boss")
	else:
		newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
		newbutton.text = 'Forget Location'
		newbutton.connect("pressed",self,"clear_dungeon")

func skip_to_boss():
	current_level = active_location.levels.size()
	active_location.progress.level = current_level
	current_stage = active_location.levels["L" + str(active_location.levels.size())].stages-1
	active_location.progress.stage = current_stage
	enter_dungeon()


func check_dungeon_end():
	return current_stage >= active_location.levels["L"+str(current_level)].stages && current_level >= active_location.levels.size()

func area_advance(mode):
	if globals.check_location_group() == false:
		input_handler.SystemMessage("Select at least 1 character before advancing. ")
		return
	match mode:
		'advance':
			current_stage = active_location.progress.stage
		'roam':
			current_stage = 0
	if check_events(mode) == true:
		yield(input_handler, 'EventFinished')
	
	action_type = mode
	
	StartCombat()



func enter_level(level, skip_to_end = false):
	current_level = level
	if skip_to_end == true:
		current_level = active_location.levels.size()
		active_location.progress.level = current_level
		current_stage = active_location.levels["L" + str(active_location.levels.size())].stages-1
		active_location.progress.stage = current_stage
	if active_location.progress.level < level:
		active_location.progress.level = level
		active_location.progress.stage = 0
	
	if check_events('enter_level') == true:
		yield(input_handler, 'EventFinished')
	
	input_handler.ClearContainer($LocationGui/ScrollContainer/VBoxContainer)
	var newbutton
	if active_location.progress.level == level && active_location.progress.stage < active_location.levels["L"+str(level)].stages:
		newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
		newbutton.text = 'Advance'
		newbutton.connect("pressed",self,"area_advance",['advance'])
	elif active_location.progress.level == level && active_location.progress.stage >= active_location.levels["L"+str(level)].stages:
		if active_location.levels.has("L"+str(level + 1)) == true:
			newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
			newbutton.text = 'Move to the next level'
			newbutton.connect("pressed",self,"enter_level",[level+1])
		else:
			newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
			newbutton.text = 'Forget Location'
			newbutton.connect("pressed",self,"clear_dungeon")
	
	if variables.allow_skip_fights:
		newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
		newbutton.text = 'Skip to last room'
		newbutton.connect("pressed",self,"enter_level", [level, true])
	
#	newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
#	newbutton.text = 'Roam'
#	newbutton.connect("pressed",self,"area_advance",['roam'])
	
	newbutton = input_handler.DuplicateContainerTemplate($LocationGui/ScrollContainer/VBoxContainer)
	newbutton.text = 'Return'
	newbutton.connect("pressed",self,"enter_dungeon")
	build_location_group()
	build_location_description()


func finish_combat():
	
	if action_type == 'advance' && check_dungeon_end() == false:
		active_location.progress.stage += 1
		current_stage = active_location.progress.stage
		if active_location.progress.stage > active_location.levels["L"+str(current_level)].stages:
			active_location.progress.stage = 0
			active_location.progress.level += 1
			current_stage = active_location.progress.stage
			current_level = active_location.progress.level
		if check_dungeon_end() == false:
			if active_location.has('scriptedevents') && globals.check_events("finish_combat") == true:
				yield(input_handler, 'EventFinished')
			if active_location.has('randomevents') && globals.check_random_event() == true:
				yield(input_handler, 'EventFinished')
		else:
			active_location.completed = true
			check_events("finish_combat")
			check_events("dungeon_complete")
		
		enter_dungeon()
	elif action_type == 'location_finish':
		Navigation.build_accessible_locations()
		Navigation.select_location("Aliron")
	else:
		enter_dungeon()


func StartCombat():
	globals.current_level = current_level
	globals.current_stage = current_stage
	globals.StartCombat()


func slave_position_selected(pos, character):
	pos = 'pos'+str(pos)
	if character == null:
		active_location.group.erase(pos)
		build_location_group()
		return
	character = character.id
	var positiontaken = false
	var oldheroposition = null
	if active_location.group.has(pos) && ResourceScripts.game_party.characters[active_location.group[pos]].check_location(active_location.id, true):
		positiontaken = true
	
	for i in active_location.group:
		if active_location.group[i] == character:
			oldheroposition = i
			active_location.group.erase(i)
	
	if oldheroposition != null && positiontaken == true && oldheroposition != pos:
		active_location.group[oldheroposition] = active_location.group[pos]
	
	active_location.group[pos] = character
	build_location_group()


func slave_position_deselect(character):
		for i in active_location.group:
			if active_location.group[i] == character.id:
				active_location.group.erase(i)
				break
		build_location_group()



func details_quest_up(difficulty):
	if active_faction.questsetting.total - (active_faction.questsetting.easy + active_faction.questsetting.medium + active_faction.questsetting.hard) > 0:
		active_faction.questsetting[difficulty] += 1
	faction_upgrade()

func details_quest_down(difficulty):
	if active_faction.questsetting[difficulty] > 0:
		active_faction.questsetting[difficulty] -= 1
	faction_upgrade()

var panelmode = 'items'
var panelmodes = {item = {name = "Items", code = 'items'}, spells = {name = 'Spells', code = 'spells'}}
var panelmodesarray = ['items','spells']

func switch_panel():
	match panelmode:
		'spells':
			$LocationGui/ItemUsePanel/Button.text = panelmodes.item.name
			$LocationGui/ItemUsePanel/ScrollContainer.show()
			$LocationGui/ItemUsePanel/SpellContainer.hide()
			panelmode = 'items'
		'items':
			$LocationGui/ItemUsePanel/Button.text = panelmodes.spells.name
			$LocationGui/ItemUsePanel/ScrollContainer.hide()
			$LocationGui/ItemUsePanel/SpellContainer.show()
			panelmode = 'spells'
