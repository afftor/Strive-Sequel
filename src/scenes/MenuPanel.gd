extends "res://src/scenes/ClosingPanel.gd"

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

func OptionsOpen():
	$Options.open()

func PlayClickSound():
	input_handler.PlaySound("button_click")


func Exit():
	input_handler.get_spec_node(input_handler.NODE_CONFIRMPANEL, [self, 'MainMenu', tr('LEAVECONFIRM')])
	#input_handler.ShowConfirmPanel(self, 'MainMenu', tr('LEAVECONFIRM'))

func MainMenu():
	globals.return_to_main_menu()
