extends Node

var bids = []

signal bid_removed(bid)

func add_bid(bid: BidMetadata):
	bids.append(bid)
	var timer = get_tree().create_timer(bid.valid_seconds)
	timer.timeout.connect(expire_bid.bind(bid))
	

func expire_bid(bid):
	if VehicleDatabase.vehicles_on_forecourt.has(bid.vehicle_metadata):
		bids.erase(bid)
		bid_removed.emit(bid)
