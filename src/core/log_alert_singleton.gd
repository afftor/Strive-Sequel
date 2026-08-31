extends Timer

var file
var path
var last_pos = 0
var last_len = 0
var alert_node
var cash_str = ""

#a mirror of the engine log where every line carries the wall clock time it appeared
const STAMPED_DIR = "user://logs"
const STAMPED_PREFIX = "stamped_"
const STAMPED_KEEP = 10
var stamped_path = ""

var debug_log = {
	check_log_attempts = 0,
	log_modified = 0,
	show_string_sessions = 0
}
var debug_log_time = 60000
var last_debug_log_show = 0

func _ready():
	if !variables.use_log_alert:
		queue_free()
		return
	
	wait_time = 1.0
	set_log_file()
	set_stamped_file()
	connect("timeout", self, "check_log")
	#the timer runs even while alerts are muted, so the timestamped log has no holes in it
	start()
	last_debug_log_show = Time.get_ticks_msec()

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
	if Time.get_ticks_msec() > last_debug_log_show + debug_log_time:
		last_debug_log_show = Time.get_ticks_msec()
#		print(debug_log)
	debug_log.check_log_attempts += 1
	var err = file.open(path, File.READ)
	if err != OK:
		print("log_alert can't open log file! Error code: %s" % err)
		return
	var new_len = file.get_len()
	if last_len == new_len:
		file.close()
		return
	
	last_len = new_len
	debug_log.log_modified += 1
	file.seek(last_pos)
	var new_lines = []
	while file.get_position() < file.get_len():
		new_lines.append(file.get_line())
	last_pos = file.get_position()
	file.close()
	
	if new_lines.empty():
		return
	var stamp = time_stamp()
	write_stamped(new_lines, stamp)
	if input_handler.globalsettings.stop_log_alert:
		return
	debug_log.show_string_sessions += 1
	for line in new_lines:
		show_string("[%s] %s" % [stamp.right(11), line])

func time_stamp() -> String:
	var t = OS.get_datetime()
	return "%04d-%02d-%02d %02d:%02d:%02d" % [t.year, t.month, t.day, t.hour, t.minute, t.second]

func set_stamped_file():
	var dir = Directory.new()
	if !dir.dir_exists(STAMPED_DIR):
		var mk_err = dir.make_dir_recursive(STAMPED_DIR)
		if mk_err != OK:
			print("log_alert can't create %s! Error code: %s" % [STAMPED_DIR, mk_err])
			return
	if dir.open(STAMPED_DIR) == OK:
		prune_stamped_files(dir)
	var t = OS.get_datetime()
	stamped_path = "%s/%s%04d-%02d-%02d_%02d.%02d.%02d.log" % [STAMPED_DIR, STAMPED_PREFIX, t.year, t.month, t.day, t.hour, t.minute, t.second]
	write_stamped(["log_alert started, mirroring %s" % path], time_stamp())

#only ever touches the files this mirror writes, the engine prunes its own godot_* logs itself
func prune_stamped_files(dir :Directory):
	var found = []
	dir.list_dir_begin(true, true)
	var entry = dir.get_next()
	while entry != "":
		if entry.begins_with(STAMPED_PREFIX) and entry.ends_with(".log"):
			found.append(entry)
		entry = dir.get_next()
	dir.list_dir_end()
	found.sort()
	while found.size() >= STAMPED_KEEP:
		dir.remove(found.pop_front())

func write_stamped(lines :Array, stamp :String):
	if stamped_path.empty() or lines.empty():
		return
	var out = File.new()
	var err
	if out.file_exists(stamped_path):
		err = out.open(stamped_path, File.READ_WRITE)
		if err == OK:
			out.seek_end()
	else:
		err = out.open(stamped_path, File.WRITE)
	if err != OK:
		#give up instead of retrying once a second for the rest of the session
		stamped_path = ""
		print("log_alert can't write the timestamped log! Error code: %s" % err)
		return
	for line in lines:
		out.store_line("[%s] %s" % [stamp, line])
	#closing after every batch keeps the file complete if the game dies mid-session
	out.close()

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

#muting only hides the popup now, the timestamped log keeps recording
func stop_check_log():
	input_handler.globalsettings.stop_log_alert = true

func resume_check_log():
	input_handler.globalsettings.stop_log_alert = false
