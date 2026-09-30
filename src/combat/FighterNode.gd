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

var buffs_cont
var buff_fonts = {}
#the row show_buffs laid out: {size, y, shown}; null without buffs
var buff_row = null

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


func _ready():
	set_process(false)
	connect("gui_input", self, "_on_Button_gui_input")
	if has_node("Buffs"):
		buffs_cont = $Buffs
		buffs_cont.mouse_filter = MOUSE_FILTER_IGNORE
		buffs_cont.add_constant_override("separation", BUFF_GAP)
		buffs_cont.connect("draw", self, "draw_buff_strip")

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

func process_sfx(code, params = {}):
	if fighter == null: return
	#a copy: start_animation writes sprite_name / video_name into params, and params here can be
	#a dictionary straight from the effect data
	var data = {node = self, time = input_handler.combat_node.turns, type = code, slot = 'SFX', params = params.duplicate(true)}
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
	if animation_node != null: animation_node.freeze_card(self, fighter.hp > 0 and fighter.has_status('freeze'))
	show_buffs()
	if animation_node != null: animation_node.status_aura(self)

#Buff row over the bars: icons as large as fit between the two sizes, the rest behind a "+N" chip
const BUFF_SIZE_MAX = 45
const BUFF_SIZE_MIN = 30
const BUFF_ROW_X = 10
const BUFF_ROW_WIDTH = 162
const BUFF_GAP = 2
const BUFF_ROW_LIFT = 4
const BUFF_STRIP_RISE = 9
const BUFF_STRIP_COLOR = Color(0, 0, 0, 0.74)
const BUFF_FONT_DATA = preload("res://assets/Fonts_v2/PT_Sans/PTSans-Bold.ttf")
const BUFF_RING_COLORS = {buff = Color(0.86, 0.72, 0.4), debuff = Color(0.82, 0.29, 0.25), neutral = Color(0.55, 0.53, 0.48)}
const BUFF_NUMBER_COLORS = {turns = Color(1, 1, 1), hits = Color(1, 0.7, 0.34), attacks = Color(1, 0.7, 0.34),
	hours = Color(0.62, 0.83, 1), stacks = Color(0.96, 0.84, 0.49), value = Color(0.62, 0.83, 1)}
const BUFF_CHIP_FILL = Color(0.03, 0.04, 0.07, 0.9)
const BUFF_CHIP_BORDER = Color(0.79, 0.64, 0.36, 0.7)
const BUFF_CHIP_TEXT = Color(0.95, 0.84, 0.56)

func show_buffs():
	input_handler.ClearContainer(buffs_cont)
	var count = buffs.size()
	buff_row = null
	if count > 0:
		var icon_size = int(clamp(floor(float(BUFF_ROW_WIDTH - BUFF_GAP * (count - 1)) / count), BUFF_SIZE_MIN, BUFF_SIZE_MAX))
		var fit = max(1, int(float(BUFF_ROW_WIDTH + BUFF_GAP) / (icon_size + BUFF_GAP)))
		var shown = count if count <= fit else fit - 1
		var font = get_buff_font(int(round(8 + icon_size * 0.15)))
		for k in range(shown):
			add_buff(buffs[k], icon_size, font)
		if shown < count:
			add_buff_chip(buffs.slice(shown, count - 1), icon_size, font)
		var bottom = $bars.margin_bottom - BUFF_ROW_LIFT
		for bar in $bars.get_children():
			if bar.visible:
				bottom -= bar.rect_min_size.y
		buffs_cont.rect_position = Vector2(BUFF_ROW_X, bottom - icon_size)
		buffs_cont.rect_size = Vector2(0, icon_size)
		buff_row = {size = icon_size, y = bottom - icon_size, shown = shown}
	buffs_cont.update()

#where the buff row's dark strip begins, in card coordinates; the portrait's bottom without a row
func buff_floor():
	var bottom = $Icon.rect_position.y + $Icon.rect_size.y
	if buff_row == null: return bottom
	return min(bottom, buff_row.y - BUFF_STRIP_RISE)

#the icon of a status in the row: {rect, texture} in card coordinates; the "+N" chip when it is hidden behind it
func buff_icon(status):
	if buff_row == null: return null
	for k in range(buffs.size()):
		if !buff_has_tag(buffs[k], status): continue
		var slot = min(k, buff_row.shown)
		var rect = Rect2(BUFF_ROW_X + slot * (buff_row.size + BUFF_GAP), buff_row.y, buff_row.size, buff_row.size)
		return {rect = rect, texture = buffs[k].icon if k < buff_row.shown else null}
	return null

func buff_has_tag(b, tag):
	var eff = b.parent
	if eff is eff_stack:
		var first = null
		for id in eff.effects:
			first = id
			break
		eff = first
	for depth in range(4):
		if eff is String:
			eff = effects_pool.effects.get(eff)
		if !(eff is base_effect) or typeof(eff.template) != TYPE_DICTIONARY:
			break
		if eff.template.get('tags', []).has(tag):
			return true
		eff = eff.parent
	return false

func add_buff(i, icon_size, font):
	var newbuff = make_buff_icon(icon_size)
	newbuff.texture = i.icon
	newbuff.hint_tooltip = i.description
	newbuff.connect("draw", self, "draw_buff_icon", [newbuff, BUFF_RING_COLORS[get_buff_side(i)], null])
	var value = null
	var event = 'value'
	if i.template.has('bonuseffect'):
		match i.template.bonuseffect:
			'barrier':
				value = fighter.shield
			'lust':
				value = fighter.get_stat('lust')
			'counterattacks':
				value = fighter.get_stat('counterattacks')
			'fed':
				value = fighter.get_stat('fed')
	if i.tags.has('show_amount'):
		value = "×" + str(i.get_stacks())
		event = 'stacks'
	else:
		var duration = i.get_duration()
		if duration != null:
			value = duration.count
			event = duration.event
	if value != null:
		set_buff_label(newbuff, str(value), BUFF_NUMBER_COLORS.get(event, Color(1, 1, 1)), font, Label.ALIGN_RIGHT, Label.VALIGN_BOTTOM, 2)

func add_buff_chip(hidden, icon_size, font):
	var chip = make_buff_icon(icon_size)
	chip.texture = null
	var lines = []
	for b in hidden:
		lines.push_back(b.description)
	chip.hint_tooltip = PoolStringArray(lines).join("\n")
	chip.connect("draw", self, "draw_buff_icon", [chip, BUFF_CHIP_BORDER, BUFF_CHIP_FILL])
	set_buff_label(chip, "+" + str(hidden.size()), BUFF_CHIP_TEXT, font, Label.ALIGN_CENTER, Label.VALIGN_CENTER, 0)

func make_buff_icon(icon_size):
	var node = input_handler.DuplicateContainerTemplate(buffs_cont)
	node.rect_min_size = Vector2(icon_size, icon_size)
	node.size_flags_vertical = 0
	return node

func set_buff_label(node, text, color, font, align, valign, drop):
	var label = node.get_node("Label")
	label.text = text
	label.add_font_override("font", font)
	label.set("custom_colors/font_color", color)
	label.align = align
	label.valign = valign
	label.rect_position = Vector2()
	label.rect_size = node.rect_min_size + Vector2(0, drop)
	label.show()

func get_buff_font(px):
	if !buff_fonts.has(px):
		var font = DynamicFont.new()
		font.font_data = BUFF_FONT_DATA
		font.size = px
		font.outline_size = 1
		font.outline_color = Color(0, 0, 0)
		font.use_filter = true
		buff_fonts[px] = font
	return buff_fonts[px]

#'buff' / 'debuff' from the tags of the effect behind the icon or of its parents; most effects have neither
func get_buff_side(b):
	var eff = b.parent
	if eff is eff_stack:
		var first = null
		for id in eff.effects:
			first = id
			break
		eff = first
	for depth in range(4):
		if eff is String:
			eff = effects_pool.effects.get(eff)
		if !(eff is base_effect) or typeof(eff.template) != TYPE_DICTIONARY:
			break
		var tags = eff.template.get('tags', [])
		if tags.has('negative') or tags.has('debuff'):
			return 'debuff'
		if tags.has('positive') or tags.has('buff'):
			return 'buff'
		eff = eff.parent
	return 'neutral'

func draw_buff_icon(node, ring, fill):
	var rect = Rect2(Vector2(), node.rect_size)
	if fill != null:
		node.draw_rect(rect, fill)
	node.draw_rect(rect.grow(0.5), Color(0, 0, 0, 0.9), false)
	node.draw_rect(rect.grow(-0.5), ring, false)
	node.draw_rect(rect.grow(-1.5), Color(0, 0, 0, 0.35), false)

func draw_buff_strip():
	if buffs.empty():
		return
	var left = $Icon.rect_position.x - buffs_cont.rect_position.x
	var right = left + $Icon.rect_size.x
	var bottom = $Icon.rect_position.y + $Icon.rect_size.y - buffs_cont.rect_position.y
	var top = -BUFF_STRIP_RISE
	var mid = lerp(top, bottom, 0.72)
	var clear = Color(0, 0, 0, 0)
	buffs_cont.draw_polygon(PoolVector2Array([Vector2(left, top), Vector2(right, top), Vector2(right, mid), Vector2(left, mid)]),
		PoolColorArray([clear, clear, BUFF_STRIP_COLOR, BUFF_STRIP_COLOR]))
	buffs_cont.draw_rect(Rect2(left, mid, right - left, bottom - mid), BUFF_STRIP_COLOR)

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


#Death is shown through the desaturation percent. For the 'mind' damage type Icon
#carries swirl_shader, whose parameter of the same name drives both the swirl and
#the greying out - that is the whole mind kill effect, since that branch leaves the
#overlay without a texture. The "In the shadows" silhouette is StatusAura's.
func refresh_icon_desat():
	if $Icon.material == null or $Icon.material.shader == null: return
	var shader_path = $Icon.material.shader.resource_path
	if !shader_path.ends_with('desaturate.shader') and !shader_path.ends_with('swirl.shader'): return
	$Icon.material.set_shader_param('percent', 1.0 if $overlay.visible else 0.0)


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
