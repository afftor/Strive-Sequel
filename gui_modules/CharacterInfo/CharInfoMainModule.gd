extends Panel

var active_person
var char_module_state

onready var ClassesModule = $SlaveClassesModule
onready var DetailsModule = $SlaveDetailsModule
onready var SummaryModule = $SlaveSummaryModule
onready var DietModule = $SlaveDietModule
onready var BodyModule = $SlaveBodyModule
onready var SlaveInfo = $SlaveInfoModule
onready var submodules = []
var inventory_scene

func _ready():
	gui_controller.add_close_button(self, "add_offset")
#	for module in self.get_children():
#		module.update()
#	update()
	$TalkButton.connect("pressed", self, 'talk', [])

func talk():
	if active_person.get_stat("unique") == "kurdan":
		input_handler.interactive_message("ginny_visit", '',{})
	elif active_person.get_stat("unique") == "zephyra":
		input_handler.interactive_message("ginny_visit", '',{})

func update():
	# active_person = gui_controller.mansion.active_person if SummaryModule.selected_person == null else SummaryModule.selected_person
	active_person = input_handler.interacted_character
	SlaveInfo.get_node("DietButton").pressed = DietModule.is_visible()
	SummaryModule.show_summary()
	SlaveInfo.update()
	BodyModule.update()
	for button in SummaryModule.get_node("VBoxContainer").get_children():
		button.disabled = active_person.is_on_quest()
	SlaveInfo.get_node("DietButton").disabled = active_person.is_on_quest()


func set_state(state):
	if state == char_module_state:
		gui_controller.windows_opened.clear()
		char_module_state = "default"
	else:
		char_module_state = state
	SummaryModule.update_buttons()
	match_state()

func match_state():
	$CloseButton.visible = !ClassesModule.get_node("ClassPanel").is_visible()
	match char_module_state:
		"default":
			DetailsModule.hide()
			DietModule.hide()
			ClassesModule.hide()
			SummaryModule.update_buttons()
			DetailsModule.get_node("SexTraitsPanel").hide()
		"class":
			DetailsModule.hide()
			DietModule.hide()
			ClassesModule.class_category("all")
			ClassesModule.show()
			DetailsModule.get_node("SexTraitsPanel").hide()
		"details":
			gui_controller.windows_opened.clear()
			gui_controller.windows_opened.append(DetailsModule)
			ClassesModule.hide()
			DietModule.hide()
			DetailsModule.get_node("SexTraitsPanel").hide()
			DetailsModule.unpress_buttons()
			DetailsModule.custom_description_open()
			DetailsModule.show()
		"diet":
			ClassesModule.hide()
			DietModule.hide()
			DetailsModule.get_node("SexTraitsPanel").hide()
			DietModule.open_diet_window()
			DietModule.show()
		"gear":
			char_module_state = "default"
			gui_controller.windows_opened.clear()
			open_gear()
	update()




#func _on_Button_pressed():
		# pass


func open_gear():
	self.hide()
	gui_controller.inventory = input_handler.get_spec_node(input_handler.NODE_INVENTORY_NEW)
	gui_controller.inventory.show()
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.inventory
	gui_controller.inventory.set_active_hero(active_person)
	gui_controller.emit_signal("screen_changed")

