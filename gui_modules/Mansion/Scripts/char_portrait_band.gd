extends Control
#The character standing beside a popup: their stored picture if they have one, the doll if they
#do not, a silhouette if the player has turned dolls off. The training popup has shown one for a
#while and the progression popup now shows the same; the answer of "what does this character look
#like" belongs in one place rather than in each window that wants to draw it.
#
#The nodes are the scene's: StoredImage for a painted sprite, Paperdoll for the doll. This only
#decides which of the two is shown and fits it to the band.

onready var stored_image = $StoredImage
onready var doll = $Paperdoll

#rebuilding the doll is the expensive half of opening a window, so it is skipped when nothing
#about the character or the band has changed since the last time
var cached_person_id = ""
var cached_clothed = true
var cached_size = Vector2.ZERO


func show_for(person):
	if person == null:
		hide_band()
		return
	visible = true
	stored_image.visible = false
	doll.visible = false
	var texture = stored_person_image(person)
	if texture != null:
		stored_image.texture = texture
		fit_sprite(texture)
		stored_image.visible = true
		return
	if !input_handler.globalsettings.disable_paperdoll:
		var clothed = !person.has_work_rule("nudity")
		doll.visible = true
		doll.test_mode = false
		if cached_person_id != str(person.id) or cached_clothed != clothed 				or cached_size != rect_size or doll.character != person:
			doll.rebuild(person)
			doll.rebuild_cloth(clothed)
			cached_person_id = str(person.id)
			cached_clothed = clothed
			cached_size = rect_size
		return
	var silhouette = person.get_body_image()
	if silhouette != null:
		stored_image.texture = silhouette
		fit_sprite(silhouette)
		stored_image.visible = true


func hide_band():
	visible = false
	stored_image.visible = false
	doll.visible = false


#A character written into the story has pictures of their own, and which one depends on how they
#are dressed and on whether the player has married them.
func stored_person_image(person):
	var texture = person.get_stored_body_image()
	var unique_code = person.get_stat("unique")
	if unique_code == null or !worlddata.pregen_character_sprites.has(unique_code):
		return texture
	var sprite_data = worlddata.pregen_character_sprites[unique_code]
	if person.has_work_rule("nudity") and sprite_data.has("nude"):
		texture = images.get_sprite(sprite_data.nude.path)
	if ResourceScripts.game_progress.spouse != null 			and !ResourceScripts.game_progress.marriage_completed:
		var spouse = characters_pool.get_char_by_id(ResourceScripts.game_progress.spouse)
		if spouse != null and spouse.get_stat("unique") == unique_code and sprite_data.has("wed"):
			texture = images.get_sprite(sprite_data.wed.path)
	return texture


#A drawn sprite has no doll to stand itself on the floor, so it is fitted by hand: scaled to
#whichever edge it meets first, centred across, and pinned to the bottom.
func fit_sprite(texture):
	var band = rect_size
	var source = texture.get_size()
	if source.x <= 0 or source.y <= 0 or band.x <= 0 or band.y <= 0:
		return
	var fit = min(band.x / source.x, band.y / source.y)
	var shown = source * fit
	var side = (band.x - shown.x) * 0.5
	stored_image.margin_left = side
	stored_image.margin_right = -side
	stored_image.margin_top = band.y - shown.y
	stored_image.margin_bottom = 0
