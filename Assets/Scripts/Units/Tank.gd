extends KinematicBody2D

export (int) var speed = 200

onready var target = position
var velocity = Vector2()

var Bullet = preload("res://Assets/Prefubs/TankBullet1.tscn")

func _input(event):
	if event.is_action_pressed("mouse_right"):
		target = get_global_mouse_position()
	if event.is_action_pressed("mouse_left"):
		shoot()

func shoot():
	var b = Bullet.instance()
	b.start($muzzle.global_position, rotation)
	get_parent().add_child(b)

func detect_enemy():
	pass
	
func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	detect_enemy()
	if position.distance_to(target) > 25:
		velocity = move_and_slide(velocity)
		look_at(target)
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			#print(collision.collider)


func _on_detect_body_entered(body):
	pass
	#print(body) # Replace with function body.
