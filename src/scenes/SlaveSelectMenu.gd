extends "res://src/scenes/ClosingPanel.gd"

var target_func
var target_node

func open(targetnode, targetfunc, reqs = [], allow_remove = false, challenge = null):
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
		if i.is_on_quest():
			continue
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		var text = i.get_short_name()
		if challenge != null:
			if i.get_stat('chg_' + challenge + "_max") < 1:
				newnode.hide()
				continue
			elif i.get_stat("chg_" + challenge + "_max") - i.get_stat("chg_" + challenge) <= 0:
				newnode.disabled = true
			text += (
				" - " 
				+ tr("CHALLENGE" + challenge.to_upper()) + ": "
				+ str(i.get_stat("chg_" + challenge + "_max") - i.get_stat("chg_" + challenge))
				+ "/"
				+ str(i.get_stat("chg_" + challenge + "_max"))
				)
			newnode.connect("pressed", self, 'add_challenge_point', [i, challenge])
		newnode.get_node("icon").texture = i.get_icon_small()
		newnode.get_node('text').text = text
		newnode.connect('pressed', self, 'select', [i])
		globals.connectslavetooltip(newnode, i)
	$Label.visible = $ScrollContainer/VBoxContainer.get_child_count() <= 1

func select(character):
	target_node.call(target_func, character)
	hide()

func add_challenge_point(character, challenge):
	character.add_stat("chg_"+challenge, 1)
