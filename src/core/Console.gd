extends Control
# Called when the node enters the scene tree for the first time.
var IsActive = false
onready var _RichTextLabel = get_node("Console/RichTextLabel")

func _ready():
	get_tree().root.get_node("MansionMainModule").call_deferred("remove_child",self)
	get_tree().root.call_deferred("add_child",self)
	if log_alert != null and is_instance_valid(log_alert):
		log_alert.set_alert_node(self)
		$log_alert_panel.show()
		$log_alert_panel/CheckBox.connect("toggled", self, "on_hide_errors_toggled")
		$log_alert_panel/close.connect("pressed", self, "close")

func _input(event):
	if event.is_action_pressed("ConsoleOpenButton"):
		if !IsActive:
			open()
		else :
			close()

#func _unhandled_input(event):
#	pass

func open():
	if IsActive: return
	
	var place = get_tree().root.get_child_count()
	get_tree().root.call_deferred("move_child",self,place)
	#get_tree().root.set_disable_input(true)
	
	IsActive = true
	visible = true

func close():
	if !IsActive: return
	
	#get_tree().root.set_disable_input(false)
	visible = false
	IsActive = false

func _on_TextEdit_text_entered(new_text):
	var splitstring = new_text.split(" ")
	if splitstring[0] == "/do" :
		var jsonstring = JSON.parse(splitstring[1])
		#если не удалось спарсить то пишем почему и выходим из метода
		if jsonstring.error:
			add_text(jsonstring.error_string + "\n")
			return
		#если все норм, то результат оборачиваем в  массив словарей
		var command = [jsonstring.result]
		#и отправляем на выполнение
		var a = globals.common_effects(command)
		
		var output_text = new_text + "\n"
		
		if a != null:
			output_text += a + "\n"
		else:
			output_text += "Command complete\n"
		add_text(output_text)
	elif splitstring[0] == "/launch" :
		var a = input_handler.interactive_message(splitstring[1])
		
		var output_text = new_text + "\n"
		
		if a != null:
			output_text += a + "\n"
		else:
			output_text += "Command complete\n"
		add_text(output_text)

func add_text(new_text :String):
	_RichTextLabel.text += new_text

func on_hide_errors_toggled(button_pressed):
	if button_pressed:
		log_alert.stop_check_log()
	else:
		log_alert.resume_check_log()
