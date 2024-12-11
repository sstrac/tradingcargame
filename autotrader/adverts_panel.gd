extends PanelContainer

@onready var vehicle_label = get_node("AdvertHBox/VehicleLabel")
@onready var valuation_label = get_node("AdvertHBox/ValuationLabel")
@onready var offer_label = get_node("AdvertHBox/OfferLabel")
@onready var button = get_node("AdvertHBox/Button")

var metadata

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vehicle_label.set_text("{Vehicle name}")
	valuation_label.set_text("%s" % metadata.valuation)
	offer_label.set_text("{offer}")

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
