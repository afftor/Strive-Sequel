extends Node

signal pass_next_animation
signal cast_finished
signal predamage_finished
signal postdamage_finished
signal alleffectsfinished

var cast_timer = 0
var aftereffecttimer = 0
var postdamagetimer = 0
var aftereffectdelay = 0.1

func _process(delta):
	if cast_timer > 0:
		cast_timer -= delta
		if cast_timer <= 0:
			cast_finished()
	if aftereffecttimer > 0:
		aftereffecttimer -= delta
		if aftereffecttimer <= 0:
			predamage_finished()
	if postdamagetimer > 0:
		postdamagetimer -= delta
		if postdamagetimer <= 0:
			postdamage_finished()

func casterattack(node):
	var tween = input_handler.GetTweenNode(node)
	var playtime = 0.2
	var delaytime = 0
	var effectdelay = 0.6
	var nextanimationtime = 0
	
	#tween.interpolate_property(node, 'rect_position', node.get_position(), node.get_position() + Vector2(100,0), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delaytime)
	#tween.interpolate_property(node, 'rect_position', node.get_position() + Vector2(100,0), node.get_position(), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, playtime)
	tween.start()
	
	
	#tween.interpolate_callback(input_handler, 0,'PlaySound',"slash")
	
	tween.interpolate_callback(self, nextanimationtime, 'nextanimation')
	
	cast_timer = effectdelay

func nextanimation():
	emit_signal("pass_next_animation")

func cast_finished():
	emit_signal("cast_finished")

func predamage_finished():
	emit_signal("predamage_finished")
#	var tween = input_handler.GetTweenNode(self)
#	tween.interpolate_callback(self, 1, 'allanimationsfinished')
#	tween.start()

func postdamage_finished():
	emit_signal("postdamage_finished")
	var tween = input_handler.GetTweenNode(self)
	tween.interpolate_callback(self, 1, 'allanimationsfinished')
	tween.start()

func allanimationsfinished():
	emit_signal("alleffectsfinished")


func targetattack(node):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.2
	input_handler.gfx(node, 'slash')
	tween.interpolate_callback(self, nextanimationtime, 'nextanimation')
	tween.start()
	aftereffecttimer = nextanimationtime + aftereffectdelay


func targetfire(node):
	var tween = input_handler.GetTweenNode(node)
	var nextanimationtime = 0.2
	input_handler.gfx(node, 'fire')
	tween.interpolate_callback(self, nextanimationtime, 'nextanimation')
	tween.start()
	postdamagetimer = nextanimationtime + aftereffectdelay

func miss(node):
	var tween = input_handler.GetTweenNode(node)
	var playtime = 0.1
	var nextanimationtime = 0.0
	var delaytime = 0.8
	input_handler.PlaySound("combatmiss")
	input_handler.FloatText(node, tr("MISS"), 'miss', Color(1,1,1), 2, 0.2, node.get_node('Icon').rect_size/2-Vector2(20,20))
	tween.interpolate_property(node, 'modulate', Color(1,1,1), Color(1,1,0), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	tween.interpolate_property(node, 'modulate', Color(1,1,0), Color(1,1,1), playtime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delaytime)
	tween.start()
	aftereffecttimer = nextanimationtime + aftereffectdelay
