extends Control

# GUI Blocks
onready var nav = $LocationGui/NavigationModule
onready var res_panel = $LocationGui/Resources
onready var res_container = $LocationGui/Resources/Materials
onready var captured_panel = $LocationGui/AvailableSlaves
onready var map_panel = $LocationGui/MapPanel
onready var map_container = $LocationGui/MapPanel/CanvasLayer

#var active_area
var active_location

var positiondict = {
	1: "LocationGui/Positions/HBoxContainer/frontrow/1",
	2: "LocationGui/Positions/HBoxContainer/frontrow/2",
	3: "LocationGui/Positions/HBoxContainer/frontrow/3",
	4: "LocationGui/Positions/HBoxContainer/backrow/4",
	5: "LocationGui/Positions/HBoxContainer/backrow/5",
	6: "LocationGui/Positions/HBoxContainer/backrow/6",
}


func get_stamina_mod(): #temporal, 2add later
	return 1.0


func get_current_stamina(modified = true):
	var res = active_location.stamina
	if modified:
		res /= get_stamina_mod()
	return res


func pay_stamina(value, modified = true):
	if modified:
		value *= get_stamina_mod()
	active_location.stamina -= value
	update_stamina()


func update_stamina():
	map_panel.get_node("Stamina/Label").text = "Stamina: %d/%d" % [active_location.stamina, 100]


func party_check(dict):
	if active_location == null: 
		return false
	input_handler.active_location = active_location
	build_location_group()
	var party = input_handler.get_active_party()
	match dict.code:
		'party_size':
			return input_handler.operate(dict.operant, party.size(), dict.value)
		_: #characters check
			var res = false
			for ch in party:
				res = res or ch.valuecheck(dict)
			return res


func location_chars_check(dict):
	if active_location == null: 
		return false
	input_handler.active_location = active_location
	build_location_group()
	var party = input_handler.get_location_characters()
	match dict.code:
		'amount':
			return input_handler.operate(dict.operant, party.size(), dict.value)
		_: #characters check
			var res = false
			for ch in party:
				res = res or ch.valuecheck(dict)
			return res


func _ready():
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
	$JournalButton.connect("pressed", self, "open_journal")
	map_panel.get_node("res").connect("toggled", self, 'toggle_res')
	map_panel.get_node("slaves").connect("toggled", self, 'toggle_slaves')
	globals.connecttexttooltip(map_panel.get_node("res"), "Show/hide local resources")
	globals.connecttexttooltip(map_panel.get_node("slaves"), "Show/hide captured characters")
	gui_controller.win_btn_connections_handler(true, $MansionJournalModule, $JournalButton)
	gui_controller.windows_opened.clear()
	globals.connect("hour_tick", self, "build_location_group")
	input_handler.connect("EventFinished", self, 'build_location_group')
	input_handler.connect("LootGathered", self, 'build_location_group')
	input_handler.connect("LocationSlavesUpdate", self, 'build_location_group')
	input_handler.connect("update_itemlist", self, 'update_sell_list')


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


func open(location):
	active_location = location
	# $NavigationModule.build_accessible_locations()
	# $NavigationModule.update_buttons()
	input_handler.exploration_node = self
	# var loca = ResourceScripts.world_gen.get_location_from_code(selected_location)
	# if loca.type == "capital":
	# 	open_city(selected_location)

#var current_level
#var current_stage


func open_location(data): #2fix
	input_handler.ActivateTutorial("exploration")
	input_handler.StopBackgroundSound()
	gui_controller.nav_panel = $LocationGui/NavigationModule
#	active_location = data.id #wrong
#	var gatherable_resources
#	$LocationGui/Resources/Forget.visible = true
#	res_panel.get_node("SelectWorkers").visible = !active_location.gather_limit_resources.empty()
	gui_controller.clock.hide()
#	$LocationGui.show()
	res_container.update()
	active_location = data
	input_handler.active_area = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[data.id].area]
##	input_handler.active_area = active_area
#	input_handler.active_location = data
	input_handler.emit_signal("LocationSlavesUpdate")
	current_level = 0
	build_level()
	update_stamina()
	var dungeon = active_location.dungeon[current_level]
	var tdata = ResourceScripts.game_world.dungeons[dungeon]
	scout_room(tdata.first_room, true)
##	if input_handler.active_location.has('progress'):
##		current_level = active_location.progress.level
##		current_stage = active_location.progress.stage
#	if input_handler.active_location.has('background'):
#		$LocationGui/Image/TextureRect.texture = images.backgrounds[input_handler.active_location.background]
	if active_location.has('bgm'):
		input_handler.SetMusic(input_handler.active_location.bgm)
#
	#check if anyone is present
	build_location_group()
	var presented_characters = []
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		if i.check_location(active_location.id, true):
			presented_characters.append(i)
	build_location_description()
##	if data.type in ["quest_location", "encounter"]:
#	if input_handler.active_area.questlocations.has(active_location):#or active_area.encounters.has(selected_location):
#		$LocationGui/Resources/Forget.visible = false
##		$LocationGui/Resources/SelectWorkers.visible = false
##		$LocationGui/Resources/Label.visible = false
#	else:
#		$LocationGui/Resources/Label.visible = true
#	if data.has("locked"):
#		if data.locked:
#			$LocationGui/Resources/Forget.visible = false
#			$LocationGui/Resources/SelectWorkers.visible = false
#			$LocationGui/Resources/Label.visible = true
	gui_controller.nav_panel.build_accessible_locations()
	#input_handler.interactive_message("spring", '',{})


func build_location_description():
	var text = ''
	text = (
		active_location.name
		+ " ("
		+ tr(active_location.classname)
#		+ ")\n"
		+ " - "
#				+ tr("DUNGEONDIFFICULTY")
#				+ ": "
#				+ tr("DUNGEONDIFFICULTY" + active_location.difficulty.to_upper())
	)
	text += tr("LEVELS") + " " + str(current_level + 1)
	if active_location.completed:
		text += "{color=aqua|" + tr("LOC_COMPLETE") + "}"
	map_panel.get_node('RichTextLabel').bbcode_text = (
		'[center]'
		+ globals.TextEncoder(text)
		+ "[/center]"
	)


func slave_position_selected(pos, character):
	pos = 'pos' + str(pos)
	if character == null:
		input_handler.active_location.group.erase(pos)
		build_location_group()
		return
	if character.has_status('no_combat'):
		input_handler.SystemMessage(character.translate(tr("CHAR_NO_COMBAT")))
		return
	elif !character.is_master() and !character.has_status('combatant'):
		input_handler.SystemMessage(character.translate(tr("NO_FIGHT_LOW_OBED")))
		return
	character = character.id
	var positiontaken = false
	var oldheroposition = null
	if (
		input_handler.active_location.group.has(pos)
		&& ResourceScripts.game_party.characters[input_handler.active_location.group[pos]].check_location(
			input_handler.active_location.id, true
		)
	):
		positiontaken = true
	
	for i in input_handler.active_location.group:
		if input_handler.active_location.group[i] == character:
			oldheroposition = i
			input_handler.active_location.group.erase(i)
	var INTEGER_VALUE_FROM_POS_INDEX = 3
	if oldheroposition != null && positiontaken == true && oldheroposition != pos:
		input_handler.active_location.group[oldheroposition] = input_handler.active_location.group[pos]
		var CHARACTER_UID = input_handler.active_location.group[oldheroposition]
		ResourceScripts.game_party.characters[CHARACTER_UID].combat_position = int(oldheroposition[INTEGER_VALUE_FROM_POS_INDEX])
	input_handler.active_location.group[pos] = character
	build_location_group()


func slave_position_deselect(character):
	for i in input_handler.active_location.group:
		if input_handler.active_location.group[i] == character.id:
			input_handler.active_location.group.erase(i)
			break
	build_location_group()


func use_item_on_character(character, item):
	item.use_explore(character, self)  #item.use_explore(state.characters[active_location.group['pos'+str(position)]])
	item.amount -= 1
	#show_heal_items(position)
	build_location_group()


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
			'line':
				targets = []
				var tpos = target.combat_position
				for line in variables.lines.values():
					if !line.has(tpos): continue
					for pos in line:
						if input_handler.active_location.group.has('pos' + str(pos)):
							targets.push_back(ResourceScripts.game_party.characters[input_handler.active_location.group[('pos' + str(pos))]])
					break
			'row':
				targets = []
				var tpos = target.combat_position
				for line in variables.rows.values():
					if !line.has(tpos): continue
					for pos in line:
						if input_handler.active_location.group.has('pos' + str(pos)):
							targets.push_back(ResourceScripts.game_party.characters[input_handler.active_location.group[('pos' + str(pos))]])
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
			s_skill2.process_event(variables.TR_EXPLORE_POSTDAMAGE)
			s_skill2.caster.process_event(variables.TR_EXPLORE_POSTDAMAGE, s_skill2)
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

#obsolete
#func area_advance(mode): #advance request
#	globals.reset_roll_data()
#	globals.char_roll_data.diff = input_handler.active_location.difficulty
#	if globals.check_location_group() == false:
#		input_handler.SystemMessage("Select at least 1 character before advancing. ")
#		return
##	current_stage = active_location.progress.stage
#	globals.char_roll_data.lvl = input_handler.active_location.progress.level
#	for ch_id in input_handler.active_location.group.values():
#		globals.char_roll_data.mf += characters_pool.get_char_by_id(ch_id).get_stat('magic_find')
#
#	if check_events(mode) == true:
#		yield(input_handler, 'EventFinished')
#	input_handler.combat_explore = true
#	var rand_event = false
#	if (randf() <= variables.dungeon_unique_encounter_chance and !check_staged_enemies()):
#		rand_event = globals.start_unique_event()
#		if rand_event != false:
#			input_handler.combat_advance = true
##			advance()
#	if ( !rand_event and
#		input_handler.active_location.has('randomevents') and
#		randf() <= variables.dungeon_encounter_chance and
#		!check_staged_enemies() 
#	):
#		rand_event = globals.start_random_event()
#		if rand_event != false:
#			input_handler.combat_advance = true
##			advance()
#	if rand_event == false:
#		input_handler.combat_advance = false
#		StartCombat()
#
#	action_type = mode
#
#
#func check_staged_enemies():
#	var result = false
#	var progress = input_handler.active_location.progress
#	for i in input_handler.active_location.stagedenemies:
#		if i.stage == progress.stage && i.level == progress.level:
#			result = true
#			break
#	return result
#
#
#func advance():
#	input_handler.combat_explore = false
#	build_location_group()
#	if check_dungeon_end() == false:
#		input_handler.active_location.progress.stage += 1
##		current_stage = active_location.progress.stage
#		if input_handler.active_location.progress.stage > input_handler.active_location.levels["L" + str(input_handler.active_location.progress.level)].stages:
#			input_handler.active_location.progress.stage = 0
#			input_handler.active_location.progress.level += 1
##			current_stage = active_location.progress.stage
##			current_level = active_location.progress.level
##		globals.current_level = current_level
#		if check_dungeon_end():
#			if input_handler.active_location.completed == false:
#				input_handler.active_location.completed = true
#				globals.common_effects([{code = "complete_active_location_quests"}])
#				check_events("dungeon_complete")
#			# $LocationGui/Resources/Forget.visible = true
#			$LocationGui/Resources/SelectWorkers.visible = true
#			$LocationGui/Resources/Forget.visible = true
#			$LocationGui/Resources/Materials.update()
#		enter_dungeon()
#	elif action_type == 'location_finish':
#		Navigation.build_accessible_locations()
#		Navigation.select_location("aliron")
#	else:
#		enter_dungeon()
#
#
func StartCombat(): #2change it to pregen groups anf StartFixedAreaCombat
	input_handler.play_animation("fight")
	yield(get_tree().create_timer(1), "timeout")
	ResourceScripts.core_animations.BlackScreenTransition(0.5)
	yield(get_tree().create_timer(0.5), "timeout")
#	globals.current_level = current_level
#	globals.current_stage = current_stage
	globals.StartAreaCombat()


# func play_animation(animation):
# 	var anim_scene
# 	match animation:
# 		"fight":
# 			input_handler.PlaySound("battle_start")
# 			anim_scene = input_handler.get_spec_node(input_handler.ANIM_BATTLE_START)
# 			anim_scene.raise()
# 			anim_scene.get_node("AnimationPlayer").play("battle_start")
# 			yield(anim_scene.get_node("AnimationPlayer"), "animation_finished")
# 			ResourceScripts.core_animations.FadeAnimation(anim_scene, 0.5)
# 			yield(get_tree().create_timer(0.5), 'timeout')
# 			anim_scene.queue_free()
# 		"quest":
# 			input_handler.PlaySound("quest_aquired")
# 			anim_scene = input_handler.get_spec_node(input_handler.ANIM_TASK_AQUARED)
# 			anim_scene.get_node("SelectedQuest").text = selectedquest.name
# 			anim_scene.get_node("AnimationPlayer").play("task_aquared")
# 			yield(anim_scene.get_node("AnimationPlayer"), "animation_finished")
# 			anim_scene.queue_free()


var action_type
var active_skill


func clear_dungeon():
	input_handler.get_spec_node(
		input_handler.NODE_YESNOPANEL,
		[
			self,
			'clear_dungeon_confirm',
			tr("FORGETLOCATIONQUESTION")
		]
	)

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
	if input_handler.active_location == null || !input_handler.active_location.has("group"):
		return
	input_handler.active_location.group.clear()
	for ch in ResourceScripts.game_party.characters.values():
		if !ch.has_profession('master') && ch.get_stat('obedience') == 0:
			continue
		if ch.check_location(input_handler.active_location.id, true) and ch.combat_position != 0 and !ch.has_status('no_combat') and ch.has_status('combatant'):
			if !input_handler.active_location.group.has(['pos' + str(ch.combat_position)]):
				input_handler.active_location.group['pos' + str(ch.combat_position)] = ch.id
	for i in positiondict:
#		if (active_location.group.has('pos' + str(i)) && ((ResourceScripts.game_party.characters.has(active_location.group['pos' + str(i)]) == false) || ResourceScripts.game_party.characters[active_location.group['pos' + str(i)]].has_status('no_combat'))):
#			active_location.group.erase('pos' + str(i))
		if !input_handler.active_location.group.has('pos' + str(i)):
			get_node(positiondict[i] + "/Image").dragdata = null
			get_node(positiondict[i] + "/Image").texture = null
			get_node(positiondict[i] + "/Image").hide()
			get_node(positiondict[i]).self_modulate.a = 1
			get_node(positiondict[i]).character = null
			continue
#		if (active_location.group.has('pos' + str(i)) && ResourceScripts.game_party.characters[active_location.group['pos' + str(i)]] != null && ResourceScripts.game_party.characters[active_location.group['pos' + str(i)]].check_location(active_location.id, true)):
		else:
			var character = ResourceScripts.game_party.characters[input_handler.active_location.group[('pos' + str(i))]]
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
	var char_array = input_handler.get_location_characters()
	for i in char_array:
		counter += 1
		newbutton = input_handler.DuplicateContainerTemplate(
			$LocationGui/PresentedSlavesPanel/ScrollContainer/VBoxContainer
		)
		newbutton.dragdata = i
		newbutton.get_node("icon").texture = i.get_icon_small()
		if newbutton.get_node('icon').texture == null:
			if i.has_profession('master'):
				newbutton.get_node('icon').texture = images.icons.class_master
			elif i.get_stat('slave_class') == 'servant':
				newbutton.get_node('icon').texture = images.icons.class_servant
			else:
				newbutton.get_node('icon').texture = images.icons.class_slave
		newbutton.get_node("Label").text = i.get_short_name()
		newbutton.connect("pressed", self, "return_character", [i])
		if input_handler.active_location.group.values().has(i.id):
			newbutton.get_node("icon").modulate = Color(0.3, 0.3, 0.3)
		globals.connectslavetooltip(newbutton, i)
	if counter == 0 && gui_controller.exploration.get_node("LocationGui").is_visible():
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
	build_location_group()

func return_all_to_mansion():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'return_all_to_mansion_confirm', "Return all character back to Mansion?"])


func return_all_to_mansion_confirm():
	var presented_characters = []
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		if i.check_location(input_handler.active_location.id, true):
			presented_characters.append(i)
	for person in presented_characters:
		person.remove_from_task()
		person.return_to_mansion()
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
		if person.check_location(input_handler.active_location.id, true):
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


func select_workers():
	var MANSION = gui_controller.mansion
	MANSION.SlaveListModule.selected_location = active_location
	MANSION.SlaveListModule.show_location_characters()
	$NavigationModule.return_to_mansion()
	yield(get_tree().create_timer(0.6), 'timeout')
	MANSION.get_node("MansionJobModule2").selected_location = active_location
	MANSION.SlaveListModule.OpenJobModule()


func toggle_res(value):
	res_panel.visible = value


func toggle_slaves(value):
	captured_panel.visible = value

#map movement
var current_level = 0
var selected_room = null #combat cash
var active_subroom = null #event cash
const default_map_pos = Vector2(630, 500)
const default_room_size = Vector2(270, 270)

func build_level():
	var dungeon = active_location.dungeon[current_level]
	var data = ResourceScripts.game_world.dungeons[dungeon]
	input_handler.ClearContainer(map_container, ['room'])
	
	for room in data.rooms:
		var newroom = input_handler.DuplicateContainerTemplate(map_container, 'room')
		newroom.setup(room)
	
	scout_room(data.first_room, true)
	update_map()
	build_location_description()


func update_map():
	for room in map_container.get_children():
		room.update()


func room_pressed(room_id):
	if globals.check_location_group() == false:
		input_handler.SystemMessage("Select at least 1 character before advancing. ")
		return
	globals.reset_roll_data()
	globals.char_roll_data.diff = active_location.difficulty
	globals.char_roll_data.lvl = current_level
	for ch_id in active_location.group.values():
		globals.char_roll_data.mf += characters_pool.get_char_by_id(ch_id).get_stat('magic_find')
	var data = ResourceScripts.game_world.rooms[room_id]
	if data.type == 'empty':
		return
	if !(data.type in ['ladder_up']):
		if get_current_stamina() < active_location.stamina_cost:
			input_handler.SystemMessage("No stamina")
			return
		pay_stamina(active_location.stamina_cost)
		update_stamina()
	scout_room(room_id)


func scout_room(room_id, stay = false):
	var data = ResourceScripts.game_world.rooms[room_id]
	if data.status =='obscured':
		data.status = 'scouted'
		for room in data.neighbours.values():
			if room != null:
				obscure_room(room)
	
	selected_room = null
	update_map()
	if stay:
		move_to_room(room_id)
		return
	
	match data.type:
#		'empty':
#			move_to_room(room_id)
		'combat':
			selected_room = room_id
#			input_handler.combat_advance = false
			globals.StartAreaCombat() #temporal, 2fix
		'combat_boss':
			selected_room = room_id
#			input_handler.combat_advance = false
			globals.StartAreaCombat() #temporal, 2fix, important!
		'event':
			#2add
#			input_handler.combat_advance = true
			var _event = globals.start_fixed_event(data.event)
			if !_event:
				_event = globals.start_random_event()
			move_to_room(room_id)
			pass
		'ladder_down':
			current_level += 1
			build_level()
			var dungeon = active_location.dungeon[current_level]
			var tdata = ResourceScripts.game_world.dungeons[dungeon]
			scout_room(tdata.first_room, true)
		'ladder_up':
			current_level -= 1
			build_level()


func obscure_room(room_id):
	var data = ResourceScripts.game_world.rooms[room_id]
	if data.status =='hidden':
		data.status = 'obscured'


func move_to_room(room_id = null):
	if room_id == null:
		room_id = selected_room
	selected_room = null
	if room_id == null:
		return
	
	build_location_group()
	build_location_description()
	var data = ResourceScripts.game_world.rooms[room_id]
	data.status = 'cleared'
	if data.type in ['ladder_down', 'ladder_up']:
		data.status = 'scouted'
	if data.type == 'combat_boss':
		active_location.completed = true
		globals.common_effects([{code = "complete_active_location_quests"}])
		build_location_description()
	if data.type in ['event', 'combat', 'combat_boss']:
		data.type = 'empty'
	update_map()
	#add path counting and events


func subroom_pressed(room_id, subroom_id):
	if globals.check_location_group() == false:
		input_handler.SystemMessage("Select at least 1 character before advancing. ")
		return
	globals.reset_roll_data()
	globals.char_roll_data.diff = active_location.difficulty
	globals.char_roll_data.lvl = current_level
	for ch_id in active_location.group.values():
		globals.char_roll_data.mf += characters_pool.get_char_by_id(ch_id).get_stat('magic_find')
	var data = ResourceScripts.game_world.rooms[room_id]
	var subroom_data = data.subrooms[subroom_id]
	if get_current_stamina() < subroom_data.stamina_cost:
		input_handler.SystemMessage("No stamina")
		return
	active_subroom = null
	selected_room = null
	
	match subroom_data.type:
		'empty': #should never be called
			print('empty subroom activated')
			return
		'onetime_event':
			selected_room = room_id
			active_subroom = subroom_id
			pay_stamina(subroom_data.stamina_cost)
			#2test
#			input_handler.combat_advance = true
			var _event = globals.start_fixed_event(subroom_data.event)
			if !_event:
				_event = globals.start_random_event()
			clear_subroom()
		'event':
			selected_room = room_id
			active_subroom = subroom_id
			pay_stamina(subroom_data.stamina_cost)
			#2test
#			input_handler.combat_advance = true
			var _event = globals.start_fixed_event(subroom_data.event)
			if !_event:
				_event = globals.start_random_event()
		'unique_event':
			selected_room = room_id
			active_subroom = subroom_id
			pay_stamina(subroom_data.stamina_cost)
			#2test
#			input_handler.combat_advance = true
			var _event = globals.start_unique_event()
			if !_event:
				_event = globals.start_random_event()
		'resource':
			selected_room = room_id
			active_subroom = subroom_id
			pay_stamina(subroom_data.stamina_cost)
			input_handler.AddOrIncrementDict(active_location.gather_limit_resources, {subroom_data.resource : subroom_data.amount})
			res_panel.get_node("SelectWorkers").visible = true
			res_container.update()
			clear_subroom()


func clear_subroom():
	if active_subroom == null:
		print('error clearing subroom setup')
		return
	if selected_room == null:
		print('error clearing subroom setup')
		return
	var data = ResourceScripts.game_world.rooms[selected_room]
	data.subrooms[active_subroom].type = 'empty'
	update_map()
	active_subroom = null
