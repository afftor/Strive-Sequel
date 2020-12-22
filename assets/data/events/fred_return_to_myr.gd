var data = {
	fred_return_to_myr_1 = {
		variations = [
			# Var 1
			{reqs = [{type = 'decision', value = 'brought_fred', check = true}],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "RETURNTOMYR_IF_FRED", reqs = []}],
			options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [],
			bonus_effects = [{code = 'decision', value = 'aire_is_saved'}], dialogue_argument = 1, type = 'next_dialogue'}],
			},
			# Var 2
			{reqs = [{type = 'decision', value = 'kill_fred', check = true}],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "RETURNTOMYR_IF_NOT_FRED", reqs = []}],
			options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [],
			bonus_effects = [{code = 'decision', value = 'aire_is_saved'}], dialogue_argument = 1, type = 'next_dialogue'}],
			},
			# Var 3
			{reqs = [], #{type = 'decision', value = 'bribe_from_fred_taken', check = true}
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "RETURNTOMYR", reqs = []}],
			options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [],
			bonus_effects = [{code = 'decision', value = 'aire_is_saved'}], dialogue_argument = 1, type = 'next_dialogue'}],
			},
		]
	},
}
