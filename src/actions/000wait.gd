extends Node

const category = 'other'
const code = 'wait'
const order = 0
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = ''
const virginloss = false
const giverconsent = 'any'
const takerconsent = 'any'
const givertags = []
const takertags = []


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
