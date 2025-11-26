extends Control

#var active_area
var active_location
onready var nav = $LocationGui/NavigationModule


var selected_location


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
	$LocationGui/Resources/Forget.connect("pressed", self, "forget_location")
	$LocationGui/PresentedSlavesPanel/ReturnAll.connect("pressed", self, "return_all_to_mansion")
	$TestButton.connect("pressed", self, "test")
	$TestButton.visible = gui_controller.mansion.test_mode
	$JournalButton.connect("pressed", self, "open_journal")
	gui_controller.win_btn_connections_handler(true, $MansionJournalModule, $JournalButton)
	gui_controller.windows_opened.clear()
	globals.connect("hour_tick", self, "build_location_group")
	globals.connect("update_clock", self, "update_gold")
	input_handler.connect("EventFinished", self, 'build_location_group')
	input_handler.connect("EventFinished", self, 'open_location_actions')
	input_handler.connect("LootGathered", self, 'build_location_group')
	input_handler.connect("LocationSlavesUpdate", self, 'build_location_group')
	input_handler.connect("update_itemlist", $AreaShop, 'update_sell_list')
	input_handler.connect("clear_cashed", self, 'clear_cashed')
	# gui_controller.win_btn_connections_handler(true, $AreaShop, closebutton)
#	$LocationGui/ce.connect("pressed", input_handler, "interactive_message", ['celena_shrine_find', '', {}])


func clear_cashed():
	active_location = null
	selected_location = 'aliron'


func test():
	for win in gui_controller.windows_opened:
		print(win.name)


func open_journal():
	if !$MansionJournalModule.visible:
		ResourceScripts.core_animations.UnfadeAnimation($MansionJournalModule, 0.5)
		$MansionJournalModule.visible = true
		$MansionJournalModule.open()
	else:
		ResourceScripts.core_animations.FadeAnimation($MansionJournalModule, 0.5)
		yield(get_tree().create_timer(0.5), "timeout")
		$MansionJournalModule.visible = false
	
	gui_controller.windows_opened.append($MansionJournalModule) if $MansionJournalModule.visible else gui_controller.windows_opened.erase($MansionJournalModule)


func open(location):
	selected_location = location
	input_handler.exploration_node = self



func open_location(data):
	input_handler.ActivateTutorial("TUTORIALLIST6")
	input_handler.StopBackgroundSound()
	gui_controller.nav_panel = $LocationGui/NavigationModule
#	nav = $LocationGui/NavigationModule
	selected_location = data.id
	var gatherable_resources
	$LocationGui/Resources/Forget.visible = false
	gui_controller.clock.hide()
	if data.has('gather_resources'):
		gatherable_resources = data.gather_resources
		$LocationGui/Resources/SelectWorkers.visible = true
	if gatherable_resources == null:
		$LocationGui/Resources/SelectWorkers.visible = false
	$LocationGui.show()
	$LocationGui/Resources/Materials.update()
	active_location = data
	input_handler.exploration_node = self
	input_handler.active_area = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[data.id].area]
#	input_handler.active_area = active_area
	input_handler.active_location = data
	input_handler.emit_signal("LocationSlavesUpdate")
#	if input_handler.active_location.has('progress'):
#		current_level = active_location.progress.level
#		current_stage = active_location.progress.stage
	if active_location.has('background'):
		$LocationGui/Image/TextureRect.texture = images.get_background(active_location.background)
	if active_location.has('bgm'):
		input_handler.SetMusic(active_location.bgm, true)

	#check if anyone is present
	build_location_group()
	var presented_characters = []
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		if i.check_location(active_location.id, true):
			presented_characters.append(i)
	if presented_characters.size() > 0 || variables.allow_remote_intereaction == true:
		open_location_actions()
	build_location_description()
#	if data.type in ["quest_location", "encounter"]:
	if input_handler.active_area.questlocations.has(selected_location):#or active_area.encounters.has(selected_location):
		$LocationGui/Resources/Forget.visible = false
#		$LocationGui/Resources/SelectWorkers.visible = false
#		$LocationGui/Resources/Label.visible = false
	else:
		$LocationGui/Resources/Label.visible = true
	if data.has("locked"):
		if data.locked:
			$LocationGui/Resources/Forget.visible = false
			$LocationGui/Resources/SelectWorkers.visible = false
			$LocationGui/Resources/Label.visible = true
	gui_controller.nav_panel.build_accessible_locations()
	#input_handler.interactive_message("spring", '',{})


func build_location_description():
#	var active_location = active_location
	var text = ''
	match active_location.type:
		'settlement':
			text = tr(active_location.classname) + ": " + active_location.name
		'skirmish':
			pass
		'quest_location':
			text = active_location.name #+ "\n" + active_location.descript
	$LocationGui/DungeonInfo/RichTextLabel.bbcode_text = (
		'[center]'
		+ globals.TextEncoder(text)
		+ "[/center]"
	)


func slave_position_selected(pos, character):
	var str_pos = 'pos' + str(pos)
	if character == null:
		active_location.group.erase(str_pos)
		build_location_group()
		return
	if character.has_status('no_combat'):
		input_handler.SystemMessage(character.translate(tr("CHAR_NO_COMBAT")))
		return
	elif !character.is_combatant():
		input_handler.SystemMessage(character.translate(tr("NO_FIGHT_LOW_OBED")))
		return
	var ch_id = character.id
	if active_location.group.has(str_pos):
		var oldchar =  ResourceScripts.game_party.characters[active_location.group[str_pos]]
		if oldchar.check_location(active_location.id, true): #should always be
			if character.combat_position != pos:
				oldchar.combat_position = character.combat_position
			else:
				oldchar.combat_position = 0
	character.combat_position = pos
	build_location_group()


func slave_position_deselect(character):
	for i in active_location.group:
		if active_location.group[i] == character.id:
			active_location.group.erase(i)
			character.combat_position = 0
			break
	build_location_group()


func use_item_on_character(character, item):
	item.use_explore(character, self)  #item.use_explore(state.characters[active_location.group['pos'+str(position)]])
	item.amount -= 1
	#show_heal_items(position)
	call_deferred('build_location_group')


func use_e_combat_skill(caster, target, skill):
	caster.pay_cost(skill.cost)
	caster.combatgroup = 'ally'
	if !caster.has_status('ignore_catalysts_for_%s' % skill.code):
		for i in skill.catalysts:
			ResourceScripts.game_res.materials[i] -= skill.catalysts[i]
	if skill.charges > 0:
		if caster.skills.combat_skill_charges.has(skill.code):
			caster.skills.combat_skill_charges[skill.code] += 1
		else:
			caster.skills.combat_skill_charges[skill.code] = 1
		caster.skills.daily_cooldowns[skill.code] = skill.cooldown
	var s_skill1 = ResourceScripts.scriptdict.class_sskill.new()
	s_skill1.createfromskill(skill)
	s_skill1.setup_caster(caster)
	#s_skill1.setup_target(target)
	s_skill1.process_event(variables.TR_CAST, {skill = s_skill1, caster = caster, target = target})
	caster.process_event(variables.TR_CAST, {skill = s_skill1, caster = caster, target = target})
	var targets
	for n in range(s_skill1.repeat):
		match skill.target_number:
			'single':
				targets = [target]
			'all':
				targets = input_handler.get_active_party()
			'line':
				targets = []
				var tpos = target.combat_position
				for line in variables.lines.values():
					if !line.has(tpos): continue
					for pos in line:
						if active_location.group.has('pos' + str(pos)):
							targets.push_back(ResourceScripts.game_party.characters[active_location.group[('pos' + str(pos))]])
					break
			'row':
				targets = []
				var tpos = target.combat_position
				for line in variables.rows.values():
					if !line.has(tpos): continue
					for pos in line:
						if active_location.group.has('pos' + str(pos)):
							targets.push_back(ResourceScripts.game_party.characters[active_location.group[('pos' + str(pos))]])
					break
		var s_skill2_list = []
		for i in targets:
			if skill.has('damage_type') and skill.damage_type == 'resurrect':
				i.resurrect(
					input_handler.calculate_number_from_string_array(skill.value[0], caster, target)
				)
			else:
				target.combatgroup = 'ally'
				var s_skill2 = s_skill1.clone()
				s_skill2.setup_target(i)
				s_skill2.setup_final()
				s_skill2.hit_roll()
				s_skill2.resolve_value(true)
				s_skill2_list.push_back(s_skill2)
		for s_skill2 in s_skill2_list:
			s_skill2.process_event(variables.TR_HIT, {skill = s_skill2, caster = caster, target = target})
			s_skill2.caster.process_event(variables.TR_HIT, {skill = s_skill2, caster = caster, target = target})
			s_skill2.target.process_event(variables.TR_DEF, {skill = s_skill2, caster = caster, target = target})
			s_skill2.setup_effects_final()
		for s_skill2 in s_skill2_list:
			if s_skill2.hit_res == variables.RES_MISS:
				pass
			else:
				execute_skill(s_skill2)
		for s_skill2 in s_skill2_list:
			s_skill2.process_event(variables.TR_EXPLORE_POSTDAMAGE, {skill = s_skill2, caster = caster, target = target})
			s_skill2.caster.process_event(variables.TR_EXPLORE_POSTDAMAGE, {skill = s_skill2, caster = caster, target = target})
			if s_skill2.target.hp <= 0:
				s_skill2.process_event(variables.TR_KILL, {skill = s_skill2, caster = caster, target = target})
				s_skill2.caster.process_event(variables.TR_KILL, {skill = s_skill2, caster = caster, target = target})
			s_skill2.remove_effects()
	s_skill1.process_event(variables.TR_SKILL_FINISH)
	caster.process_event(variables.TR_SKILL_FINISH, {skill = s_skill1, caster = caster, target = target})
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
		if !i.check_conditions(): continue
		if i.damagestat == 'no_stat':
			continue  #for skill values that directly process into effects
		if i.damagestat == 'damage_hp' and i.dmgf == 0:  #drain, damage, damage no log, drain no log
			if i.is_drain > 0.0 && s_skill2.tags.has('no_log'):
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
				var rval2 = s_skill2.caster.heal(rval * i.is_drain)
			elif i.is_drain > 0.0:
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
				var rval2 = s_skill2.caster.heal(rval * i.is_drain)
				text += (
					"%s drained %d health from %s and gained %d health."
					% [
						s_skill2.caster.get_short_name(),
						rval,
						s_skill2.target.get_short_name(),
						rval2
					]
				)
			elif s_skill2.tags.has('no_log') &&  i.is_drain <= 0.0:
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
			else:
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
				text += "%s is hit for %d damage. " % [s_skill2.target.get_short_name(), rval]  #, s_skill2.value[i]]
		elif i.damagestat == 'damage_hp' and i.dmgf == 1:  #heal, heal no log
			if s_skill2.tags.has('no_log'):
				var rval = s_skill2.target.heal(i.value)
			else:
				var rval = s_skill2.target.heal(i.value)
				text += "%s is healed for %d health." % [s_skill2.target.get_short_name(), rval]
		elif i.damagestat == 'restore_mana' and i.dmgf == 0:  #heal, heal no log
			if ! s_skill2.tags.has('no log'):
				var rval = s_skill2.target.mana_update(i.value)
				text += "%s restored %d mana." % [s_skill2.target.get_short_name(), rval]
			else:
				s_skill2.target.mana_update(i.value)
		elif i.damagestat == 'restore_mana' and i.dmgf == 1:  #drain, damage, damage no log, drain no log
			var rval = s_skill2.target.mana_update(-i.value)
			if i.is_drain > 0.0:
				var rval2 = s_skill2.caster.mana_update(rval * i.is_drain)
				if ! s_skill2.tags.has('no log'):
					text += (
						"%s drained %d mana from %s and gained %d mana."
						% [s_skill2.caster.get_short_name(), rval, s_skill2.target.name, rval2]
					)
			if ! s_skill2.tags.has('no log'):
				text += "%s lost %d mana." % [s_skill2.target.get_short_name(), rval]
		else:
			var mod = i.dmgf
			var stat = i.damagestat
			if mod == 0:
				var rval = s_skill2.target.stat_update(stat, i.value)
				if ! s_skill2.tags.has('no log'):
					text += (
						"%s restored %d %s."
						% [s_skill2.target.get_short_name(), rval, tr(stat)]
					)
			elif mod == 1:
				var rval = s_skill2.target.stat_update(stat, -i.value)
				if i.is_drain > 0.0:
					var rval2 = s_skill2.caster.stat_update(stat, -rval * i.is_drain)
					if ! s_skill2.tags.has('no log'):
						text += (
							"%s drained %d %s from %s."
							% [
								s_skill2.caster.get_short_name(),
								i.value,
								tr(stat),
								s_skill2.target.get_short_name()
							]
						)
				elif ! s_skill2.tags.has('no log'):
					text += "%s loses %d %s." % [s_skill2.target.get_short_name(), -rval, tr(stat)]
			elif mod == 2:
				var rval = s_skill2.target.stat_update(stat, i.value, true)
				if i.is_drain > 0.0:  # use this on your own risk
					var rval2 = s_skill2.caster.stat_update(stat, -rval * i.is_drain)
					if ! s_skill2.tags.has('no log'):
						text += (
							"%s drained %d %s from %s."
							% [
								s_skill2.caster.get_short_name(),
								i.value,
								tr(stat),
								s_skill2.target.get_short_name()
							]
						)
				elif ! s_skill2.tags.has('no log'):
					text += (
						"%s's %s is now %d."
						% [s_skill2.target.get_short_name(), tr(stat), i.value]
					)
			else:
				print('error in damagestat %s' % i.damagestat)  #obsolete in new format


func StartCombat():
	input_handler.play_animation("fight")
	yield(get_tree().create_timer(1), "timeout")
	ResourceScripts.core_animations.BlackScreenTransition(0.5)
	yield(get_tree().create_timer(0.5), "timeout")
#	globals.current_level = current_level
#	globals.current_stage = current_stage
	globals.StartCombat()


var action_type
var active_skill


func forget_location():
	input_handler.get_spec_node(
		input_handler.NODE_YESNOPANEL,
		[
			self,
			'clear_dungeon_confirm',
			tr("FORGETLOCATIONQUESTION")
		]
	)


func clear_dungeon_confirm():
	globals.remove_location(active_location.id)
	action_type = 'location_finish'


func build_location_group():
	#clear_groups()
	if active_location == null || !active_location.has("group"):
		return
	active_location.group.clear()
	for ch in ResourceScripts.game_party.characters.values():
		if !ch.is_combatant():
			continue
		if ch.check_location(active_location.id, true) and ch.combat_position != 0 and !ch.has_status('no_combat') and ch.is_combatant():
			if !active_location.group.has(['pos' + str(ch.combat_position)]):
				active_location.group['pos' + str(ch.combat_position)] = ch.id
	for i in positiondict:
#		if (active_location.group.has('pos' + str(i)) && ((ResourceScripts.game_party.characters.has(active_location.group['pos' + str(i)]) == false) || ResourceScripts.game_party.characters[active_location.group['pos' + str(i)]].has_status('no_combat'))):
#			active_location.group.erase('pos' + str(i))
		if !active_location.group.has('pos' + str(i)):
			get_node(positiondict[i] + "/Image").dragdata = null
			get_node(positiondict[i] + "/Image").texture = null
			get_node(positiondict[i] + "/Image").hide()
			get_node(positiondict[i]).self_modulate.a = 1
			get_node(positiondict[i]).character = null
			continue
#		if (active_location.group.has('pos' + str(i)) && ResourceScripts.game_party.characters[active_location.group['pos' + str(i)]] != null && ResourceScripts.game_party.characters[active_location.group['pos' + str(i)]].check_location(active_location.id, true)):
		else:
			var character = ResourceScripts.game_party.characters[active_location.group[('pos' + str(i))]]
			get_node(positiondict[i] + "/Image").texture = character.get_icon()
#			if get_node(positiondict[i] + "/Image").texture == null:
#				if character.has_profession('master'):
#					get_node(positiondict[i] + "/Image").texture = images.icons.class_master
#				elif character.get_stat('slave_class') == 'servant':
#					get_node(positiondict[i] + "/Image").texture = images.icons.class_servant
#				else:
#					get_node(positiondict[i] + "/Image").texture = images.icons.class_slave
#			get_node(positiondict[i] + "/Image").texture = character.get_class_icon()
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
#		else:
#			get_node(positiondict[i] + "/Image").dragdata = null
#			get_node(positiondict[i] + "/Image").texture = null
#			get_node(positiondict[i] + "/Image").hide()
#			get_node(positiondict[i]).self_modulate.a = 1
#			get_node(positiondict[i]).character = null

	var newbutton
	var counter = 0
	input_handler.ClearContainer($LocationGui/PresentedSlavesPanel/ScrollContainer/VBoxContainer)
	var char_array = input_handler.get_location_characters_by_id(active_location.id)
	for i in char_array:
		counter += 1
		newbutton = input_handler.DuplicateContainerTemplate(
			$LocationGui/PresentedSlavesPanel/ScrollContainer/VBoxContainer
		)
		newbutton.dragdata = i
		newbutton.get_node("icon").texture = i.get_icon_small()
		if newbutton.get_node('icon').texture == null:
			if i.has_profession('master'):
				newbutton.get_node('icon').texture = images.get_icon('class_master')
			elif i.get_stat('slave_class') == 'servant':
				newbutton.get_node('icon').texture = images.get_icon('class_servant')
			else:
				newbutton.get_node('icon').texture = images.get_icon('class_slave')
		newbutton.get_node("Label").text = i.get_short_name()
		newbutton.connect("pressed", self, "return_character", [i])
		if active_location.group.values().has(i.id):
			newbutton.get_node("icon").modulate = Color(0.3, 0.3, 0.3)
		globals.connectslavetooltip(newbutton, i)
	if (counter == 0
		&& input_handler.active_location.id == active_location.id
		&& is_visible()):#$LocationGui.is_visible()
		nav.return_to_mansion()
		return
	build_item_panel()
	build_spell_panel()


func add_rolled_chars(tarr):
	if active_location != null:
		if !active_location.has('captured_characters'):
			active_location.captured_characters = []
	else:
		return
	for id in tarr:
		active_location.captured_characters.push_back(id)
	input_handler.emit_signal("LocationSlavesUpdate")


var selectedperson
func return_character(character):
	selectedperson = character
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'return_character_confirm', character.translate(tr("SENDCHARBACKQUESTION"))])


func return_character_confirm():
	selectedperson.remove_from_task()
	selectedperson.return_to_mansion()
	active_location.teleporter = false
	build_location_group()

func return_all_to_mansion():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'return_all_to_mansion_confirm', "Return all character back to Mansion?"])


func return_all_to_mansion_confirm():
	var presented_characters = []
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		if i.check_location(active_location.id, true):
			presented_characters.append(i)
	for person in presented_characters:
		person.remove_from_task()
		person.return_to_mansion()
	active_location.teleporter = false
	nav.return_to_mansion("default")



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
		newnode.get_node("Name").text = tr("ITEM" + str(i.code).to_upper())
		newnode.dragdata = i
		globals.connectitemtooltip_v2(newnode, i)
		tutorial_items = true
	# if tutorial_items == true:
	# 	if !ResourceScripts.game_progress.active_tutorials.has("exploration_items"):
	# 		input_handler.ActivateTutorial("exploration_items")
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
			for i in person.get_combat_skills() + person.get_explore_skills():
				var skill = Skilldata.get_template(i, person)
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
				for st in skill.cost:
					text += (
						"\n\n"
						+ statdata.statdata[st].name
						+ " cost: "
						+ str(skill.cost[st])
						+ " ("
						+ str(floor(person.get_stat(st)))
						+ ")"
					)
				if !skill.catalysts.empty() and !person.has_status('ignore_catalysts_for_%s' % i):
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
				if !person.check_cost(skill.cost):
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
	if active_location == null:
		return
	input_handler.ClearContainer($LocationGui/DungeonInfo/ScrollContainer/VBoxContainer)
	var newbutton
	var option_list = []
	if active_location.has("locked"):
		if active_location.locked:
			# do options
			if worlddata.fixed_location_options.has(active_location.code):
				option_list = worlddata.fixed_location_options[active_location.code]
			elif active_location.has("options"):
				option_list = active_location.options
			for i in option_list:
				if globals.checkreqs(i.reqs) == true:
					newbutton = input_handler.DuplicateContainerTemplate(
						$LocationGui/DungeonInfo/ScrollContainer/VBoxContainer
					)
					newbutton.toggle_mode = false
					newbutton.text = tr(i.text)
					newbutton.connect("pressed", globals, 'common_effects', [i.args])
			return
	match active_location.type:
		'settlement':
			for i in active_location.actions:
				newbutton = input_handler.DuplicateContainerTemplate(
					$LocationGui/DungeonInfo/ScrollContainer/VBoxContainer
				)
				newbutton.toggle_mode = true
				newbutton.text = tr(i.to_upper())
				newbutton.connect("toggled", self, i, [newbutton])
	
	if worlddata.fixed_location_options.has(active_location.code):
		option_list = worlddata.fixed_location_options[active_location.code]
	elif active_location.has("options"):
		option_list = active_location.options
	for i in option_list:
		if globals.checkreqs(i.reqs) == true:
			newbutton = input_handler.DuplicateContainerTemplate(
				$LocationGui/DungeonInfo/ScrollContainer/VBoxContainer
			)
			newbutton.toggle_mode = false
			newbutton.text = tr(i.text)
			newbutton.connect("pressed", globals, 'common_effects', [i.args])


func check_events(action):
	return globals.check_events(action)


func open_shop(pressed, pressed_button, shop):
        var shop_data = {}
        match shop:
                'area':
                        if input_handler.active_area and input_handler.active_area.has('shop'):
                                shop_data = input_handler.active_area.shop
                'location':
                        if pressed and active_location and active_location.has('shop'):
                                shop_data = active_location.shop
                _:
                        shop_data = shop
        $AreaShop.open_shop(pressed, pressed_button, shop_data)


func local_shop(pressed, button):
        if active_location and active_location.has('shop'):
                        $AreaShop.open_shop(pressed, button, active_location.shop)


func update_gold():
        $AreaShop.update_gold()
