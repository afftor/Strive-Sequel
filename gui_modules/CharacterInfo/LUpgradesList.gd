extends Control

var upgrades_data = {
#	"master_bedroom":{
#		x = 1,
#		y = 1
#	}
}

var unit_size = 80

var person
var root

func _ready():
	gather_data()

func update_upgrades_tree(ch):
	person = ch
	input_handler.ClearContainer(self)
	for code in upgrades_data:
		var panel = input_handler.DuplicateContainerTemplate(self)
		panel.setup_upgrade(code)
		panel.rect_position = unit_size * Vector2(upgrades_data[code].x, upgrades_data[code].y)
		panel.connect("pressed", self, "learn_upgrade", [code])


func gather_data():
	for trait_data in Traitdata.traits.values():
		if !trait_data.has('tags'): continue
		if !trait_data.tags.has('loyalty'): continue
		if !trait_data.has("tree_position"): continue
		upgrades_data[trait_data.code] = trait_data.tree_position



func learn_upgrade(id):
	person.add_stat('loyalty', -person.get_price_for_trait(id))
	person.add_stat('loyalty_traits_unlocked', 1)
	person.add_trait(id)
	update_upgrades_tree(person)
	root.update()
