extends "res://src/scenes/ClosingPanel.gd"

var target_func
var target_node
onready var req_info = $req_info
onready var req_info_label = $req_info/reqs_list
onready var slave_btn_cont = $ScrollContainer/VBoxContainer
onready var hide_pretenders_btn = $hide_btn
var reqs_text
var hide_pretenders = false

var silently_hide_codes = ['is_at_location', 'in_combat_party']

func _ready():
	hide_pretenders_btn.connect("pressed", self, "on_hide_pretenders_press")

func open(targetnode, targetfunc, reqs = [], allow_remove = false, challenge = null):
	target_func = targetfunc
	target_node = targetnode
	req_info.hide()
	var show_req_info = (challenge == null)#could be changed with time
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
	if !reqs_list.empty() and show_req_info:
		var has_visible_reqs = false
		for req in reqs_list:
			if !(req.code in silently_hide_codes):
				has_visible_reqs = true
				break
		show_req_info = has_visible_reqs
	if !reqs_list.empty() and show_req_info:
		reqs_text = tr('REQUIREMENTS_TOOLTIP') + ":"
		for req in reqs_list:
			if !(req.code in silently_hide_codes):
				reqs_text += '\n' + ResourceScripts.descriptions.make_slave_statreq_text(req)
		req_info_label.bbcode_text = reqs_text
		req_info.show()
		hide_pretenders_btn.show()
	else:
		hide_pretenders_btn.hide()
	
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
			var silently_hide = false
			for req in reqs_list:
				var is_silent = req.code in silently_hide_codes
				var color = "green"
				if !i.checkreqs(req):
					reqs_met = false
					color = "red"
					if is_silent:
						silently_hide = true
						break
				if show_req_info and !is_silent:
					reqs_met_text += "\n{color=%s|%s}" % [color, ResourceScripts.descriptions.make_slave_statreq_text(req)]
			if silently_hide:
				newnode.hide()
			elif show_req_info:
				newnode.disabled = !reqs_met
				var recap
				if reqs_met: recap = 'REQUIREMENTSMET'
				else: recap = 'REQUIREMENTSARENTMET'
				reqs_met_text = "%s%s" % [tr(recap), reqs_met_text]
				newnode.set_meta("reqs_met_text", reqs_met_text)
				newnode.connect("mouse_entered", self, "show_req_info", [newnode])
				newnode.connect("mouse_exited", self, "try_hide_req_info")
			else:
				if !reqs_met:
					newnode.hide()
		globals.connectslavetooltip(newnode, i)
	$Label.visible = slave_btn_cont.get_child_count() <= 1
	if hide_pretenders_btn.visible:
		check_hide_pretenders()

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

func on_hide_pretenders_press():
	hide_pretenders = !hide_pretenders
	check_hide_pretenders()

func check_hide_pretenders():
	if hide_pretenders:
		hide_pretenders_btn.text = tr("REQ_SHOW_PRETENDER")
	else:
		hide_pretenders_btn.text = tr("REQ_HIDE_PRETENDER")
	for btn in slave_btn_cont.get_children():
		if !btn.has_meta("reqs_met_text"): continue
		if hide_pretenders:
			btn.visible = !btn.disabled
		else:
			btn.visible = true
