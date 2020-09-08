extends Panel

var active_person
var char_module_state

# onready var GUIWorld = get_parent()

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
	for module in self.get_children():
		module.update()
	update()


func update():
	active_person = gui_controller.mansion.active_person
	# if GUIWorld.PreviousScene == GUIWorld.gui_data["INVENTORY"].main_module:
	# 	GUIWorld.PreviousScene = null
	# 	return
	# if gui_controller.windows_opened.size() == 0:
	# 	set_state("default")
	SummaryModule.show_summary()


func set_state(state):
#	var inventory_scene = GUIWorld.gui_data["INVENTORY"].main_module
	# if state == char_module_state:
	# 	submodules.clear()
	# 	char_module_state = "default"
	# else:
	char_module_state = state
	SummaryModule.update_buttons()
	match_state()

func match_state():
	$CloseButton.visible = !ClassesModule.get_node("ClassPanel").is_visible()
#	GUIWorld.CurrentScene = self
	update()
	match char_module_state:
		"default":
			# if DetailsModule.is_visible():
			# 	ResourceScripts.core_animations.FadeAnimation(DetailsModule, 0.3)

			# if DietModule.is_visible():
			# 	ResourceScripts.core_animations.FadeAnimation(DietModule, 0.3)

			# if ClassesModule.is_visible():
			# 	ResourceScripts.core_animations.FadeAnimation(ClassesModule, 0.3)
			# yield(get_tree().create_timer(0.4), "timeout")
			DetailsModule.hide()
			DietModule.hide()
			ClassesModule.hide()
			SummaryModule.update_buttons()
			DetailsModule.get_node("SexTraitsPanel").hide()
		"class":
			# if DetailsModule.is_visible():
			# 	ResourceScripts.core_animations.FadeAnimation(DetailsModule, 0.3)
			submodules.clear()
			submodules.append(ClassesModule)
			DetailsModule.hide()

			# if DietModule.is_visible():
			# 	ResourceScripts.core_animations.FadeAnimation(DietModule, 0.3)
			DietModule.hide()

			ClassesModule.class_category("all")
			# ResourceScripts.core_animations.UnfadeAnimation(ClassesModule, 0.3)
			ClassesModule.show()
			DetailsModule.get_node("SexTraitsPanel").hide()
		"details":
			# if ClassesModule.is_visible():
			# 	ResourceScripts.core_animations.FadeAnimation(ClassesModule, 0.3)
			gui_controller.windows_opened.clear()
			gui_controller.windows_opened.append(DetailsModule)
			ClassesModule.hide()

			# if DietModule.is_visible():
			# 	ResourceScripts.core_animations.FadeAnimation(DietModule, 0.3)
			DietModule.hide()
			DetailsModule.get_node("SexTraitsPanel").hide()
			# ResourceScripts.core_animations.UnfadeAnimation(DetailsModule, 0.3)
			DetailsModule.show()
		"diet":
			# if ClassesModule.is_visible():
			# 	ResourceScripts.core_animations.FadeAnimation(ClassesModule, 0.3)
			ClassesModule.hide()

			# if DetailsModule.is_visible():
			# 	ResourceScripts.core_animations.FadeAnimation(DetailsModule, 0.3)
			DietModule.hide()
			DetailsModule.get_node("SexTraitsPanel").hide()
			submodules.clear()
			DietModule.open_diet_window()
			# ResourceScripts.core_animations.UnfadeAnimation(DietModule, 0.3)
			DietModule.show()
		"gear":
			char_module_state = "default"
			open_gear()
			for node in submodules:
				node.hide()
			submodules.clear()
			



#func _on_Button_pressed():
#	print("Current Scene:" + str(GUIWorld.CurrentScene.name))
#	print("Previous Scene:" + str(GUIWorld.PreviousScene.name))


func open_gear():
	self.hide()
	gui_controller.inventory = input_handler.get_spec_node(input_handler.NODE_INVENTORY_NEW)
	gui_controller.inventory.show()
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.inventory
	gui_controller.inventory.set_active_hero(active_person)
	gui_controller.emit_signal("screen_changed")

