extends Path3D


@export var lane: int
@onready var customer = get_node("PathFollow3D/Customer")
@onready var timer = get_node("Timer")
@onready var path_follow: PathFollow3D = get_node("PathFollow3D")

var forward: bool = false
var reversed: bool = false

func _ready():
	Bids.bid_removed.connect(_on_bid_removed)
	timer.timeout.connect(go_to_forecourt)
	customer.lane = lane


func _on_bid_removed(bid):
	if not bid.online and bid.vehicle_metadata.lane == lane:
		forward = true
		reversed = true
	
	
func go_to_forecourt():
	var vehicle_in_lane = VehicleDatabase.vehicles_on_forecourt.filter(func(v): return v.lane == lane)
	
	if !vehicle_in_lane.is_empty():
		forward = true
		customer.animation_player.play("bob")
		customer.make_offer(vehicle_in_lane[0])


func _process(delta):
	if forward and not reversed:
		path_follow.progress_ratio += delta * range(5, 10).pick_random() / 10
		if path_follow.progress_ratio > 0.9:
			forward = false
			timer.stop()
	elif forward and reversed:
		path_follow.progress_ratio -= delta * range(5, 10).pick_random() / 10
		if path_follow.progress_ratio < 0.1:
			forward = false
			reversed = false
			timer.start()

	
