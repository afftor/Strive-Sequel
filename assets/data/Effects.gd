extends Node
var effects = {
}
#to fix EFFECT TAGS TO TEMPLATE
#'positive'/'negative' - the widest classification (to most global cleaning like bard2 skill effect)
#'buff'/'debuff' - additional markings for common effect removal effects (like purge) (and maybe add two more for a state effects)
#any other - for additional customisation

var effect_table = {
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
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_S_CAST],
				req_skill = true,
				conditions = [{type = 'skill', value = ['tags', 'has', 'positive']}],
				atomic = [],
				buffs = [],
				sub_effects = [
					{
						type = 'oneshot',
						target = 'skill',
						atomic = [{type = 'stat_mul', stat = 'value', value = 1.2, stats = ['authority', 'loyalty', 'loyaltyObedience', 'submissionObedience']}],
						buffs = [],
						sub_effects = []
					}
				]
			},
		],
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
		atomic = [{type = 'stat_add', stat = 'resist_all', value = 15}],
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
	e_tame6 = {
		type = 'c_static',
		descript = '',
		conditions = [{code = 'stat', stat = 'tame_factor', operant = 'gte', value = 6}],
		tags = ['recheck_stats', 'recheck_item'],
		atomic = [{type = 'stat_mul', stat = 'obDrainReduction', value = 0.8}],
		buffs = [],
		sub_effects = [],
	},
	#traits
	e_tr_hide = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_S],
		conditions = [{type = 'owner', value = [{code = 'gear_equiped', param = 'geartype', value = 'heavy', check = false}, {code = 'gear_equiped', param = 'geartype', value = 'medium', check = false}]}],
		atomic = [],
		buffs = [],
		req_skill = false,
		sub_effects = ['e_t_hide']
	},
	e_tr_slave = {
		type = 'static',
		atomic = [
			{type = 'stat_add', stat = 'damage_mod_all', value = -0.1},
			{type = 'stat_add_p', stat = 'mod_collect', value = 0.1},
			{type = 'stat_add_p', stat = 'mod_pros', value = 0.1},
			{type = 'stat_add_p', stat = 'mod_farm', value = 0.1},
			{type = 'stat_add_p', stat = 'mod_smith', value = -0.15},
			{type = 'stat_add_p', stat = 'mod_alchemy', value = -0.15},
			{type = 'stat_add_p', stat = 'mod_tailor', value = -0.15},
			{type = 'stat_mul', stat = 'obDrainReduction', value = 0.9}
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
	e_tr_spouse = {
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
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.3, stats = ['authority']}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	e_tr_renown = {
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
				atomic = [
					{type = 'stat_mul', stat = 'value', value = 1.5, stats = ['loyaltyObedience']},
					{type = 'stat_mul', stat = 'value', value = 1.5, stats = ['loyalty']},
					],
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
		atomic = [],
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
			{type = 'stat_add', stat = 'obDrainIncrease', value = 0.5},
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
				buffs = [],
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
		buffs = ['b_free_use'],#buff for indicating free item use, obviosly not b_stun
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'add_tag', value = 'instant'}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	e_tr_healer = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		reset = [],
		req_skill = true,
		conditions = [{type = 'skill', value = ['ability_type', 'neq', 'item']}, {type = 'skill', value = ['tags', 'has', 'heal']}],
		atomic = [],
		buffs = [],#'b_power_pot'],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.25}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	e_tr_hunter1 = rebuild_skillvalue_template({target_race = 'beast', tag = 'damage',  value = 1.15}),
	e_tr_bers1 = rebuild_skillvalue_template({source = 'fire', skilltype = 'skill', tag = 'damage', value = 1.2}),
	e_tr_bers2 = rebuild_skillvalue_template({source = 'earth', skilltype = 'skill', tag = 'damage', value = 1.2}),
	e_tr_druid = rebuild_skillvalue_template({source = 'earth', skilltype = 'spell', tag = 'damage', value = 1.2}),
	e_tr_bishop = rebuild_skillvalue_template({source = 'light', skilltype = 'spell', tag = 'damage', value = 1.4}),
	e_tr_sniper = rebuild_skillvalue_template({num_targets = 'single', skilltype = 'skill', tag = 'damage', value = 1.25}),
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
	e_tr_witcrit = {
		type = 'dynamic',
		tags = ['recheck_stats'],
		atomic = [{type = 'stat_add', stat = 'critchance', value = [['parent_args', 0],'*',3]}],
		buffs = [],
		args = [{obj = 'app_obj', param = 'wits_factor'}],
		sub_effects = []
	},
	e_rare_sturdy = {
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'hpmax', value = 1.5},
			{type = 'stat_add', stat = 'armorpenetration', value = 30},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/hitrate.png",
				description = "Rare: Sturdy\nIncreased Health and Armor Penetration",
				limit = 1,
				t_name = 'rare_sturdy'
			}
		],
		sub_effects = [],
	},
	e_rare_nimble = {
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'evasion', value = 0.15},
			{type = 'stat_add', stat = 'evasion', value = 30},
			{type = 'stat_add', stat = 'speed', value = 15},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/speed.png",
				description = "Rare: Nimble\nIncreased Evasion and Speed",
				limit = 1,
				t_name = 'rare_nimble'
			}
		],
		sub_effects = [],
	},
	e_rare_strong = {
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'hpmax', value = 0.5},
			{type = 'stat_add_p', stat = 'damage_mod_all', value = 0.2},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/firedamagebonus.png",
				description = "Rare: Strong\nIncreased Damage and Maximum Healt",
				limit = 1,
				t_name = 'rare_strong'
			}
		],
		sub_effects = [],
	},
	e_rare_deadly = {
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'damage_mod_all', value = 0.35},
			{type = 'stat_add_p', stat = 'hitrate', value = 0.3},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/critrate.png",
				description = "Rare: Deadly\nIncreased Damage and Hitrate",
				limit = 1,
				t_name = 'rare_deadly'
			}
		],
		sub_effects = [],
	},
	e_rare_precise = {
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'hitrate', value = 0.25},
			{type = 'stat_add', stat = 'evasion', value = 35},
			{type = 'stat_add', stat = 'mdef', value = 20},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/bowextradamage.png",
				description = "Rare: Precise\nIncreased Evasion, Hitrate and MDEF",
				limit = 1,
				t_name = 'rare_precise'
			}
		],
		sub_effects = [],
	},
	e_rare_tough = {
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'hpmax', value = 0.35},
			{type = 'stat_add', stat = 'armor', value = 30},
			{type = 'stat_add', stat = 'mdef', value = 30},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/bowextradamage.png",
				description = "Rare: Tough\nIncreased Health, DEF and MDEF",
				limit = 1,
				t_name = 'rare_tough'
			}
		],
		sub_effects = [],
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
#	e_s_shackles1 = {
#		type = 'trigger',
#		trigger = [variables.TR_POSTDAMAGE],
#		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
#		req_skill = true,
#		sub_effects = ['e_shackles1'],
#		args = [{obj = 'parent', param = 'target'}, {obj = 'parent', param = 'caster'}],#[target, caster]
#		buffs = []
#	},
#	e_shackles1 = {
#		type = 'temp_s',
#		target = 'target',
#		name = 'shackles',
#		rem_event = variables.TR_SHACKLES_OFF,
#		stack = 1,
#		tags = [],
#		sub_effects = [],
#		args = [{obj = 'parent_arg_get', index = 0, param = 'magic_factor'}, {obj = 'parent_arg_get', index = 1, param = 'magic_factor'}],#[target.magic_factor, caster.magic_factor]
#		atomic = ['a_shackles_1'],
#		buffs = ['b_shackles'],
#	},
	e_shackles = {#to add duration for sure
		type = 'temp_s',
		target = 'target',
		name = 'shackles',
		rem_event = variables.TR_SHACKLES_OFF,
		stack = 1,
		tags = ['shackles'],
		sub_effects = [],
		args = [],
		atomic = ['a_shackles'],
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
		target = 'receiver',
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
	e_celena_bless = {
		type = 'temp_s',
		name = 'celena_bless',
		tick_event = variables.TR_TICK,
		duration = 4,
		stack = 1,
		sub_effects = [],
		tags = [],
		atomic = [
			{type = 'stat_add_p', stat = 'productivity', value = 0.1},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Worker.png",
				description = "Celena's Blessing: Reduce damage taken by 30%%.",
				limit = 1,
				t_name = 'celena_bless',
				mansion_only = true,
			}
		],
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
			{type = 'stat_add_p', stat = 'productivity', value = 0.1},
		],
		buffs = [
			{
				icon = "res://assets/images/gui/gui icons/food_love.png",
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
				description = "Hated Food: Productivity reduced by 10%%.",
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
		sub_effects = [{
			type = 'oneshot',
			atomic = [{type = 'stat_add_p', stat = 'authority', value = -1}]
		}],
		tags = [],#['addition_rest_tick'],
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
				description = "Starvation\nProductivity reduced by 50%%\nDamage reduced by 50%%",
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
			{type = 'stat_add_p', stat = 'hpmax', value = -20},
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
				description = "Grave Injury\nProductivity reduced by 25%%. Sexuals Bonus -50. Can't participate in Combat. ",
				limit = 1,
				t_name = 'grave_injury',
#				mansion_only = true,
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
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Discipline2.png",
				description = "Labor efficiency increased by 50%%",
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
		tags = ['s_dur_add'],
		sub_effects = [],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Reward_with_sex 3.png",
				description = "Seduce: Escape chance decreased",
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
		tags = ['s_dur_add'],
		sub_effects = [],
		atomic = [{type = 'stat_add_p', stat = 'lusttick', value = 0.5}],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Reward_with_sex 3.png",
				description = "Greater Seduce: Escape chance decreased; Lust Growth increased by 50%%",
				limit = 1,
				t_name = '',
				mansion_only = true,
			}
		],
	},
	e_t_allure1 = {
		type = 'temp_s',
		target = 'target',
		name = 'allure1',
		tick_event = variables.TR_TICK,
		duration = 'parent_arg',
		stack = 1,
		tags = ['s_dur_add'],
		sub_effects = [],
		atomic = [{type = 'stat_mul', stat = 'obDrainReduction', value = 0.8}],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Charm.png",
				description = "Allured: Obedience drain reduced by 20%%",
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
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'damage_mod_all', value = 0.2},
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
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
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
	e_t_serve = {
		type = 'temp_s',
		target = 'target',
		name = 'serve',
		tick_event = variables.TR_TICK,
		duration = 4,
		stack = 1,
		tags = [],
		sub_effects = [],
		atomic = [{type = 'stat_mul', stat = 'obDrainReduction', value = 0.75}],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Charm.png",
				description = "Serving: Obedience drain reduced by 25%%",
				limit = 1,
				t_name = 'serve',
				mansion_only = true,
			}
		],
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
	e_t_trap = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH, variables.TR_SKILL_FINISH],
		stack = 1,
		atomic = [],
		name = 'trap_debuff',
		buffs = ['b_trap'],
		sub_effects = ['e_tr_trap']
	},
	e_tr_trap = {
		type = 'trigger',
		target = 'target',
		trigger = [variables.TR_CAST],
		req_skill = false,
		conditions = [{type = 'random', value = 0.5}],
		atomic = [],
		buffs = [],
		sub_effects = ['e_trap']
	},
	e_trap = {
		type = 'temp_s',
		target = 'owner',
		name = 'trap',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
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
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
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
		],
		req_skill = true,
		args = [],
		sub_effects = ['e_t_distract'],
		buffs = [],
	},
#	e_s_distract1 = {
#		type = 'trigger',
#		trigger = [variables.TR_POSTDAMAGE],
#		conditions = [
#			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
#			{type = 'target', value = {code = 'is_humanoid', check = false} }
#		],
#		req_skill = true,
#		value = -20,
#		args = [{obj = 'template', param = 'value'}],
#		sub_effects = ['e_t_distract'],
#		buffs = []
#	},
	e_t_distract = {
		type = 'temp_s',
		target = 'target',
		name = 'distract',
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		duration = 2,
		tags = ['debuff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'evasion', value = -30},
			{type = 'stat_add', stat = 'hitrate', value = -30}
		],
		buffs = ['b_distract'],
		args = [],
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
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
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
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
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
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
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
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
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
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'damage_mod_all', value = 0.25},
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
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 3,
		stack = 1,#or not
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'atk', value = 0.25},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/dodgedebuff.png",
				description = "ATK Increased",
				limit = 1,
				t_name = 'bless'
			}
		],
	},
	e_t_mental_bless = {
		type = 'temp_s',
		target = 'target',
		name = 'Mental Enhancement',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 3,
		stack = 1,#or not
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'matk', value = 0.25},
#			{type = 'stat_add', stat = 'matk', value = 10},
#			{type = 'stat_add', stat = 'armor', value = 10},
#			{type = 'stat_add', stat = 'mdef', value = 10},
#			{type = 'stat_add', stat = 'evasion', value = 10},
#			{type = 'stat_add', stat = 'hitrate', value = 10},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/dodgedebuff.png",
				description = "MATK Increased",
				limit = 1,
				t_name = 'mental_bless'
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
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 3,
		stack = 1,#or not
		tags = ['buff'],
		sub_effects = [],
		atomic = [{type = 'stat_add', stat = 'evasion', value = 65}],
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
		tick_event = variables.TR_TURN_S,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
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
		tick_event = variables.TR_TURN_S,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
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
				description = "Damage reduced",
				limit = 1,
				t_name = 'sstrike'
			}
		],
	},
	e_t_endure = {#mb to add status resists
		type = 'temp_s',
		target = 'target',
		name = 'endure',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 2,
		stack = 1,
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'resist_normal', value = 20},
			{type = 'stat_add', stat = 'resist_fire', value = 20},
			{type = 'stat_add', stat = 'resist_earth', value = 20},
			{type = 'stat_add', stat = 'resist_water', value = 20},
			{type = 'stat_add', stat = 'resist_air', value = 20},
			{type = 'stat_add', stat = 'resist_light', value = 20},
			{type = 'stat_add', stat = 'resist_dark', value = 20},
			{type = 'stat_add', stat = 'resist_mind', value = 20}
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Authority.png",
				description = "Resists increased",
				limit = 1,
				t_name = 'endure',
				combat_only = true,
			}
		],
	},
	e_s_bard1 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [],
		sub_effects = ['e_clean_bards','e_t_bard1'],
		buffs = []
	},
	e_s_bard2 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [],
		sub_effects = ['e_clean_bards','e_t_bard2'],
		buffs = []
	},
	e_s_bard3 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [],
		sub_effects = ['e_clean_bards','e_t_bard3'],
		buffs = []
	},
	e_t_bard1 = {
		type = 'temp_s',
		target = 'target',
		name = 'bard1',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		duration = 4,
		tags = ['buff', 'positive', 'bard'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'hitrate', value = 20},
			{type = 'stat_add', stat = 'evasion', value = 20},
			{type = 'stat_add', stat = 'speed', value = 20},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Bard.png",
				description = "Bard - faster",
				limit = 1,
				t_name = 'bard',
				combat_only = true,
			}
		],
	},
	e_t_bard3 = {
		type = 'temp_s',
		target = 'target',
		name = 'bard3',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		duration = 4,
		tags = ['buff', 'positive', 'bard'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'atk', value = 0.2},
			{type = 'stat_add_p', stat = 'matk', value = 0.2},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Bard.png",
				description = "Bard - stronger",
				limit = 1,
				t_name = 'bard',
				combat_only = true,
			}
		],
	},
	e_t_bard2 = {
		type = 'temp_s',
		target = 'target',
		name = 'bard2',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		duration = 4,
		tags = ['buff', 'positive', 'bard'],
		sub_effects = ['e_bards_clean'],
		atomic = [
			{type = 'stat_add', stat = 'armor', value = 15},
			{type = 'stat_add', stat = 'mdef', value = 15},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Bard.png",
				description = "Bard - resilent",
				limit = 1,
				t_name = 'bard',
				combat_only = true,
			}
		],
	},
	e_bards_clean = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		conditions = [],
		req_skill = false,
		args = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			args = [],
			atomic = [{type = 'remove_effect', value = 'negative'}]
		}],
		buffs = [],
	},
	e_clean_bards = {
		type = 'oneshot',
		target = 'target',
		args = [],
		atomic = [{type = 'remove_all_effects', value = 'bard'}],
	},
	e_s_mirror = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [],
		sub_effects = ['e_clean_reflections','e_t_mirror'],
		buffs = []
	},
	e_t_mirror = {
		type = 'temp_s',
		tags = ['reflection', 'buff'],
		target = 'target',
		duration = 2,
		name = 'mirror_image',
		stack = 1,
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		buffs = ['b_mirror'],
		sub_effects = ['e_t_mirror1']
	},
	e_t_mirror1 = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['damage_type', 'neq', 'mind'] },
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
	e_s_field = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [{obj = 'parent', param = 'process_value' }],
		sub_effects = ['e_clean_reflections','e_t_field'],
		buffs = []
	},
	e_t_field = {
		type = 'temp_s',
		tags = ['reflection', 'buff'],
		target = 'target',
		duration = 2,
		name = 'energy_field',
		stack = 1,
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		buffs = ['b_field'],
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = ['e_t_field1']
	},
	e_t_field1 = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'random', value = 0.5}
		],
		req_skill = true,
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = [{
			type = 'oneshot',
			target = 'caster',
			args = [{obj = 'parent_args', param = 0}],
			atomic = [
				{type = 'sfx', value = 'targetattack'},
				{type = 'damage', value = ['parent_args', 0], source = 'air'}]
		}],
		buffs = []
	},
	e_clean_reflections = {
		type = 'oneshot',
		target = 'target',
		args = [],
		atomic = [{type = 'remove_all_effects', value = 'reflection'}],
	},
	e_t_shell = {
		type = 'temp_s',
		tags = ['buff', 'positive'],
		target = 'target',
		duration = 4,
		name = 'protective_shell',
		stack = 1,
		tick_event = variables.TR_POST_TARG,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		buffs = ['b_shell'],
		args = [],
		sub_effects = ['e_t_shell1']
	},
	e_t_shell1 = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage'] },
		],
		req_skill = true,
		args = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [{type = 'stat_mul', stat = 'value', value = 0.65}]
		}],
		buffs = []
	},
	e_s_purge = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'target',
			args = [],
			atomic = [{type = 'remove_all_effects', value = 'debuff'}],#change debuff tag to another in natural-based debuff effects
		}],
		buffs = []
	},
	e_s_elweakness = {
		type = 'temp_s',
		target = 'target',
		name = 'elweakness',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		stack = 1,
		tags = ['debuff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'resist_fire', value = -40},
			{type = 'stat_add', stat = 'resist_earth', value = -40},
			{type = 'stat_add', stat = 'resist_water', value = -40},
			{type = 'stat_add', stat = 'resist_air', value = -40},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "Resistes decreased",
				limit = 1,
				t_name = 'elweak',
				combat_only = true,
			}
		],
	},
	e_s_elprotect = {
		type = 'temp_s',
		target = 'target',
		name = 'elweakness',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		stack = 1,
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'resist_fire', value = 25},
			{type = 'stat_add', stat = 'resist_earth', value = 25},
			{type = 'stat_add', stat = 'resist_water', value = 25},
			{type = 'stat_add', stat = 'resist_air', value = 25},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "Resistes increased",
				limit = 1,
				t_name = 'elweak',
				combat_only = true,
			}
		],
	},
	e_t_camo = {
		type = 'temp_s',
		target = 'target',
		name = 'camo',
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 2,
		stack = 1,
		tags = ['buff'],
		sub_effects = [],
		atomic = [{type = 'stat_add', stat = 'evasion', value = 20}],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Fear.png",
				description = "Evasion increased",
				limit = 1,
				t_name = 'camo'
			}
		],
	},
	e_s_hmark = { #has troubles with protect effect
		type = 'temp_s',
		target = 'target',
		name = 'huntersmark',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		stack = 1,
		tags = ['debuff'],
		sub_effects = ['e_t_hmark'],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "Receives more damage",
				limit = 1,
				t_name = 'huntersmark',
				combat_only = true,
			}
		],
	},
	e_t_hmark = {
		type = 'trigger',
		conditions = [{type = 'skill', value = ['tags', 'has', 'damage']}],
		trigger = [variables.TR_DEF],
		req_skill = true,
		args = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				args = [],
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.15}],
			},
		],
		buffs = []
	},
	e_clean_taunt = {
		type = 'oneshot',
		target = 'target',
		args = [],
		atomic = [{type = 'remove_all_effects', value = 'taunt'}],
	},
	e_t_taunt = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [{obj = 'parent', param = 'caster' }],
		sub_effects = ['e_clean_taunt', 'e_s_taunt'],
		buffs = []
	},
	e_s_devour = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [{obj = 'parent', param = 'caster'}],
		sub_effects = ['e_t_devour'],
		buffs = []
	},
	e_t_devour = {
		type = 'temp_s',
		tags = ['negative'],
		target = 'target',
		name = 'devour',
		stack = 1,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		buffs = [{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "Spirit devoured",
				limit = 1,
				t_name = 'devour',
			}],
		args = [{obj = 'parent_args', param = 0, comment = 'caster'}, {obj = 'parent_arg_get', index = 0, param = 'mpmax', comment = 'casters mpmax' }],
		sub_effects = ['e_tr_devour']
	},
	e_tr_devour = {
		type = 'trigger',
		trigger = [variables.TR_DEATH],
		conditions = [],
		req_skill = false,
		args = [{obj = 'parent_args', param = 0, comment = 'caster'}, {obj = 'parent_args', param = 1, comment = 'casters mpmax'}],
		sub_effects = [{
			type = 'oneshot',
			target = 'arg',
			args = [{obj = 'parent_args', param = 0, comment = 'caster'}, {obj = 'parent_args', param = 1, comment = 'casters mpmax'}],
			atomic = [
				{type = 'mana', value = [['parent_args', 1], '*', 0.2]}
				]
		}],
		buffs = []
	},
	e_s_l_orb = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [{type = 'target', value = [{code = 'stat', stat = 'hp', operant = 'gt', value = 0}]}],
		req_skill = true,
		args = [{obj = 'parent', param = 'target'}],
		sub_effects = ['e_tr_l_orb'],
		buffs = []
	},
	e_tr_l_orb = {
		type = 'trigger',
		trigger = [variables.TR_SKILL_FINISH],
		reset = [variables.TR_TURN_GET],
		target = 'caster',
		conditions = [],
		req_skill = true,
		args = [{obj = 'parent_args', param = 0, comment = 'target'}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				args = [{obj = 'parent_args', param = 0, comment = 'target'}],
				atomic = [{type = 'use_combat_skill', skill = 'l_orb1', target = ['parent_args', 0]}]
			},
			{
				type = 'oneshot',
				target = 'self',
				execute = 'remove'
			}
		],
		buffs = []
	},
	e_clean_spirits = {
		type = 'oneshot',
		target = 'target',
		args = [],
		atomic = [{type = 'remove_all_effects', value = 'spirit'}],
	},
	e_s_spirit1 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [],
		sub_effects = ['e_clean_spirits','e_t_spirit1'],
		buffs = []
	},
	e_s_spirit2 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [],
		sub_effects = ['e_clean_spirits','e_t_spirit2'],
		buffs = []
	},
	e_s_spirit3 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [],
		sub_effects = ['e_clean_spirits','e_t_spirit3'],
		buffs = []
	},
	e_t_spirit1 = {
		type = 'temp_s',
		target = 'target',
		name = 'spirit1',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		tags = ['spirit'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'evasion', value = 25},
			{type = 'stat_add', stat = 'speed', value = 30},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "spirit - hare",
				limit = 1,
				t_name = 'spirit',
				combat_only = true,
			}
		],
	},
	e_t_spirit3 = {
		type = 'temp_s',
		target = 'target',
		name = 'spirit3',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		tags = ['spirit'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'hitrate', value = 30},
			{type = 'stat_add', stat = 'damage_mod_skill', value = 0.2},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "spirit - eagle",
				limit = 1,
				t_name = 'spirit',
				combat_only = true,
			}
		],
	},
	e_t_spirit2 = {
		type = 'temp_s',
		target = 'target',
		name = 'spirit2',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		tags = ['spirit'],
		sub_effects = ['e_t_turtle1', 'e_t_turtle2'],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "spirit - turtle",
				limit = 1,
				t_name = 'spirit',
				combat_only = true,
			}
		],
	},
	e_t_turtle1 = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['ability_type', 'eq', 'skill']}
		],
		req_skill = true,
		args = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [{type = 'stat_mul', stat = 'value', value = 0.75}]
		}],
		buffs = []
	},
	e_t_turtle2 = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['ability_type', 'eq', 'spell']}
		],
		req_skill = true,
		args = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [{type = 'stat_mul',  stat = 'value', value = 0.85}]
		}],
		buffs = []
	},
	#statuses
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
				description = "Hidden",
				t_name = 'hide'
			}
		],
		sub_effects = [],
	},
	e_t_hide2 = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_HIT, variables.TR_COMBAT_F, variables.TR_DMG],
		stack = 1,
		name = 'hide',
		tags = ['buff', 'hide'],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/icon_eyes.png",
				description = "Hidden",
				t_name = 'hide'
			}
		],
		sub_effects = [],
	},
	e_t_reincarnate = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F],
		stack = 1,
		name = 'reincarnate',
		tags = ['reincarnate'], #and all other apopriaate
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Innervate.png",
				description = "Will be reborn on death",
				t_name = 'reincarnate'
			}
		],
		sub_effects = [],
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
				description = "Magic defence decreased",
				limit = 1,
				t_name = 'holydebuff'
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
	e_s_freeze = {#no-duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_POSTDAMAGE, variables.TR_DEATH],
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
		rem_event = [variables.TR_COMBAT_F, variables.TR_POSTDAMAGE, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_S],
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
	e_s_taunt = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH, variables.TR_TAUNT_FAIL], #optional remove event
		tick_event = [variables.TR_TURN_F],
		duration = 2,
		stack = 1,
		name = 'taunt',
		tags = ['debuff', 'taunt', 'negative'],
		buffs = ['b_taunt'],
		args = [{obj = 'parent_arg_get', index = 0, param = 'id'}],
		atomic = [{type = 'stat_set_revert', stat = 'taunt', value = ['parent_args', 0]}]
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
	e_s_resto = {
		type = 'temp_s',
		target = 'target',
		name = 'resto',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['buff'],
		args = [
			{type = 'stat_add', stat = 'resist_normal', value = 20},
		],
		sub_effects = [],
		atomic = [],
		buffs = ['b_resto'],
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
		tags = ['affliction', 'negative', 'debuff'],
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
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['affliction', 'bleed'],
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
	e_s_shred = {
		type = 'temp_s',
		target = 'target',
		name = 'shred',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		tags = ['affliction'],
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
	e_tr_curseatk = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		reset = [],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['target_range', 'eq', 'melee']},
			],
		atomic = [],
		buffs = ['tr_curseatk'],
		sub_effects = ['e_s_curseatk']
	},
	e_s_curseatk = {
		type = 'temp_s',
		target = 'caster',
		name = 'curseatk',
		stack = 0,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 2,
		tags = ['affliction', 'negative', 'debuff'],
		args = [],
		sub_effects = [],
		atomic = [{type = 'stat_add_p', stat = 'atk', value = -0.25}],
		buffs = ['b_curseatk'],
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
	e_tr_fireshield = {
		type = 'static',
		tags = ['negative'],
		args = [],
		sub_effects = [
			{
				type = 'trigger',
				conditions = [{type = 'skill', value = ['damage_type', 'eq', 'water'] }],
				trigger = [variables.TR_POST_TARG],
				req_skill = true,
				sub_effects = [
					{
						type = 'oneshot',
						target = 'self',
						execute = 'remove_parent'
					}
				],
				buffs = []
			},
			{
				type = 'trigger',
				conditions = [],
				trigger = [variables.TR_TURN_GET],
				req_skill = false,
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						args = [{obj = 'app_obj'}],
						atomic = [{type = 'use_combat_skill', skill = 'pas_fireshield', target = ['parent_args', 0]}]
					}
				],
				buffs = []
			},
		],
		atomic = [],
		buffs = ['b_fireshield'],
	},
	e_atkpass = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		req_skill = false,
		conditions = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			args = [{obj = 'app_obj'}],
			atomic = [{type = 'use_combat_skill', skill = 'pas_atkpass_apply', target = ['parent_args', 0]}]
			}],
		buffs = ['b_atkpass_src']
	},
	e_s_atkpass = {
		type = 'temp_s',
		target = 'target',
		name = 'atkpass',
		stack = 0,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['positive', 'buff', 'atkpass'],
		args = [],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'atk', value = 0.1},
			{type = 'stat_add_p', stat = 'matk', value = 0.1},
			],
		buffs = ['b_atkpass'],
	},
	e_t_atkpass_remove = {
		type = 'temp_s',
		target = 'target',
		name = 'atkpass_remove',
		stack = 1,
		rem_event = [variables.TR_COMBAT_F],
		tags = [],
		args = [],
		sub_effects = ['e_tr_atkpass_remove'],
	},
	e_tr_atkpass_remove = {
		type = 'trigger',
		trigger = [variables.TR_DEATH],
		req_skill = false,
		conditions = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			args = [{obj = 'app_obj'}],
			atomic = [{type = 'use_combat_skill', skill = 'pas_atkpass_remove', target = ['parent_args', 0]}]
					}]
	},
	e_s_atkpass_remove = {
		type = 'oneshot',
		target = 'target',
		args = [],
		atomic = [{type = 'remove_all_effects', value = 'atkpass'}],
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
			description = "+50 Armor Penetration; +20%% Damage Dealt.",
			args = [],
			limit = 1,
			t_name = 'takeposition',
		}]
	},
	e_s_windwall = {
		type = 'temp_s',
		duration = 4,
		stack = 1,
		name = 'e_s_windwall',
		target = 'target',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		args = [],
		atomic = [
			{type = 'stat_add', stat = 'resist_damage_ranged', value = 0.5},
		],
		sub_effects = [],
		buffs = [{
			icon = "res://assets/images/iconsskills/windwall.png",
			description = "Reduces randged damage by 50%%",
			args = [],
			limit = 1,
			t_name = 'windwall',
		}]
	},
	#items
	e_i_shackles = {
		type = 'c_static',
		descript = 'Prevents escape if Physics Factor less than 4.',
		conditions = [{code = 'stat', stat = 'physics_factor', operant = 'lt', value = 4}],
		tags = ['recheck_stats', 'recheck_item'],
		no_escape = true,
		atomic = [],
		buffs = [],
		sub_effects = [],
	},
	e_i_shackles_obed = {
		type = 'c_static',
		descript = 'Reduce Obedience drain by 75%',
		conditions = [{code = 'stat', stat = 'physics_factor', operant = 'lt', value = 4}],
		tags = ['recheck_stats', 'recheck_item'],
		atomic = [
		{type = 'stat_mul', stat = 'obDrainReduction', value = 0.25}
		],
		buffs = [],
		sub_effects = [],
	},
	e_i_pet_suit = {
		type = 'static',
#		conditions = [],
		descript = "Obedience Drain is increased by 20%.",
		tags = ['recheck_class', 'recheck_item'], #useless
		atomic = [
		{type = 'stat_add', stat = 'obDrainIncrease', value = 0.2},
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
#		conditions = [],
		descript = "Obedience Drain -30%",
		tags = [],
		atomic = [
		{type = 'stat_mul', stat = 'obDrainReduction', value = 0.7},
		],
		buffs = [],
		sub_effects = [],
	},
	e_i_handcuffs_obed = {
		type = 'static',
#		conditions = [],
		descript = "Obedience Drain -15%",
		tags = [],
		atomic = [
		{type = 'stat_mul', stat = 'obDrainReduction', value = 0.85},
		],
		buffs = [],
		sub_effects = [],
	},
	e_worker_outfit_effect = {
		type = 'static',
#		conditions = [],
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
#		conditions = [],
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
		atomic = [{type = 'stat_mul', stat = 'obDrainReduction', value = 0.65},{type = 'stat_add_p', stat = 'authority_mod', value = 0.20}],
		descript = 'Reduces Obedience Drain by 35%. Increases Authority gain by 20%. ',
		buffs = [],
		sub_effects = [],
	},
	e_chocker_effect = {
		type = 'static',
		atomic = [{type = 'stat_mul', stat = 'obDrainReduction', value = 0.8}],
		descript = "Reduces Obedience Drain by 20%.",
		buffs = [],
		sub_effects = [],
	},
	e_steel_collar_effect = {
		type = 'static',
		atomic = [{type = 'stat_mul', stat = 'obDrainReduction', value = 0.35},{type = 'stat_add_p', stat = 'authority_mod', value = 0.35}],
		descript = 'Reduces Obedience Drain by 65%. Increases Authority gain by 35%.',
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
		conditions = [{code = 'gear_equiped', value = 'pet_suit', check = true}],
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
	e_tentacle_suit_subeffect = {
		type = 'c_static',
		conditions = [
			{code = 'trait', trait = 'deviant', check = false},
			{code = 'stat', stat = 'sex_factor', operant = 'lt', value = 5}
		],
		tags = ['recheck_trait', 'recheck_item'],
		descript = 'Reduce Physics and Wits by 25 if character has less than 5 Sex Factor and no Deviant trait.',
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



	master_combat_1 = {
		type = 'temp_s',
		target = 'target',
		name = "Master's Morale",
		tick_event = variables.TR_TICK,
		duration = 8,
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
		duration = 12,
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
		duration = 8,
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
		conditions = [{code = 'gear_equiped', param = 'geartype', value = 'spear', check = true}],
		tags = ['recheck_item'],
		atomic = [
			{type = 'stat_add', stat = 'speed', value = 10},
		],
		buffs = [],
		sub_effects = [],
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
					{type = 'stat_add', stat = 'resist_all', value = 30},
				],
				buffs = [],
				sub_effects = [],
			}
		],
		buffs = [{
			icon = "res://assets/images/iconsskills/icon_protective_shell.png",
			description = "Celena's Blessing: Reduce incoming damage by 30%%",
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
			description = "Freya's Blessing: +30 Armor Penetration, +25 Hitrate",
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
			description = "Celena's Curse: Max health is reduced by 50%%.",
			args = [],
			limit = 1,
			t_name = 'celena_curse',
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
			description = "Freya's Curse: -50 Evasion and Hit Rate.",
			args = [],
			limit = 1,
			t_name = 'freya_curse',
		}]
	},

	date_bonus = { #not used
		type = 'temp_s',
		duration = 1,
		stack = 1,
		name = 'date_bonus',
		tick_event = [variables.TR_TICK],
		args = [{obj = 'self', param = 'subm_bonus'}, {obj = 'self', param = 'loyal_bonus'}],
		sub_effects = ['t_date_bonus'],
		buffs = [{
			icon = "res://assets/images/iconsskills/Reward_with_sex 3.png",
			description = "Loyalty gain increased by %d%%. %d hours remains",
			args = [{obj = 'parent_args', param = 1},{obj = 'parent_args', param = 0}, {obj = 'parent', param = 'remains'}],
			limit = 1,
			t_name = 'date_effect',
			mansion_only = true,
		}]
	},
	t_date_bonus = { #not used
		type = 'static',
		tags = [],
		args = [{obj = 'parent_args', param = 0}, {obj = 'parent_args', param = 1}],
		atomic = [
			{type = 'stat_add_p', stat = 'loyalty_gain_mod', value = [['parent_args', 1], '*', 0.01]},
		],
		sub_effects = [],
		buffs = []
	},


	resist_state = {
		type = 'temp_s',
		duration = 6,
		stack = 1,
		name = 'resist_state',
		tick_event = [variables.TR_TICK],
		args = [],
		sub_effects = [],
		tags = ['no_obed_gain'],
		buffs = [{
			icon = "res://assets/images/iconsskills/Shackle.png",
			description = "Resist state: Can't gain obedience from positive abilities. Can't use exploration skills. Positive actions during dates less effective.",
			args = [],
			limit = 1,
			t_name = 'resist_state',
		}]
	},
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
			description = "Is pregnant. Speed -10, Physics Bonus -20",
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
			description = "Is heavily pregnant. Speed -20, Physics Bonus -40",
			args = [],
			limit = 1,
			t_name = 'preg',
		}]
	},
	e_brand = {
		type = 'static',
		atomic = [{type = 'stat_mul', stat = 'obDrainReduction', value = 0.75}],
		buffs = [],
		sub_effects = [],
	},
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
	a_shackles = {type = 'stat_add', stat = 'timid_factor', value = 2},
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
	a_bleed = {type = 'damage', source = 'true', value = [['parent_args', 0], '*', 0.25]},
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
	b_charm_c = {
		icon = "res://assets/images/iconsskills/Charm.png", #?? mb to fix
		description = "Charmed",
		limit = 1,
		t_name = 'charm'
	},
	b_trap = {
		icon = "res://assets/images/traits/hitrate.png",
		description = "Trapped",
		limit = 1,
		t_name = 'trap'
	},
	b_mirror = {
		icon = "res://assets/images/traits/hitrate.png",
		description = "Mirror image - chance to evade damage from skills",
		limit = 1,
		t_name = 'mirror'
	},
	b_field= {
		icon = "res://assets/images/iconsskills/Barrier.png",
		description = "Energy field - chance to deal Air Spell damage to attacker",
		limit = 1,
		t_name = 'field'
	},
	b_shell= {
		icon = "res://assets/images/traits/hitrate.png",
		description = "Protective shell",
		limit = 1,
		t_name = 'shell'
	},
	b_taunt= {
		icon = "res://assets/images/traits/hitrate.png",
		description = "Taunted",
		limit = 1,
		t_name = 'taunt'
	},
	b_distract = {
		icon = "res://assets/images/iconsskills/distract.png",
		description = "Hitrate and Evasion reduced",
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
		description = "Disarmed: Can't use Skill type abilities",
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
		icon = "res://assets/images/iconsclasses/Attendant.png",
		description = "Allows to use an item without taking a turn",
		t_name = 'freuse',
		combat_only = true
	},
	b_shred = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "Armor reduced",
		t_name = 'shred',
		combat_only = true
	},
	b_growl = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "Speed and evasion decreased",
		t_name = 'shrgrowled',
		combat_only = true
	},
	b_curseatk = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "Attack decreased",
		t_name = 'curseatk',
		combat_only = true
	},
	tr_curseatk = {
		icon = "res://assets/images/iconsskills/icon_turtle.png",
		description = "Attacking this target cause atk decreased",
		t_name = 'curseatk_src',
	},
	b_magicward = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "Attack and mdef increased",
		t_name = 'magicward',
		combat_only = true
	},
	b_slam = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "Healing reduced",
		t_name = 'slam',
		combat_only = true
	},
	b_fireshield = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "Fire shield",
		t_name = 'fireshield',
		combat_only = true
	},
	b_atkpass = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "Damage increased",
		t_name = 'atkpass',
		limit = -1,
		combat_only = true
	},
	b_atkpass_src = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "Increases ATK and MATK of allies by 10 every other turn. Clear when defeated.",
		t_name = 'atkpass_s',
		limit = 1,
		combat_only = true
	},
	b_resto= {
		icon = "res://assets/images/traits/hitrate.png",
		description = "Incoming damage reduced",
		limit = 1,
		t_name = 'resto'
	},
	b_factor_maxed = {
		icon = "res://assets/images/iconsskills/Authority.png",
		description = "",
		limit = 1,
		t_name = 'b_factor_maxed',
		mansion_only = true
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


func rebuild_skillvalue_template(args):
	var trigger = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_HIT],
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
	if args.has('value'): #shold be always true - for without it this makes no sence
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
	
	return trigger
