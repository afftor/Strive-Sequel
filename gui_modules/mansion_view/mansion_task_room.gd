extends Button
#One piece of work at another location, drawn as a room so the screen reads the same way
#everywhere: a thing with places in it that people are dropped into.
#
#Dungeon seams are the exception the spec calls for - they take as many hands as you send,
#so they show a count of what is left in the ground instead of a row of places.

const LocationTasks = preload("res://gui_modules/mansion_view/mansion_location_tasks.gd")

var view = null
var entry = null


func setup(view_node, task_entry):
	view = view_node
	entry = task_entry
	set_meta('task', task_entry.id)
	if !is_connected("pressed", self, "on_pressed"):
		connect("pressed", self, "on_pressed")
	refresh()


func refresh():
	modulate = target_modulate()
	$icon.texture = load(entry.icon) if entry.icon != '' else null
	$name.text = tr(entry.name)
	var workers = LocationTasks.workers_of(entry.id)
	$output.text = LocationTasks.production_text(entry.id)
	if entry.unlimited:
		#no places to draw: what matters is how much is left, not how many can dig
		$People.visible = false
		$count.visible = true
		$count.text = "%s %d" % [tr("MANSIONVIEW_REMAINING"), int(entry.remaining)]
	else:
		$count.visible = false
		build_places(workers)
	globals.connecttexttooltip(self, build_tooltip(workers), true)


func build_places(workers):
	input_handler.ClearContainer($People)
	$People.visible = true
	for char_id in workers:
		var cell = input_handler.DuplicateContainerTemplate($People)
		cell.setup(view, 'task', entry.id, char_id)
	for _i in range(max(0, entry.max_workers - workers.size())):
		var cell = input_handler.DuplicateContainerTemplate($People)
		cell.setup(view, 'task', entry.id, null)


func build_tooltip(workers):
	var text = tr(entry.name)
	if entry.descript != '':
		text += "\n" + tr(entry.descript)
	if entry.unlimited:
		text += "\n%s %d" % [tr("MANSIONVIEW_REMAINING"), int(entry.remaining)]
		text += "\n%s %d" % [tr("MANSIONVIEW_WORKERS"), workers.size()]
	else:
		text += "\n%s %d/%d" % [tr("MANSIONVIEW_WORKPLACES"), workers.size(), entry.max_workers]
	var output = LocationTasks.production_text(entry.id)
	if output != "":
		text += "\n%s %s" % [tr("MANSIONVIEW_PERTURN"), output]
	return text


#Somebody in hand goes to work here, the same as dropping them on it. With empty hands
#there is nothing to open - a piece of work out here has no card behind it.
func on_pressed():
	if view.picked_char == null:
		return
	if !can_drop_data(Vector2.ZERO, view.pick_data()):
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_FULL"))
		return
	view.place_picked('task', entry.id, null)


#Whatever will not take the person in hand steps back, the way the mansion's rooms do.
func target_modulate():
	if view.picked_char == null or can_drop_data(Vector2.ZERO, view.pick_data()):
		return Color(1, 1, 1, 1)
	return Color(0.5, 0.5, 0.5, 1)


#Dropping onto the body rather than onto a particular place puts them in the first free
#one - and a dungeon seam always has room.
func can_drop_data(_position, data):
	if !(data is Dictionary) or data.get('kind', '') != 'mansion_char':
		return false
	if entry.unlimited:
		return true
	return LocationTasks.workers_of(entry.id).size() < entry.max_workers


func drop_data(_position, data):
	view.place_character('task', entry.id, data.char_id, null)
