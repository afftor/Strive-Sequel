extends Control
#mb we should dissect this script in two for clarity reasons

var arraydata
var parentnodearray
var target_node
var target_function
#lists that reorder their rows for display turn this off: a drop would write the visual
#position back into the array and no longer match what is on screen
var drag_enabled = true

signal mouse_exited_custom
signal dropped

func get_drag_data(position):
	if !drag_enabled:
		return null
	set_drag_preview(self.duplicate())
	return {data = arraydata, arr = parentnodearray}

func can_drop_data(position, data):
	return drag_enabled and data.arr == parentnodearray

func drop_data(position, data):
	if str(data.data) == str(arraydata):
		return
	var order1 = parentnodearray.find(data.data)
	var order2 = parentnodearray.find(arraydata)

	parentnodearray.erase(data.data)
	parentnodearray.insert(order2, data.data)
	target_node.call(target_function)
	emit_signal("dropped")
	#get_parent().get_parent().get_parent().get_parent().change_order()

func _ready():
	connect("mouse_exited", self, 'check_mouse_exit')

func check_mouse_exit():
	if !get_global_rect().has_point(get_global_mouse_position()):
		emit_signal("mouse_exited_custom")
