extends HBoxContainer
var OkPanel

var flag_textures = {
	"en": preload("res://assets/Textures_v2/UNIVERSAL/Flags/flag_en.png"),
	"es": preload("res://assets/Textures_v2/UNIVERSAL/Flags/flag_es.png"),
	"fr": preload("res://assets/Textures_v2/UNIVERSAL/Flags/flag_fr.png"),
	"it": preload("res://assets/Textures_v2/UNIVERSAL/Flags/flag_it.png"),
	"ru": preload("res://assets/Textures_v2/UNIVERSAL/Flags/flag_ru.png"),
	"zh": preload("res://assets/Textures_v2/UNIVERSAL/Flags/flag_zh.png"),
}

const SELECTED_COLOR = Color(1, 1, 1, 1)
const UNSELECTED_COLOR = Color(0.5, 0.5, 0.5, 1)

var locale_names = {}
var pending_locale = ''

func _ready():
	for locale in input_handler.TranslationData:
		if !flag_textures.has(locale):
			continue
		locale_names[locale] = load(variables.LocalizationFolder + locale + "/info.gd").new().data.eng_name
		var button = TextureButton.new()
		button.name = locale
		button.texture_normal = flag_textures[locale]
		button.rect_min_size = Vector2(56, 37)
		button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		globals.connecttexttooltip(button, locale_names[locale])
		button.modulate = SELECTED_COLOR if locale == input_handler.globalsettings.ActiveLocalization else UNSELECTED_COLOR
		button.connect("pressed", self, "_on_flag_pressed", [locale])
		add_child(button)

func _on_flag_pressed(locale):
	if locale == input_handler.globalsettings.ActiveLocalization:
		return
	pending_locale = locale
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'switch_locale_confirmed', tr('OPTIONSWITCHLANGUAGECONFIRM') % locale_names[locale]])

func switch_locale_confirmed():
	input_handler.globalsettings.ActiveLocalization = pending_locale.to_lower()
	input_handler.settings_save(input_handler.globalsettings)
	for child in get_children():
		child.modulate = SELECTED_COLOR if child.name == pending_locale else UNSELECTED_COLOR
	OkPanel.visible = true
