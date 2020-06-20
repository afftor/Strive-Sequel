extends Panel


onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD)

var person
onready var ImageSelect = $PopUp
var details_state = "description"
var portaitsbuilt = false


# Called when the node enters the scene tree for the first time.
func _ready():
#	$CloseButton.connect("pressed", self, "hide")
	$VBoxContainer/descript.connect("pressed", self, "custom_description_open")
	$VBoxContainer/nickname.connect("pressed", self, "custom_nickname_open")
	$VBoxContainer/masternoun.connect("pressed", self, "custom_masternoun_open")
	$VBoxContainer/icon.connect("pressed", self, "custom_icon_open", ["portrait"])
	$VBoxContainer/body.connect("pressed", self, "custom_icon_open", ["body"])
	$Label.text = "Add Custom Description"
	$ConfirmButton.connect("pressed", self, "confirm")
	custom_description_open()


func show_text_edit():
	$TextEdit.show()
	$Label.show()
	$VBoxContainer/IconBlock.hide()
	$ScrollContainer.hide()

func custom_description_open():
	$ConfirmButton.show()
	person = GUIWorld.gui_data["MANSION"].main_module.active_person
	if person != null:
		show_text_edit()
		$Label.text = "Add Custom Description"
		details_state = "description"
		$TextEdit.text = person.get_stat('bonus_description')

func custom_nickname_open():
	$ConfirmButton.show()
	person = GUIWorld.gui_data["MANSION"].main_module.active_person
	show_text_edit()
	$Label.text = "Add Custom Nickname"
	details_state = "nickname"
	$TextEdit.text = person.get_stat('nickname')

func custom_masternoun_open():
	$ConfirmButton.show()
	person = GUIWorld.gui_data["MANSION"].main_module.active_person
	show_text_edit()
	$Label.text = "Add Custom Masternoun"
	details_state = "masternoun"
	$TextEdit.text = person.get_stat('masternoun')

func custom_icon_open(state):
	$Label.hide()
	$ConfirmButton.hide()
	$TextEdit.hide()
	$VBoxContainer/IconBlock.show()
	$ScrollContainer.show()
	ImageSelect.mode = state
	ImageSelect.buildimagelist(state)
	details_state = state


func confirm():
	person = GUIWorld.gui_data["MANSION"].main_module.active_person
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

