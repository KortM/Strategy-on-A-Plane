extends Camera2D

var speed = 400
onready var map = get_parent().get_node("Ground")
var screen_size = null

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		#screen_size = get_viewport_rect().size
		velocity = velocity.normalized() * speed
		position += velocity * delta
		position.x = clamp(position.x, screen_size.x / 2, map.cell_size.x * map.get_used_rect().size.x - screen_size.x / 2)
		position.y = clamp(position.y, screen_size.y / 2, map.cell_size.y * map.get_used_rect().size.y - screen_size.y / 2)
	if Input.is_action_pressed("ui_home"):
		print(zoom)
		if zoom.x >= 0.5 and zoom.y >= 0.5:
			zoom *=0.9
	if Input.is_action_pressed("ui_end"):
		if zoom.x <= 1 and zoom.y <=1:
			zoom /= 0.9
