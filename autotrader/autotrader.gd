extends VBoxContainer

var advert = preload("res://autotrader/adverts_panel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	VehicleDatabase._pop_vehicle_to_forecourt()
	VehicleDatabase._pop_vehicle_to_forecourt()
	VehicleDatabase._pop_vehicle_to_forecourt()

	for vehicle in VehicleDatabase.vehicles_on_forecourt:
		var vehicleAd = advert.instantiate()
		vehicleAd.metadata = vehicle
		add_child(vehicleAd)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
