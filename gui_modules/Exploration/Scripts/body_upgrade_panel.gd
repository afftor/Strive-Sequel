extends Control

onready var StatsContainer = $StatsPanel/StatsVBox
onready var CharList = $CharList/ScrollContainer/CharactersVBox
onready var UpgList = $UpgradeList/ScrollContainer/upgrades


var substract_gold = 0
var current_node
var person
var active_upgrade

func hide_upg_info():
	$StatsPanel.hide()
	$UpgradeList.hide()


func show_characters_panel():
	# var idx = 0
	input_handler.ClearContainer(CharList)
	for i in ResourceScripts.game_party.character_order:
		var character = ResourceScripts.game_party.characters[i]
		var name = character.get_full_name()
		var newbutton = input_handler.DuplicateContainerTemplate(CharList)
		newbutton.get_node("CharacterName").text = name
		newbutton.get_node("icon").texture = character.get_icon_small()
		newbutton.connect("pressed", self, "select_char", [character])
		newbutton.set_meta("slave", character)
		globals.connectslavetooltip(newbutton, character)
	hide_upg_info()


func select_char(character):
#	person = character
#	active_upgrade = null
#	$UpgradeList.show()
#	$StatsPanel.hide()
#	update_buttons()
	input_handler.get_spec_node(input_handler.NODE_CHAREDIT, [character])



func build_upgrades():
	input_handler.ClearContainer(UpgList)
	for upg in Traitdata.body_upgrades:
		var data = Traitdata.body_upgrades[upg]
		var newnode = input_handler.DuplicateContainerTemplate(UpgList)
		newnode.set_meta('upgrade', upg)
		newnode.get_node('UpgradeName').text = tr(data.name)
		if data.icon is String:
			newnode.get_node('icon').texture = load(data.icon)
		else:
			newnode.get_node('icon').texture = data.icon
		globals.connecttexttooltip(newnode, tr(data.descript))
		newnode.connect('pressed', self, 'select_upgrade', [upg])


func _ready():
	gui_controller.add_close_button(self)
	# show_characters_panel()
	$StatsPanel/ConfirmButton.connect("pressed", self, "upgrade_body")
	globals.connecttexttooltip($Hint, tr("BODY_UPGRADE_TOOLTIP"))
	build_upgrades()


func update_buttons():
	for button in CharList.get_children():
		if !button.has_meta("slave"):
			continue
		button.pressed = button.get_meta("slave") == person
	if person == null:
		hide_upg_info()
		return
	for button in UpgList.get_children():
		if !button.has_meta("upgrade"):
			continue
		var upg = button.get_meta("upgrade")
		button.pressed = upg == active_upgrade
		var data = Traitdata.body_upgrades[upg]
		if person.checkreqs(data.reqs) or person.statlist.body_upgrades.has(upg):
			button.disabled = false
		else:
			button.disabled = true
			if upg == active_upgrade:
				button.pressed = false
				active_upgrade = null
				$StatsPanel.hide()


func select_upgrade(upg):
	active_upgrade = upg
	if person == null:
		return
	update_buttons()
	$StatsPanel.show()
	var data = Traitdata.body_upgrades[upg]
	$StatsPanel/ConfirmButton.disabled = !person.can_add_upgrade(upg)
	$StatsPanel/Gold/Label.text = "%d / %d" % [data.goldcost, ResourceScripts.game_res.money]
	substract_gold = data.goldcost
	if data.goldcost > ResourceScripts.game_res.money:
		$StatsPanel/ConfirmButton.disabled = true
	$StatsPanel/Points.text = "Upgrade points: %d / %d" % [data.cost, person.get_upgrade_points()]
	$StatsPanel/StatInfoNameValue.text = tr(data.name)


func upgrade_stat():
	person.add_upgrade(active_upgrade)
	ResourceScripts.game_res.money -= substract_gold
	#need animation
#	input_handler.play_animation('factor', {stat = active_stat, character = person})
	active_upgrade = null
	update_buttons()


