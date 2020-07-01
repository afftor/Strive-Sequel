extends Control


var closebuttonoffset = [15,15]
var closebutton
var open_sound = 'menu_open'
var close_sound = 'menu_close'
var close_played = false

# Main Modules
onready var MAIN_MODULES = {
	MANSION = preload("res://GUI_New/Mansion/MansionMainModule.tscn"),
	SLAVE_INFO = load("res://GUI_New/CharacterInfo/CharInfoMainModule.tscn"),
	INVENTORY = preload("res://GUI_New/Inventory/InventoryMainModule.tscn"),
	EXPLORATION = preload("res://GUI_New/Exploration/ExplorationMainModule.tscn"),
}


# GUI Dict
onready var gui_data = {}

# Variables
var CurrentScene
var PreviousScene
var BaseScene


func _ready():
	# hide()
	# return
	test_mode()
	for scene in MAIN_MODULES:
		var main_module = MAIN_MODULES[scene].instance()
		add_child(main_module)
		gui_data[scene] = {"main_module": main_module}

	CurrentScene = gui_data["MANSION"].main_module
	BaseScene = gui_data["MANSION"].main_module
	visibility_handler()


func _input(event):
	if (event.is_action_released("ESC") || event.is_action_released("RMB")):
		var ignore_rightclick = false
		for i in get_tree().get_nodes_in_group("ignore_rightclicks"):
			if i.get_global_rect().has_point(get_global_mouse_position()):
				ignore_rightclick = true
				continue
		if !ignore_rightclick:
			visibility_handler()


func visibility_handler():
	var has_submodules_opened = (CurrentScene.submodules.size() > 0)
	if has_submodules_opened:
		submodules_handler()
	if CurrentScene == gui_data["INVENTORY"].main_module && PreviousScene == gui_data["SLAVE_INFO"].main_module && CurrentScene.is_visible():
		CurrentScene.hide()
		CurrentScene = PreviousScene
	if BaseScene == gui_data["MANSION"].main_module && !has_submodules_opened:
		BaseScene.mansion_state = "default"
	if !has_submodules_opened && CurrentScene.is_visible():
		CurrentScene = BaseScene
	for scene in gui_data.values():
		scene.main_module.visible = (scene.main_module == CurrentScene)
	CurrentScene.update()
	for subscene in CurrentScene.get_children():
		subscene.update()


func submodules_handler():
	var last_opened_id = (CurrentScene.submodules.size() - 1)
	var last_opened = CurrentScene.submodules[last_opened_id]
	CurrentScene.submodules[last_opened_id].hide()
	CurrentScene.submodules.erase(last_opened)


func close_scene():
	if BaseScene == gui_data["MANSION"].main_module:
		BaseScene.mansion_state = "default"
	for module in CurrentScene.submodules:
		module.hide()
	CurrentScene.submodules.clear()
	set_current_scene(BaseScene)


func set_current_scene(scene):
	if CurrentScene == gui_data["SLAVE_INFO"].main_module:
		PreviousScene = CurrentScene
	CurrentScene = scene
	visibility_handler()


func add_close_button(scene):
	var pos_in_tree = scene.get_child_count()
	rect_pivot_offset = Vector2(rect_size.x/2, rect_size.y/2)
	closebutton = load(ResourceScripts.scenedict.close).instance()
	scene.add_child(closebutton)
	scene.move_child(closebutton, pos_in_tree)
	closebutton.connect("pressed", self, 'close_scene')
	var rect = scene.get_global_rect()
	var pos = Vector2(rect.end.x - closebutton.rect_size.x - closebuttonoffset[0], rect.position.y + closebuttonoffset[1])
	closebutton.rect_global_position = pos



func show_class_info(classcode, person = null):
	if person == null:
		person = gui_data["MANSION"].main_module.active_person
	var node = input_handler.get_spec_node(input_handler.NODE_CLASSINFO) #get_class_info_panel()
	node.open(classcode, person)
	CurrentScene.submodules.append(node)






















func test_mode():
	ResourceScripts.game_world.make_world()
	var character = ResourceScripts.scriptdict.class_slave.new()
	character.create('HalfkinCat', 'male', 'random')
	character.set_stat('consent', 100)
	character.set_stat('penis_virgin', true)
	characters_pool.move_to_state(character.id)
	character.add_trait('core_trait')
	character.unlock_class("master")
	character.unlock_class("archer")
	character.unlock_class("necromancer")
	character.unlock_class("rogue")
	character.unlock_class("pet")
	character.unlock_class("souleater")
	var bow = globals.CreateGearItem("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'})
	globals.AddItemToInventory(bow)
	character.equip(bow)
	character.set_slave_category('master')
	character.statlist.negative_sex_traits = ['dislike_missionary']
	character.statlist.unlocked_sex_traits = [
		'submissive',
		'pushover',
		'bottle_fairy',
		'dominant',
		'sadist',
		'desired',
		'curious',
		'life_power'
	]
	#character.armor = 135
	character.set_stat('wits', 20)
	character.set_stat('consent', 100)
	character.set_stat('charm_factor', 5)
	character.set_stat('physics_factor', 5)
	#character.unlock_class("worker")
	character.mp = 50
	character.unlock_class("sadist")
#		character.unlock_class("caster")
	for i in Skilldata.Skilllist:
		if Skilldata.Skilllist[i].type != 'social':
			continue
		character.skills.social_skills.append(i)
	character.is_players_character = true
	globals.impregnate(character, character)
	#character.pregnancy.duration = 2

	character = ResourceScripts.scriptdict.class_slave.new()
	character.create('HalfkinCat', 'random', 'random')
	character.set_stat('consent', 100)
	character.statlist.negative_sex_traits = ['dislike_missionary']
	characters_pool.move_to_state(character.id)
	#character.unlock_class("attendant")
	character.add_trait('core_trait')
	character.set_slave_category('servant')
	character.set_stat('obedience', 100)
	character.set_stat('lust', 50)
	character.is_players_character = true
	character = ResourceScripts.scriptdict.class_slave.new()
	character.create('HalfkinCat', 'random', 'random')
	characters_pool.move_to_state(character.id)



	character.set_stat('obedience', 0)
	#character.fear = 25
	#character.base_exp = 99
	character.set_stat('charm_factor', 5)
	character.set_stat('physics_factor', 5)
	character.set_stat('wits_factor', 5)
	character.set_stat('sexuals_factor', 5)
	character.set_stat('charm', 100)
	character.set_stat('physics', 100)
	character.set_stat('wits', 100)

	var character2 = ResourceScripts.scriptdict.class_slave.new()
	character2.create('HalfkinCat', 'random', 'random')
	character2.set_stat('charm', 0)
	character2.set_stat('physics', 0)
	character2.set_stat('wits', 0)
	character2.set_stat('sexuals', 0)
	var text = ''
	for i in races.tasklist.values():
		for k in i.production.values():
			var value = character.get_progress_task(i.code, k.code, true) / k.progress_per_item
			if Items.materiallist.has(k.item):
				pass

			else:
				pass

	var base_price = 0
	var output_price = 0
	for i in Items.recipes.values():
		base_price = 0
		output_price = 0
		for k in i.materials:
			base_price += Items.materiallist[k].price * i.materials[k]
		for k in i.items:
			base_price += Items.itemlist[k].price * i.items[k]

		if Items.materiallist.has(i.resultitem):
			output_price = Items.materiallist[i.resultitem].price * i.resultamount
			if base_price != 0:
				text += (
					Items.materiallist[i.resultitem].name
					+ ": Cost - "
					+ str(base_price)
					+ ", Return - "
					+ str(output_price)
					+ "\n"
				)
		else:
			output_price = Items.itemlist[i.resultitem].price * i.resultamount
			if base_price != 0:
				text += (
					Items.itemlist[i.resultitem].name
					+ ": Cost - "
					+ str(base_price)
					+ ", Return - "
					+ str(output_price)
					+ "\n"
				)

	character.set_stat('loyalty', 95)
	character.set_stat('authority', 100)
	character.set_stat('submission', 95)
	character.mp = 10
	character.hp = 95
	#character.exhaustion = 1000
	character.add_trait('core_trait')
	character.set_slave_category('slave')
	character.is_players_character = true

	globals.common_effects(
		[
			{code = 'make_story_character', value = 'Daisy'},
			{
				code = 'unique_character_changes',
				value = 'daisy',
				args = [
					{code = 'sexuals_factor', value = 1, operant = "+"},
					{code = 'sextrait', value = 'submissive', operant = 'add'},  #for sextrait/add setting, trait is appended to character's traits
					{code = 'submission', operant = '+', value = 50},
					{code = 'obedience', operant = '+', value = 30},
					{code = 'tag', operant = 'remove', value = 'no_sex'},
				]
			}
		]
	)
	ResourceScripts.game_res.money = 505590
	for i in Items.materiallist:
		ResourceScripts.game_res.materials[i] = 200
	ResourceScripts.game_res.materials.bandage = 0
	globals.AddItemToInventory(globals.CreateGearItem("handcuffs", {}))
	globals.AddItemToInventory(globals.CreateGearItem("pet_suit", {}))
	globals.AddItemToInventory(globals.CreateGearItem("tail_plug", {}))
	globals.AddItemToInventory(globals.CreateGearItem("maid_dress", {}))
	globals.AddItemToInventory(globals.CreateGearItem("craftsman_suit", {}))
	globals.AddItemToInventory(globals.CreateGearItem("worker_outfit", {}))
	globals.AddItemToInventory(globals.CreateGearItem("lacy_underwear", {}))
	globals.AddItemToInventory(globals.CreateGearItem("animal_gloves", {}))
	globals.AddItemToInventory(globals.CreateGearItem("amulet_of_recognition", {}))
	globals.AddItemToInventory(globals.CreateUsableItem("alcohol"))
	globals.AddItemToInventory(globals.CreateUsableItem("exp_scroll", 4))
	globals.AddItemToInventory(globals.CreateUsableItem("writ_of_exemption", 3))
	globals.AddItemToInventory(globals.CreateUsableItem("lifegem", 5))
	globals.AddItemToInventory(globals.CreateUsableItem("energyshard", 2))
	globals.AddItemToInventory(globals.CreateUsableItem("strong_pheromones", 3))
	globals.AddItemToInventory(globals.CreateUsableItem("revitalizer", 3))
	globals.AddItemToInventory(
		globals.CreateGearItem("axe", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
	)
	globals.AddItemToInventory(globals.CreateGearItem("club", {WeaponMace = 'stone'}))
	globals.AddItemToInventory(
		globals.CreateGearItem("spear", {WeaponHandle = 'wood', Blade = 'obsidian'})
	)
	globals.AddItemToInventory(
		globals.CreateGearItem("pickaxe", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
	)
	globals.AddItemToInventory(
		globals.CreateGearItem("hammer", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
	)
	globals.AddItemToInventory(
		globals.CreateGearItem("hunt_knife", {ToolHandle = 'wood', ToolBlade = 'obsidian'})
	)
	globals.AddItemToInventory(
		globals.CreateGearItem("legs_base_metal", {ArmorBaseHeavy = 'mithril', ArmorTrim = 'wood'})
	)
	globals.AddItemToInventory(
		globals.CreateGearItem("chest_base_metal", {ArmorBaseHeavy = 'mithril', ArmorTrim = 'wood'})
	)
	globals.AddItemToInventory(
		globals.CreateGearItem(
			"chest_base_cloth", {ArmorBaseCloth = 'clothsilk', ArmorTrim = 'wood'}
		)
	)
	ResourceScripts.game_progress.show_tutorial = true
	ResourceScripts.game_progress.active_quests.append(
		{code = 'election_global_quest', stage = 'stage1'}
	)
	for i in ResourceScripts.game_world.areas.plains.factions.values():
		i.totalreputation += 500
	character.unlock_class("pet")
	character.unlock_class("souleater")
	character.mp = 10
	var tmp = {}
	tmp.oral = 70
	tmp.anal = 90
	tmp.petting = 100
	character.set_stat('sex_skills', tmp)
	input_handler.active_location = ResourceScripts.game_world.areas.plains.locations[ResourceScripts.game_world.areas.plains.locations.keys()[3]]  #[state.areas.plains.locations.size()-1]]
	input_handler.active_area = ResourceScripts.game_world.areas.plains

	for i in ResourceScripts.game_world.areas.plains.factions.values():
		i.reputation = 500
