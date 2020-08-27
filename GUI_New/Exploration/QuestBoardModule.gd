extends Panel


var is_quest_board_opened = false
onready var Shop = get_parent().get_node("ExploreShopModule")
onready var SlaveMarket = get_parent().get_node("ExploreHireModule")


func _ready():
	$QuestDetails/AcceptQuest.connect("pressed", self, "accept_quest")


func quest_board():
	var counter = 0
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	for i in get_parent().active_area.quests.factions:
		for k in get_parent().active_area.quests.factions[i].values():
			if k.state == 'free':
				counter += 1
				var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
				newbutton.get_node("Label").text = k.name
				var text = k.descript
				newbutton.get_node("RichTextLabel2").bbcode_text = globals.TextEncoder(text)
				newbutton.get_node("ButtonOverlay").connect("pressed",self,"see_quest_info", [k])
				newbutton.get_node("ButtonOverlay").connect("mouse_entered",self,"change_texture", [newbutton, "in"])
				newbutton.get_node("ButtonOverlay").connect("mouse_exited",self,"change_texture", [newbutton, "out"])
				newbutton.set_meta("quest", k)
	# get_parent().clear_submodules()
	if !get_parent().submodules.has(self):
		get_parent().submodules.append(self)
	for module in get_parent().submodules:
		if module != self:
			module.hide()
			get_parent().submodules.erase(module)
	Shop.is_shop_opened = false
	SlaveMarket.is_slave_market_opened = false
	$NoQuests.visible = counter == 0
	$QuestDetails.hide()

	# Animations
	is_quest_board_opened = !is_quest_board_opened
	if !is_quest_board_opened:
		# hide()
		return
	get_parent().City.Guild.hide()
	if get_parent().get_node("GuildBG").is_visible():
		ResourceScripts.core_animations.FadeAnimation(get_parent().get_node("GuildBG"),0.5)
		yield(get_tree().create_timer(0.5), "timeout")
		get_parent().get_node("GuildBG").hide()
	get_parent().City.opened_guild = {code = ""}
	get_parent().City.update_buttons("quest_board")
	if !self.is_visible():
		self.set("modulate", Color(1,1,1,0))
		show()
		ResourceScripts.core_animations.UnfadeAnimation(self,0.5)
		if !get_parent().get_node("GuildBG").is_visible():
			yield(get_tree().create_timer(0.5), "timeout")
		self.set("modulate", Color(1,1,1,1))
	get_parent().selectedquest = null



func change_texture(button, state):
	match state:
		"in":
			button.texture_normal = load("res://assets/Textures_v2/CITY/Universal/paper_small_active.png")
		"out":
			button.texture_normal = load("res://assets/Textures_v2/CITY/Universal/paper_small.png")


func see_quest_info(quest):
	for i in $ScrollContainer/VBoxContainer.get_children():
		if i.name == 'Button':
			continue
		i.pressed = i.get_meta('quest') == quest
	input_handler.ghost_items.clear()
	get_parent().selectedquest = quest
	$QuestDetails.show()
	input_handler.ClearContainer($QuestDetails/questreqs)
	input_handler.ClearContainer($QuestDetails/questrewards)
	var text = '[center]' + quest.name + '[/center]\n' + quest.descript
	for i in quest.requirements:
		var newbutton = input_handler.DuplicateContainerTemplate($QuestDetails/questreqs)
		match i.code:
			'kill_monsters':
				newbutton.texture = images.icons.quest_enemy
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
				newbutton.texture = images.icons.quest_enemy
				newbutton.hint_tooltip = "Hunt Monsters: " + Enemydata.enemies[i.type].name + " - " + str(i.value)
			'random_item':
				var itemtemplate = Items.itemlist[i.type]
				newbutton.texture = itemtemplate.icon
				newbutton.hint_tooltip = itemtemplate.name + ": " + str(i.value) 
				if itemtemplate.has('parts'):
					#newbutton.material = load("res://src/ItemShader.tres").duplicate()
					var showcase_item = globals.CreateGearItem(i.type, i.parts)
					input_handler.itemshadeimage(newbutton, showcase_item)
					globals.connectitemtooltip(newbutton, showcase_item)
					if i.has('parts'):
						newbutton.hint_tooltip += "\nPart Requirements: "
						for k in i.parts:
							newbutton.hint_tooltip += "\n"+ tr(Items.Parts[k].name)  + ": " +str(Items.materiallist[i.parts[k]].name)
				newbutton.get_node("amount").text = str(i.value) 
				newbutton.get_node("amount").show()
			'complete_location':
				newbutton.texture = images.icons.quest_encounter
				newbutton.hint_tooltip = "Complete quest location: " + worlddata.dungeons[i.type].name
				text += "\n" + worlddata.dungeons[i.type].name + ": " + worlddata.dungeons[i.type].descript
			'complete_dungeon':
				newbutton.texture = images.icons.quest_dungeon
				newbutton.hint_tooltip = "Complete quest dungeon: "
			'random_material':
				newbutton.texture = Items.materiallist[i.type].icon
				newbutton.get_node("amount").show()
				newbutton.get_node("amount").text = str(i.value)
				globals.connectmaterialtooltip(newbutton, Items.materiallist[i.type], '\n\n[color=yellow]Required: ' + str(i.value) + "[/color]")
			'slave_delivery':
				newbutton.texture = images.icons.quest_slave_delivery
				var tooltiptext = "Slave Required:\n"
				for k in i.statreqs:
					if k.code in ['is_master', 'is_free']:
						continue
					match k.code:
						'stat':
							tooltiptext += statdata.statdata[k.stat].name +": "+ input_handler.operant_translation(k.operant) + " " + str(k.value) + " "  + "\n"
						'sex':
							tooltiptext += "Sex: " + tr('SLAVESEX'+k.value.to_upper()) + "\n"
				globals.connecttexttooltip(newbutton,tooltiptext)
	
	for i in quest.rewards:
		var newbutton = input_handler.DuplicateContainerTemplate($QuestDetails/questrewards)
		match i.code:
			'gear':
				var item = globals.CreateGearItem(i.item, i.itemparts)
				item.set_icon(newbutton)
				input_handler.ghost_items.append(item)
				globals.connectitemtooltip(newbutton, item)
			'gear_static':
				newbutton.texture = Items.itemlist[i.item].icon
				globals.connecttempitemtooltip(newbutton, Items.itemlist[i.item], 'geartemplate')
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
			'usable':
				var item = Items.itemlist[i.item]
				newbutton.texture = item.icon
				globals.connecttempitemtooltip(newbutton, item, 'geartemplate')
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
			'material':
				var material = Items.materiallist[i.item]
				newbutton.texture = material.icon
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
				globals.connectmaterialtooltip(newbutton, material)
			'gold':
				var value = round(i.value + i.value * variables.master_charm_quests_gold_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])
				newbutton.texture = images.icons.quest_gold
				newbutton.get_node("amount").text = str(value)
				newbutton.get_node("amount").show()
				newbutton.hint_tooltip = "Gold: " + str(i.value) + " + " + str(round(i.value * variables.master_charm_quests_gold_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])) + "(Master Charm Bonus)"
			'reputation':
				var value = round(i.value + i.value * variables.master_charm_quests_rep_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])
				newbutton.texture = images.icons[i.code]
				newbutton.get_node("amount").text = str(value)
				newbutton.get_node("amount").show()
				newbutton.hint_tooltip = "Reputation (" + quest.source + "): " + str(i.value) + " + " + str(round(i.value * variables.master_charm_quests_rep_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))]))+ "(Master Charm Bonus)"
	$QuestDetails/Requester.text = ""
	$QuestDetails/Requester.text += get_parent().active_area.factions[quest.source].name + " "
	
	$QuestDetails/RichTextLabel.bbcode_text = globals.TextEncoder(text)
	$QuestDetails/time/Label.text = "Limit: " + str(quest.time_limit) + " days."


func accept_quest():
	var selectedquest = get_parent().selectedquest
	var active_area = get_parent().active_area
	ResourceScripts.game_world.take_quest(selectedquest, active_area)
	for i in selectedquest.requirements:
		if i.code in ['complete_dungeon','complete_location']:
			#input_handler.get_spec_node(input_handler.NODE_POPUP, ["You've received a new quest location.", 'Confirm'])
			#input_handler.ShowPopupPanel("You've received a new quest location.")
			#update_categories()
			break
	input_handler.interactive_message('quest_accept','',{})
	is_quest_board_opened = false
	play_animation()
	quest_board()
	var active_location = get_parent().active_location
	if active_location.has('bgm'):
		input_handler.SetMusic(active_location.bgm)



func play_animation():
	input_handler.SetMusic("quest_aquired")
	var anim_scene = input_handler.get_spec_node(input_handler.ANIM_TASK_AQUARED)
	anim_scene.get_node("SelectedQuest").text = get_parent().selectedquest.name
	anim_scene.get_node("AnimationPlayer").play("task_aquared")
	yield(get_tree().create_timer(4), "timeout")
	anim_scene.queue_free()

