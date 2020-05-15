extends Reference
class_name Item

var name = ""
var id
var itembase
var code
var icon
var description = ''
var stackable = false
#var inventory

#Useable data
var amount = 1 setget amount_set
var useeffects
var useskill

#Gear Data
var type
var itemtype
var toolcategory
var geartype
var subtype
var durability
var maxdurability
var price
var bonusstats = {} #bonus stats apply to chars
var parts = {}
var effects = []
var reqs = []
var task
var owner = null
var partcolororder
var broken = false
var tags = []
var materials = []
var weaponrange
var multislots = []
var slots = []
var hitsound
var interaction_use = false


func CreateUsable(ItemName = '', number = 1):
	type = 'usable'
	itembase = ItemName
	code = ItemName
	stackable = true
	amount = number
	var itemtemplate = Items.itemlist[ItemName]
	if itemtemplate.icon != null:
		icon = itemtemplate.icon.get_path()
	name = itemtemplate.name
	if itemtemplate.has("interaction_effect"):
		interaction_use = true
	itemtype = 'usable'
	description = itemtemplate.descript
	#itemtype = itemtemplate.itemtype
#	useeffects = itemtemplate.useeffects
#	useskill = itemtemplate.useskill
#	description = itemtemplate.description

func amount_set(value):
	amount = value
	if amount <= 0:
		ResourceScripts.game_res.items.erase(id)

func UseItem(user = null, target = null):
	var finaltarget
	for i in effects:
		var effect = Effectdata.effects[i]
		if i.taker == 'caster':
			if user == null:
				return
			finaltarget = user
		elif i.taker == 'target':
			if target == null:
				return
			finaltarget = target
		Effectdata.call(effect.effect, finaltarget, effect.value)

func CreateGear(ItemName = '', dictparts = {}, bonus = {}):
	var mode = 'normal'
	if dictparts.size() == 0:
		mode = 'simple'
	itembase = ItemName
	bonusstats = {}#task_energy_tool = 0, task_efficiency_tool = 0, atk = 0, matk = 0, damagemod = 1, armor = 0, armorpenetration = 0, evasion = 0, hitrate = 0, hpmax = 0, hpmod = 0, manamod = 0, speed = 0, resistfire = 0, resistearth = 0, resistair = 0, resistwater = 0, mdef = 0}
	stackable = false
	type = 'gear'
	var itemtemplate = Items.itemlist[ItemName]
	var tempname = itemtemplate.name
	
	geartype = itemtemplate.geartype
	if itemtemplate.has('weaponrange'):
		weaponrange = itemtemplate.weaponrange
	itemtype = itemtemplate.itemtype
	if itemtemplate.tags.has('tool'):
		toolcategory = itemtemplate.tool_category
	
	for i in itemtemplate.basestats:
		if bonusstats.has(i):
			bonusstats[i] += itemtemplate.basestats[i]
		else:
			bonusstats[i] = itemtemplate.basestats[i]
	
	if itemtemplate.has('effects'):
		for e in itemtemplate.effects:
			effects.push_back(e)
	
	reqs = itemtemplate.reqs
	tags = itemtemplate.tags
	if itemtemplate.has('multislots'):
		multislots = itemtemplate.multislots
	if itemtemplate.has('hitsound'):
		hitsound = itemtemplate.hitsound
	slots = itemtemplate.slots
	if mode == 'normal':
		parts = dictparts.duplicate()
		#durability = itemtemplate.basedurability
		partcolororder = itemtemplate.partcolororder
	
		var parteffectdict = {}
		for i in parts:
			var material = Items.materiallist[parts[i]]
			var materialeffects = material['parts'][i].duplicate(true)
			if itemtemplate.itemtype == 'armor':
				for i in materialeffects:
					materialeffects[i] = float(materialeffects[i]) / 2
			materials.append(material.code)
			input_handler.AddOrIncrementDict(parteffectdict, materialeffects)
#		if parteffectdict.has('durabilitymod'):
#			durability *= parteffectdict.durabilitymod
		for i in parteffectdict:
			if self.get(i) != null && i != 'effects':
				#self[i] += parteffectdict[i]
				set(i, get(i)+parteffectdict[i])
			elif bonusstats.has(i):
				bonusstats[i] += parteffectdict[i]
			elif i == 'effects':
				for k in parteffectdict[i]:
					effects.append(k)
			else:
				bonusstats[i] = parteffectdict[i]
		for i in itemtemplate.basemods:
			if bonusstats.has(i):
				bonusstats[i] *= itemtemplate.basemods[i]
	
	if itemtemplate.icon != null:
		if itemtemplate.has("alticons"):
			var alticon = false
			for i in itemtemplate.alticons.values():
				if i.materials.has(parts[i.part]):
					icon = i.icon.get_path()
					if i.has('altname'):
						tempname = i.altname
					alticon = true
			if alticon == false:
				icon = itemtemplate.icon.get_path()
		else:
			icon = itemtemplate.icon.get_path()
	
	if mode == 'normal':
		#durability = round(durability)
		#maxdurability = round(durability)
		if dictparts.size() == itemtemplate.parts.size():
			name = Items.materiallist[dictparts[itemtemplate.partmaterialname]].adjective.capitalize() + ' ' + tempname
		else:
			name = tempname
	if bonusstats.has('atk') && bonusstats.has('damagemod'):
		bonusstats.atk = ceil(bonusstats.atk + (bonusstats.atk*bonusstats.damagemod))
		bonusstats.erase('damagemod')
	
	if mode == 'simple':
		name = itemtemplate.name
		description = itemtemplate.descript
	else:
		if parts.has(itemtemplate.partmaterialname):
			
			name = Items.materiallist[parts[itemtemplate.partmaterialname]].adjective + " " +itemtemplate.name
		else:
			name = itemtemplate.name
		#name = itemtemplate.partmaterialname
	

func substractitemcost():
	var itemtemplate = Items.itemlist[itembase]
	for i in parts:
		ResourceScripts.game_res.materials[parts[i]] -= itemtemplate.parts[i]

func set_icon(node):
	var icon_texture = input_handler.loadimage(icon)
#	if ResourcePreloader.new().has_resource(icon) == false:
#		icon_texture = input_handler.loadimage(icon)
#	else:
#		icon_texture = load(icon)
	
	if node.get_class() == "TextureButton":
		node.texture_normal = icon_texture
	else:
		node.texture = icon_texture
	node.material = null
	if parts.size() > 0:
		var shader = load("res://assets/ItemShader.tres").duplicate()
		if node.material != shader:
			node.material = shader
		else:
			shader = node.material
		for i in parts:
			var part = 'part' +  str(partcolororder[i]) + 'color'
			var color = Items.materiallist[parts[i]].color
			node.material.set_shader_param(part, color)


func tooltiptext():
	var text = ''
	text += '[center]' + name + '[/center]\n'
	if geartype != null:
		text += 'Type: ' + geartype + "\n"
	else:
		text += "Type: Usable\n"
	
	if slots.size() > 0:
		text += "Slots: "
		for i in slots:
			text += tr("ITEMSLOT"+i.to_upper()) + ", "
		text = text.substr(0, text.length() -2) + ". \n"
	
	if toolcategory != null:
		text += tr("TOOLWORKCATEGORY") + ": " 
		for i in toolcategory:
			text += statdata.worktoolnames[i] +", "
		text = text.substr(0, text.length()-2) 
	if description != null:
		text += description
	if !reqs.empty():
		var tempslave = ResourceScripts.scriptdict.class_slave.new()
		text += "\n" + tempslave.decipher_reqs(reqs)
	if itemtype in ['armor','weapon','tool']:
		text += "\n\n"
		for i in bonusstats:
			if bonusstats[i] != 0:
				var value = bonusstats[i]
				var change = ''
				if statdata.statdata[i].has('percent'):
					value = value*100
				text += statdata.statdata[i].name + ': {color='
				if value > 0:
					change = '+'
					text += 'green|' + change
				else:
					text += 'red|'
				value = str(value)
				if statdata.statdata[i].has('percent'):
					value = value + '%'
				text += value + '}\n'
		text += tooltipeffects()
	elif itemtype == 'usable':
		text += '\n\n' + tr("INPOSESSION") + ': ' + str(amount)
	
	text = globals.TextEncoder(text)
	return text

func tooltipeffects():
	var text = ''
	for i in effects:
		if Effectdata.effect_table[i].descript != '':
			text += Effectdata.effect_table[i].descript + "\n"
#		text += "{color=" + Effectdata.effects[i].textcolor + '|' + Effectdata.effects[i].descript
#		text += '}\n'
	return text

func tooltip(targetnode):
	var node = input_handler.get_spec_node(input_handler.NODE_ITEMTOOLTIP) #input_handler.GetItemTooltip()
	var data = {text = tooltiptext(), icon = input_handler.loadimage(icon, 'icons'), item = self, price = str(calculateprice())}
	node.showup(targetnode, data, 'gear')


func repairwithmaterials():
	var materialsdict = counterepairmaterials()
	
	durability = maxdurability
	
	for i in materialsdict:
		ResourceScripts.game_res.materials[i] -= materialsdict[i]

func canrepairwithmaterials(): #checks if item can be repaired at present state and returns the problem
	var canrepair = true
	var text = ''
	var materialsdict = counterepairmaterials()
	
	for i in materialsdict:
		if ResourceScripts.game_res.materials[i] < materialsdict[i]:
			canrepair = false
			text += tr("NOTENOUGH") + ' [color=yellow]' + Items.materiallist[i].name + '[/color]'
	
	if effects.has('brittle'):
		canrepair = false
		text = tr("CANTREPAIREFFECT")
	
	var returndict = {canrepair = canrepair, text = text}
	
	return returndict

func calculatematerials():
	var itemtemplate = Items.itemlist[itembase] #item base for item parts amount
	var materialsdict = {} #total materials used in creation
	#collecting parts info
	for i in parts:
		if materialsdict.has(parts[i]):
			materialsdict[parts[i]] += itemtemplate.parts[i]
		else:
			materialsdict[parts[i]] = itemtemplate.parts[i]
	return materialsdict

func counterepairmaterials():
	var requiredmaterialsdict = calculatematerials()
	var itemtemplate = Items.itemlist[itembase] 
	
	#calculating total resource needs
	var multiplier = 0
	match itemtemplate.repairdifficulty: #0.5, 0.65, 0.8
		'easy':
			multiplier = variables.RepairCostMultiplierEasy
		'medium':
			multiplier = variables.RepairCostMultiplierMedium
		'hard':
			multiplier = variables.RepairCostMultiplierHard
	if effects.has('natural'): #0.15
		multiplier -= variables.ItemEffectNaturalMultiplier
	
	var durabilitymultiplier = 1 - durability/maxdurability
	
	for i in requiredmaterialsdict:
		requiredmaterialsdict[i] *= multiplier * durabilitymultiplier
		requiredmaterialsdict[i] = ceil(requiredmaterialsdict[i])
	
	return requiredmaterialsdict

func calculateprice():
	var price = 0
	if itemtype == 'usable' || Items.itemlist[itembase].crafttype == 'basic':
		price = Items.itemlist[itembase].price
	else:
		var materialsdict = calculatematerials()
		for i in materialsdict:
			price += Items.materiallist[i].price*materialsdict[i]
		price += Items.recipes[itembase].workunits * 5
	return price

func use_explore(character):
	var itemskill = Items.itemlist[itembase].explor_effect
	character.use_social_skill(itemskill, character)
