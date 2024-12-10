extends Node

var vehicles: Array[VehicleInfo] = []

func _ready():
	var v = VehicleInfo.new()
	vehicles.append(v)
