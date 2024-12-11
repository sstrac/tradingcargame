extends Node


const vehicle_scene = preload("res://forecourt/vehicle.tscn")

@onready var lane1 = get_node("Lane")
@onready var lane2 = get_node("Lane2")
@onready var lane3 = get_node("Lane3")
@onready var score_keeper = get_node("CanvasLayer/Panel/VBoxContainer/RichTextLabel")
@onready var camera = get_node("Camera3D")
@onready var autotrader_canvas = get_node("CanvasLayer2")
@onready var autotrader = autotrader_canvas.get_node("Autotrader")
@onready var vehicle_container = get_node("Vehicles")
@onready var customers = get_node("Customers").get_children()
@onready var lanes = [lane1, lane2, lane3]
@onready var exclamation_point = get_node("%ExclamationPoint")


func _ready():
	Score.score_changed.connect(_update_score)
	VehicleDatabase.vehicle_sold.connect(_remove_vehicle)
	_update_score()
	
	for i in range(3):
		var vehicle_metadata = VehicleDatabase.pop_vehicle_to_forecourt()
		vehicle_metadata.lane = i + 1
		VehicleDatabase.signal_vehicle_added(vehicle_metadata)
	
	for i in range(3):
		_create_and_add_vehicle_node(i + 1)
	
	for lane in lanes:
		lane.get_child(0).timeout.connect(_new_vehicle.bind(lane.lane))



func _new_vehicle(lane):
	lanes[lane - 1].get_child(0).stop()
	var vehicle_metadata = VehicleDatabase.pop_vehicle_to_forecourt()
	vehicle_metadata.lane = lane
	VehicleDatabase.signal_vehicle_added(vehicle_metadata)
	_create_and_add_vehicle_node(lane)


func _create_and_add_vehicle_node(lane):
	var i = lane - 1
	var vehicle = vehicle_scene.instantiate()
	var vehicle_for_lane = VehicleDatabase.vehicles_on_forecourt.filter(func(v): return v.lane == lane)[0]
	vehicle.vehicle_metadata = vehicle_for_lane
	vehicle_container.add_child(vehicle)
	vehicle.global_position = lanes[i].global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if VehicleDatabase.vehicles_on_forecourt.is_empty():
		exclamation_point.hide()
	else:
		exclamation_point.show()
	
	if Input.is_action_pressed("left") and camera.global_position.x > -1:
		camera.global_position.x = lerp(camera.global_position.x, -0.8, delta)
	elif Input.is_action_pressed("right") and camera.global_position.x < 1:
		camera.global_position.x = lerp(camera.global_position.x, 0.8, delta)


func _update_score():
	score_keeper.text = "[center]£%d" % Score.score


func filter_vehicle_by_metadata(vehicle_node, vehicle_metadata):
	return vehicle_node.vehicle_metadata.lane == vehicle_metadata.lane


func _remove_vehicle(vehicle_metadata):
	#remove vehicle node
	var vehicle_node = vehicle_container.get_children().filter(
		filter_vehicle_by_metadata.bind(vehicle_metadata)
	)[0]
	vehicle_node.queue_free()
	
	#make customer leave
	var customer_path = customers.filter(func(c): return c.lane == vehicle_metadata.lane)[0]
	customer_path.forward = true
	customer_path.reversed = true
	
	#start timer to load in a new car
	lanes[vehicle_metadata.lane - 1].get_child(0).start()


func _on_area_3d_area_entered(player_area):
	if player_area.collision_layer == 1:
		autotrader_canvas.show()


func _on_area_3d_area_exited(player_area):
	if player_area.collision_layer == 1:
		autotrader_canvas.hide()
