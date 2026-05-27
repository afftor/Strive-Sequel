extends Reference

var givers
var takers


#For expressions in brackets: 1 refers to givers, 2 refers to takers and checks if groups consist of 1 or more persons to pick up correct references.
#[name1] and [name2] build name lists of those parties, while [name] refers to specific person from any side (generally used in reactions)
#expressions without brackets tend to refer only to specific person and build their description or pronounce parts. [body] will try to add some random adjectives depending on character's traits.
#[his], [he] etc will be replaced with female pronouns if referred character is not male
#[his1] can be also replaced with their and will refer to group


func decoder(text, tempgivers = null, temptakers = null):
	if tempgivers != null: givers = tempgivers
	if temptakers != null: takers = temptakers
	if takers.size() == 0:
		takers = givers

	#split before parse
	text = splitrand(text)

	#dictionary of replacements
	var replacements = {
		#state verbs
		'[their]' : 'your' if givers[0].person.has_profession("master") || takers[0].person.has_profession("master") else 'their',
		'[is1]' : 'are' if givers.size() >= 2 or givers[0].person.has_profession("master") else 'is',
		'[is2]' : 'are' if takers.size() >= 2 or takers[0].person.has_profession("master") else 'is',
		'[has1]' : 'have' if givers.size() >= 2 or givers[0].person.has_profession("master") else 'has',
		'[has2]' : 'have' if takers.size() >= 2 or takers[0].person.has_profession("master") else 'has',
		'[was1]' : 'were' if givers.size() >= 2 or givers[0].person.has_profession("master") else 'was',
		'[was2]' : 'were' if takers.size() >= 2 or takers[0].person.has_profession("master") else 'was',
		#verb endings
		'[ies/y1]' : 'y' if givers.size() >= 2 or givers[0].person.has_profession("master") else 'ies',
		'[ies/y2]' : 'y' if takers.size() >= 2 or takers[0].person.has_profession("master") else 'ies',
		'[s/1]' : '' if givers.size() >= 2 or givers[0].person.has_profession("master") else 's',
		'[s/2]' : '' if takers.size() >= 2 or takers[0].person.has_profession("master") else 's',
		'[es/1]' : '' if givers.size() >= 2 or givers[0].person.has_profession("master") else 'es',
		'[es/2]' : '' if takers.size() >= 2 or takers[0].person.has_profession("master") else 'es',
		#verb endings involving objects and body actions
		#same as above, but only takes number into account
		'[ies/y#1]' : 'y' if givers.size() >= 2 else 'ies',
		'[ies/y#2]' : 'y' if takers.size() >= 2 else 'ies',
		'[s/#1]' : '' if givers.size() >= 2 else 's',
		'[s/#2]' : '' if takers.size() >= 2 else 's',
		'[es/#1]' : '' if givers.size() >= 2 else 'es',
		'[es/#2]' : '' if takers.size() >= 2 else 'es',
		#nouns
		'[y/ies1]' : 'ies' if givers.size() >= 2 else 'y',
		'[y/ies2]' : 'ies' if takers.size() >= 2 else 'y',
		'[/s1]' : 's' if givers.size() >= 2 else '',
		'[/s2]' : 's' if takers.size() >= 2 else '',
		'[/es1]' : 'es' if givers.size() >= 2 else '',
		'[/es2]' : 'es' if takers.size() >= 2 else '',
		'[a /1]' : '' if givers.size() >= 2 else 'a ',
		'[a /2]' : '' if takers.size() >= 2 else 'a ',
		'[an /1]' : '' if givers.size() >= 2 else 'an ',
		'[an /2]' : '' if takers.size() >= 2 else 'an ',
		#pronouns
		'[it1]' : 'them' if givers.size() >= 2 else 'it',
		'[it2]' : 'them' if takers.size() >= 2 else 'it',
		'[he1]' : he(givers),
		'[he2]' : he(takers),
		'[he3]' : he(givers + takers),
		'[him1]' : him(givers),
		'[him2]' : him(takers),
		'[him3]' : him(givers + takers),
		'[himself1]' : himself(givers),
		'[himself2]' : himself(takers),
		'[himself3]' : himself(givers + takers),
		'[his1]' : his(givers),
		'[his2]' : his(takers),
		'[his3]' : his(givers + takers),
		'[his_1]' : his_(givers),
		'[his_2]' : his_(takers),
		'[his_3]' : his_(givers + takers),
		#proper nouns
		'[name1]' : name(givers),
		'[name2]' : name(takers),
		'[name3]' : name(givers + takers),
		'[names1]' : names(givers),
		'[names2]' : names(takers),
		'[names3]' : names(givers + takers),
		'[partner1]' : partner(givers),
		'[partner2]' : partner(takers),
		'[partner3]' : partner(givers + takers),
		'[partners1]' : partners(givers),
		'[partners2]' : partners(takers),
		'[partners3]' : partners(givers + takers),
		'[race1]' : race(givers),
		'[race2]' : race(takers),
		'[race3]' : race(givers + takers),
		'[boy1]' : boy(givers),
		'[boy2]' : boy(takers),
		'[boy3]' : boy(givers + takers),
		#body parts
		'[pussy1]' : pussy(givers),
		'[pussy2]' : pussy(takers),
		'[pussy3]' : pussy(givers + takers),
		'[penis1]' : penis(givers),
		'[penis2]' : penis(takers),
		'[penis3]' : penis(givers + takers),
		'[ass1]' : ass(givers),
		'[ass2]' : ass(takers),
		'[ass3]' : ass(givers + takers),
		'[hips1]' : hips(givers),
		'[hips2]' : hips(takers),
		'[hips3]' : hips(givers + takers),
		'[tits1]' : tits(givers),
		'[tits2]' : tits(takers),
		'[tits3]' : tits(givers + takers),
		'[body1]' : body(givers),
		'[body2]' : body(takers),
		'[body3]' : body(givers + takers),
		#sex actions
		'[fuck1]' : fuck(givers),
		'[fuck2]' : fuck(takers),
		'[fuck3]' : fuck(givers + takers),
		'[fucks1]' : fucks(givers),
		'[fucks2]' : fucks(takers),
		'[fucks3]' : fucks(givers + takers),
		'[fucking1]' : fucking(givers),
		'[fucking2]' : fucking(takers),
		'[fucking3]' : fucking(givers + takers),
		'[vfuck1]' : fuck(givers),
		'[vfuck2]' : fuck(takers),
		'[vfuck3]' : fuck(givers + takers),
		'[vfucks1]' : fucks(givers),
		'[vfucks2]' : fucks(takers),
		'[vfucks3]' : fucks(givers + takers),
		'[vfucking1]' : fucking(givers),
		'[vfucking2]' : fucking(takers),
		'[vfucking3]' : fucking(givers + takers),
		'[afuck1]' : fuck(givers),
		'[afuck2]' : fuck(takers),
		'[afuck3]' : fuck(givers + takers),
		'[afucks1]' : fucks(givers),
		'[afucks2]' : fucks(takers),
		'[afucks3]' : fucks(givers + takers),
		'[afucking1]' : fucking(givers),
		'[afucking2]' : fucking(takers),
		'[afucking3]' : fucking(givers + takers),
		#unfinished
		'[labia1]' : 'labia' if givers.size() >= 2 else labia(givers[0]),
		'[labia2]' : 'labia' if takers.size() >= 2 else labia(takers[0]),
		'[anus1]' : 'anuses' if givers.size() >= 2 else anus(givers[0]),
		'[anus2]' : 'anuses' if takers.size() >= 2 else anus(takers[0]),
	}

	#some tricks to make proper nouns easier
	if text.find("[name1]") + text.find("[names1]") < -1:
		replacements['[he1]'] = name(givers)
	if text.find("[name2]") + text.find("[names2]") < -1:
		replacements['[he2]'] = name(takers)

	#replace
	for i in replacements:
		text = text.replace(i, replacements[i])

	text = splitrand(text)
	#handle capitalization
	text = capitallogic(text)

	return text

#choose randomly from str in {^str:str:str}
#does not support nesting
#func splitrand(text):
#	while text.find("{^") >= 0:
#		var temptext = text.substr(text.find("{^"), text.find("}")+1 - text.find("{^"))
#		text = text.replace(temptext, temptext.split(":")[randi()%temptext.split(":").size()].replace("{^", "").replace("}",""))
#	return text

func splitrand(text):
	while text.find("{^") >= 0:
		var temptext = text.substr(text.find("{^"), text.find("}", text.find("{^"))+1 - text.find("{^"))
		text = text.replace(temptext, temptext.split(":")[randi()%temptext.split(":").size()].replace("{^", "").replace("}",""))
	return text

#capitalize the first letter in text and those after strings in the array clookfor
#ignores flags inside "[" and "]"
func capitallogic(text):
	var clookfor = ["\n",". ","! ","|"]
	var clookat = [0]
	var cplace
	for i in clookfor:
		cplace = 0
		while text.find(i, cplace) >= 0:
			clookat.append(text.find(i, cplace) + i.length())
			cplace = text.find(i, cplace + i.length() + 1)
	for i in clookat:
		if text.substr(i, 1) == "[":
				i = text.find("]", i) + 1
		if i < text.length():
			text = text.left(i) + text.substr(i, 1).to_upper() + text.right(i + 1)
	return text


func dictionary(member, text):
	if member.person.has_profession("master"):
		text = text.replace('[name]', '[color=yellow]' + 'you' + '[/color]' if givers.find(member) >= 0 else '[color=aqua]' + 'you' + '[/color]')
	else:
		text = text.replace('[name]', '[color=yellow]' + member.name + '[/color]' if givers.find(member) >= 0 else '[color=aqua]' + member.name + '[/color]')
	if member.person.has_profession("master"):
		text = text.replace('[his]', 'you')
	else:
		text = text.replace('[his]', 'his' if member.person.get_stat('sex') == 'male' else 'her')
	text = text.replace('[body]', body(member))
	return text

func he(group):
	for i in group:
		if i.person.has_profession("master"):
			if group.size() == 1:
				return 'you'
			elif group.size() == 2:
				return '{^you both:you}'
			else:
				return '{^you all:you}'
	if group.size() == 1:
		if group[0].sex == 'male':
			return 'he'
		else:
			return 'she'
	elif group.size() == 2:
		return '{^they both:they}'
	else:
		return 'they'

func himself(group):
	for i in group:
		if i.person.has_profession("master"):
			if group.size() == 1:
				return 'yourself'
			else:
				return 'yourselves'
	if group.size() == 1:
		if group[0].sex == 'male':
			return 'himself'
		else:
			return 'herself'
	else:
		return 'themselves'

func his(group):
	for i in group:
		if i.person.has_profession("master"):
			if group.size() == 1:
				return 'your'
			elif group.size() == 2:
				return '{^both of your:your}'
			else:
				return '{^all of your:your}'
	if group.size() == 1:
		if group[0].sex == 'male':
			return 'his'
		else:
			return 'her'
	else:
		return 'their'

func his_(group):
	for i in group:
		if i.person.has_profession("master"):
			return 'yours'
	if group.size() == 1:
		if group[0].sex == 'male':
			return 'his'
		else:
			return 'hers'
	else:
		return 'theirs'

func him(group):
	for i in group:
		if i.person.has_profession("master"):
			if group.size() == 1:
				return 'you'
			elif group.size() == 2:
				return '{^you both:both of you}'
			else:
				return '{^you all:all of you}'
	if group.size() == 1:
		if group[0].sex == 'male':
			return 'him'
		else:
			return 'her'
	elif group.size() == 2:
		return '{^them both:them}'
	else:
		return 'them'

func name(group):
	var text = ''
	for i in group:
		#text += "%" + str(i.number) #portraittag

		if group == givers:
			text += '[color=yellow]'
			if i.person.has_profession("master"):
				text += 'you'
			else:
				text += i.name
			text += '[/color]'
			if i != givers.back() && givers.find(i) != givers.size()-2:
				text += ', '
			elif givers.find(i) == givers.size()-2:
				text += ' and '
		else:
			text += '[color=aqua]'
			if i.person.has_profession("master"):
				text += 'you'
			else:
				if globals.getrelativename(givers[0].person, i.person) != null && randf() >= 0.5:
					if givers[0].person.has_profession("master"):
						text += givers[0].person.translate('your ')
					else:
						text += givers[0].person.translate('[his] ')
					text += globals.getrelativename(givers[0].person ,i.person)
				else:
					text += i.name
			text += '[/color]'
			if i != takers.back() && takers.find(i) != takers.size()-2:
				text += ', '
			elif takers.find(i) == takers.size()-2:
				text += ' and '
	return text

func names(group):
	var text = ''
	for i in group:
		#text += "%" + str(i.number)
		if group == givers:
			text += '[color=yellow]'
			if i.person.has_profession("master"):
				if group.size() == 1:
					text += 'your'
				else:
					text += 'you'
			else:
				text += i.name
			text += '[/color]'
			if i != givers.back() && givers.find(i) != givers.size()-2:
				text += ', '
			elif givers.find(i) == givers.size()-2:
				text += ' and '
		else:
			text += '[color=aqua]'
			if i.person.has_profession("master"):
				if group.size() == 1:
					text += 'your'
				else:
					text += 'you'
			else:
				text += i.name
			text += '[/color]'
			if i != takers.back() && takers.find(i) != takers.size()-2:
				text += ', '
			elif takers.find(i) == takers.size()-2:
				text += ' and '
#		if i.person.has_profession("master") == false:
#			text += "'s"
	return text

#no recursive functions allowed in godot so this looks semi-horrible, but whatever
#fuck() and variants used after "to" or a modal verb such as "will/should"
#fucks() used in other present tense cases, will return fuck() depending on group characteristics
#vfuck() and afuck() variants assume verticality
func fuck(group):
	var outputs = []
	var temp = ''
	outputs += [getrandomfromarray(['SEXDESC_FUCK_BASE_1','SEXDESC_FUCK_BASE_2','SEXDESC_FUCK_BASE_3','SEXDESC_FUCK_BASE_4','SEXDESC_FUCK_BASE_5','SEXDESC_FUCK_BASE_6'])]
	temp = getrandomfromarray(['SEXDESC_FUCK_THRUST_1','SEXDESC_FUCK_THRUST_2','SEXDESC_FUCK_THRUST_3','SEXDESC_FUCK_THRUST_4','SEXDESC_FUCK_THRUST_5','SEXDESC_FUCK_THRUST_6','SEXDESC_FUCK_THRUST_7','SEXDESC_FUCK_THRUST_8'])
	temp += getrandomfromarray([' ' + his(group) + ' ' + penis(group),''])
	temp += getrandomfromarray([' deep','']) + ' into'
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_FUCK_SLIDE_1','SEXDESC_FUCK_SLIDE_2','SEXDESC_FUCK_SLIDE_3','SEXDESC_FUCK_SLIDE_4'])
	temp += getrandomfromarray([' ' + his(group) + ' ' + penis(group),'']) + ' in and out of'
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_FUCK_SLIDE_1','SEXDESC_FUCK_THRUST_6'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + penis(group),himself(group)])
	temp += ' ' + getrandomfromarray(['in and out of','inside'])
	outputs += [temp]
	return outputs[randi()%outputs.size()]

func fucks(group):
	if group.size() >= 2:
		return fuck(group)
	for i in group:
		if i.person.has_profession("master"):
			return fuck(group)
	var outputs = []
	var temp = ''
	outputs += [getrandomfromarray(['SEXDESC_FUCKS_BASE_1','SEXDESC_FUCKS_BASE_2','SEXDESC_FUCKS_BASE_3','SEXDESC_FUCKS_BASE_4','SEXDESC_FUCKS_BASE_5','SEXDESC_FUCKS_BASE_6'])]
	temp = getrandomfromarray(['SEXDESC_FUCKS_THRUST_1','SEXDESC_FUCKS_THRUST_2','SEXDESC_FUCKS_THRUST_3','SEXDESC_FUCKS_THRUST_4','SEXDESC_FUCKS_THRUST_5','SEXDESC_FUCKS_THRUST_6','SEXDESC_FUCKS_THRUST_7','SEXDESC_FUCKS_THRUST_8'])
	temp += getrandomfromarray([' ' + his(group) + ' ' + penis(group),''])
	temp += getrandomfromarray([' deep','']) + ' into'
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_FUCKS_SLIDE_1','SEXDESC_FUCKS_SLIDE_2','SEXDESC_FUCKS_SLIDE_3','SEXDESC_FUCKS_SLIDE_4'])
	temp += getrandomfromarray([' ' + his(group) + ' ' + penis(group),'']) + ' in and out of'
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_FUCKS_SLIDE_1','SEXDESC_FUCKS_SLIDE_4'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + penis(group),himself(group)])
	temp += ' ' + getrandomfromarray(['SEXDESC_FUCKS_INOUT_1','SEXDESC_FUCKS_INOUT_2','SEXDESC_FUCKS_INOUT_3'])
	outputs += [temp]
	return outputs[randi()%outputs.size()]

func fucking(group):
	var outputs = []
	var temp = ''
	outputs += [getrandomfromarray(['SEXDESC_FUCKING_BASE_1','SEXDESC_FUCKING_BASE_2','SEXDESC_FUCKING_BASE_3','SEXDESC_FUCKING_BASE_4','SEXDESC_FUCKING_BASE_5','SEXDESC_FUCKING_BASE_6'])]
	temp = getrandomfromarray(['SEXDESC_FUCKING_THRUST_1','SEXDESC_FUCKING_THRUST_2','SEXDESC_FUCKING_THRUST_3','SEXDESC_FUCKING_THRUST_4','SEXDESC_FUCKING_THRUST_5','SEXDESC_FUCKING_THRUST_6','SEXDESC_FUCKING_THRUST_7','SEXDESC_FUCKING_THRUST_8'])
	temp += getrandomfromarray([' ' + his(group) + ' ' + penis(group),''])
	temp += getrandomfromarray([' deep','']) + ' into'
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_FUCKING_SLIDE_1','SEXDESC_FUCKING_SLIDE_2','SEXDESC_FUCKING_SLIDE_3','SEXDESC_FUCKING_SLIDE_4'])
	temp += getrandomfromarray([' ' + his(group) + ' ' + penis(group),'']) + ' in and out of'
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_FUCKING_SLIDE_1','SEXDESC_FUCKING_SLIDE_4'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + penis(group),himself(group)])
	temp += ' ' + getrandomfromarray(['in and out of','into','inside'])
	outputs += [temp]
	return outputs[randi()%outputs.size()]

func vfuck(group):
	var outputs = []
	var temp = ''
	outputs += [getrandomfromarray(['SEXDESC_VFUCK_BASE_1','SEXDESC_VFUCK_BASE_2','SEXDESC_VFUCK_BASE_3','SEXDESC_VFUCK_BASE_4'])]
	temp = getrandomfromarray(['SEXDESC_VFUCK_GRIND_1','SEXDESC_VFUCK_GRIND_2','SEXDESC_VFUCK_GRIND_3'])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_GRIND_ATOP_1','SEXDESC_VFUCK_GRIND_ATOP_2','SEXDESC_VFUCK_GRIND_ATOP_3'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCK_HIP_1','SEXDESC_VFUCK_HIP_2','SEXDESC_VFUCK_HIP_3','SEXDESC_VFUCK_HIP_4','SEXDESC_VFUCK_HIP_5','SEXDESC_VFUCK_HIP_6'])
	temp += ' ' + his(group) + ' ' + hips(group)
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_GRIND_ATOP_1','SEXDESC_VFUCK_GRIND_ATOP_2','SEXDESC_VFUCK_GRIND_ATOP_3'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCK_SLAM_1','SEXDESC_VFUCK_SLAM_2','SEXDESC_VFUCK_SLAM_3','SEXDESC_VFUCK_SLAM_4'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + pussy(group),himself(group)])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_SLAM_DIR_1','SEXDESC_VFUCK_SLAM_DIR_2'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCK_IMPALE_1','SEXDESC_VFUCK_IMPALE_2','SEXDESC_VFUCK_IMPALE_3','SEXDESC_VFUCK_IMPALE_4'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + pussy(group),himself(group)])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_IMPALE_DIR_1','SEXDESC_VFUCK_IMPALE_DIR_2'])
	outputs += [temp]
	return outputs[randi()%outputs.size()]

func vfucks(group):
	if group.size() >= 2:
		return vfuck(group)
	for i in group:
		if i.person.has_profession("master"):
			return vfuck(group)
	var outputs = []
	var temp = ''
	outputs += [getrandomfromarray(['SEXDESC_VFUCKS_BASE_1','SEXDESC_VFUCKS_BASE_2','SEXDESC_VFUCKS_BASE_3','SEXDESC_VFUCKS_BASE_4'])]
	temp = getrandomfromarray(['SEXDESC_VFUCKS_GRIND_1','SEXDESC_VFUCKS_GRIND_2','SEXDESC_VFUCKS_GRIND_3'])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_GRIND_ATOP_1','SEXDESC_VFUCK_GRIND_ATOP_2','SEXDESC_VFUCK_GRIND_ATOP_3'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCKS_HIP_1','SEXDESC_VFUCKS_HIP_2','SEXDESC_VFUCKS_HIP_3','SEXDESC_VFUCKS_HIP_4','SEXDESC_VFUCKS_HIP_5','SEXDESC_VFUCKS_HIP_6'])
	temp += ' ' + his(group) + ' ' + hips(group)
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_GRIND_ATOP_1','SEXDESC_VFUCK_GRIND_ATOP_2','SEXDESC_VFUCK_GRIND_ATOP_3'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCKS_SLAM_1','SEXDESC_VFUCKS_SLAM_2','SEXDESC_VFUCKS_SLAM_3','SEXDESC_VFUCKS_SLAM_4'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + pussy(group),himself(group)])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_SLAM_DIR_1','SEXDESC_VFUCK_SLAM_DIR_2'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCKS_IMPALE_1','SEXDESC_VFUCKS_IMPALE_2','SEXDESC_VFUCKS_IMPALE_3','SEXDESC_VFUCKS_IMPALE_4'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + pussy(group),himself(group)])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_IMPALE_DIR_1','SEXDESC_VFUCK_IMPALE_DIR_2'])
	outputs += [temp]
	return outputs[randi()%outputs.size()]

func vfucking(group):
	var outputs = []
	var temp = ''
	outputs += [getrandomfromarray(['SEXDESC_VFUCKING_BASE_1','SEXDESC_VFUCKING_BASE_2','SEXDESC_VFUCKING_BASE_3','SEXDESC_VFUCKING_BASE_4'])]
	temp = getrandomfromarray(['SEXDESC_VFUCKING_GRIND_1','SEXDESC_VFUCKING_GRIND_2','SEXDESC_VFUCKING_GRIND_3'])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_GRIND_ATOP_1','SEXDESC_VFUCK_GRIND_ATOP_2','SEXDESC_VFUCK_GRIND_ATOP_3'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCKING_HIP_1','SEXDESC_VFUCKING_HIP_2','SEXDESC_VFUCKING_HIP_3','SEXDESC_VFUCKING_HIP_4','SEXDESC_VFUCKING_HIP_5','SEXDESC_VFUCKING_HIP_6'])
	temp += ' ' + his(group) + ' ' + hips(group)
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_GRIND_ATOP_1','SEXDESC_VFUCK_GRIND_ATOP_2','SEXDESC_VFUCK_GRIND_ATOP_3'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCKING_SLAM_1','SEXDESC_VFUCKING_SLAM_2','SEXDESC_VFUCKING_SLAM_3','SEXDESC_VFUCKING_SLAM_4'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + pussy(group),himself(group)])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_SLAM_DIR_1','SEXDESC_VFUCK_SLAM_DIR_2'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCKING_IMPALE_1','SEXDESC_VFUCKING_IMPALE_2','SEXDESC_VFUCKING_IMPALE_3','SEXDESC_VFUCKING_IMPALE_4'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + pussy(group),himself(group)])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_IMPALE_DIR_1','SEXDESC_VFUCK_IMPALE_DIR_2'])
	outputs += [temp]
	return outputs[randi()%outputs.size()]

func afuck(group):
	var outputs = []
	var temp = ''
	outputs += [getrandomfromarray(['SEXDESC_VFUCK_BASE_1','SEXDESC_VFUCK_BASE_2','SEXDESC_VFUCK_BASE_3','SEXDESC_VFUCK_BASE_4'])]
	temp = getrandomfromarray(['SEXDESC_VFUCK_GRIND_1','SEXDESC_VFUCK_GRIND_2','SEXDESC_VFUCK_GRIND_3'])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_GRIND_ATOP_1','SEXDESC_VFUCK_GRIND_ATOP_2','SEXDESC_VFUCK_GRIND_ATOP_3'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCK_HIP_1','SEXDESC_VFUCK_HIP_2','SEXDESC_VFUCK_HIP_3','SEXDESC_VFUCK_HIP_4','SEXDESC_VFUCK_HIP_5','SEXDESC_VFUCK_HIP_6'])
	temp += ' ' + his(group) + ' ' + hips(group)
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_GRIND_ATOP_1','SEXDESC_VFUCK_GRIND_ATOP_2','SEXDESC_VFUCK_GRIND_ATOP_3'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCK_SLAM_1','SEXDESC_VFUCK_SLAM_2','SEXDESC_VFUCK_SLAM_3','SEXDESC_VFUCK_SLAM_4'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + anus(group),himself(group)])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_SLAM_DIR_1','SEXDESC_VFUCK_SLAM_DIR_2'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCK_IMPALE_1','SEXDESC_VFUCK_IMPALE_2','SEXDESC_VFUCK_IMPALE_3','SEXDESC_VFUCK_IMPALE_4'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + anus(group),himself(group)])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_IMPALE_DIR_1','SEXDESC_VFUCK_IMPALE_DIR_2'])
	outputs += [temp]
	return outputs[randi()%outputs.size()]

func afucks(group):
	if group.size() >= 2:
		return afuck(group)
	for i in group:
		if i.person.has_profession("master"):
			return afuck(group)
	var outputs = []
	var temp = ''
	outputs += [getrandomfromarray(['SEXDESC_VFUCKS_BASE_1','SEXDESC_VFUCKS_BASE_2','SEXDESC_VFUCKS_BASE_3','SEXDESC_VFUCKS_BASE_4'])]
	temp = getrandomfromarray(['SEXDESC_VFUCKS_GRIND_1','SEXDESC_VFUCKS_GRIND_2','SEXDESC_VFUCKS_GRIND_3'])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_GRIND_ATOP_1','SEXDESC_VFUCK_GRIND_ATOP_2','SEXDESC_VFUCK_GRIND_ATOP_3'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCKS_HIP_1','SEXDESC_VFUCKS_HIP_2','SEXDESC_VFUCKS_HIP_3','SEXDESC_VFUCKS_HIP_4','SEXDESC_VFUCKS_HIP_5','SEXDESC_VFUCKS_HIP_6'])
	temp += ' ' + his(group) + ' ' + hips(group)
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_GRIND_ATOP_1','SEXDESC_VFUCK_GRIND_ATOP_2','SEXDESC_VFUCK_GRIND_ATOP_3'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCKS_SLAM_1','SEXDESC_VFUCKS_SLAM_2','SEXDESC_VFUCKS_SLAM_3','SEXDESC_VFUCKS_SLAM_4'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + anus(group),himself(group)])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_SLAM_DIR_1','SEXDESC_VFUCK_SLAM_DIR_2'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCKS_IMPALE_1','SEXDESC_VFUCKS_IMPALE_2','SEXDESC_VFUCKS_IMPALE_3','SEXDESC_VFUCKS_IMPALE_4'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + anus(group),himself(group)])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_IMPALE_DIR_1','SEXDESC_VFUCK_IMPALE_DIR_2'])
	outputs += [temp]
	return outputs[randi()%outputs.size()]

func afucking(group):
	var outputs = []
	var temp = ''
	outputs += [getrandomfromarray(['SEXDESC_VFUCKING_BASE_1','SEXDESC_VFUCKING_BASE_2','SEXDESC_VFUCKING_BASE_3','SEXDESC_VFUCKING_BASE_4'])]
	temp = getrandomfromarray(['SEXDESC_VFUCKING_GRIND_1','SEXDESC_VFUCKING_GRIND_2','SEXDESC_VFUCKING_GRIND_3'])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_GRIND_ATOP_1','SEXDESC_VFUCK_GRIND_ATOP_2','SEXDESC_VFUCK_GRIND_ATOP_3'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCKING_HIP_1','SEXDESC_VFUCKING_HIP_2','SEXDESC_VFUCKING_HIP_3','SEXDESC_VFUCKING_HIP_4','SEXDESC_VFUCKING_HIP_5','SEXDESC_VFUCKING_HIP_6'])
	temp += ' ' + his(group) + ' ' + hips(group)
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_GRIND_ATOP_1','SEXDESC_VFUCK_GRIND_ATOP_2','SEXDESC_VFUCK_GRIND_ATOP_3'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCKING_SLAM_1','SEXDESC_VFUCKING_SLAM_2','SEXDESC_VFUCKING_SLAM_3','SEXDESC_VFUCKING_SLAM_4'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + anus(group),himself(group)])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_SLAM_DIR_1','SEXDESC_VFUCK_SLAM_DIR_2'])
	outputs += [temp]
	temp = getrandomfromarray(['SEXDESC_VFUCKING_IMPALE_1','SEXDESC_VFUCKING_IMPALE_2','SEXDESC_VFUCKING_IMPALE_3','SEXDESC_VFUCKING_IMPALE_4'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + anus(group),himself(group)])
	temp += ' ' + getrandomfromarray(['SEXDESC_VFUCK_IMPALE_DIR_1','SEXDESC_VFUCK_IMPALE_DIR_2'])
	outputs += [temp]
	return outputs[randi()%outputs.size()]

#this could be added to the race dictionaries instead
const racenames = {
	Human = {
		single = "human",
		plural = "humans",
		singlepos = "human's",
		pluralpos = "humans'"
	},
	Elf = {
		single = "elf",
		plural = "elves",
		singlepos = "elf's",
		pluralpos = "elves'"
	},
	'Tribal Elf' : {
		single = "elf",
		plural = "elves",
		singlepos = "elf's",
		pluralpos = "elves'"
	},
	'Dark Elf' : {
		single = "elf",
		plural = "elves",
		singlepos = "elf's",
		pluralpos = "elves'"
	},
	Orc = {
		single = "orc",
		plural = "orcs",
		singlepos = "orc's",
		pluralpos = "orcs'"
	},
	Gnome = {
		single = "gnome",
		plural = "gnomes",
		singlepos = "gnome's",
		pluralpos = "gnomes'"
	},
	Dwarf = {
		single = "dwarf",
		plural = "dwarves",
		singlepos = "dwarf's",
		pluralpos = "dwarves'"
	},
	Kobold = {
		single = "kobold",
		plural = "kobolds",
		singlepos = "kobold's",
		pluralpos = "kobolds'"
	},
	Goblin = {
		single = "goblin",
		plural = "goblins",
		singlepos = "goblin's",
		pluralpos = "goblins'"
	},
	Fairy = {
		single = "fairy",
		plural = "fairies",
		singlepos = "fairy's",
		pluralpos = "fairies'"
	},
	Seraph = {
		single = "seraph",
		plural = "seraphs",
		singlepos = "seraph's",
		pluralpos = "seraphs'"
	},
	Demon = {
		single = "demon",
		plural = "demon's",
		singlepos = "demon's",
		pluralpos = "demons'"
	},
	Dryad = {
		single = "dryad",
		plural = "dryads",
		singlepos = "dryad's",
		pluralpos = "dryads'"
	},
	Dragonkin = {
		single = "dragon",
		plural = "dragons",
		singlepos = "dragon's",
		pluralpos = "dragons'"
	},
	Taurus = {
		single = "taurus",
		plural = "tauruses",
		singlepos = "taurus'",
		pluralpos = "tauruses'"
	},
	Slime = {
		single = "slime",
		plural = "slimes",
		singlepos = "slime's",
		pluralpos = "slimes'"
	},
	Lamia = {
		single = "lamia",
		plural = "lamias",
		singlepos = "lamia's",
		pluralpos = "lamias'"
	},
	Harpy = {
		single = "harpy",
		plural = "harpies",
		singlepos = "harpy's",
		pluralpos = "harpies'"
	},
	Arachna = {
		single = "arachna",
		plural = "arachnas",
		singlepos = "arachna's",
		pluralpos = "arachnas'"
	},
	Centaur = {
		single = "centaur",
		plural = "centaurs",
		singlepos = "centaur's",
		pluralpos = "centaurs'"
	},
	Nereid = {
		single = "nereid",
		plural = "nereids",
		singlepos = "nereid's",
		pluralpos = "nereids'"
	},
	Scylla = {
		single = "scylla",
		plural = "scyllas",
		singlepos = "scylla's",
		pluralpos = "scyllas'"
	},
	"Beastkin Cat" : {
		single = "cat",
		plural = "cats",
		singlepos = "cat's",
		pluralpos = "cats'"
	},
	"Beastkin Fox" : {
		single = "fox",
		plural = "foxes",
		singlepos = "fox's",
		pluralpos = "foxes'"
	},
	"Beastkin Wolf" : {
		single = "wolf",
		plural = "wolves",
		singlepos = "wolf's",
		pluralpos = "wolves'"
	},
	"Beastkin Bunny" : {
		single = "bunny",
		plural = "bunnies",
		singlepos = "bunny's",
		pluralpos = "bunnies'"
	},
	"Beastkin Tanuki" : {
		single = "tanuki",
		plural = "tanukis",
		singlepos = "tanuki's",
		pluralpos = "tanukis'"
	},
	"Halfkin Cat" : {
		single = "cat",
		plural = "cats",
		singlepos = "cat's",
		pluralpos = "cats'"
	},
	"Halfkin Fox" : {
		single = "fox",
		plural = "foxes",
		singlepos = "fox's",
		pluralpos = "foxes'"
	},
	"Halfkin Wolf" : {
		single = "wolf",
		plural = "wolves",
		singlepos = "wolf's",
		pluralpos = "wolves'"
	},
	"Halfkin Bunny" : {
		single = "bunny",
		plural = "bunnies",
		singlepos = "bunny's",
		pluralpos = "bunnies'"
	},
	"Halfkin Tanuki" : {
		single = "tanuki",
		plural = "tanukis",
		singlepos = "tanuki's",
		pluralpos = "tanukis'"
	}
}


func partner(group):
	var array1 = []
	var array2 = []
	var marray1 = null
	var marray2 = null
	var tarray = []
	var boygirl = ''
	for i in group:
		if i.person.has_profession("master") && group.size() == 1:
			return "you"
		array1 = []
		array2 = []
		var thick = thickness(i.person)
		#feminity descriptors
		if i.person.get_stat('tits_size') == 'masculine':
			array1 += ["SEXDESC_PARTNER_MASC_1","SEXDESC_PARTNER_MASC_2"]
		elif thick < 3:
			array1 += ["SEXDESC_PARTNER_SLIM_1","SEXDESC_PARTNER_SLIM_2","SEXDESC_PARTNER_SLIM_3"]
		elif thick < 5:
			array1 += ["SEXDESC_PARTNER_MED_1","SEXDESC_PARTNER_MED_2"]
		elif thick < 7:
			array1 += ["SEXDESC_PARTNER_THICK_1","SEXDESC_PARTNER_THICK_2","SEXDESC_PARTNER_THICK_3","SEXDESC_PARTNER_THICK_4","SEXDESC_PARTNER_THICK_5"]
		else:
			array1 += ["SEXDESC_PARTNER_VERYTHICK_1","SEXDESC_PARTNER_VERYTHICK_2","SEXDESC_PARTNER_VERYTHICK_3","SEXDESC_PARTNER_VERYTHICK_4","SEXDESC_PARTNER_VERYTHICK_5","SEXDESC_PARTNER_VERYTHICK_6"]
		#body
		if i.person.get_stat('pregnancy_duration') > 1:
			array1 += ["SEXDESC_PARTNER_PREGNANT_1","SEXDESC_PARTNER_PREGNANT_2"]
		#age
		match i.person.get_stat('age'):
			'child':
				array1 += ["SEXDESC_PARTNER_NEET_1","SEXDESC_PARTNER_NEET_2"]
				array2 += ["child"] if group.size() == 1 else ["children"]
			'teen':
				array1 += ['SEXDESC_PARTNER_TEEN_1']
				array2 += ["teen"] if group.size() == 1 else ["teens"]
			_:
				array1 += ['SEXDESC_PARTNER_ADULT_1', 'SEXDESC_PARTNER_ADULT_2']
		#beauty
		if i.person.get_stat('charm') >= 50:
			array1 += ['SEXDESC_PARTNER_CHARM_1']
			if i.person.get_stat('sex') == 'male':
				array1 += ['SEXDESC_PARTNER_CHARM_MALE_1']
			elif i.person.get_stat('age') == 'child':
				array1 += ['SEXDESC_PARTNER_CHARM_NEET_1','SEXDESC_PARTNER_CHARM_NEET_2']
			elif i.person.get_stat('age') == 'teen':
				array1 += ['SEXDESC_PARTNER_CHARM_TEEN_1','SEXDESC_PARTNER_CHARM_TEEN_2','SEXDESC_PARTNER_CHARM_TEEN_3']
			else:
				array1 += ['SEXDESC_PARTNER_CHARM_ADULT_1','SEXDESC_PARTNER_CHARM_ADULT_2']
		#size
		match i.person.get_stat('height'):
			'petite','shortstack':
				array1 += ["SEXDESC_PARTNER_SMALL_1","SEXDESC_PARTNER_SMALL_2","SEXDESC_PARTNER_SMALL_3","SEXDESC_PARTNER_SMALL_4","SEXDESC_PARTNER_SMALL_5"]
			'tall', 'towering':
				array1 += ["SEXDESC_PARTNER_LARGE_1","SEXDESC_PARTNER_LARGE_2","SEXDESC_PARTNER_LARGE_3","SEXDESC_PARTNER_LARGE_4"]
		#personality
		if i.person.get_stat('charm') > 60:
			if i.person.get_stat('age') in ['child','teen']:
				array1 += ['SEXDESC_PARTNER_CHARM_AGE_1','SEXDESC_PARTNER_CHARM_AGE_2']
			if i.person.get_stat('age') in ['adult','teen','mature']:
				array1 += ['SEXDESC_PARTNER_CHARM_AGE2_1','SEXDESC_PARTNER_CHARM_AGE2_2','SEXDESC_PARTNER_CHARM_AGE2_3']
		if i.person.get_stat('personality') == 'shy':
			array1 += ['SEXDESC_PARTNER_SHY_1','SEXDESC_PARTNER_SHY_2']
		if i.person.get_stat('wits') > 80:
			array1 += ['SEXDESC_PARTNER_CLEVER_1']
		if i.person.get_stat('personality') == 'bold':
			array1 += ['SEXDESC_PARTNER_BOLD_1','SEXDESC_PARTNER_BOLD_2']
		if i.lust > 300:
			array1 += ['SEXDESC_PARTNER_HORNY_1', 'SEXDESC_PARTNER_HORNY_2']
		#boy/girl
		if i.person.get_stat('sex') == 'male':
			if i.person.get_stat('age') == 'mature':
				boygirl = 'man' if group.size() == 1 else 'men'
				if group.size() >= 2:
					boygirl = 'boy' if group.size() == 1 else 'boys'
			else:
				boygirl = 'boy' if group.size() == 1 else 'boys'
		else:
			if i.person.get_stat('age') == 'mature':
				boygirl = 'woman' if group.size() == 1 else 'women'
				if group.size() >= 2:
					boygirl = 'girl' if group.size() == 1 else 'girls'
			else:
				boygirl = 'girl' if group.size() == 1 else 'girls'
		array2 += [boygirl]
		#race
		for k in racenames:
			if k == i.person.get_stat('race'):
				array2 += [racenames[k].single + ' ' + boygirl]
				if group.size() >= 2:
					array2 += [racenames[k].plural]
		#for multiple people, only incude shared
		if marray1 == null:
			marray1 = array1
			marray2 = array2
		else:
			tarray = [] + marray1
			for j in tarray:
				if not array1.has(j):
					marray1.erase(j)
			tarray = [] + marray2
			for j in tarray:
				if not array2.has(j):
					marray2.erase(j)
	#assures correct return values
	if marray1.empty():
		if marray2.empty():
			return "the diverse group"
		else:
			return "the " + getrandomfromarray(marray2)
	elif marray2.empty():
		return "the " + getrandomfromarray(marray1) + " group"
	else:
		return "the " + getrandomfromarray(marray1) + " " + getrandomfromarray(marray2)


func partners(group):
	var array1 = []
	var array2 = []
	var marray1 = null
	var marray2 = null
	var tarray = []
	var boygirl = ''
	for i in group:
		if i.person.has_profession("master") && group.size() == 1:
			return "your"
		array1 = []
		array2 = []
		var thick = thickness(i.person)
		#feminity descriptors
		if i.person.get_stat('tits_size') == 'masculine':
			array1 += ["SEXDESC_PARTNER_MASC_1","SEXDESC_PARTNER_MASC_2"]
		elif thick < 3:
			array1 += ["SEXDESC_PARTNER_SLIM_1","SEXDESC_PARTNER_SLIM_2","SEXDESC_PARTNER_SLIM_3","SEXDESC_BODY_SLIM_4"]
		elif thick < 5:
			array1 += ["SEXDESC_PARTNER_MED_1","SEXDESC_PARTNER_MED_2"]
		elif thick < 7:
			array1 += ["SEXDESC_PARTNER_THICK_1","SEXDESC_PARTNER_THICK_2","SEXDESC_PARTNER_THICK_3","SEXDESC_PARTNER_THICK_4","SEXDESC_PARTNER_THICK_5"]
		else:
			array1 += ["SEXDESC_PARTNER_VERYTHICK_1","SEXDESC_PARTNER_VERYTHICK_2","SEXDESC_PARTNER_VERYTHICK_3","SEXDESC_PARTNER_VERYTHICK_4","SEXDESC_PARTNER_VERYTHICK_5","SEXDESC_PARTNER_VERYTHICK_6"]
		#body
		if i.person.get_stat('pregnancy_duration') > 1:
			array1 += ["SEXDESC_PARTNER_PREGNANT_1","SEXDESC_PARTNER_PREGNANT_2"]
		#age
		if i.person.get_stat('age') == 'child':
			array1 += ["SEXDESC_PARTNER_NEET_1","SEXDESC_PARTNER_NEET_2"]
			array2 += ["child's"] if group.size() == 1 else ["childrens'"]
		elif i.person.get_stat('age') == 'teen':
			array1 += ['SEXDESC_PARTNER_TEEN_1']
			array2 += ["teen's"] if group.size() == 1 else ["teens'"]
		else:
			array1 += ['SEXDESC_PARTNER_ADULT_1', 'SEXDESC_PARTNER_ADULT_2']
		#beauty
		if i.person.get_stat('charm') >= 50:
			array1 += ['SEXDESC_PARTNER_CHARM_1']
			if i.person.get_stat('sex') == 'male':
				array1 += ['SEXDESC_PARTNER_CHARM_MALE_1']
			elif i.person.get_stat('age') == 'child':
				array1 += ['SEXDESC_PARTNER_CHARM_NEET_1','SEXDESC_PARTNER_CHARM_NEET_2']
			elif i.person.get_stat('age') == 'teen':
				array1 += ['SEXDESC_PARTNER_CHARM_TEEN_1','SEXDESC_PARTNER_CHARM_TEEN_2','SEXDESC_PARTNER_CHARM_TEEN_3']
			else:
				array1 += ['SEXDESC_PARTNER_CHARM_ADULT_1','SEXDESC_PARTNER_CHARM_ADULT_2']
		#size
		if i.person.get_stat('height') in ['petite','shortstack']:
			array1 += ["SEXDESC_PARTNER_SMALL_1","SEXDESC_PARTNER_SMALL_2","SEXDESC_PARTNER_SMALL_3","SEXDESC_PARTNER_SMALL_4","SEXDESC_PARTNER_SMALL_5"]
		elif i.person.get_stat('height') in ['tall', 'towering']:
			array1 += ["SEXDESC_PARTNER_LARGE_1","SEXDESC_BODY_LARGE_2","SEXDESC_PARTNER_LARGE_2","SEXDESC_PARTNER_LARGE_3","SEXDESC_PARTNER_LARGE_4"]
		#personality
		if i.person.get_stat('charm') > 60:
			if i.person.get_stat('age') in ['child','teen']:
				array1 += ['SEXDESC_PARTNER_CHARM_AGE_1','SEXDESC_PARTNER_CHARM_AGE_2']
			if i.person.get_stat('age') in ['adult','teen']:
				array1 += ['SEXDESC_PARTNER_CHARM_AGE2_1','SEXDESC_PARTNER_CHARM_AGE2_2','SEXDESC_PARTNER_CHARM_AGE2_3']
#		if mp.cour < 40:
#			array1 += ['shy','meek']
		if i.person.get_stat('wits') > 80:
			array1 += ['SEXDESC_PARTNER_CLEVER_1']
#		if mp.conf > 65:
#			array1 += ['proud','haughty']
		if i.lust > 300:
			array1 += ['SEXDESC_PARTNER_HORNY_1', 'SEXDESC_PARTNER_HORNY_2']
		#boy/girl
		if i.person.get_stat('sex') == 'male':
			if i.person.get_stat('age') == 'adult':
				boygirl = "man's" if group.size() == 1 else "men's"
				if group.size() >= 2:
					boygirl = "boy's" if group.size() == 1 else "boys'"
			else:
				boygirl = "boy's" if group.size() == 1 else "boys'"
		else:
			if i.person.get_stat('age') == 'adult':
				boygirl = "woman's" if group.size() == 1 else "women's"
				if group.size() >= 2:
					boygirl = "girl's" if group.size() == 1 else "girls'"
			else:
				boygirl = "girl's" if group.size() == 1 else "girls'"
		array2 += [boygirl]
		#race
		for j in racenames:
			if j == i.person.get_stat('race'):
				array2 += [racenames[j].single + ' ' + boygirl]
				if group.size() >= 2:
					array2 += [racenames[j].pluralpos]
				else:
					array2 += [racenames[j].singlepos]
		#for multiple people, only incude shared
		if marray1 == null:
			marray1 = array1
			marray2 = array2
		else:
			tarray = [] + marray1
			for j in tarray:
				if not array1.has(j):
					marray1.erase(j)
			tarray = [] + marray2
			for j in tarray:
				if not array2.has(j):
					marray2.erase(j)
	#assures correct return values
	if marray1.empty():
		if marray2.empty():
			return "the diverse group's"
		else:
			return "the " + getrandomfromarray(marray2)
	elif marray2.empty():
		return "the " + getrandomfromarray(marray1) + " group's"
	else:
		return "the " + getrandomfromarray(marray1) + " " + getrandomfromarray(marray2)

func body(group):
	var array1 = []
	var array2 = []
	var marray1 = null
	var marray2 = null
	var tarray = []
	for i in group:
		array1 = []
		array2 = ["SEXDESC_BODY_BASE_1"] if group.size() == 1 else ["SEXDESC_BODY_BASE_2"]
		var thick = thickness(i.person)
		#feminity
		if i.person.get_stat('tits_size') == 'masculine':
			array1 += ["SEXDESC_BODY_MASCULINE_1","SEXDESC_BODY_MASCULINE_2"]
		elif thick < 3:
			array1 += ["SEXDESC_BODY_SLIM_1","SEXDESC_BODY_SLIM_2","SEXDESC_BODY_SLIM_3","SEXDESC_BODY_SLIM_4"]
		elif thick < 5:
			array1 += ["SEXDESC_BODY_MED_1","SEXDESC_BODY_MED_2"]
		elif thick < 7:
			array1 += ["SEXDESC_BODY_THICK_1","SEXDESC_BODY_THICK_2","SEXDESC_BODY_THICK_3","SEXDESC_BODY_THICK_4","SEXDESC_BODY_THICK_5"]
		else:
			array1 += ["SEXDESC_BODY_VERYTHICK_1","SEXDESC_BODY_VERYTHICK_2","SEXDESC_BODY_VERYTHICK_3","SEXDESC_BODY_VERYTHICK_4","SEXDESC_BODY_VERYTHICK_5"]
		#beauty
		if i.person.get_stat('charm') >= 50:
			array1 += ['SEXDESC_BODY_CHARM_1','SEXDESC_BODY_CHARM_2']
			if i.person.get_stat('age') in ['adult','teen'] && i.person.get_stat('sex') != 'male':
				array1 += ['SEXDESC_BODY_CHARM_FEMALE_1','SEXDESC_BODY_CHARM_FEMALE_2']
		#age
		if i.person.get_stat('age') == 'child':
			array1 += ["SEXDESC_BODY_NEET_1","SEXDESC_BODY_NEET_2"]
		elif i.person.get_stat('age') == 'teen':
			array1 += ["SEXDESC_BODY_TEEN_1"]
		elif i.person.get_stat('age') == 'adult':
			if i.person.get_stat('sex') == 'male':
				array1 += ["SEXDESC_BODY_ADULT_MALE_1"]
			else:
				array1 += ["SEXDESC_BODY_ADULT_FEMALE_1","SEXDESC_BODY_ADULT_FEMALE_2"]
		#size
		if i.person.get_stat('height') in ['petite','shortstack']:
			array1 += ["SEXDESC_BODY_SMALL_1","SEXDESC_BODY_SMALL_2","SEXDESC_BODY_SMALL_3"]
		elif i.person.get_stat('height') in ['tall','towering']:
			array1 += ["SEXDESC_BODY_LARGE_1","SEXDESC_BODY_LARGE_2","SEXDESC_BODY_LARGE_3"]
		#bodytype
		if i.person.get_stat('body_shape') == 'jelly':
			array1 += ["SEXDESC_BODY_JELLY_1","SEXDESC_BODY_JELLY_2","SEXDESC_BODY_JELLY_3"]
		if i.person.get_stat('body_shape') == 'halfsnake':
			array1 += ["SEXDESC_BODY_SNAKE_1","SEXDESC_BODY_SNAKE_2"]
		elif i.person.get_stat('skin_coverage') == 'full_body_fur':
			array1 += ["SEXDESC_BODY_FUR_1","SEXDESC_BODY_FUR_2","SEXDESC_BODY_FUR_3"]
		#for multiple people, only incude shared
		if marray1 == null:
			marray1 = array1
			marray2 = array2
		else:
			tarray = [] + marray1
			for j in tarray:
				if not array1.has(j):
					marray1.erase(j)
			tarray = [] + marray2
			for j in tarray:
				if not array2.has(j):
					marray2.erase(j)
	#30% of time do not use descriptors
	if  randf() < 0.5 || marray1.empty():
		return getrandomfromarray(marray2)
	else:
		return getrandomfromarray(marray1) + " " + getrandomfromarray(marray2)

func penis(group):
	var array1 = []
	var array2 = []
	var marray1 = null
	var marray2 = null
	var tarray = []
	for i in group:
		array1 = []
		array2 = ['SEXDESC_PENIS_BASE_1','SEXDESC_PENIS_BASE_2','SEXDESC_PENIS_BASE_3','SEXDESC_PENIS_BASE_4'] if group.size() == 1 else ['SEXDESC_PENIS_BASE_1','SEXDESC_PENIS_BASE_2','SEXDESC_PENIS_BASE_3','SEXDESC_PENIS_BASE_4']
		if i.person.get_stat('penis_size') == 'small':
			array1 += ["SEXDESC_PENIS_SMALL_1","SEXDESC_PENIS_SMALL_2","SEXDESC_PENIS_SMALL_3"]
			if i.person.get_stat('age') == 'child':
				array1 += ["SEXDESC_PENIS_SMALL_NEET_1"]
		elif i.person.get_stat('penis_size')== 'average':
			array1 += ["SEXDESC_PENIS_AVG_1","SEXDESC_PENIS_AVG_2"]
			if i.person.get_stat('age') == 'child':
				array1 += ["SEXDESC_PENIS_AVG_NEET_1","SEXDESC_PENIS_AVG_NEET_2"]
		elif  i.person.get_stat('penis_size') == 'big':
			array1 += ["SEXDESC_PENIS_BIG_1","SEXDESC_PENIS_BIG_2","SEXDESC_PENIS_BIG_3","SEXDESC_PENIS_BIG_4","SEXDESC_PENIS_BIG_5"]
			if i.person.get_stat('age') == 'child':
				array1 += ["SEXDESC_PENIS_BIG_NEET_1","SEXDESC_PENIS_BIG_NEET_2"]
		#penistype descriptors
		match i.person.get_stat('penis_type'):
			'feline':
				array1 += ['SEXDESC_PENIS_FELINE_1']
			'canine':
				array1 += ['SEXDESC_PENIS_CANINE_1','SEXDESC_PENIS_CANINE_2']
			'equine':
				array1 += ['SEXDESC_PENIS_EQUINE_1','SEXDESC_PENIS_EQUINE_2']
				array2 += ['SEXDESC_PENIS_EQUINE_BASE_1','SEXDESC_PENIS_EQUINE_BASE_2']
		#other descriptors
		if i.person.get_stat('penis_size') == '':
			array2 = ['SEXDESC_PENIS_STRAPON_1','SEXDESC_PENIS_BASE_4'] if group.size() == 1 else ['SEXDESC_PENIS_STRAPON_1','SEXDESC_PENIS_BASE_4']
		elif i.person.get_stat('sex') == 'male':
			array2 += ['SEXDESC_PENIS_MALE_1'] if group.size() == 1 else ['SEXDESC_PENIS_MALE_1']
		elif i.person.get_stat('sex') == 'futanari':
			array1 += ['SEXDESC_PENIS_FUTA_1']
		#for multiple people, only incude shared
		if marray1 == null:
			marray1 = array1
			marray2 = array2
		else:
			tarray = [] + marray1
			for j in tarray:
				if not array1.has(j):
					marray1.erase(j)
			tarray = [] + marray2
			for j in tarray:
				if not array2.has(j):
					marray2.erase(j)
	#30% of time do not use descriptors
	if  randf() < 0.3 || marray1.empty():
		return getrandomfromarray(marray2)
	else:
		return getrandomfromarray(marray1) + " " + getrandomfromarray(marray2)


func pussy(group):
	var array1 = []
	var array2 = []
	var marray1 = null
	var marray2 = null
	var tarray = []
	for i in group:
		array1 = []
		array2 = ["SEXDESC_PUSSY_BASE_1","SEXDESC_PUSSY_BASE_2","SEXDESC_PUSSY_BASE_3"] if group.size() == 1 else ["SEXDESC_PUSSY_BASE_1","SEXDESC_PUSSY_BASE_2","SEXDESC_PUSSY_BASE_3"]
		#body
		if i.horny >= 100:
			array1 += ["SEXDESC_PUSSY_WET_1","SEXDESC_PUSSY_WET_2","SEXDESC_PUSSY_WET_3"]
		if i.person.get_stat('has_womb') && i.person.get_stat('pregnancy_duration') == 0:
			array1 += ["SEXDESC_PUSSY_FERTILE_1"]
		if i.person.get_stat('vaginal_virgin'):
			array1 += ["SEXDESC_PUSSY_VIRGIN_1","SEXDESC_PUSSY_VIRGIN_2","SEXDESC_PUSSY_VIRGIN_3"]
#		if mp.pubichair == 'clean':
#			if mp.age == 'child':
#				array1 += ["smooth","hairless","pubeless","bald"]
#			else:
#				array1 += ["smoothly shaved","hairless","pubeless","shaved"]
		#age
		match i.person.get_stat('age'):
			'child':
				array1 += ["SEXDESC_PUSSY_NEET_1","SEXDESC_PUSSY_NEET_2","SEXDESC_PUSSY_NEET_3","SEXDESC_PUSSY_NEET_4","SEXDESC_PUSSY_NEET_5"]
			'teen':
				array1 += ["SEXDESC_PUSSY_TEEN_1","SEXDESC_PUSSY_TEEN_2","SEXDESC_PUSSY_TEEN_3"]
			_:
				array1 += ["SEXDESC_PUSSY_ADULT_1","SEXDESC_PUSSY_ADULT_2","SEXDESC_PUSSY_ADULT_3"]
		#race
		if i.person.get_stat('body_shape') == 'halfhorse':
			array1 += ["SEXDESC_PUSSY_HORSE_1","SEXDESC_PUSSY_HORSE_2","SEXDESC_PUSSY_HORSE_2"]
		else:
			array2 += ["SEXDESC_PUSSY_BASE_4"] if group.size() == 1 else ["SEXDESC_PUSSY_BASE_4"]
		#for multiple people, only incude shared
		if marray1 == null:
			marray1 = array1
			marray2 = array2
		else:
			tarray = [] + marray1
			for j in tarray:
				if not array1.has(j):
					marray1.erase(j)
			tarray = [] + marray2
			for j in tarray:
				if not array2.has(j):
					marray2.erase(j)
	#30% of time do not use descriptors
	if  randf() < 0.3 || marray1.empty():
		return getrandomfromarray(marray2)
	else:
		return getrandomfromarray(marray1) + " " + getrandomfromarray(marray2)

func race(group):
	for i in group:
		# return i.person.translate('[race_short]')
		return input_handler.random_from_array(races.short_race_names[races.racelist[i.person.get_stat('race')].code]) if i.person.get_stat('race') != "" else ""

func boy(group):
	for i in group:
		# return i.person.translate('[boy]')
		return globals.fastif(i.person.get_stat('sex') == 'male', 'boy', 'girl')

func labia(member):
	var array = ["SEXDESC_LABIA_1","SEXDESC_LABIA_2","SEXDESC_LABIA_3","SEXDESC_LABIA_4"]
	return getrandomfromarray(array)

func ass(group):
	var array1 = []
	var array2 = []
	var marray1 = null
	var marray2 = null
	var tarray = []
	for i in group:
		array1 = []
		array2 = ["SEXDESC_ASS_BASE_1","SEXDESC_ASS_BASE_2","SEXDESC_ASS_BASE_3","SEXDESC_ASS_BASE_4"] if group.size() == 1 else ["SEXDESC_ASS_BASE_1","SEXDESC_ASS_BASE_2","SEXDESC_ASS_BASE_3","SEXDESC_ASS_BASE_4"]
		#size/age descriptors

		if i.person.get_stat('skin_coverage').find('fur') >= 0:
			array1 += ['SEXDESC_ASS_FUR_1','SEXDESC_ASS_FUR_2','SEXDESC_ASS_FUR_3']
		match i.person.get_stat('ass_size'):
			'flat':
				array1 += ["SEXDESC_ASS_FLAT_1","SEXDESC_ASS_FLAT_2"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["SEXDESC_ASS_FLAT_TEEN_1","SEXDESC_ASS_FLAT_TEEN_2","SEXDESC_ASS_FLAT_TEEN_3"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["SEXDESC_ASS_FLAT_NEET_1","SEXDESC_ASS_FLAT_NEET_2","SEXDESC_ASS_FLAT_NEET_3","SEXDESC_ASS_FLAT_NEET_4"]
			'small':
				array1 += ["SEXDESC_ASS_SMALL_1","SEXDESC_ASS_SMALL_2"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["SEXDESC_ASS_SMALL_TEEN_1"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["SEXDESC_ASS_SMALL_NEET_1","SEXDESC_ASS_SMALL_NEET_2"]
			'average':
				array1 += ["SEXDESC_ASS_AVG_1","SEXDESC_ASS_AVG_2","SEXDESC_ASS_AVG_3"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["SEXDESC_ASS_AVG_TEEN_1"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["SEXDESC_ASS_AVG_NEET_1","SEXDESC_ASS_AVG_NEET_2"]
			'big':
				array1 += ["SEXDESC_ASS_BIG_1","SEXDESC_ASS_BIG_2","SEXDESC_ASS_BIG_3","SEXDESC_ASS_BIG_4"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["SEXDESC_ASS_BIG_TEEN_1","SEXDESC_ASS_BIG_TEEN_2"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["SEXDESC_ASS_BIG_NEET_1","SEXDESC_ASS_BIG_NEET_2"]
			'huge':
				array1 += ["SEXDESC_ASS_HUGE_1","SEXDESC_ASS_HUGE_2","SEXDESC_ASS_HUGE_3","SEXDESC_ASS_HUGE_4","SEXDESC_ASS_HUGE_5","SEXDESC_ASS_HUGE_6"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["SEXDESC_ASS_HUGE_TEEN_1","SEXDESC_ASS_HUGE_TEEN_2"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["SEXDESC_ASS_HUGE_NEET_1","SEXDESC_ASS_HUGE_NEET_2"]
		#bodytype descriptors
		match i.person.get_stat('body_shape'):
			'jelly':
				array1 += ["SEXDESC_ASS_JELLY_1","SEXDESC_ASS_JELLY_2","SEXDESC_ASS_JELLY_3"]
			'halfhorse':
				array1 += ["SEXDESC_ASS_HORSE_1","SEXDESC_ASS_HORSE_2"]
				array2 += ["SEXDESC_ASS_HORSE_BASE_1"]
			'halfspider':
				array1 += ["SEXDESC_ASS_SPIDER_1","SEXDESC_ASS_SPIDER_2"]
				array2 = ["SEXDESC_ASS_SPIDER_BASE_1","SEXDESC_ASS_BASE_2"] if group.size() == 1 else ["SEXDESC_ASS_SPIDER_BASE_1","SEXDESC_ASS_BASE_2"]
		#beauty descriptors
		if i.person.get_stat('charm') >= 50:
			if i.person.get_stat('age') == 'child':
				array1 += ["SEXDESC_ASS_CHARM_NEET_1","SEXDESC_ASS_CHARM_NEET_1","SEXDESC_ASS_CHARM_NEET_2","SEXDESC_ASS_CHARM_NEET_3"]
			elif i.person.get_stat('age') == 'teen':
				array1 += ["SEXDESC_ASS_CHARM_TEEN_1","SEXDESC_ASS_CHARM_TEEN_2","SEXDESC_ASS_CHARM_TEEN_3","SEXDESC_ASS_CHARM_TEEN_4"]
			else:
				array1 += ["SEXDESC_ASS_CHARM_ADULT_1","SEXDESC_ASS_CHARM_ADULT_2","SEXDESC_ASS_CHARM_ADULT_3","SEXDESC_ASS_CHARM_ADULT_4"]
		#for multiple people, only incude shared
		if marray1 == null:
			marray1 = array1
			marray2 = array2
		else:
			tarray = [] + marray1
			for j in tarray:
				if not array1.has(j):
					marray1.erase(j)
			tarray = [] + marray2
			for j in tarray:
				if not array2.has(j):
					marray2.erase(j)
	#30% of time do not use descriptors
	if  randf() < 0.3 || marray1.empty():
		return getrandomfromarray(marray2)
	else:
		return getrandomfromarray(marray1) + " " + getrandomfromarray(marray2)

#only to be used in specific contexts to avoid description bloat
#not a replacement for "hips"
func hips(group):
	var array1 = []
	var array2 = []
	var marray1 = null
	var marray2 = null
	var tarray = []
	for i in group:
		array1 = []
		array2 = ["SEXDESC_HIPS_BASE_1"]
		#size/age descriptors
		if i.person.get_stat('skin_coverage').find('fur') >= 0:
			array1 += ['SEXDESC_HIPS_FUR_1','SEXDESC_HIPS_FUR_2','SEXDESC_HIPS_FUR_3']
		if i.person.get_stat('sex') == 'male' && i.person.get_stat('ass_size') in ['flat','small']:
			array1 += ["SEXDESC_HIPS_TRIM_1","SEXDESC_HIPS_TRIM_2"]
		else:
			match i.person.get_stat('ass_size'):
				'flat':
					array1 += ["SEXDESC_HIPS_FLAT_1","SEXDESC_HIPS_FLAT_2","SEXDESC_HIPS_FLAT_3","SEXDESC_HIPS_FLAT_4"]
				'small':
					array1 += ["SEXDESC_HIPS_SMALL_1","SEXDESC_HIPS_SMALL_2","SEXDESC_HIPS_SMALL_3","SEXDESC_HIPS_SMALL_4"]
				'average':
					array1 += ["SEXDESC_HIPS_AVG_1","SEXDESC_HIPS_AVG_2"]
					if i.person.get_stat('age') == 'teen':
						array1 += ["SEXDESC_HIPS_AVG_TEEN_1"]
					elif i.person.get_stat('age') == 'child':
						array1 += ["SEXDESC_HIPS_AVG_NEET_1","SEXDESC_HIPS_AVG_NEET_2"]
				'big':
					array1 += ["SEXDESC_HIPS_BIG_1","SEXDESC_HIPS_BIG_2","SEXDESC_HIPS_BIG_3","SEXDESC_HIPS_BIG_4","SEXDESC_HIPS_BIG_5"]
					if i.person.get_stat('age') == 'teen':
						array1 += ["SEXDESC_HIPS_BIG_TEEN_1","SEXDESC_HIPS_BIG_TEEN_2"]
					elif i.person.get_stat('age') == 'child':
						array1 += ["SEXDESC_HIPS_BIG_NEET_1","SEXDESC_HIPS_BIG_NEET_2"]
				'huge':
					array1 += ["SEXDESC_HIPS_HUGE_1","SEXDESC_HIPS_HUGE_2","SEXDESC_HIPS_HUGE_3","SEXDESC_HIPS_HUGE_4","SEXDESC_HIPS_HUGE_5","SEXDESC_HIPS_HUGE_6"]
					if i.person.get_stat('age') == 'teen':
						array1 += ["SEXDESC_HIPS_HUGE_TEEN_1","SEXDESC_HIPS_HUGE_TEEN_2"]
					elif i.person.get_stat('age') == 'child':
						array1 += ["SEXDESC_HIPS_HUGE_NEET_1","SEXDESC_HIPS_HUGE_NEET_2"]
		#bodytype descriptors
		if i.person.get_stat('body_shape') == 'halfhorse':
			array1 += ["SEXDESC_HIPS_HORSE_1","SEXDESC_HIPS_HORSE_2"]
		elif i.person.get_stat('body_shape') == 'halfsnake':
			array1 += ["SEXDESC_HIPS_SNAKE_1"]
		#for multiple people, only incude shared
		if marray1 == null:
			marray1 = array1
			marray2 = array2
		else:
			tarray = [] + marray1
			for j in tarray:
				if not array1.has(j):
					marray1.erase(j)
			tarray = [] + marray2
			for j in tarray:
				if not array2.has(j):
					marray2.erase(j)
	#30% of time do not use descriptors
	if  randf() < 0.5 || marray1.empty():
		return getrandomfromarray(marray2)
	else:
		return getrandomfromarray(marray1) + " " + getrandomfromarray(marray2)

func tits(group):
	var array1 = []
	var array2 = []
	var marray1 = null
	var marray2 = null
	var tarray = []
	for i in group:
		array1 = []
		array2 = ["SEXDESC_TITS_BASE_1","SEXDESC_TITS_BASE_2","SEXDESC_TITS_BASE_3","SEXDESC_TITS_BASE_4"] if group.size() == 1 else ["SEXDESC_TITS_BASE_1","SEXDESC_TITS_BASE_2","SEXDESC_TITS_BASE_3","SEXDESC_TITS_BASE_4"]
		#size/age descriptors
		if i.person.get_stat('skin_coverage').find('fur') >= 0:
			array1 += ['SEXDESC_TITS_FUR_1','SEXDESC_TITS_FUR_2','SEXDESC_TITS_FUR_3']
		match i.person.get_stat('tits_size'):
			'masculine':
				array1 += ["SEXDESC_TITS_MASC_1","SEXDESC_TITS_MASC_2","SEXDESC_TITS_MASC_3"]
				array2 = ["SEXDESC_TITS_MASC_BASE_1","SEXDESC_TITS_MASC_BASE_2"] if group.size() == 1 else ["SEXDESC_TITS_MASC_BASE_1","SEXDESC_TITS_MASC_BASE_2"]
			'flat':
				array1 += ["SEXDESC_TITS_FLAT_1","SEXDESC_TITS_FLAT_2"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["SEXDESC_TITS_FLAT_TEEN_1","SEXDESC_TITS_FLAT_TEEN_2","SEXDESC_TITS_FLAT_TEEN_3"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["SEXDESC_TITS_FLAT_NEET_1","SEXDESC_TITS_FLAT_NEET_2","SEXDESC_TITS_FLAT_NEET_3","SEXDESC_TITS_FLAT_NEET_4"]
			'small':
				array1 += ["SEXDESC_TITS_SMALL_1","SEXDESC_TITS_SMALL_2"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["SEXDESC_TITS_SMALL_TEEN_1"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["SEXDESC_TITS_SMALL_NEET_1","SEXDESC_TITS_SMALL_NEET_2"]
			'average':
				array1 += ["SEXDESC_TITS_AVG_1","SEXDESC_TITS_AVG_2","SEXDESC_TITS_AVG_3"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["SEXDESC_TITS_AVG_TEEN_1"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["SEXDESC_TITS_AVG_NEET_1","SEXDESC_TITS_AVG_NEET_2"]
			'big':
				array1 += ["SEXDESC_TITS_BIG_1","SEXDESC_TITS_BIG_2","SEXDESC_TITS_BIG_3","SEXDESC_TITS_BIG_4"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["SEXDESC_TITS_BIG_TEEN_1","SEXDESC_TITS_BIG_TEEN_2"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["SEXDESC_TITS_BIG_NEET_1","SEXDESC_TITS_BIG_NEET_2"]
			'huge':
				array1 += ["SEXDESC_TITS_HUGE_1","SEXDESC_TITS_HUGE_2","SEXDESC_TITS_HUGE_3","SEXDESC_TITS_HUGE_4","SEXDESC_TITS_HUGE_5","SEXDESC_TITS_HUGE_6"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["SEXDESC_TITS_HUGE_TEEN_1","SEXDESC_TITS_HUGE_TEEN_2"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["SEXDESC_TITS_HUGE_NEET_1","SEXDESC_TITS_HUGE_NEET_2"]
		#bodytype descriptors
		if i.person.get_stat('body_shape') == 'jelly':
			array1 += ["SEXDESC_TITS_JELLY_1","SEXDESC_TITS_JELLY_2","SEXDESC_TITS_JELLY_3"]
		#beauty descriptors
		if i.person.get_stat('charm') >= 50:
			match i.person.get_stat('age'):
				'child':
					array1 += ["SEXDESC_TITS_CHARM_NEET_1","SEXDESC_TITS_CHARM_NEET_1","SEXDESC_TITS_CHARM_NEET_2","SEXDESC_TITS_CHARM_NEET_3"]
				'teen':
					array1 += ["SEXDESC_TITS_CHARM_TEEN_1","SEXDESC_TITS_CHARM_TEEN_2","SEXDESC_TITS_CHARM_TEEN_3","SEXDESC_TITS_CHARM_TEEN_4"]
				_:
					array1 += ["SEXDESC_TITS_CHARM_ADULT_1","SEXDESC_TITS_CHARM_ADULT_2","SEXDESC_TITS_CHARM_ADULT_3","SEXDESC_TITS_CHARM_ADULT_4"]
		#for multiple people, only incude shared
		if marray1 == null:
			marray1 = array1
			marray2 = array2
		else:
			tarray = [] + marray1
			for j in tarray:
				if not array1.has(j):
					marray1.erase(j)
			tarray = [] + marray2
			for j in tarray:
				if not array2.has(j):
					marray2.erase(j)
	#30% of time do not use descriptors
	if  randf() < 0.3 || marray1.empty():
		return getrandomfromarray(marray2, true)
	else:
		return getrandomfromarray(marray1) + " " + getrandomfromarray(marray2)

func anus(member):
	var array = []
	var array2 = ["SEXDESC_ANUS_BASE_1","SEXDESC_ANUS_BASE_2","SEXDESC_ANUS_BASE_3","SEXDESC_ANUS_BASE_4"]
	if member.person.get_stat('anal_virgin_lost') == null:
		array += ["SEXDESC_ANUS_VIRGIN_1","SEXDESC_ANUS_VIRGIN_2","SEXDESC_ANUS_VIRGIN_3"]
	if member.person.get_stat('age') != 'adult':
		array += ["SEXDESC_ANUS_YOUNG_1","SEXDESC_ANUS_YOUNG_2"]
	else:
		array += ["SEXDESC_ANUS_ADULT_1","SEXDESC_ANUS_ADULT_2"]
	return getrandomfromarray(array) + " " + getrandomfromarray(array2)

#register tickness
func thickness(ch):
	var thick = 0
	match ch.get_stat('tits_size'):
		'small':
			thick += 1
		'average':
			thick += 2
		'big':
			thick += 3
		'huge':
			thick += 4
	match ch.get_stat('ass_size'):
		'small':
			thick += 1
		'average':
			thick += 2
		'big':
			thick += 3
		'huge':
			thick += 4
	return thick

func getrandomfromarray(array, shouldpassempty = false):
	if !array.empty():
		return tr(array[randi()%array.size()])
	elif shouldpassempty == false:
		print("empty array passed to getrandomfromarray(array)")
		return ""
	else:
		return ""
