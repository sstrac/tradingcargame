extends Control

@onready var vboxnode = get_node("VBoxContainer")

var advert = preload("res://advert.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for vehicle in VehicleDatabase.vehicles:
		var vehicleAd = advert.instantiate()
		vehicleAd.metadata = vehicle
		vboxnode.add_child(vehicleAd)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
