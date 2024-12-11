extends Node

var vehicles: Array[VehicleMetadata] = []
var vehicles_on_forecourt: Array[VehicleMetadata] = []

signal vehicle_sold(vehicle_metadata)
signal vehicle_stock_added(vehicle_metadata)


func _ready():
	for i in range(100):
		vehicles.append(ForecourtPopulator.random())


func pop_vehicle_to_forecourt() -> VehicleMetadata:
	var v = vehicles.pop_back()
	vehicles_on_forecourt.append(v)
	return v
	

func signal_vehicle_sold(vehicle_metadata):
	vehicle_sold.emit(vehicle_metadata)


func signal_vehicle_added(vehicle_metadata):
	vehicle_stock_added.emit(vehicle_metadata)
