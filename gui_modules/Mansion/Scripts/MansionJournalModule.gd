extends Panel
#warning-ignore-all:return_value_discarded

var selectedquest
var type = "main"


func _ready():
	gui_controller.add_close_button(self)
	$CompleteButton.connect("pressed", self, "CompleteQuest")
	$CancelButton.connect("pressed", self, "CancelQuest")
	$SelectCharacter.connect("pressed", self, "SelectCharacters")
	$ItemSelectionPanel/CancelButton.connect("pressed",self, 'hide_item_selection')
	$ItemSelectionPanel/ConfirmButton.connect("pressed", self, "turn_in_quest_items")
	$Main.connect("pressed", self, "change_type", ["main"])
	$Minor.connect("pressed", self, "change_type", ["minor"])


func change_type(newtype):
	$RightPanel/QuestDescript.bbcode_text = ""
	for i in $ScrollContainer/VBoxContainer.get_children():
		if i.has_meta('quest'):
			i.pressed = false
	type = newtype
	$Main.pressed = newtype == "main"
	$Minor.pressed = newtype == "minor"
	$CancelButton.visible = false
	$CompleteButton.visible = false
	$SelectCharacter.visible = false
	$RightPanel/QuestDescript.clear()
	$RightPanel/rewards.hide()
	$RightPanel/reqs.hide()
	$RightPanel/Label.hide()
	$RightPanel/Label2.hide()
	$RightPanel/DiffLabel.hide()
	$RightPanel/CenterContainer/Time.hide()
	hide_item_selection()
	show_quests()



func show_quests():
	for button in $ScrollContainer/VBoxContainer.get_children():
		if !button.has_meta("type"):
			continue
		button.visible = (button.get_meta("type") == type)


func open():
	# $Main.pressed = true
	$CancelButton.visible = false
	$CompleteButton.visible = false
	$SelectCharacter.visible = false
	$RightPanel/QuestDescript.clear()
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	$RightPanel/rewards.hide()
	$RightPanel/reqs.hide()
	$RightPanel/Label.hide()
	$RightPanel/Label2.hide()
	$RightPanel/DiffLabel.hide()
	$RightPanel/CenterContainer/Time.hide()
	hide_item_selection()
	for i in ResourceScripts.game_progress.active_quests:
		make_active_quest_button(i)
	for i in ResourceScripts.game_world.areas.values():
		for guild in i.quests.factions:
			for quest in i.quests.factions[guild].values():
				if quest.state == 'taken':
					make_quest_button(quest)
		for quest in i.quests.global.values():
			if quest.state == 'taken':
				make_quest_button(quest)
	change_type(type)
	show_quests()

func make_active_quest_button(quest):
	var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = scenedata.quests[quest.code].stages[quest.stage].name
	newbutton.connect("pressed", self, "show_quest_info", [quest])
	newbutton.set_meta("quest", quest)
	newbutton.set_meta("type", "main")
	# newbutton.modulate = Color(1,1,0.3)
	newbutton.hide()

func make_quest_button(quest):
	var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = quest.name
	newbutton.connect("pressed", self, "show_quest_info", [quest])
	newbutton.set_meta("quest", quest)
	newbutton.set_meta("type", "minor")
	newbutton.hide()

func show_quest_info(quest):
	$RightPanel/rewards.show()
	$RightPanel/reqs.show()
	$RightPanel/Label.show()
	$RightPanel/Label2.show()
	$RightPanel/CenterContainer/Time.show()
	$CompleteButton.show()
	$SelectCharacter.hide()
	input_handler.ClearContainer($RightPanel/reqs)
	input_handler.ClearContainer($RightPanel/rewards)
	for i in $ScrollContainer/VBoxContainer.get_children():
		if i.has_meta('quest'):
			i.pressed = i.get_meta('quest') == quest

	if !quest.has('stage'):
		$CancelButton.visible = true
		$CompleteButton.visible = true
		$RightPanel/DiffLabel.show()
		$RightPanel/DiffLabel.text = tr("DUNGEONDIFFICULTY")+": " + tr("DUNGEONDIFFICULTY"+quest.difficulty.to_upper())
		var quest_descript = quest.descript
		selectedquest = quest
		input_handler.selectedquest = quest
		for i in quest.requirements:
			var newbutton = input_handler.DuplicateContainerTemplate($RightPanel/reqs)
			match i.code:
				'kill_monsters':
					newbutton.get_node("TextureRect").texture = images.icons.quest_enemy
					newbutton.get_node("amount").text = str(i.value)
					newbutton.get_node("amount").show()
					newbutton.hint_tooltip = tr("QUESTDEFEAT")+": " + tr(variables.enemy_types[i.type]) + " - " + str(i.curvalue) + "/" + str(i.value)
				'random_item':
					var itemtemplate = Items.itemlist[i.type]
					newbutton.get_node("TextureRect").texture = itemtemplate.icon
					newbutton.hint_tooltip = itemtemplate.name + ": " + str(i.value)
					newbutton.get_node("amount").text = str(i.value)
					newbutton.get_node("amount").show()
					if itemtemplate.has('parts'):
						#newbutton.material = load("res://src/ItemShader.tres").duplicate()
						var showcase_item = globals.CreateGearItem(i.type, i.parts)
						# input_handler.itemshadeimage(newbutton, showcase_item)
						showcase_item.set_icon(newbutton.get_node("TextureRect"))
						globals.connectitemtooltip_v2(newbutton, showcase_item)
						if i.has('parts'):
							newbutton.hint_tooltip += "\n" + tr("QUESTPARTREQUIREMENTS") + ": "
							for k in i.parts:
								newbutton.hint_tooltip += "\n"+ tr(Items.Parts[k].name)  + ": " +str(Items.materiallist[i.parts[k]].name)
				'complete_location':
					newbutton.get_node("TextureRect").texture = images.icons[i.code]
					globals.connecttexttooltip(newbutton, tr("QUESTCOMPLETEQUESTLOC")+": " + tr(DungeonData.dungeons[i.type].name))
				'complete_dungeon':
					newbutton.get_node("TextureRect").texture = images.icons[i.code]
					globals.connecttexttooltip(newbutton, tr("QUESTCOMPLETEQUESTLOC2") +  " [color=aqua]" + tr(ResourceScripts.game_world.areas[i.area].name) + "[/color]: [color=yellow]" + tr(i.locationname) + "[/color]")
				'random_material':
					newbutton.get_node("TextureRect").texture = Items.materiallist[i.type].icon
					newbutton.get_node("amount").show()
					newbutton.get_node("amount").text = str(i.value)
					globals.connectmaterialtooltip(newbutton, Items.materiallist[i.type], '\n\n[color=yellow]' + tr("QUESTREQUIRED") + ': ' + str(i.value) + "[/color]")
				'slave_delivery':
					newbutton.get_node("TextureRect").texture = images.icons.quest_slave_delivery
					newbutton.get_node("amount").show()
					newbutton.get_node("amount").text = str(i.delivered_slaves) + "/" + str(i.value)
					var tooltiptext = tr("QUESTSLAVEREQUIRED")+":\n"
					for k in i.statreqs:
						if k.code in ['is_master', 'is_free']:
							continue
						match k.code:
							'stat':
								if k.stat.ends_with('factor') && input_handler.globalsettings.factors_as_words:
									tooltiptext += statdata.statdata[k.stat].name +": "+ input_handler.operant_translation(k.operant) + " " +  tr(ResourceScripts.descriptions.factor_descripts[int(k.value)]) + " "  + "\n"
								else:
									tooltiptext += statdata.statdata[k.stat].name +": "+ input_handler.operant_translation(k.operant) + " " + str(k.value) + " "  + "\n"
							'sex':
								tooltiptext += "Sex: " + tr('SLAVESEX'+k.value.to_upper()) + "\n"
							'one_of_races':
								tooltiptext += "Race: " 
								for j in k.value:
									tooltiptext += tr("RACE" + j.to_upper()) + ", "
								tooltiptext = tooltiptext.substr(0, tooltiptext.length() - 2) + ".\n"
					globals.connecttexttooltip(newbutton,tooltiptext)
				'slave_work':
					$CompleteButton.hide()
					$SelectCharacter.show()
					$SelectCharacter.disabled = quest.taken
					if quest.id in ResourceScripts.game_progress.work_quests_finished:
						$CompleteButton.show()
						$SelectCharacter.hide()
					var time = ''
					var reqs = {}
					for  req in quest.requirements:
						if req.has("statreqs"):
							reqs = req.statreqs
							char_reqs = reqs
						if req.has("work_time"):
							time = str(req.work_time)
							work_time_holder = time
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
							var profbutton = input_handler.DuplicateContainerTemplate($RightPanel/reqs)
							var prof_icon = classesdata.professions[prof].icon
							profbutton.get_node("TextureRect").texture = prof_icon
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
							var prof_name = tr("QUESTREQUIREDCLASS")+":\n" + profname
							globals.connecttexttooltip(profbutton, prof_name)
					newbutton.get_node("TextureRect").texture = images.icons.quest_slave_delivery
					var stats_text = "\n"+tr("QUESTSTATS")+":\n"
					var tooltiptext = tr("QUESTSLAVEREQUIRED")+":\n"
					tooltiptext += "Sex: " + sex
					if !stats.empty():
						for st in stats:
							stats_text += st.capitalize() + " : " + str(stats[st]) + '\n'
						tooltiptext += stats_text
					globals.connecttexttooltip(newbutton, tooltiptext)
					quest_descript += "\n"+tr("QUESTWORKDURATION")+": " + time + ' '+tr("QUESTDAYS")+'.'
				'special_task':
					$CompleteButton.hide()
					if quest.id in ResourceScripts.game_progress.work_quests_finished:
						$CompleteButton.show()
					var t_text = tr("QUESTCOMPLETETASK")
					if i.has('name'):
						t_text += ": " + tr(i.name)
					if i.has('icon'):
						newbutton.get_node("TextureRect").texture = load(i.icon)
					quest_descript += t_text
					globals.connecttexttooltip(newbutton, t_text)
		
		for i in quest.rewards:
			var newbutton = input_handler.DuplicateContainerTemplate($RightPanel/rewards)
			match i.code:
				'gear':
					var item = globals.CreateGearItem(i.item, i.itemparts)
					item.set_icon(newbutton.get_node("TextureRect"))
					input_handler.ghost_items.append(item)
					globals.connectitemtooltip_v2(newbutton, item)
				'gear_static':
					newbutton.get_node("TextureRect").texture = Items.itemlist[i.item].icon
					newbutton.get_node("amount").text = str(i.value)
					newbutton.get_node("amount").show()
					globals.connecttempitemtooltip(newbutton, Items.itemlist[i.item], 'geartemplate')
				'gold':
					newbutton.get_node("TextureRect").texture = images.icons.quest_gold
					if i.value is Array:
						newbutton.get_node("amount").show()
						newbutton.get_node("amount").text = "x" + str(stepify(i.value[0],0.1))
						globals.connecttexttooltip(newbutton, "Gold reward will be determined based on end item value.")
						
					else:
						var value = round(i.value + i.value * variables.master_charm_quests_gold_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])
						newbutton.get_node("amount").text = str(value)
						globals.connecttexttooltip(newbutton, tr("QUESTGOLD")+": " + str(i.value) + " + " + str(round(i.value * variables.master_charm_quests_gold_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])) + " ("+tr("QUESTMASTERCHARMBONUS")+")")
						newbutton.get_node("amount").show()
				'reputation':
					var value = round(i.value + i.value * variables.master_charm_quests_rep_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])
					newbutton.get_node("TextureRect").texture = images.icons["guilds_" + quest.source + "_colored"]
					newbutton.get_node("amount").text = str(value)
					newbutton.get_node("amount").show()
					globals.connecttexttooltip(newbutton, (tr("QUESTREPUTATION")+" (" + quest.source.capitalize() + "): " + str(i.value) + " + " + str(round(i.value * variables.master_charm_quests_rep_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))]))+ " ("+tr("QUESTMASTERCHARMBONUS")+")"))
				'material':
					var material = Items.materiallist[i.item]
					newbutton.get_node("TextureRect").texture = material.icon
					newbutton.get_node("amount").text = str(i.value)
					newbutton.get_node("amount").show()
					globals.connectmaterialtooltip(newbutton, material)
				'usable':
					var item = Items.itemlist[i.item]
					newbutton.get_node("TextureRect").texture = item.icon
					globals.connecttempitemtooltip_v2(newbutton, item, 'geartemplate')
					newbutton.get_node("amount").text = str(i.value)
					newbutton.get_node("amount").show()

		$RightPanel/QuestDescript.bbcode_text = '[center]' + quest.name + '[/center]\n' + quest_descript
		$RightPanel/CenterContainer/Time/Label.text = str(quest.time_limit) + " "+ tr("QUESTDAYSLEFT") + "."
	else:
		$RightPanel/rewards.hide()
		$RightPanel/reqs.hide()
		$RightPanel/Label.hide()
		$RightPanel/Label2.hide()
		$RightPanel/CenterContainer/Time.hide()
		$CancelButton.visible = false
		$CompleteButton.visible = false
		$SelectCharacter.visible = false
		var quest_stage = scenedata.quests[quest.code].stages[quest.stage]
		$RightPanel/QuestDescript.bbcode_text = globals.TextEncoder('[center]' + tr(quest_stage.name) + '[/center]\n' + tr(scenedata.quests[quest.code].summary) + "\n\n" + tr(quest_stage.descript))


var selectedslave

func CompleteQuest():
	var text = ''
	var check = true
	if variables.ignore_quest_requirements:
		CompleteReqs()
		return
	
	for i in selectedquest.requirements:
		if i.code == 'random_item' && i.completed == false:
			select_items_for_quest(i)
			return
		elif i.code == 'slave_delivery' && i.value > i.delivered_slaves:
			select_character_for_quest(i)
			return
	if selectedquest.state == 'taken':
		for i in selectedquest.requirements:
			match i.code:
				'kill_monsters':
					check = i.value <= i.curvalue
				"random_material":
					check = ResourceScripts.game_res.if_has_material(i.type, 'gte', i.value)
				"random_item":
					check = i.completed
				"slave_delivery":
					check = i.value == i.delivered_slaves
				'complete_dungeon':
					check = i.completed
				'complete_location':
					check = i.completed
			if check == false:
				break
		if check == false:
			input_handler.SystemMessage(tr("REQUIREMENTSARENTMET"))
			input_handler.PlaySound("error")
			return
		else:
			CompleteReqs()

func select_character_for_quest(reqs):
	selected_req = reqs
	var statreqs = reqs.statreqs.duplicate(true)
	statreqs.append({code = 'workrule', value = 'lock', check = false})
	input_handler.ShowSlaveSelectPanel(self, 'character_selected', statreqs)

var tchar = null
func character_selected(character):
	tchar = character
	if character.is_unique():
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'character_selected_coonfirm', "Give away unique slave? They will be lost forever."])
	else:
		character_selected_coonfirm()

func character_selected_coonfirm():
	var character = tchar
	ResourceScripts.game_party.add_fate(character.id, tr("SOLD")) #or not sold
	ResourceScripts.game_party.remove_slave(character, true)
	selected_req.delivered_slaves += 1
	show_quest_info(selectedquest)
	if selected_req.delivered_slaves == selected_req.value:
		CompleteQuest()
	input_handler.rebuild_slave_list()

func CompleteReqs():
	for i in selectedquest.requirements:
		match i.code:
			"random_material":
				ResourceScripts.game_res.set_material(i.type, '-', i.value)
	selectedquest.state = 'complete'
	globals.text_log_add("quest", tr("QUESTCOMPLETEMESSAGE")+": " + selectedquest.name)
	Reward()

var char_reqs
func SelectCharacters():
	input_handler.ShowSlaveSelectPanel(self, 'event_person_selected', char_reqs)


var selected_character
func event_person_selected(character):
	selected_character = character
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'event_person_selected_confirm', tr('SENDCHARTOQUESTCONFIRM')])


var work_time_holder
func event_person_selected_confirm():
	var character = selected_character
	character.assign_to_quest_and_make_unavalible(selectedquest, work_time_holder)
	var quest_taken = ResourceScripts.game_world.get_quest_by_id(selectedquest.id)
	quest_taken.taken = true
	show_quest_info(selectedquest)


func Reward():
	# input_handler.PlaySound("questcomplete")
	var is_recount_reputation = false
	var reputation_value = 0
	var guild
	for i in selectedquest.rewards:
		match i.code:
			'gold':
				if i.value is Array:
					var val = i.value[0] * selectedquest.turned_value
					val *= 1 +  variables.master_charm_quests_gold_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))]
					ResourceScripts.game_res.money += round(val)
				else:
					ResourceScripts.game_res.money += round(i.value + i.value * variables.master_charm_quests_gold_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])
			'reputation':
				# ResourceScripts.game_world.areas[selectedquest.area].factions[selectedquest.source].reputation += round(i.value + i.value * variables.master_charm_quests_rep_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])
				# ResourceScripts.game_world.areas[selectedquest.area].factions[selectedquest.source].totalreputation += round(i.value + i.value * variables.master_charm_quests_rep_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])
				reputation_value = round(i.value + i.value * variables.master_charm_quests_rep_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])
				guild = selectedquest.source
				is_recount_reputation = true
			'gear':
				globals.AddItemToInventory(globals.CreateGearItemQuest(i.item, i.itemparts, selectedquest))
			'gear_static':
				globals.AddItemToInventory(globals.CreateGearItem(i.item, {}))
			'material':
				ResourceScripts.game_res.materials[i.item] += i.value
			'usable':
				globals.AddItemToInventory(globals.CreateUsableItem(i.item, i.value))

	#remake into data system
	if selectedquest.area == 'plains':
		for i in ResourceScripts.game_world.areas[selectedquest.area].factions.values():
			if i.totalreputation >= 300 && ResourceScripts.game_progress.get_active_quest("guilds_introduction") != null && ResourceScripts.game_progress.get_active_quest("guilds_introduction").stage == 'stage1':
				ResourceScripts.game_progress.get_active_quest("guilds_introduction").stage = 'stage1_5'
				globals.common_effects([{code = 'add_timed_event', value = "guilds_elections_switch", args = [{type = 'add_to_date', date = [1,1], hour = 1}]}])
	if ResourceScripts.game_progress.get_active_quest("guilds_introduction") != null && ResourceScripts.game_progress.get_active_quest("guilds_introduction").stage == 'stage1_5':
		var counter = false
		for i in ResourceScripts.game_progress.stored_events.timed_events:
			if i.has('action'):
				continue
			if i.code == 'guilds_elections_switch':
				counter = true
		if counter == false:
			globals.common_effects([{code = 'add_timed_event', value = "guilds_elections_switch", args = [{type = 'add_to_date', date = [1,1], hour = 1}]}])
	open()
	input_handler.play_animation("repeatable_quest_completed")
	yield(get_tree().create_timer(3.5), 'timeout')
	if is_recount_reputation:
		globals.common_effects([{code = 'reputation', name = guild, value = reputation_value, operant = '+'}])

func CancelQuest():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'cancel_quest_confirm', tr("FORFEITQUESTQUESTION")])
	#input_handler.ShowConfirmPanel(self, "cancel_quest_confirm", "Forfeit This Quest?")


func cancel_quest_confirm():
	for ch in ResourceScripts.game_party.characters.values():
		if ch.is_on_quest() and ch.get_work() != 'disabled' and selectedquest.id == ch.get_selected_quest():
			ch.remove_from_work_quest()
	ResourceScripts.game_world.complete_quest(selectedquest, "failed")
	open()

var selected_items = []
var selected_req

func select_items_for_quest(quest_req):
	$ItemSelectionPanel.show()
	selected_items.clear()
	selected_req = quest_req
	$ItemSelectionPanel/ConfirmButton.disabled = true
	input_handler.ClearContainer($ItemSelectionPanel/ScrollContainer/GridContainer)
	var array = []
	for i in ResourceScripts.game_res.items.values():
		if i.itembase != quest_req.type || i.owner != null:
			continue
		if quest_req.has('parts'):
			var f = true
			for part in quest_req.parts:
				if !i.parts.has(part) or i.parts[part] != quest_req.parts[part]:
					f = false
					break
			if !f: continue
		array.append(i)
	$ItemSelectionPanel/noitems.visible = array.size() == 0
	for i in array:
		var newbutton = input_handler.DuplicateContainerTemplate($ItemSelectionPanel/ScrollContainer/GridContainer)
		newbutton.connect('pressed', self, 'item_pressed', [i])
		i.set_icon(newbutton.get_node("TextureRect"))
		globals.connectitemtooltip_v2(newbutton, i)
		if i.amount > 1:
			newbutton.get_node("Amount").text = str(i.amount)
			newbutton.get_node("Amount").show()
	item_selection_update()


func item_pressed(item):
	if selected_items.has(item):
		selected_items.erase(item)
	else:
		selected_items.append(item)
	item_selection_update()


func item_selection_update():
	var existing_items = {}
	for i in selected_items:
		input_handler.AddOrIncrementDict(existing_items, {i.itembase : i.amount})
	var amount = 0
	if existing_items.has(selected_req.type):
		amount = existing_items[selected_req.type]
	var text = 'Required Items: ' + Items.itemlist[selected_req.type].name + ": " + str(amount) + "/"+ str(selected_req.value) + '.'
	$ItemSelectionPanel/RichTextLabel.bbcode_text = text


	$ItemSelectionPanel/ConfirmButton.disabled = amount < selected_req.value


func hide_item_selection():
	$ItemSelectionPanel.hide()


func turn_in_quest_items():
	if !selectedquest.has('turned_value') :
		selectedquest.turned_value = 0
	var amount = selected_req.value
	for i in selected_items:
		if i.amount < amount:
			amount -= i.amount
			selectedquest.turned_value += i.calculateprice() * i.amount
			i.amount = 0
		else:
			i.amount -= amount
			selectedquest.turned_value += i.calculateprice() * amount
	
	input_handler.emit_signal("update_itemlist")
	selected_req.completed = true
	$ItemSelectionPanel.hide()
	CompleteQuest()


