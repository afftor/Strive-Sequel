extends Control

var gamepaused_nonplayer = false
var gamepaused = false
var gamespeed = 1
var previouspeed = 0
onready var timebuttons = [$"TimeNode/0speed", $"TimeNode/1speed", $"TimeNode/2speed"]


func _ready():
	for i in Skilldata.professions.values():
		i.name = tr("PROF" + i.code.to_upper())
		i.descript = tr("PROF" + i.code.to_upper()+"DESCRIPT")
	
	for i in Items.materiallist.values():
		i.name = tr("MATERIAL" + i.code.to_upper())
		i.descript = tr("MATERIAL" + i.code.to_upper()+"DESCRIPT")
	
	for i in Items.itemlist.values():
		i.name = tr("ITEM" + i.code.to_upper())
		i.descript = tr("ITEM" + i.code.to_upper()+"DESCRIPT")
	
	$InventoryButton.connect("pressed",self,'open_inventory')
	$CraftButton.connect("pressed",self,"open_craft")
	
	state.connect("task_added", self, 'build_task_bar')

func open_inventory():
	$Inventory.open()

func open_craft():
	$CraftPanel.open()


func _process(delta):
	if self.visible == false:
		return
	$TimeNode/HidePanel.visible = gamepaused_nonplayer
	settime()
	
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
		state.daytime += delta * gamespeed
		for i in state.characters.values():
			pass


func settime():
	if state.daytime > variables.TimePerDay:
		state.date += 1
		state.daytime = 0
		globals.EventCheck() #После переноса эвентов на сигналы нужно перенести все эвенты, тригерящиеся в определенные дни на середину дня а не на начало
	$TimeNode/Date.text = tr("DAY") + ": " + str(state.date)
	$TimeNode/TimeWheel.rect_rotation = (state.daytime / variables.TimePerDay * 360) - 90

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
		if i.code in ['alchemy','tailor','cook','forge']:
			pass
		else:
			newnode.get_node("icon").texture = Items.materiallist[races.tasklist[i.code].production[i.product].item].icon
		newnode.get_node("ProgressBar").max_value = i.threshhold
		newnode.get_node("ProgressBar").value = i.progress
		newnode.set_meta("dict", i)

func update_task_bar():
	for i in $TaskProgress/ScrollContainer/VBoxContainer.get_children():
		if i.has_meta("dict"):
			var task = i.get_meta('dict')
			i.get_node("ProgressBar").value = task.progress

func open_task_panel(task):
	globals.ClearContainer($TaskPanel/ScrollContainer/HBoxContainer)
	for i in task.workers:
		var newbutton = globals.DuplicateContainerTemplate($TaskPanel/ScrollContainer/HBoxContainer)
		newbutton.get_node("icon").texture = i.icon
		newbutton.connect("pressed",self,"open_slave", [i])


