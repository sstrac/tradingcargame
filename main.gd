extends Node


const hatchback = preload("res://forecourt/vehicle.tscn")

@onready var marker1 = get_node("Marker3D")
@onready var marker2 = get_node("Marker3D2")
@onready var marker3 = get_node("Marker3D3")

# Called when the node enters the scene tree for the first time.
func _ready():
	var markers = [marker1, marker2, marker3]
	for i in range(3):
		var v = hatchback.instantiate()
		v.vehicle_metadata = VehicleDatabase.vehicles[i]
		v.global_position = markers[i].global_position
		add_child(v)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
