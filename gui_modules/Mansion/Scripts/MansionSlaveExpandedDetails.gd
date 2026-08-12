extends PanelContainer

signal inventory_requested(person)
signal food_filter_requested(person)

var person

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
const COMBAT_STATS = [
	"atk",
	"matk",
	"armor",
	"mdef",
	"hitrate",
	"evasion",
	"speed",
	"armorpenetration",
	"critchance",
	"critmod",
]
const COMBAT_STAT_TOOLTIPS = {
	"atk": "SIMATK_DESC",
	"matk": "SIMMATK_DESC",
	"armor": "SIMDEF_DESC",
	"mdef": "SIMMDEF_DESC",
	"hitrate": "SIMHITRATE_DESC",
	"evasion": "SIMEVASION_DESC",
	"speed": "SIMSPEED_DESC",
	"armorpenetration": "SIMARMORPEN_DESC",
	"critchance": "SIMCRITICAL_DESC",
	"critmod": "SIMCRITICALMOD_DESC",
}
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
	"wits_factor": preload("res://assets/images/gui/gui icons/wit.png"),
	"charm_factor": preload("res://assets/images/gui/gui icons/charm.png"),
	"sexuals_factor": preload("res://assets/images/gui/gui icons/sex.png"),
	"tame_factor": preload("res://assets/images/gui/gui icons/tame_factor.png"),
	"authority_factor": preload("res://assets/images/gui/gui icons/timid_factor.png"),
	"physics": preload("res://assets/images/gui/gui icons/icon_physics.png"),
	"wits": preload("res://assets/images/gui/gui icons/icon_wits.png"),
	"charm": preload("res://assets/images/gui/gui icons/icon_charm.png"),
	"productivity": preload("res://assets/images/gui/inventory/icon_craft1.png"),
}

onready var Classes = $Sections/Classes/Content/Scroll/Items
onready var FactorRows = $Sections/Overview/Left/Factors/Content/Rows
onready var StatRows = $Sections/Overview/Left/BaseStats/Content/Rows
onready var CharacterRows = $Sections/Overview/Right/CharacterInfo/Content/Rows
onready var Relationships = $Sections/Overview/Right/Relationships
onready var Equipment = $Sections/Equipment/Content/Scroll/Items
onready var Traits = $Sections/Traits/Content/Scroll/Items
onready var Buffs = $Sections/Buffs/Content/Scroll/Items
onready var CombatStatItems = $Sections/CombatStats/Content/Stats/Items
onready var ResistItems = $Sections/CombatStats/Content/Resists/Items


func _ready():
	$Sections/Overview/Right/Food/Content/Filter.connect(
		"pressed", self, "_request_food_filter"
	)
	globals.connecttexttooltip(
		$Sections/Overview/Right/Food/Content/Filter,
		tr("INFOFOODFILTER")
	)


func _request_inventory():
	if person != null:
		emit_signal("inventory_requested", person)


func _request_food_filter():
	if person != null:
		emit_signal("food_filter_requested", person)


func prepare_expanded_person(value):
	person = value


func set_person(value):
	prepare_expanded_person(value)
	build_professions()
	build_overview()
	build_expanded_character_info()
	build_relationships()
	build_equipment()
	build_traits()
	build_buffs()
	build_combat_stats()


func build_professions():
	input_handler.ClearContainer(Classes)
	if person == null:
		return
	for profession_code in person.get_professions():
		var newnode = input_handler.DuplicateContainerTemplate(Classes)
		var profession = classesdata.professions[profession_code]
		newnode.get_node("ProfIcon").texture = profession.icon
		newnode.connect("signal_RMB_release", gui_controller, "show_class_info", [profession_code, person])
		globals.connectclasstooltip(newnode, person, profession_code)


func build_overview():
	input_handler.ClearContainer(FactorRows)
	input_handler.ClearContainer(StatRows)
	if person == null:
		return
	for code in OVERVIEW_FACTORS:
		if person.is_master() and code in ["tame_factor", "authority_factor"]:
			continue
		var row = input_handler.DuplicateContainerTemplate(FactorRows)
		_setup_overview_row(row, code, str(int(floor(person.get_stat(code)))), true)
	for code in OVERVIEW_STATS:
		var value
		if code == "productivity":
			value = str(int(floor(person.get_stat(code)))) + "%"
		else:
			var current_value = int(floor(person.get_stat(code)))
			var maximum_value = int(floor(person.get_stat(code + "_cap") + person.get_stat(code + "_bonus")))
			value = str(current_value) + " / " + str(maximum_value)
		var row = input_handler.DuplicateContainerTemplate(StatRows)
		_setup_overview_row(row, code, value, false)


func _setup_overview_row(row, code, value, factor):
	row.get_node("Icon").texture = OVERVIEW_ICONS[code]
	row.get_node("Value").text = value
	if factor:
		var factor_index = int(clamp(floor(person.get_stat(code)), 1, 6))
		row.get_node("Value").set("custom_colors/font_color", variables.hexcolordict["factor" + str(factor_index)])
	else:
		row.get_node("Value").set("custom_colors/font_color", variables.hexcolordict["k_yellow"])
	var tooltip
	if code == "productivity":
		tooltip = _build_productivity_tooltip()
	else:
		tooltip = "[center]{color=yellow|" + tr("STAT" + code.to_upper()) + "}[/center]\n" + person.translate(statdata.statdata[code].descript)
	globals.connecttexttooltip(row, tooltip)


func _build_productivity_tooltip():
	var text = "[center]" + statdata.statdata.productivity.name + "[/center]\n"
	text += person.translate(statdata.statdata.productivity.descript)
	text += "\n" + tr("TOTALPRODUCTIVITY") + ": " + str(floor(person.get_stat("productivity")))
	for mod_code in variables.productivity_mods:
		var mod_value = person.get_stat(mod_code)
		var line = str(round(mod_value * 100)) + " - " + statdata.statdata[mod_code].name
		if mod_value > 1:
			text += "\n{color=green|" + line + "}"
		elif mod_value < 1:
			text += "\n{color=red|" + line + "}"
		else:
			text += "\n" + line
	return text


func build_expanded_character_info():
	if person == null:
		return
	var fame_row = CharacterRows.get_node("Fame")
	fame_row.get_node("Value").text = tr(person.get_fame_bonus("name"))
	globals.connecttexttooltip(fame_row,
		person.translate(tr("TOOLTIPFAME") + "\n\n{color=yellow|" + tr(person.get_fame_bonus("desc")) + "}")
		+ "\n" + person.get_fame_bonus_desc())

	var price_row = CharacterRows.get_node("Price")
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

	var standing_row = Relationships.get_node("Content/Standing")
	standing_row.visible = !person.is_master()
	if standing_row.visible:
		standing_row.get_node("Value").text = person.get_character_standing()
		globals.connecttexttooltip(standing_row, _build_standing_tooltip())

	var personality_row = CharacterRows.get_node("Personality")
	var personality = person.get_stat("personality")
	personality_row.get_node("Icon").texture = PERSONALITY_ICONS.get(personality, PERSONALITY_ICONS.neutral)
	personality_row.get_node("Value").text = tr("PERSONALITYNAME" + personality.to_upper())
	globals.connecttexttooltip(personality_row, globals.get_character_personality_tooltip(personality))

	var food_row = $Sections/Overview/Right/Food/Content
	var preferred_food = food_row.get_node("PreferredFood")
	var food_love = person.food.food_love
	preferred_food.visible = food_love != null and food_love != ""
	globals.disconnect_text_tooltip(preferred_food)
	if preferred_food.visible:
		preferred_food.get_node("Icon").texture = images.get_icon(food_love)
		globals.connecttexttooltip(preferred_food,
			"[center]" + tr("FOODLIKEDTYPE") + "[/center]\n" + tr("FOODTYPE" + food_love.to_upper()))
	var demand = person.get_food_demand()
	var demand_label = food_row.get_node("Demand")
	demand_label.text = tr("FOODDEMAND" + demand.to_upper())
	demand_label.set("custom_colors/font_color", Color(variables.hexcolordict[variables.food_demand_colors[demand]]))
	globals.connecttexttooltip(demand_label,
		"[center]" + tr("FOODDEMAND") + "[/center]\n" + tr("FOODDEMAND" + demand.to_upper() + "DESCRIPT"))

	var consent_label = $Sections/Overview/Right/Consent/Value
	if person.is_master():
		consent_label.text = tr("SIBLINGMODULECONSENT") + tr("MASTER")
		globals.connecttexttooltip(consent_label, person.translate(tr("INFOCONSENTMASTER")))
	else:
		consent_label.text = tr("SIBLINGMODULECONSENT") + tr(variables.consent_dict[int(person.get_stat("consent"))])
		globals.connecttexttooltip(consent_label, tr("INFOCONSENT"))


func build_relationships():
	if person == null:
		return
	Relationships.visible = !person.is_master()
	if !Relationships.visible:
		return
	for code in ["affection", "respect"]:
		var row = Relationships.get_node("Content/Bars/" + code.capitalize())
		row.get_node("Bar").value = person.get_stat(code)
		var tooltip = "[center]{color=yellow|" + tr("STAT" + code.to_upper()) + "}[/center]\n" + person.translate(statdata.statdata[code].descript)
		globals.connecttexttooltip(row, tooltip)


func build_equipment():
	input_handler.ClearContainer(Equipment)
	if person == null:
		return
	for item in person.get_equiped_items():
		var newnode = input_handler.DuplicateContainerTemplate(Equipment)
		item.set_icon(newnode.get_node("Icon"))
		if item.quality != "":
			newnode.get_node("quality_color").texture = variables.quality_colors[item.quality]
			newnode.get_node("quality_color").show()
		else:
			newnode.get_node("quality_color").hide()
		globals.connectitemtooltip_v2(newnode, item)
		newnode.connect("pressed", self, "_request_inventory")


func build_traits():
	if person != null:
		globals.build_traitlist_for_char(person, Traits)


func build_buffs():
	if person != null:
		globals.build_buffs_for_char(person, Buffs, "mansion")


func build_combat_stats():
	input_handler.ClearContainer(CombatStatItems)
	input_handler.ClearContainer(ResistItems)
	if person == null:
		return
	for code in COMBAT_STATS:
		var entry = input_handler.DuplicateContainerTemplate(CombatStatItems)
		entry.name = code
		entry.get_node("Icon").texture = images.get_icon(variables.fighter_stat_icons[code])
		entry.get_node("Value").text = _format_combat_stat(code)
		globals.connecttexttooltip(entry, tr(COMBAT_STAT_TOOLTIPS[code]))
	for code in variables.resists_list:
		var entry = input_handler.DuplicateContainerTemplate(ResistItems)
		entry.name = code
		entry.get_node("Icon").texture = images.get_icon("resist_" + code)
		var value = person.get_stat("resist_" + code)
		var value_label = entry.get_node("Value")
		value_label.text = str(value)
		if value > 0:
			value_label.set("custom_colors/font_color", variables.hexcolordict.yellow)
		elif value < 0:
			value_label.set("custom_colors/font_color", variables.hexcolordict.green)
		else:
			value_label.set("custom_colors/font_color", variables.hexcolordict.white)
		globals.connecttexttooltip(entry, tr(code.to_upper() + "RESIST_DESC"))


func _format_combat_stat(code):
	if code == "critmod":
		return str(floor(person.get_stat(code) * 100)) + "%"
	if code == "speed":
		return str(floor(person.get_stat(code)[0]))
	return str(floor(person.get_stat(code)))


func _build_standing_tooltip():
	var text = person.translate(tr("TOOLTIPCHARACTERSTANDING"))
	var standing_code = person.get_character_standing_code()
	var effect_code = "e_" + standing_code
	if person.has_status(standing_code) and Effectdata.effect_table.has(effect_code):
		var effect = Effectdata.effect_table[effect_code]
		text += "\n\n[center]{color=yellow|%s}[/center]\n%s" % [
			tr("TRAIT" + standing_code.to_upper()),
			person.translate(tr("TRAIT" + standing_code.to_upper() + "DESCRIPT")),
		]
		var bonus_text = person.translate(globals.build_desc_for_bonusstats(effect.statchanges).strip_edges())
		if bonus_text != "":
			text += "\n" + bonus_text
	return text
