extends Panel
#warning-ignore-all:return_value_discarded


var category = 'all'
var person
var mode
var current_class
var selected_skill

var skill_category = "all"
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
	for i in $SkillPanel/Categories.get_children():
		i.connect("pressed", self, 'change_skill_category', [i.name])
	$SkillTooltip/cancel_button.connect("pressed", self, "hide_skilltooltip")
	$SkillTooltip/unlock_button.connect("pressed", self, "buy_skill")
	$SkillTooltip.connect("hide", self, "build_skills")
	$ClassPanel/Unlock.connect('pressed', self, 'unlock_class')
	$UpgradeButton.connect("pressed", $stats_upgrade, 'show')
	if !get_parent().name == "CheatsModule":
		$CheckBox.connect("pressed", self, "checkbox_locked")
	input_handler.AddPanelOpenCloseAnimation($ClassPanel)
	globals.connecttexttooltip($SkillPanel/Categories/all, "All")
	globals.connecttexttooltip($SkillPanel/Categories/combat, "Combat")
	globals.connecttexttooltip($SkillPanel/Categories/spell, "Spell")
	globals.connecttexttooltip($SkillPanel/Categories/support, "Support")
	globals.connecttexttooltip($SkillPanel/Categories/aoe, "AoE")
	globals.connecttexttooltip($SkillPanel/Categories/heal, "Heal")
	globals.connecttexttooltip($SkillTooltip/icon_cooldown, "Cooldown")
	globals.connecttexttooltip($SkillTooltip/icon_usage, "Manacost")
	globals.connecttexttooltip($categories/all, "All")
	globals.connecttexttooltip($categories/social, "Social")
	globals.connecttexttooltip($categories/labor, "Labor")
	globals.connecttexttooltip($categories/sexual, "Sexual")
	globals.connecttexttooltip($categories/combat, "Combat")
	globals.connecttexttooltip($categories/magic, "Magic")
	globals.connecttexttooltip($SkillPanel/skillpoints_label, tr('TOOLTIPSKILLPOINTS'))

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
	$SkillPanel.show()
	input_handler.ClearContainer($ScrollContainer/GridContainer)
	$SkillTooltip.hide()
	build_skills()
	var array = []
	for i in classesdata.professions.values():
		if !ResourceScripts.game_progress.unlock_all_classes:
			if (!i.categories.has(category) && category != 'all') || !person.checkreqs(i.showupreqs) || person.has_profession(i.code):
				continue
			if !$CheckBox.pressed && person.checkreqs(i.reqs) == false:
				continue
		array.append(i)
	
	array.sort_custom(self, 'sort_by_name')
	
	for i in array:
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/GridContainer)
		newbutton.get_node('icon').texture = i.icon
		var name = i.name
		if !ResourceScripts.game_progress.unlock_all_classes:
			if i.has('altname') && person.checkreqs(i.altnamereqs):
				name = i.altname
			if person.checkreqs(i.reqs) == false:
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
	build_skills()

func class_category(name):
	person = gui_controller.mansion.active_person if person == null else input_handler.interacted_character
	category = name
	$ClassPanel.hide()
	$SkillPanel.show()
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
	if !ResourceScripts.game_progress.unlock_all_classes:
		class_locked = !person.checkreqs(tempclass.reqs)
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
	$SkillPanel.hide()

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
	$SkillPanel.show()
	gui_controller.windows_opened.clear()
	yield(get_tree().create_timer(0.2),"timeout")
	person.add_stat('base_exp', -person.get_next_class_exp())
	person.unlock_class(current_class)
	yield(get_tree().create_timer(0.2),"timeout")
	globals.text_log_add("class", person.translate("[name] has acquired new Class: " + classesdata.professions[current_class].name))
	get_parent().BodyModule.update()
	get_parent().set_state("default")
	
func build_skills():
	input_handler.ClearContainer($SkillPanel/ScrollContainer/GridContainer)
	
	var array = []
	var array_learned = []
	
	for i in Skilldata.Skilllist.values():
		if i.tags.has("learnable"):
			if person.get_combat_skills().has(i.code):
				array_learned.append(i)
			else:
				array.append(i)
	array.sort_custom(self, 'sort_by_name')
	for i in array_learned + array:
		if !person.checkreqs(i.learn_reqs):
			continue
		var newbutton =  input_handler.DuplicateContainerTemplate($SkillPanel/ScrollContainer/GridContainer)
		newbutton.connect('pressed', self, "skill_selected", [i])
		globals.connecttexttooltip(newbutton, '[center]' + i.name + '[/center]\n' + i.descript)
		newbutton.get_node("icon").texture = i.icon
		newbutton.get_node("name").text = i.name
		newbutton.set_meta('skill', i)
		if array_learned.has(i):
			newbutton.disabled = true
	sort_skills()
	$SkillPanel/skillpoints_label.text = "Skill Points: " + str(person.get_ability_experience())
	

func is_skill_locked(skill):
	if skill.learn_reqs.size() == 0:
		return false
	
	var locked = true
	for p in person.xp_module.professions:
		if classesdata.professions[p].has("traits"):
			for t in classesdata.professions[p].traits:
				for lr in skill.learn_reqs:
					if lr.trait == t:
						locked = false
	return locked

func sort_skills():
	if skill_category == "all":
		for i in $SkillPanel/ScrollContainer/GridContainer.get_children():
			i.visible = i.has_meta('skill')
		return
	else:
		for i in $SkillPanel/ScrollContainer/GridContainer.get_children():
			i.visible = false
	
	for i in $SkillPanel/ScrollContainer/GridContainer.get_children():
		if i.has_meta("skill"):
			var skill = i.get_meta("skill")
			if skill == null:
				continue
			if skill.tags.has(skill_category):
				i.visible = true
			# combat and spell
			# not working and uselesss due to no gui for it
#			for lr in skill.learn_reqs:
#				if skill_category in lr.trait:
#					i.visible = true

func change_skill_category(cat):
	skill_category = cat
	for i in $SkillPanel/Categories.get_children():
		i.pressed = i.name == cat
	sort_skills()

func skill_selected(skill):
	for i in $SkillPanel/ScrollContainer/GridContainer.get_children():
		if i.has_meta("skill") && i.get_meta("skill").code != skill.code:
			i.pressed = false
	selected_skill = skill
	$SkillTooltip/req_icon.texture = null
	globals.connecttexttooltip($SkillTooltip/req_icon, "")
	$SkillTooltip/req_icon.hint_tooltip = ""
	$SkillTooltip/usage.text = "0"
	$SkillTooltip/unlock_button.disabled = false
	$SkillTooltip/exp.set("custom_colors/font_color", "#f9e380")
	if skill.learn_cost > person.get_ability_experience():
		$SkillTooltip/unlock_button.disabled = true
		$SkillTooltip/exp.set("custom_colors/font_color", variables.hexcolordict.red)
	
	for i in skill.learn_reqs:
		if i.code == 'trait':
			if i.trait == "basic_spells":
				$SkillTooltip/req_icon.texture = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_basic_spells.png")
				globals.connecttexttooltip($SkillTooltip/req_icon, tr("TRAITBASIC_SPELLS"))
			if i.trait == "advanced_spells":
				$SkillTooltip/req_icon.texture = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_advanced_spells.png")
				globals.connecttexttooltip($SkillTooltip/req_icon, tr("TRAITADVANCED_SPELLS"))
			if i.trait == "basic_combat":
				$SkillTooltip/req_icon.texture = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_basic_combat.png")
				globals.connecttexttooltip($SkillTooltip/req_icon, tr("TRAITBASIC_COMBAT"))
			if i.trait == "advanced_combat":
				$SkillTooltip/req_icon.texture = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_advanced_combat.png")
				globals.connecttexttooltip($SkillTooltip/req_icon, tr("TRAITADVANCED_COMBAT"))
		elif i.code == 'stat':
			if i.stat == 'wings':
				$SkillTooltip/req_icon.texture = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_basic_combat.png") #2change!
				globals.connecttexttooltip($SkillTooltip/req_icon, tr("STATWINGS"))
	$SkillTooltip/req.visible = $SkillTooltip/req_icon.texture != null
	gui_controller.windows_opened.append($SkillTooltip)
	$SkillTooltip.show()
	$SkillTooltip/icon.texture = skill.icon
	$SkillTooltip/name.text = tr("SKILL" + skill.code.to_upper())
	$SkillTooltip/description.text = tr("SKILL" + skill.code.to_upper() + "DESCRIPT")
	if skill.has("learn_cost"):
		$SkillTooltip/exp.text = str(skill.learn_cost) + " SP"
	$SkillTooltip/cooldown.text = str(skill.combatcooldown)
	if skill.cost.has("mp"):
		$SkillTooltip/usage.text = str(skill.cost.mp)

func buy_skill():
	person.learn_c_skill(selected_skill.code)
	
	var args = {}
	args["skill"] = selected_skill
	args["person"] = person
	input_handler.play_animation("skill_unlocked", args)
	hide_skilltooltip()
	yield(get_tree().create_timer(4.5), 'timeout')
	build_skills()

func hide_skilltooltip():
	$SkillTooltip.hide()
	gui_controller.windows_opened.erase($SkillTooltip)
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
