extends Reference
#Free placement of rectangles inside a bounded area: bounds checking, blocked ground,
#overlap rejection, and moving something already placed. Pure and static, like
#mansion_layout.gd, and equally free of autoload references.
#
#The floor itself no longer needs this - rooms sit in fixed slots that come from the
#level map, and the player only swaps their contents. This module is the placement logic
#that drove the old free-form floor, kept intact and still tested because a room's
#interior needs exactly the same rules: furniture will be laid out inside a room's own
#area, where the player really does choose coordinates.
#
#Nothing in the mansion screen calls it yet. It is deliberately generic - it knows about
#an area, obstacles and items, not about rooms or furniture - so the interior work can
#adopt it without reshaping it first.
#
#Rectangles are stored as [x, y, width, height] arrays rather than Rect2 so that anything
#built on this stays JSON-safe and can ride along in a save.

const RECT_FIELDS = 4


#### area ####

#blocked is a list of [x, y, w, h] rectangles inside the area that never accept an item.
static func make_area(width, height, blocked = []):
	return {width = int(width), height = int(height), blocked = blocked.duplicate()}


static func to_rect(rect):
	return Rect2(int(rect[0]), int(rect[1]), int(rect[2]), int(rect[3]))


static func from_rect(rect):
	return [int(rect.position.x), int(rect.position.y), int(rect.size.x), int(rect.size.y)]


#### items ####

#items is {id_string: {id, rect, payload}} - a dictionary so it serializes cleanly.
static func make_items():
	return {}


static func get_item(items, item_id):
	var key = str(item_id)
	if !items.has(key):
		return null
	return items[key]


static func item_at(items, x, y):
	var point = Vector2(int(x), int(y))
	for item in items.values():
		if to_rect(item.rect).has_point(point):
			return item
	return null


static func next_id(items):
	var res = 1
	for item in items.values():
		res = max(res, int(item.id) + 1)
	return int(res)


#### placement ####

#Returns {ok = bool, reason = "LOCALIZATION_KEY"}; reason only matters when ok is false.
static func can_place(area, items, rect, ignore_id = null):
	if rect == null or rect.size() != RECT_FIELDS:
		return {ok = false, reason = 'MANSIONVIEW_ERR_VOID'}
	var target = to_rect(rect)
	if target.size.x <= 0 or target.size.y <= 0:
		return {ok = false, reason = 'MANSIONVIEW_ERR_VOID'}
	if target.position.x < 0 or target.position.y < 0 \
			or target.end.x > area.width or target.end.y > area.height:
		return {ok = false, reason = 'MANSIONVIEW_ERR_NOSPACE'}
	for blocked in area.blocked:
		if to_rect(blocked).intersects(target):
			return {ok = false, reason = 'MANSIONVIEW_ERR_LOCKED'}
	#rectangles are compared directly, so this stays O(items) however large the area is
	for item in items.values():
		if ignore_id != null and str(item.id) == str(ignore_id):
			continue
		if to_rect(item.rect).intersects(target):
			return {ok = false, reason = 'MANSIONVIEW_ERR_OCCUPIED'}
	return {ok = true, reason = ''}


static func place(area, items, rect, payload = null):
	if !can_place(area, items, rect).ok:
		return null
	var item_id = next_id(items)
	items[str(item_id)] = {
		id = item_id,
		rect = [int(rect[0]), int(rect[1]), int(rect[2]), int(rect[3])],
		payload = payload,
	}
	return item_id


static func remove(items, item_id):
	var key = str(item_id)
	if !items.has(key):
		return false
	items.erase(key)
	return true


#### moving ####

static func can_move(area, items, item_id, x, y):
	var item = get_item(items, item_id)
	if item == null:
		return {ok = false, reason = 'MANSIONVIEW_ERR_VOID'}
	#an item may always overlap the ground it already covers
	return can_place(area, items, [int(x), int(y), item.rect[2], item.rect[3]], item_id)


static func move(area, items, item_id, x, y):
	if !can_move(area, items, item_id, x, y).ok:
		return false
	var item = get_item(items, item_id)
	item.rect[0] = int(x)
	item.rect[1] = int(y)
	return true


#### migration ####

#JSON has no integers, so anything persisted through a save comes back as floats.
static func validate(items):
	if !(items is Dictionary):
		return false
	for item in items.values():
		item.id = int(item.id)
		for i in range(RECT_FIELDS):
			item.rect[i] = int(item.rect[i])
	return true
