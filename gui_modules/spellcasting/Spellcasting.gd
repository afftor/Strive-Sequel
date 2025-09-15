extends Control

var mode = 0
var selected_person = null
var selected_spell = null

onready var caser_container = $caster/CasterContainer/VBoxContainer
onready var target_container = $targets/TargetContainer/VBoxContainer
onready var no_targets = $targets/TargetContainer/VBoxContainer/no_targets
onready var spells_container = $spells/SpellContainer/VBoxContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	gui_controller.add_close_button(self, "add_offset")


func open(t_person = null, t_spell = null, lock_selected = false):
	mode = 0
	if t_person != null:
		selected_person = t_person.id
		if lock_selected:
			mode = 1
		if t_spell != null:
			selected_spell = t_spell
			if lock_selected:
				mode = 2
		else:
			selected_spell = null
	else:
		selected_person = null
	update()
#	match_mode()


func update():
	update_casters()
	update_spells()
	update_targets()
	match_mode()


func match_mode():
	$targets.visible = true
	match mode:
		0:
			$caster.visible = true
			$spells.visible = true
		1:
			$caster.visible = false
			$spells.visible = true
			if selected_person == null:
				hide()
		2:
			$caster.visible = false
			$spells.visible = false
			if selected_spell == null:
				input_handler.emit_signal("SpellUsed")
				hide()


func update_casters():
	input_handler.ClearContainer(caser_container)
	for ch_id in ResourceScripts.game_party.character_order:
		var tchar = characters_pool.get_char_by_id(ch_id)
		if tchar.is_on_quest():
			continue
		if tchar.get_social_skills().empty():
			continue
		var newbutton = input_handler.DuplicateContainerTemplate(caser_container)
		newbutton.set_meta('person', ch_id)
		if selected_person != null:
			newbutton.pressed = (ch_id == selected_person)
		newbutton.get_node('icon').texture = tchar.get_icon()
		newbutton.get_node('name').text = tchar.get_full_name()
		newbutton.connect('pressed', self, 'select_caster', [ch_id])
		globals.connectslavetooltip(newbutton, tchar)


func select_caster(t_id):
	if t_id != selected_person:
		selected_person = t_id
		selected_spell = null
		update_casters()
		update_spells()
		update_targets()


func update_spells():
	if selected_person == null:
		selected_spell = null
		$spells/SpellContainer.visible = false
		return
	else:
		$spells/SpellContainer.visible = true
	var caster = characters_pool.get_char_by_id(selected_person)
	input_handler.ClearContainer(spells_container)
	for sp_id in caster.get_social_skills():
		var panel = input_handler.DuplicateContainerTemplate(spells_container)
		var s_data = Skilldata.get_template(sp_id, caster)
		if sp_id == selected_spell:
			panel.pressed = true
		panel.connect('pressed', self, 'select_spell', [sp_id])
		panel.get_node('name').text = tr(s_data.name)
		if s_data.icon is String:
			panel.get_node('icon').texture = load(s_data.icon)
		else:
			panel.get_node('icon').texture = s_data.icon
		globals.connectskilltooltip(panel, sp_id, caster)
		if s_data.cost.has('mp'):
			panel.get_node('cost').text = str(s_data.cost.mp)
		else:
			panel.get_node('cost').text = '0'
		var charges = Skilldata.get_charges(s_data, caster)
		var used_charges = 0
		if caster.skills.social_skills_charges.has(sp_id):
			used_charges = caster.skills.social_skills_charges[sp_id]
		panel.get_node('charges').text = str(charges - used_charges) + "/" + str(charges)
		if !caster.check_cost(s_data.cost):
			panel.disabled = true
		if (caster.checkreqs(s_data.reqs) == false) or (caster.has_status('no_social_skills') and caster.skills.active_panel == variables.PANEL_SOC) or caster.get_work() == 'disabled':
			panel.disabled = true
		if charges - used_charges <= 0:
			panel.disabled = true
			if caster.skills.social_cooldowns.has(sp_id):
				panel.get_node('cd2').visible = true
				panel.get_node('cdicon').visible = true
				panel.get_node('cd2').text = str(caster.skills.social_cooldowns[sp_id])
			if caster.skills.daily_cooldowns.has(sp_id):
				panel.get_node('cd2').visible = true
				panel.get_node('cdicon').visible = true
				panel.get_node('cd2').text = str(caster.skills.daily_cooldowns[sp_id])


func select_spell(s_id):
	if s_id != selected_spell:
		selected_spell = s_id
		update_spells()
		update_targets()


func update_targets():
	if selected_person == null or selected_spell == null:
		$targets/TargetContainer.visible = false
		return
	else:
		$targets/TargetContainer.visible = true
	var caster = characters_pool.get_char_by_id(selected_person)
	var spell = Skilldata.get_template(selected_spell, caster)
	if spell.tags.has('no_target'):
		caster.use_social_skill(selected_spell, caster)
		reset_spell()
		return
	input_handler.ClearContainer(target_container, ['Button', 'no_targets'])
	no_targets.visible = true
	for ch_id in ResourceScripts.game_party.character_order:
		var tchar = characters_pool.get_char_by_id(ch_id)
		if tchar.is_on_quest():
			continue
		if !caster.same_location_with(tchar):
			continue
		if !tchar.checkreqs(spell.targetreqs):
			continue
		no_targets.visible = false
		var newbutton = input_handler.DuplicateContainerTemplate(target_container, 'Button')
		newbutton.get_node('icon').texture = tchar.get_icon()
		newbutton.get_node('name').text = tchar.get_short_name()
		if spell.tags.has('can_miss'):
			var chance = spell.chance
			if chance is Array or chance is Dictionary:
				chance = input_handler.calculate_number_from_string_array(chance, caster, tchar)
			var evade = spell.evade
			if evade is Array or evade is Dictionary:
				evade = input_handler.calculate_number_from_string_array(evade, caster, tchar)
			var res_chance = max(chance - evade, 5)
			newbutton.get_node('info').text = str(res_chance) + '%'
		globals.connectslavetooltip(newbutton, tchar)
		newbutton.connect('pressed', self, 'select_target', [ch_id])


func select_target(ch_id):
	var caster = characters_pool.get_char_by_id(selected_person)
	var target = characters_pool.get_char_by_id(ch_id)
	var spell = Skilldata.get_template(selected_spell, caster)
	caster.use_social_skill(selected_spell, target)
	reset_spell()


func reset_spell():
	selected_spell = null
	update()


func hide():
	if gui_controller.current_screen == gui_controller.spells:
		gui_controller.current_screen = gui_controller.previous_screen
	.hide()
