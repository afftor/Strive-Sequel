extends TextureButton
var color_dict = {
	selected = Color(variables.hexcolordict.green),
	avail = Color(variables.hexcolordict.yellow),
	lock1 = Color(variables.hexcolordict.red), #reqs not met
	lock2 = Color(variables.hexcolordict.gray), #another prof selected
	
}



func _ready():
	connect("mouse_entered", self, "set_selected")
	connect("mouse_exited", self, "set_normal")


func setup_prof(prof_id):
	if prof_id == null:
		$Image.visible = false
		$name.visible = false
		modulate = Color(0,0,0,0)
		disabled = true
		return
	var person = get_parent().person
	set_meta("code", prof_id)
#	var upgrade_data = upgradedata.upgradelist[upgrade_id]
	var upgrade_data = Traitdata.slave_profs[prof_id]
	$name.text = tr(upgrade_data.name)
	var text = '[center]'+tr(upgrade_data.name)+'[/center]\n'
	#setup icon
	if upgrade_data.icon is String:
		$Image.texture = load(upgrade_data.icon)
	else:
		$Image.texture = upgrade_data.icon
	#setup_cost
	disabled = false
	
	if person.get_stat('slave_spec') != null:
		if person.get_stat('slave_spec') != prof_id:
			disabled = true
			$bg.modulate = color_dict.lock2
			set_inactive()
			hint_tooltip += "\n"+tr("ANOTHERPROFSELECTED")
			$cost.text = ""
			$level.text = ""
			$progress.visible = false
			text += globals.build_desc_for_bonusstats(upgrade_data.bonusstats)
		else:
			set_selected()
			$bg.modulate = color_dict.selected
			$cost.text = "%d/%d" % [person.get_stat('slave_spec_progress'), person.get_next_slave_prof_lv_loyalty()]
			$progress.visible = true
			$progress.value = person.get_stat('slave_spec_progress')
			$progress.max_value = person.get_next_slave_prof_lv_loyalty()
			$level.text = input_handler.roman_number_converter(person.get_stat('slave_spec_level'))
			if !person.get_stat('loyalty_locked'):
				connect("pressed", get_parent(), "assign_loyalty")
			text += globals.build_desc_for_bonusstats(upgrade_data.bonusstats, person.get_stat('slave_spec_level'))
	else:
		$progress.visible = false
		$cost.text = "%d" % [person.get_next_slave_prof_lv_loyalty()]
		$level.text = ""
		text += globals.build_desc_for_bonusstats(upgrade_data.bonusstats)
		if person.get_stat('loyalty') < person.get_next_slave_prof_lv_loyalty():
			disabled = true
			$bg.modulate = color_dict.lock1
			set_inactive()
			hint_tooltip += "\n"+tr("NOTENOUGHLOYALTY")
		elif upgrade_data.has('reqs') and !person.checkreqs(upgrade_data.reqs):
			disabled = true
			$bg.modulate = color_dict.lock1
			set_inactive()
			hint_tooltip += "\n"+tr("REQUIREMENTSARENTMET")
		else:
			set_normal()
			$bg.modulate = color_dict.avail
			connect("pressed", get_parent(), "select_prof", [prof_id])
	for i in upgrade_data.effects:
		text += tr(Effectdata.effect_table[i].descript) + "\n"
	
	text += tr("LOYALTYSPECTOOLTIP") + "\n"
	
	
	
	text += "\n"+ tr("REQUIREMENTS_TOOLTIP") + ":" +"\n"+ tr(person.decipher_reqs(upgrade_data.reqs, true))
	
	globals.connecttexttooltip(self, text)



func set_selected():
	if disabled: return
	$Image.material = null
	$name.set("custom_colors/font_color", Color("#f9e181"))

func set_normal():
	if disabled: return
	if pressed: return
	$Image.material = null
	$name.set("custom_colors/font_color", Color("#e0e0e0"))

func set_inactive():
	$Image.material = load("res://assets/sfx/bw_shader.tres")
	$name.set("custom_colors/font_color", Color("#777777"))


func match_selected(id):
	if disabled: return
	if !visible: return
	if id != null and get_meta("code") == id:
		set_selected()
		pressed = true
	elif id == null:
		pressed = false
		set_selected()
	else:
		pressed = false
		set_normal()
