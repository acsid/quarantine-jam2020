extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_gui():
	$NinePatchRect/VBoxContainer/HBoxContainer/delivered.text = String(data.delivered)
	$NinePatchRect/VBoxContainer/HBoxContainer2/Label2.text = String(data.loss)
	$NinePatchRect/VBoxContainer/HBoxContainer3/cash.text = String(data.money)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
