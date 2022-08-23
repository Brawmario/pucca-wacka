extends CanvasLayer
class_name GameUI


signal started
signal cleared_save

@onready var score_label: RichTextLabel = $ScoreLabel
@onready var timer_label: Label = $TimerLabel
@onready var title_label: Label = $TitleLabel
@onready var high_score_label: Label = $HighScoreLabel
@onready var play_button: Button = $PlayButton
@onready var clear_button: Button = $ClearButton


func update_timer(time: float) -> void:
	if timer_label.visible:
		timer_label.text = "Timer: %d" % floor(time)


func update_score(score: int) -> void:
	score_label.text = "[wave amp=50 freq=40]Score: %d[/wave]" % score
	await get_tree().create_timer(0.2).timeout
	score_label.text = "Score: %d" % score


func update_high_score(score: int) -> void:
	if score != Const.NO_SCORE:
		high_score_label.text = "High Score: %d" % score
	else:
		high_score_label.text = "High Score:"


func add_perdi() -> void:
	var perdi: RichTextLabel = $PerdiLabel.duplicate()
	perdi.add_to_group("perdi")
	perdi.position = Vector2(randf_range(0, 480 - 100), randf_range(0, 720 - 100))
	add_child(perdi)
	perdi.show()


func start_game() -> void:
	play_button.visible = false
	clear_button.visible = false
	title_label.visible = false
	high_score_label.visible = false

	score_label.text = "Score: 0"
	timer_label.visible = true
	score_label.visible = true


func end_game() -> void:
	timer_label.visible = false
	score_label.visible = false

	play_button.visible = true
	clear_button.visible = true
	title_label.visible = true
	high_score_label.visible = true


func _on_PlayButton_pressed() -> void:
	started.emit()


func _on_ClearButton_pressed():
	cleared_save.emit()
