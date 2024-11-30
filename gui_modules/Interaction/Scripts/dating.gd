extends Control

#mood & fear - dating only stats, they increase and reduce from actions (start at 0)
#authority & consent - increase directly from some actions (punishments/intimacy)
#loyalty/submission get buff

#need to remove all resist_state checks - for they are obsolete 

var location
var master
var person
var public = false
var mood = 0.0 setget mood_set,mood_get
var fear = 0.0 setget fear_set
var authStart #authority
var consStart #consent
var date = false
var jail = false
var drunkness = 0.0
var actionhistory = []
var categories = ['Affection','Discipline','Location','Items']
var locationarray = ['livingroom','town','dungeon','garden','bedroom']
var location_changed = false
var finish_encounter = false
var turn = 0 setget turn_set
var observing_slaves = []
onready var showntext = '' setget showtext_set,showtext_get
var submodules = []

var helpdescript = {
	mood = '[center]Mood[/center]\nA high mood increases likeliness of positive outcome of intimate actions and provides Loyalty after session is finished.\nMood grows from positive interactions and decreases from negative interactions.',
	fear = '[center]Fear[/center]\nFear improves Authority and Obedience once date is over. \nFear grows from punishing actions, but when pushed too high will make partner breakdown and stop interaction. ',
	#consent = "[center]Consent[/center]\nConsent will make character agree to perform lewder actions in a more exciting situtations. \nConsent is gained by willingly performing lewd actions.",
	#authority = ""
	}

func fear_set(value):
	var difference = value - fear
	difference *= rand_range(0.75, 1.25)
	if difference != 0:
		if difference > 0:
			$fear/Label.text = "+"
			$fear/Label.set("custom_colors/font_color", Color(1,0,0))
		else:
			$fear/Label.text = "—"
			$fear/Label.set('custom_colors/font_color', Color(0,1,0))
		ResourceScripts.core_animations.FadeAnimation($fear/Label,0.5)
	fear = max(0,fear + difference)
	$fear.value = floor(fear)


func mood_set(value):
	var difference = value - mood
	difference *= rand_range(0.75, 1.25)
	if difference != 0:
		if difference > 0:
			if person.has_temp_effect('resist_state'):
				difference /= 3
			$mood/Label.text = "+"
			$mood/Label.set("custom_colors/font_color", Color(0,1,0))
		else:
			$mood/Label.text = "—"
			$mood/Label.set('custom_colors/font_color', Color(1,0,0))
		ResourceScripts.core_animations.FadeAnimation($mood/Label,0.5)
	mood = max(0,mood + difference)
	$mood.value = floor(mood)

func mood_get():
	return mood

func turn_set(value):
	turn = value
	$turns/Label.text = str(turn)

var locationdicts = {
	livingroom = {code = 'livingroom',name = tr('DATING_LIVING_ROOM'), background = 'mansion'},
	bedroom = {code = 'bedroom',name = tr('DATING_BEDROOM'), background = 'mansion'},
	dungeon = {code = 'dungeon',name = tr('DATING_TORTURE_ROOM'), background = 'dungeon'},
	garden = {code = 'garden',name = tr('DATING_GARDEN'), background = 'garden'},
	town = {code = 'town',name = tr('DATING_STREETS'), background = 'aliron'},
}


var dateclassarray = []

class dateclass:
	var person
	var sex
	var name
	var lust = 0
	var lube = 0
	var sens = 0
	var horny = 0


func _ready():
#	ResourceScripts.game_world.make_world()
#	location = 'livingroom'
#
#	globals.AddItemToInventory(globals.CreateUsableItem("alcohol"))
#	globals.AddItemToInventory(globals.CreateUsableItem("beer"))
#	master = ResourceScripts.scriptdict.class_slave.new()
#	master.create('Human', 'male', 'random')
#	master.unlock_class('master')
#	characters_pool.move_to_state(master.id)
#
#	person = ResourceScripts.scriptdict.class_slave.new()
#	person.create('HalfkinFox', 'female', 'random')
#	person.set_stat('personality', 'shy')
#	ResourceScripts.game_res.upgrades.torture_room = 1
#
#	var character = ResourceScripts.scriptdict.class_slave.new()
#	character.create('HalfkinCat', 'female', 'random')
#	characters_pool.move_to_state(character.id)
#	character = ResourceScripts.scriptdict.class_slave.new()
#	character.create('HalfkinCat', 'female', 'random')
#	characters_pool.move_to_state(character.id)
#	character = ResourceScripts.scriptdict.class_slave.new()
#	character.create('HalfkinCat', 'female', 'random')
#	characters_pool.move_to_state(character.id)
	for i in helpdescript:
		globals.connecttexttooltip(get_node(i),helpdescript[i])
	#globals.connecttexttooltip($panel/categories/Location,"Location can influence your partner and allow new options. Does not cost Time.")
	#globals.connecttexttooltip($panel/categories/Training,"Training together will end the encounter.")
	$end/sexbutton.connect("pressed", self, 'start_sex')
	$StopButton.connect("pressed",self,'doaction', ["stop"])
	gui_controller.add_close_button($Items)
#	initiate(person)

func initiate(tempperson):
	var text = ''
	self.visible = true
	self.mood = 0
	self.drunkness = 0
	self.turn = 10
	self.consStart = tr(variables.consent_dict[int(tempperson.get_stat('consent'))])
	self.finish_encounter = false
	date = false
	public = false
	observing_slaves.clear()
	$sexswitch.visible = false
	$end.visible = false
	$textfield/RichTextLabel.clear()
	location_changed = false
	$background.texture = images.get_background('mansion')



	actionhistory.clear()
	dateclassarray.clear()

	person = tempperson

	master = ResourceScripts.game_party.get_master()

	var newclass = dateclass.new()
	newclass.sex = master.get_stat('sex')
	newclass.name = master.get_short_name()
	newclass.person = master
	dateclassarray.append(newclass)
	newclass = dateclass.new()
	newclass.person = person
	newclass.sex = person.get_stat('sex')
	newclass.name = person.get_short_name()
	dateclassarray.append(newclass)



	self.fear = 0#person.fear
	var stored_image = person.get_stored_body_image()
	if stored_image != null:
		$fullbody.texture = stored_image
		$fullbody.visible = true
		$ragdoll.visible = false
	elif !input_handler.globalsettings.disable_paperdoll:
		$fullbody.visible = false
		$ragdoll.visible = true
		$ragdoll.test_mode = false
		$ragdoll.rebuild(person)
		$ragdoll.rebuild_cloth(true)
	else:
		$fullbody.texture = person.get_body_image()
		$fullbody.visible = true
		$ragdoll.visible = false
#	$fullbody.set_texture(null)
#	if person.get_body_image() != null:
##		var image = person.get_body_image()
##		if images.sprites.has(person.get_stat("unique")):
##			image = images.sprites[person.get_stat("unique")]
##			pass #print(image.get_path())
#		var image
#		var non_body = person.statlist.statlist.body_image.replace("_body", "")
#		if images.sprites.has(non_body):
#			image = input_handler.loadimage(images.sprites[non_body], 'shades')
#		else:
#			image = person.get_body_image()
#		$fullbody.set_texture(image)
	# $textfield/slaveportrait.texture = null

	if person.get_icon_small() != null:
		$textfield/slaveportrait/TextureRect.set_texture(person.get_icon_small())
	else:
		$textfield/slaveportrait/TextureRect.set_texture(null)
	$textfield/slaveportrait/Name.text = person.get_short_name()
	$textfield/masterportrait/Name.text = master.get_short_name()
	$textfield/masterportrait/TextureRect.set_texture(master.get_icon_small())
	# if $textfield/slaveportrait.texture == null:
	# 	$textfield/slaveportrait/TextureRect.visible = false
	# else:
	# 	$textfield/slaveportrait/TextureRect.visible = true

	# $textfield/masterportrait/TextureRect.texture = null
#	if globals.player.imageportait != null && globals.loadimage(globals.player.imageportait):
#		$textfield/masterportrait.set_texture(globals.loadimage(globals.player.imageportait))
#	else:
#		globals.player.imageportait = null
#		$textfield/masterportrait.set_texture(null)
	# if $textfield/masterportrait.texture == null:
	# 	$textfield/masterportrait/TextureRect.visible = false
	# else:
	# 	$textfield/masterportrait/TextureRect.visible = true



	if jail == true:
		location = 'dungeon'
		text = tr("DATING_JAIL_TEST")
		$panel/categories/Location.disabled = true
	else:
		$panel/categories/Location.disabled = false
		location = 'livingroom'
		text = tr("DATING_LIVING_ROOM_TEXT_1")
#		if person.has_temp_effect('resist_state'):
#			text += "[he2] reluctantly follows you having no other choice, still sore from [his2] encapture."
#			text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_start_angry')) + "\n"
#		elif person.get_stat('loyalty_total') >= 35:
#			text += tr("DATING_LIVING_ROOM_TEXT_2")
#			self.mood += 10
#			text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_start_happy')) + "\n"
#		elif person.get_stat('obedience') >= 40:
#			self.mood += 4
#			text += tr("DATING_LIVING_ROOM_TEXT_3")
#			text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_start')) + "\n"
#		else:
#
#			text += tr("DATING_LIVING_ROOM_TEXT_4")
#			text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_start')) + "\n"
	self.showntext = globals.TextEncoder(text)
	updatelist()
	$panel/categories/Affection.emit_signal("pressed")

var category


func showtext_set(value):
	var text = decoder(value)
	$textfield/RichTextLabel.bbcode_text = text
	showntext = text

func showtext_get():
	return $textfield/RichTextLabel.bbcode_text


func selectcategory(button):
	for i in $panel/categories.get_children():
		i.pressed = false
		if i.name == button:
			i.pressed = true
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
	category = button
	updatelist()

func endencounter():
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
	if $sexswitch.visible == false && $end.visible == false:
		var text = calculateresults()
		$end/RichTextLabel.bbcode_text = text
		$end.visible = true

func check_location(array):
	if array.size() == 0:
		return true
	else:
		return array.has(location)


func updatelist():
	for i in $panel/ScrollContainer/GridContainer.get_children():
		if i.name != 'Button':
			i.visible = false
			i.queue_free()
	$PlaceName.text = locationdicts[location].name
	#$panel/categories/Location.visible = !location_changed
	if category == 'Location':
		for i in locationdicts.values():
			if i.code == location || (i.code == 'dungeon' && ResourceScripts.game_res.upgrades.torture_room == 0):
				continue
			var newnode = $panel/ScrollContainer/GridContainer/Button.duplicate()
			$panel/ScrollContainer/GridContainer.add_child(newnode)
			newnode.visible = true
			newnode.text = i.name
			newnode.connect("pressed",self,'moveto', [i.code])


	for i in actionsdict.values():
		if i.name == "Stop":
			continue
		if person.checkreqs(i.reqs) == true && check_location(i.location) && (i.group == category || i.group == 'any'):
			if i.has('onetime') && checkhistory(i.effect) > 0 || (finish_encounter == true && i.effect != 'stop'):
				continue
			var newnode = $panel/ScrollContainer/GridContainer/Button.duplicate()
			$panel/ScrollContainer/GridContainer.add_child(newnode)
			newnode.visible = true
			newnode.text = person.translate(i.name)
			newnode.connect("pressed",self,'doaction', [i.effect])
			var text = i.descript
			if dislike_same_sex() == true && i.effect in ['flirt','kiss','propose']:
				text += globals.TextEncoder(tr("DATING_DISLIKE_SAME_SEX"))
			globals.connecttexttooltip(newnode, person.translate(text))
			if i.has('disablereqs'):
				newnode.disabled = true

	$panel/ScrollContainer/GridContainer.move_child($panel/ScrollContainer/GridContainer/Button, $panel/ScrollContainer/GridContainer.get_children().size())
	var text = tr("SIBLINGMODULECONSENT") + tr(variables.consent_dict[int(person.get_stat("consent"))])
	$authconslabel.text = text
	#$mana/Label.text = str(globals.resources.mana)
	$gold/Label.text = ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.money)
#	$supply/Label.text = str(globals.itemdict.supply.amount)

func moveto(newloc):
	location_changed = true
	self.location = newloc
	ResourceScripts.core_animations.BlackScreenTransition(0.5)
	yield(get_tree().create_timer(0.5), 'timeout')
	$panel/categories/Affection.emit_signal("pressed")
	$background.texture = images.get_background(locationdicts[newloc].background)
	self.showntext = tr('DATING_MOVE_TO_TEXT') + locationdicts[location].name + '[/color]. '


	updatelist()

func actiontooltip(descript):
	globals.showtooltip(person.dictionary(descript))


onready var parser = ResourceScripts.scriptdict.sexinteraction_parser.new()

func decoder(text):
	text = parser.decoder(text, [dateclassarray[0]], [dateclassarray[1]])
	return text

var stopactions = false

func doaction(action):
	if stopactions == true:
		return
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
	stopactions = true
	if action in ['train', 'study','practice_charm', 'public']:
		ResourceScripts.core_animations.BlackScreenTransition(0.5)
		yield(get_tree().create_timer(0.5), 'timeout')
	var text = call(action, person, checkhistory(action))
	if !action in ['useitem', 'food']:
		self.showntext = globals.TextEncoder(decoder(text))
	actionhistory.append(action)
	stopactions = false
	if !action in ['train', 'study','practice_charm', 'public', 'useitem','stop']:
		self.turn -= 1
		if turn%2 == 0:
			if location == 'garden' && person.get_stat('personality') == 'shy':
				self.mood += 4
				self.showntext += decoder(tr("DATING_LOC_INFLUENCE_1"))
			elif location == 'town' && person.get_stat('personality') == 'bold':
				self.mood += 4
				self.showntext += decoder(tr("DATING_LOC_INFLUENCE_2"))
			elif location == 'dungeon':
				self.fear += 3
				self.showntext += decoder(tr("DATING_LOC_INFLUENCE_3"))
	if turn <= 0:
		finish_encounter = true
		self.showntext += tr("DATING_NO_TIME")
	drunkness()
	updatelist()

func checkhistory(action):
	var counter = 0
	for i in actionhistory:
		if i == action:
			counter += 1
	return counter


var date_lines = {
	chat_start = [
		[tr("DATING_CHAT_START_1"), 1],
		[tr("DATING_CHAT_START_2"), 3],
		[tr("DATING_CHAT_START_3"),1],
		[tr("DATING_CHAT_START_4"),1],
	],
	chat_positive = [
		[tr("DATING_CHAT_POSITIVE_1"),1],
		[tr("DATING_CHAT_POSITIVE_2"),1],
	],
	chat_negative = [
		[tr("DATING_CHAT_NEGATIVE_1"),1],
		[tr("DATING_CHAT_NEGATIVE_2"),1],
	],
	flirt_start = [
		[tr("DATING_FLIRT_START_1"), 1],
		[tr("DATING_FLIRT_START_2"), 1],
		[tr("DATING_FLIRT_START_3"), 1],
	],
	flirt_positive = [
		[tr("DATING_FLIRT_POSITIVE_1"), 1],
		[tr("DATING_FLIRT_POSITIVE_2"), 1],
		[tr("DATING_FLIRT_POSITIVE_3"), 1],
	],
	flirt_negative = [
		[tr("DATING_FLIRT_NEGATIVE_1"), 1],
		[tr("DATING_FLIRT_NEGATIVE_2"), 1],
		[tr("DATING_FLIRT_NEGATIVE_3"), 1],
	],

	touch_start = [
		[tr("DATING_TOUCH_START_1"), 1],
	],
	touch_positive = [
		[tr("DATING_TOUCH_POSITIVE_1"), 1],
	],
	touch_negative = [
		[tr("DATING_TOUCH_NEGATIVE_1"), 1],
	],
	combhair_start = [
		[tr("DATING_COMBHAIR_START_1"), 1],
	],
	combhair_positive = [
		[tr("DATING_COMBHAIR_POSITIVE_1"), 1],
	],
	combhair_negative = [
		[tr("DATING_COMBHAIR_NEGATIVE_1"), 1],
	],



	hug_start_samesize = [ [tr("DATING_HUG_START_SAMESIZE_1"), 1], [tr("DATING_HUG_START_SAMESIZE_2"), 1], [tr("DATING_HUG_START_SAMESIZE_3"), 1], ],
	hug_start_bigsize = [ [tr("DATING_HUG_START_BIGSIZE_1"), 1], [tr("DATING_HUG_START_BIGSIZE_2"), 1], ],
	hug_start_smallsize = [ [tr("DATING_HUG_START_SMALLSIZE_1"), 1], ],
	hug_positive_samesize = [ [tr("DATING_HUG_POSITIVE_SAMESIZE_1"), 1], [tr("DATING_HUG_POSITIVE_SAMESIZE_2"), 1], ],
	hug_positive_bigsize = [ [tr("DATING_HUG_POSITIVE_BIGSIZE_1"), 1], [tr("DATING_HUG_POSITIVE_BIGSIZE_2"), 0.5], ],
	hug_positive_smallsize = [ [tr("DATING_HUG_POSITIVE_SMALLSIZE_1"), 1], [tr("DATING_HUG_POSITIVE_SMALLSIZE_2"), 0.5], ],
	hug_negative = [ [tr("DATING_HUG_NEGATIVE_1"), 1], ],
	kiss_start = [ [tr("DATING_KISS_START_1"), 1], ],
	kiss_positive = [ [tr("DATING_KISS_POSITIVE_1"), 1], [tr("DATING_KISS_POSITIVE_2"), 1], ],
	kiss_erotic = [ [tr("DATING_KISS_EROTIC_1"),1], ],
	kiss_erotic_public = [tr("DATING_KISS_EROTIC_PUBLIC_1"), 1],
	kiss_negative = [ [tr("DATING_KISS_NEGATIVE_1"), 1], [tr("DATING_KISS_NEGATIVE_2"), 1] ],
	
	marry_initiate = [ [tr("DATING_MARRY_INITIATE_1"), 1] ],
	marry_same_sex = [ [tr("DATING_MARRY_SAME_SEX_1"), 1] ],
	agreed_to_marry_prev = [ [tr("DATING_AGREED_TO_MARRY_PREV_1"), 1] ],
	agreed_to_marry = [ [tr("DATING_AGREED_TO_MARRY_1"), 1] ],
	refused_to_marry = [ [tr("DATING_REFUSED_TO_MARRY_1"), 1] ],
	propose_initiate = [ [tr("DATING_PROPOSE_INITIATE_1"), 1] ],
	propose_had_sex_before = [ [tr("DATING_PROPOSE_HAD_SEX_BEFORE_1"), 1] ],
	propose_was_forced_before = [ [tr("DATING_PROPOSE_WAS_FORCED_BEFORE_1"), 1] ],
	propose_already_reached_consent = [ [tr("DATING_PROPOSE_ALREADY_REACHED_CONSENT_1"), 1], ["DATING_PROPOSE_ALREADY_REACHED_CONSENT_2", 1] ],
	propose_reject = [ [tr("DATING_PROPOSE_REJECT_1"), 1] ],
	propose_accept = [ [tr("DATING_PROPOSE_ACCEPT_1"), 1], [tr("DATING_PROPOSE_ACCEPT_2"), 1] ],

	praise_initiate = [ [tr("DATING_PRAISE_INITIATE_1"), 1], [tr("DATING_PRAISE_INITIATE_2"), 1], [tr("DATING_PRAISE_INITIATE_3"), 1] ],
	praise_accept = [[tr("DATING_PRAISE_ACCEPT_1"), 1]],
	praise_resist = [[tr("DATING_PRAISE_RESIST_1"), 1]],

	pathead_initiate = [[tr("DATING_PATHEAD_INITIATE_1"), 1]],

	pathead_accept = [[tr("DATING_PATHEAD_ACCEPT_1"), 1], [tr("DATING_PATHEAD_ACCEPT_2"), 1], [tr("DATING_PATHEAD_ACCEPT_3"), 1]],
	pathead_resist = [[tr("DATING_PATHEAD_RESIST_1"), 1], [tr("DATING_PATHEAD_RESIST_2"), 1]],

	scold_initiate = [[tr("DATING_SCOLD_INITIATE_1"), 1]],
	scold_accept = [[tr("DATING_SCOLD_ACCEPT_1"), 1]],
	scold_resist = [[tr("DATING_SCOLD_RESIST_1"), 1]],
	rubears_initiate = [[tr("DATING_RUBEARS_INITIATE_1"), 1], [tr("DATING_RUBEARS_INITIATE_2"), 1]],
	rubears_accept = [[tr("DATING_RUBEARS_ACCEPT_1"), 1]],
	rubears_resist = [[tr("DATING_RUBEARS_RESIST_1"), 1]],
	stroketail_initiate = [[tr("DATING_STROKETAIL_INITIATE_1"), 1]],
	stroketail_accept = [[tr("DATING_STROKETAIL_ACCEPT_1"), 1], [tr("DATING_STROKETAIL_ACCEPT_2"), 1]],
	stroketail_resist = [[tr("DATING_STROKETAIL_RESIST_1"), 1]],
	pullear_initiate = [[tr("DATING_PULLEAR_INITIATE_1"), 1]],
	pullear_accept = [[tr("DATING_PULLEAR_ACCEPT_1"), 1]],
	pullear_resist = [[tr("DATING_PULLEAR_RESIST_1"), 1], [tr("DATING_PULLEAR_RESIST_2"), 1]],
	pulltail_initiate = [[tr("DATING_PULLTAIL_INITIATE_1"), 1]],
	pulltail_accept = [[tr("DATING_PULLTAIL_ACCEPT_1"), 1]],
	pulltail_resist = [[tr("DATING_PULLTAIL_RESIST_1"), 1], [tr("DATING_PULLTAIL_RESIST_2"), 1]],
	slap_initiate = [[tr("DATING_SLAP_INITIATE_1"), 1]],
	slap_accept = [[tr("DATING_SLAP_ACCEPT_1"), 1]],
	slap_resist = [[tr("DATING_SLAP_RESIST_1"), 1]],
	food_initiate = [[tr("DATING_FOOD_INITIATE_1"), 1]],
	food_resist = [[tr("DATING_FOOD_RESIST_1"), 1]],
	food_liked = [[tr("DATING_FOOD_LIKED_1"), 1]],
	food_hated = [[tr("DATING_FOOD_HATED_1"), 1]],
	food_netural = [[tr("DATING_FOOD_NEUTRAL_1"), 1]],

}

var descripts = {
	hairlength = {func = 'hairlength_descripts', stat = 'hair_length'},
	earadj = {func = 'ears_descripts', stat = 'ears'},
	tailadj = {func = 'tail_descripts', stat = 'tail'},
}

func character_description(text_input):
	var text = text_input
	var temptext = ''

	text = text.replace('[haircolor]', tr("HAIRCOLOR_" + person.get_stat('hair_color').to_upper()) + " ")
	for i in descripts:
		temptext = call(descripts[i].func, person.get_stat(descripts[i].stat))
		if temptext != '':
			temptext += " "
		text = text.replace("["+i+"]", temptext)

	return text

func hairlength_descripts(hairlength):
	var text = ''
	if hairlength in ['shoulder','waist','hips']:
		text = input_handler.weightedrandom([['long',3],['gorgeous',1],['beautiful',1],['soft',1], ['silky',1]])
	elif hairlength in ['ear','neck']:
		text = input_handler.weightedrandom([['soft',1],['silky',1]])
	return text

func ears_descripts(eartype):
	var array = [['',0.5]]
	if eartype in ['human','elven','orcish','demon','fish']:
		pass
	elif eartype in ['cat','wolf','fox','tanuki','bunny_standing','bunny_drooping','cow']:
		array = [['fluffy',1],['animal',1]]
		match eartype:
			'cat':
				array.append(['cat',1])
				array.append(['feline',1])
			'wolf':
				array.append(['wolf',1])
				array.append(['dog-like',1])
			'fox':
				array.append(['fox',1])
			'wolf':
				array.append(['wolf',1])
			'tanuki':
				array.append(['racoon',1])
			'bunny_standing','bunny_drooping':
				array.append(['bunny',1])
	elif eartype == 'feathered':
		array.append(["feathered", 1])

	return input_handler.weightedrandom(array)

func tail_descripts(tailtype):
	var array = [['',0.5]]
	if !tailtype in ['fox','cat','wolf','dragon','demon','tanuki','fish','lizard']:
		pass
	elif tailtype in ['cat','wolf','fox','tanuki','cow']:
		array = [['fluffy',1],['furry',1]]
		match tailtype:
			'cat':
				array.append(['cat',1])
				array.append(['feline',1])
			'wolf':
				array.append(['wolf',1])
				array.append(['dog-like',1])
			'fox':
				array.append(['fox',1])
			'wolf':
				array.append(['wolf',1])
			'tanuki':
				array.append(['racoon',1])
	elif tailtype in ['dragon','demon','fish','lizard']:
		match tailtype:
			'dragon':
				array.append(['dragon',1])
				array.append(['scaly',1])
			'demon':
				array.append(['demonic',1])
			'fish':
				array.append(['fish-like',1])
				array.append(['scaly',1])
			'lizard':
				array.append(['lizard',1])
				array.append(['scaly',1])

	return input_handler.weightedrandom(array)

func compare_heights(char1, char2):
	var rval = 'same'
	var height1 = variables.slave_heights.find(char1.get_stat('height'))
	var height2 = variables.slave_heights.find(char2.get_stat('height'))

	if height1-1 > height2:
		rval = 'big'
	if height2-1 > height1:
		rval = 'small'

	return rval


func is_same_sex():
	var rval = false
	if master.get_stat('sex') == person.get_stat('sex'):
		rval = true
	return rval

func is_same_sex_except_futa():
	var rval = false
	if master.get_stat('sex') == person.get_stat('sex') && master.get_stat('sex') != 'futa':
		rval = true
	return rval

func dislike_same_sex():
	var rval = false
	if is_same_sex() == true && !person.check_trait('bisexual'):
		rval = true
	return rval

func chat(person, counter):

	var text = input_handler.weightedrandom(date_lines.chat_start) + "\n\n"

	if 8 - counter*1.5 > 2 :
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.chat_positive)
		text += "}"
		self.mood += 8 - counter*1.5
	else:
		self.mood -= 1
		text += "{color=red|"
		text += input_handler.weightedrandom(date_lines.chat_negative)
		text += "}"

	return text

func flirt(person, counter):
	var text = ''
	text += input_handler.weightedrandom(date_lines.flirt_start) + "\n\n"

	var min_mood = rand_range(8,14)
	if dislike_same_sex():
		min_mood *= 2
	if mood > min_mood && 10 - counter*2 > 2:
		self.mood += 10 - counter * 2
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.flirt_positive)
		text += "}"
	else:
		text += "{color=red|"
		text += input_handler.weightedrandom(date_lines.flirt_negative)
		text += "}"
		self.mood -= 3
	return text


func intimate(person, counter):
	var text = tr("DATING_INTIM_BED_1")
	if mood >= 80 - master.get_stat('charm_factor') * 7:
		var has_unknown_traits = false
		var trait_array = person.get_all_sex_traits()
		var unknown_trait_array = []
		for i in trait_array:
			if trait_array[i] == false:
				has_unknown_traits = true
				unknown_trait_array.append(i)
		if has_unknown_traits == true:
			var unlocking_trait = input_handler.random_from_array(unknown_trait_array)
			person.make_trait_known(unlocking_trait)
			text += tr("DATING_INTIM_BED_2")
			text += tr("DATING_INTIM_BED_3") + Traitdata.sex_traits[unlocking_trait].name
			text += "}"
		else:
			text += tr("DATING_INTIM_BED_4")
			text += "}"
		if person.get_stat('consent') < ceil(person.get_stat("sexuals_factor")/2.0):
			person.add_stat('consent', 1)
			text += "\n" + person.translate(tr("DATING_INTIM_BED_6")) + tr(variables.consent_dict[int(person.get_stat('consent'))])  + "}"
	else:
		text += tr("DATING_INTIM_BED_5")
		self.mood -= 8
	return text

func touch(person, counter):

	var text = ''
	text += input_handler.weightedrandom(date_lines.touch_start) + "\n\n"

	if 6 - counter > 1:
		self.mood += 6 - counter
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.touch_positive)
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		text += "{color=red|"
		text += input_handler.weightedrandom(date_lines.touch_negative)
		text += "}"
		self.mood -= 2
	return text

func holdhands(person, counter):
	var text = ''
	if location != 'bedroom':
		text += tr("DATING_HOLDHANDS_1")
	else:
		text += tr("DATING_HOLDHANDS_2")
	if 8 - counter > 3 && self.mood >= 5:
		text += tr("DATING_HOLDHANDS_3")
		self.mood += 8 - counter
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		self.mood -= 2
		text += tr("DATING_HOLDHANDS_4")

	return text

func combhair(person, counter):
	var text = ''
	text += input_handler.weightedrandom(date_lines.combhair_start) + "\n\n"

	if 7 - counter > 2:
		self.mood += 7 - counter
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.combhair_positive)
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		text += "{color=red|"
		text += input_handler.weightedrandom(date_lines.combhair_negative)
		text += "}"
		self.mood -= 2
	return character_description(text)


func hug(person, counter):
	var text = ''
	var size_difference = compare_heights(master,person)
	text += input_handler.weightedrandom(date_lines['hug_start_'+size_difference+"size"]) + "\n\n"


	if (11 - counter*2 > 2 ) && self.mood >= 20:
		self.mood += 11 - counter*2
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines['hug_positive_'+size_difference+"size"])
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		text += "{color=red|"
		text += input_handler.weightedrandom(date_lines['hug_negative'])
		text += "}"
		self.mood -= 2
	return character_description(text)


func kiss(person, counter):
	var text = input_handler.weightedrandom(date_lines.kiss_start) + "\n\n"

	var min_mood = 20
	if dislike_same_sex():
		min_mood *= 1.5

	if self.mood < min_mood:
		text += "{color=red|"
		text += input_handler.weightedrandom(date_lines.kiss_negative)
		text += "}"
		self.mood -= 5
	elif self.mood >= min_mood && (self.mood < min_mood*2 || (location == 'city' && !person.check_traits('shameless'))):
		self.mood += 20
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.kiss_positive)

		if person.get_stat('personality') in ['shy','kind']:
			text += tr("DATING_KISS_1")
		else:
			text +=  tr("DATING_KISS_2")

		text += "}"
		if randf() > 0.5:
			text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	elif self.mood >= min_mood*2:
		self.mood += 30
		text += "{color=green|"
		if location == 'city' && person.check_traits('shameless'):
			text += input_handler.weightedrandom(date_lines.kiss_erotic_puclic)
		else:
			text += input_handler.weightedrandom(date_lines.kiss_erotic)

		match person.get_stat('personality'):
			'serious', 'kind':
				text += tr("DATING_KISS_3")
			'shy':
				text +=  tr("DATING_KISS_4")
			'bold':
				text +=  tr("DATING_KISS_5")

		text += "}"
		if randf() > 0.5:
			text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"

	return text

func rape(person, counter):
	var text = ''

	return text






func propose(person, counter):
	var text = ''

	var gave_consent = false

	#guaranteed agreement

	if person.get_stat('had_cons_sex_with_mc') == true:
		gave_consent = true
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.propose_had_sex_before)
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_proposal_had_sex')) + "\n"
	elif person.get_stat('had_forced_sex_with_mc') == true:
		gave_consent = true
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.propose_was_forced_before)
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_proposal_was_forced')) + "\n"

	if person.get_stat('consent') >= 4:
		gave_consent = true
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.propose_already_reached_consent)
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_proposal_agree')) + "\n"


	if gave_consent == false:
		var difficulty =  self.mood * 2 + drunkness * 6
#		if person.has_status('sex_basic'): difficulty += 40# 2 rework
		if dislike_same_sex():
			difficulty -= 25
	#	if globals.state.relativesdata.has(person.id) && (int(globals.state.relativesdata[person.id].father) == int(globals.player.id) || int(globals.state.relativesdata[person.id].mother) == int(globals.player.id)):
	#		difficulty -= 10
		if difficulty <= 100:
			text += "{color=red|"
			text += input_handler.weightedrandom(date_lines.propose_reject)
			text += "}"
			self.mood -= 15
			text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_proposal_refuse'))
		else:
			gave_consent = true
			text += "{color=green|"
			text += input_handler.weightedrandom(date_lines.propose_accept)
			text += "}"
			text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_proposal_agree'))

		if gave_consent == true:
			person.set_stat('was_proposed',true)

		return text

var sexmode

var unique_marry_rules = {
	anastasia = {
		marriage_agreed = {
			reqs = [{type = 'decision', value = 'AnastasiaMarry', check = true}],
			text = "ANASTASIA_MARRIAGE_AGREED_TEXT",
			description = "ANASTASIA_MARRIAGE_AGREED_DESCRIPTION",
			agrees = true
		},
		enslavement_agreed = {
			reqs = [{type = 'decision', value = 'AnastasiaMarry', check = false}],
			text = "ANASTASIA_ENSLAVEMENT_AGREED_TEXT",
			description = "ANASTASIA_ENSLAVEMENT_AGREED_DESCRIPTION",
			agrees = false
		},
	},
	aire = {
		ana_alive = {
			reqs = [{type = 'decision', value = 'PrincessObtained', check = true}],
			text = "AIRE_ANA_ALIVE_TEXT",
			description = "AIRE_ANA_ALIVE_DESCRIPTION",
			agrees = false
		},
		ana_dead = {
			reqs = [{type = 'decision', value = 'PrincessDead', check = true}],
			text = "AIRE_ANA_DEAD_TEXT",
			description = "AIRE_ANA_DEAD_DESCRIPTION",
			agrees = false
		},
		
	},
	daisy = {
		daisy_quest_finished = {
			reqs = [{type = "quest_completed", name = "daisy_lost", check = true}],
			text = "DAISY_QUEST_FINISHED_TEXT",
			description = "DAISY_QUEST_FINISHED_DESCRIPTION",
			agrees = true
		},
		daisy_quest_unfinished = {
			reqs = [{type = "quest_completed", name = "daisy_lost", check = false}],
			text = "DAISY_QUEST_UNFINISHED_TEXT",
			description = "DAISY_QUEST_UNFINISHED_DESCRIPTION",
			agrees = false
		},
	},
	kuro = {
		kuro_quest_finished = {
			reqs = [{type = "quest_completed", name = "kuro_tome_quest", check = true}],
			text = "KURO_QUEST_FINISHED_TEXT",
			description = "KURO_QUEST_FINISHED_DESCRIPTION",
			agrees = true
		},
#		kuro_quest_unfinished = {
#			reqs = [{type = "quest_completed", name = "daisy_lost", check = false}],
#			text = "DAISY_QUEST_UNFINISHED_TEXT",
#			description = "DAISY_QUEST_UNFINISHED_DESCRIPTION",
#			agrees = false
#		},
	},
	cali = {
		cali_quest_finished = {
			reqs = [{type = "quest_completed", name = "cali_heirloom_quest", check = true}],
			text = "CALI_QUEST_FINISHED_DESCRIPTION",
			description = "CALI_QUEST_FINISHED_TEXT",
			agrees = true
		},
		cali_quest_unfinished = {
			reqs = [{type = "has_active_quest", name = "cali_heirloom_quest", check = true}],
			text = "CALI_QUEST_UNFINISHED_DESCRIPTION",
			description = "CALI_QUEST_UNFINISHED_TEXT",
			agrees = false
		},
		
		cali_bad_route_finished = {
			reqs = [{type = "quest_completed", name = "cali_taming_quest", check = true}],
			text = "CALI_BAD_ROUTE_FINISHED_TEXT",
			description = "CALI_BAD_ROUTE_FINISHED_DESCRIPTION",
			agrees = true
		},
		cali_bad_route_unfinished = {
			reqs = [{type = "has_active_quest", name = "cali_taming_quest", check = true}],
			text = "CALI_BAD_ROUTE_UNFINISHED_TEXT",
			description = "CALI_BAD_ROUTE_UNFINISHED_DESCRIPTION",
			agrees = false
		},
	},
	lilia = {
		lilia_quest_finished = {
			reqs = [{type = "quest_completed", name = "lilia_finale_quest", check = true}],
			text = "LILIA_QUEST_FINISHED_TEXT",
			description = "LILIA_QUEST_FINISHED_DESCRIPTION",
			agrees = true
		},
		lilia_quest_unfinished = {
			reqs = [{type = "quest_completed", name = "lilia_finale_quest", check = false}],
			text = "LILIA_QUEST_FINISHED_TEXT",
			description = "LILIA_QUEST_FINISHED_DESCRIPTION",
			agrees = false
		},
	},
	lilith = {
		lilith_quest_finished = {
			reqs = [{type = "quest_completed", name = "lilith_patron_quest", check = true}],
			text = "LILIA_QUEST_FINISHED_TEXT",
			description = "LILIA_QUEST_FINISHED_DESCRIPTION",
			agrees = true
		},
		lilith_quest_unfinished = {
			reqs = [{type = "quest_completed", name = "lilith_patron_quest", check = false}],
			text = "LILIA_QUEST_FINISHED_TEXT",
			description = "LILIA_QUEST_FINISHED_DESCRIPTION",
			agrees = false
		},
	},
	amelia = {
		amelia_agree = {
			reqs = [],
			text = "AMELIA_PROPOSAL_TEXT",
			description = "AMELIA_PROPOSAL_DESCRIPT",
			agrees = true
		},
	},
}

func ask_to_marry(person, counter):
	var text = ''

	var gave_consent = false
	
	if is_same_sex_except_futa():
		text += "{color=red|"
		text += input_handler.weightedrandom(date_lines.marry_same_sex)
		text += "}"
		return text
	
	
	if person.get_stat('agreed_to_marry') == true:
		gave_consent = true
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.agreed_to_marry_prev)
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'marry_proposal_agreed_before')) + "\n"
		return text
	var unique_descript = ""
	var unique_text = ""
	if unique_marry_rules.has(person.get_stat('unique')):
		for i in unique_marry_rules[person.get_stat('unique')].values():
			if globals.checkreqs(i.reqs):
				gave_consent = i.agrees
				unique_text = person.translate(tr(i.text))
				unique_descript = person.translate(tr(i.description))
				
				break
	else:
		if person.has_status('relation'): #fix, this one is always true
			gave_consent = true
	
	
	
	if gave_consent:
		person.set_stat('agreed_to_marry', true)
		self.mood += 50
		text += "{color=green|"
		if unique_descript != "":
			text += unique_descript
		else:
			text += input_handler.weightedrandom(date_lines.agreed_to_marry)
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: "
		if unique_text != "":
			text += unique_text
		else:
			text += person.translate(input_handler.get_random_chat_line(person, 'marry_proposal_agree')) 
	else:
		text += "{color=red|"
		if unique_descript != "":
			text += unique_descript
		else:
			text += input_handler.weightedrandom(date_lines.refused_to_marry)
		text += "}"
		self.mood -= 25
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: "
		if unique_text != "":
			text += unique_text
		else:
			text += person.translate(input_handler.get_random_chat_line(person, 'marry_proposal_refuse'))
	
	return text


func praise(person, counter):
	var text = input_handler.weightedrandom(date_lines.praise_initiate) + "\n\n"

	if person.has_temp_effect('resist_state') == false:
		self.mood += 15
#		person.add_stat('obedience', 50)
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.praise_accept)
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'master_praise')) + "\n"
	else:
		text += "{color=red|"
		text += input_handler.weightedrandom(date_lines.praise_resist)
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'praise_reject')) + "\n"
	return character_description(text)

func pathead(person, counter):
	var text = input_handler.weightedrandom(date_lines.pathead_initiate) + "\n\n"

	if person.has_temp_effect('resist_state') == false && 10-counter*1.5 > 2:
		self.mood += 10 - counter*1.5
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.pathead_accept)
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		text += "{color=red|"
		text += input_handler.weightedrandom(date_lines.pathead_resist)
		text += "}"
	return character_description(text)

func scold(person, counter):
	var text = input_handler.weightedrandom(date_lines.scold_initiate) + "\n\n"
	var value = {mood = -3, fear = 10 - counter, action = 'scold'}

	if person.has_temp_effect('resist_state') == false:
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.scold_accept)
		text += "}"
		#text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		value.mood = -10
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.scold_resist)
		text += "}"

	text += punish_process(value)

	return character_description(text)

func rubears(person, counter):
	var text = input_handler.weightedrandom(date_lines.rubears_initiate) + "\n\n"

#	if person.has_temp_effect('resist_state') == false && person.get_stat('loyalty_total') >= 50 && 8 - counter > 3:
#		self.mood += 8 - counter
#		text += "{color=green|"
#		text += input_handler.weightedrandom(date_lines.rubears_accept)
#		text += "}"
#		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
#	else:
#		self.mood -= 2
#		text += "{color=red|"
#		text += input_handler.weightedrandom(date_lines.rubears_resist)
#		text += "}"
	return character_description(text)

func stroketail(person, counter):
	var text = input_handler.weightedrandom(date_lines.stroketail_initiate) + "\n\n"

#	if person.has_temp_effect('resist_state') == false && person.get_stat('loyalty_total') >= 65 && 11 - counter*1.5 > 2:
#		self.mood += 11 - counter*1.5
#		text += "{color=green|"
#		text += input_handler.weightedrandom(date_lines.stroketail_accept)
#		text += "}"
#		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
#	else:
#		self.mood -= 3
#		text += "{color=red|"
#		text += input_handler.weightedrandom(date_lines.stroketail_resist)
#		text += "}"
	return character_description(text)
#	var text = ''
#	text += "You gently stroke [name2]'s tail. "
#
#	if counter < 5 || randf() >= 0.4:
#		self.mood += 11
#		text = text + "[he2] seems happy with your attention, as [his2] tail wags in response."
#		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
#	else:
#		text = text + "[he2] seems to be bored from repeated action. "
#		self.mood -= 1
#	return text

func pullear(person, counter):

	var text = input_handler.weightedrandom(date_lines.pullear_initiate) + "\n\n"
	var value = {mood = -7, fear = 14-counter, action = 'pullear'}

	if person.has_temp_effect('resist_state') == false:
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.pullear_accept)
		text += "}"
		#text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		value.mood = -10
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.pullear_resist)
		text += "}"

	text += punish_process(value)

	return character_description(text)

func pulltail(person, counter):

	var text = input_handler.weightedrandom(date_lines.pulltail_initiate) + "\n\n"
	var value = {mood = -5, fear = 15-counter, action = 'pulltail'}

	if person.has_temp_effect('resist_state') == false:
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.pulltail_accept)
		text += "}"
		#text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		value.mood = -10
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.pulltail_resist)
		text += "}"

	text += punish_process(value)

	return character_description(text)

func punish_process(value):
	var text = ''
	if person.check_trait("Masochist") && randf() >= 0.8:
		text += tr("DATING_PUNISH_1")
		value.mood = -value.mood

	if randf() >= 0.5:
		match value.action:
			'scold':
				text += "\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_scold'))
			"pullear",'pulltail','slap','flag':
				text += "\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_punish_light'))
			'wax','horse','flag','whip':
				text += "\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_punish_heavy'))

	if observing_slaves.size() > 0:
		text += "\n\n[color=yellow]"
		var array = []
		for i in observing_slaves:
			array.append(i.get_short_name())
		text += input_handler.text_form_recitation(array)
		text += tr("DATING_PUNISH_2")


		value.mood *= 1.2
		value.fear *= 1.3


	self.fear += value.fear
	self.mood += value.mood

	return text

func build_observing_slaves():
	for i in ResourceScripts.game_party.character_order:
		var character = ResourceScripts.game_party.characters[i]
		if character.check_location('aliron') && character != person && !character.has_profession('master'):
			observing_slaves.append(character)

func slap(person, counter):
	var text = ''
	text += tr("DATING_SLAP_1")

	var value = {mood = -3, fear = 12-counter, action = 'slap'}
	text += punish_process(value)
	return text

func flag(person, counter):
	var text = ''
	text += tr("DATING_FLAG_1")

	var value = {mood = -5, fear = 16-counter, action = 'flag'}

	text += punish_process(value)
	return text

func whip(person, counter):
	var text = ''
	text += tr("DATING_WHIP_1")


	var value = {mood = -5, fear = 20-counter, action = 'whip'}
	text += punish_process(value)
	return text

func horse(person, counter):
	var text = ''
	text += tr("DATING_HORSE_1")


	var value = {mood = -5, fear = 20-counter, action = 'horse'}
	text += punish_process(value)

	return text

func wax(person, counter):
	var text = ''
	text += tr("DATING_WAX_1")

	var value = {mood = -5, fear = 18-counter, action = 'wax'}

	text += punish_process(value)

	return text

func train(person, counter):
	var text = ''
	var value = person.get_stat('physics_factor') * (turn/4.0)
	var value2 = master.get_stat('physics_factor') * (turn/4.0)


	text += (tr("DATING_TRAIN_1")
	+ master.get_short_name() + ": +" + str(floor(value2)) + "; "
	+ person.get_short_name() + ": +" + str(floor(value)))
	person.add_stat('physics', value)
	master.add_stat('physics', value2)
	self.mood += self.turn
	self.turn = 0
	finish_encounter = true

	return text

func study(person, counter):
	var text = ''
	var value = person.get_stat('wits_factor') * (turn/4.0)
	var value2 = master.get_stat('wits_factor') * (turn/4.0)

	text += (tr("DATING_STUDY_1")
	+ master.get_short_name() + ": +" + str(floor(value2)) + "; "
	+ person.get_short_name() + ": +" + str(floor(value)))

	person.add_stat('wits', value)
	master.add_stat('wits', value2)
	self.mood += self.turn
	self.turn = 0
	finish_encounter = true

	return text

func charm(person, counter):
	var text = ''
	var value = person.get_stat('charm_factor') * (turn/4.0)
	var value2 = master.get_stat('charm_factor') * (turn/4.0)

	text += (tr("DATING_CHARM_1")
	+ master.get_short_name() + ": +" + str(floor(value2)) + "; "
	+ person.get_short_name() + ": +" + str(floor(value)))

	person.add_stat('charm', value)
	master.add_stat('charm', value2)
	self.mood += self.turn
	self.turn = 0
	finish_encounter = true

	return text



func castfear(person, counter):
	var text = ''
	var spell = globals.spelldict.fear
	person.metrics.spell += 1
	var spellnode = globals.spells
	spellnode.person = person
	text = spellnode.call(spell.effect)
	updatebars()
	return text

func castsedate(person, counter):
	var text = ''
	var spell = globals.spelldict.sedation
	person.metrics.spell += 1
	var spellnode = globals.spells
	spellnode.person = person
	text = spellnode.call(spell.effect)
	updatebars()
	return text


func public(person, counter):
	var text = ''
	if public == false:
		build_observing_slaves()
		if observing_slaves.size() > 0:
			text = tr("DATING_PUBLIC_1")
			text += "\n\n[color=yellow]"
			var array = []
			for i in observing_slaves:
				array.append(i.get_short_name())
			text += input_handler.text_form_recitation(array)
			text += tr("DATING_PUBLIC_2")
			public = true
			text += "{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_public')) + "\n"
			for i in observing_slaves:
				var temptext = i.translate(input_handler.get_random_chat_line(i, 'date_public_observe'))
				temptext = person.translate(temptext.replace('[2','['))
				text += "\n{color=yellow|" + i.get_short_name() + "}: " + temptext

		else:
			text += tr("DATING_PUBLIC_3")
	else:
		text = tr("DATING_PUBLIC_4")
		public = false
		observing_slaves.clear()
	return text

func updatebars():
	self.fear = person.fear

func stop(person, counter):
	var text = ''
	endencounter()
	return text

func get_item_category(item):
	var type
	if Items.materiallist.has(item.code):
		if item.type == 'food':
			type = 'food'
		else:
			type = 'material'
	else:
		if item.itemtype == 'tool':
			type = 'tool'
		elif item.itemtype == 'weapon':
			type = 'weapon'
		elif item.itemtype == 'armor':
			if item.geartype == 'costume':
				type = 'costume'
			else:
				type = 'armor'
		else:
			type = 'usable'
	return type


var prev_action = ""

func food(person, counter):
	input_handler.append_not_duplicate(gui_controller.windows_opened, $Items)
	$Items.visible = !$Items.is_visible() || (prev_action == "useitem" || prev_action == "")
	var array = []
	for i in ResourceScripts.game_res.materials:
		if ResourceScripts.game_res.materials[i] <= 0:
			continue
		var material = Items.materiallist[i]
		var type = get_item_category(material)
		if type == "food":
			array.append(material)

	input_handler.ClearContainer($Items/ScrollContainer/HBoxContainer)
	for item in array:
		var newbutton = input_handler.DuplicateContainerTemplate($Items/ScrollContainer/HBoxContainer)
		newbutton.get_node("ItemTexture").texture = item.icon
		newbutton.get_node("Label").text = item.name
		newbutton.get_node("Amount").text = str(ResourceScripts.game_res.materials[item.code])
		newbutton.connect("pressed", self, "usefood", [item])
		globals.connectmaterialtooltip(newbutton, item)
	prev_action = "food"


func usefood(food):
	var text = input_handler.weightedrandom(date_lines.food_initiate).replace("[food]", food.name) + "\n\n"
	$Items.hide()
	ResourceScripts.game_res.set_material(food.code, '-', 1)
	self.turn -=1

	if person.has_temp_effect('resist_state'):
		text += "{color=red|"
		text += input_handler.weightedrandom(date_lines.food_resist)
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'treat_food_resist')) + "\n"
	else:
		var state = 'neutral'
		if food.tags.has(person.food.food_love):
			state = 'like'
			for i in food.tags:
				if person.food.food_hate.has(i):
					state = 'neutral'
		else:
			for i in food.tags:
				if person.food.food_hate.has(i):
					state = 'hate'

		if state == 'like':
			text += "{color=green|"
			text += input_handler.weightedrandom(date_lines.food_liked)
			text += "}"
			self.mood += 15
			text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'treat_food_like')) + "\n"
		elif state == 'hate':
			self.mood -= 10
			text += "{color=red|"
			text += input_handler.weightedrandom(date_lines.food_hated)
			text += "}"
			text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'treat_food_hate')) + "\n"
		elif state == 'neutral':
			text += "{color=green|"
			text += input_handler.weightedrandom(date_lines.food_netural)
			text += "}"
			self.mood += 5
			text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'treat_food_neutral')) + "\n"

	self.showntext = globals.TextEncoder(decoder(text))
	updatelist()


func useitem(person, counter):
	if !gui_controller.windows_opened.has($Items):
		gui_controller.windows_opened.append($Items)
	$Items.visible = !$Items.is_visible() || (prev_action == "food" || prev_action == "")
	var array = []
	for i in ResourceScripts.game_res.items.values():
		if i.type == 'gear':
			continue
		if Items.itemlist[i.code].tags.has('date'):
			array.append(i)
	input_handler.ClearContainer($Items/ScrollContainer/HBoxContainer)
	for item in array:
		var newbutton = input_handler.DuplicateContainerTemplate($Items/ScrollContainer/HBoxContainer)
		newbutton.get_node("ItemTexture").texture = load(item.icon)
		newbutton.get_node("Label").text = item.code.capitalize()
		newbutton.get_node("Amount").text = str(ResourceScripts.game_res.items[item.id].amount)
		newbutton.connect("pressed", self, "item_selected", [item])
	# globals.ItemSelect(self, 'date_use', 'item_selected')
	# return ''
	prev_action = "useitem"

func item_selected(item):
	call(item.code, person)
	$Items.hide()

func alcohol(person):
	var text = ''
	text += tr("DATING_ALCO_1")
	if self.mood < 15 || !person.has_status('relation'): #or another trait, basic servitude removed
		text += tr("DATING_ALCO_2")
	else:
		text += tr("DATING_ALCO_3")
		self.mood += 15

		drunkness += 3
		ResourceScripts.game_res.remove_item('alcohol',1)

	self.showntext = globals.TextEncoder(decoder(text))
	drunkness()
	updatelist()

func beer(person):
	var text = ''
	text += tr("DATING_ALCO_1")
	if self.mood < 5:
		text += tr("DATING_ALCO_2")
	else:
		text += tr("DATING_ALCO_3")
		self.mood += 10

		drunkness += 1
		ResourceScripts.game_res.remove_item('beer',1)

	self.showntext = globals.TextEncoder(decoder(text))
	drunkness()
	updatelist()



func drunkness():
	var capacity = variables.slave_heights.find(person.get_stat('height'))
	if drunkness > capacity + 3:
		endencounter()
		$end/RichTextLabel.bbcode_text += decoder(tr("DATING_ALCO_OVERDOSE_1"))

func strChange(value):
	if value > 0:
		return "+" + str(round(value))
	else:
		return str(round(value))

func calculateresults():
	var sex_offer = false
	var endmood = floor(self.mood)
	var endfear = floor(self.fear)

#	var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table['date_bonus'])
#	person.apply_effect(effects_pool.add_effect(eff))
	var obedience = 100
	var authority = 0
	var consent = 0
	var loyalty = 0
	var text = ('Encounter Ended.'
	+ "\nMood: " + str(endmood)
	+ "\nFear: " + str(endfear)
	)
	if endmood >= endfear:
#		loyalty = ceil(endmood/4) + max(0,(master.get_stat('charm_factor')) - 3) * 5
		loyalty = 6 + master.get_stat('charm_factor') * 2 +  person.get_stat('tame_factor') * 2
		text += (tr("DATING_POSITIVE_MODE_1")
		+ tr("DATING_LOYALTY_1") + str(loyalty) + tr("DATING_CHARMF_BONUS_1") + str( max(0,(master.get_stat('charm_factor')) - 3) * 5) + ")"
		+ tr("DATING_AUTHORITY_BONUS_1") + str(authority)
		+ tr("DATING_AUTHORITY_BONUS_2")
		)

		person.add_stat("loyalty", loyalty)

	else:
		loyalty = 6 + master.get_stat('charm_factor') + person.get_stat('timid_factor') 
		text += (tr("DATING_FEARFUL_1")
		+ tr("DATING_OBEDIENCE_1") + str(obedience)
		+ tr("DATING_AUTHORITY_1") + str(authority) + tr("DATING_PHYSF_BONUS_1") + str(master.get_stat("physics_factor")*4)+")"
		+ tr("DATING_PHYSF_BONUS_2")
		)
#		person.add_stat("loyalty", loyalty)
	
#	person.add_stat("obedience", obedience)

	if person.get_stat('consent') >= 2:
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_sex_offer')) + tr("DATING_SEX_OFFER_1")
		sex_offer = true

	$end/sexbutton.visible = sex_offer && !person.has_status("no_sex")

	return globals.TextEncoder(person.translate(text))

func start_sex():
	ResourceScripts.core_animations.BlackScreenTransition(0.5)
	yield(get_tree().create_timer(0.5), 'timeout')
	self.hide()
	if gui_controller.sex_panel == null:
		gui_controller.sex_panel = input_handler.get_spec_node(input_handler.NODE_SEX)
	gui_controller.sex_panel.startsequence([master, person])
	gui_controller.sex_panel.raise()


func _on_finishbutton_pressed():
	gui_controller.windows_opened.clear()
	ResourceScripts.core_animations.BlackScreenTransition(0.5)
	yield(get_tree().create_timer(0.5), 'timeout')
	hide()
	gui_controller.current_screen = gui_controller.previous_screen
	gui_controller.current_screen.raise()
	gui_controller.current_screen.show()
	if gui_controller.current_screen == gui_controller.mansion:
		gui_controller.current_screen.mansion_state_set("default")
		gui_controller.clock.show()
		gui_controller.clock.raise()


func _on_cancelsex_pressed():
	gui_controller.windows_opened.clear()
	$sexswitch.visible = false

func _on_confirmsex_pressed():
	gui_controller.windows_opened.clear()
	if $sexswitch/cancelsex.visible == true:
		calculateresults()
	self.visible = false
	get_parent().sexmode = 'sex'
	get_parent().sexslaves = [person]
	get_parent()._on_startbutton_pressed()
	yield(get_parent(),'animfinished')
	get_parent().sexmode = 'meet'


var actionsdict = {
	chat = {
		group = 'Affection',
		name = tr("DATING_CHAT_1"),
		reqs = [],
		location = [],#empty = any
		descript = tr("DATING_CHAT_DESC_1"),
		effect = 'chat',
	},
	flirt = {
		group = 'Affection',
		name = tr("DATING_FLIRT_1"),
		descript = tr("DATING_FLIRT_DESC_1"),
		reqs = [],
		location = [],
		effect = 'flirt',
	},
	intimate = {
		group = 'Affection',
		name = tr("DATING_INTIMATE_1"),
		descript = tr("DATING_INTIMATE_DESC_1"),
		reqs = [],
		onetime = true,
		location = [],
		effect = 'intimate',
	},
	touch = {
		group = 'Affection',
		name = tr("DATING_TOUCH_1"),
		reqs = [],
		descript = tr("DATING_TOUCH_DESC_1"),
		location = [],
		effect = 'touch',
	},
	holdhands = {
		group = 'Affection',
		name = tr("DATING_HOLDHANDS_5"),
		descript = tr("DATING_HOLDHANDS_DESC_5"),
		reqs = [],
		location = ['garden','town','bedroom'],
		effect = 'holdhands',
	},
	praise = {
		group = 'Affection',
		name = tr("DATING_PRAISE_1"),
		descript = tr("DATING_PRAISE_DESC_1"),
		reqs = [],
		location = [],
		onetime = true,
		effect = 'praise',
	},
	pathead = {
		group = 'Affection',
		name = tr("DATING_PATHEAD_1"),
		descript = tr("DATING_PATHEAD_DESC_1"),
		reqs = [],
		location = [],
		effect = 'pathead',
	},
	combhair = {
		group = 'Affection',
		name = tr("DATING_COMBHAIR_1"),
		descript = tr("DATING_COMBHAIR_DESC_1"),
		reqs = [{code = 'hair_length', value = ['bald'], check = false}],
		location = [],
		effect = 'combhair',
	},
	hug = {
		group = 'Affection',
		name = tr("DATING_HUG_1"),
		descript = tr("DATING_HUG_DESC_1"),
		reqs = [],
		location = [],
		effect = 'hug',
	},
	kiss = {
		group = 'Affection',
		name = tr("DATING_KISS_6"),
		descript = tr("DATING_KISS_DESC_6"),
		onetime = true,
		reqs = [],
		location = [],
		effect = 'kiss',
	},
	rubears = {
		group = 'Affection',
		name = tr("DATING_RUBEARS_1"),
		descript = tr("DATING_RUBEARS_DESC_1"),
		reqs = [{code = 'long_ears', check = true}],
		location = [],
		effect = 'rubears',
	},
	stroketail = {
		group = 'Affection',
		name = tr("DATING_STROKETAIL_1"),
		descript = tr("DATING_STROKETAIL_DESC_1"),
		reqs = [{code = 'long_tail', check = true}],
		location = [],
		effect = 'stroketail',
	},
	ask_to_marry = {
		group = 'Affection',
		name = tr("DATING_ASK_TO_MARRY_1"),
		descript = tr("DATING_ASK_TO_MARRY_DESC_1"),
		reqs = [{code = 'master_is_marrried', value = false}],
		onetime = true,
		location = [],
		effect = 'ask_to_marry',
		
	},
	

#	frenchkiss = {
#		group = 'Affection',
#		name = 'French Kiss',
#		descript = "Kiss [name] in an erotic manner",
#		reqs = [],
#		location = [],
#		effect = 'frenchkiss',
#	},
#	pushdown = {
#		group = 'Affection',
#		name = 'Push down',
#		descript = "Force yourself on [name]",
#		reqs = [],
#		location = [],
#		effect = 'pushdown',
#	},
	propose = {
		group = 'Affection',
		name = tr("DATING_PROPOSE_1"),
		descript = tr("DATING_PROPOSE_DESC_1"),
		reqs = [{code = 'stat', stat = 'consent', operant = 'lt', value = 3}, {code = 'stat', stat = 'was_proposed', operant = 'eq', value = false}],
		location = ['bedroom'],
		effect = 'propose',
	},

	scold = {
		group = 'Discipline',
		name = tr("DATING_SCOLD"),
		descript = tr("DATING_SCOLD_DESC_1"),
		reqs = [],
		location = [],
		effect = 'scold',
	},
	slap = {
		group = 'Discipline',
		name = tr("DATING_SLAP"),
		descript = tr("DATING_SLAP_DESC_1"),
		reqs = [],
		location = [],
		effect = 'slap',
	},
	pullear = {
		group = 'Discipline',
		name = tr("DATING_PULLEAR"),
		descript = tr("DATING_PULLEAR_DESC_1"),
		reqs = [],
		location = [],
		effect = 'pullear',
	},
	pulltail = {
		group = 'Discipline',
		name = tr("DATING_PULLTAIL"),
		descript = tr("DATING_PULLTAIL_DESC_1"),
		reqs = [{code = 'bodypart', part = 'tail', operant = 'neq', value = ''}],
		location = [],
		effect = 'pulltail',
	},
	flag = {
		group = 'Discipline',
		name = tr("DATING_FLAG"),
		descript = tr("DATING_FLAG_DESC_1"),
		reqs = [],
		location = ['dungeon'],
		effect = 'flag',
	},
	whip = {
		group = 'Discipline',
		name = tr("DATING_WHIP"),
		descript = tr("DATING_WHIP_DESC_1"),
		reqs = [],
		location = ['dungeon'],
		effect = 'whip',
	},
	wax = {
		group = 'Discipline',
		name = tr("DATING_WAX"),
		descript = tr("DATING_WAX_DESC_1"),
		reqs = [],
		location = ['dungeon'],
		effect = 'wax',
	},
	horse = {
		group = 'Discipline',
		name = tr("DATING_HORSE"),
		descript = tr("DATING_HORSE_DESC_1"),
		reqs = [],
		location = ['dungeon'],
		effect = 'horse',
	},
	public = {
		group = 'Discipline',
		name = tr("DATING_PUBLIC"),
		descript = tr("DATING_PUBLIC_DESC_1"),
		reqs = [],
		date_reqs = [],
		location = ['dungeon'],
		#reqs = "location == 'dungeon' && public == false",
		effect = 'public',
	},
#	publicpunishoff = {
#		group = 'Discipline',
#		name = 'Disperse others',
#		descript = "Make other slaves leave and not observe [name]'s punishments. Does not cost Time.",
#		reqs = [],
#		date_reqs = [],
#		location = ['dungeon'],
#		#reqs = "location == 'dungeon' && public == true",
#		effect = 'public',
#	},
#	castfear = {
#		group = 'Discipline',
#		name = 'Cast Fear',
#		descript = "Punish [name] with Fear spell. \n[color=aqua]Costs " + str(globals.spells.spellcost(globals.spelldict.fear)) + " mana.[/color]",
#		reqs = "globals.spelldict.fear.learned == true && globals.resources.mana >= globals.spells.spellcost(globals.spelldict.fear)",
#		effect = 'castfear',
#	},
#	castsedate = {
#		group = 'Discipline',
#		name = 'Cast Sedation',
#		descript = "Use Sedation spell on [name]. \n[color=aqua]Costs " + str(globals.spells.spellcost(globals.spelldict.sedation)) + " mana.[/color]",
#		reqs = "globals.spelldict.sedation.learned == true && globals.resources.mana >= globals.spells.spellcost(globals.spelldict.sedation)",
#		effect = 'castsedate',
#	},

	gift = {
		group = "Items",
		name = tr("DATING_GIFT"),
		descript = tr("DATING_GIFT_DESC_1"),
		reqs = [],
		#reqs = "!location == 'dungeon'",
		disablereqs = 'globals.resources.gold >= 10',
		location = [],
		effect = 'gift',
		onetime = true,
	},
	sweets = {
		group = "Items",
		name = tr("DATING_SWEETS"),
		descript = tr("DATING_SWEETS_DESC_1"),
		reqs = [],
		#reqs = "location == 'town'",
		disablereqs = 'globals.resources.gold >= 5',
		location = ['town'],
		effect = 'sweets',
		onetime = true,
	},
	tea = {
		group = "Items",
		name = tr("DATING_TEA"),
		descript = tr("DATING_TEA_DESC_1"),
		reqs = [],
		location = ['livingroom','bedroom'],
		#reqs = 'location in ["livingroom","bedroom"]',
		disablereqs = 'globals.itemdict.supply.amount >= 1',
		effect = 'tea',
	},
	wine = {
		group = "Items",
		name = tr("DATING_WINE"),
		descript = tr("DATING_WINE_DESC_1"),
		reqs = [],
		location = ['livingroom','bedroom','garden','town'],
		#reqs = 'location in ["livingroom","bedroom","garden","town"]',
		disablereqs = 'globals.itemdict.supply.amount >= 2',
		effect = 'wine',
	},

	train = {
		group = 'Training',
		name = tr("DATING_TRAIN"),
		reqs = [],
		location = [],
		descript = tr("DATING_TRAIN_DESC_1"),
		effect = 'train',
	},
	study = {
		group = 'Training',
		name = tr("DATING_STUDY"),
		reqs = [],
		location = [],
		descript = tr("DATING_STUDY_DESC_1"),
		effect = 'study',
	},
	practice_charm = {
		group = 'Training',
		name = tr("DATING_PRACTICE_CHARM"),
		reqs = [],
		location = [],
		descript = tr("DATING_PRACTICE_CHARM_DESC_1"),
		effect = 'charm',
	},
	useitem = {
		group = "Affection",
		name = tr("DATING_USE_ITEM"),
		descript = tr("DATING_USE_ITEM_DESC_1"),
		reqs = [],
		location = [],
		effect = 'useitem',
	},

	food = {
		group = "Affection",
		name = tr("DATING_FOOD"),
		descript = tr("DATING_FOOD_DESC_1"),
		reqs = [],
		location = [],
		effect = 'food',
		#onetime = true,
	},

	stop = {
		group = "any",
		name = tr("DATING_STOP"),
		descript = tr("DATING_STOP_DESC_1"),
		reqs = [],
		location = [],
		effect = 'stop',
	},
}
