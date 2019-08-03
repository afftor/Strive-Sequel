extends "res://files/Close Panel Button/ClosingPanel.gd"
#warning-ignore-all:return_value_discarded

var category = 'all'
var person
var mode

func _ready():
	for i in $categories.get_children():
		i.connect("pressed",self,'class_category', [i.name])
	
	$CheckBox.connect("pressed", self, "checkbox_locked")
	globals.AddPanelOpenCloseAnimation($ClassPanel)

func open(tempperson, tempmode = 'normal'):
	person = tempperson
	mode = tempmode
	show()
	globals.ClearContainer($ScrollContainer/GridContainer)
	
	for i in Skilldata.professions.values():
		if (!i.categories.has(category) && category != 'all') || !person.checkreqs(i.showupreqs):
			continue
		if !$CheckBox.pressed && person.checkreqs(i.reqs) == false:
			continue
		var newbutton = globals.DuplicateContainerTemplate($ScrollContainer/GridContainer)
		newbutton.get_node('icon').texture = i.icon
		var name = i.name
		if i.has('altname') && person.checkreqs(i.altnamereqs):
			name = i.altname
		newbutton.get_node('name').text = name
		newbutton.connect('pressed',self,"unlock_class", [i.code])

func checkbox_locked():
	open(person, mode)

func class_category(name):
	category = name
	for i in $categories.get_children():
		i.pressed = i.name == category
	open(person, mode)



func open_class(classcode):
	var tempclass = Skilldata.professions[classcode]
	var text = get_class_details(tempclass)#"[center]" + tempclass.name + '[/center]\n' + tempclass.descript
	
	$ClassPanel.show()
	
	$ClassPanel/TextureRect.texture = tempclass.icon
	$ClassPanel/RichTextLabel.bbcode_text = text
	
	globals.ClearContainer($ClassPanel/SocialSkills/HBoxContainer)
	globals.ClearContainer($ClassPanel/CombatSkills/HBoxContainer)
	
	$ClassPanel/SocialSkills.visible = tempclass.skills.size() > 0
	$ClassPanel/SocialLabel.visible = $ClassPanel/SocialSkills.visible
	$ClassPanel/CombatSkills.visible = tempclass.combatskills.size() > 0
	$ClassPanel/CombatLabel.visible = $ClassPanel/CombatLabel.visible
	
	for i in tempclass.skills:
		var skill = Skilldata.Skilllist[i]
		var newnode = globals.DuplicateContainerTemplate($ClassPanel/SocialSkills/HBoxContainer)
		newnode.texture = skill.icon
		globals.connectskilltooltip(newnode, skill.code, person)
	for i in tempclass.combatskills:
		var skill = Skilldata.Skilllist[i]
		var newnode = globals.DuplicateContainerTemplate($ClassPanel/CombatSkills/HBoxContainer)
		#newnode.texture = skill.icon
		#add_toolti
	
	text = "Experience required: " + str(floor(person.base_exp)) + "/" + str(person.get_next_class_exp()) 
	
	$ClassPanel/Unlock.disabled = person.base_exp < person.get_next_class_exp()
	
	$ClassPanel/ExpLabel.text = text



func get_class_details(classdata):
	var text = ''
	var name = classdata.name
	if classdata.has('altname') && person.checkreqs(classdata.altnamereqs):
		name = classdata.altname
	text += "[center]" + name + '[/center]\n' + person.translate(classdata.descript) 
	
	if person.decipher_reqs(classdata.reqs, true) != '':
		text += '\n\n' + person.decipher_reqs(classdata.reqs, true)
	text += '\n'
	for i in classdata.statchanges:
		text += i.keys()[0] + ": " + str(i.values()[0]) + "\n"
	
	
	return text
	
	#$RichTextLabel.bbcode_text = text


func unlock_class(i):
	open_class(i)