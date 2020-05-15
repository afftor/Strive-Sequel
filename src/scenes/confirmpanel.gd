extends Popup

var targetnode
var targetfunction

func _ready():
#warning-ignore:return_value_discarded
	$Confirm.connect('pressed',self, 'ConfirmPanelConfirm')
#warning-ignore:return_value_discarded
	$Cancel.connect('pressed', self, 'CloseConfirmPanel')

func Show(TargetNode, ConfirmFunction, Text):
	popup()
	$RichTextLabel.bbcode_text = Text
	targetnode = TargetNode
	targetfunction = ConfirmFunction

func ConfirmPanelConfirm():
	hide()
	targetnode.call(targetfunction)


func CloseConfirmPanel():
	hide()

