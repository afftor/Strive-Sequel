extends Panel


var stat_tooltip_keys = {
	atk = 'SIMATK_DESC',
	matk = 'SIMMATK_DESC',
	armor = 'SIMDEF_DESC',
	mdef = 'SIMMDEF_DESC',
	hitrate = 'SIMHITRATE_DESC',
	evasion = 'SIMEVASION_DESC',
	speed = 'SIMSPEED_DESC',
	armorpenetration = 'SIMARMORPEN_DESC',
	critchance = 'SIMCRITICAL_DESC',
	critmod = 'SIMCRITICALMOD_DESC',
}


func _ready():
	for i in variables.resists_list:
		if i == 'all': continue
		var newicon = $resists/Icon.duplicate()
		var newvalue = $resists/Value.duplicate()
		$resists.add_child(newicon)
		$resists.add_child(newvalue)
		newicon.texture = images.get_icon('resist_' + i)
		newvalue.name = i
		newicon.show()
		newvalue.show()
		globals.connecttexttooltip(newicon, tr(i.to_upper() + "RESIST_DESC"))
	for stat in stat_tooltip_keys:
		var icon_node = $base_stats.get_node_or_null("label_" + stat)
		if icon_node:
			icon_node.texture = images.get_icon(variables.fighter_stat_icons[stat])
			globals.connecttexttooltip(icon_node, tr(stat_tooltip_keys[stat]))

			
func open_base_stats():
	var character = input_handler.interacted_character

	for i in variables.fighter_stats_list:
		if !i in ['hpmax', 'mpmax','critmod', 'speed']:
			$base_stats.get_node(i).text = str(floor(character.get_stat(i)))
		elif i == 'critmod':
			$base_stats.get_node(i).text = str(floor(character.get_stat(i)*100))  + '%'
		elif i == 'speed':
			$base_stats.get_node(i).text = str(floor(character.get_stat(i)[0]))

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

