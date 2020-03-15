extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const PACKET = preload("res://Packet.tscn")
onready var nav_2d = $"/root/world/Navigation2D"
onready var line_2d : Line2D = $Line2D
onready var camera2d : Camera2D = $Camera2D
var cur_packet = null
var level = 1

var newrequest_radius = 10

var objectives  = {} 

func newClient():
	var pos = Vector2(rand_range(-newrequest_radius,newrequest_radius),rand_range(-newrequest_radius,newrequest_radius))
	if not $"/root/world/Navigation2D/TileMap".get_cellv(pos) == -1:
		print("client colliding with something")
		newrequest_radius += 2
		return
	print("new client")
	newrequest_radius += 1
	$"/root/world/Navigation2D/TileMap".set_cellv(pos,3)
	

func getNav2d():
	return nav_2d

func getPath(object,goto):
	var new_path = nav_2d.get_simple_path(object,goto)
	$Line2D.points = new_path
	return new_path

# Called when the node enters the scene tree for the first time.
func _ready():
	objectives[0] = 1
	objectives[1] = 3

func getObjective():
	var objective = 0
	var type = randi()%2+1
	if type == 1:
		objective = 3
	if type == 2:
		objective = 4
	var possible = $"/root/world/Navigation2D/TileMap".get_used_cells_by_id(objective)
	return possible[randi() % possible.size()]

func showObjective(position):
	$Objective.position = $Navigation2D/TileMap.map_to_world(position)
	$Objective.visible = true
	
func spawnPacket(howmany = 1):
	for n in range(howmany):
		var packet = PACKET.instance()
		packet.init($Navigation2D/TileMap.map_to_world(getObjective()))
		get_parent().add_child(packet)

# Called every frame. 'delta' is the elapsed time since the previous frame.



##timer time out spawn 1 packet
func _on_Timer_timeout():
	spawnPacket(20)
	pass

