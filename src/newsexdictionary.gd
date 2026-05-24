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
		"[name2] {^wraps:hooks}[s/2] [his2] legs around [name1]",
		"[name2] {^pulls:draws}[s/2] [name1] {^closer:in}",
		"[name2] {^arches:lifts}[s/2] [his2] hips to meet [name1]",
	]},

	repeat_mean = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^pin[s/1]:hold[s/1]} [name2] down as [he2] {^squirm[s/2]:writh[es/2]}",
		"[name2] {^tr[ies/y2] to push:attempt[s/2] to push} [name1] away",
		"[name2] {^whimper[s/2]:protest[s/2]} as [name1] {^press[es/1]:push[es/1]} [him2] into the {^mattress:sheets}",
	]},

	lotus_nice = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [true],
	},
	lines = [
		"[name2] {^let[s/2] [himself2]:allow[s/2] [himself2] to be} lowered onto [his2] back[/s2] as [name1] climb[s/1] {^atop:on top of} [him2]",
		"[name2] {^shifts:rolls}[s/2] onto [his2] back[/s2] and [name1] settle[s/1] {^atop:over} [him2]",
	]},

	lotus_mean = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [false],
	},
	lines = [
		"[name2] {^squirm[s/2]:struggle[s/2]} as [name1] {^push[es/1]:force[s/1]} [him2] onto [his2] back[/s2]",
		"[name1] {^push[es/1]:shove[s/1]} [name2] onto [his2] back[/s2] despite [his2] {^protests:resistance}",
	]},

	revlotus_nice = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [true],
	},
	lines = [
		"[name2] {^let[s/2] [himself2]:allow[s/2] [himself2] to be} flipped over onto [his2] back",
		"[name2] {^rolls:shifts}[s/2] over onto [his2] back as [name1] guide[s/1] [him2]",
	]},

	revlotus_mean = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [false],
	},
	lines = [
		"[name2] {^struggle[s/2]:resist[s/2]} as [name1] {^flip[s/1]:force[s/1]} [him2] over onto [his2] back",
		"[name1] {^flip[s/1]:turn[s/1]} [name2] over despite [his2] {^protests:resistance}",
	]},

	doggy_nice = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [true],
	},
	lines = [
		"[name2] {^rolls:turns}[s/2] over onto [his2] back[/s2] and [name1] climb[s/1] {^atop:on top of} [him2]",
		"[name2] {^let[s/2] [himself2]:allow[s/2] [himself2] to be} flipped over as [name1] settle[s/1] {^atop:over} [him2]",
	]},

	doggy_mean = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [false],
	},
	lines = [
		"[name2] {^struggle[s/2]:squirm[s/2]} as [name1] {^flip[s/1]:force[s/1]} [him2] onto [his2] back[/s2]",
		"[name1] {^yank[s/1]:jerk[s/1]} [name2] onto [his2] back[/s2] as [he2] {^protest[s/2]:resist[s/2]}",
	]},

	insert_nice = {
	conditions = {
		link = [null],
		consent = [true],
	},
	lines = [
		"[name2] {^lies:settles}[s/2] down{^ on [his2] back:} as [name1] {^moves:climbs}[s/1] {^atop:on top of} [him2]",
		"[name2] {^shifts:moves}[s/2] onto [his2] back, letting [name1] {^settle:climb} {^atop:over} [him2]",
	]},

	insert_mean = {
	conditions = {
		link = [null],
		consent = [false],
	},
	lines = [
		"[name2] {^squirm[s/2]:struggle[s/2]} as [name1] {^pin[s/1]:hold[s/1]} [him2] down{^ on [his2] back:}",
		"[name1] {^force[s/1]:push[es/1]} [name2] onto [his2] back as [he2] {^tr[ies/y2] to resist:protest[s/2]}",
	]},

},

start_1_doggy = {

	repeat_nice = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [true],
	},
	lines = [
		"[name2] {^push[es/2]:rock[s/2]} back against [name1]",
		"[name2] {^arches:raises}[s/2] [his2] back, {^inviting:welcoming} [name1] deeper",
		"[name2] {^grips:clutches}[s/2] the {^sheets:bedding} as [name1] continues",
	]},

	repeat_mean = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^hold[s/1]:pin[s/1]} [name2] in place as [he2] {^tr[ies/y2] to pull away:attempt[s/2] to escape}",
		"[name2] {^whimper[s/2]:whin[es/2]:protest[s/2]} as [name1] {^hold[s/1]:keep[s/1]} [him2] from moving",
		"[name2] {^struggle[s/2]:squirm[s/2]} against [name1]'s grip",
	]},

	lotus_nice = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [true],
	},
	lines = [
		"[name2] {^let[s/2] [himself2]:allow[s/2] [himself2] to be} guided onto {^all fours:[his2] hands and knees}",
		"[name2] {^shifts:rolls}[s/2] forward onto {^all fours:[his2] knees} as [name1] direct[s/1] [him2]",
	]},

	lotus_mean = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [false],
	},
	lines = [
		"[name2] {^squirm[s/2]:struggle[s/2]} as [name1] {^push[es/1]:shove[s/1]} [him2] onto {^all fours:[his2] hands and knees}",
		"[name1] {^force[s/1]:push[es/1]} [name2] forward onto {^all fours:[his2] knees} despite [his2] {^protests:resistance}",
	]},

	revlotus_nice = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [true],
	},
	lines = [
		"[name2] {^let[s/2] [himself2]:shift[s/2]} forward onto {^all fours:[his2] hands and knees}",
		"[name2] {^moves:settles}[s/2] into position as [name1] guide[s/1] [him2]",
	]},

	revlotus_mean = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [false],
	},
	lines = [
		"[name2] {^resist[s/2]:struggle[s/2]} as [name1] {^force[s/1]:push[es/1]} [him2] forward onto {^all fours:[his2] knees}",
		"[name1] {^push[es/1]:shove[s/1]} [name2] into position as [he2] {^protest[s/2]:squirm[s/2]}",
	]},

	missionary_nice = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [true],
	},
	lines = [
		"[name2] {^rolls:turns}[s/2] over onto {^all fours:[his2] hands and knees}",
		"[name2] {^shifts:moves}[s/2] onto {^all fours:[his2] knees} as [name1] guide[s/1] [him2]",
	]},

	missionary_mean = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [false],
	},
	lines = [
		"[name2] {^squirm[s/2]:struggle[s/2]} as [name1] {^flip[s/1]:force[s/1]} [him2] onto {^all fours:[his2] hands and knees}",
		"[name1] {^yank[s/1]:jerk[s/1]} [name2] over as [he2] {^protest[s/2]:resist[s/2]}",
	]},

	insert_nice = {
	conditions = {
		link = [null],
		consent = [true],
	},
	lines = [
		"[name2] {^get[s/2] on all fours:position[s/2] [himself2]} as [name1] move[s/1] behind [him2]",
		"[name2] {^arches:raises}[s/2] [his2] back, {^presenting:offering} [himself2] to [name1]",
	]},

	insert_mean = {
	conditions = {
		link = [null],
		consent = [false],
	},
	lines = [
		"[name2] {^struggle[s/2]:resist[s/2]} as [name1] {^force[s/1]:push[es/1]} [him2] onto [his2] hands and knees",
		"[name1] {^pin[s/1]:hold[s/1]} [name2] down {^on all fours:on [his2] knees} as [he2] {^squirm[s/2]:protest[s/2]}",
	]},

},

start_1_lotus = {

	repeat_nice = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^hold[s/1]:grasp[s/1]:stead[ies/y1]} [name2] by [his2] [hips2]",
		"[name1] {^squeeze:knead:massage}[s/1] [names2] {^ass:butt}cheeks",
		"[name1] {^hug:hold:squeeze}[s/1] [name2] close to [his1] bod[y/ies1]",
	]},

	repeat_mean = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^roughly :}{^squeeze:knead}[s/1] [names2] {^ass:butt}cheeks",
		"[name1] {^roughly :}{^grabs[s/1]:seize[s/1]} [name2] by [his2] [hips2]",
	]},

	revlotus_nice = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^carefully :}{^flip:spin:turn}[s/1] [name2] {^around on [his1] lap[/s1]:to face [him1]}",
		"[name1] {^grab:hold}[s/1] [name2] by [his2] [hips2] and {^flip:spin:turn}[s/1] [him2] around on [his1] lap[/s1]",
	]},

	revlotus_mean = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^nonchalantly :}{^flip:spin:turn}[s/1] [name2] {^around on [his1] lap[/s1]:to face [him1]}",
		"[name1] {^grab:seize}[s/1] [name2] by [his2] [hips2] and {^flip:spin:turn}[s/1] [him2] around on [his1] lap[/s1]",
	]},

	missionary_nice = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^pull:guide}[s/1] [name2] up {^onto [his1] lap[/s1]:on top of [him1]:to face [him1]}",
		"[name1] {^lift:guide:pull}[s/1] [name2] up off [his2] back and onto [his1] lap[/s1]",
	]},

	missionary_mean = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^jerk:yank}[s/1] [name2] up {^onto [his1] lap[/s1]:on top of [him1]:to face [him1]}",
		"[name1] {^yank:jerk:pull}[s/1] [name2] up off [his2] back and onto [his1] lap[/s1]",
	]},

	doggy_nice = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^flip:roll:turn}[s/1] [name2] over and {^pull:guide}[s/1] [him2] up {^onto [his1] lap[/s1]:on top of [him1]:to face [him1]}",
		"[name1] {^lift:guide:pull}[s/1] [name2] up off [his2] hands and knees and {^flip:spin:turn}[s/1] [him2] around onto [his1] lap[/s1]",
	]},

	doggy_mean = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^flip:roll:turn}[s/1] [name2] over and {^jerk:yank}[s/1] [him2] up {^onto [his1] lap[/s1]:on top of [him1]:to face [him1]}",
		"[name1] {^yank:jerk:pull}[s/1] [name2] up off [his2] hands and knees and {^flip:spin:turn}[s/1] [him2] around onto [his1] lap[/s1]",
	]},

	insert_nice = {
	conditions = {
		link = [null],
		consent = [true],
	},
	lines = [
		"[name1] {^gently :}{^pull:guide}[s/1] [name2] onto [his1] lap[/s1]",
		"[name1] {^grab:hold}[s/1] [name2] by [his2] [hips2] and {^lower:drop}[s/1] [him2] onto [his1] lap[/s1]",
	]},

	insert_mean = {
	conditions = {
		link = [null],
		consent = [false],
	},
	lines = [
		"[name1] {^roughly :}{^jerk:yank}[s/1] [name2] onto [his1] lap[/s1]",
		"[name1] {^grab:seize}[s/1] [name2] by [his2] [hips2] and {^pull:drop}[s/1] [him2] onto [his1] lap[/s1]",
	]},

},

start_1_revlotus = {

	repeat_nice = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^hold:lift}[s/1] [names2] thighs apart",
		"[name1] {^hold[s/1]:grasp[s/1]:stead[ies/y1]} [name2] by [his2] {^[hips2]:thighs}",
		"[name1] {^hug:hold:squeeze}[s/1] [name2] close to [his1] bod[y/ies1]",
	]},

	repeat_mean = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^roughly :}{^pull[s/1]:spread[s/1]:hold[s/1]} [names2] thighs apart",
		"[name1] {^roughly :}{^grabs[s/1]:seize[s/1]} [name2] by [his2] [hips2]",
	]},

	lotus_nice = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^carefully :}{^flip:spin:turn}[s/1] [name2] {^around on [his1] lap[/s1]:to face away from [him1]}",
		"[name1] {^grab:hold}[s/1] [name2] by [his2] [hips2] and {^flip:spin:turn}[s/1] [him2] around on [his1] lap[/s1]",
	]},

	lotus_mean = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^nonchalantly :}{^flip:spin:turn}[s/1] [name2] {^around on [his1] lap[/s1]:to face away from [him1]}",
		"[name1] {^grab:seize}[s/1] [name2] by [his2] [hips2] and {^flip:spin:turn}[s/1] [him2] around on [his1] lap[/s1]",
	]},

	doggy_nice = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^pull:guide}[s/1] [name2] up {^onto [his1] lap[/s1]:on top of [him1]:against [him1]}",
		"[name1] {^lift:guide:pull}[s/1] [name2] up off [his2] hands and knees and onto [his1] lap[/s1]",
	]},

	doggy_mean = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^jerk:yank}[s/1] [name2] up {^onto [his1] lap[/s1]:on top of [him1]:against [him1]}",
		"[name1] {^yank:jerk:pull}[s/1] [name2] up off [his2] hands and knees and onto [his1] lap[/s1]",
	]},

	missionary_nice = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^flip:roll:turn}[s/1] [name2] over and {^pull:guide}[s/1] [him2] up {^onto [his1] lap[/s1]:on top of [him1]:against [him1]}",
		"[name1] {^lift:guide:pull}[s/1] [name2] up off [his2] back and {^flip:spin:turn}[s/1] [him2] around onto [his1] lap[/s1]",
	]},

	missionary_mean = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^flip:roll:turn}[s/1] [name2] over and {^jerk:yank}[s/1] [him2] up {^onto [his1] lap[/s1]:on top of [him1]:against [him1]}",
		"[name1] {^yank:jerk:pull}[s/1] [name2] up off [his2] hands and knees and {^flip:spin:turn}[s/1] [him2] around onto [his1] lap[/s1]",
	]},

	insert_nice = {
	conditions = {
		link = [null],
		consent = [true],
	},
	lines = [
		"[name1] {^flip:spin:turn}[s/1] [name2] around and {^gently :}{^pull:guide}[s/1] [him2] onto [his1] lap[/s1]",
		"[name1] {^grab:hold}[s/1] [name2] by [his2] [hips2] and {^flip:spin:turn}[s/1] [him2] around onto [his1] lap[/s1]",
	]},

	insert_mean = {
	conditions = {
		link = [null],
		consent = [false],
	},
	lines = [
		"[name1] {^flip:spin:turn}[s/1] [name2] around and {^roughly :}{^jerk:yank}[s/1] [him2] onto [his1] lap[/s1]",
		"[name1] {^grab:seize}[s/1] [name2] by [his2] [hips2] and {^flip:spin:turn}[s/1] [him2] around onto [his1] lap[/s1]",
	]},

},

start_2_sexv = {

	same = {
	conditions = {
		orifice = ["same"],
	},
	lines = [
		", {^picking up the:increasing [his1]} pace {^slightly :a bit :}as [he1] {^work:pump:move}[s/1] [his1] hips. ",
		", enjoying {^[himself1]:sensations of [partners2] [body2]} far too much to {^stop now:consider stopping}. ",
		", trying to {^take in:absorb} {^every detail:each second} of the {^tantilizing:erotic:sensual} display {^unfolding:playing out} {^before:in front of} [his1] eyes. ",
	]},

	same_giver_mastered_nice = {
	conditions = {
		orifice = ["same"],
		consent = [true],
		giver_skill_level = ['mastered'],
	},
	lines = [
		", {^immediately:quickly} locking into a {^precise:perfect} rhythm as if [he1] never stopped. ",
	]},

	same_giver_skilled_nice = {
	conditions = {
		orifice = ["same"],
		consent = [true],
		giver_skill_level = ['skilled'],
	},
	lines = [
		", {^settling:falling} back into a {^comfortable:steady} pace without missing a beat. ",
	]},

	same_giver_novice_nice = {
	conditions = {
		orifice = ["same"],
		consent = [true],
		giver_skill_level = ['novice'],
	},
	lines = [
		", {^taking a moment:needing a beat} to {^find:reestablish} [his1] rhythm. ",
	]},

	holeswap = {
	conditions = {
		orifice = ["swap"],
	},
	lines = [
		", {^pulling:removing} [his1] [penis1] from [names2] [anus2] and {^aligning it:lining it up} with [his2] [pussy2] instead. ",
		", {^slipping:sliding} [himself1] out from [names2] [anus2] and {^probing:pushing} into the {^entrance:mouth} of [his2] [pussy2]. ",
	]},

	insert = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
	},
	lines = [
		", {^aligning:lining up} [his1] [penis1] with the {^entrance:mouth} of [his2] [pussy2]. ",
		", {^probing:pressing} {^the tip of :}[his1] [penis1] into the {^entrance:mouth} of [his2] [pussy2]. ",
	]},

	insert_giver_mastered_nice = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [true],
		giver_skill_level = ['mastered'],
	},
	lines = [
		", {^pressing:sliding} inside [name2] at exactly the right angle, drawing a sharp breath from [him2]. ",
	]},

	insert_giver_skilled_nice = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [true],
		giver_skill_level = ['skilled'],
	},
	lines = [
		", {^lining:aligning} [himself1] up carefully before {^pressing:sliding} inside [name2]. ",
	]},

	insert_giver_mastered_mean = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [false],
		giver_skill_level = ['mastered'],
	},
	lines = [
		", {^driving:forcing} [himself1] inside with {^practiced:deliberate} control, leaving [name2] no room to resist. ",
	]},

	insert_giver_skilled_mean = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [false],
		giver_skill_level = ['skilled'],
	},
	lines = [
		", {^pushing:forcing} [himself1] inside despite [name2]'s {^resistance:protests}. ",
	]},

	insert_giver_novice_nice = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [true],
		giver_skill_level = ['novice'],
	},
	lines = [
		", {^fumbling:struggling} to find the right angle before {^pressing:pushing} inside [name2]. ",
	]},

	insert_taker_mastered_nice = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [true],
		taker_skill_level = ['mastered'],
	},
	lines = [
		", [name2] {^tilt[s/2]:angle[s/2]} [his2] hips to {^take [name1] more easily:guide [name1] to the right spot}. ",
	]},

	insert_taker_skilled_nice = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [true],
		taker_skill_level = ['skilled'],
	},
	lines = [
		", [name2] {^exhale[s/2]:relax[es/2]}, {^consciously:deliberately} opening up for [name1]. ",
	]},

	insert_taker_novice_nice = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [true],
		taker_skill_level = ['novice'],
	},
	lines = [
		", [name2] {^clench[es/2]:tighten[s/2]} instinctively as [name1] {^press[es/1]:push[es/1]} inside. ",
	]},

	insert_taker_skilled_mean = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [false],
		taker_skill_level = ['skilled'],
	},
	lines = [
		", [name2] {^clench[es/2]:tighten[s/2]} involuntarily as [name1] {^enter[s/1]:push[es/1] inside} [him2]. ",
	]},

	insert_taker_novice_mean = {
	conditions = {
		orifice = ["insert"],
		taker_fingering_ongoing = [false],
		consent = [false],
		taker_skill_level = ['novice'],
	},
	lines = [
		", [name2] {^lock[s/2]:seize[s/2]} up as [name1] {^force[s/1]:push[es/1]} inside [him2]. ",
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
		", {^picking up the:increasing [his1]} pace {^slightly :a bit :}as [he1] {^work:pump:move}[s/1] [his1] hips. ",
		", enjoying {^[himself1]:sensations of [partners2] [body2]} far too much to {^stop now:consider stopping}. ",
		", trying to {^take in:absorb} {^every detail:each second} of the {^tantilizing:erotic:sensual} display {^unfolding:playing out} {^before:in front of} [his1] eyes. ",
	]},

	holeswap = {
	conditions = {
		orifice = ["swap"],
	},
	lines = [
		", {^pulling:removing} [his1] [penis1] from [names2] [pussy2] and {^aligning it:lining it up} with [his2] [anus2] instead. ",
		", {^slipping:sliding} [himself1] out from [names2] [pussy2] and {^probing:pushing} into the {^entrance:mouth} of [his2] [anus2]. ",
	]},

	insert = {
	conditions = {
		orifice = ["insert"],
	},
	lines = [
		", {^aligning:lining up} [his1] [penis1] with the {^entrance:mouth} of [his2] [anus2]. ",
		", {^probing:pressing} {^the tip of :}[his1] [penis1] into the {^entrance:mouth} of [his2] [anus2]. ",
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
		"[name2] {^hug:hold:squeeze:embrace}[s/2] [name1] as closely as [he2] can",
		"[name2] throw[s/2] [his2] arms around [name1]",
		"[name2] {^wrap:hook}[s/2] [his2] legs around [name1]",
	]},

	facing_nice = {
	conditions = {
		virgin = [false],
		facing = [true],
		consent = [true],
	},
	lines = [
		"[name2] {^stare:glance:look}[s/2] {^longingly:wistfully:coquettishly} into [names1] eyes",
	]},

	facing_mean = {
	conditions = {
		virgin = [false],
		facing = [true],
		consent = [false],
	},
	lines = [
		"[name2] {^turn:look}[s/2] away from [name1] in {^shame:humiliation}",
		"[name2] {^helplessly :fruitlessly :}tr[ies/y2] to {^push:move} away",
	]},

	nonfacing_nice = {
	conditions = {
		virgin = [false],
		facing = [false],
		consent = [true],
	},
	lines = [
		"[name2] {^push:press}[es/2] [himself2] {^back:backward} against [name1]",
		"[name2] {^stare:glance:look}[s/2] {^longingly:wistfully:coquettishly} {^back:backward} {^over [his2] shoulder :}at [name1]",
	]},

	nonfacing_mean = {
	conditions = {
		virgin = [false],
		facing = [false],
		consent = [false],
	},
	lines = [
		"[name2] {^helplessly :fruitlessly :}tr[ies/y2] to {^pull:move} away",
	]},

	virgin_nice = {
	conditions = {
		virgin = [true],
		consent = [true],
	},
	lines = [
		"[name2] brace[s/2] [himself2], holding [his2] breath",
		"[name2] steels [his2] resolve, trying to {^look:seem} brave",
		"[names2] {^nethers:genitals} {^stretch to make room:widen to a new shape:offer some resistance}",
	]},

	virgin_mean = {
	conditions = {
		virgin = [true],
		consent = [false],
	},
	lines = [
		"[name2] brace[s/2] [himself2], tears forming in [his2] eyes",
		"[name2] reels with {^horror:terror:dread:shock}",
		"[names2] {^nethers:genitals} {^stretch:permanently widen:offer resistance}",
	]},

	virgin_facing_nice = {
	conditions = {
		virgin = [true],
		facing = [true],
		consent = [true],
	},
	lines = [
		"[name2] stare[s/2] down with wide eyes",
	]},

	virgin_facing_mean = {
	conditions = {
		virgin = [true],
		facing = [true],
		consent = [false],
	},
	lines = [
		"[name2] stare[s/2] down in {^horror:terror:dread:shock}",
	]},

	virgin_nonfacing_nice = {
	conditions = {
		virgin = [true],
		facing = [false],
		consent = [true],
	},
	lines = [
		"[name2] stare[s/2] back with wide eyes",
	]},

	virgin_nonfacing_mean = {
	conditions = {
		virgin = [true],
		facing = [false],
		consent = [false],
	},
	lines = [
		"[name2] stare[s/2] back in {^horror:terror:dread:shock}",
	]},

	nice = {
	conditions = {
		virgin = [false],
		consent = [true],
	},
	lines = [
		"[name2] arch[es/2] [his2] back",
		"[name2] {^spread[s/2]:part[s/2]} [his2] thighs {^to allow [name1] deeper:to give [name1] better access}",
	]},

	mean = {
	conditions = {
		virgin = [false],
		consent = [false],
	},
	lines = [
		"[name2] {^helplessly :fruitlessly :}struggle[s/2] against [name1]",
	]},

	insert = {
	conditions = {
		virgin = [false],
		orifice = ["insert"]
	},
	lines = [
		"[names2] [labia2] {^envelop:spread apart for:swallow} [names1] [penis1]",
	]},

	noninsert = {
	conditions = {
		virgin = [false],
		orifice = ["same","shift","swap"]
	},
	lines = [
		"[names2] [labia2] {^slide along:coil around:tug at} [names1] [penis1]",
	]},

	giver_mastered_nice = {
	conditions = {
		virgin = [false],
		consent = [true],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"[name1] {^adjust[s/1]:shift[s/1]} [his1] angle to {^draw out:elicit} a gasp from [name2]",
		"[name1] {^read[s/1]:sense[s/1]} every shift in [name2]'s body and {^respond[s/1]:adjust[s/1]} accordingly",
	]},

	giver_skilled_nice = {
	conditions = {
		virgin = [false],
		consent = [true],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"[name1] {^maintain[s/1]:keep[s/1]} a {^steady:consistent} pace, {^watching:reading} [name2]'s reactions",
	]},

	giver_novice_nice = {
	conditions = {
		virgin = [false],
		consent = [true],
		giver_skill_level = ['novice'],
	},
	lines = [
		"[name1] {^thrust[s/1]:move[s/1]} {^at the wrong angle:unevenly}, still finding [his1] footing",
		"[name1] {^fumble[s/1]:struggle[s/1]} to maintain a rhythm",
	]},

	taker_mastered_nice = {
	conditions = {
		virgin = [false],
		consent = [true],
		taker_skill_level = ['mastered'],
	},
	lines = [
		"[name2] {^clench[es/2]:squeeze[s/2]} around [name1] at exactly the right moment",
		"[name2] {^angle[s/2]:tilt[s/2]} [his2] hips to {^take [name1] deeper:draw [name1] in further}",
	]},

	taker_skilled_nice = {
	conditions = {
		virgin = [false],
		consent = [true],
		taker_skill_level = ['skilled'],
	},
	lines = [
		"[name2] {^start[s/2]:begin[s/2]} to {^rock:shift}[s/2] [his2] hips {^with:in time with} [name1]",
		"[name2] {^consciously:deliberately} {^relax[es/2]:open[s/2] up} around [name1]",
	]},

	taker_novice_nice = {
	conditions = {
		virgin = [false],
		consent = [true],
		taker_skill_level = ['novice'],
	},
	lines = [
		"[name2] {^clamp[s/2]:clench[es/2]} up involuntarily with each thrust",
		"[name2] lie[s/2] {^rigid:motionless}, not knowing how to respond",
	]},

	giver_mastered_mean = {
	conditions = {
		virgin = [false],
		consent = [false],
		giver_skill_level = ['mastered'],
	},
	lines = [
		"[name1] {^pin[s/1]:hold[s/1]} [name2] at exactly the right angle, knowing [he2] can't resist",
		"[name1] {^use[s/1]:work[s/1]} [name2]'s body with {^clinical:cold} precision",
	]},

	giver_skilled_mean = {
	conditions = {
		virgin = [false],
		consent = [false],
		giver_skill_level = ['skilled'],
	},
	lines = [
		"[name1] {^keep[s/1]:hold[s/1]} [name2] {^pinned:in place} with a {^confident:practiced} grip",
	]},

	giver_novice_mean = {
	conditions = {
		virgin = [false],
		consent = [false],
		giver_skill_level = ['novice'],
	},
	lines = [
		"[name1] {^fumble[s/1]:struggle[s/1]} to maintain [his1] grip on [name2]",
	]},

	taker_mastered_mean = {
	conditions = {
		virgin = [false],
		consent = [false],
		taker_skill_level = ['mastered'],
	},
	lines = [
		"[name2] {^clench[es/2]:squeeze[s/2]} around [name1] {^helplessly:involuntarily}, [his2] body {^responding:reacting} on its own",
		"[name2] {^fight[s/2]:struggle[s/2]} against [his2] own instincts as [his2] hips {^twitch:shift} toward [name1]",
	]},

	taker_skilled_mean = {
	conditions = {
		virgin = [false],
		consent = [false],
		taker_skill_level = ['skilled'],
	},
	lines = [
		"[name2] {^tr[ies/y2] to stay:struggle[s/2] to remain} still as [his2] hips {^twitch:shift} on their own",
	]},

	taker_novice_mean = {
	conditions = {
		virgin = [false],
		consent = [false],
		taker_skill_level = ['novice'],
	},
	lines = [
		"[name2] {^lock[s/2]:clamp[s/2]} up entirely, body rigid with {^shock:panic}",
		"[name2] {^whimper[s/2]:sob[s/2]}, unable to do anything but endure",
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
		"[name2] {^hug:hold:squeeze:embrace}[s/2] [name1] as closely as [he2] can",
		"[name2] throw[s/2] [his2] arms around [name1]",
		"[name2] {^wrap:hook}[s/2] [his2] legs around [name1]",
	]},

	facing_nice = {
	conditions = {
		virgin = [false],
		facing = [true],
		consent = [true],
	},
	lines = [
		"[name2] {^stare:glance:look}[s/2] {^longingly:wistfully:coquettishly} into [names1] eyes",
	]},

	facing_mean = {
	conditions = {
		virgin = [false],
		facing = [true],
		consent = [false],
	},
	lines = [
		"[name2] {^turn:look}[s/2] away from [name1] in {^shame:humiliation}",
		"[name2] {^helplessly :fruitlessly :}tr[ies/y2] to {^push:move} away",
	]},

	nonfacing_nice = {
	conditions = {
		virgin = [false],
		facing = [false],
		consent = [true],
	},
	lines = [
		"[name2] {^push:press}[es/2] [himself2] {^back:backward} against [name1]",
		"[name2] {^stare:glance:look}[s/2] {^longingly:wistfully:coquettishly} {^back:backward} {^over [his2] shoulder :}at [name1]",
	]},

	nonfacing_mean = {
	conditions = {
		virgin = [false],
		facing = [false],
		consent = [false],
	},
	lines = [
		"[name2] {^helplessly :fruitlessly :}tr[ies/y2] to {^pull:move} away",
	]},

	virgin_nice = {
	conditions = {
		virgin = [true],
		consent = [true],
	},
	lines = [
		"[names2] {^ass:butt}hole {^stretch[es/#2] to make room:widen[s/#2] to a new shape:offer[s/#2] some resistance}",
	]},

	virgin_mean = {
	conditions = {
		virgin = [true],
		consent = [false],
	},
	lines = [
		"[names2] {^ass:butt}hole {^stretch[es/#2]:permanently widen[s/#2]:offer[s/#2] resistance}",
	]},

	virgin_facing_nice = {
	conditions = {
		virgin = [true],
		facing = [true],
		consent = [true],
	},
	lines = [
		"[name2] stare[s/2] down with wide eyes",
	]},

	virgin_facing_mean = {
	conditions = {
		virgin = [true],
		facing = [true],
		consent = [false],
	},
	lines = [
		"[name2] stare[s/2] down in {^horror:terror:dread:shock}",
	]},

	virgin_nonfacing_nice = {
	conditions = {
		virgin = [true],
		facing = [false],
		consent = [true],
	},
	lines = [
		"[name2] stare[s/2] back with wide eyes",
	]},

	virgin_nonfacing_mean = {
	conditions = {
		virgin = [true],
		facing = [false],
		consent = [false],
	},
	lines = [
		"[name2] stare[s/2] back in {^horror:terror:dread:shock}",
	]},

	nice = {
	conditions = {
		virgin = [false],
		consent = [true],
	},
	lines = [
		"[name2] arch[es/2] [his2] back",
		"[name2] {^spread[s/2]:part[s/2]} [his2] thighs {^to allow [name1] deeper:to give [name1] better access}",
	]},

	mean = {
	conditions = {
		virgin = [false],
		consent = [false],
	},
	lines = [
		"[name2] {^helplessly :fruitlessly :}struggle[s/2] against [name1]",
	]},

	default = {
	conditions = {
		virgin = [false],
	},
	lines = [
		"[names2] {^ass:butt}hole {^envelop[s/#2]:wrap[s/#2] around:tug[s/#2] at} [names1] [penis1]",
	]},

},

main_2_sexv = {

	virgin = {
	conditions = {
		virgin = [true],
	},
	lines = [
		" as [color=#ff5df8][he1] {^rip:tear:break}[s/1] {^open:through} [partners2] hymen[/s2][/color]",
		" as [color=#ff5df8][he1] claim[s/1] [partners2] {^virginit[y/ies2]:virgin puss[y/ies2]}[/color]",
		" as [color=#ff5df8][he1] {^break[s/1] in:deflower[s/1]} [partners2] {^unused:virgin} puss[y/ies2][/color]",
	]},

	virgin_mean = {
	conditions = {
		consent = [false],
		virgin = [true],
	},
	lines = [
		" as [color=#ff5df8] [he1] rob[s/1] [partner2] of [his2] {^virginit[y/ies2]:first time[/s2]}[/color]",
	]},

	insert = {
	conditions = {
		virgin = [false],
		orifice = ["swap","insert"],
	},
	lines = [
		" as [he1] {^jam[s/1]:push[es/1]:thrust[s/1]:insert[s/1]} [his1] [penis1] into [partner2]",
		" as [he1] {^slide[s/1]:push[es/1]} [himself1] {^into:inside} [partners2] {^[body2]:[pussy2]}",
	]},

	shift = {
	conditions = {
		virgin = [false],
		orifice = ["shift"],
	},
	lines = [
		" as [he1] {^resume:continue}[s/1] [fucking1] [partners2] {^[body2]:[pussy2]:insides}",
	]},

	nonrepeat = {
	conditions = {
		virgin = [false],
		orifice = ["shift","swap"]
	},
	lines = [
		" as [he1] {^begin:start}[s/1] {^to [fuck1]:[fucking1]} [partners2] {^[body2]:[pussy2]:insides}",
	]},

	repeat = {
	conditions = {
		virgin = [false],
		orifice = ["same"]
	},
	lines = [
		" as [he1] [fucks1] [partners2] {^[body2]:[pussy2]:insides}",
	]},

},

main_2_sexa = {

	virgin = {
	conditions = {
		virgin = [true],
	},
	lines = [
		" as [color=#ff5df8][he1] claim[s/1] [partners2] {^anal virginit[y/ies2]:virgin butthole[/s2]}[/color]",
		" as [color=#ff5df8][he1] {^break[s/1] in:deflower[s/1]} [partners2] {^unused:virgin} {^ass:butt}hole[/s2][/color]",
	]},

	virgin_mean = {
	conditions = {
		consent = [false],
		virgin = [true],
	},
	lines = [
		" as [color=#ff5df8][he1] rob[s/1] [partner2] of [his2] {^anal virginit[y/ies2]:first time[/s2]}[/color]",
	]},

	insert = {
	conditions = {
		virgin = [false],
		orifice = ["swap","insert"],
	},
	lines = [
		" as [he1] {^jam[s/1]:push[es/1]:thrust[s/1]:insert[s/1]} [his1] [penis1] into [partner2]",
		" as [he1] {^slide[s/1]:push[es/1]} [himself1] {^into:inside} [partners2] {^[body2]:[anus2]}",
	]},

	shift = {
	conditions = {
		virgin = [false],
		orifice = ["shift"],
	},
	lines = [
		" as [he1] {^resume:continue}[s/1] [fucking1] [partners2] {^[body2]:[anus2]:insides}",
	]},

	nonrepeat = {
	conditions = {
		virgin = [false],
		orifice = ["shift","swap"]
	},
	lines = [
		" as [he1] {^begin:start}[s/1] {^to [fuck1]:[fucking1]} [partners2] {^[body2]:[anus2]:insides}",
	]},

	repeat = {
	conditions = {
		virgin = [false],
		orifice = ["same"]
	},
	lines = [
		" as [he1] {^repeatedly ::}[fucks1] [partners2] {^[body2]:[anus2]:insides}",
	]},

},

main_2_fsexv = {

	virgin = {
	conditions = {
		virgin = [true],
	},
	lines = [
		" as [he1] {^rip:tear:break}[s/1] {^open:through} [his1] own hymen. ",
		" as [he1] give[s/1] [partner2] [his1] {^virginity:first time}. ",
		" as [he1] {^break[s/1] in:deflower[s/1]} [his1] {^unused:virgin} puss[y/ies1]. ",
	]},

},

main_2_fsexa = {

	virgin = {
	conditions = {
		virgin = [true],
	},
	lines = [
		" as [he1] give[s/1] [partner2] [his1] {^anal virginity:first time}. ",
		" as [he1] {^break[s/1] in:deflower[s/1]} [his1] {^unused:virgin} {^ass:butt}hole[/s1]. ",
	]},

},

main_3_sex = {

	default = {
	conditions = {
	},
	lines = [
		". ",
	]},

},

react_1_sex = {

	arousal_4_nice = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		"[name2] dangle[s/2] [his2] tongue[/s2] out of [his2] mouth",
		"[name2] lose[s/2] focus and roll[s/2] [his2] eyes back",
		"[name2] {^cr[ies/y2] out:moans} {^wildly:passionately} with each thrust",
		"[name2] can hardly contain [himself2]",
	]},

	arousal_4_mean = {
	conditions = {
		consent = [false],
		arousal = [4,5],
	},
	lines = [
		"[name2] can't help but move [his2] hips",
		"[name2] {^doesn't even try:completely forget[s/2]} to hold[s/2] in [his2] voice",
		"[name2] cling[s/2] to [his2] last {^vestiges:bits} of self-control",
	]},

	arousal_3_nice = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		"[name2] can't help but move [his2] hips",
		"[name2] moan[s/2] loudly",
		"[name2] cr[ies/y2] out with each thrust",
	]},

	arousal_3_mean = {
	conditions = {
		consent = [false],
		arousal = [3],
	},
	lines = [
		"[names2] [body2] {^quiver[s/2]:twitch[es/2]}",
		"[name2] can't help but moan",
		"[name2] inadvertently cr[ies/y2] out",
	]},

	arousal_2_nice = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		"[names2] [body2] {^quiver[s/2]:twitch[es/2]}",
		"[name2] moan[s/2]",
		"[name2] cr[ies/y2] out",
	]},

	arousal_2_mean = {
	conditions = {
		consent = [false],
		arousal = [2],
	},
	lines = [
		"[name2] let[s/2] out {^quiet:muffled} noises",
		"[name2] trie[s/2] to look away",
		"[name2] twitch[es/2]",
	]},

	arousal_1_nice = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		"[name2] let[s/2] out {^quiet:muffled} noises",
		"[name2] twitch[es/2]",
		"[name2] softly moan[s/2]",
	]},

	arousal_1_mean = {
	conditions = {
		consent = [false],
		arousal = [1],
	},
	lines = [
		"[name2] clench[es/2] [his2] teeth",
		"[name2] tenses[s/2] up",
		"[name2] look[s/2] away in indignation",
	]},

	taker_mastered_nice = {
	conditions = {
		consent = [true],
		taker_skill_level = ['mastered'],
	},
	lines = [
		"[name2] {^clench[es/2]:squeeze[s/2]} around [name1], {^timing:coordinating} it with each thrust",
		"[name2] {^tilt[s/2]:angle[s/2]} [his2] hips to {^take [name1] deeper:maximize the sensation}",
	]},

	taker_skilled_nice = {
	conditions = {
		consent = [true],
		taker_skill_level = ['skilled'],
	},
	lines = [
		"[name2] {^rock[s/2]:shift[s/2]} [his2] hips {^tentatively:experimentally}, {^finding:learning} what feels good",
		"[name2] begin[s/2] to {^consciously:actively} move with [name1]",
	]},

	taker_novice_nice = {
	conditions = {
		consent = [true],
		taker_skill_level = ['novice'],
	},
	lines = [
		"[name2] {^gasp[s/2]:whimper[s/2]} at each sensation, {^overwhelmed:caught off guard} by the feeling",
		"[name2] {^lie[s/2]:remain[s/2]} {^rigid:tense}, not knowing what to do with [himself2]",
	]},

	taker_mastered_mean = {
	conditions = {
		consent = [false],
		taker_skill_level = ['mastered'],
	},
	lines = [
		"[name2] {^clench[es/2]:squeeze[s/2]} around [name1] {^helplessly:involuntarily}, unable to stop [himself2]",
		"[name2] {^fight[s/2]:struggle[s/2]} to suppress [his2] body's {^trained:instinctive} response",
	]},

	taker_skilled_mean = {
	conditions = {
		consent = [false],
		taker_skill_level = ['skilled'],
	},
	lines = [
		"[name2] {^tr[ies/y2] to stay:struggle[s/2] to remain} still as [his2] hips {^twitch:shift} on their own",
	]},

	taker_novice_mean = {
	conditions = {
		consent = [false],
		taker_skill_level = ['novice'],
	},
	lines = [
		"[name2] {^lock[s/2]:seize[s/2]} up, body rigid with {^shock:panic}",
		"[name2] {^shudder[s/2]:flinch[es/2]} with each thrust, unable to adapt",
	]},

},

react_1_fsex = {

	arousal_4 = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		"[name1] dangle[s/1] [his1] tongue[/s1] out of [his1] mouth",
		"[name2] lose[s/1] focus and roll[s/1] [his1] eyes back",
		"[name2] {^cr[ies/y1] out:moans} {^wildly:passionately} with each movement",
		"[name2] can hardly contain [himself1]",
	]},

	arousal_3 = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		"[name2] can't help but move [his1] hips",
		"[name2] moan[s/1] loudly",
		"[name2] cr[ies/y1] out with each movement",
	]},

	arousal_2 = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		"[names2] [body1] {^quiver[s/1]:twitch[es/1]}",
		"[name2] moan[s/1]",
		"[name2] cr[ies/y1] out",
	]},

	arousal_1 = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		"[name2] let[s/1] out {^quiet:muffled} noises",
		"[name2] twitch[es/1]",
		"[name2] softly moan[s/1]",
	]},

},

react_2_sex = {

	arousal_4_nice = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		", {^rapidly:quickly} {^nearing:approaching:edging toward} {^orgasm:[his2] climax:[his2] peak}",
		", {^resting:teetering} on the {^verge:edge} of {^orgasm:climax}",
		"",
	]},

	arousal_4_mean = {
	conditions = {
		consent = [false],
		arousal = [4,5],
	},
	lines = [
		", {^having fallen:helpless:powerless} in the face of [his2] rapidly approaching {^orgasm:climax}",
		", trying {^desperately:with futility} to stave off [his2] {^orgasm:climax}",
		"",
	]},

	arousal_3_nice = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		", [his2] {^enjoyment:pleasure:satisfaction} {^clearly :}{^showing:evident}",
		", the {^pleasure:sensations} inside [him2] becoming too much to {^bear:take}",
		"",
	]},

	arousal_3_mean = {
	conditions = {
		consent = [false],
		arousal = [3],
	},
	lines = [
		", having lost [his2] composure",
		", feeling very aroused in spite of [himself2]",
		"",
	]},

	arousal_2_nice = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		", [his2] {^enjoyment:pleasure:satisfaction} building",
		", pleasure {^building:welling up} inside [him2]",
		"",
	]},

	arousal_2_mean = {
	conditions = {
		consent = [false],
		arousal = [2],
	},
	lines = [
		", [his2] composure starting to {^crack:fail:wane}",
		", beginning to feel aroused in spite of [himself2]",
		"",
	]},

	arousal_1_nice = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		", {^still adjusting:getting adjusted:far from orgasm}",
		", only just beginning to enjoy [himself2]",
		"",
	]},

	arousal_1_mean = {
	conditions = {
		consent = [false],
		arousal = [1],
	},
	lines = [
		", trying to {^resist:compose [himself2]:ignore what's happening}",
		", feeling {^ashamed:demeaned}",
		"",
	]},

	giver_mastered_nice = {
	conditions = {
		consent = [true],
		giver_skill_level = ['mastered'],
	},
	lines = [
		", every thrust {^precisely:expertly} aimed by [name1]",
		", {^driven:pushed} further with each {^precise:well-placed} move from [name1]",
		"",
	]},

	giver_skilled_nice = {
	conditions = {
		consent = [true],
		giver_skill_level = ['skilled'],
	},
	lines = [
		", guided along by [names1] {^steady:consistent} rhythm",
		"",
	]},

	giver_novice_nice = {
	conditions = {
		consent = [true],
		giver_skill_level = ['novice'],
	},
	lines = [
		", {^despite:in spite of} [names1] {^uneven:clumsy} movements",
		"",
	]},

	giver_mastered_mean = {
	conditions = {
		consent = [false],
		giver_skill_level = ['mastered'],
	},
	lines = [
		", [his2] body {^surrendering:giving in} to [names1] {^expert:practiced} control despite [himself2]",
		"",
	]},

	giver_skilled_mean = {
	conditions = {
		consent = [false],
		giver_skill_level = ['skilled'],
	},
	lines = [
		", [his2] resistance {^crumbling:faltering} under [names1] {^confident:relentless} pace",
		"",
	]},

	giver_novice_mean = {
	conditions = {
		consent = [false],
		giver_skill_level = ['novice'],
	},
	lines = [
		", {^even through:despite} [names1] {^clumsy:fumbling} handling",
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
		", {^rapidly:quickly} {^nearing:approaching:edging toward} {^orgasm:[his1] climax:[his1] peak}",
		", {^resting:teetering} on the {^verge:edge} of {^orgasm:climax}",
		"",
	]},

	arousal_3 = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		", [his1] {^enjoyment:pleasure:satisfaction} {^clearly :}{^showing:evident}",
		", the {^pleasure:sensations} inside [him1] becoming too much to {^bear:take}",
		"",
	]},

	arousal_2 = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		", [his1] {^enjoyment:pleasure:satisfaction} building",
		", pleasure {^building:welling up} inside [him1]",
		"",
	]},

	arousal_1 = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		", {^still adjusting:getting adjusted:far from orgasm}",
		", only just beginning to enjoy [himself1]",
		"",
	]},

},

react_3_sexv = {

	default = {
	conditions = {
	},
	lines = [
		" as [names1] [penis1] {^fill[s/#1]:slide[s/#1] in and out of:plow[s/#1]} [his2] [pussy2].",
		" as [names1] [penis1] {^massage[s/#1]:scrape[s/#1] against:rub[s/#1] against} the walls of [his2] [pussy2].",
		" as [his2] [pussy2] get[s/2] {^stretched:churned:massaged} by [names1] [penis1].",
	]},

},

react_3_sexa = {

	default = {
	conditions = {
	},
	lines = [
		" as [names1] [penis1] {^fill[s/#1]:slide[s/#1] in and out of:plow[s/#1]} [his2] [anus2].",
		" as [names1] [penis1] {^massage[s/#1]:scrape[s/#1] against:rub[s/#1] against} the walls of [his2] [anus2].",
		" as [his2] [anus2] get[s/2] {^stretched:churned:massaged} by [names1] [penis1].",
	]},

},

react_3_fsexv = {

	default = {
	conditions = {
	},
	lines = [
		" as [names2] [penis2] {^filll[s/#2]:slide[s/#2] in and out of} [his1] [pussy1].",
		" as [names1] [penis2] {^massage[s/#2]:scrape[s/#2] against:rub[s/#2] against} the walls of [his1] [pussy1].",
		" as [his1] [anus1] get[s/1] {^stretched:churned:massaged} by [names2] [pussy2].",
	]},

},

react_3_fsexa = {

	default = {
	conditions = {
	},
	lines = [
		" as [names2] [penis2] {^filll[s/#2]:slide[s/#2] in and out of} [his1] [anus1].",
		" as [names1] [penis2] {^massage[s/#2]:scrape[s/#2] against:rub[s/#2] against} the walls of [his1] [anus1].",
		" as [his1] [anus1] get[s/1] {^stretched:churned:massaged} by [names2] [penis2].",
	]},

},

}
