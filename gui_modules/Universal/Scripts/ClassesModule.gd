extends Panel


var category = 'all'
var person
var mode
var classes_to_add = []

func _ready():
	for i in $categories.get_children():
		i.connect("pressed",self,'class_category', [i.name])
	$Confirm.connect("pressed", self, "confirm_class_selection")


func class_category(name):
	person = gui_controller.mansion.active_person
	category = name
	for i in $categories.get_children():
		i.pressed = i.name == category
	show_classes()



func open(tempperson, tempmode = 'normal'):
	person = tempperson
	mode = tempmode
	classes_to_add.clear()
	show()
	show_classes()
	


func show_classes():
	if !gui_controller.windows_opened.has(self):
		gui_controller.windows_opened.append(self)

	input_handler.ClearContainer($ScrollContainer/GridContainer)
	
	var array = []
	for i in classesdata.professions.values():
		if (!i.categories.has(category) && category != 'all') || person.has_profession(i.code):
			continue
		array.append(i)
	
	array.sort_custom(self, 'sort_classes')
	
	for i in array:
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/GridContainer)
		newbutton.get_node('icon').texture = i.icon
		var name = i.name
		if i.has('altname') && person.checkreqs(i.altnamereqs):
			name = i.altname
		newbutton.get_node('name').text = name
		newbutton.connect('pressed',self,"add_class", [i.code])
		newbutton.set_meta('class_code', i.code)
		globals.connecttexttooltip(newbutton, ResourceScripts.descriptions.get_class_details(person, i, true, true))


func sort_classes(first,second):
#	return first.name <= second.name
	return first.name < second.name


func add_class(cls):
	classes_to_add.append(cls) if !classes_to_add.has(cls) else classes_to_add.erase(cls)


func confirm_class_selection():
	for cls in classes_to_add:
		person.unlock_class(cls)
	classes_to_add.clear()
	gui_controller.mansion.SlaveModule.show_slave_info()
	hide()
