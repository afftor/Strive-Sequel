extends Panel


onready var MansionMainModule = _find_mansion_main()
var person
var pinned_person
export(bool) var embedded = false

const OVERVIEW_FACTORS = [
	"growth_factor",
	"physics_factor",
	"magic_factor",
	"wits_factor",
	"charm_factor",
	"sexuals_factor",
	"tame_factor",
	"authority_factor",
]
const OVERVIEW_STATS = ["physics", "wits", "charm", "productivity"]
const PERSONALITY_ICONS = {
	"bold": preload("res://assets/Textures_v2/MANSION/personality_bold.png"),
	"kind": preload("res://assets/Textures_v2/MANSION/personality_kind.png"),
	"shy": preload("res://assets/Textures_v2/MANSION/personality_shy.png"),
	"serious": preload("res://assets/Textures_v2/MANSION/personality_serious.png"),
	"neutral": preload("res://assets/Textures_v2/MANSION/personality_neutral.png"),
}
const OVERVIEW_ICONS = {
	"growth_factor": preload("res://assets/images/gui/gui icons/growth_factor.png"),
	"physics_factor": preload("res://assets/images/gui/gui icons/physics_factor.png"),
	"magic_factor": preload("res://assets/images/gui/gui icons/magic_factor.png"),
	"wits_factor": preload("res://assets/images/gui/gui icons/wit_factor.png"),
	"charm_factor": preload("res://assets/images/gui/gui icons/charm_factor.png"),
	"sexuals_factor": preload("res://assets/images/gui/gui icons/sex_factor.png"),
	"tame_factor": preload("res://assets/images/gui/gui icons/tame_factor.png"),
	"authority_factor": preload("res://assets/images/gui/gui icons/timid_factor.png"),
	"physics": preload("res://assets/images/gui/gui icons/icon_physics.png"),
	"wits": preload("res://assets/images/gui/gui icons/icon_wits.png"),
	"charm": preload("res://assets/images/gui/gui icons/icon_charm.png"),
	"productivity": preload("res://assets/images/gui/inventory/icon_craft1.png"),
}


func _find_mansion_main():
	var node = get_parent()
	while node != null:
		if node.has_method("mansion_state_set") and node.has_method("set_active_person"):
			return node
		node = node.get_parent()
	return null

# Called when the node enters the scene tree for the first time.
func _ready():
	if MansionMainModule != null:
		$CharacterInfoButton.connect("pressed", MansionMainModule, "mansion_state_set", ["char_info"])
	$TextureRect2/Exp.connect("pressed", self, "open_char_class_info")
	for i in $base_stats.get_children():
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	globals.connecttexttooltip(get_node("TextureRect2/Exp"), statdata.statdata["base_exp"].descript)
	for i in $TextureRect2.get_children():
		if i.name == "Exp":
			continue
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	var legacy_panel_enabled = MansionMainModule == null or MansionMainModule.get("show_legacy_character_panels")
	if !embedded and legacy_panel_enabled:
		globals.connect("hour_tick", self, "show_slave_info")
		input_handler.connect("EventFinished", self, "show_slave_info")
		input_handler.register_btn_source("char_info", self, "tut_get_info_btn")
	hotkeys.connect("bindings_changed", self, "build_info_btn_tooltip")
	build_info_btn_tooltip()


func build_info_btn_tooltip():
	globals.connecttexttooltip($CharacterInfoButton, hotkeys.get_tooltip_text("MSMNAME", 'mansion_char_info'))


func tut_get_info_btn():
	return $CharacterInfoButton

func open_char_class_info():
	if gui_controller.slavepanel == null:
		gui_controller.slavepanel = input_handler.get_spec_node(input_handler.NODE_SLAVEMODULE)
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.slavepanel
	gui_controller.slavepanel.show()
	gui_controller.slavepanel.raise()
	gui_controller.slavepanel.set_state("class")


func show_slave_info():
	if globals.gameover_process:
		return
	if pinned_person != null:
		person = pinned_person
	elif MansionMainModule != null and MansionMainModule.hovered_person != null:
		person = MansionMainModule.hovered_person
	else:
		person = input_handler.interacted_character
	if person == null:
		return
	$Panel.visible = false
	build_professions()
	if !embedded:
		build_legacy_info()
	if $ExpandedStats.visible:
		build_overview()
		build_expanded_character_info()
	build_traits()
	build_buffs()


func prepare_expanded_person(value):
	pinned_person = value
	person = value
	$Panel.visible = false


func build_professions():
	input_handler.ClearContainer($TextureRect/ScrollContainer/professions)
	for profession_code in person.get_professions():
		var newnode = input_handler.DuplicateContainerTemplate($TextureRect/ScrollContainer/professions)
		var profession = classesdata.professions[profession_code]
		newnode.get_node("Label").text = ResourceScripts.descriptions.get_class_name(profession, person)
		newnode.get_node("ProfIcon").texture = profession.icon
		newnode.connect('signal_RMB_release', gui_controller, 'show_class_info', [profession_code, person])
		globals.connectclasstooltip(newnode, person, profession_code)



#The embedded version hides this old portrait/stat block. Keeping it separate lets the
#expanded panel distribute its own sections over several frames.
func build_legacy_info():
	globals.build_attrs_for_char(self, person)
	$exp.text = str(floor(person.get_stat('base_exp')))
	$productivity/Label.text = str(round(person.get_stat('productivity'))) + "%"
	if person.is_master() or person.is_unique():
		$RichTextLabel.set("custom_colors/default_color", variables.hexcolordict.unique)
	else:
		$RichTextLabel.set("custom_colors/default_color", variables.hexcolordict.white)
	$RichTextLabel.bbcode_text = "[center]" + person.get_full_name() + "[/center]"
	for stat_code in ['hp', 'mp', 'lust']:
		get_node("base_stats/" + stat_code).max_value = person.get_stat(stat_code + 'max')
		get_node("base_stats/" + stat_code).value = person.get_stat(stat_code)
		get_node("base_stats/" + stat_code + '/Label').text = str(floor(person.get_stat(stat_code))) + "/" + str(floor(person.get_stat(stat_code + 'max')))
	$base_stats/lust.visible = person.check_trait('succubus')
	$growth.text = tr(ResourceScripts.descriptions.factor_descripts[int(floor(person.get_stat('growth_factor')))])
	$growth.set("custom_colors/font_color", variables.hexcolordict['factor' + str(int(floor(person.get_stat('growth_factor'))))])
	for stat_code in ['physics', 'wits', 'charm']:
		var bonus = person.get_stat(stat_code + "_bonus")
		var color = set_color(bonus)
		get_node(stat_code).text = str(floor(person.get_stat(stat_code)))
		get_node(stat_code).set("custom_colors/font_color", color)
		get_node(stat_code + '2').text = str(person.get_stat(stat_code + '_cap') + bonus)
		get_node(stat_code + '2').set("custom_colors/font_color", color)
	var productivity_text = "[center]" + statdata.statdata.productivity.name + "[/center]\n" + statdata.statdata.productivity.descript + "\n" + tr("TOTALPRODUCTIVITY") + ": " + str(floor(person.get_stat('productivity')))
	for mod_code in variables.productivity_mods:
		var mod_value = person.get_stat(mod_code)
		if mod_value > 1:
			productivity_text += "\n{color=green|" + str(round(mod_value * 100)) + " - " + statdata.statdata[mod_code].name + "}"
		elif mod_value < 1:
			productivity_text += "\n{color=red|" + str(round(mod_value * 100)) + " - " + statdata.statdata[mod_code].name + "}"
		else:
			productivity_text += "\n" + str(round(mod_value * 100)) + " - " + statdata.statdata[mod_code].name
	globals.connecttexttooltip($productivity, globals.TextEncoder(productivity_text))


func build_traits():
	globals.build_traitlist_for_char(person, $scroll/traitscontainer)


func build_buffs():
	globals.build_buffs_for_char(person, $buffscontainer, 'mansion')


func set_person(value):
	pinned_person = value
	show_slave_info()


func build_overview():
	input_handler.ClearContainer($ExpandedStats/Factors/Rows)
	input_handler.ClearContainer($ExpandedStats/BaseStats/Rows)
	for code in OVERVIEW_FACTORS:
		if person.is_master() and code in ["tame_factor", "authority_factor"]:
			continue
		var row = input_handler.DuplicateContainerTemplate($ExpandedStats/Factors/Rows)
		setup_overview_row(row, code, str(int(floor(person.get_stat(code)))), true)
	for code in OVERVIEW_STATS:
		var value
		if code == "productivity":
			value = str(int(floor(person.get_stat(code)))) + "%"
		else:
			var current_value = int(floor(person.get_stat(code)))
			var maximum_value = int(floor(person.get_stat(code + "_cap") + person.get_stat(code + "_bonus")))
			value = str(current_value) + " / " + str(maximum_value)
		var row = input_handler.DuplicateContainerTemplate($ExpandedStats/BaseStats/Rows)
		setup_overview_row(row, code, value, false)


func setup_overview_row(row, code, value, factor):
	row.get_node("Icon").texture = OVERVIEW_ICONS[code]
	row.get_node("Value").text = value
	if factor:
		var factor_index = int(clamp(floor(person.get_stat(code)), 1, 6))
		row.get_node("Value").set("custom_colors/font_color", variables.hexcolordict["factor" + str(factor_index)])
	else:
		row.get_node("Value").set("custom_colors/font_color", variables.hexcolordict["k_yellow"])
	var tooltip = "[center]{color=yellow|" + tr("STAT" + code.to_upper()) + "}[/center]\n" + person.translate(statdata.statdata[code].descript)
	globals.connecttexttooltip(row, tooltip)


func get_body_preview_texture():
	var body_texture = person.get_stored_body_image()
	if body_texture == null:
		body_texture = person.get_body_image()
	return body_texture


func build_expanded_character_info():
	var fame_row = $ExpandedStats/CharacterInfo/Rows/Fame
	fame_row.get_node("Value").text = tr(person.get_fame_bonus('name'))
	globals.connecttexttooltip(fame_row,
		person.translate(tr("TOOLTIPFAME") + "\n\n{color=yellow|" + tr(person.get_fame_bonus('desc')) + "}")
		+ "\n" + person.get_fame_bonus_desc())

	var price_row = $ExpandedStats/CharacterInfo/Rows/Price
	price_row.visible = !person.has_profession("master")
	if price_row.visible:
		var price = person.calculate_price(false, false, true)
		var character_tax = person.get_weekly_tax()
		price_row.get_node("Value").text = str(price)
		if character_tax > 0:
			price_row.get_node("Value").text += " (%d)" % character_tax
		var value_tooltip = tr("TOOLTIPVALUE") + "\n\n" + person.get_price_composition()
		if character_tax > 0:
			value_tooltip += "\n%s: {color=yellow|%d} (%d + %d)" % [
				tr("FAMEDESC_UPKEEP"), character_tax, person.get_upkeep(), person.get_value_upkeep()
			]
		globals.connecttexttooltip(price_row, value_tooltip)

	var standing_row = $ExpandedStats/CharacterInfo/Rows/Standing
	standing_row.visible = !person.is_master()
	if standing_row.visible:
		standing_row.get_node("Value").text = person.get_character_standing()
		globals.connecttexttooltip(standing_row, build_standing_tooltip())

	var personality_row = $ExpandedStats/CharacterInfo/Rows/Personality
	var personality = person.get_stat("personality")
	personality_row.get_node("Icon").texture = PERSONALITY_ICONS.get(personality, PERSONALITY_ICONS.neutral)
	personality_row.get_node("Value").text = tr("PERSONALITYNAME" + personality.to_upper())
	globals.connecttexttooltip(personality_row, globals.get_character_personality_tooltip(personality))

	var consent_label = $ExpandedStats/CharacterInfo/Consent
	if person.is_master():
		consent_label.text = tr("SIBLINGMODULECONSENT") + tr("MASTER")
		globals.connecttexttooltip(consent_label, person.translate(tr("INFOCONSENTMASTER")))
	else:
		consent_label.text = tr("SIBLINGMODULECONSENT") + tr(variables.consent_dict[int(person.get_stat('consent'))])
		globals.connecttexttooltip(consent_label, tr("INFOCONSENT"))


func build_standing_tooltip():
	var text = person.translate(tr("TOOLTIPCHARACTERSTANDING"))
	var standing_code = person.get_character_standing_code()
	var effect_code = 'e_' + standing_code
	if person.has_status(standing_code) and Effectdata.effect_table.has(effect_code):
		var effect = Effectdata.effect_table[effect_code]
		text += "\n\n[center]{color=yellow|%s}[/center]\n%s" % [
			tr('TRAIT' + standing_code.to_upper()),
			person.translate(tr('TRAIT' + standing_code.to_upper() + 'DESCRIPT')),
		]
		var bonus_text = person.translate(globals.build_desc_for_bonusstats(effect.statchanges).strip_edges())
		if bonus_text != "":
			text += "\n" + bonus_text
	return text


func set_color(value):
	var color = Color(0.87,0.87,0.87,1)
	if value > 0:
		color = Color(0.31,0.99,0.51,1)
	elif value < 0:
		color = Color(0.99,0.31,0.36,1)
	return color


func text_url_hover(meta):
	match meta:
		'race':
			var texttooltip = input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP) #input_handler.GetTextTooltip()
			texttooltip.showup($RichTextLabel, person.show_race_description())
			yield(get_tree(), 'idle_frame')
			texttooltip.rect_global_position = get_global_mouse_position()
	#globals.connecttexttooltip($RichTextLabel, person.show_race_description())

func text_url_hover_hide(meta = null):
	match meta:
		'race':
			var texttooltip = input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP) #input_handler.GetTextTooltip()
			texttooltip.hide()


