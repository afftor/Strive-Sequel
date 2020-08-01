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

var helpdescript = {
	mood = '[center]Mood[/center]\nA high mood increases likeliness of positive outcome of intimate actions and provides Loyalty growth buff after session is finished.\nMood grows from positive interactions and decreases from negative interactions.',
	fear = '[center]Fear[/center]\nFear provides Submission growth buff after session is finished. \nFear grows from punishing actions, but when pushed too high will make partner breakdown and stop interaction. ',
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
	ResourceScripts.game_world.make_world()
	location = 'livingroom'
	
	globals.AddItemToInventory(globals.CreateUsableItem("alcohol"))
	globals.AddItemToInventory(globals.CreateUsableItem("beer"))
	master = ResourceScripts.scriptdict.class_slave.new()
	master.create('Human', 'male', 'random')
	master.unlock_class('master')
	characters_pool.move_to_state(master.id)
	
	person = ResourceScripts.scriptdict.class_slave.new()
	person.create('HalfkinFox', 'female', 'random')
	person.set_stat('personality', 'shy')
	ResourceScripts.game_res.upgrades.torture_room = 1
	
	var character = ResourceScripts.scriptdict.class_slave.new()
	character.create('HalfkinCat', 'female', 'random')
	characters_pool.move_to_state(character.id)
	character = ResourceScripts.scriptdict.class_slave.new()
	character.create('HalfkinCat', 'female', 'random')
	characters_pool.move_to_state(character.id)
	character = ResourceScripts.scriptdict.class_slave.new()
	character.create('HalfkinCat', 'female', 'random')
	characters_pool.move_to_state(character.id)
	for i in helpdescript:
		globals.connecttexttooltip(get_node(i),helpdescript[i])
	globals.connecttexttooltip($panel/categories/Location,"Location can influence your partner and allow new options. Does not cost Time.")
	globals.connecttexttooltip($panel/categories/Training,"Training together will end the encounter.")
	$end/sexbutton.connect("pressed", self, 'start_sex')
	initiate(person)

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
	
	#master = ResourceScripts.game_party.get_master()
	
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
	if person.get_body_image() != null && person.get_body_image() != null:
		$fullbody.set_texture(person.get_body_image())
	$textfield/slaveportrait.texture = null
	
	if person.get_icon() != null && person.get_icon():
		$textfield/slaveportrait.set_texture(person.get_icon())
	else:
		$textfield/slaveportrait.set_texture(null)
	if $textfield/slaveportrait.texture == null:
		$textfield/slaveportrait/TextureRect.visible = false
	else:
		$textfield/slaveportrait/TextureRect.visible = true
	
	$textfield/masterportrait.texture = null
#	if globals.player.imageportait != null && globals.loadimage(globals.player.imageportait):
#		$textfield/masterportrait.set_texture(globals.loadimage(globals.player.imageportait))
#	else:
#		globals.player.imageportait = null
#		$textfield/masterportrait.set_texture(null)
	if $textfield/masterportrait.texture == null:
		$textfield/masterportrait/TextureRect.visible = false
	else:
		$textfield/masterportrait/TextureRect.visible = true
	
	
	
	if jail == true:
		location = 'dungeon'
		text = "You visit [name2] in [his2] cell and decide to spend some time with [him2]. "
		$panel/categories/Location.disabled = true
	else:
		$panel/categories/Location.disabled = false
		location = 'livingroom'
		text = "You meet [name2] and order [him2] to keep you company. "
		if person.get_stat('loyalty') >= 25:
			text += "[he2] gladly accepts your order and is ready to follow you anywhere you take [him2]. "
			self.mood += 10
		elif person.get_stat('obedience') >= 90:
			self.mood += 4
			text += "[he2] obediently agrees to your order and tries [his2] best to please you. "
		else:
			
			text += "Without great joy [he2] obeys your order and reluctantly joins you. "
#		if person.lust >= 30:
#			mood += 6
#		elif person.traits.has("Devoted"):
#			mood += 10
	
	#$panel/consent.visible = person.get_stat('consent')
	
	self.showntext = text
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
	$textfield/Label.text = locationdicts[location].name
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
		if person.checkreqs(i.reqs) == true && check_location(i.location) && (i.group == category || i.group == 'any'):
			if i.has('onetime') && checkhistory(i.effect) > 0 || (finish_encounter == true && i.effect != 'stop'):
				continue
			var newnode = $panel/ScrollContainer/GridContainer/Button.duplicate()
			$panel/ScrollContainer/GridContainer.add_child(newnode)
			newnode.visible = true
			newnode.text = person.translate(i.name)
			newnode.connect("pressed",self,'doaction', [i.effect])
			globals.connecttexttooltip(newnode, person.translate(i.descript))
			if i.has('disablereqs'):
				newnode.disabled = true
	
	$panel/ScrollContainer/GridContainer.move_child($panel/ScrollContainer/GridContainer/Button, $panel/ScrollContainer/GridContainer.get_children().size())
	var text = "Authority: " + str(floor(person.get_stat('authority'))) + "("  + str(person.authority_threshold()) + ")" + ", Consent: " + str(floor(person.get_stat("consent"))) 
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
	self.showntext = 'You lead [name2] to the [color=yellow]' + locationdicts[location].name + '[/color]. '
	
	
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
	if !action in ['useitem']:
		self.showntext = globals.TextEncoder(decoder(text))
	actionhistory.append(action)
	stopactions = false
	if !action in ['train', 'study','practice_charm', 'public', 'useitem']:
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

var chatlines = [
	"You attempt to initiate a friendly chat with [name2]. ",
	"You make a small talk to [name2]. ",
	"You and [name2] discuss the weather. ",
]

func chat(person, counter):
	var text = ''
	text += "You attempt to initiate a friendly chat with [name2]. "
	
	
	if counter < 3 || randf() >= counter/10.0+0.1:
		text += "[name2] spends some time engaging in a friendly chat with you. "
		self.mood += 8
	else:
		self.mood -= 1
		text += "[name2] replies, but does so reluctantly. "
	
	
	return text

func intimate(person, counter):
	var text = ''
	text += "You talk to [name2] about sexual things. "
	
	if location == 'bedroom':
		self.mood += 10
		text += "[he2] opens up to you."
		person.add_stat('consent', rand_range(2,3))
	elif person.check_trait("shameless"):
		text += "Being {color=yellow|[Shameless]} [he2] does not mind discussing it in public and opens up to you."
		self.mood += 10
		person.add_stat('consent', rand_range(2,3))
	else:
		self.mood -= 3
		text += "[he2] seems to be reluctant to talk about such intimate matters in public and dodges the theme."
	
	
	
	return text

func touch(person, counter):
	var text = ''
	text += "You casually touch [name2] in various places. "
	
	if counter < 3 && fear < 20:
		text += "[he2] reacts relaxingly to your touch"
		self.mood += 6
		if person.get_stat('loyalty') >= 10 && randf() >= 0.65:
			text += ' and smiles at you'
		text += '. '
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		self.mood -= 1
		text += "[he2] reacts coldly to your touch. "
	return text

func holdhands(person, counter):
	var text = ''
	if location != 'bedroom':
		text += "You take [name2]'s hand into yours and stroll around. "
	else:
		text += "You take [name2]'s hand into yours and move closer. "
	if (counter < 3 || randf() >= 0.4) && self.mood >= 4:
		text += "[he2] holds your hand firmly. "
		self.mood += 9
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		self.mood -= 1
		text += "[he2] holds your hand, but looks reclusive. "
	
	return text

func combhair(person, counter): 
	var text = ''
	text += "You gently comb [name2]'s hair. "
	
	if (counter < 3 || randf() >= 0.8) && self.mood >= 12:
		text += "[he2] smiles and looks pleased. "
		self.mood += 8
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		self.mood -= 2
		text += "[he2] looks uncomfortable. "
	
	return text


func hug(person, counter): 
	var text = ''
	text += "You embrace [name2] in your arms. "
	
	if (counter < 3 || randf() >= 0.7) && self.mood >= 6:
		text += "[he2] embraces you back resting [his2] head on your chest. "
		self.mood += 11
		if person.get_stat("consent") < 12:
			person.add_stat('consent', rand_range(3,5))
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		self.mood -= 3
		text += "[he2] does not do anything waiting uncomfortably for you to finish. "
	
	return text

func kiss(person, counter): 
	var text = ''
	text += "You gently kiss [name2] on the cheek. "
	
	if (self.mood >= 10 || person.get_stat('loyalty') >= 15):
		if person.get_stat('personality') in ['shy','kind']:
			text += "[he2] blushes and looks away. "
		else:
			text += "[he2] giggles looking at you. "
		self.mood += 12
		if person.get_stat("consent") < 15:
			person.add_stat('consent', rand_range(3,5))
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		self.mood -= 2
		text += "[he2] abruptly stops you, showing [his2] disinterest. "
	
	return text

func frenchkiss(person, counter): 
	var text = ''
	text += "You invade [name2]'s mouth with your tongue. "
	
	if self.mood >= 20 && (location == 'bedroom' || person.check_trait("shameless")):
		if person.check_trait("shameless"):
			text += "Being {color=yellow|[Shameless]} [he2] does not mind doing it in public and passionately accepts your kiss."
		else:
			text += "[he2] closes eyes passionately accepting your kiss."
		if !person.check_trait("Bisexual") && person.get_stat('sex') == master.get_stat('sex'):
			self.mood += 6
		else:
			self.mood += 13
		if person.get_stat("consent") < 25:
			person.add_stat('consent', rand_range(3,5))
	else:
		self.mood -= 5
		text += "[he2] abruptly stops you, showing [his2] disinterest. "
	
	return text

#func pushdown(person, counter):
#	var text = ''
#	var mode
#	text += "You forcefully push [name2] down giving [him2] a sultry look. "
#	if person.effects.has("captured"):
#		self.mood -= 10
#		text += "[he2] resists and pushes you back. "
#		mode = 'abuse'
#	elif self.mood*4 + person.get_stat('loyalty') + person.lust >= 100 || (person.sextraits.has("Likes it rough") && self.mood*3 + person.get_stat('loyalty') + person.lust >= 75):
#		text += "[he2] closes eyes and silently accepts you. "
#		self.mood += 3
#		mode = 'rapeconsent'
#	else:
#		self.mood -= 6
#		text += "[he2] resists and pushes you back. "
#		mode = 'abuse'
#	showsexswitch(text,mode)
#	return text

func propose(person, counter):
	var text = ''
	text += "You ask [name2] if [he2] would like to take your relationship to the next level. "
	var difficulty =  self.mood*3 + person.get_stat('loyalty')*2 + drunkness*5
	if person.get_stat('sex') ==  ResourceScripts.game_party.get_master().get_stat('sex') && !person.check_trait('bisexual'):
		difficulty -= 10
#	if globals.state.relativesdata.has(person.id) && (int(globals.state.relativesdata[person.id].father) == int(globals.player.id) || int(globals.state.relativesdata[person.id].mother) == int(globals.player.id)):
#		difficulty -= 10
	if difficulty <= 100:
		text += "[he2] shows a troubled face and rejects your proposal. "
		self.mood -= 15
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_proposal_refuse')) 
		return text
	else:
		#showsexswitch(text, mode)
		text += "[he2] gives a meek nod, showing [his2] readiness to follow you to the bedroom."
		person.set_stat('consent', 20)
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_proposal_agree'))
		return text

var sexmode

#func showsexswitch(text, mode):
#	$sexswitch.visible = true
#	sexmode = mode
#	$end/RichTextLabel.bbcode_text = text
#	if mode == 'abuse':
#		text += "\n[color=yellow]Rape [name2] anyway?[/color]"
#		$sexswitch/confirmsex.visible = true
#		$sexswitch/cancelsex.visible = true
#	elif mode == 'rapeconsent':
#		sexmode = 'sex'
#		$sexswitch/confirmsex.visible = true
#		$sexswitch/cancelsex.visible = false
#	elif mode == 'sex':
#		$sexswitch/confirmsex.visible = true
#		$sexswitch/cancelsex.visible = false
#
#	text = decoder(text) 
#	if $sexswitch/cancelsex.visible == false:
#		text += calculateresults()
#	$sexswitch/RichTextLabel.bbcode_text = text

func praise(person, counter):
	var text = ''
	text += "You praise [name2] for [his2] recent behavoir. "
	
	if person.get_stat('obedience') >= 85 && counter < 2:
		self.mood += 3
		text = text + "[he2] listens to your praise with joy evident on [his2] face.  "
	elif person.get_stat('obedience') >= 85:
		text = text + "[he2] takes your words respectfully but without great joy. You’ve probably overpraised [him2] lately. "
		
	else:
		text = text + "[he2] takes your praise arrogantly, gaining joy from it. "
		self.mood += 3
		#person.get_stat('loyalty') -= rand_range(1,2)
	
	return text

func pathead(person, counter):
	var text = ''
	text += "You pat [name2]'s head and praise [him2] for [his2] recent behavior. "
	
	if counter < 5 || randf() >= 0.4:
		self.mood += 2
		text = text + "[he2] takes it with joy evident on [his2] face.  "
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		text = text + "[he2] seems to be bored from repeated action. "
		self.mood -= 1
	return text

func scold(person, counter):
	var text = ''
	text += "You scold [name2] for [his2] recent faults. "
	
	var value = {mood = -2, fear = 10, authority = 3, action = 'scold'}
	
	text += punish_process(value)
	return text

func rubears(person, counter):
	var text = ''
	text += "You affectionately rub [name2] behind [his2] ears. "
	
	if counter < 5 || randf() >= 0.4:
		self.mood += 9
		text = text + "[he2] seems pleased with it, as [his2] ears playfully twitch.  "
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		text = text + "[he2] seems to be bored from repeated action. "
		self.mood -= 1
	return text

func stroketail(person, counter):
	var text = ''
	text += "You gently stroke [name2]'s tail. "
	
	if counter < 5 || randf() >= 0.4:
		self.mood += 11
		text = text + "[he2] seems happy with your attention, as [his2] tail wags in response."
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_affection')) + "\n"
	else:
		text = text + "[he2] seems to be bored from repeated action. "
		self.mood -= 1
	return text

func pullear(person, counter):
	var text = ''
	text += "You forcefully stretch [name2]'s ear making [him2] let out a pleading cry. "
	
	var value = {mood = -7, fear = 14, authority = 4, action = 'pullear'}
	
	text += punish_process(value)
	return text

func pulltail(person, counter):
	var text = ''
	text += "You yank [name2]'s tail with force making [him2] whimper in pain. "
	
	var value = {mood = -5, fear = 15, authority = 4, action = 'pulltail'}
	text += punish_process(value)
	return text

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
			if i.get_stat('authority') < 20:
				i.add_stat('authority',rand_range(2,4))
		text += input_handler.text_form_recitation(array)
		text += "[/color] watch over [name2]'s humiliation in awe. "
		
		
		value.mood *= 1.2
		value.fear *= 1.3
		value.authority *= 1.2
	
	
	person.add_stat('authority', value.authority)
	self.fear += value.fear
	self.mood += value.mood
	
	return text

func build_observing_slaves():
	for i in ResourceScripts.game_party.character_order:
		var character = ResourceScripts.game_party.characters[i]
		if character.check_location('Aliron') && character != person && !character.has_profession('master'):
			observing_slaves.append(character)

func slap(person, counter):
	var text = ''
	text += "You slap [name2] across the face as punishment. [his2] cheek gets red. "
	
	var value = {mood = -3, fear = 12, authority = 3, action = 'slap'}
	text += punish_process(value)
	return text

func flag(person, counter):
	var text = ''
	text += "You put [name2] on the punishment table, and after exposing [his2] rear, punish it with force. "
	
	var value = {mood = -5, fear = 16, authority = 5, action = 'flag'}
	
	text += punish_process(value)
	return text

func whip(person, counter):
	var text = ''
	text += "You put [name2] on the punishment table, and after exposing [his2] rear, whip it with force. "
	
	
	var value = {mood = -5, fear = 20, authority = 5, action = 'whip'}
	text += punish_process(value)
	return text

func horse(person, counter):
	var text = ''
	text += "You tie [name2] securely to the wooden horse with [his2] legs spread wide. [he2] cries with pain under [his2] own weight. "
	
	
	var value = {mood = -5, fear = 20, authority = 5, action = 'horse'}
	text += punish_process(value)
	
	return text

func wax(person, counter):
	var text = ''
	text += "You put [name2] on the punishment table and after exposing [his2] body you drip hot wax over it making [him2] cry with pain. "
	
	var value = {mood = -5, fear = 18, authority = 6, action = 'wax'}
	
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
	
	self.mood += 4
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
	self.mood += 20
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
	self.mood += rand_range(20,30)
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

func useitem(person, counter):
	globals.ItemSelect(self, 'date_use', 'item_selected')
	return ''

func item_selected(item):
	call(item.code, person)

func alcohol(person):
	var text = ''
	text += "You present [name2] with a bottle of whiskey. "
	if self.mood < 15 || person.get_stat('authority') < 10:
		text += 'However, [he2] refuses to drink in your company. '
	else:
		text += "[he2] accepts your invitation and you slowly consume it, as [his2] mood improve. You notice that [he2] gets tipsy and feels at ease with you. "
		self.mood += 15
		person.add_stat('authority', 11)
		person.add_stat('consent', 5)
		
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
		person.add_stat('authority', 5)
		person.add_stat('consent', 3)
		
		drunkness += 1
		ResourceScripts.game_res.remove_item('beer',1)
	
	self.showntext = globals.TextEncoder(decoder(text))
	drunkness()
	updatelist()




#func wine(person, counter):
#	var text = ''
#	text += "You serve fresh wine for you and [name2]. "
#
#	if self.mood < 5 || person.get_stat('obedience') < 80:
#		text = "[he2] refuses to drink with you. "
#	else:
#		if counter < 3:
#			text += "[he2] drinks with you and [his2] mood seems to improve."
#			self.mood += 4
#			drunkness += 1
#		else:
#			self.mood += 2
#			text += "[he2] keeps you company, but the wine does not seem to affect [him2] as heavily as before. "
#			drunkness += 1
#
#		globals.itemdict.supply.amount -= 2
#
#	if person.sextraits.has("Alcohol Intolerance"):
#		drunkness += 1
#
#	return text


#func gift(person, counter):
#	var text = ''
#	text += "You present [name2] with a small decorative gift. "
#
#	if person.get_stat('obedience') >= 75:
#		self.mood += 7
#		#person.get_stat('loyalty') += 4
#		text = text + "[he2] accepts your gift with a pleasant smile on [his2] face.  "
#
#	else:
#		text = text + "[he2] takes your gift arrogantly, barely respecting your intention. "
#		self.mood += 3
#
#
#	globals.resources.gold -= 10
#
#	return text
#
#func sweets(person, counter):
#	var text = ''
#	text += "You purchase some candies for [name2] from a local vendor. "
#
#	if person.get_stat('obedience') >= 55:
#		self.mood += 6
#		#person.get_stat('loyalty') += 3
#		text = text + "[he2] joyfull accepts them and enjoys the sweet taste.  "
#
#	else:
#		text = text + "[he2] takes your gift arrogantly, barely respecting your intention. "
#		self.mood += 3
#
#
#	globals.resources.gold -= 5
#
#	return text
#
#
#func tea(person, counter):
#	var text = ''
#	text += "You serve tea for you and [name2]. While drinking, you both chatand get a bit closer.  "
#
#	if counter <= 3 || randf() >= 0.5:
#		self.mood += 5
#		text += "[name2] seems to be pleased with your generosity and enjoys your company. "
#	else:
#		self.mood += 1
#
#	globals.itemdict.supply.amount -= 1
#
#	return text

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
	var loyal_bonus = floor(self.mood * 2)
	var subm_bonus = floor(self.fear * 2) 
	
	var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table['date_bonus'])
	eff.set_args('subm_bonus', subm_bonus)
	eff.set_args('loyal_bonus', loyal_bonus)
	person.apply_effect(effects_pool.add_effect(eff))
	
	var text = ('Encounter Complete!'
	+ "\nLoyalty bonus for next 36 hours: +" + str(loyal_bonus) +"%"
	+ "\nSubmission bonus for next 36 hours: +" + str(subm_bonus) +"%"
	
	+ "\nConsent Gained: " + str(floor(person.get_stat('consent')-self.consStart))
	+ "\nAuthority Gained: " + str(floor(person.get_stat("authority") - self.authStart))
	)
	
	if person.get_stat('consent') >= 30 || person.get_stat('loyalty') + person.get_stat('consent')*2 > 110:
		text += "\n\n{color=aqua|" + person.get_short_name() + "}: " + person.translate(input_handler.get_random_chat_line(person, 'date_sex_offer')) + "\n"
		sex_offer = true
	
	$end/sexbutton.visible = sex_offer
	
	return text

func start_sex():
	ResourceScripts.core_animations.BlackScreenTransition(0.5)
	yield(get_tree().create_timer(0.5), 'timeout')
	self.hide()
	input_handler.GUIWorld.gui_data["INTERACTION"].main_module.startsequence([master, person])

func _on_finishbutton_pressed():
	ResourceScripts.core_animations.BlackScreenTransition(0.5)
	yield(get_tree().create_timer(0.5), 'timeout')
	hide()


func _on_cancelsex_pressed():
	$sexswitch.visible = false

func _on_confirmsex_pressed():
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
		#disablereqs = "!person.traits.has('Mute')",
	},
	intimate = {
		group = 'Affection',
		name = 'Intimate Talk',
		descript = 'Have an intimate talk. Slightly increases Consent if mood is above low.',
		reqs = [],
		location = [],
		effect = 'intimate',
		#disablereqs = "!person.traits.has('Mute')",
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
		descript = "Praise [name] for [his] previous success to encourage further good behavior",
		reqs = [],
		location = [],
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
		reqs = [],
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
		descript = "Kiss [name] lightly",
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
		reqs = [{code = 'bodypart', part = 'tail', operant = 'neq', value = ''}],
		location = [],
		effect = 'stroketail',
	},
	
	frenchkiss = {
		group = 'Affection',
		name = 'French Kiss',
		descript = "Kiss [name] in an erotic manner",
		reqs = [],
		location = [],
		effect = 'frenchkiss',
	},
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
		reqs = [{code = 'stat', stat = 'consent', operant = 'lte', value = 20}],
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
		descript = "Slap [name] across the face to reprimand [him]. Slightly icnreases Authority.",
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
	
	stop = {
		group = "any",
		name = "Stop",
		descript = "Stop interaction and let [name] return to work.",
		reqs = [],
		location = [],
		effect = 'stop',
	},
}
