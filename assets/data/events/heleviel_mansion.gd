extends Reference
var data = {
	heleviel_mansion_1 = {
		reqs = [

		],
		unlocked_gallery_seq = "heleviel_mansion",
		music = "heleviel_theme", 
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_MANSION_1",
		options = [
			{
				code = "close",
				text = "HELEVIEL_MANSION_1_O_0",
				reqs = [

				]
			}
		],
		character = "$heleviel"
	},
	
	
	heleviel_snowset_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		character = '$heleviel',
		unlocked_char_sprites = {heleviel = ["christmass"]},
		reqs = [],
		text = [ {text = "HELEVIEL_SNOWSET_EVENT_1", reqs = []} ],
		options = [ {
			code = 'heleviel_snowset_2', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},

	heleviel_snowset_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		character = '$heleviel',
		character2 = 'sigmund',
		reqs = [],
		text = [ {text = "HELEVIEL_SNOWSET_EVENT_2", reqs = []} ],
		options = [ {
			code = 'heleviel_snowset_3', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},

	heleviel_snowset_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		character = '$heleviel',
		character2 = 'sigmund',
		reqs = [],
		text = [ {text = "HELEVIEL_SNOWSET_EVENT_3", reqs = []} ],
		options = [ {
			code = 'heleviel_snowset_4', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},

	heleviel_snowset_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		character = 'heleviel_christmas',
		reqs = [],
		text = [ {text = "HELEVIEL_SNOWSET_EVENT_4", reqs = []} ],
		options = [ {
			code = 'heleviel_snowset_choice_1', reqs = [], text = "HELEVIEL_SNOWSET_OPTION_1", dialogue_argument = 1
		}, {
			code = 'heleviel_snowset_choice_2', reqs = [], text = "HELEVIEL_SNOWSET_OPTION_2", type = 'next_dialogue', dialogue_argument = 2
		} ]
	},

	heleviel_snowset_choice_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		character = 'heleviel_christmas',
		reqs = [],
		common_effects = [
		],
		text = [ {text = "HELEVIEL_SNOWSET_EVENT_5A", reqs = []} ],
		options = [ {
			code = 'heleviel_snowset_choice_2', reqs = [], text = "HELEVIEL_SNOWSET_OPTION_2", type = 'next_dialogue', dialogue_argument = 2
		} ]
	},

	heleviel_snowset_choice_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		character = 'heleviel_christmas',
		reqs = [],
		common_effects = [
			{code = 'unique_character_changes', value = 'heleviel', args = [
			{code = 'unique_variation', operant = '=', value = "christmas"},
			{code = 'icon_image', operant = '=', value = "res://assets/images/portraits/heleviel_snowset_prt.png"},
			{code = 'body_image', operant = '=', value = "heleviel_christmas_body"}]},
			{code = 'decision', value = 'heleviel_christmas_rewarded'},
			{code = 'update_prts'},
		],
		text = [ {text = "HELEVIEL_SNOWSET_EVENT_5B", reqs = []} ],
		options = [ {
			code = 'christmas_scene', reqs = [], text = tr("DIALOGUECLOSE"), change_dialogue_type = 2
		} ]
	},
	
	
	christmas_scene = {
		tags = [
			"dialogue_scene",
			"blackscreen_transition_slow"
		],
		custom_background = "christmas25",
		scene_type = "story_scene",
		save_scene_to_gallery = true,
		common_effects = [
			{
				code = "hide_dialogue"
			},
		],
		text = "",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [{code = 'update_guild'}]
			},
		]
	}
}
