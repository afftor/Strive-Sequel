extends Panel

onready var ask_yes_btn = $ask_panel/RichTextLabel/TextureRect/ButtonL
onready var ask_no_btn = $ask_panel/RichTextLabel/TextureRect/ButtonR
onready var ask_text = $ask_panel/RichTextLabel
onready var menu_training = $VBoxContainer/training
onready var menu_work = $VBoxContainer/work
onready var menu_leveling = $VBoxContainer/leveling
onready var menu_quest = $VBoxContainer/quest_and_combat
onready var menu_abort = $VBoxContainer2/abort
onready var menu_back = $VBoxContainer2/back

var on_confirm_func
var pending_tut

func _ready():
	menu_training.connect("pressed", self, "ask_tutorial", ['training'])
	menu_work.connect("pressed", self, "ask_tutorial", ['work'])
	menu_leveling.connect("pressed", self, "ask_tutorial", ['leveling'])
	menu_quest.connect("pressed", self, "ask_tutorial", ['quest_and_combat'])
	menu_abort.connect("pressed", self, "on_abort")
	ask_yes_btn.connect("pressed", self, "ask_confirm")
	ask_no_btn.connect("pressed", $ask_panel, "hide")
	menu_back.connect("pressed", self, "hide_menu")

func show():
	if input_handler.hard_tutorial == null:#in menu
		menu_abort.hide()
		menu_back.show()
	else:
		if !input_handler.is_btn_exists("tut_menu_yes"):
			register_btns()
		menu_abort.show()
		menu_back.visible = input_handler.hard_tutorial.is_tut_active()
	.show()

func register_btns():
	input_handler.register_btn_source("tut_menu_yes", self, "get_abort_yes")
	input_handler.register_btn_source("tut_menu_no", self, "get_abort_no")
	input_handler.register_btn_source("tut_menu_training", self, "get_training")
	input_handler.register_btn_source("tut_menu_work", self, "get_work")
	input_handler.register_btn_source("tut_menu_leveling", self, "get_leveling")
	input_handler.register_btn_source("tut_menu_quest", self, "get_quest_and_combat")
	input_handler.register_btn_source("tut_menu_abort", self, "get_abort")
	input_handler.register_btn_source("tut_menu_back", self, "get_back")

func get_abort_yes():
	return ask_yes_btn
func get_abort_no():
	return ask_no_btn
func get_training():
	return menu_training
func get_work():
	return menu_work
func get_leveling():
	return menu_leveling
func get_quest_and_combat():
	return menu_quest
func get_abort():
	return menu_abort
func get_back():
	return menu_back

func ask_confirm():
	$ask_panel.hide()
	call(on_confirm_func)
	hide_menu()

func ask_tutorial(tut_name):
	ask_text.text = tr("STARTTUTORIAL")
	on_confirm_func = 'start_tutorial'
	pending_tut = tut_name
	$ask_panel.popup()

func start_tutorial():
	input_handler.activate_hard_tutorial()
	input_handler.hard_tutorial.prepare_tutorial(pending_tut)

func on_abort():
	ask_text.text = tr("ABORTTUTORIALQ")
	on_confirm_func = 'abort_tutorial'
	$ask_panel.popup()

func abort_tutorial():
	input_handler.hard_tutorial.abort_tutorial()

func hide_menu():
	if input_handler.hard_tutorial != null:
		input_handler.hard_tutorial.on_tutorial_menu_hide()
	else:
		queue_free()
	hide()
