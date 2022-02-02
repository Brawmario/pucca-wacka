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
#	for pucca in get_tree().get_nodes_in_group("pucca"):
#		var error = pucca.connect("clicked", self, "_on_pucca_cliked")
#		print(error)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer_label.visible:
		timer_label.text = "Timer: " + str(floor(game_timer.time_left))


func update_score(amount: int) -> void:
	score += amount
	if amount > 0:
		score_label.bbcode_text = "[wave amp=50 freq=40]Score: " + str(score) + "[/wave]"
		yield(get_tree().create_timer(0.2), "timeout")
	else:
		var perdi: RichTextLabel = $GameUI/PerdiLabel.duplicate()
		perdi.add_to_group("perdi")
		perdi.rect_position = Vector2(rand_range(0, 480 - 100), rand_range(0, 720 - 100))
		$GameUI.add_child(perdi)
		perdi.show()
	score_label.bbcode_text = "Score: " + str(score)


func start_game() -> void:
	for pucca in get_tree().get_nodes_in_group("pucca"):
		pucca.start_game()
	score = 0
	score_label.bbcode_text = "Score: 0"
	timer_label.visible = true
	score_label.visible = true
	game_timer.start(30)


func end_game() -> void:
	for pucca in get_tree().get_nodes_in_group("pucca"):
		pucca.end_game()

	update_high_score()

	timer_label.visible = false
	score_label.visible = false

	play_button.visible = true
	title_label.visible = true
	high_score_label.visible = true

	for perdi in get_tree().get_nodes_in_group("perdi"):
		perdi.queue_free()


func update_high_score() -> void:
	high_score = max(high_score, score)
	high_score_label.text = "High Score: " + str(high_score)


func _on_GameTimer_timeout():
	end_game()


func _on_PlayButton_pressed() -> void:
	print("PlayButton pressed")
	play_button.visible = false
	title_label.visible = false
	high_score_label.visible = false
	start_game()


#func _on_pucca_cliked(pucca_type) -> void:
#	match pucca_type:
#		Pucca.PuccaType.PUCCA:
#			update_score(1)
#		Pucca.PuccaType.NEGA_PUCCA:
#			update_score(-1)


func _on_Pucca_cliked(pucca_type) -> void:
	update_score(1)


func _on_NegaPucca_cliked(pucca_type) -> void:
	update_score(-1)
