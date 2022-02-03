extends Node2D


var score := Const.NO_SCORE
var high_score := 0

onready var game_ui: GameUI = $GameUI
onready var game_timer: Timer = $GameTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_ui.update_high_score(get_high_score())
#	for pucca in get_tree().get_nodes_in_group("pucca"):
#		var error = pucca.connect("clicked", self, "_on_pucca_cliked")
#		print(error)


# Called every frame. 'delta' is the elapsed time since the previous frame.
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


func _on_GameTimer_timeout():
	end_game()


func _on_GameUI_started() -> void:
	start_game()


func _on_GameUI_cleared_save():
	SaveManager.clear_save()
	game_ui.update_high_score(get_high_score())


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
