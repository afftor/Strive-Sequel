extends Control

#warning-ignore-all:return_value_discarded
var currentenemies
var area
var turns = 0
var animationskip = false

var encountercode

var combatlog = ''

var instantanimation = null

var shotanimationarray = [] #supposedanimation = {code = 'code', runnext = false, delayuntilnext = 0}

var CombatAnimations = preload("res://src/CombatAnimations.gd").new()

var debug = true

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


var dummy

func _ready():
	battlefield.resize(14)
	for i in range(1,13):
		battlefield[i] = null
	add_child(CombatAnimations)
	$ItemPanel/debugvictory.connect("pressed",self, 'cheatvictory')
	$Rewards/CloseButton.connect("pressed",self,'FinishCombat')
	
#	if variables.combat_tests == true:
#		start_combat(testplayergroup, testenemygroup, 'mansion')
	


func cheatvictory():
	for i in enemygroup:
		var tchar = characters_pool.get_char_by_id(enemygroup[i])
		tchar.hp = 0
	#checkwinlose()

func _process(delta):
	pass


func start_combat(newplayergroup, newenemygroup, background, music = 'battle1', enemy_stats_mod = 1):
	#$Background.texture = images.backgrounds[background]
	globals.combat_node = self
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
	buildenemygroup(enemygroup, enemy_stats_mod)
	buildplayergroup(playergroup)
	#victory()
	#start combat triggers
	for i in playergroup.values() + enemygroup.values():
		var tchar = characters_pool.get_char_by_id(i)
		tchar.process_event(variables.TR_COMBAT_S)
		tchar.displaynode.rebuildbuffs()
	input_handler.ShowGameTip('aftercombat')
	select_actor()

func FinishCombat():
	for i in playergroup.values() + enemygroup.values():
		var tchar = characters_pool.get_char_by_id(i)
		#to replace for sure - disp part
		#i.cooldowns.clear() 
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
	hide()
	globals.combat_node = null
	input_handler.ShowGameTip('explore')
	input_handler.emit_signal("CombatEnded", encountercode)
	input_handler.SetMusic("exploration")
	get_parent().finish_combat()


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
		for k in tchar.cooldowns:
			tchar.cooldowns[k] -= 1
			if tchar.cooldowns[k] <= 0:
				cooldowncleararray.append(k)
		for k in cooldowncleararray:
			tchar.cooldowns.erase(k)

func checkdeaths():
	for i in range(battlefield.size()):
		if battlefield[i] == null: continue
		var tchar = characters_pool.get_char_by_id(battlefield[i])
		if tchar.defeated != true && tchar.hp <= 0:
			tchar.death()
			combatlogadd("\n" + tchar.name + " has been defeated.")
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
	
	input_handler.PlaySound("victory")
	
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
						if randf() >= i[1]:
							rewardsdict.gold += 1
						counter -= 1
			elif Items.materiallist.has(i[0]):
				var counter = 1
				if i.size() > 2:
					counter = i[2]
				while counter > 0:
					if randf() >= i[1]:
						globals.AddOrIncrementDict(loot, {i[0] : 1})
					counter -= 1
				globals.AddOrIncrementDict(rewardsdict.materials, loot)
			elif Items.itemlist.has(i[0]):
				var itemtemp = Items.itemlist[i[0]]
				var counter = 1
				if i.size() > 2:
					counter = i[2]
				while counter > 0:
					if randf() >= i[1]:
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
	
	globals.ClearContainerForced($Rewards/HBoxContainer/first)
	globals.ClearContainerForced($Rewards/HBoxContainer/second)
	globals.ClearContainer($Rewards/ScrollContainer/HBoxContainer)
	for i in playergroup.values():
		var tchar = characters_pool.get_char_by_id(i)
		var newbutton = globals.DuplicateContainerTemplate($Rewards/HBoxContainer/first)
		if $Rewards/HBoxContainer/first.get_children().size() >= 5:
			$Rewards/HBoxContainer/first.remove_child(newbutton)
			$Rewards/HBoxContainer/second.add_child(newbutton)
		#newbutton.get_node('icon').texture = tchar.portrait_circle()
		newbutton.get_node("xpbar").value = tchar.base_exp
		tchar.base_exp += ceil(rewardsdict.xp*tchar.exp_mod)
		#var level = tchar.level
		var subtween = input_handler.GetTweenNode(newbutton)
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
	$Rewards.set_meta("result", 'victory')
	for i in rewardsdict.materials:
		var item = Items.materiallist[i]
		var newbutton = globals.DuplicateContainerTemplate($Rewards/ScrollContainer/HBoxContainer)
		newbutton.hide()
		newbutton.texture = item.icon
		newbutton.get_node("Label").text = str(rewardsdict.materials[i])
		state.materials[i] += rewardsdict.materials[i]
		globals.connectmaterialtooltip(newbutton, item)
	for i in rewardsdict.items:
		var newnode = globals.DuplicateContainerTemplate($Rewards/ScrollContainer/HBoxContainer)
		newnode.hide()
		newnode.texture = load(i.icon)
		globals.AddItemToInventory(i)
		globals.connectitemtooltip(newnode, state.items[globals.get_item_id_by_code(i.itembase)])
		if i.amount == null:
			newnode.get_node("Label").visible = false
		else:
			newnode.get_node("Label").text = str(i.amount)
	
	yield(get_tree().create_timer(1.7), 'timeout')
	
	for i in $Rewards/ScrollContainer/HBoxContainer.get_children():
		if i.name == 'Button':
			continue
		tween = input_handler.GetTweenNode(i)
		yield(get_tree().create_timer(1), 'timeout')
		i.show()
		input_handler.PlaySound("itemget")
		tween.interpolate_property(i,'rect_scale', Vector2(1.5,1.5), Vector2(1,1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	
	#yield(get_tree().create_timer(1), 'timeout')
	$Rewards/CloseButton.disabled = false
	

func defeat():
	globals.CurrentScene.GameOverShow()
	set_process(false)
	set_process_input(false)

func player_turn(pos):
	var selected_character = characters_pool.get_char_by_id(playergroup[pos])
	#selected_character.update_timers()
	selected_character.process_event(variables.TR_TURN_GET)
	if !selected_character.can_act():
		combatlogadd("%s cannot act" % selected_character.name)
		selected_character.process_event(variables.TR_TURN_F)
		selected_character.displaynode.rebuildbuffs()
		call_deferred('select_actor')
		return
	if selected_character.has_status('confuse'):
		activeaction = selected_character.get_skill_by_tag('default')
		UpdateSkillTargets(true)
		var targ = get_random_target()
		use_skill(selected_character.get_skill_by_tag('default'), selected_character, targ)
		return
	if selected_character.has_status('taunt'):
		var tchar = characters_pool.get_char_by_id(selected_character.taunt)
		selected_character.taunt = null
		if can_be_taunted(selected_character, tchar):
			use_skill(selected_character.get_skill_by_tag('default'), selected_character, tchar)
			return
	allowaction = true
	activecharacter = selected_character
	RebuildSkillPanel()
	RebuildItemPanel()
	SelectSkill(selected_character.selectedskill)


#rangetypes melee, any, backmelee

func UpdateSkillTargets(glow_skip = false): 
	var skill = Skilldata.Skilllist[activeaction]
	var fighter = activecharacter
	var targetgroups = skill.target
	var rangetype = skill.target_range
	ClearSkillTargets()
	
	for i in $SkillPanel/ScrollContainer/GridContainer.get_children() + $ItemPanel/ScrollContainer/GridContainer.get_children():
		if i.has_meta('skill'):
			i.pressed = i.get_meta('skill') == skill.code
	
	#not sure if this is correct
	if rangetype == 'weapon':
		if activecharacter.gear.rhand == null:
			rangetype = 'melee'
		else:
			var weapon = state.items[activecharacter.gear.rhand]
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

func CheckMeleeRange(group): #Check if group front row is still in place
	var rval = false
	var counter = 0
	#reqires adding hide checks
	match group:
		'enemy':
			for pos in range(7,10):
				if battlefield[pos] == null:continue
				var tchar = characters_pool.get_char_by_id(battlefield[pos])
				if tchar.defeated == true: continue
				if tchar.has_status('hide'): continue
				counter += 1
		'ally':
			for pos in range(1,4):
				if battlefield[pos] == null:continue
				var tchar = characters_pool.get_char_by_id(battlefield[pos])
				if tchar.defeated == true: continue
				if tchar.has_status('hide'): continue
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
	var fighter = characters_pool.get_char_by_id(enemygroup[pos])
	#fighter.update_timers()
	fighter.process_event(variables.TR_TURN_GET)
	if !fighter.can_act():
		combatlogadd("%s cannot act" % fighter.name)
		fighter.process_event(variables.TR_TURN_F)
		fighter.displaynode.rebuildbuffs()
		call_deferred('select_actor')
		return
	#Selecting active skill
	
	Highlight(pos, 'enemy')
	
	var castskill = fighter.ai._get_action()
	var target = get_char_by_pos(fighter.ai._get_target(castskill))
	
	#remade for the case if taunt would be used
	#not forget that here taunt holds id not pos
	#reqs some update
	if fighter.has_status('confuse'):
		castskill = fighter.get_skil_by_tag('default')
		activeaction = castskill
		UpdateSkillTargets(true)
		target = get_random_target()
	if fighter.has_status('taunt'):
		var targ = characters_pool.get_char_by_id(fighter.taunt)
		fighter.taunt = null
		if can_be_taunted(fighter, targ):
			target = targ;
			castskill = fighter.get_skil_by_tag('default')
	if target == null:
		print(fighter.name, ' no target found')
		return
	while use_skill(castskill, fighter, target):
		castskill = fighter.ai._get_action()
		target = get_char_by_pos(fighter.ai._get_target(castskill))



func env_turn():
	if autoskill == null: return
	activecharacter = null
	use_skill(autoskill, null, null)


func calculateorder():
	turnorder.clear()
	for pos in playergroup:
		var tchar = characters_pool.get_char_by_id(playergroup[pos])
		if tchar.defeated == true:
			continue
		turnorder.append({speed = tchar.speed + randf() * 5, pos = pos})
	for pos in enemygroup:
		var tchar = characters_pool.get_char_by_id(enemygroup[pos])
		if tchar.defeated == true:
			continue
		turnorder.append({speed = tchar.speed + randf() * 5, pos = pos})
	
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
	panel.material = $Panel/PlayerGroup/Back/left/Template.material.duplicate()
	panel.get_node('border').material = $Panel/PlayerGroup/Back/left/Template.get_node('border').material.duplicate()
	fighter.displaynode = panel
	panel.name = 'Character'
	panel.set_script(load("res://files/FighterNode.gd"))
	panel.position = int(spot)
	fighter.position = int(spot)
	panel.fighter = fighter
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
	if fighter.get_stat('mpmax') == 0:
		panel.get_node("MP").value = 0
	panel.get_node("Label").text = fighter.name
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
	panel.rebuildbuffs()

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
	if !allowaction: return;
	var panel = fighter.displaynode
	fighterhighlighted = false
	if variables.CombatAllyHpAlwaysVisible == false || fighter.combatgroup == 'enemy':
		panel.get_node("hplabel").hide()
		panel.get_node("mplabel").hide()
	Input.set_custom_mouse_cursor(cursors.default)
	Stop_Target_Glow();
	for f in allowedtargets.enemy:
		Target_Glow(f);
	for f in allowedtargets.ally:
		Target_Glow(f);

func ShowFighterStats(fighter):
	if fightover == true:
		return
	$StatsPanel.show()
	$StatsPanel.open(fighter)
#	var text = ''
#	if fighter.combatgroup == 'ally':
#
#		$StatsPanel/hp.text = 'Health: ' + str(fighter.hp) + '/' + str(fighter.get_stat('hpmax'))
#		if fighter.mpmax > 0:
#			$StatsPanel/mana.text = "Mana: " + str(fighter.mp) + '/' + str(fighter.get_stat('mpmax'))
#		else:
#			$StatsPanel/mana.text = ''
#	else:
#		$StatsPanel/hp.text = 'Health: ' + str(round(globals.calculatepercent(fighter.hp, fighter.get_stat('hpmax')))) + "%%"
#		if fighter.mpmax > 0:
#			$StatsPanel/mana.text = "Mana: " + str(round(globals.calculatepercent(fighter.mp, fighter.get_stat('mpmax')))) + "%%"
#		else:
#			$StatsPanel/mana.text = ''
#	#TO REBUILD NEW STATS
##	$StatsPanel/damage.text = "Attack: " + str(round(fighter.atk)) 
##	$StatsPanel/crit.text = tr("CRITICAL") + ": " + str(fighter.get_stat('critchance')) + "%%/" + str(fighter.critmod*100) + '%%' 
##	$StatsPanel/hitrate.text = "Hit Rate: " + str(fighter.hitrate)
##	$StatsPanel/armorpen.text = "Armor Penetration: " + str(fighter.armorpenetration)
##
##	$StatsPanel/armor.text = "Armor: " + str(fighter.armor) 
##	$StatsPanel/mdef.text = "M. Armor: " + str(fighter.mdef)
##	$StatsPanel/evasion.text =  "Evasion: " + str(fighter.evasion) 
##	$StatsPanel/speed.text = "Speed: " + str(fighter.speed)
##
##	for i in ['fire','water','earth','air']:
##		get_node("StatsPanel/resist"+i).text = "Resist " + i.capitalize() + ": " + str(fighter.resists[i]) + " "
#
#	$StatsPanel.show()
#	$StatsPanel/name.text = tr(fighter.name)
#	#$StatsPanel/descript.text = fighter.flavor
#	#$StatsPanel/TextureRect.texture = fighter.combat_full_portrait()
##	for i in fighter.buffs:
##		text += i + "\n"
#	for b in fighter.get_all_buffs():
#		text += b.name + '\n'
#	$StatsPanel/effects.bbcode_text = text

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
    
		#stub for AI setuping, need func in charclass for it
		tchar.ai = ai_base.new()
		tchar.ai.set_single_state({})
		tchar.ai.app_obj = tchar
		
		for i in ['hpmax', 'atk', 'matk', 'hitrate', 'armor']:
			tchar.set(i, tchar.get(i) * enemy_stats_mod)
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
	#to add code for different costs
	#and various limits and cooldowns
	allowaction = false
	
	var skill = Skilldata.Skilllist[skill_code]
	if caster != null:
		combatlogadd('\n'+ caster.name + ' uses ' + skill.name + ". ")
	
		caster.mp -= skill.manacost

		if skill.cooldown > 0:
			caster.combat_cooldowns[skill_code] = skill.cooldown
	
	var s_skill1 = S_Skill.new()
	s_skill1.createfromskill(skill_code)
	s_skill1.setup_caster(caster)
	#s_skill1.setup_target(target)
	s_skill1.process_event(variables.TR_CAST)
	
	if caster == null: caster = dummy
	
	for e in caster.triggered_effects:
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if eff.req_skill:
			eff.set_args('skill', s_skill1)
			eff.process_event(variables.TR_CAST)
			eff.set_args('skill', null)
		else:
			eff.process_event(variables.TR_CAST)
	
	var targets #= CalculateTargets(skill, target, true)
	
	var endturn = !skill.tags.has('instant');
	
	for n in range(s_skill1.repeat):
		#var finalhit = (n == s_skill1.repeat - 1)
		# ^ was that necessary?
		if skill.has('random_target') or (target != null and target.hp <= 0) :
			UpdateSkillTargets();
			target = get_random_target()
		
		targets = CalculateTargets(skill, target, true) 
		
		var animations = skill.sfx
		var animationdict = {windup = [], predamage = [], postdamage = []}
		
		
		#sort animations
		for i in animations:
			animationdict[i.period].append(i)
		
		#casteranimations
		if skill.has('sounddata') and skill.sounddata.initiate != null:
			input_handler.PlaySound(skill.sounddata.initiate)
		for i in animationdict.windup:
			var sfxtarget = ProcessSfxTarget(i.target, caster, target)
			CombatAnimations.call(i.code, sfxtarget)
			yield(CombatAnimations, 'pass_next_animation')
		
		if animationdict.windup.size() > 0:
			yield(CombatAnimations, 'cast_finished')
		for i in targets:
			if skill.has('sounddata') and skill.sounddata.strike != null:
				if skill.sounddata.strike == 'weapon':
					input_handler.PlaySound(get_weapon_sound(caster))
				else:
					input_handler.PlaySound(skill.sounddata.strike)
			for j in animationdict.predamage:
				var sfxtarget = ProcessSfxTarget(j.target, caster, i)
				CombatAnimations.call(j.code, sfxtarget)
				yield(CombatAnimations, 'pass_next_animation')
			if animationdict.predamage.size() > 0:
				yield(CombatAnimations, 'predamage_finished')
			if skill.damage_type == 'summon':
				summon(skill.value[0], skill.value[1]);
			elif skill.damage_type == 'resurrect':
				i.resurrect(skill.value[0]) #not sure
			else: 
				execute_skill(s_skill1, caster, i)
				#s_skill1.remove_effects()
			
			#hit landed animation
			
			if skill.has('sounddata') and skill.sounddata.hit != null:
				if skill.sounddata.hittype == 'absolute':
					input_handler.PlaySound(skill.sounddata.hit)
				elif skill.sounddata.hittype == 'bodyarmor':
					input_handler.PlaySound(calculate_hit_sound(skill, caster, target))
			for j in animationdict.postdamage:
				var sfxtarget = ProcessSfxTarget(j.target, caster, i)
				CombatAnimations.call(j.code, sfxtarget)
				yield(CombatAnimations, 'pass_next_animation')
			if animationdict.postdamage.size() > 0:
				yield(CombatAnimations, 'postdamage_finished')
		
		if animationdict.postdamage.size() > 0:
			yield(CombatAnimations, 'alleffectsfinished')
		
	
	s_skill1.process_event(variables.TR_SKILL_FINISH)
	for e in caster.triggered_effects:
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if eff.req_skill:
			eff.set_args('skill', s_skill1)
			eff.process_event(variables.TR_SKILL_FINISH)
			eff.set_args('skill', null)
		else:
			eff.process_event(variables.TR_SKILL_FINISH)
	s_skill1.remove_effects()
	#follow-up
	if skill.has('follow_up'):
		use_skill(skill.follow_up, caster, target)
	if skill.has('not_final'): return
	
	#final
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
		return false
	else:
		allowaction = true
		RebuildSkillPanel()
		RebuildItemPanel()
		SelectSkill(activeaction)
		return true


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

func get_enemy_targets_all(fighter):
	var res = []
	if fighter.position in range(1, 7):
		for p in enemygroup.values():
			var tchar = characters_pool.get_char_by_id(p)
			if tchar.defeated: continue
			if tchar.has_status('hide'): continue
			res.push_back(tchar)
	else:
		for p in playergroup.values():
			var tchar = characters_pool.get_char_by_id(p)
			if tchar.defeated: continue
			if tchar.has_status('hide'): continue
			res.push_back(tchar)
	return res

func get_enemy_targets_melee(fighter):#to complete
	var res = []
	if fighter.position in range(1, 7):
		for p in enemygroup.values():
			var tchar = characters_pool.get_char_by_id(p)
			if tchar.defeated: continue
			if tchar.has_status('hide'): continue
			if CheckMeleeRange('enemy') and tchar.position > 9: continue
			res.push_back(tchar)
	else:
		for p in playergroup.values():
			var tchar = characters_pool.get_char_by_id(p)
			if tchar.defeated: continue
			if tchar.has_status('hide'): continue
			if CheckMeleeRange('player') and tchar.position > 3: continue
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
			for j in battlefield:
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
				elif j in range(1, 13) && targetgroup == 'full':
					if battlefield[j] == null : continue
					var tchar = characters_pool.get_char_by_id(battlefield[j])
					if tchar.defeated: continue
					if !tchar.can_be_damaged(skill.code) and !finale: continue
					array.append(tchar)
	if (!finale) and skill.has('random_target'):
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


func execute_skill(skill, caster, target):
	#var ref = Skillsdata.skilllist[skill]
	var s_skill2:S_Skill = skill.clone()
	s_skill2.setup_target(target)
	#there has to be another trigger cycle but for now there is no one of this type
	s_skill2.setup_final()
	s_skill2.hit_roll()
	s_skill2.resolve_value(CheckMeleeRange(caster.combatgroup))

	s_skill2.process_event(variables.TR_HIT)
	for e in caster.triggered_effects:
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if eff.req_skill:
			eff.set_args('skill', s_skill2)
			eff.process_event(variables.TR_HIT)
			eff.set_args('skill', null)
		else:
			eff.process_event(variables.TR_HIT)
	for e in target.triggered_effects:
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if eff.req_skill:
			eff.set_args('skill', s_skill2)
			eff.process_event(variables.TR_DEF) 
			eff.set_args('skill', null)
		else:
			eff.process_event(variables.TR_DEF)
	#apply resists and modifiers
	if s_skill2.hit_res == variables.RES_MISS:
		miss(target)
		combatlogadd(target.name + " evades the damage.")
		Off_Target_Glow()
		return
	target = s_skill2.target #not sure if it is safe
	s_skill2.calculate_dmg()
	var text = '\n'
	if s_skill2.hit_res == variables.RES_CRIT:
		text += "[color=yellow]Critical!![/color] "
	#new section applying conception of multi-value skills
	#TO POLISH & REMAKE
	for i in range(s_skill2.value.size()):
		if s_skill2.damagestat[i] == 'no_stat': continue #for skill values that directly process into effects
		if s_skill2.damagestat[i] == '+damage_hp': #drain, damage, damage no log, drain no log
			if s_skill2.is_drain && s_skill2.tags.has('no_log'):
				var rval = target.deal_damage(s_skill2.value[i], s_skill2.damage_type)
				var rval2 = caster.heal(rval)
			elif s_skill2.is_drain:
				var rval = target.deal_damage(s_skill2.value[i], s_skill2.damage_type)
				var rval2 = caster.heal(rval)
				text += "%s drained %d hp (%d actually) from %s and gained %d hp\n" %[caster.name, s_skill2.value[i], rval, target.name, rval2]
			elif s_skill2.tags.has('no_log') && !s_skill2.is_drain:
				var rval = target.deal_damage(s_skill2.value[i], s_skill2.damage_type)
			else:
				var rval = target.deal_damage(s_skill2.value[i], s_skill2.damage_type)
				text += "%s is hit for %d damage (%d actually)\n" %[target.name, s_skill2.value[i], rval] 
		elif s_skill2.damagestat[i] == '-damage_hp': #heal, heal no log
			if s_skill2.tags.has('no_log'):
				var rval = target.heal(s_skill2.value[i])
			else:
				var rval = target.heal(s_skill2.value[i])
				text += "%s is healed for %d hp (%d actually)\n" %[target.name, s_skill2.value[i], rval]
		elif s_skill2.damagestat[i] == '+restore_mana': #heal, heal no log
			if !s_skill2.tags.has('no log'):
				var rval = target.mana_update(s_skill2.value[i])
				text += "%s restored %d mana (%d actually)\n" %[target.name, s_skill2.value[i], rval] 
			else:
				target.mana_update(s_skill2.value[i])
		elif s_skill2.damagestat[i] == '-restore_mana': #drain, damage, damage no log, drain no log
			var rval = target.mana_update(-s_skill2.value[i])
			if s_skill2.is_drain:
				var rval2 = caster.mana_update(rval)
				if !s_skill2.tags.has('no log'):
					text += "%s drained %d mana (%d actually) from %s and gained %d mana\n" %[caster.name, s_skill2.value[i], rval, target.name, rval2]
			if !s_skill2.tags.has('no log'):
				text += "%s lost %d mana (%d actually)\n" %[target.name, s_skill2.value[i], -rval] 
		else: 
			var mod = s_skill2.damagestat[i][0]
			var stat = s_skill2.damagestat[i].right(1) 
			if mod == '+':
				var rval = target.stat_update(stat, s_skill2.value[i])
				if !s_skill2.tags.has('no log'):
					text += "%s restored %d %s\n" %[target.name, rval, tr(stat)] 
			elif mod == '-':
				var rval = target.stat_update(stat, -s_skill2.value[i])
				if s_skill2.is_drain:
					var rval2 = caster.stat_update(stat, -rval)
					if !s_skill2.tags.has('no log'):
						text += "%s drained %d %s from %s\n" %[caster.name, s_skill2.value[i], tr(stat),  target.name]
				elif !s_skill2.tags.has('no log'):
					text += "%s loses %d %s" %[target.name, -rval, tr(stat)]
			elif mod == '=':
				var rval = target.stat_update(stat, s_skill2.value[i], true)
				if s_skill2.is_drain:# use this on your own risk
					var rval2 = caster.stat_update(stat, -rval)
					if !s_skill2.tags.has('no log'):
						text += "%s drained %d %s from %s\n" %[caster.name, s_skill2.value[i], tr(stat),  target.name]
				elif !s_skill2.tags.has('no log'):
					text += "%s's %s is now %d\n" %[target.name, tr(stat), s_skill2.value[i]] 
			else: print('error in damagestat %s' % s_skill2.damagestat[i])

	combatlogadd(text)
	s_skill2.process_event(variables.TR_POSTDAMAGE)
	for e in caster.triggered_effects:
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if eff.req_skill:
			eff.set_args('skill', s_skill2)
			eff.process_event(variables.TR_POSTDAMAGE)
			eff.set_args('skill', null)
		else:
			eff.process_event(variables.TR_POSTDAMAGE)
	if target.hp <= 0:
		s_skill2.process_event(variables.TR_KILL)
		for e in caster.triggered_effects:
			var eff:triggered_effect = effects_pool.get_effect_by_id(e)
			if eff.req_skill:
				eff.set_args('skill', s_skill2)
				eff.process_event(variables.TR_KILL)
				eff.set_args('skill', null)
			else:
				eff.process_event(variables.TR_KILL)
		#caster.process_event(variables.TR_KILL)
	#checkdeaths()
	target.displaynode.rebuildbuffs()
	checkdeaths()
	if target.displaynode != null:
		target.displaynode.rebuildbuffs()
	Off_Target_Glow();
	s_skill2.remove_effects()


func miss(fighter):
	CombatAnimations.miss(fighter.displaynode)


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
	for i in activecharacter.combat_skills:
		var newbutton = globals.DuplicateContainerTemplate($SkillPanel/ScrollContainer/GridContainer)
		var skill = Skilldata.Skilllist[i]
		newbutton.get_node("Icon").texture = skill.icon
		newbutton.get_node("manacost").text = str(skill.manacost)
		if skill.manacost <= 0:
			newbutton.get_node("manacost").hide()
		if skill.manacost > activecharacter.mp:
			newbutton.get_node("Icon").modulate = Color(0,0,1)
		if activecharacter.cooldowns.has(i):
			newbutton.disabled = true
			newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
		if !activecharacter.checkreqs(skill.reqs):
			newbutton.disabled = true
			newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
		newbutton.connect('pressed', self, 'SelectSkill', [skill.code])
		if activecharacter.mp < skill.manacost:
			newbutton.disabled = true
			newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
		newbutton.set_meta('skill', skill.code)
		globals.connectskilltooltip(newbutton, i, activecharacter)

func SelectSkill(skill):
	Input.set_custom_mouse_cursor(cursors.default)
	skill = Skilldata.Skilllist[skill]
	if activecharacter.mp < skill.manacost || activecharacter.combat_cooldowns.has(skill.code):
		#SelectSkill('attack')
		call_deferred('SelectSkill', 'attack');
		return
	activecharacter.selectedskill = skill.code
	activeaction = skill.code
	UpdateSkillTargets()
	if allowedtargets.ally.size() == 0 and allowedtargets.enemy.size() == 0:
		checkwinlose();
	

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
	activeaction = item.useskill
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
	$Combatlog/RichTextLabel.append_bbcode(text)
