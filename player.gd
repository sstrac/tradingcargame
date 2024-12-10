extends CharacterBody3D

@onready var animation_player = get_node("AnimationPlayer")
@onready var character = get_node("Character")
@onready var sprint_timer = get_node("SprintTimer")
@onready var particles = get_node("CPUParticles3D")

var y_rotation

const NORMAL_SPEED = 7.0
const SPRINT_SPEED = 12.0

var speed = NORMAL_SPEED
const JUMP_VELOCITY = 4.5


func _ready():
	y_rotation = character.rotation.y
	sprint_timer.timeout.connect(_stop_sprinting)

func _stop_sprinting():
	sprint_timer.stop()
	speed = NORMAL_SPEED
	await get_tree().create_timer(2).timeout
	particles.emitting = false


func _input(event):
	print(speed)
	if event.is_action_pressed("shift") and is_on_floor():
		speed = SPRINT_SPEED
		sprint_timer.start() 
		particles.emitting = true
	elif event.is_action_released("shift"):
		await _stop_sprinting()


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
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
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
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		animation_player.stop()

	move_and_slide()
