extends Panel

var selectedhero


func _ready():
	pass


func update():
	selectedhero = input_handler.interacted_character
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newnode.get_node("Label").text = i.get_full_name()
		newnode.pressed = (i == selectedhero)
		if i.is_on_quest():
			newnode.disabled = true
			newnode.set("modulate", Color(1,0,0,1))
		newnode.connect("pressed", get_parent(), "set_active_hero", [i])
