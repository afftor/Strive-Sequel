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
	$autoassign.connect('pressed', self, 'toggle_autoassign')

func update_upgrades_tree(ch, tab):
	person = ch
	curtab = tab
	input_handler.ClearContainer(self, ['Button', 'Button2', 'autoassign'])
	$autoassign.pressed = person.get_stat('loyalty_locked')
	$autoassign.visible = person.get_stat('slave_spec') != null 
	for code in upgrades_data:
		var panel
		if code == 'autoassign':
			panel = $autoassign
		elif code.begins_with('slave_'):
			panel = input_handler.DuplicateContainerTemplate(self, 'Button2')
			panel.setup_prof(code)
#			panel.connect("pressed", self, "select_prof", [code])
		else:
			panel = input_handler.DuplicateContainerTemplate(self, 'Button')
			panel.setup_upgrade(code)
			panel.connect("pressed", self, "learn_upgrade", [code])
		if upgrades_data[code].tab != curtab:
			panel.visible = false
		panel.rect_position = unit_size * Vector2(upgrades_data[code].x, upgrades_data[code].y)
		


func gather_data():
	upgrades_data.autoassign = {tab = 1, x = 1}
	for trait_data in Traitdata.traits.values():
		if !trait_data.has('tags'): continue
		if !trait_data.tags.has('loyalty'): continue
		if !trait_data.has("tree_position"): continue
		upgrades_data[trait_data.code] = trait_data.tree_position
	for trait_data in Traitdata.slave_profs.values():
		if !trait_data.has("tree_position"): continue
		upgrades_data[trait_data.code] = trait_data.tree_position
		upgrades_data.autoassign.y = trait_data.tree_position.y + 3


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


func select_prof(id):
	selected_id = id
	var text = "Unlock this for {color=green|" + str(person.get_next_slave_prof_lv_loyalty()) + "} Loyalty? This selection blocks other professions. "
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'select_prof_confirmed', tr(text)])


func select_prof_confirmed():
	if selected_id == "": return
	var args = {}
	args["current_trait"] = selected_id
	args["person"] = person
	person.set_slave_prof(selected_id)
#	person.add_stat('loyalty_traits_unlocked', 1)
#	person.add_trait(selected_id)
	selected_id = ""
	update_upgrades_tree(person, curtab)
	root.update()
	input_handler.play_animation("slave_spec_aquired", args)


func toggle_autoassign():
	var val = !person.get_stat('loyalty_locked')
	$autoassign.pressed = val
	if val:
		var loyalty = person.get_stat('loyalty')
		person.add_stat('loyalty', - loyalty)
		person.add_slave_prof_progress(loyalty)
	person.set_stat('loyalty_locked', val)
	update_upgrades_tree(person, curtab)
	root.update()


func assign_loyalty():
	var text = "Assign all loyalty to profession? "
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'assign_loyalty_confirm', tr(text)])

func assign_loyalty_confirm():
	var loyalty = person.get_stat('loyalty')
	person.add_stat('loyalty', - loyalty)
	person.add_slave_prof_progress(loyalty)
	update_upgrades_tree(person, curtab)
	root.update()
