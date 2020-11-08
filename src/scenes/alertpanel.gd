extends Popup

var targetnode : Object

# Functions to call (methods of `targetnode`); or '' (empty string)
# for no-op.
var left_fn  : String
var right_fn : String

func _ready() -> void:
#warning-ignore:return_value_discarded
	$ButtonL.connect('pressed',self, 'OnLeftButton')
#warning-ignore:return_value_discarded
	$ButtonR.connect('pressed', self, 'OnRightButton')

func ShowConfirmCancel(TargetNode : Object, \
                       ConfirmFunction : String, Text : String) -> void:
        Show(TargetNode, Text, "CONFIRM", ConfirmFunction, "CANCEL", '')

func ShowYesNo(TargetNode : Object, \
               YesFunction : String, Text : String) -> void:
        Show(TargetNode, Text, "YES", YesFunction, "NO", '')

func Show(TargetNode : Object, Text : String, \
          LeftLabel : String, LeftFunc : String, \
          RightLabel : String, RightFunc : String) -> void:
        popup()
        $RichTextLabel.bbcode_text = Text
        targetnode = TargetNode
        left_fn = LeftFunc
        right_fn = RightFunc
        $ButtonL/Label.text = LeftLabel
        $ButtonR/Label.text = RightLabel

func OnLeftButton() -> void:
        hide()
        if left_fn != '':
                targetnode.call(left_fn)

func OnRightButton() -> void:
        hide()
        if right_fn != '':
                targetnode.call(right_fn)
