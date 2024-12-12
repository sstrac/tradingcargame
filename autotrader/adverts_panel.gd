extends PanelContainer

@onready var texture_rect: TextureRect = get_node("AdvertHBox/TextureRect")
@onready var lane_label = get_node("%LaneLabel")
@onready var valuation_label = get_node("%ValuationLabel")
@onready var offer_label = get_node("%OfferLabel")
@onready var panel: PanelContainer = get_node("AdvertHBox/VBoxContainer4/Panel")


var metadata: VehicleMetadata
var bid: BidMetadata

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect.texture = metadata.img
	metadata.valuationUpdated.connect(_updateText)
	lane_label.set_text("[center]%d" % metadata.lane)
	valuation_label.set_text("[center]£%d" % metadata.valuation)
	offer_label.set_text("[center]£%d" % bid.offer_price)

	
func _updateText():
	valuation_label.set_text("[center]£%d" % metadata.valuation)


func _resolve_bid():
	for bid in Bids.bids:
		if bid.vehicle_metadata == metadata:
			Bids.expire_bid(bid)

func _remove_car():
	VehicleDatabase.vehicles_on_forecourt.erase(metadata)
	VehicleDatabase.signal_vehicle_sold(metadata)


func _take_their_money():
	Score.score += bid.offer_price - metadata.valuation


func _on_button_pressed():
	_resolve_bid()
	_take_their_money()
	_remove_car()
	queue_free()
