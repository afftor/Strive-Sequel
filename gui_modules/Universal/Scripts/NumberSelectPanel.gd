extends Panel

#Reusable "how many?" popup, lifted from the crafting screen's NumberSelect2.
#Opened through input_handler.get_spec_node(input_handler.NODE_NUMBERSELECT, [...]).

#warning-ignore-all:return_value_discarded

var target_node
var target_function
var extra_args = []
var min_value = 1
var max_value = 1
var amount = 1

func _ready():
	$Screen.connect('pressed', self, 'close_panel')
	$CloseButton.connect('pressed', self, 'close_panel')
	$VBoxContainer/HBoxContainer1/pt1/b1.connect('pressed', self, 'number_change', [-10])
	$VBoxContainer/HBoxContainer1/pt1/b2.connect('pressed', self, 'number_change', [-1])
	$VBoxContainer/HBoxContainer1/pt3/b3.connect('pressed', self, 'number_change', [1])
	$VBoxContainer/HBoxContainer1/pt3/b4.connect('pressed', self, 'number_change', [10])
	$VBoxContainer/HBoxContainer1/pt2/Amount.connect('text_entered', self, 'number_text_entered')
	$VBoxContainer/HBoxContainer1/pt2/Amount.connect('focus_exited', self, 'number_text_focus_exited')
	$VBoxContainer/Button.connect('pressed', self, 'confirm')


#header - title above the panel, subject - name shown under the icon.
#On confirm the chosen number is passed to node.call(funcname, amount, ...args).
func open(node, funcname, header = '', subject = '', icon = null, maxvalue = 1, minvalue = 1, startvalue = 1, args = []):
	target_node = node
	target_function = funcname
	extra_args = args
	min_value = int(max(1, minvalue))
	max_value = int(max(min_value, maxvalue))
	amount = clamp_amount(startvalue)
	$Label2.text = header
	$VBoxContainer/name.text = subject
	$VBoxContainer/icon.texture = input_handler.loadimage(icon, 'icons')
	$VBoxContainer/label1.text = tr("CRAFTQUANTITY")
	$VBoxContainer/Button/Label.text = tr("CONFIRM")
	globals.connecttexttooltip($VBoxContainer/HBoxContainer1/pt2/Amount, tr("CRAFTINPOSSESSION") + ": " + str(max_value))
	build_panel()
	show()
	raise()


func clamp_amount(value):
	return int(clamp(int(value), min_value, max_value))


func build_panel():
	$VBoxContainer/HBoxContainer1/pt2/Amount.text = str(amount)


func number_change(value):
	amount = clamp_amount(amount + value)
	build_panel()


func number_text_entered(_text):
	set_number_from_text()


func number_text_focus_exited():
	set_number_from_text()


func set_number_from_text():
	amount = clamp_amount(int($VBoxContainer/HBoxContainer1/pt2/Amount.text))
	build_panel()


func confirm():
	hide()
	if target_node == null or target_function == null:
		return
	var call_args = [amount]
	call_args.append_array(extra_args)
	target_node.callv(target_function, call_args)


func close_panel():
	hide()
