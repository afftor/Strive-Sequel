extends TextureButton


signal signal_RMB
signal signal_RMB_release
signal signal_LMB

var position = 0
var fighter
var RMBpressed = false

var damageeffectsarray = []

var hp
var mp

func _process(delta):
	if $hplabel.visible:
		update_hp_label()
	if $mplabel.visible:
		update_mp_label()
	for i in damageeffectsarray:
		if i.played == false:
			textdamageeffect(i)
			i.played = true
		yield(get_tree().create_timer(0.5), "timeout")
	for i in damageeffectsarray:
		if i.played == true:
			damageeffectsarray.erase(i)
			break

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


func update_hp():
	if hp == null:
		hp = fighter.hp
	if hp != null && hp != fighter.hp:
		var data = {value = 0, type = '', color = Color(), played = false}
		data.value = fighter.hp - hp
		if data.value < 0:
			data.color = Color(1,0.2,0.2)
			if fighter.combatgroup == 'ally':
				data.type = 'damageally'
			else:
				data.type = 'damageenemy' 
		else:
			data.type = 'heal'
			data.color = Color(0.2,1,0.2)
		
		hp = fighter.hp
		damageeffectsarray.append(data)
	

func textdamageeffect(data):
	var tween = input_handler.GetTweenNode(self)
	var node = get_node("HP")
	
	
	input_handler.FloatText(self, str(data.value), data.type, data.color, 2, 0.2, get_node('Icon').rect_size/2)
#		tween.interpolate_property(self.material.shader, 'modulate', Color(1,0,0,0), Color(1,0,0,1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#		tween.interpolate_property(self.material.shader, 'modulate', Color(1,0,0,1), Color(1,0,0,0), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.3)
	
	
	tween.interpolate_property(node, 'value', node.value, globals.calculatepercent(fighter.hp, fighter.hpmax()), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func update_mana():
	var tween = input_handler.GetTweenNode(self)
	var node = get_node("Mana")
	mp = fighter.mana
	
	tween.interpolate_property(node, 'value', node.value, globals.calculatepercent(fighter.mana, fighter.manamax()), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func update_hp_label():
	if fighter.combatgroup == 'ally':
		$hplabel.text = str(fighter.hp) + '/' + str(fighter.hpmax())
	else:
		$hplabel.text = str(round(globals.calculatepercent(fighter.hp, fighter.hpmax()))) + '%'

func update_mp_label():
	if fighter.combatgroup == 'ally':
		$mplabel.text = str(fighter.mana) + '/' + str(fighter.manamax())
	else:
		$mplabel.text = str(round(globals.calculatepercent(fighter.mana, fighter.manamax()))) + '%'

func defeat():
	$Icon.material = load("res://assets/sfx/bw_shader.tres")
	input_handler.FadeAnimation(self, 0.5, 0.3)
	set_process_input(false)


func update_shield(): #FILL COLORS FOR OTHER SHIELD TYPES
	if fighter.shield <= 0: 
		self.material.set_shader_param('modulate', Color(0.9, 0.9, 0.9, 0.0))
		return
	else:
		match fighter.shieldtype:
			variables.S_PHYS: #tempate, add all other values from this enum
				self.material.set_shader_param('modulate', Color(0.8, 0.8, 0.8, 1.0)); #example

func rebuildbuffs():
	globals.ClearContainer($Buffs)
	for i in fighter.buffs:
		var newbuff = globals.DuplicateContainerTemplate($Buffs)
		var buff = Effectdata.buffs[i]
		var text = buff.description
		newbuff.texture = buff.icon
		if buff.has('bonuseffect'):
			match buff.bonuseffect:
				'barrier':
					newbuff.get_node("Label").show()
					newbuff.get_node("Label").text = str(fighter.shield)
		globals.connecttooltip(newbuff, text)

