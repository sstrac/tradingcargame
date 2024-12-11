extends Node


const vehicle_scene = preload("res://forecourt/vehicle.tscn")

@onready var marker1 = get_node("Marker3D")
@onready var marker2 = get_node("Marker3D2")
@onready var marker3 = get_node("Marker3D3")
@onready var score_keeper = get_node("CanvasLayer/Panel/VBoxContainer/RichTextLabel")
@onready var camera = get_node("Camera3D")
#@onready var customers = []

# Called when the node enters the scene tree for the first time.
func _ready():
	score_keeper.text = "[center]%d" % Score.score
	
	for i in range(3):
		var vehicle_metadata = VehicleDatabase.pop_vehicle_to_forecourt()
		vehicle_metadata.lane = i + 1
	
	var markers = [marker1, marker2, marker3]
	for i in range(3):
		var vehicle = vehicle_scene.instantiate()
		vehicle.vehicle_metadata = VehicleDatabase.vehicles_on_forecourt[i]
		add_child(vehicle)
		vehicle.global_position = markers[i].global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("left") and camera.global_position.x > -1:
		camera.global_position.x = lerp(camera.global_position.x, -0.8, delta)
	elif Input.is_action_pressed("right") and camera.global_position.x < 1:
		camera.global_position.x = lerp(camera.global_position.x, 0.8, delta)
