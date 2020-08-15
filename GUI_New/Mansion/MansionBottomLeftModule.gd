extends Control

onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)

func _ready():
	$VBoxContainer/TravelsButton.connect("pressed", self, "_button_clicked", ["travels", $VBoxContainer/TravelsButton])
	$VBoxContainer/UpgradesButton.connect("pressed", self, "_button_clicked", ["upgrades", $VBoxContainer/UpgradesButton])
	$VBoxContainer/CraftButton.connect("pressed", self, "_button_clicked", ["craft", $VBoxContainer/CraftButton])
	$VBoxContainer/InventoryButton.connect("pressed", self, "open_inventory")
	$VBoxContainer/SexButton.connect("pressed", self, "_button_clicked", ["sex", $VBoxContainer/SexButton])
	$VBoxContainer/Journal.connect("toggled", self, "open_journal")

func _button_clicked(state, button):
	if button.is_pressed():
		get_parent().mansion_state = state
	else:
		get_parent().mansion_state = "default"
	
func open_inventory():	
	GUIWorld.PreviousScene = GUIWorld.gui_data["MANSION"].main_module
	GUIWorld.set_current_scene(GUIWorld.gui_data["INVENTORY"].main_module)
	ResourceScripts.core_animations.UnfadeAnimation(GUIWorld.gui_data["INVENTORY"].main_module, 0.3)
	yield(get_tree().create_timer(0.3), "timeout")
	
func open_interaction():
	get_parent().InteractSelection.show()
	get_parent().InteractSelection.open()



func open_journal(pressed):
	if pressed:
		ResourceScripts.core_animations.UnfadeAnimation(get_parent().Journal, 0.5)
	else:
		ResourceScripts.core_animations.FadeAnimation(get_parent().Journal, 0.5)
		yield(get_tree().create_timer(0.5), "timeout")
	get_parent().Journal.visible = pressed
	get_parent().Journal.open()
	get_parent().submodules.append(get_parent().Journal) if pressed else get_parent().submodules.erase(get_parent().Journal)




func update():
	$VBoxContainer/Journal.pressed = get_parent().Journal.is_visible()
