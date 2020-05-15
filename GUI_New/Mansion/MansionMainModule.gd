extends Control

# Signals
signal population_changed

# Preloads
# const PopulationModule = preload("res://GUI_New/Mansion/MansionPopulationModule.gd")
var SlaveListModule = ResourceScripts.scriptdict.slavelistmodule

# Variables
onready var slavelist_module = SlaveListModule.new() 

# Temporary Testing Variables


func test_mode():
	print("Test Mode Enabled")
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
	var bow = globals.CreateGearItem("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'})
	globals.AddItemToInventory(bow)
	character.equip(bow)
	character.set_slave_category('master')
	character.statlist.negative_sex_traits = ['dislike_missionary']
	character.statlist.unlocked_sex_traits = ['submissive', 'pushover','bottle_fairy','dominant','sadist','desired','curious','life_power']
	#character.armor = 135
	character.set_stat('wits',20)
	character.set_stat('consent',100)
	character.set_stat('charm_factor',5)
	character.set_stat('physics_factor',5)
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
	character.set_stat('consent',100)
	character.statlist.negative_sex_traits = ['dislike_missionary']
	characters_pool.move_to_state(character.id)
	#character.unlock_class("attendant")
	character.add_trait('core_trait')
	character.set_slave_category('servant')
	character.set_stat('obedience', 100)
	character.set_stat('lust',50)
	character.is_players_character = true
	character = ResourceScripts.scriptdict.class_slave.new()
	character.create('HalfkinCat', 'random', 'random')
	characters_pool.move_to_state(character.id)
	
#		for i in range(1,20):
#
#			character = ResourceScripts.scriptdict.class_slave.new()
#			character.create('BeastkinCat', 'random', 'random')
#			characters_pool.move_to_state(character.id)
	
	character.set_stat('obedience', 0)
	#character.fear = 25
	#character.base_exp = 99
	character.set_stat('charm_factor' ,5)
	character.set_stat('physics_factor' ,5)
	character.set_stat('wits_factor' ,5)
	character.set_stat('sexuals_factor' , 5)
	character.set_stat('charm' , 100)
	character.set_stat('physics' ,100)
	character.set_stat('wits' , 100)
	
	var character2 = ResourceScripts.scriptdict.class_slave.new()
	character2.create('HalfkinCat', 'random', 'random')
	character2.set_stat('charm' , 0)
	character2.set_stat('physics' ,0)
	character2.set_stat('wits' , 0)
	character2.set_stat('sexuals' , 0)
	var text = ''
	for i in races.tasklist.values():
		for k in i.production.values():
			var value = character.get_progress_task(i.code, k.code, true)/k.progress_per_item
			if Items.materiallist.has(k.item):
				pass
#					var item = Items.materiallist[k.item]
#					text += item.name + ": Min " + str(stepify(races.get_progress_task(character2, i.code, k.code, true)/k.progress_per_item*item.price,0.1)) 
#					text += ", Max " + str(stepify(value*item.price,0.1)) + "\n"
			else:
				pass
#					text += k.code + ": Min " + str(stepify(races.get_progress_task(character2, i.code, k.code, true)/k.progress_per_item,0.1)) 
#					text += ", Max " + str(stepify(value,0.1)) + "\n"
#
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
			output_price = Items.materiallist[i.resultitem].price*i.resultamount
			if base_price != 0:
				text += Items.materiallist[i.resultitem].name + ": Cost - " + str(base_price) + ", Return - " + str(output_price) + "\n"
		else:
			output_price = Items.itemlist[i.resultitem].price*i.resultamount
			if base_price != 0:
				text += Items.itemlist[i.resultitem].name + ": Cost - " + str(base_price) + ", Return - " + str(output_price) + "\n"
			
	#print(text)
	character.set_stat('loyalty' , 95)
	character.set_stat('authority' ,100)
	character.set_stat('submission' , 95)
	character.mp = 10
	character.hp = 95
	#character.exhaustion = 1000
	character.add_trait('core_trait')
	character.set_slave_category('slave')
	character.is_players_character = true
	
	globals.common_effects([{code = 'make_story_character', value = 'Daisy'}, {code = 'unique_character_changes', value = 'daisy', args = [
		{code = 'sexuals_factor', value = 1, operant = "+"},
		{code = 'sextrait', value = 'submissive', operant = 'add'},#for sextrait/add setting, trait is appended to character's traits
		{code = 'submission', operant = '+', value = 50},
		{code = 'obedience', operant = '+', value = 30},
		{code = 'tag', operant = 'remove', value = 'no_sex'},
		]}])
	#state.revert()
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
	globals.AddItemToInventory(globals.CreateUsableItem("exp_scroll",4))
	globals.AddItemToInventory(globals.CreateUsableItem("writ_of_exemption", 3))
	globals.AddItemToInventory(globals.CreateUsableItem("lifegem", 5))
	globals.AddItemToInventory(globals.CreateUsableItem("energyshard", 2))
	globals.AddItemToInventory(globals.CreateUsableItem("strong_pheromones", 3))
	globals.AddItemToInventory(globals.CreateUsableItem("revitalizer", 3))
	globals.AddItemToInventory(globals.CreateGearItem("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'}))
	globals.AddItemToInventory(globals.CreateGearItem("axe", {ToolHandle = 'wood', ToolBlade = 'obsidian'}))
	globals.AddItemToInventory(globals.CreateGearItem("club", {WeaponMace = 'stone'}))
	globals.AddItemToInventory(globals.CreateGearItem("spear", {WeaponHandle = 'wood', Blade = 'obsidian'}))
	globals.AddItemToInventory(globals.CreateGearItem("pickaxe", {ToolHandle = 'wood', ToolBlade = 'obsidian'}))
	globals.AddItemToInventory(globals.CreateGearItem("hammer", {ToolHandle = 'wood', ToolBlade = 'obsidian'}))
	globals.AddItemToInventory(globals.CreateGearItem("hunt_knife", {ToolHandle = 'wood', ToolBlade = 'obsidian'}))
	globals.AddItemToInventory(globals.CreateGearItem("legs_base_metal", {ArmorBaseHeavy = 'mithril', ArmorTrim = 'wood'}))
	globals.AddItemToInventory(globals.CreateGearItem("chest_base_metal", {ArmorBaseHeavy = 'mithril', ArmorTrim = 'wood'}))
	globals.AddItemToInventory(globals.CreateGearItem("chest_base_cloth", {ArmorBaseCloth = 'clothsilk', ArmorTrim = 'wood'}))
	#$SlaveList.rebuild()
	#state.common_effects([{code = 'make_quest_location', value = 'quest_fighters_lich'}])
	ResourceScripts.game_progress.show_tutorial = true
#		state.active_quests.append({code = "lich_enc_initiate", stage = 'stage1'})
	#state.decisions = ["fighters_election_support",'mages_election_support','workers_election_support']
#	state.mainprogress = 0
	ResourceScripts.game_progress.active_quests.append({code = 'election_global_quest', stage = 'stage1'})
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
	character.set_stat('base_exp', 500)
	#input_handler.get_spec_node(input_handler.NODE_LOOTTABLE).open(world_gen.make_chest_loot('mages_join_reward'), 'Teh Loot')
	#input_handler.get_loot_node().open(world_gen.make_chest_loot('warriors_join_reward'), ' Loot')
	input_handler.active_location = ResourceScripts.game_world.areas.plains.locations[ResourceScripts.game_world.areas.plains.locations.keys()[3]]#[state.areas.plains.locations.size()-1]]
	input_handler.active_area = ResourceScripts.game_world.areas.plains
	#state.decisions = ['fighters_election_support', 'workers_election_support', 'servants_election_support', 'mages_election_support']
	#input_handler.add_random_chat_message(newchar, 'hire')
	#input_handler.interactive_message("starting_dialogue4", '',{})
	
	#input_handler.interactive_message('intro', '', {})
	
	for i in ResourceScripts.game_world.areas.plains.factions.values():
		i.reputation = 500


func _ready():
	# connect("population_changed", self, "test")
	# connect("population_changed", population_module, "_on_population_changed")
	test_mode()
	yield(get_tree(), "idle_frame")
	$MansionSlaveListModule.rebuild()

func test():
	# population_module._on_population_changed()
	pass

