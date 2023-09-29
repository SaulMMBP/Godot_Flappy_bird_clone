extends CharacterBody2D

signal get_point

@export var speed = 100.0
var is_moving

func _ready():
	position.x = 2000
	position.y = randf_range(get_viewport_rect().size.y / 4, (get_viewport_rect().size.y / 4) * 3)


func start():
	is_moving = true


func stop():
	is_moving = false


func _physics_process(delta):
	if get_slide_collision_count() > 0:
		is_moving = false
	
	if is_moving:
		move(delta)


func move(delta):
	velocity.x -= speed * delta
	
	if position.x < get_viewport_rect().size.x / 2 + 5 and position.x > get_viewport_rect().size.x / 2 - 5:
		get_point.emit()

	move_and_slide()
	
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	if position.x < 0:
		queue_free()
