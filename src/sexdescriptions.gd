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
	outputs += [getrandomfromarray(['fuck','plow','screw','penetrate','churn','pummel'])]
	temp = getrandomfromarray(['plunge','hammer','pound','pump','slam','thrust','grind','drive'])
	temp += getrandomfromarray([' ' + his(group) + ' ' + penis(group),''])
	temp += getrandomfromarray([' deep','']) + ' into'
	outputs += [temp]
	temp = getrandomfromarray(['plunge','pump','slide','thrust'])
	temp += getrandomfromarray([' ' + his(group) + ' ' + penis(group),'']) + ' in and out of'
	outputs += [temp]
	temp = getrandomfromarray(['plunge','thrust'])
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
	outputs += [getrandomfromarray(['fucks','plows','screws','penetrates','churns','pummels'])]
	temp = getrandomfromarray(['plunges','hammers','pounds','pumps','slams','thrusts','grinds','drives'])
	temp += getrandomfromarray([' ' + his(group) + ' ' + penis(group),''])
	temp += getrandomfromarray([' deep','']) + ' into'
	outputs += [temp]
	temp = getrandomfromarray(['plunges','pumps','slides','thrusts'])
	temp += getrandomfromarray([' ' + his(group) + ' ' + penis(group),'']) + ' in and out of'
	outputs += [temp]
	temp = getrandomfromarray(['plunges','thrusts'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + penis(group),himself(group)])
	temp += ' ' + getrandomfromarray(['in and out of','into','inside'])
	outputs += [temp]
	return outputs[randi()%outputs.size()]

func fucking(group):
	var outputs = []
	var temp = ''
	outputs += [getrandomfromarray(['fucking','plowing','screwing','penetrating','churning','pummeling'])]
	temp = getrandomfromarray(['plunging','hammering','pounding','pumping','slaming','thrusting','grinding','driving'])
	temp += getrandomfromarray([' ' + his(group) + ' ' + penis(group),''])
	temp += getrandomfromarray([' deep','']) + ' into'
	outputs += [temp]
	temp = getrandomfromarray(['plunging','pumping','sliding','thrusting'])
	temp += getrandomfromarray([' ' + his(group) + ' ' + penis(group),'']) + ' in and out of'
	outputs += [temp]
	temp = getrandomfromarray(['plunging','thrusting'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + penis(group),himself(group)])
	temp += ' ' + getrandomfromarray(['in and out of','into','inside'])
	outputs += [temp]
	return outputs[randi()%outputs.size()]

func vfuck(group):
	var outputs = []
	var temp = ''
	outputs += [getrandomfromarray(['massage','squeeze','envelop','milk'])]
	temp = getrandomfromarray(['grind','bounce','gyrate'])
	temp += ' ' + getrandomfromarray(['on top of','on','atop'])
	outputs += [temp]
	temp = getrandomfromarray(['grind','bounce','gyrate','thrust','pump','work'])
	temp += ' ' + his(group) + ' ' + hips(group)
	temp += ' ' + getrandomfromarray(['on top of','on','atop'])
	outputs += [temp]
	temp = getrandomfromarray(['grind','thrust','slam','pound'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + pussy(group),himself(group)])
	temp += ' ' + getrandomfromarray(['against','down on'])
	outputs += [temp]
	temp = getrandomfromarray(['impale','pleasure','churn','satisfy'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + pussy(group),himself(group)])
	temp += ' ' + getrandomfromarray(['on top of','on'])
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
	outputs += [getrandomfromarray(['massages','squeezes','envelops','milks'])]
	temp = getrandomfromarray(['grinds','bounces','gyrates'])
	temp += ' ' + getrandomfromarray(['on top of','on','atop'])
	outputs += [temp]
	temp = getrandomfromarray(['grinds','bounces','gyrates','thrusts','pumps','works'])
	temp += ' ' + his(group) + ' ' + hips(group)
	temp += ' ' + getrandomfromarray(['on top of','on','atop'])
	outputs += [temp]
	temp = getrandomfromarray(['grinds','thrusts','slams','pounds'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + pussy(group),himself(group)])
	temp += ' ' + getrandomfromarray(['against','down on'])
	outputs += [temp]
	temp = getrandomfromarray(['impales','pleasures','churns','satisfies'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + pussy(group),himself(group)])
	temp += ' ' + getrandomfromarray(['on top of','on'])
	outputs += [temp]
	return outputs[randi()%outputs.size()]

func vfucking(group):
	var outputs = []
	var temp = ''
	outputs += [getrandomfromarray(['massaging','squeezing','enveloping','milking'])]
	temp = getrandomfromarray(['grinding','bouncing','gyrating'])
	temp += ' ' + getrandomfromarray(['on top of','on','atop'])
	outputs += [temp]
	temp = getrandomfromarray(['grinding','bouncing','gyrating','thrusting','pumping','working'])
	temp += ' ' + his(group) + ' ' + hips(group)
	temp += ' ' + getrandomfromarray(['on top of','on','atop'])
	outputs += [temp]
	temp = getrandomfromarray(['grinding','thrusting','slamming','pounding'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + pussy(group),himself(group)])
	temp += ' ' + getrandomfromarray(['against','down on'])
	outputs += [temp]
	temp = getrandomfromarray(['impaling','pleasuring','churning','satisfying'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + pussy(group),himself(group)])
	temp += ' ' + getrandomfromarray(['on top of','on'])
	outputs += [temp]
	return outputs[randi()%outputs.size()]

func afuck(group):
	var outputs = []
	var temp = ''
	outputs += [getrandomfromarray(['massage','squeeze','envelop','milk'])]
	temp = getrandomfromarray(['grind','bounce','gyrate'])
	temp += ' ' + getrandomfromarray(['on top of','on','atop'])
	outputs += [temp]
	temp = getrandomfromarray(['grind','bounce','gyrate','thrust','pump','work'])
	temp += ' ' + his(group) + ' ' + hips(group)
	temp += ' ' + getrandomfromarray(['on top of','on','atop'])
	outputs += [temp]
	temp = getrandomfromarray(['grind','thrust','slam','pound'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + anus(group),himself(group)])
	temp += ' ' + getrandomfromarray(['against','down on'])
	outputs += [temp]
	temp = getrandomfromarray(['impale','pleasure','churn','satisfy'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + anus(group),himself(group)])
	temp += ' ' + getrandomfromarray(['on top of','on'])
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
	outputs += [getrandomfromarray(['massages','squeezes','envelops','milks'])]
	temp = getrandomfromarray(['grinds','bounces','gyrates'])
	temp += ' ' + getrandomfromarray(['on top of','on','atop'])
	outputs += [temp]
	temp = getrandomfromarray(['grinds','bounces','gyrates','thrusts','pumps','works'])
	temp += ' ' + his(group) + ' ' + hips(group)
	temp += ' ' + getrandomfromarray(['on top of','on','atop'])
	outputs += [temp]
	temp = getrandomfromarray(['grinds','thrusts','slams','pounds'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + anus(group),himself(group)])
	temp += ' ' + getrandomfromarray(['against','down on'])
	outputs += [temp]
	temp = getrandomfromarray(['impales','pleasures','churns','satisfies'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + anus(group),himself(group)])
	temp += ' ' + getrandomfromarray(['on top of','on'])
	outputs += [temp]
	return outputs[randi()%outputs.size()]

func afucking(group):
	var outputs = []
	var temp = ''
	outputs += [getrandomfromarray(['massaging','squeezing','enveloping','milking'])]
	temp = getrandomfromarray(['grinding','bouncing','gyrating'])
	temp += ' ' + getrandomfromarray(['on top of','on','atop'])
	outputs += [temp]
	temp = getrandomfromarray(['grinding','bouncing','gyrating','thrusting','pumping','working'])
	temp += ' ' + his(group) + ' ' + hips(group)
	temp += ' ' + getrandomfromarray(['on top of','on','atop'])
	outputs += [temp]
	temp = getrandomfromarray(['grinding','thrusting','slamming','pounding'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + anus(group),himself(group)])
	temp += ' ' + getrandomfromarray(['against','down on'])
	outputs += [temp]
	temp = getrandomfromarray(['impaling','pleasuring','churning','satisfying'])
	temp += ' ' + getrandomfromarray([his(group) + ' ' + anus(group),himself(group)])
	temp += ' ' + getrandomfromarray(['on top of','on'])
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
			array1 += ["muscular","toned"]
		elif thick < 3:
			array1 += ["dainty","delicate","slim"]
		elif thick < 5:
			array1 += ["healthy","shapely"]
		elif thick < 7:
			array1 += ["healthy","shapely","sensuous","curvaceous","buxom"]
		else:
			array1 += ["sensuous","curvaceous","buxom","voluptuous","bombastic","meaty"]
		#body
		if i.person.get_stat('pregnancy_duration') > 1:
			array1 += ["pregnant","gravid"]
		#age
		match i.person.get_stat('age'):
			'child':
				array1 += ["young","adolescent"]
				array2 += ["child"] if group.size() == 1 else ["children"]
			'teen':
				array1 += ['young']
				array2 += ["teen"] if group.size() == 1 else ["teens"]
			_:
				array1 += ['mature', 'adult']
		#beauty
		if i.person.get_stat('charm') >= 50:
			array1 += ['attractive']
			if i.person.get_stat('sex') == 'male':
				array1 += ['handsome']
			elif i.person.get_stat('age') == 'child':
				array1 += ['cute','pretty']
			elif i.person.get_stat('age') == 'teen':
				array1 += ['cute','pretty','beautiful']
			else:
				array1 += ['pretty','beautiful']
		#size
		match i.person.get_stat('height'):
			'petite','shortstack':
				array1 += ["tiny","small","little","pint-sized","diminutive"]
			'tall', 'towering':
				array1 += ["giant","large","big","tall"]
		#personality
		if i.person.get_stat('charm') > 60:
			if i.person.get_stat('age') in ['child','teen']:
				array1 += ['adorable','cute']
			if i.person.get_stat('age') in ['adult','teen','mature']:
				array1 += ['charming','enchanting','captivating']
		if i.person.get_stat('personality') == 'shy':
			array1 += ['shy','meek']
		if i.person.get_stat('wits') > 80:
			array1 += ['clever']
		if i.person.get_stat('personality') == 'bold':
			array1 += ['brave','haughty']
		if i.lust > 300:
			array1 += ['horny', 'excited']
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
			array1 += ["muscular","toned"]
		elif thick < 3:
			array1 += ["dainty","delicate","slim","petite"]
		elif thick < 5:
			array1 += ["healthy","shapely"]
		elif thick < 7:
			array1 += ["healthy","shapely","sensuous","curvaceous","buxom"]
		else:
			array1 += ["sensuous","curvaceous","buxom","voluptuous","bombastic","meaty"]
		#body
		if i.person.get_stat('pregnancy_duration') > 1:
			array1 += ["pregnant","gravid"]
		#age
		if i.person.get_stat('age') == 'child':
			array1 += ["young","adolescent"]
			array2 += ["child's"] if group.size() == 1 else ["childrens'"]
		elif i.person.get_stat('age') == 'teen':
			array1 += ['young']
			array2 += ["teen's"] if group.size() == 1 else ["teens'"]
		else:
			array1 += ['mature', 'adult']
		#beauty
		if i.person.get_stat('charm') >= 50:
			array1 += ['attractive']
			if i.person.get_stat('sex') == 'male':
				array1 += ['handsome']
			elif i.person.get_stat('age') == 'child':
				array1 += ['cute','pretty']
			elif i.person.get_stat('age') == 'teen':
				array1 += ['cute','pretty','beautiful']
			else:
				array1 += ['pretty','beautiful']
		#size
		if i.person.get_stat('height') in ['petite','shortstack']:
			array1 += ["tiny","small","little","pint-sized","diminutive"]
		elif i.person.get_stat('height') in ['tall', 'towering']:
			array1 += ["giant","huge","large","big","tall"]
		#personality
		if i.person.get_stat('charm') > 60:
			if i.person.get_stat('age') in ['child','teen']:
				array1 += ['adorable','cute']
			if i.person.get_stat('age') in ['adult','teen']:
				array1 += ['charming','enchanting','captivating']
#		if mp.cour < 40:
#			array1 += ['shy','meek']
		if i.person.get_stat('wits') > 80:
			array1 += ['clever']
#		if mp.conf > 65:
#			array1 += ['proud','haughty']
		if i.lust > 300:
			array1 += ['horny', 'excited']
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
		array2 = ["body"] if group.size() == 1 else ["bodies"]
		var thick = thickness(i.person)
		#feminity
		if i.person.get_stat('tits_size') == 'masculine':
			array1 += ["muscular","toned"]
		elif thick < 3:
			array1 += ["dainty","delicate","slim","petite"]
		elif thick < 5:
			array1 += ["healthy","shapely"]
		elif thick < 7:
			array1 += ["healthy","shapely","sensuous","curvaceous","buxom"]
		else:
			array1 += ["sensuous","curvaceous","buxom","voluptuous","bombastic"]
		#beauty
		if i.person.get_stat('charm') >= 50:
			array1 += ['alluring','enticing']
			if i.person.get_stat('age') in ['adult','teen'] && i.person.get_stat('sex') != 'male':
				array1 += ['ravishing','seductive']
		#age
		if i.person.get_stat('age') == 'child':
			array1 += ["youthful","immature"]
		elif i.person.get_stat('age') == 'teen':
			array1 += ["youthful"]
		elif i.person.get_stat('age') == 'adult':
			if i.person.get_stat('sex') == 'male':
				array1 += ["manly"]
			else:
				array1 += ["womanly","mature"]
		#size
		if i.person.get_stat('height') in ['petite','shortstack']:
			array1 += ["tiny","small","little"]
		elif i.person.get_stat('height') in ['tall','towering']:
			array1 += ["giant","huge","large"]
		#bodytype
		if i.person.get_stat('body_shape') == 'jelly':
			array1 += ["transparent","squishy","gelatinous"]
		if i.person.get_stat('body_shape') == 'halfsnake':
			array1 += ["long","serpentine"]
		elif i.person.get_stat('skin_coverage') == 'full_body_fur':
			array1 += ["furry","fluffy","fur-covered"]
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
		array2 = ['cock','dick','penis','shaft'] if group.size() == 1 else ['cocks','dicks','penises','shafts']
		if i.person.get_stat('penis_size') == 'small':
			array1 += ["tiny","small","petite"]
			if i.person.get_stat('age') == 'child':
				array1 += ["immature"]
		elif i.person.get_stat('penis_size')== 'average':
			array1 += ["average-sized","decently-sized"]
			if i.person.get_stat('age') == 'child':
				array1 += ["well-developed","adult-like"]
		elif  i.person.get_stat('penis_size') == 'big':
			array1 += ["big","sizeable","thick","girthy","impressively large"]
			if i.person.get_stat('age') == 'child':
				array1 += ["overgrown","surprisingly large"]
		#penistype descriptors
		match i.person.get_stat('penis_type'):
			'feline':
				array1 += ['barbed']
			'canine':
				array1 += ['knotted','tapered']
			'equine':
				array1 += ['flared','long']
				array2 += ['horse cock','horse dick']
		#other descriptors
		if i.person.get_stat('penis_size') == '':
			array2 = ['strap-on','shaft'] if group.size() == 1 else ['strap-ons','shafts']
		elif i.person.get_stat('sex') == 'male':
			array2 += ['manhood'] if group.size() == 1 else ['manhoods']
		elif i.person.get_stat('sex') == 'futanari':
			array1 += ['futa']
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
		array2 = ["vagina","pussy","cunt"] if group.size() == 1 else ["vaginas","pussies","cunts"]
		#body
		if i.horny >= 100:
			array1 += ["wet","slick","dripping"]
		if i.person.get_stat('has_womb') && i.person.get_stat('pregnancy_duration') == 0:
			array1 += ["fertile"]
		if i.person.get_stat('vaginal_virgin'):
			array1 += ["virgin","virginal","unused"]
#		if mp.pubichair == 'clean':
#			if mp.age == 'child':
#				array1 += ["smooth","hairless","pubeless","bald"]
#			else:
#				array1 += ["smoothly shaved","hairless","pubeless","shaved"]
		#age
		match i.person.get_stat('age'):
			'child':
				array1 += ["childish","immature","girlish","youthful","undeveloped"]
			'teen':
				array1 += ["girlish","youthful","developing"]
			_:
				array1 += ["womanly","mature","developed"]
		#race
		if i.person.get_stat('body_shape') == 'halfhorse':
			array1 += ["muscular","horse","horse"]
		else:
			array2 += ["slit"] if group.size() == 1 else ["slits"]
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
	var array = ["labia","pussy lips","genitals","folds"]
	return getrandomfromarray(array)

func ass(group):
	var array1 = []
	var array2 = []
	var marray1 = null
	var marray2 = null
	var tarray = []
	for i in group:
		array1 = []
		array2 = ["ass","butt","backside","rear"] if group.size() == 1 else ["asses","butts","backsides","rears"]
		#size/age descriptors

		if i.person.get_stat('skin_coverage').find('fur') >= 0:
			array1 += ['fuzzy','fluffy','furry']
		match i.person.get_stat('ass_size'):
			'flat':
				array1 += ["flat","compact"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["tiny","developing","childlike"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["tiny","developing","undeveloped","immature"]
			'small':
				array1 += ["small","compact"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["developing"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["undeveloped","immature"]
			'average':
				array1 += ["round","well-rounded","shapely"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["well-developed"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["well-developed","impressively large"]
			'big':
				array1 += ["big","sizeable","plump","hefty"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["well-developed","impressively large"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["overgrown","surprisingly large"]
			'huge':
				array1 += ["huge","massive","fat","meaty","gigantic","enormous"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["well-developed","surprisingly large"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["overgrown","shockingly large"]
		#bodytype descriptors
		match i.person.get_stat('body_shape'):
			'jelly':
				array1 += ["gelatinous","slimy","gooey"]
			'halfhorse':
				array1 += ["equine","hairy"]
				array2 += ["hindquarters"]
			'halfspider':
				array1 += ["chitinous","spider"]
				array2 = ["abdomen","butt"] if group.size() == 1 else ["abdomens","butts"]
		#beauty descriptors
		if i.person.get_stat('charm') >= 50:
			if i.person.get_stat('age') == 'child':
				array1 += ["cute","cute","flawless","perfect"]
			elif i.person.get_stat('age') == 'teen':
				array1 += ["cute","beautiful","flawless","perfect"]
			else:
				array1 += ["seductive","beautiful","flawless","perfect"]
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
		array2 = ["hips"]
		#size/age descriptors
		if i.person.get_stat('skin_coverage').find('fur') >= 0:
			array1 += ['fuzzy','fluffy','furry']
		if i.person.get_stat('sex') == 'male' && i.person.get_stat('ass_size') in ['flat','small']:
			array1 += ["trim","slim"]
		else:
			match i.person.get_stat('ass_size'):
				'flat':
					array1 += ["slim","slender","petite","tiny"]
				'small':
					array1 += ["slim","slender","svelte","small"]
				'average':
					array1 += ["curved","shapely"]
					if i.person.get_stat('age') == 'teen':
						array1 += ["well-developed"]
					elif i.person.get_stat('age') == 'child':
						array1 += ["well-developed","impressively thick"]
				'big':
					array1 += ["sizeable","ample","wide","thick","curvaceous"]
					if i.person.get_stat('age') == 'teen':
						array1 += ["well-developed","impressively thick"]
					elif i.person.get_stat('age') == 'child':
						array1 += ["overgrown","surprisingly thick"]
				'huge':
					array1 += ["huge","massive","enormous","wide","thick","curvaceous"]
					if i.person.get_stat('age') == 'teen':
						array1 += ["well-developed","surprisingly thick"]
					elif i.person.get_stat('age') == 'child':
						array1 += ["overgrown","shockingly thick"]
		#bodytype descriptors
		if i.person.get_stat('body_shape') == 'halfhorse':
			array1 += ["equine","hairy"]
		elif i.person.get_stat('body_shape') == 'halfsnake':
			array1 += ["scaly"]
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
		array2 = ["tits","boobs","breasts","chest"] if group.size() == 1 else ["tits","boobs","breasts","chests"]
		#size/age descriptors
		if i.person.get_stat('skin_coverage').find('fur') >= 0:
			array1 += ['fuzzy','fluffy','furry']
		match i.person.get_stat('tits_size'):
			'masculine':
				array1 += ["muscular","strong","toned"]
				array2 = ["chest","pecs"] if group.size() == 1 else ["chests","pecs"]
			'flat':
				array1 += ["flat","small"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["tiny","developing","childlike"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["tiny","developing","undeveloped","immature"]
			'small':
				array1 += ["small","compact"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["developing"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["undeveloped","immature"]
			'average':
				array1 += ["round","well-rounded","shapely"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["well-developed"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["well-developed","impressively large"]
			'big':
				array1 += ["big","sizeable","plump","hefty"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["well-developed","impressively large"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["overgrown","surprisingly large"]
			'huge':
				array1 += ["huge","massive","fat","meaty","gigantic","enormous"]
				if i.person.get_stat('age') == 'teen':
					array1 += ["well-developed","surprisingly large"]
				elif i.person.get_stat('age') == 'child':
					array1 += ["overgrown","shockingly large"]
		#bodytype descriptors
		if i.person.get_stat('body_shape') == 'jelly':
			array1 += ["gelatinous","slimy","gooey"]
		#beauty descriptors
		if i.person.get_stat('charm') >= 50:
			match i.person.get_stat('age'):
				'child':
					array1 += ["cute","cute","flawless","perfect"]
				'teen':
					array1 += ["cute","beautiful","flawless","perfect"]
				_:
					array1 += ["seductive","beautiful","flawless","perfect"]
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

func anus(member):
	var array = []
	var array2 = ["anus","asshole","butthole","rectum"]
	if member.person.get_stat('anal_virgin_lost') == null:
		array += ["virgin","virginal","unused"]
	if member.person.get_stat('age') != 'adult':
		array += ["pink","youthful"]
	else:
		array += ["rosy","mature"]
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

func getrandomfromarray(array):
	if !array.empty():
		return array[randi()%array.size()]
	else:
		print("empty array passed to getrandomfromarray(array)")
		return ""
