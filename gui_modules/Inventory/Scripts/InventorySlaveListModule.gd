extends Panel

var selectedhero
# Called when the node enters the scene tree for the first time.
func _ready():
	update()


func update():
	selectedhero = input_handler.interacted_character
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newnode.get_node("Label").text = i.get_full_name()
		newnode.pressed = (i == selectedhero)
		newnode.connect("pressed", get_parent(), "set_active_hero", [i])
