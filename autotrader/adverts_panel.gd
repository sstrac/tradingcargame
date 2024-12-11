extends PanelContainer

@onready var lane_label = get_node("AdvertHBox/LaneLabel")
@onready var valuation_label = get_node("AdvertHBox/ValuationLabel")
@onready var offer_label = get_node("AdvertHBox/OfferLabel")
@onready var button = get_node("AdvertHBox/Button")

var metadata
var bid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	metadata.valuationUpdated.connect(_updateText)
	lane_label.set_text("Lane %d" % metadata.lane)
	valuation_label.set_text("£%s" % metadata.valuation)
	offer_label.set_text("£%s" % bid.offer_price)


	pass # Replace with function body.


	
func _updateText():
	valuation_label.set_text("£%s" % metadata.valuation)

func _on_button_pressed() -> void:
	_resolve_bid()
	_take_their_money()
	_remove_car()
	queue_free()

func _resolve_bid():
	for bid in Bids.bids:
		if bid.lane == metadata.lane:
			Bids.bids.erase(bid)

func _remove_car():
	VehicleDatabase.vehicles_on_forecourt.erase(metadata)
	VehicleDatabase.signal_vehicle_sold(metadata)


func _take_their_money():
	Score.score += bid.offer_price - metadata.valuation
