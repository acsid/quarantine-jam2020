extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = $"/root/world/Navigation2D/TileMap".map_to_world($"/root/world/Navigation2D/TileMap".world_to_map($"/root/world/Camera2D".position + get_viewport().get_mouse_position()))

func _input(event):
	if event is InputEventMouseButton:
		if event.get_button_index():
			if data.getTile($"/root/world/Camera2D".position + get_viewport().get_mouse_position()) == -1 && data.money >= 10:
				data.addMoney(-10)
				$"/root/world/Navigation2D/TileMap".set_cellv($"/root/world/Navigation2D/TileMap".world_to_map($"/root/world/Camera2D".position + get_viewport().get_mouse_position()),1)