extends Reference

var skills = {
	class_copy = {
		new_syntax = true,
		code = 'class_copy',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		reqs = [],
		targetreqs = [],
		effects = [],
		cost = {},
		charges = 1,
		cooldown = 0,
		icon = load("res://assets/images/iconsskills/icon_mirror_image.png"),
		tags = [],
		special = 'class_copy',
	},
	
}
var effects = {
	readd_class_copy = {
		type = 'trigger',
		trigger = [variables.TR_OBLIVION],
		req_skill = false,
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'add_soc_skill', skill = 'class_copy'}],
			}
		]
	},
}
var atomic_effects = {}
var buffs = {}
var stacks = {}

