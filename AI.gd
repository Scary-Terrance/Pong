extends KinematicBody2D

const SPEED = 200

onready var ball = get_parent().get_node("Ball")

var velocity = Vector2(0.0, 0.0)

func _physics_process(delta):
	var y = 0.0
	if ball:
		if self.position.y < ball.position.y && self.position.y + 64 < 600:
			y = 1.0
		elif self.position.y > ball.position.y && self.position.y - 64 > 0:
			y = -1.0
	velocity.y = y * SPEED * delta
	move_and_collide(velocity)
