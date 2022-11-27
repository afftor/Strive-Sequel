extends Control
# Called when the node enters the scene tree for the first time.
var IsActive = false
onready var _RichTextLabel = get_node("Console/RichTextLabel")

func _ready():
	get_tree().root.get_node("MansionMainModule").call_deferred("remove_child",self)
	get_tree().root.call_deferred("add_child",self)
	pass

func _input(event):
	if event.is_action_pressed("ConsoleOpenButton"):
		if (IsActive == false):
			var place = get_tree().root.get_child_count()
			get_tree().root.call_deferred("move_child",self,place)
			#get_tree().root.set_disable_input(true)
			
			IsActive = true
			visible = true
		else :
			#get_tree().root.set_disable_input(false)
			visible = false
			IsActive = false
	pass
func _unhandled_input(event):
	pass


func _on_TextEdit_text_entered(new_text):
	var splitstring = new_text.split(" ")
	if splitstring[0] == "/do" :
		var jsonstring = JSON.parse(splitstring[1])
		#если не удалось спарсить то пишем почему и выходим из метода
		if jsonstring.error:
			_RichTextLabel.text += jsonstring.error_string + "\n"
			return
		#если все норм, то результат оборачиваем в  массив словарей
		var command = [jsonstring.result]
		#и отправляем на выполнение
		var a = globals.common_effects(command)
		
		_RichTextLabel.text += new_text + "\n"
		
		if a != null:
			_RichTextLabel.text += a + "\n"
		else:
			_RichTextLabel.text += "Command complete \n"
	elif splitstring[0] == "/launch" :
		var a = input_handler.interactive_message(splitstring[1])
		
		_RichTextLabel.text += new_text + "\n"
		
		if a != null:
			_RichTextLabel.text += a + "\n"
		else:
			_RichTextLabel.text += "Command complete \n"
		
	pass # Replace with function body.
