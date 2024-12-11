extends Path3D


@export var lane: int
@onready var customer = get_node("PathFollow3D/Customer")
@onready var timer = get_node("Timer")
@onready var path_follow: PathFollow3D = get_node("PathFollow3D")

var forward: bool = false

func _ready():
	timer.timeout.connect(go_to_forecourt)
	customer.lane = lane


func go_to_forecourt():
	var vehicle_in_lane = VehicleDatabase.vehicles_on_forecourt.filter(func(v): return v.lane == lane)
	
	if !vehicle_in_lane.is_empty():
		forward = true
		customer.animation_player.play("bob")
		_make_offer(vehicle_in_lane[0])
	

func _make_offer(vehicle: VehicleMetadata):
	var bid = BidMetadata.new(vehicle)
	Bids.bids.append(bid)
	customer.label.set_text("£%d" % bid.offer_price)


func _process(delta):
	if forward:
		path_follow.progress_ratio += delta * range(5, 10).pick_random() / 10
		if path_follow.progress_ratio > 0.9:
			forward = false
			timer.stop()
			#customer.animation_player.stop()
	
	

	
