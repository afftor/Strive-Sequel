extends Node

var person

func _init():
	for i in bodypartsdata:
		for k in bodypartsdata[i].values():
			if k.code != null:
				if !k.has('name') or k.name == "":
					k.name = tr("BODYPART" + i.to_upper() + k.code.to_upper())
#				text += k.name + ' = "' + k.code + '",\n'
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
'entry', 'age', '[newline]', 'hair_length', 'hair_style', 'eye_color', 'eye_shape', 'body_shape', 'horns', 'ears', '[skin_coverage]', 'body_color_skin', 'skin_coverage','wings', 'tail', 'height', 
'[newline]','tits_size','multiple_tits','lactation','pregnancy','ass_size','[allowed_sex]','penis_type','[allowed_sex]', 'balls_size','[allowed_sex]', 'has_pussy','[allowed_sex]', "anal_virgin", '[newline]','slave_status', 'piercing','[newline]','tattoo','[newline]','[bonus]'
]

func new_charcter_description(character):
	var text = ''

	var check_allowed_sex = false
	var add_no_sex_descript = false
	var check_skin_coverage = false

	for i in descriptionorder:
		if i in ['entry','pregnancy','multiple_tits','lactation','piercing','tattoo','slave_status']:
			var temptext = call(i)
			if temptext != "":
				text += temptext
			continue
		elif i == '[newline]':
			if text.ends_with("\n\n") == false:
				text += "\n\n"
			continue
		elif i == '[allowed_sex]':
			check_allowed_sex = true
			continue
		elif i == '[skin_coverage]':
			check_skin_coverage = true
			continue
		elif i == '[bonus]':
			if !character.get_stat('bonus_description').begins_with("#"):
				text += character.get_stat('bonus_description')
			continue
		elif check_skin_coverage == true:
			check_skin_coverage = false
			if character.get_stat("skin_coverage") in variables.skin_coverage_false:
				continue
		elif check_allowed_sex == true && (person.has_status("no_sex") || (person.is_players_character == false && person.is_known_to_player == false)):
			check_allowed_sex = false
			if add_no_sex_descript == false:
				text += tr("NOSEXDETAILSDESCRIPT")
				add_no_sex_descript = true
			continue
		elif i == 'hair_style' && person.get_stat('hair_length') == 'bald':
			continue
		var charpart = character.get_stat(i)
		if str(charpart) != '':
			var newtext = ''
			if bodypartsdata[i].has(charpart):
				newtext = bodypartsdata[i][charpart].chardescript
				if bodypartsdata[i][charpart].has('combine') && str(character.get_stat(bodypartsdata[i][charpart].combine)) != '':
					newtext = bodypartsdata[bodypartsdata[i][charpart].combine][str(charpart) + "_" + str(character.get_stat(bodypartsdata[i][charpart].combine))].chardescript
				elif bodypartsdata[i][charpart].has('combine') && character.get_stat(bodypartsdata[i][charpart].combine) == '':
					newtext = ''
			elif bodypartsdata[i].has('default'):
				newtext = bodypartsdata[i].default.chardescript
			if !newtext in ["", " "]:
				text += newtext + " "
	
	text = input_handler.text_cut_excessive_lines(text)
	return text

func entry():
	var text = ''
	text += person.get_full_name() + ". "
	if person.has_profession('master'):
		text = "[color=green]Mansion's [Master][/color] - " + text
	return ""

var showmode = 'default'

func multiple_tits():
	var text
	if person.get_stat('multiple_tits') >= 1:
		if person.get_stat('multiple_tits_developed') == false:
			text = 'Below [his] chest you can spot [color=yellow]' + str(person.get_stat('multiple_tits')) + ' additional '+ globals.fastif(person.get_stat('multiple_tits') == 1, 'pair', 'pairs') +'[/color] of [color=yellow]rudimentary nipples[/color]. '
		else:
			text = 'Below [his] chest [he] possesses [color=yellow]' + str(person.multiple_tits) + globals.fastif(person.get_stat('multiple_tits') == 1, ' row', ' rows')+ '[/color] of slightly smaller [color=yellow]ripe tits[/color]. '
	else:
		text = ''
	return text

func lactation():
	var text
	if person.get_stat('lactation') == true:
		text = "[His] nipples are {color=yellow|secreting milk}. "
	else:
		text = ''
	return text

func slave_status():
	if person.is_players_character == false || person.get_stat('slave_class') == 'master':
		return ''
	
	var text = "{color=yellow|" + tr("DESCRIPTCLASS" + person.get_stat("slave_class").to_upper()) + "}"
#	match person.get_stat("slave_class"):
#		'slave':
#			text = tr("DESCRIPTCLASSSLAVE")
#		'peon':
#			text = ''
#		'merc':
#			text = ''
	#elif person.
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

func pregnancy():
	var text = ''
	if person.get_stat('pregnancy_duration') > 0 :
		if variables.pregduration/3 > person.get_stat('pregnancy_duration'):
			text += tr("BODYPARTPREGLINELATE")

		elif variables.pregduration/1.5 > person.get_stat('pregnancy_duration'):
			text += tr("BODYPARTPREGLINEEARLY")



	return text

func piercing(): #currently unused
	var text = ""
	#add later
	if person.get_stat('piercing_earlobes') == 'earrings':
		text += '[His] ears are decorated with a pair of [color=aqua]fancy earrings[/color]. '
	elif person.get_stat('piercing_earlobes') == 'stud':
		text += '[His] ears have a pair of [color=aqua]small studs[/color] in them. '
	if person.get_stat('piercing_eyebrow') == 'stud':
		text += '[His] eyebrow is decorated with a [color=aqua]small stud[/color]. '
	if person.get_stat('piercing_nose') == 'ring':
		text += '[His] nose bears a [color=aqua]large nose ring[/color] in it. '
	elif person.get_stat('piercing_nose') == 'stud':
		text += '[His] nose has a [color=aqua]small stud[/color] in it. '
	if person.get_stat('piercing_lips') == 'ring':
		text += '[His] lip is pierced with a [color=aqua]small ring[/color]. '
	elif person.get_stat('piercing_lips') == 'stud':
		text += '[His] lip has a [color=aqua]small stud[/color] in it. '
	if person.get_stat('piercing_tongue') == 'stud':
		text += '[His] tongue has a shiny [color=aqua]stud[/color], visible when [he] talks. '
	if person.get_stat('piercing_navel') == 'stud':
		text += "[His] navel is pierced with a [color=aqua]small stud[/color]."

	if person.get_stat('piercing_nipples') == 'stud':
		text += '[His] pierced nipples are decorated with [color=aqua]a pair of small studs[/color]. '
	elif person.get_stat('piercing_nipples') == 'ring':
		text += '[His] pierced nipples contain a [color=aqua]pair of rings[/color]. '
	elif person.get_stat('piercing_nipples') == 'chain':
		text += 'Her pierced nipples are connected by a [color=aqua]small chain[/color]. '
	if person.get_stat('piercing_clit') == 'ring':
		text += '[His] clit is pierced with a [color=aqua]ring[/color]. '
	elif person.get_stat('piercing_clit') == 'stud':
		text += '[His] clit has a [color=aqua]small stud[/color] in it. '
	if person.get_stat('piercing_labia') == 'ring':
		text += '[His] pierced labia is decorated with [color=aqua]a pair of rings[/color]. '
	elif person.get_stat('piercing_labia') == 'stud':
		text += '[His] pierced labia is decorated with a [color=aqua]small stud[/color]. '
	if person.get_stat('piercing_penis') == 'ring':
		text += '[His] cock has a considerable [color=aqua]ring[/color] on the tip. '
	elif person.get_stat('piercing_penis') == 'stud':
		text += '[His] cock has a [color=aqua]stud[/color] in it. '

	if text != '':
		#posible bug
		if globals.state.descriptsettings.piercing == true || showmode != 'default':
			text = "\n\n[url=piercing][color=#d1b970]Piercing:[/color][/url] " + text
		else:
			text = "\n[url=piercing][color=#d1b970]Piercing:[/color][/url] Omitted."
	return text

#var tattoo_descripts = {
#	face_makeup = "[His] face has permanent makeup accentuating on [his] beauty.",
#	face_tribal = "[His] face is painted with tribal markings.",
#	neck_branding = "[His] neck features a slave brand with your name on it.",
#	chest_lust = "[His] chest is decorated with a lewd marks emphasizing [his] nipples.",
#	chest_tribal = "[His] chest is camouflaged with tribal markings.",
#	waist_hp = "Back of [his] waist holds an delicate plant tattoo.",
#	waist_mp = "Back of [his] waist is decorated with glowing energy lines.",
#	arms_hp = "[His] arms are decorated with elegant plant tattoos.",
#	arms_mp = "[His] arms feature glowing energy lines.",
#	arms_tribal = "[His] arms are painted with tribal markings.",
#	ass_branding = "[His] ass cheek has a slave brand with your name on it.",
#	ass_lust = "[His] rear is decorated with a lewd crest.",
#	crotch_branding = "[His] crotch has a slave brand with your name on it.",
#	crotch_lust = "[His] crotch is tattooed with a lewd crest.",
#	legs_hp = "[His] legs are decorated with a elegant plant tattoos.",
#	legs_mp = "[His] legs feature glowing energy lines.",
#	legs_tribal = "[His] legs are painted with tribal markings.",
#}



func tattoo():
	var text = ''
	for slot in person.get_filled_tattoos():
		text += tr("DESCRIPTTATOO" + (slot.trim_prefix('tattoo_') + "_" + person.get_tattoo(slot).replace("ink_",'')).to_upper()) + " "
	if text.length()> 0:
		return "{color=magenta|" + text + "}"
	else:
		return text
	#Fix later
#	var tmp = person.get_stat('tattoo')
#	var tmp1 = person.get_stat('tattooshow')
#	var sametattoo = true
#	for i in tmp.values():
#		if tmp.face != i || tmp.face == 'none':
#			sametattoo = false
#			break
#	if sametattoo == true:
#		text += "[name]'s entire body is tattooed with [color=yellow]" + tattoooptions[tmp.face].name + '[/color] pattern, featuring complex ' + tattoooptions[tmp.face].descript + '. '
#	else:
#		if tmp.face != 'none' && tmp1.face == true:
#			text += tattoosdescript.face.start + '[color=yellow]' + tattoooptions[tmp.face].name + '[/color]' + tattoosdescript.face.end + tattoooptions[tmp.face].descript + '. '
#		if tmp.chest != 'none' && tmp1.chest == true:
#			text += tattoosdescript.chest.start + '[color=yellow]' + tattoooptions[tmp.chest].name + '[/color]' + tattoosdescript.chest.end + tattoooptions[tmp.chest].descript + '. '
#		if tmp.arms != 'none' && tmp1.arms == true:
#			text += tattoosdescript.arms.start + '[color=yellow]' + tattoooptions[tmp.arms].name + '[/color]' + tattoosdescript.arms.end + tattoooptions[tmp.arms].descript + '. '
#		if tmp.waist != 'none' && tmp1.waist == true:
#			text += tattoosdescript.waist.start + '[color=yellow]' + tattoooptions[tmp.waist].name + '[/color]' + tattoosdescript.waist.end + tattoooptions[tmp.waist].descript + '. '
#		if tmp.legs != 'none' && tmp1.legs == true:
#			text += tattoosdescript.legs.start + '[color=yellow]' + tattoooptions[tmp.legs].name + '[/color]' + tattoosdescript.legs.end + tattoooptions[tmp.legs].descript + '. '
#		if tmp.ass != 'none' && tmp1.ass == true:
#			text += tattoosdescript.ass.start + '[color=yellow]' + tattoooptions[tmp.ass].name + '[/color]' + tattoosdescript.ass.end + tattoooptions[tmp.ass].descript + '. '
#	if text != '':
#		#possible bug
#		if globals.state.descriptsettings.tattoo == true || showmode != 'default':
#			text = "\n\n[url=tattoo][color=#d1b970]Tattoos:[/color][/url] " + text
#		else:
#			text = "\n[url=tattoo][color=#d1b970]Tattoos:[/color][/url] Omitted."
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
	sex = {
		male = {code = 'male', name = '', chardescript = '', bodychanges = [
			{code = 'hair_length', value = [['ear', 4], ['neck',2], ['shoulder',0.5],['bald',0.2]], reqs = []},
			{code = 'hair_length', value = [['bald',1]], reqs = [{code = 'race', race = 'Kobold', check = true}]},
			{code = 'hair_length', value = [['ear',0.5],['shoulder',2], ['waist', 2], ['hips',0.5]], reqs = [{code = 'one_of_races', value = ['Elf','DarkElf'], check = true}]},
			{code = 'hair_style',  value = [['straight', 10], ['ponytail',1]], reqs = []},
			{code = 'ass_size', value = [['flat', 1], ['masculine',1]], reqs = []},
			{code = 'tits_size', value = [['flat', 1], ['masculine', 1]], reqs = []},
			{code = 'has_womb', value = [[false,1]], reqs = []},
			{code = 'has_pussy', value = [[false,1]], reqs = []},
			{code = 'vaginal_virgin', value = [[false,1]], reqs = []},
			{code = 'penis_size', value = [['small', 1], ['average', 5], ['big',1]], reqs = []},
			{code = 'balls_size', value = [['small', 1], ['average', 5], ['big',1]], reqs = []},
			{code = 'eye_tex', value = [['eyes1m', 1],['eyes2m', 1],['eyes3m', 1],['eyes4m', 1],['eyes5m', 1],], reqs = []},
			{code = 'chin', value = [['default', 1],['male', 1],['muscle', 1]], reqs = []},
			{code = 'chin', value = [['beastkin', 1]], reqs = [{code = 'one_of_races', value = ['BeastkinCat','BeastkinWolf', 'BeastkinFox', 'BeastkinBunny', 'BeastkinTanuki'], check = true}]},
			{code = 'eyebrows', value = [['style1', 1],['style6', 1],['style7', 1]], reqs = []},
		]},
		female = {code = 'female', name = '', chardescript = '', bodychanges = [
			{code = 'hair_length', value = [['ear', 0.5],['neck',2],['shoulder',3],['waist',1],['hips',0.5]], reqs = []},
			{code = 'hair_style', value = [['straight', 2],['ponytail',1],['pigtails',1],['braid',1],['twinbraids',1]], reqs = []},
			{code = 'ass_size', value = [['flat', 1], ['small',1], ['average', 1], ['big', 1], ['huge', 1]], reqs = []},
			{code = 'tits_size', value = [['flat', 1], ['small',1], ['average', 1], ['big', 1], ['huge', 1]], reqs = []},
			{code = 'tits_size', value = [['average', 1], ['big', 1], ['huge', 1]], reqs = [{code = 'race', race = 'Taurus', check = true}]},
			{code = 'tits_size', value = [['average', 0.5], ['small', 2], ['flat', 0.5],['big',0.2]], reqs = [{code = 'race', race = 'Kobold', check = true}]},
			{code = 'has_womb', value = [[true,1]], reqs = []},
			{code = 'has_pussy', value = [[true,1]], reqs = []},
			{code = 'penis_size', value = [['',1]], reqs = []},
			{code = 'balls_size', value = [['',1]], reqs = []},
			{code = 'beard', value = [['no',1]], reqs = []},
#			{code = 'moustache', value = [['no',1]], reqs = []},
			{code = 'hair_facial_color', value = [['',1]], reqs = []},
			{code = 'penis_virgin', value = [[false,1]], reqs = []},
			{code = 'eye_tex', value = [['eyes1', 1],['eyes2', 1],['eyes3', 1],['eyes4', 1],['eyes5', 1],], reqs = []},
			{code = 'chin', value = [['default', 1],['curve', 1],['small', 1],['skinny', 1]], reqs = []},
			{code = 'chin', value = [['beastkin', 1]], reqs = [{code = 'one_of_races', value = ['BeastkinCat','BeastkinWolf', 'BeastkinFox', 'BeastkinBunny', 'BeastkinTanuki'], check = true}]},
			{code = 'eyebrows', value = [['style1', 1],['style2', 1],['style3', 1],['style4', 1],['style5', 1]], reqs = []},
		]},
		futa = {code = 'futa', name = '', chardescript = '', bodychanges = [
			{code = 'hair_length', value = [['ear', 0.5],['neck',2],['shoulder',3],['waist',1],['hips',0.5]], reqs = []},
			{code = 'hair_style', value = [['straight', 2],['ponytail',1],['pigtails',1],['braid',1],['twinbraids',1]], reqs = []},
			{code = 'ass_size', value = [['flat', 1], ['small',1], ['average', 1], ['big', 1], ['huge', 1]], reqs = []},
			{code = 'tits_size', value = [['flat', 1], ['small',1], ['average', 1], ['big', 1], ['huge', 1]], reqs = []},
			{code = 'tits_size', value = [['average', 1], ['big', 1], ['huge', 1]], reqs = [{code = 'race', race = 'Taurus', check = true}]},
			{code = 'tits_size', value = [['average', 0.5], ['small', 2], ['flat', 0.5],['big',0.2]], reqs = [{code = 'race', race = 'Kobold', check = true}]},
			{code = 'has_womb', value = [[true,1]], reqs = [],},
			{code = 'has_pussy', value = [[true,1]], reqs = []},
			{code = 'penis_size', value = [['small', 1], ['average', 3], ['big', 1]], reqs = []},
			{code = 'balls_size', value = [['small', 1], ['average', 3], ['big', 1]], reqs = [{code = 'setting', type = 'futa_balls', value = true}]},
			{code = 'balls_size', value = [['',1]], reqs = [{code = 'setting', type = 'futa_balls', value = false}]},
			{code = 'beard', value = [['no',1]], reqs = []},
			{code = 'eye_tex', value = [['eyes1', 1],['eyes2', 1],['eyes3', 1],['eyes4', 1],['eyes5', 1],], reqs = []},
			{code = 'chin', value = [['default', 1],['curve', 1],['small', 1],['skinny', 1]], reqs = []},
			{code = 'chin', value = [['beastkin', 1]], reqs = [{code = 'one_of_races', value = ['BeastkinCat','BeastkinWolf', 'BeastkinFox', 'BeastkinBunny', 'BeastkinTanuki'], check = true}]},
			{code = 'eyebrows', value = [['style1', 1],['style2', 1],['style3', 1],['style4', 1],['style5', 1]], reqs = []},
		]},
	},
	age = {
#		child = {code = 'child', name = '', chardescript = '', bodychanges = [
#			{code = 'height', value = [['petite', 1],['short',1]], reqs = [{code = 'stat', type = 'height', operant = 'hasnt', value = ['petite', 'short', 'tiny']}]},
#			{code = 'ass_size', value = [['flat', 2],['small',1]], reqs = [{code = 'stat', type = 'sex', operant = 'neq', value = 'male'}]},
#			{code = 'tits_size', value = [['flat', 2],['small',1]], reqs = [{code = 'stat', type = 'sex', operant = 'neq', value = 'male'}]},
#		]
#		},

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
	#duplicate and correct for all other parts of hair. currently only synchronization part made
	#2add proper values
	hair_length = {
		bald = {code = 'bald', name = '', chardescript = '', bodychanges = []},
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
	#incomplete
	hair_back = {
		"": {code = "", name = 'no', chardescript = '', bodychanges = []}
	}, 
	hair_assist = {
		"": {code = "", name = 'no', chardescript = '', bodychanges = []}
	}, 
	chin = {
		default = {code = "default", name = 'style1', chardescript = '', bodychanges = []},
		curve = {code = "curve", name = 'style2', chardescript = '', bodychanges = []},
		kobold = {code = "kobold", name = 'kobold', chardescript = '', bodychanges = []},
		small = {code = "small", name = 'style3', chardescript = '', bodychanges = []},
		skinny = {code = "skinny", name = 'style4', chardescript = '', bodychanges = []},
		male = {code = "male", name = 'style5', chardescript = '', bodychanges = []},
		muscle = {code = "muscle", name = 'style6', chardescript = '', bodychanges = []},
		short = {code = "short", name = 'style7', chardescript = '', bodychanges = []},
		beastkin = {code = "beastkin", name = 'beastkin', chardescript = '', bodychanges = []},
	},
	nose = {
		beastkin =  {code = "beastkin", name = 'beastkin', chardescript = '', bodychanges = []},
		default =  {code = "default", name = 'style1', chardescript = '', bodychanges = []},
		dwarf =  {code = "dwarf", name = 'dwarf', chardescript = '', bodychanges = []},
		kobold =  {code = "kobold", name = 'kobold', chardescript = '', bodychanges = []},
		small =  {code = "small", name = 'style2', chardescript = '', bodychanges = []},
		straight =  {code = "straight", name = 'style3', chardescript = '', bodychanges = []},
	},
	eye_color = {
		default = {code = 'default', name = '', chardescript = '', bodychanges = []},
	},
	eye_shape = {
		normal = {code = 'normal', name = '', chardescript = '', bodychanges = []},
		slit = {code = 'slit', name = '', chardescript = '', bodychanges = []},
	},
	horns = {
		"": {code = "", name = 'NO', chardescript = '', bodychanges = []},
		null: {code = null, name = 'NO', chardescript = '', bodychanges = []},
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
	body_color_skin = {
		pale = {code = 'pale', name = '', chardescript = '', bodychanges = []},
		grey = {code = 'grey', name = '', chardescript = '', bodychanges = []},
		fair = {code = 'fair', name = '', chardescript = '', bodychanges = []},
		olive = {code = 'olive', name = '', chardescript = '', bodychanges = []},
		'tan' : {code = 'tan', name = '', chardescript = '', bodychanges = []},
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
		scale2 = {code = 'scale2', name = '', chardescript = '', bodychanges = []},
		scale3 = {code = 'scale3', name = '', chardescript = '', bodychanges = []},
		feathers = {code = 'feathers', name = '', chardescript = '', bodychanges = []},
		fur_white = {code = 'fur_white', name = '', chardescript = '', bodychanges = [
			{code = 'body_color_tail', value = [['white2', 1]], reqs = []},
		]},
		fur_grey = {code = 'fur_grey', name = '', chardescript = '', bodychanges = [
			{code = 'body_color_tail', value = [['white3', 1]], reqs = []},
		]},
		fur_brown = {code = 'fur_brown', name = '', chardescript = '', bodychanges = [
			{code = 'body_color_tail', value = [['brown3', 1]], reqs = []},
		]},
		fur_striped = {code = 'fur_striped', name = '', chardescript = '', bodychanges = [
			{code = 'body_color_tail', value = [['orange3', 1]], reqs = []},
		]},
		fur_black = {code = 'fur_black', name = '', chardescript = '', bodychanges = [
			{code = 'body_color_tail', value = [['dark3', 1]], reqs = []},
		]},
		fur_orange = {code = 'fur_orange', name = '', chardescript = '', bodychanges = [
			{code = 'body_color_tail', value = [['orange3', 1]], reqs = []},
		]},
		fur_orange_white = {code = 'fur_orange_white', name = '', chardescript = '', bodychanges = [
			{code = 'body_color_tail', value = [['orange2', 1]], reqs = []},
		]},
	},
	wings = {
		"": {code = "", name = 'NO', chardescript = '', bodychanges = [{code = 'body_color_wings', value = [['pink1', 1]], reqs = []},]},
		null: {code = null, name = 'NO', chardescript = '', bodychanges = [{code = 'body_color_wings', value = [['pink1', 1]], reqs = []},]},
		feathered_black = {code = 'feathered_black', name = '', chardescript = '', bodychanges = [{code = 'body_color_wings', value = [['dark2', 1]], reqs = []},]},
		seraph = {code = 'seraph', name = '', chardescript = '', bodychanges = [{code = 'body_color_wings', value = [['white1', 1]], reqs = []},]},
		feathered_brown = {code = 'feathered_brown', name = '', chardescript = '', bodychanges = [{code = 'body_color_wings', value = [['dark1', 1]], reqs = []},]},
		fairy = {code = 'fairy', name = '', chardescript = '', bodychanges = []},
		demon = {code = 'demon', name = '', chardescript = '', bodychanges = [{code = 'body_color_wings', value = [['red3', 1]], reqs = []},]},
		dragon = {code = 'dragon', name = '', chardescript = '', bodychanges = [{code = 'body_color_wings', value = [['yellow3', 1]], reqs = []},]},
		leather_black = {code = 'leather_black', name = '', chardescript = '', bodychanges = [{code = 'body_color_wings', value = [['dark3', 1]], reqs = []},]},
		leather_red = {code = 'leather_red', name = '', chardescript = '', bodychanges = [{code = 'body_color_wings', value = [['red1', 1]], reqs = []},]},
	},
	tail = {
		"": {code = "", name = 'NO', chardescript = '', bodychanges = []},
		null: {code = null, name = 'NO', chardescript = '', bodychanges = []},
		cat = {code = 'cat', name = '', chardescript = '', bodychanges = []},
		fox = {code = 'fox', name = '', chardescript = '', bodychanges = []},
		wolf = {code = 'wolf', name = '', chardescript = '', bodychanges = []},
		bunny = {code = 'bunny', name = '', chardescript = '', bodychanges = []},
		tanuki = {code = 'tanuki', name = '', chardescript = '', bodychanges = []},
		cow = {code = 'cow', name = '', chardescript = '', bodychanges = []},
		demon = {code = 'demon', name = '', chardescript = '', bodychanges = [{code = 'body_color_tail', value = [['dark2', 1]], reqs = []},]},
		dragon = {code = 'dragon', name = '', chardescript = '', bodychanges = [{code = 'body_color_tail', value = [['red2', 1]], reqs = []},]},
		mouse = {code = 'mouse', name = '', chardescript = '', bodychanges = [{code = 'body_color_tail', value = [['white2', 1]], reqs = []},]},
		kobold = {code = 'kobold', name = '', chardescript = '', bodychanges = [{code = 'body_color_tail', value = [['green2', 1]], reqs = []},]},
		avian = {code = 'avian', name = '', chardescript = '', bodychanges = []},
		fish = {code = 'fish', name = '', chardescript = '', bodychanges = [{code = 'body_color_tail', value = [['blue2', 1]], reqs = []},]},
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
		human = {code = 'human', combine = 'penis_size', bodychanges = []},
		canine = {code = 'canine', combine = 'penis_size', bodychanges = []},
		feline = {code = 'feline', combine = 'penis_size', bodychanges = []},
		equine = {code = 'equine', combine = 'penis_size', bodychanges = []},
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
	#not sure if nonmatching ids and codes are correct
	has_pussy = {
		true : {code = 'true', combine = "vaginal_virgin", bodychanges = []},
		false : {code = 'false', name = '', chardescript = '', bodychanges = []},

	},
	vaginal_virgin = {
		true : {code = 'true', name = '', chardescript = '', bodychanges = []},
		false : {code = 'false', name = '', chardescript = '', bodychanges = []},
		True_True = {code = 'true_true', name = '', chardescript = '', bodychanges = []},
		True_False = {code = 'true_False', name = '', chardescript = '', bodychanges = []},
	},
	anal_virgin = {
		true : {code = 'true', name = '', chardescript = '', bodychanges = []},
		false : {code = 'false', name = '', chardescript = '', bodychanges = []},
	},
	mouth_virgin = {
		true : {code = 'true', name = '', chardescript = '', bodychanges = []},
		false : {code = 'false', name = '', chardescript = '', bodychanges = []},
	},
	penis_virgin = {
		true : {code = 'true', name = '', chardescript = '', bodychanges = []},
		false : {code = 'false', name = '', chardescript = '', bodychanges = []},
	},
	slave_class = {
		'master': {code = 'master', name = 'SLAVECLASSMASTER', chardescript = '', bodychanges = [], icon = 'class_master'},
		'slave': {code = 'slave', name = 'SLAVECLASSSLAVE', chardescript = '', bodychanges = [], icon = 'class_slave'},
		'slave_trained': {code = 'slave_trained', name = 'SLAVECLASSSLAVETRAINED', chardescript = '', bodychanges = [], icon = 'class_slave'}, 
		'servant': {code = 'servant', name = 'SLAVECLASSSERVANT', chardescript = '', bodychanges = [], icon = 'class_servant'},
		'servant_notax': {code = 'servant_notax', name = 'SLAVECLASSSERVANTALT', chardescript = '', bodychanges = [], icon = 'class_servant'},
		'heir': {code = 'heir', name = 'SLAVECLASSHEIR', chardescript = '', bodychanges = [], icon = 'class_heir'},
		'spouse': {code = 'spouse', name = 'SLAVECLASSSPOUSE', chardescript = '', bodychanges = [], icon = 'class_spouse'},
	}
}

var factor_descripts = {
	1:tr('FACTORDESCRIPTS1'),
	2:tr("FACTORDESCRIPTS2"),
	3:tr("FACTORDESCRIPTS3"),
	4:tr("FACTORDESCRIPTS4"),
	5:tr("FACTORDESCRIPTS5"),
	6:tr("FACTORDESCRIPTS6")
}

func get_class_name(prof, newperson):
	person = newperson
	var name = prof.name
	if prof.has('altname') && person.checkreqs(prof.altnamereqs):
		name = prof.altname
	return name

func get_class_details(newperson, classdata, showreqs = true, showskills = false):
	person = newperson
	var text = '[center]'+get_class_name(classdata, person)+'[/center]\n'


	if showreqs == true:
		text += tr('REQUIREMENTS_TOOLTIP') + ': '
		if classdata.reqs.size() > 0:
			text += '\n' + get_class_reqs(person, classdata)
		else:
			text +=  tr("REQSNONE")
	if classdata.statchanges.size() > 0:
		text += '\n\n' + tr("CLASSBONUS") + ":\n"
		text += get_class_bonuses(person,classdata)

	text += "\n" + get_class_traits(person,classdata)


	#text += "\n" + person.translate(classdata.descript) #"[center]" + name + '[/center]\n' +

	if showskills == true && (classdata.skills + classdata.combatskills).size() > 0:
		if classdata.skills.size() > 0:
			text += "\n{color=yellow|"+tr("CLASSDETAILSKILLS")+": "
			for i in classdata.skills:
				text += Skilldata.get_template(i, person).name + ", "
			text = text.substr(0, text.length() - 2) + "}"
		if classdata.combatskills.size() > 0:
			text += "\n{color=yellow|"+tr("CLASSDETAILCOMBATSKILLS")+": "
			for i in classdata.combatskills:
				text += Skilldata.get_template(i, person).name + ", "
			text = text.substr(0, text.length() - 2) + "}"

	return globals.TextEncoder(text)

func get_class_reqs(newperson, classdata, colorcode = true):
	var text = ''
	if newperson.decipher_reqs(classdata.reqs, colorcode, true):
		text += newperson.decipher_reqs(classdata.reqs, colorcode, true)
	return text

func get_class_bonuses(newperson, classdata): #maybe there should be used the same generation of stat changes description as in loyalty traits and items 
	var text = ''
	for i in classdata.statchanges:
		var data = statdata.statdata[i]
		var value = classdata.statchanges[i]
		if value is bool:
			text += tr(data.name + '_' + str(value).to_upper()) + "\n" 
			continue #temp stub
		if value is Array:
			text += tr(data.name) + ": "
			for st in value:
				match data.array_type:
					'mastery':
						text += "%s, " % tr(Skilldata.masteries[st].name)
			text = text.trim_suffix(', ')
			text += "\n"
			continue#temp stub
		if data.percent: 
			value *= 100
		text += data.name + ": "
		if value  > 0:
			text += "+"
		text += str(value)
		if data.percent:
			text += "%"
		text += "\n"
	for i in classdata.traits:
		var trait = Traitdata.traits[i]
		if trait.has('show_in_parent_stats') and trait.show_in_parent_stats:
			text += globals.TextEncoder(trait.descript) + "\n"
			if !trait.has('bonusstats'): continue
			for j in trait.bonusstats:
				var data = statdata.statdata[j]
				var value = trait.bonusstats[j]
				if data.percent: 
					value *= 100
				text += data.name + ": "
				if value  > 0:
					text += "+"
				text += str(value)
				if data.percent:
					text += "%"
				text += "\n"
	#if there will be new tags, that would need description, refactor this code: make it a system
	if classdata.has('tags') and classdata.tags.has('stable_fame'):
		text += tr('TAGSTABLE_FAME') + "\n"
	if newperson != null:
		text = newperson.translate(text)
	return text


func get_class_bonuses_short(newperson, classdata): #maybe there should be used the same generation of stat changes description as in loyalty traits and items 
	var text = ''
	for i in classdata.statchanges:
		var data = statdata.statdata[i]
		var value = classdata.statchanges[i]
		if data.tags.has('show_in_header'):
			continue
		if value is bool:
			text += tr(data.name + '_' + str(value).to_upper()) + "\n" 
			continue #temp stub
		if value is Array:
			text += tr(data.name) + ": "
			for st in value:
				match data.array_type:
					'mastery':
						text += "%s, " % tr(Skilldata.masteries[st].name)
			text = text.trim_suffix(', ')
			text += "\n"
			continue#temp stub
		if data.percent: 
			value *= 100
		text += data.name + ": "
		if value  > 0:
			text += "+"
		text += str(value)
		if data.percent:
			text += "%"
		text += "\n"
	for i in classdata.traits:
		var trait = Traitdata.traits[i]
		if trait.has('show_in_parent_stats') and trait.show_in_parent_stats:
			text += globals.TextEncoder(trait.descript) + "\n"
			if !trait.has('bonusstats'): continue
			for j in trait.bonusstats:
				var data = statdata.statdata[j]
				var value = trait.bonusstats[j]
				if data.percent: 
					value *= 100
				text += data.name + ": "
				if value  > 0:
					text += "+"
				text += str(value)
				if data.percent:
					text += "%"
				text += "\n" 
	if newperson != null:
		text = newperson.translate(text)
	return text


func get_class_traits(newperson, classdata):
	var text = ''
	for i in classdata.traits:
		var trait = Traitdata.traits[i]
		if trait.has('show_in_parent_stats') and trait.show_in_parent_stats: continue
		if trait.name.to_upper() != trait.name:
			text += "{color=brown|" + trait.name + "}: "
		text += trait.descript + "\n"
	if newperson != null:
		text = newperson.translate(text)
	return globals.TextEncoder(text)

func get_class_traits_no_icons(newperson, classdata):
	var text = ''
	for i in classdata.traits:
		if i == "basic_spells" or i == "advanced_spells" or i == "basic_combat" or i == "advanced_combat":
			print('error in classdata')
			print(classdata)
			continue
		var trait = Traitdata.traits[i]
		if trait.has('show_in_parent_stats') and trait.show_in_parent_stats: continue
		if trait.name.to_upper() != trait.name:
			text += "{color=brown|" + trait.name + "}: "
		text += trait.descript + "\n"
	if newperson != null:
		text = newperson.translate(text)
	return globals.TextEncoder(text)


func trim_tag(text, tag, arg = null):
	var res = text
	var regexp = RegEx.new()
	var prefix
	var suffix = "\\[/%s\\]" % tag
	if arg != null:
		prefix = "\\[%s=%s\\]" % [tag, arg]
	else:
		prefix = "\\[%s.*\\]" % tag
	var expression = "(?<str1>%s(?<str2>.*)%s)" % [prefix, suffix]
	regexp.compile(expression)
	for result in regexp.search_all(text):
		res = res.replace(result.get_string('str1'),result.get_string('str2'))
	return res

func get_fame_tier_bonus(tier):
	var text = ''
	var dict = variables.fame_tiers[tier]
	if dict.has('price_bonus') and dict.price_bonus > 0.0:
		text += "%s: {color=green|+%d%%}\n" % [tr('FAMEDESC_PRICE_BONUS'), int(dict.price_bonus * 100)]
	if dict.has('upkeep'):
		text += '%s: {color=yellow|%d}\n' % [tr('FAMEDESC_UPKEEP'), dict.upkeep]
	if dict.has('loyalty_bonus'):
		text += '%s: {color=green|+%d%%}\n' % [tr('FAMEDESC_LOYALTY_BONUS'), int(dict.loyalty_bonus * 100)]
	if dict.has('recruit_bonus'):
		text += '%s: {color=green|+%d%%}\n' % [tr('FAMEDESC_RECRUIT_BONUS'), int(dict.recruit_bonus * 100)]
	return text

func make_slave_statreq_text(req):
	match req.code:
		'is_master':
			var text
			if req.check: text = "STATREQ_IS_SLAVE_TYPE"
			else: text = "STATREQ_IS_NOT_SLAVE_TYPE"
			return "%s %s %s %s" % [
				tr(text),
				tr('CHARTYPEMASTER'),
				tr('REQOR'),
				tr('CHARTYPEMASTERF')]
		'is_free':
			if req.check: return tr('STATREQ_IS_FREE')
			else: return tr('STATREQ_IS_NOT_FREE')
		'slave_type':
			var text
			if req.operant == 'eq': text = "STATREQ_IS_SLAVE_TYPE"
			else: text = "STATREQ_IS_NOT_SLAVE_TYPE"
			return "%s %s" % [tr(text), tr("CHARTYPE" + req.value.to_upper())]
		'has_status':
			if req.status == 'tr_obed_donate' and req.check:
				return tr("STATREQ_TRAINING_OBEDIENCE")
			return String(req).trim_prefix("{").trim_suffix("}")
		'workrule':
			if req.value == 'lock' and !req.check:
				return tr("STATREQ_WORKRULE_LOCK")
			return String(req).trim_prefix("{").trim_suffix("}")
		'stat':
			var stat_name = statdata.statdata[req.stat].name
			var operant_text = input_handler.operant_translation(req.operant)
			if req.stat.ends_with('factor') && input_handler.globalsettings.factors_as_words:
				return "%s: %s %s" % [stat_name, operant_text, tr(ResourceScripts.descriptions.factor_descripts[int(req.value)])]
			elif req.stat in ['vaginal_virgin']:#operant is eq or neq, and value is bool
				if (req.operant == 'eq' and req.value) or (req.operant == 'neq' and !req.value):
					return "%s %s" % [tr("OPERANTEQ"), stat_name]
				else:
					return "%s %s" % [tr("OPERANTNEQ"), stat_name]
			elif req.stat == 'personality':
				var val
				if req.value is Array:
					val = ''
					for j in range(req.value.size()):
						if j == req.value.size()-1: val += ' %s ' % tr('REQOR')
						elif j != 0: val += ', '
						val += tr("PERSONALITYNAME" + req.value[j].to_upper())
				else:
					val = tr("PERSONALITYNAME" + req.value.to_upper())
				if req.operant == 'neq':
					return "%s: %s %s." % [stat_name, operant_text, val]
				else:
					return "%s: %s." % [stat_name, val]
			elif bodypartsdata.has(req.stat):# tits_size, height, ass_size
				var val
				if req.value is Array:
					val = ''
					for j in range(req.value.size()):
						if j == req.value.size()-1: val += ' %s ' % tr('REQOR')
						elif j != 0: val += ', '
						val += bodypartsdata[req.stat][req.value[j]].name
				else:
					val = bodypartsdata[req.stat][req.value].name
				return "%s: %s %s." % [stat_name, operant_text, val]
			else:
				return "%s: %s %s." % [stat_name, operant_text, req.value]
		'sex':
			var text = "%s: " % tr('STATSEX')
			if req.has('check') and !req.check:
				text += "%s " % tr("OPERANTNEQ")
			text += "%s." % tr('SLAVESEX'+req.value.to_upper())
			return text
		'one_of_races':
			var text = "%s: " % tr('STATRACE')
			for j in req.value:
				text += "%s, " % tr("RACE" + j.to_upper())
			text = "%s." % text.substr(0, text.length() - 2)
			return text
		'race':
			var text = "%s: " % tr('STATRACE')
			if req.has('check') and !req.check:
				text += "%s " % tr("OPERANTNEQ")
			text += "%s." % tr("RACE" + req.race.to_upper())
			return text
		'trait':
			var text = "%s: " % tr('TRAITS')
			if req.has('check') and !req.check:
				text += "%s " % tr("OPERANTNEQ")
			text += "%s." % Traitdata.traits[req.trait].name
			return text
		'has_profession':
			var text = "%s: " % tr('REQHASCLASS')
			if req.has('check') and !req.check:
				text += "%s " % tr("OPERANTNEQ")
			var prof_name
			if req.has("altname"):
				prof_name = classesdata.professions[req.profession].altname
			else:
				prof_name = classesdata.professions[req.profession].name
			text += "%s." % prof_name
			return text
		'gear_equiped':
			var text
			if req.has('orflag') and req.orflag:
				text = "   %s " % tr('REQOR')
			else:
				text = "%s: " % tr('REQMUSTHAVEGEAR')
			if req.has('check') and !req.check:
				text += "%s " % tr("OPERANTNEQ")
			text += "%s." % Items.itemlist[req.value].name
			return text
		'is_at_location':
			#not sure if it's needed. Make main.gd's lines if so
			print("warning: make_slave_statreq_text() used 'is_at_location' code!")
			if req.check: return "Must be at specific location"
			else: return "Must not be at specific location"
		'in_combat_party':
			#not sure if it's needed. Make main.gd's lines if so
			print("warning: make_slave_statreq_text() used 'in_combat_party' code!")
			if req.value: return "Must be in combat party"
			else: return "Must not be in combat party"
		'or_list':
			var text = make_slave_statreq_text(req.or_list[0])
			for i in range(1, req.or_list.size()):
				text += "\n  %s %s" % [tr('REQOR'), make_slave_statreq_text(req.or_list[i])]
			return text
		_:
			return String(req).replace("{", "(").replace("}", ")")
