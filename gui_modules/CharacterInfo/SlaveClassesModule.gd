extends Panel
#warning-ignore-all:return_value_discarded


var category = 'all'
var person
var mode
var current_class

var parentnode
var shutoff = false
var prevnode

var character = Reference

var Panel_x = 598
var Text_x = 565

func _ready():
	for i in $categories.get_children():
		i.connect("pressed",self,'class_category', [i.name])

	$ClassPanel/Unlock.connect('pressed', self, 'unlock_class')
	if !get_parent().name == "CheatsModule":
		$CheckBox.connect("pressed", self, "checkbox_locked")
	input_handler.AddPanelOpenCloseAnimation($ClassPanel)

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
	if !gui_controller.windows_opened.has(self):
		gui_controller.windows_opened.append(self)
	person = tempperson
	mode = tempmode
	current_class = null
	show()
	input_handler.ClearContainer($ScrollContainer/GridContainer)
	
	var array = []
	for i in classesdata.professions.values():
		if !ResourceScripts.game_progress.unlock_all_classes:
			if (!i.categories.has(category) && category != 'all') || !person.checkreqs(i.showupreqs) || person.has_profession(i.code):
				continue
			if !$CheckBox.pressed && person.checkreqs(i.reqs) == false:
				continue
		array.append(i)
	
	array.sort_custom(self, 'sort_classes')
	
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
	person = gui_controller.mansion.active_person
	open(person, mode)

func class_category(name):
	person = gui_controller.mansion.active_person if person == null else get_parent().active_person
	category = name
	for i in $categories.get_children():
		i.pressed = i.name == category
	open(person, mode)

func sort_classes(first,second):
	return first.name <= second.name

func open_class(classcode):
	if !gui_controller.windows_opened.has($ClassPanel):
		gui_controller.windows_opened.append($ClassPanel)
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

func update_class_buttons(classcode):
	for button in $ScrollContainer/GridContainer.get_children():
		if button == $ScrollContainer/GridContainer.get_child($ScrollContainer/GridContainer.get_children().size()-1):
			continue
		button.pressed = (button.get_meta("class_code") == classcode)


func unlock_class():
	play_animation()
	$ClassPanel.hide()
	gui_controller.windows_opened.clear()
	yield(get_tree().create_timer(0.2),"timeout")
	person.add_stat('base_exp', -person.get_next_class_exp())
	person.unlock_class(current_class)
	yield(get_tree().create_timer(0.2),"timeout")
	globals.text_log_add("class", person.translate("[name] has acquired new Class: " + classesdata.professions[current_class].name))
	get_parent().BodyModule.update()
	get_parent().set_state("default")


func play_animation():
	input_handler.PlaySound("class_aquired")
	var anim_scene
	anim_scene = input_handler.get_spec_node(input_handler.ANIM_CLASS_ACHIEVED)
	anim_scene.get_node("AnimationPlayer").play("class_achieved")
	anim_scene.get_node("TextureRect").texture = classesdata.professions[current_class].icon
	anim_scene.get_node("Label2").text = current_class.capitalize()
	anim_scene.get_node("Label3").text = person.get_full_name()
	yield(anim_scene.get_node("AnimationPlayer"), "animation_finished")
	ResourceScripts.core_animations.FadeAnimation(anim_scene, 0.5)
	yield(get_tree().create_timer(0.5), 'timeout')
	anim_scene.queue_free()
	input_handler.SetMusic("mansion1")
