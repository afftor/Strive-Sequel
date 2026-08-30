extends Control

#Everything this panel used to state in words - class, race, fame, price, standing,
#personality - is on the character's card in the mansion list now. What is left here is the
#written description and the hairstyle picker that hangs off it.

var person


func _ready():
	$Description/RichTextLabel.connect("meta_clicked", self, 'text_url_click')
	$Description/RichTextLabel.connect("meta_hover_started", self, 'text_url_hover')
	$Description/RichTextLabel.connect("meta_hover_ended", self, "text_url_hover_hide")
	$HairChange/screen.connect("pressed", self, "close_hairstyle")
	$DescriptionButton.connect("pressed", self, 'toggle_description')

	update()


func toggle_description():
	$Description.visible = !$Description.visible


func update():
	if person != input_handler.interacted_character:
		person = input_handler.interacted_character
	if person != null:
		$Description/RichTextLabel.bbcode_text = person.make_description()


func text_url_click(meta):
	match meta:
		'hair':
			input_handler.ClearContainer($HairChange/hair_style)
			var hairdata = ResourceScripts.descriptions.bodypartsdata.hair_style
			$HairChange.visible = true
			for i in hairdata.values():
				var panel = input_handler.DuplicateContainerTemplate($HairChange/hair_style)
				panel.text = tr(i.name)
				panel.connect('pressed', self, 'confirm_hairstyle', [i.code])
			$HairChange/screen.set_global_position(Vector2(0, 0))
			$HairChange/hair_style.set_global_position(get_viewport().get_mouse_position() - Vector2($HairChange/hair_style.rect_size.x, 0))


func confirm_hairstyle(style):
	person.set_stat('hair_style', style)
	person.set_stat('portrait_update', true)
	$HairChange.visible = false
	update()
	get_parent().update()


func close_hairstyle():
	$HairChange.visible = false


func text_url_hover(meta):
	match meta:
		'race':
			var texttooltip = input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP)
			texttooltip.showup($Description/RichTextLabel, person.show_race_description())
			yield(get_tree(), 'idle_frame')
			texttooltip.rect_global_position = get_global_mouse_position()


func text_url_hover_hide(meta = null):
	match meta:
		'race':
			var texttooltip = input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP)
			texttooltip.hide()
