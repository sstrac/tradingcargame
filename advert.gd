extends Panel

@onready var label = get_node("RichTextLabel")
var metadata

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.set_text("%s" % metadata.valuation)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
