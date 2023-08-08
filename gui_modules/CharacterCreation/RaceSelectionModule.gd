extends Panel

var selected_race = ""

func _ready():
	$ConfirmButton.connect("pressed", self, "select_character_race")
	$CancelButton.connect("pressed", self, "cancel_race_selection")


func select_race():
	show()
	get_parent().ClassSelection.hide()
	var person = get_parent().person
	selected_race = person.get_stat("race")
	input_handler.ClearContainer($RaceSelection/ScrollContainer/VBoxContainer)
	for id in races.racelist:
		var i = races.racelist[id]
		var newbutton = input_handler.DuplicateContainerTemplate($RaceSelection/ScrollContainer/VBoxContainer)
		if person.get_stat('race') == i.code: newbutton.pressed = true
		newbutton.get_node('name').text = i.name
		newbutton.get_node('icon').texture = i.icon
		newbutton.set_meta('race', id)
		# newbutton.connect("mouse_entered", self, 'show_race_info',[i.code])
		newbutton.connect("pressed", self, "show_race_info", [id])
	show_race_info(person.get_stat("race"))


func select_character_race():
	hide()
	# var person = get_parent().person
	get_parent().person.set_stat('race', selected_race)
	get_parent().preservedsettings["race"] = selected_race
	get_parent().valid_preservedsettings['race'] = true
	get_parent().rebuild_slave()
	get_parent().build_race()


func show_race_info(temprace):
	selected_race = temprace
	var person = get_parent().person
	var race = races.racelist[temprace]
	var image
	var text = race.descript
	
	text += "\n\n{color=yellow|" + tr("RACE_BONUSES") + ": "
	for i in race.race_bonus:
		if (i as String).begins_with('resist'):
			text += i.replace("resist_","").capitalize() + " Resist: " + str(race.race_bonus[i]) + "%, "
			continue
		if statdata.statdata[i].percent == true:
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
		button.pressed = selected_race == button.get_meta('race')


func cancel_race_selection():
	hide()
