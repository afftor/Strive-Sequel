extends Panel

var selected_race = ""

func _ready():
	$ConfirmButton.connect("pressed", self, "select_character_race")
	$CancelButton.connect("pressed", self, "cancel_race_selection")


func select_race():
	selected_race = ""
	show()
	get_parent().ClassSelection.hide()
	var person = get_parent().person
	input_handler.ClearContainer($RaceSelection/ScrollContainer/VBoxContainer)
	for i in races.racelist.values():
		var newbutton = input_handler.DuplicateContainerTemplate($RaceSelection/ScrollContainer/VBoxContainer)
		if person.get_stat('race') == i.code: newbutton.pressed = true
		newbutton.text = i.name
		# newbutton.connect("mouse_entered", self, 'show_race_info',[i.code])
		newbutton.connect("pressed", self, "show_race_info", [i.code])


func select_character_race():
	hide()
	var person = get_parent().person
	person.set_stat('race', selected_race)
	get_parent().preservedsettings["race"] = selected_race
	get_parent().rebuild_slave()


func show_race_info(temprace):
	selected_race = temprace
	var person = get_parent().person
	var race = races.racelist[temprace]
	var image
	var text = race.descript
	
	text += "\n\n{color=yellow|Race bonuses: "
	for i in race.race_bonus:
		if (i as String).begins_with('resist'):
			text += i.replace("resist","").capitalize() + " Resist: " + str(race.race_bonus[i]) + "%, "
			continue
		if statdata.statdata[i].has("percent") && statdata.statdata[i].percent == true:
			text += statdata.statdata[i].name + ": " + str(race.race_bonus[i]*100) + '%, '
		else:
			text += statdata.statdata[i].name + ": " + str(race.race_bonus[i]) + ', '
	text = text.substr(0, text.length() - 2) + ".}"
	
	$RaceSelection/RichTextLabel.bbcode_text = globals.TextEncoder(text)
	text = race.code.to_lower().replace('halfkin','beastkin')
	var tmp = person.get_stat('sex')
	if tmp != null:
		if tmp == 'male':
			text += "_m"
		else:
			text += "_f"
		
		if images.shades.has(text):
			image = images.shades[text]
	
	$RaceSelection/TextureRect.texture = image
	update_buttons()

func update_buttons():
	for button in $RaceSelection/ScrollContainer/VBoxContainer.get_children():
		if button.name == "Button":
			continue
		button.pressed = selected_race == button.text


func cancel_race_selection():
	hide()
