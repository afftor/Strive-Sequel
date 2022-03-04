extends Reference

var parent: WeakRef


#food
var food_counter = 23
#var food_consumption = 1
var food_consumption_rations = false
var food_love = ''
var food_hate = []
var food_filter = {high = [], med = [], low = [], disable = []}
var starvation = false


func get_racial_features(race):
	var race_template = races.racelist[race]
	var array = []
	for i in race_template.diet_love:
		array.append([i, race_template.diet_love[i]])
	food_love = input_handler.weightedrandom(array)
	for i in race_template.diet_hate:
		if race_template.diet_hate[i] >= randf()*100 && i != food_love:
			food_hate.append(i)
	#print(food_love,food_hate)

func process_chardata(data):
	get_racial_features(data.race)
	#advanced generation
	var array = []
	if data.has('diet_love'):
		for i in data.diet_love:
			array.append([i, data.diet_love[i]])
		food_love = input_handler.weightedrandom(array)
	if data.has('diet_hate'):
		food_hate.clear()
		for i in data.diet_hate:
			if data.diet_hate[i] >= randf()*100 && i != food_love:
				food_hate.append(i)
	#simple data processing
	if data.has('food_like'):
		food_love = data.food_like
	if data.has('food_hate'):
		food_hate = data.food_hate.duplicate()
	create()

func create():
	#setting food filter
	for type in food_filter:
		food_filter[type].clear()
	for i in Items.materiallist.values():
		if i.type == 'food':
			if i.tags.has(food_love):
				food_filter.high.append(i.code)
			else:
				var check = false
				for k in food_hate:
					if i.tags.has(k):
						food_filter.low.append(i.code)
						check = true
						break
				if check == false:
					food_filter.med.append(i.code)


func get_food():
	if parent.get_ref().check_trait('undead'): return
	var eaten = false
	if food_consumption_rations == true && parent.get_ref().get_static_effect_by_code('work_rule_ration') == null:
		parent.get_ref().add_stat('food_consumption', 3)
	var food_consumption = parent.get_ref().get_stat('food_consumption')
	for j in ['high','med','low']:
		for i in food_filter[j]:
			var food = Items.materiallist[i]
			if ResourceScripts.game_res.materials[i] >= food_consumption:
				ResourceScripts.game_res.materials[i] -= food_consumption
				eaten = true
			if eaten == true:
				if food.tags.has(food_love):
					var check = false
					for k in food_hate:
						if food.tags.has(k):
							check = true
					if check == false:
						var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table.e_food_like)
						parent.get_ref().apply_effect(effects_pool.add_effect(eff))
				else:
					var check = false
					for k in food_hate:
						if food.tags.has(k):
							check = true
					if check == true:
						if food.tags.size() <= 1:
							var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table.e_food_dislike)
							parent.get_ref().apply_effect(effects_pool.add_effect(eff))
				break
		if eaten == true:
			starvation = false
			break
	
	if food_consumption_rations == true && parent.get_ref().get_static_effect_by_code('work_rule_ration') == null:
		food_consumption_rations = false
		parent.get_ref().add_stat('food_consumption', 3, true)
	
	if eaten == false:
		var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table.e_starve)
		parent.get_ref().apply_effect(effects_pool.add_effect(eff))
		starvation = true
		
		globals.text_log_add('food', parent.get_ref().get_short_name() + ": not enough food. Authority reduced.")


func predict_food():
	if parent.get_ref().check_trait('undead'): return {}
	var food_consumption = parent.get_ref().get_stat('food_consumption')
	var food = food_love
	var res = {}
	res[food] = food_consumption
	return res
