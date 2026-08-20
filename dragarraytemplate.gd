extends Control
#mb we should dissect this script in two for clarity reasons

var arraydata
var parentnodearray
var target_node
var target_function
#lists that reorder their rows for display turn this off: a drop would write the visual
#position back into the array and no longer match what is on screen
var drag_enabled = true
export(NodePath) var drag_preview_source = NodePath("")
export(Vector2) var drag_preview_size = Vector2()

signal mouse_exited_custom
signal dropped

func get_drag_data(position):
	if !drag_enabled:
		return null
	set_drag_preview(build_drag_preview())
	return {data = arraydata, arr = parentnodearray}


func build_drag_preview():
	if drag_preview_source != NodePath("") and has_node(drag_preview_source):
		var source = get_node(drag_preview_source)
		if source is TextureRect and source.texture != null:
			var preview = TextureRect.new()
			preview.texture = source.texture
			preview.expand = true
			preview.stretch_mode = source.stretch_mode
			preview.flip_h = source.flip_h
			preview.flip_v = source.flip_v
			preview.mouse_filter = MOUSE_FILTER_IGNORE
			preview.rect_size = drag_preview_size if drag_preview_size != Vector2() else source.rect_size
			preview.rect_position = -preview.rect_size * 0.5
			return preview
	return self.duplicate()

#Only another entry of this very list, being dragged into a new position, is a drop. Other
#drags pass over these entries - the mansion screen has portraits being carried about - and
#reaching for 'arr' on a payload that has none is an error, not a false.
func can_drop_data(position, data):
	if !drag_enabled or !(data is Dictionary) or !data.has('arr'):
		return false
	return data.arr == parentnodearray

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
