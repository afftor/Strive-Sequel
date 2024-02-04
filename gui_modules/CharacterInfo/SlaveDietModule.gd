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
		for k in ['high','med','low','disable']:
			if person.food.food_filter[k].has(i.code):
				newbutton.get_node("filter").text = tr("FOODFILTER" + k.to_upper())
				newbutton.get_node("filter").set("custom_colors/font_color", Color(variables.hexcolordict[categorycolors[k]]))
				break
		newbutton.connect("pressed", self, "change_food_category", [i.code])

func change_food_category(foodcode):
	var current_category
	for i in ['high','med','low','disable']:
		if person.food.food_filter[i].has(foodcode):
			current_category = i
			break
	person.food.food_filter[current_category].erase(foodcode)
	var newcategory
	if category_order.size() > category_order.find(current_category)+1:
		newcategory = category_order[category_order.find(current_category)+1]
	else:
		newcategory = category_order[0]
	person.food.food_filter[newcategory].append(foodcode)
	#input_handler.GetItemTooltip().hide()
	# input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
	open_diet_window()

var category_order = ['high','med','low','disable']
var categorycolors = {high = "green", med = 'yellow', low = 'red', disable = 'gray'}

func sort_food(first, second):
#	return first.name >= second.name
	return first.name > second.name
