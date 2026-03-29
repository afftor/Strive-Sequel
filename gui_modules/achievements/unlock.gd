extends Control

onready var cont = $VBoxContainer
onready var achi_label = $VBoxContainer/achi_label
onready var bonus_label = $VBoxContainer/bonus_label

const TIME_ON_SCREEN = 10.0

func _ready():
	$timer.connect("timeout", self, "close")

#don't needed in fact, while there is queue_free() at end
#func open():
#	achi_label.hide()
#	bonus_label.hide()
#	input_handler.ClearContainer(cont, [
#		"achi_label", "achi", "bonus_label", "bonus"])
#	show()
#	$timer.start(TIME_ON_SCREEN)

func close():
	ResourceScripts.core_animations.FadeAnimation(self, 2.0)
	var tweennode = input_handler.GetTweenNode(self)
	if !tweennode.is_connected("tween_all_completed", self, "queue_free"):
		tweennode.connect("tween_all_completed", self, "queue_free", [], CONNECT_ONESHOT)

func add_achi(data):
	var new_panel = input_handler.DuplicateContainerTemplate(cont, "achi")
	cont.move_child(new_panel, cont.get_node("bonus_label").get_index())
	new_panel.set_opened(data)
	achi_label.show()
	restart_timer()
func add_bonus(data):
	var new_panel = input_handler.DuplicateContainerTemplate(cont, "bonus")
	new_panel.set_opened(data)
	bonus_label.show()
	restart_timer()

func restart_timer():
	var tweennode = input_handler.GetTweenNode(self)
	if tweennode.is_active():
		tweennode.stop_all()
		tweennode.reset_all()
	$timer.start(TIME_ON_SCREEN)
	yield(get_tree(), 'idle_frame')
	raise()

