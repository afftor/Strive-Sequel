extends TextureButton
var color_dict = {
	unlocked = Color(variables.hexcolordict.green),
	avail = Color(variables.hexcolordict.yellow),
	lock1 = Color(variables.hexcolordict.red),
	lock2 = Color(variables.hexcolordict.red),
	
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
	var person = get_parent().person
	set_meta("code", upgrade_id)
#	var upgrade_data = upgradedata.upgradelist[upgrade_id]
	var upgrade_data = Traitdata.traits[upgrade_id]
	if upgrade_data.has('hide_reqs') and person.checkreqs(upgrade_data.hide_reqs):
		visible = false
	else:
		visible = true
	$name.text = tr(upgrade_data.name)
	globals.connecttexttooltip(self,'[center]'+tr(upgrade_data.name)+'[/center]\n'+tr(upgrade_data.descript))
	#setup icon
	if upgrade_data.icon is String:
		$Image.texture = load(upgrade_data.icon)
	else:
		$Image.texture = upgrade_data.icon
	#setup_cost
	$cost.text = str(person.get_price_for_trait(upgrade_id))
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
		hint_tooltip += "\nRequirements are not met"
	elif  person.get_stat('loyalty') < person.get_price_for_trait(upgrade_id):
		disabled = true
		$bg.modulate = color_dict.lock1
		set_inactive()
		hint_tooltip += "\nNot enough Loyalty"
	else:
		$bg.modulate = color_dict.avail
		set_normal()


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
