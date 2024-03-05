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
var curtab = 3

func _ready():
	gather_data()

func update_upgrades_tree():
	person = ResourceScripts.game_party.get_master()
	input_handler.ClearContainer(self, ['Button'])
	for code in upgrades_data:
		var panel
		panel = input_handler.DuplicateContainerTemplate(self, 'Button')
		panel.setup_upgrade(code)
		panel.connect("pressed", self, "learn_upgrade", [code])
		if upgrades_data[code].tab != curtab:
			panel.visible = false
		panel.rect_position = unit_size * Vector2(upgrades_data[code].x, upgrades_data[code].y)
		


func gather_data():
	for trait_data in Traitdata.traits.values():
		if !trait_data.has('tags'): continue
		if !trait_data.tags.has('loyalty_master'): continue
		if !trait_data.has("tree_position"): continue
		upgrades_data[trait_data.code] = trait_data.tree_position


var selected_id = ""
func learn_upgrade(id):
	selected_id = id
	var data = Traitdata.traits[id]
	var text = "Unlock this for {color=green|" + str(data.l_cost) + "} Master Points?"
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'learn_upgrade_confirmed', tr(text)])


func learn_upgrade_confirmed():
	if selected_id == "": return
	var data = Traitdata.traits[selected_id]
	var args = {}
	args["current_trait"] = selected_id
	args["person"] = person
	ResourceScripts.game_progress.master_points -= data.l_cost
#	person.add_stat('loyalty_traits_unlocked', 1)
	person.add_trait(selected_id)
	selected_id = ""
	update_upgrades_tree()
	root.update()
	input_handler.play_animation("trait_aquired", args)
