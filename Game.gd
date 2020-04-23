extends Node2D

onready var ball = $Ball

func _physics_process(delta):
	if ball.position.x - 16 <= 0:
		get_tree().reload_current_scene()
	elif ball.position.x + 16 >= 1024:
		get_tree().reload_current_scene()
