extends Control

#warning-ignore-all:return_value_discarded
var gamepaused_nonplayer = false
var gamepaused = false
var gamespeed = 0
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
	
	globals.connecttexttooltip($gold/TextureRect, tr("TOOLTIPGOLD"))
	globals.connecttexttooltip($food/TextureRect, tr("TOOLTIPFOOD"))

	state.log_node = $Log
	
	state.connect("task_added", self, 'build_task_bar')
	
	$TimeNode/Date.text = "Day: " + str(state.date) + ", Hour: " + str(state.hour) + ":00"
	
	if variables.generate_test_chars:
		var character = Slave.new()
		character.create('random', 'random', 'random')
		character.penis_virgin = true
		characters_pool.move_to_state(character.id)
		character.get_trait('core_trait')
		character.unlock_class("master")
		character.charm_factor = 1
		#character.unlock_class("worker")
		character.mp = 50
#		character.unlock_class("caster")
		for i in Skilldata.Skilllist:
			if Skilldata.Skilllist[i].type != 'social':
				continue
			character.social_skills.append(i)
		character.is_players_character = true
#		globals.impregnate(character, character)
#		character.pregnancy.duration = 1
		
		character = Slave.new()
		character.create('random', 'random', 'random')
		characters_pool.move_to_state(character.id)
		character.unlock_class("fighter")
		character.get_trait('core_trait')
		character.obedience = 100
		character.lust = 50
		character.is_players_character = true
		character = Slave.new()
		character.create('random', 'random', 'random')
		characters_pool.move_to_state(character.id)
		character.obedience = 0
		character.fear = 25
		character.tame_factor = 6
		character.lust = 50
		character.base_exp += 500
		#character.exhaustion = 1000
		character.get_trait('core_trait')
		character.unlock_class("succubus")
		character.is_players_character = true
		
		#state.revert()
		for i in Items.materiallist:
			state.materials[i] = 100
		globals.AddItemToInventory(globals.CreateGearItem("strapon", {}))
		globals.AddItemToInventory(globals.CreateGearItem("pet_suit", {}))
		globals.AddItemToInventory(globals.CreateGearItem("maid_dress", {}))
		globals.AddItemToInventory(globals.CreateGearItem("craftsman_suit", {}))
		globals.AddItemToInventory(globals.CreateGearItem("worker_outfit", {}))
		globals.AddItemToInventory(globals.CreateGearItem("lacy_underwear", {}))
		globals.AddItemToInventory(globals.CreateGearItem("anal_plug", {}))
		globals.AddItemToInventory(globals.CreateGearItem("shackles", {}))
		globals.AddItemToInventory(globals.CreateGearItem("handcuffs", {}))
		globals.AddItemToInventory(globals.CreateUsableItem("alcohol"))
		globals.AddItemToInventory(globals.CreateUsableItem("hairdye"))
		globals.AddItemToInventory(globals.CreateUsableItem("minorus_potion", 3))
		globals.AddItemToInventory(globals.CreateUsableItem("majorus_potion", 3))
		globals.AddItemToInventory(globals.CreateGearItem("bow", {ToolHandle = 'wood', Blade = 'obsidian'}))
		globals.AddItemToInventory(globals.CreateGearItem("legs_base_metal", {ArmorBaseHeavy = 'mithril', ArmorTrim = 'wood'}))
		$SlaveList.rebuild()
		yield(get_tree(), 'idle_frame')
		input_handler.get_loot_node().open(world_gen.make_chest_loot('easy_chest_usable'), 'Teh Loot')
		#input_handler.interactive_message('event_good_loot_small', 'loot', {})
	elif globals.start_new_game == true:
		globals.start_new_game = false
		self.visible = false
		input_handler.StartCharacterCreation("master")
		input_handler.connect("CharacterCreated", self, "show", [], 4)
		input_handler.connect("CharacterCreated", input_handler, "StartCharacterCreation", ['slave'], 4)
	
	build_task_bar()
	$SlaveList.rebuild()
	
	input_handler.SetMusicRandom("mansion")
	
	input_handler.SystemMessageNode = $SysMessage
	
	
	
	#$TestButton.connect("pressed",$imageselect, "chooseimage", [state.characters[state.characters.keys()[0]]])

func _process(delta):
	if self.visible == false:
		return
	$TimeNode/HidePanel.visible = gamepaused_nonplayer
	$gold.text = str(state.money)
	$food.text = str(state.get_food()) + " - " + str(state.get_food_consumption())
	$population.text = "Population: "+ str(state.characters.size()) +"/" + str(state.get_pop_cap())
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
	
	if gamespeed != 0:
		gametime += delta * gamespeed
		$TimeNode/dayprogress.value = globals.calculatepercent(gametime, variables.SecondsPerHour)
		if gametime >= variables.SecondsPerHour:
			gametime -= variables.SecondsPerHour
			state.hour += 1
			if state.hour == 6:
				world_gen.update_locations()
			
			
			if state.hour >= variables.HoursPerDay:
				state.update_global_cooldowns()
				state.hour = 0
				state.date += 1
				state.daily_interactions_left = 1
				for i in state.characters.values():
					i.cooldown_tick()
					i.process_event(variables.TR_DAY)
				for i in state.areas.values():
					world_gen.update_guilds(i)
			for i in state.characters.values():
				i.pretick()
			for i in state.characters.values():
				i.act_prepared()
			for i in state.characters.values():
				i.tick()
			
			$TimeNode/Date.text = "Day: " + str(state.date) + ", Hour: " + str(state.hour) + ":00"
			state.emit_signal("hour_tick")



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
		if i.code in ['alchemy','tailor','cooking','smith','cooking']:
			if state.craftinglists[i.code].size() <= 0:
				newnode.hide()
			else:
				newnode.show()
				newnode.get_node("ProgressBar").max_value = state.craftinglists[i.code][0].workunits_needed
				newnode.get_node("ProgressBar").value = state.craftinglists[i.code][0].workunits
				var recipe = Items.recipes[state.craftinglists[i.code][0].code]
				if recipe.resultitemtype == 'material':
					newnode.get_node("icon").texture = Items.materiallist[state.craftinglists[i.code][0].code].icon
					newnode.get_node("icon/Label").show()
					newnode.get_node("icon/Label").text = str(state.materials[state.craftinglists[i.code][0].code])
				else:
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
			newnode.get_node("icon/Label").show()
			newnode.get_node("icon/Label").text = str(state.materials[races.tasklist[i.code].production[i.product].item])
		newnode.set_meta("dict", i)
		

func update_task_bar():
	for i in $TaskProgress/ScrollContainer/VBoxContainer.get_children():
		if i.has_meta("dict"):
			var task = i.get_meta('dict')
			var text = 'Active workers: '
			for i in i.workers:
				text += "\n" + state.characters[i].name
			globals.connecttexttooltip(i, text)
			if task.code in ['alchemy','tailor','cook','smith','cooking']:
				if state.craftinglists[task.code].size() <= 0:
					i.hide()
				else:
					i.show()
					var recipe = Items.recipes[state.craftinglists[task.code][0].code]
					i.get_node("ProgressBar").max_value = state.craftinglists[task.code][0].workunits_needed
					i.get_node("ProgressBar").value = state.craftinglists[task.code][0].workunits
					if recipe.resultitemtype == 'material':
						i.get_node("icon").texture = Items.materiallist[state.craftinglists[task.code][0].code].icon
						i.get_node("icon/Label").show()
						i.get_node("icon/Label").text = str(state.materials[state.craftinglists[task.code][0].code])
					else:
						i.get_node("icon").texture = Items.itemlist[state.craftinglists[task.code][0].code].icon
					if state.craftinglists[task.code][0].has('partdict'):
						i.get_node('icon').material = load("res://files/ItemShader.tres").duplicate()
						var itemtemplate = Items.itemlist[state.craftinglists[task.code][0].code]
						for k in state.craftinglists[task.code][0].partdict:
							var part = 'part' +  str(itemtemplate.partcolororder[k]) + 'color'
							var color = Items.materiallist[state.craftinglists[task.code][0].partdict[k]].color
							i.get_node("icon").material.set_shader_param(part, color)
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
				i.get_node("icon/Label").text = str(state.materials[races.tasklist[task.code].production[task.product].item])
	

func show_task_workers(newnode):
	input_handler.MousePositionScripts.append({nodes = [newnode], targetnode = self, script = 'hide_task_workers'})
	var data = newnode.get_meta("dict")

func hide_task_workers():
	pass

func open_inventory():
	input_handler.ShowInentory({mode = 'all'})

func open_craft():
	$CraftPanel.open()

func open_questlog():
	$QuestPanel.open()

func open_upgrades():
	$UpgradeList.open()
