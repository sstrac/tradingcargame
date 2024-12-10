extends Node

var vehicles: Array[VehicleMetadata] = []

func _ready():
	for i in range(100):
		vehicles.append(ForecourtPopulator.random())
