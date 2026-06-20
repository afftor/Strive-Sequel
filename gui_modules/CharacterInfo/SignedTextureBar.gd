extends Control

export(float, -100, 100, 1) var value = 0 setget set_value


func _ready():
	update_value()


func set_value(new_value):
	value = clamp(new_value, -100, 100)
	if is_inside_tree():
		update_value()


func update_value():
	$Negative.value = max(-value, 0)
	$Positive.value = max(value, 0)
