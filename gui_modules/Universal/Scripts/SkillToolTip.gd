extends tooltip_main

var skill
onready var sec_node = $descript
onready var main_node = $ScrollContainer

func showup(node, skillcode, ch):
	if _setup(node):
		skill = Skilldata.get_template(skillcode, ch)


func update():
	var text = skill.name
	main_node.get_node('VBoxContainer/TextureRect2/name').text = text
	text = skill.descript
	main_node.get_node('VBoxContainer/TextureRect2/TextureRect').texture = skill.icon
	if skill.has("eff_descript"):
		sec_node.bbcode_text = globals.TextEncoder(skill.eff_descript)
		sec_node.show()
	else:
		sec_node.hide()
	var charges = skill.charges
	if charges > 0 and skill.cooldown > 0:
		text += tr("\n\n" + tr("MAX_CHARGES") + ": {color=yellow|") + str(charges) + "}. " + tr("TOOLTIP_COOLDOWN") + ": " + str(skill.cooldown) + " " + tr("TOOLTIP_DAY_S")
	if skill.has('combatcooldown') && skill.combatcooldown > 0:
		text += "\n\n" + tr("TOOLTIP_COOLDOWN") + ": {color=yellow|" + str(skill.combatcooldown) + "}"
	
	if !parentnode.has_meta('display_only'):
		text += "\n\n{color=yellow|"+tr("TOOLTIPRIGHTCLICKABILITY")+"}"
	
	main_node.get_node('VBoxContainer/descript').bbcode_text = globals.TextEncoder(text)
	
	text = tr("USAGE_COST") + ": "
	for st in skill.cost:
		text += "%s: %d. " % [statdata.statdata[st].name ,int(skill.cost[st])]
	if skill.has('catalysts') && skill.catalysts.size() > 0:
		for i in skill.catalysts:
			text += Items.materiallist[i].name + " - " + str(skill.catalysts[i]) + ", "
		text = text.substr(0, text.length() - 2) + ". "
	if text == tr("USAGE_COST") + ": ":
		text += tr("TOOLTIP_NONE")
	
	main_node.get_node('VBoxContainer/cost').text = text
	
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
	#ugly patch to force sec_node to shrink, when there is less text
	sec_node.rect_size.y = sec_node.rect_min_size.y
	
	emit_signal("update_completed")

