extends Panel

onready var StatsContainer = $StatsPanel/StatsVBox
#onready var CharList = $CharList/ScrollContainer/CharactersVBox
onready var Materials = $StatsPanel/Materials
var selected_character

var stats_dict = {
	"physics_factor": "Physics Factor",
	"magic_factor": "Magic Factor",
	"wits_factor": "Wits Factor",
	"charm_factor": "Charm Factor",
	"sexuals_factor": "Sexuals Factor",
	"tame_factor": "Tame Factor",
	"timid_factor": "Timid Factor",
#	"growth_factor": "Growth Factor"
}

#var price = {
#	2: {gold = 100, wood = 10},
#	3: {gold = 200, woodmagic = 10},
#	4: {gold = 500, woodiron = 10},
#	5: {gold = 1000, mithril = 10, clothmagic = 10},
#	6: {gold = 3000, woodancient = 5, adamantine = 5, clothethereal = 5, bonedragon = 3},
#}

var substract_exp = 0
var current_node
var person

func show():
	if visible: return
	input_handler.CenterNode(self)
	person = get_parent().person
	.show()
#	$StatsPanel/ConfirmButton.grab_focus()
#	input_handler.lock_focus($StatsPanel/ConfirmButton)
	show_stats()


func hide_stats_info():
	$StatsPanel.hide()
	


#func show_characters_panel():
#	# var idx = 0
#	var name
#	input_handler.ClearContainer(CharList)
#	for i in ResourceScripts.game_party.character_order:
#		var character = ResourceScripts.game_party.characters[i]
#		name = character.get_full_name()
#		var newbutton = input_handler.DuplicateContainerTemplate(CharList)
#		newbutton.get_node("CharacterName").text = name
#		newbutton.get_node("icon").texture = character.get_icon()
#		newbutton.connect("pressed", self, "show_stats", [character])
#		newbutton.set_meta("slave", character)
#	$StatsPanel.hide()


func show_stats():
	Materials.hide()
	$StatsPanel/Gold.hide()
	$StatsPanel/StatInfoCurrentValue.hide()
	$StatsPanel/StatInfoNameValue.hide()
	$StatsPanel/ConfirmButton.hide()
	$StatsPanel.show()
	input_handler.ClearContainer(StatsContainer)
	if person == null:
		return
	for stat in stats_dict:
		# if character.get_stat(stat) == 6:
		# 	continue
		if person.is_master() && stat in ["timid_factor", "tame_factor"]:
			continue
		else:
			var newbutton = input_handler.DuplicateContainerTemplate(StatsContainer)
			newbutton.get_node("StatName").text = stats_dict[stat]
			if person.get_stat(stat) == 6:
				newbutton.disabled = true
				continue
			newbutton.connect("pressed", self, "show_stat_info", [stat])
			newbutton.set_meta("stat", stat)
#	update_buttons()


func _ready():
	gui_controller.add_close_button_simple(self)
	# show_characters_panel()
	$StatsPanel/ConfirmButton.connect("pressed", self, "upgrade_stat")


#func update_buttons():
#	for button in CharList.get_children():
#		if !button.has_meta("slave"):
#			continue
#		button.pressed = button.get_meta("slave") == person



func show_stat_info(stat):
	### Testing Node
	$StatsPanel/Testing.text = (
		person.get_full_name()
		+ "\n"
		+ "physics_factor"
		+ str(person.get_stat("physics_factor"))
		+ "\n"
		+ "wits_factor"
		+ str(person.get_stat("wits_factor"))
		+ "\n"
		+ "sexuals_factor"
		+ str(person.get_stat("sexuals_factor"))
		+ "\n"
		+ "charm_factor"
		+ str(person.get_stat("charm_factor"))
		+ "\n"
		+ "timid_factor"
		+ str(person.get_stat("timid_factor"))
		+ "\n"
		+ "tame_factor"
		+ str(person.get_stat("tame_factor"))
		+ "\n"
		+ "magic_factor"
		+ str(person.get_stat("magic_factor"))
		+ "\n"
	)
	### 
	for node in StatsContainer.get_children():
		if !node.has_meta('stat'): continue
		node.pressed = (node.get_meta('stat') == stat)
	###
	substract_exp = 0
	$StatsPanel.show()
	$StatsPanel/ConfirmButton.visible = stat != null
	$StatsPanel/Gold.show()
	var stat_next_level = int(person.get_stat(stat) + 1)
	$StatsPanel/StatInfoNameValue.text = stats_dict[stat]
	$StatsPanel/StatInfoCurrentValue.text = "Current value: " + str(person.get_stat(stat))
	if variables.basestat_factor_upgrade.has(stat_next_level):
		$StatsPanel/StatInfoCurrentValue.show()
		$StatsPanel/StatInfoNameValue.show()
		substract_exp = variables.basestat_factor_upgrade[stat_next_level]
		$StatsPanel/ConfirmButton.disabled = person.get_stat('base_exp') < substract_exp
		$StatsPanel/Gold.text = "EXP: " + str(substract_exp)
	else:
#		$StatsPanel/StatInfoCurrentValue.hide()
#		$StatsPanel/StatInfoNameValue.hide()
		$StatsPanel/StatInfoCurrentValue.text += "Max value reached." + "\n" + "Upgrade is not possible."
		$StatsPanel/ConfirmButton.disabled = true
		show_stats()
	active_stat = stat
	



var active_stat


func upgrade_stat():
	var character = person
	var stat = active_stat
	person.add_stat('base_exp', -substract_exp)
	character.add_stat(stat, 1)
	show_stats()
	show_stat_info(stat)
	gui_controller.slavepanel.update()

