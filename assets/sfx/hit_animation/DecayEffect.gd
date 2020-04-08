extends Sprite

func _ready():
	#play()
	material.set_shader_param('width', 0.7)
	material.set_shader_param('bordmwidth', 0)
	pass

func play():
	var tw = Tween.new()
	add_child(tw)
	tw.interpolate_property(get_material(), "shader_param/width",0.6 , 0, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	tw.interpolate_property(get_material(), "shader_param/bordmwidth",0 , 0.1, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	tw.interpolate_property(get_material(), "shader_param/bordmwidth", 0.1 , 2.0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT, 1)
	tw.interpolate_property(get_material(), "shader_param/bordmval",0.5 , 1.0, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	#tw.interpolate_property(get_material(), "shader_param/crop", 1.0 , 0.0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT, 2)
	tw.start()
