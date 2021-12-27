extends Panel

onready var StatsContainer = $StatsPanel/StatsVBox
onready var CharList = $CharList/ScrollContainer/CharactersVBox
var selected_character

var stats_dict = {
#	"physics_factor": "Physics Factor",
#	"wits_factor": "Wits Factor",
#	"charm_factor": "Charm Factor",
#	"sexuals_factor": "Sexuals Factor",
#	"timid_factor": "Timid Factor",
#	"tame_factor": "Tame Factor",
#	"magic_factor": "Magic Factor"
	"growth_factor": "Growth Factor"
}

#var price = {
#	2: {gold = 100, wood = 10},
#	3: {gold = 200, woodmagic = 10},
#	4: {gold = 500, woodiron = 10},
#	5: {gold = 1000, mithril = 10, clothmagic = 10},
#	6: {gold = 3000, woodancient = 5, adamantine = 5, clothethereal = 5, bonedragon = 3},
#}

var substract_gold = 0
var current_node
var person


func hide_stats_info():
	$StatsPanel.hide()


func show_characters_panel():
	# var idx = 0
	var name
	input_handler.ClearContainer(CharList)
	for i in ResourceScripts.game_party.character_order:
		var character = ResourceScripts.game_party.characters[i]
		name = character.get_full_name()
		var newbutton = input_handler.DuplicateContainerTemplate(CharList)
		newbutton.get_node("CharacterName").text = name
		newbutton.get_node("icon").texture = character.get_icon()
		newbutton.connect("pressed", self, "show_stats", [character])
		newbutton.set_meta("slave", character)
	$StatsPanel.hide()


func show_stats(character):
	$StatsPanel/Gold.hide()
	$StatsPanel/StatInfoCurrentValue.hide()
	$StatsPanel/StatInfoNameValue.hide()
	$StatsPanel/ConfirmButton.hide()
	$StatsPanel.show()
	input_handler.ClearContainer(StatsContainer)
	if character == null:
		return
	for stat in stats_dict:
		# if character.get_stat(stat) == 6:
		# 	continue
		if character.is_master() && stat in ["timid_factor", "tame_factor"]:
			continue
		else:
			var newbutton = input_handler.DuplicateContainerTemplate(StatsContainer)
			newbutton.get_node("StatName").text = stats_dict[stat]
			if character.get_stat(stat) == 6:
				newbutton.disabled = true
				continue
			newbutton.connect("pressed", self, "show_stat_info", [stat, character])
			newbutton.set_meta("stat", stat)
	person = character
	update_buttons()


func _ready():
	gui_controller.add_close_button(self)
	# show_characters_panel()
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
	for node in StatsContainer.get_children():
		node.pressed = (node.get_meta('stat') == stat)
	###
	substract_gold = 0
	$StatsPanel.show()
	$StatsPanel/ConfirmButton.visible = stat != null
	$StatsPanel/Gold.show()
	var stat_next_level = int(character.get_stat(stat) + 1)
	$StatsPanel/StatInfoNameValue.text = stats_dict[stat]
	$StatsPanel/StatInfoCurrentValue.text = "Current value: " + str(character.get_stat(stat))
	if variables.growth_factor_upgrade.has(stat_next_level):
		$StatsPanel/StatInfoCurrentValue.show()
		$StatsPanel/StatInfoNameValue.show()
		substract_gold = variables.growth_factor_upgrade[stat_next_level]
		$StatsPanel/ConfirmButton.disabled = ResourceScripts.game_res.money < substract_gold
		$StatsPanel/Gold/Label.text = str(substract_gold)
	else:
#		$StatsPanel/StatInfoCurrentValue.hide()
#		$StatsPanel/StatInfoNameValue.hide()
		$StatsPanel/StatInfoCurrentValue.text += "Max value reached." + "\n" + "Upgrade is not possible."
		$StatsPanel/ConfirmButton.disabled = true
		$StatsPanel/Gold.hide()
		show_stats(character)
	person = character
	active_stat = stat



var active_stat


func upgrade_stat():
	var character = person
	var stat = active_stat
	ResourceScripts.game_res.money -= substract_gold
	character.add_stat(stat, 1)
	show_stats(character)
	show_stat_info(stat, character)

