extends Node


var portraitCache = []
var portraitCacheAge = 0
var validPortraits = []

func _ready():
	portraitCache = gen()


func setrandom(person):
	# Weight for portrait selecting criteria is as follows:
	# Race->Sex->Age->Hair_Colour->Skin_Colour->Natural_Selection
	if(portraitCache != null):
		validPortraits = portraitCache.duplicate()
	else:
		return
	# Filter on Race
	var filteringPortraits = []
	if(validPortraits.empty()):
		print("fail")
		return
	for p in validPortraits:
		if p.races.has(person.race):
			filteringPortraits.append(p)
	if rnd_settings.debug: print('Filtered on race %s, resulted in %d portraits.' % [person.race, filteringPortraits.size()])
	if (filteringPortraits.size() < rnd_settings.minMatch):
		return
	if !filteringPortraits.empty():
		validPortraits.clear()
		validPortraits = filteringPortraits

	# Filter on Gender
	filteringPortraits = []
	for p in validPortraits:
		if p.genders.has(person.sex):
			filteringPortraits.append(p) #Add portrait that has required sex
	if rnd_settings.debug: print('Filtered on gender %s, resulted in %d portraits.' % [person.sex, filteringPortraits.size()])
	if (filteringPortraits.size() < rnd_settings.minMatch):
		return
	if !filteringPortraits.empty():
		validPortraits.clear()
		validPortraits = filteringPortraits

	# Filter on Age
	filteringPortraits = []
	for p in validPortraits:
		if p.ages.has(person.age):
			filteringPortraits.append(p)
	if (filteringPortraits.size() < rnd_settings.minMatch):
		# Not enough, let's broaden things a bit.
		if person.age == 'adult':
			# Add teens to adult.
			for p in validPortraits:
				if p.ages.has('teen'):
					filteringPortraits.append(p)
		elif person.age == 'teen':
			# Add childs to teen.
			for p in validPortraits:
				if p.ages.has('child'):
					filteringPortraits.append(p) 
			if (filteringPortraits.size() < rnd_settings.minMatch):
				# Add adults too.
				for p in validPortraits:
					if p.ages.has('adult'):
						filteringPortraits.append(p)
		elif person.age == 'child':
			# Add childs to teen.
			for p in validPortraits:
				if p.ages.has('teen'):
					filteringPortraits.append(p) #Add portrait with the right race
		elif person.age == 'mature': # new age added to conquest, may not being assigning portraits correctly - need to fix.
			# Add mature to adult.
			for p in validPortraits:
				if p.ages.has('adult'):
					filteringPortraits.append(p) #Add portrait with the right race
	if rnd_settings.debug: print('Filtered on age %s, resulted in %d portraits.' % [person.age, filteringPortraits.size()])
	if (filteringPortraits.size() < rnd_settings.minMatch):
		# still not enough? abort
		return
	if !filteringPortraits.empty():
		validPortraits.clear()
		validPortraits = filteringPortraits

	# Weighted filtering for the remainder
	var totalWeight = 0.0
	var weightedPortraits = []
	#hair color renamed, is furcolor == fur?
	var haircolor = ''
	if person.hair_color != null && !person.hair_color.empty():
		haircolor = person.hair_color
	elif person.fur != null && !person.fur.empty():
		haircolor = person.fur
	
	if rnd_settings.debug: print('Generating weights for hair: %s, skin: %s, tits: %s, and ass: %s' % [haircolor, person.skin, person.tits_size, person.ass_size])
	for p in validPortraits:
		var pWeight = rnd_settings.base_weight
		if !haircolor.empty() && p.hairColors.has(haircolor):
			if pWeight <= 0: pWeight = 1.0
			pWeight *= rnd_settings.haircolor_weight
		if person.skin != null && !person.skin.empty() && p.skinColors.has(person.skin):
			if pWeight <= 0: pWeight = 1.0
			pWeight *= rnd_settings.skincolor_weight
		if person.tits_size != null && !person.tits_size.empty() && p.titSizes.has(person.tits_size):
			if pWeight <= 0: pWeight = 1.0
			pWeight *= rnd_settings.titsize_weight
		if person.ass_size != null && !person.ass_size.empty() && p.assSizes.has(person.ass_size):
			if pWeight <= 0: pWeight = 1.0
			pWeight *= rnd_settings.asssize_weight
		if pWeight > 0:
			if rnd_settings.debug: print('Weight: %8.1f Portrait: %s' % [pWeight, p.file])
			var wp = {'weight': pWeight, 'file': p.file}
			weightedPortraits.append(wp)
			totalWeight += pWeight


	if !weightedPortraits.empty():
		var selection = randf() * totalWeight
		if rnd_settings.debug: print("%d weighted profiles, total weight: %.1f, selected weight: %f" % [weightedPortraits.size(), totalWeight, selection])
		for wp in weightedPortraits:
			selection -= wp.weight
			if selection < 0:
				if rnd_settings.debug: print('Assigning portrait: %s' % wp.file)
				person.imageportait = wp.file
				break
	elif !validPortraits.empty():
		# Revert to old random selection
		person.imageportait = validPortraits[randi() % validPortraits.size()].file
	else:
		person.imageportait = portraitCache[randi() % validPortraits.size()].file
	return person.imageportait


func gen(): # used by globals.gd _ready() to generate portrait cache once, greatly decreasing load times on larger systems
	var arr=[]
	var time_start = OS.get_unix_time()
	for file in input_handler.dir_contents(input_handler.globalsettings.portrait_folder):
		arr.append(ResourceScripts.scriptdict.rnd_portrait.new(file))
	var time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	print('Generating portrait attribute cache took ', minutes, ' minutes and ', seconds, ' seconds.')
	if arr.empty(): return # No portraits, nothing to do.
	return arr
