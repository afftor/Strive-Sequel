extends "res://files/Close Panel Button/ClosingPanel.gd"
#warning-ignore-all:return_value_discarded

var selectedupgrade

func _ready():
	globals.AddPanelOpenCloseAnimation($UpgradeDescript)
	$UpgradeDescript/UnlockButton.connect("pressed", self, "unlockupgrade")
	
	if variables.unlock_all_upgrades == true:
		for i in globals.upgradelist.values():
			selectupgrade(i)
			unlockupgrade()
	yield(get_tree().create_timer(0.3), "timeout")
	hide()
	

func open():
	show()
	$UpgradeDescript.hide()
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	var array = []
	for i in globals.upgradelist.values():
		array.append(i)
	
	array.sort_custom(self, 'sortupgrades')
	
	for i in array:
		var currentupgradelevel = findupgradelevel(i)
		
		var check = true
		if i.levels.has(currentupgradelevel):
			for k in i.levels[currentupgradelevel].unlockreqs:
				if state.valuecheck(k) == false:
					check = false
		if check == false:
			continue
		
		var text = i.name
		
		if currentupgradelevel > 1 && i.levels.has(currentupgradelevel):
			text += ": " + str(currentupgradelevel)
		
		
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		if i.levels.has(currentupgradelevel) == false:
			newbutton.get_node("name").set("custom_colors/font_color", Color(0,0.6,0))
			text += ' Unlocked'
			newbutton.get_node("icon").texture = i.levels[currentupgradelevel-1].icon
		else:
			newbutton.get_node("icon").texture = i.levels[currentupgradelevel].icon
		if state.upgrade_progresses.has(i.code):
			newbutton.get_node("progress").visible = true
			newbutton.get_node("progress").value = state.upgrade_progresses[i.code].progress
			newbutton.get_node("progress").max_value = i.levels[currentupgradelevel].taskprogress
		if state.selected_upgrade.code == i.code:
			text += " - Current Upgrade"
		newbutton.get_node("name").text = text
		newbutton.connect("pressed", self, "selectupgrade", [i])
	
	if state.selected_upgrade.code != '':
		var tempupgrade = globals.upgradelist[state.selected_upgrade.code]
		var tempupgradelevel = state.selected_upgrade.level
		$ActiveUpgrade.show()
		$ActiveUpgrade/Label.text = "Active Upgrade: " + tempupgrade.name
		$ActiveUpgrade/ProgressBar.value = state.upgrade_progresses[tempupgrade.code].progress
		$ActiveUpgrade/ProgressBar.max_value = tempupgrade.levels[tempupgradelevel].taskprogress
	else:
		$ActiveUpgrade.hide()


func sortupgrades(first, second):
	if first.levels.has(findupgradelevel(first)) && second.levels.has(findupgradelevel(second)):
		if first.positionorder < second.positionorder:
			return true
		else:
			return false
	elif first.levels.has(findupgradelevel(first)):
		return true
	else:
		return false

func selectupgrade(upgrade):
	var text = upgrade.descript
	selectedupgrade = upgrade
	$UpgradeDescript.show()
	$UpgradeDescript/Label.text = upgrade.name
	
	
	
	globals.ClearContainer($UpgradeDescript/HBoxContainer)
	
	var currentupgradelevel = findupgradelevel(upgrade)
	
	
	if currentupgradelevel > 1:
		text += '\n\n' + tr("UPGRADEPREVBONUS") + ': ' + upgrade.levels[currentupgradelevel-1].bonusdescript
	
	var canpurchase = true
	
	if upgrade.levels.has(currentupgradelevel):
		text += '\n\n' + tr("UPGRADENEXTBONUS") + ': ' + upgrade.levels[currentupgradelevel].bonusdescript
		
		for i in upgrade.levels[currentupgradelevel].cost:
			var item = Items.materiallist[i]
			var newnode = globals.DuplicateContainerTemplate($UpgradeDescript/HBoxContainer)
			newnode.get_node("icon").texture = item.icon
			newnode.get_node("Label").text = str(state.materials[i]) + "/"+ str(upgrade.levels[currentupgradelevel].cost[i])
			globals.connectmaterialtooltip(newnode, item)
			if state.materials[i] >= upgrade.levels[currentupgradelevel].cost[i]:
				newnode.get_node('Label').set("custom_colors/font_color", Color(0,0.6,0))
			else:
				newnode.get_node('Label').set("custom_colors/font_color", Color(0.6,0,0))
				canpurchase = false
	else:
		canpurchase = false
	
	if state.upgrade_progresses.has(upgrade.code):
		canpurchase = false
	if variables.free_upgrades == true:
		canpurchase = true
	
	$UpgradeDescript/RichTextLabel.bbcode_text = text
	$UpgradeDescript/UnlockButton.visible = canpurchase

func findupgradelevel(upgrade):
	var rval = 1
	if state.upgrades.has(upgrade.code):
		rval += state.upgrades[upgrade.code]
	return rval

func unlockupgrade():
	var upgrade = selectedupgrade
	var currentupgradelevel = findupgradelevel(upgrade)
	if variables.free_upgrades == false:
		for i in upgrade.levels[currentupgradelevel].cost:
			state.materials[i] -= upgrade.levels[currentupgradelevel].cost[i]
	var upgradecode = upgrade.code
	
	if variables.instant_upgrades == false:
		
		state.upgrade_progresses[upgrade.code] = {level = currentupgradelevel, progress = 0}
		state.selected_upgrade = {code = upgradecode, level = currentupgradelevel}
		
	else:
		
		if state.upgrades.has(upgrade.code):
			state.upgrades[upgrade.code] += 1
		else:
			state.upgrades[upgrade.code] = 1
	
	open()
	#input_handler.emit_signal("UpgradeUnlocked", upgrade)
	#animation
#	if upgrade.levels[currentupgradelevel].has("townnode"):
#		var animnode
#		if get_parent().has_node(upgrade.levels[currentupgradelevel].townnode):
#			animnode = get_parent().get_node(upgrade.levels[currentupgradelevel].townnode)
#		else:
#			animnode = get_parent().get_node("Background/"+upgrade.levels[currentupgradelevel].townnode)
#		if animnode != null:
#			self.modulate.a = 0
#			animnode.show()
#			input_handler.ShowOutline(animnode)
#			input_handler.UnfadeAnimation(animnode, 2.5, 0)
#			input_handler.PlaySound("building")
#			yield(get_tree().create_timer(2.5), 'timeout')
#			self.modulate.a = 1
#			input_handler.HideOutline(animnode)

