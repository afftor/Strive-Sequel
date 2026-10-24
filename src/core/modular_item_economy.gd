extends Reference

#Shared by item valuation, recipe queues and the offline price calculator.
#These are price quality multipliers, separate from quality's effect on item stats.
const MATERIAL_VALUE_PER_WORK = 10.0
const PRICE_BONUS_PER_WORK = 0.05
const PRICE_QUALITY_MULTIPLIERS = {
	"" : 1.0,
	poor = 0.75,
	average = 0.9,
	good = 1.0,
	epic = 1.2,
	legendary = 1.5
}


static func material_cost(part_amounts, selected_parts, materials):
	var total = 0.0
	for part in selected_parts:
		total += materials[selected_parts[part]].price * part_amounts[part]
	return total


static func work_units(material_value):
	return float(material_value) / MATERIAL_VALUE_PER_WORK


static func price(material_value, quality, enchant_count, cursed):
	var result = material_value * (1.0 + work_units(material_value) * PRICE_BONUS_PER_WORK)
	result *= PRICE_QUALITY_MULTIPLIERS[quality]
	result *= 1.0 + enchant_count * 0.15
	if cursed:
		result *= 0.60
	return int(result)


static func update_task_work(task, new_limit):
	var old_limit = float(task.get('progress_limit', 0.0))
	if is_equal_approx(old_limit, float(new_limit)):
		return
	if old_limit > 0.0 and task.has('progress'):
		task.progress = float(task.progress) * float(new_limit) / old_limit
	task.progress_limit = new_limit
