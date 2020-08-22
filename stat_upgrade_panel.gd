extends Panel

onready var StatsContainer = $StatsPanel/StatsVBox
onready var CharList = $CharList/ScrollContainer/CharactersVBox
onready var Materials = $StatsPanel/Materials
onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)
var selected_character

var stats_dict = {
	"physics_factor": "Physics Factor",
	"wits_factor": "Wits Factor",
	"charm_factor": "Charm Factor",
	"sexuals_factor": "Sexuals Factor",
	"timid_factor": "Timid Factor",
	"tame_factor": "Tame Factor",
	"magic_factor": "Magic Factor"
}

var price = {
	2: {gold = 100, wood = 10},
	3: {gold = 200, woodmagic = 10},
	4: {gold = 500, woodiron = 10},
	5: {gold = 1000, mithril = 10, clothmagic = 10},
	6: {gold = 3000, woodancient = 5, adamantine = 5, clothethereal = 5, bonedragon = 3},
}

var substract_gold = 0
var substract_materials = {}
var current_node
var person


func hide_stats_info():
	$StatsPanel.hide()


func show_characters_panel():
	var idx = 0
	var name
	input_handler.ClearContainer(CharList)
	for character in ResourceScripts.game_party.characters.values():
		name = character.get_full_name()
		var newbutton = input_handler.DuplicateContainerTemplate(CharList)
		newbutton.get_node("CharacterName").text = name
		newbutton.connect("pressed", self, "show_stats", [character])
		newbutton.set_meta("slave", character)
	$StatsPanel.hide()


func show_stats(character):
	Materials.hide()
	$StatsPanel/Gold.hide()
	$StatsPanel/StatInfoCurrentValue.hide()
	$StatsPanel/StatInfoNameValue.hide()
	$StatsPanel/ConfirmButton.hide()
	$StatsPanel.show()
	var stats_to_show = 0
	input_handler.ClearContainer(StatsContainer)
	if character == null:
		return
	for stat in stats_dict:
		if character.get_stat(stat) == 6:
			continue
		else:
			stats_to_show += 1
			var newbutton = input_handler.DuplicateContainerTemplate(StatsContainer)
			newbutton.get_node("StatName").text = stats_dict[stat]
			newbutton.connect("pressed", self, "show_stat_info", [stat, character])
	person = character
	update_buttons()


func _ready():
	GUIWorld.add_close_button(self)
	show_characters_panel()
	$StatsPanel/ConfirmButton.connect("pressed", self, "upgrade_stat")


func update_buttons():
	for button in CharList.get_children():
		if !button.has_meta("slave"):
			continue
		button.pressed = button.get_meta("slave") == person



func show_stat_info(stat, character):
	### Testing Node
	$StatsPanel/Testing.text = (
		character.get_full_name()
		+ "\n"
		+ "physics_factor"
		+ str(character.get_stat("physics_factor"))
		+ "\n"
		+ "wits_factor"
		+ str(character.get_stat("wits_factor"))
		+ "\n"
		+ "sexuals_factor"
		+ str(character.get_stat("sexuals_factor"))
		+ "\n"
		+ "charm_factor"
		+ str(character.get_stat("charm_factor"))
		+ "\n"
		+ "timid_factor"
		+ str(character.get_stat("timid_factor"))
		+ "\n"
		+ "tame_factor"
		+ str(character.get_stat("tame_factor"))
		+ "\n"
		+ "magic_factor"
		+ str(character.get_stat("magic_factor"))
		+ "\n"
	)
	### 
	substract_gold = 0
	substract_materials.clear()
	$StatsPanel.show()
	$StatsPanel/ConfirmButton.visible = stat != null
	Materials.show()
	$StatsPanel/Gold.show()
	var stat_next_level = int(character.get_stat(stat) + 1)
	var upgrade_price_items
	if price.has(stat_next_level):
		upgrade_price_items = price[stat_next_level]
	var upgrade_price
	$StatsPanel/StatInfoNameValue.text = stats_dict[stat]
	$StatsPanel/StatInfoCurrentValue.text = "Current value: " + str(character.get_stat(stat))
	if stat_next_level < 7:
		$StatsPanel/StatInfoCurrentValue.show()
		$StatsPanel/StatInfoNameValue.show()
		upgrade_price = set_upgrade_price(upgrade_price_items)
		var upgrade_alowed = check_upgrade_possibility(stat, character, upgrade_price_items)
		$StatsPanel/ConfirmButton.disabled = ! upgrade_alowed
	else:
		$StatsPanel/StatInfoCurrentValue.hide()
		$StatsPanel/StatInfoNameValue.hide()
		upgrade_price = "Max value reached." + "\n" + "Upgrade is not possible."
		$StatsPanel/ConfirmButton.disabled = true
		show_stats(character)
	$StatsPanel/StatInfoUpgradeValue.text = upgrade_price
	person = character
	active_stat = stat
	if upgrade_price_items != null:
		input_handler.ClearContainer(Materials)
		for i in upgrade_price_items:
			if i == "gold":
				$StatsPanel/Gold/Label.text = str(upgrade_price_items[i])
				continue
			var item = Items.materiallist[i]
			var newbutton = input_handler.DuplicateContainerTemplate(Materials)
			newbutton.get_node("TextureRect").texture = Items.materiallist[i].icon
			newbutton.get_node("Label").text = str(upgrade_price_items[i])
			globals.connectmaterialtooltip(newbutton, item)
	Materials.visible = upgrade_price_items != null
	$StatsPanel/Gold.visible = upgrade_price_items != null
	



var active_stat


func upgrade_stat():
	var character = person
	var stat = active_stat
	ResourceScripts.game_res.money -= substract_gold
	for material in substract_materials:
		ResourceScripts.game_res.materials[material] -= substract_materials[material]
	character.add_stat(stat, 1)
	show_stats(character)
	show_stat_info(stat, character)


func set_upgrade_price(upgrade_price_items):
	var upgrade_price = ""
	for item in upgrade_price_items:
		upgrade_price += str(item) + " - " + str(upgrade_price_items[item]) + "\n"

	return upgrade_price


func check_upgrade_possibility(stat, character, upgrade_price_items):
	var upgrade_alowed = true
	var is_enough = true
	var material
	for item in upgrade_price_items:
		if item == "gold":
			is_enough = (ResourceScripts.game_res.money >= upgrade_price_items[item])
			upgrade_alowed = (upgrade_alowed && is_enough)
			if upgrade_alowed:
				substract_gold += upgrade_price_items[item]
			else:
				break
		else:
			material = ResourceScripts.game_res.materials[item]
			is_enough = (material >= upgrade_price_items[item])
			upgrade_alowed = (upgrade_alowed && is_enough)
			if upgrade_alowed:
				substract_materials[item] = upgrade_price_items[item]
			else:
				break

	return upgrade_alowed
