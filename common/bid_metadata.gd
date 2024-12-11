extends Resource

class_name BidMetadata

var offer_price: int
var valid_seconds: int
var lane: int
var online: bool

func _init(vehicle_metadata: VehicleMetadata, online: bool):
	self.offer_price = vehicle_metadata.valuation * randf_range(0.80, 1.15)
	self.valid_seconds = randf_range(10, 20)
	self.lane = vehicle_metadata.lane
	self.online = online
