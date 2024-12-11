extends Resource

class_name BidMetadata

var offer_price: int
var lane: int


func _init(vehicle_metadata: VehicleMetadata):
	self.offer_price = vehicle_metadata.valuation * randf_range(0.80, 1.15)
	self.lane = vehicle_metadata.lane
