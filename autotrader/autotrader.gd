extends VBoxContainer

var advert = preload("res://autotrader/adverts_panel.tscn")

func populate_with_forecourt_vehicles():
	for vehicle in VehicleDatabase.vehicles_on_forecourt:
		var vehicleAd = advert.instantiate()
		vehicleAd.metadata = vehicle
		add_child(vehicleAd)
