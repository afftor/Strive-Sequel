extends Panel

var active_person
var char_module_state

onready var ClassesModule = $SlaveClassesModule
onready var DetailsModule = $SlaveDetailsModule
onready var SummaryModule = $SlaveSummaryModule
onready var SlaveSiblingsModule = $SlaveSiblingsModule
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

var unique_dict = { #shows available talk characters. Scenes go in order from higher priority and reqs to lower. No scenes isn't supported yet
	kurdan = {
	code = 'kurdan', 
	scenes = [
		{code = 'kurdan_dialogue_start', reqs = []}
		]
	},
	
	zephyra = {
	code = 'zephyra', 
	scenes = [
		{code = 'zephyra_dialogue_start', reqs = []}
		]
	},
	
	anastasia = {
	code = 'anastasia', 
	scenes = [
		{code = 'anastasia_dialogue_start', reqs = []}
	]
	},
	
	daisy = {
	code = 'daisy', 
	scenes = [
		{code = 'daisy_dialogue_start', reqs = []}
	]
	},
	
}


func talk():
	input_handler.active_character = active_person
	var unique = active_person.get_stat('unique')
	if unique_dict.has(unique):
		gui_controller.close_scene(self)
		var scene 
		for i in unique_dict[unique].scenes:
			if globals.checkreqs(i.reqs):
				scene = i.code
				break
				
		if scene != null:
			input_handler.interactive_message(scene)

func update():
	# active_person = gui_controller.mansion.active_person if SummaryModule.selected_person == null else SummaryModule.selected_person
	active_person = input_handler.interacted_character
	SummaryModule.show_summary()
	SlaveInfo.update()
	BodyModule.update()
	$TalkButton.visible = unique_dict.has(active_person.get_stat('unique'))
	if char_module_state == "siblings" or char_module_state == "skills":
		$TalkButton.hide()

func set_state(state):
	if state == char_module_state:
		gui_controller.windows_opened.clear()
		char_module_state = "default"
	else:
		char_module_state = state
	match_state()

func match_state():
	$CloseButton.visible = !ClassesModule.get_node("ClassPanel").is_visible()
	for b in SummaryModule.get_node("GridContainer").get_children():
		b.set_pressed(false)
	match char_module_state:
		"default":
			#gui_controller.inventory = input_handler.get_spec_node(input_handler.NODE_INVENTORY_NEW)
			#gui_controller.inventory.hide()
	
			DetailsModule.hide()
			ClassesModule.hide()
			SlaveSiblingsModule.hide()
			BodyModule.show()
			SlaveInfo.show()
			$TalkButton.show()
			$SlaveBodyModule/Body.show()
			$SlaveBodyModule/buffscontainer.show()
			$SlaveBodyModule.get_stylebox("panel", "").modulate_color.a = 255
		"skills":
			gui_controller.windows_opened.clear()
			gui_controller.windows_opened.append(ClassesModule)
			DetailsModule.hide()
			SlaveSiblingsModule.hide()
			ClassesModule.class_category("all")
			ClassesModule.show()
			$SlaveBodyModule/Body.hide()
			$SlaveBodyModule/buffscontainer.hide()
			SummaryModule.get_node("GridContainer/SkillsButton").set_pressed(true)
			$SlaveBodyModule/buffscontainer.hide()
			#BodyModule.hide()
		"details":
			gui_controller.windows_opened.clear()
			gui_controller.windows_opened.append(DetailsModule)
			ClassesModule.hide()
			SlaveSiblingsModule.hide()
			DetailsModule.unpress_buttons()
			DetailsModule.custom_description_open()
			DetailsModule.show()
			SummaryModule.get_node("GridContainer/DetailsButton").set_pressed(true)
			$TalkButton.show()
			$SlaveBodyModule/Body.show()
			$SlaveBodyModule/buffscontainer.show() #or hide? it's all good @Sphinx
			$SlaveBodyModule.get_stylebox("panel", "").modulate_color.a = 255
		"gear":
			#char_module_state = "default"
			gui_controller.windows_opened.clear()
			$SlaveBodyModule/buffscontainer.hide()
			open_gear()
		"siblings":
			gui_controller.windows_opened.clear()
			gui_controller.windows_opened.append(SlaveSiblingsModule)
			$TalkButton.hide()
			$SlaveBodyModule/buffscontainer.hide()
			$SlaveBodyModule/Body.hide()
			$SlaveBodyModule/buffscontainer.hide()
			$SlaveBodyModule.get_stylebox("panel", "").modulate_color.a = 0
			SlaveInfo.hide()
			DetailsModule.hide()
			ClassesModule.hide()
			SummaryModule.get_node("GridContainer/SiblingsButton").set_pressed(true)
			SlaveSiblingsModule.show()
			SlaveSiblingsModule.DietModule.open_diet_window()
			SlaveSiblingsModule.update()
			#BodyModule.hide()
			
	update()




#func _on_Button_pressed():
		# pass


func open_gear():
	self.hide()
	gui_controller.inventory = input_handler.get_spec_node(input_handler.NODE_INVENTORY_NEW)
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.inventory, 0.3)
	gui_controller.inventory.show()
	gui_controller.inventory.get_node("GridContainer/GearButton").set_pressed(true)
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.inventory
	gui_controller.inventory.set_active_hero(active_person)
	gui_controller.emit_signal("screen_changed")

