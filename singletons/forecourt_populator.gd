extends Node

const hatchback = preload("res://textures/vehicles/hatchback.tres")
const monster_truck = preload("res://textures/vehicles/monster_truck.tres")
const muscle_2 = preload("res://textures/vehicles/muscle_2.tres")
const muscle = preload("res://textures/vehicles/muscle.tres")
const pickup = preload("res://textures/vehicles/pickup.tres")
const roadster = preload("res://textures/vehicles/roadster.tres")
const sedan = preload("res://textures/vehicles/sedan.tres")
const suv = preload("res://textures/vehicles/suv.tres")
const truck = preload("res://textures/vehicles/truck.tres")
const van = preload("res://textures/vehicles/van.tres")


var vehicle_models = [hatchback, monster_truck, muscle_2, muscle, pickup, roadster, sedan, suv, truck, van]


func random():
	var vehicle_metadata = VehicleMetadata.new()
	vehicle_metadata.valuation = range(5000, 50000).pick_random()
	vehicle_metadata.depricationFactor = randf_range(0.9, 0.99)
	vehicle_metadata.fluctuationFactor = randf_range(0, 0.1)
	var vehicle_repr: VehicleRepresentation = vehicle_models.pick_random()
	vehicle_metadata.model = vehicle_repr.model.instantiate()
	vehicle_metadata.img = vehicle_repr.texture
	return vehicle_metadata
