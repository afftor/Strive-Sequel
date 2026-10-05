extends Control

#Two red lines corner to corner over whatever lies beneath: this goes if the player goes ahead.
const COLOR = Color(1, 0.165, 0.12)
const WIDTH = 3.0


func _ready():
	connect("resized", self, "update")


func _draw():
	draw_line(Vector2.ZERO, rect_size, COLOR, WIDTH, true)
	draw_line(Vector2(0, rect_size.y), Vector2(rect_size.x, 0), COLOR, WIDTH, true)
