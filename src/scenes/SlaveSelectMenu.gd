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
	
	var charlist = []
	
	if challenge == 'captured':
		for i in input_handler.active_location.captured_characters:
			var tchar = characters_pool.get_char_by_id(i)
			charlist.append(tchar)
	else:
		for id in  ResourceScripts.game_party.character_order:
			var i = ResourceScripts.game_party.characters[id]
			if i.checkreqs(reqs) == false:
				continue
			if i.is_on_quest():
				continue
			charlist.append(i)
	
	for i in charlist:
		if i.checkreqs(reqs) == false:
			continue
		if i.is_on_quest():
			continue
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		var text = i.get_short_name()
		if challenge != null && challenge != 'captured':
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
		if challenge == 'captured':
			newnode.connect('pressed',self,'remove_captured_character',[i])
		newnode.get_node("icon").texture = i.get_icon_small()
		newnode.get_node('text').text = text
		newnode.connect('pressed', self, 'select', [i])
		globals.connectslavetooltip(newnode, i)
	$Label.visible = $ScrollContainer/VBoxContainer.get_child_count() <= 1

func select(character):
	target_node.call(target_func, character)
	hide()

var challenge_stat_dict = {
	strength = 'physics',
	dexterity = 'physics',
	wisdom = 'wits',
	charm = 'charm'
}

func add_challenge_point(character, challenge):
	character.add_stat("chg_"+challenge, 1)
	if challenge_stat_dict.has(challenge):
		character.affect_char({type = 'stat', stat = challenge_stat_dict[challenge], value = 4})

func remove_captured_character(i):
	i.is_active = false
	input_handler.active_location.captured_characters.erase(i.id)
