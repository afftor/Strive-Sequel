extends Panel

# onready var itemcontainer = $ScrollContainer/GridContainer

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
#onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)
#onready var char_module = GUIWorld.gui_data["SLAVE_INFO"].main_module

signal inventory_opened
signal inventory_hidden
signal item_used
signal item_equipped
signal item_discarded
signal item_sold

#warning-ignore-all:return_value_discarded
#warning-ignore-all:unused_signal

func _ready():
	gui_controller.add_close_button(self, "add_offset")
	$VBoxContainer/InfoButton.connect("pressed", self, "close_inventory", ["default"])
	$VBoxContainer/ClassButton.connect("pressed", self, "close_inventory", ["class"])
	$VBoxContainer/DetailsButton.connect("pressed", self, "close_inventory", ["details"])


func close_inventory(state):
	if gui_controller.slavepanel == null:
		gui_controller.slavepanel = input_handler.get_spec_node(input_handler.NODE_SLAVEMODULE)
	gui_controller.current_screen = gui_controller.slavepanel
	gui_controller.previous_screen = gui_controller.mansion
	gui_controller.slavepanel.set_state(state)
	gui_controller.slavepanel.show()
	self.hide()
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.slavepanel, 0.3)




func update():
	if selectedhero == null:
		selectedhero = gui_controller.mansion.active_person
	set_active_hero(selectedhero)


func set_active_hero(hero):
	# gui_controller.mansion.active_person = hero
	selectedhero = hero
	SlaveList.update()
	ItemsList.buildinventory()
	GearModule.build_gear_panel()
	StatsModule.open_base_stats()
	FactorsModule.show_factors()
	GearModule.show_buffs()



