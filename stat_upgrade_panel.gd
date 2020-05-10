extends "res://files/Close Panel Button/ClosingPanel.gd"

onready var StatsContainer = $StatsScroll/StatsVBox

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
	2: {gold = 100, wood = 10, woodmagic = 1000},
	3: {gold = 200, woodmagic = 10},
	4: {gold = 500, wood = 10},
	5: {gold = 700, wood = 10},
	6: {gold = 5000},
}

var substract_gold = 0
var substract_materials = {}
var current_node




func hide_stats_info():
	$StatsPanel.hide()


func show_characters_panel():	
	var idx = 0
	var name
	for character in state.characters.values():
		name = character.name.capitalize() + " " + character.surname.capitalize()
		$CharactersOptionButton.add_item(name)
		$CharactersOptionButton.set_item_metadata(idx, character)
		idx += 1
	$CharactersOptionButton.connect("item_selected", self, "show_stats")
	show_stats(0)


func show_stats(node):
	var character = $CharactersOptionButton.get_selected_metadata()
	if current_node != node:
		current_node = node
		$StatsPanel.hide()
	var stats_to_show = 0
	globals.ClearContainer(StatsContainer)
	for stat in stats_dict:
		if character[stat] == 6:
			continue
		else:
			stats_to_show += 1
			var newbutton = globals.DuplicateContainerTemplate(StatsContainer)
			newbutton.get_node("StatName").text = stats_dict[stat]
			newbutton.connect("pressed", self, "show_stat_info", [stat, character])
	if stats_to_show > 0:
		$NothingToUpgrade.hide()
	else:
		$NothingToUpgrade.show()


func _ready():
	show_characters_panel()
	$StatsPanel/ConfirmButton.connect("pressed", self, "upgrade_stat")



func show_stat_info(stat, character):
	### Testing Node
	$StatsPanel/Testing.text = (character.name + "\n" + 
		"physics_factor" +	str(character.physics_factor) + "\n" +
		"wits_factor" +	str(character.wits_factor) + "\n" +
		"sexuals_factor" +	str(character.sexuals_factor) + "\n" +
		"charm_factor" +	str(character.charm_factor) + "\n" +
		"timid_factor" +	str(character.timid_factor) + "\n" +
		"tame_factor" +	str(character.tame_factor) + "\n" +
		"magic_factor" +	str(character.magic_factor) + "\n")
	### 
	substract_gold = 0
	substract_materials.clear()
	$StatsPanel.show()
	var stat_next_level = int(character[stat] + 1)
	var upgrade_price_items
	if price.has(stat_next_level):
		upgrade_price_items = price[stat_next_level]
	var upgrade_price
	$StatsPanel/StatInfoNameValue.text = stats_dict[stat]
	$StatsPanel/StatInfoCurrentValue.text = str(character[stat])
	if stat_next_level < 7:
		upgrade_price = set_upgrade_price(upgrade_price_items)
		var upgrade_alowed = check_upgrade_possibility(stat, character, upgrade_price_items)
		$StatsPanel/ConfirmButton.disabled = !upgrade_alowed
	else:
		upgrade_price = "Max value reached." + "\n" + "Upgrade is not possible."
		$StatsPanel/ConfirmButton.disabled = true
		show_stats(current_node)
	$StatsPanel/StatInfoUpgradeValue.text = upgrade_price
	person = character
	active_stat = stat

var person
var active_stat

func upgrade_stat():
	var character = person
	var stat = active_stat
	state.money -= substract_gold
	for material in substract_materials:
		state.materials[material] -= substract_materials[material]
	character[stat] += 1
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
			is_enough = (state.money >= upgrade_price_items[item])
			upgrade_alowed = (upgrade_alowed && is_enough)
			if upgrade_alowed:
				substract_gold += upgrade_price_items[item]
			else:
				break
		else:
			material = state.materials.get(item, 0)
			is_enough = (material >= upgrade_price_items[item])
			upgrade_alowed = (upgrade_alowed && is_enough)
			if upgrade_alowed:
				substract_materials[item] = upgrade_price_items[item]
			else:
				break

	return upgrade_alowed




