extends Panel
#The slave market's Upgrades tab: a character's factors raised for Tokens of Recognition and gold.

const EXPANDED = preload("res://gui_modules/Mansion/Scripts/MansionSlaveExpandedDetails.gd")
const UPGRADE_ANIM = preload("res://gui_modules/Animations/Animation_factor_upgrade.gd")
const SHORT_COLOR = Color(1, 0.45, 0.45)
const ENOUGH_COLOR = Color(0.976, 0.882, 0.506)
const RAISED_COLOR = Color(0.56, 0.9, 0.46)
const SPENT_GAP = 14
const EFFECT_LIFE = 1.4

var person = null
var plan = {}
var found = {}


func _ready():
	var buy = _node("Buy")
	if buy is BaseButton:
		buy.connect("pressed", self, "_on_buy_pressed")
	var reset = _node("Reset")
	if reset is BaseButton:
		reset.connect("pressed", self, "_on_reset_pressed")
	var help = _node("Help")
	if help != null:
		globals.connecttexttooltip(help, tr("SQ_UPGRADE_HELP"))
	var token_box = _node("TokenBox")
	if token_box != null:
		globals.connecttexttooltip(token_box, tr("SQ_TOKENS_TOOLTIP"))
	var token_icon = _node("TokenIcon")
	if token_icon is TextureRect:
		token_icon.texture = ResourceScripts.slave_quests.token_icon()
	ResourceScripts.slave_quests.connect("tokens_changed", self, "_on_tokens_changed")


func open():
	build_characters()
	if ResourceScripts.slave_quests.can_upgrade_character(person):
		select(person)
	else:
		select_first()
	show()


func _node(node_name):
	if !found.has(node_name) or !is_instance_valid(found[node_name]):
		found[node_name] = find_node(node_name, true, false)
	return found[node_name]


func _put_text(node_name, text):
	var node = _node(node_name)
	if node is Label or node is Button:
		node.text = text


#--------------characters--------------

func build_characters():
	var list = _node("Characters")
	if !(list is Container) or !list.has_node("CharRow"):
		return
	input_handler.ClearContainer(list, ['CharRow'])
	var sq = ResourceScripts.slave_quests
	for id in ResourceScripts.game_party.character_order:
		var character = ResourceScripts.game_party.characters.get(id)
		if !sq.can_upgrade_character(character):
			continue
		var row = input_handler.DuplicateContainerTemplate(list, 'CharRow')
		row.set_meta("character_id", character.id)
		var portrait = row.get_node_or_null("Portrait")
		if portrait is TextureRect:
			portrait.texture = character.get_icon_small()
		var name_label = row.get_node_or_null("Name")
		if name_label is Label:
			name_label.text = character.get_short_name()
		var type_label = row.get_node_or_null("Type")
		if type_label is Label:
			type_label.text = globals.character_type_name(character)
		if row is BaseButton:
			row.toggle_mode = true
			row.connect("pressed", self, "select", [character])


func select_first():
	var sq = ResourceScripts.slave_quests
	for id in ResourceScripts.game_party.character_order:
		var character = ResourceScripts.game_party.characters.get(id)
		if sq.can_upgrade_character(character):
			select(character)
			return
	select(null)


func select(character):
	person = character
	plan = {}
	var list = _node("Characters")
	if list is Container:
		for row in list.get_children():
			if row is BaseButton and row.has_meta("character_id"):
				row.pressed = person != null and row.get_meta("character_id") == person.id
	build_plan()


#--------------the plan--------------

func build_plan():
	var sq = ResourceScripts.slave_quests
	var chosen = person != null
	var pick = _node("Pick")
	if pick is CanvasItem:
		pick.visible = !chosen
	var plan_box = _node("Plan")
	if plan_box is CanvasItem:
		plan_box.visible = chosen
	var rows = _node("FactorRows")
	if rows is Container and rows.has_node("FactorRow"):
		input_handler.ClearContainer(rows, ['FactorRow'])
	if !chosen:
		update_totals()
		return
	var portrait = _node("SelectedPortrait")
	if portrait is TextureRect:
		portrait.texture = person.get_icon()
	_put_text("SelectedName", person.get_full_name())
	if rows is Container and rows.has_node("FactorRow"):
		for code in sq.upgradable_factors(person):
			var row = input_handler.DuplicateContainerTemplate(rows, 'FactorRow')
			row.set_meta("factor", code)
			var minus = row.get_node_or_null("Minus")
			if minus is BaseButton:
				minus.connect("pressed", self, "step", [code, -1])
			var plus = row.get_node_or_null("Plus")
			if plus is BaseButton:
				plus.connect("pressed", self, "step", [code, 1])
			fill_factor_row(row, code)
	update_totals()


func step(code, direction):
	if person == null:
		return
	var sq = ResourceScripts.slave_quests
	var current = sq.factor_level(person, code)
	var target = int(plan.get(code, current)) + direction
	target = int(clamp(target, current, max(current, sq.factor_upgrade_limit())))
	if target == current:
		plan.erase(code)
	else:
		plan[code] = target
	var rows = _node("FactorRows")
	if rows is Container:
		for row in rows.get_children():
			if row.has_meta("factor") and row.get_meta("factor") == code:
				fill_factor_row(row, code)
	update_totals()


func fill_factor_row(row, code):
	var sq = ResourceScripts.slave_quests
	var current = sq.factor_level(person, code)
	var planned = int(plan.get(code, current))
	var limit = sq.factor_upgrade_limit()
	var icon = row.get_node_or_null("Icon")
	if icon is TextureRect:
		icon.texture = EXPANDED.OVERVIEW_ICONS[code]
	var name_label = row.get_node_or_null("FactorName")
	if name_label is Label:
		name_label.text = tr(statdata.statdata[code].name)
	_level_text(row.get_node_or_null("Current"), current, false)
	_level_text(row.get_node_or_null("Planned"), planned, planned > current)
	var minus = row.get_node_or_null("Minus")
	if minus is BaseButton:
		minus.disabled = planned <= current
	var plus = row.get_node_or_null("Plus")
	if plus is BaseButton:
		plus.disabled = planned >= limit
		var why = ""
		if planned >= int(sq.quest_data.factor_upgrade.top_level):
			why = tr("SQ_UPGRADE_AT_TOP")
		elif planned >= limit:
			why = tr("SQ_UPGRADE_AT_LIMIT")
		else:
			var cost = sq.factor_step_cost(planned + 1)
			why = globals._report_text("SQ_UPGRADE_STEP", [_level_word(planned + 1), cost.tokens, cost.gold])
		globals.connecttexttooltip(plus, why)
	var step_cost = row.get_node_or_null("StepCost")
	if step_cost is CanvasItem:
		var cost = sq.upgrade_plan_cost(person, {code: planned})
		step_cost.visible = cost.steps > 0
		var tokens = step_cost.find_node("StepTokens", true, false)
		if tokens is Label:
			tokens.text = str(cost.tokens)
		var gold = step_cost.find_node("StepGold", true, false)
		if gold is Label:
			gold.text = str(cost.gold)
		var token_icon = step_cost.find_node("StepTokenIcon", true, false)
		if token_icon is TextureRect:
			token_icon.texture = sq.token_icon()


func _level_text(label, level, raised):
	if !(label is Label):
		return
	label.text = _level_word(level)
	var colour = RAISED_COLOR if raised else Color(variables.hexcolordict["factor" + str(int(clamp(level, 1, 6)))])
	label.set("custom_colors/font_color", colour)


func _level_word(level):
	if input_handler.globalsettings.factors_as_words:
		return ResourceScripts.descriptions.factor_descripts[int(clamp(level, 1, 6))]
	return str(level)


#--------------the bill--------------

func update_totals():
	var sq = ResourceScripts.slave_quests
	_put_text("Tokens", str(sq.get_tokens()))
	var limit = sq.factor_upgrade_limit()
	if limit <= 0:
		_put_text("Limit", globals._report_text("SQ_UPGRADE_LOCKED", [_first_rank_with_upgrades()]))
	else:
		_put_text("Limit", globals._report_text("SQ_UPGRADE_LIMIT", [_level_word(limit)]))
	var cost = sq.upgrade_plan_cost(person, plan) if person != null else {tokens = 0, gold = 0, steps = 0}
	var money = ResourceScripts.game_res.money
	_total("TotalTokens", cost.tokens, sq.get_tokens())
	_total("TotalGold", cost.gold, money)
	var total_icon = _node("TotalTokenIcon")
	if total_icon is TextureRect:
		total_icon.texture = sq.token_icon()
	var problem = sq.upgrade_plan_problem(person, plan) if person != null else tr("SQ_UPGRADE_NOTHING")
	var buy = _node("Buy")
	if buy is BaseButton:
		buy.disabled = problem != ''
		globals.connecttexttooltip(buy, problem if problem != '' else tr("SQ_UPGRADE_BUY_TOOLTIP"))
	var reset = _node("Reset")
	if reset is BaseButton:
		reset.disabled = plan.empty()


func _total(node_name, needed, have):
	var label = _node(node_name)
	if !(label is Label):
		return
	label.text = "%d / %d" % [needed, have]
	label.set("custom_colors/font_color", SHORT_COLOR if needed > have else ENOUGH_COLOR)


func _first_rank_with_upgrades():
	for data in ResourceScripts.slave_quests.quest_data.ranks:
		if int(data.factor_upgrade_cap) > 0:
			return data.code
	return "-"


func _on_reset_pressed():
	plan = {}
	build_plan()


func _on_buy_pressed():
	var sq = ResourceScripts.slave_quests
	if person == null or sq.upgrade_plan_problem(person, plan) != '':
		return
	var cost = sq.upgrade_plan_cost(person, plan)
	var text = globals._report_text("SQ_UPGRADE_ASK", [cost.tokens, cost.gold])
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, '_on_buy_confirmed', person.translate(text)])


func _on_buy_confirmed():
	if person == null:
		return
	var sq = ResourceScripts.slave_quests
	var raised = sq.upgrade_plan_raises(person, plan)
	var cost = sq.upgrade_plan_cost(person, plan)
	if sq.apply_upgrade_plan(person, plan, _anim_area()):
		input_handler.PlaySound("money_spend")
		plan = {}
		build_plan()
		play_purchase_effects(raised, cost)


func _on_tokens_changed():
	if is_visible_in_tree():
		update_totals()


#--------------the purchase--------------

func _anim_area():
	for node_name in ["CharacterPanel", "CharScroll"]:
		var node = _node(node_name)
		if node is Control and node.is_visible_in_tree():
			return node.get_global_rect()
	return null


func play_purchase_effects(raised, cost):
	var beats = UPGRADE_ANIM.schedule(raised)
	_float_spent("SpentTokens", "Tokens", cost.tokens, 0.3)
	_float_spent("SpentGold", "TotalGold", cost.gold, 0.35)
	for i in range(raised.size()):
		var line = beats.lines[i]
		get_tree().create_timer(line.first_pop).connect("timeout", self, "_light_row", [raised[i].code, line.word - line.first_pop])


func _factor_row(code):
	var rows = _node("FactorRows")
	if rows is Container:
		for row in rows.get_children():
			if row.has_meta("factor") and row.get_meta("factor") == code:
				return row
	return null


func _light_row(code, word_delay):
	var row = _factor_row(code)
	var effects = _node("RowEffects")
	if row == null or !(effects is Control) or !effects.has_node("RowEffect") or !is_visible_in_tree():
		return
	var fx = input_handler.DuplicateContainerTemplate(effects, 'RowEffect')
	fx.rect_global_position = row.rect_global_position
	fx.rect_size = row.rect_size
	var tween = input_handler.GetTweenNode(fx)
	var flash = fx.get_node_or_null("Flash")
	if flash is CanvasItem:
		flash.modulate = Color(1, 1, 1, 0)
		_tween_fade(tween, flash, 0.0, 1.0, 0.25, 0.0)
		_tween_fade(tween, flash, 1.0, 0.0, 0.8, 0.3)
	var band = fx.find_node("Band", true, false)
	if band is Control:
		var y = band.rect_position.y
		tween.interpolate_property(band, "rect_position", Vector2(-band.rect_size.x - 40, y), Vector2(fx.rect_size.x + 40, y), 0.7, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	var medallion = fx.get_node_or_null("Medallion")
	if medallion is TextureRect:
		var icon = row.get_node_or_null("Icon")
		medallion.texture = icon.texture if icon is TextureRect else null
		medallion.rect_pivot_offset = medallion.rect_size / 2
		tween.interpolate_property(medallion, "rect_scale", Vector2(1, 1), Vector2(1.32, 1.32), 0.23, Tween.TRANS_QUAD, Tween.EASE_OUT, 0.1)
		tween.interpolate_property(medallion, "rect_scale", Vector2(1.32, 1.32), Vector2(1, 1), 0.29, Tween.TRANS_QUAD, Tween.EASE_IN, 0.33)
	var ring = fx.get_node_or_null("Ring")
	if ring is Control:
		ring.rect_pivot_offset = ring.rect_size / 2
		ring.modulate = Color(1, 1, 1, 0)
		tween.interpolate_property(ring, "rect_scale", Vector2(0.4, 0.4), Vector2(1.35, 1.35), 0.65, Tween.TRANS_QUAD, Tween.EASE_OUT, 0.1)
		_tween_fade(tween, ring, 0.0, 1.0, 0.04, 0.1)
		_tween_fade(tween, ring, 1.0, 0.0, 0.55, 0.2)
	tween.start()
	var current = row.get_node_or_null("Current")
	if current is CanvasItem:
		var flare = input_handler.GetTweenNode(current)
		flare.interpolate_property(current, "modulate", Color(2.2, 2.2, 2.2), Color(1, 1, 1), 0.8, Tween.TRANS_QUAD, Tween.EASE_OUT, max(word_delay, 0.0))
		flare.start()
	get_tree().create_timer(EFFECT_LIFE).connect("timeout", fx, "queue_free")


func _float_spent(node_name, anchor_name, amount, delay):
	var label = _node(node_name)
	var anchor = _node(anchor_name)
	if !(label is Label) or !(anchor is Label) or amount <= 0:
		return
	label.text = "-%d" % amount
	var font = anchor.get_font("font")
	var text_width = font.get_string_size(anchor.text).x if font != null else 0.0
	var size = label.get_combined_minimum_size()
	label.rect_size = size
	var top = anchor.rect_global_position.y + (anchor.rect_size.y - size.y) / 2
	label.rect_global_position = Vector2(anchor.rect_global_position.x + text_width + SPENT_GAP, top + 6).floor()
	var start = label.rect_position
	label.modulate = Color(1, 1, 1, 0)
	var tween = input_handler.GetTweenNode(label)
	tween.remove_all()
	tween.interpolate_property(label, "rect_position", start, start - Vector2(0, 22), 1.3, Tween.TRANS_QUAD, Tween.EASE_OUT, delay)
	_tween_fade(tween, label, 0.0, 1.0, 0.2, delay)
	_tween_fade(tween, label, 1.0, 0.0, 0.6, delay + 0.7)
	tween.start()


func _tween_fade(tween, node, from, to, time, delay):
	tween.interpolate_property(node, "modulate", Color(1, 1, 1, from), Color(1, 1, 1, to), time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
