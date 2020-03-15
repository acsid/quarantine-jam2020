extends Sprite


var speed : = 100.0
var path : = PoolVector2Array() setget set_path
var is_busy = false 
var is_selected = false
var last_tile = Vector2()
var objective = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	last_tile = get_tree().get_current_scene().get_node("Navigation2D/TileMap").world_to_map(self.position)
	#data.d[last_tile] += 1
	objective = $"/root/world/".getObjective()
	set_process(false)

func init(pos):
	#print("Packet Spawn")
	self.position = pos
	self.position.y += 16
	

func _process(delta: float) -> void:
	var move_distance : = speed * delta
	if last_tile == objective:
		print("local packet")
		queue_free()
	checkTile()
	move_along_path(move_distance)
	
func getTile():
	var tile = get_tree().get_current_scene().get_node("Navigation2D/TileMap").get_cellv(get_tree().get_current_scene().get_node("Navigation2D/TileMap").world_to_map(self.position))	
	return tile
	
func checkTile():
	var tile = get_tree().get_current_scene().get_node("Navigation2D/TileMap").get_cellv(get_tree().get_current_scene().get_node("Navigation2D/TileMap").world_to_map(self.position))
	if not last_tile == get_tree().get_current_scene().get_node("Navigation2D/TileMap").world_to_map(self.position):
		#data.d[last_tile] += -1
		last_tile = get_tree().get_current_scene().get_node("Navigation2D/TileMap").world_to_map(self.position)
		#print("tile changed")
		#print(tile)
		if last_tile == objective:
			if getTile() == 3:
				data.addDelivered("client")
			if getTile() == 4:
				data.addDelivered("endpoint")
			print("Success")
			queue_free()
		else:
			$TimeOut.start()
	elif last_tile == get_tree().get_current_scene().get_node("Navigation2D/TileMap").world_to_map(self.position):
		pass
	else:
		#data.d[get_tree().get_current_scene().get_node("Navigation2D/TileMap").world_to_map(self.position)] += 1
		last_tile = get_tree().get_current_scene().get_node("Navigation2D/TileMap").world_to_map(self.position)
	
func move_along_path(distance : float) -> void:
	var start_point : = position
	for i in range(path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif distance < 0.0 :
			position = path[0]
			set_process(false)
			break
		if path.size() == 1:
			position = path[0]
			set_process(false)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
	
func set_path(value : PoolVector2Array) -> void:
	path = value
	if value.size() == 0:
		return
	set_process(true)


func _input(event):
	if is_busy:
		return
	if not is_selected:
		return
	if not event is InputEventMouseButton:
		return
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
	#print(event.global_position)
	var new_path = $"/root/world/".getPath(position,$"/root/world/Camera2D".position+event.global_position)
	#line_2d.points = new_path
	set_path(new_path)
	is_selected = false
	print(event)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.get_button_index() && not is_busy && not is_selected:
			is_selected = true
			$"/root/world/".showObjective(objective)


func _on_Timer_timeout():
	var target = get_tree().get_current_scene().get_node("Navigation2D/TileMap").map_to_world(objective)
	target.y += 8
	target.x -= 8
	var new_path = $"/root/world/".getPath(position,target)
	#line_2d.points = new_path
	set_path(new_path)


func _on_TimeOut_timeout():
	if last_tile == objective:
		if getTile() == 3:
			data.addDelivered("client")
		print("Success")
		queue_free()
	else:
		data.addLoss()
		print("Fail")
		queue_free()
	
	pass # Replace with function body.
