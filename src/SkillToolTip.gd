extends Panel

var parentnode
var shutoff = false
var prevnode

var character = Reference

func _process(delta):
	if parentnode != null && ( parentnode.is_visible_in_tree() == false || !parentnode.get_global_rect().has_point(get_global_mouse_position())):
		set_process(false)
		hide()

func _init():
	set_process(false)

func showup(node, skillcode):
	var skill = Skilldata.Skilllist[skillcode]
	parentnode = node
	if shutoff == true && prevnode == parentnode:
		return
	show()
	set_process(true)
	var text = '[center]'+skill.name+'[/center]\n' + skill.descript
	
	if skill.charges > 0:
		text += "\n\nMax Charges: [color=yellow]" + str(skill.charges) + "[/color]. Cooldown: " + str(skill.cooldown) + " day(s)."
	$descript.bbcode_text = text
	
	text = "Usage Cost: "
	if skill.manacost > 0:
		text += "Mana: " + str(skill.manacost) + ". "
	if skill.energycost > 0:
		text += "Energy: " + str(skill.energycost) + ". "
	if text == "Usage Cost: ":
		text += "None"
	$cost.text = text
	
	
	var pos = node.get_global_rect()
	pos = Vector2(pos.position.x, pos.end.y + 10)
	set_global_position(pos)
	
	$descript.rect_size.y = 190
	rect_size.y = 270
	
	yield(get_tree(), 'idle_frame')
	
	rect_size.y = max(270, $descript.get_v_scroll().get_max() + 90)
	$descript.rect_size.y = rect_size.y - 80
	
	
	
	var screen = get_viewport().get_visible_rect()
	if get_rect().end.x >= screen.size.x:
		rect_global_position.x -= get_rect().end.x - screen.size.x
	if get_rect().end.y >= screen.size.y:
		rect_global_position.y = node.get_global_rect().position.y - (get_rect().size.y+10)
	prevnode = parentnode

