extends TextureButton

export var index = 0;
signal i_pressed(i);

func press():
	emit_signal('i_pressed',index);

func _ready():
#warning-ignore:return_value_discarded
	connect('pressed', self, 'press');


