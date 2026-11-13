extends Reference
var data = {
	daisy_first_event = {
		text = tr("SCENEDAISY_FIRST_EVENT_TEXT"),
		tags = ['linked_event'],
		reqs = [{type = 'unique_character_at_mansion', name = 'daisy', check = true, negative = 'repeat_next_day'}],#this requirement only applies when checking timed_events. 'negative' means what resolution should apply when requirement is not met.
		image = 'daisyevent',
		options = [
		{code = 'daisy_first_event_reassure', text = tr("SCENEDAISY_FIRST_EVENT_OPTION1"), type = 'next_dialogue', reqs = []},
		{code = 'daisy_first_event_discipline', text = tr("SCENEDAISY_FIRST_EVENT_OPTION2"), type = 'next_dialogue', reqs = []},
		],
	},
	daisy_first_event_discipline = {
		text = tr("SCENEDAISY_FIRST_EVENT_DISCIPLINE"),
		custom_background = "daisy_discipline",
		dialogue_type = 2,
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = [],
		image = null,
		common_effects = [{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'sexuals_factor', value = 1, operant = "+"},
			{code = 'sextrait', value = 'submissive', operant = 'add', known = true},#for sextrait/add setting, trait is appended to character's traits
			{code = 'tag', operant = 'remove', value = 'no_sex'},
			]}],
		options = [
		{code = 'close', text = tr('DIALOGUECLOSE'), reqs = []},
		],
	},
}
