extends Control

var achi_groups = {}
var achi_subs = {}
onready var achi_cont = $achi_scroll/achi_cont
onready var sub_cont = $sub_close/bg/ScrollContainer/VBoxContainer
onready var sub_node = $sub_close/bg
onready var sub_scroller = $sub_close/bg/ScrollContainer
onready var GROUP_MARGIN_Y = sub_scroller.rect_position.y
onready var tab_cont = $tab_cont
onready var tab_main = $tab_cont/tab

func _ready():
	$CloseButton.connect("pressed", self, "hide")
	$CloseButton2.connect("pressed", self, "hide")
	$sub_close.connect("pressed", $sub_close, "hide")
	sub_cont.get_node("close").connect("pressed", $sub_close, "hide")
	$Reset.connect("pressed", self, "ask_reset")
	tab_main.connect("pressed", self, "on_tab_pressed", [tab_main])
	tab_main.set_meta("id", "main")

func try_add_achi_group(group_name):
	if achi_groups.has(group_name):
		return
	achi_groups[group_name] = {locked = [], unlocked = []}
	if group_name == "main":
		return
	
	var new_tab = input_handler.DuplicateContainerTemplate(tab_cont, "tab")
	var group = input_handler.achievements.get_group(group_name)
	new_tab.get_node("Label").text = tr(group.name)
	new_tab.set_meta("id", group.id)
	new_tab.connect("pressed", self, "on_tab_pressed", [new_tab])

func try_add_achi_subs(lord_name):
	if achi_subs.has(lord_name):
		return
	achi_subs[lord_name] = {locked = [], unlocked = []}

func show():
	try_add_achi_group("main")
	for status in ["unlocked", "locked"]:
		var dict
		if status == "unlocked":
			dict = input_handler.achievements.get_unlocked_achimnts()
		else:#status == "locked":
			dict = input_handler.achievements.get_locked_achimnts()
		for achi_name in dict:
			var achi = dict[achi_name]
			if achi.has("group"):
				try_add_achi_group(achi.group)
				achi_groups[achi.group][status].append(achi)
			elif achi.has("sub_to"):
				try_add_achi_subs(achi.sub_to)
				achi_subs[achi.sub_to][status].append(achi)
			else:
				achi_groups.main[status].append(achi)
	
	$achi_points_cont/points.text = str(input_handler.achievements.get_all_points())
	
	tab_main.pressed = true
	on_tab_pressed(tab_main)
	
	.show()

func hide():
	input_handler.ClearContainer(achi_cont, ["achi"])
	input_handler.ClearContainer(tab_cont, ["tab"])
	achi_groups.clear()
	achi_subs.clear()
	.hide()

func on_tab_pressed(tab):
	var group_name = tab.get_meta("id")
	if !tab.pressed:
		if group_name == "main":
			tab.pressed = true
			return
		group_name = "main"
		tab = tab_main
		tab_main.pressed = true
	for i_tab in tab_cont.get_children():
		if i_tab != tab:
			i_tab.pressed = false
	
	input_handler.ClearContainer(achi_cont, ["achi"])
	for status in ["unlocked", "locked"]:
		var panel_func
		if status == "unlocked":
			panel_func = "set_opened"
		else:#status == "locked"
			panel_func = "set_locked"
		for achi in achi_groups[group_name][status]:
			var new_panel = input_handler.DuplicateContainerTemplate(achi_cont, "achi")
			new_panel.call(panel_func, achi)
			if achi_subs.has(achi.id):
				new_panel.add_group()
				new_panel.connect("open_sublist", self, "open_subs", [new_panel])
	


func open_subs(group_name, parent):
	input_handler.ClearContainer(sub_cont, ["achi", "close"])
	sub_scroller.scroll_vertical_enabled = false
	for achi in achi_subs[group_name].unlocked:
		var new_panel = input_handler.DuplicateContainerTemplate(sub_cont, "achi")
		new_panel.set_opened(achi)
	for achi in achi_subs[group_name].locked:
		var new_panel = input_handler.DuplicateContainerTemplate(sub_cont, "achi")
		new_panel.set_locked(achi)
	sub_cont.get_node("close").raise()
	sub_node.rect_global_position.x = parent.rect_global_position.x - 10
	sub_node.rect_global_position.y = parent.rect_global_position.y + parent.rect_size.y + 4
	
	#for sub_cont to recalc size
	#dont like it one bit! Need to remake it
#	print("befor %s %s" % [sub_scroller.rect_size.y, sub_cont.rect_size.y])
	$sub_close.show()
	yield(get_tree(), 'idle_frame')
#	print("after %s %s" % [sub_scroller.rect_size.y, sub_cont.rect_size.y])
	
	sub_scroller.rect_size.y = sub_cont.rect_size.y
	
	var screen = get_viewport().get_visible_rect()
	if sub_scroller.rect_size.y > screen.size.y:
		sub_node.rect_global_position.y = 0
		sub_scroller.scroll_vertical_enabled = true
		sub_scroller.rect_size.y = screen.size.y - GROUP_MARGIN_Y * 2
	elif sub_scroller.get_global_rect().end.y >= screen.size.y:
		sub_node.rect_global_position.y = screen.size.y - GROUP_MARGIN_Y * 2 - sub_scroller.rect_size.y
	
	sub_node.rect_size.y = sub_scroller.rect_size.y + GROUP_MARGIN_Y * 2

func ask_reset():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'reset', tr("ACHIEVEMENT_RESET_ASK")])

func reset():
	input_handler.achievements.reset()
	hide()
	show()


