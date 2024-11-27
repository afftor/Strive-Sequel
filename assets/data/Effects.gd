extends Node
var effects = {
}

var effect_nolog = ['commander']
#to fix EFFECT TAGS TO TEMPLATE
#'positive'/'negative' - the widest classification (to most global cleaning like bard2 skill effect)
#'buff'/'debuff' - additional markings for common effect removal effects (like purge) (and maybe add two more for a state effects)
#any other - for additional customisation

var effect_table = {
#	e_test_global = {
#		type = 'temp_global',
#		tags = ['negative', 'duration_turns'],
#		target = 'target',
#		name = 'test',
#		stack = 1,
#		buffs = [{
#				icon = "res://assets/images/iconsskills/Discipline.png",
#				description = "TRAITEFFECTDEVOUR",
#				limit = 1,
#				t_name = 'devour',
#			}],
#		args = [],
#		timers = [
#			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 2}, 
#			{events = variables.TR_COMBAT_F, objects = [], timer = 1}
#		],
#		sub_effects = []
#	},
	#maxstat
	e_phy6 = {
		type = 'c_static',
		descript = '',
		conditions = [{code = 'stat', stat = 'physics_factor', operant = 'gte', value = 6}],
		tags = ['recheck_stats', 'recheck_item'],
		atomic = [{type = 'stat_add_p', stat = 'hp_reg_mod', value = 1}],
		buffs = [],
		sub_effects = [],
	},
	e_wit6 = {
		type = 'c_static',
		descript = '',
		conditions = [{code = 'stat', stat = 'wits_factor', operant = 'gte', value = 6}],
		tags = ['recheck_stats', 'recheck_item'],
		atomic = [{type = 'stat_add', stat = 'exp_gain_mod', value = 0.2}],
		buffs = [],
		sub_effects = [],
	},
	e_charm6 = {
		type = 'c_static',
		descript = '',
		conditions = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 6}],
		tags = ['recheck_stats', 'recheck_item'],
		atomic = [{type = 'stat_add', stat = 'mod_service', value = 0.25}, {type = 'stat_add', stat = 'chg_persuasion_max', value = 1}],
		buffs = [],
		sub_effects = [],
	},
	e_sex6 = {
		type = 'c_static',
		descript = '',
		conditions = [{code = 'stat', stat = 'sexuals_factor', operant = 'gte', value = 6}],
		tags = ['recheck_stats', 'recheck_item'],
		atomic = [{type = 'stat_add', stat = 'speed', value = 10}],
		buffs = [],
		sub_effects = [],
	},
	e_timid6 = {
		type = 'c_static',
		descript = '',
		conditions = [{code = 'stat', stat = 'timid_factor', operant = 'gte', value = 6}],
		tags = ['recheck_stats', 'recheck_item'],
		atomic = [{type = 'stat_add', stat = 'damage_reduction', value = 15}],
		buffs = [],
		sub_effects = [],
	},
	e_mag6 = {
		type = 'c_static',
		descript = '',
		conditions = [{code = 'stat', stat = 'magic_factor', operant = 'gte', value = 6}],
		tags = ['recheck_stats', 'recheck_item'],
		atomic = [{type = 'stat_add_p', stat = 'matk', value = 0.1}],
		buffs = [],
		sub_effects = [],
	},
	e_tame6 = { #real effect is in trainings, for display only
		type = 'c_static',
		descript = '',
		conditions = [{code = 'stat', stat = 'tame_factor', operant = 'gte', value = 6}],
		tags = ['recheck_stats', 'recheck_item'],
		atomic = [],
		buffs = [],
		sub_effects = [],
	},
	e_virgin = {
		type = 'c_static',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'sex', operant = 'neq', value = 'male'},
			{code = 'stat', stat = 'vaginal_virgin', operant = 'eq', value = true},
			],
		tags = ['recheck_stats', 'virgin'],
		atomic = [], #{type = 'stat_add_p', stat = 'price', value = 0.25}],
		buffs = [{
			icon = "res://assets/images/iconstraits/lotus.png",
			description = "TRAITEFFECTVIRGIN",
			limit = 1,
			t_name = 'b_virgin',
			mansion_only = true,
			show_in_traits = true
		},],
		sub_effects = [],
	},
	#personality
	e_person_bold = {
		type = 'c_static',
		descript = '',
		conditions = [{code = 'stat', stat = 'personality', operant = 'eq', value = 'bold'}],
		tags = ['recheck_stats'],
		atomic = [
			#{type = 'stat_add_p', stat = 'matk', value = -0.25}
		],
		buffs = [],
		sub_effects = [rebuild_skillvalue_template({skilltype = 'skill', value = 1.15})],
	},
	e_person_shy = {
		type = 'c_static',
		descript = '',
		conditions = [{code = 'stat', stat = 'personality', operant = 'eq', value = 'shy'}],
		tags = ['recheck_stats'],
		atomic = [
			{type = 'stat_add_p', stat = 'matk', value = 0.15},
			#{type = 'stat_add_p', stat = 'atk', value = -0.2}
		],
		buffs = [],
		sub_effects = [],
	},
	e_person_kind = {
		type = 'c_static',
		descript = '',
		conditions = [{code = 'stat', stat = 'personality', operant = 'eq', value = 'kind'}],
		tags = ['recheck_stats'],
		atomic = [],
		buffs = [],
		sub_effects = [rebuild_skillvalue_template({tag = 'heal', value = 1.5}),],
	},
	e_person_serious = {
		type = 'c_static',
		descript = '',
		conditions = [{code = 'stat', stat = 'personality', operant = 'eq', value = 'serious'}],
		tags = ['recheck_stats'],
		atomic = [
			{type = 'stat_add', stat = 'damage_reduction', value = 20},
		],
		buffs = [],
		sub_effects = [],
	},
	#traits
	e_tr_resist = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['ability_type', 'eq', 'spell'] },
			{type = 'random', value = 0.25}
		],
		req_skill = true,
		args = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [{type = 'stat_set', stat = 'hit_res', value = variables.RES_MISS}]
		}],
		buffs = []
	},
	e_tr_mm = {
		type = 'static',
		atomic = [{type = 'stat_mul', stat = 'mpmax', value = 0.5}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_gifted = {
		type = 'static',
		atomic = [{type = 'stat_mul', stat = 'mpmax', value = 2}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_bell = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'atk', value = 0.15}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_hidpow = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'matk', value = 0.15}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_healthy = {
		type = 'static',
		atomic = [{type = 'bonus', bonusname = 'hp_flat_bonus', value = 10}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_pacifist = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'atk', value = -0.5}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_minept = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'matk', value = -0.5}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_whimp = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'hpmax', value = -0.4},],
		buffs = [],
		sub_effects = [],
	},
	e_ltr_exhibit = {
		type = 'static',
		atomic = [{type = 'stat_add', stat = 'lusttick', value = 1}],
		buffs = [],
		sub_effects = [],
	},
	e_brokein = {
		type = 'oneshot',
		target = 'owner',
		atomic = [{type = 'remove_trait', trait = 'untrained'}],
		buffs = [],
		sub_effects = []
	},
	# i think we need to display those statuses as buffs
	
	work_rule_luxury = {
		code = 'work_rule_luxury',
		type = 'static',
		atomic = [
			{type = 'stat_add', stat = 'exp_gain_mod', value = 0.05},
			{type = 'stat_add', stat = 'productivity', value = 0.05},
		],
		buffs = [],
		sub_effects = [rebuild_simple_dot(['loyalty'], [0.5], variables.TR_DAY),],
	},
	work_rule_ration = {
		code = 'work_rule_ration',
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'productivity', value = 0.15},
			{type = 'stat_add', stat = 'food_consumption', value = 3},
		],
		buffs = [],
		sub_effects = [],
	},
	work_rule_shifts = {
		code = 'work_rule_shifts',
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'productivity', value = 0.25},
		],
		tags = ['no_working_bonuses'],
		buffs = [],
		sub_effects = [],
	},
	work_rule_masturbation = {
		code = 'work_rule_masturbation',
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'lusttick', value = 0.15},
		],
		buffs = [],
		sub_effects = [],
	},
	
	
	e_tr_copy_test = { 
		type = 'trigger',
		trigger = [variables.TR_CAST],
		reset = [variables.TR_TURN_GET],
		req_skill = true,
		conditions = [{type = 'skill', value = ['ability_type', 'eq', 'spell']}],
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				atomic = [{type = 'copy_skill'}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	e_tr_copy_25 = { 
		type = 'trigger',
		trigger = [variables.TR_CAST],
		reset = [variables.TR_TURN_GET], #mb not, idk how it can be wrong
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['ability_type', 'eq', 'spell']},
			{type = 'random', value = 0.25}
			],
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				atomic = [{type = 'copy_skill'}],
				buffs = [],
				sub_effects = []
			}
		]
	},
#	e_tr_witcrit = {
#		type = 'trigger',
#		trigger = [variables.TR_CAST],
#		req_skill = true,
#		conditions = [],
#		atomic = [],
#		buffs = [],
#		args = [{obj = 'app_obj', param = 'wits_factor'}],
#		sub_effects = [
#			{
#				type = 'oneshot',
#				target = 'skill',
#				args = [{obj = 'parent_args', param = 0}],
#				atomic = [{type = 'stat_add', stat = 'critchance', value = [['parent_args', 0],'*',3]}],
#				buffs = [],
#				sub_effects = []
#			}
#		]
#	},
	e_s_dayoff = {
		type = 'temp_s',
		target = 'target',
		name = 'dayoff',
		stack = 1,
		duration = 4,
		tick_event = [variables.TR_TICK],
		rem_event = [variables.TR_DEATH],
		tags = [],
		args = [],
		sub_effects = [],
		atomic = [{type = 'disable'}],
		buffs = ['b_dayoff'],
	},
	
	#skills
	e_target_kill = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				atomic = ['a_self_kill'],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
#	e_t_charm = { #not used
#		type = 'temp_s',
#		target = 'target',
#		name = 'charm',
#		tick_event = variables.TR_TICK,
#		duration = 'parent',
#		stack = 1,
#		tags = ['magic', 's_dur_add'],
#		sub_effects = [],
#		atomic = [
#			{type = 'stat_add_p', stat = 'lusttick', value = 0.25},
#		],
#		buffs = ['b_charm'],
#	},
	e_s_regen = {
		type = 'temp_s',
		target = 'target',
		name = 'regen',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['positive'],
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = ['e_t_regen'],
		atomic = [],
		buffs = ['b_regen'], 
	},
	e_t_regen = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		req_skill = false,
		conditions = [],
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = [{
				type = 'oneshot',
				target = 'owner',
				args = [{obj = 'parent_args', param = 0}],
				atomic = ['a_sanctuary_heal'],
			}
		]
	},
	e_food_like = {
		type = 'temp_s',
		name = 'food_like',
		tick_event = variables.TR_TICK,
		duration = 4,
		stack = 1,
		sub_effects = [],
		tags = [],
		atomic = [
			{type = 'stat_add_p', stat = 'productivity', value = 0.05},
			{type = 'stat_add', stat = 'exp_gain_mod', value = 0.05},
		],
		buffs = [
			{
				icon = "res://assets/images/gui/gui icons/food_love.png",
				description = "TRAITEFFECTFAVFOOD",
				limit = 1,
				t_name = 'food_like',
				mansion_only = true, #mb remove
			}
		],
	},
	e_food_dislike = {
		type = 'temp_s',
		name = 'food_dislike',
		tick_event = variables.TR_TICK,
		duration = 4,
		stack = 1,
		sub_effects = [],
		tags = [],
		atomic = [
			{type = 'stat_add_p', stat = 'productivity', value = -0.1},
		],
		buffs = [
			{
				icon = "res://assets/images/gui/gui icons/food_hate.png",
				description = "TRAITEFFECTHATEDFOOD",
				limit = 1,
				t_name = 'food_hate',
				mansion_only = true,
			}
		],
	},
#	e_starve = {
#		type = 'temp_s',
#		target = 'target',
#		name = 'starvation',
#		tick_event = variables.TR_TICK,
#		duration = 24,
#		stack = 1,
#		sub_effects = [],
#		tags = [],
#		atomic = [],
#		buffs = [
#			{
#				icon = "res://assets/images/iconsitems/food_old.png",
#				description = "No food has been eaten: Exhaustion does not restore while resting.",
#				limit = 1,
#				t_name = 'starvation',
#				mansion_only = true,
#			}
#		],
#	},
	e_starve = {
		type = 'temp_s',
		name = 'starvation',
		tick_event = variables.TR_TICK,
		duration = 4,
		stack = 1,
		sub_effects = [], #loyalty part hardcoded
		tags = ['starvation'],#['addition_rest_tick'], 
		atomic = [
			{type = 'stat_add_p', stat = 'productivity', value = -0.5}, #or simply stat_add as productivity is measured in persents and '-50% productivity' can have both meanings
			#depending on displaying purpose use this
#			{type = 'stat_add_p', stat = 'atk', value = -50},
#			{type = 'stat_add_p', stat = 'matk', value = -50},
			#or this
			{type = 'stat_add', stat = 'damage_mod_all', value = -0.5},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsitems/food_old.png",
				description = "TRAITEFFECTSTARVE", 
				limit = 1,
				t_name = 'starvation',
#				mansion_only = true,
			}
		],
	},
	e_injury = {
		type = 'temp_s',
		name = 'injury',
		tick_event = variables.TR_TICK,
		duration = 4,
		stack = 1,
		sub_effects = [],
		tags = ['addition_rest_tick', 'injury'],
		atomic = [
			{type = 'stat_add_p', stat = 'hpmax', value = -0.2},
		],
		buffs = [
			{#to fix
				icon = "res://assets/images/iconsitems/food_old.png",
				description = "No food has been eaten: Exhaustion does not restore while resting.",
				limit = 1,
				t_name = 'injury',
#				mansion_only = true,
			}
		],
	},
	e_g_injury_delay = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_F],
		req_skill = false,
		tags = ['on_dead'],
		conditions = [],
		sub_effects = ['e_grave_injury',
			{
				type = 'oneshot',
				target = 'self',
				execute = 'remove'
			}
		]
	},
	e_grave_injury = {
		type = 'temp_s',
		name = 'grave_injury',
		tick_event = variables.TR_TICK,
		target = 'owner',
		duration = 12,
		stack = 1,
		sub_effects = [],
		tags = ['addition_rest_tick', 'no_combat', 'on_dead', 'injury'],# need to implement person.has_status('no_combat') check in exploration interface
		atomic = [
			{type = 'stat_add', stat = 'sexuals_bonus', value = -50},
			{type = 'stat_add_p', stat = 'productivity', value = -0.25},#or simply stat_add as productivity is measured in persents and '-25% productivity' can have both meanings
		],
		buffs = [
			{#to fix
				icon = "res://assets/images/iconsskills/icon_blood_explosion.png",
				description = "TRAITEFFECTGRAVEINJ", 
				limit = 1,
				t_name = 'grave_injury',
#				mansion_only = true,
			}
		],
	},
	e_g_injury_delay_alt = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_F],
		req_skill = false,
		tags = ['on_dead'],
		conditions = [],
		sub_effects = ['e_grave_injury_alt',
			{
				type = 'oneshot',
				target = 'self',
				execute = 'remove'
			}
		]
	},
	e_grave_injury_alt = {
		type = 'temp_s',
		name = 'grave_injury',
		tick_event = variables.TR_TICK,
		target = 'owner',
		duration = 8,
		stack = 1,
		sub_effects = [],
		tags = ['addition_rest_tick', 'no_combat', 'on_dead', 'injury'],# need to implement person.has_status('no_combat') check in exploration interface
		atomic = [
			{type = 'stat_add', stat = 'sexuals_bonus', value = -50},
			{type = 'stat_add_p', stat = 'productivity', value = -0.25},#or simply stat_add as productivity is measured in persents and '-25% productivity' can have both meanings
		],
		buffs = [
			{#to fix
				icon = "res://assets/images/iconsskills/icon_blood_explosion.png",
				description = "TRAITEFFECTGRAVEINJ", 
				limit = 1,
				t_name = 'grave_injury',
#				mansion_only = true,
			}
		],
	},
	e_s_undead = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [],
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				atomic = [{type = 'add_trait', trait = 'undead'}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	
	#version for trap skill only usable by player
#	e_t_trap = {
#		type = 'trigger',
#		target = 'target',
#		trigger = [variables.TR_CAST],
#		req_skill = false,
#		conditions = [],
#		atomic = [],
#		buffs = ['b_trap'],
#		sub_effects = [
#			'e_trap',
#			{
#				type = 'oneshot',
#				target = 'self',
#				execute = 'remove'
#			}
#		]
#	},
	e_t_acid = {
		type = 'temp_s',
		target = 'target',
		name = 'acid',
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,#or not
		duration = 3,
		tags = ['debuff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'armor', value = -25},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsitems/miscarriagepot.png",
				description = "TRAITEFFECTACID",
				limit = 1,
				t_name = 'acid_bomb'
			}
		],
	},
	
	e_t_attract = {
		type = 'temp_s',
		target = 'target',
		name = 'attract',
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,#or not
		duration = 3,
		tags = ['debuff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'damage_mod_all', value = -0.3},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Whore.png",
				description = "TRAITEFFECTATTRACTED",
				limit = 1,
				t_name = 'attract'
			}
		],
	},
	e_s_ragestrike = {
		type = 'trigger',
		conditions = [],
		trigger = [variables.TR_CAST],
		req_skill = true,
		args = [{obj = 'parent', param = 'caster'}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				args = [{obj = 'parent_arg_get', index = 0, param = 'hp'},{obj = 'parent_arg_get', index = 0, param = 'hpmax'}],
				atomic = [{type = 'stat_mul', stat = 'value', value = [['parent_args', 0],'/',['parent_args', 1],'*',-2,'+',3.5]}],
			},
		],
		buffs = []
	},
	e_t_disruption = {
		type = 'temp_s',
		target = 'target',
		name = 'disruption',
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 2,
		stack = 1,
		tags = ['debuff'],
		sub_effects = [],
		atomic = ['a_remove_buff', 'a_silence'],
		buffs = ['b_silence'],
	},
	#not final but working as always
	e_s_barrier = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [],
		sub_effects = [
			{
				type = 'temp_s',
				target = 'target',
				tick_event = variables.TR_TURN_GET,
				rem_event = [variables.TR_SHIELD_DOWN,variables.TR_COMBAT_F, variables.TR_DEATH],
				duration = 3,
				stack = 1,
				name = 'shield',
				tags = ['buff', 'shield'],
				atomic = [
					{type = 'stat_set_revert', stat = 'shield', value = 100},
					{type = 'stat_set_revert', stat = 'shieldtype', value = variables.S_FULL} #not sure about s_full
					],
				args = [{obj = 'app_obj', param = 'shield', dynamic = true}],
				buffs = [
					{
						icon = "res://assets/images/traits/armor.png",
						description = "TRAITEFFECTBARRIER",
						args = [{obj = 'parent_args', param = 0}],
						t_name = 'shield'
					}
				],
				sub_effects = [],
			}
		],
		buffs = []
	},
	e_t_blizz = {
		type = 'temp_s',
		target = 'target',
		name = 'blizz',
		tick_event = variables.TR_TURN_S,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 2,
		stack = 1,
		tags = ['debuff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'speed', value = -20},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/speeddebuf.png",
				description = "TRAITEFFECTBLIZZARD",
				limit = 1,
				t_name = 'blizzard'
			}
		],
	},
	
	e_s_bloodex = {
		type = 'trigger',
		trigger = [variables.TR_CAST],
		req_skill = true,
		conditions = [],
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				args = [{obj = 'app_obj', param = 'hpmax'}],
				atomic = [{type = 'stat_add', stat = 'hp', value = [['parent_args', 0],'*',-0.20]}],
				buffs = [],
				sub_effects = []
			}
		]
	},
#	e_s_fcleave = {
#		type = 'trigger',
#		trigger = [variables.TR_POSTDAMAGE],
#		conditions = [
#			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
#			{type = 'random', value = 0.2}
#		],
#		req_skill = true,
#		args = [{obj = 'parent', param = 'process_value' }],
#		sub_effects = ['e_t_burn'],
#	},
	e_s_fireburst = {
		type = 'temp_s',
		target = 'target',
		name = 'fireburst',
		tick_event = variables.TR_TURN_S,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,#or not
		duration = 'parent',
		tags = ['debuff'],
		atomic = [
			{type = 'stat_add', stat = 'hitrate', value = -20},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Mindread.png",
				description = "TRAITEFFECTFIREBURST",
				limit = 1,
				t_name = 'fireburst'
			}
		],
	},
	e_s_arrowrain = {
		type = 'temp_s',
		target = 'target',
		name = 'arrowrain',
		tick_event = variables.TR_TURN_S,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,#or not
		duration = 'parent',
		tags = ['debuff'],
		atomic = [
			{type = 'stat_add', stat = 'mdef', value = -20},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/arrowshower.png",
				description = "TRAITEFFECTARROWRAIN",
				limit = 1,
				t_name = 'arrowrain'
			}
		],
	},
	e_s_sstrike = {
		type = 'temp_s',
		target = 'target',
		name = 'sstrike',
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,#or not
		duration = 'parent',
		tags = ['debuff'],
		atomic = [
			{type = 'stat_add', stat = 'atk', value = -20},
			{type = 'stat_add', stat = 'matk', value = -20},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Sedate.png",
				description = "TRAITEFFECTSSTRIKE",
				limit = 1,
				t_name = 'sstrike'
			}
		],
	},
	e_t_holy = {
		type = 'temp_s',
		target = 'target',
		name = 'holydebuff',
		duration = 'parent',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		tags = ['debuff', 'negative'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'mdef', value = -20},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/light_spell_aoe.png",
				description = "TRAITEFFECTHOLY",
				limit = 1,
				t_name = 'holydebuff'
			}
		],
	},
	#curses and enchantments
	e_s_nostun = rebuild_stat_bonus('resist_stun', 200),
	#statuses 
	e_t_provoke = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [{obj = 'parent', param = 'caster' }],
		sub_effects = [rebuild_remove_effect('taunt'), 'e_s_taunt'],
		buffs = []
	},
	e_s_taunt = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH, variables.TR_TAUNT_FAIL], #optional remove event
		tick_event = [variables.TR_TURN_F],
		duration = 2,
		stack = 1,
		name = 'taunt',
		tags = ['debuff', 'taunt', 'negative', 'taunt_hard'],
		buffs = ['b_taunt'],
		args = [{obj = 'parent_arg_get', index = 0, param = 'id'}],
		atomic = [{type = 'stat_set_revert', stat = 'taunt', value = ['parent_args', 0]}]
	},
	e_t_taunt = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [{obj = 'parent', param = 'caster' }],
		sub_effects = [rebuild_remove_effect('taunt'), 'e_s_taunt_new'],
		buffs = []
	},
	e_s_taunt_new = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH, variables.TR_TAUNT_FAIL], #optional remove event
		tick_event = [variables.TR_TURN_F],
		duration = 2,
		stack = 1,
		name = 'taunt',
		tags = ['debuff', 'taunt', 'negative', 'taunt_soft'],
		buffs = ['b_taunt'],
		args = [{obj = 'parent_arg_get', index = 0, param = 'id'}],
		atomic = [{type = 'stat_set_revert', stat = 'taunt', value = ['parent_args', 0]}]
	},
	e_t_hide = {
		type = 'temp_s',
		target = 'owner',
		rem_event = [variables.TR_HIT, variables.TR_COMBAT_F, variables.TR_DMG],
		stack = 1,
		name = 'hide',
		tags = ['buff', 'hide'],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/icon_eyes.png",
				description = "TRAITEFFECTHIDE",
				t_name = 'hide'
			}
		],
		sub_effects = [],
	},
	e_s_stonewall = {
		type = 'temp_s',
		target = 'caster',
		name = 'stonewall',
		stack = 1,
		tick_event = [variables.TR_TURN_GET],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['positive', 'stonewall'],
		args = [],
		sub_effects = [],
		atomic = [{type = 'stat_add', stat = 'damage_reduction', value = 25}],
		buffs = ['b_stonewall'], 
	},
	e_s_lasstand = {
		type = 'temp_s',
		tags = ['buff', 'positive', 'last_stand'],
		target = 'caster',
		tick_event = [variables.TR_TURN_GET],
		rem_event = [variables.TR_COMBAT_F],
		duration = 'parent',
		name = 'Last stand',
		stack = 1,
		args = [],
		sub_effects = [],
		atomic = [],
		buffs = ['b_laststand'],
	},
	e_s_burn_new = {
		type = 'temp_s',
		target = 'target',
		name = 'burn_new',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['affliction', 'tick_after_trigger', 'burn'],
		args = [{obj = 'parent_arg_get', index = 1, param = 'burn_mod'}],
		sub_effects = ['e_burn_new'],
		atomic = [],
		buffs = ['b_burn'],
	},
	e_burn_new = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		req_skill = false,
		conditions = [],
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = [{
				type = 'oneshot',
				target = 'owner',
				args = [{obj = 'app_obj', param = 'hpmax'}, {obj = 'app_obj', param = 'burn_damage'}, {obj = 'parent_args', param = 0}],
				atomic = ['a_burn_new'],
			}
		]
	},
	e_s_poison_new = {
		type = 'temp_s',
		target = 'target',
		name = 'poison_new',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['affliction', 'tick_after_trigger', 'poison'],
		args = [{obj = 'parent_arg_get', index = 1, param = 'poison_mod'}],
		sub_effects = ['e_poison_new'],
		atomic = [],
		buffs = ['b_poison'],
	},
	e_poison_new = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		req_skill = false,
		conditions = [],
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = [{
				type = 'oneshot',
				target = 'owner',
				args = [{obj = 'app_obj', param = 'hpmax'}, {obj = 'app_obj', param = 'poison_damage'}, {obj = 'parent_args', param = 0}],
				atomic = ['a_poison_new'],
			}
		]
	},
	e_s_bleed_new = {
		type = 'temp_s',
		target = 'target',
		name = 'bleed',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['affliction', 'tick_after_trigger', 'bleed'],
		args = [{obj = 'parent_arg_get', index = 1, param = 'bleed_mod'}],
		sub_effects = ['e_bleed_new'],
		atomic = [],
		buffs = ['b_bleed'],
	},
	e_bleed_new = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		req_skill = false,
		conditions = [],
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = [{
				type = 'oneshot',
				target = 'owner',
				args = [{obj = 'app_obj', param = 'hpmax'}, {obj = 'app_obj', param = 'bleed_damage'}, {obj = 'parent_args', param = 0}],
				atomic = ['a_bleed_new'],
			}
		]
	},
	e_s_shred = {#1turn duration, can't pass duration onto global temps, so clone it for different duartions
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'shred'],
		target = 'target',
		name = 'shred',
		stack = 2,
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 1}, #1 turn duration
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		args = [],
		sub_effects = [],
		atomic = [{type = 'stat_add_p', stat = 'armor', value = -0.5}],
		buffs = ['b_shred'],
	},
	e_s_shred2 = {
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'shred'],
		target = 'target',
		name = 'shred',
		stack = 2,
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 2}, #2 turns duration
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		args = [],
		sub_effects = [],
		atomic = [{type = 'stat_add_p', stat = 'armor', value = -0.5}],
		buffs = ['b_shred'],
	},
	e_s_shred3 = {
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'shred'],
		target = 'target',
		name = 'shred',
		stack = 2,
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 3}, #3 turns duration
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		args = [],
		sub_effects = [],
		atomic = [{type = 'stat_add_p', stat = 'armor', value = -0.5}],
		buffs = ['b_shred'],
	},
	e_s_shred5 = {
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'shred'],
		target = 'target',
		name = 'shred',
		stack = 2,
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 5}, #2 turns duration
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		args = [],
		sub_effects = [],
		atomic = [{type = 'stat_add_p', stat = 'armor', value = -0.5}],
		buffs = ['b_shred'],
	},
	e_s_shatter = {#1turn duration, can't pass duration onto global temps, so clone it for different duartions
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'shatter'],
		target = 'target',
		name = 'shatter',
		stack = 2,
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 1}, #1 turn duration
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		args = [],
		sub_effects = [],
		atomic = [{type = 'stat_add_p', stat = 'mdef', value = -0.5}],
		buffs = ['b_shatter'],
	},
	e_s_shatter3 = {#3turn duration, can't pass duration onto global temps, so clone it for different duartions
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'shatter'],
		target = 'target',
		name = 'shatter',
		stack = 2,
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 3}, #3 turn duration
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		args = [],
		sub_effects = [],
		atomic = [{type = 'stat_add_p', stat = 'mdef', value = -0.5}],
		buffs = ['b_shatter'],
	},
	e_s_shatter5 = {#5turn duration, can't pass duration onto global temps, so clone it for different duartions
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'shatter'],
		target = 'target',
		name = 'shatter',
		stack = 2,
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 5}, #5 turn duration
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		args = [],
		sub_effects = [],
		atomic = [{type = 'stat_add_p', stat = 'mdef', value = -0.5}],
		buffs = ['b_shatter'],
	},
	
	e_s_sleep = {#1turn duration, can't pass duration onto global temps, so clone it for different duartions
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'disable', 'sleep'],
		target = 'target',
		name = 'sleep',
		disable = true,
		stack = 1,
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 1}, #1 turn duration
			{events = [variables.TR_DMG], objects = 'owner', timer = 1}, #damage removes
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		args = [],
		sub_effects = [],
		atomic = [],
		buffs = ['b_sleep'],
	},
	e_s_sleep_compartibility = {#1turn duration, can't pass duration onto global temps, so clone it for different duartions
		#THIS EFFECT IS STUB, DO NOT COPY, DO NOT EDIT - it uses reversed order of parent trigger args, so it is conterintuitive
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'disable', 'sleep'],
		target = 'target',
		name = 'sleep',
		disable = true,
		stack = 1,
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'target', timer = 1}, #1 turn duration of CASTER
			{events = [variables.TR_DMG], objects = 'owner', timer = 1}, #damage removes
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'target', timer = 1}, #CASTER
		],
		args = [],
		sub_effects = [],
		atomic = [],
		buffs = ['b_sleep'],
	},
	e_s_blind = {
		type = 'temp_s',
		target = 'target',
		name = 'blind',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['affliction', 'blind'],
		args = [],
		sub_effects = [],
		atomic = [{type = 'stat_add', stat = 'hitrate', value = -50}],
		buffs = ['b_blind'],
	},
	e_s_fear = {
		type = 'temp_s',
		target = 'target',
		name = 'fear',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['affliction', 'fear'],
		args = [],
		sub_effects = [],
		atomic = [{type = 'stat_add', stat = 'damage_mod_all', value = -0.25}],
		buffs = ['b_fear'],
	},
	e_s_shock = {
		type = 'temp_s',
		target = 'target',
		name = 'shock',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['affliction', 'shock'],
		args = [],
		sub_effects = [rebuild_remove_effect('fear')],
		atomic = [{type = 'stat_add', stat = 'damage_reduction', value = -15}],
		buffs = ['b_shock'],
	},
	e_s_ensnare = { #1turn duration, can't pass duration onto global temps, so clone it for different duartions
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'ensnare'],
		target = 'target',
		name = 'ensnare',
		stack = 1,
		args = [],
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 1}, 
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		atomic = [
			{type = 'stat_add', stat = 'evasion', value = -75}
		],
		buffs = ['b_ensnare'],
		sub_effects = [],
	},
	e_s_ensnare2 = { #2turn duration, can't pass duration onto global temps, so clone it for different duartions
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'ensnare'],
		target = 'target',
		name = 'ensnare',
		stack = 1,
		args = [],
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 2}, 
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		atomic = [
			{type = 'stat_add', stat = 'evasion', value = -75}
		],
		buffs = ['b_ensnare'],
		sub_effects = [],
	},
	e_s_ensnare5 = { #5turn duration, can't pass duration onto global temps, so clone it for different duartions
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'ensnare'],
		target = 'target',
		name = 'ensnare',
		stack = 1,
		args = [],
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 5}, 
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		atomic = [
			{type = 'stat_add', stat = 'evasion', value = -75}
		],
		buffs = ['b_ensnare'],
		sub_effects = [],
	},
	e_s_cursed = {
		type = 'temp_s',
		target = 'target',
		name = 'cursed',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		stack = 1,
		tags = ['debuff', 'cursed'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'resist_normal', value = -40},
			{type = 'stat_add', stat = 'resist_fire', value = -40},
			{type = 'stat_add', stat = 'resist_earth', value = -40},
			{type = 'stat_add', stat = 'resist_water', value = -40},
			{type = 'stat_add', stat = 'resist_air', value = -40},
			{type = 'stat_add', stat = 'resist_light', value = -40},
			{type = 'stat_add', stat = 'resist_dark', value = -40},
			{type = 'stat_add', stat = 'resist_mind', value = -40}
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Authority.png",
				description = "TRAITEFFECTCURSE",
				limit = 1,
				t_name = 'curse',
				combat_only = true,
			}
		],
	},
	
	e_s_stun = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_TURN_F, variables.TR_DEATH],
		stack = 1,
		name = 'stun',
		disable = true,
		tags = ['debuff', 'stun'],
		buffs = ['b_stun'],
		sub_effects = [rebuild_remove_effect('shock')],
	},
	e_s_stun1 = {#duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		duration = 'parent',
		stack = 1,
		name = 'stun',
		disable = true,
		tags = ['debuff', 'stun'],
		buffs = ['b_stun'],
		sub_effects = [rebuild_remove_effect('shock')],
	},
	e_s_stun2 = {#parent_arg duration
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		stack = 1,
		duration = 'parent_arg',
		name = 'stun',
		disable = true,
		tags = ['debuff', 'stun'],
		buffs = ['b_stun'],
		sub_effects = [rebuild_remove_effect('shock')],
	},
	e_s_charm = {#parent duration
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DMG],
		tick_event = [variables.TR_TURN_F],
		stack = 1,
		duration = 'parent',
		name = 'charm',
		disable = true,
		tags = ['debuff', 'charm'],
		buffs = ['b_charm_c'],
	},
	e_s_wet = {#parent-duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
#		tick_event = [variables.TR_TURN_F],
		duration = -1,
		stack = 1,
		name = 'wet',
		tags = ['debuff', 'wet'],
		buffs = ['b_wet'],
		sub_effects = [
			rebuild_remove_effect('burn'),
			'e_t_wet']
	},
	e_t_wet = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				conditions = [['damage_type', 'eq', 'air']],
				atomic = [
					{type = 'stat_mul', stat = 'value', value = 1.5},
					{type = 'remove_all_effects', value = 'wet'}
					],
			},
			{
				type = 'oneshot',
				target = 'skill',
				conditions = [['damage_type', 'eq', 'fire']],
				atomic = [
					{type = 'stat_mul', stat = 'value', value = 0.5},
					{type = 'remove_all_effects', value = 'wet'}
					],
			},
		]
	},
	e_s_freeze1 = {#parent-duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_POSTDAMAGE, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		duration = 'parent',
		stack = 1,
		name = 'freeze',
		disable = true,
		tags = ['debuff', 'freeze'],
		buffs = ['b_freeze'],
		sub_effects = [
			rebuild_remove_effect('wet'),
			rebuild_remove_effect('burn'),
			'e_t_freeze']
	},
	e_t_freeze = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				conditions = [['damage_type', 'eq', 'air']],
				atomic = [{type = 'stat_mul', stat = 'value', value = 2.0/1.25}],
			},
			{
				type = 'oneshot',
				target = 'skill',
				conditions = [['damage_type', 'eq', 'fire']],
				atomic = [{type = 'stat_mul', stat = 'value', value = 0.5/1.25}],
			},
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.25}],
			},
			{
				type = 'oneshot',
				target = 'target',
				atomic = [{type = 'remove_all_effects', value = 'freeze'}],
			},
		]
	},
	e_s_disarm = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_TURN_F, variables.TR_DEATH],
		stack = 1,
		name = 'disarm',
		tags = ['debuff', 'disarm'],
		buffs = ['b_disarm'],
	},
	e_s_disarm1 = {#duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		duration = 'parent',
		stack = 1,
		name = 'disarm',
		tags = ['debuff', 'disarm'],
		buffs = ['b_disarm'],
	},
	e_s_disarm2 = {#parent_arg duration
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		stack = 1,
		duration = 'parent_arg',
		name = 'disarm',
		tags = ['debuff', 'disarm'],
		buffs = ['b_disarm'],
	},
	e_s_disarm3 = {#duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		duration = 'parent',
		stack = 1,
		name = 'disarm',
		tags = ['negative', 'disarm'], #or disarm only
		buffs = ['b_disarm'],
	},
	e_s_silence = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_TURN_F, variables.TR_DEATH],
		stack = 1,
		name = 'silence',
		tags = ['debuff', 'silence'],
		buffs = ['b_silence'],
	},
	e_s_silence1 = {#duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		duration = 'parent',
		stack = 1,
		name = 'silence',
		tags = ['debuff', 'silence'],
		buffs = ['b_silence'],
	},
	e_s_silence2 = {#parent_arg duration
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		stack = 1,
		duration = 'parent_arg',
		name = 'silence',
		tags = ['debuff', 'silence'],
		buffs = ['b_silence'],
	},
	
	e_s_void = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH, variables.TR_TURN_F],
		stack = 1,
		name = 'void',
		tags = ['buff', 'void'],
		buffs = ['b_void'],
	},
	e_s_void1 = {#duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		duration = 'parent',
		stack = 1,
		name = 'void',
		tags = ['buff', 'void'],
		buffs = ['b_void'],
	},
	e_s_void2 = {#parent_arg duration
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		stack = 1,
		duration = 'parent_arg',
		name = 'void',
		tags = ['buff', 'void'],
		buffs = ['b_void'],
	},
	e_s_banish = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH, variables.TR_TURN_F],
		stack = 1,
		name = 'banish',
		tags = ['buff', 'banish'],
		buffs = ['b_banish'],
	},
	e_s_banish1 = {#duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		duration = 'parent',
		stack = 1,
		name = 'banish',
		tags = ['buff', 'banish'],
		buffs = ['b_banish'],
	},
	e_s_banish2 = {#parent_arg duration
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		stack = 1,
		duration = 'parent_arg',
		name = 'banish',
		tags = ['buff', 'banish'],
		buffs = ['b_banish'],
	},
	e_s_confuse = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH, variables.TR_TURN_F],
		stack = 1,
		name = 'confuse',
		tags = ['debuff', 'confuse'],
		buffs = ['b_confuse'],
	},
	e_s_defend = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH, variables.TR_TURN_GET],
		stack = 1,
		name = 'defend',
		tags = ['buff', 'defend'],
		buffs = ['b_defend'],
		sub_effects = ['e_t_defend']
	},
	e_t_defend = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 0.5}],
			}
		]
	},
#	e_s_regen = {#not sure about duration modes
#		type = 'temp_s',
#		target = 'target',
#		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
#		stack = 1,
#		name = 'regen',
#		tags = ['buff', 'regen'],
#		buffs = ['b_regen'],
#		sub_effects = ['e_t_regen']
#	},
#	e_t_regen = {
#		type = 'trigger',
#		trigger = [variables.TR_TURN_GET],
#		conditions = [],
#		sub_effects = [
#			{
#				type = 'oneshot',
#				target = 'owner',
#				args = [{obj = 'app_obj', param = 'hpmax'}],
#				atomic = ['a_regen'],
#			}
#		]
#	},
#	e_s_burn = {
#		type = 'trigger',
#		trigger = [variables.TR_POSTDAMAGE],
#		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
#		req_skill = true,
#		args = [{obj = 'parent', param = 'process_value' }],
#		sub_effects = ['e_t_burn'],
#	},
	e_s_burn = {
		type = 'temp_s',
		target = 'target',
		name = 'burn',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['affliction', 'burn'],
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = ['e_burn'],
		atomic = [],
		buffs = ['b_burn'],
	},
	e_burn = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		req_skill = false,
		conditions = [],
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = [{
				type = 'oneshot',
				target = 'owner',
				args = [{obj = 'parent_args', param = 0}],
				atomic = ['a_burn'],
			}
		]
	},
#	e_s_poison = {
#		type = 'trigger',
#		trigger = [variables.TR_POSTDAMAGE],
#		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
#		req_skill = true,
#		args = [{obj = 'parent', param = 'process_value' }],
#		sub_effects = ['e_t_poison'],
#	},
	e_s_poison = {
		type = 'temp_s',
		target = 'target',
		name = 'poison',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['affliction', 'negative', 'debuff', 'poison'],
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = ['e_poison'],
		atomic = [],
		buffs = ['b_poison'],
	},
	e_poison = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		req_skill = false,
		conditions = [],
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = [{obj = 'parent_args', param = 0}],
				atomic = ['a_poison'],
			}
		]
	},
	
	
	e_s_shred_old = {
		type = 'temp_s',
		target = 'target',
		name = 'shred',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['affliction','shred'],
		args = [],
		sub_effects = [],
		atomic = [{type = 'stat_add', stat = 'armor', value = -30}],
		buffs = ['b_shred'],
	},
	
	e_s_growl = {
		type = 'temp_s',
		target = 'target',
		name = 'growl',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['affliction'],
		args = [],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'speed', value = -20},
			{type = 'stat_add', stat = 'evasion', value = -15},
			],
		buffs = ['b_growl'],
	},
	e_s_rejuvenation = {
		type = 'temp_s',
		target = 'target',
		name = 'rejuvenation',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['positive'],
		args = [],
		sub_effects = ['e_t_rejuvenation'],
		atomic = [],
		buffs = ['b_regen'],
	},
	e_t_rejuvenation = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		req_skill = false,
		conditions = [],
		args = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = [{obj = 'app_obj', param = 'hpmax'}],
				atomic = [
					{type = 'heal', value = [['parent_args', 0], '*', 0.15]},
					],
				buffs = [],
				sub_effects = []
			},
		]
	},
	e_s_mward = {
		type = 'temp_s',
		target = 'target',
		name = 'magicward',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 4,
		tags = ['positive', 'buff'],
		args = [],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'atk', value = 0.25},
			{type = 'stat_add', stat = 'mdef', value = 40},
			],
		buffs = ['b_magicward'],
	},
	e_s_mward2 = {
		type = 'temp_s',
		target = 'target',
		name = 'magicward',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 2,
		tags = ['positive', 'buff'],
		args = [],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'atk', value = 0.25},
			{type = 'stat_add', stat = 'mdef', value = 40},
			],
		buffs = ['b_magicward'],
	},
	e_s_slam = {
		type = 'temp_s',
		target = 'target',
		name = 'slam',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['negative'],
		args = [],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'resist_damage_heal', value = -100},
			],
		buffs = ['b_slam'],
	},
	e_s_takeposition = {
		type = 'temp_s',
		duration = 2,
		stack = 1,
		target = 'target',
		name = 'e_s_takeposition',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		args = [],
		atomic = [
			{type = 'stat_add', stat = 'damage_mod_all', value = 0.2},
			{type = 'stat_add', stat = 'armorpenetration', value = 50},
		],
		sub_effects = [],
		buffs = [{
			icon = "res://assets/images/iconsskills/takeposition.png",
			description = "TRAITEFFECTPOSITIONTAKEN",
			args = [],
			limit = 1,
			t_name = 'takeposition',
		}]
	},
	#items
	e_i_shackles = rebuild_simple_dot(['loyalty', 'spirit'], [1, -1], variables.TR_DAY),
	e_i_handcuffs = rebuild_simple_dot(['loyalty', 'spirit'], [0.5, -0.5], variables.TR_DAY),
	e_i_collar = rebuild_simple_dot(['loyalty', 'spirit'], [5, -5], variables.TR_DAY),
	e_i_pet_suit_bonus = {
		type = 'c_static',
		conditions = [{code = 'has_profession', profession = 'pet', check = true}],
		descript = "TRAITEFFECTPETSUIT",
		tags = ['recheck_class', 'recheck_item'],
		atomic = [{type = 'stat_add', stat = 'charm_bonus', value = 10}],
		buffs = [],
		sub_effects = [],
	},
	e_worker_outfit_effect = {
		type = 'static',
#		conditions = [],
		descript = "TRAITEFFECTWORKEROUTFIT",
		tags = [],
		atomic = [
		{type = 'stat_add_p', stat = 'mod_hunt', value = 0.25},
		{type = 'stat_add_p', stat = 'mod_fish', value = 0.25},
		{type = 'stat_add_p', stat = 'mod_collect', value = 0.25},
		{type = 'stat_add_p', stat = 'mod_farm', value = 0.25},

		],
		buffs = [],
		sub_effects = [],
	},
	e_craftman_suit_effect = {
		type = 'static',
#		conditions = [],
		descript = "TRAITEFFECTCRAFTSMANSUIT",
		tags = [],
		atomic = [
		{type = 'stat_add_p', stat = 'mod_cook', value = 0.25},
		{type = 'stat_add_p', stat = 'mod_smith', value = 0.25},
		{type = 'stat_add_p', stat = 'mod_alchemy', value = 0.25},
		{type = 'stat_add_p', stat = 'mod_build', value = 0.25},
		{type = 'stat_add_p', stat = 'mod_tailor', value = 0.25},

		],
		buffs = [],
		sub_effects = [],
	},
	e_i_anal = {
		type = 'c_static',
		conditions = [{code = 'trait', trait = 'anal', check = true}],
		tags = ['recheck_trait', 'recheck_item'],
		descript = "TRAITEFFECTANAL",
		atomic = [{type = 'stat_add_p', stat = 'lusttick', value = 0.15}],
		buffs = [],
		sub_effects = [],
	},
	e_handcuffs_effect = {
		type = 'trigger',
		conditions = [],
		trigger = [variables.TR_DAY],
		descript = "TRAITEFFECTHANDCUFFS",
		req_skill = false,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				index = 1,
				value = 10,# X from item description
				args = [{obj = 'template', param = 'index'},{obj = 'template', param = 'value'}],
				atomic = ['a_add_counter_args'],
			},
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [
					{code = 'stat_index', stat = 'counters', index = 1, operant = 'gte', value = 100},
					{code = 'trait', trait = 'submissive', check = false},
				],
				atomic = [{type = 'add_sex_trait', trait = 'submissive'}],
			},
		],
		buffs = []
	},
	e_anal_trait_counter = {
		type = 'trigger',
		conditions = [],
		trigger = [variables.TR_DAY],
		descript = "TRAITEFFECTANALCOUNT",
		req_skill = false,
		args = [{obj = 'app_obj', param = 'sexuals_factor'}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				X = 12,
				args = [{obj = 'parent_args', param = 0}, {obj = 'template', param = 'X'}],
				atomic = [
					{type = 'add_counter', index = 2, value = [['parent_args', 0],'*',['parent_args',1]]}
				],
			},
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [
					{code = 'stat_index', stat = 'counters', index = 2, operant = 'gte', value = 100},
					{code = 'trait', trait = 'anal', check = false},
				],
				atomic = [{type = 'add_sex_trait', trait = 'anal'}],
			},
		],
		buffs = []
	},
	e_res = {
		type = 'oneshot',
		target = 'target',
		args = [{obj = 'parent_args', param = 0}],
		atomic = ['a_res'],
		buffs = [],
		sub_effects = []
	},
	#temp items
	e_tail_plug_effect = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'lusttick', value = 0.1}],
		descript = "TRAITEFFECTTAILPLUG",
		buffs = [],
		sub_effects = [],
	},
	e_tail_plug_bonus = {
		type = 'c_static',
		tags = ['recheck_item'],
		conditions = [{code = 'gear_equiped', value = 'pet_suit', check = true}],
		atomic = [{type = 'stat_add', stat = 'charm_bonus', value = 10}],
		descript = "TRAITEFFECTTAILPLUGBONUS",
		buffs = [],
		sub_effects = [],
	},

	e_sunderwear_effect = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'lusttick', value = 0.25}],
		descript = "TRAITEFFECTUNDERWEAR",
		buffs = [],
		sub_effects = [],
	},
	e_tentacle_suit_effect = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'lusttick', value = 1}],
		descript = "TRAITEFFECTTENTACLESUIT",
		buffs = [],
		sub_effects = [],
	},
	e_tentacle_suit_subeffect = {
		type = 'c_static',
		conditions = [
			{code = 'trait', trait = 'deviant', check = false},
			{code = 'stat', stat = 'sexuals_factor', operant = 'lt', value = 5}
		],
		tags = ['recheck_trait', 'recheck_item'],
		descript = "TRAITEFFECTTENTACLESUB",
		atomic = [
			{type = 'stat_add', stat = 'wits_bonus', value = -25},
			{type = 'stat_add', stat = 'physics_bonus', value = -25}
		],
		buffs = [],
		sub_effects = [],
	},

	#core
	e_fire_custom = {
		type = 'oneshot',
		target = 'owner',
		atomic = ['a_fire_custom'],
		buffs = [],
		sub_effects = [],
	},
	e_fire_custom1 = {
		type = 'oneshot',
		target = 'owner',
		atomic = ['a_fire_custom1'],
		buffs = [],
		sub_effects = [],
	},
	satisfaction_1 = {
		type = 'temp_s',
		target = 'target',
		name = "Satisfaction",
		tick_event = variables.TR_TICK,
		duration = 6,
		stack = 1,
		tags = [],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'productivity', value = 0.1},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Reward_with_sex 3.png",
				description = "TRAITEFFECTSATISFIED",
				limit = 1,
				t_name = "Satisfaction",
				mansion_only = true,
			}
		],
	},
	satisfaction_2 = {
		type = 'temp_s',
		target = 'target',
		name = "Satisfaction",
		tick_event = variables.TR_TICK,
		duration = 6,
		stack = 1,
		tags = [],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'productivity', value = 0.2},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Reward_with_sex 3.png",
				description = "TRAITEFFECTSATISFIED2",
				limit = 1,
				t_name = "Satisfaction",
				mansion_only = true,
			}
		],
	},
	
	test_recast = {
		type = 'trigger',
		trigger = [variables.TR_TICK],
		req_skill = false,
		conditions = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			atomic = [{type = 'use_social_skill', skill = 'test_recast'}]
		}],
		buffs = ['b_stun']
	},
	test_recast1 = {
		type = 'temp_s',
		target = 'receiver',
		name = 'test',
		buffs = ['b_freeze'],
		stack = 0,
		rem_event = variables.TR_TICK,
	},
	test_combat_start = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_S],
		req_skill = false,
		conditions = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			atomic = [{type = 'sfx', value = 'test_combat_start'}]
		}],
	},
	
	celena_bless = {
		type = 'temp_s',
		duration = 2,
		stack = 1,
		name = 'celena_bless',
		tick_event = [variables.TR_TICK],
		args = [],
		sub_effects = [
			{
				type = 'oneshot',
				args = [],
				atomic = [{type = 'remove_all_effects', value = 'injury'}],
			},
			{
				type = 'static',
				tags = [],
				atomic = [
					{type = 'stat_add', stat = 'damage_reduction', value = 30},
				],
				buffs = [],
				sub_effects = [],
			}
		],
		buffs = [{
			icon = "res://assets/images/iconsskills/icon_protective_shell.png",
			description = "TRAITEFFECTCELENABLESS",
			args = [],
			limit = 1,
			t_name = 'celena_bless',
		}]
	},
	freya_bless = {
		type = 'temp_s',
		duration = 4,
		stack = 1,
		name = 'freya_bless',
		tick_event = [variables.TR_TICK],
		args = [],
		atomic = [
			{type = 'stat_add', stat = 'hitrate', value = 25},
			{type = 'stat_add', stat = 'armorpenetration', value = 30},
		],
		sub_effects = [],
		buffs = [{
			icon = "res://assets/images/iconsskills/heavyshot.png",
			description = "TRAITEFFECTFREYABLESS",
			args = [],
			limit = 1,
			t_name = 'freya_bless',
		}]
	},
	celena_curse = {
		type = 'temp_s',
		duration = 4,
		stack = 1,
		name = 'celena_curse',
		tick_event = [variables.TR_TICK],
		args = [],
		atomic = [
			{type = 'stat_mul', stat = 'hpmax', value = 0.5},
		],
		sub_effects = [],
		buffs = [{
			icon = "res://assets/images/iconsskills/BloodMagic.png",
			description = "TRAITEFFECTCELENACURSE",
			args = [],
			limit = 1,
			t_name = 'celena_curse',
		}]
	},
	hybris_curse = {
		type = 'temp_s',
		duration = 4,
		stack = 1,
		name = 'hybris_curse',
		tick_event = [variables.TR_TICK],
		args = [],
		atomic = [
			{type = 'stat_mul', stat = 'armor', value = 0.5},
		],
		sub_effects = [],
		buffs = [{
			icon = "res://assets/images/iconsskills/Acid-spit.png",
			description = "TRAITEFFECTHYBRISCURSE",
			args = [],
			limit = 1,
			t_name = 'hybris_curse',
		}]
	},
	freya_curse = {
		type = 'temp_s',
		duration = 8,
		stack = 1,
		name = 'freya_curse',
		tick_event = [variables.TR_TICK],
		args = [],
		tags = [],
		atomic = [
			{type = 'stat_add', stat = 'evasion', value = -50},
			{type = 'stat_add', stat = 'hitrate', value = -50},
		],
		sub_effects = [],
		buffs = [{
			icon = "res://assets/images/iconsskills/BloodMagic.png",
			description = "TRAITEFFECTFREYACURSE",
			args = [],
			limit = 1,
			t_name = 'freya_curse',
		}]
	},

#	date_bonus = { 
#		type = 'temp_s',
#		duration = 1,
#		stack = 1,
#		name = 'date_bonus',
#		tick_event = [variables.TR_TICK],
#		args = [],
#		sub_effects = [],
#		atomic = [{type = 'stat_add_p', stat = 'loyalty_gain', value = 0.5}],
#		buffs = [{
#			icon = "res://assets/images/iconsskills/Reward_with_sex 3.png",
#			description = "TRAITEFFECTDATEBONUS",
#			args = [],
#			limit = 1,
#			t_name = 'date_effect',
#			mansion_only = true,
#		}]
#	},

	

	e_pregnancy = {
		type = 'temp_u',
		stack = 1,
		name = 'pregnancy',
		tags = ['pregnant'],
		atomic = [
			{type = 'stat_add', stat = 'speed', value = -10},
			{type = 'stat_add', stat = 'physics_bonus', value = -20},
		],
		next_level = 'e_pregnancy1',
		sub_effects = [],
		buffs = [{
			icon = "res://assets/images/iconsskills/preg_icon1.png",
			description = "TRAITEFFECTISPREGNANT",
			args = [],
			limit = 1,
			t_name = 'preg',
		}]
	},
	e_pregnancy1 = {
		type = 'temp_u',
		stack = 1,
		name = 'pregnancy',
		tags = ['pregnant', 'heavy_pregnant'],
		atomic = [
			{type = 'stat_add', stat = 'speed', value = -20},
			{type = 'stat_add', stat = 'physics_bonus', value = -40},
		],
		sub_effects = [],
		buffs = [{
			icon = "res://assets/images/iconsskills/preg_icon2.png",
			description = "TRAITEFFECTISPREGNANT2",
			args = [],
			limit = 1,
			t_name = 'preg',
		}]
	},
	e_brand = rebuild_simple_dot(['loyalty', 'spirit'], [0.5, -0.5], variables.TR_DAY),
	e_mkup = {
		type = 'static',
		atomic = [{type = 'stat_add', stat = 'charm_bonus', value = 10}],
		buffs = [],
		sub_effects = [],
	},
	e_tlust1 = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'lusttick', value = 0.1}],
		buffs = [],
		sub_effects = [],
	},
	e_tlust2 = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'lusttick', value = 0.2}],
		buffs = [],
		sub_effects = [],
	},
	e_thpr = {
		type = 'static',
		atomic = [{type = 'stat_add', stat = 'hp_reg_mod', value = 0.2}],
		buffs = [],
		sub_effects = [],
	},
	e_tmpr = {
		type = 'static',
		atomic = [{type = 'stat_add', stat = 'mp_reg_mod', value = 0.1}],
		buffs = [],
		sub_effects = [],
	},
	e_trib1 = {
		type = 'static',
		atomic = [{type = 'stat_add', stat = 'physics_bonus', value = 3}],
		buffs = [],
		sub_effects = [],
	},
	e_trib2 = {
		type = 'static',
		atomic = [{type = 'stat_add', stat = 'hpmax', value = 5}],
		buffs = [],
		sub_effects = [],
	},
	e_i_gauntlets = {
		type = 'static',
		descript = "Skill Damage: +10%",
		atomic = [{type = 'stat_add', stat = 'damage_mod_skill', value = 0.1}],
		buffs = [],
		sub_effects = [],
	},
};

var atomic = {
	#new part
	a_stat_add = {type = 'stat_add', stat = ['parent_args', 0], value = ['parent_args', 1]},
	a_stat_add_p = {type = 'stat_add_p', stat = ['parent_args', 0], value = ['parent_args', 1]},
	a_stat_mul = {type = 'stat_mul', stat = ['parent_args', 0], value = ['parent_args', 1]},
	a_poison_arg025 = {type = 'damage', source = variables.S_PHYS, value = [['parent_args', 0],'*',0.25]},#bugged
	a_remove_buff = {type = 'remove_effect', value = 'buff'},
	a_self_kill = {type = 'kill'},
	a_fire_custom = {type = 'event', value = variables.TR_CUSTOM},
	a_fire_custom1 = {type = 'event', value = variables.TR_CUSTOM1},

	a_caster_heal = {type = 'heal', value = [['parent_arg_get', 0, 'process_value'], '*', 0.5]},
	a_firefist = {type = 'damage', value = [['parent_arg_get', 0, 'process_value'], '*', 0.2], source = variables.S_FIRE},#bugged
	a_gobmet_blade = {type = 'damage', source = variables.S_EARTH, value = ['parent_args', 0]},#bugged
	a_elvenwood_rod = {type = 'mana', value = [['parent_args', 0], '*', 0.1]},
	#not used new part (allows to setup stat changing with effect's template)

	a_hp_restore_ex = {type = 'heal', value = [['parent_args', 0], '*', 0.2]},#can be made as stat_add to hppercent
	a_mana_restore_ex = {type = 'mana', value = [['parent_args', 1], '*', 0.2]},
	a_ward_shield = {type = 'stat_set_revert', stat = 'shield', value = ['parent_args', 1]},
	a_souls1 = {type = 'stat_add', stat = 'damage', value = [['parent_args', 0],'*',5]},#bugged
	a_souls2 = {type = 'stat_add', stat = 'armor', value = [['parent_args', 0],'*',5]},
	a_damage_arg = {type = 'damage', value = ['parent_args', 0]},
	a_add_counter_args = {type = 'add_counter', index = ['parent_args', 0], value = ['parent_args', 1]},
	a_regen = {type = 'heal', value = [['parent_args', 0],'*',0.25]},
	a_burn = {type = 'damage', source = 'fire', value = ['parent_args', 0]},
	a_poison = {type = 'damage', source = 'earth', value = ['parent_args', 0]},
	a_bleed = {type = 'damage', source = 'true', value = [['parent_args', 0], '*', 0.25]},
	a_res = {type = 'resurrect', value = ['parent_args', 0]},
	
	a_burn_new = {type = 'damage', source = 'fire', value = [['parent_args', 0], '*', ['parent_args', 1], '*', ['parent_args', 2],]},
	a_poison_new = {type = 'damage', source = 'true', value = [['parent_args', 0], '*', ['parent_args', 1], '*', ['parent_args', 2],]},
	a_bleed_new = {type = 'damage', source = 'true', value = [['parent_args', 0], '*', ['parent_args', 1], '*', ['parent_args', 2],]},
	
};
#needs filling
var buffs = {
	#new part
	#icons are defined by path or by name in images.icons, do not load images here!
#	b_shackles = {
#		icon = "res://assets/images/iconsskills/Magic Shackles.png",
#		description = "BUFFDESCRIPTSHACKLES",
#		limit = 1,
#		t_name = 'shackles',
#		mansion_only = true,
#	},
#	b_great_shackles = {
#		icon = "res://assets/images/iconsskills/Strong Magic Shackles.png",
#		description = "BUFFDESCRIPTGREATSHACKLES",
#		limit = 1,
#		t_name = 'shackles',
#		mansion_only = true,
#	},
	b_charm = {
		icon = "res://assets/images/iconsskills/Charm.png",
		description = "BUFFDESCRIPTCHARM",
		args = [{obj = 'parent', param = 'remains'}],
		limit = 1,
		t_name = 'charmed',
		mansion_only = true,
	},
	b_stun = {
		icon = "res://assets/images/traits/experience.png", #?? mb to fix
		description = "BUFFDESCRIPTSTUN",
		limit = 1,
		t_name = 'stun'
	},
	b_charm_c = {
		icon = "res://assets/images/iconsskills/Charm.png", #?? mb to fix
		description = "BUFFDESCRIPTCHARM2",
		limit = 1,
		t_name = 'charm'
	},
	b_mirror = {
		icon = "res://assets/images/traits/hitrate.png",
		description = "BUFFDESCRIPTMIRROR",
		limit = 1,
		t_name = 'mirror'
	},
	b_taunt= {
		icon = "res://assets/images/traits/hitrate.png",
		description = "BUFFDESCRIPTTAUNT",
		limit = 1,
		t_name = 'taunt'
	},
	b_silence = {
		icon = "res://assets/images/iconsskills/Seduce.png",
		description = "BUFFDESCRIPTSILENCE",
		t_name = 'silence'
	},
	b_wet = {
		icon = "res://assets/images/iconsskills/Barrier.png",
		description = "BUFFDESCRIPTWET", 
		t_name = 'wet'
	},
	b_freeze = {
		icon = "res://assets/images/iconsskills/Barrier.png",
		description = "BUFFDESCRIPTFROZEN", 
		t_name = 'freeze'
	},
	b_disarm = {
		icon = "res://assets/images/iconsskills/Shackle.png",
		description = "BUFFDESCRIPTDISARM",
		t_name = 'disarm'
	},
	b_banish = {
		icon = "res://assets/images/iconsclasses/Cattle.png",
		description = "BUFFDESCRIPTBANISH",
		t_name = 'banish'
	},
	b_void = {
		icon = "res://assets/images/iconsclasses/Headman.png",
		description = "BUFFDESCRIPTVOID",
		t_name = 'void'
	},
	b_defend = {
		icon = "res://assets/images/iconsclasses/Knight.png",
		description = "BUFFDESCRIPTDEFEND",
		t_name = 'defend'
	},
	b_regen = {
		icon = "res://assets/images/iconsskills/lesserheal.png",
		description = "BUFFDESCRIPTREGEN",
		t_name = 'regen'
	},
	b_stonewall = {
		icon = "res://assets/images/iconsskills/icon_endure.png",
		description = "BUFFDESCRIPTSTONEWALL",
		t_name = 'stonewall',
		combat_only = true
	},
	b_laststand = {
		icon = "res://assets/images/iconsskills/skill_last_stand.png",
		description = "BUFFDESCRIPTLASTSTAND",
		t_name = 'laststand',
		combat_only = true
	},
	b_burn = {
		icon = "res://assets/images/iconsskills/firebolt.png",
		description = "BUFFDESCRIPTBURNING",
		t_name = 'burn'
	},
	b_poison = {
		icon = "res://assets/images/iconsskills/skill_dip_poison.png",
		description = "BUFFDESCRIPTPOISON",
		t_name = 'poison'
	},
	b_bleed = {
		icon = "res://assets/images/iconsskills/icon_blood_explosion.png",
		description = "BUFFDESCRIPTBLEEDING",
		t_name = 'bleed'
	},
	b_confuse = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTCONFUSE",
		t_name = 'confuse'
	},
	b_command = {
		icon = "res://assets/images/iconsclasses/Attendant.png", #fix
		description = "BUFFDESCRIPTCOMMANDBONUS",
		t_name = 'command',
		combat_only = true
	},
	b_shred = {
		icon = "res://assets/images/iconsskills/Acid-spit.png",
		description = "BUFFDESCRIPTSHRED",
		t_name = 'shred',
		combat_only = true
	},
	b_shatter = {
		icon = "res://assets/images/iconsskills/icon_elemental_protection.png",
		description = "BUFFDESCRIPTSHATTER",
		t_name = 'shatter',
		combat_only = true
	},
	
	b_sleep = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTSLEEP",
		t_name = 'sleep',
		combat_only = true
	},
	b_blind = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTBLIND",
		t_name = 'blind',
		combat_only = true
	},
	b_fear = {
		icon = "res://assets/images/iconsskills/Fear.png",
		description = "BUFFDESCRIPTFEAR",
		t_name = 'fear',
		combat_only = true
	},
	b_shock = {
		icon = "res://assets/images/iconsskills/Innervate.png",
		description = "BUFFDESCRIPTSHOCK",
		t_name = 'shock',
		combat_only = true
	},
	b_ensnare = {
		icon = "res://assets/images/iconsskills/skill_ensnare.png",
		description = "BUFFDESCRIPTENSNARE",
		t_name = 'ensnare',
		combat_only = true
	},
	b_growl = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTGROWL",
		t_name = 'shrgrowled',
		combat_only = true
	},
	
	b_magicward = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTMAGICWARD",
		t_name = 'magicward',
		combat_only = true
	},
	b_slam = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTSLAM",
		t_name = 'slam',
		combat_only = true
	},
	
	b_atkpass = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTATKPAS",
		t_name = 'atkpass',
		limit = -1,
		combat_only = true
	},
	b_atkpass_src = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTATTACKPASSSRC",
		t_name = 'atkpass_s',
		limit = 1,
		combat_only = true
	},
	b_factor_maxed = {
		icon = "res://assets/images/iconsskills/Authority.png",
		description = "",
		limit = 1,
		t_name = 'b_factor_maxed',
		mansion_only = true,
		show_in_traits = true
	},
	b_curse = {#stub for default curse icon
		icon = "res://assets/images/iconsenchants/curse_mono_100.png",
		description = "BUFFDESCRIPTCURSE",
		t_name = 'curse',
	},
	b_enchant = {#stub for default enchant icon
		icon = "res://assets/images/iconsskills/Authority.png",
		description = "BUFFDESCRIPTENCHANT",
		t_name = 'enchant',
	},
	b_bold = {
		icon = "res://assets/images/iconsenchants/curse_mono_100.png",#fix
		description = "BUFFDESCRIPTBOLD",
		t_name = 'personality',
	},
	b_kind = {
		icon = "res://assets/images/iconsenchants/curse_mono_100.png",#fix
		description = "BUFFDESCRIPTKIND",
		t_name = 'personality',
	},
	b_shy = {
		icon = "res://assets/images/iconsenchants/curse_mono_100.png",#fix
		description = "BUFFDESCRIPTSHY",
		t_name = 'personality',
	},
	b_serious = {
		icon = "res://assets/images/iconsenchants/curse_mono_100.png",#fix
		description = "BUFFDESCRIPTSERIOUS",
		t_name = 'personality',
	},
	
	b_dayoff = {
		icon = "res://assets/images/iconsenchants/curse_mono_100.png",#fix
		description = "",
		t_name = 'dayoff',
	},
	
};

func rebuild_template(args):
	var res = {
		type = 'trigger',
		req_skill = true,
		trigger = [],
		conditions = [],
		buffs = [],
		sub_effects = []
	}
	if args.has('trigger'): res.trigger.push_back(args.trigger) #for simplicity only one trigger type can be passed
	else: res.trigger.push_back(variables.TR_POSTDAMAGE)

	if args.has('res_condition'): res.conditions.push_back({type = 'skill', value = ['hit_res', 'mask', args.res_condition]})
	else: res.conditions.push_back({type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]})

	if args.has('checkres'):
		res.conditions.push_back({type = 'checkres', value = args.chance, resist = args.checkres})
	elif args.has('chance'):
		res.conditions.push_back({type = 'random', value = args.chance})

	if args.has('duration'): #for this to work effect should have its duration set to 'parent'
		res.duration = args.duration
	if args.has('push_value'):
		res.args = [{obj = 'parent', param = 'process_value'}]
	elif args.has('push_characters'):
		res.args = [{obj = 'parent', param = 'target'}, {obj = 'parent', param = 'caster'}]

	res.sub_effects.push_back(args.effect)

	return res


func rebuild_template_globals(args):
	var res = {
		type = 'trigger',
		req_skill = true,
		trigger = [],
		conditions = [],
		buffs = [],
		sub_effects = [],
		args = [{obj = 'parent', param = 'caster'}, {obj = 'parent', param = 'target'}]
	}
	if args.has('trigger'): res.trigger.push_back(args.trigger) #for simplicity only one trigger type can be passed
	else: res.trigger.push_back(variables.TR_POSTDAMAGE)

	if args.has('res_condition'): res.conditions.push_back({type = 'skill', value = ['hit_res', 'mask', args.res_condition]})
	else: res.conditions.push_back({type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]})

	if args.has('checkres'):
		res.conditions.push_back({type = 'checkres', value = args.chance, resist = args.checkres})
	elif args.has('chance'):
		res.conditions.push_back({type = 'random', value = args.chance})

	if args.has('push_value'):
		res.args.push_back({obj = 'parent', param = 'process_value'})

	res.sub_effects.push_back(args.effect)

	return res


func rebuild_skillvalue_template(args):
	var trigger = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_HIT],
#		reset = [variables.TR_CAST],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		buffs = [],
		sub_effects = []
	}
	var sub = {
		type = 'oneshot',
		target = 'skill',
		atomic = [],
		buffs = [],
		sub_effects = []
	}
	var atomic = {type = 'stat_mul', stat = 'value', value = 1}
	var condition = {type = 'skill', value = []}
	var targetcondition = {type = 'target', value = []}
	if args.has('value'): #should be always true - for without it this makes no sence
		atomic.value = args.value
	
	sub.atomic.push_back(atomic)
	trigger.sub_effects.push_back(sub)
	
	if args.has('tag'):
		var tmp = condition.duplicate(true)
		tmp.value = ['tags', 'has', args.tag]
		trigger.conditions.push_back(tmp)
	
	if args.has('tags'):
		for tag in args.tags:
			var tmp = condition.duplicate(true)
			tmp.value = ['tags', 'has', tag]
			trigger.conditions.push_back(tmp)
	
	if args.has('skilltype'):
		var tmp = condition.duplicate(true)
		tmp.value = ['ability_type', 'eq', args.skilltype]
		trigger.conditions.push_back(tmp)
	
	if args.has('num_targets'):
		var tmp = condition.duplicate(true)
		tmp.value = ['target_number', 'eq', args.num_targets]
		trigger.conditions.push_back(tmp)
	
	if args.has('source'):
		var tmp = condition.duplicate(true)
		tmp.value = ['damage_type', 'eq', args.source]
		trigger.conditions.push_back(tmp)
	
	if args.has('target_race'):
		var tmp = targetcondition.duplicate(true)
		tmp.value.push_back({code = 'stat', stat = 'racegroup', operant = 'eq', value = args.target_race})
		trigger.conditions.push_back(tmp)
	
	if args.has('target_tag'):
		var tmp = targetcondition.duplicate(true)
		tmp.value.push_back({code = 'tags', operant = 'has', value = args.target_tag})
		trigger.conditions.push_back(tmp)
	
	if args.has('target_status'):
		var tmp = targetcondition.duplicate(true)
		tmp.value.push_back({code = 'has_status', check = true, status = args.target_status})
		trigger.conditions.push_back(tmp)
	
	return trigger


func rebuild_defvalue_template(args):
	var trigger = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_DEF],
#		reset = [variables.TR_CAST],
		conditions = [],
		buffs = [],
		sub_effects = []
	}
	var sub = {
		type = 'oneshot',
		target = 'skill',
		atomic = [],
		buffs = [],
		sub_effects = []
	}
	var atomic = {type = 'stat_mul', stat = 'value', value = 1}
	var condition = {type = 'skill', value = []}
	var castercondition = {type = 'caster', value = []}
	if args.has('value'): #should be always true - for without it this makes no sence
		atomic.value = args.value
	
	sub.atomic.push_back(atomic)
	trigger.sub_effects.push_back(sub)
	
	if args.has('tag'):
		var tmp = condition.duplicate(true)
		tmp.value = ['tags', 'has', args.tag]
		trigger.conditions.push_back(tmp)
	
	if args.has('tags'):
		for tag in args.tags:
			var tmp = condition.duplicate(true)
			tmp.value = ['tags', 'has', tag]
			trigger.conditions.push_back(tmp)
	
	if args.has('skilltype'):
		var tmp = condition.duplicate(true)
		tmp.value = ['ability_type', 'eq', args.skilltype]
		trigger.conditions.push_back(tmp)
	
	if args.has('num_targets'):
		var tmp = condition.duplicate(true)
		tmp.value = ['target_number', 'eq', args.num_targets]
		trigger.conditions.push_back(tmp)
	
	if args.has('source'):
		var tmp = condition.duplicate(true)
		tmp.value = ['damage_type', 'eq', args.source]
		trigger.conditions.push_back(tmp)
	
	if args.has('caster_race'):
		var tmp = castercondition.duplicate(true)
		tmp.value.push_back({code = 'stat', stat = 'racegroup', operant = 'eq', value = args.caster_race})
		trigger.conditions.push_back(tmp)
	
	if args.has('caster_tag'):
		var tmp = castercondition.duplicate(true)
		tmp.value.push_back({code = 'tags', operant = 'has', value = args.caster_tag})
		trigger.conditions.push_back(tmp)
	
	return trigger


func rebuild_stat_bonus(stat, value, buff = null, mode = 'stat_add'):
	var template = {
		type = 'static',
		atomic = [],
		buffs = [],
		sub_effects = [],
		args = [{obj = 'template', param = 'stat'}, {obj = 'template', param = 'value'}]
	}
	template.stat = stat
	template.value = value
	if buff != null:
		template.buffs.push_back(buff)
	template.atomic.push_back('a_' + mode)
	return template


func rebuild_simple_dot(stat, value, trigger = variables.TR_TURN_F):
	var template = {
		type = 'trigger',
		trigger = [],
		req_skill = false,
		conditions = [],
		args = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = [],
				atomic = [],
			}
		]
		}
	for i in range(stat.size()):
		var atomic_template = {type = 'stat_add', stat = '', value = ''}
		
		atomic_template.stat = stat[i]
		atomic_template.value = value[i]
		template.sub_effects[0].atomic.push_back(atomic_template)
	
	template.trigger.push_back(trigger)
	
	return template
	
func rebuild_oneshot_addstat(stat, value, target = 'owner'):
	var template = {
		type = 'oneshot',
		args = [],
		atomic = [],
		buffs = [],
		sub_effects = []
	}
	template.target = target
	if stat is Array:
		for i in range(stat.size()):
			var a_template = {type = 'stat_add', stat = 'loyalty', value = 1}
			a_template.stat = stat[i]
			a_template.value = value[i]
			template.atomic.push_back(a_template)
	else:
		var a_template = {type = 'stat_add', stat = 'loyalty', value = 1}
		a_template.stat = stat
		a_template.value = value
		template.atomic.push_back(a_template)
	
	return template


func rebuild_remove_effect(eff):
	var template = {
		type = 'oneshot',
		target = 'target',
		args = [],
		atomic = [{type = 'remove_all_effects', value = eff}],
	}
	
	return template


func rebuild_make_status(args):
	var atomic = {type = 'make_status_effect', parent = ['parent_id']}
	var template = {
		type = 'oneshot',
		target = 'target',
		args = [],
		atomic = [],
	}
	atomic.effect = args.effect
	if args.has('duration'):
		atomic.duration = args.duration
	else:
		atomic.duration = 1
	if args.has('chance'):
		atomic.chance = args.chance
	else:
		atomic.chance = 1.0
	template.atomic.push_back(atomic)
	return template
