extends Reference

var list = {
	char_rnd_injury = {
		vars = {
			var_injury_money = 20,
			var_injury_exp = 50,
			var_injury_physics = 5,
			var_injury_charm = 5
		},
	},
	char_rnd_asleep = {
		vars = {
			var_asleep_exp = 25,
			var_asleep_loyalty = 5,
			var_asleep_consent_req = 3,
			var_asleep_consent = 1,
			var_asleep_lust = 10,
			var_asleep_wits = 5
		},
	},
	char_rnd_bullying = {
		special_reqs = {
			char_reqs = [
				{
					code = 'stat',
					stat = 'personality',
					operant = 'neq',
					value = 'bold'
				},
			]
		},
		vars = {
			var_bullying_charm = 5,
			var_bullying_loyalty = 5,
			var_bullying_exp_char = 25,
			var_bullying_exp_mast = 25
		}
	},
	char_rnd_misbehave = {
		special_reqs = {
			char_reqs = [
				{
					code = 'stat',
					stat = 'personality',
					operant = 'neq',
					value = 'shy'
				},
			]
		},
		vars = {
			var_misbehave_charm = 5,
			var_misbehave_physics = 5
		}
	},
	char_rnd_lost = {
		vars = {
			var_lost_money = 20,
			var_lost_loyalty = 10,
			var_lost_wits = 5
		}
	},
	char_rnd_unwell = {
		vars = {
			var_unwell_exp = 30,
			var_unwell_charm = 5,
			var_unwell_physics = 5,
			var_unwell_hp = -25
		}
	},
	char_rnd_attention = {
		vars = {
			var_attention_consent_high = 4,#4+
			var_attention_consent_low = 2,
			var_attention_consent = 1,
			var_attention_charm = 5,
			var_attention_loyalty = 10,
			var_attention_exp = 25
		}
	},
	char_rnd_treasure = {
		vars = {
			var_treasure_money = 50,
			var_treasure_loyalty = 10,
			var_treasure_charm = 5,
			var_treasure_exp = 35
		}
	},
	char_rnd_nightmare = {
		vars = {
			var_nightmare_charm = 5,
			var_nightmare_loyalty = 5,
			var_nightmare_wits = 5
		}
	},
	char_rnd_hated_food = {
		special_reqs = {
			char_count = 2
		},
		vars = {
			var_hated_food_relation_up = 10,
			var_hated_food_relation_down = -10,
			var_hated_food_exp = 20
		}
	},
	char_rnd_quarrel = {
		special_reqs = {
			char_count = 2
		},
		vars = {
			var_quarrel_loyalty = 5,
			var_quarrel_exp = 30,
			var_quarrel_physics = 5
		}
	},
	char_rnd_love = {
		special_reqs = {
			char_count = 2,
			get_romance_pair = true
		},
		vars = {
			var_love_relation = -15,
			var_love_charm = 5,
			var_love_wits = 5,
			var_love_exp = 20
		}
	},
	char_rnd_discustomer = {
		special_reqs = {
			char_count = 2,
#			char_reqs_precise = {
#				1 : {code = 'work', value = 'brothel'}
#				2 : {code = 'work', value = 'brothel'}
#			}
			char_reqs = {
				code = 'work',
				value = 'brothel'
			}
		},
		vars = {
			var_discustomer_charm = 5,
			var_discustomer_relation_down = -10,
			var_discustomer_relation_up = 10,
			var_discustomer_wits = 5,
			var_discustomer_loyalty = 5,
			var_discustomer_physics = 5,
		}
	},
	char_rnd_likecustomer = {
		special_reqs = {
			char_count = 2,
			char_reqs = {
				code = 'work',
				value = 'brothel'
			}
		},
		vars = {
			var_likecustomer_charm = 5,
			var_likecustomer_money = 25,
			var_likecustomer_exp = 30
		}
	},
	char_rnd_trap = {
		special_reqs = {
			char_reqs = [
				{
					code = 'location_param',
					param = 'type',
					value = 'dungeon'
				},
				{
					code = 'in_combat_party',
					value = true
				}
			]
		},
		vars = {
			var_trap_stamina = 30,
			var_trap_injury_dur = 1
		}
	},
	char_rnd_skirmish = {
		special_reqs = {
			char_reqs = [
				{
					code = 'location_param',
					param = 'type',
					value = 'dungeon'
				},
				{
					code = 'in_combat_party',
					value = true
				}
			]
		},
		vars = {
			var_skirmish_stamina = 15,
			var_skirmish_charm = 5,
			var_skirmish_physics = 5,
			var_skirmish_money = 20,
			var_skirmish_hp = -10,
			var_skirmish_exp = 25
		}
	},
	char_rnd_pray = {
		special_reqs = {
			char_reqs = [
				{
					code = 'is_unique',
					value = false
				},
				{
					code = 'slave_type',
					operant = 'neq',
					value = 'slave'
				},
				{
					code = 'slave_type',
					operant = 'neq',
					value = 'slave_trained'
				}
			]
		},
		vars = {
			var_pray_loyalty = 5,
			var_pray_resistance = -25,
			var_pray_exp = 25
		}
	},
	char_rnd_letter = {
		special_reqs = {
			char_reqs = [
				{
					code = 'is_unique',
					value = false
				},
				{
					code = 'slave_type',
					operant = 'neq',
					value = 'slave'
				},
				{
					code = 'slave_type',
					operant = 'neq',
					value = 'slave_trained'
				}
			]
		},
		vars = {
			var_letter_grain = 20,
			var_letter_loyalty = 5,
			var_letter_resistance = -50,
			var_letter_exp = 35,
			var_letter_burn_exp = 25
		}
	},
	char_rnd_brokenvase = {
		vars = {
			var_brokenvase_loyalty = 5,
			var_brokenvase_exp_repair = 25,
			var_brokenvase_exp_replace = 25,
			var_brokenvase_money = 30,
			var_brokenvase_exp_punish = 20,
			var_brokenvase_duration = 1
		}
	},
	char_rnd_hunt_offering = {
		special_reqs = {
			char_reqs = [
				{
					code = 'one_of_races',
					value = ['BeastkinCat', 'BeastkinFox', 'BeastkinWolf', 'HalfkinCat', 'HalfkinFox', 'HalfkinWolf']
				},
				{
					code = 'stat',
					stat = 'wits_factor',
					operant = 'lte',
					value = 2
				}
			]
		},
		vars = {
			var_hunt_loyalty_accept = 15,
			var_hunt_exp_explain = 35,
			var_hunt_loyalty_explain = 5,
			var_hunt_wits_refuse = 5
		}
	},
	char_rnd_late_knock = {
		special_reqs = {
			char_reqs = [
				{
					code = 'trait',
					trait = 'training_s_sexservice',
					check = true
				},
				{
					code = 'stat',
					stat = 'consent',
					operant = 'gte',
					value = 2
				},
				{
					code = 'slave_type',
					operant = 'neq',
					value = 'spouse'
				}
			]
		},
		vars = {
			var_late_knock_exp_dismiss = 25,
			var_late_knock_charm_invite = 10,
			var_late_knock_loyalty_pull = 10,
			var_late_knock_exp_pull = 15
		}
	},
	char_rnd_caught = {
		special_reqs = {
			char_count = 2,
			get_lovers_pair = true
		},
		vars = {
			var_caught_xp = 15
		}
	},
	char_rnd_admirer = {
		vars = {
			var_admirer_wits_send = 5,
			var_admirer_exp_send = 15,
			var_admirer_charm_negotiate = 5,
			var_admirer_exp_negotiate = 15,
			var_admirer_exp_refuse = 20,
			var_admirer_loyalty_refuse = 10
		}
	},
	char_rnd_bath = {
		special_reqs = {
			global_reqs = [
				{
					type = 'has_upgrade',
					name = 'resting',
					value = 1
				}
			],
			char_reqs = [
				{
					code = 'trait',
					trait = 'training_s_sexservice',
					check = true
				},
				{
					code = 'stat',
					stat = 'consent',
					operant = 'gte',
					value = 2
				},
				{
					code = 'slave_type',
					operant = 'neq',
					value = 'spouse'
				}
			]
		},
		vars = {
			var_bath_loyalty_accept = 5,
			var_bath_exp_accept = 20,
			var_bath_loyalty_pullin = 15,
			var_bath_exp_dismiss = 30
		}
	},
	char_rnd_theft = {
		special_reqs = {
			char_reqs = [
				{
					code = 'stat',
					stat = 'personality',
					operant = 'neq',
					value = 'bold'
				}
			]
		},
		vars = {
			var_theft_exp_punish = 30,
			var_theft_loyalty_explain = 10,
			var_theft_exp_silent = 30,
			var_theft_wits_silent = 5
		}
	},
	char_rnd_sparring = {
		special_reqs = {
			char_count = 2,
			char_reqs = [
				{
					code = 'has_status',
					status = 'combatant',
					check = true
				}
			]
		},
		vars = {
			var_sparring_loyalty_move = 5,
			var_sparring_exp_move = 15,
			var_sparring_relation_care = 25,
			var_sparring_exp_care = 25,
			var_sparring_relation_formal = 15,
			var_sparring_exp_formal = 30
		}
	},
	char_rnd_laying = {
		special_reqs = {
			char_reqs = [
				{
					code = 'one_of_races',
					value = ['Harpy', 'Lamia']
				},
				{
					code = 'sex',
					operant = 'neq',
					value = 'male'
				}
			]
		},
		vars = {
			var_laying_rest_dur = 2,
			var_laying_exp_time = 25,
			var_laying_loyalty_time = 5,
			var_laying_charm_stay = 10,
			var_laying_exp_stay = 20,
			var_laying_loyalty_stay = 5,
			var_laying_exp_work = 20
		}
	},

}

func supplement_events():
	for id in list:
		if !list[id].has("vars"):
			continue
		var event_vars = list[id].vars
		var event = scenedata.scenedict[id]
		for opt in event.options:
			set_supplements(opt.reqs, event_vars)
			set_supplements(opt.bonus_effects, event_vars)

func is_placeholder(entry):
	return (entry is String and entry.begins_with("var_"))

func get_supplement(entry, vars):
	for i in vars:
		if entry == i:
			return vars[i]

func set_supplements(entry, vars):
	if entry is Dictionary:
		for i in entry:
			var val = entry[i]
			if is_placeholder(val):
				entry[i] = get_supplement(val, vars)
			else:#if dict or arr
				set_supplements(val, vars)
	elif entry is Array:
		for i in range(0, entry.size()):
			var val = entry[i]
			if is_placeholder(val):
				entry[i] = get_supplement(val, vars)
			else:#if dict or arr
				set_supplements(val, vars)



