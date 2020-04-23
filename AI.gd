extends KinematicBody2D

const SPEED = 200

var velocity = Vector2(0.0, 0.0)

func _physics_process(delta):
	# Keep the paddle in bounds
	if self.position.y - 64 < 0:
		self.position.y = 64
	elif self.position.y + 64 > 600:
		self.position.y = 600 - 64
	# Find the ball node
	for ball in get_tree().get_nodes_in_group("Balls"):
		var y = 0.0
		# Ball is below the paddle, move down
		if self.position.y + 10 < ball.position.y && self.position.y + 64 < 600:
			y = 1.0
		# Ball is above the paddle move up
		elif self.position.y - 10 > ball.position.y && self.position.y - 64 > 0:
			y = -1.0
		# Lerp towards ball y axis position to prevent jittering
		velocity.y = lerp(y * SPEED * delta, velocity.y, 0.05)
		move_and_collide(velocity)
