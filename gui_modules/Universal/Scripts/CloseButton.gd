extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "close_parent")

func close_parent():
	ResourceScripts.core_animations.FadeAnimation(get_parent())
