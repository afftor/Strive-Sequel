extends Reference
class_name worker

var name
var type
var id
var task
var energy setget energy_set
var maxenergy
var currenttask
var icon
var model

func create(data):
	name = data.name
	type = data.type
	id = "w" + str(state.workeridcounter)
	state.workeridcounter += 1
	maxenergy = data.maxenergy
	energy = data.maxenergy
	icon = data.icon.get_path()
	state.workers[id] = self

func energy_set(value):
	energy = clamp(0, round(value), maxenergy)

func restoreenergy():
	var value = maxenergy - energy
	if state.food > value:
		energy += value
		state.food -= value
		return true
	else:
		if state.food == 0:
			return false
		energy += state.food
		state.food = 0
		return true

func get_task():
	for i in state.tasks:
		if i.worker == id:
			return i
	return null


func serialize():
	var tmp = {};
	var arr = ['name', 'type', 'id', 'task', 'energy', 'maxenergy','icon', 'currenttask', 'model'];
	for prop in arr:
		tmp[prop] = get(prop);
	return tmp

func deserialize(tmp):
	var arr = ['name', 'type', 'id', 'task', 'maxenergy','icon', 'currenttask', 'model'];
	for prop in arr:
		set(prop, tmp[prop]);
	energy = tmp.energy
	#id = int(id)
	pass