extends Control

#just for comprehension. This scene is no longer "Master Upgrade List",
#but "Tree Upgrade List", where "Tree" - means specific items disposition.
#It works now with master's upgrades and minor training
enum list_types {mastery, minor}
export(list_types) var list_type = list_types.mastery

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

#for optimization reasons, so minor buttons wouldn't have to recalc it each time
var minor_training_count = 0
var minor_training_max = 0

func _ready():
	gather_data()

func set_person(new_person):
	person = new_person
	if is_list_minor():
		minor_training_count = person.get_minor_training_count()
		minor_training_max = person.get_minor_training_max()
#		globals.connecttexttooltip($Tooltip, person.translate(tr(("TOOLTIPMINORTRAINING"))))
#	else:
#		globals.connecttexttooltip($Tooltip, person.translate(tr(("TOOLTIPMASTERTRAINING"))))

func update_upgrades_tree():
	if is_list_mastery():
		set_person(ResourceScripts.game_party.get_master())
	input_handler.ClearContainer(self, ['Button', 'Tooltip'])
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
		if !trait_data.has("tree_position"): continue
		if is_list_mastery():
			if !trait_data.tags.has('loyalty_master'): continue
		elif is_list_minor():
			if !trait_data.tags.has('minor_training'): continue
		upgrades_data[trait_data.code] = trait_data.tree_position


var selected_id = ""
func learn_upgrade(id):
	selected_id = id
	var data = Traitdata.traits[id]
	var currency
	var text
	if is_list_mastery():
		currency = tr('UPGRADELIST_UNLOCK_MP')
		text = tr("UPGRADELIST_UNLOCK") % [data.l_cost, currency]
	elif is_list_minor():
		currency = tr('UPGRADELIST_UNLOCK_GOLD')
		text = tr("UPGRADELIST_UNLOCK_MINOR") % [data.l_cost, currency, str(person.get_minor_training_time())]
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'learn_upgrade_confirmed', text])


func learn_upgrade_confirmed():
	if selected_id == "": return
	var data = Traitdata.traits[selected_id]
	var args = {}
	args["current_trait"] = selected_id
	args["person"] = person
	if is_list_mastery():
		ResourceScripts.game_progress.master_points -= data.l_cost
		person.add_trait(selected_id)
		input_handler.play_animation("trait_aquired", args)
	elif is_list_minor():
		ResourceScripts.game_res.money -= data.l_cost
		person.start_minor_training(selected_id)
#	person.add_stat('loyalty_traits_unlocked', 1)
	selected_id = ""
	update_upgrades_tree()
	root.update()

func is_list_minor():
	return list_type == list_types.minor
func is_list_mastery():
	return list_type == list_types.mastery
