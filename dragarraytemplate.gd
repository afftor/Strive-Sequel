extends Control
#mb we should dissect this script in two for clarity reasons

var arraydata
var parentnodearray
var target_node
var target_function

signal mouse_exited_custom

func get_drag_data(position):
	set_drag_preview(self.duplicate())
	return arraydata

func can_drop_data(position, data):
	#print(data)
	return true

func drop_data(position, data):
	if str(data) == str(arraydata):
		return
	var order1 = parentnodearray.find(data)
	var order2 = parentnodearray.find(arraydata)

	parentnodearray.erase(data)
	parentnodearray.insert(order2, data)
	target_node.call(target_function)
	#get_parent().get_parent().get_parent().get_parent().change_order()

func _ready():
	connect("mouse_exited", self, 'check_mouse_exit')

func check_mouse_exit():
	if !get_global_rect().has_point(get_global_mouse_position()):
		emit_signal("mouse_exited_custom")
