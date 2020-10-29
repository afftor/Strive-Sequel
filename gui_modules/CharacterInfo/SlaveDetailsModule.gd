extends Panel


#onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)

var person
onready var ImageSelect = $PopUp
onready var CharMainModule = get_parent()
var details_state = "description"
var portaitsbuilt = false


func _ready():
#	$CloseButton.connect("pressed", self, "hide")
	$VBoxContainer/descript.connect("pressed", self, "custom_description_open")
	$VBoxContainer/nickname.connect("pressed", self, "custom_nickname_open")
	$VBoxContainer/masternoun.connect("pressed", self, "custom_masternoun_open")
	$VBoxContainer/icon.connect("pressed", self, "custom_icon_open", ["portrait"])
	$VBoxContainer/body.connect("pressed", self, "custom_icon_open", ["body"])
	$VBoxContainer/traits.connect("pressed", self, "sex_traits_open")
	$Label.text = "Add Custom Description"
	$ConfirmButton.connect("pressed", self, "confirm")
	custom_description_open()


func unpress_buttons():
	for button in $VBoxContainer.get_children():
		if button.get_class() != "Button":
			continue
		button.pressed = false


func show_text_edit():
	$SexTraitsPanel.hide()
	$TextEdit.show()
	$Label.show()
	$VBoxContainer/IconBlock.hide()
	$ScrollContainer.hide()

func custom_description_open():
	unpress_buttons()
	$VBoxContainer/descript.pressed = true
	$SexTraitsPanel.hide()
	$ConfirmButton.show()
	person = input_handler.interacted_character
	if person != null:
		show_text_edit()
		$Label.text = "Add Custom Description"
		details_state = "description"
		$TextEdit.text = person.get_stat('bonus_description')

func custom_nickname_open():
	unpress_buttons()
	$VBoxContainer/nickname.pressed = true
	$SexTraitsPanel.hide()
	$ConfirmButton.show()
	person = input_handler.interacted_character
	show_text_edit()
	$Label.text = "Add Custom Nickname"
	details_state = "nickname"
	$TextEdit.text = person.get_stat('nickname')

func custom_masternoun_open():
	unpress_buttons()
	$VBoxContainer/masternoun.pressed = true
	$SexTraitsPanel.hide()
	$ConfirmButton.show()
	person = input_handler.interacted_character
	show_text_edit()
	$Label.text = "Add Custom Masternoun"
	details_state = "masternoun"
	$TextEdit.text = person.get_stat('masternoun')

func custom_icon_open(state):
	unpress_buttons()
	if state == "portrait":
		$VBoxContainer/icon.pressed = true
	else:
		$VBoxContainer/body.pressed = true
	$SexTraitsPanel.hide()
	$Label.hide()
	$ConfirmButton.hide()
	$TextEdit.hide()
	$VBoxContainer/IconBlock.show()
	$ScrollContainer.show()
	ImageSelect.mode = state
	ImageSelect.buildimagelist(state)
	details_state = state

func sex_traits_open():
	unpress_buttons()
	$VBoxContainer/traits.pressed = true
	$SexTraitsPanel.show()
	$VBoxContainer/IconBlock.hide()
	person = input_handler.interacted_character
	input_handler.ClearContainer($SexTraitsPanel/ScrollContainer/VBoxContainer)
	$SexTraitsPanel/TraitsNotLearned.bbcode_text = person.translate(tr("NOTALLTRAITSLEARNED"))
	var array = person.get_all_sex_traits()#.keys()
	var all_traits_known = true
	for i in array:
		if array[i] == false:
			all_traits_known = false
			break
	if all_traits_known:
		array = person.get_unlocked_sex_traits()#.keys()
		array.sort_custom(self, 'sort_traits')
	
		for i in array:
			var newbutton = input_handler.DuplicateContainerTemplate($SexTraitsPanel/ScrollContainer/VBoxContainer)
			newbutton.pressed = person.check_trait(i)
			newbutton.text = Traitdata.sex_traits[i].name
			globals.connecttexttooltip(newbutton, person.translate(Traitdata.sex_traits[i].descript))
			newbutton.connect("toggled", self, 'toggle_trait', [i])
	$SexTraitsPanel/TraitsNotLearned.visible = !all_traits_known
	update_trait_capacity()

func update_trait_capacity():
	person = input_handler.interacted_character
	var text = 'Current Capacity: ' + str(person.statlist.sex_traits.size()) + "/" + str(person.get_stat('sexuals_factor')+1)
	$SexTraitsPanel/TraitCapacity.text = text
	for i in $SexTraitsPanel/ScrollContainer/VBoxContainer.get_children():
		i.disabled = person.get_stat('sexuals_factor')+1 - person.statlist.sex_traits.size() <= 0 && i.pressed == false


func toggle_trait(trait_status, trait):
	match trait_status:
		true:
			if !person.check_trait(trait):
				person.add_sex_trait(trait, true)
		false:
			if person.check_trait(trait):
				person.remove_sex_trait(trait, false)
	update_trait_capacity()
	get_parent().SlaveInfo.rebuild_traits()



func confirm():
	person = input_handler.interacted_character
	var text = $TextEdit.text
	match details_state:
		"description":
			person.set_stat('bonus_description', text)
		"nickname":
			person.set_stat('nickname', text)
		"masternoun":
			person.set_stat('masternoun', text)
		# "icon":
		# 	$ImageSelect.chooseimage(person, "icon")
		# "body":
		# 	$ImageSelect.chooseimage(person, "body")

