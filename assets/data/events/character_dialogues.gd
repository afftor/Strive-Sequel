var data = {
	zephyra_dialogue_start = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'zephyra',
		text = [
			{text = "ZEPHYRA_EXTRA_GREET", reqs = [
		{type = "location_has_specific_slaves", value = 1, location = 'mansion', reqs = [
		{code = 'unique', value = 'zephyra'}, {code = 'slave_category', value = 'peon'}]}]},
			{text = "ZEPHYRA_EXTRA_GREET2", reqs = [
		{type = "location_has_specific_slaves", value = 1, location = 'mansion', reqs = [
		{code = 'unique', value = 'zephyra'}, {code = 'slave_category', value = 'slave'}]}]}], 
		options = [ {
			code = 'looking_for_princess_elven_11', text = "LOOKING_FOR_PRINCESS_OPTION_37", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'looking_for_princess_elven_11', text = "LOOKING_FOR_PRINCESS_OPTION_38", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'looking_for_princess_elven_11', text = "LOOKING_FOR_PRINCESS_OPTION_39", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}, ],
	}
}
