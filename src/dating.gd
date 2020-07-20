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
var categories = ['Actions','P&P','Location','Items']
var locationarray = ['livingroom','town','dungeon','garden','bedroom']
var location_changed = false
var turn = 0
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
	fear = fear + difference
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
	mood = mood + difference
	$mood.value = floor(mood)

func mood_get():
	return mood

onready var nakedspritesdict = {
	Cali = {cons = 'calinakedhappy', rape = 'calinakedsad', clothcons = 'calineutral', clothrape = 'calisad'},
	Tisha = {cons = 'tishanakedhappy', rape = 'tishanakedneutral', clothcons = 'tishahappy', clothrape = 'tishaneutral'},
	Emily = {cons = 'emilynakedhappy', rape = 'emilynakedneutral', clothcons = 'emily2happy', clothrape = 'emily2worried'},
	Chloe = {cons = 'chloenakedhappy', rape = 'chloenakedneutral', clothcons = 'chloehappy2', clothrape = 'chloeneutral2'},
	Maple = {cons = 'fairynaked', rape = 'fairynaked', clothcons = 'fairy', clothrape = 'fairy'},
	Yris = {cons = 'yrisnormalnaked', rape = 'yrisshocknaked', clothcons = 'yrisnormal', clothrape = 'yrisshock'},
	Ayneris = {cons = 'aynerisneutralnaked', rape = 'aynerisangrynaked', clothcons = 'aynerisneutral', clothrape = 'aynerisangry'},
	Zoe = {cons = "zoehappynaked", rape = 'zoesadnaked', clothcons = 'zoehappy', clothrape = 'zoesad'},
	Melissa = {cons = "melissanakedfriendly", rape = 'melissanakedneutral', clothcons = 'melissafriendly', clothrape = 'melissaneutral'},
	}

var locationdicts = {
	livingroom = {code = 'livingroom',name = 'Living Room', background = 'mansion'},
	bedroom = {code = 'bedroom',name = 'Bedroom', background = 'mansion'},
	dungeon = {code = 'dungeon',name = 'Dungeon', background = 'jail'},
	garden = {code = 'garden',name = 'Garden', background = 'crossroads'},
	town = {code = 'town',name = 'Streets', background = 'localtown'},
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
	location = 'livingroom'
	master = ResourceScripts.scriptdict.class_slave.new()
	master.create('Human', 'male', 'random')
	
	person = ResourceScripts.scriptdict.class_slave.new()
	person.create('HalfkinCat', 'female', 'random')
	person.set_stat('personality', 'shy')
	for i in helpdescript:
		globals.connecttexttooltip(get_node(i),helpdescript[i])
	globals.connecttexttooltip($panel/categories/Location,"You can only change location once.")
	initiate(person)

func initiate(tempperson):
	var text = ''
	self.visible = true
	self.mood = 0
	self.drunkness = 0
	self.turn = 0
	self.authStart = tempperson.get_stat('authority')
	self.consStart = tempperson.get_stat('consent')
	date = false
	public = false
	$sexswitch.visible = false
	$end.visible = false
	$textfield/RichTextLabel.clear()
	location_changed = false
	
	
	
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
		get_parent().background = 'jail'
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
	
	$panel/consent.visible = person.get_stat('consent')
	
	self.showntext = text
	updatelist()
	$panel/categories/Actions.emit_signal("pressed")

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
	category = button
	updatelist()

func endencounter():
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
	$panel/categories/Location.visible = !location_changed
	for i in actionsdict.values():
		if person.checkreqs(i.reqs) == true && check_location(i.location) && i.group == category:
			if i.has('onetime') && checkhistory(i.effect) > 0:
				continue
			var newnode = $panel/ScrollContainer/GridContainer/Button.duplicate()
			$panel/ScrollContainer/GridContainer.add_child(newnode)
			newnode.visible = true
			newnode.text = person.translate(i.name)
			newnode.connect("pressed",self,'doaction', [i.effect])
			globals.connecttexttooltip(newnode, person.translate(i.descript))
#			newnode.connect("mouse_entered",self,'actiontooltip', [i.descript])
#			newnode.connect("mouse_exited",globals,'hidetooltip')
			if i.has('disablereqs'):
				newnode.disabled = true
	if category == 'Location':
		for i in locationdicts.values():
			if i.code == location:
				continue
			var newnode = $panel/ScrollContainer/GridContainer/Button.duplicate()
			$panel/ScrollContainer/GridContainer.add_child(newnode)
			newnode.visible = true
			newnode.text = "Move to "+ i.name
			newnode.connect("pressed",self,'moveto', [i.code])
	
	$panel/ScrollContainer/GridContainer.move_child($panel/ScrollContainer/GridContainer/Button, $panel/ScrollContainer/GridContainer.get_children().size())
	var text = "Authority: " + str(floor(person.get_stat('authority'))) + "("  + str(person.authority_threshold()) + ")" + ", Consent: " + str(floor(person.get_stat("consent"))) 
	$authconslabel.text = text
	#$mana/Label.text = str(globals.resources.mana)
	$gold/Label.text = ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.money)
#	$supply/Label.text = str(globals.itemdict.supply.amount)

func moveto(newloc):
	location_changed = true
	self.location = newloc
	$panel/categories/Actions.emit_signal("pressed")
#	if locationdicts[location].background != 'localtown':
#		get_parent().background = locationdicts[location].background
#	else:
#		get_parent().background = globals.state.location
	self.showntext = 'You lead [name2] to the [color=yellow]' + locationdicts[location].name + '[/color]. '
	
	updatelist()

func actiontooltip(descript):
	globals.showtooltip(person.dictionary(descript))


onready var parser = ResourceScripts.scriptdict.sexinteraction_parser.new()

func decoder(text):
	text = parser.decoder(text, [dateclassarray[0]], [dateclassarray[1]])
	return text

func doaction(action):
	self.showntext = decoder(call(action, person, checkhistory(action)))
	actionhistory.append(action)
	turn += 1
	if turn%3 == 0:
		if location == 'bedroom':
			self.showntext += decoder("\n\n[color=yellow]Location influence:[/color] [name2] seems to be getting more into intimate mood...")
		elif location == 'garden' && person.get_stat('personality') == 'shy':
			self.mood += 3
			self.showntext += decoder("\n\n[color=yellow]Location influence:[/color] [name2] finds this place to be rather peaceful...")
		elif location == 'town' && person.get_stat('personality') == 'bold':
			self.mood += 3
			self.showntext += decoder("\n\n[color=yellow]Location influence:[/color] [name2] finds this place to be rather joyful...")
		elif location == 'dungeon':
			self.fear += 4
			self.showntext += decoder("\n\n[color=yellow]Location influence:[/color] [name2] finds this place to be rather grim...")
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
		self.mood += 4
	else:
		self.mood -= 1
		text += "[name2] replies, but does so reluctantly. "
	
	
	return text

func intimate(person, counter):
	var text = ''
	text += "You talk to [name2] about personal matters. "
	
	if randf() >= counter/10.0 && self.mood >= 7:
		text += "[he2] opens to you"
		self.mood += 3
		person.add_stat('consent', rand_range(2,3))
		if person.get_stat('loyalty') >= 30 && randf() >= 0.65:
			text += ' and moves slightly closer'
		text += '. '
	elif counter >= 5 && randf() >= 0.5:
		self.mood -= 1
		text += "[he2] looks at you contemplatively, but fails to make a connection. "
	else:
		self.mood -= 2
		text += "[he2] gives you a stiff look. "
	
	
	return text

func touch(person, counter):
	var text = ''
	text += "You casually touch [name2] in various places. "
	
	if counter < 3 && fear < 20:
		text += "[he2] reacts relaxingly to your touch"
		self.mood += rand_range(5,6)
		if person.get_stat('loyalty') >= 10 && randf() >= 0.65:
			text += ' and smiles at you'
		text += '. '
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
		self.mood += 5
	else:
		self.mood -= 1
		text += "[he2] holds your hand, but looks reclusive. "
	
	return text

func combhair(person, counter): 
	var text = ''
	text += "You gently comb [name2]'s hair. "
	
	if (counter < 3 || randf() >= 0.8) && self.mood >= 12:
		text += "[he2] smiles and looks pleased. "
		self.mood += rand_range(4,6)
	else:
		self.mood -= 2
		text += "[he2] looks uncomfortable. "
	
	return text


func hug(person, counter): 
	var text = ''
	text += "You embrace [name2] in your arms. "
	
	if (counter < 3 || randf() >= 0.7) && self.mood >= 6:
		text += "[he2] embraces you back resting [his2] head on your chest. "
		self.mood += rand_range(5,9)
		if person.get_stat("consent") < 12:
			person.add_stat('consent', rand_range(3,5))
	else:
		self.mood -= 2
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
		self.mood += (rand_range(4,8))
		if person.get_stat("consent") < 15:
			person.add_stat('consent', rand_range(3,5))
	else:
		self.mood -= 2
		text += "[he2] abruptly stops you, showing [his2] disinterest. "
	
	return text

func frenchkiss(person, counter): 
	var text = ''
	text += "You invade [name2]'s mouth with your tongue. "
	
	if (self.mood >= 10 && person.consent >= 15) || person.get_stat('consent') >= 25:
		text += "[he2] closes eyes passionately accepting your kiss. "
		if !person.check_trait("Bisexual") && person.get_stat('sex') == master.get_stat('sex'):
			self.mood += 5
		else:
			self.mood += 10
	else:
		self.mood -= 4
		text += "[he2] abruptly stops you, showing [his2] disinterest. "
	
	return text

func pushdown(person, counter):
	var text = ''
	var mode
	text += "You forcefully push [name2] down giving [him2] a sultry look. "
	if person.effects.has("captured"):
		self.mood -= 10
		text += "[he2] resists and pushes you back. "
		mode = 'abuse'
	elif self.mood*4 + person.get_stat('loyalty') + person.lust >= 100 || (person.sextraits.has("Likes it rough") && self.mood*3 + person.get_stat('loyalty') + person.lust >= 75):
		text += "[he2] closes eyes and silently accepts you. "
		self.mood += 3
		mode = 'rapeconsent'
	else:
		self.mood -= 6
		text += "[he2] resists and pushes you back. "
		mode = 'abuse'
	showsexswitch(text,mode)
	return text

func propose(person, counter):
	var text = ''
	var mode
	if person.consent == true:
		text = "[name2] previously gave you [his2] consent and you proceed with your intentions. "
		mode = 'sex'
		globals.state.sexactions += 1
		showsexswitch(text, mode)
		return text
	else:
		text += "You ask [name2] if [he2] would like to take your relationship to the next level. "
		var difficulty =  self.mood*3 + person.get_stat('loyalty')*2 + person.lust + drunkness*3
		if person.effects.has('captured'): difficulty -= 80
		if person.sex == globals.player.sex && !person.sextraits.has('Homosexual'):
			difficulty -= 10
		if globals.state.relativesdata.has(person.id) && (int(globals.state.relativesdata[person.id].father) == int(globals.player.id) || int(globals.state.relativesdata[person.id].mother) == int(globals.player.id)):
			difficulty -= 10
		if person.sextraits.has('Prude'):
			difficulty -= 5
		if difficulty <= 100:
			text += "[he2] shows a troubled face and rejects your proposal. "
			self.mood -= 4
			return text
		else:
			person.lust += 3
			mode = 'sex'
			globals.state.sexactions += 1
			showsexswitch(text, mode)
			text += "[he2] gives a meek nod and you lead [him2] to bedroom."
			text += "\n\n[color=green]Unlocked sexual actions with [name2].[/color]"
			if person.levelupreqs.has('code') && person.levelupreqs.code == 'relationship':
				text += "\n\n[color=green]After getting closer with [name2], you felt like [he2] unlocked new potential. [/color]"
				person.levelup()
			person.consent = true
			
			return text
	
	

var sexmode

func showsexswitch(text, mode):
	$sexswitch.visible = true
	sexmode = mode
	$end/RichTextLabel.bbcode_text = text
	if mode == 'abuse':
		text += "\n[color=yellow]Rape [name2] anyway?[/color]"
		$sexswitch/confirmsex.visible = true
		$sexswitch/cancelsex.visible = true
	elif mode == 'rapeconsent':
		sexmode = 'sex'
		$sexswitch/confirmsex.visible = true
		$sexswitch/cancelsex.visible = false
	elif mode == 'sex':
		$sexswitch/confirmsex.visible = true
		$sexswitch/cancelsex.visible = false
	
	text = decoder(text) 
	if $sexswitch/cancelsex.visible == false:
		text += calculateresults()
	$sexswitch/RichTextLabel.bbcode_text = text

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
	else:
		text = text + "[he2] seems to be bored from repeated action. "
		self.mood -= 1
	return text

func scold(person, counter):
	var text = ''
	text += "You scold [name2] for [his2] recent faults. "
	self.mood -= 2
	self.fear += 7
	
	text += punishaddedeffect()
	return text


func punishaddedeffect():
	var text = ''
	if person.check_trait("Masochist") && randf() >= 0.5:
		text += "[Masochist][name2] seems to take [his2] punishment with some unusual enthusiasm... "
		person.lust += rand_range(2,4)
		self.mood += 4
	if public == true:
		var slavearray = []
		for i in globals.slaves:
			if i.away.duration == 0 && i.sleep != 'farm' && i != person:
				slavearray.append(i)
		if slavearray.size() > 0:
			text += "\n\n[color=yellow]Invited slaves watch over [name2] in awe. [/color] "
			for i in slavearray:
				i.fear += 3
				#i.stress += 3
				if actionhistory.back() in ['woodenhorse','flagellate']:
					pass
					#i.lust += 2
	return text

func slap(person, counter):
	var text = ''
	text += "You slap [name2] across the face as punishment. [his2] cheek gets red. "
	self.fear += 12
	self.mood -= 2
	person.add_stat("authority", 3)
	text += punishaddedeffect()
	return text

func flag(person, counter):
	var text = ''
	text += "You put [name2] on the punishment table, and after exposing [his2] rear, punish it with force. "
	
	self.fear += 9
	self.mood -= 3
	
	text += punishaddedeffect()
	return text

func whip(person, counter):
	var text = ''
	text += "You put [name2] on the punishment table, and after exposing [his2] rear, whip it with force. "
	
	self.fear += 11
	self.mood -= 3
	
	text += punishaddedeffect()
	return text

func horse(person, counter):
	var text = ''
	text += "You tie [name2] securely to the wooden horse with [his2] legs spread wide. [he2] cries with pain under [his2] own weight. "
	
	self.fear += 12
	self.mood -= 4
	person.lust += rand_range(5,10)
	
	text += punishaddedeffect()
	
	return text

func wax(person, counter):
	var text = ''
	text += "You put [name2] on the punishment table and after exposing [his2] body you drip hot wax over it making [him2] cry with pain. "
	
	self.fear += 11
	self.mood -= 3
	
	text += punishaddedeffect()
	
	return text

#func teach(person, counter):
#	var text = ''
#	var value = round(3 + person.wit/12) - drunkness*2
#	if person.traits.has("Clever"):
#		value += value*0.25
#	text += "You spend some time with [name2], teaching [him2]. "
#
#	if stress < 10+person.wit/2 || counter < 4:
#		self.mood -= 1
#		self.stress += 10 - person.wit/15
#		text += "[name2] learns new things under your watch. " 
#		if person.traits.has("Clever"):
#			text += "\n[Clever]Bonus points"
#	else:
#		text += "[name2] looks heavily bored, not taking the lesson seriously. " 
#
#	if drunkness > 0:
#		text += "\nLesson was less effective due to [name2]'s alcohol intoxication. "
#
#	return text

func gift(person, counter):
	var text = ''
	text += "You present [name2] with a small decorative gift. "
	
	if person.get_stat('obedience') >= 75:
		self.mood += 7
		#person.get_stat('loyalty') += 4
		text = text + "[he2] accepts your gift with a pleasant smile on [his2] face.  "
		
	else:
		text = text + "[he2] takes your gift arrogantly, barely respecting your intention. "
		self.mood += 3
	
	
	globals.resources.gold -= 10
	
	return text

func sweets(person, counter):
	var text = ''
	text += "You purchase some candies for [name2] from a local vendor. "
	
	if person.get_stat('obedience') >= 55:
		self.mood += 6
		#person.get_stat('loyalty') += 3
		text = text + "[he2] joyfull accepts them and enjoys the sweet taste.  "
		
	else:
		text = text + "[he2] takes your gift arrogantly, barely respecting your intention. "
		self.mood += 3
	
	
	globals.resources.gold -= 5
	
	return text


func tea(person, counter):
	var text = ''
	text += "You serve tea for you and [name2]. While drinking, you both chatand get a bit closer.  "
	
	if counter <= 3 || randf() >= 0.5:
		self.mood += 5
		text += "[name2] seems to be pleased with your generosity and enjoys your company. "
	else:
		self.mood += 1
	
	globals.itemdict.supply.amount -= 1
	
	return text

func wine(person, counter):
	var text = ''
	text += "You serve fresh wine for you and [name2]. "
	
	if self.mood < 5 || person.get_stat('obedience') < 80:
		text = "[he2] refuses to drink with you. "
	else:
		if counter < 3:
			text += "[he2] drinks with you and [his2] mood seems to improve."
			self.mood += 4
			drunkness += 1
		else:
			self.mood += 2
			text += "[he2] keeps you company, but the wine does not seem to affect [him2] as heavily as before. "
			drunkness += 1
		
		globals.itemdict.supply.amount -= 2
	
	if person.sextraits.has("Alcohol Intolerance"):
		drunkness += 1
	
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
	public = !public
	if public == true:
		text = "You order everyone into dungeon and make them watch over [name2]'s disgrace. "
	else:
		text = "You order everyone to get back to their business leaving you and [name2] alone. "
	return text

func updatebars():
	self.fear = person.fear

func stop(person, counter):
	var text = ''
	endencounter()
	return text

func drunkness():
	if drunkness > max(0, 2) + 1:
		person.away.duration = 1
		endencounter()
		$end/RichTextLabel.bbcode_text += decoder('\n\n[color=yellow][name2] has passed out from alcohol overdose. [/color]')

func strChange(value):
	if value > 0:
		return "+" + str(round(value))
	else:
		return str(round(value))

func calculateresults():
	var text = ''
	
	text += "\nMood Bonus: "
	text += "\n\nFinal results: "
	var dict = {}
	
	for i in dict:
		person[i] += dict[i]
	return text


func _on_finishbutton_pressed():
	get_parent()._on_mansion_pressed()
	if OS.get_name() != 'HTML5':
		yield(get_parent(),'animfinished')
	self.visible = false

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
		group = 'Actions',
		name = 'Chat',
		reqs = [],
		location = [],#empty = any
		descript = 'Have a friendly chat. Will boost Mood slightly.',
		effect = 'chat',
		#disablereqs = "!person.traits.has('Mute')",
	},
	intimate = {
		group = "Actions",
		name = 'Intimate Talk',
		descript = 'Have an intimate talk. Slightly increases Consent if mood is above low.',
		reqs = [],
		location = [],
		effect = 'intimate',
		#disablereqs = "!person.traits.has('Mute')",
	},
	touch = {
		group = "Actions",
		name = 'Touch',
		reqs = [],
		descript = 'Light physical contact',
		location = [],
		effect = 'touch',
	},
	holdhands = {
		group = "Actions",
		name = 'Hold hands',
		descript = "Take [name]'s hand into yours",
		reqs = [],
		location = ['garden','town','bedroom'],
		effect = 'holdhands',
	},
	combhair = {
		group = "Actions",
		name = 'Comb Hair',
		descript = "Comb [name]'s hair",
		reqs = [],
		location = [],
		effect = 'combhair',
	},
	hug = {
		group = "Actions",
		name = 'Hug',
		descript = "Prolonged close physical contact",
		reqs = [],
		location = [],
		effect = 'hug',
	},
	kiss = {
		group = "Actions",
		name = 'Kiss',
		descript = "Kiss [name] lightly",
		reqs = [],
		location = [],
		effect = 'kiss',
	},
	frenchkiss = {
		group = "Actions",
		name = 'French Kiss',
		descript = "Kiss [name] in an erotic manner",
		reqs = [],
		location = [],
		effect = 'frenchkiss',
	},
	pushdown = {
		group = "Actions",
		name = 'Push down',
		descript = "Force yourself on [name]",
		reqs = [],
		location = [],
		effect = 'pushdown',
	},
	proposal = {
		group = "Actions",
		name = 'Request intimacy',
		descript = "Ask [name] if they would like to be intimate",
		reqs = [],
		location = [],
		effect = 'propose',
	},
	praise = {
		group = "P&P",
		name = 'Praise',
		descript = "Praise [name] for [his] previous success to encourage further good behavior",
		reqs = [],
		location = [],
		effect = 'praise',
	},
	pathead = {
		group = "P&P",
		name = 'Pat head',
		descript = "Praise [name] and pat [his] head for [his] previous success to encourage further good behavior",
		reqs = [],
		location = [],
		effect = 'pathead',
	},
	scold = {
		group = "P&P",
		name = 'Scold',
		descript = "Scold [name] for [his] previous mistakes to re-enforce obedience",
		reqs = [],
		location = [],
		effect = 'scold',
	},
	slap = {
		group = "P&P",
		name = 'Slap',
		descript = "Slap [name] across the face to reprimand [him]. Slightly icnreases Authority.",
		reqs = [],
		location = [],
		effect = 'slap',
	},
	flagellate = {
		group = "P&P",
		name = 'Flagellate',
		descript = "Spank [name] as punishment",
		reqs = [],
		location = ['dungeon'],
		effect = 'flag',
	},
	whip = {
		group = "P&P",
		name = 'Whipping',
		descript = "Whip [name] as punishment",
		reqs = [],
		location = ['dungeon'],
		effect = 'whip',
	},
	wax = {
		group = "P&P",
		name = 'Hot Wax',
		descript = "Torture with hot wax",
		reqs = [],
		location = ['dungeon'],
		effect = 'wax',
	},
	woodenhorse = {
		group = "P&P",
		name = 'Wooden Horse',
		descript = "Torture with a wooden horse",
		reqs = [],
		location = ['dungeon'],
		effect = 'horse',
	},
	publicpunish = {
		group = "P&P",
		name = 'Invite others',
		descript = "Invite other slaves to observe [name]'s punishments. Observing punishments builds fear and stress, although, at lower rate. However, it also gives punished more stress and lowers loyalty. ",
		reqs = [],
		location = ['dungeon'],
		#reqs = "location == 'dungeon' && public == false",
		effect = 'public',
	},
	publicpunishoff = {
		group = "P&P",
		name = 'Disperse others',
		descript = "Make other slaves leave and not observe [name]'s punishments. ",
		reqs = [],
		location = ['dungeon'],
		#reqs = "location == 'dungeon' && public == true",
		effect = 'public',
	},
#	castfear = {
#		group = "P&P",
#		name = 'Cast Fear',
#		descript = "Punish [name] with Fear spell. \n[color=aqua]Costs " + str(globals.spells.spellcost(globals.spelldict.fear)) + " mana.[/color]",
#		reqs = "globals.spelldict.fear.learned == true && globals.resources.mana >= globals.spells.spellcost(globals.spelldict.fear)",
#		effect = 'castfear',
#	},
#	castsedate = {
#		group = "P&P",
#		name = 'Cast Sedation',
#		descript = "Use Sedation spell on [name]. \n[color=aqua]Costs " + str(globals.spells.spellcost(globals.spelldict.sedation)) + " mana.[/color]",
#		reqs = "globals.spelldict.sedation.learned == true && globals.resources.mana >= globals.spells.spellcost(globals.spelldict.sedation)",
#		effect = 'castsedate',
#	},
	
#
#	teach = {
#		group = "Actions",
#		name = 'Teach',
#		descript = "Teach [name] to accumulate learning points",
#		reqs = "location in ['livingroom','garden']",
#		effect = 'teach',
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
	stop = {
		group = "Actions",
		name = "Stop",
		descript = "Stop interaction and let [name] return to work.",
		reqs = [],
		location = [],
		effect = 'stop',
	},
}
