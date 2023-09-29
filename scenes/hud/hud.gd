extends CanvasLayer

signal start

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameOver.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and $Start.visible:
		_on_start_pressed()


func on_obstacle_get_point():
	score +=1
	$Score.text = "Score: %s" % score


func game_over():
	$GameOver.show()
	await get_tree().create_timer(1.0).timeout
	$GameOver.hide()
	$Start.show()


func _on_start_pressed():
	start.emit()
	score = 0
	$Score.text = "Score: %s" % score
	$Start.hide()
