extends Panel

onready var UpgradesContainer = $UpgradeList/ScrollContainer/VBoxContainer
onready var QueueContainer = $QueueList/ScrollContainer/VBoxContainer

var state_list = ['upgrades', 'queue']
var state_id = 0



func _ready():
	input_handler.AddPanelOpenCloseAnimation($UpgradeDescript)
	$UpgradeDescript/UnlockButton.connect("pressed", self, "add_to_upgrades_queue")
	$StateButton.connect("pressed", self, "change_state")
	$StateButton.text = str(state_list[state_id]).capitalize()
	yield(get_tree().create_timer(0.3), "timeout")
	if variables.unlock_all_upgrades == true:
		for i in globals.upgradelist.values():
			ResourceScripts.game_res.upgrades[i.code] = i.levels.keys().back()
	globals.connect("hour_tick", self, "update_buttons")
	# hide()

func change_state():
	if state_id == state_list.size() - 1:
		state_id = 0
	else:
		state_id += 1
	show_list()
	$StateButton.text = str(state_list[state_id]).capitalize()
	

func show_list():
	match state_list[state_id]:
		'upgrades':
			open()
		'queue':
			open_queue()
	


func open_queue():
	$UpgradeList.hide()
	$QueueList.show()
	var upgrades = ResourceScripts.game_res.upgrades_queue
	input_handler.ClearContainer(QueueContainer)
	for upgrade in upgrades:
		var text = upgradedata.upgradelist[upgrade].name
		var newbutton = input_handler.DuplicateContainerTemplate(QueueContainer)
		newbutton.set_meta('upgrade', upgradedata.upgradelist[upgrade])
		newbutton.target_node = self
		newbutton.target_function = 'open_queue'
		newbutton.arraydata = upgrade
		newbutton.parentnodearray = ResourceScripts.game_res.upgrades_queue
		newbutton.get_node("name").text = text

		var currentupgradelevel = findupgradelevel(upgradedata.upgradelist[upgrade])

		update_progress(upgradedata.upgradelist[upgrade], newbutton, currentupgradelevel)
		newbutton.set_meta('upgrade', upgrade)
		newbutton.connect("pressed", self, "selectupgrade", [upgradedata.upgradelist[upgrade]])

func open():
	$UpgradeList.show()
	$QueueList.hide()
	update_buttons()


func update_buttons():
	var array = []
	var upgrade = get_parent().selected_upgrade
	input_handler.ClearContainer(UpgradesContainer)
	for i in upgradedata.upgradelist.values():
		array.append(i)

	array.sort_custom(self, 'sortupgrades')

	for i in array:
		var currentupgradelevel = findupgradelevel(i)

		var check = true
		if i.levels.has(currentupgradelevel + 1):
			for k in i.levels[currentupgradelevel + 1].unlockreqs:
				if ResourceScripts.game_res.valuecheck(k) == false:
					check = false
		if check == false:
			continue

		var text = i.name

		if currentupgradelevel > 0 && i.levels.has(currentupgradelevel + 1):
			text += ": " + str(currentupgradelevel + 1)

		var newbutton = input_handler.DuplicateContainerTemplate(UpgradesContainer)
		if i.levels.has(currentupgradelevel + 1) == false:
			newbutton.get_node("name").set("custom_colors/font_color", Color(0, 0.6, 0))
			text += ' Unlocked'
		update_progress(i, newbutton, currentupgradelevel)
		newbutton.get_node("name").text = text
		newbutton.set_meta('upgrade', i)
		newbutton.connect("pressed", self, "selectupgrade", [i])


func update_progress(upgrade, newbutton, currentupgradelevel):
	if ResourceScripts.game_res.upgrade_progresses.has(upgrade.code):
		newbutton.get_node("progress").visible = true
		newbutton.get_node("progress").value = ResourceScripts.game_res.upgrade_progresses[upgrade.code].progress
		newbutton.get_node("progress").max_value = upgrade.levels[(currentupgradelevel	+ 1)].taskprogress


func sortupgrades(first, second):
	if first.levels.has(findupgradelevel(first)) && second.levels.has(findupgradelevel(second)):
		return first.positionorder < second.positionorder
	else:
		return first.levels.has(findupgradelevel(first))


func selectupgrade(upgrade):
	get_parent().is_upgrade_selected = true
	get_parent().active_person = null
	get_parent().selected_upgrade = upgrade
	get_parent().upgrades_manager()
	var text = upgrade.descript
	var is_already_in_queue = ResourceScripts.game_res.upgrades_queue.has(upgrade.code)
	$UpgradeDescript/UnlockButton.disabled = is_already_in_queue
	$UpgradeDescript.show()
	$UpgradeDescript/Label.text = upgrade.name

	for i in UpgradesContainer.get_children():
		if i.name == 'Button':
			continue
		i.pressed = i.get_meta("upgrade") == get_parent().selected_upgrade

	input_handler.ClearContainer($UpgradeDescript/HBoxContainer)

	var currentupgradelevel = findupgradelevel(upgrade) + 1

	if currentupgradelevel > 1:
		text += ('\n\n' + tr("UPGRADEPREVBONUS") + ': '	+ upgrade.levels[currentupgradelevel - 1].bonusdescript)

	var canpurchase = true

	if upgrade.levels.has(currentupgradelevel):
		text += ('\n\n'	+ tr("UPGRADENEXTBONUS") + ': '	+ upgrade.levels[currentupgradelevel].bonusdescript)

		$UpgradeDescript/Time.show()
		$UpgradeDescript/Time/Label.text = str(upgrade.levels[currentupgradelevel].taskprogress)
		for i in upgrade.levels[currentupgradelevel].cost:
			var item = Items.materiallist[i]
			var newnode = input_handler.DuplicateContainerTemplate($UpgradeDescript/HBoxContainer)
			newnode.get_node("icon").texture = item.icon
			var value1 = upgrade.levels[currentupgradelevel].cost[i]
			if ResourceScripts.game_res.upgrade_progresses.has(upgrade.code):
				value1 = 0
			newnode.get_node("Label").text = str(ResourceScripts.game_res.materials[i]) + "/" + str(value1)
			globals.connectmaterialtooltip(newnode, item)
			if ResourceScripts.game_res.materials[i] >= upgrade.levels[currentupgradelevel].cost[i]:
				newnode.get_node('Label').set("custom_colors/font_color", Color(0.2, 0.8, 0.2))
			else:
				newnode.get_node('Label').set("custom_colors/font_color", Color(0.8, 0.2, 0.2))
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

func start_upgrade():
	var person = get_parent().active_person
	var upgrade = get_parent().selected_upgrade
	var currentupgradelevel = findupgradelevel(upgrade) + 1
	if ResourceScripts.game_res.upgrade_progresses.has(upgrade.code):
		if ResourceScripts.game_res.upgrades_queue[0] == upgrade.code:
			return
	else:
		if variables.free_upgrades == false:
			for i in upgrade.levels[currentupgradelevel].cost:
				ResourceScripts.game_res.materials[i] -= upgrade.levels[currentupgradelevel].cost[i]
		var upgradecode = upgrade.code

		if variables.instant_upgrades == false:
			ResourceScripts.game_res.upgrade_progresses[upgrade.code] = {level = currentupgradelevel, progress = 0}
			person.assign_to_task("building", upgrade.code)
		else:
			if ResourceScripts.game_res.upgrades.has(upgrade.code):
				ResourceScripts.game_res.upgrades[upgrade.code] += 1
			else:
				ResourceScripts.game_res.upgrades[upgrade.code] = 1
	var is_already_in_queue = ResourceScripts.game_res.upgrades_queue.has(upgrade.code)
	$UpgradeDescript/UnlockButton.disabled = is_already_in_queue
	show_list()
	# open()
	get_parent().rebuild_task_info()

func add_to_upgrades_queue():
	var upgrade = get_parent().selected_upgrade
	if !ResourceScripts.game_res.upgrades_queue.has(upgrade.code):
		ResourceScripts.game_res.upgrades_queue.append(upgrade.code)
	selectupgrade(upgrade)

