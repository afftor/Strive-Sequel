extends Node
var effects = {
	gobmetalhandle = {
		descript = tr("GOBMETALHANDLEDESCRIPT"), 
		code = 'gobmetalhandle', 
		textcolor = 'yellow', 
		effects = ['e_w_gobmet_h']
	},
	elfmetalhandle = {
		descript = tr("ELFMETALHANDLEDESCRIPT"), 
		code = 'elfmetalhandle', 
		textcolor = 'yellow', 
		effects = ['e_w_elfmet_h']
	},
	gobmetalblade = {
		descript = tr("GOBMETALBLADEDESCRIPT"), 
		code = 'gobmetalblade', 
		textcolor = 'yellow', 
		effects = ['e_w_gobmet_bl']
	},
	elfmetalblade = {
		descript = tr("ELFMETALBLADEDESCRIPT"), 
		code = 'elfmetalblade', 
		textcolor = 'yellow', 
		effects = ['e_w_elfmet_bl']
	},
	elfwoodrod = {
		descript = tr("ELFWOODRODDESCRIPT"), 
		code = 'elfwoodrod', 
		textcolor = 'yellow', 
		effects = ['e_w_elfw_r']
	},
	gobmetalrod = {
		descript = tr("GOBMETALRODDESCRIPT"), 
		code = 'gobmetalrod', 
		textcolor = 'yellow', 
		effects = ['e_tr_gobmet_r']
	},
	bonerod = {
		descript = tr("BONERODDESCRIPT"), 
		code = 'bonerod', 
		textcolor = 'yellow', 
		effects = ['e_w_bone_r'],
	},
	bonebow = {
		descript = tr("BONEBOWDESCRIPT"), 
		code = 'bonebow', 
		textcolor = 'yellow', 
		effects = ['e_w_bone_b']
	},

	axe = {#to complete??
		name = tr("BRITTLE"), 
		code = 'axe', 
		descript = tr(""), 
		textcolor = 'gray', 
		effects = ['e_w_dmgtreant','e_w_dmgbigtreant']
	},
	pick = {#to complete??
		name = tr("BRITTLE"), 
		code = 'pick', 
		descript = tr(""), 
		textcolor = 'gray', 
		effects = ['e_w_dmggolem','e_w_dmgbiggolem']
	},
}

var effect_table = {
	#traits
	e_tr_dmgbeast = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'target', value = {type = 'race', value = 'animal' } }
		],
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.2}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	e_tr_nodmgbeast = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'caster', value = {type = 'race', value = 'animal' } }
		],
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 0.8}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	e_tr_fastlearn = { #no icon for buff as this is the only effect of trait. can add if reqired
		type = 'static',
		atomic = [{type = 'stat_add', stat = 'xpmod', value = 0.15}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_hitrate = {#no icon for buff as this is the only effect of trait. can add if reqired
		type = 'static',
		atomic = [{type = 'stat_add', stat = 'hitrate', value = 10}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_ev10 = {#no icon for buff as this is the only effect of trait. can add if reqired
		type = 'static',
		atomic = [{type = 'stat_add', stat = 'evasion', value = 10}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_ev15 = {#no icon for buff as this is the only effect of trait. can add if reqired
		type = 'static',
		atomic = [{type = 'stat_add', stat = 'evasion', value = 15}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_crit = {#no icon for buff as this is the only effect of trait. can add if reqired
		type = 'static',
		atomic = [{type = 'stat_add', stat = 'critchance', value = 10}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_resist = {#no icon for buff as this is the only effect of trait. can add if reqired
		type = 'static',
		atomic = [
			{type = 'stat_add', stat = 'resistfire', value = 10},
			{type = 'stat_add', stat = 'resistair', value = 10},
			{type = 'stat_add', stat = 'resistwater', value = 10},
			{type = 'stat_add', stat = 'resistearth', value = 10},
		],
		buffs = [],
		sub_effects = [],
	},
	e_tr_armor = {#no icon for buff as this is the only effect of trait. can add if reqired
		type = 'static',
		atomic = [{type = 'stat_add', stat = 'armor', value = 5}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_hpmax = {#no icon for buff as this is the only effect of trait. can add if reqired
		type = 'static',
		atomic = [{type = 'stat_add', stat = 'hpmax', value = 25}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_speed = {#no icon for buff as this is the only effect of trait. version with icon exists too
		type = 'static',
		atomic = [{type = 'stat_add', stat = 'speed', value = 10}],
		buffs = [],
		sub_effects = [],
	},
	e_tr_regen = {#no icon for buff as this is the only effect of trait. can add if reqired
		type = 'trigger',
		req_skill = false,
		trigger = [variables.TR_TURN_F],
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'stat_add', stat = 'hppercent', value = 5}],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
	e_tr_noevade = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		sub_effects = ['e_t_noevade10'],
		atomic = [],
		buffs = [],
	},
	e_t_noevade10 = {
		type = 'temp_s',
		target = 'target',
		name = 'noevade10',
		tags = ['neg_state'],
		tick_event = variables.TR_TURN_S,
		rem_event = variables.TR_COMBAT_F,
		duration = 2,
		stack = 1,
		sub_effects = [],
		atomic = [{type = 'stat_add', stat = 'evasion', value = -10}],
		buffs = [
			{
				icon = "res://assets/images/traits/dodgedebuff.png", 
				description = "Evasion reduced for %d turns",
				args = [{obj = 'parent', param = 'remains', dynamic = true}],
				t_name = 'eva10'
			}
		],
	},
	e_tr_prot_a = {
		type = 'static',
		atomic = [],
		buffs = [
			{#for testing purpose
				icon = "res://assets/images/traits/armorgroup.png", 
				description = "This unit owns area protection effect",
				t_name = 'areaprot1'
			}
		],
		sub_effects = ['e_tr_areaprot'],
	},
	e_tr_areaprot = {
		type = 'area',
		area = 'back',
		atomic = [{type = 'stat_add', stat = 'armor', value = 10}],
		buffs = [
			{#for testing purpose
				icon = "res://assets/images/traits/armorgroup.png", 
				description = "This unit's armor is increased by area effect ",
				t_name = 'areaprot2'
			}
		],
		sub_effects = [],
	},
	e_tr_healer = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [{type = 'skill', value = ['tags', 'has', 'type_heal']}],
		args = [{obj = 'self', param = 'skill'}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				args = [{obj = 'parent_args', param = 0}],
				atomic = ['a_caster_heal'],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
	e_tr_react = {
		type = 'trigger',
		req_skill = false,
		trigger = [variables.TR_DMG],
		conditions = [],
		sub_effects = ['e_t_react'],
		buffs = [],
	},
	e_t_react = {
		type = 'temp_s',
		target = 'owner',
		name = 'react20',
		tags = ['pos_state'],
		tick_event = variables.TR_TURN_S,
		rem_event = variables.TR_COMBAT_F,
		duration = 2,
		stack = 1,
		sub_effects = [],
		atomic = [{type = 'stat_add', stat = 'speed', value = 20}],
		buffs = [
			{
				icon = "res://assets/images/traits/speedondamage.png", 
				description = "Speed increased for %d turns",
				args = [{obj = 'parent', param = 'remains'}],
				t_name = 'react'
			}
		],
	},
	e_tr_magecrit = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		reset = [variables.TR_CAST],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_CRIT]}],
		args = [{obj = 'self', param = 'skill'}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				args = [{obj = 'parent_args', param = 0}],
				atomic = ['a_magecrit'],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
	e_tr_slowarrow = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		req_skill = true,
		sub_effects = ['e_t_slowarrow'],
		buffs = []
	},
	e_t_slowarrow = {
		type = 'temp_s',
		target = 'target',
		name = 'slowarrow',
		tick_event = variables.TR_TURN_S,
		rem_event = variables.TR_COMBAT_F,
		duration = 2,
		stack = 2,
		tags = ['natural_debuf'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'speed', value = -10},
			{type = 'stat_add', stat = 'evasion', value = -10}
		],
		buffs = [
			{
				icon = "res://assets/images/traits/speeddebuf.png", 
				description = "Speed and evasion reduced",
				limit = 1,
				t_name = 'slowarrow'
			}
		],
	},
	e_tr_killer = {
		type = 'trigger',
		req_skill = false,
		trigger = [variables.TR_KILL],
		reset = [variables.TR_CAST],
		conditions = [],
		sub_effects = ['e_t_killer'],
		buffs = []
	},
	e_t_killer = {
		target = 'owner',
		type = 'temp_s',
		template_name = 'killerbuf',
		sub_effects = ['e_t_killer2'],
		stack = 1,
		rem_event = variables.TR_COMBAT_F,
		buffs = [
			{
				icon = "res://assets/images/traits/bowextradamage.png", 
				description = "This unit's next attack will do double damage to its first target",
				t_name = 'killerbuf'
			}
		],
	},
	e_t_killer2 = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_HIT],
		reset = [variables.TR_CAST],
		ready = false,#for the reason not to trigger on the same area attack as initial kill
		conditions = [{type = 'skill', value = ['skilltype', 'eq', 'skill']}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 2}],
				buffs = [],
				sub_effects = []
			},
			{
				type = 'oneshot',
				target = 'self',
				execete = 'remove_parent'
			}
		]
	},
	e_tr_rangecrit = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_HIT],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_CRIT]}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_set', stat = 'armor_p', value = 10000}],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
	e_tr_speed_a = {
		type = 'static',
		atomic = [],
		buffs = [
			{#for testing purpose
				icon = "res://assets/images/traits/dodgegroup.png", 
				description = "This unit owns area speed increasing effect",
				t_name = 'areaspeed1'
			}
		],
		sub_effects = ['e_tr_areaspeed'],
	},
	e_tr_areaspeed = {
		type = 'area',
		area = 'line',
		atomic = [{type = 'stat_add', stat = 'speed', value = 10}],#i'm still confused if this buff should increase speed or evasion....
		buffs = [
			{#for testing purpose
				icon = "res://assets/images/traits/dodgegroup.png", 
				description = "This unit's speed is increased by area effect ",
				t_name = 'areaspeed2'
			}
		],
		sub_effects = [],
	},
	e_tr_noresist = {
		type = 'trigger',
		conditions = [],
		trigger = [variables.TR_HIT],
		req_skill = true,
		sub_effects = ['e_t_noresist'],
		buffs = []
	},
	e_t_noresist = {
		type = 'temp_s',
		target = 'target',
		name = 'noresist',
		tags = ['curse'],
		tick_event = variables.TR_TURN_S,
		rem_event = variables.TR_COMBAT_F,
		duration = 1,
		stack = 1,
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'resistfire', value = -15},
			{type = 'stat_add', stat = 'resistair', value = -15},
			{type = 'stat_add', stat = 'resistwater', value = -15},
			{type = 'stat_add', stat = 'resistearth', value = -15},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/resistdebuf.png", 
				description = "All resistances reduced",
				limit = 1,
				t_name = 'noresist'
			}
		],
	},
	e_tr_firefist = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		args = [{obj = 'self', param = 'skill'}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				args = [{obj = 'parent_args', param = 0}],
				atomic = ['a_firefist'],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
	e_tr_necro = {
		type = 'static',
		sub_effects = ['e_tr_necro_clean'],
		atomic = ['a_souls1', 'a_souls2'],
		buffs = ['b_souls'],
		args = [{obj = 'app_obj', param = 'alt_mana', dynamic = true}]
	},
	e_tr_necro_clean = {
		type = 'trigger',
		req_skill = false,
		trigger = [variables.TR_COMBAT_F],
		conditions = [],
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [
					{type = 'stat_set', stat = 'alt_mana', value = 0}
				],
				buffs = [],
				sub_effects = []
			}
		]
	},
	#monstertraits
	e_tr_elheal = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		req_skill = false,
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'heal', stat = 'hp', value = 20}],
				sub_effects = []
			}
		]
	},
	e_tr_dwarwenbuf = {#pattern for buffs with limited but not defined duration
		type = 'trigger',
		conditions = [],
		trigger = [variables.TR_DMG],
		req_skill = false,
		sub_effects = ['e_t_dwarwenbuf'],
		buffs = []
	},
	e_t_dwarwenbuf = {
		type = 'temp_s',
		target = 'owner',
		name = 'dwarvenbuf',
		rem_event = variables.TR_COMBAT_F,
		stack = 0,
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'damage', value = 5},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/beastdamage.png", 
				description = "Damage increased",
				limit = 1,
				t_name = 'dwarwenbuf'
			}
		],
	},
	e_tr_treant_barrier = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		req_skill = false,
		conditions = [],
		sub_effects = [
			{
				type = 'temp_s',
				target = 'owner',
				tick_event = variables.TR_TURN_GET,
				rem_event = [variables.TR_SHIELD_DOWN,variables.TR_COMBAT_F],
				duration = 1,
				stack = 1,
				name = 'treant_shield',
				atomic = [
					{type = 'stat_set_revert', stat = 'shield', value = 15},
					{type = 'stat_set_revert', stat = 'shieldtype', value = variables.S_PHYS}
					],
				buffs = [
					{
						icon = "res://assets/images/traits/armor.png", 
						description = "Damage-absorbing shield, blocks 15 phys damage, recreates every turn",
						limit = 1,
						t_name = 'treant_shield'
					}
				],
				sub_effects = [],
			}
		],
		buffs = []
	},
	#skills
	e_s_stun05 = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'random', value = 0.5}
		],
		buffs = [],
		sub_effects = ['e_stun']
	},
	e_s_stun = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
		],
		buffs = [],
		sub_effects = ['e_stun']
	},
	e_stun = {
		type = 'temp_s',
		target = 'target',
		stack = 1,
		rem_event = [variables.TR_COMBAT_F, variables.TR_TURN_F],
		name = 'stun',
		tags = ['afflict'],
		disable = true,
		sub_effects = [],
		buffs = ['b_stun'],
		atomic = [],
	},
	e_stun_alternate = { #template that can reset duration, no difference for one-turn effects but is an example for longer effects 
		type = 'temp_s',
		target = 'target',
		stack = 1,
		tick_event = [variables.TR_TURN_GET],
		duration = 2,
		rem_event = [variables.TR_COMBAT_F],
		name = 'stun',
		disable = true,
		sub_effects = [],
		atomic = [],
		buffs = ['b_stun']
	},
	e_s_cripple = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
		],
		buffs = [],
		sub_effects = ['e_cripple']
	},
	e_cripple = {
		type = 'temp_s',
		target = 'target',
		stack = 1,
		tick_event = [variables.TR_TURN_F],
		duration = 3,
		rem_event = [variables.TR_COMBAT_F],
		name = 'cripple',
		tags = ['afflict'],
		sub_effects = [],
		atomic = [{type = 'stat_add', stat = 'damagemod', value = -0.33}],
		buffs = [
			{
				icon = "res://assets/images/traits/speeddebuf.png", 
				description = "Damage reduced for %d turns",
				args = [{obj = 'parent', param = 'remains'}],
				t_name = 'cripple'
			}
		]
	},
	e_s_spidernoarmor = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
		],
		buffs = [],
		sub_effects = ['e_spider_noarmor']
	},
	e_spider_noarmor = {
		type = 'temp_s',
		target = 'target',
		tick_event = [variables.TR_TURN_S],
		duration = 2,
		stack = 0,
		rem_event = [variables.TR_COMBAT_F],
		name = 'sp_noarm',
		tags = ['natural_debuf'],
		sub_effects = [],
		atomic = [{type = 'stat_add', stat = 'armor', value = -10}],
		buffs = [
			{
				icon = "res://assets/images/traits/armorignore.png", 
				description = "Armor reduced",
				limit = 1,
				t_name = 'sp_noarm'
			}
		]
	},
	e_s_taunt = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		sub_effects = ['e_taunt'],
		buffs = []
	},
	e_taunt = {
		type = 'temp_s',
		target = 'target',
		stack = 1,
		rem_event = [variables.TR_COMBAT_F, variables.TR_TURN_F],
		name = 'taunt',
		disable = true,
		tags = ['afflict'],
		sub_effects = [],
		atomic = [{type = 'stat_add', stat = 'damagemod', value = -0.25}],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/taunt.png", 
				description = "This unit is taunted and must attack next turn",
				limit = 1,
				t_name = 'taunt'
			}
		]
	},
	e_s_quake = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		req_skill = true,
		sub_effects = ['e_t_quake'],
		buffs = []
	},
	e_t_quake = {
		type = 'temp_s',
		target = 'target',
		name = 'earthquake',
		tick_event = variables.TR_TURN_S,
		rem_event = variables.TR_COMBAT_F,
		duration = 2,
		stack = 1,
		tags = ['natural_debuf'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'speed', value = -20},
			{type = 'stat_add', stat = 'evasion', value = -20}
		],
		buffs = [
			{
				icon = "res://assets/images/traits/speeddebuf.png", 
				description = "Speed and evasion reduced",
				limit = 1,
				t_name = 'earthquake'
			}
		],
	},
	e_s_wwalk = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		req_skill = true,
		sub_effects = ['e_t_wwalk'],
		buffs = []
	},
	e_t_wwalk = {
		type = 'temp_s',
		target = 'target',
		name = 'wwalk',
		tick_event = variables.TR_TURN_S,
		rem_event = variables.TR_COMBAT_F,
		duration = 3,
		stack = 1,
		tags = ['bless'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'speed', value = 15},
			{type = 'stat_add', stat = 'hitrate', value = 25},
			{type = 'stat_add', stat = 'evasion', value = 25}
		],
		buffs = ['b_wwalk'],
	},
	e_s_nbless = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		req_skill = true,
		sub_effects = ['e_t_nbless'],
		buffs = []
	},
	e_t_nbless = {
		type = 'temp_s',
		target = 'target',
		name = 'wwalk',
		tick_event = variables.TR_TURN_F,
		rem_event = variables.TR_COMBAT_F,
		duration = 3,
		stack = 1,
		tags = ['bless'],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_TURN_GET],
				conditions = [],
				req_skill = false,
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						atomic = [{type = 'stat_add', stat = 'hppercent', value = 20}],
						sub_effects = []
					}
				],
				buffs = []
			}
		],
		atomic = [],
		buffs = ['b_nbless'],
	},
	e_s_bcry = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		req_skill = true,
		sub_effects = ['e_t_bcry'],
		buffs = []
	},
	e_t_bcry = {
		type = 'temp_s',
		target = 'target',
		name = 'battlecry',
		tick_event = variables.TR_TURN_S,
		rem_event = variables.TR_COMBAT_F,
		duration = 3,
		stack = 1,
		tags = ['bless'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'damagemod', value = 0.2}
		],
		buffs = [
			{
				icon = "res://assets/images/traits/speeddebuf.png", #TO FIX
				description = "Damage increased",
				limit = 1,
				t_name = 'battlecry'
			},
		],
	},
	e_s_execute = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_KILL],
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				args = [{obj = 'app_obj', param = 'hpmax', dynamic = true}, {obj = 'app_obj', param = 'manamax', dynamic = true}],
				atomic = ['a_hp_restore_ex','a_mana_restore_ex'],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
	#as like all shield effects this is not a final version
	e_s_ward = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [],
		args = [{obj = 'self', param = 'skill'}],
		sub_effects = [
			{
				type = 'temp_s',
				target = 'target',
				tick_event = variables.TR_TURN_GET,
				rem_event = [variables.TR_SHIELD_DOWN,variables.TR_COMBAT_F],
				duration = 3,
				stack = 1,
				name = 'ward',
				atomic = [
					'a_ward_shield',
					{type = 'stat_set_revert', stat = 'shieldtype', value = variables.S_FULL}
					],
				args = [{obj = 'app_obj', param = 'shield', dynamic = true},{obj = 'parent_arg_get', index = 0, param = 'process_value'}],
				buffs = [
					{
						icon = "res://assets/images/traits/armor.png", 
						description = "Damage-absorbing shield (%d remains)",
						args = [{obj = 'parent_args', param = 0}],
						t_name = 'ward'
					}
				],
				sub_effects = [],
			}
		],
		buffs = []
	},
	e_s_bless = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		req_skill = true,
		sub_effects = ['e_t_bless'],
		buffs = []
	},
	e_t_bless = {
		type = 'temp_s',
		target = 'target',
		name = 'bless',
		tick_event = variables.TR_TURN_S,
		rem_event = variables.TR_COMBAT_F,
		duration = 4,
		stack = 1,
		tags = ['bless'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'damade', value = 10},
			{type = 'stat_add', stat = 'armor', value = 10},
			{type = 'stat_add', stat = 'mdef', value = 10},
			{type = 'stat_add', stat = 'speed', value = 10},
			{type = 'stat_add', stat = 'hitrate', value = 10},
			{type = 'stat_add', stat = 'evasion', value = 10},
			{type = 'stat_add', stat = 'armorpenetration', value = 10}
		],
		buffs = [
			{
				icon = "res://assets/images/traits/speeddebuf.png", #TO FIX
				description = "Stats increased",
				limit = 1,
				t_name = 'bless'
			}
		],
	},
	e_s_sanctuary = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		req_skill = true,
		args = [{obj = 'self', param = 'skill'}],
		sub_effects = ['e_t_sanctuary'],
		buffs = []
	},
	e_t_sanctuary = {
		type = 'temp_s',
		target = 'target',
		name = 'sanctuary',
		tick_event = variables.TR_TURN_F,
		rem_event = variables.TR_COMBAT_F,
		duration = 4,
		stack = 1,
		tags = ['bless'],
		args = [{obj = 'parent_arg_get', index = 0, param = 'process_value'}],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_TURN_GET],
				conditions = [],
				req_skill = false,
				args = [{obj = 'parent_args', param = 0}],
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						args = [{obj = 'parent_args', param = 0}],
						atomic = ['a_sanctuary_heal'],
						sub_effects = []
					}
				],
				buffs = []
			}
		],
		atomic = [],
		buffs = ['b_sanct'],
	},
	e_s_wave = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		req_skill = true,
		sub_effects = ['e_t_wave'],
		buffs = []
	},
	e_t_wave = {
		type = 'temp_s',
		target = 'target',
		name = 'wave',
		tick_event = variables.TR_TURN_F,
		rem_event = variables.TR_COMBAT_F,
		duration = 2,
		stack = 1,
		tags = ['natural_debuf'],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_DEF],
				conditions = [
					{type = 'skill', value = ['damagesrc','eq',variables.S_AIR] },
					{type = 'skill', value = ['hit_res','mask',variables.RES_HITCRIT] }
				],
				req_skill = true,
				sub_effects = [
					{
						type = 'oneshot',
						target = 'skill',
						atomic = [{type = 'stat_mul', stat = 'value', value = 2.0}],
						sub_effects = []
					},
					{
						type = 'oneshot',
						target = 'self',
						execute = 'remove_parent'
					}
				],
				buffs = []
			}
		],
		atomic = [],
		buffs = ['b_wave'],
	},
	e_s_spiritshield = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [],
		sub_effects = [
			{
				type = 'temp_s',
				target = 'target',
				tick_event = variables.TR_TURN_GET,
				rem_event = [variables.TR_SHIELD_DOWN, variables.TR_COMBAT_F],
				duration = 3,
				stack = 1,
				name = 'spirit_shield',
				atomic = [
					{type = 'stat_set_revert', stat = 'shield', value = 50},
					{type = 'stat_set_revert', stat = 'shieldtype', value = variables.S_FULL}
					],
				args = [{obj = 'app_obj', param = 'shield', dynamic = true}],
				buffs = [
					{
						icon = "res://assets/images/traits/armor.png", 
						description = "Damage-absorbing shield, blocks 50 damage (%d remains)",
						args = [{obj = 'parent_args', param = 0}],
						t_name = 's_shield'
					}
				],
				sub_effects = [],
			}
		],
		buffs = []
	},
	e_s_drain_kill = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_KILL],
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				atomic = [{type = 'stat_add', stat = 'alt_mana', value = 3}],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
	e_s_drain_crit = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_CRIT]}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				atomic = [{type = 'stat_add', stat = 'alt_mana', value = 1}],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
	e_cost1 = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_SKILL_FINISH],
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				atomic = [{type = 'stat_add', stat = 'alt_mana', value = -1}],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
	e_cost3 = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_SKILL_FINISH],
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				atomic = [{type = 'stat_add', stat = 'alt_mana', value = -3}],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
	e_s_implosion = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [],
		atomic = [],
		buffs = [],
		args = [{obj = 'parent', param = 'target'}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				args = [{obj = 'parent_arg_get', index = 0, param = 'armor'}],
				atomic = [{type = 'stat_add', stat = 'value', value = ['parent_args', 0]}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	e_s_explosion = {
		type = 'trigger',
		trigger = [variables.TR_CAST],
		req_skill = true,
		conditions = [],
		atomic = [],
		buffs = [],
		args = [{obj = 'parent', param = 'caster', dynamic = true}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				args = [{obj = 'parent_arg_get', index = 0, param = 'alt_mana'}],
				atomic = [{type = 'stat_mul', stat = 'value', value = [['parent_args', 0],'+',1]}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	#weapon
	e_w_gobmet_h = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'target', value = {type = 'stats', name = 'hppercent', operant = 'lte', value = 25} }
		],
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.15}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	e_w_elfmet_h = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_HIT],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				atomic = [{type = 'mana', value = 1}],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
	e_w_bone_b = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_HIT],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				atomic = [{type = 'heal', value = 1}],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
	e_w_gobmet_bl = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['skilltype', 'eq', 'skill']}# need to add this check to most of weapon effects
		],
		args = [{obj = 'app_obj', param = 'level', dynamic = true}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				args = [{obj = 'parent_args', param = 0}],
				atomic = ['a_gobmet_blade'],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
	e_w_elfmet_bl = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_HIT],
		conditions = [{type = 'target', value = {type = 'stats', name = 'hppercent', operant = 'gte', value = 100} }],
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_add', stat = 'value', value = 10}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	e_w_elfw_r = {
		type = 'trigger',
		req_skill = false,
		trigger = [variables.TR_COMBAT_F],
		conditions = [],
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = [{obj = 'app_obj',param = 'manamax'}],
				atomic = ['a_elvenwood_rod'],
				buffs = [],
				sub_effects = []
			}
		]
	},
	e_w_gobmet_r = {
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		sub_effects = ['e_taunt'],
		buffs = ['e_gobmet_rod']
	},
	e_gobmet_rod = {
		type = 'temp_s',
		target = 'target',
		tick_event = [variables.TR_TURN_S],
		rem_event = [variables.TR_COMBAT_F],
		duration = 1,
		stack = 1,
		name = 'gobmet_rod',
		tags = ['curse'],
		atomic = [{type = 'stat_add', stat = 'speed', value = -10}],
		buffs = [ #no icon
#			{
#				icon = load(""), 
#				description = "Speed reduced",
#				limit = 1,
#				t_name = 'gobmet_rod'
#			}
		]
	},
	e_w_bone_r = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_HIT],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				atomic = [{type = 'stat_add', stat = 'hppercent', value = 3}],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
	e_w_dmgtreant = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['skilltype', 'eq', 'skill']},
			{type = 'target', value = {type = 'stats', name = 'base', operant = 'eq', value = 'treant' } }
		],
		buffs = [],
		sub_effects = ['e_autocrit']
	},
	e_w_dmgbigtreant = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['skilltype', 'eq', 'skill']},
			{type = 'target', value = {type = 'stats', name = 'base', operant = 'eq', value = 'bigtreant' } }
		],
		buffs = [],
		sub_effects = ['e_autocrit']
	},
	e_w_dmggolem = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['skilltype', 'eq', 'skill']},
			{type = 'target', value = {type = 'stats', name = 'base', operant = 'eq', value = 'earthgolem' } }
		],
		buffs = [],
		sub_effects = ['e_autocrit']
	},
	e_w_dmgbiggolem = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{target = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{target = 'skill', value = ['skilltype', 'eq', 'skill']},
			{target = 'target', value = {type = 'stats', name = 'base', operant = 'eq', value = 'earthgolemboss' } }
		],
		buffs = [],
		sub_effects = ['e_autocrit']
	},
	e_autocrit = {
		type = 'oneshot',
		target = 'skill',
		atomic = [{type = 'stat_set', stat = 'hit_res', value = variables.RES_CRIT}],
		buffs = [],
		sub_effects = []
	},
	#item skills
	#those two barrier effects need fixing cause they for some reason do not work correctly in case of applying to one target 
	e_i_barrier2 = {
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
				duration = 2,
				stack = 1,
				name = 'phys_shield',
				atomic = [
					{type = 'stat_set_revert', stat = 'shield', value = 50},
					{type = 'stat_set_revert', stat = 'shieldtype', value = variables.S_PHYS}
					],
				args = [{obj = 'app_obj', param = 'shield', dynamic = true}],
				buffs = [
					{
						icon = "res://assets/images/traits/armor.png", 
						description = "Damage-absorbing shield, blocks 50 phys damage (%d remains)",
						args = [{obj = 'parent_args', param = 0}],
						t_name = 'i_shield'
					}
				],
				sub_effects = [],
			}
		],
		buffs = []
	},
	e_i_barrier3 = {
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
				duration = 2,
				stack = 1,
				name = 'mag_shield',
				atomic = [
					{type = 'stat_set_revert', stat = 'shield', value = 50},
					{type = 'stat_set_revert', stat = 'shieldtype', value = variables.S_MAG}
					],
				args = [{obj = 'app_obj', param = 'shield', dynamic = true}],
				buffs = [
					{
						icon = "res://assets/images/traits/armor.png", 
						description = "Damage-absorbing shield, blocks 50 magic damage (%d remains)",
						args = [{obj = 'parent_args', param = 0}],
						t_name = 'i_shield'
					}
				],
				sub_effects = [],
			}
		],
		buffs = []
	},
#	e_i_barrier2 = {
#		type = 'oneshot',
#		trigger = variables.TR_HIT,
#		conditions = [],
#		effects = [{target = 'target', type = 'temp_effect', effect = 'e_addbarrier2', duration = 2, stack = 1}]
#	},
#	e_i_barrier3 = {
#		type = 'oneshot',
#		trigger = variables.TR_HIT,
#		conditions = [],
#		effects = [{target = 'target', type = 'temp_effect', effect = 'e_addbarrier3', duration = 2, stack = 1}]
#	},
};

var atomic = {
	#new part
	a_caster_heal = {type = 'heal', value = [['parent_arg_get', 0, 'process_value'], '*', 0.5]},
	a_magecrit = {type = 'mana', value = ['parent_arg_get', 0, 'manacost']},
	a_firefist = {type = 'damage', value = [['parent_arg_get', 0, 'process_value'], '*', 0.2], source = variables.S_FIRE},
	a_gobmet_blade = {type = 'damage', source = variables.S_EARTH, value = ['parent_args', 0]},
	a_elvenwood_rod = {type = 'mana', value = [['parent_args', 0], '*', 0.1]},
	#not used new part (allows to setup stat changing with effect's template)
	a_stat_add = {type = 'stat_add', stat = ['parent_args', 0], value = ['parent_args', 1]},
	a_hp_restore_ex = {type = 'heal', value = [['parent_args', 0], '*', 0.2]},#can be made as stat_add to hppercent
	a_mana_restore_ex = {type = 'mana', value = [['parent_args', 1], '*', 0.2]},
	a_ward_shield = {type = 'stat_set_revert', stat = 'shield', value = ['parent_args', 1]},
	a_sanctuary_heal = {type = 'heal', value = ['parent_args', 0]},
	a_souls1 = {type = 'stat_add', stat = 'damage', value = [['parent_args', 0],'*',5]},
	a_souls2 = {type = 'stat_add', stat = 'armor', value = [['parent_args', 0],'*',5]},
};
#needs filling
var buffs = {
	#new part
	#icons are defined by path or by name in images.icons, do not load images here!
	b_stun = {
		icon = "res://assets/images/traits/experience.png", #?? mb to fix
		description = "Stunned",
		limit = 1,
		t_name = 'stun'
	},
	b_wwalk = {
		icon = "res://assets/images/traits/speeddebuf.png", #TO FIX
		description = "Stats increased",
		limit = 1,
		t_name = 'wwalk'
	},
	b_nbless = {
		icon = "res://assets/images/traits/speeddebuf.png", #TO FIX
		description = "Regenerates HP every turn",
		limit = 1,
		t_name = 'nbless'
	},
	b_sanct = {
		icon = "res://assets/images/traits/speeddebuf.png", #TO FIX
		description = "Regenerates HP every turn",
		limit = 1,
		t_name = 'sanctuary'
	},
	b_wave = {
		icon = "res://assets/images/traits/speeddebuf.png", #TO FIX
		description = "Damage from next air-based skill is doubled",
		limit = 1,
		t_name = 'wave'
	},
	b_souls = {
		icon = "res://assets/images/traits/speedondamage.png", #to fix
		description = "Has %d souls",
		args = [{obj = 'parent_args', param = 0}],
		t_name = 'souls',
		limit = 0
	}
	#code = {icon, description}
#	stun = {icon = load("res://assets/images/traits/experience.png"), description = "Stunned"},
#	noevade = {icon = load("res://assets/images/traits/dodgedebuff.png"), description = "Evasion Reduced"},
#	prot10 = {icon = null, description = null},
#	area_prot = {icon = null, description = null}, #marks owner of area protection effect
#	react = {icon = load("res://assets/images/traits/speedondamage.png"), description = "Speed Increased"},
#	slowarrow = {icon = load("res://assets/images/traits/dodgedebuff.png"), description = "Speed and Evasion reduced"},
#	killer = {icon = load("res://assets/images/traits/bowextradamage.png"), description = "Next skill damage increased"},
#	speed = {icon = null, description = null},
#	area_speed = {icon = null, description = null}, #marks owner of area speed effect
#
#	taunted = {icon = load("res://assets/images/iconsskills/taunt.png"), description = "This unit is taunted and must attack next turn"},
#	speed_debuf = {icon = null, description = null},
#
#	noresist = {icon = load("res://assets/images/traits/resistdebuf.png"), description = "Resists Reduced"},
#	shield1 = {icon = load('res://assets/images/traits/armor.png'), bonuseffect = 'barrier', description = "Every turn creates a barrier, absorbing 15 physical damage"},
#	shield2 = {icon = load('res://assets/images/traits/armor.png'), bonuseffect = 'barrier', description = "Absorbs 50 physical damage for 2 turns"},
#	shield3 = {icon = load('res://assets/images/traits/armor.png'), bonuseffect = 'barrier', description = "Absorbs 50 magic damage for 2 turns"},
#	spider_noarmor = {icon = load("res://assets/images/traits/armorignore.png"), description = "Armor Reduced"},
#	cripple = {icon = load("res://assets/images/traits/speeddebuf.png"), description = "Damage Reduced"},
#	dwarwnbuf_icon = {icon = load("res://assets/images/traits/beastdamage.png"), description = "Damage increases when taking damage"},
};
