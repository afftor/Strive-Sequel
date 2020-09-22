extends Control

# GUI Blocks
onready var GuildPanelContainer = $NavigationModule/GuildsPanel/GuildsPanelContainer/GuildSelection
onready var AreaActions = $AreaMenu/ScrollContainer/VBoxContainer
onready var SlaveMarketList = $SlaveMarket/SlaveList/ScrollContainer/VBoxContainer
onready var nav = $NavigationModule

var active_area
var active_faction
var active_location

var selected_location

var market_mode
var hiremode
var person_to_hire
var selectedquest

var city_options = {
	location_purchase = "Buy Dungeon",
	quest_board = "Notice Board",
}

var faction_actions = {
	hire = 'Hire',
	sellslaves = "Sell Characters",
	quests = 'Quests',
	upgrade = "Upgrades",
	services = "Service",
	guild_shop = "Guild Shop"
}

var positiondict = {
	1: "LocationGui/Positions/HBoxContainer/frontrow/1",
	2: "LocationGui/Positions/HBoxContainer/frontrow/2",
	3: "LocationGui/Positions/HBoxContainer/frontrow/3",
	4: "LocationGui/Positions/HBoxContainer/backrow/4",
	5: "LocationGui/Positions/HBoxContainer/backrow/5",
	6: "LocationGui/Positions/HBoxContainer/backrow/6",
}


func _ready():
	# ResourceScripts.game_world.make_world()
	# open_city("aliron")
	$FactionDetails.get_node("QuestGen").connect("pressed", self, "show_quest_gen")
	$FactionDetails.get_node("QuestGenPanel/Apply").connect(
		"pressed", self, "show_quest_gen", ["hide"]
	)
	$FactionDetails.get_node("QuestGenPanel").hide()

	for i in $FactionDetails.get_node("QuestGenPanel/HBoxContainer").get_children():
		i.get_node("up").connect("pressed", self, "details_quest_up", [i.name])
		i.get_node("down").connect("pressed", self, "details_quest_down", [i.name])
	$QuestBoard/QuestDetails/AcceptQuest.connect("pressed", self, "accept_quest")
	$SlaveMarket/PurchaseButton.connect("pressed", self, "show_full_info")
	$SlaveMarket/HireMode.connect("pressed", self, "change_mode", ["hire"])
	$SlaveMarket/SellMode.connect("pressed", self, "change_mode", ["sell"])
	$SlaveMarket/HBoxContainer/EnslaveButton.connect("pressed", self, "enslave_select")
	$SlaveMarket/HBoxContainer/UpgradeButton.connect("pressed", self, "show_upgrade_window")
	for i in $AreaShop/SellFilter.get_children():
		i.connect('pressed', self, 'selectcategory', [i, "sell"])
	for i in $AreaShop/BuyFilter.get_children():
		i.connect('pressed', self, 'selectcategory', [i, "buy"])

	for i in positiondict:
		get_node(positiondict[i]).metadata = i
		get_node(positiondict[i]).target_node = self
		get_node(positiondict[i]).target_function = 'slave_position_selected'

	$LocationGui.target_node = self
	$LocationGui.target_function = 'slave_position_deselect'
	$LocationGui/PresentedSlavesPanel/ScrollContainer.target_node = self
	$LocationGui/PresentedSlavesPanel/ScrollContainer.target_function = 'slave_position_deselect'
	$LocationGui/ItemUsePanel/ItemsButton.connect("pressed", self, "switch_panel", ["items"])
	$LocationGui/ItemUsePanel/SpellsButton.connect("pressed", self, "switch_panel", ["spells"])
	$LocationGui/ItemUsePanel/ItemsButton.pressed = true
	$LocationGui/Resources/SelectWorkers.connect("pressed", self, "select_workers")
	$LocationGui/Resources/SelectWorkers.connect("pressed", self, "select_workers")
	$LocationGui/PresentedSlavesPanel/ReturnAll.connect("pressed", self, "return_all_to_mansion")
	$BuyLocation/LocationInfo/PurchaseLocation.connect("pressed", self, "purchase_location")
	$TestButton.connect("pressed", self, "test")
	$TestButton.visible = gui_controller.mansion.test_mode
	$JournalButton.connect("toggled", self, "open_journal")
	gui_controller.win_btn_connections_handler(true, $MansionJournalModule, $JournalButton)
	gui_controller.windows_opened.clear()
	globals.connect("hour_tick", self, "build_location_group")
	input_handler.connect("EventFinished", self, 'build_location_group')

func test():
	for win in gui_controller.windows_opened:
		print(win.name)


func open_journal(pressed):
	if pressed:
		ResourceScripts.core_animations.UnfadeAnimation($MansionJournalModule, 0.5)
	else:
		ResourceScripts.core_animations.FadeAnimation($MansionJournalModule, 0.5)
		yield(get_tree().create_timer(0.5), "timeout")
	$MansionJournalModule.visible = pressed
	$MansionJournalModule.open()
	gui_controller.windows_opened.append($MansionJournalModule) if pressed else gui_controller.windows_opened.erase($MansionJournalModule)


func open(location):
	selected_location = location
	# $NavigationModule.build_accessible_locations()
	# $NavigationModule.update_buttons()
	input_handler.exploration_node = self
	# var loca = ResourceScripts.world_gen.get_location_from_code(selected_location)
	# if loca.type == "capital":
	# 	open_city(selected_location)


func open_city(city):
	gui_controller.nav_panel = $NavigationModule
	gui_controller.nav_panel.build_accessible_locations()
	gui_controller.nav_panel.update_buttons()
	active_area = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[city].area]
	self.current_pressed_area_btn = null

	$LocationGui.hide()
	if active_area.has('capital_background_noise'):
		input_handler.PlayBackgroundSound(active_area.capital_background_noise)
	if active_area.has('capital_background_music'):
		input_handler.SetMusic(active_area.capital_background_music)
	if active_area.has("capital_dynamic_background"):
		get_node("VideoPlayer").open(active_area.capital_dynamic_background)
	previous_guild = ''
	input_handler.active_area = active_area
	selected_location = city
	var guilds = []
	var area_actions = []
	for i in active_area.factions.values():
		if i.code in ["slavemarket", "exotic_slave_trader", "aliron_church"]:
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
	for guild in guilds:
		counter += 1
		var newseparator = $NavigationModule/GuildsPanel/VSeparator.duplicate()
		newbutton = input_handler.DuplicateContainerTemplate(GuildPanelContainer)
		newbutton.text = guild.name
		newbutton.connect("pressed", self, "enter_guild", [guild])
		newbutton.set_meta("guild_name", guild.name)
		GuildPanelContainer.add_child(newseparator)
		newseparator.visible = counter != guilds.size()


func build_area_menu(area_actions):
	input_handler.ClearContainer(AreaActions)
	var newbutton
	for option in active_area.capital_options:
		newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
		newbutton.get_node("Label").text = city_options[option]
		newbutton.connect("toggled", self, option, [newbutton])
	for action in area_actions:
		if action.code == "slavemarket":
			newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
			newbutton.connect("toggled", self, "faction_hire", [newbutton, action, "city_slaves"])
		elif (
			action.code == 'exotic_slave_trader'
			&& int(ResourceScripts.game_globals.date) % 7 == 0
			&& int(ResourceScripts.game_globals.date) % 14 != 0
			&& ResourceScripts.game_globals.hour >= 6
			&& ResourceScripts.game_globals.hour <= 20
		):
			newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
			newbutton.connect("toggled", self, "faction_hire", [newbutton, action])
		elif action.code == 'exotic_slave_trader':
			continue
		# elif action.code == 'aliron_church':
		# 	newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
		# 	newbutton.connect("pressed", self, "enter_church", [newbutton, action])
		# newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
		newbutton.get_node("Label").text = action.name
	newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
	newbutton.get_node("Label").text = "Shop"
	newbutton.connect("toggled", self, "open_shop", [newbutton, "area"])

	for i in active_area.events:
		if globals.checkreqs(i.reqs) == false:
			continue
		newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
		newbutton.get_node("Label").text = i.text
		if i.args.keys().has("oneshot") && !i.args.oneshot:
			newbutton.connect("pressed", input_handler, "interactive_message", [i.code, '', i.args])
		else:
			newbutton.connect("pressed", input_handler, "interactive_message", [i.code, 'area_oneshot_event', i.args])
			newbutton.connect("pressed", self, "open_city", [selected_location])
		# newbutton.modulate = Color(0.5, 0.8, 0.5)
		newbutton.texture_normal = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city.png")
		newbutton.texture_hover = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city_hover.png")
		newbutton.texture_pressed = load("res://assets/Textures_v2/CITY/Buttons/buttonbig_city_pressed.png")
		newbutton.get_node("Label").rect_position.x = 0
		newbutton.get_node("Label").rect_size.x = 272
		newbutton.get_node("Label").get("custom_fonts/font").set_size(24)
	


var current_level
var current_stage


func enter_church():
	print("I'm in church")


func open_location(data):
	input_handler.StopBackgroundSound()
	gui_controller.nav_panel = $LocationGui.get_node("NavigationModule")
	selected_location = data.id
	var gatherable_resources
	if data.type == "dungeon":
		$LocationGui.get_node("Resources/Forget").visible = data.completed
		$LocationGui.get_node("Resources/SelectWorkers").visible = data.completed
		gui_controller.clock.hide()
	else:
		$LocationGui.get_node("Resources/Forget").visible = false
		if data.type == "capital":
			return
		else:
			gui_controller.clock.hide()
			if data.has('gather_resources'):
				gatherable_resources = data.gather_resources
				$LocationGui.get_node("Resources/SelectWorkers").visible = true
			if gatherable_resources != null:
				var stop_loop = false
				for i in gatherable_resources:
					if stop_loop:
						break
					var item = Items.materiallist[i]
					var current_workers_count = 0
					var active_tasks = ResourceScripts.game_party.active_tasks
					if active_tasks == []:
						$LocationGui.get_node("Resources/SelectWorkers").visible = true
						break
					for task in active_tasks:
						if (task.code == i) && (task.task_location == selected_location):
							current_workers_count = task.workers_count
							if current_workers_count < gatherable_resources[i]:
								$LocationGui.get_node("Resources/SelectWorkers").visible = true
								stop_loop = true
								break
							else:
								$LocationGui.get_node("Resources/SelectWorkers").visible = false
	$LocationGui.show()
	$LocationGui.get_node("Resources/Materials").update()
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
	if data.type in ["quest_location", "encounter"]:
		$LocationGui/Resources/Forget.visible = false
		$LocationGui/Resources/SelectWorkers.visible = false
		$LocationGui/Resources/Label.visible = false
	else:
		$LocationGui/Resources/Label.visible = true
	gui_controller.nav_panel.build_accessible_locations()


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
				text += (
					"\nProgress: Levels - "
					+ str(current_level)
					+ "/"
					+ str(active_location.levels.size())
					+ ", "
				)
				text += "Stage - " + str(active_location.progress.stage)
			else:
				text += "\n{color=aqua|Location complete}"
		'settlement':
			text = tr(active_location.classname) + ": " + active_location.name
		'skirmish':
			pass
		'quest_location':
			text = active_location.name + "\n" + active_location.descript
	$LocationGui/DungeonInfo/RichTextLabel.bbcode_text = (
		'[center]'
		+ globals.TextEncoder(text)
		+ "[/center]"
	)


func slave_position_selected(pos, character):
	pos = 'pos' + str(pos)
	if character == null:
		active_location.group.erase(pos)
		build_location_group()
		return
	if character.has_status('no_combat'):
		input_handler.SystemMessage(
			character.translate(
				"[name] has sustained a grave injury and is unable to participate in fights."
			)
		)
		return
	elif (
		character.get_stat('obedience') <= 0
		and character.get_stat('loyalty') < 100
		and character.get_stat('submission') < 100
		and ! character.has_profession('master')
	):
		input_handler.SystemMessage(
			character.translate("[name] refuses to participate in a fight (low obedience).")
		)
		return
	character = character.id
	var positiontaken = false
	var oldheroposition = null
	if (
		active_location.group.has(pos)
		&& ResourceScripts.game_party.characters[active_location.group[pos]].check_location(
			active_location.id, true
		)
	):
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


func use_item_on_character(character, item):
	item.use_explore(character)  #item.use_explore(state.characters[active_location.group['pos'+str(position)]])
	item.amount -= 1
	#show_heal_items(position)
	build_location_group()


func use_e_combat_skill(caster, target, skill):
	caster.mp -= skill.manacost
	for i in skill.catalysts:
		ResourceScripts.game_res.materials[i] -= skill.catalysts[i]
	if skill.charges > 0:
		if caster.skills.combat_skill_charges.has(skill.code):
			caster.skills.combat_skill_charges[skill.code] += 1
		else:
			caster.skills.combat_skill_charges[skill.code] = 1
		caster.skills.daily_cooldowns[skill.code] = skill.cooldown
	var s_skill1 = ResourceScripts.scriptdict.class_sskill.new()
	s_skill1.createfromskill(skill.code)
	s_skill1.setup_caster(caster)
	#s_skill1.setup_target(target)
	s_skill1.process_event(variables.TR_CAST)
	caster.process_event(variables.TR_CAST, s_skill1)
	var targets
	for n in range(s_skill1.repeat):
		match skill.target_number:
			'single':
				targets = [target]
			'all':
				targets = input_handler.get_active_party()
		var s_skill2_list = []
		for i in targets:
			if skill.has('damage_type') and skill.damage_type == 'resurrect':
				i.resurrect(
					input_handler.calculate_number_from_string_array(skill.value[0], caster, target)
				)
			else:
				var s_skill2 = s_skill1.clone()
				s_skill2.setup_target(i)
				s_skill2.setup_final()
				s_skill2.hit_roll()
				s_skill2.resolve_value(true)
				s_skill2_list.push_back(s_skill2)
		for s_skill2 in s_skill2_list:
			s_skill2.process_event(variables.TR_HIT)
			s_skill2.caster.process_event(variables.TR_HIT, s_skill2)
			s_skill2.target.process_event(variables.TR_DEF, s_skill2)
			s_skill2.setup_effects_final()
		for s_skill2 in s_skill2_list:
			if s_skill2.hit_res == variables.RES_MISS:
				pass
			else:
				execute_skill(s_skill2)
		for s_skill2 in s_skill2_list:
			s_skill2.process_event(variables.TR_POSTDAMAGE)
			s_skill2.caster.process_event(variables.TR_POSTDAMAGE, s_skill2)
			if s_skill2.target.hp <= 0:
				s_skill2.process_event(variables.TR_KILL)
				s_skill2.caster.process_event(variables.TR_KILL, s_skill2)
			s_skill2.remove_effects()
	s_skill1.process_event(variables.TR_SKILL_FINISH)
	caster.process_event(variables.TR_SKILL_FINISH, s_skill1)
	s_skill1.remove_effects()
	for i in skill.sounddata.values():
		if i != null:
			input_handler.PlaySound(i)
	if skill.has('follow_up'):
		active_skill = skill.followup
		use_e_combat_skill(caster, target, skill)
	build_location_group()


func execute_skill(s_skill2):  #to update to exploration version
	var text = ''
	if s_skill2.hit_res == variables.RES_CRIT:
		text += "[color=yellow]Critical!![/color] "
		#s_skill2.target.displaynode.process_critical()
	for i in s_skill2.value:
		if i.damagestat == 'no_stat':
			continue  #for skill values that directly process into effects
		if i.damagestat == 'damage_hp' and i.dmgf == 0:  #drain, damage, damage no log, drain no log
			if i.is_drain && s_skill2.tags.has('no_log'):
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
				var rval2 = s_skill2.caster.heal(rval)
			elif i.is_drain:
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
				var rval2 = s_skill2.caster.heal(rval)
				text += (
					"%s drained %d health from %s and gained %d health."
					% [
						s_skill2.caster.get_stat('name'),
						rval,
						s_skill2.target.get_stat('name'),
						rval2
					]
				)
			elif s_skill2.tags.has('no_log') && ! i.is_drain:
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
			else:
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
				text += "%s is hit for %d damage. " % [s_skill2.target.get_stat('name'), rval]  #, s_skill2.value[i]] 
		elif i.damagestat == 'damage_hp' and i.dmgf == 1:  #heal, heal no log
			if s_skill2.tags.has('no_log'):
				var rval = s_skill2.target.heal(i.value)
			else:
				var rval = s_skill2.target.heal(i.value)
				text += "%s is healed for %d health." % [s_skill2.target.get_stat('name'), rval]
		elif i.damagestat == 'restore_mana' and i.dmgf == 0:  #heal, heal no log
			if ! s_skill2.tags.has('no log'):
				var rval = s_skill2.target.mana_update(i.value)
				text += "%s restored %d mana." % [s_skill2.target.get_stat('name'), rval]
			else:
				s_skill2.target.mana_update(i.value)
		elif i.damagestat == 'restore_mana' and i.dmgf == 1:  #drain, damage, damage no log, drain no log
			var rval = s_skill2.target.mana_update(-i.value)
			if i.is_drain:
				var rval2 = s_skill2.caster.mana_update(rval)
				if ! s_skill2.tags.has('no log'):
					text += (
						"%s drained %d mana from %s and gained %d mana."
						% [s_skill2.caster.get_stat('name'), rval, s_skill2.target.name, rval2]
					)
			if ! s_skill2.tags.has('no log'):
				text += "%s lost %d mana." % [s_skill2.target.get_stat('name'), rval]
		else:
			var mod = i.dmgf
			var stat = i.damagestat
			if mod == 0:
				var rval = s_skill2.target.stat_update(stat, i.value)
				if ! s_skill2.tags.has('no log'):
					text += (
						"%s restored %d %s."
						% [s_skill2.target.get_stat('name'), rval, tr(stat)]
					)
			elif mod == 1:
				var rval = s_skill2.target.stat_update(stat, -i.value)
				if i.is_drain:
					var rval2 = s_skill2.caster.stat_update(stat, -rval)
					if ! s_skill2.tags.has('no log'):
						text += (
							"%s drained %d %s from %s."
							% [
								s_skill2.caster.get_stat('name'),
								i.value,
								tr(stat),
								s_skill2.target.get_stat('name')
							]
						)
				elif ! s_skill2.tags.has('no log'):
					text += "%s loses %d %s." % [s_skill2.target.get_stat('name'), -rval, tr(stat)]
			elif mod == 2:
				var rval = s_skill2.target.stat_update(stat, i.value, true)
				if i.is_drain:  # use this on your own risk
					var rval2 = s_skill2.caster.stat_update(stat, -rval)
					if ! s_skill2.tags.has('no log'):
						text += (
							"%s drained %d %s from %s."
							% [
								s_skill2.caster.get_stat('name'),
								i.value,
								tr(stat),
								s_skill2.target.get_stat('name')
							]
						)
				elif ! s_skill2.tags.has('no log'):
					text += (
						"%s's %s is now %d."
						% [s_skill2.target.get_stat('name'), tr(stat), i.value]
					)
			else:
				print('error in damagestat %s' % i.damagestat)  #obsolete in new format


func area_advance(mode):
	if globals.check_location_group() == false:
		input_handler.SystemMessage("Select at least 1 character before advancing. ")
		return
	current_stage = active_location.progress.stage
	if check_events(mode) == true:
		yield(input_handler, 'EventFinished')
	var rand_event = false
	if (
		active_location.has('randomevents')
		&& randf() <= variables.dungeon_encounter_chance
		&& ! check_staged_enemies()
	):
		rand_event = globals.start_random_event()
		advance()
	if rand_event == false:
		StartCombat()

	action_type = mode


func check_staged_enemies():
	var result = false
	for i in input_handler.active_location.stagedenemies:
		if i.stage == current_stage && i.level == current_level:
			result = true
			break
	return result


func advance():
	if check_dungeon_end() == false:
		active_location.progress.stage += 1
		current_stage = active_location.progress.stage
		if active_location.progress.stage > active_location.levels["L" + str(current_level)].stages:
			active_location.progress.stage = 0
			active_location.progress.level += 1
			current_stage = active_location.progress.stage
			current_level = active_location.progress.level
		globals.current_level = current_level
		if check_dungeon_end():
			if active_location.completed == false:
				active_location.completed = true
				globals.common_effects([{code = "complete_active_location_quests"}])
				check_events("dungeon_complete")
			# $LocationGui/Resources/Forget.visible = true
			$LocationGui/Resources/SelectWorkers.visible = true
			$LocationGui/Resources/Forget.visible = true
			$LocationGui/Resources/Materials.update()
		enter_dungeon()
	elif action_type == 'location_finish':
		Navigation.build_accessible_locations()
		Navigation.select_location("aliron")
	else:
		enter_dungeon()


func StartCombat():
	play_animation("fight")
	yield(get_tree().create_timer(1), "timeout")
	ResourceScripts.core_animations.BlackScreenTransition(0.5)
	yield(get_tree().create_timer(0.5), "timeout")
	globals.current_level = current_level
	globals.current_stage = current_stage
	globals.StartCombat()



func skip_to_boss():
	current_level = active_location.levels.size()
	active_location.progress.level = current_level
	current_stage = active_location.levels["L" + str(active_location.levels.size())].stages - 1
	active_location.progress.stage = current_stage
	enter_dungeon()


func play_animation(animation):
	var anim_scene
	match animation:
		"fight":
			input_handler.PlaySound("battle_start")
			anim_scene = input_handler.get_spec_node(input_handler.ANIM_BATTLE_START)
			anim_scene.raise()
			anim_scene.get_node("AnimationPlayer").play("battle_start")
			yield(anim_scene.get_node("AnimationPlayer"), "animation_finished")
			ResourceScripts.core_animations.FadeAnimation(anim_scene, 0.5)
			yield(get_tree().create_timer(0.5), 'timeout')
			anim_scene.queue_free()
		"quest":
			input_handler.PlaySound("quest_aquired")
			anim_scene = input_handler.get_spec_node(input_handler.ANIM_TASK_AQUARED)
			anim_scene.get_node("SelectedQuest").text = selectedquest.name
			anim_scene.get_node("AnimationPlayer").play("task_aquared")
			yield(anim_scene.get_node("AnimationPlayer"), "animation_finished")
			anim_scene.queue_free()


func check_dungeon_end():
	return (
		current_stage >= active_location.levels["L" + str(current_level)].stages
		&& current_level >= active_location.levels.size()
	)


func enter_level(level, skip_to_end = false):
	current_level = level
	if skip_to_end == true:
		current_level = active_location.levels.size()
		active_location.progress.level = current_level
		current_stage = active_location.levels["L" + str(active_location.levels.size())].stages - 1
		active_location.progress.stage = current_stage
	if active_location.progress.level < level:
		active_location.progress.level = level
		active_location.progress.stage = 0

	if check_events('enter_level') == true:
		yield(input_handler, 'EventFinished')

	input_handler.ClearContainer($LocationGui/DungeonInfo/ScrollContainer/VBoxContainer)
	var newbutton
	if (
		active_location.progress.level == level
		&& active_location.progress.stage < active_location.levels["L" + str(level)].stages
	):
		newbutton = input_handler.DuplicateContainerTemplate(
			$LocationGui/DungeonInfo/ScrollContainer/VBoxContainer
		)
		newbutton.text = 'Advance'
		newbutton.connect("pressed", self, "area_advance", ['advance'])
#	elif active_location.progress.level == level && active_location.progress.stage >= active_location.levels["L"+str(level)].stages:
#		if active_location.levels.has("L"+str(level + 1)) == true:
#			newbutton = input_handler.DuplicateContainerTemplate($LocationGui/DungeonInfo/ScrollContainer/VBoxContainer)
#			newbutton.text = 'Move to the next level'
#			newbutton.connect("pressed",self,"enter_level",[level+1])
#		else:
#			newbutton = input_handler.DuplicateContainerTemplate($LocationGui/DungeonInfo/ScrollContainer/VBoxContainer)
#			newbutton.text = 'Forget Location'
#			newbutton.connect("pressed",self,"clear_dungeon")

	if variables.allow_skip_fights:
		newbutton = input_handler.DuplicateContainerTemplate(
			$LocationGui/DungeonInfo/ScrollContainer/VBoxContainer
		)
		newbutton.text = 'Skip to last room'
		newbutton.connect("pressed", self, "enter_level", [level, true])

	build_location_group()
	build_location_description()


var action_type
var active_skill


func clear_dungeon():
	input_handler.get_spec_node(
		input_handler.NODE_CONFIRMPANEL,
		[
			self,
			'clear_dungeon_confirm',
			"Forget this location? All present characters will be sent back to Mansion. This action can't be undone."
		]
	)


func clear_dungeon_confirm():
	globals.remove_location(active_location.id)
	action_type = 'location_finish'


func build_location_group():
	#clear_groups()
	if active_location == null || ! active_location.has("group"):
		return
	for i in positiondict:
		if (
			active_location.group.has('pos' + str(i))
			&& (
				(
					ResourceScripts.game_party.characters.has(active_location.group['pos' + str(i)])
					== false
				)
				|| ResourceScripts.game_party.characters[active_location.group['pos' + str(i)]].has_status(
					'no_combat'
				)
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
			get_node(positiondict[i] + "/Image/TextureRect/hp/Labelhp").text = (
				str(round(character.hp))
				+ "/"
				+ str(round(character.get_stat('hpmax')))
			)
			get_node(positiondict[i] + "/Image/TextureRect/mp").max_value = character.get_stat(
				'mpmax'
			)
			get_node(positiondict[i] + "/Image/TextureRect/mp").value = character.mp
			get_node(positiondict[i] + "/Image/TextureRect/mp/Labelmp").text = (
				str(round(character.mp))
				+ "/"
				+ str(round(character.get_stat('mpmax')))
			)
			get_node(positiondict[i] + "/Image").dragdata = character
			get_node(positiondict[i] + "/Image/Label").text = character.get_short_name()
			# get_node(positiondict[i]).self_modulate.a = 0
			get_node(positiondict[i]).character = character
		else:
			get_node(positiondict[i] + "/Image").dragdata = null
			get_node(positiondict[i] + "/Image").texture = null
			get_node(positiondict[i] + "/Image").hide()
			get_node(positiondict[i]).self_modulate.a = 1
			get_node(positiondict[i]).character = null
	var newbutton
	var counter = 0
	input_handler.ClearContainer($LocationGui/PresentedSlavesPanel/ScrollContainer/VBoxContainer)
	var char_array = input_handler.get_location_characters()
	for i in char_array:
		counter += 1
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
	if counter == 0 && gui_controller.exploration.get_node("LocationGui").is_visible():
		nav.return_to_mansion()
		return
	build_item_panel()
	build_spell_panel()

var selectedperson
func return_character(character):
	selectedperson = character
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'return_character_confirm', character.translate("Send [name] back?")])


func return_character_confirm():
	selectedperson.remove_from_task()
	selectedperson.return_to_mansion()
	build_location_group()

func return_all_to_mansion():
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'return_all_to_mansion_confirm', "Return all character back to Mansion?"])


func return_all_to_mansion_confirm():
	var presented_characters = []
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		if i.travel.area == active_area.code && i.check_location(active_location.id, true):
			presented_characters.append(i)
	for person in presented_characters:
		person.remove_from_task()
		person.return_to_mansion()
	$NavigationModule.return_to_mansion("default")
	


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
		newnode.get_node("Name").text = str(i.name)
		newnode.dragdata = i
		globals.connectitemtooltip(newnode, i)
		tutorial_items = true
	if tutorial_items == true:
		input_handler.ActivateTutorial("exploration_items")
	switch_panel(panelmode)


var panelmode = 'items'


func switch_panel(mode):
	panelmode = mode
	match mode:
		'items':
			$LocationGui/ItemUsePanel/ScrollContainer.show()
			$LocationGui/ItemUsePanel/SpellContainer.hide()
			$LocationGui/ItemUsePanel/SpellsButton.pressed = false
			$LocationGui/ItemUsePanel/ItemsButton.pressed = true
		'spells':
			$LocationGui/ItemUsePanel/ScrollContainer.hide()
			$LocationGui/ItemUsePanel/SpellContainer.show()
			$LocationGui/ItemUsePanel/SpellsButton.pressed = true
			$LocationGui/ItemUsePanel/ItemsButton.pressed = false


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
				if person.has_status('no_obed_gain'):
					disabled = true
				if skill.charges > 0:
					var leftcharges = skill.charges
					if person.skills.combat_skill_charges.has(skill.code):
						leftcharges -= person.skills.combat_skill_charges[skill.code]
#						newbutton.get_node("charge").visible = true
#						newbutton.get_node("charge").text = str(leftcharges)+"/"+str(skill.charges)
					if leftcharges <= 0:
						disabled = true
				if disabled == true:
					newnode.get_node("name").set("custom_colors/font_color", Color(1, 0.5, 0.5))
					newnode.script = null


func open_location_actions():
	input_handler.ClearContainer($LocationGui/DungeonInfo/ScrollContainer/VBoxContainer)
	var newbutton
	match active_location.type:
		'dungeon':
			enter_dungeon()
		'settlement':
			for i in active_location.actions:
				newbutton = input_handler.DuplicateContainerTemplate(
					$LocationGui/DungeonInfo/ScrollContainer/VBoxContainer
				)
				newbutton.text = tr(i.to_upper())
				newbutton.connect("pressed", self, i)
		'encounter':
			for i in active_location.options:
				if globals.checkreqs(i.reqs) == true:
					newbutton = input_handler.DuplicateContainerTemplate(
						$LocationGui/DungeonInfo/ScrollContainer/VBoxContainer
					)
					newbutton.text = tr(i.text)
					newbutton.connect("pressed", globals, 'common_effects', [i.args])
		'quest_location':
			for i in active_location.options:
				if globals.checkreqs(i.reqs) == true:
					newbutton = input_handler.DuplicateContainerTemplate(
						$LocationGui/DungeonInfo/ScrollContainer/VBoxContainer
					)
					newbutton.text = tr(i.text)
					newbutton.connect("pressed", globals, 'common_effects', [i.args])


func enter_dungeon():
	check_events('enter')
	build_location_group()
	build_location_description()
	current_level = active_location.progress.level
	current_stage = active_location.progress.stage
	var is_last_level = (
		active_location.progress.level >= active_location.levels.size()
		&& (
			active_location.progress.stage
			>= active_location.levels["L" + str(active_location.levels.size())].stages
		)
	)

	input_handler.ClearContainer($LocationGui/DungeonInfo/ScrollContainer/VBoxContainer)
	var newbutton
	if ! is_last_level:
		newbutton = input_handler.DuplicateContainerTemplate(
			$LocationGui/DungeonInfo/ScrollContainer/VBoxContainer
		)
		newbutton.text = 'Advance'
		newbutton.connect("pressed", self, "area_advance", ['advance'])
		if variables.allow_skip_fights:
			newbutton = input_handler.DuplicateContainerTemplate(
				$LocationGui/DungeonInfo/ScrollContainer/VBoxContainer
			)
			newbutton.text = 'Skip to last room'
			newbutton.connect("pressed", self, "skip_to_boss")
	if gui_controller.mansion.test_mode:
		newbutton = input_handler.DuplicateContainerTemplate(
			$LocationGui/DungeonInfo/ScrollContainer/VBoxContainer
		)
		newbutton.text = "(debug)Complete location"
		newbutton.connect("pressed", self, "debug_complete_location")


func debug_complete_location():
	active_location.completed = true
	enter_dungeon()


func check_events(action):
	return globals.check_events(action)


var previous_guild = ''


func enter_guild(guild):
	self.current_pressed_area_btn = null
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
	active_area = ResourceScripts.game_world.areas[guild.area]
	active_faction = guild
	market_mode = "guild_slaves"
	input_handler.active_faction = guild
	input_handler.ClearContainer(AreaActions)
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
			newbutton.get_node("Label").text = event.name
			newbutton.connect(
				"pressed",
				input_handler,
				"interactive_dialogue_start",
				[event.target, event.target_option]
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
		newbutton.get_node("Label").text = faction_actions[i]
		newbutton.connect("toggled", self, "faction_" + i, [newbutton, guild])
		newbutton.texture_normal = load("res://assets/Textures_v2/CITY/Buttons/buttonviolet.png")
		newbutton.texture_pressed = load(
			"res://assets/Textures_v2/CITY/Buttons/buttonviolet_pressed.png"
		)
		newbutton.texture_hover = load(
			"res://assets/Textures_v2/CITY/Buttons/buttonviolet_hover.png"
		)
	newbutton = input_handler.DuplicateContainerTemplate(AreaActions)
	newbutton.get_node("Label").text = "Leave"
	newbutton.connect("pressed", self, "open_city", [selected_location])

	# Visuals
	$GuildBG.texture = images.backgrounds[guild.background]
	if get_tree().get_root().get_node_or_null("dialogue") && ! get_tree().get_root().get_node("dialogue").is_visible():
		unfade($GuildBG)
	if gui_controller.is_dialogue_just_started:
		unfade($GuildBG)


var infotext = "Upgrades effects and quest settings update after some time passed. "


func faction_guild_shop(pressed, pressed_button, guild):
	gui_controller.win_btn_connections_handler(pressed, $SlaveMarket, pressed_button)
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
		newbutton.get_node("Icon").texture = item_ref.icon
		newbutton.get_node("Price").text = "x " + str(guild.reputation_shop.items[item][1])
		newbutton.get_node("Amount").show()
		newbutton.get_node("Amount").text = str(guild.reputation_shop.items[item][0])
		newbutton.connect("pressed", self, "buy_item", [item_ref, guild.reputation_shop.items[item][1], guild.reputation_shop.items[item][0]])
		if Items.itemlist.has(item):
			globals.connecttempitemtooltip(newbutton, item_ref, 'geartemplate')
		else:
			globals.connectmaterialtooltip(newbutton, item_ref)

	for cls in guild.reputation_shop.classes:
		if ResourceScripts.game_progress.unlocked_classes.has(cls):
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($GuildShop/ScrollContainer/VBoxContainer)
		newbutton.get_node("Title").text = str(cls.capitalize())
		newbutton.get_node("Price").text = "x " + str(guild.reputation_shop.classes[cls])
		newbutton.get_node("Icon").texture = classesdata.professions[cls].icon
		newbutton.connect("pressed", self, "buy_item", [cls, guild.reputation_shop.classes[cls], 1, "class"])
		var person = ResourceScripts.game_party.get_master()
		var tempclass = classesdata.professions[cls]
		var text = ''

		text += ResourceScripts.descriptions.get_class_name(tempclass, person)

		text += "\nBonuses\n"
		text += ResourceScripts.descriptions.get_class_bonuses(person, tempclass)

		text += '\n' + str(ResourceScripts.descriptions.get_class_traits(person, tempclass))
		if str(ResourceScripts.descriptions.get_class_traits(person, tempclass)) != '':
			text += '\n'

		text += tr('CLASSREQS')+"\n"
		if tempclass.reqs.size() > 0:
			text += ResourceScripts.descriptions.get_class_reqs(person, tempclass)
		else:
			text += tr("REQSNONE")

		text += '\n' + str(person.translate(tempclass.descript))
		var social_skills = ''
		var combat_skills = ''
		if tempclass.has("skills") && tempclass.skills != []:
			text += "\nSocial Skills - "
			for skill in tempclass.skills:
				social_skills += skill.capitalize() + ", "
			social_skills = social_skills.substr(0, social_skills.length() - 2)
		text += social_skills
		if tempclass.has("combatskills") && tempclass.combatskills != []:
			text += "\nCombat Skills - "
			for skill in tempclass.combatskills:
				combat_skills += skill.capitalize() + ", "
			combat_skills = combat_skills.substr(0, combat_skills.length() - 2)
		text += combat_skills
		globals.connecttexttooltip(newbutton, text)
	$GuildShop/FactionPoints.text = "x " + str(active_faction.reputation)
	$GuildShop/GuildName.text = str(active_faction.name)
	if pressed:
		unfade($GuildShop)
	else:
		fade($GuildShop)


func buy_item(item_ref, price, amount, type = "item"):
	var item_name = ''
	if type == "class":
		item_name = item_ref.capitalize()
	if type == "item":
		item_name = item_ref.name
	item_to_buy = item_ref
	$GuildShop/NumberSelection2.open(
		self,
		'buy_item_confirm',
		item_name,
		price,
		0,
		amount,
		true
	)


func buy_item_confirm(amount):
	items_amount = amount
	var item_name = ''
	var price = 0
	if typeof(item_to_buy) == TYPE_DICTIONARY:
		item_name = item_to_buy.name
		price = active_faction.reputation_shop.items[item_to_buy.code][1] * amount
	if typeof(item_to_buy) == TYPE_STRING:
		item_name = item_to_buy
		price = active_faction.reputation_shop.classes[item_to_buy]
	var text = "Are you sure you want to spend " + str(price) + " reputation points " + "for " + str(item_name)  + "?"
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL,
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
			ResourceScripts.game_res.set_material(item_to_buy.code, '+', items_amount)
			active_faction.reputation_shop.items[item_to_buy.code][0] -= items_amount
		elif Items.itemlist.has(item_to_buy.code):
			active_faction.reputation_shop.items[item_to_buy.code][0] -= items_amount
			match item_to_buy.type:
				'usable':
					globals.AddItemToInventory(globals.CreateUsableItem(item_to_buy.code))
				'gear':
					globals.AddItemToInventory(globals.CreateGearItem(item_to_buy.code, {}))
	active_faction.reputation -= active_faction.reputation_shop.items[item_to_buy.code][1] * items_amount
	faction_guild_shop(true, current_pressed_area_btn, active_faction)


func faction_upgrade(pressed, pressed_button, guild):
	gui_controller.win_btn_connections_handler(pressed, $SlaveMarket, pressed_button)
	active_faction = guild
	self.current_pressed_area_btn = pressed_button
	var text = ''
	# $FactionDetails.visible = pressed
	input_handler.ClearContainer($FactionDetails/VBoxContainer)
	text = infotext
	$FactionDetails/RichTextLabel.text = text
	$FactionDetails/FactionPoints.text = "Faction points: " + str(active_faction.totalreputation)
	$FactionDetails/UnspentPoints.text = "Unspent points: " + str(active_faction.reputation)

	for i in active_faction.questsetting:
		if i == 'total':
			continue
		$FactionDetails/QuestGenPanel/HBoxContainer.get_node(i + "/counter").text = str(
			active_faction.questsetting[i]
		)

	$FactionDetails/QuestGenPanel/totalquestpoints.text = (
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
		var newnode = input_handler.DuplicateContainerTemplate($FactionDetails/VBoxContainer)
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
			newnode.hide()
			continue

		newnode.get_node("text").bbcode_text = text
		newnode.get_node("Price").text = (
			"Price: "
			+ str(i.cost[currentupgradelevel])
			+ " faction points."
		)
		newnode.get_node("confirm").connect(
			'pressed', self, "unlock_upgrade", [i, currentupgradelevel]
		)
		if pressed:
			unfade($FactionDetails)
		else:
			fade($FactionDetails)


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
	faction_upgrade(true, current_pressed_area_btn, active_faction)


func show_quest_gen(action = "show"):
	if action == "show":
		$FactionDetails.get_node("QuestGenPanel").visible = $FactionDetails.get_node("QuestGen").is_pressed()
	else:
		$FactionDetails.get_node("QuestGenPanel").hide()
		$FactionDetails.get_node("QuestGen").pressed = false


func details_quest_up(difficulty):
	if (
		(
			active_faction.questsetting.total
			- (
				active_faction.questsetting.easy
				+ active_faction.questsetting.medium
				+ active_faction.questsetting.hard
			)
		)
		> 0
	):
		active_faction.questsetting[difficulty] += 1
	faction_upgrade(true, current_pressed_area_btn, active_faction)


func details_quest_down(difficulty):
	if active_faction.questsetting[difficulty] > 0:
		active_faction.questsetting[difficulty] -= 1
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
	if person == null:
		FullSlaveInfo.show_summary(person_to_hire)
	else:
		FullSlaveInfo.show_summary(person)
	# FullSlaveInfo.update_purchase_btn()


func faction_hire(pressed, pressed_button, area, mode = "guild_slaves"):
	market_mode = mode
	gui_controller.win_btn_connections_handler(pressed, $SlaveMarket, pressed_button)
	active_faction = area
	self.current_pressed_area_btn = pressed_button
	# $SlaveMarket.visible = pressed
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
		newbutton.get_node("Price").text = str(tchar.calculate_price())
		newbutton.get_node('icon').texture = tchar.get_icon()
		#newbutton.connect('signal_RMB_release',input_handler,'ShowSlavePanel', [tchar])
		newbutton.connect("pressed", self, 'show_slave_info', [tchar])  #, self, "select_slave_in_guild", [tchar])
		newbutton.connect('gui_input', self, 'double_clicked')
		newbutton.set_meta("person", tchar)
		globals.connectslavetooltip(newbutton, tchar)
	var person_id
	if active_faction.slaves != []:
		person_id = active_faction.slaves[0]
	else:
		return
	var person = characters_pool.get_char_by_id(person_id)
	show_slave_info(person)
	if pressed:
		unfade($SlaveMarket)
	else:
		fade($SlaveMarket)

func show_upgrade_window():
	gui_controller.close_top_window()
	if !gui_controller.windows_opened.has($StatsUpgrade):
		gui_controller.windows_opened.append($StatsUpgrade)
	$StatsUpgrade.show()
	$StatsUpgrade.show_characters_panel()



func change_mode(mode):
	hiremode = mode
	if mode == "hire":
		faction_hire(true, current_pressed_area_btn, active_faction, "city_slaves")
	else:
		sell_slave()

func sell_slave():
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
		if (tchar.has_profession('master')): # || tchar.valuecheck({code = 'is_free', check = true}) == false):
			continue
		char_list.append(tchar)
		var newbutton = input_handler.DuplicateContainerTemplate($SlaveMarket/SlaveList/ScrollContainer/VBoxContainer)
		newbutton.get_node("name").text = tchar.get_short_name() + " - " + tchar.get_short_race()
		newbutton.get_node("Price").text = str(round(tchar.calculate_price() / 2))
		newbutton.connect("pressed", self, 'show_slave_info', [tchar])
		newbutton.connect('gui_input', self, 'double_clicked')
		newbutton.set_meta("person", tchar)
		newbutton.get_node('icon').texture = tchar.get_icon()
		globals.connectslavetooltip(newbutton, tchar)
	if char_list != []:
		var person = char_list[0]
		show_slave_info(person)
		char_list.clear()

func show_slave_info(person):
	person_to_hire = person
	$SlaveMarket/HBoxContainer/EnslaveButton.visible = person.get_stat("slave_class") != "slave" && market_mode != "guild_slaves" # && (!person.has_profession('master'))
	for button in SlaveMarketList.get_children():
		if button.name == "Button":
			continue
		button.pressed = button.get_meta("person") == person_to_hire
	globals.connecttexttooltip($SlaveMarket/RichTextLabel, person.show_race_description())
	$SlaveMarket/exp.text = str(floor(person.get_stat('base_exp')))
	var text = person.get_short_name() + person.translate(" [race] [age]")
	input_handler.ClearContainer($SlaveMarket/TextureRect/professions)
	if person.xp_module.professions.size() > 5:
		$SlaveMarket/TextureRect/professions.columns = 10
		$SlaveMarket/TextureRect/professions/Button.rect_min_size = Vector2(45, 45)
		$SlaveMarket/TextureRect/professions/Button/ProfIcon.rect_size = Vector2(34, 34)
		$SlaveMarket/TextureRect/professions/Button/Label.hide()
	else:
		$SlaveMarket/TextureRect/professions.columns = 5
		$SlaveMarket/TextureRect/professions/Button.rect_min_size = Vector2(90, 90)
		$SlaveMarket/TextureRect/professions/Button/ProfIcon.rect_size = Vector2(78, 78)
		$SlaveMarket/TextureRect/professions/Button/Label.show()

	for i in person.xp_module.professions:
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
	$SlaveMarket/sex.texture = images.icons[person.get_stat('sex')]
	$SlaveMarket/RichTextLabel.bbcode_text = text

	for i in ['hp', 'mp', 'lust']:
		get_node("SlaveMarket/base_stats/" + i).max_value = person.get_stat(i + 'max')
		get_node("SlaveMarket/base_stats/" + i).value = person.get_stat(i)
		get_node("SlaveMarket/base_stats/" + i + '/Label').text = (
			str(floor(person.get_stat(i)))
			+ "/"
			+ str(floor(person.get_stat(i + 'max')))
		)
	text = (
		"Type: [color=yellow]"
		+ person.translate(statdata.slave_class_names[person.get_stat('slave_class')])
		+ "[/color]\n"
	)

	for i in $SlaveMarket/factors.get_children():
		# if i.name in ['food_consumption', 'base_exp']:
		if i.name in ['base_exp']:
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

	$SlaveMarket/ConsentLabel.text = "Consent: " + str(floor(person.get_stat('consent')))
	$SlaveMarket/PurchaseButton.disabled = false
	#$PurchaseButton.disabled = person.calculate_price() > ResourceScripts.game_res.money
	# rebuild_traits(person)


var sell_category = 'all'
var buy_category = 'all'
var active_shop
func faction_sellslaves():
	hiremode = 'sell'
#	$HirePanel.show()
#	$HirePanel/RichTextLabel.bbcode_text = ""
	input_handler.ClearContainer($SlaveMarket/SlaveList/ScrollContainer/VBoxContainer)
	for i in ResourceScripts.game_party.characters:
		var tchar = characters_pool.get_char_by_id(i)
		if tchar.has_profession('master') || tchar.valuecheck({code = 'is_free', check = true}) == false:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($SlaveMarket/SlaveList/ScrollContainer/VBoxContainer)
		newbutton.get_node("name").text = tchar.get_stat('name')
		newbutton.get_node("Price").text = str(round(tchar.calculate_price()/2))
		newbutton.connect("pressed", self, "sell_slave", [tchar])
		newbutton.set_meta("person", tchar)
		globals.connectslavetooltip(newbutton, tchar)

func unfade(window):
	window.set("modulate", Color(1, 1, 1, 0))
	window.show()
	ResourceScripts.core_animations.UnfadeAnimation(window, 0.5)
	yield(get_tree().create_timer(0.5), "timeout")
	window.set("modulate", Color(1, 1, 1, 1))

func fade(window):
	# window.set("modulate", Color(1, 1, 1, 1))
	ResourceScripts.core_animations.FadeAnimation(window, 0.5)
	yield(get_tree().create_timer(0.5), "timeout")
	window.hide()
	# window.set("modulate", Color(1, 1, 1, 0))


func open_shop(pressed, pressed_button, shop):
	gui_controller.win_btn_connections_handler(pressed, $AreaShop, pressed_button)
	self.current_pressed_area_btn = pressed_button
	# $AreaShop.visible = pressed
	match shop:
		'area':
			active_shop = active_area.shop
		'location':
			active_shop = input_handler.active_location.shop
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

func local_shop():
	open_shop(true, current_pressed_area_btn, 'location')


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
	for i in ResourceScripts.game_res.materials:
		if ResourceScripts.game_res.materials[i] <= 0:
			continue
		var item = Items.materiallist[i]
		var type = get_item_category(item)
		var newbutton = input_handler.DuplicateContainerTemplate(
			$AreaShop/SellBlock/ScrollContainer/VBoxContainer
		)
		newbutton.get_node("name").text = item.name
		newbutton.get_node("icon").texture = item.icon
		newbutton.get_node("price").text = str(item.price)
		newbutton.get_node("amount").visible = true
		newbutton.get_node("amount").text = str(ResourceScripts.game_res.materials[i])
		newbutton.set_meta('type', type)
		newbutton.connect("pressed", self, "item_sell", [item])
		newbutton.visible = (newbutton.get_meta("type") == sell_category) || sell_category == "all"
		globals.connectmaterialtooltip(newbutton, item)
	for item in ResourceScripts.game_res.items.values():
		var type = get_item_category(item)
		if item.owner != null:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate(
			$AreaShop/SellBlock/ScrollContainer/VBoxContainer
		)
		newbutton.get_node("name").text = item.name
		item.set_icon(newbutton.get_node("icon"))  #.texture = item.get_icon()
		newbutton.get_node("price").text = str(item.calculateprice() / 2)
		newbutton.get_node("amount").visible = true
		newbutton.get_node("amount").text = str(item.amount)
		newbutton.set_meta('type', type)
		newbutton.connect("pressed", self, "item_sell", [item])
		newbutton.visible = (newbutton.get_meta("type") == sell_category) || sell_category == "all"
		globals.connectitemtooltip(newbutton, item)


func update_buy_list():
	input_handler.ClearContainer($AreaShop/BuyBlock/ScrollContainer/VBoxContainer)
	tempitems.clear()
	for i in active_shop:
		if Items.materiallist.has(i):
			var item = Items.materiallist[i]
			var amount = -1
			if typeof(active_shop) == TYPE_DICTIONARY:
				amount = active_shop[i]
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
			newbutton.connect("pressed", self, "item_purchase", [item, amount])
			newbutton.visible = (
				(newbutton.get_meta("type") == buy_category)
				|| buy_category == "all"
			)
			globals.connectmaterialtooltip(newbutton, item, 'material')
			if amount > 0:
				newbutton.get_node("amount").text = str(amount)
				newbutton.get_node("amount").show()
		elif Items.itemlist.has(i):
			var item = Items.itemlist[i]
			var amount = -1
			if item.has('parts'):
				amount = 1
			else:
				amount = active_shop[i]
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
			newbutton.visible = (
				(newbutton.get_meta("type") == buy_category)
				|| buy_category == "all"
			)
			if item.has('parts'):
				var newitem = globals.CreateGearItem(i, active_shop[i], {}, null)
				newitem.set_icon(newbutton.get_node('icon'))
				newbutton.get_node("name").text = newitem.name
				tempitems.append(newitem)
				globals.connectitemtooltip(newbutton, newitem)
				newbutton.get_node("price").text = str(newitem.calculateprice())
				newbutton.connect('pressed', self, "item_purchase", [newitem, amount])
			else:
				globals.connecttempitemtooltip(newbutton, item, 'geartemplate')
				newbutton.connect('pressed', self, "item_purchase", [item, amount])
			if amount > 0:
				newbutton.get_node("amount").text = str(amount)
				newbutton.get_node("amount").show()


var purchase_item


func item_purchase(item, amount):
	purchase_item = item
	if amount < 0:
		amount = 100
	var price = 0
	if typeof(item) == TYPE_OBJECT:
		price = item.calculateprice()
	else:
		price = item.price
	$AreaShop/NumberSelection.open(
		self,
		'item_puchase_confirm',
		"Buy " + str(item.name),
		price,
		0,
		amount,
		true,
		item.icon
	)


func item_puchase_confirm(value):
	input_handler.PlaySound("money_spend")
	if typeof(purchase_item) == TYPE_OBJECT:
		globals.AddItemToInventory(purchase_item)
		ResourceScripts.game_res.money -= purchase_item.calculateprice()
		input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
		for i in active_shop:
			if purchase_item.itembase == i && str(purchase_item.parts) == str(active_shop[i]):
				active_shop.erase(i)
				break
		update_sell_list()
		update_buy_list()
	else:
		if Items.materiallist.has(purchase_item.code):
			ResourceScripts.game_res.set_material(purchase_item.code, '+', value)
			ResourceScripts.game_res.money -= purchase_item.price * value
			if typeof(active_shop) == TYPE_DICTIONARY:
				active_shop[purchase_item.code] -= value
		elif Items.itemlist.has(purchase_item.code):
			ResourceScripts.game_res.money -= purchase_item.price * value
			if typeof(active_shop) == TYPE_DICTIONARY:
				active_shop[purchase_item.code] -= value
			while value > 0:
				match purchase_item.type:
					'usable':
						globals.AddItemToInventory(globals.CreateUsableItem(purchase_item.code))
					'gear':
						globals.AddItemToInventory(globals.CreateGearItem(purchase_item.code, {}))
				value -= 1
		update_sell_list()
		update_buy_list()


func item_sell(item):
	purchase_item = item
	var price
	if item.price:
		price = item.price  # / 2
	else:
		price = item.calculateprice() / 2
	var sellingamount
	if ! Items.materiallist.has(item.code):
		price = item.calculateprice() / 2
		sellingamount = item.amount
	else:
		sellingamount = ResourceScripts.game_res.materials[item.code]
	$AreaShop/NumberSelection.open(
		self,
		'item_sell_confirm',
		"Sell " + str(item.name),
		price,
		0,
		sellingamount,
		false,
		item.icon
	)


func item_sell_confirm(value):
	input_handler.PlaySound("money_spend")
	var price
	if purchase_item.price:
		price = purchase_item.price  # / 2
	else:
		price = purchase_item.calculateprice() / 2
	if Items.materiallist.has(purchase_item.code):
		ResourceScripts.game_res.set_material(purchase_item.code, '-', value)
	else:
		price = round(purchase_item.calculateprice() / 2)
		purchase_item.amount -= value
	ResourceScripts.game_res.money += price * value
	update_sell_list()
	update_buy_list()


func quest_board(pressed, pressed_button):
	gui_controller.win_btn_connections_handler(pressed, $QuestBoard, pressed_button)
	self.current_pressed_area_btn = pressed_button
	# $QuestBoard.visible = pressed
	var counter = 0
	input_handler.ClearContainer($QuestBoard/ScrollContainer/VBoxContainer)
	for i in active_area.quests.factions:
		for k in active_area.quests.factions[i].values():
			if k.state == 'free':
				counter += 1
				var newbutton = input_handler.DuplicateContainerTemplate(
					$QuestBoard/ScrollContainer/VBoxContainer
				)
				newbutton.get_node("Label").text = k.name
				var text = k.descript
				newbutton.get_node("RichTextLabel2").bbcode_text = globals.TextEncoder(text)
				newbutton.get_node("ButtonOverlay").connect("pressed", self, "see_quest_info", [k])
				newbutton.get_node("ButtonOverlay").connect(
					"mouse_entered", self, "change_texture", [newbutton, "in"]
				)
				newbutton.get_node("ButtonOverlay").connect(
					"mouse_exited", self, "change_texture", [newbutton, "out"]
				)
				newbutton.set_meta("quest", k)
	$QuestBoard/NoQuests.visible = counter == 0
	if pressed:
		unfade($QuestBoard)
	else:
		fade($QuestBoard)


func accept_quest():
	ResourceScripts.game_world.take_quest(selectedquest, active_area)
	for i in selectedquest.requirements:
		if i.code in ['complete_dungeon', 'complete_location']:
			break
	input_handler.interactive_message('quest_accept', '', {})
	play_animation("quest")
	quest_board(true, current_pressed_area_btn)


func change_texture(button, state):
	match state:
		"in":
			button.texture_normal = load(
				"res://assets/Textures_v2/CITY/Universal/paper_small_active.png"
			)
		"out":
			button.texture_normal = load("res://assets/Textures_v2/CITY/Universal/paper_small.png")


func see_quest_info(quest):
	for i in $QuestBoard/ScrollContainer/VBoxContainer.get_children():
		if i.name == 'Button':
			continue
		i.pressed = i.get_meta('quest') == quest
	input_handler.ghost_items.clear()
	selectedquest = quest
	$QuestBoard/QuestDetails.show()
	input_handler.ClearContainer($QuestBoard/QuestDetails/questreqs)
	input_handler.ClearContainer($QuestBoard/QuestDetails/questrewards)
	var text = '[center]' + quest.name + '[/center]\n' + quest.descript
	for i in quest.requirements:
		var newbutton = input_handler.DuplicateContainerTemplate($QuestBoard/QuestDetails/questreqs)
		match i.code:
			'kill_monsters':
				newbutton.texture = images.icons.quest_enemy
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
				newbutton.get_node("Icon").texture = images.icons.quest_enemy
				newbutton.hint_tooltip = (
					"Hunt Monsters: "
					+ Enemydata.enemies[i.type].name
					+ " - "
					+ str(i.value)
				)
			'random_item':
				var itemtemplate = Items.itemlist[i.type]
				newbutton.get_node("Icon").texture = itemtemplate.icon
				newbutton.hint_tooltip = itemtemplate.name + ": " + str(i.value)
				if itemtemplate.has('parts'):
					#newbutton.material = load("res://src/ItemShader.tres").duplicate()
					var showcase_item = globals.CreateGearItem(i.type, i.parts)
					input_handler.itemshadeimage(newbutton, showcase_item)
					globals.connectitemtooltip(newbutton, showcase_item)
					if i.has('parts'):
						newbutton.hint_tooltip += "\nPart Requirements: "
						for k in i.parts:
							newbutton.hint_tooltip += (
								"\n"
								+ tr(Items.Parts[k].name)
								+ ": "
								+ str(Items.materiallist[i.parts[k]].name)
							)
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
			'complete_location':
				newbutton.get_node("Icon").texture = images.icons.quest_encounter
				newbutton.hint_tooltip = (
					"Complete quest location: "
					+ worlddata.dungeons[i.type].name
				)
				text += (
					"\n"
					+ worlddata.dungeons[i.type].name
					+ ": "
					+ worlddata.dungeons[i.type].descript
				)
			'complete_dungeon':
				newbutton.get_node("Icon").texture = images.icons.quest_dungeon
				newbutton.hint_tooltip = "Complete quest dungeon: "
			'random_material':
				newbutton.get_node("Icon").texture = Items.materiallist[i.type].icon
				newbutton.get_node("amount").show()
				newbutton.get_node("amount").text = str(i.value)
				globals.connectmaterialtooltip(
					newbutton,
					Items.materiallist[i.type],
					'\n\n[color=yellow]Required: ' + str(i.value) + "[/color]"
				)
			'slave_delivery':
				newbutton.get_node("Icon").texture = images.icons.quest_slave_delivery
				var tooltiptext = "Slave Required:\n"
				for k in i.statreqs:
					if k.code in ['is_master', 'is_free']:
						continue
					match k.code:
						'stat':
							tooltiptext += (
								statdata.statdata[k.stat].name
								+ ": "
								+ input_handler.operant_translation(k.operant)
								+ " "
								+ str(k.value)
								+ " "
								+ "\n"
							)
						'sex':
							tooltiptext += "Sex: " + tr('SLAVESEX' + k.value.to_upper()) + "\n"
				globals.connecttexttooltip(newbutton, tooltiptext)

	for i in quest.rewards:
		var newbutton = input_handler.DuplicateContainerTemplate(
			$QuestBoard/QuestDetails/questrewards
		)
		match i.code:
			'gear':
				var item = globals.CreateGearItem(i.item, i.itemparts)
				item.set_icon(newbutton)
				input_handler.ghost_items.append(item)
				globals.connectitemtooltip(newbutton, item)
			'gear_static':
				newbutton.get_node("Icon").texture = Items.itemlist[i.item].icon
				globals.connecttempitemtooltip(newbutton, Items.itemlist[i.item], 'geartemplate')
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
			'usable':
				var item = Items.itemlist[i.item]
				newbutton.get_node("Icon").texture = item.icon
				globals.connecttempitemtooltip(newbutton, item, 'geartemplate')
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
			'material':
				var material = Items.materiallist[i.item]
				newbutton.get_node("Icon").texture = material.icon
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
				globals.connectmaterialtooltip(newbutton, material)
			'gold':
				var value = round(
					(
						i.value
						+ (
							i.value
							* variables.master_charm_quests_gold_bonus[int(
								ResourceScripts.game_party.get_master().get_stat('charm_factor')
							)]
						)
					)
				)
				newbutton.get_node("Icon").texture = images.icons.quest_gold
				newbutton.get_node("amount").text = str(value)
				newbutton.get_node("amount").show()
				newbutton.hint_tooltip = (
					"Gold: "
					+ str(i.value)
					+ " + "
					+ str(
						round(
							(
								i.value
								* variables.master_charm_quests_gold_bonus[int(
									ResourceScripts.game_party.get_master().get_stat('charm_factor')
								)]
							)
						)
					)
					+ "(Master Charm Bonus)"
				)
			'reputation':
				var value = round(
					(
						i.value
						+ (
							i.value
							* variables.master_charm_quests_rep_bonus[int(
								ResourceScripts.game_party.get_master().get_stat('charm_factor')
							)]
						)
					)
				)
				newbutton.get_node("Icon").texture = images.icons[i.code]
				newbutton.get_node("amount").text = str(value)
				newbutton.get_node("amount").show()
				newbutton.hint_tooltip = (
					"Reputation ("
					+ quest.source
					+ "): "
					+ str(i.value)
					+ " + "
					+ str(
						round(
							(
								i.value
								* variables.master_charm_quests_rep_bonus[int(
									ResourceScripts.game_party.get_master().get_stat('charm_factor')
								)]
							)
						)
					)
					+ "(Master Charm Bonus)"
				)
	$QuestBoard/QuestDetails/Requester.text = ""
	$QuestBoard/QuestDetails/Requester.text += active_area.factions[quest.source].name + " "

	$QuestBoard/QuestDetails/RichTextLabel.bbcode_text = globals.TextEncoder(text)
	$QuestBoard/QuestDetails/time/Label.text = "Limit: " + str(quest.time_limit) + " days."


func location_purchase(pressed, pressed_button):
	$BuyLocation/LocationInfo.hide()
	self.current_pressed_area_btn = pressed_button
	gui_controller.win_btn_connections_handler(pressed, $BuyLocation, pressed_button)
	input_handler.ClearContainer($BuyLocation/ScrollContainer/VBoxContainer)
	for i in worlddata.dungeons.values():
		if i.type != 'dungeon':
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

	update_location_shop_btn(location.name)


func update_location_shop_btn(location_name):
	for btn in $BuyLocation/ScrollContainer/VBoxContainer.get_children():
		if !btn.has_meta("location_name"):
			continue
		btn.pressed = btn.get_meta("location_name") == location_name

	
var purchasing_location

func purchase_location():
	if purchasing_location.has('purchase_area'):
		active_area = ResourceScripts.game_world.areas[purchasing_location.purchase_area]
	if active_area.locations.size() < 8:
		var randomlocation = []
		for i in active_area.locationpool:
			randomlocation.append(worlddata.dungeons[i].code)
		randomlocation = ResourceScripts.world_gen.make_location(
			purchasing_location.code, active_area
		)
		input_handler.active_location = randomlocation
		input_handler.active_area = active_area
		active_area.locations[randomlocation.id] = randomlocation
		ResourceScripts.game_world.location_links[randomlocation.id] = {
			area = active_area.code, category = 'locations'
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
	if current_pressed_area_btn == null:
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



func select_workers():
	var MANSION = gui_controller.mansion
	MANSION.SlaveListModule.selected_location = selected_location
	MANSION.SlaveListModule.show_location_characters()
	MANSION.active_person = MANSION.SlaveListModule.visible_persons[0].get_meta("slave")
	MANSION.hovered_person = null
	MANSION.SlaveModule.show_slave_info()
	MANSION.set_active_person(MANSION.active_person)
	$NavigationModule.return_to_mansion("occupation")
