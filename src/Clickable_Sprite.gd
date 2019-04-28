extends TextureButton

export var charname = "Null"
export var inside_node_name = "";

var next_scene = ""
var active = false
export var is_char = true;

var inside_node = null;
#var timer = 0.0
#var k = 1.0

#func _process(delta):
#	timer += k*delta
#	if timer > 0.8:
#		timer = 0.8
#		k = -1.0
#	if timer < 0.0:
#		timer = 0.0
#		k = 1.0
#	if material == null: return
#	material.set_shader_param('opacity', timer)

func _ready():
	material = load("res://files/portret_shader.tres").duplicate();
	material.set_shader_param('opacity', 0.0);
	if has_node('QuestActive'):
		var node = get_node('QuestActive');
		#node.connect('pressed', self, '_onclick')
		node.connect('mouse_entered', self, 'activate_outline');
		node.connect('mouse_exited', self, 'deactivate_outline');
		node.mouse_filter = MOUSE_FILTER_PASS;
		node.visible = false;
#warning-ignore:return_value_discarded
	connect('pressed', self, '_onclick')
#warning-ignore:return_value_discarded
	connect('mouse_entered', self, 'activate_outline');
#warning-ignore:return_value_discarded
	connect('mouse_exited', self, 'deactivate_outline');
	add_to_group("char_sprite")
	set_active_val()
	regenerate_click_mask()
	if !is_char:
		inside_node = get_parent().get_node(inside_node_name);


func activate_outline():
	if is_char and !active:
		return;
	material.set_shader_param('opacity', 0.8);

func deactivate_outline():
	material.set_shader_param('opacity', 0.0);

func regenerate_click_mask():
	var t = texture_normal.get_data()
	var ti = Image.new()
	ti.copy_from(t)
	var tti = Image.new()
	tti.create(rect_size.x, rect_size.y, false, 5)
	var k = min (tti.get_width()*1.0/ti.get_width(), tti.get_height()*1.0/ti.get_height())
	ti.resize(int(ti.get_width()*k), int(ti.get_height()*k))
	var offset = 0.5*(tti.get_size() - ti.get_size())
	tti.blend_rect(ti, Rect2(Vector2(0,0), ti.get_size()), offset)
	texture_click_mask = BitMap.new()
	texture_click_mask.create_from_image_alpha(tti)

func _onclick():
	if inside_node != null:
		inside_node.open();
	if !active:return
	active = false
	if has_node('QuestActive'):
		$QuestActive.visible = false;
	#material = null
	#set_process(false)
	#.update()
	globals.StartEventScene(next_scene)

func set_active_val():#temporal contruction, until event starting reworking
	if state.CurEvent != "": return
	active = false;
	var f = false;
	for e in events.characters[charname]:
		var res = globals.SimpleEventCheck(e)
		if res:
			f = true
			if has_node('QuestActive'):
				$QuestActive.visible = true;
			if is_char:
				active = true;
				next_scene = e
				#material = load("res://files/portret_shader.tres")
				#set_process(true)
				#.update()
				return
			else:
				break
	if !is_char:
		for e in events.buildings[charname]:
			var res = globals.SimpleEventCheck(e);
			if res:
				f = true
				active = true
				if has_node('QuestActive'):
					$QuestActive.visible = true;
				next_scene = e
				return
	next_scene = "";
	if f == false:
		active = false;
	#material = null
		if has_node('QuestActive'):
			$QuestActive.visible = false;
	#set_process(false)
	#.update()