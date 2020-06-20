extends Control


var tasks = []


func _ready():
	for task in ResourceScripts.game_party.active_tasks:
		if task.code == "building":
			print(task.product)
			print(task.workers)
