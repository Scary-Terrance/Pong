extends Node2D

# Nodes
onready var ball_sack = preload("res://Ball.tscn")
onready var player_score_label = $UI/Player_Score
onready var ai_score_label = $UI/AI_Score

# Sound Effects
onready var spawn = $Spawn
onready var score = $Score

var ball
var player_score = 0
var ai_score = 0

# Create a new ball at spawn.position
func _spawn_ball():
	ball = ball_sack.instance()
	ball.set_name("Ball")
	ball.position = spawn.position
	add_child(ball)

func _ready():
	_spawn_ball()

# Called every time the ball reaches a goal
func _score():
	score.play()
	self.remove_child(ball)
	_spawn_ball()
	
func _physics_process(_delta):
	if ball:
		# The AI Scores
		if ball.position.x - 16 <= 0:
			_score()
			ai_score += 1
			ai_score_label.text = String(ai_score)
	
		# The Player Scores
		elif ball.position.x + 16 >= 1024:
			_score()
			player_score += 1
			player_score_label.text = String(player_score)

