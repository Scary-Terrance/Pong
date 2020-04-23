extends KinematicBody2D

const SPEED = 200

var velocity = Vector2(0.0, 0.0)

func _physics_process(delta):
	var y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if y == -1 && self.position.y - 64 <= 0:
		y = 0
	elif y == 1 && self.position.y + 64 >= 600:
		y = 0
	velocity.y = y * SPEED * delta
	move_and_collide(velocity)
	
