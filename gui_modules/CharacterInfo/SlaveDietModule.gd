extends Control

var person

func _ready():
	pass
	 

func open_diet_window():
	#if !gui_controller.windows_opened.has(self):
	#	gui_controller.windows_opened.append(self)
	#self.raise()
	self.show()
	person = input_handler.interacted_character
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	#$RichTextLabel.bbcode_text = tr("INFOFOODFILTER")
	var array = []
	for i in Items.materiallist.values():
		if i.type == 'food' && i.tags.size() > 0:
			array.append(i)
	array.sort_custom(self, 'sort_food')
	for i in array:
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.get_node("Label").text = i.name
		globals.connectmaterialtooltip(newbutton, i)
		var k = person.get_filter_for_food(i.code)
		newbutton.get_node("filter").text = tr("FOODFILTER" + k.to_upper())
		newbutton.get_node("filter").set("custom_colors/font_color", Color(variables.hexcolordict[variables.categorycolors[k]]))
		newbutton.connect("pressed", self, "change_food_category", [i.code])
		newbutton.set_meta('exploration', true)

func change_food_category(foodcode):
	person.change_food_category(foodcode)
	
	#input_handler.GetItemTooltip().hide()
	# input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
	open_diet_window()


func sort_food(first, second):
#	return first.name >= second.name
	return first.name > second.name
