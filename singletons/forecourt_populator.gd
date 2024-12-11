extends Node

const hatchback = preload("res://textures/vehicles/Hatchback.fbx")
const monster_truck = preload("res://textures/vehicles/Monster Truck.fbx")
const muscle_2 = preload("res://textures/vehicles/Muscle 2.fbx")
const muscle = preload("res://textures/vehicles/Muscle.fbx")
const pickup = preload("res://textures/vehicles/Pickup.fbx")
const roadster = preload("res://textures/vehicles/Roadster.fbx")
const sedan = preload("res://textures/vehicles/Sedan.fbx")
const suv = preload("res://textures/vehicles/SUV.fbx")
const truck = preload("res://textures/vehicles/Truck.fbx")
const van = preload("res://textures/vehicles/Van.fbx")


var vehicle_models = [hatchback, monster_truck, muscle_2, muscle, pickup, roadster, sedan, suv, truck, van]


func random():
	var vehicle_metadata = VehicleMetadata.new()
	vehicle_metadata.valuation = range(5000, 50000).pick_random()
	vehicle_metadata.depricationFactor = randf_range(0.9, 0.99)
	vehicle_metadata.fluctuationFactor = randf_range(0, 0.1)
	vehicle_metadata.model = vehicle_models.pick_random().instantiate()
	return vehicle_metadata
