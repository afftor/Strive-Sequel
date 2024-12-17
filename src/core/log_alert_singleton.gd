extends Timer

var file
var path
var last_pos = 0
var last_time = 0
var alert_node

func _ready():
	if !variables.use_log_alert:
		queue_free()
		return
	
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
	alert_node.open()
	alert_node.add_text(input_str + "\n")

func set_alert_node(new_node):
	alert_node = new_node

func stop_check_log():
	stop()

func resume_check_log():
	start()
