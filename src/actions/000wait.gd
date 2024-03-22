extends Reference

const category = 'other'
const code = 'wait'
const order = 0
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = ''
const virginloss = false
const givertags = []
const takertags = []
const giver_skill = []
const taker_skill = []
const consent_level = 0


const consent_giver = 0
const consent_taker = 0

func getname(state = null):
	return "Wait"

func getongoingname(givers, takers):
	return ""

func getongoingdescription(givers, takers):
	return ""

func requirements():
	var valid = true
	if givers.size() < 1:
		valid = false
	return valid

func initiate():
	return "[name1] rest[s/1] for a bit and wait[s/1]... "
