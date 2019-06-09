extends Control

#warning-ignore-all:return_value_discarded
var gamepaused_nonplayer = false
var gamepaused = false
var gamespeed = 1
var gametime = 0
var previouspeed = 0
onready var timebuttons = [$"TimeNode/0speed", $"TimeNode/1speed", $"TimeNode/2speed"]


func _ready():
	globals.CurrentScene = self
	
	var speedvalues = [0,1,5]
	var tooltips = [tr('PAUSEBUTTONTOOLTIP'),tr('NORMALBUTTONTOOLTIP'),tr('FASTBUTTONTOOLTIP')]
	var counter = 0
	for i in timebuttons:
		globals.connecttexttooltip(i, tooltips[counter])
		i.connect("pressed",self,'changespeed',[i])
		i.set_meta('value', speedvalues[counter])
		counter += 1
	
	
	
	$InventoryButton.connect("pressed",self,'open_inventory')
	$CraftButton.connect("pressed",self,"open_craft")
	$ExploreButton.connect("pressed",$Exploration,"open")
	$QuestlogButton.connect("pressed", self, "open_questlog")
	$UpgradeButton.connect("pressed", self, "open_upgrades")
	$MenuButton.connect("pressed", $MenuPanel, "open")
	$InteractButton.connect("pressed", $InteractionSelectPanel, 'open')
	
	
	state.money = 500
	state.log_node = $TextLog
	
	state.connect("task_added", self, 'build_task_bar')
	settime()
	
	if globals.start_new_game == false:
		var character = globals.characterdata.new()
		character.create('random', 'random', 'random')
		state.characters[character.id] = character
		character.unlock_class("master")
		character = globals.characterdata.new()
		character.create('random', 'random', 'random')
		state.characters[character.id] = character
		character = globals.characterdata.new()
		character.create('random', 'random', 'random')
		state.characters[character.id] = character
		$SlaveList.rebuild()
		globals.AddItemToInventory(globals.CreateGearItem("leather_collar", {}))
		globals.AddItemToInventory(globals.CreateGearItem("axe", {ToolHandle = 'wood', Blade = 'wood'}))
	else:
		globals.start_new_game = false
		self.visible = false
		input_handler.StartCharacterCreation("master")
		input_handler.connect("CharacterCreated", self, "show", [], 4)
	
	#$TestButton.connect("pressed",$imageselect, "chooseimage", [state.characters[state.characters.keys()[0]]])

func _process(delta):
	if self.visible == false:
		return
	$TimeNode/HidePanel.visible = gamepaused_nonplayer
	$gold.text = str(state.money)
	
	#buildscreen()
	update_task_bar()
	
	if gamepaused == false:
		for i in get_tree().get_nodes_in_group("pauseprocess"):
			if i.visible == true:
				previouspeed = gamespeed
				changespeed(timebuttons[0], false)
				gamepaused = true
				gamepaused_nonplayer = true
	else:
		var allnodeshidden = true
		for i in get_tree().get_nodes_in_group("pauseprocess"):
			if i.visible == true:
				allnodeshidden = false
				break
		
		
		
		if allnodeshidden == true && gamepaused_nonplayer == true:
			restoreoldspeed(previouspeed)
			gamepaused_nonplayer = false
			gamepaused = false
	
#	$ControlPanel/Gold.text = str(state.money)
#	$ControlPanel/Food.text = str(state.food)
	
#	$BlackScreen.visible = $BlackScreen.modulate.a > 0.0
	if gamespeed != 0:
		gametime += delta * gamespeed
		if gametime >= variables.SecondsPerHour:
			settime()
			gametime -= variables.SecondsPerHour
			state.emit_signal("hour_tick")
			state.hour += 1
			if state.hour >= variables.HoursPerDay:
				state.hour = 0
				state.date += 1
				for i in state.characters.values():
					i.cooldown_tick()
				for i in state.areas.values():
					world_gen.update_guilds(i)
			for i in state.characters.values():
				i.tick()


func settime():
#	if state.daytime > variables.TimePerDay:
#		state.date += 1
#		state.daytime = 0
#		globals.EventCheck() #После переноса эвентов на сигналы нужно перенести все эвенты, тригерящиеся в определенные дни на середину дня а не на начало
	$TimeNode/Date.text = "D: " + str(state.date) + " T: " + str(state.hour) + ":00"
	$TimeNode/TimeWheel.rect_rotation = (float(state.hour) / variables.HoursPerDay * 360)-180

func changespeed(button, playsound = true):
	var oldvalue = gamespeed
	var newvalue = button.get_meta('value')
	for i in timebuttons:
		i.pressed = i == button
	gamespeed = newvalue
	var soundarray = ['time_stop', 'time_start', 'time_up']
	if oldvalue != newvalue && playsound:
		input_handler.PlaySound(soundarray[int(button.name[0])])
	
	gamepaused = newvalue == 0
	input_handler.emit_signal("SpeedChanged", gamespeed)

func restoreoldspeed(value):
	for i in timebuttons:
		if i.get_meta("value") == value:
			changespeed(i, false)

func build_task_bar():
	globals.ClearContainer($TaskProgress/ScrollContainer/VBoxContainer)
	
	for i in state.active_tasks:
		var newnode = globals.DuplicateContainerTemplate($TaskProgress/ScrollContainer/VBoxContainer)
		newnode.get_node("Label").text = races.tasklist[i.code].name
		if i.code in ['alchemy','tailor','cook','smith']:
			if state.craftinglists[i.code].size() <= 0:
				newnode.hide()
			else:
				newnode.show()
				newnode.get_node("ProgressBar").max_value = state.craftinglists[i.code][0].workunits_needed
				newnode.get_node("ProgressBar").value = state.craftinglists[i.code][0].workunits
				newnode.get_node("icon").texture = Items.itemlist[state.craftinglists[i.code][0].code].icon
				if state.craftinglists[i.code][0].has('partdict'):
					newnode.get_node('icon').material = load("res://files/ItemShader.tres")
		elif i.product in ['prostitutegold']:
			newnode.get_node("icon").texture = races.tasklist[i.code].production[i.product].icon
			newnode.get_node("ProgressBar").max_value = i.threshhold
			newnode.get_node("ProgressBar").value = i.progress
		elif i.product == 'building':
			if state.selected_upgrade.code == '':
				newnode.hide()
			else:
				newnode.show()
				newnode.get_node("icon").texture = races.tasklist[i.code].production[i.product].icon
				newnode.get_node("ProgressBar").max_value = globals.upgradelist[state.selected_upgrade.code].levels[state.selected_upgrade.level].taskprogress
				newnode.get_node("ProgressBar").value = state.upgrade_progresses[state.selected_upgrade.code].progress
				
		else:
			newnode.get_node("icon").texture = Items.materiallist[races.tasklist[i.code].production[i.product].item].icon
			newnode.get_node("ProgressBar").max_value = i.threshhold
			newnode.get_node("ProgressBar").value = i.progress
		newnode.set_meta("dict", i)
		

func update_task_bar():
	for i in $TaskProgress/ScrollContainer/VBoxContainer.get_children():
		if i.has_meta("dict"):
			var task = i.get_meta('dict')
			if task.code in ['alchemy','tailor','cook','smith']:
				if state.craftinglists[task.code].size() <= 0:
					i.hide()
				else:
					i.show()
					i.get_node("ProgressBar").max_value = state.craftinglists[task.code][0].workunits_needed
					i.get_node("ProgressBar").value = state.craftinglists[task.code][0].workunits
			elif task.code == 'building':
				if state.selected_upgrade.code == '':
					i.hide()
				else:
					i.show()
					i.get_node("icon").texture = races.tasklist[task.code].production[task.product].icon
					i.get_node("ProgressBar").max_value = globals.upgradelist[state.selected_upgrade.code].levels[state.selected_upgrade.level].taskprogress
					i.get_node("ProgressBar").value = state.upgrade_progresses[state.selected_upgrade.code].progress
			else:
				i.visible = task.workers.size() != 0
				i.get_node("ProgressBar").value = task.progress

func open_inventory():
	input_handler.ShowInentory({mode = 'all'})

func open_craft():
	$CraftPanel.open()

func open_questlog():
	$QuestPanel.open()

func open_upgrades():
	$UpgradeList.open()
