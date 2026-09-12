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
#and, where the floor has one, a third:
#
#	backdrop - a picture to stand on instead of the painted slab, lined up by its own
#	           landmark rather than by pixels. See the key on the first floor below.
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

#The coordinate field every floor is expressed in. Wider than the house needs to be: a tile is
#a fixed nine pixels (mansion_floor_grid.TILE_PX), so a larger field spaces the rooms out rather
#than shrinking them, and the drawing they stand on is wider still than the house itself.
const FIELD_TILES = 160

#A slot, in tiles - the size of a room as the manor is drawn, which is a shade wider than it is
#tall. Every slot on every floor is this size, so any two of them can trade contents without
#anything having to be checked about their shapes.
const SLOT_TILES = [18, 17]

#The house is a wide manor of two floors over its own grounds. Its offset wings leave irregular
#corridors around the staircase, which stays in the exact middle so it meets between floors.
#
#Most of the house starts under rubble. The estate is inherited half-ruined: four rooms on the
#ground floor are open, everything else has to be cleared before it can be used, and clearing
#is how the mansion grows rather than the plan handing out more slots later.
#The house is a wide manor of two floors over its own grounds. Both floors are the same five
#columns by three rows with a seven-tile gap all round, and the staircase in the very middle
#with the landing above and below it left as hall - so the stairs is in the same place
#whichever floor you are looking at, and no room shares a wall with its neighbour.
#
#Most of the house starts under rubble. The estate is inherited half-ruined: four rooms on the
#ground floor are open, everything else has to be cleared before it can be used, and clearing
#is how the mansion grows rather than the plan handing out more slots later.
const LIST = {
	default_manor = {
		code = 'default_manor',
		floors = [
			#Ten rooms: a two-by-two around the staircase, and a wing of three at either end.
			#Open at the start: the master's own room and a bedroom in the centre, the store
			#room in the left wing and one bare room in the right. The other six are rubble.
			{
				code = '1F',
				#The floor is a picture of itself: the manor seen from above, with its rooms,
				#walls, corridors and grounds drawn in. 'yard' is the box the ten rooms and the
				#hall between them fill inside that picture, given as shares of it; 'over' is the
				#tiles that box is laid on. The picture is blown up until the yard covers those
				#tiles, which is what puts every slot below inside the room drawn for it - so the
				#two are measured together, and moving one without the other pulls them apart.
				#
				#The file carries four hundred pixels of mirrored canopy above the house that the
				#artist's picture does not. The plan is drawn across the whole screen rather than
				#into a panel, and the picture is what the dragging stops against, so it has to
				#reach every corner of that screen from every position it can be dragged to. The
				#band the rooms are centred in is the lower two thirds of the screen: a picture
				#that only just covers the screen therefore leaves the house too high in it, and
				#one large enough to hang lower is too wide to fit between the side panels. That
				#strip of sky is what buys both, and at rest it lies under the HUD.
				backdrop = {
					art = 'res://assets/images/backgrounds/mansion_manor.png',
					yard = [0.2008, 0.3930, 0.6073, 0.3688],
					over = [13, 53, 134, 54],
				},
				areas = [
					{state = 'floor', rect = [13, 53, 134, 54]},
				],
				slots = [
					{code = 'a1', rect = [19, 54, 18, 17], broken = true},
					{code = 'a2', rect = [53, 53, 18, 17]},
					{code = 'a4', rect = [90, 53, 18, 17]},
					{code = 'a5', rect = [122, 54, 18, 17], broken = true},
					{code = 'b1', rect = [13, 71, 18, 17]},
					{code = 'b3', rect = [71, 76, 18, 17]},
					{code = 'b5', rect = [129, 72, 18, 17]},
					{code = 'c1', rect = [19, 89, 18, 17], broken = true},
					{code = 'c2', rect = [52, 90, 18, 17], broken = true},
					{code = 'c4', rect = [90, 90, 18, 17], broken = true},
					{code = 'c5', rect = [122, 90, 18, 17], broken = true},
				],
				prebuilt = {a2 = 'master_bedroom', a4 = 'bedrooms', b1 = 'store_room', b3 = 'stairs'},
			},
			#Eight rooms, four to either side of the staircase. Two stand open beside it; the
			#rest is rubble.
			{
				code = '2F',
				#The same drawing as the floor below, and lined up the same way - see there. It is
				#dimmed and cooled a little because this floor is above that one: the same rooms in
				#the same places would otherwise give the player nothing to tell the two apart.
				backdrop = {
					art = 'res://assets/images/backgrounds/mansion_manor.png',
					yard = [0.2008, 0.3930, 0.6073, 0.3688],
					over = [13, 53, 134, 54],
					shade = [0.60, 0.64, 0.76],
				},
				areas = [
					{state = 'floor', rect = [13, 53, 134, 54]},
				],
				slots = [
					{code = 'a1', rect = [19, 54, 18, 17], broken = true},
					{code = 'a2', rect = [53, 53, 18, 17]},
					{code = 'a4', rect = [90, 53, 18, 17]},
					{code = 'a5', rect = [122, 54, 18, 17], broken = true},
					{code = 'b3', rect = [71, 76, 18, 17]},
					{code = 'c1', rect = [19, 89, 18, 17], broken = true},
					{code = 'c2', rect = [52, 90, 18, 17], broken = true},
					{code = 'c4', rect = [90, 90, 18, 17], broken = true},
					{code = 'c5', rect = [122, 90, 18, 17], broken = true},
				],
				prebuilt = {b3 = 'stairs'},
			},
			#The estate grounds. Not a floor of the house at all - it is drawn by the local
			#tasks screen rather than by the floorplan, and has no staircase because it is not
			#somewhere you climb to. It is a floor of the layout only so that raising a barn
			#uses the same builders, the same costs and the same save as raising a bedroom.
			{
				code = 'GROUNDS',
				areas = [
					{state = 'floor', rect = [12, 30, 96, 60]},
				],
				slots = [
					{code = 'g1', rect = [15, 35, 18, 18]},
					{code = 'g2', rect = [39, 35, 18, 18]},
					{code = 'g3', rect = [63, 35, 18, 18]},
					{code = 'g4', rect = [87, 35, 18, 18]},
					{code = 'g5', rect = [27, 65, 18, 18]},
					{code = 'g6', rect = [51, 65, 18, 18]},
					{code = 'g7', rect = [75, 65, 18, 18]},
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


#The slots a floor is made of, as a sorted list of codes. This - not the signature above - is
#what says whether a saved floor still fits the plan: a slot IS its code, and the rect beside
#it only says where the room is drawn. Moving the house around its backdrop rewrites every
#rect and changes nothing about which rooms exist, so comparing the full signature condemned
#a floor for a change of picture. Read out of the stored shape rather than kept separately,
#so a save written before this distinction existed answers the same list.
static func shape_codes(shape):
	var codes = []
	for part in str(shape).split(";", false):
		codes.append(part.split(":")[0])
	codes.sort()
	return codes


static func slot_codes(floor_plan):
	var codes = []
	for slot in floor_plan.slots:
		codes.append(slot.code)
	codes.sort()
	return codes
