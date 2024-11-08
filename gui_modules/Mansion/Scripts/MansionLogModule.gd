extends Panel

func _ready():
	$left.connect("pressed", self, "change_type", ["left"])
	$right.connect("pressed", self, "change_type", ["right"])
	globals.connecttexttooltip($left, tr('LOGLEFTTTOOLTIP'))
	globals.connecttexttooltip($right, tr('LOGRIGHTTOOLTIP'))


func change_type(newtype):
	$ScrollContainer.visible = newtype == "left"
	$ServiceLog.visible = newtype == "right"
	$left.pressed = newtype == "left"
	$right.pressed = newtype == "right"

func clean_service_log():
	for ch in $ServiceLog/VBoxContainer.get_children():
		if ch.visible:
			ch.queue_free()
