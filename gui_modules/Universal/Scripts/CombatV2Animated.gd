extends Control

#warning-ignore-all:return_value_discarded
# warning-ignore:unused_signal
var currentenemies
var area
var turns = 0
var global_turn = 0
var animationskip = false

var encountercode

var combatlog = ''

var instantanimation = null

var shotanimationarray = [] #supposedanimation = {code = 'code', runnext = false, delayuntilnext = 0}

var CombatAnimations = ResourceScripts.scriptdict.combat_animation.new()
var ActionQueue
var queue_script = preload("res://src/combat/action_queue.gd")

var debug = false

var combat_data = {}
var allowaction = false
var highlightargets = false
var allowedtargets = {}
var turnorder = []
var fightover = false

var playergroup = {} #pos:hid
var enemygroup = {}
var currentactor

var summons = [] #pos

var activeaction
var activeitem
var activecharacter
var customcursor = null

var autoskill = null
var autoskill_delay = 0
var autoskill_delay_rem = 0
var autoskill_times = 0
var autoskill_dummy

var enemypaneltextures = {
	normal = null,
	target = null,
}
var playerpaneltextures = {
	normal = null,
	target = null,
	disabled = null,
}
var battlefield = [] #hid/null
onready var battlefieldpositions = {1 : $Panel/PlayerGroup/Front/left, 2 : $Panel/PlayerGroup/Front/mid, 3 : $Panel/PlayerGroup/Front/right,
4 : $Panel/PlayerGroup/Back/left, 5 : $Panel/PlayerGroup/Back/mid, 6 : $Panel/PlayerGroup/Back/right,
7 : $Panel2/EnemyGroup/Front/left, 8 : $Panel2/EnemyGroup/Front/mid, 9 : $Panel2/EnemyGroup/Front/right,
10: $Panel2/EnemyGroup/Back/left, 11 : $Panel2/EnemyGroup/Back/mid, 12 : $Panel2/EnemyGroup/Back/right}

var no_material_reward = false
var external_reward
var only_show_mat_reward = false

var dummy = {
	triggered_effects = []
}

signal skill_use_finshed


func _ready():
	if gui_controller.mansion != null:
		debug = gui_controller.mansion.test_mode
	autoskill_dummy = ResourceScripts.scriptdict.class_slave.new("combat_dummy")
	autoskill_dummy.position = 0
	autoskill_dummy.displaynode = ResourceScripts.scriptdict.fighternode.new()
	autoskill_dummy.displaynode.animation_node = CombatAnimations
	autoskill_dummy.displaynode.fighter = autoskill_dummy
	autoskill_dummy.npc_reference = 'combat_global'
	#test fix
	add_child(autoskill_dummy.displaynode)
	autoskill_dummy.displaynode.visible = false
	#----
	battlefield.resize(14)
	for i in range(1,13):
		battlefield[i] = null
	add_child(CombatAnimations)
	$ItemPanel/debugvictory.connect("pressed",self, 'cheatvictory')
	$Rewards/CloseButton.connect("pressed",self,'FinishCombat')
	$Menu/Items.connect("toggled", self, "open_items")
	$Menu/Run.connect("pressed", self, "run")
	$ItemPanel.hide()
	
	$Button.connect("pressed", self, "on_skillbook_click")
	$SkillBook.connect("closing", self, "RebuildSkillPanel")

func on_skillbook_click():
	$SkillBook.activecharacter = activecharacter
	$SkillBook.toggle()
	RebuildSkillPanel()


func _input(event):
	#simple version based on legacy code and without proper keybinding
	if !allowaction: return
	if str(event.as_text().replace("Kp ",'')) in str(range(1,9)):
		var skill_index = int(event.as_text().replace("Kp ",''))
		if activecharacter == null: return
		var src = activecharacter.skills.combat_skill_panel
		if !src.has(skill_index): return
		var skill = src[skill_index]
		var skill_data = Skilldata.get_template(skill, activecharacter)
		if !activecharacter.can_use_skill(skill_data): return
		#possible not reqired
		if !activecharacter.has_status('ignore_catalysts_for_%s' % skill):
			for i in skill_data.catalysts:
				if ResourceScripts.game_res.materials[i] < skill_data.catalysts[i]: return
		if skill_data.charges > 0 and activecharacter.skills.combat_skill_charges.has(skill) and activecharacter.skills.combat_skill_charges[skill] >= skill_data.charges: return
		SelectSkill(skill)


func run():
	defeat(true)


var norun_mode = false
func set_norun_mode(value):
	norun_mode = value


func open_items(pressed):
	$StatsPanel_v2.hide()
	$ItemPanel.visible = pressed


func cheatvictory():
	victory()
#	for i in enemygroup:
#		var tchar = characters_pool.get_char_by_id(enemygroup[i])
#		tchar.hp = 0
	#checkwinlose()


func reset_combat_data():
	combat_data.instawin = false
	combat_data.hpmod = 1.0
	combat_data.xp_mod = 1.0
	combat_data.enemy_stats_mod = 1.0


func start_combat(newplayergroup, newenemygroup, background, music = 'battle1', t_combat_data = {}):
	if images.backgrounds.has(background):
		$Background.texture = images.get_background(background)
	else:
		$Background.texture = images.get_background('dungeon')
	if music == "default":
		music = 'battle1'
	no_material_reward = false
	only_show_mat_reward = false
	external_reward = null
	hide()
	
	$ItemPanel/debugvictory.visible = debug
	# if variables.combat_tests == false:
	# 	ResourceScripts.core_animations.BlackScreenTransition(0.5)
	# 	yield(get_tree().create_timer(0.5), 'timeout')
	input_handler.emit_signal("CombatStarted", encountercode)
	# input_handler.ActivateTutorial("combat")
	show()
	input_handler.combat_node = self
	gui_controller.combat = self
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = self
	autoskill = null
	turns = 0
	global_turn = 0
	$Combatlog/RichTextLabel.clear()
	summons.clear()
	enemygroup.clear()
	playergroup.clear()
	turnorder.clear()
	if music == 'combattheme':
		var temparray = ['battle1','battle2','battle3']
		music = temparray[randi()%temparray.size()]
	input_handler.SetMusic(music)
	fightover = false
	$Rewards.visible = false
	allowaction = false
	$Button.disabled = true
	reset_combat_data()
	for arg in combat_data:
		if t_combat_data.has(arg):
			combat_data[arg] = t_combat_data[arg]
	enemygroup = newenemygroup
	playergroup = newplayergroup
	for i in range(1,13):
		battlefield[i] = null
	buildenemygroup(enemygroup)
	buildplayergroup(playergroup)
	autoskill_dummy.is_active = true
	#victory()
	#start combat triggers
	CombatAnimations.force_end()
	if combat_data.instawin:
		victory()
	else:
		ActionQueue = queue_script.new()
		ActionQueue.combatnode = self
		ActionQueue.animationnode = CombatAnimations
		for i in playergroup.values() + enemygroup.values():
			var tchar = characters_pool.get_char_by_id(i)
			tchar.process_event(variables.TR_COMBAT_S)
			ActionQueue.add_rebuildbuffs(tchar.displaynode)
		set_process_input(true)
		ActionQueue.add_start_combat()
		ActionQueue.invoke_resume()



func buildenemygroup(enemygroup):
	for i in range(1,7):
		if enemygroup[i] != null:
			enemygroup[i+6] = enemygroup[i]
		enemygroup.erase(i)
	
	for i in enemygroup:
		if enemygroup[i] == 'boss':
			continue
		if enemygroup[i] == null:
			continue
		var tempname = enemygroup[i]
		var rare = false
		var mboss = false
		if tempname.ends_with('_rare'):
			tempname = tempname.trim_suffix('_rare')
			rare = true
		if tempname.ends_with('_miniboss'):
			tempname = tempname.trim_suffix('_miniboss')
			mboss = true
		var tchar = ResourceScripts.scriptdict.class_slave.new("combat_enemy")
		enemygroup[i] = characters_pool.add_char(tchar)
		tchar.generate_simple_fighter(tempname)
		tchar.combatgroup = 'enemy'
		tchar.position = i
		if rare:
			tchar.add_rare_trait()
		if mboss:
			tchar.tags.push_back("miniboss")
			tchar.add_trait('miniboss')
		tchar.add_trait('core_trait')
	
	for i in enemygroup:
		if enemygroup[i] == null:
			continue
		var tchar = characters_pool.get_char_by_id(enemygroup[i])
		for stat in ['hpmax', 'xpreward']:
			tchar.mul_stat(stat, combat_data.enemy_stats_mod)
		for stat in ['atk', 'matk', 'armor']:
			tchar.mul_stat(stat, min(combat_data.enemy_stats_mod, variables.survival_cap_main))
		for stat in ['hitrate', 'evasion']:
			tchar.mul_stat(stat, min(combat_data.enemy_stats_mod, variables.survival_cap_secondary))
		tchar.hp = tchar.get_stat("hpmax") * combat_data.hpmod
		tchar.mp = tchar.get_stat("mpmax")
		battlefield[int(i)] = enemygroup[i]
		make_fighter_panel(tchar, i)



func buildplayergroup(group):
	#to remake getting data from state
	#operating this data was remade
	playergroup = {}
	for i in group:
		if int(i) > 6: break
		if group[i] == null:
			continue
		playergroupcounter += 1
		var fighter = ResourceScripts.game_party.characters[group[i]]
		fighter.combatgroup = 'ally'
		battlefield[int(i)] = fighter.id
		playergroup[int(i)] = fighter.id #only change
		fighter.setup_etb()
	
	for i in playergroup:
		var fighter = characters_pool.get_char_by_id(playergroup[i])
		make_fighter_panel(fighter, i)
	fill_summons()


func fill_summons(): 
	for i in [4, 5, 6, 1, 2, 3]:
		if battlefield[i] == null: 
			continue
		var tchar = get_char_by_pos(i)
		for summon in Enemydata.summons:
			if tchar.has_status(summon):
				var data = Enemydata.summons[summon]
				var amount = 0.0
				for rec in data.amount:
					if rec is Dictionary:
						amount += tchar.get_stat(rec.stat) * rec.mod
					else:
						amount += rec
				amount = int(ceil(amount))
				for ii in range(amount):
					summon(data.summon, 6, 'ally')


func make_fighter_panel(fighter, spot):
	spot = int(spot)
	var container = battlefieldpositions[int(spot)]
	var panel = $Panel/PlayerGroup/Back/left/Template.duplicate()
	panel.visible = true
	panel.material = load("res://assets/sfx/BarrierShader.tres").duplicate()
	#panel.material = $Panel/PlayerGroup/Back/left/Template.material.duplicate()
	panel.get_node('border').material = $Panel/PlayerGroup/Back/left/Template.get_node('border').material.duplicate()
	fighter.displaynode = panel
	panel.name = 'Character'
	panel.set_script(ResourceScripts.scriptdict.fighternode)
	panel.position = int(spot)
	panel.animation_node = CombatAnimations
	CombatAnimations.connect('alleffectsfinished', panel, 'check_active')
	fighter.position = int(spot)
	panel.fighter = fighter
	panel.hp = fighter.hp
	panel.mp = fighter.mp
	panel.connect("signal_RMB", self, "ShowFighterStats")
	# panel.connect("signal_RMB_release", self, 'HideFighterStats')
	panel.connect("signal_LMB", self, 'FighterPress')
	panel.connect("mouse_entered", self, 'FighterMouseOver', [fighter.id])
	panel.connect("mouse_exited", self, 'FighterMouseOverFinish', [fighter.id])
	if variables.CombatAllyHpAlwaysVisible && fighter.combatgroup == 'ally':
		panel.get_node("bars/HP/hplabel").show()
		panel.get_node("bars/MP/mplabel").show()
	if fighter.combatgroup != 'ally':
		panel.get_node("bars/MP").visible = false
#	panel.set_meta('character',fighter)
	panel.get_node("Icon").texture = fighter.get_icon()
	panel.get_node('Icon').material = load("res://assets/sfx/bw_shader.tres").duplicate()
	panel.turn_overlay(false)
	panel.get_node("bars/HP").value = input_handler.calculatepercent(fighter.hp, fighter.get_stat('hpmax'))
	panel.get_node("bars/MP").value = input_handler.calculatepercent(fighter.mp, fighter.get_stat('mpmax'))
	panel.hp = fighter.hp
	panel.update_hp_label(fighter.hp, 100.0)
	panel.update_mp_label(fighter.mp, 100.0)
	if fighter.get_stat('mpmax') == 0:
		panel.get_node("bars/MP").value = 0
	panel.get_node("Label").text = fighter.get_short_name()
	if fighter.get_short_name().length() > 10:
		panel.get_node('Label').set("custom_fonts/font",load("res://MainFont_Small.tres"))
	container.add_child(panel)
	panel.rect_position = Vector2(0,0)
	#setuping target glowing
	var g_color;
	if spot < 7:
		g_color = Color(0.0, 1.0, 0.0, 0.0);
	else:
		g_color = Color(1.0, 0.0, 0.0, 0.0);
	panel.material.set_shader_param('modulate', g_color);
	panel.turn_overlay(false)
	panel.noq_rebuildbuffs()


func checkdeaths():
	for i in range(battlefield.size()):
		if battlefield[i] == null: 
			continue
		var tchar = get_char_by_pos(i)
		if tchar.defeated != true && tchar.hp <= 0:
			#tchar.displaynode.defeat()
			#tchar.death()
			tchar.defeated = true
			tchar.hp = 0
			input_handler.emit_signal('fighter_changed')
			combatlogadd("\n" + tchar.get_short_name() + " has been defeated.\n")
			for j in range(turnorder.size()):
				if turnorder[j].pos == i:
					turnorder.remove(j)
					update_queue_asynch()
					break
			#turnorder.erase(battlefield[i])
			if summons.has(i):
				tchar.displaynode.queue_free()
				tchar.displaynode = null
				tchar.is_active = false
				battlefield[i] = null
				if tchar.combatgroup == 'enemy':
					enemygroup.erase(i)
				else:
					playergroup.erase(i)
				summons.erase(i)


var playergroupcounter = 0
func checkwinlose():
	if fightover == true:
		return true
	playergroupcounter = 0
	var enemygroupcounter = 0
	for i in range(battlefield.size()):
		if battlefield[i] == null:
			continue
		if get_char_by_pos(i).defeated:
			continue
		if i in range(1,7):
			playergroupcounter += 1
		else:
			enemygroupcounter += 1
	if playergroupcounter <= 0:
		ActionQueue.add_end_combat(false)
		if !ActionQueue.is_active:
			ActionQueue.invoke()
		return true
	elif enemygroupcounter <= 0:
		ActionQueue.add_end_combat(true)
		if !ActionQueue.is_active:
			ActionQueue.invoke()
		return true
	for i in range(battlefield.size()):
		if battlefield[i] == null:
			continue
		if get_char_by_pos(i).defeated:
			continue
	return false


func force_newturn():
	calculateorder()
	newturn()
	select_actor()


func select_actor():
	if !ActionQueue.is_empty():
		if !ActionQueue.is_active:
			ActionQueue.invoke()
		yield(ActionQueue, 'queue_empty')
	
	ActionQueue.reinit()
	ClearSkillTargets()
	ClearSkillPanel()
	ClearItemPanel()
	checkdeaths()
	if checkwinlose() == true:
		return
	if turnorder.empty():
		#to test, maybe this is wrong decision
		calculateorder()
		newturn()
	currentactor = turnorder[0].pos
	turnorder.remove(0)
	update_queue_asynch()
	#currentactor.update_timers()
	current_turn()


func current_turn():
	if checkwinlose() == true:
		return
	if currentactor <= 0:
		env_turn()
	elif currentactor < 7:
		player_turn()
	else:
		enemy_turn()


func newturn():
	effects_pool.process_event(variables.TR_TURN_S)
	global_turn += 1
	for i in playergroup.values() + enemygroup.values():
		var tchar = characters_pool.get_char_by_id(i)
		tchar.process_event(variables.TR_TURN_S)
		tchar.displaynode.rebuildbuffs()
		#not sure about keeping all beyond - dis part, mb needs reworking
		var cooldowncleararray = []
		for k in tchar.skills.combat_cooldowns:
			if tchar.skills.combat_cooldowns[k] < 0: continue
			tchar.skills.combat_cooldowns[k] -= 1
			if tchar.skills.combat_cooldowns[k] <= 0:
				cooldowncleararray.append(k)
		for k in cooldowncleararray:
			tchar.skills.combat_cooldowns.erase(k)


func calculateorder():
	turnorder.clear()
	if autoskill != null:
		turnorder.append({pos = 0, speed = 100})
	for pos in playergroup:
		var tchar = get_char_by_pos(pos)
		if tchar.defeated == true:
			continue
		turnorder.append({speed = tchar.get_stat('speed') + randf() * 5, pos = pos})
	for pos in enemygroup:
		var tchar = get_char_by_pos(pos)
		if tchar.defeated == true:
			continue
		turnorder.append({speed = tchar.get_stat('speed') + randf() * 5, pos = pos})
	
	turnorder.sort_custom(self, 'speedsort')
#	update_queue_asynch()


func speedsort(first, second):
	return first.speed > second.speed


func player_turn():
	var pos = currentactor
	# battlefieldpositions[pos].get_node("Character/Active").show()
	for position in battlefieldpositions.values():
		if position.get_node_or_null("Character"):
			position.get_node("Character/Active").visible = battlefieldpositions[pos] == position
	turns += 1
	var selected_character = get_char_by_pos(pos)
	activecharacter = selected_character
	#selected_character.update_timers()
	selected_character.process_event(variables.TR_TURN_GET)
	effects_pool.process_event(variables.TR_TURN_GET, selected_character)
	selected_character.displaynode.rebuildbuffs()
	CombatAnimations.check_start()
#	$Panel3.texture = load("res://assets/Textures_v2/BATTLE/Panels/panel_battle_nameturn_l.png")
#	$Panel3/Label.text = selected_character.get_short_name()
	if CombatAnimations.is_busy: 
		yield(CombatAnimations, 'alleffectsfinished')
	turns += 1
	if !selected_character.can_act():
		#combatlogadd("%s cannot act" % selected_character.name)
		selected_character.process_event(variables.TR_TURN_F)
		effects_pool.process_event(variables.TR_TURN_F, selected_character)
		selected_character.displaynode.rebuildbuffs()
		call_deferred('select_actor')
		return
	if selected_character.has_status('confuse'):
		activeaction = selected_character.get_skill_by_tag('default')
		var activeaction_data = Skilldata.get_template_combat(activeaction, selected_character)
		UpdateSkillTargets(selected_character, activeaction_data, true)
		var targ = get_random_target()
		use_skill(activeaction, selected_character, targ)
		return
	if selected_character.has_status('taunt_hard'):
		var tchar = characters_pool.get_char_by_id(selected_character.get_stat('taunt'))
#		selected_character.taunt = null
		if can_be_taunted(selected_character, tchar):
			use_skill(selected_character.get_skill_by_tag('default'), selected_character, tchar)
			return
		else:
			selected_character.process_event(variables.TR_TAUNT_FAIL)
	CombatAnimations.check_start()
	if CombatAnimations.is_busy: 
		yield(CombatAnimations, 'alleffectsfinished')
	$Panel3.visible = true
	$Menu/Run.disabled = norun_mode
	#allowaction = true
	RebuildSkillPanel()
	RebuildItemPanel()
	SelectSkill(selected_character.selectedskill)



func enemy_turn():
	var pos = currentactor
	for position in battlefieldpositions.values():
		if position.get_node_or_null("Character"):
			position.get_node("Character/Active").visible = battlefieldpositions[pos] == position
	$Menu/Run.disabled = true
	turns += 1
	var fighter = get_char_by_pos(pos)
	$Panel3.visible = false
#	$Panel3.texture = load("res://assets/Textures_v2/BATTLE/Panels/panel_battle_nameturn_r.png")
#	$Panel3/Label.text = fighter.get_short_name()
	#fighter.update_timers()
	fighter.process_event(variables.TR_TURN_GET)
	effects_pool.process_event(variables.TR_TURN_GET, fighter)
	fighter.displaynode.rebuildbuffs()
	CombatAnimations.check_start()
	if CombatAnimations.is_busy: 
		yield(CombatAnimations, 'alleffectsfinished')
	if !fighter.can_act():
		#combatlogadd("%s cannot act" % fighter.name)
		fighter.process_event(variables.TR_TURN_F)
		effects_pool.process_event(variables.TR_TURN_F, fighter)
		fighter.displaynode.rebuildbuffs() #I got error here once @SphinxKingStone
		call_deferred('select_actor')
		return
	#Selecting active skill
	
	Highlight(pos, 'enemy')
	
	turns += 1
	var castskill = fighter.ai._get_action()
	var target = fighter.ai._get_target(castskill)
	if target == null:
		castskill = fighter.ai._get_action(true)
		target = fighter.ai._get_target(castskill)
	if target == null:
		checkwinlose()
		return
	target = get_char_by_pos(target)

	if fighter.has_status('confuse'):
		castskill = fighter.get_skill_by_tag('default')
		activeaction = castskill
		var activeaction_data = Skilldata.get_template_combat(activeaction, fighter)
		UpdateSkillTargets(fighter, activeaction_data, true)
		target = get_random_target()
	if fighter.has_status('taunt_hard'):
		var targ = characters_pool.get_char_by_id(fighter.get_stat('taunt'))
#		fighter.taunt = null
		if can_be_taunted(fighter, targ):
			target = targ;
			castskill = fighter.get_skill_by_tag('default')
		else:
			fighter.process_event(variables.TR_TAUNT_FAIL)
	if target == null:
		print(fighter.get_short_name(), ' no target found')
		return
	use_skill(castskill, fighter, target)



func env_turn():
	if autoskill == null: return
	if autoskill_delay_rem <= 0:
		autoskill_delay_rem = autoskill_delay
		turns += 1
		activecharacter = autoskill_dummy
		autoskill_times -= 1
		use_skill(autoskill, autoskill_dummy, get_proper_target_for_autoskill(), variables.SKILL_AUTO)
		if autoskill_times == 0: 
			autoskill = null
		CombatAnimations.check_start()
		if CombatAnimations.is_busy: 
			yield(CombatAnimations, 'alleffectsfinished')
	else:
		autoskill_delay_rem -= 1


#rangetypes melee, any, backmelee

func UpdateSkillTargets(caster, skill, glow_skip = false):
#	var skill = Skilldata.get_template(activeaction, caster)
	var fighter = caster
	var targetgroups = skill.target
	var rangetype = skill.target_range
	ClearSkillTargets()

	for i in $SkillPanel.get_children() + $ItemPanel/ScrollContainer/GridContainer.get_children():
		if i.has_meta('skill'):
			i.pressed = i.get_meta('skill') == skill.code

	#not sure if this is correct
	if rangetype == 'weapon': rangetype = fighter.get_weapon_range()
	highlightargets = true
	allowedtargets.clear()
	allowedtargets = {ally = [], enemy = []}

	#assuming no player skills are battlefield-scale
	if targetgroups == 'enemy' or targetgroups == 'all':
		var t_targets
		if rangetype == 'any': t_targets = get_enemy_targets_all(fighter)
		if rangetype == 'melee': t_targets = get_enemy_targets_melee(fighter)
		for t in t_targets:
			if skill.has('targetreqs') and !t.checkreqs(skill.targetreqs):
				continue
#			if !t.can_be_damaged(skill): 
#				continue
			allowedtargets.enemy.push_back(t.position)
	if targetgroups == 'ally' or targetgroups == 'all':
		var t_targets = get_allied_targets(fighter)
		if rangetype == 'dead':
			t_targets.clear()
			for t in playergroup.values():
				var tchar = characters_pool.get_char_by_id(t)
				if tchar.defeated:
					t_targets.push_back(tchar)
			pass
		for t in t_targets:
			if rangetype == 'not_caster' and t.id == caster.id: continue
			if skill.has('targetreqs') and !t.checkreqs(skill.targetreqs): continue
			allowedtargets.ally.push_back(t.position)
	if targetgroups == 'self':
		allowedtargets.ally.append(int(fighter.position))

	if glow_skip: return

	Highlight(currentactor,'selected')
	Off_Target_Glow();
	for f in allowedtargets.enemy:
		Target_Glow(f);
	for f in allowedtargets.ally:
		Target_Glow(f);


func ClearSkillTargets():
	for pos in range(battlefield.size()):
		if battlefield[pos] == null: continue
		if get_char_by_pos(pos).displaynode == null: continue #this check obviosly covers some bug still needed to be found and fixen
		StopHighlight(pos)


func FindFighterRow(fighter):
	var pos = fighter.position
	if pos in range(4,7) || pos in range(10,13):
		pos = 'backrow'
	else:
		pos = 'frontrow'
	return pos


func CheckMeleeRange(group, hide_ignore = false): #Check if group front row is still in place
	var rval = false
	var counter = 0
	#reqires adding hide checks
	match group:
		'enemy':
			for pos in range(7,10):
				if battlefield[pos] == null:continue
				var tchar = get_char_by_pos(pos)
				if tchar.defeated == true: continue
				if tchar.has_status('hide') and !hide_ignore: continue
				counter += 1
		'ally':
			for pos in range(1,4):
				if battlefield[pos] == null:continue
				var tchar = get_char_by_pos(pos)
				if tchar.defeated == true: continue
				if tchar.has_status('hide') and !hide_ignore: continue
				counter += 1
	if counter > 0: rval = true
	return rval


func can_be_taunted(caster, target):
	if target.defeated: return false
	match target.combatgroup:
		'ally':
			if target.position < 4: return true
			if !CheckMeleeRange('ally'): return true
		'enemy':
			if target.position < 10: return true
			if !CheckMeleeRange('enemy'): return true
	var s_code = caster.get_skill_by_tag('default')
	var skill = Skilldata.get_template(s_code, caster)
	return (skill.target_range == 'any')



func setup_autoskill(data, person):
	autoskill = data.skill
	if data.has('delay'):
		autoskill_delay = data.delay
	else:
		autoskill_delay = 0
	autoskill_delay_rem = autoskill_delay
	if data.has('number'):
		autoskill_times = data.number
	else:
		autoskill_times = -1
	autoskill_dummy.combatgroup = "_" + person.combatgroup
	autoskill_dummy.set_stat('atk', person.get_stat('atk'))
	autoskill_dummy.set_stat('matk', person.get_stat('matk'))


var fighterhighlighted = false
func FighterShowStats(fighter):
	var panel = fighter.displaynode
	panel.get_node("bars/HP/hplabel").show()
	panel.get_node("bars/MP/mplabel").show()
	
	$StatsPanelLeft.fill(fighter)
	$StatsPanelRight.fill(fighter)


func FighterMouseOver(id, no_press = false):
	var fighter = characters_pool.get_char_by_id(id)
	FighterShowStats(fighter)
	$StatsPanelLeft.visible = fighter.combatgroup != 'enemy'
	$StatsPanelRight.visible = fighter.combatgroup == 'enemy'
	if allowaction == true && no_press == false && (allowedtargets.enemy.has(fighter.position) || allowedtargets.ally.has(fighter.position)):
		if customcursor != null:
			Input.set_custom_mouse_cursor(images.cursors[customcursor])
		elif fighter.combatgroup == 'enemy':
			Input.set_custom_mouse_cursor(images.cursors.attack)
		else:
			Input.set_custom_mouse_cursor(images.cursors.support)
		var cur_targets = [];
		cur_targets = CalculateTargets(Skilldata.get_template(activeaction, activecharacter), fighter);
		Stop_Target_Glow();
		for c in cur_targets:
			Target_eff_Glow(c.position);
	elif no_press:
		Stop_Target_Glow()
		Target_Glow(fighter.position)


func FighterMouseOverFinish(id):
	var fighter = characters_pool.get_char_by_id(id)
	var panel = fighter.displaynode
	fighterhighlighted = false
	$StatsPanelRight.visible = false
	$StatsPanelLeft.visible = false
	if variables.CombatAllyHpAlwaysVisible == false || fighter.combatgroup == 'enemy':
		panel.get_node("bars/HP/hplabel").hide()
		panel.get_node("bars/MP/mplabel").hide()
	Input.set_custom_mouse_cursor(images.cursors.default)
	if !allowaction: return
	Stop_Target_Glow()
	for f in allowedtargets.enemy:
		Target_Glow(f)
	for f in allowedtargets.ally:
		Target_Glow(f)


func ShowFighterStats(id):
	var fighter = characters_pool.get_char_by_id(id)
	$ItemPanel.hide()
	$Menu/Items.pressed = false
	if fightover == true:
		return
	$StatsPanel_v2.show()
	$StatsPanel_v2.open(fighter)


func HideFighterStats():
	$StatsPanel_v2.hide()


func FighterPress(pos):
	if allowaction == false || (!allowedtargets.enemy.has(pos) && !allowedtargets.ally.has(pos)):
		return
	ClearSkillTargets()
	ClearItemPanel()
	ClearSkillPanel()
	use_skill(activeaction, activecharacter, get_char_by_pos(pos))


func transform_unit(position, id):
	var combatgroup = 'enemy'
	if position < 7:
		print('warning - transforming player character, may be error')
		combatgroup = 'ally'
	var ch_id = battlefield[position]
	if ch_id == null:
		print('error - transforming wrong position')
		return
	
	var tchar = characters_pool.get_char_by_id(ch_id)
	tchar.displaynode.name = 'temp'
	tchar.displaynode.queue_free()
	tchar.displaynode = null
	tchar.is_active = false
	battlefield[position] = null
	if tchar.combatgroup == 'enemy':
		enemygroup.erase(position)
	else:
		playergroup.erase(position)
	
	tchar = ResourceScripts.scriptdict.class_slave.new("combat_transform");
#	tchar.createfromenemy(montype);
	match combatgroup:
		'enemy':
			tchar.generate_simple_fighter(id)
			tchar.combatgroup = 'enemy'
			enemygroup[position] = characters_pool.add_char(tchar)
			battlefield[position] = enemygroup[position]
		'ally':
			tchar.generate_simple_fighter(id, false)
			tchar.combatgroup = 'ally'
			playergroup[position] = characters_pool.add_char(tchar)
			battlefield[position] = playergroup[position]
			tchar.selectedskill = tchar.get_skill_by_tag('default')
	tchar.position = position
	tchar.hp = tchar.get_stat("hpmax")
	tchar.mp = tchar.get_stat("mpmax")
	tchar.add_trait('core_trait')
	
	make_fighter_panel(tchar, position)
	tchar.process_event(variables.TR_COMBAT_S)
	ActionQueue.add_rebuildbuffs(tchar.displaynode)


func summon(montype, limit, combatgroup, incombat = false): #reworked
	if summons.size() >= limit: return
	#find empty slot in group
	if montype is String:
		montype = [montype, montype]
	var group
	var group2 = null
	var slot = 2
	match combatgroup:
		'enemy':
			if montype[0] == null:
				group = [10, 11, 12]
				group2 = [7, 8, 9]
				slot = 1
			elif montype[1] == null:
				group = [7, 8, 9]
				group2 = [10, 11, 12]
				slot = 0
			else:
				group = [7, 8, 9, 10, 11, 12]
		'ally':
			if montype[0] == null:
				group = [4, 5, 6]
				group2 = [1, 2, 3]
				slot = 1
			elif montype[1] == null:
				group = [1, 2, 3]
				group2 = [4, 5, 6]
				slot = 0
			else:
				group = [1, 2, 3, 4, 5, 6]
	var pos = [];
	for p in group:
		if battlefield[p] == null: 
			pos.push_back(p)
	if pos.size() == 0: 
		if group2 == null:
			return
		for p in group2:
			if battlefield[p] == null: 
				pos.push_back(p)
		if pos.size() == 0: 
			return
	var sum_pos = input_handler.random_from_array(pos)
	summons.push_back(sum_pos)
	if slot == 2:
		if sum_pos in [1, 2, 3, 7, 8, 9]:
			slot = 0
		else:
			slot = 1
	var tchar = ResourceScripts.scriptdict.class_slave.new("combat_summon");
#	tchar.createfromenemy(montype);
	match combatgroup:
		'enemy':
			enemygroup[sum_pos] = characters_pool.add_char(tchar)
			tchar.generate_simple_fighter(montype[slot])
			tchar.combatgroup = 'enemy'
			battlefield[sum_pos] = enemygroup[sum_pos]
		'ally':
			playergroup[sum_pos] = characters_pool.add_char(tchar)
			tchar.generate_simple_fighter(montype[slot], false)
			tchar.combatgroup = 'ally'
			tchar.is_players_character = true
			battlefield[sum_pos] = playergroup[sum_pos]
			tchar.selectedskill = tchar.get_skill_by_tag('default')
	tchar.position = sum_pos
	tchar.hp = tchar.get_stat("hpmax")
	tchar.mp = tchar.get_stat("mpmax")
	tchar.add_trait('core_trait')
	
	make_fighter_panel(tchar, sum_pos)
	if incombat:
		tchar.process_event(variables.TR_COMBAT_S)
		ActionQueue.add_rebuildbuffs(tchar.displaynode)



func use_skill(skill_code, caster, target, mode = variables.SKILL_BASE):
	if !ActionQueue.is_empty():
		print('error - activating skill on non-empty queue')
		return
	$ItemPanel.hide()
	$Menu/Items.pressed = false
	if activeaction != skill_code:
		activeaction = skill_code
	allowaction = false
	$Button.disabled = true
	var template = Skilldata.get_template_combat(skill_code, caster)
	if template.ability_type == 'item':
		mode = variables.SKILL_ITEM
	var tmp_handler = ActionQueue.add_skill_callback()
	tmp_handler.mode = mode
	tmp_handler.parent = self
	tmp_handler.createfromskill(template)
	tmp_handler.setup_caster(caster)
	tmp_handler.setup_target(target)
	ActionQueue.invoke()


func get_char_by_pos(pos):
	return characters_pool.get_char_by_id(battlefield[pos])


#autoskills should have no variations
func get_proper_target_for_autoskill():
	var skill = Skilldata.Skilllist[autoskill]
	var temp = []
	match skill.target:
		'ally':
			if autoskill_dummy.combatgroup == '_ally':
				for p in playergroup.values():
					if !characters_pool.get_char_by_id(p).defeated: temp.push_back(characters_pool.get_char_by_id(p))
			elif autoskill_dummy.combatgroup == '_enemy':
				for p in enemygroup.values():
					if !characters_pool.get_char_by_id(p).defeated: temp.push_back(characters_pool.get_char_by_id(p))
		'enemy':
			if autoskill_dummy.combatgroup == '_ally':
				for p in enemygroup.values():
					if !characters_pool.get_char_by_id(p).defeated: temp.push_back(characters_pool.get_char_by_id(p))
			elif autoskill_dummy.combatgroup == '_enemy':
				for p in playergroup.values():
					if !characters_pool.get_char_by_id(p).defeated: temp.push_back(characters_pool.get_char_by_id(p))
		'full':
			for p in enemygroup.values():
				if !characters_pool.get_char_by_id(p).defeated: temp.push_back(characters_pool.get_char_by_id(p))
			for p in playergroup.values():
				if !characters_pool.get_char_by_id(p).defeated: temp.push_back(characters_pool.get_char_by_id(p))
	if !temp.empty():
		return temp[globals.rng.randi_range(0, temp.size()-1)]
	else: return null


func get_allied_targets(fighter):
	var res = []
	if fighter.position in range(1, 7):
		for p in playergroup.values():
			var tchar = characters_pool.get_char_by_id(p)
			if !tchar.defeated:
				res.push_back(tchar)
	else:
		for p in enemygroup.values():
			var tchar = characters_pool.get_char_by_id(p)
			if !tchar.defeated:
				res.push_back(tchar)
	return res


func get_enemy_targets_all(fighter, ignore_immune = false):
	var res = []
	if fighter.position in range(1, 7):
		for p in enemygroup.values():
			var tchar = characters_pool.get_char_by_id(p)
			if tchar.defeated: 
				continue
			if tchar.has_status('hide') and !ignore_immune: 
				continue
			if tchar.has_status('warded') and !ignore_immune: 
				continue
			res.push_back(tchar)
	else:
		for p in playergroup.values():
			var tchar = characters_pool.get_char_by_id(p)
			if tchar.defeated: 
				continue
			if tchar.has_status('hide') and !ignore_immune: 
				continue
			if tchar.has_status('warded') and !ignore_immune: 
				continue
			res.push_back(tchar)
	return res


func get_enemy_targets_melee(fighter, ignore_immune = false):
	var res = []
	if fighter.position in range(1, 7):
		for p in enemygroup.values():
			var tchar = characters_pool.get_char_by_id(p)
			if tchar.defeated: continue
			if tchar.has_status('hide') and !ignore_immune: 
				continue
			if CheckMeleeRange('enemy', ignore_immune) and tchar.position > 9: 
				continue
			if tchar.has_status('warded') and !ignore_immune: 
				continue
			res.push_back(tchar)
	else:
		for p in playergroup.values():
			var tchar = characters_pool.get_char_by_id(p)
			if tchar.defeated: 
				continue
			if tchar.has_status('hide') and !ignore_immune: 
				continue
			if CheckMeleeRange('ally', ignore_immune) and tchar.position > 3: 
				continue
			if tchar.has_status('warded') and !ignore_immune: continue
			res.push_back(tchar)
	return res



func CalculateTargets(skill, target, finale = false):
	var array = []
	if target == null: 
		return array
	
	var targetgroup
	if int(target.position) in range(1,7):
		targetgroup = 'player'
	else:
		targetgroup = 'enemy'
#	if skill.target == 'full':
#		targetgroup = 'full'
	
	match skill.target_number:
		'single':
			array = [target]
		'row':
			for i in variables.rows:
				if variables.rows[i].has(target.position):
					for j in variables.rows[i]:
						if battlefield[j] == null : continue
						var tchar = get_char_by_pos(j)
						if tchar.defeated: continue
						if !tchar.can_be_damaged(skill) and !finale: continue
						array.append(tchar)
		'line':
			for i in variables.lines:
				if variables.lines[i].has(target.position):
					for j in variables.lines[i]:
						if battlefield[j] == null : continue
						var tchar = get_char_by_pos(j)
						if tchar.defeated: continue
						if !tchar.can_be_damaged(skill) and !finale: continue
						array.append(tchar)
		'all':
			for j in range(1, 13):
				if j in range(1,7) && targetgroup == 'player':
					if battlefield[j] == null : continue
					var tchar = get_char_by_pos(j)
					if tchar.defeated: continue
					if !tchar.can_be_damaged(skill) and !finale: continue
					array.append(tchar)
				elif j in range(7, 13) && targetgroup == 'enemy':
					if battlefield[j] == null : continue
					var tchar = get_char_by_pos(j)
					if tchar.defeated: continue
					if !tchar.can_be_damaged(skill) and !finale: continue
					array.append(tchar)
				elif targetgroup == 'full':
					if battlefield[j] == null : continue
					var tchar = get_char_by_pos(j)
					if tchar.defeated: continue
					if !tchar.can_be_damaged(skill) and !finale: continue
					array.append(tchar)
		'all_allowed':
			array.clear()
			for pos in allowedtargets.enemy + allowedtargets.ally:
				var tchar = get_char_by_pos(pos)
				array.push_back(tchar)
		'nontarget':
			for j in range(1, 13):
				if target.position == j: 
					continue
				if j in range(1,7) && targetgroup == 'player':
					if battlefield[j] == null : continue
					var tchar = get_char_by_pos(j)
					if tchar.defeated: continue
					if !tchar.can_be_damaged(skill) and !finale: continue
					array.append(tchar)
				elif j in range(7, 13) && targetgroup == 'enemy':
					if battlefield[j] == null : continue
					var tchar = get_char_by_pos(j)
					if tchar.defeated: continue
					if !tchar.can_be_damaged(skill) and !finale: continue
					array.append(tchar)
				elif targetgroup == 'full':
					if battlefield[j] == null : continue
					var tchar = get_char_by_pos(j)
					if tchar.defeated: continue
					if !tchar.can_be_damaged(skill) and !finale: continue
					array.append(tchar)
		'nontarget_group':
			for j in range(1, 13):
				if target.position == j: continue
				if j in range(1,7) && targetgroup == 'enemy':
					if battlefield[j] == null : continue
					var tchar = get_char_by_pos(j)
					if tchar.defeated: continue
					if !tchar.can_be_damaged(skill) and !finale: continue
					array.append(tchar)
				elif j in range(7, 13) && targetgroup == 'player':
					if battlefield[j] == null : continue
					var tchar = get_char_by_pos(j)
					if tchar.defeated: continue
					if !tchar.can_be_damaged(skill) and !finale: continue
					array.append(tchar)
		'single_nontarget':
			for j in range(1, 13):
				if target.position == j: continue
				if j in range(1,7) && targetgroup == 'player':
					if battlefield[j] == null : continue
					var tchar = get_char_by_pos(j)
					if tchar.defeated: continue
					if !tchar.can_be_damaged(skill) and !finale: continue
					array.append(tchar)
				elif j in range(7, 13) && targetgroup == 'enemy':
					if battlefield[j] == null : continue
					var tchar = get_char_by_pos(j)
					if tchar.defeated: continue
					if !tchar.can_be_damaged(skill) and !finale: continue
					array.append(tchar)
				elif targetgroup == 'full':
					if battlefield[j] == null : continue
					var tchar = get_char_by_pos(j)
					if tchar.defeated: continue
					if !tchar.can_be_damaged(skill) and !finale: continue
					array.append(tchar)
			if !array.empty():
				var tmp = array[globals.rng.randi_range(0, array.size()-1)]
				array.clear()
				array = [tmp]
		'x_random':
			if finale:
				for j in range(1, 13):
					if j in range(1,7) && targetgroup == 'player':
						if battlefield[j] == null : continue
						var tchar = get_char_by_pos(j)
						if tchar.defeated: continue
						if !tchar.can_be_damaged(skill) and !finale: continue
						array.append(tchar)
					elif j in range(7, 13) && targetgroup == 'enemy':
						if battlefield[j] == null : continue
						var tchar = get_char_by_pos(j)
						if tchar.defeated: continue
						if !tchar.can_be_damaged(skill) and !finale: continue
						array.append(tchar)
					elif targetgroup == 'full':
						if battlefield[j] == null : continue
						var tchar = get_char_by_pos(j)
						if tchar.defeated: continue
						if !tchar.can_be_damaged(skill) and !finale: continue
						array.append(tchar)
				while array.size() > skill.number_rnd_targets:
					var tmp = globals.rng.randi_range(0, array.size() - 1)
					array.remove(tmp)
	if (!finale) and skill.tags.has('random_target'):
		array.clear()
		for pos in allowedtargets.enemy + allowedtargets.ally:
			var tchar = get_char_by_pos(pos)
			array.push_back(tchar)
	return array


func get_random_target():
	var tmparr = []
	for pos in allowedtargets.enemy + allowedtargets.ally:
		var tchar = get_char_by_pos(pos)
		tmparr.push_back(tchar)
	if tmparr.empty(): return null
	return input_handler.random_from_array(tmparr)


func Highlight(pos, type):
	var node = battlefieldpositions[pos].get_node("Character")
#	match type:
#		'selected':
#			ResourceScripts.core_animations.SelectionGlow(node)
#		'target':
#			input_handler.TargetGlow(node)
#		'targetsupport':
#			input_handler.TargetSupport(node)
#		'enemy':
#			input_handler.TargetEnemyTurn(node)


func StopHighlight(pos):
	var node = battlefieldpositions[pos].get_node("Character")
	input_handler.StopTweenRepeat(node)


func Target_eff_Glow (pos):
	var node = battlefieldpositions[pos].get_node("Character");
	if node == null: return;
	var temp
	
	temp = Color(1.0,0.0,1.0,1.0);
	node.get_node('border').material.set_shader_param('modulate', temp);


func Target_Glow (pos):
	var node = battlefieldpositions[pos].get_node("Character");
	if node == null: return;
	var temp
	if pos in range(1,7):
		temp = Color(0.0,1.0,0.0,1.0);
	else:
		temp = Color(1.0,0.0,0.0,1.0);
	node.get_node('border').visible = true;
	node.get_node('border').material.set_shader_param('modulate', temp);


func Stop_Target_Glow ():
	for pos in range(1,13):
		var p_node = battlefieldpositions[pos];
		if !p_node.has_node('Character'): continue;
		var node = p_node.get_node("Character");
		#if node == null: continue;
		#node.material.shader_param.Modulate.a = 0.0;
		var temp = node.get_node('border').material.get_shader_param('modulate');
		temp.a = 0.0;
		node.get_node('border').material.set_shader_param('modulate', temp);


func Off_Target_Glow ():
	for pos in range(1,13):
		var p_node = battlefieldpositions[pos];
		if !p_node.has_node('Character'): continue;
		var node = p_node.get_node("Character");
		#if node == null: continue;
		#node.material.shader_param.Modulate.a = 0.0;
		#var temp = node.get_node('border').material.get_shader_param('modulate');
		#temp.a = 0.0;
		node.get_node('border').visible = false;


func ClearSkillPanel():
	input_handler.ClearContainer($SkillPanel)


func RebuildSkillPanel():
	if activecharacter == null: return
	ClearSkillPanel()
#	var counter = 0
	var src = activecharacter.skills.combat_skill_panel
	for i in range(1,21):
		var newbutton = input_handler.DuplicateContainerTemplate($SkillPanel)
		if src.has(i):
			var skill = Skilldata.get_template(activecharacter.skills.combat_skill_panel[i], activecharacter)
			newbutton.get_node("Icon").texture = skill.icon
			if skill.cost.has('mp'):
				newbutton.get_node("manacost").text = str(int(skill.cost.mp))
				newbutton.get_node("manacost").visible = true
			if !activecharacter.check_cost(skill.cost):
	#			newbutton.get_node("Icon").modulate = Color(0,0,1)
				newbutton.disabled = true
				newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
			if activecharacter.skills.combat_cooldowns.has(skill.code):
				newbutton.disabled = true
				newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
				newbutton.get_node("cooldown").visible = true
				newbutton.get_node("cooldown").text = str(activecharacter.skills.combat_cooldowns[skill.code])
				newbutton.get_node("cooldown").set("custom_colors/font_color", variables.hexcolordict.magenta)
			if skill.charges > 0:
				var leftcharges = skill.charges
				if activecharacter.skills.combat_skill_charges.has(skill.code):
					leftcharges -= activecharacter.skills.combat_skill_charges[skill.code]
				newbutton.get_node("charge").visible = true
				newbutton.get_node("charge").text = str(leftcharges)+"/"+str(skill.charges)
				if leftcharges <= 0:
					newbutton.disabled = true
					newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
					newbutton.get_node("cooldown").visible = true
					newbutton.get_node("cooldown").text = str(activecharacter.skills.daily_cooldowns[skill.code])
					newbutton.get_node("cooldown").set("custom_colors/font_color", variables.hexcolordict.red)
			if !activecharacter.checkreqs(skill.reqs):
				newbutton.disabled = true
				newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
			if activecharacter.has_status('silence') and skill.ability_type == 'spell' and !skill.tags.has('default'):
				newbutton.disabled = true
				newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
			if activecharacter.has_status('disarm') and skill.ability_type == 'skill' and !skill.tags.has('default'):
				newbutton.disabled = true
				newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
			if activecharacter.has_status('no_combat_skills') and skill.ability_type == 'skill' and !skill.tags.has('default'):
				newbutton.disabled = true
				newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
			if activecharacter.has_status('no_combat_spells') and skill.ability_type == 'spell' and !skill.tags.has('default'):
				newbutton.disabled = true
				newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
			if activecharacter.has_status('no_combat_support') and skill.tags.has('support'):
				newbutton.disabled = true
				newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
			newbutton.connect('pressed', self, 'SelectSkill', [skill.code])
#			if !activecharacter.check_cost(skill.cost):
#				newbutton.disabled = true
#				newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
			#there definetely should be catalyst check, but i'd seen no one, so added a new
			if !activecharacter.has_status('ignore_catalysts_for_%s' % skill.code):
				for res in skill.catalysts:
					if ResourceScripts.game_res.materials[res] < skill.catalysts[res]:
						newbutton.disabled = true
						newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
			newbutton.set_meta('skill', skill.code)
			newbutton.connect('signal_RMB_release',self,'select_skill_for_position', [i])
			globals.connectskilltooltip(newbutton, skill.code, activecharacter)
		else:
			newbutton.connect('signal_RMB_release',self,'select_skill_for_position', [i])


func SelectSkill(skill, user_act = true):
	if activecharacter == null: return
	
	Input.set_custom_mouse_cursor(images.cursors.default)
	skill = Skilldata.get_template(skill, activecharacter)
	$Panel3/TextureRect.texture = skill.icon
	$Panel3/Label.text = skill.name
	#need to add daily restriction check
	if !activecharacter.can_use_skill(skill)  :
		#SelectSkill('attack')
		call_deferred('SelectSkill', activecharacter.get_skill_by_tag('default'))
		return
	if !activecharacter.has_status('ignore_catalysts_for_%s' % skill.code):
		for i in skill.catalysts:
			if ResourceScripts.game_res.materials[i] < skill.catalysts[i]:
				input_handler.SystemMessage("Missing catalyst: " + Items.materiallist[i].name)
				call_deferred('SelectSkill', activecharacter.get_skill_by_tag('default'));
				break
	if skill.charges > 0 && activecharacter.skills.combat_skill_charges.has(skill.code) && activecharacter.skills.combat_skill_charges[skill.code] >= skill.charges:
		#input_handler.SystemMessage("No charges left: " + skill.name)
		call_deferred('SelectSkill', activecharacter.get_skill_by_tag('default'))
		return
	activecharacter.selectedskill = skill.code
	activeaction = skill.code
	UpdateSkillTargets(activecharacter, skill)
	allowaction = true
	$Button.disabled = false
	if allowedtargets.ally.size() == 0 and allowedtargets.enemy.size() == 0:
		checkwinlose();
	if skill.has('cursor'): customcursor = skill.cursor
	else: customcursor = null
	if skill.target == 'self':
		if !user_act:
			call_deferred('SelectSkill', activecharacter.get_skill_by_tag('default'))
			return
		globals.closeskilltooltip()
		activecharacter.selectedskill = activecharacter.get_skill_by_tag('default')
		
		call_deferred('use_skill', activeaction, activecharacter, activecharacter)


func RebuildItemPanel():
	var array = []
	
	ClearItemPanel()
	
	for i in ResourceScripts.game_res.items.values():
		if i.itemtype == 'usable' && Items.itemlist[i.itembase].has('combat_effect'):
			array.append(i)
	
	for i in array:
		var newbutton = input_handler.DuplicateContainerTemplate($ItemPanel/ScrollContainer/GridContainer)
		newbutton.get_node("Icon").texture = input_handler.loadimage(i.icon, 'icons')
		newbutton.get_node("Label").text = str(i.amount)
		newbutton.set_meta('skill', i.useskill)
		newbutton.set_meta('item', i)
		newbutton.connect('pressed', self, 'ActivateItem', [i])
		globals.connectitemtooltip_v2(newbutton, i)


func ClearItemPanel():
	input_handler.ClearContainer($ItemPanel/ScrollContainer/GridContainer)


func ActivateItem(item):
	for button in $ItemPanel/ScrollContainer/GridContainer.get_children():
		if !button.has_meta("item"): continue
		button.pressed = button.get_meta("item") == item
	activeaction = Items.itemlist[item.code].combat_effect
	activeitem = item
	SelectSkill(activeaction)
	#UpdateSkillTargets()


func combatlogadd(text):
	var data = {node = self, time = turns, type = 'c_log', slot = 'c_log', params = {text = text}}
	CombatAnimations.add_new_data(data)


func combatlogadd_q(text):
	$Combatlog/RichTextLabel.append_bbcode(text)


func update_queue_asynch():
	var data = {node = self, time = turns, type = 'order', slot = 'order', params = {queue = turnorder.duplicate(), current = currentactor}}
	CombatAnimations.add_new_data(data)


func update_queue(queue, current): #don't call in asynchroned state
	input_handler.ClearContainer($Panel4/VBoxContainer)
	
	for ch in [{pos = current}] + queue:
		if ch.pos < 0 : continue
		if battlefield[ch.pos] == null:
			continue
		var person = get_char_by_pos(ch.pos)
		var tmp = input_handler.DuplicateContainerTemplate($Panel4/VBoxContainer, 'Button')
		if ch.pos > 6:
			tmp.disabled = true
		var icon = person.get_icon()
		if icon != null:
			tmp.get_node('icon').texture = icon
		tmp.get_node('hpbar').max_value = person.get_stat('hpmax')
		tmp.get_node('hpbar').value = person.hp
		tmp.connect("mouse_entered", self, 'FighterMouseOver', [person.id, true])
		tmp.connect("mouse_exited", self, 'FighterMouseOverFinish', [person.id])


var active_position
func select_skill_for_position(position):
	if !allowaction: 
		return
	active_position = position
	var person = activecharacter
	var active_panel = 1
	input_handler.ShowSkillSelectPanel(person, active_panel, self, 'skill_selected')


func skill_selected(skill):
	var person = activecharacter
	if skill == null:
		person.skills.combat_skill_panel.erase(active_position)
	else:
		person.skills.combat_skill_panel[active_position] = skill
	RebuildSkillPanel()


func FinishCombat(victory = true):
	victory_seq_run = false
	HideFighterStats()
	set_process_input(false)
	if is_instance_valid(gui_controller.dialogue) && gui_controller.dialogue.is_visible():
		gui_controller.dialogue.close() #for test
	autoskill_dummy.is_active = false
	for i in playergroup.values() + enemygroup.values():
		var tchar = characters_pool.get_char_by_id(i)
		tchar.skills.combat_cooldowns.clear()
	
	for p in playergroup.values():
		var ch = characters_pool.get_char_by_id(p)
		if ch.hp <=0:
			if !ResourceScripts.game_globals.diff_permadeath:
				ch.hp = 1
				ch.is_active = true
				ch.defeated = false
				ch.combat_position = 0
				var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table.e_grave_injury)
				if ch.has_status('fastheal'):
					ch.apply_effect_code('e_grave_injury', {duration = 8})
				else:
					ch.apply_effect_code('e_grave_injury', {duration = 12})
			else:
				ch.killed()
		ch.process_event(variables.TR_COMBAT_F)
	effects_pool.process_event(variables.TR_COMBAT_F)
		#add permadeath check here
	
	for i in range(battlefield.size()):
		if battlefield[i] != null:
			var tchar = get_char_by_pos(i)
			tchar.displaynode.queue_free()
			tchar.displaynode = null
			battlefield[i] = null
	for i in enemygroup.values():
		#mark enemy characters for clearing
		#mb to change this part when dealing with captured enemies
		var tchar = characters_pool.get_char_by_id(i)
		tchar.is_active = false
	if victory:
		CombatAnimations.force_end()
		ResourceScripts.core_animations.BlackScreenTransition(0.5)
		yield(get_tree().create_timer(0.5), 'timeout')
		hide()
		input_handler.finish_combat()
	else:
		hide()
		input_handler.combat_defeat()
	
	input_handler.combat_node = null
	gui_controller.current_screen = gui_controller.previous_screen
	gui_controller.combat = null
	characters_pool.cleanup()


#to check next functions
var victory_seq_run = false
func victory():
	if victory_seq_run:
		return
	victory_seq_run = true
	get_tree().get_root().set_disable_input(true)
	
	autoskill_dummy.is_active = false
	CombatAnimations.check_start()
	if CombatAnimations.is_busy: 
		yield(CombatAnimations, 'alleffectsfinished')
	if ActionQueue != null:
		ActionQueue.force_clean()
		ActionQueue = null
	Input.set_custom_mouse_cursor(images.cursors.default)
	yield(get_tree().create_timer(0.5), 'timeout')
	fightover = true
	$Rewards/CloseButton.disabled = true
	input_handler.StopMusic()
	#on combat ends triggers
	for p in range(1, 7):
		if battlefield[p] == null:
			continue
		var t_p = get_char_by_pos(p)
		if summons.has(p):
			t_p.is_active = false
			playergroup.erase(p)
			summons.erase(p)
		else:
			t_p.process_event(variables.TR_VICTORY)
	effects_pool.process_event(variables.TR_VICTORY)
	#add permadeath check here
	
	input_handler.PlaySound("battle_victory")
	
	var rewardsdict = {gold = 0, materials = {}, items = [], xp = 0}
	for i in enemygroup.values():
		if i == null: #not sure why was this check added
			continue
		var tchar = characters_pool.get_char_by_id(i)
		tchar.is_active = false
		var count = 1
		if tchar.tags.has('rare'):
			count = 2
			rewardsdict.xp += 3 * tchar.get_stat('xpreward')
		elif tchar.tags.has('miniboss'):
			count = 2
			rewardsdict.xp += 2 * tchar.get_stat('xpreward')
		else:
			rewardsdict.xp += tchar.get_stat('xpreward')
		if !no_material_reward and external_reward == null:
			var loot_processor = Items.get_loot()
			var rewards = loot_processor.get_reward(tchar.get_stat('loottable'), count)
			loot_processor.merge_reward_dict(rewardsdict, rewards)
	
	if !no_material_reward and external_reward != null:
		var loot_processor = Items.get_loot()
		loot_processor.merge_reward_dict(rewardsdict, external_reward)
	
	input_handler.ClearContainer($Rewards/ScrollContainer/HBoxContainer)
	input_handler.ClearContainer($Rewards/ScrollContainer2/HBoxContainer)
	rewardsdict.xp *= combat_data.xp_mod
	var exp_per_character = rewardsdict.xp/playergroup.size()
	for i in playergroup.values():
		var tchar = characters_pool.get_char_by_id(i)
		var gained_exp = exp_per_character# * tchar.get_stat('exp_gain_mod')
		tchar.add_stat('base_exp', gained_exp)
#		tchar.add_stat('abil_exp', gained_exp)
		tchar.add_stat('metrics_win', 1)
		var newbutton = input_handler.DuplicateContainerTemplate($Rewards/ScrollContainer2/HBoxContainer)
		newbutton.hide()
		newbutton.modulate.a = 0
		newbutton.show()
		newbutton.get_node("Icon").texture = tchar.get_icon()
		newbutton.get_node("name").text = tchar.get_short_name()
		if gained_exp > 0:
			gained_exp *= tchar.get_stat('exp_gain_mod')
		gained_exp = int(gained_exp)
		newbutton.get_node("amount").text = str(gained_exp)
	
	var rewardchars = globals.roll_characters()
	for id in rewardchars:
		var tchar = characters_pool.get_char_by_id(id)
		var newbutton = input_handler.DuplicateContainerTemplate($Rewards/ScrollContainer/HBoxContainer)
		newbutton.hide()
		newbutton.modulate.a = 0
		newbutton.show()
		var ttex = tchar.get_icon_small()
		if ttex != null: 
			newbutton.get_node('Icon').texture = ttex
		else:
			newbutton.get_node('Icon').texture = load("res://assets/images/gui/explore/Captured Characters/icons/icon_hero.png")
		newbutton.get_node('name').text = tr("COMBAT_CHARACTER_CAPTURED") + ": " + tchar.get_full_name()
		newbutton.get_node('name').set("custom_colors/font_color", variables.hexcolordict['factor'+str(int(tchar.get_stat('growth_factor')))])
		newbutton.get_node("amount").text = ""
		globals.connectslavetooltip(newbutton, tchar)
	if input_handler.exploration_node != null:
		input_handler.exploration_node.add_rolled_chars(rewardchars)
	for i in rewardsdict.materials:
		var item = Items.materiallist[i]
		var newbutton = input_handler.DuplicateContainerTemplate($Rewards/ScrollContainer/HBoxContainer)
		newbutton.hide()
		newbutton.modulate.a = 0
		newbutton.show()
		newbutton.get_node("Icon").texture = item.icon
		newbutton.get_node("name").text = item.name
		newbutton.get_node("amount").text = str(rewardsdict.materials[i])
		if !only_show_mat_reward:
			ResourceScripts.game_res.materials[i] += rewardsdict.materials[i]
		globals.connectmaterialtooltip(newbutton, item)
	for i in rewardsdict.items:
		var newnode = input_handler.DuplicateContainerTemplate($Rewards/ScrollContainer/HBoxContainer)
		newnode.hide()
		newnode.modulate.a = 0
		newnode.show()
		i.set_icon(newnode.get_node("Icon"))
#		newnode.get_node("Icon").texture = input_handler.loadimage(i.icon, 'icons')
		if !only_show_mat_reward:
			globals.AddItemToInventory(i)
		newnode.get_node("name").text = i.name
#		globals.connectitemtooltip_v2(newnode, ResourceScripts.game_res.items[globals.get_item_id_by_code(i.itembase)])
		globals.connectitemtooltip_v2(newnode, i)
		if i.amount == null || i.amount == 0:
			newnode.get_node("amount").visible = false
		else:
			newnode.get_node("amount").text = str(i.amount)
	
	$Rewards/CloseButton.disabled = false
	var array = []
	for i in playergroup.values():
		array.append(i)
	if global_turn < 3:
		input_handler.get_person_for_chat(array, 'combat_won_fast')
	else:
		input_handler.get_person_for_chat(array, 'combat_won_slow')
	# yield($Rewards/AnimationPlayer, "animation_finished")
	$Rewards/gold/Label.text = '+0'
	$Rewards.set_meta("result", 'victory')
	$Rewards/gold/Label.text = str("+") + str(rewardsdict.gold)
	if !only_show_mat_reward:
		ResourceScripts.game_res.money += rewardsdict.gold
	$Rewards.show()
	$Rewards.modulate.a = 0
	$Rewards/AnimationPlayer.play("Victory")
	$Rewards.modulate.a = 1
	yield(get_tree().create_timer(1.5), "timeout")
	$Rewards/ScrollContainer/HBoxContainer.hide()
	$Rewards/ScrollContainer2/HBoxContainer.hide()
	$Rewards/ScrollContainer/HBoxContainer.show()
	$Rewards/ScrollContainer2/HBoxContainer.show()
	globals.show_buttons($Rewards/ScrollContainer/HBoxContainer)
	globals.show_buttons($Rewards/ScrollContainer2/HBoxContainer)
	get_tree().get_root().set_disable_input(false)
	$Rewards/CloseButton.grab_click_focus()


func defeat(runaway = false): #runaway is a temporary variable until run() method not fully implemented
	for p in range(1, 7):
		if battlefield[p] == null:
			continue
		var t_p = get_char_by_pos(p)
		if summons.has(p):
			t_p.is_active = false
			playergroup.erase(p)
			summons.erase(p)
	if runaway:
		input_handler.play_animation_noq("runaway")
		yield(get_tree().create_timer(4), 'timeout')
		ResourceScripts.core_animations.BlackScreenTransition(1.5)
		yield(get_tree().create_timer(1.5), 'timeout')
	else:
		input_handler.play_animation_noq("defeat")
		yield(get_tree().create_timer(3), 'timeout')
		ResourceScripts.core_animations.BlackScreenTransition(1.5)
		yield(get_tree().create_timer(1.5), 'timeout')
	
	CombatAnimations.force_end()
	Input.set_custom_mouse_cursor(images.cursors.default)
	fightover = true
	ActionQueue.force_clean()
	ActionQueue = null
	FinishCombat(false)
	input_handler.SetMusic(input_handler.explore_sound, true)

#for now it's for extornal use after start_combat()
func set_no_reward():
	no_material_reward = true

func set_only_show_reward():
	only_show_mat_reward = true

func set_external_reward(new_reward):
	external_reward = new_reward
