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
	for i in range(data.subrooms.size()):
		if data.subrooms[i] == null:
			continue
		else:
			get_node("subroom%d"%(i + 1)).disabled = false
			match data.subrooms[i].type:
				'empty':
					get_node("subroom%d/icon"%(i + 1)).texture = null
				'event', 'unique_event', 'onetime_event':
					get_node("subroom%d/icon"%(i + 1)).texture = load("res://assets/Textures_v2/Universal/Icons/icon_all_pressed.png")
				'resource':
					get_node("subroom%d/icon"%(i + 1)).texture = load("res://assets/Textures_v2/Universal/Icons/icon_resources_pressed.png")
	match data.status:
		'cleared':
			visible = true 
			$main/icon.texture = null
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
					$main/icon.texture = load("res://assets/Textures_v2/Universal/Icons/icon_weapon.png")
				'combat_boss':
					$main/icon.texture = load("res://assets/Textures_v2/Universal/Icons/icon_weapon_pressed.png")
				'event':
					$main/icon.texture = load("res://assets/Textures_v2/Universal/Icons/icon_all_pressed.png")
				'ladder_down':
					$main/icon.texture = load("res://assets/Textures_v2/Universal/Icons/icon_travel_dungeon.png")
				'ladder_up':
					$main/icon.texture = load("res://assets/Textures_v2/Universal/Icons/icon_travel_dungeon.png")
		'obscured':
			visible = true
			$main/icon.texture = load("res://assets/Textures_v2/icon_question_small.png")
			for i in range(data.subrooms.size()):
				if data.subrooms[i] == null:
					continue
				else:
					get_node("subroom%d"%(i + 1)).disabled = true
					get_node("subroom%d/icon"%(i + 1)).texture = load("res://assets/Textures_v2/icon_question_small.png")
		'hidden':
			visible = false
