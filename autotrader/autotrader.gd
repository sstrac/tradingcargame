extends VBoxContainer

var advert = preload("res://autotrader/adverts_panel.tscn")


func populate_with_forecourt_vehicles():
	for vehicle in VehicleDatabase.vehicles_on_forecourt:
		var bid = BidMetadata.new(vehicle)
		Bids.bids.append(bid)
		var vehicleAd = advert.instantiate()
		vehicleAd.metadata = vehicle
		vehicleAd.bid = bid
		add_child(vehicleAd)
