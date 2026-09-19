extends Control
#The slave market's factor purchase: one panel for the whole purchase, the new stars lighting in turn.

const EXPANDED = preload("res://gui_modules/Mansion/Scripts/MansionSlaveExpandedDetails.gd")

const STARS = 6
const GLOW_MARGIN = 27
const TOP = 151
const AREA_MARGIN = 16

const UNFOLD = 0.2
const CONTENT_IN = 0.25
const LINE_AT = 0.35
const LINE_STEP = 0.12
const FIRST_POP = 0.85
const POPS_SPAN = 1.8
const POP_GAP_MAX = 0.25
const POP_GAP_MIN = 0.1
const WORD_AFTER = 0.15
const GLOW_OUT_AFTER = 0.4
const HOLD = 1.5
const SHORTEST = 3.0
const FOLD = 0.45
const SKIP_FADE = 0.3

var character = null
var raised = []
var beats = {}
var found = {}
var state = ''
var tween = null


#{lines = [{code, appear, pops, first_pop, word}], last_pop, end} for steps = [{code, from, to}]
static func schedule(steps):
	var total = 0
	for step in steps:
		total += int(max(0, int(step.to) - int(step.from)))
	var gap = clamp(POPS_SPAN / max(total, 1), POP_GAP_MIN, POP_GAP_MAX)
	var res = {lines = [], last_pop = FIRST_POP}
	var at = FIRST_POP
	for i in range(steps.size()):
		var step = steps[i]
		var pops = []
		for _level in range(int(step.from) + 1, int(step.to) + 1):
			pops.append(at)
			res.last_pop = at
			at += gap
		var first = pops[0] if !pops.empty() else at
		var last = pops[pops.size() - 1] if !pops.empty() else at
		res.lines.append({code = step.code, appear = LINE_AT + i * LINE_STEP, pops = pops,
			first_pop = first, word = last + WORD_AFTER})
	res.end = max(res.last_pop + HOLD, SHORTEST)
	return res


func _node(node_name):
	if !found.has(node_name) or !is_instance_valid(found[node_name]):
		found[node_name] = find_node(node_name, true, false)
	return found[node_name]


func play_upgrade(who, steps, area = null):
	character = who
	raised = steps
	raise()
	var panel = _node("Panel")
	if raised.empty() or !(panel is Control):
		call_deferred("finish")
		return
	beats = schedule(raised)
	fill()
	place(area)
	start()


func fill():
	var portrait = _node("Portrait")
	if portrait is TextureRect and character != null:
		portrait.texture = character.get_icon()
	var name_label = _node("Name")
	if name_label is Label and character != null:
		name_label.text = character.get_short_name()
	var lines = _node("Lines")
	if !(lines is Container) or !lines.has_node("Line"):
		return
	input_handler.ClearContainer(lines, ['Line'])
	for step in raised:
		var line = input_handler.DuplicateContainerTemplate(lines, 'Line')
		line.set_meta("factor", step.code)
		line.modulate = Color(1, 1, 1, 0)
		var icon = line.find_node("Icon", true, false)
		if icon is TextureRect:
			icon.texture = EXPANDED.OVERVIEW_ICONS.get(step.code)
		var word = line.find_node("Word", true, false)
		if word is Label:
			word.text = level_word(int(step.to))
			word.set("custom_colors/font_color", Color(variables.hexcolordict["factor" + str(int(clamp(int(step.to), 1, 6)))]))
			word.modulate = Color(1, 1, 1, 0)
		var stars = line.find_node("Stars", true, false)
		if !(stars is Container) or !stars.has_node("Star"):
			continue
		input_handler.ClearContainer(stars, ['Star'])
		for level in range(1, STARS + 1):
			var star = input_handler.DuplicateContainerTemplate(stars, 'Star')
			star.set_meta("level", level)
			var gold = star.get_node_or_null("Gold")
			if gold is Control:
				gold.visible = level <= int(step.to)
				gold.rect_pivot_offset = gold.rect_size / 2
				gold.rect_scale = Vector2(1, 1) if level <= int(step.from) else Vector2(0.001, 0.001)
			for part in ["Shine", "Ring"]:
				var node = star.get_node_or_null(part)
				if node is Control:
					node.rect_pivot_offset = node.rect_size / 2
					node.modulate = Color(1, 1, 1, 0)


func level_word(level):
	if input_handler.globalsettings.factors_as_words:
		return ResourceScripts.descriptions.factor_descripts[int(clamp(level, 1, 6))]
	return str(level)


func place(area):
	var panel = _node("Panel")
	var size = panel.get_combined_minimum_size()
	panel.rect_size = size
	var box = Rect2(rect_global_position, rect_size) if area == null else area
	var top = TOP if area == null else box.position.y + AREA_MARGIN
	panel.rect_global_position = Vector2(box.position.x + (box.size.x - size.x) / 2, top).floor()
	panel.rect_pivot_offset = size / 2
	var glow = _node("Glow")
	if glow is Control:
		glow.rect_size = size + Vector2(GLOW_MARGIN, GLOW_MARGIN) * 2
		glow.rect_global_position = panel.rect_global_position - Vector2(GLOW_MARGIN, GLOW_MARGIN)


func start():
	state = 'playing'
	modulate = Color(1, 1, 1, 1)
	tween = input_handler.GetTweenNode(self)
	tween.remove_all()
	var panel = _node("Panel")
	panel.rect_scale = Vector2(0.001, 1)
	tween.interpolate_property(panel, "rect_scale", Vector2(0.001, 1), Vector2(1, 1), UNFOLD, Tween.TRANS_SINE, Tween.EASE_OUT)
	var content = _node("Content")
	if content is CanvasItem:
		content.modulate = Color(1, 1, 1, 0)
		_fade(content, 0.0, 1.0, CONTENT_IN, UNFOLD)
	var glow = _node("Glow")
	if glow is CanvasItem:
		glow.modulate = Color(1, 1, 1, 0)
		_fade(glow, 0.0, 1.0, 0.5, 0.5)
		_fade(glow, 1.0, 0.0, 1.0, beats.last_pop + GLOW_OUT_AFTER)
	var lines = _node("Lines")
	if lines is Container:
		var i = 0
		for line in lines.get_children():
			if !line.has_meta("factor") or i >= beats.lines.size():
				continue
			var line_beats = beats.lines[i]
			_fade(line, 0.0, 1.0, 0.25, line_beats.appear)
			var stars = line.find_node("Stars", true, false)
			var step = raised[i]
			if stars is Container:
				for star in stars.get_children():
					if !star.has_meta("level"):
						continue
					var level = star.get_meta("level")
					if level > int(step.from) and level <= int(step.to):
						_pop(star, line_beats.pops[level - int(step.from) - 1])
			var word = line.find_node("Word", true, false)
			if word is CanvasItem:
				_fade(word, 0.0, 1.0, 0.25, line_beats.word)
			i += 1
	tween.start()
	get_tree().create_timer(beats.end).connect("timeout", self, "fold")


func _fade(node, from, to, time, delay):
	tween.interpolate_property(node, "modulate", Color(1, 1, 1, from), Color(1, 1, 1, to), time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)


func _pop(star, at):
	var gold = star.get_node_or_null("Gold")
	if gold is Control:
		tween.interpolate_property(gold, "rect_scale", Vector2(0.001, 0.001), Vector2(1.25, 1.25), 0.12, Tween.TRANS_QUAD, Tween.EASE_OUT, at)
		tween.interpolate_property(gold, "rect_scale", Vector2(1.25, 1.25), Vector2(1, 1), 0.1, Tween.TRANS_QUAD, Tween.EASE_IN, at + 0.12)
	var shine = star.get_node_or_null("Shine")
	if shine is CanvasItem:
		_fade(shine, 0.0, 0.75, 0.2, at)
		_fade(shine, 0.75, 0.0, 0.7, at + 0.2)
	var ring = star.get_node_or_null("Ring")
	if ring is Control:
		tween.interpolate_property(ring, "rect_scale", Vector2(0.001, 0.001), Vector2(0.8, 0.8), 0.07, Tween.TRANS_LINEAR, Tween.EASE_OUT, at)
		tween.interpolate_property(ring, "rect_scale", Vector2(0.8, 0.8), Vector2(1, 1), 0.45, Tween.TRANS_QUAD, Tween.EASE_OUT, at + 0.07)
		tween.interpolate_property(ring, "rect_rotation", -360.0, -340.0, 0.66, Tween.TRANS_LINEAR, Tween.EASE_OUT, at)
		_fade(ring, 0.0, 1.0, 0.04, at)
		_fade(ring, 1.0, 0.0, 0.2, at + 0.45)


func fold():
	if state != 'playing':
		return
	state = 'folding'
	tween.remove_all()
	var content = _node("Content")
	if content is CanvasItem:
		_fade(content, content.modulate.a, 0.0, 0.25, 0.0)
	var glow = _node("Glow")
	if glow is CanvasItem:
		_fade(glow, glow.modulate.a, 0.0, 0.25, 0.0)
	var panel = _node("Panel")
	tween.interpolate_property(panel, "rect_scale", Vector2(1, 1), Vector2(0.001, 1), 0.2, Tween.TRANS_SINE, Tween.EASE_IN, 0.25)
	tween.start()
	get_tree().create_timer(FOLD).connect("timeout", self, "finish")


func _input(event):
	if state == 'playing' and event.is_action_released("LMB"):
		skip()


func skip():
	state = 'skipping'
	tween.remove_all()
	show_final()
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), SKIP_FADE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.1)
	tween.start()
	get_tree().create_timer(SKIP_FADE + 0.1).connect("timeout", self, "finish")


func show_final():
	var panel = _node("Panel")
	if panel is Control:
		panel.rect_scale = Vector2(1, 1)
	for node_name in ["Content", "Glow"]:
		var node = _node(node_name)
		if node is CanvasItem:
			node.modulate = Color(1, 1, 1, 1)
	var lines = _node("Lines")
	if !(lines is Container):
		return
	for line in lines.get_children():
		if !line.has_meta("factor"):
			continue
		line.modulate = Color(1, 1, 1, 1)
		var word = line.find_node("Word", true, false)
		if word is CanvasItem:
			word.modulate = Color(1, 1, 1, 1)
		var stars = line.find_node("Stars", true, false)
		if !(stars is Container):
			continue
		for star in stars.get_children():
			if !star.has_meta("level"):
				continue
			var gold = star.get_node_or_null("Gold")
			if gold is Control and gold.visible:
				gold.rect_scale = Vector2(1, 1)
			for part in ["Shine", "Ring"]:
				var node = star.get_node_or_null(part)
				if node is CanvasItem:
					node.modulate = Color(1, 1, 1, 0)


func finish():
	if state == 'done':
		return
	state = 'done'
	queue_free()
	input_handler.emit_signal("animation_finished")
