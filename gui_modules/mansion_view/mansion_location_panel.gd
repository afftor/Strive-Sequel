extends Control
#The screen for anywhere that is not the mansion. There is no floorplan out here and
#nothing to arrange: each thing that can be worked on is drawn as a room with places in
#it, over a picture of the place itself.
#
#Beds do not exist here either - everyone sleeps in the mansion wherever they are on the
#world map - so this panel only ever shows work.

const LocationTasks = preload("res://gui_modules/mansion_view/mansion_location_tasks.gd")

var view = null
var entries = []


func setup(view_node):
	view = view_node
	visible = false


func rebuild(location_code):
	$Background.texture = LocationTasks.location_background(location_code)
	$Title.text = LocationTasks.location_name(location_code)
	entries = LocationTasks.tasks_for(location_code)
	input_handler.ClearContainer($Rooms)
	for entry in entries:
		var node = input_handler.DuplicateContainerTemplate($Rooms)
		node.setup(view, entry)
	$Empty.text = tr("MANSIONVIEW_NOTHINGHERE")
	$Empty.visible = entries.empty()


#People move without the list of jobs changing, so this is the cheap path.
func refresh_places():
	for node in $Rooms.get_children():
		if node.has_meta('task') and !node.is_queued_for_deletion():
			node.refresh()
