extends Panel

var currentmission

var tutorialdict = {
	tutorial1 = {
		text = 'Visit the Market by clicking on it. ',
		trigger = 'BuildingEntered',
		mission = 'market',
		check = null,
		completioneffects = [{type = 'nexttutor', value = 'tutorial2'}]
	},
	tutorial2 = {
		text = "Assign worker to woodcutting. Open the worker menu. Select Goblin Worker. Select 'Harvest Lumber', then Confirm.",
		trigger = "WorkerAssigned",
		check = null,
		completioneffects = [{type = 'nexttutor', value = 'tutorial3'}]
	},
	tutorial3 = {
		text = "Speed up the game to make time fly faster. Use Speed buttons at the top left corner.",
		trigger = "SpeedChanged",
		mission = 10,
		check = null,
		completioneffects = [{type = 'nexttutor', value = 'tutorial4'}]
	},
	tutorial4 = {
		text = "Collect 5 Wood to progress.",
		trigger = "MaterialObtained",
		check = 'state',
		checkvalue = {type = 'has_material', material = 'wood', value = 5, operant = 'gte'},
		completioneffects = [{type = 'nexttutor', value = 'tutorial5'}]
	},
	tutorial5 = {
		text = "Purchase the Bridge upgrade to proceed. You can unlock upgrades at Town Hall.",
		trigger = "UpgradeUnlocked",
		check = 'state',
		checkvalue = {type = 'has_upgrade', name = 'bridge', value = 1}
	},
	
}


func activatetutorial(stage):
	if !tutorialdict.has(stage):
		return
	show()
	blink()
	var data = tutorialdict[stage]
	$RichTextLabel.bbcode_text = data.text
	currentmission = data
#warning-ignore:return_value_discarded
	input_handler.connect(data.trigger, self, 'sendsignal')

func sendsignal(string):
	if currentmission.has('mission') && currentmission.mission == string:
		completetutorialstage()
	elif currentmission.has('mission') == false:
		match currentmission.check:
			'state':
				if state.valuecheck(currentmission.checkvalue):
					completetutorialstage()
			null:
				completetutorialstage()

func completetutorialstage():
	var data = currentmission
	input_handler.disconnect(data.trigger, self, 'sendsignal')
	currentmission = null
	hide()
	if data.has("completioneffects"):
		for i in data.completioneffects:
			match i.type:
				'nexttutor':
					activatetutorial(i.value)

func blink():
	var tween = input_handler.GetTweenNode(self)
	tween.start()
	tween.interpolate_property(self, 'self_modulate', Color(1,1,1,0.5), Color(1,1,1,0.8), 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,1)
	tween.interpolate_property(self, 'self_modulate', Color(1,1,1,0.8), Color(1,1,1,0.5), 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,2)
	tween.interpolate_property(self, 'self_modulate', Color(1,1,1,0.5), Color(1,1,1,0.8), 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,3)
	tween.interpolate_property(self, 'self_modulate', Color(1,1,1,0.8), Color(1,1,1,0.5), 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,4)
	tween.interpolate_property(self, 'self_modulate', Color(1,1,1,0.5), Color(1,1,1,0.8), 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,5)
	tween.interpolate_property(self, 'self_modulate', Color(1,1,1,0.8), Color(1,1,1,0.5), 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,6)
