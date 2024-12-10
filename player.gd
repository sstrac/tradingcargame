extends CharacterBody3D

@onready var animation_player = get_node("AnimationPlayer")
@onready var character = get_node("Character")

var y_rotation

const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func _ready():
	y_rotation = character.rotation.y


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		var rotate_left = PI / 2
		var rotate_right = -PI / 2
		var rotate_down_clockwise = -PI
		var rotate_down_anticlockwise = PI
		var rotate_up = 0.0
		
		print(character.rotation.y)
		if direction.z == -1:
			y_rotation = rotate_up
		elif direction.x == -1:
			y_rotation = rotate_left
		elif direction.z == 1 and character.rotation.y < 0:
			y_rotation = rotate_down_clockwise
		elif direction.z == 1 and character.rotation.y >= 0:
			y_rotation = rotate_down_anticlockwise
		elif direction.x == 1:
			y_rotation = rotate_right
		#else:
			#y_rotation = y_rotation
			
		character.rotation.y = lerp(character.rotation.y, y_rotation, delta * 5)
		animation_player.play("bob")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		animation_player.stop()

	move_and_slide()
