extends Node

var save := {}
const SAVE_PATH := "user://save.json"


func _ready() -> void:
	load_save()


func load_save() -> void:
	var save_file := File.new()
	if not save_file.file_exists(SAVE_PATH):
		return
	save_file.open(SAVE_PATH, File.READ)
	var json := JSON.parse(save_file.get_as_text())
	if json.error == OK:
		save = json.result
	save_file.close()


func save_to_file() -> void:
	var save_file := File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	save_file.store_string(JSON.print(save, "\t"))
	save_file.close()

func clear_save() -> void:
	save.clear()
	save_to_file()

func save_high_score(score: int) -> void:
	if save.has("score1"):
		save["score1"] = max(save["score1"], score)
	else:
		save["score1"] = score
	save_to_file()
