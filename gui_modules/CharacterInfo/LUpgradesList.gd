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
var curtab = 1

func _ready():
	gather_data()

func update_upgrades_tree(ch, tab):
	person = ch
	curtab = tab
	input_handler.ClearContainer(self)
	for code in upgrades_data:
		var panel = input_handler.DuplicateContainerTemplate(self)
		panel.setup_upgrade(code)
		if upgrades_data[code].tab != curtab:
			panel.visible = false
		panel.rect_position = unit_size * Vector2(upgrades_data[code].x, upgrades_data[code].y)
		panel.connect("pressed", self, "learn_upgrade", [code])


func gather_data():
	for trait_data in Traitdata.traits.values():
		if !trait_data.has('tags'): continue
		if !trait_data.tags.has('loyalty'): continue
		if !trait_data.has("tree_position"): continue
		upgrades_data[trait_data.code] = trait_data.tree_position

var selected_id = ""
func learn_upgrade(id):
	selected_id = id
	var text = "Unlock this for {color=green|" + str(person.get_price_for_trait(id)) + "} Loyalty?"
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'learn_upgrade_confirmed', tr(text)])


func learn_upgrade_confirmed():
	if selected_id == "": return
	var args = {}
	args["current_trait"] = selected_id
	args["person"] = person
	person.add_stat('loyalty', -person.get_price_for_trait(selected_id))
	person.add_stat('loyalty_traits_unlocked', 1)
	person.add_trait(selected_id)
	selected_id = ""
	update_upgrades_tree(person, curtab)
	root.update()
	input_handler.play_animation("trait_aquired", args)
