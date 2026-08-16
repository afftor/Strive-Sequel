extends Panel
#warning-ignore-all:return_value_discarded


var category = 'all'
var person
var current_class
var selected_mastery = 'warfare'

var mastery_category = "combat"

var active_tab = "classes"
var popup_owner

func _ready():
	for i in $categories.get_children():
		i.connect("pressed",self,'class_category', [i.name])
	for i in $MasteryPanel/Categories.get_children():
		i.connect("pressed", self, 'change_mastery_category', [i.name])
	$ClassPanel/HBoxContainer2/Unlock.connect('pressed', self, 'unlock_class')
	$ClassPanel/HBoxContainer2/Close.connect('pressed', self, 'close_class_panel')
	for ch in $categories.get_children():
		globals.connecttexttooltip(ch, tr("CAT_" + str(ch.name).to_upper() + "_DESC"))
	$CheckBox.connect("pressed", self, "checkbox_locked")
	$MasteryPanel/AddPoint.connect("pressed", self, 'add_mastery_prompt')
	$MasteryPanel/AddPoint2.connect("pressed", self, 'add_mastery_prompt_1')
	$MasteryPanel/SkillBookButton.connect("pressed", self, "SkillBookButtonPress")
	
	input_handler.register_btn_source('class_fighter', self, 'tut_get_class_fighter')
	input_handler.register_btn_source('class_unlock', self, 'tut_get_unlock')
	input_handler.register_btn_source('mastery_leadership', self, 'tut_get_leadership')
	input_handler.register_btn_source('mastery_add_point', self, 'tut_get_AddPoint')
	input_handler.register_btn_source('mastery_add_point2', self, 'tut_get_AddPoint2')
	input_handler.register_btn_source('mastery_add_point_highlight', self, null, self, "tut_get_AddPoint_highlight")

func tut_get_class_fighter():
	for btn in $ScrollContainer/GridContainer.get_children():
		if btn.get_meta('class_code', '') == 'fighter':
			return btn

func tut_get_unlock():
	return $ClassPanel/HBoxContainer2/Unlock

func tut_get_leadership():
	for btn in $MasteryPanel/Categories2.get_children():
		if btn.get_meta('mastery', '') == 'leadership':
			return btn

func tut_get_AddPoint():
	return $MasteryPanel/AddPoint
func tut_get_AddPoint_highlight():
	var res_rect = tut_get_AddPoint().get_global_rect()
	res_rect.end = tut_get_AddPoint2().get_global_rect().end
	return res_rect
func tut_get_AddPoint2():
	return $MasteryPanel/AddPoint2

func SkillBookButtonPress():
	if popup_owner != null and popup_owner.has_method("open_skill_loadout"):
		popup_owner.open_skill_loadout(person)


func close_tooltip():
	globals.closeclasstooltip()


func open(tempperson):
	person = tempperson
	current_class = null
	update()


func reset_popup_state():
	current_class = null
	category = "all"
	mastery_category = "combat"
	selected_mastery = "warfare"
	active_tab = "classes"
	$ClassPanel.hide()
	$MasteryPanel.hide()
	for button in $categories.get_children():
		button.pressed = button.name == category
	for button in $MasteryPanel/Categories.get_children():
		button.pressed = button.name == mastery_category
	reset_popup_scrolls()
	_apply_active_tab()


func reset_popup_scrolls():
	$ScrollContainer.scroll_vertical = 0
	$ClassPanel/scroll.scroll_vertical = 0
	$MasteryPanel/mastery/RowsViewport/VBoxContainer.rect_position.y = 0


func set_popup_owner(owner):
	popup_owner = owner
	_apply_active_tab()


func set_active_tab(tab):
	active_tab = tab
	_apply_active_tab()


func _apply_active_tab():
	var show_classes = active_tab == "classes"
	var show_class_browser = show_classes and !$ClassPanel.visible
	for node_name in ["Background", "categories", "ScrollContainer", "Label", "CheckBox"]:
		var node = get_node_or_null(node_name)
		if node != null:
			node.visible = show_class_browser
	if !show_classes:
		$ClassPanel.hide()
	$MasteryPanel.visible = !show_classes


func update():
	if person == null:
		 return
	$ClassPanel.hide()
	change_mastery_category(mastery_category)
	input_handler.ClearContainer($ScrollContainer/GridContainer)
	var array = []
	for i in classesdata.professions.values():
		if !ResourceScripts.game_globals.unlock_all_classes:
			if (!i.categories.has(category) && category != 'all') || !person.checkreqs(i.showupreqs, true) || person.has_profession(i.code):
				continue
			if !$CheckBox.pressed && person.checkreqs(i.reqs, true) == false:
				continue
		array.append(i)
	
	array.sort_custom(self, 'sort_by_name')
	
	for i in array:
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/GridContainer)
		newbutton.get_node('icon').texture = i.icon
		var name = i.name
		if !ResourceScripts.game_globals.unlock_all_classes:
			if i.has('altname') && person.checkreqs(i.altnamereqs):
				name = i.altname
			var f = person.checkreqs(i.reqs, true)
			for prof in i.conflict_classes:
				f = f and !person.has_profession(prof)
			if  f == false:
				newbutton.texture_normal = load("res://assets/images/gui/universal/skill_frame_diabled.png")
				newbutton.texture_hover = load("res://assets/images/gui/universal/skill_frame_diabled.png")
				newbutton.texture_pressed = load("res://assets/images/gui/universal/skill_frame_diabled.png")
		newbutton.get_node('name').text = tr(name)
		newbutton.connect('pressed',self,"open_class", [i.code])
		newbutton.set_meta('class_code', i.code)
		globals.connectclasstooltip(newbutton, person, i.code)
		newbutton.connect('mouse_exited', self, 'close_tooltip')
	_apply_active_tab()
	_update_popup_footer()

func checkbox_locked():
	update()


func class_category(name):
	category = name
	set_active_tab("classes")
	for i in $categories.get_children():
		i.pressed = i.name == category
	update()


func sort_by_name(first,second):
	return first.name < second.name


func open_class(classcode):
	var tempclass = classesdata.professions[classcode]
	var class_locked = true
	if !ResourceScripts.game_globals.unlock_all_classes:
		class_locked = !person.checkreqs(tempclass.reqs, true)
	else:
		class_locked = false
	current_class = classcode
	set_active_tab("classes")
	$ClassPanel/scroll._open_panel(person, classcode)
	if person.has_profession(tempclass.code):
		$ClassPanel/HBoxContainer2/Unlock.hide()
	else:
		$ClassPanel/HBoxContainer2/Unlock.show()
	$ClassPanel/HBoxContainer2/Unlock.disabled = class_locked || (person.get_stat('base_exp') < person.get_next_class_exp())
	update_class_buttons(classcode)
	$ClassPanel.visible = true
	$MasteryPanel.hide()
	_apply_active_tab()


func close_class_panel():
	current_class = null
	$ClassPanel.hide()
	$ClassPanel/scroll.scroll_vertical = 0
	update_class_buttons("")
	_apply_active_tab()


func update_class_buttons(classcode):
	for button in $ScrollContainer/GridContainer.get_children():
		if button == $ScrollContainer/GridContainer.get_child($ScrollContainer/GridContainer.get_children().size()-1):
			continue
		button.pressed = (button.get_meta("class_code") == classcode)


func unlock_class():
	var args = {}
	args["current_class"] = current_class
	args["person"] = person
	input_handler.play_animation("class_aquired", args)
	$ClassPanel.hide()
	$MasteryPanel.show()
	gui_controller.windows_opened.clear()
	#the popup itself stays open behind the animation - keep it on the window stack, or
	#RMB/ESC would no longer close it
	_restore_popup_window()
	yield(get_tree().create_timer(0.2),"timeout")
	person.add_stat('base_exp', -person.get_next_class_exp())
	person.unlock_class(current_class)
	yield(get_tree().create_timer(0.2),"timeout")
	globals.text_log_add("char", person.translate(tr("CLASSNEWACQUIREDLOG") % tr(classesdata.professions[current_class].name)))
	update()

func change_mastery_category(cat):
	mastery_category = cat
	for i in $MasteryPanel/Categories.get_children():
		i.pressed = i.name == cat
	build_mastery_cat()


func get_mastery_pools(masdata):
	match masdata.type:
		'combat':
			return ['combat', 'universal']
		'spell':
			return ['magic', 'universal']
	return ['universal']


func get_invested_mastery_points(mas, pools):
	var invested_points = 0
	for pool in pools:
		invested_points += person.dyn_stats.masteries[mas][pool].size()
	return invested_points




func get_bonus_mastery_points(mas, invested_points):
	var mastery_level = int(person.get_stat('mastery_' + mas))
	return max(mastery_level - invested_points, 0)


func get_total_mastery_points(mas, invested_points):
	return invested_points + get_bonus_mastery_points(mas, invested_points)

func build_passive_mastery_bonus_tooltip(bonusstats, mul = 1):
	var lines = globals.build_desc_for_bonusstats(bonusstats, mul).strip_edges().split("\n")
	var result = []
	for line in lines:
		line = line.strip_edges()
		if line != "":
			result.append(line)
	return PoolStringArray(result).join("\n")

func build_mastery_cat():
	input_handler.ClearContainer($MasteryPanel/Categories2, ['button'])
	var tmp = null
	var change_mastery = false
	var lv_sum = {combat = 0, spell = 0}
	for mas in Skilldata.masteries:
		var masdata = Skilldata.masteries[mas]
		var text = ""
		var lv = person.get_stat('mastery_' + mas)
		lv_sum[masdata.type] += lv
		if masdata.type == mastery_category:
			if tmp == null:
				tmp = mas
			var button = input_handler.DuplicateContainerTemplate($MasteryPanel/Categories2, 'button')
			button.set_meta('mastery', mas)
			button.connect('pressed', self, 'change_mastery', [mas])
			button.get_node('icon').texture = images.get_icon(masdata.icon)
			button.get_node('icon/Label').text = str(lv)
			text += "[center]"+tr("MASTERY"+mas.to_upper()) + "[/center]\n"+tr("LVLBONUSPERPOINT")+":\n"
			text += build_passive_mastery_bonus_tooltip(masdata.passive) + '\n'
			if lv > 0:
				text += "[center]"+tr("LVLCURRENT")+":[/center]\n"
				text += build_passive_mastery_bonus_tooltip(masdata.passive, lv) + '\n'
			#add mastery tooltip
			var mastery_points_pools = get_mastery_pools(masdata)
			var invested_points = get_invested_mastery_points(mas, mastery_points_pools)
			var total_points = get_total_mastery_points(mas, invested_points)
			text += ("[center]"
				+
				tr("LVLTOTALPOINTS") + ": {color=yellow|%d}; " % [total_points]
				+
				tr("LVLINVESTED") + ": %d/%d" % [invested_points, variables.mastery_train_limit]
				+
				"[/center]\n\n"
				)
			globals.connecttexttooltip(button, text)
		else:
			if mas == selected_mastery:
				change_mastery = true
			continue
	if change_mastery:
		selected_mastery = tmp
	change_mastery(selected_mastery)
	for i in $MasteryPanel/Categories.get_children():
		i.get_node('Label').text = str(lv_sum[i.name])


var text
var text_1
func change_mastery(mas):
	selected_mastery = mas
	for node in $MasteryPanel/Categories2.get_children():
		if node.has_meta('mastery'):
			var cmastery = node.get_meta('mastery')
			node.pressed = (cmastery == selected_mastery)
	input_handler.ClearContainer($MasteryPanel/mastery/RowsViewport/VBoxContainer, ['HSeparator', 'container'])
	var masdata = Skilldata.masteries[mas]
	$MasteryPanel/mastery/Label.text = tr(masdata.name)
	$MasteryPanel/mastery/TextureRect.texture = images.get_background(masdata.background, true)
	match masdata.type:
		'combat':
			$MasteryPanel/AddPoint/TextureRect.texture = images.get_icon('mastery_point_combat')
		'spell':
			$MasteryPanel/AddPoint/TextureRect.texture = images.get_icon('mastery_point_magic')
	var lv = person.get_stat('mastery_' + mas)
	text = tr('ADD_MASTERY_CONFIRM')
	text_1 = tr("ADD_MASTERY_CONFIRM_UNIVERSAL")
	for lv_tmp in range(1, masdata.maxlevel + 1):
		if lv_tmp > 1:
			input_handler.DuplicateContainerTemplate($MasteryPanel/mastery/RowsViewport/VBoxContainer, 'HSeparator')
		var panel = input_handler.DuplicateContainerTemplate($MasteryPanel/mastery/RowsViewport/VBoxContainer, 'container')
		panel.get_node('frame/lvl').text = input_handler.roman_number_converter(lv_tmp)
		if lv_tmp > lv:
			panel.modulate = Color(0.3, 0.3, 0.3, 0.72)
			panel.get_node('frame/lvl').self_modulate = Color(1.0, 1.0, 1.0, 0.8)
			panel.get_node('frame').self_modulate = Color(1.0, 1.0, 1.0, 0.0)
		else:
			panel.modulate = Color.white
			panel.get_node('frame/lvl').self_modulate = Color.white
		var key = 'level%d' % lv_tmp
		if !masdata.has(key):
			continue
		var lvdata = masdata[key]
		for s_id in lvdata.combat_skills:
			var sdata = Skilldata.get_template(s_id, person)
			var skill_icon = input_handler.DuplicateContainerTemplate(panel.get_node('container'), 'skill')
			skill_icon.get_node('icon').material = load("res://assets/masked_sprite.tres").duplicate(true)
			if lv_tmp <= lv:
				skill_icon.texture = images.get_icon('frame_skill_1')
			else:
				skill_icon.texture = images.get_icon('frame_skill')
			skill_icon.get_node('icon').texture = sdata.icon
			skill_icon.get_node('icon').material.set_shader_param('mask', images.get_icon('frame_skill_mask'))
			skill_icon.set_meta('display_only', true)
			if sdata.has('container'):
				globals.connecttexttooltip(skill_icon, tr(sdata.descript))
			else:
				globals.connectskilltooltip(skill_icon, s_id, person)
		for s_id in lvdata.explore_skills:
			var sdata = Skilldata.get_template(s_id, person)
			var skill_icon = input_handler.DuplicateContainerTemplate(panel.get_node('container'), 'skill')
			skill_icon.get_node('icon').material = load("res://assets/masked_sprite.tres").duplicate(true)
			if lv_tmp <= lv:
				skill_icon.texture = images.get_icon('frame_explore_1')
			else:
				skill_icon.texture = images.get_icon('frame_explore')
			skill_icon.get_node('icon').texture = sdata.icon
			skill_icon.get_node('icon').material.set_shader_param('mask', images.get_icon('frame_explore_mask'))
			skill_icon.set_meta('display_only', true)
			globals.connectskilltooltip(skill_icon, s_id, person)
		for tr_id in lvdata.traits:
			var trdata = Traitdata.traits[tr_id]
			var skill_icon = input_handler.DuplicateContainerTemplate(panel.get_node('container'), 'skill')
			skill_icon.get_node('icon').material = load("res://assets/masked_sprite.tres").duplicate(true)
			var frame_id = 'frame_trait'
			var frame_mask_id = 'frame_trait_mask'
			if trdata.has('tags') and trdata.tags.has('sex_action_unlock'):
				frame_id = 'frame_sex_skill'
				frame_mask_id = 'frame_sex_skill_mask'
			if lv_tmp <= lv:
				skill_icon.texture = images.get_icon(frame_id + '_1')
			else:
				skill_icon.texture = images.get_icon(frame_id)
			if trdata.icon is String:
				skill_icon.get_node('icon').texture = load(trdata.icon)
			else:
				skill_icon.get_node('icon').texture = trdata.icon
			skill_icon.get_node('icon').material.set_shader_param('mask', images.get_icon(frame_mask_id))
			globals.connecttexttooltip(skill_icon, tr(trdata.descript))
		for s_id in lvdata.action:
			var sdata = Skilldata.training_actions[s_id]
			var skill_icon = input_handler.DuplicateContainerTemplate(panel.get_node('container'), 'skill')
			skill_icon.get_node('icon').material = load("res://assets/masked_sprite.tres").duplicate(true)
			if lv_tmp <= lv:
				skill_icon.texture = images.get_icon('frame_train_1')
			else:
				skill_icon.texture = images.get_icon('frame_train')
			skill_icon.get_node('icon').texture = load(sdata.icon)
			skill_icon.get_node('icon').material.set_shader_param('mask', images.get_icon('frame_train_mask'))
			globals.connecttexttooltip(skill_icon, '[center]' + tr(sdata.name) + '[/center]\n' + tr(sdata.descript_mastery))
	_fit_mastery_rows()
	var en_data = person.get_stat_value_data('mastery_%s_enable' % mas)
	if en_data.result:
		$MasteryPanel/blocked.visible = false
	else:
		$MasteryPanel/blocked.visible = true
		var src
		var src_val
		for rec in en_data.bonuses.set:
			if !rec.value:
				src = rec.src_type
				src_val = rec.src_value
				break
		$MasteryPanel/blocked/Label.text = tr('MASTERYBLOCKSRC') % globals.get_tr_src(src, src_val)
	
	$MasteryPanel/AddPoint.disabled = !person.can_upgrade_mastery(mas)
	$MasteryPanel/AddPoint2.disabled = !person.can_upgrade_mastery(mas, true)
	

func _fit_mastery_rows():
	var viewport = $MasteryPanel/mastery/RowsViewport
	var list = viewport.get_node("VBoxContainer")
	list.set("custom_constants/separation", 0)
	var rows = []
	var separators = []
	for child in list.get_children():
		if !child.visible:
			continue
		if child.has_node("frame") and child.has_node("container"):
			rows.append(child)
		elif child is HSeparator:
			separators.append(child)
	if rows.empty():
		return
	var separator_height = 4
	for separator in separators:
		separator.rect_min_size.y = separator_height
	var available_height = viewport.rect_size.y
	if available_height <= 0:
		available_height = $MasteryPanel/mastery.rect_size.y - viewport.margin_top + viewport.margin_bottom
	var available_row_space = int(available_height) - separators.size() * separator_height
	var row_space = max(available_row_space, rows.size())
	var base_height = int(floor(float(row_space) / rows.size()))
	var remainder = row_space - base_height * rows.size()
	for index in range(rows.size()):
		var row_height = base_height + (1 if index < remainder else 0)
		_set_mastery_row_height(rows[index], row_height)
	list.rect_position.y = 0


func _set_mastery_row_height(row, row_height):
	row.rect_min_size.y = row_height
	var content_height = 68
	var top = floor((row_height - content_height) * 0.5)
	var frame = row.get_node("frame")
	frame.margin_top = top
	frame.margin_bottom = top + content_height
	var content = row.get_node("container")
	content.margin_top = top
	content.margin_bottom = top + content_height

func add_mastery_prompt():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'add_mastery', text])


func add_mastery():
	person.upgrade_mastery(selected_mastery)
	build_mastery_cat()
	var args = {}
	args["mastery"] = selected_mastery
	args["person"] = person
	input_handler.play_animation("mastery_aquired", args)
	_update_popup_footer()


func add_mastery_prompt_1():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'add_mastery_1', text_1])


func add_mastery_1():
	person.upgrade_mastery(selected_mastery, true)
	build_mastery_cat()
	var args = {}
	args["mastery"] = selected_mastery
	args["person"] = person
	input_handler.play_animation("mastery_aquired", args)
	_update_popup_footer()


func _restore_popup_window():
	if popup_owner == null or !is_instance_valid(popup_owner) or !popup_owner.visible:
		return
	if !gui_controller.windows_opened.has(popup_owner):
		gui_controller.windows_opened.append(popup_owner)


func _update_popup_footer():
	if popup_owner != null and popup_owner.has_method("update_footer"):
		popup_owner.update_footer()
