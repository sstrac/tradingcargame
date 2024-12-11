extends Resource
class_name VehicleMetadata

var previousValuation: int
var valuation: int
var depricationFactor: float
var fluctuationFactor: float
var lane: int
var model: Node3D

signal valuationUpdated

func _init(valuation: int = 0, depricationFactor: float = 0.9, fluctuationFactor: float = 0.05) -> void:
	self.valuation = valuation
	self.depricationFactor = depricationFactor
	self.fluctuationFactor = fluctuationFactor
	ValueChangingTimer.timeout.connect(updateValuation)

func updateValuation():
	self.previousValuation = int(self.valuation)
	var valueAfterDeprication = valuation * depricationFactor
	self.valuation = valueAfterDeprication * randf_range((1+fluctuationFactor), (1-fluctuationFactor))
	valuationUpdated.emit()
