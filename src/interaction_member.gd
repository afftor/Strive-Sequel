extends Reference

var name
var person
var mood
var submission
var loyalty
var lust = 0 setget lust_set
var sens = 0 setget sens_set
var sensmod = 1.0
var lewd = 0 setget lewd_set
var lewdmod = 1.0
var role
var sex
var orgasms = 0
var lastaction
var request
var requestsdone = 0
var consent = 0
var consentgain = 1

var number = 0
var sceneref

var new_action_performed = false
var begged_for_orgasm = false

var horny = 0 setget horny_set
var hornymod = 1.0


var svagina = 0
var smouth = 0
var sclit = 0
var sbreast = 0
var spenis = 0
var sanus = 0
var activeactions = []

var performed_actions = {}
var consented_actions = {}
var new_consented_partners = 0

var orgasm = false

var effects = []
#i assume that 'tied' and 'captured' effects are handled here. if not - they should have been properly made as status effects and be checked accordingly 

var subduedby = []
var subduing

var energy = 100

var sex_traits = []

var vagina
var penis
var clit
var breast
var feet
var acc1
var acc2
var acc3
var acc4
var acc5
var acc6
var mouth
var anus
var tail
var strapon = false
var nipples
var posh1
var mode = 'normal'
var limbs = true
var npc = false

var unique_consented_takers = []
var givers_with_my_consent = {}
var bedroom_prodigy = []
var single_partner_consents = []
var diff_partners_orgasms = []
var unconsented_orgasm = 0
var shame_amount = 0
var satisfied_partners = []
var seen_orgasms = []
var orgasm_with_watcher = 0
var orgasm_effects = []
var orgasm_tags = []
var orgasm_actions = []
var orgasm_partners = []
var diff_body_orgasm = 0
var aphrodisiac_orgasms = []
var drunk_orgasm = 0
var dominant = 0
var punish_actions = []
var mazo_actions = []
var deviant_orgasms = 0
var max_ongoing_actions = 0

var actionshad = {addtraits = [], removetraits = [], samesex = 0, samesexorgasms = 0, oppositesex = 0, oppositesexorgasms = 0, punishments = 0, group = 0}

#additional fields from person
var id
var person_sexexp
var person_sexskills
var person_metrics
var person_relations
var person_mods

func setup_person(ch, no_loyal = false):
	person = ch
	id = ch.id
	person_sexexp = person.get_stat('sexexp', true)
	person_sexskills = person.get_stat('sex_skills', true)
	person_metrics = person.get_stat('metrics', true)
	person_relations = person.get_stat('relations', true)
	person_mods = person.get_stat('mods', true)
	if !no_loyal: loyalty = ch.get_stat('loyal')
	submission = ch.get_stat('obedience')
	sex = ch.get_stat('sex')
	lust = ch.get_stat('lust')*10
	sens = 0
	consent = ch.get_stat('consent')
	name = ch.get_short_name()
	sex_traits = ch.get_all_sex_traits()
	var tmp = ch.get_gear('crotch')
	if tmp != null && ResourceScripts.game_res.items[tmp].itembase == 'strapon':
		strapon = true
	lewd = 100
	for i in sex_traits:
		var trait = Traitdata.sex_traits[i]
		for k in trait.effects:
			if k.trigger == 'start':
				match k.effect:
					'maximize_hornyness':
						horny = 100

func lust_set(value):
	lust = min(value, 1000)

func sens_set(value):
	var change = value - sens
	sens += change*sensmod
	if sens >= 1000:
		if lastaction == null || ((lastaction.givers.has(self) && lastaction.scene.givertags.has('noorgasm')) || (lastaction.takers.has(self) && lastaction.scene.takertags.has('noorgasm'))):
			var can_orgasm = false
			for i in sex_traits:
				var trait = Traitdata.sex_traits[i]
				for k in trait.effects:
					if k.trigger == 'orgasm':
						if k.effect == 'can_orgasm_regardless':
							can_orgasm = true
			if can_orgasm == false:
				return
		sens = 0
		orgasm()

func lewd_set(value):
	var change = value - lewd
	lewd += change*lewdmod

func horny_set(value):
	var change = value - horny
	horny += change*hornymod

func orgasm(custom_text = null):
	var text = ''
	orgasm = true
	if lastaction == null:
		lastaction = {scene = load("res://src/actions/100caress.gd").new(), givers = [], takers = [self]}
	if person_sexexp.orgasms.has(lastaction.scene.code):
		person_sexexp.orgasms[lastaction.scene.code] += 1
	else:
		person_sexexp.orgasms[lastaction.scene.code] = 1
	for k in lastaction.givers + lastaction.takers:
		if self != k:
			if person_sexexp.orgasmpartners.has(k.id):
				person_sexexp.orgasmpartners[k.id] += 1
			else:
				person_sexexp.orgasmpartners[k.id] = 1
	
	var scene
	var temptext = ''
	var penistext = ''
	var vaginatext = ''
	var anustext = ''
	orgasms += 1
	person_metrics.orgasm += 1
	if sceneref.participants.size() == 2 && person.has_profession("master"):
		if person.check_trait("Monogamous") && (sceneref.participants[0].person.has_profession("master") || sceneref.participants[1].person.has_profession("master")):
			person.add_stat('loyal', rand_range(1.4,5.6))
		else:
			person.add_stat('loyal', rand_range(1,4))
	elif person.has_profession("master"):
		person.add_stat('loyal', rand_range(1,2))
	#anus in use, find scene
	if anus != null:
		scene = anus
		for i in scene.givers:
			globals.addrelations(person, i.person, rand_range(30,50))
		#anus in giver slot
		if scene.givers.find(self) >= 0:
			if randf() < 0.4:
				anustext = "[name1] feel[s/1] a {^sudden :intense ::}{^jolt of electricity:warmth:wave of pleasure} inside [him1] and [his1]"
			else:
				anustext = "[names1]"
			if scene.scene.takerpart == 'penis':
				anustext += " [anus1] {^squeezes:writhes around:clamps down on} [names2] [penis2] as [he1] reach[es/1] {^climax:orgasm}."
			else:
				anustext += " [anus1] {^convulses:twitches:quivers} {^in euphoria:in ecstasy:with pleasure} as [he1] reach[es/1] {^climax:orgasm}."
			anustext = sceneref.decoder(anustext, [self], scene.takers)
		#anus is in taker slot
		elif scene.takers.find(self) >= 0:
			if randf() < 0.4:
				anustext = "[name2] feel[s/2] a {^sudden :intense ::}{^jolt of electricity:warmth:wave of pleasure} inside [him2] and [his2]"
			else:
				anustext = "[names2]"
			if scene.scene.giverpart == 'penis':
				anustext += " [anus2] {^squeezes:writhes around:clamps down on} [names1] [penis1] as [he2] reach[es/2] {^climax:orgasm}."
			else:
				anustext += " [anus2] {^convulses:twitches:quivers} {^in euphoria:in ecstasy:with pleasure} as [he2] reach[es/2] {^climax:orgasm}."
			anustext = sceneref.decoder(anustext, scene.givers, [self])
		#no default conditon
	#vagina present
	if person.get_stat('vagina') != 'none':
		#vagina in use, find scene
		if vagina != null:
			scene = vagina
			for i in scene.givers:
				globals.addrelations(person, i.person, rand_range(30,50))
			#vagina in giver slot
			if scene.givers.find(self) >= 0:
				if randf() < 0.4:
					vaginatext = "[name1] feel[s/1] a {^sudden :intense ::}{^jolt of electricity:warmth:wave of pleasure} inside [him1] and [his1]"
				else:
					vaginatext = "[names1]"
				if scene.scene.takerpart == 'penis':
					vaginatext += " [pussy1] {^squeezes:writhes around:clamps down on} [names2] [penis2] as [he1] reach[es/1] {^climax:orgasm}."
				else:
					vaginatext += " [pussy1] {^convulses:twitches:quivers} {^in euphoria:in ecstasy:with pleasure} as [he1] reach[es/1] {^climax:orgasm}."
				vaginatext = sceneref.decoder(vaginatext, [self], scene.takers)
			#vagina is in taker slot
			elif scene.takers.find(self) >= 0:
				if randf() < 0.4:
					vaginatext = "[name2] feel[s/2] a {^sudden :intense ::}{^jolt of electricity:warmth:wave of pleasure} inside [him2] and [his2]"
				else:
					vaginatext = "[names2]"
				if scene.scene.giverpart == 'penis':
					vaginatext += " [pussy2] {^squeezes:writhes around:clamps down on} [names1] [penis1] as [he2] reach[es/2] {^climax:orgasm}."
				else:
					vaginatext += " [pussy2] {^convulses:twitches:quivers} {^in euphoria:in ecstasy:with pleasure} as [he2] reach[es/2] {^climax:orgasm}."
				vaginatext = sceneref.decoder(vaginatext, scene.givers, [self])
			#no default conditon
	#penis present
	if person.get_stat('penis_size') != '':
		#penis in use, find scene
		if penis != null:
			scene = penis
			for i in scene.takers:
				globals.addrelations(person, i.person, rand_range(30,50))
			#penis in giver slot
			if scene.givers.find(self) >= 0:
				if randf() < 0.4:
					penistext = "[name1] feel[s/1] {^a wave of:an intense} {^pleasure:euphoria} {^run through:course through:building in} [his1] [penis1] and [his1]"
				else:
					penistext = "[name1] {^thrust:jerk}[s/1] [his1] hips forward and a {^thick :hot :}{^jet:load:batch} of"
				if scene.scene.takerpart == '':
					penistext += " {^semen:seed:cum} {^pours onto:shoots onto:falls to} the {^ground:floor} as [he1] ejaculate[s/1]."
				elif ['anus','vagina','mouth'].has(scene.scene.takerpart):
					if scene.scene.get('takerpart2') && scene.scene.givers[1] == self:
						temptext = scene.scene.takerpart2.replace('anus', '[anus2]').replace('vagina','[pussy2]')
					else:
						temptext = scene.scene.takerpart.replace('anus', '[anus2]').replace('vagina','[pussy2]')
						if scene.scene.takerpart == 'vagina':
							for i in scene.takers:
								if sceneref.impregnationcheck(person,i.person) == true:
									globals.impregnate(person, i.person)
					penistext += " {^semen:seed:cum} {^pours:shoots:pumps:sprays} into [names2] " + temptext + " as [he1] ejaculate[s/1]."
				elif scene.scene.takerpart == 'nipples':
					penistext += " {^semen:seed:cum} fills [names2] hollow nipples. "
				elif scene.scene.takerpart == 'penis':
					penistext += " {^semen:seed:cum} {^pours:shoots:sprays}, covering [names2] [penis2]. "
				penistext = sceneref.decoder(penistext, [self], scene.takers)
			#penis in taker slot
			elif scene.takers.find(self) >= 0:
				if randf() < 0.4:
					penistext = "[name2] feel[s/2] {^a wave of:an intense} {^pleasure:euphoria} {^run through:course through:building in} [his2] [penis2] and [his2]"
				else:
					penistext = "[name2] {^thrust:jerk}[s/2] [his2] hips forward and a {^thick :hot :}{^jet:load:batch} of"
				if scene.scene.code in ['handjob','titjob']:
					penistext += " {^sticky:white:hot} {^semen:seed:cum} {^sprays onto:shoots all over:covers} [names1] face[/s1] as [he2] ejaculate[s/2]."
				elif scene.scene.code == 'tailjob':
					penistext += " {^sticky:white:hot} {^semen:seed:cum} {^sprays onto:shoots all over:covers} [names1] tail[/s1] as [he2] ejaculate[s/2]."
				elif scene.scene.giverpart == '':
					penistext += " {^semen:seed:cum} {^pours onto:shoots onto:falls to} the {^ground:floor} as [he2] ejaculate[s/2]."
				elif scene.scene.giverpart == 'penis':
					penistext += " {^semen:seed:cum} {^pours:shoots:sprays}, covering [names1] [penis1]. "
				elif ['anus','vagina','mouth'].has(scene.scene.giverpart):
					temptext = scene.scene.giverpart.replace('anus', '[anus1]').replace('vagina','[pussy1]')
					penistext += " {^semen:seed:cum} {^pours:shoots:pumps:sprays} into [names1] " + temptext + " as [he2] ejaculate[s/2]."
					if scene.scene.giverpart == 'vagina':
						for i in scene.givers:
							if sceneref.impregnationcheck(i.person, person) == true:
								globals.impregnation(i.person, person)
				penistext = sceneref.decoder(penistext, scene.givers, [self])
		#orgasm without penis, secondary ejaculation
		else:
			if randf() < 0.4:
				penistext = "[name2] {^twist:quiver:writhe}[s/2] in {^pleasure:euphoria:ecstacy} as"
			else:
				penistext = "[name2] {^can't hold back any longer:reach[es/2] [his2] limit} and"
			penistext += " {^a jet of :a rope of :}{^semen:cum} {^fires:squirts:shoots} from {^the tip of :}[his2] {^neglected :throbbing ::}[penis2]."
			penistext = sceneref.decoder(penistext, null, [self])
	if vaginatext != '' || anustext != '' || penistext != '':
		text  += vaginatext + " " + anustext + " " + penistext
	#final default condition
	else:
		if randf() < 0.4:
			temptext = "[name2] feel[s/2] {^a sudden :an intense ::}{^jolt of electricity:heat:wave of pleasure} and [his2]"
		else:
			temptext = "[names2]"
		temptext += " {^entire :whole :}body {^twists:quivers:writhes} in {^pleasure:euphoria:ecstacy} as [he2] reach[es/2] {^climax:orgasm}."
		text += sceneref.decoder(temptext, null, [self])
	
	if lastaction.scene.code in sceneref.punishcategories && lastaction.takers.has(self):
		if randf() >= 0.85 || effects.has("entranced"):
			actionshad.addtraits.append("Masochist")
#	if member.lastaction.scene.code in punishcategories && member.lastaction.givers.has(member) && member.person.asser >= 60:
#		if randf() >= 0.85 || member.person.effects.has("entranced"):
#			member.actionshad.addtraits.append("Dominant")
	if lastaction.scene.code in sceneref.analcategories && (lastaction.takers.has(self) || lastaction.scene.code == 'doubledildoass'):
		if randf() >= 0.85 || effects.has('entranced'):
			actionshad.addtraits.append("Enjoys Anal")
	if sceneref.isencountersamesex(lastaction.givers, lastaction.takers, self) == true:
		actionshad.samesexorgasms += 1
	else:
		actionshad.oppositesexorgasms += 1
	
	if custom_text != null:
		text = custom_text
	#return 
	yield(sceneref.get_tree().create_timer(0.1), "timeout")
	sceneref.get_node("Panel/sceneeffects").bbcode_text += "[color=#ff5df8]" + text + "[/color]\n"


func actioneffect(values, scenedict):
	var sensinput = 0
	var hornyinput = 0
	var sens_mod = 1.0
	var horny_mod = 1.0
	if scenedict.scene.code != 'deny_orgasm':
		lastaction = scenedict
#	person.sexuals += 0.05 for having no actual effect since sexuals has no real value
	if values.has('sens'):
		sensinput = values.sens
	if values.has('horny'):
		hornyinput = values.horny
	
	if horny < 100:
		sens_mod -= 0.5
	
	if performed_actions.has(scenedict.scene.code):
		sens_mod -= 0.05*performed_actions[scenedict.scene.code]
		performed_actions[scenedict.scene.code] += 1
	else:
		performed_actions[scenedict.scene.code] = 1
	
	var position
	var seek_group
	var self_group
	var lowestconsent = 0
	if scenedict.givers.has(self):
		self_group = 'giver'
		seek_group = 'taker'
		for i in scenedict.takers:
			var consent = sceneref.count_action_consent(scenedict.scene, self, i)
			if consent.giver_consent < lowestconsent:
				lowestconsent = consent.giver_consent
	else:
		self_group = 'taker'
		seek_group = 'giver'
		for i in scenedict.givers:
			var consent = sceneref.count_action_consent(scenedict.scene, i, self)
			if consent.taker_consent < lowestconsent:
				lowestconsent = consent.taker_consent
	var forced = false
	if lowestconsent < scenedict.scene.consent_level:
		forced = true
	if forced == false:
		if consented_actions.has(scenedict.scene.code):
			consented_actions[scenedict.scene.code] += 1
		else:
			consented_actions[scenedict.scene.code] = 1
	if lowestconsent > scenedict.scene.consent_level:
		var difference = min(lowestconsent - scenedict.scene.consent_level, 15)
		sens_mod += difference * 0.02
		horny_mod += difference * 0.02
	
	var partner_skill = 0
	var partner_skill_counter = 0
	for i in scenedict[seek_group+'s']:
		for k in scenedict.scene[seek_group+'_skill']:
			partner_skill += i.person_sexskills[k] 
			partner_skill_counter += 1
			var value = (1.0/scenedict.scene[seek_group+"_skill"].size()) * variables.sex_factor_skill_multiplier[int(i.person.get_stat('sexuals_factor'))]
			var bonus = 1
			for t in sex_traits:
				var trait = Traitdata.sex_traits[t]
				for j in trait.effects:
					if j.trigger == 'skill_exp_gain_partner' && j.effect == 'skill_exp':
						bonus = input_handler.math(j.operant, bonus, j.value)
			
			for t in i.sex_traits:
				var trait = Traitdata.sex_traits[t]
				for j in trait.effects:
					if j.trigger == 'skill_exp_gain' && j.effect == 'skill_exp':
						bonus = input_handler.math(j.operant, bonus, j.value)
			
			i.person_sexskills[k] = min(100,i.person_sexskills[k] + value * bonus)
#			if i.person.sexuals + i.person.sexuals_bonus > partner_skill:
#				partner_skill = i.person.sexuals + i.person.sexuals_bonus
		if i.person.check_trait("undead") && sex_traits.has('omnisexual') == false:
			sens_mod -= 0.5
			horny_mod -= 0.5
		for k in i.sex_traits:
			var trait = Traitdata.sex_traits[k]
			if i.checkreqs(trait.reqs, seek_group, scenedict) == false :
				continue
			for j in trait.effects:
				if j.trigger == 'action_self':
					match j.effect:
						'sens_bonus':
							sens_mod = input_handler.math(j.operant, sens_mod, j.value)
						'horny_bonus':
							horny_mod = input_handler.math(j.operant, horny_mod, j.value)
	
	sens_mod += (partner_skill/max(partner_skill_counter,0.01))*1.25/100
	
	if values.has('tags'):
		if values.tags.has('punish'):
			if (person.get_stat('obedience') < 90 || mode == 'forced') && (!person.check_trait('Masochist') && !person.check_trait('Likes it rough') && !person.check_trait('Sex-crazed')):
				for i in scenedict.givers:
					globals.addrelations(person, i.person, -rand_range(5,10))
				person.add_stat('obedience', values.obed)
#					person.stress += values.stress
				if effects.has("captured") && randf() >= values.obed/2:
					effects.captured.duration -= 1
			else:
				if person.get_stat('asser') < 35 && randf() < 0.1:
					actionshad.addtraits.append('Likes it rough')
				if !person.check_trait('Masochist') && !person.check_trait('Sex-crazed'):
					pass #leftover checks, to fill in later
#						if values.has('stress') == false:
#							values.stress = rand_range(2,6)
#						person.stress += values.stress
		if values.tags.has('group'):
			actionshad.group += 1
	
	for i in sex_traits:
		var trait = Traitdata.sex_traits[i]
		if checkreqs(trait.reqs, self_group, scenedict) == false:
			continue
		
		for k in trait.effects:
			if k.trigger == 'action_partner':
				match k.effect:
					'sens_bonus':
						sens_mod = input_handler.math(k.operant, sens_mod, k.value)
					'horny_bonus':
						horny_mod = input_handler.math(k.operant, horny_mod, k.value)
	
	self.sens += sensinput*max(0.1, sens_mod)
	self.horny += hornyinput*max(0.1, horny_mod)

func checkreqs(reqs, group, scene):
	var check = true
	for i in reqs:
		if i.has('orflag'):
			check = check or valuecheck(i, group, scene)
		else:
			check = check and valuecheck(i, group, scene)
	return check

func valuecheck(dict, group, scene):
	match dict.code:
		'effect_exists':
			return effects.has(dict.value)
		'action_tag':
			return scene.scene.get(group+'tags').has(dict.value)
		'action_partner_tag':
			var opposite_group
			if group == 'giver':
				opposite_group = 'takertags'
			else:
				opposite_group = 'givertags'
			return scene.scene.get(opposite_group).has(dict.value)
		'action_type':
			return scene.scene.code in dict.value
		'partner_check':
			var partners 
			if scene.givers.has(self):
				partners = scene.takers
			else:
				partners = scene.givers
			var check = false
			for i in partners:
				if i.person.checkreqs(dict.value) == true:
					check = true
					break
			return check

