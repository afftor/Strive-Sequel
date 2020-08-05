extends Panel

var active_person
var char_module_state

onready var GUIWorld = get_parent()

onready var ClassesModule = $SlaveClassesModule
onready var DetailsModule = $SlaveDetailsModule
onready var SummaryModule = $SlaveSummaryModule
onready var DietModule = $SlaveDietModule
onready var BodyModule = $SlaveBodyModule
onready var SlaveInfo = $SlaveInfoModule
onready var submodules = []
var inventory_scene

func _ready():
	GUIWorld.add_close_button(self)


func update():
	active_person = GUIWorld.gui_data["MANSION"].main_module.active_person
	if GUIWorld.PreviousScene == GUIWorld.gui_data["INVENTORY"].main_module:
		GUIWorld.PreviousScene = null
		return
	if submodules.size() == 0:
		set_state("default")
	SummaryModule.show_summary()


func set_state(state):
	var inventory_scene = GUIWorld.gui_data["INVENTORY"].main_module
	if state == char_module_state:
		submodules.clear()
		char_module_state = "default"
	else:
		char_module_state = state
	SummaryModule.update_buttons()
	match_state()

func match_state():
	GUIWorld.CurrentScene = self
	print("state:", char_module_state)
	match char_module_state:
		"default":
			if DetailsModule.is_visible():
				ResourceScripts.core_animations.FadeAnimation(DetailsModule, 0.3)

			if DietModule.is_visible():
				ResourceScripts.core_animations.FadeAnimation(DietModule, 0.3)

			if ClassesModule.is_visible():
				ResourceScripts.core_animations.FadeAnimation(ClassesModule, 0.3)
			yield(get_tree().create_timer(0.4), "timeout")
			DetailsModule.hide()
			DietModule.hide()
			ClassesModule.hide()
			SummaryModule.update_buttons()
			DetailsModule.get_node("SexTraitsPanel").hide()
		"class":
			if DetailsModule.is_visible():
				ResourceScripts.core_animations.FadeAnimation(DetailsModule, 0.3)
				DetailsModule.hide()

			if DietModule.is_visible():
				ResourceScripts.core_animations.FadeAnimation(DietModule, 0.3)
				DietModule.hide()

			ClassesModule.class_category("all")
			ResourceScripts.core_animations.UnfadeAnimation(ClassesModule, 0.3)
			ClassesModule.show()
			DetailsModule.get_node("SexTraitsPanel").hide()
			submodules.clear()
			submodules.append(ClassesModule)
		"details":
			if ClassesModule.is_visible():
				ResourceScripts.core_animations.FadeAnimation(ClassesModule, 0.3)
				ClassesModule.hide()

			if DietModule.is_visible():
				ResourceScripts.core_animations.FadeAnimation(DietModule, 0.3)
				DietModule.hide()
			DetailsModule.get_node("SexTraitsPanel").hide()
			ResourceScripts.core_animations.UnfadeAnimation(DetailsModule, 0.3)
			submodules.clear()
			submodules.append(DetailsModule)
			DetailsModule.show()
		"diet":
			if ClassesModule.is_visible():
				ResourceScripts.core_animations.FadeAnimation(ClassesModule, 0.3)
				ClassesModule.hide()

			if DetailsModule.is_visible():
				ResourceScripts.core_animations.FadeAnimation(DetailsModule, 0.3)
				DietModule.hide()
			DetailsModule.get_node("SexTraitsPanel").hide()
			submodules.clear()
			DietModule.open_diet_window()
			ResourceScripts.core_animations.UnfadeAnimation(DietModule, 0.3)
			DietModule.show()
		"gear":
			char_module_state = "default"
			ResourceScripts.core_animations.BlackScreenTransition()
			yield(get_tree().create_timer(0.5), "timeout")
			open_gear()
			for node in submodules:
				node.hide()
			submodules.clear()
			



func _on_Button_pressed():
	print("Current Scene:" + str(GUIWorld.CurrentScene.name))
	print("Previous Scene:" + str(GUIWorld.PreviousScene.name))


func open_gear():
	GUIWorld.set_current_scene(GUIWorld.gui_data["INVENTORY"].main_module)

