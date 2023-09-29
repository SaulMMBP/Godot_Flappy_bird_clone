extends ParallaxBackground

var speed = 100
var is_moving

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_moving:
		scroll_offset.x -= speed * delta


func start():
	is_moving = true
	
	
func stop():
	is_moving = false
