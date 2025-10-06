extends Node

var statdata = {
	#special - not in any of stats
	hp = {
		code = 'hp',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		tags = ['numeric', 'integer']
	},
	mp = {
		code = 'mp',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		tags = ['numeric', 'integer']
	},
	price = { 
		code = 'price',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['numeric'],
	},
	slave_class = {
		code = 'slave_class',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = [],
		direct = true
	},
	base_exp = {
		code = 'base_exp',
		name = '',
		descript = '',
		baseicon = 'stat_exp',
		type = 'misc',
		tags = ['numeric']
	},
	loyalty = {
		code = 'loyalty',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
		tags = ['numeric', 'integer']
	},
	spirit = {
		code = 'spirit',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
		tags = ['numeric', 'integer']
	},
	resistance = {
		code = 'resistance',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
		tags = ['numeric', 'integer']
	},
	thrall_master = {
		code = 'thrall_master',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
		tags = [],
		default_bonus = 'set'
	},
	thralls = {
		code = 'thralls',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
		tags = ['array'],
		default_bonus = 'append'
	},
	thralls_amount = {
		code = 'thralls_amount',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
		tags = ['integer'],
		default_bonus = 'set' #no setter actually
	},
	thrall_points = {
		code = 'thrall_points',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
		tags = ['integer'],
		default_bonus = 'set' #no setter actually
	},
	thralls_amount_max = {
		code = 'thralls_amount_max',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
		tags = ['integer'],
		default_bonus = 'set' #no setter actually
	},
	food_hate = {
		code = 'food_hate',
		name = '',
		descript = '',
		baseicon = 'food_hate',
		type = 'misc',
	},
	food_love = {
		code = 'food_love',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
	},
	#exterior
	beard = {
		code = 'beard',
		tags = [],
		default_bonus = 'set',
		container = 'exterior',
	},
	balls_size = {
		code = 'balls_size',
		tags = [],
		default_bonus = 'set',
		container = 'exterior',
	},
	tits_size = {
		code = 'tits_size',
		tags = [],
		default_bonus = 'set',
		container = 'exterior',
	},
	ass_size = {
		code = 'ass_size',
		tags = [],
		default_bonus = 'set',
		container = 'exterior',
	},
	chin = {
		code = 'chin',
		tags = [],
		default_bonus = 'set',
		container = 'exterior',
	},
	penis_size = {
		code = 'penis_size',
		tags = [],
		default_bonus = 'set',
		container = 'exterior',
	},
	eye_tex = {
		code = 'eye_tex',
		tags = [],
		default_bonus = 'set',
		container = 'exterior',
	},
	eyebrows = {
		code = 'eyebrows',
		tags = [],
		default_bonus = 'set',
		container = 'exterior',
	},
	hair_base_length = {
		code = 'hair_base_length',
		tags = [],
		default_bonus = 'set',
		container = 'exterior',
	},
	hair_fringe_length = {
		code = 'hair_fringe_length',
		tags = [],
		default_bonus = 'set',
		container = 'exterior',
	},
	hair_back_length = {
		code = 'hair_back_length',
		tags = [],
		default_bonus = 'set',
		container = 'exterior',
	},
	hair_assist_length = {
		code = 'hair_assist_length',
		tags = [],
		default_bonus = 'set',
		container = 'exterior',
	},
	has_pussy = {
		code = 'has_pussy',
		tags = ['bool'],
		default_bonus = 'set',
		container = 'exterior',
	},
	has_womb = {
		code = 'has_womb',
		tags = ['bool'],
		default_bonus = 'set',
		container = 'exterior',
	},
	skin = {
		code = 'skin',
		tags = ['custom_setter', 'custom_getter'],
		default_bonus = 'set',
	},
	pose = {
		code = 'pose',
		tags = ['custom_getter'],
		default_bonus = 'set',
	},
	hair_length = {
		code = 'hair_length',
		tags = ['obsolete'],
		default_bonus = 'set',
	},
	hair_color = {
		code = 'hair_color',
		tags = ['obsolete'],
		default_bonus = 'set',
	},
	hair_style = {
		code = 'hair_style',
		tags = ['obsolete'],
		default_bonus = 'set',
	},
	height = {
		code = 'height',
		tags = [],
		default_bonus = 'set',
	},
	ears = {
		code = 'ears',
		tags = [],
		default_bonus = 'set',
	},
	eye_color = {
		code = 'eye_color',
		tags = [],
		default_bonus = 'set',
	},
	eye_shape = {
		code = 'eye_shape',
		tags = [],
		default_bonus = 'set',
	},
	horns = {
		code = 'horns',
		tags = [],
		default_bonus = 'set',
	},
	wings = {
		code = 'wings',
		tags = [],
		default_bonus = 'set',
	},
	tail = {
		code = 'tail',
		tags = [],
		default_bonus = 'set',
	},
	arms = {
		code = 'arms',
		tags = [],
		default_bonus = 'set',
	},
	legs = {
		code = 'legs',
		tags = [],
		default_bonus = 'set',
	},
	body_lower = {
		code = 'body_lower',
		tags = [],
		default_bonus = 'set',
	},
	body_shape = {
		code = 'body_shape',
		tags = [],
		default_bonus = 'set',
	},
	skin_coverage = {
		code = 'skin_coverage',
		tags = [],
		default_bonus = 'set',
	},
	facial_hair = {
		code = 'facial_hair',
		tags = [],
		default_bonus = 'set',
	},
	eyeshape = {
		code = 'eyeshape',
		tags = [],
		default_bonus = 'set',
	},
	nose = {
		code = 'nose',
		tags = [],
		default_bonus = 'set',
	},
	lips = {
		code = 'lips',
		tags = [],
		default_bonus = 'set',
	},
	body_color_skin = {
		code = 'body_color_skin',
		tags = [],
		default_bonus = 'set',
	},
	body_color_lips = {
		code = 'body_color_lips',
		tags = [],
		default_bonus = 'set',
	},
	body_color_wings = {
		code = 'body_color_wings',
		tags = [],
		default_bonus = 'set',
	},
	body_color_tail = {
		code = 'body_color_tail',
		tags = [],
		default_bonus = 'set',
	},
	body_color_horns = {
		code = 'body_color_horns',
		tags = [],
		default_bonus = 'set',
	},
	body_color_animal = {
		code = 'body_color_animal',
		tags = ['custom_getter'],
		default_bonus = 'set',
	},
	body_color_ears = {
		code = 'body_color_ears',
		tags = ['custom_getter'],
		default_bonus = 'set',
	},
	hair_base = {
		code = 'hair_base',
		tags = [],
		default_bonus = 'set',
	},
	hair_assist = {
		code = 'hair_assist',
		tags = [],
		default_bonus = 'set',
	},
	hair_back = {
		code = 'hair_back',
		tags = [],
		default_bonus = 'set',
	},
	hair_fringe = {
		code = 'hair_fringe',
		tags = [],
		default_bonus = 'set',
	},
	hair_base_color_1 = {
		code = 'hair_base_color_1',
		tags = [],
		default_bonus = 'set',
	},
	hair_fringe_color_1 = {
		code = 'hair_fringe_color_1',
		tags = [],
		default_bonus = 'set',
	},
	hair_back_color_1 = {
		code = 'hair_back_color_1',
		tags = [],
		default_bonus = 'set',
	},
	hair_assist_color_1 = {
		code = 'hair_assist_color_1',
		tags = [],
		default_bonus = 'set',
	},
	hair_base_color_2 = {
		code = 'hair_base_color_2',
		tags = [],
		default_bonus = 'set',
	},
	hair_fringe_color_2 = {
		code = 'hair_fringe_color_2',
		tags = [],
		default_bonus = 'set',
	},
	hair_back_color_2 = {
		code = 'hair_back_color_2',
		tags = [],
		default_bonus = 'set',
	},
	hair_assist_color_2 = {
		code = 'hair_assist_color_2',
		tags = [],
		default_bonus = 'set',
	},
	hair_facial_color = {
		code = 'hair_facial_color',
		tags = ['custom_getter'],
		default_bonus = 'set',
	},
	#mastery_points
	mastery_point_magic = {
		code = 'mastery_point_magic',
		name = '',
		descript = '',
		baseicon = 'stat_exp',
		type = 'misc',
		tags = ['show_in_header', 'integer', 'custom_bonuses'],
		direct = false,
	},
	mastery_point_universal = {
		code = 'mastery_point_universal',
		name = '',
		descript = '',
		baseicon = 'stat_exp',
		type = 'misc',
		tags = ['show_in_header', 'integer', 'custom_bonuses'],
		direct = false,
	},
	mastery_point_combat = {
		code = 'mastery_point_combat',
		name = '',
		descript = '',
		baseicon = 'stat_exp',
		type = 'misc',
		tags = ['show_in_header', 'integer', 'custom_bonuses'],
		direct = false,
	},
	
	enabled_masteries = {
		code = 'enabled_masteries',
		name = '',
		descript = '',
		baseicon = 'food_love',
		default_bonus = 'array',
		array_type = 'mastery',
		direct = false,
		tags = []
	},
	disabled_masteries = {
		code = 'disabled_masteries',
		name = '',
		descript = '',
		is_negative = true,
		baseicon = 'food_love',
		default_bonus = 'array',
		array_type = 'mastery',
		direct = false,
		tags = []
	},
	#factors
	growth_factor = {
		code = 'growth_factor',
		name = '',
		descript = '',
		baseicon = 'stat_gf',
		type = 'factor',
		abb = 'GRO',
		tags = ['integer', 'factor'],
		direct = false,
		innate_bonuses = {mincap = variables.minimum_factor_value, maxcap = variables.maximum_factor_value},
		show_info = {category = 'non_combat'}
	},
	physics_factor = {
		code = 'physics_factor',
		name = '',
		descript = '',
		baseicon = 'stat_pf',
		type = 'factor',
		abb = 'PHY',
		tags = ['integer', 'factor'],
		direct = false,
		innate_bonuses = {mincap = variables.minimum_factor_value, maxcap = variables.maximum_factor_value},
		show_info = {category = 'non_combat'}
	},
	wits_factor = {
		code = 'wits_factor',
		name = '',
		descript = '',
		baseicon = 'stat_wit',
		type = 'factor',
		abb = 'WIT',
		tags = ['integer', 'factor'],
		direct = false,
		innate_bonuses = {mincap = variables.minimum_factor_value, maxcap = variables.maximum_factor_value},
		show_info = {category = 'non_combat'}
	},
	charm_factor = {
		code = 'charm_factor',
		name = '',
		descript = '',
		baseicon = 'stat_charm',
		type = 'factor',
		abb = 'CHA',
		tags = ['integer', 'factor'],
		direct = false,
		innate_bonuses = {mincap = variables.minimum_factor_value, maxcap = variables.maximum_factor_value},
		show_info = {category = 'non_combat'}
	},
	sexuals_factor = {
		code = 'sexuals_factor',
		name = '',
		descript = '',
		baseicon = 'stat_sf',
		type = 'factor',
		abb = 'SEX',
		tags = ['integer', 'factor'],
		direct = false,
		innate_bonuses = {mincap = variables.minimum_factor_value, maxcap = variables.maximum_factor_value},
		show_info = {category = 'non_combat'}
	},
	magic_factor = {
		code = 'magic_factor',
		name = '',
		descript = '',
		baseicon = 'stat_mf',
		type = 'factor',
		abb = 'MAG',
		tags = ['integer', 'factor'],
		direct = false,
		innate_bonuses = {mincap = variables.minimum_factor_value, maxcap = variables.maximum_factor_value},
		show_info = {category = 'non_combat'}
	},
	tame_factor = {
		code = 'tame_factor',
		name = '',
		descript = '',
		baseicon = 'stat_tf',
		type = 'factor',
		abb = 'TAM',
		tags = ['integer', 'factor'],
		direct = false,
		innate_bonuses = {mincap = variables.minimum_factor_value, maxcap = variables.maximum_factor_value},
		show_info = {category = 'non_combat'}
	},
	authority_factor = {
		code = 'authority_factor',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = 'factor',
		abb = 'TIM',
		tags = ['integer', 'factor'],
		direct = false,
		innate_bonuses = {mincap = variables.minimum_factor_value, maxcap = variables.maximum_factor_value},
		show_info = {category = 'non_combat'}
	},
	#basestats caps
	physics_cap = {
		code = 'physics_cap',
		name = '',
		descript = '',
		baseicon = 'stat_pf',
		type = 'cap',
		abb = 'PHY',
		tags = ['integer'],
		direct = false
	},
	wits_cap = {
		code = 'wits_cap',
		name = '',
		descript = '',
		baseicon = 'stat_wit',
		type = 'cap',
		abb = 'WIT',
		tags = ['integer'],
		direct = false
	},
	charm_cap = {
		code = 'charm_cap',
		name = '',
		descript = '',
		baseicon = 'stat_charm',
		type = 'cap',
		abb = 'CHA',
		tags = ['integer'],
		direct = false
	},
	#basestats
	physics = {
		code = 'physics',
		name = '',
		descript = '',
		baseicon = 'stat_bf',
		type = 'primal',
		tags = ['integer', 'cap_up', 'cap_low'],
		cap_up = 'physics_cap',
		cap_low = 0,
		show_info = {category = 'non_combat'}
	},
	wits = {
		code = 'wits',
		name = '',
		descript = '',
		baseicon = 'stat_bf',
		type = 'primal',
		tags = ['integer', 'cap_up', 'cap_low'],
		cap_up = 'wits_cap',
		cap_low = 0,
		show_info = {category = 'non_combat'}
	},
	charm = {
		code = 'charm',
		name = '',
		descript = '',
		baseicon = 'stat_bf',
		type = 'primal',
		tags = ['integer', 'cap_up', 'cap_low'],
		cap_up = 'charm_cap',
		cap_low = 0,
		show_info = {category = 'non_combat'}
	},
	sexuals = {
		code = 'sexuals',
		name = '',
		descript = '',
		baseicon = 'stat_bf',
		type = 'primal',
		tags = ['integer', 'custom_getter'],
	},
	physics_bonus = {
		code = 'physics_bonus',
		name = '',
		descript = '',
		baseicon = 'food_love',
		direct = false,
		tags = ['integer', 'custom_bonuses'],
	},
	wits_bonus = {
		code = 'wits_bonus',
		name = '',
		descript = '',
		baseicon = 'food_love',
		direct = false,
		tags = ['integer', 'custom_bonuses'],
	},
	charm_bonus = {
		code = 'charm_bonus',
		name = '',
		descript = '',
		baseicon = 'food_love',
		direct = false,
		tags = ['integer', 'custom_bonuses'],
	},
	sexuals_bonus = {
		code = 'sexuals_bonus',
		name = '',
		descript = '',
		baseicon = 'food_love',
		direct = false,
		tags = ['integer', 'custom_bonuses'],
	},
	#lust
	lust = {
		code = 'lust',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
		tags = ['integer', 'cap_up', 'cap_low', 'custom_bonuses'],
		cap_up = 'lustmax',
		cap_low = 0,
	},
	lusttick = {
		code = 'lusttick',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
		default_bonus = 'add_part',
		direct = false,
		tags = ['numeric']
	},
	lustmax = {
		code = 'lustmax',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
		default_bonus = 'add_part',
		direct = false,
		tags = ['numeric']
	},
	#training
	training_loyalty = {
		code = 'training_loyalty',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
		direct = false,
		tags = ['integer'],
		show_info = {category = 'non_combat'}
	},
	training_spirit = {
		code = 'training_spirit',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
		direct = false,
		tags = ['integer'],
		show_info = {category = 'non_combat'}
	},
	trainee_amount = {
		code = 'trainee_amount',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
		direct = false,
		tags = ['integer', 'custom_bonuses'],
		show_info = {category = 'non_combat'}
	},
	resistance_red = {
		code = 'resistance_red',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
		direct = false,
		tags = ['custom_bonuses'],
		default_bonus = 'add_part',
		show_info = {category = 'non_combat'}
	},
	trainer_loyalty_bonus = {
		code = 'trainer_loyalty_bonus',
		percent = true,
		direct = false,
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		tags = [],
		show_info = {category = 'non_combat'}
	},
	#personality
	personality_bold = {
		code = 'personality_bold',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
		tags = ['integer', 'update_state']
	},
	personality_kind = {
		code = 'personality_kind',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
		tags = ['integer', 'update_state']
	},
	personality_shy = { #virtual
		code = 'personality_shy',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
		tags = ['integer', 'update_state']
	},
	personality_serious = { #virtual
		code = 'personality_serious',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
		tags = ['integer', 'update_state']
	},
	old_personality = {
		code = 'old_personality',
		tags = [],
		default_bonus = 'set',
	},
	personality = {#virtual
		code = 'personality',
		tags = ['custom_getter', 'custom_setter', 'update_state'],
		default_bonus = 'set',
	},
	#mods
	exp_gain_mod = {
		code = 'exp_gain_mod',
		percent = true,
		direct = false,
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
		tags = ['numeric'],
		show_info = {category = 'non_combat'}
	},
	manacost_mod = {
		code = 'manacost_mod',
		percent = true,
		direct = false,
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
		tags = ['numeric'],
	},
	
	#food
	food_consumption = { #2fix
		code = 'food_consumption',
		name = '',
		descript = '',
		baseicon = 'stat_food',
		type = 'misc',
		tags = ['integer'],
		direct = false,
	},
	#combat
	taunt = {
		code = 'taunt',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		tags = [],
		direct = false,
		default_bonus = 'set'
	},
	hpmax = {
		code = 'hpmax',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		tags = ['integer', 'custom_bonuses'],
		direct = false,
		custom_order = ['add2', 'add_part2', 'mul2', 'add', 'add_part', 'mul'],
		show_info = {category = 'combat'}
	},
	mpmax = {
		code = 'mpmax',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		tags = ['integer', 'custom_bonuses'],
		direct = false,
		custom_order = ['add2', 'add_part2', 'mul2', 'add', 'add_part', 'mul'],
		show_info = {category = 'combat'}
	},
	hp_reg = {
		code = 'hp_reg',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		type = 'misc',
		tags = ['integer'],
		direct = false,
		innate_bonuses = {mincap = 0},
		custom_order = ['add_part', 'mul', 'add']
	},
	mp_reg = {
		code = 'mp_reg',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		type = 'misc',
		tags = ['integer', 'custom_bonuses'],
		direct = false,
		innate_bonuses = {mincap = 0},
		custom_order = ['add2','add_part', 'mul', 'add', 'mul2']
	},
#	hpmax_add_part = {
#		code = 'hpmax_add_part',
#		name = '',
#		descript = '',
#		percent = true,
#		baseicon = 'food_love',
#		type = 'misc',
#	},
#	hp_mul2 = {
#		code = 'hp_mul2',
#		name = '',
#		descript = '',
#		percent = true,
#		baseicon = 'food_love',
#		type = 'misc',
#	},
	hitrate = {
		code = 'hitrate',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		tags = ['integer', 'custom_bonuses'],
		direct = false,
		show_info = {category = 'combat'}
	},
	evasion = {
		code = 'evasion',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		tags = ['integer', 'custom_bonuses'],
		direct = false,
		show_info = {category = 'combat'}
	},
	speed = {
		code = 'speed',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		tags = ['integer', 'custom_bonuses'],
		direct = false,
		show_info = {category = 'combat'}
	},
	atk = {
		code = 'atk',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer', 'custom_bonuses'],
		direct = false,
		innate_bonuses = {mincap = 5},
		show_info = {category = 'combat'}
	},
	matk = {
		code = 'matk',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer', 'custom_bonuses'],
		direct = false,
		innate_bonuses = {mincap = 5},
		show_info = {category = 'combat'}
	},
	damagetype = {
		code = 'damagetype',
		name = '',
		descript = '',
		baseicon = 'food_love',
		default_bonus = 'set',
		tags = [],
		direct = false,
	},
	weapon_element = {
		code = 'weapon_element',
		name = '',
		descript = '',
		baseicon = 'food_love',
		default_bonus = 'set',
		tags = [],
		direct = false,
	},
	armor = {
		code = 'armor',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer', 'custom_bonuses'],
		direct = false,
		show_info = {category = 'combat'}
	},
	mdef = {
		code = 'mdef',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer', 'custom_bonuses'],
		direct = false,
		show_info = {category = 'combat'}
	},
	damage_reduction = {
		code = 'damage_reduction',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		tags = ['integer'],
		direct = false,
		innate_bonuses = {maxcap = 100},
		show_info = {category = 'combat'}
	},
	armorpenetration = {
		code = 'armorpenetration',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer'],
		direct = false,
		show_info = {category = 'combat'}
	},
	critchance = {
		code = 'critchance',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer'],
		direct = false,
		show_info = {category = 'combat'}
	},
	critmod = {
		code = 'critmod',
		percent = true,
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'combat'}
	},
	#effects
	burn_mod = {
		code = 'burn_mod',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
		tags = ['numeric'],
		direct = false,
	},
	bleed_mod = {
		code = 'bleed_mod',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
		tags = ['numeric'],
		direct = false,
	},
	poison_mod = {
		code = 'poison_mod',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
		tags = ['numeric'],
		direct = false,
	},
	burn_damage = {
		code = 'burn_damage',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
		default_bonus = 'mul',
		tags = ['numeric', 'is_negative'],
		direct = false,
	},
	bleed_damage = {
		code = 'bleed_damage',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
		default_bonus = 'mul',
		tags = ['numeric', 'is_negative'],
		direct = false,
	},
	poison_damage = {
		code = 'poison_damage',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
		default_bonus = 'mul',
		tags = ['numeric', 'is_negative'],
		direct = false,
	},
	darkflame_damage = {
		code = 'darkflame_damage',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
		default_bonus = 'mul',
		tags = ['numeric', 'is_negative'],
		direct = false,
	},
	#images
	icon_image = {
		code = 'icon_image',
		tags = [],
		default_bonus = 'set',
	},
	body_image = {
		code = 'body_image',
		tags = [],
		default_bonus = 'set',
	},
	unique_variation = {
		code = 'unique_variation',
		tags = [],
		default_bonus = 'set',
	},
	dynamic_portrait = {
		code = 'dynamic_portrait',
		tags = ['bool'],
		default_bonus = 'set',
	},
	portrait_update = {
		code = 'portrait_update',
		tags = ['bool', 'custom_getter'],
		default_bonus = 'set',
	},
	player_selected_icon = {
		code = 'player_selected_icon',
		tags = ['bool'],
		default_bonus = 'set',
	},
	player_selected_body = {
		code = 'player_selected_body',
		tags = ['bool'],
		default_bonus = 'set',
	},
	#other
	is_hirable = {
		code = 'is_hirable',
		tags = ['bool'],
		default_bonus = 'set',
	},
	hire_scene = {
		code = 'hire_scene',
		tags = [],
		default_bonus = 'set',
	},
	unique = {
		code = 'unique',
		tags = [],
		default_bonus = 'set',
	},
	surname = {
		code = 'surname',
		tags = [],
		default_bonus = 'set',
	},
	nickname = {
		code = 'nickname',
		tags = [],
		default_bonus = 'set',
	},
	bonus_description = {
		code = 'bonus_description',
		tags = [],
		default_bonus = 'set',
	},
	race = {
		code = 'race',
		tags = [],
		default_bonus = 'set',
	},
	racegroup = {
		code = 'racegroup',
		tags = [],
		default_bonus = 'set',
	},
	age = {
		code = 'age',
		tags = [],
		default_bonus = 'set',
	},
	sex = {
		code = 'sex',
		tags = ['update_state'],
		default_bonus = 'set',
	},
	masternoun = {
		code = 'masternoun',
		tags = [],
		default_bonus = 'set',
	},
	name = {
		code = 'name',
		tags = ['custom_setter'],
		default_bonus = 'set',
	},
	upgrade_points_total = {
		code = 'upgrade_points_total',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		tags = ['integer', 'custom_bonuses'],
		direct = false,
	},
	magic_find = {
		code = 'magic_find',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		tags = ['integer'],
		direct = false,
	},
	consent = {
		code = 'consent',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer', 'custom_getter'],
	},
	lastsexday = {
		code = 'lastsexday',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer'],
	},
	asser = {
		code = 'asser',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer'],
	},
	xpreward = {
		code = 'xpreward',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer'],
	},
	loottable = {
		code = 'loottable',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = [],
	},
	
#	price_add_part = { #not a real stat, stub for generating descriptions
#		code = 'price_add_part',
#		name = 'STATPRICE',
#		descript = '',
#		baseicon = 'food_love',
#		percent = true,
#		default_bonus = 'add_part',
#		tags = [],
#	},
#	price_add = { #not a real stat, stub for generating descriptions
#		code = 'price_add',
#		name = 'STATPRICE',
#		descript = '',
#		baseicon = 'food_love',
#		tags = [],
#	},
	
	#prod
	productivity = {
		code = 'productivity',
		name = '',
		descript = '',
		percent = true,
		base_100 = true,#refactor if need
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric', 'custom_bonuses'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	mod_collect = {
		code = 'mod_collect',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	mod_build = {
		code = 'mod_build',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	mod_hunt = {
		code = 'mod_hunt',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	mod_fish = {
		code = 'mod_fish',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	mod_cook = {
		code = 'mod_cook',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	mod_smith = {
		code = 'mod_smith',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	mod_tailor = {
		code = 'mod_tailor',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	mod_alchemy = {
		code = 'mod_alchemy',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	mod_farm = {
		code = 'mod_farm',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	mod_pros = {
		code = 'mod_pros',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	mod_service = {
		code = 'mod_service',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	mod_waitress = {
		code = 'mod_waitress',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	mod_hostess = {
		code = 'mod_hostess',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	mod_dancer = {
		code = 'mod_dancer',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	mod_strip = {
		code = 'mod_strip',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	
	base_task_crit_chance = { # for char
		code = 'base_task_crit_chance',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		tags = ['numeric'],
		direct = false,
		show_info = {category = 'non_combat'}
	},
	#challenges
	chg_strength = {
		code = 'chg_strength',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer', 'cap_up', 'cap_low'],
		cap_up = 'chg_strength_max',
		cap_low = 0,
	},
	chg_strength_max = {
		code = 'chg_strength_max',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer'],
		direct = false,
	},
	chg_dexterity = {
		code = 'chg_dexterity',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer', 'cap_up', 'cap_low'],
		cap_up = 'chg_dexterity_max',
		cap_low = 0,
	},
	chg_dexterity_max = {
		code = 'chg_dexterity_max',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer'],
		direct = false,
	},
	chg_wisdom = {
		code = 'chg_wisdom',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer', 'cap_up', 'cap_low'],
		cap_up = 'chg_wisdom_max',
		cap_low = 0,
	},
	chg_wisdom_max = {
		code = 'chg_wisdom_max',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer'],
		direct = false,
	},
	chg_persuasion = {
		code = 'chg_persuasion',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer', 'cap_up', 'cap_low'],
		cap_up = 'chg_persuasion_max',
		cap_low = 0,
	},
	chg_persuasion_max = {
		code = 'chg_persuasion_max',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer'],
		direct = false,
	},
	#sex
	penis_virgin_lost = {
		code = 'penis_virgin_lost',
		tags = ['update_state'],
		default_bonus = 'set',
	},
	vaginal_virgin_lost = {
		code = 'vaginal_virgin_lost',
		tags = ['update_state'],
		default_bonus = 'set',
	},
	anal_virgin_lost = {
		code = 'anal_virgin_lost',
		tags = ['update_state'],
		default_bonus = 'set',
	},
	mouth_virgin_lost = {
		code = 'mouth_virgin_lost',
		tags = ['update_state'],
		default_bonus = 'set',
	},
	penis_virgin = {
		code = 'penis_virgin',
		tags = ['obsolete', 'update_state'],
		default_bonus = 'set',
	},
	vaginal_virgin = {
		code = 'vaginal_virgin',
		tags = ['obsolete', 'update_state'],
		default_bonus = 'set',
	},
	anal_virgin = {
		code = 'anal_virgin',
		tags = ['obsolete', 'update_state'],
		default_bonus = 'set',
	},
	mouth_virgin = {
		code = 'mouth_virgin',
		tags = ['obsolete', 'update_state'],
		default_bonus = 'set',
	},
	penis_type = {
		code = 'penis_type',
		tags = [],
		default_bonus = 'set',
	},
	vagina = {
		code = 'vagina',
		tags = [],
		default_bonus = 'set',
	},
	multiple_tits = {
		code = 'multiple_tits',
		tags = ['integer'],
		default_bonus = 'set',
	},
	multiple_tits_developed = {
		code = 'multiple_tits_developed',
		tags = ['bool'],
		default_bonus = 'set',
	},
	lactation = {
		code = 'lactation',
		tags = ['bool'],
		default_bonus = 'set',
	},
	#pregnancy
	pregnancy_fertility = {
		code = 'pregnancy_fertility',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['numeric'],
		container = 'pregnancy'
	},
	pregnancy_duration = {
		code = 'pregnancy_duration',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer', 'update_state'],
		container = 'pregnancy'
	},
	pregnancy_baby = {
		code = 'pregnancy_baby',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = [],
		default_bonus = 'set',
		container = 'pregnancy'
	},
	pregnancy_reported = {
		code = 'pregnancy_reported',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['bool'],
		default_bonus = 'set',
		container = 'pregnancy'
	},
	#marriage
	was_proposed = {
		code = 'was_proposed',
		tags = ['bool'],
		default_bonus = 'set',
	},
	had_cons_sex_with_mc = {
		code = 'had_cons_sex_with_mc',
		tags = ['bool'],
		default_bonus = 'set',
	},
	had_forced_sex_with_mc = {
		code = 'had_forced_sex_with_mc',
		tags = ['bool'],
		default_bonus = 'set',
	},
	agreed_to_marry = {
		code = 'agreed_to_marry',
		tags = ['bool'],
		default_bonus = 'set',
	},
	#items
	task_crit_chance = { # for item desc
		code = 'task_crit_chance',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		skip_process = true
	},
	task_efficiency_tool = {
		code = 'task_efficiency_tool',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		skip_process = true
	},
	damagemod = { #for items
		code = 'damagemod',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		skip_process = true
	},
	enchant_capacity_mod = {
		code = 'enchant_capacity_mod',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
		default_bonus = 'add_part'
	},
	enchant_capacity = {
		code = 'enchant_capacity',
		name = '',
		descript = '',
		baseicon = 'food_love',
	},
	breakdown_time = {
		code = 'breakdown_time',
		name = '',
		descript = '',
		type = 'misc',
		direct = false,
		tags = ['integer'],
		default_bonus = 'add_part'
	},
	breakdown_chance_mod = {
		code = 'breakdown_chance_mod',
		name = '',
		descript = '',
		type = 'misc',
		direct = false,
		default_bonus = 'add_part'
	},
	breakdown_disabled = {
		code = 'breakdown_disabled',
		name = '',
		descript = '',
		is_negative = true,
		baseicon = 'food_love',
		default_bonus = 'append',
		direct = false,
		tags = ['array'],
		custom_order = ['append']
	},
	fame = {
		code = 'fame',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer', 'cap_up', 'cap_low'],
		cap_up = 6,
		cap_low = 0,
	},
	fame_degrade_timer = {
		code = 'fame_degrade_timer',
		name = '',
		descript = '',
		baseicon = 'food_love',
		tags = ['integer']
	},
	last_arena_win = {
		code = 'last_arena_win',
		tags = ['bool'],
		default_bonus = 'set',
	},
}

#var slave_class_names = {
#	'slave' : 'Slave',
#	servant = 'Peon',
#	'master' : '[Master]',
#	hireling = 'Hireling',
#	heir = "Heir",
#	spouse = "Spouse",
#	'slave_trained' : 'Trained Slave'
#}

var worktoolnames = {
	bow = '',
	axe = '',
	pickaxe = '',
	rod = '',
	sickle = '',
	hammer = '',
	hunt_knife = '',
}

func _ready():
	for i in Skilldata.masteries: #this is not technicaly a stat. added for a proper building of descriptions and a proper binding of processing
		statdata['mastery_' + i] = {
				code = "mastery_" + i,
				tags = ['show_in_header', 'integer'],
				direct = false,
				container = 'masteries',
				show_info = {category = 'combat'}
			}
		statdata['mastery_' + i + '_enable'] = {
				code = "mastery_" + i + '_enable',
				tags = ['bool'],
				direct = false,
				container = 'masteries',
				default_bonus = 'set',
			}
	for st in Statlist_init.tattoo:
		statdata[st] = {
				code = st,
				tags = [],
				default_bonus = 'set',
				container = 'tattoo',
			}
	for st in Statlist_init.armor_color:
		statdata[st] = {
				code = st,
				tags = [],
				default_bonus = 'set',
				container = 'armor_color',
			}
	for st in Statlist_init.piercing:
		statdata[st] = {
				code = st,
				tags = [],
				default_bonus = 'set',
				container = 'piercing',
			}
	for st in Statlist_init.metrics:
		statdata[st] = {
				code = st,
				tags = ['integer'],
				container = 'metrics',
			}
	statdata.metrics_partners.tags = ['array']
	statdata.metrics_partners.default_bonus = 'append'
	for st in Statlist_init.sex_skills:
		statdata[st] = {
				code = st,
				tags = ['integer'],
				container = 'sex_skills',
			}
	for st in Statlist_init.sexexp: #this is not technicaly a stat - but a messy log. added for a sanity sake
		statdata[st] = {
				code = st,
				tags = [],
				default_bonus = 'set',
				container = 'sexexp',
			}
	
	for st in Statlist_init.resists:
		statdata[st] = {
				code = st,
				tags = ['integer'],
				direct = false,
				container = 'resists',
				show_info = {category = 'combat', hide_if_0 = true},
			}
	for st in Statlist_init.damage_mods:
		statdata[st] = {
				code = st,
				tags = ['numeric'],
				percent = true,
				direct = false,
				container = 'damage_mods',
				show_info = {category = 'combat'}
			}
	for st in Statlist_init.manacost_mods:
		statdata[st] = {
				code = st,
				tags = ['numeric'],
				percent = true,
				direct = false,
				container = 'manacost_mods',
			}
	
	for val in statdata.values():
		if !val.has('percent'): 
			val.percent = false
		if !val.has('default_bonus'): 
			val.default_bonus = 'add'
		if !val.has('direct'): 
			val.direct = true
		if !val.has('tags'): 
			val.tags = []
#		print("STAT%s = ''," % val.code.to_upper())


func check_compatibility_operant(stat, operant):
	match operant:
		'set':
			return true
		'add', 'mul', 'add_part':
			return statdata[stat].tags.has('integer') or statdata[stat].tags.has('numeric')
		'append', 'remove':
			return statdata[stat].tags.has('array')
		_:
			return false
