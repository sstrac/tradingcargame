extends VBoxContainer

var advert = preload("res://autotrader/adverts_panel.tscn")


func _ready():
	VehicleDatabase.vehicle_sold.connect(_remove_ad)
	VehicleDatabase.vehicle_stock_added.connect(_new_bid)
	Bids.bid_removed.connect(_on_bid_expired)


func get_ads():
	var ads = get_children()
	ads.pop_front()
	return ads
	

func _remove_ad(vehicle_metadata): 
	var ads = get_ads().filter(func(a): return a.metadata == vehicle_metadata)
	if not ads.is_empty():
		ads[0].queue_free()


func _new_bid(vehicle_metadata):
	var bid = BidMetadata.new(vehicle_metadata, true)
	Bids.add_bid(bid)
	var vehicleAd = advert.instantiate()
	vehicleAd.metadata = vehicle_metadata
	vehicleAd.bid = bid
	add_child(vehicleAd)


func _on_bid_expired(bid):
	if bid.online:
		var ads = get_ads().filter(func(a): return a.bid == bid)
		if not ads.is_empty():
			print(len(ads))
			ads[0].queue_free()
