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
	for i in $"base stats".get_children():
		if statdata.statdata.has(i.name.replace("label_","")):
			globals.connecttexttooltip(i, statdata.statdata[i.name.replace("label_", "")].descript)

func open(character = ResourceScripts.scriptdict.class_slave.new()):
	$name.text = character.get_short_name()
	for i in ['hp','mp']:
		$VBoxContainer.get_node(i).text = str(floor(character.get_stat(i))) + "/" + str(floor(character.get_stat(i+"max")))
	
	for i in variables.fighter_stats_list:
		if !i in ['hpmax', 'mpmax','critmod']:
			$"base stats".get_node(i).text = str(floor(character.get_stat(i)))
		elif i == 'critmod':
			$"base stats".get_node(i).text = str(floor(character.get_stat(i)*100))
	
	for i in $resists.get_children():
		var tmp = character.get_stat('resists')
		if variables.resists_list.has(i.name):
			i.text = str(tmp[i.name])
			if tmp[i.name] > 0:
				i.set("custom_colors/font_color", variables.hexcolordict.yellow)
			elif tmp[i.name] < 0:
				i.set("custom_colors/font_color", variables.hexcolordict.green)
			else:
				i.set("custom_colors/font_color", variables.hexcolordict.white)
