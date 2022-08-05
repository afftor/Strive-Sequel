extends Control

#mood & fear - dating only stats, they increase and reduce from actions (start at 0)
#authority & consent - increase directly from some actions (punishments/intimacy)
#loyalty/submission get buff

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
	livingroom = {code = 'livingroom',name = 'Living Room', background = 'mansion'},
	bedroom = {code = 'bedroom',name = 'Bedroom', background = 'mansion'},
	dungeon = {code = 'dungeon',name = 'Torture Room', background = 'dungeon'},
	garden = {code = 'garden',name = 'Garden', background = 'garden'},
	town = {code = 'town',name = 'Streets', background = 'aliron'},
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
	self.authStart = tempperson.get_stat('authority')
	self.consStart = tempperson.get_stat('consent')
	self.finish_encounter = false
	date = false
	public = false
	observing_slaves.clear()
	$sexswitch.visible = false
	$end.visible = false
	$textfield/RichTextLabel.clear()
	location_changed = false
	$background.texture = images.backgrounds.mansion



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
	$fullbody.set_texture(null)
	if person.get_body_image() != null:
#		var image = person.get_body_image()
#		if images.sprites.has(person.get_stat("unique")):
#			image = images.sprites[person.get_stat("unique")]
#			pass #print(image.get_path())
		var image
		var non_body = person.statlist.statlist.body_image.replace("_body", "")
		if images.sprites.has(non_body):
			image = input_handler.loadimage(images.sprites[non_body], 'shades')
		else:
			image = person.get_body_image()
		$fullbody.set_texture(image)
	# $textfield/slaveportrait.texture = null

	if person.get_icon_small() != null:
		$textfield/slaveportrait/TextureRect.set_texture(person.get_icon_small())
	else:
		$textfield/slaveportrait/TextureRect.set_texture(null)
	$textfield/slaveportrait/Name.text = person.get_short_name()
	$textfield/masterportrait/Name.text = master.get_short_name()
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
		text = "You visit [name2] in [his2] cell and decide to spend some time with [him2]. "
		$panel/categories/Location.disabled = true
	else:
		$panel/categories/Location.disabled = false
		location = 'livingroom'
		text = "You meet {^[name2]:[race2] [boy2]} and order [him2] to keep you company. "
		if person.has_temp_effect('resist_state'):
			text += "[he2] reluctantly follows you having no other choice, still sore from [his2] encapture."
			text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_start_angry')) + "\n"
		elif person.get_stat('loyalty_total') >= 35:
			text += "[he2] gladly accepts your order and is ready to follow you anywhere you take [him2]. "
			self.mood += 10
			text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_start_happy')) + "\n"
		elif person.get_stat('obedience') >= 40:
			self.mood += 4
			text += "[he2] obediently agrees to your order and tries [his2] best to please you. "
			text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_start')) + "\n"
		else:

			text += "Without great joy [he2] obeys your order and reluctantly joins you. "
			text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_start')) + "\n"


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
				text += globals.TextEncoder("\n{color=yellow|Sexuality: [name] does not seem to be enthusiastic in having relationship with you. Mood required for positive response is increased.}")
			globals.connecttexttooltip(newnode, person.translate(text))
			if i.has('disablereqs'):
				newnode.disabled = true

	$panel/ScrollContainer/GridContainer.move_child($panel/ScrollContainer/GridContainer/Button, $panel/ScrollContainer/GridContainer.get_children().size())
	var text = "Consent: " + str(floor(person.get_stat("consent")))  #"Authority: " + str(floor(person.get_stat('authority'))) + "("  + str(person.authority_threshold()) + ")" + ",

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
	$background.texture = images.backgrounds[locationdicts[newloc].background]
	self.showntext = 'You lead {^[name2]:[race2] [boy2]} to the [color=yellow]' + locationdicts[location].name + '[/color]. '


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
				self.showntext += decoder("\n\n[color=yellow]Location influence:[/color] [name2] finds this place to be rather peaceful, [his2] mood improves.")
			elif location == 'town' && person.get_stat('personality') == 'bold':
				self.mood += 4
				self.showntext += decoder("\n\n[color=yellow]Location influence:[/color] [name2] finds this place to be rather joyful, [his2] mood improves")
			elif location == 'dungeon':
				self.fear += 3
				self.showntext += decoder("\n\n[color=yellow]Location influence:[/color] [name2] finds this place to be rather grim, [his2] fear grows.")
	if turn <= 0:
		finish_encounter = true
		self.showntext += "\n\nYou have no more time left."
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
		["You attempt to initiate a friendly chat with {^[name2]:[race2] [boy2]}. ", 1],
		["You {^innocently:casually:friendly} {^discuss mundane thigns:chat} with {^[name2]:[race2] [boy2]}. ", 3],
		["You make a small talk to {^[name2]:[race2] [boy2]}. ",1],
		["You and [name2] discuss the weather. ",1],
	],
	chat_positive = [
		["{^[name2]:[race2] [boy2]:[he2]} spends some time engaging in a friendly chat with you. ",1],
		["{^[name2]:[race2] [boy2]:[he2]} responds to you in a friendly manner. ",1],
	],
	chat_negative = [
		["{^[name2]:[race2] [boy2]:[he2]} replies, but does so reluctantly.",1],
		["{^[name2]:[race2] [boy2]:[he2]} shows little interest in further chatting. ",1],
	],
	flirt_start = [
		["You casually flirt with {^[name2]:[race2] [boy2]}.", 1],
		["You start a lewd talk with {^[name2]:[race2] [boy2]}.", 1],
		["You ask {^[name2]:[race2] [boy2]} about [his2] fantasies.", 1],
	],
	flirt_positive = [
		["{^[name2]:[race2] [boy2]:[he2]} responds to you positively. ", 1],
		["{^[name2]:[race2] [boy2]:[he2]} gives you a playful look. ", 1],
		["{^[name2]:[race2] [boy2]:[he2]} moves slightly closer to you. ", 1],
	],
	flirt_negative = [
		["{^[name2]:[race2] [boy2]:[he2]} stays silent, showing [his2] disdain.", 1],
		["{^[name2]:[race2] [boy2]:[he2]} gives you a stern look. ", 1],
		["{^[name2]:[race2] [boy2]:[he2]} moves away from you. ", 1],
	],

	touch_start = [
		["You {^casually:lightly} touch {^[name2]:[race2] [boy2]}.", 1],
	],
	touch_positive = [
		["{^[name2]:[race2] [boy2]:[he2]} reacts relaxingly to your affection. ", 1],
	],
	touch_negative = [
		["{^[name2]:[race2] [boy2]:[he2]} looks bored and reacts coldly.", 1],
	],
	combhair_start = [
		["You {^gently:slowly} comb {^[name2]:[race2] [boy2]}'s {^[hairlength]:}{^[haircolor]:}hair.", 1],
	],
	combhair_positive = [
		["{^[name2]:[race2] [boy2]} reacts relaxingly to your affection. ", 1],
	],
	combhair_negative = [
		["{^[name2]:[race2] [boy2]} looks bored and reacts coldly.", 1],
	],



	hug_start_samesize = [
		["You give {^[name2]:[race2] [boy2]} a friendly hug.", 1],
		["You hug {^[name2]:[race2] [boy2]} in a friendly manner.", 1],
		["You embrace {^[name2]:[race2] [boy2]} in your arms.", 1],
	],
	hug_start_bigsize = [
		["You {^hug:embrace} {^[name2]:[race2] [boy2]}'s small body.", 1],
		["You lean down and {^hug:embrace} {^[name2]:[race2] [boy2]}.", 1],
	],
	hug_start_smallsize = [
		["You make {^[name2]:[race2] [boy2]} to lean down and give [him2] a hug.", 1],
	],
	hug_positive_samesize = [
		["{^[name2]:[race2] [boy2]} {^hugs:embraces} you back {^putting:resting} [his2] head on your shoulder.", 1],
		["{^[name2]:[race2] [boy2]} accepts your {^hug:embrace} and smiles warmly.", 1],
	],
	hug_positive_bigsize = [
		["{^[name2]:[race2] [boy2]} {^hugs:embraces} you back {^putting:resting} [his2] head on your chest.", 1],
		["{^[name2]:[race2] [boy2]} feels {^overwhelmed:stunned} by your size and hugs you back. ", 0.5],
	],
	hug_positive_smallsize = [
		["{^[name2]:[race2] [boy2]} is moved by your action and {^hugs:embraces} you back.", 1],
		["{^[name2]:[race2] [boy2]} awkwardly hugs you back due to your size.", 0.5],
	],
	hug_negative = [
		["{^[name2]:[race2] [boy2]} does not do anything waiting uncomfortably for you to finish.", 1],
	],

	kiss_start = [
		["You {^slowly :}{^lean:tilt:bend} to {^[name2]:[race2] [boy2]}'s face.",1],
	],
	kiss_positive = [
		["{^[name2]:[race2] [boy2]} {^tenderly:softly} kisses you back.",1],
		["{^[name2]:[race2] [boy2]} returns your kiss{^ while closing [his2] eyes:}.",1],
	],
	kiss_erotic = [
		["{^[name2]:[race2] [boy2]} {^eagerly:passionately:lewdly} pushes [his2] tongue into your mouth. You spend some time {^embracing:hugging} {^together:each other}. Finally [name2] pulls away with a {^happy:satisfied} smile. ",1],
	],
	kiss_erotic_puclic = ["{^[name2]:[race2] [boy2]} {^eagerly:passionately:lewdly} pushes [his2] tongue into your mouth. You spend some time {^embracing:hugging} {^together:each other}, ignoring {^gawking:ogling} {^people:crowd}. Finally [name2] pulls away with a {^happy:satisfied} smile. ",1],
	kiss_negative = [
		["[he2] uncomfortably {^turns:looks} away accepting your {^kiss:smooch} on the cheeck.",1],
		["[he2] {^embarrassingly:awkwardly} moves away preventing your attempt.",1]
	],
	
	marry_initiate = [
		["You bow before [name2] and propose to marry [him2]",1]
	],
	
	marry_same_sex = [
		["{^[name2]:[race2] [boy2]} instantly points out that's not possible to marry someone of same sex in current customs.",1]
		
	],
	agreed_to_marry_prev = [
		["{^[name2]:[race2] [boy2]} looks at you slightly puzzled. [He2] already agreed to this before.",1],
	],
	agreed_to_marry = [
		["{^[name2]:[race2] [boy2]} face reddens and shines up upon hearing your words.",1],
	],
	refused_to_marry = [
		["{^[name2]:[race2] [boy2]:[he2]} hastily abrupts you.",1],
	],
	propose_initiate = [
		["You ask {^[name2]:[race2] [boy2]} if [he2] would like to take your relationship to the next level. ",1]
		],
	propose_had_sex_before = [
		["{^[name2]:[race2] [boy2]:[he2]} looks at you sligtly puzzled, as you've already were having sex before and quickly agrees.",1]
		],
	propose_was_forced_before = [
		["{^[name2]:[race2] [boy2]:[he2]} looks at you with a sign of {^scorn:contempt}, as you've already {^made:forced} [him2] to have sex against [his2] will before. After a sigh [he2] gives you [his2] verbal agreement. ",1]
	],

	propose_already_reached_consent = [
		["{^[name2]:[race2] [boy2]:[he2]} responds without second thought it if already made [his2] mind about this.",1],
		["{^[name2]:[race2] [boy2]:[he2]} quickly agrees to your propose. It seems [he2] has already set up [his2] mind on this.",1]
		],

	propose_reject = [
		["{^[name2]:[race2] [boy2]:[he2]} {^denies:rejects} your proposal{^ with a troubled face:}.",1]
	],
	propose_accept = [
		["{^[name2]:[race2] [boy2]:[he2]} happily {^agrees:conrurs} to your {^request:proposal}.",1],
		["After a moment {^[name2]:[race2] [boy2]:[he2]} {^agrees:concurs} to your {^request:proposal}.",1]
	],

	praise_initiate = [
		["You praise {^[name2]:[race2] [boy2]:[he2]}'s efforts. ",1],
		["You {^proclaim:express} your gratitude to {^[name2]:[race2] [boy2]:[he2]}. ",1],
		["You praise {^[name2]:[race2] [boy2]:[he2]} for [his2] recent behavoir. ",1]
		],
	praise_accept = [
		["{^[name2]:[race2] [boy2]:[he2]} listens to your praise with a joy evident on [his2] face. ",1]
		],
	praise_resist = [
		["{^[name2]:[race2] [boy2]:[he2]} does not show any signs of accepting your praise.",1]
		],

	pathead_initiate = [
		["You {^casually:lightly} {^pat:stroke} {^[name2]:[race2] [boy2]}'s head.", 1],
	],

	pathead_accept = [
		["{^[name2]:[race2] [boy2]:[he2]} smiles back at you.", 1],
		["{^[name2]:[race2] [boy2]:[he2]} embarrassingly {^shies:looks} away.", 1],
		["{^[name2]:[race2] [boy2]:[he2]} takes it with joy evident on [his2] face.", 1],
	],
	pathead_resist = [
		["{^[name2]:[race2] [boy2]:[he2]} gives you a disapproving {^glance:look}.", 1],
		["{^[name2]:[race2] [boy2]:[he2]} seems to be offended by your gesture.", 1],
	],

	scold_initiate = [
		["You scold {^[name2]:[race2] [boy2]} for [his2] recent faults. ",1]
	],
	scold_accept = [
		["{^[name2]:[race2] [boy2]:[he2]} {^nods:looks down} in {^submission:acceptance}.", 1],
	],
	scold_resist = [
		["{^[name2]:[race2] [boy2]:[he2]} give you an annoyed look.", 1],
	],

	rubears_initiate = [
		["You {^affectionately:tenderly} {^stroke:rub:pat} {^[name2]:[race2] [boy2]} behind [his2] [earadj]ears.", 1],
		["You {^affectionately:tenderly} {^stroke:rub:pat} {^[name2]:[race2] [boy2]} on [his2] [earadj]ears, moving down to [his2] {^[haircolor]:[hairlength]} hair.", 1],
	],
	rubears_accept = [
		["{^[name2]:[race2] [boy2]:[he2]} seems {^pleased with it:to enjoy it}, as [his2] [earadj]ears {^joyfully:playfully} twitch.", 1],
	],
	rubears_resist = [
		["{^[name2]:[race2] [boy2]:[he2]} {^looks:seems} {^annoyed:unpleased} by this{^.: and waits for it to over.}", 1],
	],
	stroketail_initiate = [
		["You {^gently:affectionately} {^stroke:run your hand over} {^[name2]:[race2] [boy2]}'s [tailadj]tail.", 1],
	],
	stroketail_accept = [
		["{^[name2]:[race2] [boy2]:[he2]} seems {^pleased with it:to enjoy it}, as [his2] [tailadj]tail {^joyfully:playfully} wags.", 1],
		["{^[name2]:[race2] [boy2]:[he2]} {^twitches:jerks} {^in surprise:for a moment}, but then accepts your {^petting:caress:pumper}.", 1],
	],
	stroketail_resist = [
		["{^[name2]:[race2] [boy2]:[he2]} {^looks:seems} {^agitated:annoyed} by this{^.: and waits until you finish.}", 1],
	],
	pullear_initiate = [
		["You forcefully {^yank:stretch} {^[name2]:[race2] [boy2]}'s [earadj]ear making [him2] {^wince:let out a pleading cry}. ", 1],
	],
	pullear_accept = [
		["Despite intense pain, {^[name2]:[race2] [boy2]:[he2]} stoically endures your abuse.", 1],
	],
	pullear_resist = [
		["{^[name2]:[race2] [boy2]:[he2]} looks {^mad:angry} and tries to break free.", 1],
		["{^[name2]:[race2] [boy2]:[he2]} {^whines:cries} in protest{^:, begging for mercy}.", 1],
	],
	pulltail_initiate = [
		["You forcefully {^yank:stretch} {^[name2]:[race2] [boy2]}{^'s: by [his2]} [tailadj]tail making [him2] {^wince:let out a pleading cry}. ", 1],
	],
	pulltail_accept = [
		["Despite intense pain, {^[name2]:[race2] [boy2]:[he2]} stoically endures your abuse.", 1],
	],
	pulltail_resist = [
		["{^[name2]:[race2] [boy2]:[he2]} looks {^mad:angry} and tries to break free.", 1],
		["{^[name2]:[race2] [boy2]:[he2]} {^whines:cries} in protest{^:, begging for mercy}.", 1],
	],
	slap_initiate = [
		["You slap {^[name2]:[race2] [boy2]} across the face{: leaving a mark on [his2] cheek}. ", 1],
	],
	slap_accept = [
		["Despite intense pain, {^[name2]:[race2] [boy2]:[he2]} stoically endures your abuse.", 1],
	],
	slap_resist = [
		["{^[name2]:[race2] [boy2]:[he2]} looks {^mad:very agited}.", 1],
	],


	food_initiate = [
		["You offer {^[name2]:[race2] [boy2]:[he2]} a treat of [food].",1],
	],
	food_resist = [
		['{^[name2]:[race2] [boy2]:[he2]} rejects your offer demonstrating [his2] resistance.',1]
	],
	food_liked = [
		["{^[name2]:[race2] [boy2]:[he2]} accepts it with enthusiasm and thanks you. ",1]
	],
	food_hated = [
		["{^[name2]:[race2] [boy2]:[he2]} gives you a disdain look. ",1]
	],
	food_netural = [
		["{^[name2]:[race2] [boy2]:[he2]} accepts it respectfully, but does not show much of a joy.",1]
	],

}

var descripts = {
	hairlength = {func = 'hairlength_descripts', stat = 'hair_length'},
	earadj = {func = 'ears_descripts', stat = 'ears'},
	tailadj = {func = 'tail_descripts', stat = 'tail'},
}

func character_description(text_input):
	var text = text_input
	var temptext = ''

	text = text.replace('[haircolor]', tr(person.get_stat('hair_color'))+" ")
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
	var text = 'You {^cautiously:mindfully} ask [name2] about [his2] preferences in bed.'

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
			text += "\n\n{color=green|[name2] opens up to you and you learn a bit about [his2] preferences. "
			text += "\nYou have learned that [name2] possess a sex trait: " + Traitdata.sex_traits[unlocking_trait].name
			text += "}"
		else:
			text += "\n\n{color=green|[name2] opens up to you but you don't learn anything new about [him2]. "
			text += "}"
	else:
		text += "{color=red|You've failed to get [name2] into a mood to talk about [his2] sexual preferences}"
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
		text += "You take [name2]'s hand into yours as you stroll around. "
	else:
		text += "You take [name2]'s hand into yours and move closer. "
	if 8 - counter > 3 && self.mood >= 5:
		text += "[he2] holds your hand firmly. "
		self.mood += 8 - counter
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		self.mood -= 2
		text += "[he2] holds your hand, but looks reclusive. "

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
			text += " {^[name2]:[race2] [boy2]:[he2]} blushes and looks away. "
		else:
			text += " {^[name2]:[race2] [boy2]:[he2]} giggles looking at you. "

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
				text += "{^[name2]:[race2] [boy2]:[he2]} smiles and looks at you with bedroom eyes."
			'shy':
				text += "{^[name2]:[race2] [boy2]:[he2]} looks slightly embarrassed, realizing what [he2] just did and looks away."
			'bold':
				text += "{^[name2]:[race2] [boy2]:[he2]} giggles in satisfaction{^:, grabbing your arm}. "

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

	if person.get_stat('consent') >= 25:
		gave_consent = true
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.propose_already_reached_consent)
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_proposal_agree')) + "\n"


	if gave_consent == false:
		var difficulty =  self.mood * 2 + drunkness * 6
		if person.has_status('sex_basic'): difficulty += 40
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
			person.set_stat('consent', max(25, person.get_stat('consent')))
			person.set_stat('was_proposed',true)

		return text

var sexmode

var unique_marry_rules = {
	aire = {
		ana_alive = {
			reqs = [],
			text = "Regardless of my feelings towards you, I can't agree to it. You must marry Ana, not me.",
			agrees = false
			},
		ana_dead = {
			reqs = [],
			text = "Don't waste your time. I will never agree to this after what happened to Ana.",
			agrees = false
			},
		
	}
		
}

func ask_to_marry(person, counter):
	var text = ''

	var gave_consent = false
	
	if is_same_sex():
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
	
	if person.has_status('swear_loyalty'):
		if unique_marry_rules.has(person.get_stat('unique')):
			for i in unique_marry_rules[person.get_stat('unique')]:
				if globals.valuecheck(i.reqs):
					gave_consent = i.agrees
					if gave_consent:
						text += "{color=green|"
						text += input_handler.weightedrandom(date_lines.agreed_to_marry)
					else:
						
						text += "{color=red|"
						text += input_handler.weightedrandom(date_lines.refused_to_marry)
					text += "}"
						
					break
		else:
			gave_consent = true
	
		
	if gave_consent:
		person.set_stat('agreed_to_marry', true)
		self.mood += 50
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.agreed_to_marry)
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'marry_proposal_agree')) 
	else:
		text += "{color=red|"
		text += input_handler.weightedrandom(date_lines.refused_to_marry)
		text += "}"
		self.mood -= 25
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'marry_proposal_refuse'))
	
	return text


func praise(person, counter):
	var text = input_handler.weightedrandom(date_lines.praise_initiate) + "\n\n"

	if person.has_temp_effect('resist_state') == false:
		self.mood += 15
		person.add_stat('obedience', 50)
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

	if person.has_temp_effect('resist_state') == false && person.get_stat('loyalty_total') >= 50 && 8 - counter > 3:
		self.mood += 8 - counter
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.rubears_accept)
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		self.mood -= 2
		text += "{color=red|"
		text += input_handler.weightedrandom(date_lines.rubears_resist)
		text += "}"
	return character_description(text)

func stroketail(person, counter):
	var text = input_handler.weightedrandom(date_lines.stroketail_initiate) + "\n\n"

	if person.has_temp_effect('resist_state') == false && person.get_stat('loyalty_total') >= 65 && 11 - counter*1.5 > 2:
		self.mood += 11 - counter*1.5
		text += "{color=green|"
		text += input_handler.weightedrandom(date_lines.stroketail_accept)
		text += "}"
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		self.mood -= 3
		text += "{color=red|"
		text += input_handler.weightedrandom(date_lines.stroketail_resist)
		text += "}"
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
		text += "[Masochist][name2] seems to take [his2] punishment with an uncommon enthusiasm... "
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
		text += "[/color] watch over [name2]'s humiliation in awe. "


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
	text += "You slap [name2] across the face as punishment. [his2] cheek gets red. "

	var value = {mood = -3, fear = 12-counter, action = 'slap'}
	text += punish_process(value)
	return text

func flag(person, counter):
	var text = ''
	text += "You put [name2] on the punishment table, and after exposing [his2] rear, punish it with force. "

	var value = {mood = -5, fear = 16-counter, action = 'flag'}

	text += punish_process(value)
	return text

func whip(person, counter):
	var text = ''
	text += "You put [name2] on the punishment table, and after exposing [his2] rear, whip it with force. "


	var value = {mood = -5, fear = 20-counter, action = 'whip'}
	text += punish_process(value)
	return text

func horse(person, counter):
	var text = ''
	text += "You tie [name2] securely to the wooden horse with [his2] legs spread wide. [he2] cries with pain under [his2] own weight. "


	var value = {mood = -5, fear = 20-counter, action = 'horse'}
	text += punish_process(value)

	return text

func wax(person, counter):
	var text = ''
	text += "You put [name2] on the punishment table and after exposing [his2] body you drip hot wax over it making [him2] cry with pain. "

	var value = {mood = -5, fear = 18-counter, action = 'wax'}

	text += punish_process(value)

	return text

func train(person, counter):
	var text = ''
	var value = person.get_stat('physics_factor') * (turn/4.0)
	var value2 = master.get_stat('physics_factor') * (turn/4.0)


	text += ("You spend some time training with [name2], improving your Physics. \n"
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

	text += ("You spend some time studying with [name2], improving your Wits. \n"
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

	text += ("You spend some time practicing with [name2], improving your Charm. \n"
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
			text = "You bring everyone into torture room and make them watch over [name2]'s disgrace. "
			text += "\n\n[color=yellow]"
			var array = []
			for i in observing_slaves:
				array.append(i.get_short_name())
			text += input_handler.text_form_recitation(array)
			text += "[/color] come over to observe [name2]'s punishment.\n"
			public = true
			text += "{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_public')) + "\n"
			for i in observing_slaves:
				var temptext = i.translate(input_handler.get_random_chat_line(i, 'date_public_observe'))
				temptext = person.translate(temptext.replace('[2','['))
				text += "\n{color=yellow|" + i.get_short_name() + "}: " + temptext

		else:
			text += "\n\nYou wanted to bring everyone available to watch over [name2]'s humiliation, but nobody besides you is aroud."
	else:
		text = "You order everyone to get back to their business leaving you and [name2] alone. "
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
	text += "You present [name2] with a bottle of whiskey. "
	if self.mood < 15 || person.get_stat('authority') < 10:
		text += 'However, [he2] refuses to drink in your company. '
	else:
		text += "[he2] accepts your invitation and you slowly consume it, as [his2] mood improve. You notice that [he2] gets tipsy and feels at ease with you. "
		self.mood += 15
		#person.add_stat('authority', 11)
		#person.add_stat('consent', 2)

		drunkness += 3
		ResourceScripts.game_res.remove_item('alcohol',1)

	self.showntext = globals.TextEncoder(decoder(text))
	drunkness()
	updatelist()

func beer(person):
	var text = ''
	text += "You present [name2] with a serving of beer. "
	if self.mood < 5:
		text += 'However, [he2] refuses to drink in your company. '
	else:
		text += "[he2] accepts your invitation and you casually drink together, as [his2] mood improve. You notice that [he2] gets tipsy and feels at ease with you. "
		self.mood += 10
		#person.add_stat('authority', 5)
		#person.add_stat('consent', 3)

		drunkness += 1
		ResourceScripts.game_res.remove_item('beer',1)

	self.showntext = globals.TextEncoder(decoder(text))
	drunkness()
	updatelist()



func drunkness():
	var capacity = variables.slave_heights.find(person.get_stat('height'))
	if drunkness > capacity + 3:
		endencounter()
		$end/RichTextLabel.bbcode_text += decoder('\n\n[color=yellow][name2] has passed out from alcohol overdose. [/color]')

func strChange(value):
	if value > 0:
		return "+" + str(round(value))
	else:
		return str(round(value))

func calculateresults():
	var sex_offer = false
	var endmood = floor(self.mood)
	var endfear = floor(self.fear)

	var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table['date_bonus'])
	person.apply_effect(effects_pool.add_effect(eff))
	var obedience = 100
	var authority = 0
	var consent = 0
	var loyalty = 0
	var text = ('Encounter Ended.'
	+ "\nMood: " + str(endmood)
	+ "\nFear: " + str(endfear)
	)
#	+ "\nLoyalty Gained: +" + str(loyal_bonus)

#	+ "\nConsent Gained: " + str(floor(person.get_stat('consent')-self.consStart))
	#+ "\nAuthority Gained: " + str(floor(person.get_stat("authority") - self.authStart))
	if endmood >= endfear:
#		loyalty = ceil(endmood/4) + max(0,(master.get_stat('charm_factor')) - 3) * 5
		loyalty = 6 + master.get_stat('charm_factor') * 2 +  person.get_stat('tame_factor') * 2
		consent = master.get_stat("sexuals_factor")*4
		text += ("\n\n{color=green|Positive Mood}: "
		+ "\nLoyalty: +" + str(loyalty) + " ([Master]'s Charm Factor Bonus: +" + str( max(0,(master.get_stat('charm_factor')) - 3) * 5) + ")"
		+ "\nConsent: +" + str(consent) + " ([Master]'s Sex Factor: " + str(master.get_stat("sexuals_factor"))+")"
		+ "\nAuthority: +" + str(authority)
		+ "\n\nSatisfied by the time together, you and [name] grow closer."
		)

		person.add_stat("loyalty", loyalty)
		person.add_stat("consent", consent)

	else:
		loyalty = 6 + master.get_stat('charm_factor') + person.get_stat('timid_factor') 
		text += ("\n\n{color=red|Fearful Mood}: "
		+ "\nObedience: +" + str(obedience)
		+ "\nAuthority: +" + str(authority) + " ([Master]'s Physics Factor Bonus: +" + str(master.get_stat("physics_factor")*4)+")"
		+ "\n\nWhile this was an unpleasant expirience for [name], it will certainly teach [him] to be afraid of your anger."
		)
		person.add_stat("loyalty", loyalty)
	
	person.add_stat("obedience", obedience)

	if person.get_stat('consent') >= 30 or (person.has_status('sex_basic') and  person.get_stat('consent')*2 > 110 - 75):
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_sex_offer')) + "\n\n{color=green|It seems [name] does not mind to continue this encounter...}"
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
		name = 'Chat',
		reqs = [],
		location = [],#empty = any
		descript = 'Have a friendly chat. Will boost Mood slightly.',
		effect = 'chat',
	},
	flirt = {
		group = 'Affection',
		name = 'Flirt',
		descript = 'Flirt with [name]. Will slightly improve Consent if Mood is high. Slightly increases Consent if mood is above low.',
		reqs = [],
		location = [],
		effect = 'flirt',
	},
	intimate = {
		group = 'Affection',
		name = 'Intimate Talk',
		descript = "Have an intimate talk in attempt to learn more about [name]'s preferences. Can only be used once.",
		reqs = [],
		onetime = true,
		location = [],
		effect = 'intimate',
	},
	touch = {
		group = 'Affection',
		name = 'Touch',
		reqs = [],
		descript = 'Light physical contact',
		location = [],
		effect = 'touch',
	},
	holdhands = {
		group = 'Affection',
		name = 'Hold hands',
		descript = "Take [name]'s hand into yours",
		reqs = [],
		location = ['garden','town','bedroom'],
		effect = 'holdhands',
	},
	praise = {
		group = 'Affection',
		name = 'Praise',
		descript = "Praise [name] for [his] previous success to encourage further good behavior. Can only be used once.",
		reqs = [],
		location = [],
		onetime = true,
		effect = 'praise',
	},
	pathead = {
		group = 'Affection',
		name = 'Pat head',
		descript = "Praise [name] and pat [his] head for [his] previous success to encourage further good behavior",
		reqs = [],
		location = [],
		effect = 'pathead',
	},
	combhair = {
		group = 'Affection',
		name = 'Comb Hair',
		descript = "Comb [name]'s hair",
		reqs = [{code = 'hair_length', value = ['bald'], check = false}],
		location = [],
		effect = 'combhair',
	},
	hug = {
		group = 'Affection',
		name = 'Hug',
		descript = "Prolonged close physical contact",
		reqs = [],
		location = [],
		effect = 'hug',
	},
	kiss = {
		group = 'Affection',
		name = 'Kiss',
		descript = "Attempt to kiss [name]. Can only be used once.",
		onetime = true,
		reqs = [],
		location = [],
		effect = 'kiss',
	},
	rubears = {
		group = 'Affection',
		name = 'Rub Ears',
		descript = "Gently rub [name]'s long ears",
		reqs = [{code = 'long_ears', check = true}],
		location = [],
		effect = 'rubears',
	},
	stroketail = {
		group = 'Affection',
		name = 'Stroke Tail',
		descript = "Gently stroke [name]'s tail",
		reqs = [{code = 'long_tail', check = true}],
		location = [],
		effect = 'stroketail',
	},
	ask_to_marry = {
		group = 'Affection',
		name = 'Ask to marry',
		descript = "Make a proposal for [name], to officially marry [him].",
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
		name = 'Propose',
		descript = "Ask [name] if [he] would consent to become more intimate with you. Boosts Consent greatly when successful. ",
		reqs = [{code = 'stat', stat = 'consent', operant = 'lt', value = 25}, {code = 'stat', stat = 'was_proposed', operant = 'eq', value = false}],
		location = ['bedroom'],
		effect = 'propose',
	},

	scold = {
		group = 'Discipline',
		name = 'Scold',
		descript = "Scold [name] for [his] previous mistakes to re-enforce obedience",
		reqs = [],
		location = [],
		effect = 'scold',
	},
	slap = {
		group = 'Discipline',
		name = 'Slap',
		descript = "Slap [name] across the face to reprimand [him].",
		reqs = [],
		location = [],
		effect = 'slap',
	},
	pullear = {
		group = 'Discipline',
		name = 'Pull By Ear',
		descript = "Forcefully pull [name] by ear as a mean of discipline. ",
		reqs = [],
		location = [],
		effect = 'pullear',
	},
	pulltail = {
		group = 'Discipline',
		name = 'Pull Tail',
		descript = "Forcefully yank [name]'s tail to teach [him] [his] place.",
		reqs = [{code = 'bodypart', part = 'tail', operant = 'neq', value = ''}],
		location = [],
		effect = 'pulltail',
	},
	flag = {
		group = 'Discipline',
		name = 'Flagellate',
		descript = "Spank [name] as punishment",
		reqs = [],
		location = ['dungeon'],
		effect = 'flag',
	},
	whip = {
		group = 'Discipline',
		name = 'Whipping',
		descript = "Whip [name] as punishment",
		reqs = [],
		location = ['dungeon'],
		effect = 'whip',
	},
	wax = {
		group = 'Discipline',
		name = 'Hot Wax',
		descript = "Torture with hot wax",
		reqs = [],
		location = ['dungeon'],
		effect = 'wax',
	},
	horse = {
		group = 'Discipline',
		name = 'Wooden Horse',
		descript = "Torture with a wooden horse",
		reqs = [],
		location = ['dungeon'],
		effect = 'horse',
	},
	public = {
		group = 'Discipline',
		name = 'Bring Public',
		descript = "Invite other slaves to observe [name]'s punishments. It will slightly improve your autority among them and increase punishment effect. Use again to make them leave. Does not cost Time.  ",
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
		name = "Make Gift",
		descript = "Make a small decorative gift for [name]. \n[color=yellow]Requires 10 gold.[/color]",
		reqs = [],
		#reqs = "!location == 'dungeon'",
		disablereqs = 'globals.resources.gold >= 10',
		location = [],
		effect = 'gift',
		onetime = true,
	},
	sweets = {
		group = "Items",
		name = "Buy flowers",
		descript = "Purchase flowers from street vendor for [name]\n[color=yellow]Requires 5 gold.[/color]",
		reqs = [],
		#reqs = "location == 'town'",
		disablereqs = 'globals.resources.gold >= 5',
		location = ['town'],
		effect = 'sweets',
		onetime = true,
	},
	tea = {
		group = "Items",
		name = "Drink Tea",
		descript = "Serve tea for you and [name]. [color=yellow]Requires 1 supply.[/color]",
		reqs = [],
		location = ['livingroom','bedroom'],
		#reqs = 'location in ["livingroom","bedroom"]',
		disablereqs = 'globals.itemdict.supply.amount >= 1',
		effect = 'tea',
	},
	wine = {
		group = "Items",
		name = "Drink Wine",
		descript = "Serve wine for you and [name] (Alcohol eases intimacy request but may cause a knockout). [color=yellow]Requires 2 supplies.[/color]",
		reqs = [],
		location = ['livingroom','bedroom','garden','town'],
		#reqs = 'location in ["livingroom","bedroom","garden","town"]',
		disablereqs = 'globals.itemdict.supply.amount >= 2',
		effect = 'wine',
	},

	train = {
		group = 'Training',
		name = 'Train',
		reqs = [],
		location = [],
		descript = 'Do a paired training. Improves Physics for both based on Physics Factor and Time left. Ends encounter.',
		effect = 'train',
	},
	study = {
		group = 'Training',
		name = 'Study',
		reqs = [],
		location = [],
		descript = 'Do a paired study. Improves Wits for both based on Wits Factor and Time left. Ends encounter.',
		effect = 'study',
	},
	practice_charm = {
		group = 'Training',
		name = 'Practice Charm',
		reqs = [],
		location = [],
		descript = 'Practice Charm with [name]. Improves Charm for both based on Charm Factor and Time left. Ends encounter.',
		effect = 'charm',
	},
	useitem = {
		group = "Affection",
		name = "Use Item",
		descript = "Select an item from list to use with [name].",
		reqs = [],
		location = [],
		effect = 'useitem',
	},

	food = {
		group = "Affection",
		name = "Treat with food",
		descript = "Treat [name] with food.",
		reqs = [],
		location = [],
		effect = 'food',
		#onetime = true,
	},

	stop = {
		group = "any",
		name = "Stop",
		descript = "Stop interaction and let [name] return to work.",
		reqs = [],
		location = [],
		effect = 'stop',
	},
}
