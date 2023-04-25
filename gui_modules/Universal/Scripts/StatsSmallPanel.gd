extends Panel

func _ready():
	pass
#	for i in variables.resists_list:
#		if i == 'all': continue
#		var newlabel = $resists/Label.duplicate()
#		var newvalue = $resists/Value.duplicate()
#		$resists.add_child(newlabel)
#		$resists.add_child(newvalue)
#		newlabel.text = i.capitalize() + ":"
#		newvalue.name = i
#		newlabel.show()
#		newvalue.show()
#	for i in $"base stats".get_children():
#		if statdata.statdata.has(i.name.replace("label_","")):
#			globals.connecttexttooltip(i, statdata.statdata[i.name.replace("label_", "")].descript)

func fill(fighter):
	$name.text = fighter.get_stat('name')
	$Hp/HBoxContainer6/hp.text = str(floor(fighter.hp)) + "/" + str(floor(fighter.get_stat('hpmax')))
	$Mp/mp.text = str(floor(fighter.mp)) + "/" + str(floor(fighter.get_stat('mpmax')))
	$stats/HBoxContainer/atk.text = str(floor(fighter.get_stat('atk')))
	$stats/HBoxContainer2/armor.text = str(floor(fighter.get_stat('armor')))
	$stats/HBoxContainer3/mdef.text = str(floor(fighter.get_stat('mdef')))
	$stats/HBoxContainer4/matk.text = str(floor(fighter.get_stat('matk')))
	$stats/HBoxContainer5/speed.text = str(floor(fighter.get_stat('speed')))
	$stats2/HBoxContainer5/critchance.text = str(floor(fighter.get_stat('critchance')))
	$stats2/HBoxContainer6/hitrate.text = str(floor(fighter.get_stat('hitrate')))
	$stats2/HBoxContainer7/evasion.text = str(floor(fighter.get_stat('evasion')))
	$stats2/HBoxContainer8/armorpenetration.text = str(floor(fighter.get_stat('armorpenetration')))
	$stats2/HBoxContainer9/critmod.text = str(floor(fighter.get_stat('critmod')))
