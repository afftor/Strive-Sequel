extends HBoxContainer


var mainnode

func _ready():
	globals.connect("hour_tick", self, "update")

func update():
	var dungeon = false
	var selected_location = input_handler.active_location
	input_handler.ClearContainer(self)
	if selected_location == null:
		return
#	var location = ResourceScripts.world_gen.get_location_from_code(selected_location)
	if selected_location.type == "quest_location":
		return
	
	for r_task in ['recruit_easy', 'recruit_hard']:
		if selected_location.has('tags') and selected_location.tags.has(r_task):
			var newbutton = input_handler.DuplicateContainerTemplate(self)
			var jobdata = tasks.tasklist[r_task]
			newbutton.get_node("TextureRect").texture = jobdata.production_icon
			var max_workers_count = jobdata.base_workers
			var current_workers_count = 0
			for task in ResourceScripts.game_party.active_tasks:
				if (task.code == r_task) && (task.task_location == selected_location.code):
					current_workers_count = task.workers.size()
			newbutton.get_node("Label").text = str(max_workers_count - current_workers_count) + "/" + str(max_workers_count)
			globals.connecttexttooltip(newbutton, jobdata.descript)
	
	var gatherable_resources
	if selected_location.type in ["dungeon",'encounter']:
		dungeon = true
		if !selected_location.has('gather_limit_resources') or selected_location.gather_limit_resources.empty():
			self.visible = false
			gatherable_resources = null
#			if selected_location.completed:
		else:
			self.visible = true
			gatherable_resources = selected_location.gather_limit_resources
	else:
		if selected_location.has("category"):
			if selected_location.category != "capital":
				gatherable_resources = selected_location.gather_resources
		else:
			gatherable_resources = selected_location.gather_resources
		self.visible = true
	
	if gatherable_resources != null:
		for i in gatherable_resources:
			var item = Items.materiallist[i]
			var newbutton = input_handler.DuplicateContainerTemplate(self)
			if ResourceScripts.game_progress.can_gather_item(i):
				newbutton.get_node("TextureRect").texture = Items.materiallist[i].icon
				newbutton.set_meta("exploration", true)
				if dungeon:
					newbutton.get_node("Label").text = str(gatherable_resources[i])
					newbutton.set_meta("gather_mod", round(selected_location.gatherable_resources[i].gather_mod * 100))
				else:
					var max_workers_count = gatherable_resources[i]
					var current_workers_count = 0
					var active_tasks = ResourceScripts.game_party.active_tasks
					for task in active_tasks:
						if (task.code == i) && (task.task_location == selected_location.code):
							current_workers_count = task.workers.size()
					newbutton.set_meta("max_workers", max_workers_count)
					newbutton.set_meta("current_workers", current_workers_count)
					newbutton.get_node("Label").text = str(max_workers_count - current_workers_count) + "/" + str(max_workers_count)
				globals.connectmaterialtooltip(newbutton, item)
			else:
				newbutton.get_node("TextureRect").texture = load("res://assets/Textures_v2/Travel/placer_travel_question.png")
				newbutton.get_node("Label").text = ""
