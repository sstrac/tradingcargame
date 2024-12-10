extends CharacterBody3D


@onready var body: MeshInstance3D = get_node("Character/Body")
@onready var head: MeshInstance3D = get_node("Character/Head")
@onready var arm1: MeshInstance3D = get_node("Character/Arm")
@onready var arm2: MeshInstance3D = get_node("Character/Arm2")


const RED = preload("res://textures/red.tres")
const PINK = preload("res://textures/pink.tres")
const BABY_BLUE = preload("res://textures/baby_blue.tres")
const GREEN = preload("res://textures/green.tres")
const YELLOW = preload("res://textures/yellow.tres")
const LIGHT_SKIN = preload("res://textures/light_skin.tres")
const DARK_SKIN = preload("res://textures/dark_skin.tres")


var colours = [RED, PINK, BABY_BLUE, GREEN, YELLOW]
var skin_colours = [LIGHT_SKIN, DARK_SKIN]

func _ready():
	var skin: Material = skin_colours.pick_random()
	var shirt_colour: Material = colours.pick_random()
	body.mesh.surface_set_material(0, shirt_colour)
	head.mesh.surface_set_material(0, skin)
	arm1.mesh.surface_set_material(0, skin)
	arm2.mesh.surface_set_material(0, skin)
	
