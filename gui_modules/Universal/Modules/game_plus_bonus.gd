extends Control

func _ready():
	$btn.connect("toggled", self, "on_btn_toggled")

func on_btn_toggled(pressed):
	$CheckBox.pressed = pressed

func set_disable(value):
	$btn.disabled = value
	$CheckBox.disabled = value

func is_disabled():
	return $btn.disabled
