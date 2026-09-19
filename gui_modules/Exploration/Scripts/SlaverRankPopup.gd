extends Control
#The slaver rank ribbon after a sale or a hand-over: slave_quests.show_rank_popup() calls show_progress(data)
#with title, caption, icon, label, count, max, from, to, gold, tokens, rank, new_rank and rank_up.

const SLIDE = 780.0
const SLIDE_IN_TIME = 0.72
const SLIDE_OUT_TIME = 0.48
const RISE = [["Title", 0.2], ["CaptionRow", 0.28], ["BarBlock", 0.34]]
const RISE_BY = 12.0
const RISE_TIME = 0.42
const FILL_DELAY = 0.48
const FILL_TIME = 1.0
const GOLD_DELAY = 0.88
const TOKEN_DELAY = 1.12
const SOUND_TOKENS = "class_aquired"
const RANK_UP_AT = 1.55
const HOLD_TIME = 3.0
const HOLD_TIME_RANK_UP = 4.5
const SOUND_GOLD = "money_spend"
const SOUND_RANK_UP = "class_aquired"

var tween = Tween.new()
var data = {}
var max_value = 1
var base_positions = {}


func _ready():
	add_child(tween)
	_ignore_mouse(self)
	for node_name in ["Ribbon", "Title", "CaptionRow", "BarBlock", "GoldRow", "TokenRow"]:
		var node = _find(node_name)
		if node is Control:
			base_positions[node_name] = node.rect_position
	hide()


func _ignore_mouse(node):
	if node is Control:
		node.mouse_filter = MOUSE_FILTER_IGNORE
	for child in node.get_children():
		_ignore_mouse(child)


func show_progress(new_data):
	tween.remove_all()
	data = new_data
	max_value = max(1, int(data.get('max', 1)))
	var from = int(data.get('from', 0))
	var to = int(data.get('to', from))
	var rank_up = data.get('rank_up', false)
	var gold = int(data.get('gold', 0))
	var tokens = int(data.get('tokens', 0))

	_put_text("Title", data.get('title', ''))
	_set_shine(-1.0)
	_put_text("Caption", data.get('caption', ''))
	_put_text("Count", data.get('count', ''))
	_put_text("BarLabel", str(data.get('label', '')).to_upper())
	var crest = _find("Crest")
	if crest is TextureRect:
		crest.texture = data.get('icon') if data.get('icon') is Texture else null
		crest.visible = crest.texture != null
	_put_text("RankLetter", data.get('rank', ''))
	_put_text("Gold", "+0")
	_show("GoldRow", gold > 0)
	_put_text("Tokens", "+%d" % tokens)
	_show("TokenRow", tokens > 0)
	var token_icon = _find("TokenIcon")
	if token_icon is TextureRect:
		token_icon.texture = ResourceScripts.slave_quests.token_icon()
	var hex = _find("Hex")
	if hex is Control:
		hex.rect_scale = Vector2.ONE
	var burst = _find("Burst")
	if burst is Control:
		burst.visible = rank_up
		burst.modulate.a = 0.0
	_set_value(from)

	modulate.a = 1.0
	show()
	var title = _find("Title")
	if title is Control and title.material is ShaderMaterial:
		title.material.set_shader_param("width", title.rect_size.x)

	_from_to(_find("Ribbon"), "rect_position", _base("Ribbon") + Vector2(SLIDE, 0), _base("Ribbon"), SLIDE_IN_TIME, Tween.TRANS_BACK, Tween.EASE_OUT, 0.0)
	for rise in RISE:
		var node = _find(rise[0])
		_from_to(node, "rect_position", _base(rise[0]) + Vector2(0, RISE_BY), _base(rise[0]), RISE_TIME, Tween.TRANS_SINE, Tween.EASE_OUT, rise[1])
		_from_to(node, "modulate:a", 0.0, 1.0, RISE_TIME, Tween.TRANS_SINE, Tween.EASE_OUT, rise[1])

	tween.interpolate_method(self, "_set_value", from, to, FILL_TIME, Tween.TRANS_QUART, Tween.EASE_OUT, FILL_DELAY)
	var head = _find("Head")
	if head is Control:
		head.visible = to > from
		_from_to(head, "modulate:a", 0.0, 1.0, 0.18, Tween.TRANS_SINE, Tween.EASE_OUT, FILL_DELAY)
		tween.interpolate_property(head, "modulate:a", 1.0, 0.0, 0.45, Tween.TRANS_SINE, Tween.EASE_IN, FILL_DELAY + FILL_TIME + 0.05)
	_fly_sparks(from, to)

	if gold > 0:
		var row = _find("GoldRow")
		_from_to(row, "rect_scale", Vector2(0.4, 0.4), Vector2.ONE, 0.52, Tween.TRANS_BACK, Tween.EASE_OUT, GOLD_DELAY)
		_from_to(row, "modulate:a", 0.0, 1.0, 0.2, Tween.TRANS_SINE, Tween.EASE_OUT, GOLD_DELAY)
		tween.interpolate_method(self, "_set_gold", 0, gold, 0.65, Tween.TRANS_QUAD, Tween.EASE_OUT, GOLD_DELAY + 0.02)
		tween.interpolate_callback(self, GOLD_DELAY, "_sound", SOUND_GOLD)

	if tokens > 0:
		var token_row = _find("TokenRow")
		_from_to(token_row, "rect_scale", Vector2(0.4, 0.4), Vector2.ONE, 0.52, Tween.TRANS_BACK, Tween.EASE_OUT, TOKEN_DELAY)
		_from_to(token_row, "modulate:a", 0.0, 1.0, 0.2, Tween.TRANS_SINE, Tween.EASE_OUT, TOKEN_DELAY)
		if !rank_up:
			tween.interpolate_callback(self, TOKEN_DELAY, "_sound", SOUND_TOKENS)

	if rank_up:
		tween.interpolate_callback(self, RANK_UP_AT, "_promote")
		if burst is Control:
			tween.interpolate_property(burst, "rect_scale", Vector2(0.4, 0.4), Vector2(1.3, 1.3), 1.1, Tween.TRANS_QUAD, Tween.EASE_OUT, RANK_UP_AT)
			tween.interpolate_property(burst, "rect_rotation", 0.0, 40.0, 1.1, Tween.TRANS_QUAD, Tween.EASE_OUT, RANK_UP_AT)
			tween.interpolate_property(burst, "modulate:a", 0.0, 1.0, 0.33, Tween.TRANS_SINE, Tween.EASE_OUT, RANK_UP_AT)
			tween.interpolate_property(burst, "modulate:a", 1.0, 0.0, 0.77, Tween.TRANS_SINE, Tween.EASE_IN, RANK_UP_AT + 0.33)
		if hex is Control:
			tween.interpolate_property(hex, "rect_scale", Vector2(0.0, 1.15), Vector2(1.18, 1.18), 0.43, Tween.TRANS_SINE, Tween.EASE_OUT, RANK_UP_AT)
			tween.interpolate_property(hex, "rect_scale", Vector2(1.18, 1.18), Vector2.ONE, 0.35, Tween.TRANS_SINE, Tween.EASE_IN_OUT, RANK_UP_AT + 0.43)
		tween.interpolate_method(self, "_set_shine", -0.2, 1.2, 1.6, Tween.TRANS_SINE, Tween.EASE_IN_OUT, RANK_UP_AT)

	var hold = HOLD_TIME_RANK_UP if rank_up else HOLD_TIME
	tween.interpolate_property(_find("Ribbon"), "rect_position", _base("Ribbon"), _base("Ribbon") + Vector2(SLIDE, 0), SLIDE_OUT_TIME, Tween.TRANS_BACK, Tween.EASE_IN, hold)
	tween.interpolate_property(self, "modulate:a", 1.0, 0.0, SLIDE_OUT_TIME, Tween.TRANS_LINEAR, Tween.EASE_IN, hold)
	tween.interpolate_callback(self, hold + SLIDE_OUT_TIME, "hide")
	tween.start()


func _from_to(node, property, from, to, time, trans, easing, delay):
	if node == null:
		return
	node.set_indexed(property, from)
	tween.interpolate_property(node, property, from, to, time, trans, easing, delay)


func _base(node_name):
	return base_positions.get(node_name, Vector2())


func _set_value(value):
	var bar = _find("Bar")
	if !(bar is Range):
		return
	bar.max_value = max_value
	bar.value = value
	var head = _find("Head")
	if head is Control:
		var share = clamp(float(value) / max_value, 0.0, 1.0)
		head.rect_position.x = bar.rect_position.x + bar.rect_size.x * share - head.rect_size.x / 2


func _fly_sparks(from, to):
	var sparks = _find("Sparks")
	if !(sparks is Control):
		return
	var count = sparks.get_child_count()
	for i in range(count):
		var spark = sparks.get_child(i)
		spark.modulate.a = 0.0
		if to <= from:
			continue
		var share = float(i + 1) / (count + 1)
		var x = sparks.rect_size.x * (from + (to - from) * share) / max_value
		var start = Vector2(x - spark.rect_size.x / 2, (sparks.rect_size.y - spark.rect_size.y) / 2)
		var drift = Vector2((-1 if i % 2 == 0 else 1) * (4.5 + (i + 1) * 3.0), -18.0 - ((i + 1) % 3) * 10.5)
		var delay = FILL_DELAY + FILL_TIME * (1.0 - sqrt(1.0 - share))
		spark.rect_position = start
		tween.interpolate_property(spark, "rect_position", start, start + drift, 0.7, Tween.TRANS_SINE, Tween.EASE_OUT, delay)
		tween.interpolate_property(spark, "modulate:a", 0.0, 1.0, 0.14, Tween.TRANS_LINEAR, Tween.EASE_OUT, delay)
		tween.interpolate_property(spark, "modulate:a", 1.0, 0.0, 0.56, Tween.TRANS_SINE, Tween.EASE_IN, delay + 0.14)


func _set_gold(value):
	_put_text("Gold", "+%d" % int(round(value)))


func _set_shine(position):
	var title = _find("Title")
	if title is Control and title.material is ShaderMaterial:
		title.material.set_shader_param("shine_pos", position)


func _promote():
	_sound(SOUND_RANK_UP)
	_put_text("RankLetter", data.get('new_rank', ''))
	_put_text("Title", globals._report_text("SQ_POPUP_RANK_UP", [data.get('new_rank', '')]))


func _sound(sound_name):
	input_handler.PlaySound(sound_name)


func _find(node_name):
	return find_node(node_name, true, false)


func _put_text(node_name, text):
	var node = _find(node_name)
	if node is RichTextLabel:
		node.bbcode_enabled = true
		node.bbcode_text = text
	elif node is Label or node is Button:
		node.text = text


func _show(node_name, shown):
	var node = _find(node_name)
	if node is CanvasItem:
		node.visible = shown
