extends Node

var deities = {
	selena = {
		offering_options = ['character','material'],
		offerings = {
			1 : {input = ['material'], output = 'selena_item'},
			2 : {input = ['character'], output = ''},
		},
		demolish_reward = [],
		bless = '',
		curse = '',
		shrine_scene = '',
		
		
		
	},
	erebus = {},
	freya = {},
}


func selena_item(code):
	var text = ''
	var item = Items.materiallist[code]
	
	if item.type in ['wood','plant','food']:
		pass
	
	
	
	return text


