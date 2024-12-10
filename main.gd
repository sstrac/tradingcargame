extends Node


const hatchback = preload("res://forecourt/vehicle.tscn")

@onready var marker1 = get_node("Marker3D")
@onready var marker2 = get_node("Marker3D2")
@onready var marker3 = get_node("Marker3D3")

# Called when the node enters the scene tree for the first time.
func _ready():
	for marker in [marker1, marker2, marker3]:
		var v = hatchback.instantiate()
		v.global_position = marker.global_position
		add_child(v)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
