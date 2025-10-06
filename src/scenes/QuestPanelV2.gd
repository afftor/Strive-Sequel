extends Panel

onready var name_node = $RightPanel/name
onready var descript_node = $RightPanel/QuestDescript
onready var reward_cont = $RightPanel/rewards
onready var req_cont = $RightPanel/reqs
onready var req_label = $RightPanel/Label
onready var reward_label = $RightPanel/Label2
onready var diff_label = $RightPanel/DiffLabel
onready var time_node = $RightPanel/CenterContainer
onready var time_label = $RightPanel/CenterContainer/Time/Label


func hide_all():
#	descript_node.bbcode_text = ""
	name_node.hide()
	descript_node.clear()
	reward_cont.hide()
	req_cont.hide()
	req_label.hide()
	reward_label.hide()
	diff_label.hide()
	time_node.hide()

func show_info(quest):
	reward_cont.show()
	req_cont.show()
	req_label.show()
	reward_label.show()
	time_node.show()
	name_node.show()
	show()
	input_handler.ClearContainer(req_cont)
	input_handler.ClearContainer(reward_cont)
	input_handler.ghost_items.clear()
	
	if quest.has('stage'):#main quests?
		reward_cont.hide()
		req_cont.hide()
		req_label.hide()
		reward_label.hide()
		time_node.hide()
		var quest_stage
		if scenedata.quests[quest.code].stages.has(quest.stage):
			quest_stage = scenedata.quests[quest.code].stages[quest.stage]
		else:
			quest_stage = scenedata.error_stage.duplicate()
			quest_stage.descript = quest_stage.descript % [quest.code, quest.stage]
		name_node.bbcode_text = globals.TextEncoder('[center]%s[/center]' % tr(quest_stage.name))
		descript_node.bbcode_text = globals.TextEncoder('%s\n\n%s' % [
			tr(scenedata.quests[quest.code].summary), tr(quest_stage.descript)
			])
		return
	
	diff_label.show()
	diff_label.text = "%s: %s" % [tr("DUNGEONDIFFICULTY"), tr("DUNGEONDIFFICULTY"+quest.difficulty.to_upper())]
	var quest_descript = tr(quest.descript)
	for i in quest.requirements:
		var newbutton = input_handler.DuplicateContainerTemplate(req_cont)
		match i.code:
			'kill_monsters':
				newbutton.get_node("TextureRect").texture = images.get_icon('quest_enemy')
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
				var value = String(i.value)
				if i.has('curvalue'):
					value = '%s/%s' % [i.curvalue, i.value]
				newbutton.hint_tooltip = "%s: %s - %s" % [tr("QUESTDEFEAT"), tr(variables.enemy_types[i.type]), value]
#				globals.connecttexttooltip(newbutton, "%s: %s - %s" % [tr("QUESTDEFEAT"), tr(variables.enemy_types[i.type]), i.value])
			'random_item':
				var itemtemplate = Items.itemlist[i.type]
				newbutton.get_node("TextureRect").texture = itemtemplate.icon
				newbutton.hint_tooltip = "%s: %s" % [itemtemplate.name, i.value]
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
				if itemtemplate.has('parts'):
					#newbutton.material = load("res://src/ItemShader.tres").duplicate()
					var showcase_item = globals.CreateGearItem(i.type, i.parts)
					# input_handler.itemshadeimage(newbutton, showcase_item)
					showcase_item.set_icon(newbutton.get_node("TextureRect"))
					globals.connectitemtooltip_v2(newbutton, showcase_item)
					if i.has('parts'):
						newbutton.hint_tooltip += "\n%s: " % tr("QUESTPARTREQUIREMENTS")
						for k in i.parts:
							newbutton.hint_tooltip += "\n%s: %s" % [tr(Items.Parts[k].name), Items.materiallist[i.parts[k]].name]
				#globals.connecttexttooltip(newbutton, subtext)#subtext here is hint_tooltip content
			'complete_location':
				newbutton.get_node("TextureRect").texture = images.get_icon(i.code)
				globals.connecttexttooltip(newbutton, "%s: %s" % [tr("QUESTCOMPLETEQUESTLOC"), tr(DungeonData.dungeons[i.type].name)])
				quest_descript += ("\n%s: %s" % [#?
					tr(DungeonData.dungeons[i.type].name),
					tr(DungeonData.dungeons[i.type].descript)])
			'complete_dungeon':
				var area
				if i.has('area'):
					area = i.area
				else:
					area = input_handler.active_area.code
				var locationname
				if i.has('locationname'):
					locationname = i.locationname
				else:
					locationname = DungeonData.dungeons[i.type].name
				newbutton.get_node("TextureRect").texture = images.get_icon(i.code)
				globals.connecttexttooltip(newbutton, "%s [color=aqua]%s[/color]: [color=yellow]%s[/color]" % [tr("QUESTCOMPLETEQUESTLOC2"), tr(ResourceScripts.game_world.areas[area].name), tr(locationname)])
				#globals.connecttexttooltip(newbutton, "%s: %s" % [tr("QUESTCOMPLETEQUESTLOC"), tr("LOCATIONNAME" + i.type.to_upper())])#todo add dungeon name 
			'random_material':
				newbutton.get_node("TextureRect").texture = Items.materiallist[i.type].icon
				newbutton.get_node("amount").show()
				newbutton.get_node("amount").text = str(i.value)
				globals.connectmaterialtooltip(newbutton, Items.materiallist[i.type], '\n\n[color=yellow]%s: %s[/color]' % [tr("QUESTREQUIRED"), i.value])
			'slave_delivery':
				newbutton.get_node("TextureRect").texture = images.get_icon('quest_slave_delivery')
				newbutton.get_node("amount").show()
				var value = String(i.value)
				if quest.state == 'taken':#if i.has('delivered_slaves'):
					value = "%s/%s" % [i.delivered_slaves, i.value]
				newbutton.get_node("amount").text = value
				var tooltiptext = "%s:\n" % tr("QUESTSLAVEREQUIRED")
				for k in i.statreqs:
					if k.code in ['is_master', 'is_free']:
						continue
					match k.code:
						'stat':
							var stat_name = statdata.statdata[k.stat].name
							var operant_text = input_handler.operant_translation(k.operant)
							if k.stat.ends_with('factor') && input_handler.globalsettings.factors_as_words:
								tooltiptext += "%s: %s %s \n" % [stat_name, operant_text, tr(ResourceScripts.descriptions.factor_descripts[int(k.value)])]
							elif k.stat in ['vaginal_virgin']:#operant is eq or neq, and value is bool
								if (k.operant == 'eq' and k.value) or (k.operant == 'neq' and !k.value):
									tooltiptext += "%s %s\n" % [tr("OPERANTEQ"), stat_name]
								else:
									tooltiptext += "%s %s\n" % [tr("OPERANTNEQ"), stat_name]
							elif k.stat == 'personality':
								var val
								if k.value is Array:
									val = ''
									for j in range(k.value.size()):
										if j == k.value.size()-1: val += ' %s ' % tr('REQOR')
										elif j != 0: val += ', '
										val += tr("PERSONALITYNAME" + k.value[j].to_upper())
								else:
									val = tr("PERSONALITYNAME" + k.value.to_upper())
								if k.operant == 'neq':
									tooltiptext += "%s: %s %s.\n" % [stat_name, operant_text, val]
								else:
									tooltiptext += "%s: %s.\n" % [stat_name, val]
							elif ResourceScripts.descriptions.bodypartsdata.has(k.stat):# tits_size, height, ass_size
								var val
								if k.value is Array:
									val = ''
									for j in range(k.value.size()):
										if j == k.value.size()-1: val += ' %s ' % tr('REQOR')
										elif j != 0: val += ', '
										val += ResourceScripts.descriptions.bodypartsdata[k.stat][k.value[j]].name
								else:
									val = ResourceScripts.descriptions.bodypartsdata[k.stat][k.value].name
								tooltiptext += "%s: %s %s.\n" % [stat_name, operant_text, val]
							else:
								tooltiptext += "%s: %s %s.\n" % [stat_name, operant_text, k.value]
						'sex':
							tooltiptext += "%s: " % tr('STATSEX')
							if k.has('check') and !k.check:
								tooltiptext += "%s " % tr("OPERANTNEQ")
							tooltiptext += "%s.\n" % tr('SLAVESEX'+k.value.to_upper())
						'one_of_races':
							tooltiptext += "%s: " % tr('STATRACE')
							for j in k.value:
								tooltiptext += "%s, " % tr("RACE" + j.to_upper())
							tooltiptext = "%s.\n" % tooltiptext.substr(0, tooltiptext.length() - 2)
						'race':
							tooltiptext += "%s: " % tr('STATRACE')
							if k.has('check') and !k.check:
								tooltiptext += "%s " % tr("OPERANTNEQ")
							tooltiptext += "%s.\n" % tr("RACE" + k.race.to_upper())
						'trait':
							tooltiptext += "%s: " % tr('TRAITS')
							if k.has('check') and !k.check:
								tooltiptext += "%s " % tr("OPERANTNEQ")
							tooltiptext += "%s.\n" % Traitdata.traits[k.trait].name
						'has_profession':
							tooltiptext += "%s: " % tr('REQHASCLASS')
							if k.has('check') and !k.check:
								tooltiptext += "%s " % tr("OPERANTNEQ")
							var prof_name
							if k.has("altname"):
								prof_name = classesdata.professions[k.profession].altname
							else:
								prof_name = classesdata.professions[k.profession].name
							tooltiptext += "%s.\n" % prof_name
						'gear_equiped':
							if k.has('orflag') and k.orflag:
								tooltiptext += "   %s " % tr('REQOR')
							else:
								tooltiptext += "%s: " % tr('REQMUSTHAVEGEAR')
							if k.has('check') and !k.check:
								tooltiptext += "%s " % tr("OPERANTNEQ")
							tooltiptext += "%s.\n" % Items.itemlist[k.value].name
						_:
							if k.code != 'slave_type':#crutch (temporal?) for guilds' quests
								tooltiptext += String(k).trim_prefix("{").trim_suffix("}") + "\n"
				tooltiptext += "%s/%s slaves delivered." % [i.delivered_slaves, i.value]
				if quest.has('faction'):#way to determine slave quest
					quest_descript += "\n" + tooltiptext
					
					quest_descript = quest_descript.replace("[factionname]","{color=green|"+ tr(ResourceScripts.slave_quests.get_faction(quest.faction).name) + "}")
					tooltiptext = ""
				globals.connecttexttooltip(newbutton, tooltiptext)
			'slave_work':
				var time = ''
				var reqs = {}
				for req in quest.requirements:
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
						var profbutton = input_handler.DuplicateContainerTemplate(req_cont)
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
										profname += "/%s" % classesdata.professions[prof].altname
									break
						var prof_name = "%s:\n%s" % [tr("QUESTREQUIREDCLASS"), profname]
						globals.connecttexttooltip(profbutton, prof_name)
				newbutton.get_node("TextureRect").texture = images.get_icon('quest_slave_delivery')
				var stats_text = "\n%s:\n" % tr("QUESTSTATS")
				var tooltiptext = "%s:\n" % tr("QUESTSLAVEREQUIRED")
				if sex != "":
					tooltiptext += "%s: %s" % [tr("QUESTSEX"), sex]
				if !stats.empty():
					for st in stats:
						stats_text += "%s : %s\n" % [st.capitalize(), stats[st]]
					tooltiptext += stats_text
				globals.connecttexttooltip(newbutton, tooltiptext)
				quest_descript += "\n%s: %s %s." % [tr("QUESTWORKDURATION"), time, tr("QUESTDAYS")]
			'special_task':
				var t_text = tr("QUESTCOMPLETETASK")
				if i.has('name'):
					t_text += ": %s" % tr(i.name)
				if i.has('icon'):
					newbutton.get_node("TextureRect").texture = load(i.icon)
				quest_descript += t_text
				globals.connecttexttooltip(newbutton, t_text)
	
	for i in quest.rewards:
		var newbutton = input_handler.DuplicateContainerTemplate(reward_cont)
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
				newbutton.get_node("TextureRect").texture = images.get_icon('quest_gold')
				if i.value is Array:
					newbutton.get_node("amount").show()
					newbutton.get_node("amount").text = "x%s" % stepify(i.value[0],0.1)
					globals.connecttexttooltip(newbutton, tr("QUESTGOLDREWARD"))
				else:
					var bonus = i.value * variables.master_charm_quests_gold_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))]
					var value = round(i.value + bonus)
					newbutton.get_node("amount").text = str(value)
					newbutton.get_node("amount").show()
					globals.connecttexttooltip(newbutton, "%s: %s + %s (%s)" % [
						tr("QUESTGOLD"), i.value, round(bonus),
						tr("QUESTMASTERCHARMBONUS")])
			'reputation':
				var bonus = i.value * variables.master_charm_quests_rep_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))]
				var value = round(i.value + bonus)
				newbutton.get_node("TextureRect").texture = images.get_icon("guilds_" + quest.source + "_colored")
				newbutton.get_node("amount").text = str(value)
				newbutton.get_node("amount").show()
				globals.connecttexttooltip(newbutton, ("%s (%s): %s + %s (%s)" % [
					tr("QUESTREPUTATION"), quest.source.capitalize(), i.value, round(bonus),
					tr("QUESTMASTERCHARMBONUS")]))
			'material':
				var material = Items.materiallist[i.item]
				newbutton.get_node("TextureRect").texture = material.icon
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()
				globals.connectmaterialtooltip(newbutton, material)
			'usable':
				var item = Items.itemlist[i.item]
				#input_handler.itemshadeimage(newbutton.get_node("TextureRect"), item)
				newbutton.get_node("TextureRect").texture = item.icon
				globals.connecttempitemtooltip_v2(newbutton, item, 'geartemplate')#connecttempitemtooltip
				newbutton.get_node("amount").text = str(i.value)
				newbutton.get_node("amount").show()

	name_node.bbcode_text = globals.TextEncoder('[center]%s[/center]' % tr(quest.name))
	descript_node.bbcode_text = globals.TextEncoder(quest_descript)
	var time_str
	if quest.state == 'taken':
		time_str = "%s %s." % [quest.time_limit, tr("QUESTDAYSLEFT")]
	else:
		time_str = "%s%s." % [quest.time_limit, tr("QBDAY")]#QBDAY has his own space
	time_label.text = time_str
	
	var faction_icon = $RightPanel/CenterContainer/fact_bg/fact
	var faction_stemp = $RightPanel/CenterContainer/fact_bg
	if quest.has('faction'):
		ResourceScripts.slave_quests.process_faction_icon(faction_icon, quest.faction)
		faction_stemp.show()
	elif quest.has('source') and worlddata.factiondata.has(quest.source):
		var factiondata = worlddata.factiondata[quest.source]
		faction_icon.texture = images.get_icon("guilds_" + quest.source)#factiondata.icon
		globals.connecttexttooltip(faction_icon, "%s\n%s" % [
			tr(factiondata.name), tr(factiondata.description),
		])
		faction_stemp.show()
	else:
		faction_stemp.hide()
	
	if quest.has('faction'):#way to determine slave quest:
		diff_label.hide()
		req_label.hide()
		req_cont.hide()
		
	elif !req_label.visible:
		diff_label.show()
		req_label.show()
		req_cont.show()


