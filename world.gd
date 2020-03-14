extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var nav_2d = $"/root/world/Navigation2D"
onready var line_2d : Line2D = $Line2D
onready var camera2d : Camera2D = $Camera2D
var cur_packet = null

func getNav2d():
	return nav_2d

func getPath(object,goto):
	var new_path = nav_2d.get_simple_path(object,goto)
	$Line2D.points = new_path
	return new_path

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.


