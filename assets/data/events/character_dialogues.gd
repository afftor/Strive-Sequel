var data = {
	zephyra_dialogue_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'zephyra',
		text = [
			{text = "ZEPHYRA_EXTRA_GREET", reqs = [
				{type = 'active_character_checks', value = [{code = 'is_master', check = false}, {code = 'race_is_beast', check = false}]}]},
			{text = "ZEPHYRA_EXTRA_GREET2", reqs = [
		{type = "location_has_specific_slaves", value = 1, location = 'mansion', reqs = [
		{code = 'unique', value = 'zephyra'}, {code = 'slave_category', value = 'slave'}]}]}], 
		options = [ {
			code = 'looking_for_princess_elven_11', text = "ZEPHYRA_EXTRA_OPTION1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ],
	}
}
