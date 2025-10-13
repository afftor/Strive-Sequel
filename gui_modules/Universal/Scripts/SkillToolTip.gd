extends tooltip_main

var skill

func showup(node, skillcode, ch):
	if _setup(node):
		skill = Skilldata.get_template(skillcode, ch)


func update():
	var text = '[center]' + skill.name + '[/center]\n' + skill.descript
	
	var charges = skill.charges
	if charges > 0 and skill.cooldown > 0:
		text += tr("\n\n" + tr("MAX_CHARGES") + ": {color=yellow|") + str(charges) + "}. " + tr("TOOLTIP_COOLDOWN") + ": " + str(skill.cooldown) + " " + tr("TOOLTIP_DAY_S")
	if skill.has('combatcooldown') && skill.combatcooldown > 0:
		text += "\n\n" + tr("TOOLTIP_COOLDOWN") + ": {color=yellow|" + str(skill.combatcooldown) + "}"
	
	if !parentnode.has_meta('display_only'):
		text += "\n\n{color=yellow|"+tr("TOOLTIPRIGHTCLICKABILITY")+"}"
	
	$descript.bbcode_text = globals.TextEncoder(text)
	
	text = tr("USAGE_COST") + ": "
	for st in skill.cost:
		text += "%s: %d. " % [statdata.statdata[st].name ,int(skill.cost[st])]
	if skill.has('catalysts') && skill.catalysts.size() > 0:
		for i in skill.catalysts:
			text += Items.materiallist[i].name + " - " + str(skill.catalysts[i]) + ", "
		text = text.substr(0, text.length() - 2) + ". "
	if text == tr("USAGE_COST") + ": ":
		text += tr("TOOLTIP_NONE")
	
	$cost.text = text
	
	var pos = parentnode.get_global_rect()
	pos = Vector2(pos.position.x, pos.end.y + 10)
	set_global_position(pos)
	
	$descript.rect_size.y = 190
	rect_size.y = 270
	
	yield(get_tree(), 'idle_frame')
	
	rect_size.y = max(270, $descript.get_v_scroll().get_max() + 55 + $cost.rect_size.y)
	$descript.rect_size.y = rect_size.y - 80
	
	var screen = get_viewport().get_visible_rect()
	if get_rect().end.x >= screen.size.x:
		rect_global_position.x -= get_rect().end.x - screen.size.x
	if get_rect().end.y >= screen.size.y:
		rect_global_position.y = parentnode.get_global_rect().position.y - (get_rect().size.y+10)
	emit_signal("update_completed")

