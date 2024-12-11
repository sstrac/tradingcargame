extends Node

var vehicles: Array[VehicleMetadata] = []
var vehicles_on_forecourt: Array[VehicleMetadata] = []

func _ready():
	for i in range(100):
		vehicles.append(ForecourtPopulator.random())


func pop_vehicle_to_forecourt() -> VehicleMetadata:
	var v = vehicles.pop_back()
	vehicles_on_forecourt.append(v)
	return v
