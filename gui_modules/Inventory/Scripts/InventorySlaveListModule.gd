extends Panel

var selectedhero


func update():
	selectedhero = input_handler.interacted_character
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		var newnode = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newnode.get_node("Label").text = i.get_full_name()
		if i.is_master() or i.is_unique():
			newnode.get_node("Label").set("custom_colors/font_color", variables.hexcolordict.unique)
		newnode.pressed = (i == selectedhero)
		if i.is_on_quest():
			newnode.disabled = true
			newnode.set("modulate", Color(1,0,0,1))
		newnode.connect("pressed", get_parent(), "set_active_hero", [i])
		var work = i.get_work()
		var gatherable = Items.materiallist.has(work)
		if work in ['', 'Assignment', 'disabled']:
			if i.is_on_quest():
				pass
				#stub
				newnode.get_node("ToolIcon").texture = null
				newnode.get_node("TaskIcon").texture = null
			else:
				newnode.get_node("ToolIcon").texture = null
				newnode.get_node("TaskIcon").texture = load("res://assets/images/gui/gui icons/icon_rest_brothel.png")
				globals.connecttexttooltip(newnode.get_node("TaskIcon"), tr('REST')) #2test, not sure if assignments are here or in upper block
		elif work == 'special':
			var task = i.find_worktask()
			newnode.get_node("ToolIcon").texture = null
			newnode.get_node("TaskIcon").texture = load(task.icon)
			globals.connecttexttooltip(newnode.get_node("TaskIcon"), tr(task.name))
		elif gatherable:
			var res = Items.materiallist[work]
			newnode.get_node("TaskIcon").texture = res.icon
			globals.connecttexttooltip(newnode.get_node("TaskIcon"), tr(res.name))
			if res.has('tool_type'):
				#stub
				var worktool = Items.itemlist[res.tool_type]
				newnode.get_node("ToolIcon").texture = worktool.icon
				globals.connecttexttooltip(newnode.get_node("ToolIcon"), tr(worktool.name))
			else:
				newnode.get_node("ToolIcon").texture = null
		else:
			var task = races.tasklist[work]
			if task.has('production_icon'):
				newnode.get_node("TaskIcon").texture = task.production_icon
				globals.connecttexttooltip(newnode.get_node("TaskIcon"), tr(task.descript))
			elif task.has('production_item'):
				newnode.get_node("TaskIcon").texture = Items.materiallist[task.production_item].icon
				globals.connecttexttooltip(newnode.get_node("TaskIcon"), tr(task.descript))
			else:
				newnode.get_node("TaskIcon").texture = null
			if task.has('worktool'):
				#stub
				var worktool = Items.itemlist[task.worktool]
				newnode.get_node("ToolIcon").texture = worktool.icon
				globals.connecttexttooltip(newnode.get_node("ToolIcon"), tr(worktool.name))
			else:
				newnode.get_node("ToolIcon").texture = null
