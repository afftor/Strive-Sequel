extends Panel

var active_person
var char_module_state

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
	#$TalkButton.connect("pressed", self, 'talk', [])
	#$RemoveButton.connect('pressed',self,'remove',[])
	input_handler.connect('PortraitUpdate', self, 'refresh_portrait')
	input_handler.connect('SpellUsed', self, 'update')
	input_handler.register_btn_source('char_close_button', self, 'tut_get_close_button')


func tut_get_close_button():
	return $CloseButton


func remove():
	#gui_controller.close_scene(self)
	input_handler.active_character = active_person
	input_handler.interactive_message('slave_remove')

func refresh_portrait():
	#a finished shot only needs the picture swapped. update() rebuilds the whole screen,
	#ragdoll included, which is a full pass over every generator transform - far too much
	#for one texture, and it is what made the new portrait show up half a second late
	if !is_visible_in_tree() or active_person == null:
		return
	SummaryModule.get_node('Portrait').texture = active_person.get_icon()


func update():
	if !is_visible_in_tree():
		return
	active_person = input_handler.interacted_character
	if active_person == null:
		return
	active_person.update_prt()
	SummaryModule.show_summary()
	SummaryModule.update_buttons()
	SlaveInfo.update()
	BodyModule.update()
	SlaveSiblingsModule.update()
	
#	$TalkButton.visible = unique_dict.has(active_person.get_stat('unique'))
#	$RemoveButton.visible = !active_person.is_master()
#	if char_module_state == "siblings":
#		$TalkButton.hide()
#		$RemoveButton.hide()



func set_state(state):
	if state == char_module_state:
		gui_controller.windows_opened.clear()
		char_module_state = "default"
	else:
		char_module_state = state
	match_state()

func match_state():
#	var tooltip = input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP)
#	globals.disconnect_text_tooltip(tooltip.parentnode)
#	tooltip.turnoff()
#	tooltip.hide()
#	for b in SummaryModule.get_node("GridContainer").get_children():
#		b.set_pressed(false)
	match char_module_state:
		"default":
			#gui_controller.inventory = input_handler.get_spec_node(input_handler.NODE_INVENTORY_NEW)
			#gui_controller.inventory.hide()
	
			DetailsModule.hide()
			SlaveSiblingsModule.hide()
			BodyModule.show()
			SlaveInfo.show()
			#$TalkButton.show()
#			$SlaveBodyModule/Body.show()
			$SlaveBodyModule.body_show(true)
			$SlaveBodyModule/buffscontainer.show()
			$SlaveBodyModule.get_stylebox("panel", "").modulate_color.a = 255
		"details":
			gui_controller.windows_opened.clear()
			gui_controller.windows_opened.append(DetailsModule)
			SlaveSiblingsModule.hide()
			DetailsModule.unpress_buttons()
			DetailsModule.custom_description_open()
			DetailsModule.show()
			#SummaryModule.get_node("GridContainer/DetailsButton").set_pressed(true)
			#$TalkButton.show()
#			$SlaveBodyModule/Body.show()
			$SlaveBodyModule.body_show(true)
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
			#$TalkButton.hide()
			$SlaveBodyModule/buffscontainer.show()
#			$SlaveBodyModule/Body.hide()
			$SlaveBodyModule.body_show(true)
			$SlaveBodyModule.get_stylebox("panel", "").modulate_color.a = 0
			SlaveInfo.hide()
			DetailsModule.hide()
			#SummaryModule.get_node("GridContainer/SiblingsButton").set_pressed(true)
			SlaveSiblingsModule.show()
#			SlaveSiblingsModule.DietModule.open_diet_window()
			SlaveSiblingsModule.update()
			#BodyModule.hide()
	SummaryModule.set_buttons_pressed(char_module_state)
	update()


func open_gear():
	self.hide()
	gui_controller.inventory = input_handler.get_spec_node(input_handler.NODE_INVENTORY_NEW)
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.inventory, 0.3)
	gui_controller.inventory.show()
	#gui_controller.inventory.get_node("GridContainer/GearButton").set_pressed(true)
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.inventory
	gui_controller.inventory.set_active_hero(active_person)
	gui_controller.emit_signal("screen_changed")


