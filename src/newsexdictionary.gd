extends Reference
#I DO THINK THAT CONSENT CONDITIONS HERE ARE ALL WRONG DUE TO STAT BEING INT NOW!!!!!
#linksets
const linksets = {

	none = [
	],

	sex = [
		"missionary",
		"missionaryanal",
		"doggy",
		"doggyanal",
		"lotus",
		"lotusanal",
		"revlotus",
		"revlotusanal",
	],

	tail = [
		"inserttailv",
		"inserttaila",
	],

	caress = [
		"missionary",
		"missionaryanal",
		"doggy",
		"doggyanal",
		"lotus",
		"lotusanal",
		"revlotus",
		"revlotusanal",
		"ontop",
		"ontopanal",
	],
}

#shared lines for newtype actions
const shared_lines = {

start_1_missionary = {

	repeat_nice = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_MISSIONARY_REPEAT_NICE_1",
		"SEXDICT_START_1_MISSIONARY_REPEAT_NICE_2",
		"SEXDICT_START_1_MISSIONARY_REPEAT_NICE_3",
	]},

	repeat_mean = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_MISSIONARY_REPEAT_MEAN_1",
		"SEXDICT_START_1_MISSIONARY_REPEAT_MEAN_2",
		"SEXDICT_START_1_MISSIONARY_REPEAT_MEAN_3",
	]},

	lotus_nice = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_MISSIONARY_LOTUS_NICE_1",
		"SEXDICT_START_1_MISSIONARY_LOTUS_NICE_2",
	]},

	lotus_mean = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_MISSIONARY_LOTUS_MEAN_1",
		"SEXDICT_START_1_MISSIONARY_LOTUS_MEAN_2",
	]},

	revlotus_nice = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_MISSIONARY_REVLOTUS_NICE_1",
		"SEXDICT_START_1_MISSIONARY_REVLOTUS_NICE_2",
	]},

	revlotus_mean = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_MISSIONARY_REVLOTUS_MEAN_1",
		"SEXDICT_START_1_MISSIONARY_REVLOTUS_MEAN_2",
	]},

	doggy_nice = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_MISSIONARY_DOGGY_NICE_1",
		"SEXDICT_START_1_MISSIONARY_DOGGY_NICE_2",
	]},

	doggy_mean = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_MISSIONARY_DOGGY_MEAN_1",
		"SEXDICT_START_1_MISSIONARY_DOGGY_MEAN_2",
	]},

	insert_nice = {
	conditions = {
		link = [null],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_MISSIONARY_INSERT_NICE_1",
		"SEXDICT_START_1_MISSIONARY_INSERT_NICE_2",
	]},

	insert_mean = {
	conditions = {
		link = [null],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_MISSIONARY_INSERT_MEAN_1",
		"SEXDICT_START_1_MISSIONARY_INSERT_MEAN_2",
	]},

},

start_1_doggy = {

	repeat_nice = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_DOGGY_REPEAT_NICE_1",
		"SEXDICT_START_1_DOGGY_REPEAT_NICE_2",
		"SEXDICT_START_1_DOGGY_REPEAT_NICE_3",
	]},

	repeat_mean = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_DOGGY_REPEAT_MEAN_1",
		"SEXDICT_START_1_DOGGY_REPEAT_MEAN_2",
		"SEXDICT_START_1_DOGGY_REPEAT_MEAN_3",
	]},

	lotus_nice = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_DOGGY_LOTUS_NICE_1",
		"SEXDICT_START_1_DOGGY_LOTUS_NICE_2",
	]},

	lotus_mean = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_DOGGY_LOTUS_MEAN_1",
		"SEXDICT_START_1_DOGGY_LOTUS_MEAN_2",
	]},

	revlotus_nice = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_DOGGY_REVLOTUS_NICE_1",
		"SEXDICT_START_1_DOGGY_REVLOTUS_NICE_2",
	]},

	revlotus_mean = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_DOGGY_REVLOTUS_MEAN_1",
		"SEXDICT_START_1_DOGGY_REVLOTUS_MEAN_2",
	]},

	missionary_nice = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_DOGGY_MISSIONARY_NICE_1",
		"SEXDICT_START_1_DOGGY_MISSIONARY_NICE_2",
	]},

	missionary_mean = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_DOGGY_MISSIONARY_MEAN_1",
		"SEXDICT_START_1_DOGGY_MISSIONARY_MEAN_2",
	]},

	insert_nice = {
	conditions = {
		link = [null],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_DOGGY_INSERT_NICE_1",
		"SEXDICT_START_1_DOGGY_INSERT_NICE_2",
	]},

	insert_mean = {
	conditions = {
		link = [null],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_DOGGY_INSERT_MEAN_1",
		"SEXDICT_START_1_DOGGY_INSERT_MEAN_2",
	]},

},

start_1_lotus = {

	repeat_nice = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_LOTUS_REPEAT_NICE_1",
		"SEXDICT_START_1_LOTUS_REPEAT_NICE_2",
		"SEXDICT_START_1_LOTUS_REPEAT_NICE_3",
	]},

	repeat_mean = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_LOTUS_REPEAT_MEAN_1",
		"SEXDICT_START_1_LOTUS_REPEAT_MEAN_2",
	]},

	revlotus_nice = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_LOTUS_REVLOTUS_NICE_1",
		"SEXDICT_START_1_LOTUS_REVLOTUS_NICE_2",
	]},

	revlotus_mean = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_LOTUS_REVLOTUS_MEAN_1",
		"SEXDICT_START_1_LOTUS_REVLOTUS_MEAN_2",
	]},

	missionary_nice = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_LOTUS_MISSIONARY_NICE_1",
		"SEXDICT_START_1_LOTUS_MISSIONARY_NICE_2",
	]},

	missionary_mean = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_LOTUS_MISSIONARY_MEAN_1",
		"SEXDICT_START_1_LOTUS_MISSIONARY_MEAN_2",
	]},

	doggy_nice = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_LOTUS_DOGGY_NICE_1",
		"SEXDICT_START_1_LOTUS_DOGGY_NICE_2",
	]},

	doggy_mean = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_LOTUS_DOGGY_MEAN_1",
		"SEXDICT_START_1_LOTUS_DOGGY_MEAN_2",
	]},

	insert_nice = {
	conditions = {
		link = [null],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_LOTUS_INSERT_NICE_1",
		"SEXDICT_START_1_LOTUS_INSERT_NICE_2",
	]},

	insert_mean = {
	conditions = {
		link = [null],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_LOTUS_INSERT_MEAN_1",
		"SEXDICT_START_1_LOTUS_INSERT_MEAN_2",
	]},

},

start_1_revlotus = {

	repeat_nice = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_REVLOTUS_REPEAT_NICE_1",
		"SEXDICT_START_1_REVLOTUS_REPEAT_NICE_2",
		"SEXDICT_START_1_REVLOTUS_REPEAT_NICE_3",
	]},

	repeat_mean = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_REVLOTUS_REPEAT_MEAN_1",
		"SEXDICT_START_1_REVLOTUS_REPEAT_MEAN_2",
	]},

	lotus_nice = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_REVLOTUS_LOTUS_NICE_1",
		"SEXDICT_START_1_REVLOTUS_LOTUS_NICE_2",
	]},

	lotus_mean = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_REVLOTUS_LOTUS_MEAN_1",
		"SEXDICT_START_1_REVLOTUS_LOTUS_MEAN_2",
	]},

	doggy_nice = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_REVLOTUS_DOGGY_NICE_1",
		"SEXDICT_START_1_REVLOTUS_DOGGY_NICE_2",
	]},

	doggy_mean = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_REVLOTUS_DOGGY_MEAN_1",
		"SEXDICT_START_1_REVLOTUS_DOGGY_MEAN_2",
	]},

	missionary_nice = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_REVLOTUS_MISSIONARY_NICE_1",
		"SEXDICT_START_1_REVLOTUS_MISSIONARY_NICE_2",
	]},

	missionary_mean = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_REVLOTUS_MISSIONARY_MEAN_1",
		"SEXDICT_START_1_REVLOTUS_MISSIONARY_MEAN_2",
	]},

	insert_nice = {
	conditions = {
		link = [null],
		consent = [true],
	},
	lines = [
		"SEXDICT_START_1_REVLOTUS_INSERT_NICE_1",
		"SEXDICT_START_1_REVLOTUS_INSERT_NICE_2",
	]},

	insert_mean = {
	conditions = {
		link = [null],
		consent = [false],
	},
	lines = [
		"SEXDICT_START_1_REVLOTUS_INSERT_MEAN_1",
		"SEXDICT_START_1_REVLOTUS_INSERT_MEAN_2",
	]},

},

start_2_sexv = {

	same = {
	conditions = {
		orifice = ["same"],
	},
	lines = [
		"SEXDICT_START_2_SEXV_SAME_1",
		"SEXDICT_START_2_SEXV_SAME_2",
		"SEXDICT_START_2_SEXV_SAME_3",
	]},

	same_giver_mastered_nice = {
	conditions = {
		orifice = ["same"],
		consent = [true],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXDICT_START_2_SEXV_SAME_GIVER_MASTERED_NICE_1",
	]},

	same_giver_skilled_nice = {
	conditions = {
		orifice = ["same"],
		consent = [true],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXDICT_START_2_SEXV_SAME_GIVER_SKILLED_NICE_1",
	]},

	same_giver_novice_nice = {
	conditions = {
		orifice = ["same"],
		consent = [true],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXDICT_START_2_SEXV_SAME_GIVER_NOVICE_NICE_1",
	]},

	holeswap = {
	conditions = {
		orifice = ["swap"],
	},
	lines = [
		"SEXDICT_START_2_SEXV_HOLESWAP_1",
		"SEXDICT_START_2_SEXV_HOLESWAP_2",
	]},

	insert = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
	},
	lines = [
		"SEXDICT_START_2_SEXV_INSERT_1",
		"SEXDICT_START_2_SEXV_INSERT_2",
	]},

	insert_giver_mastered_nice = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [true],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXDICT_START_2_SEXV_INSERT_GIVER_MASTERED_NICE_1",
	]},

	insert_giver_skilled_nice = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [true],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXDICT_START_2_SEXV_INSERT_GIVER_SKILLED_NICE_1",
	]},

	insert_giver_mastered_mean = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [false],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXDICT_START_2_SEXV_INSERT_GIVER_MASTERED_MEAN_1",
	]},

	insert_giver_skilled_mean = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [false],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXDICT_START_2_SEXV_INSERT_GIVER_SKILLED_MEAN_1",
	]},

	insert_giver_novice_nice = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [true],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXDICT_START_2_SEXV_INSERT_GIVER_NOVICE_NICE_1",
	]},

	insert_taker_mastered_nice = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [true],
		taker_skill_level = ['mastered'],
	},
	lines = [
		"SEXDICT_START_2_SEXV_INSERT_TAKER_MASTERED_NICE_1",
	]},

	insert_taker_skilled_nice = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [true],
		taker_skill_level = ['skilled'],
	},
	lines = [
		"SEXDICT_START_2_SEXV_INSERT_TAKER_SKILLED_NICE_1",
	]},

	insert_taker_novice_nice = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [true],
		taker_skill_level = ['novice'],
	},
	lines = [
		"SEXDICT_START_2_SEXV_INSERT_TAKER_NOVICE_NICE_1",
	]},

	insert_taker_skilled_mean = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [false],
		taker_skill_level = ['skilled'],
	},
	lines = [
		"SEXDICT_START_2_SEXV_INSERT_TAKER_SKILLED_MEAN_1",
	]},

	insert_taker_novice_mean = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [false],
		taker_skill_level = ['novice'],
	},
	lines = [
		"SEXDICT_START_2_SEXV_INSERT_TAKER_NOVICE_MEAN_1",
	]},

	insert_fingering_nice = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [true],
		consent = [true],
	},
	lines = [
		"SEXDESC_VAGINAL_INSERT_FINGERING_TRANSITION_1",
		"SEXDESC_VAGINAL_INSERT_FINGERING_TRANSITION_2",
		"SEXDESC_VAGINAL_INSERT_FINGERING_TRANSITION_4",
		"SEXDESC_VAGINAL_INSERT_FINGERING_TRANSITION_5",
	]},

	insert_fingering_mean = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [true],
		consent = [false],
	},
	lines = [
		"SEXDESC_VAGINAL_INSERT_FINGERING_TRANSITION_3",
		"SEXDESC_VAGINAL_INSERT_FINGERING_TRANSITION_4",
		"SEXDESC_VAGINAL_INSERT_FINGERING_TRANSITION_5",
	]},

},

start_2_sexa = {

	same = {
	conditions = {
		orifice = ["same"],
	},
	lines = [
		"SEXDICT_START_2_SEXA_SAME_1",
		"SEXDICT_START_2_SEXA_SAME_2",
		"SEXDICT_START_2_SEXA_SAME_3",
	]},

	holeswap = {
	conditions = {
		orifice = ["swap"],
	},
	lines = [
		"SEXDICT_START_2_SEXA_HOLESWAP_1",
		"SEXDICT_START_2_SEXA_HOLESWAP_2",
	]},

	insert = {
	conditions = {
		orifice = ["insert"],
	},
	lines = [
		"SEXDICT_START_2_SEXA_INSERT_1",
		"SEXDICT_START_2_SEXA_INSERT_2",
	]},

},

main_1_sexv = {

	huggable_nice = {
	conditions = {
		virgin = [false],
		parallel = [true],
		facing = [true],
		consent = [true],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_HUGGABLE_NICE_1",
		"SEXDICT_MAIN_1_SEXV_HUGGABLE_NICE_2",
		"SEXDICT_MAIN_1_SEXV_HUGGABLE_NICE_3",
	]},

	facing_nice = {
	conditions = {
		virgin = [false],
		facing = [true],
		consent = [true],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_FACING_NICE_1",
	]},

	facing_mean = {
	conditions = {
		virgin = [false],
		facing = [true],
		consent = [false],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_FACING_MEAN_1",
		"SEXDICT_MAIN_1_SEXV_FACING_MEAN_2",
	]},

	nonfacing_nice = {
	conditions = {
		virgin = [false],
		facing = [false],
		consent = [true],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_NONFACING_NICE_1",
		"SEXDICT_MAIN_1_SEXV_NONFACING_NICE_2",
	]},

	nonfacing_mean = {
	conditions = {
		virgin = [false],
		facing = [false],
		consent = [false],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_NONFACING_MEAN_1",
	]},

	virgin_nice = {
	conditions = {
		virgin = [true],
		consent = [true],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_VIRGIN_NICE_1",
		"SEXDICT_MAIN_1_SEXV_VIRGIN_NICE_2",
		"SEXDICT_MAIN_1_SEXV_VIRGIN_NICE_3",
	]},

	virgin_mean = {
	conditions = {
		virgin = [true],
		consent = [false],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_VIRGIN_MEAN_1",
		"SEXDICT_MAIN_1_SEXV_VIRGIN_MEAN_2",
		"SEXDICT_MAIN_1_SEXV_VIRGIN_MEAN_3",
	]},

	virgin_facing_nice = {
	conditions = {
		virgin = [true],
		facing = [true],
		consent = [true],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_VIRGIN_FACING_NICE_1",
	]},

	virgin_facing_mean = {
	conditions = {
		virgin = [true],
		facing = [true],
		consent = [false],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_VIRGIN_FACING_MEAN_1",
	]},

	virgin_nonfacing_nice = {
	conditions = {
		virgin = [true],
		facing = [false],
		consent = [true],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_VIRGIN_NONFACING_NICE_1",
	]},

	virgin_nonfacing_mean = {
	conditions = {
		virgin = [true],
		facing = [false],
		consent = [false],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_VIRGIN_NONFACING_MEAN_1",
	]},

	nice = {
	conditions = {
		virgin = [false],
		consent = [true],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_NICE_1",
		"SEXDICT_MAIN_1_SEXV_NICE_2",
	]},

	mean = {
	conditions = {
		virgin = [false],
		consent = [false],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_MEAN_1",
	]},

	insert = {
	conditions = {
		virgin = [false],
		orifice = ["insert"]
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_INSERT_1",
	]},

	noninsert = {
	conditions = {
		virgin = [false],
		orifice = ["same","shift","swap"]
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_NONINSERT_1",
	]},

	giver_mastered_nice = {
	conditions = {
		virgin = [false],
		consent = [true],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_GIVER_MASTERED_NICE_1",
		"SEXDICT_MAIN_1_SEXV_GIVER_MASTERED_NICE_2",
	]},

	giver_skilled_nice = {
	conditions = {
		virgin = [false],
		consent = [true],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_GIVER_SKILLED_NICE_1",
	]},

	giver_novice_nice = {
	conditions = {
		virgin = [false],
		consent = [true],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_GIVER_NOVICE_NICE_1",
		"SEXDICT_MAIN_1_SEXV_GIVER_NOVICE_NICE_2",
	]},

	taker_mastered_nice = {
	conditions = {
		virgin = [false],
		consent = [true],
		taker_skill_level = ['mastered'],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_TAKER_MASTERED_NICE_1",
		"SEXDICT_MAIN_1_SEXV_TAKER_MASTERED_NICE_2",
	]},

	taker_skilled_nice = {
	conditions = {
		virgin = [false],
		consent = [true],
		taker_skill_level = ['skilled'],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_TAKER_SKILLED_NICE_1",
		"SEXDICT_MAIN_1_SEXV_TAKER_SKILLED_NICE_2",
	]},

	taker_novice_nice = {
	conditions = {
		virgin = [false],
		consent = [true],
		taker_skill_level = ['novice'],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_TAKER_NOVICE_NICE_1",
		"SEXDICT_MAIN_1_SEXV_TAKER_NOVICE_NICE_2",
	]},

	giver_mastered_mean = {
	conditions = {
		virgin = [false],
		consent = [false],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_GIVER_MASTERED_MEAN_1",
		"SEXDICT_MAIN_1_SEXV_GIVER_MASTERED_MEAN_2",
	]},

	giver_skilled_mean = {
	conditions = {
		virgin = [false],
		consent = [false],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_GIVER_SKILLED_MEAN_1",
	]},

	giver_novice_mean = {
	conditions = {
		virgin = [false],
		consent = [false],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_GIVER_NOVICE_MEAN_1",
	]},

	taker_mastered_mean = {
	conditions = {
		virgin = [false],
		consent = [false],
		taker_skill_level = ['mastered'],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_TAKER_MASTERED_MEAN_1",
		"SEXDICT_MAIN_1_SEXV_TAKER_MASTERED_MEAN_2",
	]},

	taker_skilled_mean = {
	conditions = {
		virgin = [false],
		consent = [false],
		taker_skill_level = ['skilled'],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_TAKER_SKILLED_MEAN_1",
	]},

	taker_novice_mean = {
	conditions = {
		virgin = [false],
		consent = [false],
		taker_skill_level = ['novice'],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXV_TAKER_NOVICE_MEAN_1",
		"SEXDICT_MAIN_1_SEXV_TAKER_NOVICE_MEAN_2",
	]},

},

main_1_sexa = {

	huggable_nice = {
	conditions = {
		virgin = [false],
		parallel = [true],
		facing = [true],
		consent = [true],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXA_HUGGABLE_NICE_1",
		"SEXDICT_MAIN_1_SEXA_HUGGABLE_NICE_2",
		"SEXDICT_MAIN_1_SEXA_HUGGABLE_NICE_3",
	]},

	facing_nice = {
	conditions = {
		virgin = [false],
		facing = [true],
		consent = [true],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXA_FACING_NICE_1",
	]},

	facing_mean = {
	conditions = {
		virgin = [false],
		facing = [true],
		consent = [false],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXA_FACING_MEAN_1",
		"SEXDICT_MAIN_1_SEXA_FACING_MEAN_2",
	]},

	nonfacing_nice = {
	conditions = {
		virgin = [false],
		facing = [false],
		consent = [true],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXA_NONFACING_NICE_1",
		"SEXDICT_MAIN_1_SEXA_NONFACING_NICE_2",
	]},

	nonfacing_mean = {
	conditions = {
		virgin = [false],
		facing = [false],
		consent = [false],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXA_NONFACING_MEAN_1",
	]},

	virgin_nice = {
	conditions = {
		virgin = [true],
		consent = [true],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXA_VIRGIN_NICE_1",
	]},

	virgin_mean = {
	conditions = {
		virgin = [true],
		consent = [false],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXA_VIRGIN_MEAN_1",
	]},

	virgin_facing_nice = {
	conditions = {
		virgin = [true],
		facing = [true],
		consent = [true],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXA_VIRGIN_FACING_NICE_1",
	]},

	virgin_facing_mean = {
	conditions = {
		virgin = [true],
		facing = [true],
		consent = [false],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXA_VIRGIN_FACING_MEAN_1",
	]},

	virgin_nonfacing_nice = {
	conditions = {
		virgin = [true],
		facing = [false],
		consent = [true],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXA_VIRGIN_NONFACING_NICE_1",
	]},

	virgin_nonfacing_mean = {
	conditions = {
		virgin = [true],
		facing = [false],
		consent = [false],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXA_VIRGIN_NONFACING_MEAN_1",
	]},

	nice = {
	conditions = {
		virgin = [false],
		consent = [true],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXA_NICE_1",
		"SEXDICT_MAIN_1_SEXA_NICE_2",
	]},

	mean = {
	conditions = {
		virgin = [false],
		consent = [false],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXA_MEAN_1",
	]},

	default = {
	conditions = {
		virgin = [false],
	},
	lines = [
		"SEXDICT_MAIN_1_SEXA_DEFAULT_1",
	]},

},

main_2_sexv = {

	virgin = {
	conditions = {
		virgin = [true],
	},
	lines = [
		"SEXDICT_MAIN_2_SEXV_VIRGIN_1",
		"SEXDICT_MAIN_2_SEXV_VIRGIN_2",
		"SEXDICT_MAIN_2_SEXV_VIRGIN_3",
	]},

	virgin_mean = {
	conditions = {
		consent = [false],
		virgin = [true],
	},
	lines = [
		"SEXDICT_MAIN_2_SEXV_VIRGIN_MEAN_1",
	]},

	insert = {
	conditions = {
		virgin = [false],
		orifice = ["swap","insert"],
	},
	lines = [
		"SEXDICT_MAIN_2_SEXV_INSERT_1",
		"SEXDICT_MAIN_2_SEXV_INSERT_2",
	]},

	shift = {
	conditions = {
		virgin = [false],
		orifice = ["shift"],
	},
	lines = [
		"SEXDICT_MAIN_2_SEXV_SHIFT_1",
	]},

	nonrepeat = {
	conditions = {
		virgin = [false],
		orifice = ["shift","swap"]
	},
	lines = [
		"SEXDICT_MAIN_2_SEXV_NONREPEAT_1",
	]},

	repeat = {
	conditions = {
		virgin = [false],
		orifice = ["same"]
	},
	lines = [
		"SEXDICT_MAIN_2_SEXV_REPEAT_1",
	]},

},

main_2_sexa = {

	virgin = {
	conditions = {
		virgin = [true],
	},
	lines = [
		"SEXDICT_MAIN_2_SEXA_VIRGIN_1",
		"SEXDICT_MAIN_2_SEXA_VIRGIN_2",
	]},

	virgin_mean = {
	conditions = {
		consent = [false],
		virgin = [true],
	},
	lines = [
		"SEXDICT_MAIN_2_SEXA_VIRGIN_MEAN_1",
	]},

	insert = {
	conditions = {
		virgin = [false],
		orifice = ["swap","insert"],
	},
	lines = [
		"SEXDICT_MAIN_2_SEXA_INSERT_1",
		"SEXDICT_MAIN_2_SEXA_INSERT_2",
	]},

	shift = {
	conditions = {
		virgin = [false],
		orifice = ["shift"],
	},
	lines = [
		"SEXDICT_MAIN_2_SEXA_SHIFT_1",
	]},

	nonrepeat = {
	conditions = {
		virgin = [false],
		orifice = ["shift","swap"]
	},
	lines = [
		"SEXDICT_MAIN_2_SEXA_NONREPEAT_1",
	]},

	repeat = {
	conditions = {
		virgin = [false],
		orifice = ["same"]
	},
	lines = [
		"SEXDICT_MAIN_2_SEXA_REPEAT_1",
	]},

},

main_2_fsexv = {

	virgin = {
	conditions = {
		virgin = [true],
	},
	lines = [
		"SEXDICT_MAIN_2_FSEXV_VIRGIN_1",
		"SEXDICT_MAIN_2_FSEXV_VIRGIN_2",
		"SEXDICT_MAIN_2_FSEXV_VIRGIN_3",
	]},

},

main_2_fsexa = {

	virgin = {
	conditions = {
		virgin = [true],
	},
	lines = [
		"SEXDICT_MAIN_2_FSEXA_VIRGIN_1",
		"SEXDICT_MAIN_2_FSEXA_VIRGIN_2",
	]},

},

main_3_sex = {

	default = {
	conditions = {
	},
	lines = [
		"SEXDICT_MAIN_3_SEX_DEFAULT_1",
	]},

},

react_1_sex = {

	arousal_4_nice = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		"SEXDICT_REACT_1_SEX_AROUSAL_4_NICE_1",
		"SEXDICT_REACT_1_SEX_AROUSAL_4_NICE_2",
		"SEXDICT_REACT_1_SEX_AROUSAL_4_NICE_3",
		"SEXDICT_REACT_1_SEX_AROUSAL_4_NICE_4",
	]},

	arousal_4_mean = {
	conditions = {
		consent = [false],
		arousal = [4,5],
	},
	lines = [
		"SEXDICT_REACT_1_SEX_AROUSAL_4_MEAN_1",
		"SEXDICT_REACT_1_SEX_AROUSAL_4_MEAN_2",
		"SEXDICT_REACT_1_SEX_AROUSAL_4_MEAN_3",
	]},

	arousal_3_nice = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		"SEXDICT_REACT_1_SEX_AROUSAL_3_NICE_1",
		"SEXDICT_REACT_1_SEX_AROUSAL_3_NICE_2",
		"SEXDICT_REACT_1_SEX_AROUSAL_3_NICE_3",
	]},

	arousal_3_mean = {
	conditions = {
		consent = [false],
		arousal = [3],
	},
	lines = [
		"SEXDICT_REACT_1_SEX_AROUSAL_3_MEAN_1",
		"SEXDICT_REACT_1_SEX_AROUSAL_3_MEAN_2",
		"SEXDICT_REACT_1_SEX_AROUSAL_3_MEAN_3",
	]},

	arousal_2_nice = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		"SEXDICT_REACT_1_SEX_AROUSAL_2_NICE_1",
		"SEXDICT_REACT_1_SEX_AROUSAL_2_NICE_2",
		"SEXDICT_REACT_1_SEX_AROUSAL_2_NICE_3",
	]},

	arousal_2_mean = {
	conditions = {
		consent = [false],
		arousal = [2],
	},
	lines = [
		"SEXDICT_REACT_1_SEX_AROUSAL_2_MEAN_1",
		"SEXDICT_REACT_1_SEX_AROUSAL_2_MEAN_2",
		"SEXDICT_REACT_1_SEX_AROUSAL_2_MEAN_3",
	]},

	arousal_1_nice = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		"SEXDICT_REACT_1_SEX_AROUSAL_1_NICE_1",
		"SEXDICT_REACT_1_SEX_AROUSAL_1_NICE_2",
		"SEXDICT_REACT_1_SEX_AROUSAL_1_NICE_3",
	]},

	arousal_1_mean = {
	conditions = {
		consent = [false],
		arousal = [1],
	},
	lines = [
		"SEXDICT_REACT_1_SEX_AROUSAL_1_MEAN_1",
		"SEXDICT_REACT_1_SEX_AROUSAL_1_MEAN_2",
		"SEXDICT_REACT_1_SEX_AROUSAL_1_MEAN_3",
	]},

	taker_mastered_nice = {
	conditions = {
		consent = [true],
		taker_skill_level = ['mastered'],
	},
	lines = [
		"SEXDICT_REACT_1_SEX_TAKER_MASTERED_NICE_1",
		"SEXDICT_REACT_1_SEX_TAKER_MASTERED_NICE_2",
	]},

	taker_skilled_nice = {
	conditions = {
		consent = [true],
		taker_skill_level = ['skilled'],
	},
	lines = [
		"SEXDICT_REACT_1_SEX_TAKER_SKILLED_NICE_1",
		"SEXDICT_REACT_1_SEX_TAKER_SKILLED_NICE_2",
	]},

	taker_novice_nice = {
	conditions = {
		consent = [true],
		taker_skill_level = ['novice'],
	},
	lines = [
		"SEXDICT_REACT_1_SEX_TAKER_NOVICE_NICE_1",
		"SEXDICT_REACT_1_SEX_TAKER_NOVICE_NICE_2",
	]},

	taker_mastered_mean = {
	conditions = {
		consent = [false],
		taker_skill_level = ['mastered'],
	},
	lines = [
		"SEXDICT_REACT_1_SEX_TAKER_MASTERED_MEAN_1",
		"SEXDICT_REACT_1_SEX_TAKER_MASTERED_MEAN_2",
	]},

	taker_skilled_mean = {
	conditions = {
		consent = [false],
		taker_skill_level = ['skilled'],
	},
	lines = [
		"SEXDICT_REACT_1_SEX_TAKER_SKILLED_MEAN_1",
	]},

	taker_novice_mean = {
	conditions = {
		consent = [false],
		taker_skill_level = ['novice'],
	},
	lines = [
		"SEXDICT_REACT_1_SEX_TAKER_NOVICE_MEAN_1",
		"SEXDICT_REACT_1_SEX_TAKER_NOVICE_MEAN_2",
	]},

},

react_1_fsex = {

	arousal_4 = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		"SEXDICT_REACT_1_FSEX_AROUSAL_4_1",
		"SEXDICT_REACT_1_FSEX_AROUSAL_4_2",
		"SEXDICT_REACT_1_FSEX_AROUSAL_4_3",
		"SEXDICT_REACT_1_FSEX_AROUSAL_4_4",
	]},

	arousal_3 = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		"SEXDICT_REACT_1_FSEX_AROUSAL_3_1",
		"SEXDICT_REACT_1_FSEX_AROUSAL_3_2",
		"SEXDICT_REACT_1_FSEX_AROUSAL_3_3",
	]},

	arousal_2 = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		"SEXDICT_REACT_1_FSEX_AROUSAL_2_1",
		"SEXDICT_REACT_1_FSEX_AROUSAL_2_2",
		"SEXDICT_REACT_1_FSEX_AROUSAL_2_3",
	]},

	arousal_1 = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		"SEXDICT_REACT_1_FSEX_AROUSAL_1_1",
		"SEXDICT_REACT_1_FSEX_AROUSAL_1_2",
		"SEXDICT_REACT_1_FSEX_AROUSAL_1_3",
	]},

},

react_2_sex = {

	arousal_4_nice = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		"SEXDICT_REACT_2_SEX_AROUSAL_4_NICE_1",
		"SEXDICT_REACT_2_SEX_AROUSAL_4_NICE_2",
		"",
	]},

	arousal_4_mean = {
	conditions = {
		consent = [false],
		arousal = [4,5],
	},
	lines = [
		"SEXDICT_REACT_2_SEX_AROUSAL_4_MEAN_1",
		"SEXDICT_REACT_2_SEX_AROUSAL_4_MEAN_2",
		"",
	]},

	arousal_3_nice = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		"SEXDICT_REACT_2_SEX_AROUSAL_3_NICE_1",
		"SEXDICT_REACT_2_SEX_AROUSAL_3_NICE_2",
		"",
	]},

	arousal_3_mean = {
	conditions = {
		consent = [false],
		arousal = [3],
	},
	lines = [
		"SEXDICT_REACT_2_SEX_AROUSAL_3_MEAN_1",
		"SEXDICT_REACT_2_SEX_AROUSAL_3_MEAN_2",
		"",
	]},

	arousal_2_nice = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		"SEXDICT_REACT_2_SEX_AROUSAL_2_NICE_1",
		"SEXDICT_REACT_2_SEX_AROUSAL_2_NICE_2",
		"",
	]},

	arousal_2_mean = {
	conditions = {
		consent = [false],
		arousal = [2],
	},
	lines = [
		"SEXDICT_REACT_2_SEX_AROUSAL_2_MEAN_1",
		"SEXDICT_REACT_2_SEX_AROUSAL_2_MEAN_2",
		"",
	]},

	arousal_1_nice = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		"SEXDICT_REACT_2_SEX_AROUSAL_1_NICE_1",
		"SEXDICT_REACT_2_SEX_AROUSAL_1_NICE_2",
		"",
	]},

	arousal_1_mean = {
	conditions = {
		consent = [false],
		arousal = [1],
	},
	lines = [
		"SEXDICT_REACT_2_SEX_AROUSAL_1_MEAN_1",
		"SEXDICT_REACT_2_SEX_AROUSAL_1_MEAN_2",
		"",
	]},

	giver_mastered_nice = {
	conditions = {
		consent = [true],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXDICT_REACT_2_SEX_GIVER_MASTERED_NICE_1",
		"SEXDICT_REACT_2_SEX_GIVER_MASTERED_NICE_2",
		"",
	]},

	giver_skilled_nice = {
	conditions = {
		consent = [true],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXDICT_REACT_2_SEX_GIVER_SKILLED_NICE_1",
		"",
	]},

	giver_novice_nice = {
	conditions = {
		consent = [true],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXDICT_REACT_2_SEX_GIVER_NOVICE_NICE_1",
		"",
	]},

	giver_mastered_mean = {
	conditions = {
		consent = [false],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"SEXDICT_REACT_2_SEX_GIVER_MASTERED_MEAN_1",
		"",
	]},

	giver_skilled_mean = {
	conditions = {
		consent = [false],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"SEXDICT_REACT_2_SEX_GIVER_SKILLED_MEAN_1",
		"",
	]},

	giver_novice_mean = {
	conditions = {
		consent = [false],
		giver_skill_level = ['novice'],
	},
	lines = [
		"SEXDICT_REACT_2_SEX_GIVER_NOVICE_MEAN_1",
		"",
	]},

},

react_2_fsex = {

	arousal_4 = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		"SEXDICT_REACT_2_FSEX_AROUSAL_4_1",
		"SEXDICT_REACT_2_FSEX_AROUSAL_4_2",
		"",
	]},

	arousal_3 = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		"SEXDICT_REACT_2_FSEX_AROUSAL_3_1",
		"SEXDICT_REACT_2_FSEX_AROUSAL_3_2",
		"",
	]},

	arousal_2 = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		"SEXDICT_REACT_2_FSEX_AROUSAL_2_1",
		"SEXDICT_REACT_2_FSEX_AROUSAL_2_2",
		"",
	]},

	arousal_1 = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		"SEXDICT_REACT_2_FSEX_AROUSAL_1_1",
		"SEXDICT_REACT_2_FSEX_AROUSAL_1_2",
		"",
	]},

},

react_3_sexv = {

	default = {
	conditions = {
	},
	lines = [
		"SEXDICT_REACT_3_SEXV_DEFAULT_1",
		"SEXDICT_REACT_3_SEXV_DEFAULT_2",
		"SEXDICT_REACT_3_SEXV_DEFAULT_3",
	]},

},

react_3_sexa = {

	default = {
	conditions = {
	},
	lines = [
		"SEXDICT_REACT_3_SEXA_DEFAULT_1",
		"SEXDICT_REACT_3_SEXA_DEFAULT_2",
		"SEXDICT_REACT_3_SEXA_DEFAULT_3",
	]},

},

react_3_fsexv = {

	default = {
	conditions = {
	},
	lines = [
		"SEXDICT_REACT_3_FSEXV_DEFAULT_1",
		"SEXDICT_REACT_3_FSEXV_DEFAULT_2",
		"SEXDICT_REACT_3_FSEXV_DEFAULT_3",
	]},

},

react_3_fsexa = {

	default = {
	conditions = {
	},
	lines = [
		"SEXDICT_REACT_3_FSEXA_DEFAULT_1",
		"SEXDICT_REACT_3_FSEXA_DEFAULT_2",
		"SEXDICT_REACT_3_FSEXA_DEFAULT_3",
	]},

},

}
