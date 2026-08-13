extends RichTextEffect

#smooth top-to-bottom appearance of a text block wrapped into [reveal][/reveal].
#per-character alpha is used instead of a shader material, because a custom material
#on a text node breaks glyph rendering in godot 3.

var bbcode = "reveal"

var start_time = 0
var start_index = 0
var duration = 1.4
var total_chars = 1
var soft_chars = 200.0
var softness_ratio = 0.4
var min_soft_chars = 200.0
var max_index_seen = 0
var finished = true


#first_index is an absolute index of the block's first character - relative_index can't be
#used for this, as it restarts at every bbcode tag inside the block.
#softness is a part of the block over which characters fade in. it should cover several
#lines, otherwise the wave reads as a line running left to right instead of text
#appearing from top to bottom
func start(first_index, char_count, new_duration = 1.4, softness = 0.4, min_softness = 200.0):
	start_index = int(max(first_index, 0))
	duration = max(new_duration, 0.01)
	softness_ratio = softness
	min_soft_chars = min_softness
	max_index_seen = 0
	set_block_size(char_count)
	start_time = OS.get_ticks_msec()
	finished = false


#RichTextLabel counts its characters lazily, on redraw, so the real block size is known
#only a frame after the text was set - until then a rough estimate is used
func set_block_size(char_count):
	total_chars = int(max(char_count, 1))
	#a short block can't afford the full softness - it would just fade in as a whole
	soft_chars = max(total_chars * softness_ratio, min(total_chars * 0.9, min_soft_chars))


func _process_custom_fx(char_fx):
	if finished:
		return true
	var index = char_fx.absolute_index - start_index
	if index < 0:#text shown before the current block always stays visible
		return true
	max_index_seen = int(max(max_index_seen, index))
	var time = (OS.get_ticks_msec() - start_time) / 1000.0
	var head = (time / duration) * (total_chars + soft_chars)
	#the wave is not cut off by the timer alone - it also has to pass the last character
	#actually drawn, otherwise the rest of the text would pop up at once
	if time >= duration and (head >= max_index_seen + soft_chars or time >= duration * 1.4):
		finished = true
		return true
	char_fx.color.a *= clamp((head - index) / soft_chars, 0.0, 1.0)
	return true
