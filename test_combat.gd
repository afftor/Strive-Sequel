extends Control

var combatlist = []

func _ready():
	variables.allow_remote_intereaction = true
	$test.connect("pressed", self, 'run_test')
	
	setup_player()
	for id in Enemydata.enemygroups:
		combatlist.push_back(id)
		$selector.add_item(id)


func setup_player():
	var character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
	character.create('Nereid', 'male', 'random')
	character.fill_boosters()
	character.unlock_class("master")
	characters_pool.move_to_state(character.id)
	#character.armor = 135
	#character.set_stat('wits', 20)
	character.set_stat('consent', 5)
	character.set_stat('charm_factor', 2)
	character.set_stat('physics_factor', 6)
	character.set_stat('sexuals_factor', 6)
	#character.set_stat('wits_factor', 5)
	character.set_stat('food_love', "meat")
	character.set_stat('food_hate', ["grain"])
	character.set_stat('charm', 100)
	character.set_stat('wits', 100)
#	character.add_stat('wits', 100)
	character.add_stat('hpmax', 100)
	
	character.set_stat('height', 'average')
	character.xp_module.base_exp = 1500
	character.add_stat('abil_exp', 1500)
	character.add_stat('resist_normal', 50)
	character.add_stat('damage_reduction', 50)
	character.add_stat('mastery_point_universal', 90)
	character.set_stat('personality_kind', 100)
	character.set_stat('personality_bold', 50)
	var bow = globals.CreateGearItemQuality("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'}, 'poor', false)
	globals.AddItemToInventory(bow)
	bow = globals.CreateGearItemQuality("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'}, 'average', false)
	globals.AddItemToInventory(bow)
	bow = globals.CreateGearItemQuality("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'}, 'legendary', false)
	globals.AddItemToInventory(bow)
	character.equip(bow)
	character.set_slave_category('master')
	character.get_random_traits()
	
#	character.unlock_class("worker")
	character.unlock_class("necromancer")
#	character.unlock_class("caster")
	character.unlock_class("worker")
	character.unlock_class("apprentice")
#	character.unlock_class("assassin")
	character.unlock_class("rogue")
	character.is_players_character = true
	
	globals.common_effects(
			[
				{code = 'make_story_character', value = 'Daisy'},
				{code = 'make_story_character', value = 'Cali'},
				{code = 'make_story_character', value = 'Aire'},
				{code = 'make_story_character', value = 'Jean'},
				{code = 'make_story_character', value = 'Zephyra'},
				{code = 'make_story_character', value = 'Anastasia'},
				{code = 'make_story_character', value = 'Kuro'},
				{code = 'make_story_character', value = 'Lilia'},
			]
		)


func run_test():
	input_handler.active_location = {
		group = {},
		id = 'aliron',
		}
	globals.char_roll_data.no_roll = true
	var enc_template = {unittype = 'randomgroup', unitcode = combatlist[$selector.selected], bg = 'default', bgm = 'default', win_effects = [], lose_effects = []}
	Enemydata.encounters.combat_test = enc_template
	globals.current_enemy_group = 'combat_test'
	input_handler.get_spec_node(input_handler.NODE_COMBATPOSITIONS)
