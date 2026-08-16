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
var buffs = []

var is_active = true

var buff_scroll_max_page = 0
var buff_scroll_page = 0

var buffs_timer
var buffs_fade_timer
var buffs_cont
var buffs_on_pause = false

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

#func _input(event):
#	if fighter == null: return
#	if get_global_rect().has_point(get_global_mouse_position()):
#		if event.is_pressed():
#			if event.is_action("RMB"):
#				emit_signal("signal_RMB", fighter)
#				RMBpressed = true
#			elif event.is_action('LMB'):
#				emit_signal("signal_LMB", position)
#	if event.is_action_released("RMB") && RMBpressed == true:
#		emit_signal("signal_RMB_release")
#		RMBpressed = false

#Floating of the active fighter: the card gently rises and sinks while a shadow
#breathes under it. The rest position is not captured from the live node, we know
#it for sure: every slot is a Container exactly the size of the card, and
#make_fighter_panel places it at zero. A snapshot of the current position would
#cement any foreign shift that hasn't been played out yet.
const FLOAT_RISE = 8.0
const FLOAT_PERIOD = 1.6
const FLOAT_SHADOW_ALPHA = 0.45
const FLOAT_HOME = Vector2(0, 0)

var float_on = false
#var float_shadow = null
#var float_shadow_y = 0.0
var float_time = 0.0
var float_shifted = false

const STEALTH_DESAT = 0.7
const STEALTH_TINT = Color(0.62, 0.74, 1.0)

var stealth_on = false


func _ready():
	set_process(false)
	connect("gui_input", self, "_on_Button_gui_input")
	if has_node("Buffs"):
		buffs_timer = $Buffs/Timer
		buffs_fade_timer = $Buffs/fade_timer
		buffs_cont = $Buffs
		buffs_timer.connect("timeout", self, "show_next_buff_page")
		buffs_fade_timer.connect("timeout", self, "show_buff_page_true")
		buffs_cont.connect("mouse_entered", self, "mouse_in_buffs")
		buffs_cont.connect("mouse_exited", self, "try_mouse_out_buffs")
		buffs_cont.connect("gui_input", self, "_on_buffs_gui_input")
		buffs_cont.connect("resized", self, "_on_buffs_cont_resized")

func _on_Button_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			BUTTON_LEFT:
				emit_signal("signal_LMB", position)
			BUTTON_RIGHT:
				emit_signal("signal_RMB_release")
				emit_signal("signal_RMB", fighter.id)


func get_attack_vector():
	if fighter.combatgroup == 'ally': return Vector2(100, 0)
	elif fighter.combatgroup == 'enemy': return Vector2(-100, 0)

func get_flip():
	return (fighter.combatgroup == 'ally')

func update_hp():
	if hp == null:
		hp = fighter.hp
	if hp != null && hp != fighter.hp:
		var args = {damage = 0, type = '', color = Color(), newhp = fighter.hp, newhpp = input_handler.calculatepercent(fighter.hp, fighter.get_stat('hpmax')), damage_float = true}
		args.damage = fighter.hp - hp
		if args.damage < 0:
			args.color = Color(0.8,0.2,0.2)
			if fighter.combatgroup == 'ally':
				args.type = 'damageally'
			else:
				args.type = 'damageenemy' 
		else:
			args.type = 'heal'
			args.color = Color(0.2,0.8,0.2)
		if hp <= 0: 
			args.damage_float = false
			if args.newhp > 0:
				args.res = true
		hp = fighter.hp
		if args.newhp < 0:
			args.newhp = 0
			args.newhpp = 0
			hp = 0
		#damageeffectsarray.append(data)
		var data = {node = self, time = input_handler.combat_node.turns,type = 'hp_update',slot = 'HP', params = args}
		animation_node.add_new_data(data)

func update_mana():
	if mp == null:
		mp = fighter.mp
	if mp != null && mp != fighter.mp:
		var args = {newmp = fighter.mp, newmpp = input_handler.calculatepercent(fighter.mp, fighter.get_stat('mpmax'))}
		mp = fighter.mp
		#damageeffectsarray.append(data)
		var data = {node = self, time = input_handler.combat_node.turns,type = 'mp_update',slot = 'MP', params = args}
		animation_node.add_new_data(data)


func defeat():
	var data = {node = self, time = input_handler.combat_node.turns, type = 'defeat', slot = 'SFX', params = {}}
	animation_node.add_new_data(data)



func update_shield(): 
	var args = {}
	if fighter.shield <= 0: 
		args.color = Color(0.9, 0.9, 0.9, 0.0)
		#self.material.set_shader_param('modulate', Color(0.9, 0.9, 0.9, 0.0))
		#return
	else:
		args.color = Color(0.8, 0.8, 0.8, 1.0)
		#self.material.set_shader_param('modulate', Color(0.8, 0.8, 0.8, 1.0)); #example
	var data = {node = self, time = input_handler.combat_node.turns, type = 'shield_update',slot = 'SHIELD', params = args}
	animation_node.add_new_data(data)

func process_sfx(code):
	if fighter == null: return
	var data = {node = self, time = input_handler.combat_node.turns,type = code, slot = 'SFX', params = {}}
	animation_node.add_new_data(data)

func process_sound(sound):
	var data = {node = self, time = input_handler.combat_node.turns, type = 'sound', slot = 'sound', params = {sound = sound}}
	animation_node.add_new_data(data)

func rebuildbuffs():
	if fighter == null: return
	if !fighter.is_active: return
	var data = {node = self, time = input_handler.combat_node.turns, type = 'buffs', slot = 'buffs', params = []}#fighter.get_combat_buffs()}
	animation_node.add_new_data(data)

func process_critical():
	var data = {node = self, time = input_handler.combat_node.turns, type = 'critical', slot = 'crit', params = {}}
	animation_node.add_new_data(data)

#control visuals
func noq_rebuildbuffs():
	if !visible: return
	#all that legacy stuff should be deleted probably
#	var oldbuff = 0
#	var newbuffs = fighter.get_combat_buffs()
#	if fighter.hp <= 0:
#		newbuffs.clear()
#	for b in newbuffs:
#		if buffs.has(b.template_name): oldbuff += 1
##	if oldbuff == buffs.size():
#	if false: #for test purpose
#		for i in newbuffs:
#			if buffs.has(i.template_name): update_buff(i)
#			else: add_buff(i)
#	else:
#	input_handler.ClearContainer(buffs_cont)
#	buffs.clear()
#	for i in newbuffs:
#		add_buff(i)
#	switch_buff_scroll(newbuffs.size())
	
	buffs = fighter.get_combat_buffs()
	if fighter.hp <= 0:
		buffs.clear()
	set_stealth(fighter.hp > 0 and fighter.has_status('hide'))
	if buffs.empty():
		buff_scroll_max_page = 0
	else:
		buff_scroll_max_page = int(ceil(float(buffs.size())/3.0)) - 1
	if buff_scroll_page > buff_scroll_max_page:
		buff_scroll_page = 0
	show_buff_page(false)
	if buff_scroll_max_page > 0:
		if buffs_timer.is_stopped():
			buffs_timer.start()
	elif !buffs_timer.is_stopped():
		buffs_timer.stop()

func show_next_buff_page():
	buff_scroll_page += 1
	if buff_scroll_page > buff_scroll_max_page:
		buff_scroll_page = 0
	show_buff_page()

var buffs_in_fade = false
func show_buff_page(make_fade = true):
	if buffs_in_fade: return
	if make_fade:
		ResourceScripts.core_animations.FadeAnimation(buffs_cont, buffs_fade_timer.wait_time)
		buffs_in_fade = true
		buffs_fade_timer.start()
	else:
		show_buff_page_true()
func show_buff_page_true():
	input_handler.ClearContainer(buffs_cont)
	var max_pos = min((buff_scroll_page+1) * 3, buffs.size())
	for i in range(buff_scroll_page * 3, max_pos):
		add_buff(buffs[i])
	if buffs_in_fade:
		buffs_in_fade = false
		ResourceScripts.core_animations.UnfadeAnimation(buffs_cont, buffs_fade_timer.wait_time)

func add_buff(i):
	if !visible: return
	var newbuff = input_handler.DuplicateContainerTemplate(buffs_cont)
	var text = i.description
	newbuff.texture = i.icon
#	buffs.push_back(i.template_name)
	if i.template.has('bonuseffect'):
		match i.template.bonuseffect:
			'barrier':
				newbuff.get_node("Label").show()
				newbuff.get_node("Label").text = str(fighter.shield)
			'lust':
				newbuff.get_node("Label").show()
				newbuff.get_node("Label").text = str(fighter.get_stat('lust'))
			'counterattacks':
				newbuff.get_node("Label").show()
				newbuff.get_node("Label").text = str(fighter.get_stat('counterattacks'))
			'fed':
				newbuff.get_node("Label").show()
				newbuff.get_node("Label").text = str(fighter.get_stat('fed'))
	newbuff.hint_tooltip = text
	
	if i.tags.has('show_amount'):
		newbuff.get_node("Label").text = str(i.get_stacks())
		newbuff.get_node("Label").set("custom_colors/font_color",Color(1,1,0))
		newbuff.get_node("Label").show()
	else:
		var tmp = i.get_duration()
		if tmp != null:
			newbuff.get_node("Label").text = str(tmp.count)
			match tmp.event:
				'hours':
					newbuff.get_node("Label").set("custom_colors/font_color",Color(0,0,1))
				'turns':
					newbuff.get_node("Label").set("custom_colors/font_color",Color(0,1,0))
				'hits':
					newbuff.get_node("Label").set("custom_colors/font_color",Color(1,0,0))
				'attacks':
					newbuff.get_node("Label").set("custom_colors/font_color",Color(1,0,0))
			newbuff.get_node("Label").show()

func mouse_in_buffs():
	if buffs_on_pause: return
	buffs_on_pause = true
	buffs_timer.paused = true

func try_mouse_out_buffs():
	if !buffs_on_pause or is_mouse_on_buffs(): return
	buffs_on_pause = false
	buffs_timer.paused = false
	if !buffs_timer.is_stopped():
		buffs_timer.start()

func _on_buffs_gui_input(event):
	if !buffs_on_pause or buff_scroll_max_page == 0: return
	if event.is_action_released("LMB"):
		show_next_buff_page()
#	elif event.is_action_released("RMB"):
#		buff_scroll_page -= 1
#		if buff_scroll_page < 0:
#			buff_scroll_page = buff_scroll_max_page
#		show_buff_page()

func _on_buffs_cont_resized():
	if buffs_on_pause:
		try_mouse_out_buffs()
	elif !buffs_on_pause and is_mouse_on_buffs():
		mouse_in_buffs()

func is_mouse_on_buffs():
	return buffs_cont.get_rect().has_point(buffs_cont.get_parent().get_local_mouse_position())

#not used
#func update_buff(i): 
#	if !visible: return
#	var pos = buffs.find(i.template_name)
#	var newbuff = $Buffs.get_child(pos)
#	var text = i.description
#	newbuff.texture = i.icon
#	buffs.push_back(i.template_name)
#	if i.template.has('bonuseffect'):
#		match i.template.bonuseffect:
#			'barrier':
#				newbuff.get_node("Label").show()
#				newbuff.get_node("Label").text = str(fighter.shield)
#	newbuff.hint_tooltip = text
#	var tmp = i.get_duration()
#	if tmp != null:
#		newbuff.get_node("Label").text = str(tmp.count)
#		match tmp.event:
#			'hours':
#				newbuff.get_node("Label").set("custom_colors/font_color",Color(0,0,1))
#			'turns':
#				newbuff.get_node("Label").set("custom_colors/font_color",Color(0,1,0))
#			'hits':
#				newbuff.get_node("Label").set("custom_colors/font_color",Color(1,0,0))
#			'attacks':
#				newbuff.get_node("Label").set("custom_colors/font_color",Color(1,0,0))
#		newbuff.get_node("Label").show()


func update_hp_label(newhp, newhpp):
	if !visible: return
	if fighter.combatgroup == 'ally' || ResourceScripts.game_globals.show_enemy_hp:
		$bars/HP/hplabel.text = str(ceil(newhp)) + '/' + str(ceil(fighter.get_stat('hpmax')))
	else:
		$bars/HP/hplabel.text = str(ceil(newhpp)) + '%%'

func update_mp_label(newmp, newmpp):
	if !visible: return
	if fighter.combatgroup == 'ally' || ResourceScripts.game_globals.show_enemy_hp:
		$bars/MP/mplabel.text = str(floor(newmp)) + '/' + str(floor(fighter.get_stat('mpmax')))
	else:
		$bars/MP/mplabel.text = str(floor(newmpp)) + '%%'

func noq_defeat():
	set_floating(false)
	if !visible:
		return
	if fighter.is_active:
		turn_overlay(true)
#		$Icon.material = load("res://assets/sfx/bw_shader.tres")
	else:
#		fighter = null
		is_active = false
#		queue_free()
#	set_process_input(false)

func resurrect():
	if !visible: return
	turn_overlay(false)
#	$Icon.material = null


func check_active():
	if !is_active:
#		if fighter != null:
		fighter.displaynode = null
		fighter = null
		#rename before deleting, same as in transform_fighter: queue_free is
		#deferred, but the slot must count as empty right away
		name = 'temp'
		queue_free()


func setup_overlay(type):
	match type:
		'normal', 'true':
			$Icon.material = load("res://assets/sfx/bw_shader_alt.tres").duplicate()
			$overlay.texture = load("res://assets/Textures_v2/BATTLE/overlays/death.png")
			#remove particles
			for nd in $overlay.get_children():
				nd.queue_free()
#			ResourceScripts.core_animations.gfx_particles_infinite($overlay, 'heal') #test
		'fire':
			$Icon.material = load("res://assets/sfx/bw_shader_alt.tres").duplicate()
			$overlay.texture = load("res://assets/Textures_v2/BATTLE/overlays/fire.png")
			#remove particles
			for nd in $overlay.get_children():
				nd.queue_free()
			ResourceScripts.core_animations.gfx_particles_infinite($overlay, 'sparks')
		'earth':
			$Icon.material = load("res://assets/sfx/bw_shader_alt.tres").duplicate()
			$overlay.texture = load("res://assets/Textures_v2/BATTLE/overlays/dirt.png")
			#remove particles
			for nd in $overlay.get_children():
				nd.queue_free()
		'air':
			$Icon.material = load("res://assets/sfx/bw_shader_alt.tres").duplicate()
			$overlay.texture = load("res://assets/Textures_v2/BATTLE/overlays/lightning1.png")
			#remove particles
			for nd in $overlay.get_children():
				nd.queue_free()
		'water':
			$Icon.material = load("res://assets/sfx/bw_shader_alt.tres").duplicate()
			$overlay.texture = load("res://assets/Textures_v2/BATTLE/overlays/water.png")
			#remove particles
			for nd in $overlay.get_children():
				nd.queue_free()
		'light':
			$Icon.material = load("res://assets/sfx/bw_shader_alt.tres").duplicate()
			$overlay.texture = load("res://assets/Textures_v2/BATTLE/overlays/light.png")
			#remove particles
			for nd in $overlay.get_children():
				nd.queue_free()
		'dark':
			$Icon.material = load("res://assets/sfx/bw_shader_alt.tres").duplicate()
			$overlay.texture = load("res://assets/Textures_v2/BATTLE/overlays/dark.png")
			#remove particles
			for nd in $overlay.get_children():
				nd.queue_free()
		'ice':
			$Icon.material = load("res://assets/sfx/bw_shader_alt.tres").duplicate()
			$overlay.texture = load("res://assets/Textures_v2/BATTLE/overlays/frost.png")
			#remove particles
			for nd in $overlay.get_children():
				nd.queue_free()
			ResourceScripts.core_animations.gfx_particles_infinite($overlay, 'snow')
		'mind':
			$Icon.material = load("res://assets/sfx/swirl_shader.tres").duplicate()
			$overlay.texture = null
			#remove particles
			for nd in $overlay.get_children():
				nd.queue_free()
		_:
			print("no damage type - %s" % type)
	#the Icon material was just swapped for a fresh one - restore desaturation
	refresh_icon_desat()


func turn_overlay(val):
	$overlay.visible = val
	refresh_icon_desat()


#"In the shadows" status (e_t_hide2, tag hide): the portrait fades out and shifts
#to a cold moonlit tone. Desaturation comes from the same desaturate.shader that
#already sits on Icon, and the tint from the portrait's own modulate - no extra
#nodes needed.
func set_stealth(val):
	if stealth_on == val: return
	stealth_on = val
	$Icon.modulate = STEALTH_TINT if val else Color(1, 1, 1, 1)
	refresh_icon_desat()


#Death is shown through the same percent and takes priority. For the 'mind'
#damage type Icon carries swirl_shader, whose parameter of the same name drives
#both the swirl and the greying out - that is the whole mind kill effect, since
#that branch leaves the overlay without a texture. So death does touch it, and
#only stealth stays desaturate-only.
func refresh_icon_desat():
	if $Icon.material == null or $Icon.material.shader == null: return
	var shader_path = $Icon.material.shader.resource_path
	var is_desat = shader_path.ends_with('desaturate.shader')
	if !is_desat and !shader_path.ends_with('swirl.shader'): return
	if $overlay.visible:
		$Icon.material.set_shader_param('percent', 1.0)
	elif stealth_on and is_desat:
		$Icon.material.set_shader_param('percent', STEALTH_DESAT)
	else:
		$Icon.material.set_shader_param('percent', 0.0)


#The shadow is created lazily and only for whoever's turn it is: other cards
#don't need it.
#func make_float_shadow():
#	if float_shadow != null: return
#	var t = TextureRect.new()
#	t.name = 'FloatShadow'
#	t.texture = load("res://assets/sfx/float_shadow.png")
#	t.expand = true
#	t.stretch_mode = TextureRect.STRETCH_SCALE
#	t.mouse_filter = Control.MOUSE_FILTER_IGNORE
#	#Portraits are almost always opaque, so there is nothing to put behind the
#	#card - we draw the shadow on top and push it below the bottom edge, where
#	#nothing overlaps it.
#	t.rect_position = Vector2(26, 196)
#	t.rect_size = Vector2(130, 26)
#	t.rect_pivot_offset = t.rect_size / 2
#	t.modulate.a = 0.0
#	add_child(t)
#	float_shadow = t
#	float_shadow_y = t.rect_position.y


func set_floating(val):
	if float_on == val: return
	float_on = val
	if val:
#		make_float_shadow()
		float_time = 0.0
	else:
		float_stop()
	set_process(val)


#Clears the shift but not the mode itself: floating resumes once the card is
#free again.
func float_stop():
	if float_shifted:
		rect_position = FLOAT_HOME
		float_shifted = false
#	if float_shadow != null:
#		float_shadow.modulate.a = 0.0
#		float_shadow.rect_position.y = float_shadow_y
#		float_shadow.rect_scale = Vector2(1, 1)


#While the card is playing its own animation, floating yields: the node has a
#single rect_position, and the tween and _process would fight over it.
func float_busy():
	if has_node('tween') and $tween.is_active(): return true
	if animation_node != null and animation_node.animation_delays.has(self): return true
	for i in ResourceScripts.core_animations.ShakingNodes:
		if i.node == self: return true
	return false


func _process(delta):
	if !float_on: return
	if float_busy():
		float_stop()
		return
	float_shifted = true
	float_time += delta
	var k = 0.5 - 0.5 * cos(float_time / FLOAT_PERIOD * TAU)
	var rise = FLOAT_RISE * k
	rect_position = FLOAT_HOME + Vector2(0, -rise)
#	if float_shadow != null:
#		float_shadow.rect_position.y = float_shadow_y + rise
#		float_shadow.rect_scale = Vector2(1.0 - 0.18 * k, 1.0 - 0.18 * k)
#		float_shadow.modulate.a = FLOAT_SHADOW_ALPHA * (1.0 - 0.25 * k)
