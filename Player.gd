extends KinematicBody2D

const SPEED = 200

var velocity = Vector2(0.0, 0.0)

func _physics_process(delta):
	# Determine whether up or down is being pressed
	var y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	# Move up if the player is hitting up and it won't move the paddle off screen
	if y == -1 && self.position.y - 64 <= 0:
		y = 0
	# Move down if the player is hitting down and it won't move the paddle off screen
	elif y == 1 && self.position.y + 64 >= 600:
		y = 0
	velocity.y = y * SPEED * delta
	move_and_collide(velocity)
	
