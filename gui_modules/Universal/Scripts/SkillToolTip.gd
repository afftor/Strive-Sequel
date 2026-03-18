extends tooltip_main

var skill
onready var sec_node = $descript
onready var main_node = $ScrollContainer
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
	}
}

func showup(node, skillcode, ch):
	if _setup(node):
		skill = Skilldata.get_template(skillcode, ch)

func _input(event):
	if state != STATE_OPEN:
		return
	if event.is_action_pressed("shift"):
		mode = MODE_ADVANCED
		update()
	elif event.is_action_released("shift"):
		mode = MODE_DEFAULT
		update()

func update():
	var text = skill.name
	main_node.get_node('VBoxContainer/TextureRect2/name').text = text
	main_node.get_node('VBoxContainer/TextureRect2/TextureRect').texture = skill.icon
	if skill.has("eff_descript") and mode == MODE_DEFAULT:
		sec_node.bbcode_text = globals.TextEncoder(skill.eff_descript)
		sec_node.show()
	else:
		sec_node.hide()
	if mode == MODE_DEFAULT:
		text = skill.descript
		
		if !parentnode.has_meta('display_only'):
			text += "\n\n{color=yellow|"+tr("TOOLTIPRIGHTCLICKABILITY")+"}"
	elif mode == MODE_ADVANCED:
		text = ""
		for tip_type in ["ability_type", "target_number", "target"]:
			if !skill.has(tip_type):
				continue
			var tip_text = skill[tip_type]
			if tips[tip_type].has(tip_text):
				tip_text = tr(tips[tip_type][tip_text])
			text += "%s: %s" % [tr(tips[tip_type].title), tip_text]
			if tip_type != "target":
				text += "\n"
		if skill.charges > 0 and skill.cooldown > 0:
			text += "\n%s: {color=yellow|%s}. %s: {color=yellow|%s} %s" % [
				tr("MAX_CHARGES"), str(skill.charges),
				tr("TOOLTIP_COOLDOWN"), str(skill.cooldown), tr("TOOLTIP_DAY_S")]
		if skill.has('combatcooldown') && skill.combatcooldown > 0:
			text += "\n" + tr("TOOLTIP_COOLDOWN") + ": {color=yellow|" + str(skill.combatcooldown) + "}"
	main_node.get_node('VBoxContainer/descript').bbcode_text = globals.TextEncoder(text)
	
	if mode == MODE_ADVANCED:
		text = ""
		for st in skill.cost:
			text += "%s: %d. " % [statdata.statdata[st].name ,int(skill.cost[st])]
		if skill.has('catalysts') && skill.catalysts.size() > 0:
			for i in skill.catalysts:
				text += Items.materiallist[i].name + " - " + str(skill.catalysts[i]) + ", "
			text = text.substr(0, text.length() - 2) + ". "
		if text.empty():
			text += tr("TOOLTIP_NONE")
		text = tr("USAGE_COST") + ": " + text
		
		main_node.get_node('VBoxContainer/cost').show()
		main_node.get_node('VBoxContainer/cost').text = text
	elif mode == MODE_DEFAULT:
		main_node.get_node('VBoxContainer/cost').hide()
	
	
	var pos = parentnode.get_global_rect()
	pos = Vector2(pos.position.x, pos.end.y + 10)
	main_node.set_global_position(pos)
	
	main_node.get_node('VBoxContainer/descript').rect_size.y = 190
	main_node.rect_size.y = 270
	
	yield(get_tree(), 'idle_frame')
	
	if !weakref(parentnode).get_ref():
		emit_signal("update_completed")
		return
	
	main_node.rect_size.y = max(270, main_node.get_node('VBoxContainer/descript').get_v_scroll().get_max() + 55 + main_node.get_node('VBoxContainer/cost').rect_size.y)
	main_node.get_node('VBoxContainer/descript').rect_size.y = main_node.rect_size.y - 80
	
	#ugly patch to force node to shrink, when there is less text
	main_node.rect_size.y = main_node.rect_min_size.y
	sec_node.rect_size.y = sec_node.rect_min_size.y
	var screen = get_viewport().get_visible_rect()
	if main_node.get_rect().end.x >= screen.size.x:
		main_node.rect_global_position.x -= main_node.get_rect().end.x - screen.size.x
	if main_node.get_rect().end.y >= screen.size.y:
		main_node.rect_global_position.y = parentnode.get_global_rect().position.y - (main_node.get_rect().size.y+10)
	if sec_node.visible:
		var margin = abs(sec_node.get_node("Panel").rect_position.x)
		sec_node.rect_position.x = main_node.get_rect().end.x + margin
		sec_node.rect_position.y = main_node.rect_position.y + margin
		if sec_node.get_rect().end.x >= screen.size.x:
			sec_node.rect_position.x = main_node.rect_position.x - (sec_node.rect_size.x + margin)
		if sec_node.get_rect().end.y >= screen.size.y:
			main_node.rect_global_position.y = parentnode.get_global_rect().position.y - (sec_node.get_rect().size.y+10)
	
	
	emit_signal("update_completed")

