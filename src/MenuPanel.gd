extends "res://files/Close Panel Button/ClosingPanel.gd"

#warning-ignore-all:return_value_discarded

func _ready():
	$VBoxContainer/Save.connect('pressed', $saveloadpanel, 'SavePanelOpen')
	$VBoxContainer/Load.connect('pressed', $saveloadpanel, 'LoadPanelOpen')
	$VBoxContainer/Options.connect('pressed', self, 'OptionsOpen')
	$VBoxContainer/Exit.connect('pressed', self, 'Exit')
	move_child($InputBlock, 0)
	for i in $VBoxContainer.get_children():
		i.connect("pressed", self, "PlayClickSound")

func open():
	.show()
#	if globals.CurrentScene.get_node("ExploreScreen/combat") != null && globals.CurrentScene.get_node("ExploreScreen/combat").visible:
#		$VBoxContainer/Save.disabled = true
#	else:
#		$VBoxContainer/Save.disabled = false

func OptionsOpen():
	$Options.open()

func PlayClickSound():
	input_handler.PlaySound("button_click")


func Exit():
	input_handler.ShowConfirmPanel(self, 'MainMenu', tr('LEAVECONFIRM'))

func MainMenu():
	globals.CurrentScene.queue_free()
	globals.ChangeScene('menu')
	get_parent().queue_free()