extends VBoxContainer

var advert = preload("res://autotrader/adverts_panel.tscn")


func _ready():
	VehicleDatabase.vehicle_sold.connect(_remove_ad)
	VehicleDatabase.vehicle_stock_added.connect(_new_bid)


func _remove_ad(vehicle_metadata): 
	var ads = get_children()
	ads.pop_front()
	var ad = ads.filter(func(a): return a.metadata == vehicle_metadata)[0]
	ad.queue_free()


func _new_bid(vehicle_metadata):
	var bid = BidMetadata.new(vehicle_metadata)
	Bids.bids.append(bid)
	var vehicleAd = advert.instantiate()
	vehicleAd.metadata = vehicle_metadata
	vehicleAd.bid = bid
	add_child(vehicleAd)
