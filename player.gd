extends CharacterBody3D

@onready var animation_player = get_node("AnimationPlayer")
@onready var character = get_node("Character")
@onready var sprint_timer = get_node("SprintTimer")
@onready var particles = get_node("%CPUParticles3D")
@onready var area = get_node("Area3D")

var y_rotation
var closest_customer


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
	if event.is_action_pressed("shift") and is_on_floor():
		speed = SPRINT_SPEED
		sprint_timer.start() 
		particles.emitting = true
	elif event.is_action_released("shift"):
		await _stop_sprinting()
	elif event.is_action_pressed("E") and closest_customer:
		var vehicle = VehicleDatabase.vehicles_on_forecourt.filter(func(v): return v.lane == closest_customer.lane)[0]
		_resolve_bid()
		_make_customer_leave()
		_take_their_money(vehicle)
		_remove_car(vehicle)
		closest_customer = null
		


func _resolve_bid():
	for bid in Bids.bids:
		if bid.lane == closest_customer.lane:
			Bids.bids.erase(bid)


func _make_customer_leave():
	closest_customer.label.hide()
	var customer_path = closest_customer.get_parent().get_parent()
	customer_path.forward = true
	customer_path.reversed = true
	

func _take_their_money(vehicle):
	Score.score += closest_customer.bid.offer_price - vehicle.valuation


func _remove_car(vehicle):
	VehicleDatabase.vehicles_on_forecourt.erase(vehicle)
	VehicleDatabase.signal_vehicle_sold(vehicle)
	
	
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


func _on_area_3d_area_entered(area: Area3D):
	if area.collision_layer == 1:
		area.E.visible = true
		closest_customer = area


func _on_area_3d_area_exited(area):
	if area.collision_layer == 1:
		area.E.visible = false
		closest_customer = null
