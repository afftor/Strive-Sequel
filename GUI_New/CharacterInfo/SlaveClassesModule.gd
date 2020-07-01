extends Panel
#warning-ignore-all:return_value_discarded

onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)

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
		# self.rect_size.x = Panel_x/2
		$Tooltip/RichTextLabel.bbcode_text = '[center]'+$RichTextLabel.bbcode_text+'[/center]'
	else:
		$Tooltip/RichTextLabel.rect_size.x = Text_x
		# self.rect_size.x = Panel_x
	yield(get_tree(), 'idle_frame')
	# if !weakref(node).get_ref():
	# 	return
	# rect_size.y = $RichTextLabel.get_v_scroll().get_max() + 50
	$Tooltip/RichTextLabel.rect_size.y = rect_size.y

func close_tooltip():
	$Tooltip.hide()

func open(tempperson, tempmode = 'normal'):
	person = tempperson
	mode = tempmode
	current_class = null
	show()
	input_handler.ClearContainer($ScrollContainer/GridContainer)
	
	var array = []
	for i in classesdata.professions.values():
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
		if i.has('altname') && person.checkreqs(i.altnamereqs):
			name = i.altname
		if person.checkreqs(i.reqs) == false:
			newbutton.texture_normal = load("res://assets/images/gui/universal/skill_frame_diabled.png")
			newbutton.texture_hover = load("res://assets/images/gui/universal/skill_frame_diabled.png")
			newbutton.disabled = true
		newbutton.get_node('name').text = name
		newbutton.connect('pressed',self,"open_class", [i.code])
		newbutton.set_meta('class_code', i.code)
		newbutton.connect('mouse_entered', self, 'show_tooltip', [newbutton, ResourceScripts.descriptions.get_class_details(person, i, true, true)])
		newbutton.connect('mouse_exited', self, 'close_tooltip')
		# globals.connecttexttooltip(newbutton, ResourceScripts.descriptions.get_class_details(person, i, true, true))
	


func checkbox_locked():
	person = GUIWorld.gui_data["MANSION"].main_module.active_person
	open(person, mode)

func class_category(name):
	person = GUIWorld.gui_data["MANSION"].main_module.active_person
	category = name
	for i in $categories.get_children():
		i.pressed = i.name == category
	open(person, mode)

func sort_classes(first,second):
	if first.name >= second.name:
		return false
	else:
		return true

func open_class(classcode):
	var sub_modules = GUIWorld.gui_data.SLAVE_INFO.main_module.submodules
	if !sub_modules.has($ClassPanel):
		GUIWorld.gui_data.SLAVE_INFO.main_module.submodules.append($ClassPanel)
	var tempclass = classesdata.professions[classcode]
	var text = ResourceScripts.descriptions.get_class_details(person, tempclass)
	current_class = classcode
	$ClassPanel.open(classcode,person)
	if person.has_profession(tempclass.code):
		text = person.translate('[name] has already acquired this class.')
		$ClassPanel/Unlock.hide()
		$ClassPanel/ExpLabel.set("custom_colors/font_color", Color(1,1,1))
	else:
		text = tr("EXPREQUIRED")+": " + str(person.get_next_class_exp()) + "/" +  str(floor(person.get_stat('base_exp'))) 
		$ClassPanel/Unlock.disabled = person.get_stat('base_exp') < person.get_next_class_exp()
		$ClassPanel/Unlock.show()
		if person.get_stat('base_exp') < person.get_next_class_exp():
			$ClassPanel/ExpLabel.set("custom_colors/font_color", variables.hexcolordict.red)
		else:
			$ClassPanel/ExpLabel.set("custom_colors/font_color", variables.hexcolordict.green)
	
	$ClassPanel/ExpLabel.text = text
	update_class_buttons(classcode)

func update_class_buttons(classcode):
	for button in $ScrollContainer/GridContainer.get_children():
		if button == $ScrollContainer/GridContainer.get_child($ScrollContainer/GridContainer.get_children().size()-1):
			continue
		button.pressed = (button.get_meta("class_code") == classcode)


func unlock_class():
	$ClassPanel.hide()
	yield(get_tree().create_timer(0.2),"timeout")
	.hide()
	person.add_stat('base_exp', -person.get_next_class_exp())
	person.unlock_class(current_class)
	yield(get_tree().create_timer(0.2),"timeout")
	input_handler.ShowSlavePanel(person)
	#input_handler.get_spec_node(input_handler.NODE_SLAVEPANEL, [person])
	globals.text_log_add("class", person.translate("[name] has acquired new Class: " + classesdata.professions[current_class].name))
	input_handler.PlaySound("ding")
	input_handler.update_slave_list()
