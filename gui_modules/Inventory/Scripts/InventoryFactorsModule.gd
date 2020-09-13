extends Control

onready var base_stats_container = $VBoxContainer2/TextureRect2

func _ready():
	globals.connecttexttooltip(get_node("VBoxContainer2/TextureRect2/Exp"), statdata.statdata["base_exp"].descript)
	$VBoxContainer2/TextureRect4/NextClassExp.hint_tooltip = tr("NEXTCLASSEXP")# + str(person.get_next_class_exp())
	for i in base_stats_container.get_children():
		if i.name == "Exp":
			continue
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	for i in $factors1.get_children():
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	for i in $factors2.get_children():
		globals.connecttexttooltip(i, statdata.statdata[i.name].descript)
	show_factors()


func show_factors():
	var person = get_parent().selectedhero
	if person != null:
		$VBoxContainer2/TextureRect3/BaseExp.text = str(floor(person.get_stat("base_exp")))
		$VBoxContainer2/TextureRect4/NextClassExp.text = str(person.get_next_class_exp())
		for i in $factors1.get_children():
			if input_handler.globalsettings.factors_as_words:
				i.get_node("Label").text = ResourceScripts.descriptions.factor_descripts[int(floor(person.get_stat(i.name)))]
				i.get_node("Label").set("custom_colors/font_color", variables.hexcolordict['factor'+str(int(floor(person.get_stat(i.name))))])
			else:
				i.get_node("Label").text = str(floor(person.get_stat(i.name)))
				i.get_node("Label").set("custom_colors/font_color", Color(1,1,1))

		for i in $factors2.get_children():
			if input_handler.globalsettings.factors_as_words:
				i.get_node("Label").text = ResourceScripts.descriptions.factor_descripts[int(floor(person.get_stat(i.name)))]
				i.get_node("Label").set("custom_colors/font_color", variables.hexcolordict['factor'+str(int(floor(person.get_stat(i.name))))])
			else:
				i.get_node("Label").text = str(floor(person.get_stat(i.name)))
				i.get_node("Label").set("custom_colors/font_color", Color(1,1,1))

		for i in ['physics','wits','charm','sexuals']:
			if i != 'sexuals':
				var text = ''
				if person.get_stat(i+"_bonus") > 0:
					text += '+'
				if person.get_stat(i+"_bonus") != 0:
					text += str(floor(person.get_stat(i+"_bonus")))
				get_node("VBoxContainer2/TextureRect3/" + str(i)).text = str(floor(person.get_stat(i))) + text
				get_node("VBoxContainer2/TextureRect4/" + i + "2").text = str(person.get_stat(i+'_factor') * 20)
			else:
				get_node("VBoxContainer2/TextureRect3/" + i).text = str(floor(person.get_stat(i)))
				get_node("VBoxContainer2/TextureRect4/" + i + "2").text = '100'
