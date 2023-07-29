extends Panel

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
	$VBoxContainer/icon2.connect("pressed", self, "make_random_portrait")
	$VBoxContainer/body.connect("pressed", self, "custom_icon_open", ["body"])
	$VBoxContainer/uniquesprite.connect("pressed", self, 'unique_sprite_choose')
	$Label.text = tr("DESCRIPT_BUTTON_TEXT")
	$ConfirmButton.connect("pressed", self, "confirm")
	custom_description_open()

func show():
	.show()
	$VBoxContainer/uniquesprite.visible = person.get_stat('unique') != null

func unpress_buttons():
	for button in $VBoxContainer.get_children():
		if button.get_class() != "Button":
			continue
		button.pressed = false


func show_text_edit():
	$TextEdit.show()
	$Label.show()
	$VBoxContainer/IconBlock.hide()
	$ScrollContainer.hide()

func custom_description_open():
	unpress_buttons()
	$VBoxContainer/descript.pressed = true
	$ConfirmButton.show()
	person = input_handler.interacted_character
	if person != null:
		show_text_edit()
		$Label.text = tr("DESCRIPT2_BUTTON_TEXT")
		details_state = tr("DESCRIPT_LABEL")
		$TextEdit.text = person.get_stat('bonus_description')

func custom_nickname_open():
	unpress_buttons()
	$VBoxContainer/nickname.pressed = true
	$ConfirmButton.show()
	person = input_handler.interacted_character
	show_text_edit()
	$Label.text = tr("CUSTOM_NICK_LABEL")
	details_state = "nickname"
	$TextEdit.text = person.get_stat('nickname')

func custom_masternoun_open():
	unpress_buttons()
	$VBoxContainer/masternoun.pressed = true
	$ConfirmButton.show()
	person = input_handler.interacted_character
	show_text_edit()
	$Label.text = tr("CUSTOM_MNOUN_LABEL")
	details_state = "masternoun"
	$TextEdit.text = person.get_stat('masternoun')

func custom_icon_open(state):
	unpress_buttons()
	if state == "portrait":
		$VBoxContainer/icon.pressed = true
	else:
		$VBoxContainer/body.pressed = true
	$Label.hide()
	$ConfirmButton.hide()
	$TextEdit.hide()
	$VBoxContainer/IconBlock.show()
	$ScrollContainer.show()
	ImageSelect.mode = state
	ImageSelect.buildimagelist(state)
	details_state = state

func unique_sprite_choose():
	unpress_buttons()
	$VBoxContainer/uniquesprite.pressed = true
	$Label.hide()
	$ConfirmButton.hide()
	$TextEdit.hide()
	$VBoxContainer/IconBlock.show()
	$ScrollContainer.show()
	ImageSelect.mode = 'unique'
	ImageSelect.buildimagelist('unique')
	details_state = 'unique_sprite'
	

func make_random_portrait():
	unpress_buttons()
	person = input_handler.interacted_character
	if person != null:
		person.make_random_portrait()
		gui_controller.slavepanel.BodyModule.update()
		gui_controller.slavepanel.SummaryModule.show_summary()  



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

