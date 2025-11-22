extends Control

var person
onready var CharMainModule = get_parent().get_parent()

func build_relatives():
	person = get_parent().person
	if person == null: return
	
	if !ResourceScripts.game_party.relativesdata.has(person.id): 
		ResourceScripts.game_party.createrelativesdata(person)
	var reldata = ResourceScripts.game_party.relativesdata[person.id]
	#parents
	input_handler.ClearContainer($Relatives/Parents, ['Head', 'panel'])
	for rel_id in ['mother', 'father']:
		if reldata[rel_id] == null: continue
		var tnewdata = ResourceScripts.game_party.relativesdata[reldata[rel_id]] #this is not granted, but it can't fail without manual data editing - so i won't check for it
		var tchar = characters_pool.get_char_by_id(reldata[rel_id]) # no check for baby here - for the same reason
		var panel = input_handler.DuplicateContainerTemplate($Relatives/Parents, 'panel')
		build_panel(panel, tnewdata, tchar)
	#siblings
	input_handler.ClearContainer($Relatives/ScrollContainer/Siblings, ['Head', 'panel'])
	for rel_id in reldata.siblings:
		var tnewdata = ResourceScripts.game_party.relativesdata[rel_id] #this is not granted, but it can't fail without manual data editing - so i won't check for it
		var tchar = characters_pool.get_char_by_id(rel_id) 
		if ResourceScripts.game_party.babies.has(rel_id): 
			#unborn baby
			continue
		var panel = input_handler.DuplicateContainerTemplate($Relatives/ScrollContainer/Siblings, 'panel')
		build_panel(panel, tnewdata, tchar)
	#children
	input_handler.ClearContainer($Relatives/ScrollContainer2/Children, ['Head', 'panel'])
	for rel_id in reldata.children:
		var tnewdata = ResourceScripts.game_party.relativesdata[rel_id] #this is not granted, but it can't fail without manual data editing - so i won't check for it
		var tchar = characters_pool.get_char_by_id(rel_id) 
		if ResourceScripts.game_party.babies.has(rel_id): 
			#unborn baby
			continue
		var panel = input_handler.DuplicateContainerTemplate($Relatives/ScrollContainer2/Children, 'panel')
		build_panel(panel, tnewdata, tchar)


func change_slave(newchar):
	input_handler.get_spec_node(input_handler.NODE_SLAVETOOLTIP).hide()
	input_handler.interacted_character = newchar #possibly wrong
	# CharMainModule.active_person = selected_person
	CharMainModule.match_state()
	CharMainModule.ClassesModule.get_node("ClassPanel").hide()
	# CharMainModule.DetailsModule.person = selected_person
	CharMainModule.DetailsModule.custom_description_open()


func build_panel(panel, tnewdata, tchar):
	panel.get_node('name').text = tnewdata.name # add any other info from relative data if you want
	if tchar != null:
		panel.get_node('Icon').texture = tchar.get_icon()
		if tchar.is_players_character: #if not sold or dead
			if !tchar.is_on_quest():
				panel.get_node('name').connect('pressed', self, 'change_slave', [tchar])
			globals.connectslavetooltip(panel.get_node('name'), tchar)
		else:
			globals.connecttexttooltip(panel.get_node('name'), build_tooltip_text(tnewdata))
#			panel.get_node('name').disabled = true
	else:
		panel.get_node('Icon').texture = null #this is bad, but we can't afford to store icons
		globals.connecttexttooltip(panel.get_node('name'), build_tooltip_text(tnewdata))
#		panel.get_node('name').disabled = true


func build_tooltip_text(reldata):
	var res = ""
	res += "Name: {name}\nRace: {race}\nSex: {sex}".format(reldata)
	if reldata.has('fate'):
		res += "\nFate: %s" % reldata.fate
	return res
