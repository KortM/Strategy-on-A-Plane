extends Panel

export var size = Vector2(100,100)

func _draw():
	draw_rect(Rect2(Vector2(0,0), size), Color(0.5, 0.5, 0.5))
