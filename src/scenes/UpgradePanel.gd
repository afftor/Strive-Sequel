extends "res://src/scenes/ClosingPanel.gd"
#warning-ignore-all:return_value_discarded

var selectedupgrade

func _ready():
	input_handler.AddPanelOpenCloseAnimation($UpgradeDescript)
	$UpgradeDescript/UnlockButton.connect("pressed", self, "unlockupgrade")
	
	yield(get_tree().create_timer(0.3), "timeout")
	if variables.unlock_all_upgrades == true:
		for i in upgradedata.upgradelist.values():
			ResourceScripts.game_res.upgrades[i.code] = i.levels.keys().back()
	hide()
	

func open():
	show()
	$UpgradeDescript.hide()
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	var array = []
	for i in upgradedata.upgradelist.values():
		array.append(i)
	
	array.sort_custom(self, 'sortupgrades')
	
	for i in array:
		var currentupgradelevel = findupgradelevel(i)
		
		var check = true
		if i.levels.has(currentupgradelevel+1):
			for k in i.levels[currentupgradelevel+1].unlockreqs:
				if globals.valuecheck(k) == false:
					check = false
		if check == false:
			continue
		
		var text = i.name
		
		if currentupgradelevel > 0 && i.levels.has(currentupgradelevel+1):
			text += ": " + str(currentupgradelevel+1)
		
		
		var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		if i.levels.has(currentupgradelevel+1) == false:
			newbutton.get_node("name").set("custom_colors/font_color", Color(0,0.6,0))
			text += ' Unlocked'
			#newbutton.get_node("icon").texture = i.levels[currentupgradelevel-1].icon
		#else:
			#newbutton.get_node("icon").texture = i.levels[currentupgradelevel].icon
		if ResourceScripts.game_res.upgrade_progresses.has(i.code):
			newbutton.get_node("progress").visible = true
			newbutton.get_node("progress").value = ResourceScripts.game_res.upgrade_progresses[i.code].progress
			newbutton.get_node("progress").max_value = i.levels[currentupgradelevel+1].taskprogress
		if ResourceScripts.game_res.selected_upgrade.code == i.code:
			text += " - Current Upgrade"
		newbutton.get_node("name").text = text
		newbutton.set_meta('upgrade', i)
		newbutton.connect("pressed", self, "selectupgrade", [i])
	
	if ResourceScripts.game_res.selected_upgrade.code != '':
		var tempupgrade = upgradedata.upgradelist[ResourceScripts.game_res.selected_upgrade.code]
		var tempupgradelevel = ResourceScripts.game_res.selected_upgrade.level
		$ActiveUpgrade.show()
		$ActiveUpgrade/Label.text = "Active Upgrade: " + tempupgrade.name
		$ActiveUpgrade/ProgressBar.value = ResourceScripts.game_res.upgrade_progresses[tempupgrade.code].progress
		$ActiveUpgrade/ProgressBar.max_value = tempupgrade.levels[tempupgradelevel].taskprogress
	else:
		$ActiveUpgrade.hide()
	input_handler.ActivateTutorial('upgrades')


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
	
	for i in $ScrollContainer/VBoxContainer.get_children():
		if i.name == 'Button':
			continue
		i.pressed = i.get_meta("upgrade") == selectedupgrade
	
	input_handler.ClearContainer($UpgradeDescript/HBoxContainer)
	
	var currentupgradelevel = findupgradelevel(upgrade)+1
	
	
	if currentupgradelevel > 1:
		text += '\n\n' + tr("UPGRADEPREVBONUS") + ': ' + upgrade.levels[currentupgradelevel-1].bonusdescript
	
	var canpurchase = true
	
	if upgrade.levels.has(currentupgradelevel):
		text += '\n\n' + tr("UPGRADENEXTBONUS") + ': ' + upgrade.levels[currentupgradelevel].bonusdescript
		
		$UpgradeDescript/Time.show()
		$UpgradeDescript/Time/Label.text = str(upgrade.levels[currentupgradelevel].taskprogress)
		for i in upgrade.levels[currentupgradelevel].cost:
			var item = Items.materiallist[i]
			var newnode = input_handler.DuplicateContainerTemplate($UpgradeDescript/HBoxContainer)
			newnode.get_node("icon").texture = item.icon
			var value1 = upgrade.levels[currentupgradelevel].cost[i]
			if ResourceScripts.game_res.upgrade_progresses.has(upgrade.code):
				value1 = 0
			newnode.get_node("Label").text = str(ResourceScripts.game_res.materials[i]) + "/"+ str(value1)
			globals.connectmaterialtooltip(newnode, item)
			if ResourceScripts.game_res.materials[i] >= upgrade.levels[currentupgradelevel].cost[i]:
				newnode.get_node('Label').set("custom_colors/font_color", Color(0.2,0.8,0.2))
			else:
				newnode.get_node('Label').set("custom_colors/font_color", Color(0.8,0.2,0.2))
				canpurchase = false
	else:
		$UpgradeDescript/Time.hide()
		canpurchase = false
	
	if ResourceScripts.game_res.upgrade_progresses.has(upgrade.code) && ResourceScripts.game_res.selected_upgrade.code == upgrade.code:
		canpurchase = false
	if variables.free_upgrades == true || ResourceScripts.game_res.upgrade_progresses.has(upgrade.code):
		canpurchase = true
	
	
	$UpgradeDescript/RichTextLabel.bbcode_text = text
	$UpgradeDescript/UnlockButton.visible = canpurchase

func findupgradelevel(upgrade):
	var rval = 0
	if ResourceScripts.game_res.upgrades.has(upgrade.code):
		rval = ResourceScripts.game_res.upgrades[upgrade.code]
	return int(rval)


func unlockupgrade():
	var upgrade = selectedupgrade
	var currentupgradelevel = findupgradelevel(upgrade) + 1
	
	if ResourceScripts.game_res.upgrade_progresses.has(upgrade.code):
		ResourceScripts.game_res.selected_upgrade = {code = upgrade.code, level = currentupgradelevel}
	else:
		if variables.free_upgrades == false:
			for i in upgrade.levels[currentupgradelevel].cost:
				ResourceScripts.game_res.materials[i] -= upgrade.levels[currentupgradelevel].cost[i]
		var upgradecode = upgrade.code
		
		if variables.instant_upgrades == false:
			ResourceScripts.game_res.upgrade_progresses[upgrade.code] = {level = currentupgradelevel, progress = 0}
			ResourceScripts.game_res.selected_upgrade = {code = upgradecode, level = currentupgradelevel}
		else:
			if ResourceScripts.game_res.upgrades.has(upgrade.code):
				ResourceScripts.game_res.upgrades[upgrade.code] += 1
			else:
				ResourceScripts.game_res.upgrades[upgrade.code] = 1
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

