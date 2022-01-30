extends Area2D

signal clicked

var clickable := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Circle_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if clickable and event.button_index == BUTTON_LEFT and event.pressed:
			print("Pucca hitbox clicked")
			emit_signal("clicked")
