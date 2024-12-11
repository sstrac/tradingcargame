extends Path3D



@onready var customer = get_node("PathFollow3D/Customer")
@onready var timer = get_node("Timer")
@onready var path_follow: PathFollow3D = get_node("PathFollow3D")

var forward: bool = false

func _ready():
	timer.timeout.connect(go_to_forecourt)


func go_to_forecourt():
	forward = true
	

func _process(delta):
	if forward:
		customer.animation_player.play("bob")
		
		path_follow.progress_ratio += delta * range(5, 10).pick_random() / 10
		if path_follow.progress_ratio > 0.9:
			forward = false
			timer.stop()
			#customer.animation_player.stop()
	
	

	
