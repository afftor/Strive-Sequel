extends Node

var person

func _init():
	for i in bodypartsdata:
		for k in bodypartsdata[i].values():
			k.name = tr("BODYPART" + i.to_upper() + k.code.to_upper())
#			text += k.name + ' = "' + k.code + '",\n'
			k.chardescript = tr("BODYPART" + i.to_upper() + k.code.to_upper() + "DESCRIPT")
#	var file = File.new()
#	file.open(globals.userfolder + "storednames.ini", File.WRITE)
#	file.store_line(text)
#	file.close()

func create_character_description(character):
	var text = ''
	person = character
#
#	text += entry() + getdescription('age')
#
#	text += getdescription('hair_length') + getdescription('hair_style') + getdescription("eye_color") + getdescription("eye_shape") + getdescription('horns') + getdescription('ears')
#
#	if !person.skin_coverage.find('fur') >= 0:
#		text += getdescription('skin') 
#
#	text += getdescription("skin_coverage") + getdescription("wings") + getdescription("tail") + getdescription("height")
#
#	text += genitals() + mods() + tattoo() + piercing()
#
#	if character.bonus_description != '':
#		text += "\n\n" + character.bonus_description
	return new_charcter_description(character)

var descriptionorder = [
'entry', 'age', '[newline]', 'hair_length', 'hair_style', 'eye_color', 'eye_shape', 'horns', 'ears', 'skin', 'skin_coverage','wings', 'tail', 'height',
'[newline]','tits_size','multiple_tits','ass_size','penis_type', 'balls_size', 'has_pussy', '[newline]', 'piercing','[newline]','tattoo'
]

func new_charcter_description(character):
	var text = ''
	
	for i in descriptionorder:
		if i in ['entry','multiple_tits','piercing','tattoo']:
			var temptext = call(i)
			if temptext != "":
				text += temptext
			continue
		elif i == '[newline]':
			text += "\n\n"
			continue
		var charpart = character.get(i)
		if str(charpart) != '':
			var newtext = ' '
			if bodypartsdata[i].has(charpart):
				newtext = bodypartsdata[i][charpart].chardescript
				if bodypartsdata[i][charpart].has('combine') && str(character.get(bodypartsdata[i][charpart].combine)) != '':
					newtext = bodypartsdata[bodypartsdata[i][charpart].combine][str(charpart) + "_" + str(character.get(bodypartsdata[i][charpart].combine))].chardescript
				elif bodypartsdata[i][charpart].has('combine') && character.get(bodypartsdata[i][charpart].combine) == '':
					newtext = ' '
			elif bodypartsdata[i].has('default'):
				newtext = bodypartsdata[i].default.chardescript
			if newtext != ' ':
				text += newtext
			text += " "
	return text

func entry():
	var text = ''
	text += person.name
	if person.nickname != '':
		text += ' "' + person.nickname + '" '
	if person.surname != '':
		text += " " + person.surname + ". "
	else:
		text += ". "
	if person.professions.has('master'):
		text =  "[color=green]Mansion's [Master][/color] - " + text
	return text

var showmode = 'default'

func multiple_tits():
	var text
	if person.multiple_tits >= 1:
		if person.multiple_tits_developed == false:
			text = 'Below [his] chest you can spot [color=yellow]' + str(person.multiple_tits) + ' additional '+ globals.fastif(person.multiple_tits == 1, 'pair', 'pairs') +'[/color] of [color=yellow]rudimentary nipples[/color]. '
		else:
			text = 'Below [his] chest [he] possesses [color=yellow]' + str(person.multiple_tits) + globals.fastif(person.multiple_tits == 1, ' row', ' rows')+ '[/color] of slightly smaller [color=yellow]ripe tits[/color]. '
	else:
		text = ''
	return text


#func genitals():
#	var text = '\n'
#	if showmode == 'default':
#		text = "\n" + text + getdescription("tits_size") + gettitsextra() + getdescription("ass_size") + lowergenitals()
#		if person.pregnancy.duration > variables.pregduration/1.5:
#			text += "\n\n[His] unborn child forces [his] belly to protrude massively; [he] will give birth soon."
#		elif person.pregnancy.duration > variables.pregduration/2:
#			text += "\n\n[His] advanced pregnancy is clearly evident by the prominent bulge in [his] belly."
#		elif person.pregnancy.duration > variables.pregduration/4:
#			text += "\n\n[His] unborn fetus causes [his] belly to bulge slightly."
#		if person.has_womb == false && person.sex != 'male':
#			text += "\n\n[color=yellow][name]'s womb is sterile.[/color]"
##	else:
##		text += "Omitted. "
#
#	return text
#
#
#
#func lowergenitals():
#	var text = ''
#	if person.has_pussy == true:
#		if person.vaginal_virgin == true:
#			text = '[He] has a tight, [color=yellow]virgin pussy[/color]. '
#		else:
#			text = '[He] has a [color=yellow]normal pussy[/color] below [his] waist. '
#	if person.penis_size != '':
#		var temp = person.penis_type + '_' + person.penis_size
#		if penisdescription.has(temp):
#			text += penisdescription[temp]
#	if person.balls_size != '':
#		text += getdescription('balls_size')
#	if person.has_pussy == false && person.penis_size == '' && person.balls_size == '':
#		text += "For some reason, [his] crotch has no visible genitals. "
#	return text
#
#func getdescription(value):
#	var text
#	if descriptions.has(value) && descriptions[value].has(person[value]):
#		text = descriptions[value][person[value]]
#		text = text.split('|',true)
#		text = text[rand_range(0,text.size())]
#	elif descriptions.has(value) && descriptions[value].has('default'):
#		text = descriptions[value].default
#	else:
#		text = "[color=red]Error at getting description for " + value + ": " + person[value] + '[/color]. '
#	if text != '':
#		text += " "
#	return text
#
#
func piercing():
	var text = ""
	#add later
	if person.piercing.earlobes == 'earrings':
		text += '[His] ears are decorated with a pair of [color=aqua]fancy earrings[/color]. '
	elif person.piercing.earlobes == 'stud':
		text += '[His] ears have a pair of [color=aqua]small studs[/color] in them. '
	if person.piercing.eyebrow == 'stud':
		text += '[His] eyebrow is decorated with a [color=aqua]small stud[/color]. '
	if person.piercing.nose == 'ring':
		text += '[His] nose bears a [color=aqua]large nose ring[/color] in it. '
	elif person.piercing.nose == 'stud':
		text += '[His] nose has a [color=aqua]small stud[/color] in it. '
	if person.piercing.lips == 'ring':
		text += '[His] lip is pierced with a [color=aqua]small ring[/color]. '
	elif person.piercing.lips == 'stud':
		text += '[His] lip has a [color=aqua]small stud[/color] in it. '
	if person.piercing.tongue == 'stud':
		text += '[His] tongue has a shiny [color=aqua]stud[/color], visible when [he] talks. '
	if person.piercing.navel == 'stud':
		text += "[His] navel is pierced with a [color=aqua]small stud[/color]."

	if person.piercing.nipples == 'stud':
		text += '[His] pierced nipples are decorated with [color=aqua]a pair of small studs[/color]. '
	elif person.piercing.nipples == 'ring':
		text += '[His] pierced nipples contain a [color=aqua]pair of rings[/color]. '
	elif person.piercing.nipples == 'chain':
		text += 'Her pierced nipples are connected by a [color=aqua]small chain[/color]. '
	if person.piercing.clit == 'ring':
		text += '[His] clit is pierced with a [color=aqua]ring[/color]. '
	elif person.piercing.clit == 'stud':
		text += '[His] clit has a [color=aqua]small stud[/color] in it. '
	if person.piercing.labia == 'ring':
		text += '[His] pierced labia is decorated with [color=aqua]a pair of rings[/color]. '
	elif person.piercing.labia == 'stud':
		text += '[His] pierced labia is decorated with a [color=aqua]small stud[/color]. '
	if person.piercing.penis == 'ring':
		text += '[His] cock has a considerable [color=aqua]ring[/color] on the tip. '
	elif person.piercing.penis == 'stud':
		text += '[His] cock has a [color=aqua]stud[/color] in it. '

	if text != '':
		if globals.state.descriptsettings.piercing == true || showmode != 'default':
			text = "\n\n[url=piercing][color=#d1b970]Piercing:[/color][/url] " + text
		else:
			text = "\n[url=piercing][color=#d1b970]Piercing:[/color][/url] Omitted."
	return text

func tattoo():
	var text = ''
	#Fix later

	var sametattoo = true
	for i in person.tattoo.values():
		if person.tattoo.face != i || person.tattoo.face == 'none':
			sametattoo = false
			break
	if sametattoo == true:
		text += "[name]'s entire body is tattooed with [color=yellow]" + tattoooptions[person.tattoo.face].name + '[/color] pattern, featuring complex ' + tattoooptions[person.tattoo.face].descript + '. '
	else:
		if person.tattoo.face != 'none' && person.tattooshow.face == true:
			text += tattoosdescript.face.start + '[color=yellow]' + tattoooptions[person.tattoo.face].name + '[/color]' + tattoosdescript.face.end + tattoooptions[person.tattoo.face].descript + '. '
		if person.tattoo.chest != 'none' && person.tattooshow.chest == true:
			text += tattoosdescript.chest.start + '[color=yellow]' + tattoooptions[person.tattoo.chest].name + '[/color]' + tattoosdescript.chest.end + tattoooptions[person.tattoo.chest].descript + '. '
		if person.tattoo.arms != 'none' && person.tattooshow.arms == true:
			text += tattoosdescript.arms.start + '[color=yellow]' + tattoooptions[person.tattoo.arms].name + '[/color]' + tattoosdescript.arms.end + tattoooptions[person.tattoo.arms].descript + '. '
		if person.tattoo.waist != 'none' && person.tattooshow.waist == true:
			text += tattoosdescript.waist.start + '[color=yellow]' + tattoooptions[person.tattoo.waist].name + '[/color]' + tattoosdescript.waist.end + tattoooptions[person.tattoo.waist].descript + '. '
		if person.tattoo.legs != 'none' && person.tattooshow.legs == true:
			text += tattoosdescript.legs.start + '[color=yellow]' + tattoooptions[person.tattoo.legs].name + '[/color]' + tattoosdescript.legs.end + tattoooptions[person.tattoo.legs].descript + '. '
		if person.tattoo.ass != 'none' && person.tattooshow.ass == true:
			text += tattoosdescript.ass.start + '[color=yellow]' + tattoooptions[person.tattoo.ass].name + '[/color]' + tattoosdescript.ass.end + tattoooptions[person.tattoo.ass].descript + '. '
	if text != '':
		if globals.state.descriptsettings.tattoo == true || showmode != 'default': 
			text = "\n\n[url=tattoo][color=#d1b970]Tattoos:[/color][/url] " + text
		else:
			text = "\n[url=tattoo][color=#d1b970]Tattoos:[/color][/url] Omitted."
	return text
#
#func mods():
#	var text = ''
#
#	if person.mods.has('hollownipples') == true:
#		text += '[color=#B05DB0][His] nipples are magically modified, allowing them to stretch and be penetrated. [/color]'
#	if person.mods.has('augmentfur'):
#		text += "[color=#B05DB0][His] fur is magically augmented to provide extra protection against harmful effects.[/color]\n"
#	if person.mods.has('augmenttongue'):
#		text += "[color=#B05DB0][His] tongue is unusually long, increasing performance during oral sex [/color]\n"
#	if person.mods.has('augmentscales'):
#		text += "[color=#B05DB0][His] scales are magically modified to be thicker than normal and provide extra protection.[/color]\n"
#	if person.mods.has('augmenthearing'):
#		text += "[color=#B05DB0][His] hearing is magically augmented, increasing [his] awareness of [his] surroundings.[/color]\n"
#	if person.mods.has('augmentstr'):
#		text += "[color=#B05DB0]Through magical modification, the potential of [his] muscles has increased.[/color]\n"
#	if person.mods.has('augmentagi'):
#		text += "[color=#B05DB0]Through magical modification, [his] pre-existing limitations on [his] reflexes and flexibility no longer hold [him] back.[/color]\n"
#
#	if text != '':
#		text = "\n[url=mods]Mods: [/url]" + text
#	return text


var tattoosdescript = { #this goes like : start + tattoo theme + end + tattoo description: I.e On [his] face you see a notable nature themed tattoo, depicting flowers and vines
	face = {start = "On [his] cheek you see a notable ", end = " themed tattoo, depicting"},
	chest = {start = "[His] chest is decorated with a ", end = " tattoo, portraying"},
	waist = {start = "On the lower part of [his] back, you spot a ", end = " tattooed image of"},
	arms = {start = "[His] arm has a skillfully created ", end = " image of"},
	legs = {start = "[His] ankle holds a piece of ", end = " art, representing"},
	ass = {start = "[His] butt has a large ", end = " themed image showing "},
	}
	
var tattoooptions = {
	none = {name = 'none', descript = "", applydescript = "Select a tattoo theme."},
	nature = {name = 'nature', descript = " flowers and vines", function = "naturetattoo", applydescript = "A nature themed tattoo will increase [name]'s beauty. "},
	tribal = {name = 'tribal',descript = " totemic markings and symbols", function = "tribaltattoo", applydescript = "A tribal themed tattoo will increase [name]'s scouting performance. "},
	degrading = {name = 'derogatory', descript = " rude words and lewd drawings", function = "degradingtattoo", applydescript = "A derogatory themed tattoo will enhance [name]'s lust and enforce obedience. "},
	animalistic = {name = 'beastly', descript = " realistic beasts and insects", function = "animaltattoo", applydescript = "An animalistic themed tattoo will boost [name]'s energy regeneration. "},
	magic = {name = "energy", descript = " empowering patterns and runes", function = "manatattoo", applydescript = "A tattoo consisting of magic runes will increase [name]'s Magic Affinity. "},
	}


var bodypartsdata = {
	age = {
		teen = {code = 'teen', name = '', chardescript = '', bodychanges = []},
		adult = {code = 'adult', name = '', chardescript = '', bodychanges = []},
		mature = {code = 'mature', name = '', chardescript = '', bodychanges = []},
	},
	body_shape = {
		humanoid = {code = 'humanoid', name = '', chardescript = '', bodychanges = []},
		bestial = {code = 'bestial', name = '', chardescript = '', bodychanges = []},
		shortstack = {code = 'shortstack', name = '', chardescript = '', bodychanges = []},
		jelly = {code = 'jelly', name = '', chardescript = '', bodychanges = []},
		halfbird = {code = 'halfbird', name = '', chardescript = '', bodychanges = []},
		halfsnake = {code = 'halfsnake', name = '', chardescript = '', bodychanges = []},
		halffish = {code = 'halffish', name = '', chardescript = '', bodychanges = []},
		halfspider = {code = 'halfspider', name = '', chardescript = '', bodychanges = []},
		halfhorse = {code = 'halfhorse', name = '', chardescript = '', bodychanges = []},
		halfsquid = {code = 'halfsquid', name = '', chardescript = '', bodychanges = []},
	},
	hair_length = {
		ear = {code = 'ear', name = '', chardescript = '', bodychanges = []}, 
		neck = {code = 'neck', name = '', chardescript = '', bodychanges = []},
		shoulder = {code = 'shoulder', name = '', chardescript = '', bodychanges = []},
		waist = {code = 'waist', name = '', chardescript = '', bodychanges = []},
		hips = {code = 'hips', name = '', chardescript = '', bodychanges = []},
	},
	hair_style = {
		straight = {code = 'straight', name = '', chardescript = '', bodychanges = []},
		ponytail = {code = 'ponytail', name = '', chardescript = '', bodychanges = []},
		pigtails = {code = 'pigtails', name = '', chardescript = '', bodychanges = []},
		braid = {code = 'braid', name = '', chardescript = '', bodychanges = []},
		twinbraids = {code = 'twinbraids', name = '', chardescript = '', bodychanges = []},
		bun = {code = 'bun', name = '', chardescript = '', bodychanges = []},
	},
	eye_color = {
		default = {code = 'default', name = '', chardescript = '', bodychanges = []},
	},
	eye_shape = {
		normal = {code = 'normal', name = '', chardescript = '', bodychanges = []},
		slit = {code = 'slit', name = '', chardescript = '', bodychanges = []},
	},
	horns = {
		short = {code = 'short', name = '', chardescript = '', bodychanges = []},
		straight = {code = 'straight', name = '', chardescript = '', bodychanges = []},
		curved = {code = 'curved', name = '', chardescript = '', bodychanges = []},
	},
	ears = {
		human = {code = 'human', name = '', chardescript = '', bodychanges = []},
		elven = {code = 'elven', name = '', chardescript = '', bodychanges = []},
		orcish = {code = 'orcish', name = '', chardescript = '', bodychanges = []},
		cat = {code = 'cat', name = '', chardescript = '', bodychanges = []},
		wolf = {code = 'wolf', name = '', chardescript = '', bodychanges = []},
		fox = {code = 'fox', name = '', chardescript = '', bodychanges = []},
		bunny_standing = {code = 'bunny_standing', name = '', chardescript = '', bodychanges = []},
		bunny_drooping = {code = 'bunny_drooping', name = '', chardescript = '', bodychanges = []},
		tanuki = {code = 'tanuki', name = '', chardescript = '', bodychanges = []},
		demon = {code = 'demon', name = '', chardescript = '', bodychanges = []},
		cow = {code = 'cow', name = '', chardescript = '', bodychanges = []},
		feathered = {code = 'feathered', name = '', chardescript = '', bodychanges = []},
		fish = {code = 'fish', name = '', chardescript = '', bodychanges = []},
	},
	skin = {
		pale = {code = 'pale', name = '', chardescript = '', bodychanges = []},
		grey = {code = 'grey', name = '', chardescript = '', bodychanges = []},
		fair = {code = 'fair', name = '', chardescript = '', bodychanges = []},
		olive = {code = 'olive', name = '', chardescript = '', bodychanges = []},
		tan = {code = 'tan', name = '', chardescript = '', bodychanges = []},
		brown = {code = 'brown', name = '', chardescript = '', bodychanges = []},
		dark = {code = 'dark', name = '', chardescript = '', bodychanges = []},
		slime = {code = 'slime', name = '', chardescript = '', bodychanges = []},
		blue = {code = 'blue', name = '', chardescript = '', bodychanges = []},
		paleblue = {code = 'paleblue', name = '', chardescript = '', bodychanges = []},
		green = {code = 'green', name = '', chardescript = '', bodychanges = []},
		red = {code = 'red', name = '', chardescript = '', bodychanges = []},
		purple = {code = 'purple', name = '', chardescript = '', bodychanges = []},
		teal = {code = 'teal', name = '', chardescript = '', bodychanges = []},
	},
	skin_coverage = {
		plant = {code = 'plant', name = '', chardescript = '', bodychanges = []},
		scale = {code = 'scale', name = '', chardescript = '', bodychanges = []},
		feathers = {code = 'feathers', name = '', chardescript = '', bodychanges = []},
		fur_white = {code = 'fur_white', name = '', chardescript = '', bodychanges = []},
		fur_grey = {code = 'fur_grey', name = '', chardescript = '', bodychanges = []},
		fur_brown = {code = 'fur_brown', name = '', chardescript = '', bodychanges = []},
		fur_striped = {code = 'fur_striped', name = '', chardescript = '', bodychanges = []},
		fur_black = {code = 'fur_black', name = '', chardescript = '', bodychanges = []},
		fur_orange = {code = 'fur_orange', name = '', chardescript = '', bodychanges = []},
		fur_orange_white = {code = 'fur_orange_white', name = '', chardescript = '', bodychanges = []},
	},
	wings = {
		feathered_black = {code = 'feathered_black', name = '', chardescript = '', bodychanges = []},
		seraph = {code = 'seraph', name = '', chardescript = '', bodychanges = []},
		feathered_brown = {code = 'feathered_brown', name = '', chardescript = '', bodychanges = []},
		fairy = {code = 'fairy', name = '', chardescript = '', bodychanges = []},
		demon = {code = 'demon', name = '', chardescript = '', bodychanges = []},
		dragon = {code = 'dragon', name = '', chardescript = '', bodychanges = []},
		leather_black = {code = 'leather_black', name = '', chardescript = '', bodychanges = []},
		leather_red = {code = 'leather_red', name = '', chardescript = '', bodychanges = []},
	},
	tail = {
		cat = {code = 'cat', name = '', chardescript = '', bodychanges = []},
		fox = {code = 'fox', name = '', chardescript = '', bodychanges = []},
		wolf = {code = 'wolf', name = '', chardescript = '', bodychanges = []},
		bunny = {code = 'bunny', name = '', chardescript = '', bodychanges = []},
		tanuki = {code = 'tanuki', name = '', chardescript = '', bodychanges = []},
		cow = {code = 'cow', name = '', chardescript = '', bodychanges = []},
		demon = {code = 'demon', name = '', chardescript = '', bodychanges = []},
		dragon = {code = 'dragon', name = '', chardescript = '', bodychanges = []},
		avian = {code = 'avian', name = '', chardescript = '', bodychanges = []},
		fish = {code = 'fish', name = '', chardescript = '', bodychanges = []},
		snake = {code = 'snake', name = '', chardescript = '', bodychanges = []},
		tentacles = {code = 'tentacles', name = '', chardescript = '', bodychanges = []},
		horse = {code = 'horse', name = '', chardescript = '', bodychanges = []},
		spider = {code = 'spider', name = '', chardescript = '', bodychanges = []},
	},
	height = {
		tiny = {code = 'tiny', name = '', chardescript = '', bodychanges = []},
		petite = {code = 'petite', name = '', chardescript = '', bodychanges = []},
		short = {code = 'short', name = '', chardescript = '', bodychanges = []},
		average = {code = 'average', name = '', chardescript = '', bodychanges = []},
		tall = {code = 'tall', name = '', chardescript = '', bodychanges = []},
		towering = {code = 'towering', name = '', chardescript = '', bodychanges = []},
	},
	tits_size = {
		flat = {code = 'flat', name = '', chardescript = '', bodychanges = []},
		small = {code = 'small', name = '', chardescript = '', bodychanges = []},
		average = {code = 'average', name = '', chardescript = '', bodychanges = []},
		big = {code = 'big', name = '', chardescript = '', bodychanges = []},
		huge = {code = 'huge', name = '', chardescript = '', bodychanges = []},
		masculine = {code = 'masculine', name = '', chardescript = '', bodychanges = []},
	},
	ass_size = {
		flat = {code = 'flat', name = '', chardescript = '', bodychanges = []},
		small = {code = 'small', name = '', chardescript = '', bodychanges = []},
		average = {code = 'average', name = '', chardescript = '', bodychanges = []},
		big = {code = 'big', name = '', chardescript = '', bodychanges = []},
		huge = {code = 'huge', name = '', chardescript = '', bodychanges = []},
		masculine = {code = 'masculine', name = '', chardescript = '', bodychanges = []},
	},
	balls_size = {
		small = {code = 'small', name = '', chardescript = '', bodychanges = []},
		average = {code = 'average', name = '', chardescript = '', bodychanges = []},
		big = {code = 'big', name = '', chardescript = '', bodychanges = []},
	},
	penis_type = {
		human = {code = 'human', combine = 'penis_size'},
		canine = {code = 'canine', combine = 'penis_size'},
		feline = {code = 'feline', combine = 'penis_size'},
		equine = {code = 'equine', combine = 'penis_size'},
	},
	penis_size = {
		human_small = {code = 'human_small', name = '', chardescript = '', bodychanges = []},
		human_average = {code = 'human_average', name = '', chardescript = '', bodychanges = []},
		human_big = {code = 'human_big', name = '', chardescript = '', bodychanges = []},
		canine_small = {code = 'canine_small', name = '', chardescript = '', bodychanges = []},
		canine_average = {code = 'canine_average', name = '', chardescript = '', bodychanges = []},
		canine_big = {code = 'canine_big', name = '', chardescript = '', bodychanges = []},
		feline_small = {code = 'feline_small', name = '', chardescript = '', bodychanges = []},
		feline_average = {code = 'feline_average', name = '', chardescript = '', bodychanges = []},
		feline_big = {code = 'feline_big', name = '', chardescript = '', bodychanges = []},
		equine_small = {code = 'equine_small', name = '', chardescript = '', bodychanges = []},
		equine_average = {code = 'equine_average', name = '', chardescript = '', bodychanges = []},
		equine_big = {code = 'equine_big', name = '', chardescript = '', bodychanges = []},
		
	},
	has_pussy = {
		true : {code = 'true', combine = "vaginal_virgin"},
		false : {code = 'false', name = '', chardescript = '', bodychanges = []},
		
	},
	vaginal_virgin = {
		True_True = {code = 'true_true', name = '', chardescript = '', bodychanges = []},
		True_False = {code = 'true_False', name = '', chardescript = '', bodychanges = []},
	}
	
}


#
#var penisdescription = {
#	human_small = 'Below [his] waist dangles a [color=yellow]tiny humanish dick[/color], small enough that it could be called cute. ',
#	human_average ='[He] has an [color=yellow]ordinary humanish penis[/color] below [his] waist, more than enough to make most men proud. ',
#	human_big = 'A [color=yellow]huge humanish cock[/color] swings heavily from [his] groin, big enough to give even the most veteran whore pause. ',
#	canine_small = 'A slender, pointed [color=yellow]canine dick[/color] hangs below [his] waist, so small that its knot is barely noticeable. ',
#	canine_average = '[He] has a knobby, red, [color=yellow]canine cock[/color] of respectable size below [his] waist, which wouldn’t look out of place on a large dog. ', 
#	canine_big = 'Growing from [his] crotch is a [color=yellow]massive canine dick[/color], red-skinned and sporting a thick knot near the base. ',
#	feline_small = 'A [color=yellow]tiny feline penis[/color] dangles below [his] waist, so small you can barely see the barbs. ',
#	feline_average = '[He] has a barbed [color=yellow]cat dick[/color] growing from [his] crotch, big enough to rival an average human. ',
#	feline_big = 'There is a frighteningly [color=yellow]large feline cock[/color] hanging between [his] thighs, its sizable barbs making it somewhat intimidating. ', 
#	equine_small = 'Below [his] waist hangs a [color=yellow]smallish equine cock[/color], which is still respectable compared to the average man. ',
#	equine_average= 'A [color=yellow]sizable equine cock[/color] grows from [his] nethers, which, while small on a horse, is still thicker and heavier than the average human tool. ',
#	equine_big = 'A [color=yellow]massive equine cock[/color] hangs heavily below [his] waist, its mottled texture not quite matching the rest of [his] skin. ',
#}
#
#
#var descriptions = {
#"age": {
#"teen": "[He]'s a [color=aqua]teenage [boy][/color] of the [url=race][color=yellow][raceadj] race[/color][/url].",
#"adult": "[He]'s a [color=aqua]young adult [male][/color] of the [url=race][color=yellow][raceadj] race[/color][/url].",
#"mature": "[He]'s a [color=aqua]matured [male][/color] of the [url=race][color=yellow][raceadj] race[/color][/url]."
#},
#"body_shape": {
#"humanoid": "",
#"bestial": "",
#"shortstack": "[His] body is rather [color=yellow]petite[/color], about half the size of the average person.",
#"jelly": "[His] body is [color=yellow]jelly-like[/color] and partly transparent.",
#"halfbird": "[His] body has [color=yellow]wings for arms and avian legs[/color] making everyday tasks difficult.",
#"halfsnake": "The lower portion of [his] body consists of a long-winding [color=yellow]snake’s tail[/color].",
#"halffish": "[His] body is [color=yellow]scaly and sleek[/color], possessing fins and webbed digits.",
#"halfspider": "The lower portion of [his] body consists of a [color=yellow]spider's legs and abdomen[/color].",
#"halfhorse": "While [his] upper body is human, [his] lower body is [color=yellow]equine[/color] in nature.",
#"halfsquid": "The lower portion of [his] body consists of a [color=yellow]number of tentacular appendages[/color], similar to those of an octopus."
#},
#
#"hair_length": {
#"ear": "[His] [color=aqua][hair_color][/color] hair is cut [color=aqua]short[/color].",
#"neck": "[His] [color=aqua][hair_color][/color] hair falls down to just [color=aqua]below [his] neck[/color].",
#"shoulder": "[His] wavy [color=aqua][hair_color][/color] hair is [color=aqua]shoulder length[/color].",
#"waist": "[His] gorgeous [color=aqua][hair_color][/color] hair [color=aqua]sways down to [his] waist[/color].",
#"hips": "[His] [color=aqua][hair_color][/color] hair cascades down, [color=aqua]reaching [his] hips[/color]."
#},
#"hair_style": {
#"straight": "It [color=aqua]hangs freely[/color] from [his] head.",
#"ponytail": "It is tied in a [color=aqua]high ponytail[/color].",
#"pigtails": "It is managed in girly [color=aqua]twin-tails[/color].",
#"braid": "It is combed into a single [color=aqua]braid[/color].",
#"twinbraids": "It is combed into [color=aqua]two braids[/color].",
#"bun": "It is tied into a neat [color=aqua]bun[/color]."
#},
#"eye_color": {
#"default": "[His] eyes are [color=aqua][eye_color][/color]."
#},
#"eye_shape": {
#"normal": "",
#"slit": "[He] has [color=aqua]vertical, animalistic pupils[/color]."
#},
#"horns": {
#"": "",
#"short": "There is a pair of [color=aqua]tiny, pointed horns[/color] on top of [his] head.",
#"straight": "[He] has a pair of [color=aqua]long, bull-like horns[/color].",
#"curved": "There are [color=aqua]curved horns[/color] coiling around [his] head."
#},
#"ears": {
#"human": "",
#"normal": "",
#"elven": "[He] has straight long [color=aqua]pointed[/color] ears.",
#"orcish": "[He] has [color=aqua]stubby pointed[/color] ears.",
#"cat": "[He] has a pair of perky [color=aqua]cat[/color] ears.",
#"wolf": "[He] has a pair of stubby [color=aqua]wolf[/color] ears.",
#"fox": "[He] has a pair of long expressive [color=aqua]fox[/color] ears.",
#'bunny_standing' : "[He] has a pair of [color=aqua]standing bunny ears[/color] rising above [his] head.",
#'bunny_drooping' : "[He] has a pair of [color=aqua]droopy, bunny ears[/color] on [his] head.",
#"tanuki": "[He] has a pair of rounded [color=aqua]racoon[/color] ears.",
#"demon": "[He] has a pair of [color=aqua]demonic[/color] ears.",
#"cow": "[He] has a pair of fluffy [color=aqua]cow[/color] ears.",
#"feathered": "There's a pair of clutched [color=aqua]feathery ears[/color] on the sides of [His] head.",
#"fish": "[His] ears look like a pair of [color=aqua]fins[/color]."
#},
#"skin": {
#"pale": "[His] skin is a [color=aqua]pale[/color] white.",
#"grey": "[His] skin is a stone [color=aqua]grey[/color].",
#"fair": "[His] skin is healthy and [color=aqua]fair[/color] color.",
#"olive": "[His] skin is of an unusual [color=aqua]olive[/color] tone.",
#"tan": "[His] skin is a [color=aqua]tanned[/color] bronze color.",
#"brown": "[His] skin is a mixed [color=aqua]brown[/color] color.",
#"dark": "[His] skin is deep [color=aqua]dark[/color].",
#"slime": "[His] skin is [color=aqua]semi-transparent and jelly-like[/color].",
#"blue": "[His] skin is dark [color=aqua]blue[/color].",
#"pale blue": "[His] skin is [color=aqua]light pale blue[/color].",
#"green": "[His] skin is [color=aqua]green[/color].",
#"red": "[His] skin is bright [color=aqua]red[/color].",
#"purple": "[His] skin is [color=aqua]purple[/color].",
#"teal": "[His] skin is [color=aqua]teal[/color]."
#},
#"skin_coverage": {
#"": "",
#"plant": "Various leaves and bits of [color=aqua]plant matter[/color] cover parts of [his] body.",
#"scale": "[His] skin is partly covered with [color=aqua]scales[/color].",
#"feathers": "[His] body is covered in [color=aqua]bird-like feathers[/color] in many places.",
##"full_body_fur": "[His] body is covered in thick, soft [color=aqua]fur of [furcolor]",
#'fur_white':"[His] body is covered in thick, soft [color=aqua]fur of marble color[/color].",
#'fur_grey':"[His] body is covered in thick, soft [color=aqua]fur of gray color[/color].",
#'fur_brown':"[His] body is covered in thick, soft [color=aqua]fur of light-brown tone[/color].",
#'fur_striped':"[His] body is covered in thick, soft [color=aqua]striped fur[/color].",
#'fur_black':"[His] body is covered in thick, soft [color=aqua]fur of jet-black color[/color].",
#'fur_orange':"[His] body is covered in thick, soft [color=aqua]fur of common fox pattern[/color].",
#'fur_orange_white': "[His] body is covered in thick, soft [color=aqua]fur of orange-white pattern[/color].",
#},
#"fur_color": {
#"": "",
#"white": "marble color[/color].",
#"gray": "gray color[/color].",
#"orange_white": "orange-white pattern[/color].",
#"black_white": "black-white pattern[/color].",
#"black_gray": "black-gray pattern[/color].",
#"black": "jet-black color[/color].",
#"orange": "common fox pattern[/color].",
#"brown": "light-brown tone[/color]."
#},
#"wings": {
#"": "",
#"feathered_black": "On [his] back, [he] has folded, [color=aqua]black, feathery wings[/color].",
#"seraph": "On [his] back, [he] has folded, [color=aqua]white, feathery wings[/color].",
#"feathered_brown": "On [his] back, [he] has folded, [color=aqua]brown, feathery wings[/color].",
#"fairy": "On [his] back rests translucent [color=aqua]fairy wings[/color].",
#"demon": "Hidden on [his] back is a pair of bat-like, [color=aqua]demon wings[/color].",
#"dragon": "Hidden on [his] back is a pair of thick, [color=aqua]dragon wings[/color].",
#"leather_black": "Hidden on [his] back is a pair of bat-like, [color=aqua]black leather wings[/color].",
#"leather_red": "Hidden on [his] back is a pair of bat-like, [color=aqua]red leather wings[/color]."
#},
#tail = {
#	'' : '',
#	cat = 'Below [his] waist, you spot a slim [color=aqua]cat tail[/color] covered with fur.',
#	fox = '[He] has a large, fluffy [color=aqua]fox tail[/color].',
#	wolf = "Below [his] waist there's a short, fluffy, [color=aqua]wolf tail[/color].",
#	bunny = '[He] has a [color=aqua]small ball of fluff[/color] behind [his] rear.',
#	tanuki = '[He] has a plump, fluffy [color=aqua]raccoon tail[/color].',
#	cow = 'Behind [his] back you notice a long tail covered in a thin layer of fur which ends in a [color=aqua]scruffy brush[/color].',
#	demon = '[He] has a long, thin, [color=aqua]demonic tail[/color] ending in a pointed tip.',
#	dragon = 'Trailing somewhat behind [his] back is a [color=aqua]scaled tail[/color].',
#	avian = '[He] has a [color=aqua]feathery bird tail[/color] on [his] rear.', 
#	fish = '[His] rear ends in long, sleek [color=aqua]fish tail[/color].', 
#	"snake tail" : '',
#	tentacles = '',
#	horse = '',
#	"spider abdomen" : ''
#},
#"height": {
#"tiny": "[His] stature is [color=aqua]extremely small[/color], barely half the size of a normal person.",
#"petite": "[His] stature is quite [color=aqua]petite[/color].",
#"short": "[His] height is quite [color=aqua]short[/color].",
#"average": "[He] is of [color=aqua]average[/color] height.",
#"tall": "[He] is quite [color=aqua]tall[/color] compared to the average person.",
#"towering": "[He] is unusually tall, [color=aqua]towering[/color] over others."
#},
#"tits_size": {
#"flat": "[His] chest is barely visible and nearly [color=yellow]flat[/color].",
#"small": "[He] has [color=yellow]small[/color], round boobs.",
#"average": "[His] nice, [color=yellow]perky[/color] breasts are firm and inviting.",
#"big": "[His] [color=yellow]big[/color] tits are pleasantly soft, but still have a nice spring to them.",
#"huge": "[His] [color=yellow]giant[/color] tits are mind-blowingly big.",
#"masculine": "[His] chest is of definitive [color=yellow]masculine[/color] shape."
#},
#"ass_size": {
#"flat": "[His] butt is skinny and [color=yellow]flat[/color].",
#"small": "[He] has a [color=yellow]small[/color], firm butt.",
#"average": "[He] has a nice, [color=yellow]pert[/color] ass you could bounce a coin off.",
#"big": "[He] has a pleasantly [color=yellow]plump[/color], heart-shaped ass that jiggles enticingly with each step.",
#"huge": "[He] has a [color=yellow]huge[/color], attention-grabbing ass.",
#"masculine": "[His] ass definitively has a [color=yellow]masculine[/color] shape."
#},
#"balls_size": {
#"small": "[He] has a pair of [color=yellow]tiny[/color] balls.",
#"average": "[He] has an [color=yellow]average-sized[/color] ballsack.",
#"big": "[He] has a [color=yellow]huge[/color] pair of balls weighing down [his] scrotum."
#},
#"penis_type": {
#	"human": {
#	"small": "Below [his] waist dangles a [color=yellow]tiny humanish dick[/color], small enough that it could be called cute.",
#	"average": "[He] has an [color=yellow]ordinary humanish penis[/color] below [his] waist, more than enough to make most men proud.",
#	"big": "A [color=yellow]huge humanish cock[/color] swings heavily from [his] groin, big enough to give even the most veteran whore pause."
#	},
#	"canine": {
#	"small": "A slender, pointed [color=yellow]canine dick[/color] hangs below [his] waist, so small that its knot is barely noticeable.",
#	"average": "[He] has a knobby, red, [color=yellow]canine cock[/color] of respectable size below [his] waist, which wouldn’t look out of place on a large dog.", 
#	"big": "Growing from [his] crotch is a [color=yellow]massive canine dick[/color], red-skinned and sporting a thick knot near the base."
#	},
#	"feline": {
#	"small": "A [color=yellow]tiny feline penis[/color] dangles below [his] waist, so small you can barely see the barbs.",
#	"average": "[He] has a barbed [color=yellow]cat dick[/color] growing from [his] crotch, big enough to rival an average human.",
#	"big": "There is a frighteningly [color=yellow]large feline cock[/color] hanging between [his] thighs, its sizable barbs making it somewhat intimidating."
#	},
#	"equine": {
#	"small": "Below [his] waist hangs a [color=yellow]smallish equine cock[/color], which is still respectable compared to the average man.",
#	"average": "A [color=yellow]sizable equine cock[/color] grows from [his] nethers, which, while small on a horse, is still thicker and heavier than the average human tool.",
#	"big":  "A [color=yellow]massive equine cock[/color] hangs heavily below [his] waist, its mottled texture not quite matching the rest of [his] skin."
#}
#}
#}
#
