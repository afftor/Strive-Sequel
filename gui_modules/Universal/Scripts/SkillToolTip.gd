extends tooltip_main

var skill
var character
var no_advanced = false
#'combat' / 'mansion' when the tooltip belongs to a usable skill button: then costs and cooldowns are checked live
var live_kind = ''
onready var main_node = $Main
onready var sec_node = $Side
onready var sec_cont = $Side/V/cont
onready var cells = $Main/V/Band/Cells
enum {MODE_ADVANCED, MODE_DEFAULT}
var mode = MODE_DEFAULT
var tips = {
	ability_type = {
		title = "TOOLTIP_TYPE",
		item = "TOOLTIP_TYPE_ITEM",
		skill = "TOOLTIP_TYPE_SKILL",
		spell = "TOOLTIP_TYPE_SPELL"
	},
	target = {
		title = "TOOLTIP_TARGET",
		all = "TOOLTIP_TARGET_ALL",
		ally = "TOOLTIP_TARGET_ALLY",
		enemy = "TOOLTIP_TARGET_ENEMY",
		self = "TOOLTIP_TARGET_SELF"
	},
	target_number = {
		title = "TOOLTIP_NUMBER",
		all = "TOOLTIP_NUMBER_ALL",
		all_allowed = "TOOLTIP_NUMBER_ALLOWED",
		line = "TOOLTIP_NUMBER_LINE",
		nontarget = "TOOLTIP_NUMBER_NON",
		nontarget_group = "TOOLTIP_NUMBER_NONGROUP",
		row = "TOOLTIP_NUMBER_ROW",
		single = "TOOLTIP_NUMBER_SINGLE",
		single_nontarget = "TOOLTIP_NUMBER_SINGLENON",
		x_random = "TOOLTIP_NUMBER_RANDOM"
	},
	target_range = {
		title = "TOOLTIP_RANGE",
		weapon = "TOOLTIP_RANGE_WEAPON",
		any = "TOOLTIP_RANGE_ANY",
		melee = "TOOLTIP_RANGE_MELEE",
		not_caster = "TOOLTIP_RANGE_NOT_CASTER",
		dead = "TOOLTIP_RANGE_DEAD"
	},
	gear_equiped = {
		spear = "TOOLTIP_GEAR_SPEAR",
		bow = "TOOLTIP_GEAR_BOW",
		heavy = "TOOLTIP_GEAR_HEAVY",
		medium = "TOOLTIP_GEAR_MEDIUM",
	}
}

const COST_ICONS = {
	mp = "res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_mana.png",
	hp = "res://assets/images/iconsstats/hp.png",
	lust = "res://assets/images/sexicons/lust3.png",
	money = "res://assets/images/iconsitems/gold.png",
}
const COST_ICON_OTHER = "res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_usagecost.png"
const COOLDOWN_ICON = "res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_cooldown.png"
const DIAG_SHAPES = ['single', 'row', 'line', 'all', 'all_allowed', 'x_random']

var cost_colors = {
	mp = Color(0.486, 0.753, 1),
	lust = Color(1, 0.561, 0.804),
	hp = Color(1, 0.541, 0.502),
}
var color_item = Color(0.925, 0.843, 0.659)
var color_cd = Color(0.945, 0.784, 0.451)
var color_label = Color(0.639, 0.565, 0.604)
var color_short = Color(1, 0.482, 0.42)
var color_short_label = Color(1, 0.706, 0.667)
var color_wait = Color(1, 0.702, 0.361)
var color_wait_label = Color(1, 0.847, 0.659)
var bg_short = Color(0.29, 0.086, 0.106)
var bg_wait = Color(0.278, 0.188, 0.102)
var state_colors = {
	ok = [Color(0.773, 0.925, 0.667), Color(0.141, 0.212, 0.114)],
	bad = [Color(1, 0.816, 0.788), Color(0.29, 0.086, 0.106)],
	wait = [Color(1, 0.878, 0.722), Color(0.278, 0.188, 0.102)],
}
var diag_styles = {}


func _ready():
	var edge = Color(0.549, 0.416, 0.322)
	var dim_edge = Color(0.239, 0.165, 0.2)
	diag_styles.reach = _diag_box(Color(0.173, 0.102, 0.141), edge)
	diag_styles.block = _diag_box(Color(0.09, 0.047, 0.071), dim_edge)
	diag_styles.idle = _diag_box(Color(0.165, 0.102, 0.137), dim_edge)
	diag_styles.main_foe = _diag_box(Color(0.953, 0.827, 0.42))
	diag_styles.hit_foe = _diag_box(Color(0.788, 0.518, 0.227))
	diag_styles.main_ally = _diag_box(Color(0.525, 0.875, 0.69))
	diag_styles.hit_ally = _diag_box(Color(0.294, 0.624, 0.471))


func _diag_box(bg, border = null):
	var sb = StyleBoxFlat.new()
	sb.bg_color = bg
	if border != null:
		sb.border_color = border
		sb.set_border_width_all(1)
	sb.set_corner_radius_all(2)
	return sb


func showup(node, skillcode, ch):
	if _setup(node):
		character = ch
		skill = Skilldata.get_template(skillcode, ch)
		no_advanced = skill.has("type") and skill.type == 'social'


func _input(event):
	if state != STATE_OPEN or no_advanced:
		return
	if event.is_action_pressed("shift"):
		mode = MODE_ADVANCED
		update()
	elif event.is_action_released("shift"):
		mode = MODE_DEFAULT
		update()


func get_live_kind():
	if parentnode == null or parentnode.has_meta('display_only'):
		return ''
	var combat = input_handler.combat_node
	if combat != null and is_instance_valid(combat) and combat.is_a_parent_of(parentnode):
		return 'combat'
	var mansion = gui_controller.mansion
	if skill.get('type', '') == 'social' and mansion != null and is_instance_valid(mansion):
		#the old skill panel and the social bar on the expanded slave card
		var bars = [mansion.get('SkillModule')]
		var slave_list = mansion.get('SlaveListModule')
		if slave_list != null:
			bars.append(slave_list.get('ExpandedSocialSkills'))
		for bar in bars:
			if bar != null and is_instance_valid(bar) and bar.is_a_parent_of(parentnode):
				return 'mansion'
	return ''


func update():
	live_kind = get_live_kind()
	var head = main_node.get_node("V/Header/H")
	head.get_node("IconBox/Icon").texture = skill.icon
	head.get_node("T/Name").text = skill.name
	fill_type_line(head.get_node("T/Type"))

	var costs = get_costs()
	var cooldown = get_cooldown()
	fill_band(costs, cooldown)
	fill_meta(costs, cooldown)

	var text = skill.descript
	if skill.has('reqs_text'):
		text = text.trim_suffix('\n\n' + skill.reqs_text)
	main_node.get_node('V/Desc/Text').bbcode_text = globals.TextEncoder(text)
	var reqs = main_node.get_node('V/Reqs')
	#some req codes have no text (can_add_thrall), the state line still says they are unmet
	reqs.visible = skill.has('reqs_text') and skill.reqs_text.strip_edges() != ''
	if reqs.visible:
		reqs.get_node('Text').bbcode_text = globals.TextEncoder(skill.reqs_text)

	var advanced = mode == MODE_ADVANCED and !no_advanced
	main_node.get_node('V/Details').visible = advanced
	if advanced:
		fill_details()

	var foot = main_node.get_node('V/Foot/H')
	foot.get_node('Shift').text = tr("INFOHOLDSHIFT")
	foot.get_node('Shift').visible = !no_advanced and !advanced
	foot.get_node('Rmb').text = tr("TOOLTIPRIGHTCLICKABILITY")
	foot.get_node('Rmb').visible = !parentnode.has_meta('display_only')
	main_node.get_node('V/Foot').visible = foot.get_node('Shift').visible or foot.get_node('Rmb').visible

	fill_side()

	#containers keep their old height until told to shrink; rich text measures itself a frame later
	for i in range(2):
		main_node.rect_size = Vector2(main_node.rect_min_size.x, 0)
		sec_node.rect_size = Vector2(sec_node.rect_min_size.x, 0)
		yield(get_tree(), 'idle_frame')
		if !weakref(parentnode).get_ref():
			emit_signal("update_completed")
			return
	main_node.rect_size = Vector2(main_node.rect_min_size.x, 0)
	sec_node.rect_size = Vector2(sec_node.rect_min_size.x, 0)

	place()
	emit_signal("update_completed")


func place():
	var pos = parentnode.get_global_rect()
	set_global_position(Vector2(pos.position.x, pos.end.y + 10))

	var screen = get_viewport().get_visible_rect()
	if main_node.get_global_rect().end.x >= screen.size.x:
		rect_global_position.x = screen.size.x - main_node.rect_size.x
	if main_node.get_global_rect().end.y >= screen.size.y:#move to top
		rect_global_position.y = parentnode.rect_global_position.y - (main_node.rect_size.y + 10)

	var force_sec_node_left = false
	if rect_global_position.y < 0:#move to side
		var do_move = false
		var sec_node_size_x = 0
		if sec_node.visible:
			sec_node_size_x = sec_node.rect_size.x
		var estimated_pos_x = parentnode.get_global_rect().end.x + 10#right
		if estimated_pos_x + main_node.rect_size.x + sec_node_size_x < screen.size.x:
			do_move = true
		else:
			estimated_pos_x = parentnode.rect_global_position.x - main_node.rect_size.x - 10#left
			if estimated_pos_x - sec_node_size_x > 0:
				do_move = true
				force_sec_node_left = true
		if do_move:
			rect_global_position.x = estimated_pos_x
			rect_global_position.y = parentnode.rect_global_position.y

	if sec_node.visible:
		sec_node.rect_position = Vector2(main_node.rect_size.x, 0)
		if force_sec_node_left or sec_node.get_global_rect().end.x >= screen.size.x:
			sec_node.rect_position.x = -sec_node.rect_size.x
		if sec_node.get_global_rect().end.y >= screen.size.y:
			rect_global_position.y = screen.size.y - sec_node.rect_size.y


func get_tip(field):
	var value = skill.get(field)
	if tips[field].has(value):
		return tr(tips[field][value])
	return str(value)


func get_damage_type():
	if skill.has('damage_type'):
		return skill.damage_type
	if skill.get('value') is Array and !skill.value.empty() and skill.value[0] is Dictionary:
		return skill.value[0].get('source', '')
	return ''


func fill_type_line(row):
	var kind = row.get_node('Kind')
	if skill.get('type', '') == 'social':
		kind.text = tr("CAT_SOCIAL")
	elif tips.ability_type.has(skill.get('ability_type')):
		#the type keys carry an explanation on a second line
		kind.text = tr(tips.ability_type[skill.ability_type]).split("\n")[0]
	else:
		kind.text = ''
	var element = get_damage_type()
	var show_element = skill.get('tags', []).has('damage') and element in variables.resists_list
	row.get_node('Dot').visible = show_element and kind.text != ''
	row.get_node('DmgIcon').visible = show_element
	row.get_node('DmgName').visible = show_element
	if show_element:
		row.get_node('DmgIcon').texture = load("res://assets/images/iconsstats/%s.png" % element)
		row.get_node('DmgName').text = tr("STATDAMAGE_MOD_" + element.to_upper())


func get_stat_name(st):
	if statdata.statdata.has(st) and statdata.statdata[st].has('name') and statdata.statdata[st].name != '':
		return tr(statdata.statdata[st].name)
	return tr("STAT" + st.to_upper())


func get_owned(st):
	match st:
		'money':
			return ResourceScripts.game_res.money
		'mp':
			return character.mp
		'hp':
			return character.hp
	return character.get_stat(st)


func get_costs():
	var res = []
	var cost = skill.get('cost', {})
	for st in cost:
		var amount = int(cost[st])
		if amount <= 0:
			continue
		var owned = get_owned(st)
		res.append({kind = st, amount = amount, owned = owned, short = live_kind != '' and owned < amount,
			label = get_stat_name(st), icon = COST_ICONS.get(st, COST_ICON_OTHER)})
	if skill.has('catalysts') and !character.has_status('ignore_catalysts_for_%s' % skill.code):
		for mat in skill.catalysts:
			var data = Items.materiallist[mat]
			var owned = ResourceScripts.game_res.materials.get(mat, 0)
			res.append({kind = 'item', amount = int(skill.catalysts[mat]), owned = owned,
				short = live_kind != '' and owned < skill.catalysts[mat], label = data.name, icon = data.icon})
	return res


#{kind = 'turns', total, left} or {kind = 'charges', total, left, period, in_turns, wait} or null
func get_cooldown():
	var code = skill.code
	var charges = skill.get('charges', 0)
	if (charges is int or charges is float) and charges > 0:
		var in_turns = skill.has('turn_cooldown')
		#every use writes the timer and a tick clears it at <= 0, so a timer of 0 still waits one tick
		var period = int(max(1, skill.turn_cooldown if in_turns else skill.get('cooldown', 0)))
		var used = 0
		var wait = 0
		if live_kind != '':
			var sk = character.skills
			var timers
			if skill.get('type', '') == 'social':
				used = sk.social_skills_charges.get(code, 0)
				timers = sk.social_turn_cooldowns if in_turns else sk.social_cooldowns
			else:
				used = sk.combat_skill_charges.get(code, 0)
				timers = sk.daily_cooldowns
			if timers.has(code):
				wait = max(1, timers[code])
		return {kind = 'charges', total = int(charges), left = int(max(0, charges - used)), period = int(period),
			in_turns = in_turns, wait = int(wait)}
	var turns = int(skill.get('combatcooldown', 0))
	if turns > 0:
		var left = 0
		if live_kind == 'combat':
			left = int(character.skills.combat_cooldowns.get(code, 0))
		return {kind = 'turns', total = turns, left = left}
	return null


func unit_word(amount, in_turns):
	if in_turns:
		return tr("SKILLTIP_TURN") if amount == 1 else tr("SKILLTIP_TURNS")
	return tr("SKILLTIP_DAY") if amount == 1 else tr("SKILLTIP_DAYS")


func fill_band(costs, cooldown):
	input_handler.ClearContainer(cells, ['cell'])
	var made = []
	for c in costs:
		var cell = input_handler.DuplicateContainerTemplate(cells, 'cell')
		var label = c.label
		if c.kind == 'item':
			if live_kind != '':
				label += ", %d %s" % [c.owned, tr("SKILLTIP_OWNED")]
		elif c.short:
			label += ", %s %d" % [tr("SKILLTIP_HAVE"), c.owned]
		var number = ("×%d" if c.kind == 'item' else "%d") % c.amount
		var color = color_item if c.kind == 'item' else cost_colors.get(c.kind, color_item)
		paint_cell(cell, c.icon, number, label, color, 'short' if c.short else '')
		#material names are long, give that cell more room
		if c.kind == 'item':
			cell.size_flags_stretch_ratio = 1.6
		made.append(cell)
	if cooldown != null:
		var cell = input_handler.DuplicateContainerTemplate(cells, 'cell')
		if cooldown.kind == 'turns':
			if cooldown.left > 0:
				var label = "%s %s" % [unit_word(cooldown.left, true), tr("SKILLTIP_LEFT")]
				paint_cell(cell, COOLDOWN_ICON, str(cooldown.left), label, color_cd, 'wait')
				cell.get_node('V/Bar').visible = true
				cell.get_node('V/Bar/Fill').anchor_right = float(cooldown.left) / cooldown.total
			else:
				var label = "%s %s" % [unit_word(cooldown.total, true), tr("SKILLTIP_COOLDOWN")]
				paint_cell(cell, COOLDOWN_ICON, str(cooldown.total), label, color_cd, '')
		else:
			var number = "%d/%d" % [cooldown.left, cooldown.total]
			if cooldown.left <= 0 and cooldown.wait > 0:
				var label = "%s %d %s" % [tr("SKILLTIP_BACK_IN"), cooldown.wait, unit_word(cooldown.wait, cooldown.in_turns)]
				paint_cell(cell, COOLDOWN_ICON, number, label, color_cd, 'wait')
			else:
				var label = tr("SKILLTIP_CHARGES")
				if cooldown.period > 0:
					label += ", %d %s" % [cooldown.period, unit_word(cooldown.period, cooldown.in_turns)]
				paint_cell(cell, COOLDOWN_ICON, number, label, color_cd, 'short' if cooldown.left <= 0 else '')
		made.append(cell)
	if !made.empty():
		made[0].get_stylebox('panel').border_width_left = 0
	main_node.get_node('V/Band').visible = !made.empty()


func paint_cell(cell, icon, number, label, color, tint):
	var row = cell.get_node('V/Row')
	row.get_node('Icon').texture = input_handler.loadimage(icon, 'icons')
	var n = row.get_node('Txt/N')
	var l = row.get_node('Txt/L')
	n.text = number
	l.text = label
	var style = cell.get_stylebox('panel').duplicate()
	match tint:
		'short':
			n.set('custom_colors/font_color', color_short)
			l.set('custom_colors/font_color', color_short_label)
			style.bg_color = bg_short
		'wait':
			n.set('custom_colors/font_color', color_wait)
			l.set('custom_colors/font_color', color_wait_label)
			style.bg_color = bg_wait
		_:
			n.set('custom_colors/font_color', color)
			l.set('custom_colors/font_color', color_label)
			style.bg_color = Color(0, 0, 0, 0)
	cell.add_stylebox_override('panel', style)
	cell.get_node('V/Bar').visible = false


func fill_meta(costs, cooldown):
	var meta = main_node.get_node('V/Meta')
	var row = meta.get_node('H')
	var target = row.get_node('Target')
	var social = skill.get('type', '') == 'social'
	target.visible = !social and skill.has('target_number')
	if target.visible:
		var parts = []
		if skill.get('target') == 'self':
			parts.append(tr("TOOLTIP_TARGET_SELF"))
		else:
			parts.append(get_tip('target_number'))
			if skill.has('target'):
				parts.append(get_tip('target'))
			if skill.get('target_range', 'any') != 'any':
				parts.append(get_tip('target_range'))
		target.text = PoolStringArray(parts).join(" · ")
	paint_diag(row.get_node('Diag'), target.visible)

	var state_label = row.get_node('State')
	var state_data = get_state(costs, cooldown)
	state_label.visible = state_data != null
	if state_data != null:
		state_label.text = state_data[0]
		var style = state_label.get_stylebox('normal').duplicate()
		style.bg_color = state_colors[state_data[1]][1]
		state_label.add_stylebox_override('normal', style)
		state_label.set('custom_colors/font_color', state_colors[state_data[1]][0])
	meta.visible = target.visible or state_label.visible


#[text, 'ok' / 'bad' / 'wait'] or null when nothing is to be said
func get_state(costs, cooldown):
	if skill.has('reqs_text'):
		return [tr("SKILLTIP_REQS_UNMET"), 'bad']
	if live_kind == '':
		return null
	for c in costs:
		if c.short:
			if c.kind == 'item':
				return [tr("SKILLTIP_NO_MATERIALS"), 'bad']
			return [tr("SKILLTIP_NOT_ENOUGH") + " " + c.label, 'bad']
	if cooldown != null:
		if cooldown.kind == 'turns' and cooldown.left > 0:
			return ["%s %d %s" % [tr("SKILLTIP_READY_IN"), cooldown.left, unit_word(cooldown.left, true)], 'wait']
		if cooldown.kind == 'charges' and cooldown.left <= 0:
			if cooldown.wait > 0:
				return ["%s %d %s" % [tr("SKILLTIP_READY_IN"), cooldown.wait, unit_word(cooldown.wait, cooldown.in_turns)], 'wait']
			return [tr("SKILLTIP_NO_CHARGES"), 'bad']
	if is_blocked():
		return [tr("SKILLTIP_BLOCKED"), 'bad']
	return [tr("SKILLTIP_READY"), 'ok']


#the same status checks that grey out the skill buttons
func is_blocked():
	if live_kind == 'mansion':
		return character.has_status('no_social_skills') or character.get_work() == 'disabled'
	var immune = skill.get('tags', []).has('disable_immunity')
	var ability = skill.get('ability_type', '')
	if character.has_status('silence') and ability == 'spell' and !immune:
		return true
	if character.has_status('disarm') and ability == 'skill' and !immune:
		return true
	if character.has_status('no_combat_skills') and ability == 'skill':
		return true
	if character.has_status('no_combat_spells') and ability == 'spell':
		return true
	if character.is_support_self_only(skill) and !character.can_support_self(skill):
		return true
	if character.has_status('no_combat_attack') and skill.get('tags', []).has('damage'):
		return true
	return false


#a 2x3 picture of the targeted side as it stands on the battlefield:
#enemies keep their front column on the left, allies on the right
func paint_diag(diag, wanted):
	var shape = skill.get('target_number', '')
	diag.visible = wanted and shape in DIAG_SHAPES
	if !diag.visible:
		return
	var side = skill.get('target', 'enemy')
	var reach = skill.get('target_range', 'any')
	if reach == 'weapon':
		reach = character.equipment.get_weapon_range() if character.get('equipment') != null else 'melee'
	var ally = side in ['ally', 'self']
	var front = 1 if ally else 0
	var back = 1 - front
	var cell_state = {}
	for r in range(3):
		for c in range(2):
			cell_state["%d,%d" % [c, r]] = 'reach'
	if reach == 'melee' and !ally:
		for r in range(3):
			cell_state["%d,%d" % [back, r]] = 'block'
	var main = 'main_ally' if ally else 'main_foe'
	var hit = 'hit_ally' if ally else 'hit_foe'
	if side == 'self':
		for key in cell_state:
			cell_state[key] = 'idle'
		cell_state["%d,1" % back] = main
	elif shape in ['all', 'all_allowed']:
		for key in cell_state:
			cell_state[key] = hit
	elif shape != 'x_random':
		cell_state["%d,1" % front] = main
		if shape == 'row':
			cell_state["%d,1" % back] = hit
		elif shape == 'line':
			cell_state["%d,0" % front] = hit
			cell_state["%d,2" % front] = hit
	for i in range(6):
		var key = "%d,%d" % [i % 2, i / 2]
		diag.get_node("c%d" % i).add_stylebox_override('panel', diag_styles[cell_state[key]])


func fill_details():
	var grid = main_node.get_node('V/Details/Grid')
	var rows = {Type = 'ability_type', Num = 'target_number', Target = 'target', Range = 'target_range'}
	for key in rows:
		var field = rows[key]
		var shown = skill.has(field) and skill[field] != null
		grid.get_node(key + 'K').visible = shown
		grid.get_node(key + 'V').visible = shown
		if shown:
			grid.get_node(key + 'K').text = tr(tips[field].title)
			grid.get_node(key + 'V').text = get_tip(field)
	var props = []
	if skill.get('tags', []).has('instant'):
		props.append(tr("SKILLTIP_PROP_INSTANT"))
	if skill.get('tags', []).has('stealth_casting'):
		props.append(tr("SKILLTIP_PROP_STEALTH"))
	grid.get_node('PropK').visible = !props.empty()
	grid.get_node('PropV').visible = !props.empty()
	grid.get_node('PropK').text = tr("SKILLTIP_PROPERTIES")
	grid.get_node('PropV').text = PoolStringArray(props).join("\n")


#duration and chance of each status the skill applies, read off its rebuild_template effects
func get_status_args():
	var res = {}
	for eff in skill.get('effects', []):
		if !(eff is Dictionary) or !eff.has('sub_effects'):
			continue
		var data = {}
		var args = eff.get('args', {})
		if args.get('duration') is Dictionary and args.duration.has('dur'):
			data.duration = args.duration.dur
		if args.get('chance') is Dictionary and args.chance.has('chance'):
			data.chance = args.chance.chance
		for cond in eff.get('conditions', []):
			if cond is Dictionary and cond.get('type') == 'checkres':
				data.chance = cond.value
		for sub in eff.sub_effects:
			var status = sub.get('status') if sub is Dictionary else sub
			if !(status is String):
				continue
			var id = Effectdata.get_status_desc_id(status)
			if id == null or res.has(id):
				continue
			#the skill's duration reaches the status only when its template asks for one ('arg')
			var entry = data.duplicate()
			var eff_id = Effectdata.get_effect_for_status(status)
			if Effectdata.effect_table.has(eff_id) and Effectdata.effect_table[eff_id].has('duration'):
				var own = Effectdata.effect_table[eff_id].duration
				if own is int or own is float:
					entry.duration = own
				elif !(own is String):
					entry.erase('duration')
			res[id] = entry
	return res


func fill_side():
	input_handler.ClearContainer(sec_cont, ['entry'])
	if !skill.has('eff_descript') or skill.eff_descript.empty():
		sec_node.hide()
		return
	sec_node.get_node('V/Title').text = tr("SKILLTIP_APPLIES")
	var ids = Skilldata.Skilllist[skill.code].get('eff_descript', []) if Skilldata.Skilllist.has(skill.code) else []
	var status_args = get_status_args()
	for i in range(skill.eff_descript.size()):
		var desc = skill.eff_descript[i]
		var entry = input_handler.DuplicateContainerTemplate(sec_cont, 'entry')
		entry.get_node('IconBox/icon').texture = desc.icon
		#status texts read "Name: effect" - the name goes into the header line
		var text = desc.text
		var title = ''
		var split = text.find(": ")
		if split > 0 and split < 40 and text.substr(0, split).find("{") < 0 and text.substr(0, split).find("[") < 0:
			title = text.substr(0, split)
			text = text.substr(split + 2)
		var data = {}
		if i < ids.size() and status_args.has(ids[i]):
			data = status_args[ids[i]]
		var head = entry.get_node('T/Head')
		head.get_node('Name').text = title
		head.get_node('Name').visible = title != ''
		var duration = data.get('duration')
		var has_duration = (duration is int or duration is float) and duration > 0
		head.get_node('Dur').visible = has_duration
		if has_duration:
			head.get_node('Dur').text = "%d %s" % [duration, unit_word(int(duration), true)]
		var chance = data.get('chance')
		var has_chance = (chance is int or chance is float) and chance < 1
		head.get_node('Chance').visible = has_chance
		if has_chance:
			head.get_node('Chance').text = "%d%%" % int(round(chance * 100))
		head.visible = title != '' or has_duration or has_chance
		entry.get_node('T/descript').bbcode_text = globals.TextEncoder(text)
	sec_node.show()
