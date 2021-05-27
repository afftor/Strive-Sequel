extends TextureButton


func _ready():
	connect("mouse_entered", self, "set_selected")
	connect("mouse_exited", self, "set_normal")


func setup_upgrade(upgrade_id):
	if upgrade_id == null:
		$Progress.visible = false
		$Image.visible = false
		$name.visible = false
		modulate = Color(0,0,0,0)
		disabled = true
		return
	set_meta("code", upgrade_id)
	var upgrade_data = upgradedata.upgradelist[upgrade_id]
	var upgrade_lv = ResourceScripts.game_res.findupgradelevel(upgrade_id)
	var upgrade_state = null
	if upgrade_lv > 0:
		upgrade_state = upgrade_data.levels[upgrade_lv]
	var upgrade_next_state = null
	if upgrade_data.levels.has(upgrade_lv + 1):
		upgrade_next_state = upgrade_data.levels[upgrade_lv + 1]

	$name.text = tr(upgrade_data.name)
	#setup icon
	$Image.texture = images.upgrade_icons[upgrade_data.icon]
	if upgrade_next_state != null:
		$Image2.texture = images.upgrade_tiers[upgrade_lv+1]
	else:
		$Image2.texture = images.upgrade_tiers[upgrade_lv]
		$Image.modulate = Color(0,1,0)


#	if upgrade_next_state != null:
#		if upgrade_next_state.has('icon'):
#			$Image2.texture = images.upgrade_icons[upgrade_data.icon]
#		else:
#			$Image2.texture = null
#	else:
#		if upgrade_state.has('icon'):
#			$Image2.texture = images.upgrade_icons[upgrade_data.icon]
#		else:
#			$Image2.texture = null
		#2add maximazed decoration
	#setup state
	disabled = false
	if upgrade_next_state == null:
		pass
		#2add maximazed decoration
	elif globals.checkreqs(upgrade_next_state.unlockreqs):
		set_normal()
	else:
		disabled = true
		set_inactive()
	#setup progress
	$Progress.visible = true
	if ResourceScripts.game_res.upgrade_progresses.has(upgrade_id):
		$Progress/Label.text = "%d/%d" % [ResourceScripts.game_res.upgrade_progresses[upgrade_id].progress, upgrade_next_state.taskprogress]
		$Progress.max_value = upgrade_next_state.taskprogress
		$Progress.value = ResourceScripts.game_res.upgrade_progresses[upgrade_id].progress
#	elif upgrade_state != null:
#		$Progress/Label.text = "%d/%d" % [upgrade_state.taskprogress, upgrade_state.taskprogress]
#		$Progress.max_value = upgrade_state.taskprogress
#		$Progress.value = upgrade_state.taskprogress
	else:
		$Progress.visible = false


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
