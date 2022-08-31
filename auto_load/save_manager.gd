extends Node

const SAVE_PATH := "user://save.json"

const MAIN_SCORE := "score1"

var save := {}


func _ready() -> void:
	load_save()


func load_save() -> void:
	var save_file := File.new()
	if not save_file.file_exists(SAVE_PATH):
		return
	save_file.open(SAVE_PATH, File.READ)
	var json := JSON.new()
	var err := json.parse(save_file.get_as_text())
	if err == OK:
		save = json.get_data()
	save_file.close()


func save_to_file() -> void:
	var save_file := File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	save_file.store_string(JSON.stringify(save, "\t"))
	save_file.close()

func clear_save() -> void:
	save.clear()
	save_to_file()

func save_high_score(score: int) -> void:
	if save.has(MAIN_SCORE):
		save[MAIN_SCORE] = max(save[MAIN_SCORE], score)
	else:
		save[MAIN_SCORE] = score
	save_to_file()
