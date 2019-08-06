extends Panel

func _ready():
	for i in variables.resists_list:
		var newlabel = $resists/Label.duplicate()
		var newvalue = $resists/Value.duplicate()
		$resists.add_child(newlabel)
		$resists.add_child(newvalue)
		newlabel.text = i.capitalize() + ":"
		newvalue.name = i
		newlabel.show()
		newvalue.show()

func open(character):
	for i in ['hp','mp','energy']:
		$VBoxContainer.get_node(i).text = str(character.get(i)) + "/" + str(character.get(i+"max"))
	
	for i in variables.fighter_stats_list:
		if !i in ['hp', 'mp']:
			$"base stats".get_node(i).text = str(character.get(i))
	
	for i in $resists.get_children():
		if variables.resists_list.has(i.name):
			i.text = str(character.resists.get(i.name))