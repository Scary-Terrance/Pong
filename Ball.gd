extends KinematicBody2D

const SPEED = 300

var rand = RandomNumberGenerator.new()
var velocity = Vector2(0.0, 0.0)
var direction = Vector2(0.0, 0.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	rand.randomize()
	direction = _randomize_direction()
	
func _randomize_direction():
	var rand_dir = Vector2(0.0, 0.0)
	while(rand_dir.x == 0 || rand_dir.y == 0):
		rand_dir.x = randf() * rand.randi_range(-1, 1)
		rand_dir.y = randf() * rand.randi_range(-1, 1)
	rand_dir = rand_dir.normalized()
	return rand_dir
	
func _check_bounds():
	if self.position.y - 16 <= 0 || self.position.y + 16 >= 600:
		direction.y = direction.y * -1
		direction += _randomize_direction() / 2.0
		direction = direction.normalized()
	if self.position.y - 16 < 0:
		self.position.y = 16
	elif self.position.y + 16 > 600:
		self.position.y = (600 - 16)
		
var hit = false
func _check_coll(coll):
	if coll && hit == false:
		direction = coll.normal
		direction += _randomize_direction() / 2.0
		direction = direction.normalized()
		hit = true
	else:
		hit = false
	
func _physics_process(delta):
	_check_bounds()
	velocity = direction * SPEED * delta
	var coll = move_and_collide(velocity)
	_check_coll(coll)


