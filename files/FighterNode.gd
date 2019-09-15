extends TextureButton

var animation_node

signal signal_RMB
signal signal_RMB_release
signal signal_LMB

var position = 0
var fighter
var RMBpressed = false

#var damageeffectsarray = []

var hp
var mp

#data format: node, time, type, slot, params

#func _process(delta):
#	if $hplabel.visible:
#		update_hp_label()
#	if $mplabel.visible:
#		update_mp_label()
#	for i in damageeffectsarray:
#		if i.played == false:
#			textdamageeffect(i)
#			i.played = true
#		yield(get_tree().create_timer(0.5), "timeout")
#	for i in damageeffectsarray:
#		if i.played == true:
#			damageeffectsarray.erase(i)
#			break

func _input(event):
	if get_global_rect().has_point(get_global_mouse_position()):
		if event.is_pressed():
			if event.is_action("RMB"):
				emit_signal("signal_RMB", fighter)
				RMBpressed = true
			elif event.is_action('LMB'):
				emit_signal("signal_LMB", position)
	if event.is_action_released("RMB") && RMBpressed == true:
		emit_signal("signal_RMB_release")
		RMBpressed = false

func get_attack_vector():
	if fighter.combatgroup == 'ally': return Vector2(100, 0)
	elif fighter.combatgroup == 'enemy': return Vector2(-100, 0)

func update_hp():
	if hp == null:
		hp = fighter.hp
	if hp != null && hp != fighter.hp:
		var args = {damage = 0, type = '', color = Color(), newhp = fighter.hp, newhpp = globals.calculatepercent(fighter.hp, fighter.get_stat('hpmax'))}
		args.damage = fighter.hp - hp
		if args.damage < 0:
			args.color = Color(1,0.2,0.2)
			if fighter.combatgroup == 'ally':
				args.type = 'damageally'
			else:
				args.type = 'damageenemy' 
		else:
			args.type = 'heal'
			args.color = Color(0.2,1,0.2)
		hp = fighter.hp
		#damageeffectsarray.append(data)
		var data = {node = self, time = globals.combat_node.turns,type = 'hp_update',slot = 'HP', params = args}
		animation_node.add_new_data(data)

func update_mana():
	if mp == null:
		mp = fighter.mp
	if mp != null && mp != fighter.mp:
		var args = {newmp = fighter.mp, newmpp = globals.calculatepercent(fighter.mp, fighter.get_stat('mpmax'))}
		mp = fighter.mp
		#damageeffectsarray.append(data)
		var data = {node = self, time = globals.combat_node.turns,type = 'mp_update',slot = 'MP', params = args}
		animation_node.add_new_data(data)

func defeat():#not working correctly at all
	$Icon.material = load("res://assets/sfx/bw_shader.tres")
	#input_handler.FadeAnimation(self, 0.5, 0.3)
	set_process_input(false)

func update_shield(): 
	var args = {}
	if fighter.shield <= 0: 
		args.color = Color(0.9, 0.9, 0.9, 0.0)
		#self.material.set_shader_param('modulate', Color(0.9, 0.9, 0.9, 0.0))
		#return
	else:
		args.color = Color(0.8, 0.8, 0.8, 1.0)
		#self.material.set_shader_param('modulate', Color(0.8, 0.8, 0.8, 1.0)); #example
	var data = {node = self, time = globals.combat_node.turns, type = 'shield_update',slot = 'SHIELD', params = args}
	animation_node.add_new_data(data)

func process_sfx(code):
	var data = {node = self, time = globals.combat_node.turns,type = code, slot = 'SFX', params = {}}
	animation_node.add_new_data(data)

func process_sound(sound):
	var data = {node = self, time = globals.combat_node.turns, type = 'sound', slot = 'SFX', params = {sound = sound}}
	animation_node.add_new_data(data)

#control visuals
func rebuildbuffs():
	globals.ClearContainer($Buffs)
	for i in fighter.get_all_buffs():
		var newbuff = globals.DuplicateContainerTemplate($Buffs)
		#var buff = Effectdata.buffs[i]
		var text = i.description
		newbuff.texture = i.icon
		if i.template.has('bonuseffect'):
			match i.template.bonuseffect:
				'barrier':
					newbuff.get_node("Label").show()
					newbuff.get_node("Label").text = str(fighter.shield)
		globals.connecttexttooltip(newbuff, text)


func update_hp_label(newhp, newhpp):
	if fighter.combatgroup == 'ally' || variables.show_enemy_hp:
		$hplabel.text = str(newhp) + '/' + str(fighter.get_stat('hpmax'))
	else:
		$hplabel.text = str(round(newhpp)) + '%%'

func update_mp_label(newmp, newmpp):
	if fighter.combatgroup == 'ally' || variables.show_enemy_hp:
		$mplabel.text = str(newmp) + '/' + str(fighter.get_stat('mpmax'))
	else:
		$mplabel.text = str(round(newmpp)) + '%%'
