extends TextureButton
var color_dict = {
	unlocked = Color(variables.hexcolordict.green),
	avail = Color(variables.hexcolordict.yellow),
	lock1 = Color(variables.hexcolordict.red),
	lock2 = Color(variables.hexcolordict.red),
	lock3 = Color(variables.hexcolordict.red)
}



func _ready():
	connect("mouse_entered", self, "set_selected")
	connect("mouse_exited", self, "set_normal")


func setup_upgrade(upgrade_id):
	if upgrade_id == null:
		$Image.visible = false
		$name.visible = false
		modulate = Color(0,0,0,0)
		disabled = true
		return
	var list = get_parent()
	var person = list.person
	set_meta("code", upgrade_id)
#	var upgrade_data = upgradedata.upgradelist[upgrade_id]
	var upgrade_data = Traitdata.traits[upgrade_id]
	if upgrade_data.has('hide_reqs') and person.checkreqs(upgrade_data.hide_reqs):
		visible = false
	else:
		visible = true
	$name.text = tr(upgrade_data.name)
	var tooltip_text = '[center]'+tr(upgrade_data.name)+'[/center]\n'
	tooltip_text += tr(upgrade_data.descript) + "\n"
	tooltip_text += globals.build_desc_for_bonusstats(upgrade_data.bonusstats)
	#setup icon
	if upgrade_data.icon is String:
		$Image.texture = load(upgrade_data.icon)
	else:
		$Image.texture = upgrade_data.icon
	#setup_cost
	$cost.text = str(upgrade_data.l_cost)
	disabled = false
	if person.check_trait(upgrade_id):
		set_normal()
		disabled = true
		$bg.modulate = color_dict.unlocked
		$cost.visible = false
	elif upgrade_data.has('reqs') and !person.checkreqs(upgrade_data.reqs):
		disabled = true
		$bg.modulate = color_dict.lock2
		set_inactive()
		tooltip_text += "\n"+tr("REQUIREMENTSARENTMET")
	elif ((list.is_list_mastery() and
			ResourceScripts.game_progress.master_points < upgrade_data.l_cost)
			or (list.is_list_minor() and
			ResourceScripts.game_res.money < upgrade_data.l_cost)
			):
		disabled = true
		$bg.modulate = color_dict.lock1
		set_inactive()
		var tooltip_code
		if list.is_list_mastery(): tooltip_code = "NOTENOUGHMASTERPOINTS"
		elif list.is_list_minor(): tooltip_code = "NOTENOUGHGOLD"
		tooltip_text += "\n"+tr(tooltip_code)
	elif list.is_list_minor() and list.minor_training_count >= list.minor_training_max:
		disabled = true
		$bg.modulate = color_dict.lock3
		set_inactive()
		tooltip_text += "\n"+tr("MINORTRAINMAXREACHED")
	else:
		$bg.modulate = color_dict.avail
		set_normal()
	globals.connecttexttooltip(self, tooltip_text)


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
