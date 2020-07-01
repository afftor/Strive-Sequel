extends Panel

var active_person
var char_module_state

onready var GUIWorld = get_parent()

onready var ClassesModule = $SlaveClassesModule
onready var DetailsModule = $SlaveDetailsModule
onready var SummaryModule = $SlaveSummaryModule
onready var DietModule = $SlaveDietModule
onready var BodyModule = $SlaveBodyModule
onready var submodules = []
var inventory_scene

func _ready():
	GUIWorld.add_close_button(self)


func update():
	active_person = GUIWorld.gui_data["MANSION"].main_module.active_person
	if submodules.size() == 0:
		set_state("default")
	SummaryModule.show_summary()


func set_state(state):
	print("Set State:" + str(state))
	var inventory_scene = GUIWorld.gui_data["INVENTORY"].main_module
	if state == char_module_state:
		submodules.clear()
		char_module_state = "default"
	else:
		char_module_state = state
	SummaryModule.update_buttons()
	match_state()

func match_state():
	print("Match State:" + str(char_module_state))
	GUIWorld.CurrentScene = self
	match char_module_state:
		"default":
			# input_handler.Close(inventory_node)
			DetailsModule.hide()
			DietModule.hide()
			ClassesModule.hide()
			SummaryModule.update_buttons()
		"class":
			DetailsModule.hide()
			DietModule.hide()
			ClassesModule.class_category("all")
			ClassesModule.show()
			submodules.append(ClassesModule)
		"details":
			ClassesModule.hide() # Temporary
			submodules.append(DetailsModule)
			DetailsModule.show()
		"diet":
			DetailsModule.hide()
			ClassesModule.hide() # Temporary
			DietModule.open_diet_window()
			DietModule.show()
		"gear":
			for node in submodules:
				node.hide()
			submodules.clear()
			open_gear()



func _on_Button_pressed():
	print("Current Scene:" + str(GUIWorld.CurrentScene.name))
	print("Previous Scene:" + str(GUIWorld.PreviousScene.name))


func open_gear():
	GUIWorld.set_current_scene(GUIWorld.gui_data["INVENTORY"].main_module)

