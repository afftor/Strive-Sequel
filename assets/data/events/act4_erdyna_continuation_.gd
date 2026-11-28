extends Reference

var data = {
	act4_erdyna_after_leave_hub = {
		image = null,
		character = "$erdyna",
		tags = ["dialogue_scene", "master_translate", "act4_erdyna"],
		reqs = [],
		text = [
			{
				text = "ACT4_ERDYNA_AFTER_LEAVE_HUB_0",
				reqs = [],
				previous_dialogue_option = 0
			},
			{
				text = "ACT4_ERDYNA_AFTER_LEAVE_HUB_1",
				reqs = [],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_ERDYNA_AFTER_LEAVE_HUB_2",
				reqs = [],
				previous_dialogue_option = 2
			},
			{
				text = "ACT4_ERDYNA_AFTER_LEAVE_HUB_3",
				reqs = [],
				previous_dialogue_option = 3
			},
		],
		options = [
			{
				code = "act4_erdyna_after_leave_hub",
				text = "ACT4_ERDYNA_AFTER_LEAVE_OPTION_GANG",
				reqs = [],
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "act4_erdyna_after_leave_hub",
				text = "ACT4_ERDYNA_AFTER_LEAVE_OPTION_SORRY",
				reqs = [],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "act4_erdyna_after_leave_hub",
				text = "ACT4_ERDYNA_AFTER_LEAVE_OPTION_HONOR",
				reqs = [],
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = "act4_erdyna_flirt_result",
				text = "ACT4_ERDYNA_AFTER_LEAVE_OPTION_FLIRT",
				reqs = [],
				type = "next_dialogue",
				remove_after_first_use = true
			},
			{
				code = "act4_erdyna_campfire_nonflirt",
				text = "ACT4_ERDYNA_AFTER_LEAVE_OPTION_REST",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_flirt_result = {
		variations = [
			{
				reqs = [{type = "master_check", value = [{code = "stat", stat = "sexuals_factor", operant = "gte", value = 5}]}],
				image = null,
				character = "$erdyna",
				tags = ["dialogue_scene", "master_translate", "act4_erdyna"],
				text = "ACT4_ERDYNA_AFTER_LEAVE_HUB_4_SUCCESS",
				options = [
					{
						code = "erdyna_campfire_1",
						text = "DIALOGUECONTINUE",
						reqs = [],
						type = "next_dialogue"
					}
				]
			},
			{
				reqs = [{type = "master_check", value = [{code = "stat", stat = "sexuals_factor", operant = "lt", value = 5}]}],
				image = null,
				character = "$erdyna",
				tags = ["dialogue_scene", "master_translate", "act4_erdyna"],
				text = "ACT4_ERDYNA_AFTER_LEAVE_HUB_4_FAIL",
				options = [
					{
						code = "act4_erdyna_after_leave_hub",
						text = "DIALOGUECONTINUE",
						reqs = [],
						type = "next_dialogue"
					}
				]
			}
		]
	},
}
