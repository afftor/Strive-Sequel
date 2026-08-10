extends CanvasLayer
#Animation sandbox. Sits on top of a normal combat scene, switched on by the
#checkbox in test_combat. It invents nothing: it calls the same use_skill the
#game calls, so the animation played here is the one that ships. Everything else
#is lifted by variables.anim_sandbox - the turn never passes, enemies never act,
#nobody dies, skills cost nothing and never go on cooldown.

const FONT = "res://assets/Themes_v2/UNIVERSAL/NS_24.tres"

const PANEL_X = 596
const PANEL_Y = 26
const PANEL_W = 700
const PANEL_H = 700

const ICON = 58
const COLUMNS = 10

var combatnode
var font

var root
var body
var fold_button
var folded = false
var was_busy = false
var caster_pick
var target_pick
var filter_edit
var grid
var picked_label
var hint

var all_ids = []
var player_ids = {}
var group = 'player'
var group_buttons = {}
var caster_pos = []
var target_pos = []
var picked_id = null
var picked_button = null


func setup(node):
	combatnode = node
	font = load(FONT)
	#The skill tooltip is a plain Control that get_spec_node raises to the top of
	#the root viewport, so it lives on the default canvas layer. Anything above
	#layer 0 here would draw over it.
	layer = 0
	build()
	collect_skills()
	refresh_fighters()
	refresh_grid()
	#current_turn fires this before it hands control to player_turn, so the
	#revive lands before anything asks whether the caster can still act
	combatnode.connect('turn_started', self, 'revive_all')


func f(node):
	if font != null:
		node.set('custom_fonts/font', font)
	return node


func mk(type, parent, x, y, w, h):
	var n = ClassDB.instance(type)
	n.rect_position = Vector2(x, y)
	n.rect_size = Vector2(w, h)
	parent.add_child(n)
	return f(n)


func build():
	root = Panel.new()
	root.rect_position = Vector2(PANEL_X, PANEL_Y)
	root.rect_size = Vector2(PANEL_W, 56)
	root.self_modulate = Color(0.06, 0.07, 0.1, 0.94)
	add_child(root)

	var title = mk('Label', root, 16, 12, 400, 34)
	title.text = 'Animation sandbox'

	fold_button = mk('Button', root, PANEL_W - 150, 8, 134, 40)
	fold_button.text = 'Collapse'
	fold_button.connect('pressed', self, 'toggle_body')

	body = Panel.new()
	body.rect_position = Vector2(PANEL_X, PANEL_Y + 56)
	body.rect_size = Vector2(PANEL_W, PANEL_H)
	body.self_modulate = Color(0.06, 0.07, 0.1, 0.94)
	add_child(body)

	var l1 = mk('Label', body, 16, 12, 90, 32)
	l1.text = 'Caster'
	caster_pick = mk('OptionButton', body, 100, 8, 240, 40)
	#picking a fighter hands the turn over right away, so the active marker and
	#the floating card follow the choice instead of waiting for Play
	caster_pick.connect('item_selected', self, 'on_caster_selected')

	var l2 = mk('Label', body, 356, 12, 90, 32)
	l2.text = 'Target'
	target_pick = mk('OptionButton', body, 440, 8, 240, 40)

	filter_edit = mk('LineEdit', body, 16, 58, 464, 40)
	filter_edit.placeholder_text = 'filter by code or name'
	filter_edit.connect('text_changed', self, 'on_filter')

	var restore = mk('Button', body, 480, 58, 200, 40)
	restore.text = 'Restore HP/MP'
	restore.connect('pressed', self, 'restore_all')

	group_buttons.clear()
	var gx = 16
	for entry in [['player', 'Player skills'], ['other', 'Enemies and bosses'], ['all', 'All']]:
		var b = mk('Button', body, gx, 106, 214 if entry[0] != 'all' else 100, 40)
		b.text = entry[1]
		b.connect('pressed', self, 'set_group', [entry[0]])
		group_buttons[entry[0]] = b
		gx += b.rect_size.x + 8

	picked_label = mk('Label', body, 16, 152, 664, 32)
	picked_label.text = 'no skill selected'

	var scroll = mk('ScrollContainer', body, 16, 190, 664, 416)
	grid = GridContainer.new()
	grid.columns = COLUMNS
	grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.add_child(grid)

	var play = mk('Button', body, 16, 620, 260, 46)
	play.text = 'Play'
	play.connect('pressed', self, 'play')

	var slow = mk('CheckBox', body, 292, 620, 200, 46)
	slow.text = 'Slow 4x'
	slow.connect('toggled', self, 'on_slow')

	hint = mk('Label', body, 500, 628, 180, 40)
	hint.text = ''


func toggle_body():
	folded = !folded
	fold_button.text = 'Expand' if folded else 'Collapse'
	apply_visibility()


#Out of the way while anything is playing - the panel sits over the middle of
#the battlefield, which is exactly where the fighters move.
func apply_visibility():
	var playing = busy()
	root.visible = !playing
	body.visible = !playing and !folded


func _process(_delta):
	if combatnode == null: return
	var b = busy()
	if b != was_busy:
		was_busy = b
		#the queue just drained: the skill is done, put everyone back on their feet
		if !b:
			revive_all()
			refresh_fighters()
		apply_visibility()


#the action queue is dropped when combat ends, so never assume it is there
func busy():
	if combatnode.ActionQueue == null: return true
	return !combatnode.ActionQueue.is_empty()


func on_slow(val):
	Engine.time_scale = 0.25 if val else 1.0


#--- fighters ---

func fighter_label(pos):
	var ch = combatnode.get_char_by_pos(pos)
	if ch == null: return null
	var side = 'ally' if pos < 7 else 'foe'
	return '%d %s (%s)' % [pos, ch.get_short_name(), side]


func refresh_fighters():
	var keep_c = current_pos(caster_pick, caster_pos)
	var keep_t = current_pos(target_pick, target_pos)
	caster_pick.clear()
	target_pick.clear()
	caster_pos.clear()
	target_pos.clear()
	for pos in range(1, 13):
		var text = fighter_label(pos)
		if text == null: continue
		caster_pick.add_item(text)
		caster_pos.push_back(pos)
		target_pick.add_item(text)
		target_pos.push_back(pos)
	select_pos(caster_pick, caster_pos, keep_c if keep_c != null else active_pos())
	select_pos(target_pick, target_pos, keep_t if keep_t != null else first_foe())
	hook_cards()


#Clicking a card picks with it: an ally becomes the caster and takes the turn,
#an enemy becomes the target. FighterPress is muted in sandbox mode, so a click
#never fires a skill by itself.
func hook_cards():
	for pos in range(1, 13):
		var ch = combatnode.get_char_by_pos(pos)
		if ch == null or ch.displaynode == null: continue
		var node = ch.displaynode
		if !node.is_connected('signal_LMB', self, 'on_card_click'):
			node.connect('signal_LMB', self, 'on_card_click')


func on_card_click(pos):
	if pos < 7:
		select_pos(caster_pick, caster_pos, pos)
		hand_turn()
	else:
		select_pos(target_pick, target_pos, pos)


func on_caster_selected(_index):
	hand_turn()


func hand_turn():
	var pos = current_pos(caster_pick, caster_pos)
	if pos == null or busy(): return
	if combatnode.currentactor == pos: return
	combatnode.currentactor = pos
	combatnode.call_deferred('current_turn', false)


func current_pos(picker, list):
	if picker == null or list.empty(): return null
	if picker.selected < 0 or picker.selected >= list.size(): return null
	return list[picker.selected]


func select_pos(picker, list, pos):
	if pos == null: return
	var idx = list.find(pos)
	if idx >= 0: picker.selected = idx


func active_pos():
	if combatnode.activecharacter == null: return null
	return combatnode.activecharacter.position


func first_foe():
	for pos in target_pos:
		if pos >= 7: return pos
	return null


func restore_all():
	revive_all()


#Fighters are allowed to die so the death animation plays; this puts them back
#once the queue drains. Summons are the exception - checkdeaths frees their card
#outright, and a freed card cannot be brought back.
func revive_all():
	for pos in range(1, 13):
		var ch = combatnode.get_char_by_pos(pos)
		if ch == null: continue
		var was_dead = ch.defeated
		ch.defeated = false
		ch.hp = ch.get_stat('hpmax')
		ch.mp = ch.get_stat('mpmax')
		var node = ch.displaynode
		if node == null: continue
		if was_dead:
			node.resurrect()
		#exactly what make_fighter_panel does when it builds the card
		node.get_node('bars/HP').value = 100
		node.get_node('bars/MP').value = 100
		node.hp = ch.hp
		node.update_hp_label(ch.hp, 100.0)
		node.update_mp_label(ch.mp, 100.0)


#--- skills ---

func collect_skills():
	all_ids.clear()
	for id in Skilldata.Skilllist:
		var data = Skilldata.Skilllist[id]
		if !data.has('type') or data.type != 'combat': continue
		all_ids.push_back(id)
	all_ids.sort()
	collect_player_skills()


#Everything a player character can end up knowing: mastery tiers, skill books,
#class and race grants, plus the two basic attacks ch_skills hands out for free.
#Anything left over belongs to enemies and bosses.
func collect_player_skills():
	player_ids.clear()
	for code in ['attack', 'ranged_attack']:
		player_ids[code] = true

	for mastery in Skilldata.masteries:
		var data = Skilldata.masteries[mastery]
		for lv in range(1, 10):
			var key = 'level' + str(lv)
			if !data.has(key): continue
			mark_all(data[key], 'combat_skills')

	for item in Items.itemlist:
		var data = Items.itemlist[item]
		if data.has('tier') and data.tier == 'skillbook' and data.has('skill'):
			player_ids[data.skill] = true

	for prof in classesdata.professions:
		mark_all(classesdata.professions[prof], 'combatskills')

	for race in races.racelist:
		mark_all(races.racelist[race], 'combat_skills')


func mark_all(source, key):
	if !source.has(key) or !(source[key] is Array): return
	for code in source[key]:
		player_ids[code] = true


func skill_name(id):
	var data = Skilldata.Skilllist[id]
	if data.has('name') and data.name != null: return tr(str(data.name))
	return id


func on_filter(_text):
	refresh_grid()


func set_group(value):
	group = value
	refresh_grid()


func in_group(id):
	if group == 'all': return true
	if group == 'player': return player_ids.has(id)
	return !player_ids.has(id)


func refresh_grid():
	for key in group_buttons:
		group_buttons[key].self_modulate = Color(1, 1, 1, 1) if key == group else Color(1, 1, 1, 0.5)
	var mask = filter_edit.text.to_lower()
	for old in grid.get_children():
		old.queue_free()
	picked_button = null
	for id in all_ids:
		if !in_group(id): continue
		if mask != '' and id.to_lower().find(mask) < 0 and skill_name(id).to_lower().find(mask) < 0:
			continue
		grid.add_child(make_cell(id))


func make_cell(id):
	var data = Skilldata.Skilllist[id]
	var tex = null
	#icons come in both shapes: Skills.gd swaps the res:// path for a loaded
	#Texture on startup, but not every entry goes through that
	if data.has('icon') and data.icon != null:
		if data.icon is String:
			if data.icon != '':
				tex = load(data.icon)
		elif data.icon is Texture:
			tex = data.icon
	var cell
	if tex != null:
		cell = TextureButton.new()
		cell.texture_normal = tex
		cell.expand = true
		cell.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	else:
		#a handful of skills carry no icon - show the code instead of a blank hole
		cell = f(Button.new())
		cell.text = id.substr(0, 3)
	cell.rect_min_size = Vector2(ICON, ICON)
	cell.self_modulate = Color(1, 1, 1, 0.55)
	cell.connect('pressed', self, 'pick', [id, cell])
	cell.connect('gui_input', self, 'on_cell_input', [id, cell])
	#the game's own skill tooltip, same one the combat skill panel uses. Resolved
	#on hover rather than bound here, so it follows the currently picked caster.
	cell.connect('mouse_entered', self, 'on_cell_hover', [id, cell])
	if id == picked_id:
		mark_picked(cell)
	return cell


func on_cell_hover(id, cell):
	var ch = caster_char()
	if ch == null: return
	globals.showskilltooltip(id, cell, ch)


#whoever is picked as the caster, falling back to whoever holds the turn
func caster_char():
	var pos = current_pos(caster_pick, caster_pos)
	if pos != null:
		var ch = combatnode.get_char_by_pos(pos)
		if ch != null: return ch
	return combatnode.activecharacter


func on_cell_input(event, id, cell):
	if event is InputEventMouseButton and event.pressed and event.doubleclick:
		pick(id, cell)
		play()


func pick(id, cell):
	picked_id = id
	mark_picked(cell)
	picked_label.text = '%s  -  %s' % [id, skill_name(id)]


func mark_picked(cell):
	if picked_button != null and is_instance_valid(picked_button):
		picked_button.self_modulate = Color(1, 1, 1, 0.55)
	picked_button = cell
	cell.self_modulate = Color(1, 1, 1, 1)


func play():
	if picked_id == null:
		hint.text = 'pick a skill'
		return
	if busy():
		hint.text = 'busy'
		return
	var cpos = current_pos(caster_pick, caster_pos)
	if cpos == null:
		hint.text = 'no caster'
		return
	var caster = combatnode.get_char_by_pos(cpos)
	if caster == null:
		hint.text = 'no caster'
		return
	#Hand the turn over by hand instead of going through select_actor: the turn
	#order is frozen in sandbox mode, and end_action_handler returns the turn to
	#whoever currentactor points at once the skill is done.
	combatnode.currentactor = cpos
	combatnode.activecharacter = caster

	var target = null
	var tpos = current_pos(target_pick, target_pos)
	if tpos != null:
		target = combatnode.get_char_by_pos(tpos)
	if target == null:
		target = caster

	var template = Skilldata.get_template_combat(picked_id, caster)
	#same preparation the game runs before it fires a skill on its own
	combatnode.UpdateSkillTargets(caster, template, true)
	hint.text = ''
	combatnode.use_skill(picked_id, caster, target)
