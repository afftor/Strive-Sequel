extends "res://files/Close Panel Button/ClosingPanel.gd"

var selectedcharacter


func open(classcode):
	var tempclass = Skilldata.professions[classcode]
	var text = get_class_details(tempclass)#"[center]" + tempclass.name + '[/center]\n' + tempclass.descript
	
	self.show()
	
	$TextureRect.texture = tempclass.icon
	$RichTextLabel.bbcode_text = text
	
	globals.ClearContainer($SocialSkills/HBoxContainer)
	globals.ClearContainer($CombatSkills/HBoxContainer)
	
	$SocialSkills.visible = tempclass.skills.size() > 0
	$SocialLabel.visible = $SocialSkills.visible
	$CombatSkills.visible = tempclass.combatskills.size() > 0
	$CombatLabel.visible = $CombatLabel.visible
	
	for i in tempclass.skills:
		var skill = Skilldata.Skilllist[i]
		var newnode = globals.DuplicateContainerTemplate($SocialSkills/HBoxContainer)
		newnode.texture = skill.icon
		#add_tooltip
	for i in tempclass.combatskills:
		var skill = Skilldata.Skilllist[i]
		var newnode = globals.DuplicateContainerTemplate($CombatSkills/HBoxContainer)
		#newnode.texture = skill.icon
		#add_toolti
	
	text = "Experience required: " + str(selectedcharacter.base_exp) + "/" + str(selectedcharacter.get_next_class_exp()) 
	
	$Unlock.disabled = selectedcharacter.base_exp < selectedcharacter.get_next_class_exp()
	
	$ExpLabel.text = text
	


func get_class_details(classdata):
	var text = ''
	text += "[center]" + classdata.name + '[/center]\n' + classdata.descript 
	
	if selectedcharacter.decipher_reqs(classdata.reqs, true) != '':
		text += '\n\n' + selectedcharacter.decipher_reqs(classdata.reqs, true)
	text += '\n'
	for i in classdata.statchanges:
		text += i.keys()[0] + ": " + str(i.values()[0]) + "\n"
	
	
	return text
	
	#$RichTextLabel.bbcode_text = text