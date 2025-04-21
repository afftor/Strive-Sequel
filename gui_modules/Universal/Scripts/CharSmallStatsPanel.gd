extends Panel

func _ready():
	$CloseButton.connect("pressed", self, "hide")
	for i in variables.resists_list:
		if i == 'all': continue
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

func open(character = ResourceScripts.scriptdict.class_slave.new("temp_char_stats")):
	$name.text = character.get_short_name()
	$Portrait.texture = character.get_icon()
	if character.is_players_character:
		$Background.texture = load("res://assets/Textures_v2/BATTLE/Panels/panel_battle_charinfo_l.png")
	else:
		$Background.texture = load("res://assets/Textures_v2/BATTLE/Panels/panel_battle_charinfo_r.png")
	for i in ['hp','mp']:
		$VBoxContainer.get_node(i).text = str(floor(character.get_stat(i))) + "/" + str(floor(character.get_stat(i+"max")))
	
	for i in variables.fighter_stats_list:
		if !i in ['hpmax', 'mpmax','critmod']:
			$"base stats".get_node(i).text = str(floor(character.get_stat(i)))
		elif i == 'critmod':
			$"base stats".get_node(i).text = str(floor(character.get_stat(i)*100))
	
	for i in $resists.get_children():
		if !statdata.statdata.has('resist_' + i.name):
			continue
		var tmp = character.get_stat('resist_' + i.name)
		i.text = str(tmp)
		if tmp > 0:
			i.set("custom_colors/font_color", variables.hexcolordict.yellow)
		elif tmp < 0:
			i.set("custom_colors/font_color", variables.hexcolordict.green)
		else:
			i.set("custom_colors/font_color", variables.hexcolordict.white)
	
	globals.build_buffs_for_char(character, $buffscontainer, 'all')

