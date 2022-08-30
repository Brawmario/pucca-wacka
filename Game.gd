extends Node2D


var score := Const.NO_SCORE
var high_score := 0

@onready var game_ui: GameUI = $GameUI
@onready var game_timer: Timer = $GameTimer


func _ready() -> void:
	game_ui.update_high_score(get_high_score())


func _process(delta: float) -> void:
	game_ui.update_timer(game_timer.time_left)


func update_score(amount: int) -> void:
	score += amount
	game_ui.update_score(score)
	if amount < 0:
		game_ui.add_perdi()


func start_game() -> void:
	for pucca in get_tree().get_nodes_in_group("pucca"):
		pucca.start_game()
	score = 0
	game_ui.start_game()
	game_timer.start(30)


func end_game() -> void:
	for pucca in get_tree().get_nodes_in_group("pucca"):
		pucca.end_game()

	update_high_score()

	game_ui.end_game()

	for perdi in get_tree().get_nodes_in_group("perdi"):
		perdi.queue_free()


func update_high_score() -> void:
	SaveManager.save_high_score(score)
	game_ui.update_high_score(get_high_score())


func get_high_score() -> int:
	return SaveManager.save.get("score1", Const.NO_SCORE)


func _on_game_timer_timeout() -> void:
	end_game()


func _on_game_ui_started() -> void:
	start_game()


func _on_game_ui_cleared_save() -> void:
	SaveManager.clear_save()
	game_ui.update_high_score(get_high_score())


func _on_pucca_cliked() -> void:
	update_score(1)


func _on_nega_pucca_cliked() -> void:
	update_score(-1)
