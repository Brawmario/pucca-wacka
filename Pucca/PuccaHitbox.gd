extends Area2D

signal clicked

var clickable := false


func _on_Circle_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if clickable and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Pucca hitbox clicked")
			clicked.emit()
