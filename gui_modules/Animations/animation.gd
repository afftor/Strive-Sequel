extends Control

export var fade_delay = 0.0
export var lock_input = false
export var set_music = ""
export var sound = ""

var ff = false
var input_locked = false

func _input(event):
	if event.is_action_released("LMB"):
		if ff:
			return
		ff = true
		if fade_delay > 0.0:
			fade_delay = 0.1
#			fade_delay = 10
			var delta = $AnimationPlayer.current_animation_length - $AnimationPlayer.current_animation_position
			$AnimationPlayer.advance(max(delta - 0.1, 0.0))
		else:
			$AnimationPlayer.playback_speed *= 10


func play(track):
	raise()
	ff = false
	#main rack
	if lock_input:
		input_locked = true
		input_handler.lock_input()
	if sound != "":
		input_handler.PlaySound(sound)
	$AnimationPlayer.play(track)
	yield($AnimationPlayer, "animation_finished")
	#fade
	ff = true
	if fade_delay > 0.0:
		ResourceScripts.core_animations.FadeAnimation(self, fade_delay)
		yield(get_tree().create_timer(fade_delay), 'timeout')
	#closing
	if set_music != "":
		input_handler.SetMusic(set_music)
	release_input()
	queue_free()
	input_handler.emit_signal("animation_finished")


func release_input():
	if !input_locked:
		return
	input_locked = false
	input_handler.unlock_input()


#play() waits on the animation, and a scene change (load, main menu) can free this node in
#the middle of that wait - its coroutine dies with it and the lock would never be released
func _exit_tree():
	release_input()
