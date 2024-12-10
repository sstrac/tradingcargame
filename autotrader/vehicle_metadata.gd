extends Resource
class_name VehicleMetadata

@export var valuation: int
@export var depricationFactor: float
@export var fluctuationFactor: float

func _init(valuation: int = 0, depricationFactor: float = 0.9, fluctuationFactor: float = 0.05) -> void:
	self.valuation = valuation
	self.depricationFactor = depricationFactor
	self.fluctuationFactor = fluctuationFactor
	ValueChangingTimer.timeout.connect(updateValuation)

func updateValuation():
	print(valuation)
	var valueAfterDeprication = valuation * randf_range(depricationFactor, 1)
	self.valuation = valueAfterDeprication * randf_range((1+fluctuationFactor), (1-fluctuationFactor))
