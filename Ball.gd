extends KinematicBody2D

# Sound Effects
onready var bump = get_parent().get_node("Coll")
onready var squish = get_parent().get_node("Squish")
onready var serve = get_parent().get_node("Serve")

const SPEED = 300

var rand = RandomNumberGenerator.new()
var velocity = Vector2(0.0, 0.0)
var direction = Vector2(0.0, 0.0)
var hit = false

func _ready():
	# Wait 2 seconds
	yield(get_tree().create_timer(2.0), "timeout")
	# Seed the random number generator
	randomize()
	rand.randomize()
	# Serve the ball
	direction = _randomize_direction()
	serve.play()

# Create a random direction vector 2d between -1.0 and 1.0
func _randomize_direction():
	# Make sure the ball does not sit in place, both axis must be != 0
	var rand_dir = Vector2(0.0, 0.0)
	while(rand_dir.x == 0 || rand_dir.y == 0):
		# Generate a random number between -1.0 and 1.0
		rand_dir.x = randf() * rand.randi_range(-1, 1)
		rand_dir.y = randf() * rand.randi_range(-1, 1)
	rand_dir = rand_dir.normalized()
	return rand_dir

# Make sure the ball stays inside the top and bottom of the screen
func _check_bounds():
	if self.position.y - 16 <= 0 || self.position.y + 16 >= 600:
		if !hit:
			# Reverse the y axis direction
			direction.y = direction.y * -1
			# Add half of a random direction to keep things interesting
			direction += _randomize_direction() / 2.0
			direction = direction.normalized()
			bump.play()
		else:
			# The ball is stuck between the paddle and the border
			# Squish the ball past into the goal by default
			squish.play()
			if self.position.x < 512:
				self.position.x -= 32
			else:
				self.position.x += 32
	# Keep the ball from being pushed out of bounds
	if self.position.y - 16 < 0:
		self.position.y = 16
	elif self.position.y + 16 > 600:
		self.position.y = (600 - 16)
		
# Check if the ball is hitting a paddle
func _check_coll(coll):
	# hit insures collide only triggers once
	if coll && hit == false:
		# Bounce back away from the collision
		direction = coll.normal
		# Add half of a random direction to keep things interesting
		direction += _randomize_direction() / 2.0
		direction = direction.normalized()
		bump.play()
		hit = true
	else:
		hit = false
	
func _physics_process(delta):
	_check_bounds()
	velocity = direction * SPEED * delta
	var coll = move_and_collide(velocity)
	_check_coll(coll)


