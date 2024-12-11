extends StaticBody3D

@onready var label = get_node("ValueLabel")

var vehicle_metadata: VehicleMetadata

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vehicle_metadata.valuationUpdated.connect(_updateText)
	add_child(vehicle_metadata.model)
	_updateText()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _updateText():
	label.text = "£%d" % vehicle_metadata.valuation
