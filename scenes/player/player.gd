extends CharacterBody2D

signal lose

const IMPULSE = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_moving

func _ready():
	hide()

func start():
	init_animation()
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y / 2
	velocity = Vector2.ZERO
	show()
	is_moving = true


func _physics_process(delta):
	if is_moving:
		move(delta)


func move(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y = IMPULSE

	if velocity.y < 0:
		$AnimatedSprite2D.play("flying")
	else:
		$AnimatedSprite2D.stop()

	move_and_slide()
	
	if get_slide_collision_count() > 0:
		has_lose()

func has_lose():
	is_moving = false
	lose.emit()
	$AnimatedSprite2D.play("got_hit")
	await get_tree().create_timer(1.0).timeout
	$AnimatedSprite2D.stop()
	hide()



func init_animation():
	$AnimatedSprite2D.play("flying")
	$AnimatedSprite2D.stop()
