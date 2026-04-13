extends tooltip_main

var skill
onready var sec_node = $Panel
onready var sec_cont = $Panel/cont
onready var sec_cont_margins = sec_cont.margin_top * 2
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
		input_handler.ClearContainer(sec_cont, ["entry"])
		for eff_desc in skill.eff_descript:
			var new_desc = input_handler.DuplicateContainerTemplate(sec_cont, "entry")
			new_desc.get_node("icon").texture = eff_desc.icon
			new_desc.get_node("descript").bbcode_text = globals.TextEncoder(eff_desc.text)
		sec_node.show()
	else:
		sec_node.hide()
	if mode == MODE_DEFAULT:
		text = skill.descript
		
		if !parentnode.has_meta('display_only'):
			text += "\n\n{color=yellow|"+tr("TOOLTIPRIGHTCLICKABILITY")+"}"
		text += "\n"
	elif mode == MODE_ADVANCED:
		text = ""
		for tip_type in ["ability_type", "target_number", "target", "target_range"]:
			if !skill.has(tip_type):
				continue
			var tip_text = skill[tip_type]
			if tips[tip_type].has(tip_text):
				tip_text = tr(tips[tip_type][tip_text])
			text += "%s: %s" % [tr(tips[tip_type].title), tip_text]
			if tip_type != "target_range":
				text += "\n"
		if skill.has("reqs_text"):
			text += "\n" + skill.reqs_text
	
	if skill.charges > 0 and skill.cooldown > 0:
		text += "\n%s: {color=yellow|%s}. %s: {color=yellow|%s} %s" % [
			tr("MAX_CHARGES"), str(skill.charges),
			tr("TOOLTIP_COOLDOWN"), str(skill.cooldown), tr("TOOLTIP_DAY_S")]
	if skill.has('combatcooldown') && skill.combatcooldown > 0:
		text += "\n%s: {color=yellow|%s} %s" % [
			tr("TOOLTIP_COOLDOWN"), str(skill.combatcooldown), tr("TOOLTIP_TURNS")]
	
	main_node.get_node('VBoxContainer/descript').bbcode_text = globals.TextEncoder(text)
	
	text = ""
	for st in skill.cost:
		text += "%s: %d. " % [statdata.statdata[st].name, int(skill.cost[st])]
	if skill.has('catalysts') && skill.catalysts.size() > 0:
		for i in skill.catalysts:
			text += Items.materiallist[i].name + " - " + str(skill.catalysts[i]) + ", "
		text = text.substr(0, text.length() - 2) + ". "
	if text.empty():
		text += tr("TOOLTIP_NONE")
	text = tr("USAGE_COST") + ": " + text
	main_node.get_node('VBoxContainer/cost').text = text
	
	
	var pos = parentnode.get_global_rect()
	pos = Vector2(pos.position.x, pos.end.y + 10)
	set_global_position(pos)
	
	main_node.get_node('VBoxContainer/descript').rect_size.y = 190
	main_node.rect_size.y = 270
	
	#ugly patch to force node to shrink, when there is less text
#	main_node.rect_size.y = main_node.rect_min_size.y
	sec_cont.rect_size.y = sec_cont.rect_min_size.y
	
	yield(get_tree(), 'idle_frame')
	
	if !weakref(parentnode).get_ref():
		emit_signal("update_completed")
		return
	
	main_node.rect_size.y = max(270, main_node.get_node('VBoxContainer/descript').get_v_scroll().get_max() + 55 + main_node.get_node('VBoxContainer/cost').rect_size.y)
	main_node.get_node('VBoxContainer/descript').rect_size.y = main_node.rect_size.y - 80
	
	var screen = get_viewport().get_visible_rect()
	if main_node.get_global_rect().end.x >= screen.size.x:
		rect_global_position.x = screen.size.x - main_node.rect_size.x
	if main_node.get_global_rect().end.y >= screen.size.y:#move to top
		rect_global_position.y = parentnode.rect_global_position.y - (main_node.rect_size.y+10)
	
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
			#up to here possibility of not fitting per y is very low
		#if there is no do_move, leave it as is. Probability is low
	
	if sec_node.visible:
		sec_node.rect_size.y = sec_cont.rect_size.y + sec_cont_margins
		sec_node.rect_position.x = main_node.rect_size.x
		if force_sec_node_left or sec_node.get_global_rect().end.x >= screen.size.x:
			sec_node.rect_position.x = -sec_node.rect_size.x
		if sec_node.get_global_rect().end.y >= screen.size.y:#this should not take place often
			rect_global_position.y = screen.size.y - sec_node.rect_size.y
	
	emit_signal("update_completed")

