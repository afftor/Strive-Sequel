extends Control


var GUIWorld


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(Items, "ready")
	print("Items Ready")

