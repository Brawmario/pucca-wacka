extends Node2D


var score := 0

onready var score_label: RichTextLabel = $GameUI/ScoreLabel
onready var timer_label: RichTextLabel = $GameUI/TimerLabel

onready var game_timer: Timer = $GameTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $GameUI.visible:
		timer_label.bbcode_text = "[color=#32CD32]Timer: " + str(ceil(game_timer.time_left)) + "[/color]"

func update_score() -> void:
	score += 1
	score_label.bbcode_text = "[wave amp=50 freq=40][color=#32CD32]Score: " + str(score) + "[/color][/wave]"
	yield(get_tree().create_timer(0.2), "timeout")
	score_label.bbcode_text = "[color=#32CD32]Score: " + str(score) + "[/color]"



func start_game() -> void:
	$Pucca.start_game()
	$GameUI.visible = true
	game_timer.start(30)


func end_game() -> void:
	$Pucca.end_game()
	$GameUI.visible = false


func _on_Pucca_scored() -> void:
	update_score()


func _on_GameTimer_timeout():
	end_game()
