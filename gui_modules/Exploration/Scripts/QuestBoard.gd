extends Panel

var selectedquest
var category = "all"

func _ready():
	$QuestDetails/AcceptQuest.connect("pressed", self, "accept_quest")
	
	for i in $guildsortVScroll.get_children():
		i.connect('pressed',self,'selectcategory', [i])
		
	quest_board()




func selectcategory(button):
	category = button.name
	for i in $guildsortVScroll.get_children():
		i.pressed = (i == button)
	quest_board()

func selectquest(button):
	category = button.name
	for i in $ScrollContainer/VBoxContainer2.get_children():
		if i == button:
			i.get_node("Label").add_font_override("font",load("res://assets/Fonts_v2/FontThemes/NOTO_SANS_Bold_24px.tres"))
		else:
			i.get_node("Label").add_font_override("font", load("res://assets/Fonts_v2/FontThemes/MainMiddle.tres"))

func _show():
	quest_board()

func quest_board():
	input_handler.ActivateTutorial("quest")
	$QuestDetails/Panel.hide()
	$QuestDetails/AcceptQuest.hide()
#	gui_controller.win_btn_connections_handler(pressed, $QuestBoard, pressed_button)
#	self.current_pressed_area_btn = pressed_button
#	# $QuestBoard.visible = pressed
	var counter = 0
	input_handler.ClearContainer($ScrollContainer/VBoxContainer2)
	for i in input_handler.active_area.quests.factions:
		for k in input_handler.active_area.quests.factions[i].values():
			if k.state == 'free' and (k.source == category or category == "all"):
				counter += 1
				var newbutton = input_handler.DuplicateContainerTemplate(
					$ScrollContainer/VBoxContainer2
				)
				newbutton.get_node("Label").text = tr(k.name)
				newbutton.get_node("Requester").text = tr(k.difficulty)
				newbutton.get_node("ButtonOverlay").connect("pressed", self, "see_quest_info", [k])
				newbutton.set_meta("quest", k)
				newbutton.get_node("ButtonOverlay").connect('pressed',self,'selectquest', [newbutton])
	$NoQuests.visible = counter == 0
	


func see_quest_info(quest):
	var req_counter : int = 0
	for i in $ScrollContainer/VBoxContainer2.get_children():
		if i.name == 'Button':
			continue
		i.pressed = i.get_meta('quest') == quest
	$QuestDetails/Panel.show()
	input_handler.ghost_items.clear()
	selectedquest = quest
	input_handler.selectedquest = quest
	input_handler.ClearContainer($QuestDetails/Panel/VBoxContainer/req/questreqs)
	input_handler.ClearContainer($QuestDetails/Panel/VBoxContainer/Label/questrewards)
	$QuestDetails/AcceptQuest.show()
	var text_name = '[center]' + tr(quest.name) + '[/center]\n'
	var text =  tr(quest.descript)
	for i in quest.requirements:
		req_counter += 1
		var newbutton = input_handler.DuplicateContainerTemplate($QuestDetails/Panel/VBoxContainer/req/questreqs)
		match i.code:
			'kill_monsters':
#				newbutton.texture = images.icons.quest_enemy
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
				newbutton.get_node("Icon").texture = images.icons.quest_enemy
				globals.connecttexttooltip(newbutton, (
					"Defeat: "
					+ tr(variables.enemy_types[i.type])
					+ " - "
					+ str(i.value)
				))
			'random_item':
				var itemtemplate = Items.itemlist[i.type]
				newbutton.get_node("Icon").texture = itemtemplate.icon
				var subtext = itemtemplate.name + ": " + str(i.value)
				if itemtemplate.has('parts'):
					#newbutton.material = load("res://src/ItemShader.tres").duplicate()
					var showcase_item = globals.CreateGearItem(i.type, i.parts)
					# input_handler.itemshadeimage(newbutton, showcase_item)
					showcase_item.set_icon(newbutton.get_node("Icon"))
					globals.connectitemtooltip_v2(newbutton, showcase_item)
					if i.has('parts'):
						subtext +=  "\nPart Requirements: "
						for k in i.parts:
							subtext += (
								"\n"
								+ tr(Items.Parts[k].name)
								+ ": "
								+ str(Items.materiallist[i.parts[k]].name)
							)
				globals.connecttexttooltip(newbutton, subtext)
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
			'complete_location':
				newbutton.get_node("Icon").texture = images.icons.quest_encounter
				globals.connecttexttooltip(newbutton, (
					"Complete quest location: "
					+ tr(worlddata.dungeons[i.type].name)
				))
				text += (
					"\n"
					+ tr(worlddata.dungeons[i.type].name)
					+ ": "
					+ tr(worlddata.dungeons[i.type].descript)
				)
			'complete_dungeon':
				newbutton.get_node("Icon").texture = images.icons.quest_dungeon
				globals.connecttexttooltip(newbutton, "Complete quest dungeon: " + tr("LOCATIONNAME" + i.type.to_upper())) #todo add dungeon name
			'random_material':
				newbutton.get_node("Icon").texture = Items.materiallist[i.type].icon
				newbutton.get_node("amount").show()
				newbutton.get_node("amount").text = str(i.value)
				globals.connectmaterialtooltip(
					newbutton,
					Items.materiallist[i.type],
					'\n\n[color=yellow]Required: ' + str(i.value) + "[/color]"
				)
			'slave_delivery':
				newbutton.get_node("Icon").texture = images.icons.quest_slave_delivery
				var tooltiptext = "Slave Required:\n"
				for k in i.statreqs:
					if k.code in ['is_master', 'is_free']:
						continue
					match k.code:
						'stat':
							if k.stat.ends_with('factor') && input_handler.globalsettings.factors_as_words:
								tooltiptext += statdata.statdata[k.stat].name +": "+ input_handler.operant_translation(k.operant) + " " +  ResourceScripts.descriptions.factor_descripts[int(k.value)] + " "  + "\n"
							else:
								tooltiptext += statdata.statdata[k.stat].name +": "+ input_handler.operant_translation(k.operant) + " " + str(k.value) + " "  + "\n"
#							tooltiptext += (
#								statdata.statdata[k.stat].name
#								+ ": "
#								+ input_handler.operant_translation(k.operant)
#								+ " "
#								+ str(k.value)
#								+ " "
#								+ "\n"
#							)
						'sex':
							tooltiptext += "Sex: " + tr('SLAVESEX' + k.value.to_upper()) + "\n"
				globals.connecttexttooltip(newbutton, tooltiptext)
			'slave_work':
				var time = ''
				var reqs = {}
				for  req in quest.requirements:
					if req.has("statreqs"):
						reqs = req.statreqs
					if req.has("work_time"):
						time = str(req.work_time)
				var sex = ''
				var prof = ''
				var stats = {}
				for r in reqs:
					if r.code == "sex":
						sex = r.value
					if r.code == "stat":
						stats[r.stat] = r.value
					if r.code == "has_profession" && r.check:
						prof = r.profession
						var profbutton = input_handler.DuplicateContainerTemplate($QuestDetails/Panel/VBoxContainer/req/questreqs)
						req_counter += 1
						var prof_icon = classesdata.professions[prof].icon
						profbutton.get_node("Icon").texture = prof_icon
						var profname = classesdata.professions[prof].name
						if classesdata.professions[prof].has('altnamereqs'):
							for req in classesdata.professions[prof].altnamereqs:
								if req.code == 'sex':
									if sex != '':
										if input_handler.operate(req.operant, req.value, sex):
											profname = classesdata.professions[prof].altname
									else:
										profname += "/" + classesdata.professions[prof].altname
									break
						var prof_name = "Required Class:\n" + profname
						globals.connecttexttooltip(profbutton, prof_name)
				newbutton.get_node("Icon").texture = images.icons.quest_slave_delivery
				var stats_text = "\nStats:\n"
				var tooltiptext = "Slave Required:\n"
				if sex != "":
					tooltiptext += "Sex: " + sex
				if !stats.empty():
					for st in stats:
						stats_text += st.capitalize() + " : " + str(stats[st]) + '\n'
					tooltiptext += stats_text
				globals.connecttexttooltip(newbutton, tooltiptext)
				text += "\nWork duration: " + time + ' days.'
			'special_task':
				var t_text = "Complete one time task"
				if i.has('name'):
					t_text += ": " + tr(i.name)
				if i.has('icon'):
					newbutton.get_node("Icon").texture = load(i.icon)
				text += t_text
				globals.connecttexttooltip(newbutton, t_text)
	
	if req_counter > 2:
		$QuestDetails/Panel/VBoxContainer/req.rect_min_size = Vector2(0,150)
	else:
		$QuestDetails/Panel/VBoxContainer/req.rect_min_size = Vector2(0,75)

	for i in quest.rewards:
		var newbutton = input_handler.DuplicateContainerTemplate(
			$QuestDetails/Panel/VBoxContainer/Label/questrewards
		)
		match i.code:
			'gear':
				var item = globals.CreateGearItem(i.item, i.itemparts)
				item.set_icon(newbutton.get_node("Icon"))
				input_handler.ghost_items.append(item)
				globals.connectitemtooltip_v2(newbutton, item)
			'gear_static':
				newbutton.get_node("Icon").texture = Items.itemlist[i.item].icon
				globals.connecttempitemtooltip(newbutton, Items.itemlist[i.item], 'geartemplate')
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
			'usable':
				var item = Items.itemlist[i.item]
				input_handler.itemshadeimage(newbutton.get_node("Icon"), item)
				newbutton.get_node("Icon").texture = item.icon
				globals.connecttempitemtooltip(newbutton, item, 'geartemplate')
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
			'material':
				var material = Items.materiallist[i.item]
				newbutton.get_node("Icon").texture = material.icon
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
				globals.connectmaterialtooltip(newbutton, material)
			'gold':
				if i.value is Array:
					newbutton.get_node("amount").show()
					newbutton.get_node("amount").text = "x" + str(stepify(i.value[0],0.1))
					newbutton.get_node("Icon").texture = images.icons.quest_gold
					globals.connecttexttooltip(newbutton, "Gold reward will be determined based on end item value.")
				else:
					var value = round(
						(
							i.value
							+ (
								i.value
								* variables.master_charm_quests_gold_bonus[int(
									ResourceScripts.game_party.get_master().get_stat('charm_factor')
								)]
							)
						)
					)
					newbutton.get_node("Icon").texture = images.icons.quest_gold
					newbutton.get_node("amount").text = str(value)
					newbutton.get_node("amount").show()
					globals.connecttexttooltip(newbutton, (
						"Gold: "
						+ str(i.value)
						+ " + "
						+ str(
							round(
								(
									i.value
									* variables.master_charm_quests_gold_bonus[int(
										ResourceScripts.game_party.get_master().get_stat('charm_factor')
									)]
								)
							)
						)
						+ " (Master Charm Bonus)")
					)
			'reputation':
				var value = round(
					(
						i.value
						+ (
							i.value
							* variables.master_charm_quests_rep_bonus[int(
								ResourceScripts.game_party.get_master().get_stat('charm_factor')
							)]
						)
					)
				)
				newbutton.get_node("Icon").texture = images.icons["guilds_" + quest.source + "_colored"]
				newbutton.get_node("amount").text = str(value)
				newbutton.get_node("amount").show()
				globals.connecttexttooltip(newbutton, (
					"Reputation ("
					+ quest.source.capitalize()
					+ "): "
					+ str(i.value)
					+ " + "
					+ str(
						round(
							(
								i.value
								* variables.master_charm_quests_rep_bonus[int(
									ResourceScripts.game_party.get_master().get_stat('charm_factor')
								)]
							)
						)
					)
					+ " (Master Charm Bonus)"
				))
		
	$QuestDetails/Panel/RichTextLabel.bbcode_text = globals.TextEncoder(text_name)
	$QuestDetails/Panel/RichTextLabel2.bbcode_text = globals.TextEncoder(text)
	$QuestDetails/Panel/time/Label.text = str(quest.time_limit) + tr("QBDAY")

func accept_quest():
	ResourceScripts.game_world.take_quest(selectedquest, input_handler.active_area)
	for i in selectedquest.requirements:
		if i.code in ['complete_dungeon', 'complete_location']:
			break
	input_handler.interactive_message('quest_accept', '', {})
	var args = {}
	args["label"] = "Task aсquired"
	args["info"] = selectedquest.name
	args["sound"] = "quest_aquired"
	input_handler.play_animation("quest", args)
	category = "all"
	quest_board()
	


func _on_Button_pressed():
	var newbutton = input_handler.DuplicateContainerTemplate($QuestDetails/Panel/VBoxContainer/req/questreqs)
	pass # Replace with function body.
