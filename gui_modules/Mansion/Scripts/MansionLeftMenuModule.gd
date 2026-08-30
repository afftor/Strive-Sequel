extends Control

#Button node -> the label child that names it. The whole rail reads at once: pointing at any
#of the icons names all of them, which is what makes a column of pictures usable at a glance.
const BUTTON_LABELS = {
	Journal = 'Label5',
	options = 'Label5',
}


func _ready():
	$VBoxContainer/Journal.connect("toggled", self, "open_journal")
	$VBoxContainer/options.connect("pressed", self, "open_menu")
	input_handler.register_btn_source('journal_button', self, 'tut_get_Journal')
	connect("visibility_changed", self, "_hide_button_labels")


var labels_shown = false


#One region, asked once a frame, instead of a signal on every icon and every name. The names
#hang off the right of the rail past its own edge, and the gaps between the icons are real
#background - so entering and leaving fired constantly and the column blinked. A rectangle
#that covers the icons and everything they say has no edges inside it to trip over.
func _process(_delta):
	if !is_visible_in_tree():
		return
	var inside = hover_region().has_point(get_global_mouse_position())
	if inside != labels_shown:
		labels_shown = inside
		_show_button_labels(inside)


#The rail plus the strip its names are written across, whether or not they are showing: a
#hidden Label still knows where it would be.
func hover_region():
	var region = get_global_rect()
	for button_name in BUTTON_LABELS:
		var button = $VBoxContainer.get_node(button_name)
		region = region.merge(button.get_node(BUTTON_LABELS[button_name]).get_global_rect())
	return region


func _show_button_labels(value):
	for button_name in BUTTON_LABELS:
		var button = $VBoxContainer.get_node(button_name)
		button.get_node(BUTTON_LABELS[button_name]).visible = value


func _hide_button_labels():
	if is_visible_in_tree():
		return
	labels_shown = false
	_show_button_labels(false)


func tut_get_UpgradesButton():
	return $VBoxContainer/UpgradesButton
func tut_get_Journal():
	return $VBoxContainer/Journal

#hotkey entry point - drives the same buttons a click would, so every side effect
#(toggle state, panel fades, gui_controller bookkeeping) happens the usual way.
#Pressing the key of the category already open returns the mansion to its default view.
func activate_category(code):
	match code:
		'work':
			#the rail no longer carries this one - every character card opens their own work
			#from the card itself - but the key still turns the whole screen on and off
			var parent = get_parent()
			parent.mansion_state = "default" if parent.mansion_state == "occupation" else "occupation"
			return true
		'travels':
			#the navigation panel's travel button sets this before opening; from the mansion
			#the map always returns here, so clear any context left by another screen
			var map = get_parent().get_node_or_null("map")
			if map != null:
				map.set_return_context(null, null, null)
			return toggle_category("travels", $VBoxContainer/TravelsButton)
		'sex':
			#no button of its own on the rail any more - the master's room carries it
			get_parent().open_sex_selection()
			return true
		'craft':
			#no button on the rail any more - a craft room's own card opens its bench - but the
			#key still turns the whole screen on and off
			var parent = get_parent()
			parent.mansion_state = "default" if parent.mansion_state == "craft" else "craft"
			return true
		'inventory':
			open_inventory()
			return true
		'journal':
			if $VBoxContainer/Journal.disabled: return false
			$VBoxContainer/Journal.pressed = !$VBoxContainer/Journal.pressed
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
