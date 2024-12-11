extends Node

var vehicles: Array[VehicleMetadata] = []
var vehicles_on_forecourt: Array[VehicleMetadata] = []

func _ready():
	for i in range(100):
		vehicles.append(ForecourtPopulator.random())
		
func _pop_vehicle_to_forecourt():
	vehicles_on_forecourt.append(vehicles.pop_back())
