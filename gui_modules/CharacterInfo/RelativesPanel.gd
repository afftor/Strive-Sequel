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
		panel.get_node('name').text = tnewdata.name # add any other info from relative data if you want
		if tchar != null:
			panel.get_node('Icon').texture = tchar.get_icon()
			if tchar.is_players_character: #if not sold or dead
				panel.connect('pressed', self, 'change_slave', [tchar])
			else:
				panel.disabled = true
		else:
			panel.get_node('Icon').texture = null #this is bad, but we can't afford to store icons
			panel.disabled = true
	#siblings
	input_handler.ClearContainer($Relatives/Siblings, ['Head', 'panel'])
	for rel_id in reldata.siblings:
		var tnewdata = ResourceScripts.game_party.relativesdata[rel_id] #this is not granted, but it can't fail without manual data editing - so i won't check for it
		var tchar = characters_pool.get_char_by_id(rel_id) 
		if ResourceScripts.game_party.babies.has(tchar.id): 
			#unborn baby
			continue
		var panel = input_handler.DuplicateContainerTemplate($Relatives/Siblings, 'panel')
		panel.get_node('name').text = tnewdata.name # add any other info from relative data if you want
		if tchar != null:
			panel.get_node('Icon').texture = tchar.get_icon()
			if tchar.is_players_character: #if not sold or dead
				panel.connect('pressed', self, 'change_slave', [tchar])
			else:
				panel.disabled = true
		else:
			panel.get_node('Icon').texture = null #this is bad, but we can't afford to store icons
			panel.disabled = true
	#children
	input_handler.ClearContainer($Relatives/Children, ['Head', 'panel'])
	for rel_id in reldata.children:
		var tnewdata = ResourceScripts.game_party.relativesdata[rel_id] #this is not granted, but it can't fail without manual data editing - so i won't check for it
		var tchar = characters_pool.get_char_by_id(rel_id) 
		if ResourceScripts.game_party.babies.has(tchar.id): 
			#unborn baby
			continue
		var panel = input_handler.DuplicateContainerTemplate($Relatives/Children, 'panel')
		panel.get_node('name').text = tnewdata.name # add any other info from relative data if you want
		if tchar != null:
			panel.get_node('Icon').texture = tchar.get_icon()
			if tchar.is_players_character: #if not sold or dead
				panel.connect('pressed', self, 'change_slave', [tchar])
			else:
				panel.disabled = true
		else:
			panel.get_node('Icon').texture = null #this is bad, but we can't afford to store icons
			panel.disabled = true


func change_slave(newchar):
	input_handler.interacted_character = newchar #possibly wrong
	# CharMainModule.active_person = selected_person
	CharMainModule.match_state()
	CharMainModule.ClassesModule.get_node("ClassPanel").hide()
	# CharMainModule.DetailsModule.person = selected_person
	CharMainModule.DetailsModule.custom_description_open()
	
#	$GridContainer/SiblingsButton.visible = newchar.get_work() != "disabled"
#	$GridContainer/DetailsButton.visible = newchar.get_work() != "disabled"
#	$GridContainer/SkillsButton.visible = newchar.get_work() != "disabled"
#	$GridContainer/GearButton.visible = newchar.get_work() != "disabled"
