extends Node

var vehicles: Array[VehicleMetadata] = []

func _ready():
	vehicles.append(VehicleMetadata.new(25000))
	vehicles.append(VehicleMetadata.new(35000))
	vehicles.append(VehicleMetadata.new(20000))
	vehicles.append(VehicleMetadata.new(12500))
