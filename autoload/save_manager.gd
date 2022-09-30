extends Node


const SAVE_PATH := "user://save.json"
const MAIN_SCORE := "score1"

var save := {}


func _ready() -> void:
	load_save()


func load_save() -> void:
	var save_file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not save_file:
		if FileAccess.get_open_error() != ERR_FILE_NOT_FOUND:
			push_warning("Failed to open save file for reading")
		return

	var data = JSON.parse_string(save_file.get_as_text())
	if data:
		if typeof(data) == TYPE_DICTIONARY:
			save = data
		else:
			push_warning("Save JSON wasn't a valid dictionary")
	else:
		push_warning("Failed to parse save JSON")


func save_to_file() -> void:
	var save_file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if not save_file:
		push_warning("Failed to open save file for writing")
		return
	save_file.store_string(JSON.stringify(save, "\t"))


func clear_save() -> void:
	save.clear()
	save_to_file()


func save_high_score(score: int) -> void:
	if save.has(MAIN_SCORE):
		save[MAIN_SCORE] = max(save[MAIN_SCORE], score)
	else:
		save[MAIN_SCORE] = score
	save_to_file()
