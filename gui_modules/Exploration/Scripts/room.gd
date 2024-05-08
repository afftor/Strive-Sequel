extends Control
const size = 270
#2fix icons
#2add more content
func setup(room_id):
	set_meta('id', room_id)
	$main.connect("pressed", gui_controller.exploration_dungeon, 'room_pressed', [room_id])
	var data = ResourceScripts.game_world.rooms[room_id]
	rect_position.x = data.col * size
	rect_position.y = data.row * size
	for i in range(data.subrooms.size()):
		if data.subrooms[i] == null:
			get_node("subroom%d"%(i + 1)).visible = false
		else:
			get_node("subroom%d"%(i + 1)).visible = true
			get_node("subroom%d"%(i + 1)).connect("pressed", gui_controller.exploration_dungeon, 'subroom_pressed', [room_id, i])
	update()


func update():
	if !has_meta('id'):
		return
	var room_id = get_meta('id')
	var data = ResourceScripts.game_world.rooms[room_id]
	for i in data.neighbours:
		if data.neighbours[i] == null:
			get_node(i).visible = false
		else:
			var tdata = ResourceScripts.game_world.rooms[data.neighbours[i]]
			if tdata.status == 'hidden':
				get_node(i).visible = false
			else:
				get_node(i).visible = true
				if data.status == 'cleared' or data.type == 'ladder_up':
					get_node(i).modulate = Color(variables.hexcolordict.green)
					continue
				if tdata.status == 'cleared' or tdata.type == 'ladder_up':
					get_node(i).modulate = Color(variables.hexcolordict.green)
					continue
				get_node(i).modulate = Color(variables.hexcolordict.red)
	for i in range(data.subrooms.size()):
		if data.subrooms[i] == null:
			continue
		else:
			get_node("subroom%d"%(i + 1)).disabled = false
			var sb_text = ""
			match data.subrooms[i].type:
				'empty':
					get_node("subroom%d/icon"%(i + 1)).texture = null
					sb_text += "Subroom - empty"
				'event', 'unique_event', 'onetime_event':
					var icon = data.subrooms[i].icon
					get_node("subroom%d/icon"%(i + 1)).texture = images.icons[icon]
					sb_text += "Subroom - event, stamina cost - %d" % data.subrooms[i].stamina_cost
				'resource':
					get_node("subroom%d/icon"%(i + 1)).texture = load("res://assets/Textures_v2/Universal/Icons/icon_resources_pressed.png")
					sb_text += "Subroom - resource, stamina cost - %d" % data.subrooms[i].stamina_cost
			globals.connecttexttooltip(get_node("subroom%d"%(i + 1)), sb_text)
	var text = ""
	match data.status:
		'cleared':
			visible = true 
			$main/icon.texture = null
			text += "empty room"
		'scouted':
			visible = true
			for i in range(data.subrooms.size()):
				if data.subrooms[i] == null:
					continue
				else:
					get_node("subroom%d"%(i + 1)).disabled = true
			match data.type:
				'empty':
					$main/icon.texture = null
				'combat':
					$main/icon.texture = load("res://assets/Textures_v2/DUNGEON/Icons/swords_fight.png")
				'combat_boss':
					$main/icon.texture = load("res://assets/Textures_v2/Universal/Icons/icon_weapon_pressed.png")
				'event':
					$main/icon.texture = load("res://assets/Textures_v2/DUNGEON/Icons/exclaim.png")
				'ladder_down':
					$main/icon.texture = load("res://assets/Textures_v2/DUNGEON/Icons/steps.png")
				'ladder_up':
					$main/icon.texture = load("res://assets/Textures_v2/DUNGEON/Icons/steps.png")
			text += "Room, enter cost - %d" % data.stamina_cost
		'obscured':
			visible = true
			$main/icon.texture = load("res://assets/Textures_v2/DUNGEON/Icons/question.png")
			for i in range(data.subrooms.size()):
				if data.subrooms[i] == null:
					continue
				else:
					get_node("subroom%d"%(i + 1)).disabled = true
					get_node("subroom%d/icon"%(i + 1)).texture = load("res://assets/Textures_v2/DUNGEON/Icons/question.png")
					globals.connecttexttooltip(get_node("subroom%d"%(i + 1)), "unknown subroom")
			text += "Unknown room, enter cost - %d" % data.stamina_cost
		'hidden':
			visible = false
		
	globals.connecttexttooltip($main, text)
