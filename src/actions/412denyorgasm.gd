extends Node

const category = 'SM'
const code = 'deny_orgasm'
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = ''
const virginloss = false
const givertags = ['noorgasm']
const takertags = ['nooragsm']
const giver_skill = []
const taker_skill = []
const consent_level = 10

func getname(state = null):
	return "Orgasm Denial"

func getongoingname(givers, takers):
	return ""

func getongoingdescription(givers, takers):
	return ""

func requirements():
	var valid = true
	if givers.size() != 1 || takers.size() != 1 || takers[0].sens < 900:
		valid = false
	for i in givers:
		if i.subduing != null:
			valid = false
	return valid

func givereffect(member):
	var effects = {lust = 0}
	return effects

func takereffect(member):
	var effects = {lust = 0}
	return effects
	

func initiate():
	return "[name1] approaches edging [name2] as [he2] is about to climax."
