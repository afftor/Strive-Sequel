extends Reference

#Jean quest finale (act 4). Two separate fights, both single-boss:
#  jean_demon_1 -> unit jean_evil  : Jean with the demon riding her, a high-tier caster
#  jean_demon_2 -> unit jean_demon : the demon in its own vessel, a sleep-stacking predator
#Everything here is prefixed jd_. Units live in enemydata.gd, traits in Traits.gd.
#
#Conventions carried over from the coalition module:
# - a hidden skill fired from a trait has the CASTER as its target, and CalculateTargets reads the
#   side off the target - so anything aimed at the party must be target = 'self' plus
#   target_number = 'nontarget_group'.
# - every skill carries a tag that appears in its unit's `ai` buckets, or AI_base weighs it 0 and the
#   rotation silently skips it.
# - 'ignore_taunt' keeps a scripted boss on its script under a soft taunt (AI_base:115).
# - a module effect must not hold a {status = ..., overload_target = ...} sub-effect: fix_eff_data
#   walks those expecting `type`. Point the trigger's own args.target at the owner instead.

var skills = {
	#=========================================================================================
	# JEAN - the possessed caster
	#=========================================================================================
	#Greater Flame Sphere. Hidden, fired once by her trait at combat start. type 'auto' keeps it out
	#of the AI pool; the shape is pas_flamesphere's (exploration.gd:29) with a bigger bite.
	jd_greater_flame_sphere = {
		code = 'jd_greater_flame_sphere',
		descript = '',
		icon = "res://assets/images/iconsskills/firestorm.png",
		type = 'auto',
		ability_type = 'spell',
		tags = ['aoe', 'damage', 'fire', 'instant', 'noreduce', 'ignore_taunt'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'burn', duration = 2})],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		critchance = 0,
		catalysts = {},
		target = 'self',
		target_number = 'nontarget_group',
		target_range = 'any',
		damage_type = 'fire',
		sfx = [
			{code = 'flame', target = 'target', period = 'predamage'},
			{code = 'cast_fire', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = 'firebolt', strike = null, hit = 'firehit', hittype = 'static'},
		value = [['target.hpmax', '*0.22']],
	},
	#Abyss - Void and Inferno in one. e_s_void is the player spell's own debuff roll (dark.gd:225):
	#one of blind / disarm / silence per target.
	jd_abyss = {
		code = 'jd_abyss',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_void.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['damage', 'aoe', 'debuff', 'ads', 'dark', 'ultimate', 'ignore_taunt'],
		reqs = [],
		targetreqs = [],
		effects = [
			'e_s_void',
			Effectdata.rebuild_template({effect = 'e_s_darkflame', duration = 3, target_reqs = [{code = 'has_status', status = 'burn', check = true}]}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'dark',
		random_factor_p = 0.1,
		sfx = [
			{code = 'skill_void', target = 'target_group', period = 'windup'},
			{code = 'cast_dark', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = 'spell_void', strike = null, hit = null, hittype = 'static'},
		value = 0.9,
	},
	#Soil Liquefaction - Overgrowth grown up. Ground-based, so flyers are missed the same way the
	#dwarf king's quakes miss them.
	jd_soil_liquefaction = {
		code = 'jd_soil_liquefaction',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_plant.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['damage', 'aoe', 'debuff', 'ads', 'earth', 'ignore_taunt'],
		reqs = [],
		targetreqs = [],
		effects = [
			'miss_flying_target',
			Effectdata.rebuild_template({effect = 'wet'}),
			Effectdata.rebuild_template({effect = 'jd_quicksand', duration = 2}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'earth',
		sfx = [
			{code = 'overgrowth', target = 'target_group', period = 'windup'},
			{code = 'cast_earth', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = 'avalanche', strike = null, hit = null, hittype = 'dynamic'},
		value = 0.5,
	},
	#Winterfall - Hailstorm's wet/frozen bonus with Blizzard's freeze. The freeze entry is listed
	#before the wet one on purpose: a target that was already Wet freezes and is not re-wetted,
	#a dry target only gets Wet.
	jd_winterfall = {
		code = 'jd_winterfall',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_hailstorm.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['damage', 'aoe', 'debuff', 'ads', 'water', 'kill_animation_ice', 'ignore_taunt'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_skillvalue_template({target_status = 'wet', value = 1.3}),
			Effectdata.rebuild_skillvalue_template({target_status = 'freeze', value = 1.4}),
			Effectdata.rebuild_template({effect = 'freeze', duration = 2, target_reqs = [{code = 'has_status', status = 'wet', check = true}]}),
			Effectdata.rebuild_template({effect = 'wet', target_reqs = [{code = 'has_status', status = 'wet', check = false}]}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'water',
		sfx = [{code = 'debuff', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'spell_break', hit = null},
		value = 0.9,
	},
	#Perfect Storm - Tempest that leaves weather behind. The storm rides the enemies rather than the
	#caster: a hidden skill cast from a trigger cannot pick 2-4 of the far side (see the header), so
	#each stormbound hero rolls for their own lightning at the start of a round.
	jd_perfect_storm = {
		code = 'jd_perfect_storm',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_energy_field.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['damage', 'aoe', 'debuff', 'ads', 'air', 'ignore_taunt'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'shock', duration = 2}),
			Effectdata.rebuild_template({effect = 'jd_lingering_storm', duration = 3}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'air',
		sfx = [
			{code = 'tempest', target = 'target_group', period = 'windup', duration = 0.85, queue_duration = 1.0},
			{code = 'cast_air', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = null, strike = 'spell_lightning', hit = 'combat_electric_charge_strike', hittype = 'static'},
		value = 0.8,
	},
	#"Tch..! This body ain't used to this level of spellcasting just yet..." - the breather the party
	#gets between two rounds of high-tier AoE.
	jd_catch_breath = {
		code = 'jd_catch_breath',
		descript = '',
		icon = "res://assets/images/iconsskills/meditate.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['heal', 'support', 'noreduce', 'noevade', 'no_caster_bonuses', 'ignore_taunt'],
		reqs = [],
		targetreqs = [],
		effects = [],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'normal',
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['caster.hpmax', '*0.12']],
		damagestat = ['-damage_hp'],
	},
	#Volcanic Eruption - Fire Arrow and Magma Blast fired off as fast as she can chain them.
	jd_volcanic_eruption = {
		code = 'jd_volcanic_eruption',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_magma blast.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['damage', 'ads', 'debuff', 'fire', 'damage_spot', 'ignore_taunt'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'shatter', duration = 3}),
			Effectdata.rebuild_template({effect = 'burn', duration = 3}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_ANY,
		target_range = 'any',
		damage_type = 'fire',
		repeat = 5,
		sfx = [
			{code = 'magma_blast', target = 'target', period = 'predamage'},
			{code = 'cast_fire', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = 'firebolt', strike = null, hit = 'spell_explosion', hittype = 'static'},
		value = 0.5,
		variations = [
			{
				reqs = [{code = 'random', value = 50}],
				set = {repeat = 6},
			},
		]
	},
	#Demonic Struggle - what is left when she is silenced. ability_type 'skill', so Silence does not
	#touch it; the demon wrings her body for the damage and she pays in blood.
	jd_demonic_struggle = {
		code = 'jd_demonic_struggle',
		descript = '',
		icon = "res://assets/images/iconsskills/demonform.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['damage', 'ads', 'basic', 'disable_immunity', 'ignore_taunt'],
		reqs = [],
		targetreqs = [],
		effects = [
			'jd_struggle_cost',
			Effectdata.rebuild_template({effect = 'stun', duration = 1}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [
			{code = 'dark_swril', target = 'caster', period = 'windup'},
			{code = 'targetattack', target = 'target', period = 'predamage'}],
		sounddata = {initiate = 'groan', strike = 'fleshhit', hit = null},
		value = 2.5,
	},
	#=========================================================================================
	# DEMON - the dream eater
	#=========================================================================================
	#The only way into Deep Sleep from nothing. A lone hero gets plain Sleep instead, so a solo run
	#is not an instant loss.
	jd_engulfing_dream = {
		code = 'jd_engulfing_dream',
		descript = '',
		icon = "res://assets/images/iconsskills/Sedate.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['debuff', 'ads', 'noreduce', 'noevade', 'ignore_taunt'],
		reqs = [],
		targetreqs = [{code = 'has_status', status = 'jd_comatose', check = false}],
		effects = [
			Effectdata.rebuild_template({effect = 'jd_deep_sleep', duration = 1, target_reqs = [{code = 'lone_wolf', check = false}]}),
			Effectdata.rebuild_template({effect = 'jd_deep_sleep', duration = 1, target_reqs = [{code = 'lone_wolf', check = false}]}),
			Effectdata.rebuild_template({effect = 'sleep', duration = 2, target_reqs = [{code = 'lone_wolf', check = true}]}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'mind',
		chance = 999,
		critchance = 0,
		sfx = [
			{code = 'devour_spirit', target = 'target', period = 'predamage'},
			{code = 'cast_mind', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = null, strike = 'spell_break', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
	},
	#Feeding on a sleeper: deeper sleep for them, one more stack of Empowerment for him.
	jd_oneiric_feeding = {
		code = 'jd_oneiric_feeding',
		descript = '',
		icon = "res://assets/images/iconsskills/soulconsume.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['debuff', 'buff', 'ads', 'noreduce', 'noevade', 'ignore_taunt'],
		reqs = [],
		targetreqs = [{code = 'has_status', status = 'jd_deep_sleep', check = true}],
		effects = [
			Effectdata.rebuild_template({effect = 'jd_deep_sleep', duration = 1}),
			Effectdata.rebuild_template({effect = 'jd_deep_sleep', duration = 1}),
			'jd_gain_empowerment',
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'mind',
		chance = 999,
		critchance = 0,
		sfx = [
			{code = 'devour_spirit', target = 'target', period = 'predamage'},
			{code = 'cast_mind', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = null, strike = 'spell_break', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
	},
	#Once he is fat enough on dreams, the nightmare spills over onto everyone still awake.
	jd_sapid_unreality = {
		code = 'jd_sapid_unreality',
		descript = '',
		icon = "res://assets/images/iconsskills/Mind_Control.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['debuff', 'ads', 'ultimate', 'noreduce', 'noevade', 'ignore_taunt'],
		reqs = [{code = 'buff_number', status = 'jd_empowerment', operant = 'gte', value = 5}],
		targetreqs = [{code = 'has_status', status = 'jd_deep_sleep', check = true}],
		effects = [
			Effectdata.rebuild_template({effect = 'jd_deep_sleep', duration = 1}),
			Effectdata.rebuild_template({effect = 'jd_deep_sleep', duration = 1}),
			Effectdata.rebuild_template({effect = 'jd_deep_sleep', duration = 1}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'mind',
		chance = 999,
		critchance = 0,
		sfx = [
			{code = 'devour_spirit', target = 'target', period = 'predamage'},
			{code = 'cast_mind', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = null, strike = 'spell_break', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
		follow_up = 'jd_sapid_wave',
	},
	#The wave that comes with it. Sleepers are skipped (auto-miss), which also keeps it from feeding
	#his Dream Eater heal off the very people he just put under.
	jd_sapid_wave = {
		code = 'jd_sapid_wave',
		name = '',
		descript = '',
		icon = "res://assets/images/iconsskills/Mindblast.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['damage', 'aoe', 'ads', 'not_final', 'ignore_taunt'],
		reqs = [],
		targetreqs = [],
		effects = ['jd_miss_dreamers'],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'mind',
		sfx = [{code = 'mind_blast', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'spell_break', hit = null},
		value = 1.1,
		not_final = true
	},
	#The game over. It is never reachable while anybody is still awake: every rotation row puts a
	#skill that needs a non-comatose target in front of it, and those all fall silent together.
	jd_eternal_slumber = {
		code = 'jd_eternal_slumber',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_eyes.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['damage', 'aoe', 'ultimate', 'disable_immunity', 'noreduce', 'noevade', 'ignore_taunt'],
		reqs = [],
		targetreqs = [{code = 'has_status', status = 'jd_comatose', check = true}],
		effects = ['jd_slumber_kill'],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'mind',
		chance = 999,
		critchance = 0,
		sfx = [
			{code = 'black_tendrils', target = 'target_group', period = 'windup'},
			{code = 'cast_mind', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = 'spell_break', strike = 'blade', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
	},
	#"I'll Show You What This Body can Do!!" - ranged on purpose; none of his moves are melee, so a
	#comatose front line never shields the rest.
	jd_show_body = {
		code = 'jd_show_body',
		descript = '',
		icon = "res://assets/images/iconsskills/demonform.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['damage', 'ads', 'debuff', 'damage_spot', 'ignore_taunt'],
		reqs = [],
		targetreqs = [
			{code = 'has_status', status = 'jd_comatose', check = false},
			{code = 'has_status', status = 'jd_deep_sleep', check = false},
		],
		effects = [
			Effectdata.rebuild_template({effect = 'shatter', duration = 3}),
			Effectdata.rebuild_template({effect = 'stun', chance = 0.5, duration = 1}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [
			{code = 'dark_swril', target = 'caster', period = 'windup'},
			{code = 'targetattack', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'fleshhit', hit = null},
		value = 1.9,
	},
	#Vision of Indulgence. Clarity has to go before Sleep is rolled - it grants sleep immunity - and a
	#cleanse only lands a frame later, so the sleep rides a follow-up.
	jd_vision_indulgence = {
		code = 'jd_vision_indulgence',
		descript = '',
		icon = "res://assets/images/iconsskills/Great_Seduce.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['damage', 'ads', 'debuff', 'damage_spot', 'ignore_taunt'],
		reqs = [],
		targetreqs = [
			{code = 'has_status', status = 'jd_comatose', check = false},
			{code = 'has_status', status = 'jd_deep_sleep', check = false},
		],
		effects = [
			Effectdata.rebuild_template({effect = Effectdata.rebuild_remove_effect('clarity')}),
			Effectdata.rebuild_template({effect = 'blind', duration = 2}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'mind',
		sfx = [
			{code = 'mind_blast', target = 'target', period = 'predamage'},
			{code = 'cast_mind', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = null, strike = 'spell_break', hit = null},
		value = 1.2,
		follow_up = 'jd_vision_sleep',
	},
	jd_vision_sleep = {
		code = 'jd_vision_sleep',
		name = '',
		descript = '',
		icon = "res://assets/images/iconsskills/Sedate.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['debuff', 'noreduce', 'noevade', 'not_final', 'ignore_taunt'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'sleep', duration = 2})],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'mind',
		chance = 999,
		critchance = 0,
		sfx = [],
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
		not_final = true
	},
	#Shadow clones: he stops being anywhere in particular and starts throwing hands everywhere.
	jd_mass_illusion = {
		code = 'jd_mass_illusion',
		descript = '',
		icon = "res://assets/images/iconsskills/comboattack.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['damage', 'aoe', 'ads', 'buff', 'ignore_taunt'],
		reqs = [],
		targetreqs = [
			{code = 'has_status', status = 'jd_comatose', check = false},
			{code = 'has_status', status = 'jd_deep_sleep', check = false},
		],
		effects = [
			'jd_miss_dreamers',
			Effectdata.rebuild_template({effect = 'e_t_hide2', duration = 3, trigger = variables.TR_CAST, target = 'caster'}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [
			{code = 'hide', target = 'caster', period = 'windup'},
			{code = 'targetattack', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'fleshhit', hit = null},
		value = 0.9,
	},
	#A beam down one column. Sleepers are passed over, same as everything else he throws.
	jd_faustian_deliverance = {
		code = 'jd_faustian_deliverance',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_dark.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['damage', 'ads', 'debuff', 'dark', 'ignore_taunt'],
		reqs = [],
		targetreqs = [
			{code = 'has_status', status = 'jd_comatose', check = false},
			{code = 'has_status', status = 'jd_deep_sleep', check = false},
		],
		effects = [
			'jd_miss_dreamers',
			Effectdata.rebuild_template({effect = 'cursed', duration = 3}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'row',
		target_range = 'any',
		damage_type = 'dark',
		sfx = [
			{code = 'shadow_spike', target = 'target', period = 'predamage'},
			{code = 'cast_dark', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = null, strike = 'spell_dark', hit = null},
		value = 1.7,
	},
	#Hidden: the shells Jean wears. Cast once at combat start, then swapped by the shells themselves.
	jd_ward_cast_diamond = {
		code = 'jd_ward_cast_diamond',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_protective_shell.png",
		type = 'auto',
		ability_type = 'spell',
		tags = ['support', 'buff', 'noreduce', 'noevade', 'ignore_taunt'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'jd_ward_diamond', trigger = variables.TR_CAST, target = 'caster'})],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'earth',
		sfx = [
			{code = 'earth_shield', target = 'target', period = 'predamage'},
			{code = 'cast_earth', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = 'avalanche', strike = null, hit = null, hittype = 'dynamic'},
		value = [['0']],
		damagestat = ['no_stat'],
	},
	jd_ward_cast_plasma = {
		code = 'jd_ward_cast_plasma',
		descript = '',
		icon = "res://assets/images/iconsskills/Barrier.png",
		type = 'auto',
		ability_type = 'spell',
		tags = ['support', 'buff', 'noreduce', 'noevade', 'ignore_taunt'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'jd_ward_plasma', trigger = variables.TR_CAST, target = 'caster'})],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'air',
		sfx = [
			{code = 'air_shield', target = 'target', period = 'predamage'},
			{code = 'cast_air', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = null, strike = 'spell_break', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
	},
}

var effects = {
	#=========================== shared by both bosses ===========================
	#Undefilable Arrogance. resist_taunt / resist_provoke are stat entries added for this fight;
	#fear and cursed already had theirs.
	jd_demon_arrogance = {
		type = 'simple',
		statchanges = {
			bleed_damage = 0.5, poison_damage = 0.5, burn_damage = 0.5, darkflame_damage = 0.5,
			resist_taunt_set = 100, resist_provoke_set = 100, resist_fear_set = 100, resist_cursed_set = 100,
		},
		tags = ['jd_demon_arrogance'],
		buffs = [{
			icon = "res://assets/images/iconsskills/Authority.png",
			description = "TRAIT_JD_DEMON_ARROGANCE",
			tags = ['combat_only'],
		}],
	},
	#=========================== Jean ===========================
	jd_flame_sphere_open = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_S],
		conditions = [],
		atomic = [],
		buffs = [],
		req_skill = false,
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			atomic = [{type = 'use_combat_skill', skill = 'jd_greater_flame_sphere'}],
		}],
	},
	#Adaptive Warding Field: one of the two shells at combat start, picked at random.
	jd_adaptive_ward_open = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_S],
		conditions = [],
		atomic = [],
		buffs = [],
		req_skill = false,
		modal_sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'use_combat_skill', skill = 'jd_ward_cast_diamond'}],
			},
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'use_combat_skill', skill = 'jd_ward_cast_plasma'}],
			},
		],
		sub_effects = [],
	},
	#Diamond Shell - the answer to being beaten on. Swaps itself for the Plasma Shell the moment a
	#spell lands, unless she is Silenced and cannot re-cast it.
	jd_ward_diamond = {
		type = 'temp_s',
		target = 'caster',
		stack = 'jd_ward',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['buff', 'positive', 'shield', 'jd_ward', 'jd_ward_diamond'],
		statchanges = {armor = 100, resist_shred_set = 100, resist_poison_set = 100, resist_bleed_set = 100},
		buffs = ['b_jd_ward_diamond'],
		sub_effects = ['jd_ward_diamond_soak', 'jd_ward_diamond_swap', 'jd_ward_clean_shred'],
	},
	jd_ward_diamond_soak = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['ability_type', 'neq', 'spell']},
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
		],
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [{type = 'stat_mul', stat = 'value', value = 0.5}],
		}],
	},
	jd_ward_diamond_swap = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['ability_type', 'eq', 'spell']},
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'owner', value = [{code = 'has_status', status = 'silence', check = false}]},
			{type = 'owner', value = [{code = 'has_status', status = 'jd_ward_plasma', check = false}]},
		],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			atomic = [
				{type = 'remove_all_effects', value = 'jd_ward'},
				{type = 'sfx', value = 'air_shield'},
				{type = 'effect', value = 'jd_ward_plasma'},
			],
		}],
	},
	jd_ward_clean_shred = {
		type = 'oneshot',
		target = 'owner',
		atomic = [{type = 'remove_all_effects', value = 'shred'}],
	},
	#Plasma Shell - the answer to being out-cast. Swaps back the moment something physical connects.
	jd_ward_plasma = {
		type = 'temp_s',
		target = 'caster',
		stack = 'jd_ward',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['buff', 'positive', 'shield', 'jd_ward', 'jd_ward_plasma'],
		statchanges = {mdef = 100, resist_shatter_set = 100, resist_burn_set = 100, resist_wet_set = 100},
		buffs = ['b_jd_ward_plasma'],
		sub_effects = ['jd_ward_plasma_soak', 'jd_ward_plasma_swap', 'jd_ward_clean_shatter'],
	},
	jd_ward_plasma_soak = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['ability_type', 'eq', 'spell']},
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
		],
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [{type = 'stat_mul', stat = 'value', value = 0.5}],
		}],
	},
	jd_ward_plasma_swap = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['ability_type', 'neq', 'spell']},
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'owner', value = [{code = 'has_status', status = 'silence', check = false}]},
			{type = 'owner', value = [{code = 'has_status', status = 'jd_ward_diamond', check = false}]},
		],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			atomic = [
				{type = 'remove_all_effects', value = 'jd_ward'},
				{type = 'sfx', value = 'earth_shield'},
				{type = 'effect', value = 'jd_ward_diamond'},
			],
		}],
	},
	jd_ward_clean_shatter = {
		type = 'oneshot',
		target = 'owner',
		atomic = [{type = 'remove_all_effects', value = 'shatter'}],
	},
	#Second Mouth. The demon speaks for her, so a crushed windpipe means nothing - until somebody
	#puts holy light through the thing that is doing the talking.
	jd_second_mouth = {
		type = 'simple',
		conditions = [{code = 'has_status', status = 'jd_mouth_shut', check = false}],
		statchanges = {resist_silence_set = 100, resist_light_set = -75},
		tags = ['jd_second_mouth'],
		buffs = [{
			icon = "res://assets/images/iconsskills/icon_eyes.png",
			description = "TRAIT_JD_SECOND_MOUTH",
			tags = ['combat_only'],
		}],
	},
	jd_second_mouth_shut = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['damage_type', 'eq', 'light']},
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'owner', value = [{code = 'has_status', status = 'jd_mouth_shut', check = false}]},
		],
		sub_effects = ['jd_mouth_shut'],
	},
	jd_mouth_shut = {
		type = 'temp_s',
		target = 'owner',
		stack = 'jd_mouth_shut',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 2,
		tags = ['debuff', 'negative', 'jd_mouth_shut'],
		statchanges = {},
		buffs = ['b_jd_mouth_shut'],
		sub_effects = ['jd_mouth_reopen'],
	},
	#Last tick of the suppression: the mouth opens again and spits the Silence back out. Triggers run
	#before the tick that removes the status, so buff_number == 1 is "this is the turn it ends".
	jd_mouth_reopen = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		req_skill = false,
		conditions = [{type = 'owner', value = [{code = 'buff_number', status = 'jd_mouth_shut', operant = 'eq', value = 1}]}],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			atomic = [{type = 'remove_all_effects', value = 'silence'}],
		}],
	},
	#Demonic Struggle's price, paid at cast time whether or not the blow lands.
	jd_struggle_cost = {
		type = 'trigger',
		trigger = [variables.TR_CAST],
		req_skill = true,
		conditions = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'caster',
			args = {
				value = {obj = 'caster', func = 'stat', stat = 'hpmax'},
				src = {obj = 'self', func = 'src', src = 'true'},
				mod = {obj = 'self', func = 'src', src = 0.08},
			},
			atomic = ['a_damage_new'],
		}],
	},
	#Quicksand. Counts as a trap, so anything that clears traps digs the hero out.
	jd_quicksand = {
		type = 'temp_s',
		target = 'target',
		stack = 'jd_quicksand',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['debuff', 'negative', 'trap', 'jd_quicksand'],
		statchanges = {evasion_mul = 0.25, speed = -50},
		buffs = ['b_jd_quicksand'],
		sub_effects = ['jd_quicksand_flail'],
	},
	jd_quicksand_flail = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['target_range', 'eq', 'melee']},
		],
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [
				{type = 'stat_mul', stat = 'value', value = 0.0},
				{type = 'stat_set', stat = 'hit_res', value = variables.RES_MISS},
			],
		}],
	},
	#Lingering Storm. Sits on the enemies rather than the caster - a skill fired from a trigger has
	#no way to name 2-4 of the far side - so every stormbound hero rolls for their own bolt.
	jd_lingering_storm = {
		type = 'temp_s',
		target = 'target',
		stack = 'jd_lingering_storm',
		tick_event = [variables.TR_TURN_S],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['debuff', 'negative', 'jd_lingering_storm'],
		args = {jolt = {obj = 'caster', func = 'stat', stat = 'matk'}},
		statchanges = {},
		buffs = ['b_jd_lingering_storm'],
		sub_effects = ['jd_storm_bolt'],
	},
	jd_storm_bolt = {
		type = 'trigger',
		trigger = [variables.TR_TURN_S],
		req_skill = false,
		conditions = [
			{type = 'random', value = 0.5},
			{type = 'owner', value = [{code = 'stat', stat = 'hp', operant = 'gt', value = 0}]},
		],
		args = {
			target = {obj = 'owner', func = 'eq'},
			duration = {obj = 'self', func = 'dur', dur = 2},
			jolt = {obj = 'parent', func = 'arg', arg = 'jolt'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = {
					value = {obj = 'parent', func = 'arg', arg = 'jolt'},
					src = {obj = 'self', func = 'src', src = 'air'},
					mod = {obj = 'self', func = 'src', src = 0.6},
				},
				atomic = [{type = 'sfx', value = 'lightning'}, 'a_damage_new'],
			},
			'shock',
		],
	},
	#=========================== Demon ===========================
	#Dream Eater's Self-Made Vessel: every blow that lands on a sleeper feeds him.
	jd_dream_eater = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'target', value = [{code = 'or_list', or_list = [
				{code = 'has_status', status = 'sleep', check = true},
				{code = 'has_status', status = 'jd_deep_sleep', check = true},
				{code = 'has_status', status = 'jd_comatose', check = true},
			]}]},
		],
		sub_effects = [{
			type = 'oneshot',
			target = 'caster',
			args = {hp = {obj = 'caster', func = 'stat', stat = 'hpmax'}},
			atomic = [{type = 'heal', value = [['parent_args', 'hp'], '*', 0.06]}],
		}],
	},
	jd_dream_eater_display = {
		type = 'simple',
		statchanges = {},
		tags = ['jd_dream_eater_display'],
		buffs = [{
			icon = "res://assets/images/iconsskills/soulconsume.png",
			description = "TRAIT_JD_DREAM_EATER",
			tags = ['combat_only'],
		}],
	},
	jd_ennui_display = {
		type = 'simple',
		statchanges = {},
		tags = ['jd_ennui_display'],
		buffs = [{
			icon = "res://assets/images/iconsskills/skill_bloodboil.png",
			description = "TRAIT_JD_ENNUI",
			tags = ['combat_only'],
		}],
	},
	#500 Years of Ennui and Resentment - part one: try to pin him down and he gets angrier.
	jd_ennui_rage = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG, variables.TR_TURN_S, variables.TR_TURN_GET],
		req_skill = false,
		conditions = [
			{type = 'owner', value = [{code = 'has_status', status = 'jd_enrage', check = false}]},
			{type = 'owner', value = [{code = 'or_list', or_list = [
				{code = 'has_status', status = 'disable', check = true},
				{code = 'has_status', status = 'ensnared', check = true},
			]}]},
		],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			atomic = [{type = 'sfx', value = 'blood_boil'}, {type = 'effect', value = 'jd_enrage'}],
		}],
	},
	#part two: the first time he is driven under half, he tears the gag off for good.
	jd_ennui_unsilence = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG, variables.TR_TURN_S, variables.TR_DMG],
		req_skill = false,
		conditions = [
			{type = 'owner', value = [{code = 'stat', stat = 'hp', operant = 'lte', value = ['self.hpmax', '*0.5']}]},
			{type = 'owner', value = [{code = 'has_status', status = 'jd_unsilenced', check = false}]},
		],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			atomic = [
				{type = 'remove_all_effects', value = 'silence'},
				{type = 'effect', value = 'jd_unsilenced'},
			],
		}],
	},
	jd_unsilenced = {
		type = 'temp_s',
		target = 'owner',
		stack = 'jd_unsilenced',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F],
		tags = ['buff', 'positive', 'jd_unsilenced'],
		statchanges = {resist_silence_set = 100},
		buffs = ['b_jd_unsilenced'],
	},
	jd_enrage = {
		type = 'temp_s',
		target = 'owner',
		stack = 'jd_enrage',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 3,
		tags = ['buff', 'positive', 'jd_enrage'],
		statchanges = {damage_mod_all = 0.2, damage_reduction = 20, resist_mind = -20},
		buffs = ['b_jd_enrage'],
	},
	#Empowerment: +10% ATK and MATK a stack, counted by buff_number through the show_amount buff.
	jd_gain_empowerment = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'caster',
			atomic = [{type = 'effect', value = 'jd_empowerment'}],
		}],
	},
	jd_empowerment = {
		type = 'temp_s',
		target = 'owner',
		stack = 'jd_empowerment',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 1,
		tags = ['buff', 'positive', 'jd_empowerment'],
		statchanges = {atk_add_part = 0.1, matk_add_part = 0.1},
		buffs = ['b_jd_empowerment'],
	},
	#Deep Sleep. stack_s, so each helping queues behind the last one instead of refreshing it:
	#only the oldest instance ticks, and buff_number reports the whole pile.
	jd_deep_sleep = {
		type = 'temp_s',
		target = 'target',
		stack = 'jd_deep_sleep',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['debuff', 'negative', 'disable', 'jd_deep_sleep'],
		statchanges = {},
		buffs = ['b_jd_deep_sleep'],
		sub_effects = ['jd_deep_sleep_shake', 'jd_deep_sleep_clarity', 'jd_deep_sleep_coma'],
	},
	#Shaking them: any ability an ally points at them burns one helping off the pile.
	jd_deep_sleep_shake = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'caster', value = [{code = 'stat', stat = 'combatgroup', operant = 'eq', value = 'ally'}]},
		],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			atomic = [{type = 'remove_effect', value = 'jd_deep_sleep'}],
		}],
	},
	jd_deep_sleep_clarity = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		req_skill = false,
		conditions = [{type = 'owner', value = [{code = 'has_status', status = 'clarity', check = true}]}],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			atomic = [{type = 'remove_effect', value = 'jd_deep_sleep'}],
		}],
	},
	jd_deep_sleep_coma = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		req_skill = false,
		conditions = [{type = 'owner', value = [{code = 'buff_number', status = 'jd_deep_sleep', operant = 'gte', value = 8}]}],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			atomic = [
				{type = 'remove_all_effects', value = 'jd_deep_sleep'},
				{type = 'sfx', value = 'darkness'},
				{type = 'effect', value = 'jd_comatose'},
			],
		}],
	},
	jd_comatose = {
		type = 'temp_s',
		target = 'owner',
		stack = 'jd_comatose',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F],
		tags = ['debuff', 'negative', 'disable', 'jd_comatose'],
		statchanges = {},
		buffs = ['b_jd_comatose'],
	},
	#Anything he throws passes straight over a sleeper - which is also what keeps the wave from
	#feeding his own Dream Eater heal.
	jd_miss_dreamers = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'target', value = [{code = 'or_list', or_list = [
				{code = 'has_status', status = 'sleep', check = true},
				{code = 'has_status', status = 'jd_deep_sleep', check = true},
				{code = 'has_status', status = 'jd_comatose', check = true},
			]}]},
		],
		args = {skill = {obj = 'skill', func = 'eq'}},
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [
				{type = 'stat_mul', stat = 'value', value = 0.0},
				{type = 'stat_set', stat = 'hit_res', value = variables.RES_MISS},
			],
		}],
	},
	jd_slumber_kill = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [{type = 'target', value = [{code = 'has_status', status = 'jd_comatose', check = true}]}],
		sub_effects = [{
			type = 'oneshot',
			target = 'target',
			atomic = [{type = 'stat_set', stat = 'hp', value = 0}],
		}],
	},
}

var atomic_effects = {}

var buffs = {
	b_jd_ward_diamond = {
		icon = "res://assets/images/iconsskills/icon_protective_shell.png",
		description = "EFFECT_JD_WARD_DIAMOND",
		limit = 1,
	},
	b_jd_ward_plasma = {
		icon = "res://assets/images/iconsskills/Barrier.png",
		description = "EFFECT_JD_WARD_PLASMA",
		limit = 1,
	},
	b_jd_mouth_shut = {
		icon = "res://assets/images/iconsskills/light_spell.png",
		description = "EFFECT_JD_MOUTH_SHUT",
	},
	b_jd_quicksand = {
		icon = "res://assets/images/iconsskills/skill_ensnare.png",
		description = "EFFECT_JD_QUICKSAND",
	},
	b_jd_lingering_storm = {
		icon = "res://assets/images/iconsskills/icon_lightning_orb.png",
		description = "EFFECT_JD_LINGERING_STORM",
	},
	b_jd_enrage = {
		icon = "res://assets/images/iconsskills/skill_bloodboil.png",
		description = "EFFECT_JD_ENRAGE",
	},
	b_jd_unsilenced = {
		icon = "res://assets/images/iconsskills/demonform.png",
		description = "EFFECT_JD_UNSILENCED",
		limit = 1,
	},
	b_jd_empowerment = {
		icon = "res://assets/images/iconsskills/Authority.png",
		description = "EFFECT_JD_EMPOWERMENT",
		tags = ['show_amount']
	},
	b_jd_deep_sleep = {
		icon = "res://assets/images/iconsskills/Sedation.png",
		description = "EFFECT_JD_DEEP_SLEEP",
	},
	b_jd_comatose = {
		icon = "res://assets/images/iconsskills/icon_eyes.png",
		description = "EFFECT_JD_COMATOSE",
	},
}

var stacks = {
	jd_ward = {}, #stack 1
	jd_mouth_shut = {
		type = 'stack_s',
		stack = 1,
		buff = 'b_jd_mouth_shut',
	},
	jd_quicksand = {
		type = 'stack_a',
		stack = 1,
		buff = 'b_jd_quicksand',
	},
	jd_lingering_storm = {
		type = 'stack_a',
		stack = 1,
		buff = 'b_jd_lingering_storm',
	},
	jd_enrage = {}, #stack 1
	jd_unsilenced = {}, #stack 1
	jd_empowerment = {
		type = 'stack_a',
		stack = 8,
		buff = 'b_jd_empowerment',
	},
	jd_deep_sleep = {
		type = 'stack_s',
		stack = 1,
		buff = 'b_jd_deep_sleep',
	},
	jd_comatose = {}, #stack 1
}
