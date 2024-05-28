extends Control

onready var StatsContainer = $StatsPanel/StatsVBox
onready var CharList = $CharList/ScrollContainer/CharactersVBox
onready var CharList2 = $CharList2/ScrollContainer/CharactersVBox

var stats_dict = {
	"growth_factor": "Growth Factor",
	"physics_factor": "Physics Factor",
	"wits_factor": "Wits Factor",
	"charm_factor": "Charm Factor",
	"sexuals_factor": "Sexuals Factor",
	"timid_factor": "Timid Factor",
	"tame_factor": "Tame Factor",
	"magic_factor": "Magic Factor",
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
var person2
var active_stat

func hide_stats_info():
	$StatsPanel.hide()


func show_characters_panel():
	# var idx = 0
	input_handler.ClearContainer(CharList)
	for i in ResourceScripts.game_party.character_order:
		var character = ResourceScripts.game_party.characters[i]
		var name = character.get_full_name()
		var newbutton = input_handler.DuplicateContainerTemplate(CharList)
		newbutton.get_node("CharacterName").text = name
		newbutton.get_node("icon").texture = character.get_icon_small()
		newbutton.connect("pressed", self, "select_char", [character, 1])
		newbutton.set_meta("slave", character)
		globals.connectslavetooltip(newbutton, character)
	input_handler.ClearContainer(CharList2)
	for i in ResourceScripts.game_party.character_order:
		var character = ResourceScripts.game_party.characters[i]
		if character.is_master() : continue
		if character.is_unique() : continue
		if character.get_stat('slave_class') == 'servant': continue
		var name = character.get_full_name()
		var newbutton = input_handler.DuplicateContainerTemplate(CharList2)
		newbutton.get_node("CharacterName").text = name
		newbutton.get_node("icon").texture = character.get_icon_small()
		newbutton.connect("pressed", self, "select_char", [character, 2])
		newbutton.set_meta("slave", character)
		globals.connectslavetooltip(newbutton.get_node('icon'), character)
	$StatsPanel.hide()


func select_char(character, slot):
	if slot == 1:
		person = character
	else:
		person2 = character
	active_stat = null
	show_stats()


func show_stats():
	update_buttons()
	if person == null or person2 == null:
		$StatsPanel.hide()
		return
	if person == person2:
		$StatsPanel.hide()
		return
	$StatsPanel/Gold.hide()
	$StatsPanel/StatInfoCurrentValue.hide()
	$StatsPanel/StatInfoNameValue.hide()
	$StatsPanel/ConfirmButton.hide()
	$StatsPanel.show()
	input_handler.ClearContainer(StatsContainer)
	for stat in stats_dict:
		# if character.get_stat(stat) == 6:
		# 	continue
		if stat != 'growth_factor' and ResourceScripts.game_globals.difficulty == 'hard':
			continue
		if person.is_master() && stat in ["timid_factor", "tame_factor"]:
			continue
		else:
			var newbutton = input_handler.DuplicateContainerTemplate(StatsContainer)
			newbutton.get_node("StatName").text = stats_dict[stat]
			if stat == 'growth_factor':
				newbutton.get_node("StatName").set("custom_colors/font_color", variables.hexcolordict.yellow)
			if person.get_stat(stat) == 6:
				newbutton.disabled = true
				continue
			if person.get_stat(stat) >= person2.get_stat(stat):
				newbutton.disabled = true
				continue
			newbutton.connect("pressed", self, "show_stat_info", [stat])
			newbutton.set_meta("stat", stat)


func _ready():
	gui_controller.add_close_button(self)
	# show_characters_panel()
	$StatsPanel/ConfirmButton.connect("pressed", self, "upgrade_stat")
	globals.connecttexttooltip($Hint, tr("FACTOR_INCREASE_TOOLTIP"))


func update_buttons():
	for button in CharList.get_children():
		if !button.has_meta("slave"):
			continue
		button.pressed = button.get_meta("slave") == person
	for button in CharList2.get_children():
		if !button.has_meta("slave"):
			continue
		button.pressed = button.get_meta("slave") == person2



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
		if !node.has_meta("stat"):
			continue
		node.pressed = (node.get_meta('stat') == stat)
	###
	substract_gold = 0
	$StatsPanel.show()
	$StatsPanel/ConfirmButton.visible = stat != null
	$StatsPanel/Gold.show()
	var stat_cur_level = int(person.get_stat(stat))
	var stat_next_level
#	if stat == 'growth_factor':
	stat_next_level = stat_cur_level + 1
#	else:
#		stat_next_level = int(person2.get_stat(stat))
	$StatsPanel/StatInfoNameValue.text = stats_dict[stat]
	if input_handler.globalsettings.factors_as_words:
		$StatsPanel/StatInfoCurrentValue.text = ResourceScripts.descriptions.factor_descripts[stat_cur_level] + "->" + ResourceScripts.descriptions.factor_descripts[stat_next_level]
	else:
		$StatsPanel/StatInfoCurrentValue.text = str(stat_cur_level) + "->" + str(stat_next_level)

	$StatsPanel/StatInfoCurrentValue.show()
	$StatsPanel/StatInfoNameValue.show()
	substract_gold = int (person.calculate_price() * 0.5)
	$StatsPanel/ConfirmButton.disabled = ResourceScripts.game_res.money < substract_gold
	$StatsPanel/Gold/Label.text = str(substract_gold)
	active_stat = stat


func upgrade_stat():
	var tmp = person.get_stat(active_stat)
	if tmp >= 6:
		print("error - can't upgrade stat to 7 or greater")
		return
	ResourceScripts.game_res.money -= substract_gold
#	if active_stat == 'growth_factor':
	person.add_stat(active_stat, 1)
#	else:
#		person.set_stat(active_stat, person2.get_stat(active_stat))
	ResourceScripts.game_party.add_fate(person2.id, tr("SOLD2STAT"))
	ResourceScripts.game_party.remove_slave(person2, true)
	input_handler.play_animation('factor', {stat = active_stat, character = person})
	active_stat = null
	person2 = null
	show_characters_panel()


