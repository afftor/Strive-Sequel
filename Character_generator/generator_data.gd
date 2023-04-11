extends Node

var stats_to_look = ['sex']

var transforms = {
	cloth = {
		true:[
			{type = 'node_group_attr', group = 'cloth', attr = 'visible', value = true},
		],
		false:[
			{type = 'node_group_attr', group = 'cloth', attr = 'visible', value = false},
		]
	},
	sex = {
		male = [
			{type = 'node_group_select', group = 'sex', select = 'male_pose'},
		],
		female = [
			{type = 'node_group_select', group = 'sex', select = 'female_pose'},
		]
	},
}
