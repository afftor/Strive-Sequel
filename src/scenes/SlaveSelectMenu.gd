extends "res://src/scenes/ClosingPanel.gd"

var target_func
var target_node

func open(targetnode, targetfunc, reqs = [], allow_remove = false):
	target_func = targetfunc
	target_node = targetnode
	show()
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	if allow_remove == true:
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newnode.get_node("text").text = tr("REMOVE")
		newnode.connect('pressed', targetnode, targetfunc, [null])
		newnode.connect('pressed',self,'hide')
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		if i.checkreqs(reqs) == false:
			continue
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newnode.get_node("icon").texture = i.get_icon()
		newnode.get_node('text').text = i.get_short_name()
		newnode.connect('pressed', self, 'select', [i])
		globals.connectslavetooltip(newnode, i)
	$Label.visible = $ScrollContainer/VBoxContainer.get_child_count() <= 1

func select(character):
	target_node.call(target_func, character)
	hide()
