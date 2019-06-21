extends Control

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

var testenemygroup = {1 : 'elvenrat', 5 : 'elvenrat', 6 : 'elvenrat'}
var testplayergroup = {4 : 'elvenrat', 5 : 'elvenrat', 6 : 'elvenrat'}

func _ready():
	battlefield.resize(14)
	for i in range(1,13):
		battlefield[i] = null
	add_child(CombatAnimations)
#warning-ignore:return_value_discarded
	$ItemPanel/debugvictory.connect("pressed",self, 'cheatvictory')
#warning-ignore:return_value_discarded
	$Rewards/CloseButton.connect("pressed",self,'FinishCombat')


func cheatvictory():
	for i in enemygroup.values():
		i.hp = 0
	#checkwinlose()

func _process(delta):
	pass


func start_combat(newplayergroup, newenemygroup, background, music = 'combattheme'):
	#$Background.texture = images.backgrounds[background]
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
	buildenemygroup(enemygroup)
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
	input_handler.ShowGameTip('explore')
	input_handler.emit_signal("CombatEnded", encountercode)
	input_handler.SetMusic("towntheme")
	get_parent().wincontinue()
	get_parent().levelupscheck()
	globals.call_deferred('EventCheck')


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
	if currentactor < 7:
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
	for i in battlefield:
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
	
	rewardsdict = {materials = {}, items = [], xp = 0}
	for i in enemygroup.values():
		if i == null: #not sure why was this check added
			continue
		var tchar = characters_pool.get_char_by_id(i)
		rewardsdict.xp += tchar.xpreward
		var loot = {}
		if Enemydata.loottables[tchar.loottable].has('materials'):
			for j in Enemydata.loottables[tchar.loottable].materials:
				if randf()*100 <= j.chance:
					loot[j.code] = round(rand_range(j.min, j.max))
			globals.AddOrIncrementDict(rewardsdict.materials, loot)
		if Enemydata.loottables[tchar.loottable].has('usables'):
			for j in Enemydata.loottables[tchar.loottable].usables:
				if randf()*100 <= j.chance:
					var newitem = globals.CreateUsableItem(j.code, round(rand_range(j.min, j.max)))
					rewardsdict.items.append(newitem)
	
	globals.ClearContainerForced($Rewards/HBoxContainer/first)
	globals.ClearContainerForced($Rewards/HBoxContainer/second)
	globals.ClearContainer($Rewards/ScrollContainer/HBoxContainer)
	for i in playergroup.values():
		var tchar = characters_pool.get_char_by_id(i)
		var newbutton = globals.DuplicateContainerTemplate($Rewards/HBoxContainer/first)
		if $Rewards/HBoxContainer/first.get_children().size() >= 5:
			$Rewards/HBoxContainer/first.remove_child(newbutton)
			$Rewards/HBoxContainer/second.add_child(newbutton)
		newbutton.get_node('icon').texture = tchar.portrait_circle()
		newbutton.get_node("xpbar").value = tchar.baseexp
		var level = tchar.level
		tchar.baseexp += ceil(rewardsdict.xp*tchar.xpmod)
		var subtween = input_handler.GetTweenNode(newbutton)
		if tchar.level > level:
			subtween.interpolate_property(newbutton.get_node("xpbar"), 'value', newbutton.get_node("xpbar").value, 100, 0.8, Tween.TRANS_CIRC, Tween.EASE_OUT, 1)
			subtween.interpolate_property(newbutton.get_node("xpbar"), 'modulate', newbutton.get_node("xpbar").modulate, Color("fffb00"), 0.2, Tween.TRANS_CIRC, Tween.EASE_OUT, 1)
			subtween.interpolate_callback(input_handler, 1, 'DelayedText', newbutton.get_node("xpbar/Label"), tr("LEVELUP")+ ': ' + str(tchar.level) + "!")
			subtween.interpolate_callback(input_handler, 1, 'PlaySound', "levelup")
		elif i.level == level && i.baseexp == 100 :
			newbutton.get_node("xpbar").value = 100
			subtween.interpolate_property(newbutton.get_node("xpbar"), 'modulate', newbutton.get_node("xpbar").modulate, Color("fffb00"), 0.2, Tween.TRANS_CIRC, Tween.EASE_OUT)
			subtween.interpolate_callback(input_handler, 0, 'DelayedText', newbutton.get_node("xpbar/Label"), tr("MAXLEVEL"))
		else:
			subtween.interpolate_property(newbutton.get_node("xpbar"), 'value', newbutton.get_node("xpbar").value, tchar.baseexp, 0.8, Tween.TRANS_CIRC, Tween.EASE_OUT, 1)
			subtween.interpolate_callback(input_handler, 2, 'DelayedText', newbutton.get_node("xpbar/Label"), '+' + str(ceil(rewardsdict.xp*tchar.xpmod)))
		subtween.start()
	#$Rewards/ScrollContainer/HBoxContainer.move_child($Rewards/ScrollContainer/HBoxContainer/Button, $Rewards/ScrollContainer/HBoxContainer.get_children().size())
	$Rewards.visible = true
	$Rewards.set_meta("result", 'victory')
	for i in rewardsdict.materials:
		var item = Items.Materials[i]
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
		selected_character.process_event(variables.TR_TURN_F)
		call_deferred('select_actor')
		return
	allowaction = true
	activecharacter = selected_character
	RebuildSkillPanel()
	RebuildItemPanel()
	SelectSkill(selected_character.selectedskill)

#rangetypes melee, any, backmelee

func UpdateSkillTargets():
	var skill = Skilldata.skilllist[activeaction]
	var fighter = activecharacter
	var targetgroups = skill.allowedtargets
	var targetpattern = skill.targetpattern
	var rangetype = skill.userange
	ClearSkillTargets()
	
	for i in $SkillPanel/ScrollContainer/GridContainer.get_children() + $ItemPanel/ScrollContainer/GridContainer.get_children():
		if i.has_meta('skill'):
			i.pressed = i.get_meta('skill') == skill.code
	
	if rangetype == 'weapon':
		if activecharacter.gear.rhand == null:
			rangetype = 'melee'
		else:
			var weapon = state.items[activecharacter.gear.rhand]
			rangetype = weapon.weaponrange
	
	highlightargets = true
	allowedtargets.clear()
	allowedtargets = {ally = [], enemy = []}
	
	if targetgroups.has('enemy'):
		for pos in enemygroup:
			var tchar = characters_pool.get_char_by_id(enemygroup[pos])
			if tchar.defeated == true: #add check on hidden
				continue
			if rangetype == 'any':
				allowedtargets.enemy.append(pos)
			elif rangetype == 'melee':
				if CheckMeleeRange('enemy'):
					allowedtargets.enemy.append(pos)
				else:
					if pos in [7,8,9]:
						allowedtargets.enemy.append(pos)
	if targetgroups.has('ally'):
		for i in playergroup:
			if playergroup[i].defeated == true || playergroup[i] == fighter:
				continue
			allowedtargets.ally.append(i)
	if targetgroups.has('self'):
		allowedtargets.ally.append(int(fighter.position))
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

func CheckMeleeRange(group): #Check if enemy front row is still in place
	var rval = false
	var counter = 0
	#reqires adding hide checks
	match group:
		'enemy':
			for pos in range(7,10):
				if battlefield[pos] == null || characters_pool.get_char_by_id(battlefield[pos]).defeated == true:
					counter += 1
		'player':
			for pos in range(1,4):
				if battlefield[pos] == null || characters_pool.get_char_by_id(battlefield[pos]).defeated == true:
					counter += 1
	if counter == 3:
		rval = true
	return rval

func enemy_turn(pos):
	var fighter = characters_pool.get_char_by_id(enemygroup[pos])
	#fighter.update_timers()
	fighter.process_event(variables.TR_TURN_GET)
	if !fighter.can_act():
		fighter.process_event(variables.TR_TURN_F)
		call_deferred('select_actor')
		return
	
	var castskill = []
	var target = []
	
	#Selecting active skill
	
	Highlight(pos, 'enemy')
	
	for i in fighter.combat_skills:
		var skill = Skilldata.Skilllist[i]
		if fighter.cooldowns.has(skill.code) || fighter.mp < skill.manacost:
			continue
		if !fighter.process_check(skill.reqs):
			continue
		if skill.aipatterns.has('attack'):
			castskill.append([skill, skill.aipriority])
	
	castskill = input_handler.weightedrandom(castskill)
	
	#Figuring Casting Skill range
	var skillrange = castskill.target_range
	if skillrange == 'weapon':
		if fighter.gear.rhand == null:
			skillrange = 'melee'
		else:
			var weapon = state.items[fighter.gear.rhand]
			skillrange = weapon.weaponrange
	
	#Making possible targets array
	#another point of hide checks to add
	if castskill.allowedtargets.has('enemy'):
		for i in playergroup:
			if characters_pool.get_char_by_id(playergroup[i]).defeated == true:
				continue
			if skillrange == 'melee' && !CheckMeleeRange('player') && i in [4,5,6]:
				continue
			
			
			target.append([characters_pool.get_char_by_id(playergroup[i]), 1])
	elif castskill.allowedtargets.has('ally'):
		for i in enemygroup:
			if characters_pool.get_char_by_id(enemygroup[i]).defeated == true:#this check was not added in dsplaced. possibly fixes some bug with healing dead opponents
				continue
			target.append([characters_pool.get_char_by_id(enemygroup[i]), 1])
	elif castskill.allowedtargets.has('self'):
		target.append([fighter, 1]);
	
	target = input_handler.weightedrandom(target)
	
	#remade for the case if taunt would be used
	#not forget that here taunt holds id not pos
	if fighter.taunt != null:
		var targ = characters_pool.get_char_by_id(fighter.taunt);
		fighter.taunt = null
		if targ.hp > 0:
			target = targ;
			castskill = Skilldata.skilllist['attack'];
	if target == null:
		print(fighter.name, ' no target found')
		return
	use_skill(castskill.code, fighter, target)

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
	panel.get_node("HP").value = globals.calculatepercent(fighter.hp, fighter.hpmax)
	panel.get_node("Mana").value = globals.calculatepercent(fighter.mp, fighter.mpmax)
	panel.hp = fighter.hp
	if fighter.mpmax == 0:
		panel.get_node("Mana").value = 0
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
		cur_targets = CalculateTargets(Skilldata.skilllist[activeaction], activecharacter, fighter); 
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
	var text = ''
	if fighter.combatgroup == 'ally':

		$StatsPanel/hp.text = 'Health: ' + str(fighter.hp) + '/' + str(fighter.hpmax)
		if fighter.manamax > 0:
			$StatsPanel/mana.text = "Mana: " + str(fighter.mp) + '/' + str(fighter.mpmax)
		else:
			$StatsPanel/mana.text = ''
	else:
		$StatsPanel/hp.text = 'Health: ' + str(round(globals.calculatepercent(fighter.hp, fighter.hpmax))) + "%"
		if fighter.manamax > 0:
			$StatsPanel/mana.text = "Mana: " + str(round(globals.calculatepercent(fighter.mp, fighter.mpmax))) + "%"
		else:
			$StatsPanel/mana.text = ''
	$StatsPanel/damage.text = "Damage: " + str(round(fighter.damage)) 
	$StatsPanel/crit.text = tr("CRITICAL") + ": " + str(fighter.critchance) + "%/" + str(fighter.critmod*100) + '%' 
	$StatsPanel/hitrate.text = "Hit Rate: " + str(fighter.hitrate)
	$StatsPanel/armorpen.text = "Armor Penetration: " + str(fighter.armorpenetration)
	
	$StatsPanel/armor.text = "Armor: " + str(fighter.armor) 
	$StatsPanel/mdef.text = "M. Armor: " + str(fighter.mdef)
	$StatsPanel/evasion.text =  "Evasion: " + str(fighter.evasion) 
	$StatsPanel/speed.text = "Speed: " + str(fighter.speed)

	for i in ['fire','water','earth','air']:
		get_node("StatsPanel/resist"+i).text = "Resist " + i.capitalize() + ": " + str(fighter['resist'+i]) + " "
	$StatsPanel.show()
	$StatsPanel/name.text = tr(fighter.name)
	$StatsPanel/descript.text = fighter.flavor
	$StatsPanel/TextureRect.texture = fighter.combat_full_portrait()
#	for i in fighter.buffs:
#		text += i + "\n"
	for b in fighter.get_all_buffs():
		text += b.name + '\n'
	$StatsPanel/effects.bbcode_text = text

func HideFighterStats():
	$StatsPanel.hide()

func FighterPress(pos):
	if allowaction == false || (!allowedtargets.enemy.has(pos) && !allowedtargets.ally.has(pos)):
		return
	ClearSkillTargets()
	ClearItemPanel()
	ClearSkillPanel()
	use_skill(activeaction, activecharacter, characters_pool.get_char_by_id(battlefield[pos]))


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
		var tchar = Slave.new()
		tchar.generate_simple_fighter(tempname)
		tchar.combatgroup = 'enemy'
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
		var fighter = state.characters[group[i]] #!!
		fighter.combatgroup = 'ally'
		battlefield[int(i)] = fighter.id
		make_fighter_panel(fighter, i)
		newgroup[i] = fighter.id
	playergroup = newgroup

func summon(montype, limit):
	# for now summoning is implemented only for opponents
	# cause i don't know if ally summons must be player- or ai-controlled
	# and don't know if it is possible to implement ai-controlled ally
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


#func SendSkillEffect(skilleffect, caster, target):
#	var endtargets = []
#	if skilleffect.target == 'self':
#		endtargets.append(caster)
#	elif skilleffect.target == 'target':
#		endtargets.append(target)
#
#	var data = {caster = caster}
#	if skilleffect.has('value'):
#		data.value = skilleffect.value
#
#	for i in endtargets:
#		if skilleffect.has('chance') && skilleffect.chance < randf():
#			continue
#		data.target = i
#		globals.skillsdata.call(skilleffect.effect, data)
#

func use_skill(skill_code, caster, target):
	#to add code for different costs
	#and various limits and cooldowns
	allowaction = false
	
	var skill = Skilldata.skilllist[skill_code]
	combatlogadd('\n'+ caster.name + ' uses ' + skill.name + ". ")
	
	caster.mp -= skill.manacost
	var endturn = !skill.tags.has('instant');

	if skill.cooldown > 0:
		caster.cooldowns[skill_code] = skill.cooldown
	var s_skill1 = S_Skill.new()
	s_skill1.createfromskill(skill_code)
	s_skill1.setup_caster(caster)
	s_skill1.setup_target(target)
	s_skill1.process_event(variables.TR_CAST)
	for e in caster.triggered_effects:
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if eff.req_skill:
			eff.set_args('skill', s_skill1)
			eff.process_event(variables.TR_CAST)
			eff.set_args('skill', null)
		else:
			eff.process_event(variables.TR_CAST)
	# this section is for rare triggers that cares about selected target (not being real target)
	for e in target.triggered_effects:
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if eff.req_skill:
			eff.set_args('skill', s_skill1)
			eff.process_event(variables.TR_CAST_TARGET) 
			eff.set_args('skill', null)
		else:
			eff.process_event(variables.TR_CAST_TARGET)
	
	var targets = CalculateTargets(skill, caster, target)

#	var repeat = 1;
#	if skill.has('repeat'):
#		repeat = skill.repeat;
	
	for n in range(s_skill1.repeat):
		#var finalhit = (n == s_skill1.repeat - 1)
		# ^ was that necessary?
		if target.hp <= 0:
			UpdateSkillTargets();
			var new_targets = [];
			for t in allowedtargets.ally:
				new_targets.push_back(playergroup[t]);
			for t in allowedtargets.enemy:
				new_targets.push_back(enemygroup[t]);
			if new_targets.size() == 0:
				break;
			target = new_targets[int(randf()*new_targets.size())];
			targets = CalculateTargets(skill, caster, target) 
		var animations = skill.sfx
		var animationdict = {windup = [], predamage = [], postdamage = []}
		
		
		#sort animations
		for i in animations:
			animationdict[i.period].append(i)
		
		#casteranimations
		if skill.sounddata.initiate != null:
			input_handler.PlaySound(skill.sounddata.initiate)
		for i in animationdict.windup:
			var sfxtarget = ProcessSfxTarget(i.target, caster, target)
			CombatAnimations.call(i.code, sfxtarget)
			yield(CombatAnimations, 'pass_next_animation')
		
		if animationdict.windup.size() > 0:
			yield(CombatAnimations, 'cast_finished')
		for i in targets:
			if skill.sounddata.strike != null:
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
			if skill.damagetype == 'summon':
				summon(skill.value[0], skill.value[1]);
			else: 
				execute_skill(s_skill1, caster, i)
				s_skill1.remove_effects()
				pass
			
			#hit landed animation
			
			if skill.sounddata.hit != null:
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
		target.displaynode.rebuildbuffs()
		checkdeaths()
		if target.displaynode != null:
			target.displaynode.rebuildbuffs()
		checkdeaths()
	
	s_skill1.process_event(variables.TR_SKILL_FINISH)
	for e in caster.triggered_effects:
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if eff.req_skill:
			eff.set_args('skill', s_skill1)
			eff.process_event(variables.TR_SKILL_FINISH)
			eff.set_args('skill', null)
		else:
			eff.process_event(variables.TR_SKILL_FINISH)
	
	if activeitem != null:
		activeitem.amount -= 1
		activeitem = null
		SelectSkill('attack')
	

	caster.displaynode.rebuildbuffs()
	if fighterhighlighted == true:
		FighterMouseOver(target)
	#print(caster.name + ' finished attacking') 
	if endturn or caster.hp <= 0 or !caster.can_act():
		#on end turn triggers
		caster.process_event(variables.TR_TURN_F)
		call_deferred('select_actor')
	else:
		allowaction = true
		RebuildSkillPanel()
		RebuildItemPanel()
		SelectSkill(activeaction)


func ProcessSfxTarget(sfxtarget, caster, target):
	match sfxtarget:
		'caster':
			return caster.displaynode
		'target':
			return target.displaynode



#var rows = {
#	1:[1,4],
#	2:[2,5],
#	3:[3,6],
#	4:[7,10],
#	5:[8,11],
#	6:[9,12],
#} 
#var lines = {
#	1 : [1,2,3],
#	2 : [4,5,6],
#	3 : [7,8,9],
#	4 : [10,11,12],
#}


func CalculateTargets(skill, caster, target):
	var array = []
	
	var targetgroup
	var skilltargetgroups = skill.allowedtargets
	
	if target.position in range(1,7):
		targetgroup = 'player'
	else:
		targetgroup = 'enemy'
	#not sure about adding hide checks here
	match skill.targetpattern:
		'single':
			array = [target]
		'row':
			for i in variables.rows:
				if variables.rows[i].has(target.position):
					for j in variables.rows[i]:
						if battlefield[j] != null && characters_pool.get_char_by_id(battlefield[j]).defeated != true:
							array.append(characters_pool.get_char_by_id(battlefield[j]))
		'line':
			for i in variables.lines:
				if variables.lines[i].has(target.position):
					for j in variables.lines[i]:
						if battlefield[j] != null && characters_pool.get_char_by_id(battlefield[j]).defeated != true:
							array.append(characters_pool.get_char_by_id(battlefield[j]))
		'all':
			for j in battlefield:
				if j in range(1,7) && targetgroup == 'player':
					if battlefield[j] != null && characters_pool.get_char_by_id(battlefield[j]).defeated != true:
							array.append(characters_pool.get_char_by_id(battlefield[j]))
				elif j in range(7, 13) && targetgroup == 'enemy':
					if battlefield[j] != null && characters_pool.get_char_by_id(battlefield[j]).defeated != true:
							array.append(characters_pool.get_char_by_id(battlefield[j]))
	#print(array)
	return array



func execute_skill(skill, caster, target):
	#var ref = Skillsdata.skilllist[skill]
	var s_skill2:S_Skill = skill.clone()
	s_skill2.setup_target(target)
	#there has to be another trigger cycle but for now there is no one of this type
	s_skill2.setup_final()
	s_skill2.hit_roll()
	s_skill2.resolve_value(CheckMeleeRange(caster.combatgroup))
	#apply triggers
#	for t in s_skill.casteffects:
#		s_skill.apply_effect(t, variables.TR_HIT)
#	caster.on_skill_check(s_skill, variables.TR_HIT)
#	target.on_skill_check(s_skill, variables.TR_DEF)
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
	for i in range(s_skill2.value.size()):
		if s_skill2.damagestat[i] == 'no_stat': continue #for skill values that directly process into effects
		if s_skill2.damagestat[i] == 'hp': #heal, drain, damage, heal no log,  damage no log,  drain no log
			if s_skill2.tags.has('heal'):
				var rval = target.heal(s_skill2.value[i])
				text += "%s is healed for %d hp (%d actually)\n" %[target.name, s_skill2.value[i], rval] 
			elif s_skill2.tags.has('drain') && s_skill2.is_drain:
				var rval = target.deal_damage(s_skill2.value[i], s_skill2.damagesrc)
				var rval2 = caster.heal(rval)
				text += "%s drained %d hp (%d actually) from %s and gained %d hp\n" %[caster.name, s_skill2.value[i], rval, target.name, rval2]
			elif s_skill2.tags.has('damage') && !s_skill2.is_drain:
				var rval = target.deal_damage(s_skill2.value[i], s_skill2.damagesrc)
				text += "%s is hit for %d damage (%d actually)\n" %[target.name, s_skill2.value[i], rval] 
			elif s_skill2.value[i] <= 0:
				target.heal(-s_skill2.value[i])
			elif s_skill2.is_drain:
				var rval = target.deal_damage(s_skill2.value[i], s_skill2.damagesrc)
				caster.heal(rval)
			else:
				target.deal_damage(s_skill2.value[i], s_skill2.damagesrc)
		elif s_skill2.damagestat[i] == 'mana': #heal, drain, damage, heal no log,  damage no log,  drain no log
			if s_skill2.tags.has('heal'):
				var rval = target.mana_update(s_skill2.value[i])
				text += "%s restored %d mana (%d actually)\n" %[target.name, s_skill2.value[i], rval] 
			elif s_skill2.tags.has('drain') && s_skill2.is_drain:
				var rval = target.mana_update(-s_skill2.value[i])
				var rval2 = caster.mana_update(rval)
				text += "%s drained %d mana (%d actually) from %s and gained %d mana\n" %[caster.name, s_skill2.value[i], rval, target.name, rval2]
			elif s_skill2.tags.has('damage') && !s_skill2.is_drain:
				var rval = target.mana_update(-s_skill2.value[i])
				text += "%s lost %d mana (%d actually)\n" %[target.name, s_skill2.value[i], -rval] 
			elif s_skill2.value[i] < 0:
				target.mana_update(s_skill2.value[i])
			elif s_skill2.is_drain:
				var rval = target.mana_update(-s_skill2.value[i])
				caster.mana_update(rval)
			else:
				target.mana_update(-s_skill2.value[i])
		else: #add, drain, remove, set, no log
			var rval = target.stat_update(s_skill2.damagestat[i], s_skill2.value[i])
			if s_skill2.is_drain:
				var rval2 = caster.stat_update(s_skill2.damagestat[i], -rval) # do not use drain on stats that are not rel-damaging
			if s_skill2.tags.has('s_heal'):
				text += "%s restored %d %s\n" %[target.name, rval, tr(s_skill2.damagestat[i])] 
			elif s_skill2.tags.has('s_drain') && s_skill2.is_drain:
				text += "%s drained %d %s from %s\n" %[caster.name, s_skill2.value[i], tr(s_skill2.damagestat[i]),  target.name]
			elif s_skill2.tags.has('s_damage') && !s_skill2.is_drain:
				text += "%s loses %d %s" %[target.name, -rval, tr(s_skill2.damagestat[i])]
			elif s_skill2.tags.has('s_set') && !s_skill2.is_drain:
				text += "%s's %s is now %d\n" %[target.name, tr(s_skill2.damagestat[i]), s_skill2.value[i]] 
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
	Off_Target_Glow();


func miss(fighter):
	CombatAnimations.miss(fighter.displaynode)

#func makebuff(buff, caster, target):
#	var newbuff = {code = buff.code, caster = caster, duration = buff.duration, effects = [], tags = []}
#	if buff.has('icon'):
#		newbuff.icon = buff.icon
#	for i in buff.effects:
#		var value = calculate_number_from_string_array(i.value, caster, target)
#		var buffeffect = {value = value, stat = i.stat}
#		newbuff.effects.append(buffeffect)
#
#	return newbuff

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
	for i in activecharacter.skills:
		var newbutton = globals.DuplicateContainerTemplate($SkillPanel/ScrollContainer/GridContainer)
		var skill = Skilldata.skilllist[i]
		newbutton.get_node("Icon").texture = skill.icon
		newbutton.get_node("manacost").text = str(skill.manacost)
		if skill.manacost <= 0:
			newbutton.get_node("manacost").hide()
		if skill.manacost > activecharacter.mana:
			newbutton.get_node("Icon").modulate = Color(0,0,1)
		if activecharacter.cooldowns.has(i):
			newbutton.disabled = true
			newbutton.get_node("Icon").material = load("res://assets/sfx/bw_shader.tres")
		if !activecharacter.process_check(skill.reqs):
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
	skill = Skilldata.skilllist[skill]
	if activecharacter.mp < skill.manacost || activecharacter.cooldowns.has(skill.code):
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
		if i.itemtype == 'usable':
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
