extends Control

var loc_id
var confirm_obj
var confirm_func

func _ready():
	var menu = $teleport_menu
	gui_controller.add_close_button(self, "custom", Vector2(
		rect_size.x - menu.get_rect().end.x,
		menu.rect_position.y
	))

func show():
	gui_controller.windows_opened.append(self)
	.show()

func close():
	$CloseButton.emit_signal("pressed")

func set_loc_id(id):
	loc_id = id

func set_confirm_func(obj, funct):
	confirm_obj = obj
	confirm_func = funct

func teleport_check():
	var char_array = input_handler.get_location_characters_by_id(loc_id)
	var char_ids = []
	for chara in char_array:
		char_ids.append(chara.id)
	var can_tp = $teleport_menu.make_list(char_ids, self, "teleport")
	if !can_tp:
		walk_confirm()
		return
	input_handler.get_spec_node(input_handler.NODE_YESORNOPANEL, [self,
		'show',
		'walk_confirm',
		tr('SENDCHARBACKTPQUESTION')])

func teleport(chid):
	close()
	var caster = characters_pool.get_char_by_id(chid)
	var skill = Skilldata.get_template('teleport', caster)
	caster.pay_cost(skill.cost)
	confirm_obj.call(confirm_func, true)

func walk_confirm():
	confirm_obj.call(confirm_func)
