extends Node2D


var score := 0
var high_score := 0

onready var score_label: RichTextLabel = $GameUI/ScoreLabel
onready var timer_label: Label = $GameUI/TimerLabel
onready var title_label: Label = $GameUI/TitleLabel
onready var high_score_label: Label = $GameUI/HighScoreLabel
onready var play_button: Button = $GameUI/PlayButton

onready var game_timer: Timer = $GameTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer_label.visible:
		timer_label.text = "Timer: " + str(ceil(game_timer.time_left))

func update_score() -> void:
	score += 1
	score_label.bbcode_text = "[wave amp=50 freq=40]Score: " + str(score) + "[/wave]"
	yield(get_tree().create_timer(0.2), "timeout")
	score_label.bbcode_text = "Score: " + str(score)



func start_game() -> void:
	$Pucca.start_game()
	score = 0
	score_label.bbcode_text = "Score: 0"
	timer_label.visible = true
	score_label.visible = true
	game_timer.start(30)


func end_game() -> void:
	$Pucca.end_game()
	update_high_score()

	timer_label.visible = false
	score_label.visible = false

	play_button.visible = true
	title_label.visible = true
	high_score_label.visible = true


func update_high_score() -> void:
	high_score = max(high_score, score)
	high_score_label.text = "High Score: " + str(high_score)


func _on_Pucca_scored() -> void:
	update_score()


func _on_GameTimer_timeout():
	end_game()


func _on_PlayButton_pressed() -> void:
	print("PlayButton pressed")
	play_button.visible = false
	title_label.visible = false
	high_score_label.visible = false
	start_game()
