extends Reference
#decisions:
#search_advice_1 - duncan -> amelia
#search_advice_2 - amelia -> duncan
#search_advice_3 - amelia -> myr
#search_advice_4 - amelia -> amelia (failed interragation)
#prison_avail - unlock
#amelia_help - not implemented - contionues questline


var data = {
	aire_amelia1 = {
		image = null,
		music = "intimate_dark",
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "aire_amelia1",
		save_scene_to_gallery = true,
		character = "$aire",
		character2 = "$amelia",
		tags = ['dialogue_scene'],
		reqs = [{type = 'quest_completed', name = 'princess_search', check = false}],
		common_effects = [{code = 'unique_character_changes', value = 'aire', args = [
			{code = 'tag', operant = 'remove', value = 'no_sex'}]}],
		text = [
			{text = "AIRE_AMELIA1", reqs = []},
		],
		options = [
			{code = 'aire_amelia2' , text = tr("DIALOGUECONTINUE"), reqs = [], dialogue_argument = 1}
		]
	},
	aire_amelia2 = {
		image = null,
		custom_background = "aire_amelia1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		dialogue_type = 2,
		tags = ['dialogue_scene'],
		text = [
			{text = "AIRE_AMELIA2", reqs = []},
		],
		options = [
			{code = 'aire_amelia3' , text = tr("DIALOGUECONTINUE"), reqs = [], dialogue_argument = 1}
		]
	},
	aire_amelia3 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "AIRE_AMELIA3", reqs = []},
		],
		options = [
			{code = 'aire_amelia4' , text = tr("DIALOGUECONTINUE"), reqs = [], dialogue_argument = 1}
		]
	},
	aire_amelia4 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "AIRE_AMELIA4", reqs = []},
		],
		options = [
			{code = 'aire_amelia5' , text = tr("DIALOGUECONTINUE"), reqs = [], dialogue_argument = 1}
		]
	},
	aire_amelia5 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "AIRE_AMELIA5", reqs = []},
		],
		options = [
			{code = 'aire_amelia6' , text = tr("DIALOGUECONTINUE"), reqs = [], dialogue_argument = 1}
		]
	},
	aire_amelia6 = {
		image = null,
		custom_background = "aire_amelia2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		dialogue_type = 2,
		tags = ['dialogue_scene'],
		text = [
			{text = "AIRE_AMELIA6", reqs = []},
		],
		options = [
			{code = 'close' , text = tr("DIALOGUECONTINUE"), reqs = [], bonus_effects = [
				{code = 'rewrite_save'}, 
				{code = 'screen_black_transition', value = 1}
				]}
		]
	},
}
