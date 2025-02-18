extends Control

var combatlist = []

func _ready():
	variables.allow_remote_intereaction = true
	$test.connect("pressed", self, 'run_test')
	
	for id in ['weak', 'medium', 'strong', 'maxed']:
		$selector2.add_item(id)
#	setup_player()
	for id in Enemydata.enemygroups:
		combatlist.push_back(id)
	
	combatlist.sort()
	
	for i in combatlist:
		$selector.add_item(i)


func setup_player_test():
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
	ResourceScripts.game_res.materials.trap = 50
	ResourceScripts.game_res.materials.bandage = 50
	ResourceScripts.game_res.materials.unstable_concoction = 50
	input_handler.active_location = {
		group = {},
		id = 'aliron',
		}
	setup_player()
	globals.char_roll_data.no_roll = true
	var enc_template = {unittype = 'randomgroup', unitcode = combatlist[$selector.selected], bg = 'default', bgm = 'default', win_effects = [], lose_effects = [], enemy_stats_mod = float($mod1.text)}
	Enemydata.encounters.combat_test = enc_template
	globals.current_enemy_group = 'combat_test'
	input_handler.get_spec_node(input_handler.NODE_COMBATPOSITIONS)


func make_item(id, level):
	var q
	var t
	var item
	match level:
		1:
			q = input_handler.random_from_array(['poor', 'average'])
			t = input_handler.random_from_array(['t1', 't2'])
			item = globals.CreateGearItemQuality(id, t, q)
		2:
			q = input_handler.random_from_array(['average', 'good'])
			t = input_handler.random_from_array(['t3', 't4'])
			item = globals.CreateGearItemQuality(id, t, q , false)
		3:
			q = input_handler.random_from_array(['epic', 'legendary'])
			t = input_handler.random_from_array(['t5', 't6'])
			item = globals.CreateGearItemQuality(id, t, q , false)
		4:
			q = 'legendary'
			t = 't6'
			item = globals.CreateGearItemQualityEnchants(id, t, q)
	globals.AddItemToInventory(item)
	return item


func make_hero(type, level, position = 1, first = false):
	var character = ResourceScripts.scriptdict.class_slave.new("test_combat")
	character.create(input_handler.random_from_array(races.racelist.keys()), input_handler.random_from_array(['male', 'female']), 'random')
	character.fill_boosters()
	characters_pool.move_to_state(character.id)
#	character.set_stat('food_love', "meat")
#	character.set_stat('food_hate', ["grain"])
#	character.set_stat('consent', 5)
	character.add_stat('mastery_point_universal', 50)
	character.is_players_character = true
	character.set_stat('wits', 20)
	character.set_stat('physics', 20)
	if first:
		character.unlock_class("master")
		character.set_slave_category('master')
	else:
		character.set_slave_category('servant')
		character.add_trait('training_s_combat')
	var nm
	var e_list
	if level > 1:
		character.set_stat('wits', 60)
		character.set_stat('physics', 60)
	if level > 2:
		character.set_stat('wits', 100)
		character.set_stat('physics', 100)
	match type:
		'fighter':
			character.set_stat('physics_factor', 3)
			character.set_stat('wits_factor', 3)
			nm = 'fighter'
			var pool1 := ['fighter']
			var pool2 := ['rogue', 'archer']
			var pool3 := {warfare = 0, protection = 0, leadership = 0}
			for mas in pool3:
				pool3[mas] = globals.rng.randi_range(2, 3)
			match character.get_stat('race'):
				'Orc':
					pool2.push_back('berserker')
				'Dragonkin':
					pool2.push_back('dragonknight')
				'Seraph':
					if character.get_stat('sex') == 'female':
						pool2.push_back('valkyrie')
			if level > 1:
				character.set_stat('physics_factor', 5)
				pool1.append_array(pool2)
				pool2 = ['knight', 'paladin']
				for mas in pool3:
					pool3[mas] = globals.rng.randi_range(4, 5)
			if level > 2:
				pool2 = [['knight', 'deathknight'], ['paladin','templar']]
				for mas in pool3:
					pool3[mas] = 6
			for prof in pool1:
				character.unlock_class(prof, true)
				if level < 3:
					nm += '_' + prof
			if !pool2.empty():
				var roll = input_handler.random_from_array(pool2)
				if roll is Array:
					for prof in roll:
						character.unlock_class(prof, true) 
						if level < 3:
							nm += '_' + prof
				else:
					character.unlock_class(roll, true) 
					if level < 3:
						nm += '_' + roll
			if level > 2:
				nm += '_maxed'
			
			match level:
				1:
					e_list = ['chest_base_metal', 'legs_base_metal', 'shield', ['sword', 'mace', 'battleaxe', 'club', 'spear']]
				2:
					e_list = ['chest_base_metal', 'legs_base_metal', 'shield', ['sword', 'mace', 'battleaxe', 'club', 'spear']]
				3:
					e_list = [['chest_base_metal', 'chest_adv_metal'], ['legs_base_metal', 'legs_adv_metal'], 'shield', ['sword', 'mace', 'battleaxe', 'swordadv', 'spearadv', 'maceadv', 'battleaxeadv', 'club', 'spear']]
				4:
					e_list = ['chest_adv_metal', 'legs_adv_metal', 'shield', ['swordadv', 'spearadv', 'maceadv', 'battleaxeadv']]
		'rogue':
			character.set_stat('physics_factor', 3)
			character.set_stat('wits_factor', 3)
			nm = 'rogue'
			var pool1 := ['rogue', 'archer']
			var pool2 := []
			var pool3 := {warfare = 0, stealth = 0, archery = 0}
			for mas in pool3:
				pool3[mas] = globals.rng.randi_range(2, 3)
			if level > 1:
				character.set_stat('physics_factor', 4)
				character.set_stat('wits_factor', 4)
				pool2 = ['assassin', 'ninja', 'sniper', 'ranger']
				for mas in pool3:
					pool3[mas] = globals.rng.randi_range(4, 5)
			if level > 2:
				pool1.append_array(pool2)
				pool2 = []
				for mas in pool3:
					pool3[mas] = 6
			for prof in pool1:
				character.unlock_class(prof, true)
			if !pool2.empty():
				var roll = input_handler.random_from_array(pool2)
				character.unlock_class(roll, true) 
				if level < 3:
					nm += '_' + roll
			if level > 2:
				nm += '_maxed'
			#, ['dagger', 'bow', 'bowadv', 'crossbow', 'crossbowadv']
			match level:
				1:
					e_list = ['chest_base_leather', 'legs_base_leather']
					if position < 4:
						e_list.push_back('dagger')
					else:
						e_list.push_back(['bow', 'crossbow'])
				2:
					e_list = ['chest_base_leather', 'legs_base_leather']
					if position < 4:
						e_list.push_back('dagger')
					else:
						e_list.push_back(['bow', 'crossbow'])
				3:
					e_list = [['chest_base_leather', 'chest_adv_leather'], ['legs_base_leather', 'legs_adv_leather']]
					if position < 4:
						e_list.push_back('dagger')
					else:
						e_list.push_back(['bow', 'bowadv', 'crossbow', 'crossbowadv'])
				4:
					e_list = ['chest_adv_leather', 'legs_adv_leather']
					if position < 4:
						e_list.push_back('dagger')
					else:
						e_list.push_back(['bowadv', 'crossbowadv'])
			
		'support':
			character.set_stat('physics_factor', 3)
			character.set_stat('wits_factor', 3)
			nm = 'support'
			var pool1 := ['acolyte']
			var pool2 := ['priest', 'monk']
			var pool3 := {light = 0, water = 0, leadership = 0}
			for mas in pool3:
				pool3[mas] = globals.rng.randi_range(2, 3)
			if level > 1:
				character.set_stat('charm_factor', 4)
				character.set_stat('wits_factor', 4)
				pool1 = ['acolyte', 'priest']
				pool2 = ['bishop', 'monk', 'shaman', 'bard']
				for mas in pool3:
					pool3[mas] = globals.rng.randi_range(4, 5)
			if level > 2:
				pool1 = ['acolyte', 'priest', 'bishop', 'monk', 'shaman', 'bard']
				pool2 = []
				for mas in pool3:
					pool3[mas] = 6
			for prof in pool1:
				character.unlock_class(prof, true)
			if !pool2.empty():
				var roll = input_handler.random_from_array(pool2)
				character.unlock_class(roll, true) 
				nm += '_' + roll
			if level > 2:
				nm += '_maxed'
			
			match level:
				1:
					e_list = ['chest_base_cloth', 'legs_base_cloth', 'staff']
				2:
					e_list = ['chest_base_cloth', 'legs_base_cloth', 'staff']
				3:
					e_list = [['chest_base_cloth', 'chest_adv_cloth'], ['legs_base_cloth', 'legs_adv_cloth'], ['staff']]
				4:
					e_list = ['chest_adv_cloth', 'legs_adv_cloth', 'staffadv']
		'caster':
			character.set_stat('magic_factor', 3)
			character.set_stat('wits_factor', 4)
			nm = 'caster'
			var pool1 := [['apprentice'], ['scholar']]
			var pool2 := []
			for arr in pool1:
				if !arr.has('apprentice'):
					pool2.push_back(arr.duplicate())
					pool2.back().push_back('apprentice')
				if !arr.has('scholar'):
					pool2.push_back(arr.duplicate())
					pool2.back().push_back('scholar')
				if !arr.has('caster'):
					pool2.push_back(arr.duplicate())
					pool2.back().push_back('caster')
				if !arr.has('shaman'):
					pool2.push_back(arr.duplicate())
					pool2.back().push_back('shaman')
			var pool3 := {fire = 0, water = 0, earth = 0, air = 0, dark = 0, mind = 0}
			for mas in pool3:
				pool3[mas] = globals.rng.randi_range(1, 3)
			if character.get_stat('race') in ['Elf', 'Dryad', 'Fairy', 'DarkElf', 'TribalElf']:
				for arr in pool1:
					if !arr.has('druid'):
						pool2.push_back(arr.duplicate())
						pool2.back().push_back('druid')
			if character.get_stat('sex') == 'female':
				pool2.append_array([['apprentice', 'witch']])
			pool1 = []
			if level > 1:
				character.set_stat('magic_factor', 4)
				var tmp = pool2.duplicate(true)
				pool2 = [['apprentice', 'scholar', 'archmage'],]
				for arr in tmp:
					if !arr.has('caster'):
						pool2.push_back(arr.duplicate())
						pool2.back().push_back('caster')
					if !arr.has('shaman'):
						pool2.push_back(arr.duplicate())
						pool2.back().push_back('shaman')
					if (arr.has('druid') or arr.has('witch')) and arr.has('apprentice'):
						pool2.push_back(arr.duplicate())
						pool2.back().push_back('scholar')
				for mas in pool3:
					pool3[mas] = globals.rng.randi_range(3, 5)
			if level > 2:
				var tmp = pool2.duplicate(true)
				pool2 = []
				for arr in tmp:
					if arr.has('caster'):
						pool2.push_back(arr.duplicate())
						pool2.back().push_back('bloodmage')
						pool2.back().push_back('necromancer')
						if character.get_stat('sex') == 'male':
							pool2.push_back(arr.duplicate())
							pool2.back().push_back('warlock')
							pool2.back().push_back('bloodmage')
							pool2.push_back(arr.duplicate())
							pool2.back().push_back('warlock')
							pool2.back().push_back('necromancer')
					else:
						pool2.push_back(arr.duplicate())
						pool2.back().push_back('caster')
						pool2.back().push_back('engineer')
						pool2.back().push_back('bloodmage')
						pool2.back().push_back('technomancer')
						pool2.push_back(arr.duplicate())
						pool2.back().push_back('caster')
						pool2.back().push_back('engineer')
						pool2.back().push_back('necromancer')
						pool2.back().push_back('technomancer')
						if character.get_stat('sex') == 'male':
							pool2.push_back(arr.duplicate())
							pool2.back().push_back('caster')
							pool2.back().push_back('engineer')
							pool2.back().push_back('warlock')
							pool2.back().push_back('technomancer')
				for mas in pool3:
					pool3[mas] = globals.rng.randi_range(5, 6)
			if level == 4:
				pool1 = ['caster', 'archmage', 'shaman', 'apprentice', 'scholar', 'engineer', 'technomancer', 'necromancer', 'bloodmage']
				pool2 = []
				if character.get_stat('sex') == 'female':
					pool1.push_back('witch')
				if character.get_stat('race') in ['Elf', 'Dryad', 'Fairy', 'DarkElf', 'TribalElf']:
					pool1.push_back('druid')
				if character.get_stat('sex') == 'male':
					pool1.push_back('warlock')
				for mas in pool3:
					pool3[mas] = 6
			for prof in pool1:
				character.unlock_class(prof, true)
			if !pool2.empty():
				var roll = input_handler.random_from_array(pool2)
				if roll is Array:
					for prof in roll:
						character.unlock_class(prof, true) 
						if level < 3:
							nm += '_' + prof
						if level == 3 and (prof == roll[-1] or prof == roll[-2]):
							nm += '_' + prof
			if level == 4:
				nm += '_maxed'
			
			match level:
				1:
					e_list = ['chest_base_cloth', 'legs_base_cloth', 'staff']
				2:
					e_list = ['chest_base_cloth', 'legs_base_cloth', 'staff']
				3:
					e_list = [['chest_base_cloth', 'chest_adv_cloth'], ['legs_base_cloth', 'legs_adv_cloth'], ['staff']]
				4:
					e_list = ['chest_adv_cloth', 'legs_adv_cloth', 'staffadv']
	character.set_stat('name', nm)
	input_handler.active_location.group['pos' + str(position)] = character.id
	
	for id in e_list:
		var i_id = id
		if i_id is Array:
			i_id = input_handler.random_from_array(i_id)
		var item = make_item(i_id, level)
		character.equip(item)
	
	character.hp = character.get_stat("hpmax")
	character.mp = character.get_stat("mpmax")



func setup_player():
	ResourceScripts.game_party.clear_heroes()
	var level = $selector2.selected + 1
	make_hero('fighter', level, 1, true)
	match level:
		1:
			make_hero('rogue', level, 2)
			make_hero(input_handler.random_from_array(['support', 'caster']), level, 4)
		2:
			make_hero('rogue', level, 3)
			make_hero('support', level, 4)
			make_hero(input_handler.random_from_array(['rogue', 'caster']), level, 5)
		3, 4:
			make_hero('fighter', level, 2)
			make_hero('rogue', level, 3)
			make_hero('rogue', level, 4)
			make_hero('support', level, 5)
			make_hero('caster', level, 6)
	
