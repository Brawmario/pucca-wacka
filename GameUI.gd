extends CanvasLayer
class_name GameUI


signal started

onready var score_label: RichTextLabel = $ScoreLabel
onready var timer_label: Label = $TimerLabel
onready var title_label: Label = $TitleLabel
onready var high_score_label: Label = $HighScoreLabel
onready var play_button: Button = $PlayButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func update_timer(time: float) -> void:
	if timer_label.visible:
		timer_label.text = "Timer: " + str(floor(time))


func update_score(score: int) -> void:
	score_label.bbcode_text = "[wave amp=50 freq=40]Score: " + str(score) + "[/wave]"
	yield(get_tree().create_timer(0.2), "timeout")
	score_label.bbcode_text = "Score: " + str(score)


func update_high_score(score: int) -> void:
	high_score_label.text = "High Score: " + str(score)


func add_perdi() -> void:
	var perdi: RichTextLabel = $PerdiLabel.duplicate()
	perdi.add_to_group("perdi")
	perdi.rect_position = Vector2(rand_range(0, 480 - 100), rand_range(0, 720 - 100))
	add_child(perdi)
	perdi.show()


func start_game() -> void:
	play_button.visible = false
	title_label.visible = false
	high_score_label.visible = false

	score_label.bbcode_text = "Score: 0"
	timer_label.visible = true
	score_label.visible = true


func end_game() -> void:
	timer_label.visible = false
	score_label.visible = false

	play_button.visible = true
	title_label.visible = true
	high_score_label.visible = true


func _on_PlayButton_pressed() -> void:
	print("PlayButton pressed")
	emit_signal("started")
