extends Panel


var selectedhero
var person


var mode
var show_list = true
var category = 'all'
onready var ItemsList = $InventoryListModule
onready var SlaveList = $InventorySlaveListModule
onready var GearModule = $InventoryGearModule
onready var StatsModule = $InventoryStatsModule
onready var FactorsModule = $InventorySlaveListModule/InventoryFactorsModule
onready var submodules = []


signal inventory_opened
signal inventory_hidden
signal item_used
signal item_equipped
signal item_discarded
signal item_sold


func _ready():
	gui_controller.add_close_button(self, "add_offset")
	$InventoryListModule.buildinventory()
	$GridContainer/CharInfoButton.connect("pressed", self, "open_char_info")
	$GridContainer/MansionButton.connect("pressed", self, "return_to_mansion")
	input_handler.register_btn_source('inv_close_button', self, 'tut_get_close_button')

func tut_get_close_button():
	return $CloseButton


func open_char_info():
	close_inventory_to_char_info()

func return_to_mansion():
	close_inventory_to_mansion()

func close_inventory_to_char_info():
	input_handler.emit_signal('update_ragdoll')
	gui_controller.emit_signal("screen_changed")
	if gui_controller.slavepanel == null:
		gui_controller.slavepanel = input_handler.get_spec_node(input_handler.NODE_SLAVEMODULE)
	gui_controller.current_screen = gui_controller.slavepanel
	gui_controller.previous_screen = gui_controller.mansion
	gui_controller.slavepanel.show()
	gui_controller.slavepanel.set_state("default")
	self.hide()
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.slavepanel, 0.3)
	#input_handler.get_spec_node(input_handler.NODE_SLAVEMODULE).SummaryModule.get_node("GridContainer/GearButton").set_pressed(false)

func close_inventory_to_mansion():
	gui_controller.emit_signal("screen_changed")
	gui_controller.current_screen = gui_controller.mansion
	gui_controller.previous_screen = gui_controller.slavepanel
	gui_controller.mansion.show()
	gui_controller.mansion.mansion_state_set("default")
	gui_controller.clock.raise()
	gui_controller.clock.show()
	self.hide()
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.mansion, 0.3)

func update():
	if selectedhero == null:
		selectedhero = input_handler.interacted_character


func set_active_hero(hero):
	input_handler.interacted_character = hero
	selectedhero = hero
	SlaveList.update()
	ItemsList.buildinventory()
	GearModule.build_gear_panel()
	StatsModule.open_base_stats()
	FactorsModule.show_factors()
	update()
#	GearModule.show_buffs()



