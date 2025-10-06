extends "res://src/scenes/ClosingPanel.gd"

var target_func
var target_node
onready var req_info = $req_info
onready var req_info_label = $req_info/reqs_list
onready var slave_btn_cont = $ScrollContainer/VBoxContainer
var reqs_text


func open(targetnode, targetfunc, reqs = [], allow_remove = false, challenge = null):
	target_func = targetfunc
	target_node = targetnode
	req_info.hide()
	reqs_text = null
	show()
	input_handler.ClearContainer(slave_btn_cont)
	if allow_remove == true:
		var newnode = input_handler.DuplicateContainerTemplate(slave_btn_cont)
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
#			if i.checkreqs(reqs) == false:
#				continue
			if i.is_on_quest():
				continue
			charlist.append(i)
	
	var reqs_list = reqs
	if !(reqs is Array):
		reqs_list = [reqs]
	if !reqs_list.empty():
		reqs_text = tr('REQUIREMENTS_TOOLTIP') + ":"
		for req in reqs_list:
			reqs_text += '\n' + ResourceScripts.descriptions.make_slave_statreq_text(req)
	
	for i in charlist:
#		if i.checkreqs(reqs) == false:
#			continue
#		if i.is_on_quest():
#			continue
		var newnode = input_handler.DuplicateContainerTemplate(slave_btn_cont)
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
		
		if !reqs_list.empty():
			var reqs_met_text = ''
			var reqs_met = true
			for req in reqs_list:
				var color = "green"
				if !i.checkreqs(req):
					reqs_met = false
					color = "red"
				reqs_met_text += "\n{color=%s|%s}" % [color, ResourceScripts.descriptions.make_slave_statreq_text(req)]
			newnode.disabled = !reqs_met
			
			if challenge == null:
				var recap
				if reqs_met: recap = 'REQUIREMENTSMET'
				else: recap = 'REQUIREMENTSARENTMET'
				reqs_met_text = "%s%s" % [tr(recap), reqs_met_text]
				newnode.set_meta("reqs_met_text", reqs_met_text)
				newnode.connect("mouse_entered", self, "show_req_info", [newnode])
				newnode.connect("mouse_exited", self, "try_hide_req_info")
				req_info_label.bbcode_text = reqs_text
				req_info.show()
		globals.connectslavetooltip(newnode, i)
	$Label.visible = slave_btn_cont.get_child_count() <= 1

func show_req_info(btn):
	req_info_label.bbcode_text = globals.TextEncoder(btn.get_meta("reqs_met_text"))
	req_info.show()

func try_hide_req_info():
	if !slave_btn_cont.get_global_rect().has_point(get_viewport().get_mouse_position()):
		req_info_label.bbcode_text = reqs_text

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
