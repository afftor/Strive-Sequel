extends Reference
#Designer-authored mansion floors for gui_modules/mansion_view.
#Plain script, not an autoload - use preload("res://assets/data/mansion_floor_plans.gd").LIST
#
#A floor is two things, both in FIELD_TILES x FIELD_TILES coordinates:
#
#	areas - the painted shell of the building. Purely visual. Rectangles drawn in order,
#	        later ones overriding earlier ones, anything uncovered being outside.
#	slots - the fixed room positions. This is the level map: the player never chooses
#	        where a room goes, only what goes into a slot and which two slots trade
#	        contents. Whatever falls between slots reads as corridor and structure and
#	        carries no mechanics.
#
#Coordinates rather than a character mask: at this resolution a mask would be a hundred
#lines of a hundred characters, unreadable to edit, and a handful of rectangles also
#draws in a handful of calls instead of ten thousand.
#
#Every slot is the same size, which is what makes them freely interchangeable.
#
#Slot flag, optional:
#	broken - starts unavailable. Has to be repaired into an empty slot before use; that
#	         conversion is a mechanic for later, the model just carries the state.

#The coordinate field every floor is expressed in.
const FIELD_TILES = 100

#Edge length of a slot. Every slot on every floor is this size, so any two of them can
#trade contents without anything having to be checked about their shapes.
const SLOT_TILES = 18

const LIST = {
	default_manor = {
		code = 'default_manor',
		floors = [
			{
				code = '1F',
				areas = [
					{state = 'floor', rect = [2, 2, 96, 96]},
					{state = 'outside', rect = [2, 2, 6, 6]},
					{state = 'outside', rect = [92, 2, 6, 6]},
					{state = 'outside', rect = [2, 92, 6, 6]},
					{state = 'outside', rect = [92, 92, 6, 6]},
					{state = 'blocked', rect = [44, 86, 12, 12]},
				],
				slots = [
					{code = 'a1', rect = [5, 5, 18, 18]},
					{code = 'a2', rect = [29, 5, 18, 18]},
					{code = 'a3', rect = [53, 5, 18, 18]},
					{code = 'a4', rect = [77, 5, 18, 18]},
					{code = 'b1', rect = [5, 29, 18, 18]},
					{code = 'b2', rect = [29, 29, 18, 18]},
					{code = 'b3', rect = [53, 29, 18, 18]},
					{code = 'b4', rect = [77, 29, 18, 18]},
					{code = 'c1', rect = [5, 53, 18, 18]},
					{code = 'c2', rect = [29, 53, 18, 18]},
					{code = 'c3', rect = [53, 53, 18, 18]},
					{code = 'c4', rect = [77, 53, 18, 18]},
					{code = 'd1', rect = [5, 77, 18, 18]},
					{code = 'd2', rect = [29, 77, 18, 18]},
					{code = 'd3', rect = [53, 77, 18, 18]},
					{code = 'd4', rect = [77, 77, 18, 18]},
				],
				prebuilt = {b2 = 'master_bedroom', b3 = 'bedrooms', b4 = 'bedrooms', c3 = 'kitchen', c2 = 'stairs', c1 = 'store_room'},
			},
			{
				code = '2F',
				areas = [
					{state = 'floor', rect = [2, 2, 96, 96]},
					{state = 'outside', rect = [38, 38, 24, 24]},
					{state = 'blocked', rect = [2, 48, 8, 4]},
					{state = 'blocked', rect = [90, 48, 8, 4]},
				],
				slots = [
					{code = 'a1', rect = [5, 5, 18, 18]},
					{code = 'a2', rect = [29, 5, 18, 18]},
					{code = 'a3', rect = [53, 5, 18, 18]},
					{code = 'a4', rect = [77, 5, 18, 18]},
					{code = 'b1', rect = [5, 29, 18, 18]},
					{code = 'b2', rect = [29, 29, 18, 18], broken = true},
					{code = 'b3', rect = [53, 29, 18, 18]},
					{code = 'b4', rect = [77, 29, 18, 18]},
					{code = 'c1', rect = [5, 53, 18, 18]},
					{code = 'c2', rect = [29, 53, 18, 18]},
					{code = 'c3', rect = [53, 53, 18, 18]},
					{code = 'c4', rect = [77, 53, 18, 18]},
					{code = 'd1', rect = [5, 77, 18, 18], broken = true},
					{code = 'd2', rect = [29, 77, 18, 18]},
					{code = 'd3', rect = [53, 77, 18, 18]},
					{code = 'd4', rect = [77, 77, 18, 18], broken = true},
				],
				prebuilt = {c2 = 'stairs'},
			},
			{
				code = '3F',
				areas = [
					{state = 'floor', rect = [2, 24, 96, 52]},
					{state = 'blocked', rect = [2, 24, 96, 4]},
					{state = 'blocked', rect = [2, 72, 96, 4]},
				],
				slots = [
					{code = 'b1', rect = [5, 29, 18, 18], broken = true},
					{code = 'b2', rect = [29, 29, 18, 18]},
					{code = 'b3', rect = [53, 29, 18, 18]},
					{code = 'b4', rect = [77, 29, 18, 18], broken = true},
					{code = 'c1', rect = [5, 53, 18, 18]},
					{code = 'c2', rect = [29, 53, 18, 18], broken = true},
					{code = 'c3', rect = [53, 53, 18, 18], broken = true},
					{code = 'c4', rect = [77, 53, 18, 18]},
				],
				prebuilt = {b2 = 'stairs'},
			},
			#The estate grounds. Not a floor of the house at all - it is drawn by the local
			#tasks screen rather than by the floorplan, and has no staircase because it is not
			#somewhere you climb to. It is a floor of the layout only so that raising a barn
			#uses the same builders, the same costs and the same save as raising a bedroom.
			{
				code = 'GROUNDS',
				areas = [
					{state = 'floor', rect = [2, 20, 96, 60]},
				],
				slots = [
					{code = 'g1', rect = [5, 25, 18, 18]},
					{code = 'g2', rect = [29, 25, 18, 18]},
					{code = 'g3', rect = [53, 25, 18, 18]},
					{code = 'g4', rect = [77, 25, 18, 18]},
					{code = 'g5', rect = [17, 55, 18, 18]},
					{code = 'g6', rect = [41, 55, 18, 18]},
					{code = 'g7', rect = [65, 55, 18, 18]},
				],
				prebuilt = {},
			},
		],
	},
}


#Which floor is the estate grounds, or -1. Named rather than numbered because it is the one
#floor that is not part of the house and is reached from a different screen.
static func grounds_index(plan_code):
	var plan = get_plan(plan_code)
	for index in range(plan.floors.size()):
		if plan.floors[index].code == 'GROUNDS':
			return index
	return -1


static func get_plan(plan_code):
	if plan_code != null and LIST.has(plan_code):
		return LIST[plan_code]
	return LIST.default_manor


static func get_floor_plan(plan_code, floor_index):
	var plan = get_plan(plan_code)
	floor_index = int(floor_index)
	if floor_index < 0 or floor_index >= plan.floors.size():
		return null
	return plan.floors[floor_index]


static func get_slot_plan(floor_plan, slot_code):
	if floor_plan == null:
		return null
	for slot in floor_plan.slots:
		if slot.code == slot_code:
			return slot
	return null


static func slot_starts_broken(slot_plan):
	return slot_plan.get('broken', false)


#Stable text form of a floor's slots, so a layout loaded from a save can tell whether the
#designer reshaped the level since it was created. Built by hand rather than with to_json
#so it does not depend on dictionary key order.
static func shape_signature(floor_plan):
	var parts = []
	for slot in floor_plan.slots:
		parts.append("%s:%d,%d,%d,%d" % [slot.code, slot.rect[0], slot.rect[1], slot.rect[2], slot.rect[3]])
	return PoolStringArray(parts).join(";")
