extends Node

var vehicles: Array[VehicleMetadata] = []
var vehicles_on_forecourt: Array[VehicleMetadata] = []

signal vehicle_sold(vehicle_metadata)

func _ready():
	for i in range(100):
		vehicles.append(ForecourtPopulator.random())


func pop_vehicle_to_forecourt() -> VehicleMetadata:
	var v = vehicles.pop_back()
	vehicles_on_forecourt.append(v)
	return v
	

func signal_vehicle_sold(vehicle_metadata):
	vehicle_sold.emit(vehicle_metadata)
