extends Control

#Button node -> label child shown beside its icon on hover.
const BUTTON_LABELS = {
	WorkButton = 'Label',
	TravelsButton = 'Label',
	UpgradesButton = 'Label2',
	SexButton = 'Label3',
	InventoryButton = 'Label4',
	CraftButton = 'Label5',
	Journal = 'Label5',
	options = 'Label5',
}


func _ready():
	$VBoxContainer/WorkButton.connect("pressed", self, "_button_clicked", ["occupation", $VBoxContainer/WorkButton])
	$VBoxContainer/TravelsButton.connect("pressed", self, "_button_clicked", ["travels", $VBoxContainer/TravelsButton])
	$VBoxContainer/UpgradesButton.connect("pressed", self, "_button_clicked", ["upgrades", $VBoxContainer/UpgradesButton])
	$VBoxContainer/CraftButton.connect("pressed", self, "_button_clicked", ["craft", $VBoxContainer/CraftButton])
	$VBoxContainer/InventoryButton.connect("pressed", self, "open_inventory")
	$VBoxContainer/SexButton.connect("toggled", self, "open_sex")
	#$VBoxContainer/SexButton.connect("pressed", self, "_button_clicked", ["sex", $VBoxContainer/SexButton])
	$VBoxContainer/Journal.connect("toggled", self, "open_journal")
	$VBoxContainer/options.connect("pressed", self, "open_menu")
	input_handler.register_btn_source('upgrades_button', self, 'tut_get_UpgradesButton')
	input_handler.register_btn_source('work_button', self, 'tut_get_WorkButton')
	input_handler.register_btn_source('craft_button', self, 'tut_get_CraftButton')
	input_handler.register_btn_source('inventory_button', self, 'tut_get_InventoryButton')
	input_handler.register_btn_source('journal_button', self, 'tut_get_Journal')
	for button_name in BUTTON_LABELS:
		var button = $VBoxContainer.get_node(button_name)
		var label = button.get_node(BUTTON_LABELS[button_name])
		button.connect("mouse_entered", self, "_set_button_label_visible", [label, true])
		button.connect("mouse_exited", self, "_set_button_label_visible", [label, false])
	connect("visibility_changed", self, "_hide_button_labels")


func _set_button_label_visible(label, value):
	label.visible = value


func _hide_button_labels():
	if is_visible_in_tree():
		return
	for button_name in BUTTON_LABELS:
		$VBoxContainer.get_node(button_name).get_node(BUTTON_LABELS[button_name]).hide()


func tut_get_UpgradesButton():
	return $VBoxContainer/UpgradesButton
func tut_get_WorkButton():
	return $VBoxContainer/WorkButton
func tut_get_InventoryButton():
	return $VBoxContainer/InventoryButton
func tut_get_CraftButton():
	return $VBoxContainer/CraftButton
func tut_get_Journal():
	return $VBoxContainer/Journal

#hotkey entry point - drives the same buttons a click would, so every side effect
#(toggle state, panel fades, gui_controller bookkeeping) happens the usual way.
#Pressing the key of the category already open returns the mansion to its default view.
func activate_category(code):
	match code:
		'work': return toggle_category("occupation", $VBoxContainer/WorkButton)
		'travels':
			#the navigation panel's travel button sets this before opening; from the mansion
			#the map always returns here, so clear any context left by another screen
			var map = get_parent().get_node_or_null("map")
			if map != null:
				map.set_return_context(null, null, null)
			return toggle_category("travels", $VBoxContainer/TravelsButton)
		'upgrades': return toggle_category("upgrades", $VBoxContainer/UpgradesButton)
		'craft': return toggle_category("craft", $VBoxContainer/CraftButton)
		'sex':
			#SexButton and Journal listen to 'toggled', so flipping pressed is the whole call.
			#Neither owns a mansion_state, so their own button is what tracks them
			if $VBoxContainer/SexButton.disabled: return false
			$VBoxContainer/SexButton.pressed = !$VBoxContainer/SexButton.pressed
			return true
		'journal':
			if $VBoxContainer/Journal.disabled: return false
			$VBoxContainer/Journal.pressed = !$VBoxContainer/Journal.pressed
			return true
		'inventory':
			if $VBoxContainer/InventoryButton.disabled: return false
			open_inventory()
			return true
		'menu':
			if $VBoxContainer/options.disabled: return false
			open_menu()
			return true
	return false


func toggle_category(state, button):
	if button.disabled:
		return false
	#these buttons are wired to 'pressed', which set_pressed() does not emit - so the
	#handler is called by hand once the button reflects the state we are switching to
	button.pressed = get_parent().mansion_state != state
	_button_clicked(state, button)
	return true


func open_menu():
	gui_controller.game_menu = input_handler.get_spec_node(input_handler.NODE_GAMEMENU)
	gui_controller.game_menu.show()
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.game_menu
	gui_controller.update_modules()

func _button_clicked(state, button):
	if button.is_pressed():
		get_parent().mansion_state = state
	else:
		get_parent().mansion_state = "default"

func open_inventory():
	if get_parent().active_person == null:
		var person = ResourceScripts.game_party.characters[ResourceScripts.game_party.character_order[0]]
		get_parent().set_active_person(person)
	gui_controller.inventory = input_handler.get_spec_node(input_handler.NODE_INVENTORY_NEW)
	gui_controller.current_screen = gui_controller.inventory
	gui_controller.previous_screen = gui_controller.mansion
	gui_controller.inventory.show()
	gui_controller.inventory.update()
	gui_controller.inventory.set_active_hero(get_parent().active_person)
	get_parent().mansion_state_set("default")
	gui_controller.emit_signal("screen_changed")
	yield(get_tree().create_timer(0.3), "timeout")

func open_sex(val):
	gui_controller.win_btn_connections_handler(val, get_parent().SexSelect, $VBoxContainer/SexButton)
	if val:
		get_parent().SexSelect.open()
	else:
		get_parent().SexSelect.hide()

func open_interaction():
	get_parent().InteractSelection.show()
	get_parent().InteractSelection.open()



func open_journal(pressed):
	$VBoxContainer/Journal.pressed = pressed
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
