extends Control

#warning-ignore-all:return_value_discarded
# warning-ignore:unused_signal
var currentenemies
var area
var turns = 0
var animationskip = false

var encountercode

var combatlog = ''

var instantanimation = null

var shotanimationarray = [] #supposedanimation = {code = 'code', runnext = false, delayuntilnext = 0}

var CombatAnimations = preload("res://src/CombatAnimations.gd").new()

var debug = false

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

var autoskill = null

var cursors = {
	default = load("res://assets/images/gui/universal/cursordefault.png"),
	attack = load("res://assets/images/gui/universal/cursorfight.png"),
	support = load("res://assets/images/gui/universal/cursorsupport.png"),
	
}

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


var dummy = {
	triggered_effects = []
}

signal skill_use_finshed
var eot = true

func _init():
	pass
	

func _ready():
	battlefield.resize(14)
	for i in range(1,13):
		battlefield[i] = null
	add_child(CombatAnimations)
	$ItemPanel/debugvictory.connect("pressed",self, 'cheatvictory')
	$Rewards/CloseButton.connect("pressed",self,'FinishCombat')


func cheatvictory():
	victory()
#	for i in enemygroup:
#		var tchar = characters_pool.get_char_by_id(enemygroup[i])
#		tchar.hp = 0
	#checkwinlose()



func start_combat(newplayergroup, newenemygroup, background, music = 'battle1', enemy_stats_mod = 1):
	#$Background.texture = images.backgrounds[background]
	hide()
	$ItemPanel/debugvictory.visible = debug
	if variables.combat_tests == false:
		input_handler.BlackScreenTransition(0.5)
		yield(get_tree().create_timer(0.5), 'timeout')
	input_handler.emit_signal("CombatStarted", encountercode)
	input_handler.ActivateTutorial("combat")
	show()
	globals.combat_node = self
	turns = 0
	$Combatlog/RichTextLabel.clear()
	enemygroup.clear()
	playergroup.clear()
	turnorder.clear()
	input_handler.SetMusic(music)
	fightover = false
	$Rewards.visible = false
	allowaction = false
	enemygroup = newenemygroup
	playergroup = newplayergroup
	for i in range(1,13):
		battlefield[i] = null
	buildenemygroup(enemygroup, enemy_stats_mod)
	buildplayergroup(playergroup)
	#victory()
	#start combat triggers
	CombatAnimations.force_end()
	for i in playergroup.values() + enemygroup.values():
		var tchar = characters_pool.get_char_by_id(i)
		tchar.process_event(variables.TR_COMBAT_S)
		tchar.displaynode.rebuildbuffs()
	select_actor()

func FinishCombat(victory = true):
	for i in playergroup.values() + enemygroup.values():
		var tchar = characters_pool.get_char_by_id(i)
		tchar.combat_cooldowns.clear()
	for i in range(battlefield.size()):
		if battlefield[i] != null:
			var tchar = characters_pool.get_char_by_id(battlefield[i])
			tchar.displaynode.queue_free()
			tchar.displaynode = null
			battlefield[i] = null
	for i in enemygroup.values():
		#mark enemy characters for clearing
		#mb to change this part when dealing with captured enemies  
		var tchar = characters_pool.get_char_by_id(i)
		tchar.is_active = false
	CombatAnimations.force_end()
	hide()
	globals.combat_node = null
	if victory: input_handler.finish_combat()
	else: input_handler.combat_defeat()


func select_actor():
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
	#currentactor.update_timers()
	if currentactor < 0:
		env_turn()
	elif currentactor < 7:
		player_turn(currentactor)
	else:
		enemy_turn(currentactor)

func newturn():
	for i in playergroup.values() + enemygroup.values():
		var tchar = characters_pool.get_char_by_id(i)
		tchar.process_event(variables.TR_TURN_S)
		tchar.displaynode.rebuildbuffs()
		#not sure about keeping all beyond - dis part, mb needs reworking
		var cooldowncleararray = []
		for k in tchar.combat_cooldowns:
			tchar.combat_cooldowns[k] -= 1
			if tchar.combat_cooldowns[k] <= 0:
				cooldowncleararray.append(k)
		for k in cooldowncleararray:
			tchar.combat_cooldowns.erase(k)

func checkdeaths():
	for i in range(battlefield.size()):
		if battlefield[i] == null: continue
		var tchar = characters_pool.get_char_by_id(battlefield[i])
		if tchar.defeated != true && tchar.hp <= 0:
			#tchar.displaynode.defeat()
			#tchar.death()
			tchar.defeated = true
			tchar.hp = 0
			combatlogadd("\n" + tchar.name + " has been defeated.\n")
			for j in range(turnorder.size()):
				if turnorder[j].pos == i:
					turnorder.remove(j)
					break
			#turnorder.erase(battlefield[i])
			if summons.has(i):
				tchar.displaynode.queue_free()
				tchar.displaynode = null
				battlefield[i] = null
				enemygroup.erase(i)
				summons.erase(i);



func checkwinlose():
	var playergroupcounter = 0
	var enemygroupcounter = 0
	for i in range(battlefield.size()):
		if battlefield[i] == null:
			continue
		if characters_pool.get_char_by_id(battlefield[i]).defeated:
			continue
		if i in range(1,7):
			playergroupcounter += 1
		else:
			enemygroupcounter += 1
	if playergroupcounter <= 0:
		defeat()
		return true
	elif enemygroupcounter <= 0:
		victory()
		return true

var rewardsdict

#to check next functions
func victory():
	CombatAnimations.check_start()
	if CombatAnimations.is_busy: yield(CombatAnimations, 'alleffectsfinished')
	Input.set_custom_mouse_cursor(cursors.default)
	yield(get_tree().create_timer(0.5), 'timeout')
	fightover = true
	$Rewards/CloseButton.disabled = true
	input_handler.StopMusic()
	#on combat ends triggers
	for p in playergroup.values():
		characters_pool.get_char_by_id(p).process_event(variables.TR_COMBAT_F)
	
	var tween = input_handler.GetTweenNode($Rewards/victorylabel)
	tween.interpolate_property($Rewards/victorylabel,'rect_scale', Vector2(1.5,1.5), Vector2(1,1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	input_handler.PlaySound("questcomplete")
	
	rewardsdict = {gold = 0, materials = {}, items = [], xp = 0}
	for i in enemygroup.values():
		if i == null: #not sure why was this check added
			continue
		var tchar = characters_pool.get_char_by_id(i)
		rewardsdict.xp += tchar.xpreward
		var loot = {}
		for i in Enemydata.loottables[tchar.loottable]:
			if i[0] == 'gold':
				var counter = 1
				if i.size() > 2:
					counter = i[2]
				if i[1] >= 1:
					rewardsdict.gold += i[2]
				else:
					while counter > 0:
						if randf() <= i[1]:
							rewardsdict.gold += 1
						counter -= 1
			elif Items.materiallist.has(i[0]):
				var counter = 1
				if i.size() > 2:
					counter = i[2]
				while counter > 0:
					if randf() <= i[1]:
						globals.AddOrIncrementDict(loot, {i[0] : 1})
					counter -= 1
				globals.AddOrIncrementDict(rewardsdict.materials, loot)
			elif Items.itemlist.has(i[0]):
				var itemtemp = Items.itemlist[i[0]]
				var counter = 1
				if i.size() > 2:
					counter = i[2]
				while counter > 0:
					if randf() <= i[1]:
						if itemtemp.type == 'usable':
							var itemfound = false
							for k in rewardsdict.items:
								if k.itembase == i[0]:
									k.amount += 1
									itemfound = true
									break
							if itemfound == false:
								var newitem = globals.CreateUsableItem(i[0])
								rewardsdict.items.append(newitem)
					counter -= 1
		
#		if Enemydata.loottables[tchar.loottable].has('materials'):
#			for j in Enemydata.loottables[tchar.loottable].materials:
#				if randf()*100 <= j.chance:
#					loot[j.code] = round(rand_range(j.min, j.max))
#			globals.AddOrIncrementDict(rewardsdict.materials, loot)
#		if Enemydata.loottables[tchar.loottable].has('usables'):
#			for j in Enemydata.loottables[tchar.loottable].usables:
#				if randf()*100 <= j.chance:
#					var newitem = globals.CreateUsableItem(j.code, round(rand_range(j.min, j.max)))
#					rewardsdict.items.append(newitem)
	
	globals.ClearContainer($Rewards/ScrollContainer/HBoxContainer)
	globals.ClearContainer($Rewards/ScrollContainer2/HBoxContainer)
	var exp_per_character = ceil(rewardsdict.xp/playergroup.size())
	for i in playergroup.values():
		var tchar = characters_pool.get_char_by_id(i)
		var gained_exp = exp_per_character * tchar.exp_mod
		tchar.base_exp += gained_exp
		var newbutton = globals.DuplicateContainerTemplate($Rewards/ScrollContainer2/HBoxContainer)
		newbutton.texture = tchar.get_icon()
		newbutton.get_node("name").text = tchar.get_short_name()
		newbutton.get_node("amount").text = str(gained_exp)
		if tchar.hp <= 0:
			tchar.hp = 1
			tchar.defeated = false
#		var newbutton = globals.DuplicateContainerTemplate($Rewards/HBoxContainer/first)
#		if $Rewards/HBoxContainer/first.get_children().size() >= 5:
#			$Rewards/HBoxContainer/first.remove_child(newbutton)
#			$Rewards/HBoxContainer/second.add_child(newbutton)
#		#newbutton.get_node('icon').texture = tchar.portrait_circle()
#		newbutton.get_node("xpbar").value = tchar.base_exp
		#var level = tchar.level
#		var subtween = input_handler.GetTweenNode(newbutton)
#		if tchar.level > level:
#			subtween.interpolate_property(newbutton.get_node("xpbar"), 'value', newbutton.get_node("xpbar").value, 100, 0.8, Tween.TRANS_CIRC, Tween.EASE_OUT, 1)
#			subtween.interpolate_property(newbutton.get_node("xpbar"), 'modulate', newbutton.get_node("xpbar").modulate, Color("fffb00"), 0.2, Tween.TRANS_CIRC, Tween.EASE_OUT, 1)
#			subtween.interpolate_callback(input_handler, 1, 'DelayedText', newbutton.get_node("xpbar/Label"), tr("LEVELUP")+ ': ' + str(tchar.level) + "!")
#			subtween.interpolate_callback(input_handler, 1, 'PlaySound', "levelup")
#		elif i.level == level && i.baseexp == 100 :
#			newbutton.get_node("xpbar").value = 100
#			subtween.interpolate_property(newbutton.get_node("xpbar"), 'modulate', newbutton.get_node("xpbar").modulate, Color("fffb00"), 0.2, Tween.TRANS_CIRC, Tween.EASE_OUT)
#			subtween.interpolate_callback(input_handler, 0, 'DelayedText', newbutton.get_node("xpbar/Label"), tr("MAXLEVEL"))
#		else:
#			subtween.interpolate_property(newbutton.get_node("xpbar"), 'value', newbutton.get_node("xpbar").value, tchar.baseexp, 0.8, Tween.TRANS_CIRC, Tween.EASE_OUT, 1)
#			subtween.interpolate_callback(input_handler, 2, 'DelayedText', newbutton.get_node("xpbar/Label"), '+' + str(ceil(rewardsdict.xp*tchar.xpmod)))
#		subtween.start()
	#$Rewards/ScrollContainer/HBoxContainer.move_child($Rewards/ScrollContainer/HBoxContainer/Button, $Rewards/ScrollContainer/HBoxContainer.get_children().size())
	
	$Rewards.visible = true
	$Rewards.modulate.a = 0
	input_handler.UnfadeAnimation($Rewards)
	$Rewards.set_meta("result", 'victory')
	$Rewards/gold/Label.text = str("+") + str(rewardsdict.gold)
	for i in rewardsdict.materials:
		var item = Items.materiallist[i]
		var newbutton = globals.DuplicateContainerTemplate($Rewards/ScrollContainer/HBoxContainer)
		#newbutton.hide()
		newbutton.texture = item.icon
		newbutton.get_node("name").text = item.name
		newbutton.get_node("amount").text = str(rewardsdict.materials[i])
		state.materials[i] += rewardsdict.materials[i]
		globals.connectmaterialtooltip(newbutton, item)
	for i in rewardsdict.items:
		var newnode = globals.DuplicateContainerTemplate($Rewards/ScrollContainer/HBoxContainer)
		#newnode.hide()
		newnode.texture = load(i.icon)
		globals.AddItemToInventory(i)
		newnode.get_node("name").text = i.name
		globals.connectitemtooltip(newnode, state.items[globals.get_item_id_by_code(i.itembase)])
		if i.amount == null || i.amount == 0:
			newnode.get_node("amount").visible = false
		else:
			newnode.get_node("amount").text = str(i.amount)
	
	
	#yield(get_tree().create_timer(1.7), 'timeout')
	
#	for i in $Rewards/ScrollContainer/HBoxContainer.get_children():
#		if i.name == 'Button':
#			continue
#		tween = input_handler.GetTweenNode(i)
#		yield(get_tree().create_timer(1), 'timeout')
#		i.show()
#		input_handler.PlaySound("itemget")
#		tween.interpolate_property(i,'rect_scale', Vector2(1.5,1.5), Vector2(1,1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#		tween.start()
	
	#yield(get_tree().create_timer(1), 'timeout')
	$Rewards/CloseButton.disabled = false
	var array = []
	for i in playergroup.values():
		array.append(i)
	input_handler.get_person_for_chat(array, 'combat_won')

func defeat():
	CombatAnimations.check_start()
	if CombatAnimations.is_busy: yield(CombatAnimations, 'alleffectsfinished')
	Input.set_custom_mouse_cursor(cursors.default)
	fightover = true
	FinishCombat(false)

func player_turn(pos):
	turns += 1
	var selected_character = characters_pool.get_char_by_id(playergroup[pos])
	#selected_character.update_timers()
	selected_character.process_event(variables.TR_TURN_GET)
	selected_character.displaynode.rebuildbuffs()
	CombatAnimations.check_start()
	if CombatAnimations.is_busy: yield(CombatAnimations, 'alleffectsfinished')
	turns += 1
	if !selected_character.can_act():
		#combatlogadd("%s cannot act" % selected_character.name)
		selected_character.process_event(variables.TR_TURN_F)
		selected_character.displaynode.rebuildbuffs()
		call_deferred('select_actor')
		return
	if selected_character.has_status('confuse'):
		activeaction = selected_character.get_skill_by_tag('default')
		UpdateSkillTargets(selected_character, true)
		var targ = get_random_target()
		use_skill(selected_character.get_skill_by_tag('default'), selected_character, targ)
		return
	if selected_character.has_status('taunt'):
		var tchar = characters_pool.get_char_by_id(selected_character.taunt)
		selected_character.taunt = null
		if can_be_taunted(selected_character, tchar):
			use_skill(selected_character.get_skill_by_tag('default'), selected_character, tchar)
			return
	CombatAnimations.check_start()
	if CombatAnimations.is_busy: yield(CombatAnimations, 'alleffectsfinished')
	#allowaction = true
	activecharacter = selected_character
	RebuildSkillPanel()
	RebuildItemPanel()
	SelectSkill(selected_character.selectedskill)


#rangetypes melee, any, backmelee

func UpdateSkillTargets(caster, glow_skip = false): 
	var skill = Skilldata.Skilllist[activeaction]
	var fighter = caster
	var targetgroups = skill.target
	var rangetype = skill.target_range
	ClearSkillTargets()
	
	for i in $SkillPanel/ScrollContainer/GridContainer.get_children() + $ItemPanel/ScrollContainer/GridContainer.get_children():
		if i.has_meta('skill'):
			i.pressed = i.get_meta('skill') == skill.code
	
	#not sure if this is correct
	if rangetype == 'weapon':
		if fighter.gear.rhand == null:
			rangetype = 'melee'
		else:
			var weapon = state.items[fighter.gear.rhand]
			rangetype = weapon.weaponrange
	highlightargets = true
	allowedtargets.clear()
	allowedtargets = {ally = [], enemy = []}
	
	#assuming no player skills are battlefield-scale
	if targetgroups == 'enemy':
		var t_targets
		if rangetype == 'any': t_targets = get_enemy_targets_all(fighter)
		if rangetype == 'melee': t_targets = get_enemy_targets_melee(fighter)
		for t in t_targets:
			allowedtargets.enemy.push_back(t.position)
	if targetgroups == 'ally':
		var t_targets = get_allied_targets(fighter)
		if rangetype == 'dead':
			t_targets.clear()
			for t in playergroup.values():
				var tchar = characters_pool.get_char_by_id(t)
				if tchar.defeated:
					t_targets.push_back(tchar)
			pass
		for t in t_targets:
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
		if battlefield[pos] == null:continue
		if characters_pool.get_char_by_id(battlefield[pos]).displaynode == null:continue #this check obviosly covers some bug still needed to be found and fixen 
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
				var tchar = characters_pool.get_char_by_id(battlefield[pos])
				if tchar.defeated == true: continue
				if tchar.has_status('hide') and !hide_ignore: continue
				counter += 1
		'ally':
			for pos in range(1,4):
				if battlefield[pos] == null:continue
				var tchar = characters_pool.get_char_by_id(battlefield[pos])
				if tchar.defeated == true: continue
				if tchar.has_status('hide') and !hide_ignore: continue
				counter += 1
	if counter > 0: rval = true
	return rval

func can_be_taunted(caster, target):
	match target.combatgroup:
		'ally':
			if target.position < 4: return true
			if !CheckMeleeRange('ally'): return true
		'enemy':
			if target.position < 10: return true
			if !CheckMeleeRange('enemy'): return true
	var s_code = caster.get_skill_by_tag('default')
	var skill = Skilldata.Skilllist[s_code]
	return (skill.target_range == 'any')

func enemy_turn(pos):
	turns += 1
	var fighter = characters_pool.get_char_by_id(enemygroup[pos])
	#fighter.update_timers()
	fighter.process_event(variables.TR_TURN_GET)
	fighter.displaynode.rebuildbuffs()
	CombatAnimations.check_start()
	if CombatAnimations.is_busy: yield(CombatAnimations, 'alleffectsfinished')
	if !fighter.can_act():
		#combatlogadd("%s cannot act" % fighter.name)
		fighter.process_event(variables.TR_TURN_F)
		fighter.displaynode.rebuildbuffs()
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
		UpdateSkillTargets(fighter, true)
		target = get_random_target()
	if fighter.has_status('taunt'):
		var targ = characters_pool.get_char_by_id(fighter.taunt)
		fighter.taunt = null
		if can_be_taunted(fighter, targ):
			target = targ;
			castskill = fighter.get_skill_by_tag('default')
	if target == null:
		print(fighter.name, ' no target found')
		return
	use_skill(castskill, fighter, target)
	CombatAnimations.check_start()
	if CombatAnimations.is_busy: yield(CombatAnimations, 'alleffectsfinished')
	#yield(self, "skill_use_finshed")
	while eot:
		turns += 1
		castskill = fighter.ai._get_action()
		target = get_char_by_pos(fighter.ai._get_target(castskill))
		use_skill(castskill, fighter, target)
		CombatAnimations.check_start()
		if CombatAnimations.is_busy: yield(CombatAnimations, 'alleffectsfinished')



func env_turn():
	if autoskill == null: return
	turns += 1
	activecharacter = null
	use_skill(autoskill, null, null)
	CombatAnimations.check_start()
	if CombatAnimations.is_busy: yield(CombatAnimations, 'alleffectsfinished')


func calculateorder():
	turnorder.clear()
	for pos in playergroup:
		var tchar = characters_pool.get_char_by_id(playergroup[pos])
		if tchar.defeated == true:
			continue
		turnorder.append({speed = tchar.get_stat('speed') + randf() * 5, pos = pos})
	for pos in enemygroup:
		var tchar = characters_pool.get_char_by_id(enemygroup[pos])
		if tchar.defeated == true:
			continue
		turnorder.append({speed = tchar.get_stat('speed') + randf() * 5, pos = pos})
	
	turnorder.sort_custom(self, 'speedsort')

func speedsort(first, second):
	if first.speed > second.speed:
		return true
	else:
		return false

func make_fighter_panel(fighter, spot):
	#need to implement clearing panel if fighter is null for the sake of removing summons
	#or simply implement func clear_fighter_panel(pos)
	spot = int(spot)
	var container = battlefieldpositions[int(spot)]
	var panel = $Panel/PlayerGroup/Back/left/Template.duplicate()
	panel.material = load("res://files/SFX/BarrierShader.tres").duplicate()
	#panel.material = $Panel/PlayerGroup/Back/left/Template.material.duplicate()
	panel.get_node('border').material = $Panel/PlayerGroup/Back/left/Template.get_node('border').material.duplicate()
	fighter.displaynode = panel
	panel.name = 'Character'
	panel.set_script(load("res://files/FighterNode.gd"))
	panel.position = int(spot)
	panel.animation_node = CombatAnimations
	fighter.position = int(spot)
	panel.fighter = fighter
	panel.hp = fighter.hp
	panel.mp = fighter.mp
	panel.connect("signal_RMB", self, "ShowFighterStats")
	panel.connect("signal_RMB_release", self, 'HideFighterStats')
	panel.connect("signal_LMB", self, 'FighterPress')
	panel.connect("mouse_entered", self, 'FighterMouseOver', [fighter])
	panel.connect("mouse_exited", self, 'FighterMouseOverFinish', [fighter])
	if variables.CombatAllyHpAlwaysVisible && fighter.combatgroup == 'ally':
		panel.get_node("hplabel").show()
		panel.get_node("mplabel").show()
	panel.set_meta('character',fighter)
	panel.get_node("Icon").texture = fighter.get_icon()
	panel.get_node("HP").value = globals.calculatepercent(fighter.hp, fighter.get_stat('hpmax'))
	panel.get_node("MP").value = globals.calculatepercent(fighter.mp, fighter.get_stat('mpmax'))
	panel.hp = fighter.hp
	panel.update_hp_label(fighter.hp, 100.0)
	panel.update_mp_label(fighter.mp, 100.0)
	if fighter.get_stat('mpmax') == 0:
		panel.get_node("MP").value = 0
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
	panel.visible = true
	panel.noq_rebuildbuffs(fighter.get_combat_buffs())

var fighterhighlighted = false

func FighterShowStats(fighter):
	var panel = fighter.displaynode
	panel.get_node("hplabel").show()
	panel.get_node("mplabel").show()

func FighterMouseOver(fighter):
	FighterShowStats(fighter)
	if allowaction == true && (allowedtargets.enemy.has(fighter.position) || allowedtargets.ally.has(fighter.position)):
		if fighter.combatgroup == 'enemy':
			Input.set_custom_mouse_cursor(cursors.attack)
		else:
			Input.set_custom_mouse_cursor(cursors.support)
		var cur_targets = [];
		cur_targets = CalculateTargets(Skilldata.Skilllist[activeaction], fighter); 
		Stop_Target_Glow();
		for c in cur_targets:
			Target_eff_Glow(c.position);


func FighterMouseOverFinish(fighter):
	var panel = fighter.displaynode
	fighterhighlighted = false
	if variables.CombatAllyHpAlwaysVisible == false || fighter.combatgroup == 'enemy':
		panel.get_node("hplabel").hide()
		panel.get_node("mplabel").hide()
	Input.set_custom_mouse_cursor(cursors.default)
	if !allowaction: return
	Stop_Target_Glow()
	for f in allowedtargets.enemy:
		Target_Glow(f)
	for f in allowedtargets.ally:
		Target_Glow(f)

func ShowFighterStats(fighter):
	if fightover == true:
		return
	$StatsPanel.show()
	$StatsPanel.open(fighter)

func HideFighterStats():
	$StatsPanel.hide()

func FighterPress(pos):
	if allowaction == false || (!allowedtargets.enemy.has(pos) && !allowedtargets.ally.has(pos)):
		return
	ClearSkillTargets()
	ClearItemPanel()
	ClearSkillPanel()
	use_skill(activeaction, activecharacter, characters_pool.get_char_by_id(battlefield[pos]))


func buildenemygroup(enemygroup, enemy_stats_mod):
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
		var tchar = Slave.new()
		tchar.generate_simple_fighter(tempname)
		tchar.combatgroup = 'enemy'
		tchar.position = i
		
		for i in ['hpmax', 'atk', 'matk', 'hitrate', 'armor', 'xpreward']:
			tchar.set(i, round(tchar.get(i) * enemy_stats_mod))
		tchar.hp = tchar.hpmax
		enemygroup[i] = characters_pool.add_char(tchar)
		battlefield[int(i)] = enemygroup[i]
		make_fighter_panel(tchar, i)

func buildplayergroup(group):
	#to remake getting data from state
	#operating this data was remade
	var newgroup = {}
	for i in group:
		if int(i) > 6: break
		if group[i] == null:
			continue
		var fighter = state.characters[group[i]] 
		fighter.combatgroup = 'ally'
		battlefield[int(i)] = fighter.id
		make_fighter_panel(fighter, i)
		newgroup[int(i)] = fighter.id #only change
	playergroup = newgroup


func summon(montype, limit):
	if summons.size() >= limit: return
	#find empty slot in enemy group
	var group = [7,8,9,10,11,12];
	var pos = [];
	for p in group:
		if battlefield[p] == null: pos.push_back(p);
	if pos.size() == 0: return;
	var sum_pos = pos[randi() % pos.size()];
	summons.push_back(sum_pos);
	var tchar = Slave.new();
	tchar.createfromenemy(montype);
	tchar.combatgroup = 'enemy'
	enemygroup[sum_pos] = characters_pool.add_char(tchar)
	battlefield[sum_pos] = enemygroup[sum_pos];
	make_fighter_panel(battlefield[sum_pos], sum_pos);


func use_skill(skill_code, caster, target):
	if activeaction != skill_code: activeaction = skill_code
	#to add code for different costs
	#and various limits and cooldowns
	allowaction = false
	
	var skill = Skilldata.Skilllist[skill_code]

	if caster != null && skill.name != "":
		if activeitem:
			combatlogadd("\n" + caster.name + ' uses ' + activeitem.name + ". ")
		else:
			combatlogadd("\n" + caster.name + ' uses ' + skill.name + ". ")
		
		caster.mp -= skill.manacost
		
		if skill.combatcooldown > 0:
			caster.combat_cooldowns[skill_code] = skill.combatcooldown
	
	if caster.combatgroup == 'ally':
		for i in skill.catalysts:
			state.materials[i] -= skill.catalysts[i]
		if skill.charges > 0:
			if caster.combat_skill_charges.has(skill.code):
				caster.combat_skill_charges[skill.code] += 1
			else:
				caster.combat_skill_charges[skill.code] = 1
			caster.daily_cooldowns[skill_code] = skill.cooldown
		if skill.ability_type == 'skill':
			caster.physics += rand_range(0.3,0.5)
		elif skill.ability_type == 'spell':
			caster.wits += rand_range(0.3,0.5)
	#caster part of setup
	var s_skill1 = S_Skill.new()
	s_skill1.createfromskill(skill_code)
	s_skill1.setup_caster(caster)
	#s_skill1.setup_target(target)
	s_skill1.process_event(variables.TR_CAST)
	
	if caster == null: caster = dummy
	
	if typeof(caster) != TYPE_DICTIONARY: caster.process_event(variables.TR_CAST, s_skill1)

	turns += 1
	#preparing animations
	var animations = skill.sfx
	var animationdict = {windup = [], predamage = [], postdamage = []}
	#sort animations
	for i in animations:
		animationdict[i.period].append(i)
	#casteranimations
	#for sure at windup there should not be real_target-related animations
	if skill.has('sounddata') and !skill.sounddata.empty() and skill.sounddata.initiate != null:
		caster.displaynode.process_sound(skill.sounddata.initiate)
	for i in animationdict.windup:
		var sfxtarget = ProcessSfxTarget(i.target, caster, target)
		sfxtarget.process_sfx(i.code)
	#skill's repeat cycle of predamage-damage-postdamage
	var targets
	var endturn = !s_skill1.tags.has('instant');
	for n in range(s_skill1.repeat):
		#get all affected targets
		if skill.tags.has('random_target') or (target != null and target.hp <= 0) :
			if checkwinlose(): 
				eot = false
				return
			UpdateSkillTargets(caster, true);
			target = get_random_target()
		targets = CalculateTargets(skill, target, true) 
		#preparing real_target processing, predamage animations
		var s_skill2_list = []
		for i in animationdict.predamage:
			if i.target in ['target_frame']:
				target.displaynode.process_sfx(i.code)
#				if caster.combatgroup == 'ally':
#					input_handler.gfx_sprite($Panel2, i.code)
#				else:
#					input_handler.gfx_sprite($Panel, i.code)
		for i in targets:
			if skill.has('sounddata') and !skill.sounddata.empty() and skill.sounddata.strike != null:
				if skill.sounddata.strike == 'weapon':
					caster.displaynode.process_sound(get_weapon_sound(caster))
				else:
					caster.displaynode.process_sound(skill.sounddata.strike)
			for j in animationdict.predamage:
				if j.target in ['caster','target']:
					var sfxtarget = ProcessSfxTarget(j.target, caster, i)
					sfxtarget.process_sfx(j.code)
			#special results
			if skill.has('damage_type') and skill.damage_type == 'summon':
				summon(skill.value[0], skill.value[1]);
			elif skill.has('damage_type') and skill.damage_type == 'resurrect':
				i.resurrect(input_handler.calculate_number_from_string_array(skill.value[0], caster, target)) #not sure
			else: 
				#default skill result
				#execute_skill(s_skill1, caster, i)
				var s_skill2:S_Skill = s_skill1.clone()
				s_skill2.setup_target(i)
				#place for non-existing another trigger
				s_skill2.setup_final()
				s_skill2.hit_roll()
				s_skill2.resolve_value(CheckMeleeRange(caster.combatgroup))
				s_skill2_list.push_back(s_skill2)
		turns += 1
		#predamage triggers
		for s_skill2 in s_skill2_list:
			s_skill2.process_event(variables.TR_HIT)
			if typeof(caster) != TYPE_DICTIONARY: s_skill2.caster.process_event(variables.TR_HIT, s_skill2)
			s_skill2.target.process_event(variables.TR_DEF, s_skill2)
			s_skill2.setup_effects_final()
		turns += 1
		#damage
		for s_skill2 in s_skill2_list:
			#check miss
			if s_skill2.hit_res == variables.RES_MISS:
				s_skill2.target.play_sfx('miss')
				combatlogadd(target.name + " evades the damage.")
				Off_Target_Glow()
			else:
				#hit landed animation
				if skill.has('sounddata') and !skill.sounddata.empty() and skill.sounddata.hit != null:
					if skill.sounddata.hittype == 'absolute':
						s_skill2.target.displaynode.process_sound(skill.sounddata.hit)
					elif skill.sounddata.hittype == 'bodyarmor':
						s_skill2.target.displaynode.process_sound(calculate_hit_sound(skill, caster, s_skill2.target))
				for j in animationdict.postdamage:
					var sfxtarget = ProcessSfxTarget(j.target, caster, s_skill2.target)
					sfxtarget.process_sfx(j.code)
				#applying resists
				s_skill2.calculate_dmg()
				#logging result & dealing damage
				execute_skill(s_skill2)
		turns += 1
		#postdamage triggers and cleanup real_target s_skills
		for s_skill2 in s_skill2_list:
			s_skill2.process_event(variables.TR_POSTDAMAGE)
			if typeof(caster) != TYPE_DICTIONARY: s_skill2.caster.process_event(variables.TR_POSTDAMAGE, s_skill2)
			if s_skill2.target.hp <= 0:
				s_skill2.process_event(variables.TR_KILL)
				if typeof(caster) != TYPE_DICTIONARY: s_skill2.caster.process_event(variables.TR_KILL, s_skill2)
			s_skill2.target.displaynode.rebuildbuffs()
			checkdeaths()
			if s_skill2.target.displaynode != null:
				s_skill2.target.displaynode.rebuildbuffs()
			Off_Target_Glow();
			s_skill2.remove_effects()
	turns += 1
	s_skill1.process_event(variables.TR_SKILL_FINISH)
	if typeof(caster) != TYPE_DICTIONARY: caster.process_event(variables.TR_SKILL_FINISH, s_skill1)
	s_skill1.remove_effects()
	#follow-up
	if skill.has('follow_up'):
		use_skill(skill.follow_up, caster, target)
	if skill.tags.has('not_final'): return
	
	#final
	turns += 1
	if activeitem != null:
		activeitem.amount -= 1
		activeitem = null
		SelectSkill(caster.get_skill_by_tag('default'))
	
	caster.displaynode.rebuildbuffs()
	if fighterhighlighted == true:
		FighterMouseOver(target)
	#print(caster.name + ' finished attacking') 
	if endturn or caster.hp <= 0 or !caster.can_act():
		#on end turn triggers
		caster.process_event(variables.TR_TURN_F)
		call_deferred('select_actor')
		eot = false
	else:
		if activecharacter.combatgroup == 'ally':
			CombatAnimations.check_start()
			if CombatAnimations.is_busy: yield(CombatAnimations, 'alleffectsfinished')
		#allowaction = true
		RebuildSkillPanel()
		RebuildItemPanel()
		SelectSkill(activeaction)
		eot = true
	#emit_signal("skill_use_finshed")

func ProcessSfxTarget(sfxtarget, caster, target):
	match sfxtarget:
		'caster':
			return caster.displaynode
		'target':
			return target.displaynode


func get_char_by_pos(pos):
	return characters_pool.get_char_by_id(battlefield[pos])

func get_allied_targets(fighter):
	var res = []
	if fighter.position in range(1, 7):
		for p in playergroup.values():
			if !characters_pool.get_char_by_id(p).defeated: res.push_back(characters_pool.get_char_by_id(p))
	else:
		for p in enemygroup.values():
			if !characters_pool.get_char_by_id(p).defeated: res.push_back(characters_pool.get_char_by_id(p))
	return res

func get_enemy_targets_all(fighter, hide_ignore = false):
	var res = []
	if fighter.position in range(1, 7):
		for p in enemygroup.values():
			var tchar = characters_pool.get_char_by_id(p)
			if tchar.defeated: continue
			if tchar.has_status('hide') and !hide_ignore: continue
			res.push_back(tchar)
	else:
		for p in playergroup.values():
			var tchar = characters_pool.get_char_by_id(p)
			if tchar.defeated: continue
			if tchar.has_status('hide') and !hide_ignore: continue
			res.push_back(tchar)
	return res

func get_enemy_targets_melee(fighter, hide_ignore = false):
	var res = []
	if fighter.position in range(1, 7):
		for p in enemygroup.values():
			var tchar = characters_pool.get_char_by_id(p)
			if tchar.defeated: continue
			if tchar.has_status('hide') and !hide_ignore: continue
			if CheckMeleeRange('enemy', hide_ignore) and tchar.position > 9: continue
			res.push_back(tchar)
	else:
		for p in playergroup.values():
			var tchar = characters_pool.get_char_by_id(p)
			if tchar.defeated: continue
			if tchar.has_status('hide') and !hide_ignore: continue
			if CheckMeleeRange('ally', hide_ignore) and tchar.position > 3: continue
			res.push_back(tchar)
	return res



func CalculateTargets(skill, target, finale = false):
	if target == null: return 
	var array = []
	
	var targetgroup
	
	if int(target.position) in range(1,7):
		targetgroup = 'player'
	else:
		targetgroup = 'enemy'
	if skill.target == 'full':
		targetgroup = 'full'

	match skill.target_number:
		'single':
			array = [target]
		'row':
			for i in variables.rows:
				if variables.rows[i].has(target.position):
					for j in variables.rows[i]:
						if battlefield[j] == null : continue
						var tchar = characters_pool.get_char_by_id(battlefield[j])
						if tchar.defeated: continue
						if !tchar.can_be_damaged(skill.code) and !finale: continue
						array.append(tchar)
		'line':
			for i in variables.lines:
				if variables.lines[i].has(target.position):
					for j in variables.lines[i]:
						if battlefield[j] == null : continue
						var tchar = characters_pool.get_char_by_id(battlefield[j])
						if tchar.defeated: continue
						if !tchar.can_be_damaged(skill.code) and !finale: continue
						array.append(tchar)
		'all':
			for j in range(1, 13):
				if j in range(1,7) && targetgroup == 'player':
					if battlefield[j] == null : continue
					var tchar = characters_pool.get_char_by_id(battlefield[j])
					if tchar.defeated: continue
					if !tchar.can_be_damaged(skill.code) and !finale: continue
					array.append(tchar)
				elif j in range(7, 13) && targetgroup == 'enemy':
					if battlefield[j] == null : continue
					var tchar = characters_pool.get_char_by_id(battlefield[j])
					if tchar.defeated: continue
					if !tchar.can_be_damaged(skill.code) and !finale: continue
					array.append(tchar)
				elif targetgroup == 'full':
					if battlefield[j] == null : continue
					var tchar = characters_pool.get_char_by_id(battlefield[j])
					if tchar.defeated: continue
					if !tchar.can_be_damaged(skill.code) and !finale: continue
					array.append(tchar)
	if (!finale) and skill.tags.has('random_target'):
		array.clear()
		for pos in allowedtargets.enemy + allowedtargets.ally:
			var tchar = characters_pool.get_char_by_id(battlefield[pos])
			array.push_back(tchar)
	return array


func get_random_target():
	var tmparr = []
	for pos in allowedtargets.enemy + allowedtargets.ally:
		var tchar = characters_pool.get_char_by_id(battlefield[pos])
		tmparr.push_back(tchar)
	var i = globals.rng.randi_range(0, tmparr.size()-1)
	return tmparr[i]


func execute_skill(s_skill2):
	var text = ''
	if s_skill2.hit_res == variables.RES_CRIT:
		text += "[color=yellow]Critical!![/color] "
		s_skill2.target.displaynode.process_critical()
	#new section applying conception of multi-value skills
	#TO POLISH & REMAKE
	for i in s_skill2.value:
		if i.damagestat == 'no_stat': continue #for skill values that directly process into effects
		if i.damagestat == 'damage_hp' and i.dmgf == 0: #drain, damage, damage no log, drain no log
			if i.is_drain && s_skill2.tags.has('no_log'):
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
				var rval2 = s_skill2.caster.heal(rval)
			elif i.is_drain:
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
				var rval2 = s_skill2.caster.heal(rval)
				text += "%s drained %d health from %s and gained %d health." %[s_skill2.caster.name, rval, s_skill2.target.name, rval2]
			elif s_skill2.tags.has('no_log') && !i.is_drain:
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
			else:
				var rval = s_skill2.target.deal_damage(i.value, i.damage_type)
				text += "%s is hit for %d damage. " %[s_skill2.target.name, rval]#, s_skill2.value[i]] 
		elif i.damagestat == 'damage_hp' and i.dmgf == 1: #heal, heal no log
			if s_skill2.tags.has('no_log'):
				var rval = s_skill2.target.heal(i.value)
			else:
				var rval = s_skill2.target.heal(i.value)
				text += "%s is healed for %d health." %[s_skill2.target.name, rval]
		elif i.damagestat == 'restore_mana' and i.dmgf == 0: #heal, heal no log
			if !s_skill2.tags.has('no log'):
				var rval = s_skill2.target.mana_update(i.value)
				text += "%s restored %d mana." %[s_skill2.target.name, rval] 
			else:
				s_skill2.target.mana_update(i.value)
		elif i.damagestat == 'restore_mana' and i.dmgf == 1: #drain, damage, damage no log, drain no log
			var rval = s_skill2.target.mana_update(-i.value)
			if i.is_drain:
				var rval2 = s_skill2.caster.mana_update(rval)
				if !s_skill2.tags.has('no log'):
					text += "%s drained %d mana from %s and gained %d mana." %[s_skill2.caster.name, rval, s_skill2.target.name, rval2]
			if !s_skill2.tags.has('no log'):
				text += "%s lost %d mana." %[s_skill2.target.name, rval] 
		else: 
			var mod = i.dmgf
			var stat = i.damagestat
			if mod == 0:
				var rval = s_skill2.target.stat_update(stat, i.value)
				if !s_skill2.tags.has('no log'):
					text += "%s restored %d %s." %[s_skill2.target.name, rval, tr(stat)] 
			elif mod == 1:
				var rval = s_skill2.target.stat_update(stat, -i.value)
				if i.is_drain:
					var rval2 = s_skill2.caster.stat_update(stat, -rval)
					if !s_skill2.tags.has('no log'):
						text += "%s drained %d %s from %s." %[s_skill2.caster.name, i.value, tr(stat),  s_skill2.target.name]
				elif !s_skill2.tags.has('no log'):
					text += "%s loses %d %s." %[s_skill2.target.name, -rval, tr(stat)]
			elif mod == 2:
				var rval = s_skill2.target.stat_update(stat, i.value, true)
				if i.is_drain:# use this on your own risk
					var rval2 = s_skill2.caster.stat_update(stat, -rval)
					if !s_skill2.tags.has('no log'):
						text += "%s drained %d %s from %s." %[s_skill2.caster.name, i.value, tr(stat),  s_skill2.target.name]
				elif !s_skill2.tags.has('no log'):
					text += "%s's %s is now %d." %[s_skill2.target.name, tr(stat), i.value] 
			else: print('error in damagestat %s' % i.damagestat) #obsolete in new format
	combatlogadd(text)



func checkreqs(passive, caster, target):
	var rval = true
	
	if passive.has('casterreq'):
		if !input_handler.requirementcombatantcheck(passive.casterreq, caster):
			return false
	if passive.has('targetreq'):
		if !input_handler.requirementcombatantcheck(passive.targetreq, target):
			return false
	
	return rval

func Highlight(pos, type):
	var node = battlefieldpositions[pos].get_node("Character")
	match type:
		'selected':
			input_handler.SelectionGlow(node)
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
	globals.ClearContainer($SkillPanel/ScrollContainer/GridContainer)

func RebuildSkillPanel():
	ClearSkillPanel()
	for i in activecharacter.combat_skill_panel:
		var newbutton = globals.DuplicateContainerTemplate($SkillPanel/ScrollContainer/GridContainer)
		var skill = Skilldata.Skilllist[activecharacter.combat_skill_panel[i]]
		newbutton.get_node("Icon").texture = skill.icon
		newbutton.get_node("manacost").text = str(skill.manacost)
		if skill.manacost <= 0:
			newbutton.get_node("manacost").hide()
		if skill.manacost > activecharacter.mp:
			newbutton.get_node("Icon").modulate = Color(0,0,1)
		if activecharacter.combat_cooldowns.has(skill.code):
			newbutton.disabled = true
			newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
			newbutton.get_node("cooldown").visible = true
			newbutton.get_node("cooldown").text = str(activecharacter.combat_cooldowns[skill.code])
			newbutton.get_node("cooldown").set("custom_colors/font_color", globals.hexcolordict.yellow)
		if skill.charges > 0:
			var leftcharges = skill.charges
			if activecharacter.combat_skill_charges.has(skill.code):
				leftcharges -= activecharacter.combat_skill_charges[skill.code]
			newbutton.get_node("charge").visible = true
			newbutton.get_node("charge").text = str(leftcharges)+"/"+str(skill.charges)
			if leftcharges <= 0:
				newbutton.disabled = true
				newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
				newbutton.get_node("cooldown").visible = true
				newbutton.get_node("cooldown").text = str(activecharacter.daily_cooldowns[skill.code])
				newbutton.get_node("cooldown").set("custom_colors/font_color", globals.hexcolordict.red)
		if !activecharacter.checkreqs(skill.reqs):
			newbutton.disabled = true
			newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
		newbutton.connect('pressed', self, 'SelectSkill', [skill.code])
		if activecharacter.mp < skill.manacost:
			newbutton.disabled = true
			newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
		newbutton.set_meta('skill', skill.code)
		globals.connectskilltooltip(newbutton, skill.code, activecharacter)

func SelectSkill(skill):
	Input.set_custom_mouse_cursor(cursors.default)
	skill = Skilldata.Skilllist[skill]
	#need to add daily restriction check
	if activecharacter.mp < skill.manacost || activecharacter.combat_cooldowns.has(skill.code) :
		#SelectSkill('attack')
		call_deferred('SelectSkill', 'attack')
		return
	for i in skill.catalysts:
		if state.materials[i] < skill.catalysts[i]:
			input_handler.SystemMessage("Missing catalyst: " + Items.materiallist[i].name)
			call_deferred('SelectSkill', 'attack');
			break
	if skill.charges > 0 && activecharacter.combat_skill_charges.has(skill.code) && activecharacter.combat_skill_charges[skill.code] >= skill.charges:
		#input_handler.SystemMessage("No charges left: " + skill.name)
		call_deferred('SelectSkill', 'attack')
		return
	activecharacter.selectedskill = skill.code
	activeaction = skill.code
	UpdateSkillTargets(activecharacter)
	allowaction = true
	if allowedtargets.ally.size() == 0 and allowedtargets.enemy.size() == 0:
		checkwinlose();
	if skill.target == 'self':
		globals.closeskilltooltip()
		activecharacter.selectedskill = activecharacter.get_skill_by_tag('default')
		call_deferred('use_skill', activeaction, activecharacter, activecharacter)

func RebuildItemPanel():
	var array = []
	
	ClearItemPanel()
	
	for i in state.items.values():
		if i.itemtype == 'usable' && Items.itemlist[i.itembase].has('combat_effect'):
			array.append(i)
	
	for i in array:
		var newbutton = globals.DuplicateContainerTemplate($ItemPanel/ScrollContainer/GridContainer)
		newbutton.get_node("Icon").texture = load(i.icon)
		newbutton.get_node("Label").text = str(i.amount)
		newbutton.set_meta('skill', i.useskill)
		newbutton.connect('pressed', self, 'ActivateItem', [i])
		globals.connectitemtooltip(newbutton, i)

func ClearItemPanel():
	globals.ClearContainer($ItemPanel/ScrollContainer/GridContainer)

func ActivateItem(item):
	activeaction = Items.itemlist[item.code].combat_effect
	activeitem = item
	SelectSkill(activeaction)
	#UpdateSkillTargets()

func get_weapon_sound(caster):
	var item = caster.gear.rhand
	if state.items.has(item):
		item = state.items[item]
	else:
		item = null
	if item == null:
		return 'dodge'
	else:
		return item.hitsound

func calculate_hit_sound(skill, caster, target):
	var rval
	var hitsound
	if skill.sounddata.strike == 'weapon':
		hitsound = get_weapon_sound(caster)
	else:
		hitsound = skill.sounddata.strike
	
	match hitsound:
		'dodge':
			match target.bodyhitsound:
				'flesh':pass
				'wood':pass
				'stone':pass
		'blade':
			match target.bodyhitsound:
				'flesh':pass
				'wood':pass
				'stone':pass
	rval = 'fleshhit'
	
	return rval

func combatlogadd(text):
	var data = {node = self, time = turns, type = 'c_log', slot = 'c_log', params = {text = text}}
	CombatAnimations.add_new_data(data)

func combatlogadd_q(text):
	$Combatlog/RichTextLabel.append_bbcode(text)
