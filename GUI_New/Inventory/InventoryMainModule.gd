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
onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)
onready var char_module = GUIWorld.gui_data["SLAVE_INFO"].main_module

signal inventory_opened
signal inventory_hidden
signal item_used
signal item_equipped
signal item_discarded
signal item_sold

#warning-ignore-all:return_value_discarded
#warning-ignore-all:unused_signal

func _ready():
	$VBoxContainer/InfoButton.connect("pressed", self, "close_inventory", ["default"])
	$VBoxContainer/ClassButton.connect("pressed", self, "close_inventory", ["class"])
	$VBoxContainer/DetailsButton.connect("pressed", self, "close_inventory", ["details"])


func close_inventory(state):
	GUIWorld.PreviousScene = self
	GUIWorld.set_current_scene(GUIWorld.gui_data["SLAVE_INFO"].main_module)
	ResourceScripts.core_animations.UnfadeAnimation(GUIWorld.gui_data["SLAVE_INFO"].main_module, 0.3)
	char_module.set_state(state)



func update():
	selectedhero = GUIWorld.gui_data["MANSION"].main_module.active_person
	set_active_hero(selectedhero)


func set_active_hero(hero):
	selectedhero = hero
	SlaveList.update()
	ItemsList.buildinventory()
	GearModule.build_gear_panel()
	StatsModule.open_base_stats()
	FactorsModule.show_factors()
	GearModule.show_buffs()



