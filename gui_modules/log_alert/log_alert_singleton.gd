extends Timer

var file
var path
var last_pos = 0
var last_time = 0
var alert_pack
var alert_node

func _ready():
	if !variables.use_log_alert:
		queue_free()
		return
	
	alert_pack = load("res://gui_modules/log_alert/log_alert.tscn")
	wait_time = 1.0
	path = ProjectSettings.get_setting("logging/file_logging/log_path")
	file = File.new()
	connect("timeout", self, "check_log")
	start()


func check_log():
	var new_time = file.get_modified_time(path)
	if last_time == new_time:
		return
	
	last_time = new_time
	file.open(path, File.READ)
	file.seek(last_pos)
	while file.get_position() < file.get_len():
		var line = file.get_line()
		if line.findn("error") != -1:
			show_string(line)
	last_pos = file.get_position()
	file.close()

func show_string(input_str :String):
	var root = get_tree().get_root()
	if alert_node == null or !is_instance_valid(alert_node):
		alert_node = alert_pack.instance()
		root.add_child(alert_node)
	alert_node.raise()
	alert_node.show_string(input_str)
