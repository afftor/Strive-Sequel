extends Reference
#What every animation code is, in one place. Built once per CombatAnimations instance from
#the same sources start_animation consults (a method on CombatAnimations wins, then the
#video, sprite and particle dictionaries in ResourceImages) plus the measured sheet table.
#
#Before this existed the answer to "what does code X do, what does it read, when does it
#hit" was spread over start_animation, globals.make_sfx_params, two skill handlers,
#ch_equip and the sheet .tscn files. Every consumer - the sequencer, the handlers and the
#combat lab - now asks here.
#
#Kinds:
#   method      a function on CombatAnimations with the code's name (at_sword, targetattack,
#               lightning, holy_lance_step ...). has_method wins over every dictionary.
#   projectile  a method too, but one that crosses the field: queued before the hit visuals
#               of the same skill, because they wait for it to land.
#   sheet       an entry of images.GFX_sprites played by gfx_animsprite
#   particles   images.GFX_particles, played by gfx_particles
#   video       images.GFX_video, played by gfx_video
#
#Beats (seconds from the clip's own start, before any speed scaling):
#   release     when a cast lets the blow go - CAST_RELEASE for weapon sheets
#   contact     when the blow lands on the receiving side - the measured key frame of a
#               sheet, or a fixed default for what has no sheet
#
#The two placeholders 'weapon' and 'cast_weapon' are not codes: resolve() turns them into
#the code the caster's equipment gives them, which is what the handlers used to do inline.

const SheetKeys = preload("res://src/combat/anim_sheet_keys.gd")

#contact for a sheet the measurement did not cover (the eight particle scenes registered
#as sprites, or a sheet added after the table was generated)
const DEFAULT_CONTACT = 0.2

#codes whose area effect wants the primary target first in hit_nodes, then the others -
#the chain starts at the chosen card and branches out from it
const PRIMARY_FIRST_CODES = ['chain_lightning']

var anim = null
var codes = {}
var built = false


func build(anim_node):
	anim = anim_node
	codes.clear()
	for name in images.GFX_video:
		add(name, 'video')
	for name in images.GFX_particles:
		add(name, 'particles')
	for name in images.GFX_sprites:
		add(name, 'sheet')
	#a method with the code's name intercepts the generic path; register the ones the data
	#and the handlers know about, then let has_method settle any other name at play time
	for name in codes.keys():
		if anim != null and anim.has_method(name):
			codes[name].kind = 'method'
			codes[name].function = name
	for name in ['targetattack', 'ranged_attack', 'casterattack', 'assassinate', 'assassinate_step',
			'holy_lance_step', 'devastation_dash', 'devastation_strike', 'devastation_return',
			'shake_target', 'rainfall_field', 'lightning', 'chain_lightning', 'default_hit_reaction',
			'miss', 'resist', 'firebolt', 'flame', 'earth_spike', 'water_attack', 'targetfire',
			'heal', 'buff', 'debuff', 'decay']:
		if !codes.has(name) and anim != null and anim.has_method(name):
			add(name, 'method')
			codes[name].function = name
	for name in ['projectile_arrow', 'projectile_fireball']:
		add(name, 'projectile')
		codes[name].function = name
	built = true


func add(name, kind):
	var entry = {code = name, kind = kind, function = null, length = null, contact = null, release = null}
	var row = SheetKeys.lookup(name)
	if row != null:
		entry.length = row.length
		entry.contact = row.key
	if anim != null:
		if anim.CAST_RELEASE.has(name):
			#a weapon sheet: the blow is the release, measured by hand frame by frame
			entry.release = anim.CAST_RELEASE[name]
			entry.contact = anim.CAST_RELEASE[name]
	codes[name] = entry


#--- questions the rest of the engine asks -------------------------------------------

func has(code):
	if code == null: return false
	if codes.has(code): return true
	#a code that only exists as a method (a helper reused as an effect) still plays
	return anim != null and anim.has_method(str(code))


func kind_of(code):
	if code == null: return null
	if codes.has(code): return codes[code].kind
	if str(code).begins_with('projectile_'): return 'projectile'
	if anim != null and anim.has_method(str(code)): return 'method'
	return null


func is_projectile(code):
	return kind_of(code) == 'projectile'


func wants_primary_first(code):
	return PRIMARY_FIRST_CODES.has(code)


#A movement rather than art: a method with no sheet behind it. On the receiving side that
#is how the blow travels - what the lab calls the delivery role. Sheets that also have a
#method (lightning, firebolt, the at_* casts) are not deliveries.
func is_delivery(code):
	var kind = kind_of(code)
	if kind == 'projectile': return true
	return kind == 'method' and !images.GFX_sprites.has(str(code))


#The registry is advisory: start_animation still resolves a code by has_method first and
#the image dictionaries after. This lists every place the two would disagree, so a test
#can insist on an empty list.
func check():
	var problems = []
	if anim == null: return ['registry has no animation node']
	for name in codes:
		var entry = codes[name]
		var is_method = anim.has_method(name)
		match entry.kind:
			'method', 'projectile':
				if !is_method: problems.push_back('%s: kind %s but CombatAnimations has no such method' % [name, entry.kind])
			'sheet':
				if is_method: problems.push_back('%s: kind sheet but a method of that name exists' % name)
				if !images.GFX_sprites.has(name): problems.push_back('%s: kind sheet but not in GFX_sprites' % name)
			'particles':
				if is_method: problems.push_back('%s: kind particles but a method of that name exists' % name)
				if !images.GFX_particles.has(name): problems.push_back('%s: kind particles but not in GFX_particles' % name)
			'video':
				if is_method: problems.push_back('%s: kind video but a method of that name exists' % name)
				if !images.GFX_video.has(name): problems.push_back('%s: kind video but not in GFX_video' % name)
	for name in ['miss', 'default_hit_reaction', 'devastation_return', 'resist', 'targetattack', 'ranged_attack']:
		if !has(name): problems.push_back('%s: produced by code but unknown to the registry' % name)
	return problems


#The placeholders the data uses for "whatever the caster is holding".
func resolve(code, caster):
	if code == 'weapon' and caster != null:
		return caster.get_weapon_animation()
	if code == 'cast_weapon' and caster != null:
		return caster.get_weapon_cast_animation()
	return code


#Seconds from the start of the clip to the moment the blow lands, at playback speed
#`speed`. Sheets use their measured key frame; the rest fall back to a fixed beat.
func contact_time(code, speed = 1.0):
	var entry = codes.get(code, null)
	var contact = DEFAULT_CONTACT
	if entry != null and entry.contact != null:
		contact = entry.contact
	return contact / max(0.01, float(speed))


func release_time(code, speed = 1.0):
	var entry = codes.get(code, null)
	if entry == null or entry.release == null: return null
	return entry.release / max(0.01, float(speed))


func sheet_length(code):
	var entry = codes.get(code, null)
	if entry != null and entry.length != null: return entry.length
	if images.GFX_sprites.has(code):
		#not in the generated table: measure the scene the slow way and remember it
		var length = ResourceScripts.core_animations.get_gfx_sprite_time(code)
		if entry != null: entry.length = length
		return length
	return null


#Everything known about one code, for tooling.
func describe(code):
	var entry = codes.get(code, null)
	if entry == null:
		return {code = code, kind = kind_of(code), function = code if kind_of(code) == 'method' else null,
			length = null, contact = null, release = null}
	return entry.duplicate()
