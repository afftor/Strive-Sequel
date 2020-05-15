extends "res://src/scenes/ClosingPanel.gd"

#warning-ignore-all:return_value_discarded

var showntext
var target_function
var target_node
var require_gold
var cost

func _ready():
	$Button.connect('pressed', self, "confirm_number_selection")
	$HSlider.connect("value_changed", self, "change_number_selection")

func open(targetnode = null, targetfunction = null, text = '', itemcost = 0, minvalue = 0, maxvalue = 100, requiregold = false):
	show()
	showntext = text
	target_function = targetfunction
	target_node = targetnode
	cost = itemcost
	$HSlider.value = 1
	$HSlider.min_value = minvalue
	$HSlider.max_value = maxvalue
	require_gold = requiregold
	update()

func update():
	if require_gold == false:
		$Button.disabled = $HSlider.value == 0 
	else:
		$Button.disabled = $HSlider.value == 0 || ResourceScripts.game_res.money < $HSlider.value * cost
	$RichTextLabel.bbcode_text = showntext.replace("$n", str($HSlider.value)).replace("$m", str($HSlider.value*cost))

func confirm_number_selection():
	target_node.call(target_function, $HSlider.value)
	hide()

func change_number_selection(value):
	update()
