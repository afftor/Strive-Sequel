extends Control

var s1;
var s2;
var s3;
var s4;

var f1;
var f2;
var f3;
var f4;

func _on_Button_pressed():
	$load.popup();
	pass # Replace with function body.


func _on_Button2_pressed():
	$save.popup();
	pass # Replace with function body.


func _on_Button3_pressed():
	f1 = File.new();
	f1.open(s1, File.READ);
	f2 = File.new();
	f2.open(s2, File.READ_WRITE);
	f2.seek_end();
	f3 = File.new();
	f3.open(s3, File.WRITE);
	var scene = parse_json(f1.get_as_text());
	var ff = s1.get_file();
	var count = 1;
	f3.store_line('[');
	for tmp in scene:
		if tmp['effect'] == 'text':
			var s = tmp['value'];
			var s_n = "%s_%d" % [ff, count];
			var tr_line = '%s,"%s"' % [s_n, s];
			var new_tmp = tmp.duplicate();
			new_tmp['value'] = s_n;
			f2.store_line(tr_line);
			f3.store_line(to_json(new_tmp)+',');
			count += 1;
			pass
		else:
			f3.store_line(to_json(tmp)+',');
			pass
		pass
	f3.store_line(']');
	print("FINISH");
	$load.invalidate();
	pass # Replace with function body.

func _on_Button4_pressed():
	f1 = File.new();
	f1.open(s1, File.READ);
	f4 = File.new();
	f4.open(s4, File.WRITE);
	var scene = parse_json(f1.get_as_text());
	for tmp in scene:
		if tmp['effect'] == 'text':
			tmp.value = tr(tmp.value);
			pass
	var buf = to_json(scene);
	buf = buf.replace('},','},\r\n');
	f4.store_string(buf);
	print("FINISH");
	f4.close();
	$load.invalidate();
	pass 

func _on_load_file_selected(path):
	s1 = path;
	s3 = s1.get_basename() + '_convert.json';
	s4 = s1.get_basename().replace('_convert', '') + '_updated.json';
	pass # Replace with function body.


func _on_save_file_selected(path):
	s2 = path;
	pass # Replace with function body.



