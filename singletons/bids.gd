extends Node

var bids = []

signal bid_removed(bid)

func add_bid(bid: BidMetadata):
	bids.append(bid)
	var timer = get_tree().create_timer(bid.valid_seconds)
	timer.timeout.connect(remove_bid.bind(bid))
	

func remove_bid(bid):
	bids.erase(bid)
	bid_removed.emit(bid)
