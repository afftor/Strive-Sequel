extends Node


var list = {
	char_rnd_injury = {
		special_reqs = []
	},
	char_rnd_asleep = {
		special_reqs = []
	}
}

func supplement_events():
	pass
#	for id in list:
#		var event_supplement = list[id]
#		var event = scenedata.scenedict[id]
#		for opt_num in event_supplement.options:
#			var orig_opt
#			for i in event.options:
#				if i.dialogue_argument == opt_num:
#					orig_opt = i
#					break
#			for param in event_supplement.options[opt_num]:
#				orig_opt[param] = event_supplement.options[opt_num][param]
