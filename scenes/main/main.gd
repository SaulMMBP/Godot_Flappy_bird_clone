extends Node

@export var obstacles: PackedScene
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_obstacle_timer_timeout():
	var obs = obstacles.instantiate()
	obs.start()
	add_child(obs)
	obs.get_point.connect($HUD.on_obstacle_get_point)


func new_game():
	$Player.start()
	$ObstacleTimer.start()
	$Background.start()
	$Music.play()


func _on_player_lose():
	$Background.stop()
	$ObstacleTimer.stop()
	get_tree().call_group("obstacles", "stop")
	get_tree().call_group("obstacles", "queue_free")
	$HUD.game_over()
	$Music.stop()


func _on_hud_start():
	new_game()
