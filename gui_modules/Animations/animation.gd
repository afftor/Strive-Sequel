extends Control

export var fade_delay = 0.0
export var lock_input = false
export var set_music = ""
export var sound = ""

var ff = false

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
		get_tree().get_root().set_disable_input(true)
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
	if lock_input:
		get_tree().get_root().set_disable_input(false)
	queue_free()
