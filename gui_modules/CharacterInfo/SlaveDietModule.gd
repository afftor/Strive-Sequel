extends Control

var person

func _ready():
	if has_node("close"):
		$close.connect("pressed", self, "close_diet_window")
		input_handler.register_btn_source("food_preference_meat", self, "tut_get_food_preference_meat")
	 

func open_diet_window():
	#if !gui_controller.windows_opened.has(self):
	#	gui_controller.windows_opened.append(self)
	#self.raise()
	self.show()
	person = input_handler.interacted_character
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	build_demand_header()
	var array = []
	for i in Items.materiallist.values():
		if i.type == 'food':
			array.append(i)
	array.sort_custom(self, 'sort_food')
	for i in array:
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newbutton.name = i.code
		newbutton.get_node("Label").text = i.name
		if newbutton.has_node("Icon"):
			newbutton.get_node("Icon").texture = i.icon
		newbutton.get_node("Label").set("custom_colors/font_color",
			Color(variables.hexcolordict[variables.food_demand_colors[i.demand]]))
		#build_demand_header() already refreshed the demand this frame
		globals.connectmaterialtooltip(newbutton, i, globals.get_food_char_text(i, person))
		var allowed = person.get_filter_for_food(i.code)
		newbutton.get_node("filter").text = tr("FOODFILTERALLOWED" if allowed else "FOODFILTERFORBIDDEN")
		newbutton.get_node("filter").set("custom_colors/font_color",
			Color(variables.hexcolordict['green' if allowed else 'gray']))
		newbutton.connect("pressed", self, "toggle_food", [i.code])
		newbutton.set_meta('exploration', true)


#this script is shared by two scenes with different node sets - the standalone diet panel
#has a RichTextLabel, the one embedded in the character sheet has the food_* widgets
func build_demand_header():
	var demand = person.get_food_demand()
	var demand_name = tr("FOODDEMAND" + demand.to_upper())
	var demand_color = variables.hexcolordict[variables.food_demand_colors[demand]]

	if has_node("RichTextLabel"):
		var text = tr("INFOFOODFILTER")
		text += "\n" + tr("FOODDEMAND") + ": [color=%s]%s[/color]" % [demand_color, demand_name]
		if person.food.food_love != null and person.food.food_love != '':
			text += "\n" + tr("FOODLIKEDTYPE") + ": " + tr("FOODTYPE" + person.food.food_love.to_upper())
		$RichTextLabel.bbcode_text = text

	if has_node("food_consumption"):
		$food_consumption.text = tr("FOODDEMAND")
		$food_consumption/Label.text = demand_name
		$food_consumption/Label.set("custom_colors/font_color", Color(demand_color))
		globals.connecttexttooltip($food_consumption,
			"[center]" + tr("FOODDEMAND") + "[/center]\n" + tr("FOODDEMAND" + demand.to_upper() + "DESCRIPT"))
	if has_node("food_love"):
		var has_love = person.food.food_love != null and person.food.food_love != ''
		$food_love.visible = has_love
		if has_love:
			$food_love/Button.texture = images.get_icon(person.food.food_love)
			$food_love/Button.visible = true
			if has_node("food_love/Label"):
				$food_love/Label.text = tr("FOODLIKEDTYPE") + ": " + tr("FOODTYPE" + person.food.food_love.to_upper())
			globals.connecttexttooltip($food_love, "[center]" + tr("FOODLIKEDTYPE") + "[/center]\n"
				+ tr("FOODTYPE" + person.food.food_love.to_upper()))
	#disliked food no longer exists
	if has_node("food_hate"):
		$food_hate.visible = false
	if has_node("FoodFilterTooltip"):
		globals.connecttexttooltip($FoodFilterTooltip, tr("INFOFOODFILTER"))


func toggle_food(foodcode):
	person.toggle_food(foodcode)

	#input_handler.GetItemTooltip().hide()
	# input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP).hide()
	open_diet_window()


func close_diet_window():
	hide()


func tut_get_food_preference_meat():
	return $ScrollContainer/VBoxContainer.get_node_or_null("meat")


func sort_food(first, second):
	var first_demand = variables.food_demand_order.find(first.demand)
	var second_demand = variables.food_demand_order.find(second.demand)
	if first_demand == -1:
		first_demand = variables.food_demand_order.size()
	if second_demand == -1:
		second_demand = variables.food_demand_order.size()
	if first_demand == second_demand:
		return first.name < second.name
	return first_demand < second_demand
