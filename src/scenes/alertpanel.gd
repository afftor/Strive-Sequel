extends Popup

var targetnode : Object

# Functions to call (methods of `targetnode`); or '' (empty string)
# for no-op.
var left_fn  : String
var right_fn : String
onready var left_btn = $RichTextLabel/TextureRect/ButtonL
onready var left_btn_label = $RichTextLabel/TextureRect/ButtonL/Label
onready var right_btn = $RichTextLabel/TextureRect/ButtonR
onready var right_btn_label = $RichTextLabel/TextureRect/ButtonR/Label
onready var bg_panel = $RichTextLabel/TextureRect

func _ready() -> void:
#warning-ignore:return_value_discarded
	left_btn.connect('pressed',self, 'OnLeftButton')
#warning-ignore:return_value_discarded
	right_btn.connect('pressed', self, 'OnRightButton')
	bg_panel.connect('resized', self, 'OnBgResized')

func ShowConfirmCancel(TargetNode : Object, \
					   ConfirmFunction : String, Text : String) -> void:
		Show(TargetNode, Text, "CONFIRM", ConfirmFunction, "CANCEL", '')

func ShowYesNo(TargetNode : Object, \
			   YesFunction : String, Text : String) -> void:
		Show(TargetNode, Text, "YES", YesFunction, "NO", '')

func ShowYesOrNo(TargetNode : Object, \
			   YesFunction : String, NoFunction : String, Text : String) -> void:
		Show(TargetNode, Text, "YES", YesFunction, "NO", NoFunction)

# Use '' (the empty string) as label to hide a button.
func Show(TargetNode : Object, Text : String, \
		  LeftLabel : String, LeftFunc : String, \
		  RightLabel : String, RightFunc : String) -> void:
		popup()
		$RichTextLabel.bbcode_text = "[center]" +  globals.TextEncoder(Text) + "[/center]"
		targetnode = TargetNode
		left_fn = LeftFunc
		left_btn_label.text = LeftLabel
		left_btn.visible = (LeftLabel != '')
		right_fn = RightFunc
		right_btn_label.text = RightLabel
		right_btn.visible = (RightLabel != '')

func OnLeftButton() -> void:
		hide()
		if left_fn != '':
			targetnode.call(left_fn)

func OnRightButton() -> void:
		hide()
		if right_fn != '':
				targetnode.call(right_fn)

func OnBgResized() -> void:
	rect_size.y = bg_panel.rect_size.y
