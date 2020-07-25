extends Reference

var parent


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

func create():
	#setting food filter
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

func tick():
	food_counter -= 1
	if food_counter <= 0:
		food_counter = 24
		get_food()

func get_food():
	if parent.check_trait('undead'): return
	var eaten = false
	if food_consumption_rations == true && parent.get_static_effect_by_code('work_rule_ration') == null:
		parent.add_stat('food_consumption', 3)
	var food_consumption = parent.get_stat('food_consumption')
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
						parent.apply_effect(effects_pool.add_effect(eff))
				else:
					var check = false
					for k in food_hate:
						if food.tags.has(k):
							check = true
					if check == true:
						if food.tags.size() <= 1:
							var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table.e_food_dislike)
							parent.apply_effect(effects_pool.add_effect(eff))
				break
		if eaten == true:
			starvation = false
			break
	
	if food_consumption_rations == true && parent.get_static_effect_by_code('work_rule_ration') == null:
		food_consumption_rations = false
		parent.add_stat('food_consumption', 3, true)
	
	if eaten == false:
		starvation = true
		parent.add_stat('obedience', -75)
		parent.hp -= 25
		globals.text_log_add('food', parent.get_short_name() + ": has no food.")
