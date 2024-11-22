extends Panel
#warning-ignore-all:return_value_discarded


var category = 'all'
var person
var mode
var current_class
var selected_mastery = 'warfare'

var mastery_category = "combat"
# all, weapon, magic, support, aoe, heal

var parentnode
var shutoff = false
var prevnode

var character = Reference

var Panel_x = 598
var Text_x = 565

func _ready():
	for i in $categories.get_children():
		i.connect("pressed",self,'class_category', [i.name])
	for i in $MasteryPanel/Categories.get_children():
		i.connect("pressed", self, 'change_mastery_category', [i.name])
	$ClassPanel/Unlock.connect('pressed', self, 'unlock_class')
	for ch in $categories.get_children():
		globals.connecttexttooltip(ch, tr("CAT_" + str(ch.name).to_upper() + "_DESC"))
#	$UpgradeButton.connect("pressed", $stats_upgrade, 'show')
	if !get_parent().name == "CheatsModule":
		$CheckBox.connect("pressed", self, "checkbox_locked")
	input_handler.AddPanelOpenCloseAnimation($ClassPanel)
	$MasteryPanel/AddPoint.connect("pressed", self, 'add_mastery_prompt')
	$MasteryPanel/AddPoint2.connect("pressed", self, 'add_mastery_prompt_1')
	$MasteryPanel/SkillBookButton.connect("pressed", self, "SkillBookButtonPress")
	for i in ['combat', 'magic', 'universal']:
		var st = 'mastery_point_' + i
		var stdata = statdata.statdata[st]
		globals.connecttexttooltip(get_node('MasteryPanel/Categories3/' + i), tr(stdata.name))


func SkillBookButtonPress():
	$SkillBook.activecharacter = person
	$SkillBook.toggle()


func _process(delta):
	if parentnode != null && ( parentnode.is_visible_in_tree() == false || !parentnode.get_global_rect().has_point(get_global_mouse_position())):
		set_process(false)
		hide()


func _init():
	set_process(false)


func show_tooltip(node, text):
	$Tooltip.show()
	$Tooltip/RichTextLabel.rect_size.y = 10
	$Tooltip/RichTextLabel.bbcode_text = globals.TextEncoder(text)
	
	if $Tooltip/RichTextLabel.bbcode_text.length() < 30:
		$Tooltip/RichTextLabel.rect_size.x = Text_x/2
		$Tooltip.rect_size.x = Panel_x/2
		$Tooltip/RichTextLabel.bbcode_text = '[center]'+$RichTextLabel.bbcode_text+'[/center]'
	else:
		$Tooltip/RichTextLabel.rect_size.x = Text_x
		$Tooltip.rect_size.x = Panel_x
	yield(get_tree(), 'idle_frame')
	# if !weakref(node).get_ref():
	# 	return
	$Tooltip.rect_size.y = $Tooltip/RichTextLabel.get_v_scroll().get_max() + 100
	$Tooltip/RichTextLabel.rect_size.y = $Tooltip.rect_size.y - 100


func close_tooltip():
	$Tooltip.hide()

func open(tempperson, tempmode = 'normal'):
	#if !gui_controller.windows_opened.has(self):
	#	gui_controller.windows_opened.append(self)
	#show()
	person = tempperson
	mode = tempmode
	current_class = null
	update()
#	$stats_upgrade.show()


func update():
	if person == null: return
	$ClassPanel.hide()
	$MasteryPanel.show()
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
				# newbutton.disabled = true
		newbutton.get_node('name').text = name
		newbutton.connect('pressed',self,"open_class", [i.code])
		newbutton.set_meta('class_code', i.code)
		newbutton.connect('mouse_entered', self, 'show_tooltip', [newbutton, ResourceScripts.descriptions.get_class_details(person, i, true, true)])
		newbutton.connect('mouse_exited', self, 'close_tooltip')
		# globals.connecttexttooltip(newbutton, ResourceScripts.descriptions.get_class_details(person, i, true, true))


func checkbox_locked():
	person = input_handler.interacted_character
#	open(person, mode)
	update()


func class_category(name):
	person = gui_controller.mansion.active_person if person == null else input_handler.interacted_character
	category = name
	$ClassPanel.hide()
	$MasteryPanel.show()
	for i in $categories.get_children():
		i.pressed = i.name == category
	update()
#	open(person, mode)


func sort_by_name(first,second):
#	return first.name <= second.name
	return first.name < second.name


func open_class(classcode):
	#if !gui_controller.windows_opened.has($ClassPanel):
	#	gui_controller.windows_opened.append($ClassPanel)
	var tempclass = classesdata.professions[classcode]
	var class_locked = true
	if !ResourceScripts.game_globals.unlock_all_classes:
		class_locked = !person.checkreqs(tempclass.reqs, true)
	else:
		class_locked = false
	var text = ResourceScripts.descriptions.get_class_details(person, tempclass)
	current_class = classcode
	$ClassPanel.open(classcode,person)
	if person.has_profession(tempclass.code):
		text = person.translate('[name] has already acquired this class.')
		$ClassPanel/Unlock.hide()
		$ClassPanel/ExpLabel.set("custom_colors/font_color", Color(1,1,1))
	else:
		text = tr("EXPREQUIRED")+": " + str(person.get_next_class_exp()) + "/" +  str(floor(person.get_stat('base_exp'))) 
		$ClassPanel/Unlock.show()
		if person.get_stat('base_exp') < person.get_next_class_exp():
			$ClassPanel/ExpLabel.set("custom_colors/font_color", variables.hexcolordict.red)
		else:
			$ClassPanel/ExpLabel.set("custom_colors/font_color", variables.hexcolordict.green)
	$ClassPanel/Unlock.disabled = class_locked || (person.get_stat('base_exp') < person.get_next_class_exp())
	
	$ClassPanel/ExpLabel.text = text
	update_class_buttons(classcode)
	$ClassPanel.show()
	$MasteryPanel.hide()


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
	yield(get_tree().create_timer(0.2),"timeout")
	person.add_stat('base_exp', -person.get_next_class_exp())
	person.unlock_class(current_class)
	yield(get_tree().create_timer(0.2),"timeout")
	globals.text_log_add("class", person.translate("[name] has acquired new Class: " + classesdata.professions[current_class].name))
	get_parent().BodyModule.update()
	get_parent().set_state("default")


#masteries
func change_mastery_category(cat):
	mastery_category = cat
	for i in $MasteryPanel/Categories.get_children():
		i.pressed = i.name == cat
	build_mastery_cat()


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
			globals.connecttexttooltip(button, masdata.name)
			#add mastery tooltip
			text += tr(mas) + '\n'
#			text += tr(masdata.descript) + '\n'
			text += globals.build_desc_for_bonusstats(masdata.passive) + '\n'
			text += tr('CURRENTLVL') + str(lv)
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
#			node.get_node('icon/Label').text = str(person.get_stat('mastery_' + cmastery))
	input_handler.ClearContainer($MasteryPanel/mastery/ScrollContainer/VBoxContainer, ['HSeparator', 'container'])
	var masdata = Skilldata.masteries[mas]
	$MasteryPanel/mastery/Label.text = masdata.name
	$MasteryPanel/mastery.texture = images.get_background(masdata.background, true)
	match masdata.type:
		'combat':
			$MasteryPanel/AddPoint/TextureRect.texture = images.get_icon('mastery_point_combat')
		'spell':
			$MasteryPanel/AddPoint/TextureRect.texture = images.get_icon('mastery_point_magic')
	var lv = person.get_stat('mastery_' + mas)
	var lv_pas = person.xp_module.get_mastery_level(mas, true)
	text = tr('ADD_MASTERY_CONFIRM') + '\n'
	text += globals.build_desc_for_bonusstats(masdata.passive)
	for lv_tmp in range(1, masdata.maxlevel + 1):
		if lv_tmp > 1:
			input_handler.DuplicateContainerTemplate($MasteryPanel/mastery/ScrollContainer/VBoxContainer, 'HSeparator')
		var panel = input_handler.DuplicateContainerTemplate($MasteryPanel/mastery/ScrollContainer/VBoxContainer, 'container')
		panel.get_node('frame/lvl').text = input_handler.roman_number_converter(lv_tmp)
		if lv_tmp > lv:
			panel.get_node('frame/lvl').self_modulate = Color(1.0, 1.0, 1.0, 0.5)
			panel.get_node('frame').self_modulate = Color(1.0, 1.0, 1.0, 0.0)
		var key = 'level%d' % lv_tmp
		if !masdata.has(key):
			continue
		var lvdata = masdata[key]
		var f = false
		if lv_tmp == lv + 1:
			f = true
		for s_id in lvdata.combat_skills:
			var sdata = Skilldata.get_template(s_id, person)
			var skill_icon = input_handler.DuplicateContainerTemplate(panel.get_node('container'), 'skill')
			skill_icon.get_node('icon').material = load("res://assets/masked_sprite.tres").duplicate(true)
			if lv_tmp <= lv_pas:
				skill_icon.texture = images.get_icon('frame_skill_1')
			else:
				skill_icon.texture = images.get_icon('frame_skill')
#			skill_icon.texture = images.get_icon('frame_skill')
			skill_icon.get_node('icon').texture = sdata.icon
			skill_icon.get_node('icon').material.set_shader_param('mask', images.get_icon('frame_skill_mask'))
			skill_icon.set_meta('display_only', true)
			globals.connectskilltooltip(skill_icon, s_id, person)
			if f:
				text += tr('SKILLLEARN') + tr(sdata.name) + '\n'
		for s_id in lvdata.explore_skills:
			var sdata = Skilldata.get_template(s_id, person)
			var skill_icon = input_handler.DuplicateContainerTemplate(panel.get_node('container'), 'skill')
			skill_icon.get_node('icon').material = load("res://assets/masked_sprite.tres").duplicate(true)
			if lv_tmp <= lv_pas:
				skill_icon.texture = images.get_icon('frame_explore_1')
			else:
				skill_icon.texture = images.get_icon('frame_explore')
#			skill_icon.texture = images.get_icon('frame_explore')
			skill_icon.get_node('icon').texture = sdata.icon
			skill_icon.get_node('icon').material.set_shader_param('mask', images.get_icon('frame_explore_mask'))
			skill_icon.set_meta('display_only', true)
			globals.connectskilltooltip(skill_icon, s_id, person)
			if f:
				text += tr('SKILLLEARN') + tr(sdata.name) + '\n'
		for tr_id in lvdata.traits:
			var trdata = Traitdata.traits[tr_id]
			var skill_icon = input_handler.DuplicateContainerTemplate(panel.get_node('container'), 'skill')
			skill_icon.get_node('icon').material = load("res://assets/masked_sprite.tres").duplicate(true)
			if lv_tmp <= lv_pas:
				skill_icon.texture = images.get_icon('frame_trait_1')
			else:
				skill_icon.texture = images.get_icon('frame_trait')
#			skill_icon.texture = images.get_icon('frame_trait')
			skill_icon.get_node('icon').texture = trdata.icon
			skill_icon.get_node('icon').material.set_shader_param('mask', images.get_icon('frame_trait_mask'))
			globals.connecttexttooltip(skill_icon, trdata.descript)
			if f:
				text += tr('TRAITLEARN') + tr(trdata.name) + '\n'
		for s_id in lvdata.action:
			var sdata = Skilldata.training_actions[s_id]
			var skill_icon = input_handler.DuplicateContainerTemplate(panel.get_node('container'), 'skill')
			skill_icon.get_node('icon').material = load("res://assets/masked_sprite.tres").duplicate(true)
			if lv_tmp <= lv_pas:
				skill_icon.texture = images.get_icon('frame_train_1')
			else:
				skill_icon.texture = images.get_icon('frame_train')
#			skill_icon.texture = images.get_icon('frame_train')
			skill_icon.get_node('icon').texture = load(sdata.icon)
			skill_icon.get_node('icon').material.set_shader_param('mask', images.get_icon('frame_train_mask'))
			globals.connecttexttooltip(skill_icon, '[center]' + tr(sdata.name) + '[/center]\n' + tr(sdata.descript_mastery))
			if f:
				text += tr('TRAININGLEARN') + tr(sdata.name) + '\n'
	$MasteryPanel/AddPoint.disabled = !person.can_upgrade_mastery(mas)
	$MasteryPanel/AddPoint2.disabled = !person.can_upgrade_mastery(mas, true)
	$MasteryPanel/Categories3/combat/Label.text = "%d Points" % person.get_stat('mastery_point_combat')
	$MasteryPanel/Categories3/magic/Label.text = "%d Points" % person.get_stat('mastery_point_magic')
	$MasteryPanel/Categories3/universal/Label.text = "%d Points" % person.get_stat('mastery_point_universal')
	
	text += tr('FOR')
	text_1 = text
	var cost = person.upgrade_mastery_cost(mas) 
	for point in cost:
		var stdata = statdata.statdata[point]
		if cost[point] > 0:
			text += "%s : %d \n" % [tr(stdata.name), cost[point]]
	cost = person.upgrade_mastery_cost(mas, true) 
	for point in cost:
		var stdata = statdata.statdata[point]
		if cost[point] > 0:
			text_1 += "%s : %d \n" % [tr(stdata.name), cost[point]]


func add_mastery_prompt():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'add_mastery', text])


func add_mastery():
	person.upgrade_mastery(selected_mastery)
	build_mastery_cat()
#	change_mastery(selected_mastery)


func add_mastery_prompt_1():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'add_mastery_1', text_1])


func add_mastery_1():
	person.upgrade_mastery(selected_mastery, true)
	build_mastery_cat()


# func play_animation():
# 	input_handler.PlaySound("class_aquired")
# 	var anim_scene
# 	anim_scene = input_handler.get_spec_node(input_handler.ANIM_CLASS_ACHIEVED)
# 	anim_scene.get_node("AnimationPlayer").play("class_achieved")
# 	anim_scene.get_node("TextureRect").texture = classesdata.professions[current_class].icon
# 	anim_scene.get_node("Label2").text = current_class.capitalize()
# 	anim_scene.get_node("Label3").text = person.get_full_name()
# 	yield(anim_scene.get_node("AnimationPlayer"), "animation_finished")
# 	ResourceScripts.core_animations.FadeAnimation(anim_scene, 0.5)
# 	yield(get_tree().create_timer(0.5), 'timeout')
# 	anim_scene.queue_free()
# 	input_handler.SetMusic("mansion1")


