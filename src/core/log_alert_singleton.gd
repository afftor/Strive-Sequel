extends Timer

var file
var path
var last_pos = 0
var last_time = 0
var alert_node
var cash_str = ""

func _ready():
	if !variables.use_log_alert:
		queue_free()
		return
	
	wait_time = 1.0
	set_log_file()
	connect("timeout", self, "check_log")
	if input_handler.globalsettings.stop_log_alert:
		stop()
	else:
		start()

func set_log_file():
	if path != null:
		return
	path = ProjectSettings.get_setting("logging/file_logging/log_path")
	file = File.new()

#can be called befor _ready()
func fix_cur_log_position():
	set_log_file()
	file.open(path, File.READ)
	last_pos = file.get_len()
	file.close()

func check_log():
	var new_time = file.get_modified_time(path)
	if last_time == new_time:
		return
	
	last_time = new_time
	file.open(path, File.READ)
	file.seek(last_pos)
	while file.get_position() < file.get_len():
		var line = file.get_line()
#		if line.findn("error") != -1:
		show_string(line)
	last_pos = file.get_position()
	file.close()

func show_string(input_str :String):
	if alert_node != null:
		alert_node.open()
		alert_node.add_text(input_str + "\n")
	else:
		push_error("No alert_node in log_alert")
		#In normal case (after console withdraw) cash_str shouldn't be in use, but I'm keeping it for reinsurance
		cash_str += input_str + "\n"

func set_alert_node(new_node):
	alert_node = new_node
	if new_node != null and !cash_str.empty():
		alert_node.add_text(cash_str)
		cash_str = ""

func stop_check_log():
	input_handler.globalsettings.stop_log_alert = true
	stop()

func resume_check_log():
	input_handler.globalsettings.stop_log_alert = false
	start()
