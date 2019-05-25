extends Node

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
		"[name1] {^hold:lift}[s/1] [names2] legs{^ over [his2] head: apart}",
		"[name1] {^hug:hold:squeeze}[s/1] [name2] close to [his1] bod[y/ies1]",
	]},
	
	repeat_mean = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^roughly :}{^pull[s/1]:spread[s/1]:hold[s/1]} [names2] legs{^ over [his2] head: apart}",
		"[name1] {^pin[s/1]:hold[s/1]} [name2] down",
	]},
	
	lotus_nice = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^lower:drop}[s/1] [name2] onto [his2] back[/s2] and {^move:climb}[s/1] {^atop:on top of} [him2]",
		"[name1] {^loosen:release}[s/1] [his1] {^embrace:hold} and {^lower:drop}[s/1] [name2] onto [his2] back[/s2]",
	]},
	
	lotus_mean = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^push[es/1]:shove[s/1]} [name2] onto [his2] back[/s2] and {^move:climb}[s/1] {^atop:on top of} [him2]",
		"[name1] {^loosen:release}[s/1] [his1] {^grip:hold} and {^push[es/1]:shove[s/1]} [name2] onto [his2] back[/s2]",
	]},
	
	revlotus_nice = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^lower:guide}[s/1] [name2] {^forward:down} and {^flip:roll:turn}[s/1] [him2] over onto [his2] back",
		"[name1] {^loosen:release}[s/1] [his1] {^embrace:hold} and {^flip:roll:turn}[s/1] [name2] onto [his2] back",
	]},
	
	revlotus_mean = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^push[es/1]:shove[s/1]} [name2] {^forward:down} and {^flip:roll:turn}[s/1] [him2] over onto [his2] back",
		"[name1] {^loosen:release}[s/1] [his1] {^grip:hold} and {^flip:roll:turn}[s/1] [name2] onto [his2] back",
	]},
	
	doggy_nice = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^flip:roll:turn}[s/1] [name2] over {^onto [his2] back[/s2]:to face [him1]} and {^move:climb}[s/1] {^atop:on top of} [him2]",
		"[name1] {^lift:guide:pull}[s/1] [name2] up off [his2] hands and knees and {^flip:roll:turn}[s/1] [him2] over",
	]},
	
	doggy_mean = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^flip:roll:turn}[s/1] [name2] over {^onto [his2] back[/s2]:to face [him1]} and {^move:climb}[s/1] {^atop:on top of} [him2]",
		"[name1] {^yank:jerk:pull}[s/1] [name2] up off [his2] hands and knees and {^flip:roll:turn}[s/1] [him2] over",
	]},
	
	insert_nice = {
	conditions = {
		link = [null],
		consent = [true],
	},
	lines = [
		"[name1] {^gently :}{^lay:set}[s/1] [name2] down{^ on [his2] back:}",
		"[name1] {^roll:shift}[s/1] [name2] onto [his2] back and {^move:climb}[s/1] {^atop:on top of} [him2]",
	]},
	
	insert_mean = {
	conditions = {
		link = [null],
		consent = [false],
	},
	lines = [
		"[name1] {^roughly :}{^push[es/1]:pin[s/1]:hold[s/1]} [name2] down{^ on [his2] back:}",
		"[name1] {^toss[es/1]:throw[s/1]} [name2] onto [his2] back and {^move:climb}[s/1] {^atop:on top of} [him2]",
	]},
	
},

start_1_doggy = {
	
	repeat_nice = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^hold[s/1]:grasp[s/1]:stead[ies/y1]} [name2] by [his2] [hips2]",
		"[name1] {^squeeze:knead:massage}[s/1] [names2] {^ass:butt}cheeks",
	]},
	
	repeat_mean = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^roughly :}{^squeeze:knead:swat}[s/1] [names2] {^ass:butt}cheeks",
		"[name1] {^roughly :}{^grabs[s/1]:seize[s/1]} [name2] by [his2] [hips2]",
		"[name1] {^pin[s/1]:hold[s/1]} [name2] down {^on all fours:on [his2] knees}",
	]},
	
	lotus_nice = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^lower:guide}[s/1] [name2] back and {^flip:roll:turn}[s/1] [him2] over onto {^all fours:[his2] knees:[his2] hands and knees}",
		"[name1] {^loosen:release}[s/1] [his1] {^embrace:hold} and {^flip:roll:turn}[s/1] [name2] onto {^all fours:[his2] knees:[his2] hands and knees}",
	]},
	
	lotus_mean = {
	conditions = {
		link = ["lotus", "lotusanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^push[es/1]:shove[s/1]} [name2] back and {^flip:roll:turn}[s/1] [him2] over onto {^all fours:[his2] knees:[his2] hands and knees}",
		"[name1] {^loosen:release}[s/1] [his1] {^grip:hold} and {^flip:roll:turn}[s/1] [name2] onto {^all fours:[his2] knees:[his2] hands and knees}",
	]},
	
	revlotus_nice = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^lower:guide}[s/1] [name2] {^forward:down} onto {^all fours:[his2] knees:[his2] hands and knees}",
		"[name1] {^loosen:release}[s/1] [his1] {^embrace:hold} and {^roll:shift}[s/1] [name2] onto {^all fours:[his2] knees:[his2] hands and knees}",
	]},
	
	revlotus_mean = {
	conditions = {
		link = ["revlotus", "revlotusanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^push[es/1]:shove[s/1]} [name2] {^forward:down} onto {^all fours:[his2] knees:[his2] hands and knees}",
		"[name1] {^loosen:release}[s/1] [his1] {^grip:hold} and {^push[es/1]:shove[s/1]} [name2] onto {^all fours:[his2] knees:[his2] hands and knees}",
	]},
	
	missionary_nice = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^flip:roll:turn}[s/1] [name2] over onto {^all fours:[his2] knees:[his2] hands and knees}",
		"[name1] {^lift:guide:pull}[s/1] [name2] up off [his2] back[/s2] and {^flip:roll:turn}[s/1] [him2] over",
	]},
	
	missionary_mean = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^flip:roll:turn}[s/1] [name2] over onto {^all fours:[his2] knees:[his2] hands and knees}",
		"[name1] {^yank:jerk:pull}[s/1] [name2] up off [his2] back[/s2] and {^flip:roll:turn}[s/1] [him2] over",
	]},
	
	insert_nice = {
	conditions = {
		link = [null],
		consent = [true],
	},
	lines = [
		"[name1] {^gently :}{^guide:set}[s/1] [name2] down onto {^all fours:[his2] knees}",
		"[name1] {^roll:shift}[s/1] [name2] onto [his2] hands and knees",
	]},
	
	insert_mean = {
	conditions = {
		link = [null],
		consent = [false],
	},
	lines = [
		"[name1] {^roughly :}{^push[es/1]:pin[s/1]:hold[s/1]} [name2] down {^on all fours:on [his2] knees}",
		"[name1] {^toss[es/1]:throw[s/1]} [name2] onto [his2] hands and knees",
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
	},
	lines = [
		", {^aligning:lining up} [his1] [penis1] with the {^entrance:mouth} of [his2] [pussy2]. ",
		", {^probing:pressing} {^the tip of :}[his1] [penis1] into the {^entrance:mouth} of [his2] [pussy2]. ",
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