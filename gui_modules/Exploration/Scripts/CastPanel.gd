extends Control

onready var cont = $ScrollContainer/VBoxContainer
onready var scroller = $ScrollContainer

enum {ENTITY_SKILL, ENTITY_ITEM, ENTITY_RETURN}
onready var max_cont_h =  scroller.rect_size.y#508
onready var bg_margin = rect_size.y - max_cont_h#80
const BOTTOM_MARG = 50.0

signal set_entity_use(type, caster, entity)

var is_my_input = true
var build_cache = {
	person_id = null,
	add_return = false
}

func _input(event):
	if !visible: return
	if event.is_action_released("RMB") or event.is_action_released("LMB"):
		is_my_input = get_rect().has_point(event.position)
		get_tree().connect("idle_frame", self, "process_not_my_input", [], CONNECT_ONESHOT)

#func _gui_input(event):
#	if !visible: return
#	if event.is_action_released("RMB") or event.is_action_released("LMB"):
#		is_my_input = true

func abort_this_input_hide():
	is_my_input = true

func process_not_my_input():
	if cur_input_is_my(): return
	hide()

func cur_input_is_my():
	return visible and is_my_input

func hide():
	input_handler.ClearContainer(cont)
	.hide()

func build_for_person(person_id, add_return = false, only_check = false):
	if !only_check:
		build_cache.person_id = person_id
		build_cache.add_return = add_return
	cont.rect_size.y = 0
	var not_empty = false
	var person = ResourceScripts.game_party.characters[person_id]
	for skill_id in person.get_combat_skills() + person.get_explore_skills():
		if skill_id == "teleport":#hardcoded separately
			continue
		var skill = Skilldata.get_template(skill_id, person)
		if !skill.tags.has('exploration'):
			continue
		not_empty = true
		if only_check:
			return not_empty
		var newnode = input_handler.DuplicateContainerTemplate(cont)
		newnode.get_node('Icon').texture = skill.icon
		if skill.tags.has('aura_active'):
			newnode.get_node("Icon").material = load("res://assets/book_shader.tres")
		var disabled = false
		if skill.charges > 0:
			var leftcharges = skill.charges
			if person.skills.combat_skill_charges.has(skill.code):
				leftcharges -= person.skills.combat_skill_charges[skill.code]
			if leftcharges <= 0:
				disabled = true
			newnode.get_node("name").text = "%s (%s/%s)" % [
				skill.name,
				leftcharges, skill.charges]
		else:
			newnode.get_node("name").text = skill.name
		newnode.get_node("amount").hide()
		var text = skill.descript
		
		for st in skill.cost:
			text += "\n\n%s cost: %s (%s)" % [
				statdata.statdata[st].name,
				skill.cost[st],
				floor(person.get_stat(st))]
		if !skill.catalysts.empty() and !person.has_status('ignore_catalysts_for_%s' % skill_id):
			text += '\n\nRequired Catalysts: '
			for k in skill.catalysts:
				text += "\n%s: %s (%s)" % [
					Items.materiallist[k].name,
					skill.catalysts[k],
					ResourceScripts.game_res.materials[k]]
				if ResourceScripts.game_res.materials[k] < skill.catalysts[k]:
					disabled = true
		if skill.charges > 0:
			text += "\n\n%s: %s. %s: %s %s" % [
				tr("MAX_CHARGES"), str(skill.charges),
				tr("TOOLTIP_COOLDOWN"), str(skill.cooldown), tr("TOOLTIP_DAY_S")]
		globals.connecttexttooltip(newnode, text)
		if !person.check_cost(skill.cost):
			disabled = true
		if person.has_status('no_obed_gain'):
			disabled = true
		if disabled:
			newnode.get_node("name").set("custom_colors/font_color", Color(1, 0.5, 0.5))
		else:
			newnode.connect('pressed', self, 'on_pressed', [ENTITY_SKILL, person, skill, newnode])
	
#	for item in ResourceScripts.game_res.items.values():
#		if Items.itemlist[item.itembase].has('explor_effect') == false:
#			continue
#		var newnode = input_handler.DuplicateContainerTemplate(cont)
#		item.set_icon(newnode.get_node("Icon"))
#		newnode.get_node("amount").text = str(item.amount)
#		newnode.get_node("name").text = tr("ITEM" + str(item.code).to_upper())
#		globals.connectitemtooltip_v2(newnode, item)
#		newnode.connect('pressed', self, 'on_pressed', [ENTITY_ITEM, person, item])
	
	if only_check:
		return not_empty
	
	if add_return:
		var newnode = input_handler.DuplicateContainerTemplate(cont)
		newnode.get_node('Icon').hide()
		newnode.get_node("name").text = tr("RETURN_MANSION_LABEL")
		newnode.get_node("amount").hide()
		newnode.connect('pressed', self, 'on_pressed', [ENTITY_RETURN, person, {}, newnode])
	
	yield(get_tree(), 'idle_frame')#mind, that yield() is also return!
	
	scroller.rect_size.y = min(cont.rect_size.y, max_cont_h)
	rect_size.y = scroller.rect_size.y + bg_margin
	var screen = get_viewport().get_visible_rect()
#	if get_global_rect().end.y >= screen.size.y:
#		rect_position.y = screen.size.y - rect_size.y
	rect_global_position.y = (
			screen.size.y -
			rect_size.y -
			BOTTOM_MARG
		)


func rebuild():
	input_handler.ClearContainer(cont)
	yield(get_tree(), 'idle_frame')
	build_for_person(build_cache.person_id, build_cache.add_return)


func on_pressed(type, caster, entity, btn):
#	btn.get_node("pressed_bg").show()
	emit_signal("set_entity_use", type, caster, entity, btn)
#	hide()


func can_cast(person_id):
	return build_for_person(person_id, false, true)
