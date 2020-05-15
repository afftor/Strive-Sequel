extends Node
var effects = {
}

var effect_table = {
	#traits
	e_tr_slave = {
		type = 'static',
		atomic = [
			{type = 'stat_add', stat = 'modall', value = -0.1},
			{type = 'stat_add_p', stat = 'mod_collect', value = 0.1},
			{type = 'stat_add_p', stat = 'mod_pros', value = 0.1},
			{type = 'stat_add_p', stat = 'mod_farm', value = 0.1},
			{type = 'stat_add_p', stat = 'mod_smith', value = -0.15},
			{type = 'stat_add_p', stat = 'mod_alchemy', value = -0.15},
			{type = 'stat_add_p', stat = 'mod_tailor', value = -0.15},
			{type = 'stat_add_p', stat = 'submission_degrade_mod', value = -0.5}
			],
		buffs = [],
		sub_effects = [],
	},
	e_tr_master = {
		type = 'trigger',
		trigger = [variables.TR_S_CAST],
		req_skill = true,
		conditions = [],
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.5, stats = ['authority']}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	e_tr_worker = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'mod_collect', value = 0.5}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_foreman = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'mod_collect', value = 0.33}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_hunter = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'mod_hunt', value = 0.5}, {type = 'stat_add_p', stat = 'mod_fish', value = 0.5}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_smith = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'mod_smith', value = 1.0}, {type = "stat_add_p", stat = 'mod_tailor', value = 1.0}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_engi = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'mod_build', value = 1.0}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_chef = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'mod_cook', value = 1.0}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_alchemist = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'mod_alchemy', value = 1}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_cattle = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'mod_farm', value = 0.5}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_breeder = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'mod_farm', value = 1.0}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_harlot = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'mod_pros', value = 0.5}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_pet = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'mod_pros', value = 0.25}],
		buffs = [],
		sub_effects = [],
	},
	rations_food = {
		type = 'static',
		atomic = [{type = 'stat_add', stat = 'food_consumption', value = 3}],
		buffs = [],
		sub_effects = [],
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
	work_rule_constrain = {
		code = 'work_rule_constrain',
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'productivity', value = 0.15},
			{type = 'stat_add_p', stat = 'loyalty_degrade_mod', value = 0.5},
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
	e_tr_potion = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		reset = [variables.TR_TURN_GET],
		req_skill = true,
		conditions = [{type = 'skill', value = ['ability_type', 'eq', 'item']}, {type = 'skill', value = ['tags', 'has', 'heal']}],
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.25}],
				buffs = ['b_power_pot'],
				sub_effects = []
			}
		]
	},
	e_tr_attendant = { #first variant
		type = 'trigger',
		trigger = [variables.TR_CAST],
		reset = [variables.TR_TURN_GET],
		req_skill = true,
		conditions = [{type = 'skill', value = ['ability_type', 'eq', 'item']}],
		atomic = [],
		buffs = [],#buff for indicating free item use, obviosly not b_stun
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'add_tag', value = 'instant'}],
				buffs = ['b_free_use'],
				sub_effects = []
			}
		]
	},
	e_tr_witcrit = {
		type = 'trigger',
		trigger = [variables.TR_CAST],
		req_skill = true,
		conditions = [],
		atomic = [],
		buffs = [],
		args = [{obj = 'app_obj', param = 'wits_factor'}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				args = [{obj = 'parent_args', param = 0}],
				atomic = [{type = 'stat_add', stat = 'critchance', value = [['parent_args', 0],'*',3]}],
				buffs = [],
				sub_effects = []
			}
		]
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
	e_t_charm = {
		type = 'temp_s',
		target = 'target',
		name = 'charm',
		tick_event = variables.TR_TICK,
		duration = 'parent', 
		stack = 1,
		tags = ['magic', 's_dur_add'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'lusttick', value = 0.25},
		],
		buffs = ['b_charm'],
	},
	#shackles effects for now have the same bug as shield effects in displaced and here - they don't remove all previous shackles effects before applying (so on breaking shackles removing the first effect reverts shackles_chance to null and removing the second effect reverts this chance to resulting chance of the first effect), this part needs to be fixed after testing before the final version. but for test purpose current version is ok, cause this bug have controlled appearance
	e_s_shackles1 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		req_skill = true,
		sub_effects = ['e_shackles1'],
		args = [{obj = 'parent', param = 'target'}, {obj = 'parent', param = 'caster'}],#[target, caster]
		buffs = []
	},
	e_shackles1 = { 
		type = 'temp_s',
		target = 'target',
		name = 'shackles',
		rem_event = variables.TR_SHACKLES_OFF,
		stack = 1,
		tags = [],
		sub_effects = [],
		args = [{obj = 'parent_arg_get', index = 0, param = 'magic_factor'}, {obj = 'parent_arg_get', index = 1, param = 'magic_factor'}],#[target.magic_factor, caster.magic_factor]
		atomic = ['a_shackles_1'],
		buffs = ['b_shackles'],
	},
	e_s_shackles2 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		req_skill = true,
		sub_effects = ['e_shackles2'],
		args = [{obj = 'parent', param = 'target'}, {obj = 'parent', param = 'caster'}],#[target, caster]
		buffs = []
	},
	e_shackles2 = { 
		type = 'temp_s',
		target = 'target',
		name = 'shackles',
		rem_event = variables.TR_SHACKLES_OFF,
		stack = 1,
		tags = [],
		sub_effects = [],
		args = [{obj = 'parent_arg_get', index = 0, param = 'magic_factor'}, {obj = 'parent_arg_get', index = 1, param = 'magic_factor'}],#[target.magic_factor, caster.magic_factor]
		atomic = ['a_shackles_2'],
		buffs = ['b_great_shackles'],
	},
	e_t_hardwork = {
		type = 'temp_s',
		target = 'target',
		name = 'hardwork',
		tick_event = variables.TR_TICK,
		duration = 'parent', 
		stack = 1,
		tags = ['s_dur_add'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'productivity', value = 0.5},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Worker.png", 
				description = "Productivity increased",
				limit = 1,
				t_name = 'hardwork',
				mansion_only = true,
			}
		],
	},
	e_food_like = {
		type = 'temp_s',
		name = 'food_like',
		tick_event = variables.TR_TICK,
		duration = 24, 
		stack = 1,
		sub_effects = [],
		tags = [],
		atomic = [
			{type = 'stat_add_p', stat = 'productivity', value = 0.1},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Worker.png", 
				description = "Favorite Food: Productivity increased by 10%%.",
				limit = 1,
				t_name = 'food_like',
				mansion_only = true,
			}
		],
	},
	e_food_dislike = {
		type = 'temp_s',
		name = 'food_dislike',
		tick_event = variables.TR_TICK,
		duration = 24, 
		stack = 1,
		sub_effects = [],
		tags = [],
		atomic = [
			{type = 'stat_add_p', stat = 'productivity', value = -0.1},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Worker.png", 
				description = "Hated Food: Productivity reduced by 10%%.",
				limit = 1,
				t_name = 'food_hate',
				mansion_only = true,
			}
		],
	},
	e_starve = {
		type = 'temp_s',
		target = 'target',
		name = 'starvation',
		tick_event = variables.TR_TICK,
		duration = 24, 
		stack = 1,
		sub_effects = [],
		tags = [],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/iconsitems/food_old.png", 
				description = "No food has been eaten: Exhaustion does not restore while resting.",
				limit = 1,
				t_name = 'starvation',
				mansion_only = true,
			}
		],
	},
	e_t_discipline = {
		type = 'temp_s',
		target = 'target',
		name = 'discipline',
		tick_event = variables.TR_TICK,
		duration = 'parent', 
		stack = 1,
		tags = ['s_dur_add'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'mod_collect', value = 0.5},
			{type = 'stat_add_p', stat = 'mod_hunt', value = 0.5},
			{type = 'stat_add_p', stat = 'mod_fish', value = 0.5},
			{type = 'stat_add_p', stat = 'mod_cook', value = 0.5},
			{type = 'stat_add_p', stat = 'mod_smith', value = 0.5},
			{type = 'stat_add_p', stat = 'mod_alchemy', value = 0.5},
			{type = 'stat_add_p', stat = 'mod_tailor', value = 0.5},
			{type = 'stat_add_p', stat = 'mod_farm', value = 0.5},
			#{type = 'stat_mul', stat = 'mod_collect', value = 1.5},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Discipline.png", 
				description = "Efficiency increased",
				limit = 1,
				t_name = 'discipline',
				mansion_only = true,
			}
		],
	},
	e_t_seduce = {
		type = 'temp_s',
		target = 'target',
		name = 'seduce',
		tick_event = variables.TR_TICK,
		duration = 'parent_arg', 
		stack = 1,
		no_escape = true,
		no_loyal_reduction = true,
		tags = ['s_dur_add'],
		sub_effects = [],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Reward_with_sex 3.png", 
				description = tr("BUFFSEDUCE"),
				limit = 1,
				t_name = '',
				mansion_only = true,
			}
		],
	},
	e_t_greatseduce = {
		type = 'temp_s',
		target = 'target',
		name = 'seduce1',
		tick_event = variables.TR_TICK,
		duration = 'parent_arg', 
		stack = 1,
		no_escape = true,
		no_loyal_reduction = true,
		tags = ['s_dur_add'],
		sub_effects = [],
		atomic = [{type = 'stat_add_p', stat = 'lusttick', value = 0.5}],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Reward_with_sex 3.png", 
				description = tr("BUFFGREATSEDUCE"),
				limit = 1,
				t_name = '',
				mansion_only = true,
			}
		],
	},
	e_t_charm1 = {
		type = 'temp_s',
		target = 'target',
		name = 'charm1',
		tick_event = variables.TR_TICK,
		duration = 'parent_arg', 
		stack = 1,
		tags = ['s_dur_add'],
		sub_effects = [],
		atomic = [{type = 'stat_add_p', stat = 'lusttick', value = 0.2}],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Charm.png", 
				description = "charmed",
				limit = 1,
				t_name = '',
				mansion_only = true,
			}
		],
	},
	e_s_mindcontrol = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		req_skill = true,
		args = [{obj = 'parent', param = 'caster'}],
		sub_effects = ['e_t_mindcontrol_t', 'e_t_mindcontrol_c'],
		buffs = []
	},
	e_t_mindcontrol_t = {
		type = 'temp_s',
		target = 'target',
		name = 'mindcontrol',
		stack = 0,#stacks unlimitely, control this by casting checks
		no_escape = true,
		tags = ['mindcontrol'],
		args = [{obj = 'parent_arg_get', index = 0, param = 'id'}],
		sub_effects = ['e_t_mindcontrol'],
		atomic = [
			{type = 'stat_add', stat = 'wits_bonus', value = -100},
			{type = 'stat_add', stat = 'charm_bonus', value = -50},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Mind_Control.png", 
				description = "Mind Controlled",
				limit = 1,
				t_name = '',
				mansion_only = true,
			}],
	},
	e_t_mindcontrol_c = {
		type = 'temp_s',
		target = 'caster',
		name = 'mindcontrol_caster',
		stack = 0,
		tags = [],
		sub_effects = ['e_t_mindcontrol'],
		atomic = [],
		buffs = [],
	},
	e_t_mindcontrol = {
		type = 'trigger',
		conditions = [],
		trigger = [variables.TR_MOVE, variables.TR_DEATH, variables.TR_REMOVE],
		req_skill = false,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'self',
				execute = 'remove_siblings'
			},
		],
		buffs = []
	},
	e_t_stopcontrol = {
		type = 'oneshot',
		target = 'target',
		atomic = [{type = 'remove_effect', value = 'mindcontrol'}],
		buffs = [],
		sub_effects = [],
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
	e_t_inspire = {
		type = 'temp_s',
		target = 'target',
		name = 'inspire',
		tick_event = variables.TR_TURN_F,
		rem_event = variables.TR_COMBAT_F,
		stack = 1,
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'modall', value = 0.2},
			{type = 'stat_add_p', stat = 'armor', value = 0.2},
			{type = 'stat_add_p', stat = 'mdef', value = 0.2},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Praise.png", 
				description = "Inspired - damage and defence increased",
				limit = 1,
				t_name = 'inspire'
			}
		],
	},
	e_t_command = {
		type = 'temp_s',
		target = 'target',
		name = 'command',
		tick_event = variables.TR_TURN_F,
		rem_event = variables.TR_COMBAT_F,
		duration = 3, 
		stack = 1,
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'atk', value = 0.5},
			{type = 'stat_add_p', stat = 'matk', value = 0.5}
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Trainer.png", 
				description = "Damage increased",
				limit = 1,
				t_name = 'command'
			}
		],
	},
	#version for trap skill only usable by player
	e_t_trap = {
		type = 'trigger',
		target = 'target',
		trigger = [variables.TR_CAST],
		req_skill = false,
		conditions = [],
		atomic = [],
		buffs = ['b_trap'],
		sub_effects = [
			'e_trap',
			{
				type = 'oneshot',
				target = 'self',
				execute = 'remove'
			}
		]
	},
	e_trap = {
		type = 'temp_s',
		target = 'owner',
		name = 'trap',
		tick_event = variables.TR_TURN_F,
		rem_event = variables.TR_COMBAT_F,
		duration = 2, 
		stack = 1,
		disable = true,
		tags = ['stun'],
		sub_effects = [],
		atomic = [],
		buffs = ['b_stun'],
	},
	e_t_refine = {
		type = 'temp_s',
		target = 'target',
		name = 'refine',
		rem_event = variables.TR_COMBAT_F,
		stack = 1,
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'atk', value = 0.3},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/WeaponRefine.png", 
				description = "ATK increased",
				limit = 1,
				t_name = 'refine'
			}
		],
	},
	e_t_acid = {
		type = 'temp_s',
		target = 'target',
		name = 'acid',
		tick_event = variables.TR_TURN_GET,
		rem_event = variables.TR_COMBAT_F,
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
				description = "Armor reduced",
				limit = 1,
				t_name = 'acid_bomb'
			}
		],
	},
	e_s_distract = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'target', value = {code = 'is_humanoid', check = true} }
		],
		req_skill = true,
		value = -30,
		args = [{obj = 'template', param = 'value'}],
		sub_effects = ['e_t_distract'],
		buffs = []
	},
	e_s_distract1 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'target', value = {code = 'is_humanoid', check = false} }
		],
		req_skill = true,
		value = -20,
		args = [{obj = 'template', param = 'value'}],
		sub_effects = ['e_t_distract'],
		buffs = []
	},
	e_t_distract = {
		type = 'temp_s',
		target = 'target',
		name = 'distract',
		tick_event = variables.TR_TURN_GET,
		rem_event = variables.TR_COMBAT_F,
		stack = 1,#or not
		duration = 4,
		tags = ['debuff'],
		sub_effects = [],
		stat = 'evasion',
		args = [{obj = 'template', param = 'stat'}, {obj = 'parent_args', param = 0}],
		atomic = ['a_stat_add'],
		buffs = ['b_distract'],
	},
	e_t_attract = {
		type = 'temp_s',
		target = 'target',
		name = 'attract',
		tick_event = variables.TR_TURN_GET,
		rem_event = variables.TR_COMBAT_F,
		stack = 1,#or not
		duration = 3,
		tags = ['debuff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'modall', value = -0.3},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Whore.png", 
				description = "Damage reduced",
				limit = 1,
				t_name = 'attract'
			}
		],
	},
	e_s_entral = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		req_skill = true,
		sub_effects = ['e_t_entral_t', 'e_t_entral_c'],
		buffs = []
	},
	e_t_entral_t = {
		type = 'temp_s',
		target = 'target',
		name = 'entral',
		tick_event = variables.TR_TURN_F,
		rem_event = variables.TR_COMBAT_F,
		duration = 3, 
		stack = 1,
		disable = true,
		tags = ['stun'],
		sub_effects = ['e_t_entral'],
		atomic = [],
		buffs = ['b_stun'],
	},
	e_t_entral_c = {
		type = 'temp_s',
		target = 'caster',
		name = 'entral',
		tick_event = variables.TR_TURN_F,
		rem_event = variables.TR_COMBAT_F,
		duration = 3, 
		stack = 1,
		disable = true,
		tags = ['stun'],
		sub_effects = ['e_t_entral'],
		atomic = [],
		buffs = ['b_stun'],
	},
	e_t_entral = {
		type = 'trigger',
		conditions = [],
		trigger = [variables.TR_DMG],
		req_skill = false,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'self',
				execute = 'remove_siblings'
			},
			{
				type = 'oneshot',
				target = 'self',
				execute = 'remove_parent'
			}
		],
		buffs = []
	},
	e_s_protect = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		req_skill = true,
		args = [{obj = 'parent', param = 'caster'}],
		sub_effects = ['e_t_protect_c', 'e_t_protect_t'],
		buffs = []
	},
	e_t_protect_c = {
		type = 'temp_s',
		target = 'caster',
		name = 'protect_c',
		tick_event = variables.TR_TURN_F,
		rem_event = variables.TR_COMBAT_F,
		duration = 2, 
		stack = 1,
		tags = ['buff'],
		sub_effects = ['e_t_protect_ctr'],
		atomic = [
			{type = 'stat_add', stat = 'armor', value = 25} #not sure about armor but there is no defence stat
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Knight.png", 
				description = "Armor increased",
				limit = 1,
				t_name = 'protect_c'
			}
		],
	},
	e_t_protect_ctr = {
		type = 'trigger',
		conditions = [],
		trigger = [variables.TR_DEATH],
		req_skill = false,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'self',
				execute = 'remove_siblings'
			},
		],
		buffs = []
	},
	e_t_protect_t = {
		type = 'temp_s',
		target = 'target',
		name = 'protect_t',
		tick_event = variables.TR_TURN_F,
		rem_event = variables.TR_COMBAT_F,
		duration = 2, 
		stack = 1,
		tags = ['buff'],
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = ['e_t_protect_ttr'],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Knight.png", 
				description = "Is protected",
				limit = 1,
				t_name = 'protect_t'
			}
		],
	},
	e_t_protect_ttr = {
		type = 'trigger',
		conditions = [{type = 'skill', value = ['tags', 'has', 'damage']}],
		trigger = [variables.TR_DEF],
		req_skill = true,
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				args = [{obj = 'parent_args', param = 0}],
				atomic = [{type = 'stat_set', stat = 'target', value = ['parent_args', 0]}],
			},
		],
		buffs = []
	},
	e_t_dragonmight = {
		type = 'temp_s',
		target = 'target',
		name = 'dragonmight',
		rem_event = variables.TR_COMBAT_F,
		stack = 1,
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'modall', value = 0.25},
			{type = 'stat_mul', stat = 'armor', value = 1.25},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Dragon_Knight.png", 
				description = "Damage and armor increased",
				limit = 1,
				t_name = 'dragonmight'
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
		rem_event = variables.TR_COMBAT_F,
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
				rem_event = [variables.TR_SHIELD_DOWN,variables.TR_COMBAT_F],
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
						description = "Damage-absorbing shield, blocks 100 damage (%d remains)",
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
		tick_event = variables.TR_TURN_GET,
		rem_event = variables.TR_COMBAT_F,
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
				description = "Speed reduced",
				limit = 1,
				t_name = 'blizzard'
			}
		],
	},
	e_t_bless = {
		type = 'temp_s',
		target = 'target',
		name = 'bless',
		tick_event = variables.TR_TURN_F,
		rem_event = variables.TR_COMBAT_F,
		duration = 3, 
		stack = 1,#or not
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'atk', value = 10},
			{type = 'stat_add', stat = 'matk', value = 10},
			{type = 'stat_add', stat = 'armor', value = 10},
			{type = 'stat_add', stat = 'mdef', value = 10},
			{type = 'stat_add', stat = 'evasion', value = 10},
			{type = 'stat_add', stat = 'hitrate', value = 10},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/dodgedebuff.png", 
				description = "Is blesed - various stats increased",
				limit = 1,
				t_name = 'bless'
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
	e_t_fly = {
		type = 'temp_s',
		target = 'target',
		name = 'fly',
		tick_event = variables.TR_TURN_GET,
		rem_event = variables.TR_COMBAT_F,
		duration = 4, 
		stack = 1,#or not
		tags = ['buff'],
		sub_effects = [],
		atomic = [{type = 'stat_add', stat = 'evasion', value = 25}],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Fear.png", 
				description = "Evasion increased",
				limit = 1,
				t_name = 'fly'
			}
		],
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
	e_s_eshatter = {
		type = 'temp_s',
		target = 'target',
		name = 'eshatter',
		tick_event = variables.TR_TURN_GET,
		rem_event = variables.TR_COMBAT_F,
		stack = 1,#or not
		duration = 'parent',
		tags = ['debuff'],
		atomic = [
			{type = 'stat_add', stat = 'evasion', value = -25},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Debilitate.png", 
				description = "Evasion reduced",
				limit = 1,
				t_name = 'eshatter'
			}
		],
	},
	e_s_revenge = {
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
				atomic = [{type = 'stat_mul', stat = 'value', value = [['parent_args', 0],'/',['parent_args', 1],'*',-3,'+',4.0]}],
			},
		],
	},
	e_s_fireburst = {
		type = 'temp_s',
		target = 'target',
		name = 'fireburst',
		tick_event = variables.TR_TURN_GET,
		rem_event = variables.TR_COMBAT_F,
		stack = 1,#or not
		duration = 'parent',
		tags = ['debuff'],
		atomic = [
			{type = 'stat_add', stat = 'hitrate', value = -20},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Mindread.png", 
				description = "Hit chance reduced",
				limit = 1,
				t_name = 'fireburst'
			}
		],
	},
	e_s_swipe = {
		type = 'temp_s',
		target = 'target',
		name = 'swipe',
		tick_event = variables.TR_TURN_GET,
		rem_event = variables.TR_COMBAT_F,
		stack = 1,#or not
		duration = 'parent',
		tags = ['debuff'],
		atomic = [
			{type = 'stat_add', stat = 'armor', value = -20},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Acid-spit.png", 
				description = "DEF reduced",
				limit = 1,
				t_name = 'swipe'
			}
		],
	},
	e_s_arrowrain = {
		type = 'temp_s',
		target = 'target',
		name = 'arrowrain',
		tick_event = variables.TR_TURN_GET,
		rem_event = variables.TR_COMBAT_F,
		stack = 1,#or not
		duration = 'parent',
		tags = ['debuff'],
		atomic = [
			{type = 'stat_add', stat = 'mdef', value = -20},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/arrowshower.png", 
				description = "MDEF reduced",
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
		rem_event = variables.TR_COMBAT_F,
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
				description = "Damage reduced",
				limit = 1,
				t_name = 'sstrike'
			}
		],
	},
	#statuses
	e_t_hide = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_CAST, variables.TR_COMBAT_F, variables.TR_DMG],
		stack = 1,
		name = 'hide',
		tags = ['buff', 'hide'],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Mindread.png", 
				description = "Hidden",
				t_name = 'hide'
			}
		],
		sub_effects = [],
	},
	e_s_stun = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_TURN_F],
		stack = 1,
		name = 'stun',
		disable = true,
		tags = ['debuff', 'stun_prechecked'],
		buffs = ['b_stun'],
	},
	e_s_stun1 = {#duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F],
		tick_event = [variables.TR_TURN_F],
		duration = 'parent',
		stack = 1,
		name = 'stun',
		disable = true,
		tags = ['debuff', 'stun'],
		buffs = ['b_stun'],
	},
	e_s_stun2 = {#parent_arg duration
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F],
		tick_event = [variables.TR_TURN_F],
		stack = 1,
		duration = 'parent_arg',
		name = 'stun',
		disable = true,
		tags = ['debuff', 'stun'],
		buffs = ['b_stun'],
	},
	e_s_freeze = {#no-duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_POSTDAMAGE],
		stack = 1,
		name = 'freeze',
		disable = true,
		tags = ['debuff', 'freeze'],
		buffs = ['b_freeze'],
		sub_effects = ['e_t_freeze']
	},
	e_s_freeze1 = {#parent-duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_POSTDAMAGE],
		tick_event = [variables.TR_TURN_GET],
		duration = 'parent',
		stack = 1,
		name = 'freeze',
		disable = true,
		tags = ['debuff', 'freeze'],
		buffs = ['b_freeze'],
		sub_effects = ['e_t_freeze']
	},
	e_t_freeze = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['damage_type', 'eq', 'air'] }
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 2.0}],
			}
		]
	},
	e_s_disarm = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_TURN_F],
		stack = 1,
		name = 'disarm',
		tags = ['debuff', 'disarm'],
		buffs = ['b_disarm'],
	},
	e_s_disarm1 = {#duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F],
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
		rem_event = [variables.TR_COMBAT_F],
		tick_event = [variables.TR_TURN_F],
		stack = 1,
		duration = 'parent_arg',
		name = 'disarm',
		tags = ['debuff', 'disarm'],
		buffs = ['b_disarm'],
	},
	e_s_silence = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_TURN_F],
		stack = 1,
		name = 'silence',
		tags = ['debuff', 'silence'],
		buffs = ['b_silence'],
	},
	e_s_silence1 = {#duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F],
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
		rem_event = [variables.TR_COMBAT_F],
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
		rem_event = [variables.TR_COMBAT_F, variables.TR_TURN_F],
		stack = 1,
		name = 'void',
		tags = ['buff', 'void'],
		buffs = ['b_void'],
	},
	e_s_void1 = {#duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F],
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
		rem_event = [variables.TR_COMBAT_F],
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
		rem_event = [variables.TR_COMBAT_F, variables.TR_TURN_F],
		stack = 1,
		name = 'banish',
		tags = ['buff', 'banish'],
		buffs = ['b_banish'],
	},
	e_s_banish1 = {#duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F],
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
		rem_event = [variables.TR_COMBAT_F],
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
		rem_event = [variables.TR_COMBAT_F, variables.TR_TURN_F],
		stack = 1,
		name = 'confuse',
		tags = ['debuff', 'confuse'],
		buffs = ['b_confuse'],
	},
	e_s_defend = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_TURN_GET],
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
	e_s_regen = {#not sure about duration modes
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F],
		stack = 1,
		name = 'regen',
		tags = ['buff', 'regen'],
		buffs = ['b_regen'],
		sub_effects = ['e_t_regen']
	},
	e_t_regen = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = [{obj = 'app_obj', param = 'hpmax'}],
				atomic = ['a_regen'],
			}
		]
	},
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
		rem_event = [variables.TR_COMBAT_F],
		duration = 'parent_arg',
		tags = ['affliction'],
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
		rem_event = [variables.TR_COMBAT_F],
		duration = 'parent_arg',
		tags = ['affliction'],
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
	e_s_bleed = {
		type = 'temp_s',
		target = 'target',
		name = 'bleed',
		stack = 0,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F],
		duration = 'parent_arg',
		tags = ['affliction', 'bleed_prechecked'],
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = ['e_bleed'],
		atomic = [],
		buffs = ['b_bleed'],
	},
	e_bleed = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		req_skill = false,
		conditions = [],
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = [{
				type = 'oneshot',
				target = 'owner',
				args = [{obj = 'parent_args', param = 0}],
				atomic = ['a_bleed'],
			}
		]
	},
	#items
	e_i_la = {
		type = 'static',
		tags = ['penalty', 'lightarmorencumb'],
		atomic = [{type = 'stat_add', stat = 'manacost_mod', value = 0.15}],
		buffs = [
			{
				icon = "", 
				description = "",
				t_name = 'lightarmorencumb',
				limit = 1
			}
		],
		sub_effects = [],
	},
	e_i_ha = {
		type = 'static',
		tags = ['penalty', 'heavyarmorencumb'],
		atomic = [
			{type = 'stat_add', stat = 'manacost_mod', value = 0.2},
			{type = 'stat_add', stat = 'evasion', value = -10}
		],
		buffs = [
			{
				icon = "", 
				description = "",
				t_name = 'heavyarmorencumb',
				limit = 1
			}
		],
		sub_effects = [],
	},
	e_i_shackles = {
		type = 'c_static',
		descript = 'Prevents escape if Physics Factor less than 4',
		conditions = [{code = 'stat', stat = 'physics_factor', operant = 'lt', value = 4}],
		tags = ['recheck_stats', 'recheck_item'],
		no_escape = true,
		atomic = [],
		buffs = [],
		sub_effects = [],
	},
	e_i_pet_suit = {
		type = 'static',
		conditions = [],
		descript = "Loyalty Decay: -35%\nSubmission Decay: -65%.",
		tags = ['recheck_class', 'recheck_item'],
		atomic = [
		{type = 'stat_mul', stat = 'loyalty_degrade_mod', value = 0.65},
		{type = 'stat_mul', stat = 'submission_degrade_mod', value = 0.35},
		],
		buffs = [],
		sub_effects = [],
	},
	e_i_pet_suit_bonus = {
		type = 'c_static',
		conditions = [{code = 'has_profession', profession = 'pet', check = true}],
		descript = "When wearer has Pet class:\nCharm: +10\nSocial skills effect: +10%.",
		tags = ['recheck_class', 'recheck_item'],
		atomic = [{type = 'stat_add', stat = 'charm_bonus', value = 10}],
		buffs = [],
		sub_effects = ['e_pet_suit_bonus_skill'],
	},
	e_maid_dress_effect = {
		type = 'static',
		conditions = [],
		descript = "Loyalty Decay: -50%",
		tags = [],
		atomic = [
		{type = 'stat_mul', stat = 'loyalty_degrade_mod', value = 0.5},
		],
		buffs = [],
		sub_effects = [],
	},
	e_worker_outfit_effect = {
		type = 'static',
		conditions = [],
		descript = "Hunting, Fishing and Collecting Tasks: +25%",
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
		conditions = [],
		descript = "Cooking, Smithing, Alchemy, Tailor and Upgrading Tasks: +25%",
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
		descript = 'If wearer has "Likes Anal" trait: Lust growth + 15%.',
		atomic = [{type = 'stat_add_p', stat = 'lusttick', value = 0.15}],
		buffs = [],
		sub_effects = [],
	},
	e_pet_suit_bonus_skill = {
		type = 'trigger',
		trigger = [variables.TR_S_CAST],
		req_skill = true,
		conditions = [{type = 'skill', value = ['tags', 'has', 'discipline']}],
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.1}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	e_handcuffs_effect = {
		type = 'trigger',
		conditions = [],
		trigger = [variables.TR_DAY],
		descript = 'Prolonged wearing might cause wearer to become Submissive.',
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
		descript = 'Prolonged wearing makes wearer more responsive to Anal.',
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
	e_leather_collar_effect = {
		type = 'static',
		atomic = [{type = 'stat_mul', stat = 'loyalty_degrade_mod', value = 0.7},{type = 'stat_mul', stat = 'submission_degrade_mod', value = 0.7},{type = 'stat_add_p', stat = 'authority_mod', value = 0.25}],
		descript = 'Reduces Loyalty and Submission decay by 30%. Increases Authority gain by 25%. ',
		buffs = [],
		sub_effects = [],
	},
	e_chocker_effect = {
		type = 'static',
		atomic = [{type = 'stat_mul', stat = 'loyalty_degrade_mod', value = 0.4}],
		descript = "Reduces Loyalty decay by 60%.",
		buffs = [],
		sub_effects = [],
	},
	e_steel_collar_effect = {
		type = 'static',
		atomic = [{type = 'stat_mul', stat = 'submission_degrade_mod', value = 0.75},{type = 'stat_add_p', stat = 'authority_mod', value = 0.35}],
		descript = 'Reduces Submission decay by 50%. Increases Authority gain by 35%.',
		buffs = [],
		sub_effects = [],
	},
	e_tail_plug_effect = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'lusttick', value = 0.1}],
		descript = 'Increases Lust growth by 10%.',
		buffs = [],
		sub_effects = [],
	},
	e_tail_plug_bonus = {
		type = 'c_static',
		tags = ['recheck_item'],
		conditions = [{code = 'gear_eqiped', value = 'pet_suit'}],
		atomic = [{type = 'stat_add', stat = 'charm_bonus', value = 10}],
		descript = 'Increases Charm by 10 if Pet Suit equipped.',
		buffs = [],
		sub_effects = [],
	},
	
	e_sunderwear_effect = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'lusttick', value = 0.25}],
		descript = 'Increases Lust growth by 25%.',
		buffs = [],
		sub_effects = [],
	},
	e_tentacle_suit_effect = {
		type = 'static',
		atomic = [{type = 'stat_add_p', stat = 'lusttick', value = 1}],
		descript = 'Increases Lust growth by 100%.',
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
	
	
	
	master_combat_1 = {
		type = 'temp_s',
		target = 'target',
		name = "Master's Morale",
		tick_event = variables.TR_TICK,
		duration = 48,
		stack = 1,
		tags = [],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'atk', value = 0.15},
			{type = 'stat_add_p', stat = 'matk', value = 0.15},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Fighter.png", 
				description = "Atk and Matk increased by 15%%",
				limit = 1,
				t_name = "Master's Morale",
			}
		],
	},
	master_productivity_1 = {
		type = 'temp_s',
		target = 'target',
		name = "Master's Morale",
		tick_event = variables.TR_TICK,
		duration = 72, 
		stack = 1,
		tags = [],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'productivity', value = 0.2},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Worker.png", 
				description = "Productivity increased by 20%%",
				limit = 1,
				t_name = "Master's Morale",
			}
		],
	},
	satisfaction_1 = {
		type = 'temp_s',
		target = 'target',
		name = "Satisfaction",
		tick_event = variables.TR_TICK,
		duration = 36, 
		stack = 1,
		tags = [],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'productivity', value = 0.1},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Reward_with_sex 3.png", 
				description = "Productivity increased by 10%%",
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
		duration = 36, 
		stack = 1,
		tags = [],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'productivity', value = 0.2},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Reward_with_sex 3.png", 
				description = "Productivity increased by 20%%",
				limit = 1,
				t_name = "Satisfaction",
				mansion_only = true,
			}
		],
	},
	succubus_combat_1 = {
		type = 'temp_s',
		target = 'caster',
		name = "Lust Drain",
		tick_event = variables.TR_TICK,
		duration = 48,
		stack = 1,
		tags = [],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'atk', value = 0.25},
			{type = 'stat_add_p', stat = 'matk', value = 0.25},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Fighter.png", 
				description = "Atk and Matk increased by 25%%",
				limit = 1,
				t_name = "Lust Drain",
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
	valkyrie_spear_bonus = {
		type = 'c_static',
		conditions = [{code = 'gear_eqiped', param = 'geartype', value = 'spear'}],
		tags = ['recheck_item'],
		atomic = [
			{type = 'stat_add', stat = 'speed', value = 10},
		],
		buffs = [], 
		sub_effects = [],
	},
};

var atomic = {
	#new part
	a_shackles_1 = {type = 'stat_set_revert', comment = 'effect of shackles skill', stat = 'shackles_chance', value = [['parent_args', 0],'-',['parent_args', 1], '*', 10, '-', 5]},
	a_shackles_2 = {type = 'stat_set_revert', stat = 'shackles_chance', value = [['parent_args', 0],'-',['parent_args', 1], '*', 10, '-', 30]},
	a_stat_add = {type = 'stat_add', stat = ['parent_args', 0], value = ['parent_args', 1]},
	a_stat_mul = {type = 'stat_mul', stat = ['parent_args', 0], value = ['parent_args', 1]},
	a_poison_arg025 = {type = 'damage', source = variables.S_PHYS, value = [['parent_args', 0],'*',0.25]},#bugged
	a_remove_buff = {type = 'remove_effect', value = 'buff'},
	a_self_kill = {type = 'kill'},
	a_fire_custom = {type = 'event', value = variables.TR_CUSTOM},
	a_fire_custom1 = {type = 'event', value = variables.TR_CUSTOM1},
	
	a_caster_heal = {type = 'heal', value = [['parent_arg_get', 0, 'process_value'], '*', 0.5]},
	a_magecrit = {type = 'mana', value = ['parent_arg_get', 0, 'manacost']},
	a_firefist = {type = 'damage', value = [['parent_arg_get', 0, 'process_value'], '*', 0.2], source = variables.S_FIRE},#bugged
	a_gobmet_blade = {type = 'damage', source = variables.S_EARTH, value = ['parent_args', 0]},#bugged
	a_elvenwood_rod = {type = 'mana', value = [['parent_args', 0], '*', 0.1]},
	#not used new part (allows to setup stat changing with effect's template)

	a_hp_restore_ex = {type = 'heal', value = [['parent_args', 0], '*', 0.2]},#can be made as stat_add to hppercent
	a_mana_restore_ex = {type = 'mana', value = [['parent_args', 1], '*', 0.2]},
	a_ward_shield = {type = 'stat_set_revert', stat = 'shield', value = ['parent_args', 1]},
	a_sanctuary_heal = {type = 'heal', value = ['parent_args', 0]},
	a_souls1 = {type = 'stat_add', stat = 'damage', value = [['parent_args', 0],'*',5]},#bugged
	a_souls2 = {type = 'stat_add', stat = 'armor', value = [['parent_args', 0],'*',5]},
	a_damage_arg = {type = 'damage', value = ['parent_args', 0]},
	a_add_counter_args = {type = 'add_counter', index = ['parent_args', 0], value = ['parent_args', 1]},
	a_regen = {type = 'heal', value = [['parent_args', 0],'*',0.25]},
	a_burn = {type = 'damage', source = 'fire', value = ['parent_args', 0]},
	a_poison = {type = 'damage', source = 'earth', value = ['parent_args', 0]},
	a_bleed = {type = 'damage', source = 'normal', value = ['parent_args', 0]},
	a_res = {type = 'resurrect', value = ['parent_args', 0]},
};
#needs filling
var buffs = {
	#new part
	#icons are defined by path or by name in images.icons, do not load images here!
	b_shackles = {
		icon = "res://assets/images/iconsskills/Magic Shackles.png", 
		description = "Shackles",
		limit = 1,
		t_name = 'shackles',
		mansion_only = true,
	},
	b_great_shackles = {
		icon = "res://assets/images/iconsskills/Strong Magic Shackles.png", 
		description = "Great Shackles",
		limit = 1,
		t_name = 'shackles',
		mansion_only = true,
	},
	b_charm = {
		icon = "res://assets/images/iconsskills/Charm.png", 
		description = "Is charmed. %d hours remains",
		args = [{obj = 'parent', param = 'remains'}],
		limit = 1,
		t_name = 'charmed',
		mansion_only = true,
	},
	b_stun = {
		icon = "res://assets/images/traits/experience.png", #?? mb to fix
		description = "Stunned",
		limit = 1,
		t_name = 'stun'
	},
	b_trap = {
		icon = "res://assets/images/traits/hitrate.png", 
		description = "Trapped",
		limit = 1,
		t_name = 'trap'
	},
	b_distract = {
		icon = "res://assets/images/traits/dodge.png", 
		description = "Evasion reduced",
		limit = 1,
		t_name = 'distract'
	},
	b_silence = {
		icon = "res://assets/images/iconsskills/Seduce.png", 
		description = "Silenced",
		t_name = 'silence'
	},
	b_freeze = {
		icon = "res://assets/images/iconsskills/Barrier.png", 
		description = "Frozen",
		t_name = 'freeze'
	},
	b_disarm = {
		icon = "res://assets/images/iconsskills/Shackle.png", 
		description = "Disarmed",
		t_name = 'disarm'
	},
	b_banish = {
		icon = "res://assets/images/iconsclasses/Cattle.png", 
		description = "Banish",
		t_name = 'banish'
	},
	b_void = {
		icon = "res://assets/images/iconsclasses/Headman.png", 
		description = "Void",
		t_name = 'void'
	},
	b_defend = {
		icon = "res://assets/images/iconsclasses/Knight.png", 
		description = "Defend",
		t_name = 'defend'
	},
	b_regen = {
		icon = "res://assets/images/iconsskills/lesserheal.png", 
		description = "Regeneration",
		t_name = 'regen'
	},
	b_burn = {
		icon = "res://assets/images/iconsskills/firebolt.png", 
		description = "Burning",
		t_name = 'burn'
	},
	b_poison = {
		icon = "res://assets/images/iconsskills/Heal.png", 
		description = "Poisoned",
		t_name = 'poison'
	},
	b_bleed = {
		icon = "res://assets/images/iconsskills/Debilitate.png", 
		description = "Bleeding",
		t_name = 'bleed'
	},
	b_confuse = {
		icon = "res://assets/images/iconsskills/Sedate.png", 
		description = "Confusion",
		t_name = 'confuse'
	},
	b_free_use = {
		icon = "res://assets/images/iconsskills/Sedate.png", 
		description = "Confusion",
		t_name = 'freuse',
		combat_only = true
	},
	b_power_pot = {
		icon = "res://assets/images/iconsskills/Sedate.png", 
		description = "Confusion",
		t_name = 'powerpot',
		combat_only = true
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
	
	res.sub_effects.push_back(args.effect)
	
	return res
