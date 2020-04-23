extends Node2D

onready var ball_sack = preload("res://Ball.tscn")
onready var spawn = $Spawn

var ball
var player_score = 0
var ai_score = 0

func _spawn_ball():
	ball = ball_sack.instance()
	ball.set_name("Ball")
	ball.position = spawn.position
	add_child(ball)

func _ready():
	_spawn_ball()

func _physics_process(_delta):
	if ball:
		if ball.position.x - 16 <= 0:
			ai_score += 1
			self.remove_child(ball)
			_spawn_ball()
			print(ai_score)
		elif ball.position.x + 16 >= 1024:
			player_score += 1
			self.remove_child(ball)
			_spawn_ball()
			print(player_score)
