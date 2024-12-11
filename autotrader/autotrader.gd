extends VBoxContainer

var advert = preload("res://autotrader/adverts_panel.tscn")


func _ready():
	VehicleDatabase.vehicle_sold.connect(_remove_ad)
	VehicleDatabase.vehicle_stock_added.connect(_new_bid)
	Bids.bid_removed.connect(_on_bid_removed)


func get_ad_for_vehicle(vehicle_metadata):
	var ads = get_children()
	ads.pop_front()
	return ads.filter(func(a): return a.metadata == vehicle_metadata)[0]
	

func _remove_ad(vehicle_metadata): 
	var ad = get_ad_for_vehicle(vehicle_metadata)
	ad.queue_free()


func _new_bid(vehicle_metadata):
	var bid = BidMetadata.new(vehicle_metadata, true)
	Bids.add_bid(bid)
	var vehicleAd = advert.instantiate()
	vehicleAd.metadata = vehicle_metadata
	vehicleAd.bid = bid
	add_child(vehicleAd)


func _on_bid_removed(bid):
	if bid.online:
		var ads = get_children()
		ads.pop_front()
		var ad = ads.filter(func(a): return a.metadata.lane == bid.lane)[0]
		
		var new_bid_wait_seconds = randf_range(5, 10)
		get_tree().create_timer(new_bid_wait_seconds).timeout.connect(_new_bid.bind(ad.metadata))

		ad.queue_free()
