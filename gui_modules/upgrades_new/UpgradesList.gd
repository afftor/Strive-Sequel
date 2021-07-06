extends Control

var upgrades_data = {
#	"master_bedroom":{
#		tab = 1,
#		x = 1,
#		y = 1
#	}
}

var unit_size = 50

func _ready():
	gather_data()

func update_upgrades_tree(tab_n):
	input_handler.ClearContainer(self)
	for code in upgrades_data:
		if upgrades_data[code].tab != tab_n: continue
		var panel = input_handler.DuplicateContainerTemplate(self)
		panel.setup_upgrade(code)
		panel.rect_position = unit_size * Vector2(upgrades_data[code].x, upgrades_data[code].y)
		panel.connect("pressed", gui_controller.upgrades, "select_upgrade", [code])


func gather_data():
	for upgrade in upgradedata.upgradelist.values():
		if !upgrade.has("tree_position"): continue
		upgrades_data[upgrade.code] = upgrade.tree_position
