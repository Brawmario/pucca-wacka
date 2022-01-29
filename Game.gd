extends Node2D


var score := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func update_score() -> void:
	score += 1
	$ScoreLabel.bbcode_text = "[wave amp=50 freq=40][color=#32CD32]Score: " + str(score) + "[/color][/wave]"
	yield(get_tree().create_timer(0.2), "timeout")
	$ScoreLabel.bbcode_text = "[color=#32CD32]Score: " + str(score) + "[/color]"

func _on_Pucca_scored() -> void:
	update_score()
