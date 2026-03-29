extends Control

var achi_groups = {}
var achi_lords = []
onready var achi_cont = $achi_scroll/achi_cont
onready var bonus_cont = $bonus_scroll/bonus_cont
onready var group_cont = $group_close/group_bg/ScrollContainer/VBoxContainer
onready var group_node = $group_close/group_bg
onready var group_scroller = $group_close/group_bg/ScrollContainer
onready var GROUP_MARGIN_Y = group_scroller.rect_position.y

func _ready():
	$CloseButton.connect("pressed", self, "hide")
	$group_close.connect("pressed", $group_close, "hide")

func add_achi_group(group_name, is_open):
	achi_groups[group_name] = {locked = [], unlocked = []}
	var new_panel = input_handler.DuplicateContainerTemplate(achi_cont, "achi")
	if is_open:
		new_panel.set_opened_group(input_handler.achievements.get_group(group_name))
	else:
		new_panel.set_locked_group(input_handler.achievements.get_group(group_name))
	new_panel.connect("open_group", self, "open_group", [new_panel])

func try_add_achi_subs(lord_name):
	if achi_lords.has(lord_name):
		return
	achi_lords.append(lord_name)
	achi_groups[lord_name] = {locked = [], unlocked = []}

func show():
	input_handler.ClearContainer(achi_cont, ["achi"])
	input_handler.ClearContainer(bonus_cont, ["bonus"])
	achi_groups.clear()
	achi_lords.clear()
	var dict = input_handler.achievements.get_unlocked_achimnts()
	for achi_name in dict:
		var achi = dict[achi_name]
		if achi.has("group"):
			if !achi_groups.has(achi.group):
				add_achi_group(achi.group, true)
			achi_groups[achi.group].unlocked.append(achi)
		elif achi.has("sub_to"):
			try_add_achi_subs(achi.sub_to)
			achi_groups[achi.sub_to].unlocked.append(achi)
		else:
			var new_panel = input_handler.DuplicateContainerTemplate(achi_cont, "achi")
			new_panel.set_opened(achi)
	dict = input_handler.achievements.get_locked_achimnts()
	for achi_name in dict:
		var achi = dict[achi_name]
		if achi.has("group"):
			if !achi_groups.has(achi.group):
				add_achi_group(achi.group, false)
			achi_groups[achi.group].locked.append(achi)
		elif achi.has("sub_to"):
			try_add_achi_subs(achi.sub_to)
			achi_groups[achi.sub_to].locked.append(achi)
		else:
			var new_panel = input_handler.DuplicateContainerTemplate(achi_cont, "achi")
			new_panel.set_locked(achi)
	
	if !achi_lords.empty():
		for node in achi_cont.get_children():
			if achi_lords.has(node.get_achi_name()):
				node.add_group()
				node.connect("open_group", self, "open_group", [node])
	
	dict = input_handler.achievements.get_unlocked_bonuses()
	for bonus_name in dict:
		var new_panel = input_handler.DuplicateContainerTemplate(bonus_cont, "bonus")
		new_panel.set_opened(dict[bonus_name])
	dict = input_handler.achievements.get_locked_bonuses()
	for bonus_name in dict:
		var new_panel = input_handler.DuplicateContainerTemplate(bonus_cont, "bonus")
		new_panel.set_locked(dict[bonus_name])
	
	.show()

func open_group(group_name, parent):
	input_handler.ClearContainer(group_cont, ["achi"])
	group_scroller.scroll_vertical_enabled = false
	for achi in achi_groups[group_name].unlocked:
		var new_panel = input_handler.DuplicateContainerTemplate(group_cont, "achi")
		new_panel.set_opened(achi)
	for achi in achi_groups[group_name].locked:
		var new_panel = input_handler.DuplicateContainerTemplate(group_cont, "achi")
		new_panel.set_locked(achi)
	group_node.rect_global_position.x = parent.rect_global_position.x - 10
	group_node.rect_global_position.y = parent.rect_global_position.y + parent.rect_size.y + 4
	
	#for group_cont to recalc size
	#dont like it one bit! Need to remake it
#	print("befor %s %s" % [group_scroller.rect_size.y, group_cont.rect_size.y])
	$group_close.show()
	yield(get_tree(), 'idle_frame')
#	print("after %s %s" % [group_scroller.rect_size.y, group_cont.rect_size.y])
	
	group_scroller.rect_size.y = group_cont.rect_size.y
	
	var screen = get_viewport().get_visible_rect()
	if group_scroller.rect_size.y > screen.size.y:
		group_node.rect_global_position.y = 0
		group_scroller.scroll_vertical_enabled = true
		group_scroller.rect_size.y = screen.size.y - GROUP_MARGIN_Y * 2
	elif group_scroller.get_global_rect().end.y >= screen.size.y:
		group_node.rect_global_position.y = screen.size.y - GROUP_MARGIN_Y * 2 - group_scroller.rect_size.y
	
	group_node.rect_size.y = group_scroller.rect_size.y + GROUP_MARGIN_Y * 2


