extends Control
#warning-ignore-all:function_conflicts_variable

onready var parser = ResourceScripts.scriptdict.sexinteraction_parser.new()
onready var member = ResourceScripts.scriptdict.sexinteraction_member
onready var sexdict = ResourceScripts.scriptdict.sexinteraction_sexdict.new()

var participants = [] #members
var givers = [] #members
var takers = [] #members
var turns = 0
var actions = []
var ongoingactions = []
var location
var selectmode = 'normal'
var npcs = []
var aiobserve = false #True - player will not be picked by AI

var takercategories = ['cunnilingus','rimjob','handjob','titjob','tailjob','blowjob']
var analcategories = ['assfingering','rimjob','missionaryanal','doggyanal','lotusanal','revlotusanal','doubledildoass','inerttaila','analvibrator','enemaplug','insertinturnsass']
var punishcategories = []#globals.punishcategories
var penetratecategories = ['missionary','missionaryanal','doggy','doggyanal','lotus','lotusanal','revlotus','revlotusanal','doubledildo','doubledildoass','inserttailv','inserttaila','tribadism','frottage']


var filter = ['nosehook','relaxinginsense','facesit','afacesit','grovel','enemaplug']

var statuseffects = ['tied', 'subdued', 'drunk', 'tipsy', 'resist', 'sexcrazed','pheromones']

var selectedcategory = 'caress'
var categories = {caress = [], fucking = [], tools = [], SM = [], humiliation = [], other = []}

var secondactorcounter = {}

var submodules = []



#not used
#func dog():
#	var person = globals.newslave(globals.allracesarray[rand_range(0,globals.allracesarray.size())], 'adult', 'male')
#	var newmember = member.new()
#	newmember.sceneref = self
#	person.obedience = 90
#	person.lewdness = 70
#	person.penistype = 'canine'
#	person.name = "Dog " + str(secondactorcounter.dog)
#	person.penis_size = input_handler.weightedrandom([['average',1],['big',1]])
#	person.asser = rand_range(65, 100)
#	person.unique = 'dog'
#	person.imageportait = null
#	for i in categories.fucking:
#		person.sexexp.actions[i.code] = 15
#	newmember.setup_person(person)
#	newmember.limbs = false
#	newmember.consent = 100
#	participants.append(newmember)
#
#func horse():
#	var person = globals.newslave(globals.allracesarray[rand_range(0,globals.allracesarray.size())], 'adult', 'male')
#	var newmember = member.new()
#	newmember.sceneref = self
#	person.obedience = 90
#	person.lewdness = 70
#	person.penistype = 'equine'
#	person.asser = rand_range(65, 100)
#	person.name = "Horse " + str(secondactorcounter.horse)
#	person.height = 'tall'
#	person.penis_size = 'big'
#	person.unique = 'horse'
#	person.imageportait = null
#	for i in categories.fucking:
#		person.sexexp.actions[i.code] = 15
#	newmember.setup_person(person)
#	newmember.limbs = false
#	newmember.consent = 100
#	participants.append(newmember)

# warning-ignore-all:return_value_discarded

func _ready():
#	for i in globals.dir_contents('res://src/actions'):
#		if i.find('.remap') >= 0:
#			continue
#		var newaction = load(i).new()
	$Panel/sceneeffects1.connect("meta_clicked", self, '_on_sceneeffects1_meta_clicked')
	for i in globals.sex_actions_dict.values():
		categories[i.category].append(i)
	for i in get_node("Panel/HBoxContainer").get_children():
		i.connect("pressed",self,'changecategory',[i.get_name()])

	filter = []#globals.state.actionblacklist

	$OrgasmDenial/ScrollContainer/VBoxContainer/Cum.connect('pressed', self, "OrgasmDenialCum")
	$OrgasmDenial/ScrollContainer/VBoxContainer/Beg.connect('pressed', self, "OrgasmDenialBeg")
	$OrgasmDenial/ScrollContainer/VBoxContainer/Deny.connect('pressed', self, "OrgasmDenialDeny")

	var i = 4
	if input_handler.CurrentScene == null:
		globals.AddItemToInventory(globals.CreateUsableItem("alcohol"))
		globals.AddItemToInventory(globals.CreateUsableItem("aphrodisiac"))
		globals.AddItemToInventory(globals.CreateUsableItem("strong_pheromones", 10))
		ResourceScripts.game_res.materials.rope = 1
		while i > 0:
			i -= 1
			createtestdummy()
		turns = 10
		# createtestdummy('resist')
		changecategory('caress')
		clearstate()

		rebuildparticipantslist()


var OrgasmDenyVictim
var OrgasmDenyPlayer
var OrgasmDenyStage = 0

var OrgasmDenyTextButtons = {
	cum = 'Let [name2] cum',
	beg = 'Make [name2] beg for it',
	deny = 'Deny [name2] orgasm'
}
var OrgasmDenyText = {
	initiate = "[name1] stops [name2] before [he2] is able to reach orgasm.",
	cum_female_petting = "[name1] holds [name2] down, working [his1] hand over [name2]'s [pussy2]. In a few moments [name2] jerks in [his1] hands as orgasm overwhelms [him2].",
	cum_male_petting = "[name1] holds [name2] down, working [his1] hand over [name2]'s [penis2]. In a few moments [name2] releases a {^stream:sray} of {^semen:seed}, covering [name1]'s hand in it.",
	cum_female_fucking = "[name1] resumes moving [his1] body to [name2]'s relief. After a few thrusts [name2] gasps for air as [his2] [pussy2] twitches in orgasm. ",
	cum_male_fucking =  "[name1] allows [name2] to move again to [his2] relief. After a few thrusts, [he2] gasps for air, as [his2] seed fills [name1]. ",
	beg = "[name1] lets [name2] know that [he2] must beg to let [him2] cum. ",
	beg_success = "Unable to resist the temptation, [name2] looks into [his1] eyes and meekly begs for the relief.",
	beg_failure = "Despite shameful condition, [name2] musters enough will and turns away from [name1] in distress. [He2]'s still on the edge, hoping to get off though. ",
	deny = "[name1] does not allow [name2] to have [his2] relief by holding [him2] back. [name2] has no choice but to express [his2] disappointment. ",
}

func OrgasmDenyInitiate(player, victim):
	OrgasmDenyPlayer = player
	OrgasmDenyVictim = victim
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
	$OrgasmDenial.show()
	$OrgasmDenial/RichTextLabel.bbcode_text = decoder(OrgasmDenyText.initiate, [OrgasmDenyPlayer], [OrgasmDenyVictim])
	$OrgasmDenial/ScrollContainer/VBoxContainer/Cum.text = decoder("Let [him2] cum",[OrgasmDenyPlayer], [OrgasmDenyVictim])
	$OrgasmDenial/ScrollContainer/VBoxContainer/Beg.text = decoder("Make [him2] beg for it",[OrgasmDenyPlayer], [OrgasmDenyVictim])
	$OrgasmDenial/ScrollContainer/VBoxContainer/Deny.text = decoder("Deny [him2] orgasm",[OrgasmDenyPlayer], [OrgasmDenyVictim])
	OrgasmDenyStage = 0

func OrgasmDenialCum():
	var text = 'cum'
	if OrgasmDenyVictim.sex == 'female':
		text += '_female'
	else:
		text += '_male'
	if OrgasmDenyVictim.lastaction.scene.category == 'fucking':
		text += '_fucking'
	else:
		text += '_petting'
	#$Panel/sceneeffects.bbcode_text +="\n" +
	$OrgasmDenial/ScrollContainer/VBoxContainer/Beg.show()
	OrgasmDenyVictim.orgasm(decoder(OrgasmDenyText[text], [OrgasmDenyPlayer], [OrgasmDenyVictim]))
	$OrgasmDenial.hide()
	rebuildparticipantslist()

func OrgasmDenialBeg():
	var text
	if OrgasmDenyVictim.consent < 2 && randf() >= 0.5:
		text = OrgasmDenyText.beg_failure
		OrgasmDenyStage = 1
	else:
		text = OrgasmDenyText.beg_success
		OrgasmDenyStage = 2
		OrgasmDenyVictim.begged_for_orgasm = true
	$OrgasmDenial/RichTextLabel.bbcode_text = decoder(text, [OrgasmDenyPlayer], [OrgasmDenyVictim])
	$OrgasmDenial/ScrollContainer/VBoxContainer/Beg.hide()

func OrgasmDenialDeny():
	OrgasmDenyVictim.sens -= 250
	#OrgasmDenyVictim.person.add_stat('submission' ,10 + OrgasmDenyVictim.person.get_stat('sexuals_factor')) #todo add new effect
	$OrgasmDenial.hide()
	$Panel/sceneeffects.bbcode_text +="\n" + decoder(OrgasmDenyText.deny, [OrgasmDenyPlayer], [OrgasmDenyVictim])
	rebuildparticipantslist()

var cumdict = {
face = {reqs = [], name = "Face", text = "[name1] brings his {^penis:cock:dick} to [name2]'s face and release [his1] {^seed:semen:cum}. The white fluid stains [name2]'s face dripping down to [his2] chin.", specreqs = [], spectext = ''},
mouth = {reqs = [], name = "Mouth", text = "[name1] puts his {^penis:cock:dick} into [name2]'s mouth for the final release. The stream of {^seed:semen:cum} hits [name2]'s throat having [him2] gulp it down.", specreqs = [], spectext = ''},
hair = {reqs = [{code = 'stat', stat = 'hair_length', operant = 'neq', value = 'bald'}], name = "Hair", text = "[name1] puts his {^penis:cock:dick} to [name2]'s head and cums over [his2] hair. The {^seed:semen:cum} soils [name2]'s hair sticking between the strands.", specreqs = [], spectext = ''},
chest = {reqs = [], name = "Chest", text = "[name1] takes his {^penis:cock:dick} into [his1] hand and points at [name2]'s chest, cumming all over it. The hot {^seed:semen:cum} drips down [name2]'s body.", specreqs = [], spectext = ''},
belly = {reqs = [], name = "Belly", text = "[name1] puts his {^penis:cock:dick} into [his1] hand and points at [name2]'s belly. The hot {^seed:semen:cum} drips down [name2]'s navel and stomach.", specreqs = [], spectext = ''},
pubis = {reqs = [], name = "Pubis", text = "[name1] takes out {^penis:cock:dick} and places at [name2]'s pubis. The hot {^seed:semen:cum} covers [name2]'s crotch.", specreqs = [], spectext = ''},
pussy = {reqs = [{code = 'stat', stat = 'has_pussy', operant = 'eq', value = true}], name = "Pussy", text = "[name1] {^sticks:puts} his {^penis:cock:dick} into [name2]'s {^pussy:vagina:cunt}. The hot {^seed:semen:cum} {^splashes into [his2] womb:fills [his2] pussy}.", specreqs = [], spectext = ''},
ass = {reqs = [], name = "Ass", text = "[name1] {^sticks:puts} his {^penis:cock:dick} into [name2]'s {^ass:anus:rear}. The hot {^seed:semen:cum} {^splashes into [his2] intestines:fills [his2] butt}.", specreqs = [], spectext = ''},
back = {reqs = [], name = "Back", text = "[name1] puts his {^penis:cock:dick} into [his1] hand and points at [name2]'s back, cumming all over it. [name2] gasps as [he2] feels the hot fluid over [his2] back.", specreqs = [], spectext = ''},
feet = {reqs = [{code = 'stat', stat = 'body_shape', operant = 'in', value = ['humanoid','shortstack']}], name = "Feet", text = "[name1] unable to hold back anymore starts cumming over [name2]'s feet, covering them in [his1] semen.", specreqs = [], spectext = ''},
tail = {reqs = [{code = 'stat', stat = 'tail', operant = 'neq', value = ''}], name = "Tail", text = "[name1] grabs [name2]'s tail, pushing [his1] {^dick:cock:penis} onto it. With a groan, [name1] starts cumming over [name2]'s tail. ", specreqs = [], spectext = ''},
hands = {reqs = [{code = 'stat', stat = 'arms', operant = 'neq', value = 'wings'}], name = "Hands", text = "[name1] unable to hold back anymore starts cumming over [name2]'s hands, covering them in [his1] semen.", specreqs = [], spectext = ''},
}

func SelectCum(player, victim):
	OrgasmDenyPlayer = player
	OrgasmDenyVictim = victim
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
	$CumSelect.show()
	var text = "As [name1] approaches orgasm [he1] choose to cum onto [name2]'s..."
	$CumSelect/RichTextLabel.bbcode_text = decoder(text, [OrgasmDenyPlayer], [OrgasmDenyVictim])
	
	input_handler.ClearContainer($CumSelect/ScrollContainer/VBoxContainer)
	for part in cumdict.values():
		if victim.person.checkreqs(part.reqs) == false:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($CumSelect/ScrollContainer/VBoxContainer)
		newbutton.text = part.name
		newbutton.connect('pressed',self,'SelectCumTarget',[part])
		
		

func SelectCumTarget(part):
	OrgasmDenyPlayer.orgasm(decoder(part.text, [OrgasmDenyPlayer], [OrgasmDenyVictim]))
	#$Panel/sceneeffects.bbcode_text += "\n" + decoder(part.text, [OrgasmDenyPlayer], [OrgasmDenyVictim])
	$CumSelect.hide()
	rebuildparticipantslist()


func _input(event):
	if !event is InputEventKey || is_visible_in_tree() == false:
		return
	var dict = {49 : 1, 50 : 2, 51 : 3, 52 : 4,53 : 5,54 : 6,55 : 7,56 : 8, 16777351 :1, 16777352 : 2, 16777353 : 3, 16777354 : 4, 16777355 : 5, 16777356: 6, 16777357: 7, 16777358: 8}
	if event.scancode in dict:
		var key = dict[event.scancode]
		if event.is_action_pressed(str(key)) == true && participants.size() >= key:
			if !givers.has(participants[key-1]) && !takers.has(participants[key-1]):
				$Panel/givetakepanel/givercontainer.get_child(key).emit_signal("pressed")
			else:
				$Panel/givetakepanel/receivercontainer.get_child(key).emit_signal("pressed")
	if event.is_action_pressed("F") && $Panel/passbutton.disabled == false && !$Control.is_visible():
		_on_passbutton_pressed()

# var dummycounter = 0

func createtestdummy(type = 'normal'):
	var person = ResourceScripts.scriptdict.class_slave.new("local_recruit")
	
	if participants.size() == 0:
		person.create('random', 'male', 'random')
	else:
		person.create('random', 'female', 'random')
	var newmember = member.new()
	newmember.sceneref = self
	#bad solution. need replacing
	person.statlist.statlist.vaginal_virgin = true
	person.is_players_character = true
	#person.statlist.statlist.mods['hollownipples'] = 'hollownipples'
	#person.statlist.sex_traits = ['pushover']#'dislike_petting','bottle_fairy','hypersensitive','life_power',
	person.statlist.statlist.consent = round(rand_range(2,5))
	for i in person.statlist.statlist.sex_skills:
		person.statlist.statlist.sex_skills[i] += 100
	if type == 'resist':
		person.statlist.consent = false
		#globals.connectrelatives(participants[0].person, person, 'father')

	newmember.setup_person(person, true)
	newmember.consent = round(rand_range(0,3))
	#dummycounter += 1

#	if person.consent == false && person.professions.has("master"):
#		newmember.effects.append('forced')
#	if person.obedience < 80 && person.professions.has("master"):
#		newmember.effects.append('resist')

	participants.append(newmember)


func startsequence(actors):
	set_process_input(true)
	gui_controller.clock.visible = false
	hidebody()
	participants.clear()
	show()
	secondactorcounter.clear()
	$Panel/sceneeffects.clear()
	get_node("Control").hide()
	for person in actors:
		var newmember = member.new()
		newmember.sceneref = self
#		for i in actors:
#			if person != i:
#				if person.sexexp.watchers.has(i.id):
#					person.sexexp.watchers[i.id] += 1
#				else:
#					person.sexexp.watchers[i.id] = 1
		newmember.setup_person(person)
		participants.append(newmember)
		if person.check_trait("Sex-crazed"):
			newmember.effects.append("sexcrazed")
	$Panel/aiallow.pressed = aiobserve
	var temparray = []
	for i in actors:
		if i.has_profession("master") == true:
			temparray.append("{color=yellow|You}")
		else:
			temparray.append("{color=yellow|"+i.get_short_name()+"}")
	var text = input_handler.text_form_recitation(temparray) + " walk into the bedroom."

	var counter = 0
	for i in participants:
		i.number = counter
		counter += 1
	turns = variables.timeforinteraction
	changecategory('caress')
	clearstate()
	rebuildparticipantslist()
	for i in actors:
		if i.has_profession("master"):
			continue
		text += "\n{color=aqua|" + i.get_short_name() + "}: " + i.translate(input_handler.get_random_chat_line(i, 'sex_start'))
	#input_handler.get_person_for_chat(array, 'sex_start', args)

	get_node("Panel/sceneeffects").set_bbcode(globals.TextEncoder(text))


func clearstate():
	givers.clear()
	takers.clear()
	if givers.size() >= 1:
		givers.append(participants[0])

func changecategory(name):
	selectedcategory = name
	for i in get_node("Panel/HBoxContainer").get_children():
		if i.get_name() != name: i.set_pressed(false)
		else: i.set_pressed(true)
	rebuildparticipantslist()

func rebuildparticipantslist():
	var newnode
	var effects
	if selectmode == 'ai':
		clearstate()
	for i in get_node("Panel/CharList/ScrollContainer/VBoxContainer").get_children() + get_node("Panel/GridContainer/GridContainer").get_children() + get_node("Panel/givetakepanel/givercontainer").get_children() + get_node("Panel/givetakepanel/receivercontainer").get_children() + $Panel/GridContainer2/GridContainer.get_children():
		if !i.get_name() in ['Panel', 'Button']:
			i.visible = false
			i.queue_free()
	for i in participants:
		newnode = get_node("Panel/CharList/ScrollContainer/VBoxContainer/Panel").duplicate()
		newnode.visible = true
		get_node("Panel/CharList/ScrollContainer/VBoxContainer").add_child(newnode)
		newnode.get_node("name").set_text(i.person.get_short_name())
#		newnode.get_node("name").connect("pressed",self,"slavedescription",[i])
		newnode.set_meta("person", i)
		newnode.get_node('portrait').texture = i.person.get_icon_small()
		newnode.get_node("sex").set_texture(images.icons[i.sex])
		newnode.get_node("sex").set_tooltip(i.sex)
		newnode.get_node('HBoxContainer/arousal').value = i.sens
		newnode.get_node("Stamina").value = i.stamina
		globals.connecttexttooltip(newnode.get_node('Stamina'), tr("TOOLTIPSTAMINA"))
		#newnode.get_node("portrait").texture = i.person.get_icon_small()
		# newnode.get_node("container/portrait").connect("mouse_entered",self,'showbody',[i])
		# newnode.get_node("container/portrait").connect("mouse_exited",self,'hidebody')
		newnode.connect("mouse_entered", self, 'showbody', [i])
		newnode.get_node("items").connect("pressed", self, "open_item_list", [i])

		if i.request != null:
			newnode.get_node('HBoxContainer/desire').show()
			newnode.get_node('HBoxContainer/desire').hint_tooltip = i.person.translate(requests[i.request])

		if i.horny >= 100:
			newnode.get_node("HBoxContainer/horny").show()

		for k in i.effects:
			if newnode.has_node('' + k) == true:
				newnode.get_node('' + k).visible = true

		if ai.has(i):
			newnode.get_node('name').set('custom_colors/font_color', Color(1,0.2,0.8))
			newnode.get_node('name').hint_tooltip = 'Leads'

		newnode = get_node("Panel/givetakepanel/givercontainer/Button").duplicate()
		get_node("Panel/givetakepanel/givercontainer").add_child(newnode)
		if givers.find(i) >= 0:
			newnode.set_pressed(true)
		newnode.visible = true
		newnode.get_node('icon').texture = i.person.get_icon_small()
		newnode.get_node("Label").text = i.person.get_short_name()
		newnode.set_meta("person", i)
		newnode.connect("pressed",self,'switchsides',[newnode, 'give'])
		newnode = get_node("Panel/givetakepanel/receivercontainer/Button").duplicate()
		get_node("Panel/givetakepanel/receivercontainer").add_child(newnode)
		if takers.find(i) >= 0:
			newnode.set_pressed(true)
		newnode.visible = true
		newnode.get_node("Label").text = i.person.translate('[name]')
		newnode.set_meta("person", i)
		newnode.get_node('icon').texture = i.person.get_icon_small()
		newnode.connect("pressed",self,'switchsides',[newnode, 'take'])

	var text = ''

	#check for double dildo scenes between participants
	var doubledildo = doubledildocheck()
	var actionarray = []

	for i in categories:
		for k in categories[i]:
			actionarray.append(k)

	actionarray.sort_custom(self, 'sortactions')

	var showactions = true
	var actionreplacetext = ''

	for i in givers:
		if i.effects.has('tied') :
			showactions = false
			actionreplacetext = i.person.translate("[name] is tied and can't act.")
		elif i.subduedby.size() > 0:
			showactions = false
			actionreplacetext = i.person.translate("[name] is struggling and can't act.")
		elif i.effects.has('resist'):
			showactions = false
			actionreplacetext = i.person.translate("[name] resists and won't follow any orders.")
		elif i.subduing != null && ((takers.size() > 0 && takers[0] != i.subduing) || takers.size() > 1 ) :
			showactions = false
			actionreplacetext = i.person.translate("[name] is busy holding down ") + i.subduing.person.translate("[name] \nand can only act on [him]. ")

	var array = []
	var bottomrow =  ['rope', 'subdue', 'deny_orgasm', 'cum_select']

	if showactions == true:
		for i in actionarray:
			i.givers = givers
			i.takers = takers

			var result = checkaction(i, doubledildo)
			if result[0] == 'false' || i.code in ['wait'] || (selectedcategory != i.category && !i.code in bottomrow ):
				continue

			#find lowest consent possible for each participant
			var giver_consent
			var giver_name
			var giver_text
			var taker_consent
			var taker_name
			var taker_text
			for j in givers:
				for k in takers:
					var consent = count_action_consent(i, j, k)
					if giver_consent == null:
						giver_consent = consent.giver_consent
						giver_name = j.name
						giver_text = consent.giver_text
					if giver_consent > consent.giver_consent:
						giver_name = j.name
						giver_consent = consent.giver_consent
						giver_text = consent.giver_text

					if taker_consent == null:
						taker_consent = consent.taker_consent
						taker_name = k.name
						taker_text = consent.taker_text
					if taker_consent > consent.taker_consent:
						taker_consent = consent.taker_consent
						taker_name = k.name
						taker_text = consent.taker_text

			# if i.code in bottomrow :
			# 	newnode = get_node("Panel/GridContainer2/GridContainer/Button").duplicate()
			# 	get_node("Panel/GridContainer2/GridContainer").add_child(newnode)
			# else:
			newnode = get_node("Panel/GridContainer/GridContainer/Button").duplicate()
			get_node("Panel/GridContainer/GridContainer").add_child(newnode)
			newnode.visible = true
			newnode.get_node("ActionName").set_text(i.getname())
			if i.consent_giver > giver_consent || i.consent_taker > taker_consent:
				
				
				newnode.modulate = Color(1,0.7,0.7)

			var tooltiptext
			if input_handler.globalsettings.show_full_consent || true:
				
				tooltiptext = i.getname() + "\n"+giver_name + ": "
				
				if i.consent_giver <= giver_consent:
					tooltiptext += "{color=aqua|Willing}"
				else:
					tooltiptext += "{color=yellow|Refusing}" 
				
				tooltiptext +=  "\n" + giver_text + "\n" + taker_name + ": "
				
				if i.consent_taker <= taker_consent:
					tooltiptext += "{color=aqua|Willing}"
				else:
					tooltiptext += "{color=yellow|Refusing}" 
				
				tooltiptext +=  "\n" + taker_text
				
				#tooltiptext = giver_name + "\n" + giver_text + taker_name + "\n" + taker_text
				
#				tooltiptext = ("[color=aqua]Giver - " + str(i.consent_giver) + 
#				", Receiver - " + str(i.consent_taker) + 
#				"[/color]\nActor Consent: [color=aqua]"+ str(giver_consent) +"[/color] (" + giver_name + ") "  +"\n" + giver_text + 
#				"\nReceiver Consent: [color=aqua]" + str(taker_consent) + "[/color] ("+ taker_name + ') '  + "\n" + taker_text)
			else:
				tooltiptext = i.getname()
				if giver_consent < i.consent_giver:
					tooltiptext += "\n{color=red|" + giver_name + " does not wish to engage into this action}"
				if taker_consent < i.consent_taker:
					tooltiptext += "\n{color=red|" + taker_name + " does not wish to engage into this action}"
			globals.connecttexttooltip(newnode, tooltiptext)
			if result[0] == 'disabled':
				newnode.disabled = true
				newnode.hint_tooltip += ' - ' + result[1]

			newnode.connect("pressed",self,'startscene',[i])
			if i.canlast == true && newnode.disabled == false:
				newnode.get_node("continue").visible = true
				newnode.get_node("continue").connect("pressed",self,'startscenecontinue',[i])
			for j in ongoingactions:
				if j.scene.code == i.code && j.givers == i.givers && j.takers == i.takers:
					newnode.get_node("continue").pressed = true
		if selectedcategory == 'caress' && givers.size() >= 1 && !givers[0].person.has_profession("master") && selectmode != 'ai':
			# newnode = get_node("Panel/GridContainer2/GridContainer/Button").duplicate()
			newnode = get_node("Panel/GridContainer/GridContainer/Button").duplicate()
			# get_node("Panel/GridContainer2/GridContainer").add_child(newnode)
			get_node("Panel/GridContainer/GridContainer").add_child(newnode)
			newnode.visible = true
			if givers.size() < 2:
				newnode.get_node("ActionName").text = (givers[0].person.translate("Let [name] Lead"))
			else:
				newnode.get_node("ActionName").set_text("Let Selected Lead")
			newnode.connect("pressed",self,'activateai')
		elif selectmode == 'ai':
			newnode = get_node("Panel/GridContainer/GridContainer/Button").duplicate()
			get_node("Panel/GridContainer/GridContainer").add_child(newnode)
			newnode.visible = true
			newnode.set_text("Stop")
			newnode.connect("pressed",self,'activateai')
	else:
			newnode = Label.new()
			get_node("Panel/GridContainer/GridContainer").add_child(newnode)
			newnode.visible = true
			#newnode.disabled = true
			newnode.set_text(actionreplacetext)
	$Panel/GridContainer/GridContainer.move_child($Panel/GridContainer/GridContainer/Button, $Panel/GridContainer/GridContainer.get_child_count()-1)
	$Panel/GridContainer2/GridContainer.move_child($Panel/GridContainer2/GridContainer/Button, $Panel/GridContainer2/GridContainer.get_child_count()-1)
	for i in givers:
		text += '[color=yellow]' + i.name + '[/color], '
	if givers.size() == 0:
		text += '[...] '
	text += 'will do it ... to '
	for i in takers:
		text += '[color=aqua]' + i.name + '[/color], '
	if takers.size() == 0:
		text += "[...]"
	else:
		text = text.substr(0, text.length() -2)+ '. '
	text += "\n\n"
	for i in ongoingactions:
		text += decoder(i.scene.getongoingname(i.givers,i.takers), i.givers, i.takers) + ' [url='+str(ongoingactions.find(i))+'][Interrupt][/url]\n'

	if givers.size() == 0 && selectmode != 'ai':
		get_node("Panel/passbutton").set_disabled(true)
	else:
		get_node("Panel/passbutton").set_disabled(false)

	if selectmode == 'ai':
		$Panel/passbutton.set_text("Observe")
	else:
		$Panel/passbutton.set_text("Pass")

	get_node("TextureFrame/Label").set_text(str(turns))

	get_node("Panel/sceneeffects1").set_bbcode(text)

	#globals.state.actionblacklist = filter

	if turns <= 0:
		endencounter()

var itemusemember

func count_action_consent(action, giver, taker):
	var giver_value = action.consent_giver
	var taker_value = action.consent_taker
	var giver_consent = giver.consent
	var taker_consent = taker.consent
	var giver_text = ''
	var taker_text = ''

	for i in giver.sex_traits:
		var trait = Traitdata.sex_traits[i]
		if !giver.checkreqs(trait.reqs, 'giver', {scene = action, givers = action.givers, takers = action.takers}):
			continue
		for k in trait.effects:
			match k.trigger:
				'consent_check':
					if k.effect == 'consent':
						if k.operant == '*':
							giver_consent -= giver_value * k.value
							giver_text += "{color=red|" + trait.name + "}"+"\n"
							
							#giver_text += trait.name + ": -"+ str(value)+"\n"
						elif k.operant == "+":
							giver_consent += k.value
							giver_text += "{color=green|" + trait.name + "}"+"\n"
							#giver_text += trait.name + ": +"+ str(k.value)+"\n"
				'consent_check_partner':
					if k.effect == 'consent':
						if k.operant == '*':
							taker_consent -= taker_value * k.value
							giver_text += "{color=red|" + trait.name + "}"+"\n"
						#	taker_text += trait.name + ": -"+ str(value)+"\n"
						elif k.operant == '+':
							taker_consent += k.value
							giver_text += "{color=green|" + trait.name + "}"+"\n"
							#taker_text += trait.name + ": +"+ str(k.value)+"\n"

	for i in taker.sex_traits:
		var trait = Traitdata.sex_traits[i]
		if !taker.checkreqs(trait.reqs, 'taker', {scene = action, givers = action.givers, takers = action.takers}):
			continue
		for k in trait.effects:
			match k.trigger:
				'consent_check':
					if k.effect == 'consent':
						if k.operant == '*':
							taker_consent -= taker_value * k.value
							taker_text += "{color=red|" + trait.name + "}"+"\n"
							#taker_text += trait.name + ": -"+ str(value)+"\n"
						elif k.operant == "+":
							taker_consent += k.value
							taker_text += "{color=green|" + trait.name + "}"+"\n"
							#taker_text += trait.name + ": +"+ str(k.value)+"\n"
				'consent_check_partner':
					if k.effect == 'consent':
						if k.operant == '*':
							giver_consent -= giver_value * k.value
							giver_text += "{color=red|" + trait.name + "}"+"\n"
							#giver_text += trait.name + ": -"+ str(value)+"\n"
						elif k.operant == '+':
							giver_consent += k.value
							giver_text += "{color=green|" + trait.name + "}"+"\n"
							#giver_text += trait.name + ": +"+ str(k.value)+"\n"

	if participants.size() > 2 && action.givers.size() + action.takers.size() < participants.size() && !action.code in ['subdue','rope','orgasm_denial']:
		if giver.sex_traits.has("shameless"):
			pass
		elif giver.sex_traits.has("exhibitionist"):
			giver_consent += 1
			giver_text += "{color=green|Is being observed (Exhibitionist)}\n"
		else:
			giver_consent -= 1
			giver_text += "{color=red|Is being observed}\n"

		if taker.sex_traits.has("shameless"):
			pass
		elif taker.sex_traits.has("exhibitionist"):
			taker_consent += 1
			taker_text += "{color=green|Is being observed (Exhibitionist)}\n"
		else:
			taker_consent -= 1
			taker_text += "{color=red|Is being observed}\n"
			#taker_text += "Is being observed: -\n"

	if (action.givers.size() > 1 || action.takers.size() > 1) && !action.code in ['subdue','rope','orgasm_denial']:
		if giver.sex_traits.has("group"):
			giver_consent += 1
			giver_text += "{color=green|Multiple partners (Likes Groups)}\n"
		else:
			giver_consent -= 1
			giver_text += "{color=red|Multiple partners}\n"

		if taker.sex_traits.has("group"):
			taker_consent += 1
			taker_text += "{color=green|Multiple partners  (Likes Groups)}\n"
		else:
			taker_consent -= 1
			taker_text += "{color=red|Multiple partners}\n"

	if giver.sex == taker.sex && !action.code in ['subdue','rope','orgasm_denial'] :
		if giver.sex_traits.has("bisexual") == false:
			giver_consent -= 1
			giver_text += "{color=red|Same sex partner}\n"
		if taker.sex_traits.has("bisexual") == false:
			taker_consent -= 1
			taker_text += "{color=red|Same sex partner}\n"

	if action.givertags.has("anal"):
		if giver.sex_traits.has("anal"):
			pass
		elif giver.sex_traits.has('anal_like'):
			giver_consent += 1
			giver_text += "{color=green|Anal (Likes Anal)}\n"
		else:
			giver_consent -= 1
			giver_text += "{color=red|Anal}\n"

	if action.takertags.has("anal"):
		if taker.sex_traits.has("anal"):
			pass
		elif taker.sex_traits.has('anal_like'):
			taker_consent += 1
			taker_text += "{color=green|Anal (Likes Anal)}\n"
		else:
			taker_consent -= 1
			taker_text += "{color=red|Anal}\n"

	if giver.person.check_trait('undead') || giver.person.get_stat('unique') in ['dog','horse'] :
		if !taker.sex_traits.has('deviant'):
			taker_consent -= 2
			taker_text += "{color=red|Repulsive partner}\n"
	if taker.person.check_trait('undead') || taker.person.get_stat('unique') in ['dog','horse'] :
		if !giver.sex_traits.has('deviant'):
			giver_consent -= 2
			giver_text += "{color=red|Repulsive partner}\n"

	if giver.effects.has('tipsy'):
		giver_consent += 1
		giver_text += "{color=green|Tipsy}\n"
	if giver.effects.has('drunk') :
		giver_consent += 2
		giver_text += "{color=green|Drunk}\n"
	if taker.effects.has('tipsy'):
		taker_consent += 1
		taker_text += "{color=green|Tipsy}\n"
	if taker.effects.has('drunk'):
		taker_consent += 2
		taker_text += "{color=green|Drunk}\n"


#	if giver.horny >= 100:
#		giver_consent += 1
#		giver_text += "{color=green|Horny}\n"
#	if taker.horny >= 100:
#		taker_consent += 1
#		taker_text += "{color=green|Horny}\n"

	if giver.person_relations.has(taker.id):
		var rel_value = giver.person_relations[taker.id]
		if rel_value >= 350:
			giver_consent += 1
			giver_text += "{color=green|Likes partner}\n"
		elif rel_value >= 800:
			giver_consent += 2
			giver_text += "{color=green|Loves partner}\n"
		elif rel_value <= -800:
			giver_consent -= 2
			giver_text += "{color=red|Dislikes partner}\n"
		elif rel_value <= -350:
			giver_consent -= 1
			giver_text += "{color=red|Hates partner}\n"

	if taker.person_relations.has(giver.id):
		var rel_value = taker.person_relations[giver.id]
		if rel_value >= 350:
			taker_consent += 1
			taker_text += "{color=green|Likes partner}\n"
		elif rel_value >= 800:
			taker_consent += 2
			taker_text += "{color=green|Loves partner}\n"
		elif rel_value <= -800:
			taker_consent -= 2
			taker_text += "{color=red|Dislikes partner}\n"
		elif rel_value <= -350:
			taker_consent -= 1
			taker_text += "{color=red|Hates partner}\n"

	if giver.person.get_stat('body_shape') != taker.person.get_stat('body_shape') && !action.code in ['subdue','rope','orgasm_denial']:
		if !giver.sex_traits.has("open_minded"):
			giver_consent -= 1
			giver_text += '{color=red|Partner is of different species}\n'
		if !taker.sex_traits.has("open_minded"):
			taker_consent -= 1
			taker_text += "{color=red|Partner is of different species}\n"

	if action.givertags.has('vagina') && action.givertags.has('penetration') && giver.person.get_stat('vaginal_virgin'):
		giver_consent -= 1
		giver_text += "{color=red|Is virgin}\n"
	if action.takertags.has('vagina') && action.takertags.has('penetration') && taker.person.get_stat('vaginal_virgin'):
		taker_consent -= 1
		taker_text += "{color=red|Is virgin}\n"


	if giver.person.has_profession('master'):
		giver_consent = 100
		giver_text = "Maximum"
#		taker_consent += 1
#		taker_text += "Partner is " + taker.person.translate("[master]") + ": +\n"
	if taker.person.has_profession('master'):
		taker_consent = 100
		taker_text = "Maximum"
#		giver_consent += 1
#		giver_text += "Partner is " + giver.person.translate("[master]") + ": +\n"
#	if giver.person.get_stat('slave_class') == 'slave':
#		giver_consent += 1
#		giver_text += "Is a Slave: +1\n"
#	if taker.person.get_stat('slave_class') == 'slave':
#		taker_consent += 1
#		taker_text += "Is a Slave: +1\n"
	if action.code == 'subdue':
		taker_consent = 25
		taker_text = "Subdue: Receiver's consent ignored. "

	
	if giver_value == 0:
		giver_consent = 0
		giver_text = "{color=green|Action does not require consent}"
	if taker_value == 0:
		taker_consent = 0
		taker_text = "{color=green|Action does not require consent}"
	

	return {giver_consent = giver_consent, taker_consent = taker_consent, giver_text = giver_text, taker_text = taker_text}
#	var dict = {value = action.consent, giver_consent = giver.consent, taker_consent = taker.consent}
#	return dict

func open_item_list(member):
	itemusemember = member
	if !gui_controller.windows_opened.has($ItemSelectSex):
		gui_controller.windows_opened.append($ItemSelectSex)
	$ItemSelectSex.visible = !$ItemSelectSex.is_visible()
	var array = []
	for i in ResourceScripts.game_res.items.values():
		if i.interaction_use == true:
			array.append(i)
	input_handler.ClearContainer($ItemSelectSex/ScrollContainer/GridContainer)
	for item in array:
		var newbutton = input_handler.DuplicateContainerTemplate($ItemSelectSex/ScrollContainer/GridContainer)
		newbutton.get_node("icon").texture = load(item.icon)
		newbutton.get_node("name").text = item.code.capitalize()
		newbutton.get_node("Percent").text = str(ResourceScripts.game_res.items[item.id].amount)
		newbutton.connect("pressed", self, "use_item", [item])
	# globals.ItemSelect(self, 'sex_use', 'use_item')

func use_item(item):
	var effect = Items.itemlist[item.itembase].interaction_effect
	item.amount -= 1
	call(effect, itemusemember)
	open_item_list(itemusemember)
	rebuildparticipantslist()


var categoriesorder = ['caress', 'fucking', 'tools', 'SM', 'humiliation']

func sortactions(first, second):

	if categoriesorder.find(first.category) == categoriesorder.find(second.category):
		if first.get('order') != null:
			if second.get('order') != null:
#				if first.order >= second.order:
				if first.order > second.order:
					return false
				else:
					return true
			else:
				return true

		return false
	else:
		return categoriesorder.find(first.category) < categoriesorder.find(second.category)

var requests = {
pet = "[name] wishes to be touched.",
petgive = '[name] wishes to touch.',
fuck = '[name] wishes to be penetrated.',
fuckgive = '[name] wishes to penetrate.',
pussy = "[name] wishes to have [his] pussy used.",
penis = '[name] wishes to use [his] penis.',
anal = '[name] wishes to have [his] ass used.',
punish = '[name] wishes to be punished.',
humiliate = '[name] wishes to be humiliated.',
group = '[name] wishes to have multiple partners.'

}



func generaterequest(member):
	var rval = []

	for i in requests:
		rval.append(i)

	if member.person.get_stat('vaginal_virgin') == true:
		rval.erase('fuck')
	if member.person.get_stat('penis_size') == '':
		rval.erase('penis')
	if member.person.get_stat('penis_size') == '' && member.strapon == false:
		rval.erase('fuckgive')
	if member.person.get_stat('vagina') == '':
		rval.erase('pussy')
	if member.person.check_trait('Dominant'):
		rval.erase('humiliate')
	if !member.person.check_trait('Likes it rough') && !member.person.check_trait('Masochist'):
		rval.erase('punish')
	if member.person.check_trait('Monogamous') || participants.size() == 2 || (!member.person.check_trait('Fickle') && member.lewd < 50):
		rval.erase('group')



	rval = rval[randi()%rval.size()]

	$Panel/sceneeffects.bbcode_text += ("[color=#f4adf4]Desire: " + member.person.translate(requests[rval]) + '[/color]\n')

	member.request = rval

func checkrequest(member):

	if member.request == null:
		return false

	var conditionsatisfied = false

	var lastaction = member.lastaction

	match member.request:
		'pet':
			if lastaction.takers.has(member) && lastaction.scene.get('takertags') != null && lastaction.scene.takertags.has('pet'):
				conditionsatisfied = true
		'petgive':
			if lastaction.givers.has(member) && lastaction.scene.get('givertags') != null && lastaction.scene.givertags.has('pet'):
				conditionsatisfied = true
		'fuck':
			if lastaction.takers.has(member) && lastaction.scene.get('takertags') != null && lastaction.scene.takertags.has('penetration'):
				conditionsatisfied = true
		'fuckgive':
			if lastaction.givers.has(member) && lastaction.scene.get('takertags') != null && lastaction.scene.takertags.has('penetration'):
				conditionsatisfied = true
		'pussy':
			if lastaction.scene.get('givertags') != null && (lastaction.scene.givertags.has('vagina') || lastaction.scene.takertags.has('vagina')) :
				conditionsatisfied = true
		'penis':
			if lastaction.scene.get('givertags') != null && (lastaction.scene.givertags.has('penis') || lastaction.scene.takertags.has('penis')) :
				conditionsatisfied = true
		'anal':
			if lastaction.scene.get('givertags') != null && (lastaction.scene.givertags.has('anal') || lastaction.scene.takertags.has('anal')) :
				conditionsatisfied = true
		'punish':
			if lastaction.takers.has(member) && lastaction.scene.get('takertags') != null && lastaction.scene.takertags.has('punish'):
				conditionsatisfied = true
		'humiliate':
			if lastaction.takers.has(member) && lastaction.scene.get('takertags') != null && lastaction.scene.takertags.has('shame'):
				conditionsatisfied = true
		'group':
			if (lastaction.givers.has(member) && lastaction.takers.size() > 1) || (lastaction.takers.has(member) && lastaction.givers.size() > 1):
				conditionsatisfied = true

	if conditionsatisfied == true:
		member.request = null
		member.requestsdone += 1
		#$Panel/sceneeffects.bbcode_text += '[color=green]Wish satisfied.[/color]\n'
		member.sens += 350
	return conditionsatisfied

var ai = []

func activateai():
	for i in givers:
#		if i.submission < 10 || i.consent == false:
#			$Control/Panel/RichTextLabel.bbcode_text = i.person.translate('[name] refuses to participate. ')
#			return
		if i.effects.has('tied') || i.subduedby.size() > 0:
			$Control/Panel/RichTextLabel.bbcode_text = i.person.translate("[name] is immobile and can't do anything. ")
	ai.clear()
	if selectmode != 'ai':
		selectmode = 'ai'
		for i in givers:
			if !i.person.has_profession('master'):
				ai.append(i)
	else:
		selectmode = 'normal'
	rebuildparticipantslist()


func doubledildocheck():
	var doubledildo = false
	var givercheck = false
	var takercheck = false

	for scene in ongoingactions:
		if scene.scene.code in ['doubledildo','doubledildoass','tribadism','frottage']:
			for i in givers:
				if scene.givers.has(i) || scene.takers.has(i):
					givercheck = true
			for i in takers:
				if scene.givers.has(i) || scene.takers.has(i):
					takercheck = true
		if givercheck && takercheck:
			doubledildo = true
			break
		else:
			givercheck = false
			takercheck = false
	return doubledildo

func checkaction(action, doubledildo):
	action.givers = givers
	action.takers = takers
	var disabled = false
	var hint_tooltip = ''
	if action.requirements() == false || filter.has(action.code):
		return ['false']
	elif doubledildo == true && action.category in ['caress','fucking'] && !action.code in ['doubledildo','doubledildoass','tribadism','frottage']:
		return ['false']
	if action.category in ['SM','tools','humiliation']:
		var valid = true
		for k in givers+takers:
			if k.limbs == false:
				valid = false
				break
		if valid == false:
			return ['false']
	if disabled == true:
		return ['disabled',hint_tooltip]
	else:
		return ['allowed']


func slavedescription(member):
	return
	if !member.person.get_stat('unique') in ['dog','horse']:
		get_parent().popup(ResourceScripts.descriptions.trim_tag(member.person.make_description(), 'url', 'hair'))

var nakedspritesdict = [] #globals.gallery.nakedsprites

func showbody(i):
	var stored_image = i.person.get_stored_body_image()
	if stored_image != null:
		$Panel/bodyimage.texture = stored_image
		$Panel/bodyimage.visible = true
		$Panel/ragdoll.visible = false
	elif !input_handler.globalsettings.disable_paperdoll:
		$Panel/bodyimage.visible = false
		$Panel/ragdoll.visible = true
		$Panel/ragdoll.test_mode = false
		$Panel/ragdoll.rebuild(i.person)
		$Panel/ragdoll.rebuild_cloth(false)
#		$Panel/ragdoll.rebuild_underwear()
	else:
		$Panel/bodyimage.texture = i.person.get_body_image()
		$Panel/bodyimage.visible = true
		$Panel/ragdoll.visible = false
#	if i.person.get_body_image() != null:
#		$Panel/bodyimage.visible = true
#		$Panel/bodyimage.texture = i.person.get_body_image()

func hidebody():
	$Panel/bodyimage.visible = false
	$Panel/ragdoll.visible = false


func switchsides(panel, side):
	var person = panel.get_meta('person') #member, not charclass!
	givers.erase(person)
	takers.erase(person)
	if person.role == side:
		person.role = 'none'
	else:
		person.role = side
	if person.role == 'give':
		givers.append(person)
	elif person.role == 'take':
		takers.append(person)
	rebuildparticipantslist()

func startscene(scenescript, cont = false, pretext = ''):
	var textdict = {mainevent = pretext, repeats = '', orgasms = '', speech = ''}
	var effects

	var mandatoryspeech = false
	var mandatoryspeechdict
	scenescript.givers = givers
	scenescript.takers = takers
	turns -= 1
	
	var dict = {scene = scenescript, takers = [] + takers, givers = [] + givers, consents = {}}
	var resists = []
	
	
	for i in givers:
		dict.consents[i.id] = 0
		var lowest_consent = 10
		for j in takers:
			var consent = count_action_consent(scenescript, i, j)
			if scenescript.consent_giver > consent.giver_consent && resists.find(i.id) < 0:
				resists.append(i.id)
			if consent.giver_consent < lowest_consent:
				lowest_consent = consent.giver_consent
		if lowest_consent < scenescript.consent_giver:
			var resist = scenescript.consent_giver - lowest_consent
			dict.consents[i.id] = resist
			if resist == 1:
				i.low_actions_resisted += 1
			if i.actions_resisted.has(scenescript.code): 
				resist = resist/3
				i.actions_resisted[scenescript.code] += 1
			else:
				i.actions_resisted[scenescript.code] = 1
			var staminacost = resist*15
			if i.sex_traits.has("pushover"):
				resist = resist/2
			i.stamina -= resist*15
			if i.stamina <= 0:
				pass#set penalty
		

	for j in takers:
		dict.consents[j.id] = 0
		var lowest_consent = 10
		for i in givers:
			var consent = count_action_consent(scenescript, i, j)
			if scenescript.consent_taker > consent.taker_consent && resists.find(j.id) < 0:
				resists.append(j.id)
			if consent.taker_consent < lowest_consent:
				lowest_consent = consent.taker_consent
		#dict.consents[j.id] = lowest_consent
		if lowest_consent < scenescript.consent_taker:
			var resist = scenescript.consent_taker - lowest_consent
			dict.consents[j.id] = resist
			if resist == 1:
				j.low_actions_resisted += 1
			if j.actions_resisted.has(scenescript.code): 
				resist = resist/3
				j.actions_resisted[scenescript.code] += 1
			else:
				j.actions_resisted[scenescript.code] = 1
			var staminacost = resist*15
			if j.sex_traits.has("pushover"):
				resist = resist/2
			j.stamina -= resist*15
			if j.stamina <= 0:
				pass#set penalty
	
	
	
#	for i in givers + takers:
#		if dict.consents[i.id] < scenescript.consent_level:
#			var result = resistattempt(i)
#			textdict.mainevent += result.text
#			if result.consent == false:
#				get_node("Panel/sceneeffects").bbcode_text += (textdict.mainevent + "\n" + textdict.repeats)
#				rebuildparticipantslist()
#
#				return

	for i in givers + takers:
		if isencountersamesex(givers,takers,i) == true:
			i.actionshad.samesex += 1
		else:
			i.actionshad.oppositesex += 1
		if i.person_sexexp.actions.has(scenescript.code):
			i.person_sexexp.actions[scenescript.code] += 1
		else:
			i.person_sexexp.actions[scenescript.code] = 1
			i.new_action_performed = true
		for k in givers + takers:
			if k != i:
				if i.person_sexexp.partners.has(k.id):
					i.person_sexexp.partners[k.id] += 1
				else:
					i.person_sexexp.partners[k.id] = 1
					i.person.add_partner(k.id)
					if resists.find(i.id) < 0:
						k.new_consented_partners += 1


	for i in participants:
		i.orgasm = false
		if !givers.has(i) && !takers.has(i):
			if i.person_sexexp.seenactions.has(scenescript.code):
				i.person_sexexp.seenactions[scenescript.code] += 1
			else:
				i.person_sexexp.seenactions[scenescript.code] = 1

	#temporary support for scenes converted to centralized output and those not
	#should be unified in the future
	var centralized = false
	if scenescript.has_method('initiate'):
		textdict.mainevent += decoder(scenescript.initiate(), givers, takers)
	else:
		centralized = true
		textdict.mainevent += output(scenescript, scenescript.initiate, givers, takers) + output(scenescript, scenescript.ongoing, givers, takers)

	if centralized == false:
		if scenescript.has_method('reaction'):
			for i in takers:
				textdict.mainevent += '\n' + decoder(scenescript.reaction(i), givers, [i])
	elif scenescript.reaction != null:
			for i in takers:
				textdict.mainevent += '\n' + output(scenescript, scenescript.reaction, givers, [i])
	
	
	#this part likely will need full optional description of resist for each action
	for i in givers:
		if (resists.has(i.id) || i.sex_traits.has("pushover")) && randf() >= variables.resist_text_chancce:
			textdict.mainevent += "\n" + decoder(resist_text('giver',i.stamina, i), [i], takers)
			#textdict.mainevent += '\n' + decoder(scenescript.giver_resist(), i, [takers])

	for i in takers:
		if (resists.has(i.id) || i.sex_traits.has("pushover")) && randf() >= variables.resist_text_chancce:
			textdict.mainevent += "\n" + decoder(resist_text('taker',i.stamina, i), givers, [i])
			#textdict.mainevent += '\n' + decoder(scenescript.taker_resist(), givers, [i])
	
	
	
	var virgin = {type = null, character = null}

	#remove virginity if relevant
	if scenescript.virginloss == true:
		for i in givers:
			if scenescript.giverpart == 'vagina' && i.person.get_stat('vaginal_virgin') == true:
				i.person.take_virginity("vaginal",takers[0].person.id)
				virgin.type = 'vaginal'
				virgin.character = i
#				if takers.size() == 1 && takers[0].person.has_profession('master'):
#					i.person.add_stat('loyalty', 20)
			elif scenescript.giverpart == 'anus' && i.person.get_stat('anal_virgin') == true:
				i.person.take_virginity("anal",takers[0].person.id)
				virgin.type = 'anal'
				virgin.character = i
#				if takers.size() == 1 && takers[0].person.has_profession('master'):
#					i.person.add_stat('loyalty', 10)
		for i in takers:
			if scenescript.takerpart == 'vagina' && i.person.get_stat('vaginal_virgin') == true:
				i.person.take_virginity("vaginal",givers[0].person.id)
				virgin.type = 'vaginal'
				virgin.character = i
#				if givers.size() == 1 && givers[0].person.has_profession('master'):
#					i.person.add_stat('loyalty', 20)
			elif scenescript.takerpart == 'anus' && i.person.get_stat('anal_virgin') == true:
				i.person.take_virginity("anal",givers[0].person.id)
				virgin.type = 'anal'
				virgin.character = i
#				if givers.size() == 1 && givers[0].person.has_profession('master'):
#					i.person.add_stat('loyalty', 10)
		if scenescript.giverpart == 'penis':
			for i in givers:
				i.person.set_stat('penis_virgin', false)
		elif scenescript.takerpart == 'penis':
			for i in takers:
				i.person.set_stat('penis_virgin', false)

	for i in givers:
		if scenescript.giverpart != '':
			if i[scenescript.giverpart] != null:
				stopongoingaction(i[scenescript.giverpart])
			i[scenescript.giverpart] = dict

	for i in takers:
		if scenescript.takerpart != '':
			if i[scenescript.takerpart] != null:
				stopongoingaction(i[scenescript.takerpart])
			i[scenescript.takerpart] = dict

	if scenescript.get('takerpart2'):
		givers[1][scenescript.giverpart] = dict
		for i in takers:
			if i[scenescript.takerpart2] != null:
				stopongoingaction(i[scenescript.takerpart2])
			i[scenescript.takerpart2] = dict

	for i in givers:
		if scenescript.has_method('givereffect'):
			effects = scenescript.givereffect(i)
			i.actioneffect(effects, dict)

	for i in takers:
		if scenescript.has_method('takereffect'):
			effects = scenescript.takereffect(i)
			i.actioneffect(effects, dict)

	if scenescript.code in ['rope', 'subdue']:
		cont = true
		if scenescript.code == 'rope':
			mandatoryspeech = true
			mandatoryspeechdict = {character = takers[0], line = 'rope'}

	#to make action switch on that hole even if they comes from another body part
	if scenescript.code in ['doubledildo','doubledildoass','tribadism']:
		for i in ongoingactions.duplicate():
			if i.scene.category == 'fucking' && (i.givers.has(givers[0]) || i.takers.has(givers[0]) || i.givers.has(takers[0]) || i.takers.has(takers[0])):
				if i.givers == givers && i.takers == takers:
					stopongoingaction(i)
	if scenescript.code in ['cunnilingus','rimjob','facesit','afacesit','massagefoot','lickfeet']:
		for i in ongoingactions.duplicate():
			if i.scene.category == 'fucking' && (i.givers.has(givers[0]) || i.takers.has(givers[0]) || i.givers.has(takers[0]) || i.takers.has(takers[0])):
				if i.givers == givers && i.takers == takers:
					stopongoingaction(i)
	if scenescript.category == 'fucking':
		for i in ongoingactions.duplicate():
			if i.scene.code in ['cunnilingus','rimjob','facesit','afacesit','massagefoot','lickfeet'] && (i.givers.has(givers[0]) || i.takers.has(givers[0]) || i.givers.has(takers[0]) || i.takers.has(takers[0])):
				if i.givers == givers && i.takers == takers:
					stopongoingaction(i)
	if scenescript.code == 'grovel':
		for i in ongoingactions.duplicate():
			if i.scene.code in ['facesit','afacesit'] && (i.givers.has(givers[0]) || i.takers.has(givers[0]) || i.givers.has(takers[0]) || i.takers.has(takers[0])):
				if i.givers == givers && i.takers == takers:
					stopongoingaction(i)
	if scenescript.code in ['facesit','afacesit']:
		for i in ongoingactions.duplicate():
			if i.scene.code == 'grovel' && (i.givers.has(givers[0]) || i.takers.has(givers[0]) || i.givers.has(takers[0]) || i.takers.has(takers[0])):
				if i.givers == givers && i.takers == takers:
					stopongoingaction(i)
	if scenescript.code == 'rope':
		for i in takers:
			var cleararray = []
			for k in i.activeactions:
				if k.scene.code == 'subdue':
					cleararray.append(k)
			for k in cleararray:
				stopongoingaction(k)
	if scenescript.code == 'deny_orgasm':
		OrgasmDenyInitiate(givers[0], takers[0])
	if scenescript.code == 'cum_select':
		SelectCum(givers[0], takers[0])

	var sceneexists = false
	var temptext = ''
	for i in ongoingactions:
		temptext = ''
		if i.givers == givers && i.takers == takers && i.scene == scenescript:
			sceneexists = true
		elif i.scene.has_method('getongoingdescription'):
			temptext = decoder(i.scene.getongoingdescription(i.givers, i.takers), i.givers, i.takers)
		else:
			temptext = output(i.scene, i.scene.ongoing, i.givers, i.takers)
		if temptext != '':
			textdict.repeats += '\n' + temptext
	textdict.repeats = textdict.repeats.replace("[color=yellow]", '').replace('[color=aqua]', '').replace('[/color]','')

	for i in ongoingactions:
		for k in i.givers + i.takers:
			k.person_sexexp.actions[i.scene.code] += 1
			for j in i.givers + i.takers:
				if j != k:
					if k.person_sexexp.partners.has(j.id):
						k.person_sexexp.partners[j.id] += 1
					else:
						k.person_sexexp.partners[j.id] = 1
		for k in participants:
			if !i.givers.has(k) && !i.takers.has(k):
				if k.person_sexexp.seenactions.has(i.scene.code):
					k.person_sexexp.seenactions[i.scene.code] += 1
				else:
					k.person_sexexp.seenactions[i.scene.code] = 1
		if i.scene.has_method("givereffect"):
			for member in i.givers:
				effects = i.scene.givereffect(member)
				for effect in effects:
					if effect in ['sens','horny']:
						effects[effect] = effects[effect]/2
				member.actioneffect(effects, i)
		if i.scene.has_method("takereffect"):
			for member in i.takers:
				effects = i.scene.takereffect(member)
				for effect in effects:
					if effect in ['sens','horny']:
						effects[effect] = effects[effect]/2
				member.actioneffect(effects, i)

	var request

	for i in participants:
		if i in givers+takers:
			if !scenescript.code == 'deny_orgasm':
				i.lastaction = dict
			request = checkrequest(i)
			if request == true:
				textdict.orgasms += decoder("[color=aqua]Desire fullfiled! [name1] grows lewder and more sensitive. [/color]\n", [i], [i])
		else:
			for j in ongoingactions:
				if i in j.givers + j.takers:
					i.lastaction = j
#		if not i.lastaction in ongoingactions:
#			i.lastaction = null
		for k in i.sex_traits:
			var trait = Traitdata.sex_traits[k]
			for j in trait.effects:
				if j.trigger == 'end_turn':
					call(j.effect, i)

	if cont == true && sceneexists == false:
		ongoingactions.append(dict)
		for i in givers + takers:
			i.activeactions.append(dict)
	else:
		for i in givers:
			if scenescript.giverpart != '':
				i[scenescript.giverpart] = null
		for i in takers:
			if scenescript.takerpart != '':
				i[scenescript.takerpart] = null

	var x = (givers.size()+takers.size())/2

	if virgin.type != null && !virgin.character.person.has_profession('master'):
		mandatoryspeech = true
		mandatoryspeechdict = {character = virgin.character, line = "virgin_" + virgin.type}

	while x > 0:
		if mandatoryspeech == true:
			var charspeech = forced_character_speech(dict, mandatoryspeechdict.character, mandatoryspeechdict.line)
			if charspeech.text != '':
				textdict.speech += charspeech.character.name + ': ' + decoder(charspeech.text, [charspeech.character], [charspeech.partner]) + '\n'
		elif randf() < 0.3:
			var charspeech = characterspeech(dict)
			if charspeech.text != '':
				textdict.speech += charspeech.character.name + ': ' + decoder(charspeech.text, [charspeech.character], [charspeech.partner]) + '\n'
		x -= 1
	var text = textdict.mainevent + "\n" + textdict.repeats + '\n' + textdict.speech + textdict.orgasms

	get_node("Panel/sceneeffects").bbcode_text += '\n' + text

	var temparray = []

	for i in participants:
		if i.person.has_profession("master") || i.person.get_stat('unique') in ['dog','horse'] || i.effects.has('forced'):
			continue
		temparray.append(i)

	if randf() < 0.15 && temparray.size() > 0:
		generaterequest(temparray[randi()%temparray.size()])

	record_actions(scenescript, dict.consents)
	rebuildparticipantslist()

func resist_text(side, stamina, character):
	var temparray = []
	
	if character.sex_traits.has("pushover"):
		temparray += ["[name] feels {^involuntarily:helplessly} {^aroused:horny} from {^the rough treatment:being taken against [his] will}..."]
		temparray += ["[name] {^moans:cries} {^involuntarily:helplessly} as [he] falls into submission..."]
		temparray += ["[name] {^blushes:turns red} from [his] own perverted arousal..."]
	else:
		if stamina > 30:
			temparray += ["[name] winces from the distress, but can't help with [his] growing {^desire:arousal}..."]
			temparray += ["[name] shies away from the unwanted {^desire:arousal}..."]
			temparray += ["[name] feels conflicted about [his] growing {^desire:arousal}..."]
		elif stamina > 0:
			temparray += ["[name] meekly tries to push [his] partner away..."]
			temparray += ["[name] closes his eyes in shame..."]
			temparray += ["[name] weeps as [his] body betrays [him]..."]
		else:
			temparray += ["[name] is a broken mess barely reacting to any violation..."]
			temparray += ["[name] stays quiet as [his] body is ravaged..."]
	
	
	var counter = 0
	var replace = globals.fastif(side == 'giver', '1]', '2]')
	for i in temparray:
		temparray[counter] = temparray[counter].replace(']', replace) 
		counter += 1
	
	if character.sex_traits.has("pushover"):
		return globals.TextEncoder("{color=yellow|"+temparray[randi()%temparray.size()] + "}")
	else:
		return globals.TextEncoder("{color=red|"+temparray[randi()%temparray.size()] + "}")

func lewdness_aura(caster):
	for i in participants:
		if i != caster:
			i.horny += 5
			i.sens += 50

func life_power(caster):
	caster.person.hp += caster.orgasms*8

func forced_character_speech(scene, character, textdict):
	var text = ''
	var partnerside
	var partner

	if character in scene.takers:
		partnerside = 'givers'
	else:
		partnerside = 'takers'
	partner = scene[partnerside][0]

	match textdict:
		'virgin_vaginal', 'virgin_anal':
			var resist = false
			if character.horny < 100: resist = true
			if resist == false: textdict += "_like"
			else: textdict += "_dislike"
		'rope':
			var like = false
			if character.sex_traits.has("submissive"): like = true
			if like == true: textdict += "_like"
			else: textdict += "_dislike"

	text = speechdict[textdict][randi()%speechdict[textdict].size()]

	return show_charcter_speech(character, partner, text)

func characterspeech(scene):
	var character
	var partner
	var text = ''

	#who speaks

	var array = []
	for i in scene.takers+scene.givers:
		if !i.person.has_profession('master'):
			array.append(i)

	var partnerside

	character = array[randi()%array.size()]

	if character in scene.takers:
		partnerside = 'givers'
	else:
		partnerside = 'takers'

	partner = scene[partnerside][0]

	array.clear() #array will serve as speech selector
	var dict = {}
	var prevailing_lines = ['mute', 'silence', 'orgasm', 'resistorgasm', 'pain', 'painlike', 'resist', 'blowjob']

	if character.person.check_trait('Mute'):
		dict.mute = [speechdict.mute, 1]
	if character.person.check_trait('Sex-crazed'):
		dict.sexcrazed = [speechdict.sexcrazed, 1]
	if character.sex_traits.has('anal'):
		dict.enjoysanal = [speechdict.enjoysanal, 1]
	if character.sex_traits.has('submissive'):
		dict.rough = [speechdict.rough, 1]
#	if character.person.rules.silence == true:
#		dict.silence = [speechdict.silence, 1]
	if character.person.is_players_character == false:
		dict.resist = [speechdict.resist, 1]
		if scene.scene.code in ['missionaryanal', 'doggyanal', 'lotusanal','revlotusanal', 'inserttaila', 'insertinturnsass']  && partnerside == 'givers':
			dict.analrape = [speechdict.analrape, 1]
	if character.orgasm == true:
		if character.effects.has('forced'):
			dict.resistorgasm = [speechdict.resistorgasm, 1]
		else:
			dict.orgasm = [speechdict.orgasm, 1]
	if scene.scene.code in ['blowjob'] && partnerside == 'takers':
		dict.blowjob = [speechdict.blowjob, 1]
	if scene.scene.code in ['blowjob','spitroast'] && partnerside == 'givers':
		dict.blowjobtake = [speechdict.blowjobtake, 1]
	if scene.scene.code in ['missionary', 'doggy', 'lotus', 'revlotus', 'inserttailv', 'insertinturns'] && partnerside == 'givers':
		dict.vagina = [speechdict.vagina, 1]
	if scene.scene.code in ['missionaryanal', 'doggyanal', 'lotusanal','revlotusanal', 'inserttaila', 'insertinturnsass'] && partnerside == 'givers':
		dict.anal = [speechdict.anal, 1]
	if (!character.person.check_trait('Lesbian') && !character.sex_traits.has("bisexual")) && character.sex != 'male' && partner.sex != 'male' && partnerside == 'givers':
		dict.nonlesbian = [speechdict.nonlesbian, 1]
	if scene.scene.get("takertags") && scene.scene.takertags.has("pain") && partnerside == 'givers' && !character.person.check_trait('Likes it rough') && !character.person.check_trait("Masochist"):
		dict.pain = [speechdict.pain, 2.5]
	if scene.scene.get("takertags") && scene.scene.takertags.has("pain") && partnerside == 'givers' && (character.person.check_trait('Likes it rough') || character.person.check_trait("Masochist")) && !character.effects.has('resist'):
		dict.painlike = [speechdict.painlike, 2.5]

	dict.moans = [speechdict.moans, 0.25]
	for i in prevailing_lines:
		if dict.has(i):
			var temp = dict[i].duplicate()
			dict.clear()
			dict[i] = temp
			break
	for i in dict.values():
		array.append(i)
	text = input_handler.weightedrandom(array)
	if text != null:
		text = text[randi()%text.size()]

	if text == null:
		text = ''
	return show_charcter_speech(character, partner, text)

func show_charcter_speech(character, partner, text):
	if partner.person.has_profession("master") || character.person.check_trait("Monogamous"):
		text = text.replace('[name2]', character.person.get_stat('masternoun'))
	else:
		text = text.replace('[name2]', partner.name)

	return {text = '[color=lime]' + text + '[/color]', character = character, partner = partner}

var speechdict = {
resist = ["Stop it!", "No... I don't want to!", "Why are you doing this...", "You, bastard...", "Let me go!"],
resistorgasm = ["Ahh-hh... No...", "*Sob* why... this feels so good...", "No, Please stop, before I... Ahh... No *sob*"],
mute = ['...', '...!', '......', '*gasp*'],
blowjob = ["Does it feel good? *slurp*", "Mh-m... this smell...", "Does this feel good, [name2]?", "You like my mouth, [name2]?"],
blowjobtake = ["Like my cock, [name2]?" , "Yes, suck it, dear...", "Mmmm, suck it like that."],
inexperienced = ["I've never done this...", "What's this?", "Not so fast, [name2], I'm new to this..."],
#virgin = ["Aaah! My first time...", "My first time...", "My first time... you took it..."],
vagina = ["Ah! Yes! Fuck my pussy!", "Yes, fill me up, [name2]!", "More, give me more, [name2]!", "Ah, this is so good, [name2]..."],
anal = ["My {^ass:butt}... feels good...", "Ah... My {^ass:butt}...", "Keep {^fucking:ravaging:grinding} my {^ass:butt}, [name2]..."],
orgasm = ["Cumming, I'm cumming!..", "Ah, Ahh, AAAHH!","[name2], please hold me, I'm cumming!"],
analrape = ["Stop! Where are you putting it!?", "No, please, not there!", "No, not my {^ass:butt}... I beg you..."],
sexcrazed = ["Your {^dick:cock:penis}... Yes...", "Give me your {^dick:cock:penis}, [name2]... I need it", "Fuck me, [name2], I begging you!.."],
nonlesbian = ["No, we shouldn't...", "No, we are both girls...","[name2], Ah, stop, I'm not into girls..."],
enjoysanal = ["Please, put my {^butt:ass} into a good use, [name2]...", "I want it in my {^butt:ass}..."],
rough = ["[name2], do me harder...", "Yes... Please, abuse me!"],
pain = ["Ouch! It hurts...", "Please, no more...", "*sob*", 'It hurts...', '[name2], please, stop...'],
painlike = ["Umh... Yes, hit me harder...", "Yes, [name2], punish me...", "Ah... this strings... nicely..."],
silence = ['Mmhmm...', '*gasp*', 'Mhm!!'],
moans = ["Ah...", "Oh...", "Mmmh...", "[name2]..."],

virgin_vaginal_like = ["Aaah! My first time...","[name2]... You took my first time...","Ah! I Had no idea this... feels so good..."],
virgin_vaginal_dislike = ["Ouch... it hurts...", "Ah... No... *sob*", "Noo... My... First time..."],
virgin_anal_like = ["Ah! My {^ass:butt}... Soiled...", "Oh! [name2], what are you... with my {^ass:butt}..."],
virgin_anal_dislike = ["Ugh, no... It hurts...", "Why, my {^ass:butt}... stop..."],
rope_like = ["Mmh... What are you going to do with me now?...", "Oooh... I feel... hot...", "Is this wrong... to like it?..."],
rope_dislike = ["Tying me... why?", "Ugh.. This rope is so thick...", "W-what's this for?"],

}


func startscenecontinue(scenescript):
	startscene(scenescript, true)


#centralized output processing
#category currently assumed to be 'fucking', will expland with further conversions
func output(scenescript, valid_lines, givers, takers):
	var shared_lines = sexdict.shared_lines
	var giverpart = scenescript.giverpart
	var takerpart = scenescript.takerpart
	var act_lines = scenescript.act_lines
	var links = sexdict.linksets[scenescript.linkset]
	#internal
	var linearray = []
	var output = ''
	var virginpart = null
	var virginsource = null
	var link = null
	#checks
	var checks = {
		code = scenescript.code,
		link = null,
		orifice = 'insert',
		consent = true,
		virgin = true,
		parallel = true if scenescript.rotation1.x == scenescript.rotation2.x else false,
		facing = true if scenescript.rotation1.w == 0.0 && scenescript.rotation2.w == 0.0 else false,
		arousal = 1,
		lust = 1,
	}

	#link with ongoingactions
	if givers[0][giverpart] != null:
		if givers[0][giverpart].scene.code in links:
			link = givers[0][giverpart].scene
			for i in givers:
				if i[giverpart] != givers[0][giverpart]:
					link = null
					break
			for i in takers:
				if i[takerpart] != givers[0][giverpart]:
					link = null
					break
	#link with lastaction if ongoing fails
	if link == null && givers[0].lastaction != null:
		if givers[0].lastaction.scene.code in links:
			link = givers[0].lastaction.scene
			for i in givers+takers:
				if i.lastaction != givers[0].lastaction:
					link = null
					break
	#gather orifice info from link
	if link != null:
		checks.link = link.code
		if scenescript.virginloss == true && link.virginloss == true:
			if checks.code == link.code:
				checks.orifice = 'same'
			elif 'vagina' in [scenescript.giverpart] + [scenescript.takerpart] && 'vagina' in [link.giverpart] + [link.takerpart]:
				checks.orifice = 'shift'
			elif 'anus' in [scenescript.giverpart] + [scenescript.takerpart] && 'anus' in [link.giverpart] + [link.takerpart]:
				checks.orifice = 'shift'
			else:
				checks.orifice = 'swap'
	#virginity assignments
	if giverpart == 'penis':
		if takerpart == 'vagina':
			virginpart = 'vaginal_virgin'
			virginsource = takers
		elif takerpart == 'anus':
			virginpart = 'anal_virgin'
			virginsource = takers
	elif takerpart == 'penis':
		if giverpart == 'vagina':
			virginpart = 'vaginal_virgin'
			virginsource = givers
		elif giverpart == 'anus':
			virginpart = 'anal_virgin'
			virginsource = givers
	#assign virginity check
	for i in virginsource:
		if i.person.get_stat(virginpart) == false:
			checks.virgin = false
	#assign consent

#	for j in takers:
#		var lowest_consent = 100
#		for i in givers:
#			var consent = count_action_consent(scenescript, i, j)
#			if consent.taker_consent < lowest_consent:
#				lowest_consent = consent.taker_consent
#		if lowest_consent < scenescript.consent_level:
#			checks.consent = false

#	for i in takers:
#		if i.mode == 'forced' || i.effects.has('resist'):
#			checks.consent = false
	#based on screen values, subject to adjustment
	if takers.size() == 1:
		checks.arousal = int(clamp(ceil(takers[0].sens/200), 1, 5))
		checks.lust = int(clamp(ceil(takers[0].lust/200), 1, 5))

	#build the output
	var drop = false
	for i in valid_lines:
		linearray = []
		if i in act_lines:
			for j in act_lines[i]:
				drop = false
				for k in act_lines[i][j].conditions:
					if checks.has(k) && !act_lines[i][j].conditions[k].has(checks[k]):
						drop = true
						break
				if drop == false:
					linearray += act_lines[i][j].lines
		if i in shared_lines:
			for j in shared_lines[i]:
				drop = false
				for k in shared_lines[i][j].conditions:
					if checks.has(k) && !shared_lines[i][j].conditions[k].has(checks[k]):
						drop = true
						break
				if drop == false:
					linearray += shared_lines[i][j].lines
		if linearray.size() > 0:
			output += linearray[randi()%linearray.size()]

	return decoder(output, givers, takers)

func impregnationcheck(person1, person2):
	var valid = true
	if person1.get_stat('unique') in ['dog','horse'] || person2.get_stat('unique') in ['dog','horse']:
		valid = false
	return valid


func isencountersamesex(givers, takers, actor = null):
	var actorpos = ''
	var samesex = false
	if givers.size() == 0 || takers.size() == 0:
		return false
	var giverssex = givers[0].sex
	var takerssex = takers[0].sex
	if givers.has(actor):
		actorpos = 'giver'
	elif takers.has(actor):
		actorpos = 'taker'

	if (actorpos == 'giver' && ((actor.sex == 'male' && takerssex == 'male') || (actor.sex in ['female','futa'] && takerssex in ['female','futa']))) || (actorpos == 'taker' && ((actor.sex == 'male' && giverssex == 'male') || (actor.sex in ['female','futa'] && giverssex in ['female','futa']))) :
		samesex = true
	return samesex


func decoder(text, tempgivers, temptakers):
	return parser.decoder(text, tempgivers, temptakers)


func _on_sceneeffects1_meta_clicked( meta ):
	stopongoingaction(meta, true)

func stopongoingaction(meta, rebuild = false):
	var action
	if typeof(meta) == TYPE_STRING:
		action = ongoingactions[int(meta)]
	elif typeof(meta) == TYPE_DICTIONARY:
		action = meta
	for i in action.givers:
		if action.scene.giverpart != '':
			i[action.scene.giverpart] = null
	for i in action.takers:
		if action.scene.takerpart != '':
			i[action.scene.takerpart] = null
		if action.scene.get("takerpart2"):
			i[action.scene.takerpart2] = null
	if action.scene.code == 'rope':
		for i in action.takers:
			i.effects.erase('tied')
	if action.scene.code == 'subdue':
		var erasearray = []
		for taker in action.takers:
			for giver in action.givers:
				giver.subduing = null
				erasearray.append(giver)
			for giver in erasearray:
				taker.subduedby.erase(giver)
	for i in action.givers + action.takers:
		i.activeactions.erase(action)
	ongoingactions.erase(action)
	if rebuild == true:
		rebuildparticipantslist()



func _on_passbutton_pressed():
	if turns <= 0: 
		$Panel/passbutton.disabled = true
		return
	if selectmode == 'normal':
		startscene(categories.other[0])
	else:
		askslaveforaction(ai[rand_range(0, ai.size())])

func _on_stopbutton_pressed():
	endencounter()

func endencounter():
	var text = ''
	var consenttext = {}
	set_process_input(false)
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()

	for i in participants:
		
		i.person.set_stat('lastsexday', ResourceScripts.game_globals.date)
		
		
		if i.stamina > 0 && i.low_actions_resisted > 7 - i.person.get_stat('sexuals_factor')/1.5 && i.person.get_stat('consent') < 6:
			i.person.add_stat('consent', 1)
			text += i.person.translate('[name] has opened [him]self to the new experience: Consent - {color=aqua|' + tr(variables.consent_dict[int(i.person.get_stat('consent'))]) + "}\n")
		elif i.stamina == 0:
			text += i.person.translate("[name] has been devastated by this encounter and have not been able to increase [his] open mindedness. ")
		
#		if i.new_action_performed == true:
#			i.consentgain += 1
#			consenttext[i.id] += '\nTried new action: +1'
#		if i.new_consented_partners > 0:
#			i.consentgain += i.new_consented_partners*2
#			consenttext[i.id] += '\nConsented to new partners: +' + str(i.new_consented_partners*2)

#		if floor(i.consented_actions.keys().size()/3) > 0:
#			i.consentgain += floor(i.consented_actions.keys().size())/3
#			consenttext[i.id] += "\nAccepted Variety: +" + str(floor(i.consented_actions.keys().size())/3)

#		if i.effects.has("pheromones"):
#			consenttext[i.id] += "\nWas drugged with pheromones: -" + str(floor(i.consentgain/2))
#			i.consentgain = floor(i.consentgain/2)
		text += i.person.translate("[name]: Orgasms - ") + str(i.orgasms) 
#		i.person.sexuals += i.orgasms not relevant
		var expgain = round(i.orgasms * 8 + i.sens/200)
		var bonus = 1
		if i.person.has_profession("succubus") ||i.person.has_profession("true_succubus") :
			bonus += 0.5

		for t in i.sex_traits:
			var trait = Traitdata.sex_traits[t]
			for j in trait.effects:
				if j.trigger == 'encounter_end':
					if j.effect == 'exp_bonus':
						bonus = input_handler.math(j.operant, bonus, j.value)
#					elif j.effect == 'consent_gain':
#						i.consentgain = input_handler.math(j.operant, i.consentgain, j.value)
					else: call(j.effect, i)

		expgain = expgain * bonus

		i.person.add_stat('base_exp', expgain)
		text += "; Experience gained: " + str(expgain)
		if i.orgasms > 0:
			var effect = 'satisfaction_1'
			if i.orgasms >= 3:
				effect = 'satisfaction_2'
			var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table[effect])
			i.person.apply_effect(effects_pool.add_effect(eff))
#		var temptext = consenttext[i.id]
#		consenttext[i.id] = "Total: "

#		if i.consentgain > 0:
#			consenttext[i.id] += '+'
#		else:
#			consenttext[i.id] += '-'
		#consenttext[i.id] += str(i.consentgain) + temptext
		#i.person.add_stat('consent', i.consentgain)
		text += "\n"

	ongoingactions.clear()

	var array = []
	var has_master = true
	var args = []
	for i in participants:
		array.append(i.id)
		if i.person.has_profession('master'):
			args.append("partner_is_master")
	input_handler.get_person_for_chat(array, 'sex_finish', args)

	var sex_traits = Traitdata.sex_traits
	var check = false
	var chance = false
	### Adding traits
	text += "\n"
	for p in participants:
		for i in sex_traits:
			check = check_acquire_reqs(p, sex_traits[i].acquire_reqs)
			chance = (randf()*100 < (5 + 5 * p.person.get_stat('sexuals_factor')))
			if chance && check && !p.person.get_unlocked_sex_traits().has(i):
				p.person.unlock_sex_trait(i)
				text += p.name + " learned trait: " + Traitdata.sex_traits[i].name + "\n"
	### Removing Dislikes
	var dislikes = []
	for p in participants:
		for diz in p.person.get_negative_sex_traits():
			if diz.begins_with("dislike"):
				dislikes.append(diz)
			if dislikes.size() != 0:
				for i in sex_traits:
					if !i.begins_with("dislike"):
						continue
					if !i in dislikes:
						continue
					check = check_acquire_reqs(p, sex_traits[i].reqs)
					chance = (randf()*100 < (5 + 5 * p.person.get_stat('sexuals_factor')))
					if (chance && check) :
						p.person.get_negative_sex_traits().erase(i) #bad practice still
						text += p.name + " lost trait: " + Traitdata.sex_traits[i].name + "\n"

	get_node("Control").show()
	get_node("Control/Panel/RichTextLabel").set_bbcode(globals.TextEncoder(text))

func mformula(gain, mana):
	return mana + gain * max(0, mana/(mana-300)+1)



func askslaveforaction(chosen):
	#choosing target
	var targets = []
	clearstate()
	var chosensex = chosen.sex
	var debug = ""
	var group = false
	var target

	debug += 'Chosing targets... \n'

	for i in participants:
		if i != chosen:
			if i.person.has_profession("master") && aiobserve == true:
				continue
			debug += i.name
			var value = 10
			if chosen.person.check_trait("Monogamous") && !i.person.has_profession('master'):
				value = 0
			elif chosen.person.check_trait("Fickle") || chosen.person.check_trait('Slutty'):
				value = 25
			if chosen.person.check_trait('Devoted') && i.person.has_profession("master"):
				value += 50

			if i.npc == true && chosen.npc == true:
				value -= 50

			if chosen.person_sexexp.orgasms.has(i.id):
				value += chosen.person_sexexp.orgasms[i.id]*4
			if chosen.person_sexexp.watchers.has(i.id):
				value += (chosen.person_sexexp.watchers[i.id]-1)*2
			if chosen.person_sexexp.partners.has(i.id):
				value += chosen.person_sexexp.partners[i.id]/0.2
			if isencountersamesex([chosen], [i], chosen) && !chosen.person.check_trait('Bisexual') && !chosen.person.check_trait('Homosexual'):
				value = max(value/5,1)
			elif isencountersamesex([chosen], [i], chosen) == false && chosen.person.check_trait('Homosexual'):
				value = max(value/5,1)
			debug += " - " + str(value) + '\n'
			value = min(value, 120)
			if value > 0:
				targets.append([i, value])

	target = input_handler.weightedrandom(targets)
	debug += 'final target - ' + target.name

	debug += '\nChosing dom: \n'
	var dom = [['giver',40],['taker', 10]]

	if target.sex != chosen.sex && chosen.sex == 'female' && (chosen.person.get_stat('asser') < 75 || !chosen.person.check_trait("Dominant")):
		dom[0][1] = 0

	if chosen.person.get_stat('asser') >= 75:
		dom[1][1] = 0
	elif chosen.person.get_stat('asser') <= 25:
		dom[0][1] = 0
	debug += str(dom) + "\n"
	dom = input_handler.weightedrandom(dom)

	debug += 'final dom: ' + dom + '\n'

	var groupchosen = [chosen]
	var grouptarget = [target]

	if participants.size() >= 3:
		if randf() >= 0.5 && !chosen.person.check_trait("Monogamous"):
			group = true
	var freeparticipants = []

	if group == true:
		debug += "Group action attempt:\n"
		for i in participants:
			if i.person.has_profession("master") && aiobserve == true:
				continue
			if i != chosen && i != target && randf() >= 0.5:
				freeparticipants.append(i)

		while freeparticipants.size() > 0:
			var targetgroup
			var newparticipant = freeparticipants[randi()%freeparticipants.size()]
			var samesex = isencountersamesex([newparticipant], [chosen], chosen)
			if chosen.person.check_trait("Bisexual"):
				targetgroup = 'any'
			elif (chosen.person.check_trait("Homosexual") && samesex) || !samesex:
				targetgroup = 'target'
			elif chosen.person.check_trait("Homosexual"):
				targetgroup = 'any'
			else:
				targetgroup = 'chosen'
			if (targetgroup == 'any' && randf() >= 0.5) || targetgroup == 'chosen':
				groupchosen.append(newparticipant)
			else:
				grouptarget.append(newparticipant)

			freeparticipants.erase(newparticipant)

	#choosing action
	var chosenpos = ''
	var actions = []
	var chosenaction = null
	debug += 'chosing action: \n'
	for i in categories:
		for j in categories[i]:
			clearstate()
			debug += j.code + ": "
			if j.code == 'wait':
				continue
			if j.code in takercategories:
				if dom == 'taker':
					givers += groupchosen
					takers += grouptarget
				else:
					takers += groupchosen
					givers += grouptarget
			else:
				if dom == 'taker':
					takers += groupchosen
					givers += grouptarget
				else:
					givers += groupchosen
					takers += grouptarget
			var result = checkaction(j, doubledildocheck())
			if result[0] == 'allowed':
				var value = 0
				if chosen.person_sexexp.actions.has(j.code):
					value += chosen.person_sexexp.actions[j.code]/2
				if chosen.person_sexexp.orgasms.has(j.code):
					value += chosen.person_sexexp.orgasms[j.code]*4
				if chosen.person_sexexp.seenactions.has(j.code):
					value += chosen.person_sexexp.seenactions[j.code]/10

				if i in ['caress','fucking']:
					value += 10

				if !chosen.person.check_trait("Enjoys Anal") && j.code in analcategories:
					if chosenpos == 'giver' && !takercategories.has(j.code):
						value -= 5
					elif chosenpos == 'taker' && takercategories.has(j.code):
						value -= 5



				if chosen.person.check_trait('Masochist') && j.code in punishcategories && chosenpos == 'taker':
					value *= 2.5
				if chosen.person.check_trait('Dominant') && j.code in punishcategories && chosenpos == 'giver':
					value *= 2.5
#				if target.submission < 20  && j.code in punishcategories && chosenpos == 'giver':
#					value *= 3
				if chosen.person.get_stat('penis_size') == 'none' && dom == 'giver' && j.code == 'strapon':
					value *= 10
				if chosen.person.check_trait("Pervert") && ((givers.has(chosen) && j.giverconsent == 'advanced') || (takers.has(chosen) && j.takerconsent == 'advanced')):
					value += 15

				if chosen.person.get_stat('vaginal_virgin') == true && j.category == 'fucking' && !j.code in analcategories:
					value -= 25
				if chosen.person.get_stat('anal_virgin') == true && j.category == 'fucking' && j.code in analcategories:
					value -= 25

				if j.category == 'fucking':
					value += max(turns, 15)

				if j.code in ['tribadism','doubledildo','doubledildoass','frottage'] && (chosen.strapon == true || target.strapon == true):
					value = 0

				debug += str(value) + '\n'
				if value >= 0:
					actions.append([j, value])
	if actions.size() == 0:
		actions.append([categories.other[0], 1])
	chosenaction = input_handler.weightedrandom(actions)
	clearstate()
	if chosenaction.code in takercategories:
		if dom == 'taker':
			givers = groupchosen
			takers = grouptarget
		else:
			takers = groupchosen
			givers = grouptarget
	else:
		if dom == 'taker':
			takers = groupchosen
			givers = grouptarget
		else:
			givers = groupchosen
			takers = grouptarget
	var cont = false
	chosenaction.givers = givers
	chosenaction.takers = takers
	var text = '[color=green][name1] initiates ' + chosenaction.getname() + ' with [name2].[/color]\n\n'
	if chosenaction.canlast == true && randf() >= 0.2:
		cont = true
	$PopupPanel/RichTextLabel.bbcode_text = debug
	#$PopupPanel.popup()
	startscene(chosenaction, cont, decoder(text, groupchosen, grouptarget))

func _on_finishbutton_pressed():
	gui_controller.clock.visible = true
	ai.clear()
	for i in participants:
		if i.npc == false:
			for k in participants:
				if k.npc == true:
					i.person_sexexp.watchers.erase(k.id)
					i.person_sexexp.partners.erase(k.id)
					i.person_sexexp.orgasms.erase(k.id)
	selectmode = 'normal'
	gui_controller.current_screen = gui_controller.previous_screen
	gui_controller.current_screen.raise()
	gui_controller.current_screen.show()
	if gui_controller.current_screen == gui_controller.mansion:
		gui_controller.current_screen.mansion_state_set("default")
		gui_controller.clock.raise()
	hide()
	# input_handler.update_slave_list()


func _on_blacklist_pressed():
	$blacklist.visible = true
	for i in $blacklist/ScrollContainer/VBoxContainer.get_children():
		if i.get_name() != 'CheckBox':
			i.visible = false
			i.queue_free()
	for i in categories.values():
		for j in i:
			if j.code == 'wait':
				continue
			var node = $blacklist/ScrollContainer/VBoxContainer/CheckBox.duplicate()
			j.givers = [participants[0]]
			$blacklist/ScrollContainer/VBoxContainer.add_child(node)
			node.visible = true
			node.text = j.getname(1)
			node.set_pressed(!filter.has(j.code))
			node.set_meta("action", j)
			node.connect("toggled", self, 'toggleaction', [node])

func toggleaction(button, node):
	var action = node.get_meta('action')
	if filter.has(action.code):
		filter.erase(action.code)
	else:
		filter.append(action.code)
	node.set_pressed(!filter.has(action.code))

func _on_closeblacklist_pressed():
	$blacklist.visible = false
	rebuildparticipantslist()




func _on_debug_pressed():
	$PopupPanel.popup()


func _on_aiallow_pressed():
	aiobserve = $Panel/aiallow.pressed



func resistattempt(member, strength):
	var result = {text = '', consent = true}
	var subdue = 0
	var resist_chance = 0



	if !member.sex_traits.has("doormat") || randf() >= 0.5:
		member.stamina -= strength*15
	
	
	result.text = "[name1] isn't happy doing this..."

#	if resiststrength > subdue && resiststrength != 0:
#		result.consent = true
#		result.text += '[name1] resists the attempt with brute force.\n'
#	else:
#		if member.subduedby.size() == 0:
#			result.text += '[name1] tries to struggle, but [his1] strength is not enough to fight back...\n'
#		else:
#			result.text += "[name1]'s attempts to resist are stopped by being held by [name2]. \n"


	result.text = decoder(result.text, [member], member.subduedby)
	return result

#func resistattempt(member):
#	var result = {text = '', consent = true}
#	var resiststrength = member.person.get_stat('physics_factor')
#	var subdue = 0
#	var resist_chance = 0
#
#	if member.sex_traits.has('doormat') == false:
#		member.person.add_stat('obedience', -1)
#
#	match member.person.get_stat('personality'):
#		'kind':
#			resist_chance = 0.2
#		'bold':
#			resist_chance = 0.9
#		'shy':
#			resist_chance = 0.05
#		'serious':
#			resist_chance = 0.5
#	if member.sex_traits.has("doormat"):
#		resist_chance = 0
#
#	if member.effects.has('tied'):
#		resiststrength = 0
#
#		result.text += '[name1] is powerless to resist, as [his1] limbs are restricted by rope.\n'
#
#	for i in member.subduedby:
#		subdue += i.person.get_stat('physics_factor')
#
#	if resiststrength > subdue && resiststrength != 0:
#		result.consent = false
#		result.text += '[name1] resists the attempt with brute force.\n'
#	else:
#		if member.subduedby.size() == 0:
#			result.text += '[name1] tries to struggle, but [his1] strength is not enough to fight back...\n'
#		else:
#			result.text += "[name1]'s attempts to resist are stopped by being held by [name2]. \n"
#
#
#	result.text = decoder(result.text, [member], member.subduedby)
#	return result


func alcohol(member):
	var text = "\n" + member.name + " has drank an alcoholic bevarage. "
	if member.effects.has("drunk") == false && member.effects.has('tipsy') == false:
		member.sensmod += 0.2
		member.hornymod += 0.5
		member.horny += 25
		member.stamina += 40
		member.effects.append('drunk')
		text += "It made [him] slightly more horny and sensitive. "
	else:
		text += "But it seems [he] is already drunk. "
	$Panel/sceneeffects.bbcode_text += member.person.translate(text)
	givers = [member]
	_on_passbutton_pressed()

func beer(member):
	var text = "\n" + member.name + " has drank a beer. "
	if member.effects.has("drunk") == false && member.effects.has("tipsy") == false:
		member.sensmod += 0.1
		member.hornymod += 0.3
		member.horny += 10
		member.stamina += 20
		member.effects.append('tipsy')
		text += "It made [him] slightly more horny and sensitive. "
	else:
		text += "But it seems [he] is already drunk. "
	$Panel/sceneeffects.bbcode_text += member.person.translate(text)
	_on_passbutton_pressed()

func aphrodisiac(member):
	member.horny += 100
	member.stamina += 50
	var text = "\n" + member.name + " has used an aphrodisiac. [His] breath grew slower and heavier.\n{color=aqua|[name]} - {random_chat=0|aphrodisiac}"
	member.effects.append("aphrodisiac")
	input_handler.scene_characters = [member.person]
	$Panel/sceneeffects.bbcode_text += member.person.translate(globals.TextEncoder(text))
	givers = [member]
	_on_passbutton_pressed()


func sensitivity_pot(member):
	member.sensmod += 1
	member.lewdmod += 0.2
	var text = "\n" + member.name + " has used an sensitivity potion. [His] body became more responsive.\n{color=aqua|[name]} - {random_chat=0|aphrodisiac}"

	input_handler.scene_characters = [member.person]
	$Panel/sceneeffects.bbcode_text += member.person.translate(globals.TextEncoder(text))
	_on_passbutton_pressed()

func pheromones(member):
	var text = ''
	if member.effects.has('pheromones'):
		text = "\n" + member.name +" is already under effect of pheromones."
	else:
		if member.person.get_stat('race') in races.race_groups.halfbeast + races.race_groups.beast:
			member.effects.append("pheromones")
			member.lewdmod += 1
			member.consent = max(member.consent, 4)
			input_handler.scene_characters = [member.person]
			text = "\nPheromones were used on " + member.name + globals.TextEncoder("... [His] mind became engulfed in unquenchable thirst.\n{color=aqua|[name]} - {random_chat=0|aphrodisiac}")
		else:
			text = "\nPheromones were used on " + member.name + ", but they had no effect on [him]. "

	givers = [member]
	$Panel/sceneeffects.bbcode_text += member.person.translate(text)
	_on_passbutton_pressed()


func record_actions(scenescript, consents):
	scenescript.givers = givers
	scenescript.takers = takers
	for p in participants:
		p.max_ongoing_actions = max(p.max_ongoing_actions, ongoingactions.size())
		if p.orgasm:
			p.orgasm_actions.append(scenescript.code)
		if p.orgasm && !scenescript.code in p.aphrodisiac_orgasms && p.effects.has("aphrodisiac"):
			p.aphrodisiac_orgasms.append(scenescript.code)
		if p.role == null or p.role == 'none':
			for i in takers + givers:
				if i.orgasm:
					i.orgasm_with_watcher += 1
				if i.orgasm && !i in p.seen_orgasms:
					p.seen_orgasms.append(i)
		if p.role == "give":
			if scenescript.takertags.has("punish"):
				p.punish_actions.append(scenescript.code)
			for t in takers:
				if t.orgasm:
					if p.person.check_trait("undead") || p.person.check_trait("animal"):
						t.deviant_orgasms += 1
					if t.person.get_stat('body_shape') != p.person.get_stat('body_shape'):
						t.diff_body_orgasm += 1
					for tag in scenescript.takertags:
						if !tag in t.orgasm_tags:
							t.orgasm_tags.append(tag)
					for e in t.effects:
						if e in ["tipsy", "drunk"]:
							t.drunk_orgasm += 1
						if !e in t.orgasm_effects:
							t.orgasm_effects.append(e)
					if !p in t.orgasm_partners:
						t.orgasm_partners.append(p)
				if t.orgasm && !p in t.diff_partners_orgasms:
					t.diff_partners_orgasms.append(p)
				if t.orgasm && !t in p.satisfied_partners:
					p.satisfied_partners.append(t)
				if consents[t.id] > 0:
					if t.orgasm:
						t.unconsented_orgasm += 1
				else:
					if scenescript.takertags.has("punish"):
						t.mazo_actions.append(scenescript.code)
					if !scenescript.code in p.single_partner_consents:
						p.single_partner_consents.append(scenescript.code)
					if p.person.get_stat('sexuals') >= 100 && !scenescript.code in t.bedroom_prodigy:
						t.bedroom_prodigy.append(scenescript.code)
		if p.role == "take":
			for g in givers:
				if g.orgasm:
					if scenescript.givertags.has("dom"):
						g.dominant += 1
					if p.person.check_trait("undead") || p.person.check_trait("animal"):
						g.deviant_orgasms += 1
					if g.person.get_stat('body_shape') != p.person.get_stat('body_shape'):
						g.diff_body_orgasm += 1
					
					if consents[g.id] > 0:
						if g.orgasm:
							g.unconsented_orgasm += 1
					for tag in scenescript.givertags:
						if !tag in g.orgasm_tags:
							g.orgasm_tags.append(tag)
					for e in g.effects:
						if e in ["tipsy", "drunk"]:
							g.drunk_orgasm += 1
						if !e in g.orgasm_effects:
							g.orgasm_effects.append(e)

func operate_flag(flag, input1, input2, actor):
	var check = true
	match flag:
		"any":
			for i in input2:
				if i in actor[input1]:
					return check
		"only":
			check = actor[input1].has(input2)
			return check



func check_acquire_reqs(actor, arr):
	if arr.empty():
		var check = false
		return check
	var check = true
	for i in arr:
		if i.has('flag'):
			check =	operate_flag(i.flag, i.type, i.value, actor)
			return check
		if i.has('orflag'):
			check = check or acquire_valuecheck(i, actor)
		else:
			check = check and acquire_valuecheck(i, actor)
	return check

func acquire_valuecheck(r, actor):
	var check = true
	var actor_value
	match r.code:
		'stat':
			if typeof(actor[r.type]) == TYPE_ARRAY:
				actor_value = len(actor[r.type])
			else:
				actor_value = actor[r.type]
			check = input_handler.operate(r.operant, actor_value, r.value)
		'actor_check':
			check = check_acquire_reqs(actor, r.value)
		'same_sex_orgasms':
			actor_value = actor.actionshad.samesexorgasms
			check = input_handler.operate(r.operant, actor_value, r.value)
		'action_type':
			var condition = 0
			for action in actor.orgasm_actions:
				if action in r.value:
					condition += 1
			if condition < 3:
				check = false
	return check

func has_master():
	for i in participants:
		if i.person.has_profession('master'):
			return true

	return false
