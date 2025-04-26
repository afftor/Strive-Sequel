extends Reference

var file
var races
var genders
var ages
var hairColors
var furs
var skinColors
var titSizes
var assSizes
var penisSizes

var hairLengths
var hairStyles
var eyeColors
var eyeShapes
var horns
var heights

onready var statlist = Statlist_init.template.duplicate(true) setget , default_stats_get

#add missing custom races here.
var portrait_races = ['Human','Elf','TribalElf','DarkElf','Orc','BeastkinCat', 'BeastkinFox', 'BeastkinWolf', 'BeastkinBunny','HalfkinCat', 'HalfkinFox', 'HalfkinWolf', 'HalfkinBunny', 'Slime', 'Scylla', 'Nereid', 'Harpy', 'Gnome', 'Goblin', 'Fairy', 'Dragonkin', 'Kobold', 'Dwarf', 'Dryad', 'Demon', 'Seraph', 'Taurus', 'Centaur', 'Lamia', 'Arachna', 'BeastkinTanuki', 'HalfkinTanuki']

func default_stats_get():
	return statlist.duplicate()
	
func _init(_file):
	file = _file
	# Scan for each attribute.
	var filterRegex = RegEx.new()
	# TODO: Build this lists of possible bodyparts dynamically?
	
	#race scan
	races = []
	for race in portrait_races:#needs fixing probably
		if race == 'Elf':
			# Avoid matching DarkElf and TribalElf for Elf
			filterRegex.compile('(?<!dark|tribal)elf')
			if filterRegex.search(file.to_lower()):
				races.append(race)
		else:
			# Search for race, with spaces stripped.
			if file.findn(race.replace(' ','')) >= 0:
				races.append(race)
	
	#gender scan
	genders = []
	filterRegex.compile('(?<!fe)male')
	if filterRegex.search(file.to_lower()):
		genders.append('male')
	if file.findn('female') >= 0:
		genders.append('female')
	if file.findn('futa') >= 0:
		genders.append('futa')
	# If no matches, assume female.
	if genders.size() == 0:
		genders.append('female')

	#age scan
	var all_ages = ['child','teen','adult','mature']
	ages = []
	for age in all_ages:
		if file.findn(age) >= 0:
			ages.append(age)
	if !ages.has('child') && file.findn('loli') >= 0:
		ages.append('child')
	# If no matches, assume adult.
	if ages.size() == 0:
		ages.append('adult')

	#hair color scan
	hairColors = []
	for color in ['auburn', 'black', 'blond', 'blue', 'brown', 'grey', 'green', 'purple', 'red', 'white', 'gradient']:
		filterRegex.compile(color.replace(' ','') + "(?!skin)")
		if filterRegex.search(file.to_lower()):
			hairColors.append(color)
	
	#fur color scan
	furs = []
	for color in ['white','grey','striped','orange','orange_white']:
		filterRegex.compile("fur" + color.replace('_',''))
		if filterRegex.search(file.to_lower()):
			furs.append("fur_"+color)
			
	#skin color scan
	skinColors = []
	for color in ['blue', 'brown', 'dark', 'fair', 'green', 'slime', 'olive', 'pale', 'paleblue', 'purple', 'tan', 'teal', 'grey', 'red']:
		if file.findn(color.replace(' ','') + 'Skin') >= 0:
			skinColors.append(color.to_lower())
	if file.findn('SkinL') >= 0: skinColors += ['pale','fair']
	if file.findn('SkinT') >= 0: skinColors += ['olive','tan']
	if file.findn('SkinD') >= 0: skinColors += ['brown','dark']
	if file.findn('SkinB') >= 0: skinColors += ['blue','pale blue', 'teal']
	if file.findn('SkinG') >= 0: skinColors.append('green')
	if file.findn('SkinP') >= 0: skinColors.append('purple')

	#tits size scan
	titSizes = []
	for size in variables.slave_basic_sizes:
		filterRegex.compile(size + "(tits|boobs|breasts|chest)")
		if filterRegex.search(file):
			titSizes.append(size)
	if file.findn('TitsF') >= 0: titSizes += ['flat']
	if file.findn('TitsT') >= 0: titSizes += ['small']
	if file.findn('TitsS') >= 0: titSizes += ['small','flat','masculine']
	if 'female' in genders || 'futa' in genders:
		for i in titSizes.count('masculine'):
			titSizes.erase('masculine')
	if file.findn('TitsM') >= 0: titSizes.append('average')
	if file.findn('(TitsB|TitsL)') >= 0: titSizes.append('big')
	if file.findn('TitsH') >= 0: titSizes.append('huge')

	#ass size scan
	assSizes = []
	for size in variables.slave_basic_sizes:
		filterRegex.compile(size + "(ass|butt)")
		if filterRegex.search(file):
			assSizes.append(size)
	if file.findn('AssF') >= 0: assSizes.append('flat')
	if file.findn('AssT') >= 0: assSizes.append('small')
	if file.findn('AssS') >= 0: assSizes += ['small','flat','masculine']
	if 'female' in genders || 'futa' in genders:
		for i in assSizes.count('masculine'):
			assSizes.erase('masculine')
	if file.findn('AssM') >= 0: assSizes.append('average')
	if file.findn('(AssB|AssL)') >= 0: assSizes.append('big')
	if file.findn('AssH') >= 0: assSizes.append('huge')
	
	#penis size scan
	penisSizes = []
	if file.findn('PenisS') >= 0: penisSizes.append('small')
	if file.findn('PenisM') >= 0: penisSizes.append('average')
	if file.findn('PenisB') >= 0: penisSizes.append('big')
	#if file.findn('PenisH') >= 0: penisSizes.append('huge')
	
	#hair length scan
	hairLengths = []
	for length in ['bald','ear','neck','shoulder','waist','hips']:
		if file.findn(length.capitalize()) >= 0: hairLengths.append(length)
	
	#hair style scan
	hairStyles = []
	for style in ['straight','ponytail','pigtails','braid','twinbraids','bun']:
		if file.findn(style.capitalize()) >= 0: hairStyles.append(style)
		
	#eye color scan
	eyeColors = []
	for color in ['blue','green','grey','brown','black','red','amber','purple','yellow']:
		filterRegex.compile("eye" + color)
		if filterRegex.search(file.to_lower()):
			eyeColors.append(color)
			
	#eye shape scan
	eyeShapes = []
	if file.findn('eshapeNormal') >= 0: eyeShapes.append('normal')
	if file.findn('eshapeSlit') >= 0: eyeShapes.append('slit')
	
	#horns scan
	horns = []
	for shape in ['short','straight','curved']:
		filterRegex.compile("horns" + shape)
		if filterRegex.search(file.to_lower()):
			horns.append(shape)
	
	#heights scan
	heights = []
	for height in ['tiny','petite','short','average','tall','towering']:
		filterRegex.compile(height + "height")
		if filterRegex.search(file.to_lower()):
			heights.append(height)
	
	
	# Uncomment the following if you want a dump of portraits found and attribtutes assigned
	# print('Added portrait %s' % file)
	# print(description())

func description():
	var desc = ''
	if !races.empty(): desc+= 'Races: ' + PoolStringArray(races).join(',') + '\n'
	if !genders.empty(): desc+= 'Genders: ' + PoolStringArray(genders).join(',') + '\n'
	if !ages.empty(): desc+= 'Ages: ' + PoolStringArray(ages).join(',') + '\n'
	if !hairColors.empty(): desc+= 'Hair Colors: ' + PoolStringArray(hairColors).join(',') + '\n'
	if !skinColors.empty(): desc+= 'Skin Colors: ' + PoolStringArray(skinColors).join(',') + '\n'
	return desc

