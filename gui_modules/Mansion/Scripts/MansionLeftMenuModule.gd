extends Control

#Button node -> what it says and which action presses it. Every icon on the rail is also a
#hotkey, so the name of the thing and the key that opens it are one tooltip; a rebind rewrites
#the whole set at once. This replaced a column of labels that unfolded to the right of the
#icons - a tooltip says the same thing without needing room on screen to say it in.
const BUTTON_TOOLTIPS = {
	InventoryButton = ['LMMINVENTORY', 'mansion_inventory'],
	CraftButton = ['LMMCRAFT', 'mansion_craft'],
	SexButton = ['LMMDATE', 'mansion_sex'],
	Journal = ['LMMJOURNAL', 'mansion_journal'],
	options = ['LMMOPTIONS', 'mansion_menu'],
}

#These frames have no disabled art of their own, so a button that cannot be pressed is greyed
#the way the slave cards grey theirs.
const DISABLED_MATERIAL = preload("res://assets/sfx/bw_shader.tres")

#What the craft icon opens is a bench, and a bench stands in a workshop: with none built there
#is nothing behind the button. The kitchen counts - it is tagged a craft room like the forge -
#and so does the ritual room, which is what the enchanting bench needs.
const ENCHANT_ROOM = 'ritual_room'

onready var buttons = $Buttons


func _ready():
	buttons.get_node("InventoryButton").connect("pressed", self, "activate_category", ["inventory"])
	buttons.get_node("CraftButton").connect("pressed", self, "activate_category", ["craft"])
	buttons.get_node("SexButton").connect("pressed", self, "activate_category", ["sex"])
	buttons.get_node("Journal").connect("toggled", self, "open_journal")
	buttons.get_node("options").connect("pressed", self, "open_menu")
	input_handler.register_btn_source('journal_button', self, 'tut_get_Journal')
	input_handler.register_btn_source('inventory_button', self, 'tut_get_InventoryButton')
	input_handler.register_btn_source('craft_button', self, 'tut_get_CraftButton')
	hotkeys.connect("bindings_changed", self, "build_tooltips")
	globals.connect("rooms_changed", self, "refresh_craft_button")
	build_tooltips()
	refresh_craft_button()


func build_tooltips():
	for button_name in BUTTON_TOOLTIPS:
		var data = BUTTON_TOOLTIPS[button_name]
		var text = hotkeys.get_tooltip_text(data[0], data[1])
		if button_name == 'CraftButton' and !craft_available():
			text += "\n" + tr("LMMCRAFTNOROOM")
		globals.connecttexttooltip(buttons.get_node(button_name), text)


func craft_available():
	return ResourceScripts.game_res.has_room_with_tag('craft') \
		or ResourceScripts.game_res.count_rooms(ENCHANT_ROOM) > 0


#A room going up or coming down is the only thing that changes this answer, and the plan emits
#that. The tooltip is rebuilt beside the state so the greyed icon can say what it is waiting for.
func refresh_craft_button():
	var button = buttons.get_node("CraftButton")
	var available = craft_available()
	button.disabled = !available
	button.material = null if available else DISABLED_MATERIAL
	build_tooltips()


func tut_get_Journal():
	return buttons.get_node("Journal")
func tut_get_InventoryButton():
	return buttons.get_node("InventoryButton")
func tut_get_CraftButton():
	return buttons.get_node("CraftButton")

#hotkey entry point - drives the same buttons a click would, so every side effect
#(toggle state, panel fades, gui_controller bookkeeping) happens the usual way.
#Pressing the key of the category already open returns the mansion to its default view.
func activate_category(code):
	match code:
		'travels':
			#the navigation panel's travel button sets this before opening; from the mansion
			#the map always returns here, so clear any context left by another screen
			var map = get_parent().get_node_or_null("map")
			if map != null:
				map.set_return_context(null, null, null)
			return toggle_state("travels")
		'sex':
			get_parent().open_sex_selection()
			return true
		'craft':
			#the key is the button's equal, so it is refused on the same grounds: no workshop,
			#nothing to open. A craft room's own card opens its bench as well
			if !craft_available():
				return false
			return toggle_state("craft")
		'inventory':
			open_inventory()
			return true
		'journal':
			if buttons.get_node("Journal").disabled: return false
			buttons.get_node("Journal").pressed = !buttons.get_node("Journal").pressed
			return true
		'menu':
			if buttons.get_node("options").disabled: return false
			open_menu()
			return true
	return false


#Turning a screen on, or - asked for the screen already up - back off to the default view.
func toggle_state(state):
	var parent = get_parent()
	parent.mansion_state = "default" if parent.mansion_state == state else state
	return true


func open_menu():
	gui_controller.game_menu = input_handler.get_spec_node(input_handler.NODE_GAMEMENU)
	gui_controller.game_menu.show()
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.game_menu
	gui_controller.update_modules()

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
	buttons.get_node("Journal").pressed = pressed
	if pressed:
		ResourceScripts.core_animations.UnfadeAnimation(get_parent().Journal, 0.5)
	else:
		ResourceScripts.core_animations.FadeAnimation(get_parent().Journal, 0.5)
		yield(get_tree().create_timer(0.5), "timeout")
	get_parent().Journal.visible = pressed
	get_parent().Journal.open()
	get_parent().submodules.append(get_parent().Journal) if pressed else get_parent().submodules.erase(get_parent().Journal)




func update():
	buttons.get_node("Journal").pressed = get_parent().Journal.is_visible()
