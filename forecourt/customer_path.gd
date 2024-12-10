extends Path3D


const customer_scene = preload("res://forecourt/customer.tscn")

@onready var timer = get_node("Timer")
@onready var path_follow: PathFollow3D = get_node("PathFollow3D")

var forward: bool = false

func _ready():
	timer.timeout.connect(go_to_forecourt)
	path_follow.add_child(customer_scene.instantiate())


func go_to_forecourt():
	forward = true
	

func _process(delta):
	if forward:
		path_follow.progress_ratio += delta * 0.5
		if path_follow.progress_ratio > 0.9:
			forward = false
			timer.stop()
	
	

	
