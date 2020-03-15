extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var d = {}

var delivered = 0
var loss = 0
var money = 1000.00
var packetvalue = 0.01
var endpointvalue = 0.05
var tonext = 10
var level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func addDelivered(where):
	if where == "client":
		addMoney(packetvalue)
	if where == "endpoint":
		addMoney(endpointvalue)
	delivered += 1
	if delivered == tonext:
		$"/root/world/".newClient()
		tonext += 10*level
	$"/root/world/Control/".update_gui()

func addLoss():
	loss += 1
	$"/root/world/Control/".update_gui()

func addMoney(ammount):
	money += ammount
	$"/root/world/Control/".update_gui()

func getTile(position):
	var tile = get_tree().get_current_scene().get_node("Navigation2D/TileMap").get_cellv(get_tree().get_current_scene().get_node("Navigation2D/TileMap").world_to_map(position))	
	return tile

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
