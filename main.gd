extends Node


const vehicle_scene = preload("res://forecourt/vehicle.tscn")

@onready var marker1 = get_node("Marker3D")
@onready var marker2 = get_node("Marker3D2")
@onready var marker3 = get_node("Marker3D3")
@onready var score_keeper = get_node("CanvasLayer/Panel/VBoxContainer/RichTextLabel")
@onready var camera = get_node("Camera3D")
@onready var autotrader_canvas = get_node("CanvasLayer2")
@onready var autotrader = autotrader_canvas.get_node("Autotrader")

# Called when the node enters the scene tree for the first time.
func _ready():
	Score.score_changed.connect(_update_score)
	_update_score()
	
	for i in range(3):
		var vehicle_metadata = VehicleDatabase.pop_vehicle_to_forecourt()
		vehicle_metadata.lane = i + 1
	
	var markers = [marker1, marker2, marker3]
	for i in range(3):
		var vehicle = vehicle_scene.instantiate()
		vehicle.vehicle_metadata = VehicleDatabase.vehicles_on_forecourt[i]
		add_child(vehicle)
		vehicle.global_position = markers[i].global_position
	autotrader.populate_with_forecourt_vehicles()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("left") and camera.global_position.x > -1:
		camera.global_position.x = lerp(camera.global_position.x, -0.8, delta)
	elif Input.is_action_pressed("right") and camera.global_position.x < 1:
		camera.global_position.x = lerp(camera.global_position.x, 0.8, delta)

func _update_score():
	score_keeper.text = "[center]£%d" % Score.score


func _on_area_3d_area_entered(player_area):
	if player_area.collision_layer == 1:
		autotrader_canvas.show()


func _on_area_3d_area_exited(player_area):
	if player_area.collision_layer == 1:
		autotrader_canvas.hide()
