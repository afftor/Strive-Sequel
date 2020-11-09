extends HBoxContainer


var mainnode

func _ready():
	globals.connect("hour_tick", self, "update")

func update():
	var dungeon = false
	var selected_location = input_handler.active_location
	if selected_location == null:
		return
#	var location = ResourceScripts.world_gen.get_location_from_code(selected_location)
	if selected_location.type == "quest_location":
		return
	var gatherable_resources
	if selected_location.type in ["dungeon",'encounter']:
		dungeon = true
		self.visible = selected_location.completed
		if selected_location.completed:
			gatherable_resources = selected_location.gather_limit_resources
	else:
		if selected_location.has("category"):
			if selected_location.category != "capital":
				gatherable_resources = selected_location.gather_resources
		else:
			gatherable_resources = selected_location.gather_resources
		self.visible = true
		
	input_handler.ClearContainer(self)
	if gatherable_resources != null:
		for i in gatherable_resources:
			var item = Items.materiallist[i]
			var newbutton = input_handler.DuplicateContainerTemplate(self)
			newbutton.get_node("TextureRect").texture = Items.materiallist[i].icon
			newbutton.set_meta("exploration", true)
			if dungeon:
				newbutton.get_node("Label").text = str(gatherable_resources[i])
				newbutton.set_meta("gather_mod", round(selected_location.gather_mod*100))
			else:
				var max_workers_count = gatherable_resources[i]
				var current_workers_count = 0
				var active_tasks = ResourceScripts.game_party.active_tasks
				for task in active_tasks:
					if (task.code == i) && (task.task_location == selected_location.code):
						current_workers_count = task.workers_count
				newbutton.set_meta("max_workers", max_workers_count)
				newbutton.set_meta("current_workers", current_workers_count)
				newbutton.get_node("Label").text = str(max_workers_count - current_workers_count) + "/" + str(max_workers_count)
			globals.connectmaterialtooltip(newbutton, item)
