extends Node2D


var score := 0

onready var score_label: RichTextLabel = $GameUI/ScoreLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func update_score() -> void:
	score += 1
	score_label.bbcode_text = "[wave amp=50 freq=40][color=#32CD32]Score: " + str(score) + "[/color][/wave]"
	yield(get_tree().create_timer(0.2), "timeout")
	score_label.bbcode_text = "[color=#32CD32]Score: " + str(score) + "[/color]"


func start_game() -> void:
	$Pucca.start_game()
	$GameUI.visible = true


func _on_Pucca_scored() -> void:
	update_score()
