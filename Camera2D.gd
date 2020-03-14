extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _input(event):
	if event.is_action("ui_up"):
		self.position.y += -10
	if event.is_action("ui_down"):
		self.position.y += 10
	if event.is_action("ui_left"):
		self.position.x += -10
	if event.is_action("ui_right"):
		self.position.x += 10