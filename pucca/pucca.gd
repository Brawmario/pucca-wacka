extends Sprite2D
class_name Pucca


enum PuccaType {
	PUCCA,
	NEGA_PUCCA,
}

signal cliked()

@export var pucca_type: PuccaType = PuccaType.PUCCA

@onready var limit_nw: Marker2D = $Limits/LimitNW
@onready var limit_ne: Marker2D = $Limits/LimitNE
@onready var limit_se: Marker2D = $Limits/LimitSE
@onready var limit_sw: Marker2D = $Limits/LimitSW

@onready var circle: Area2D = $Circle

@onready var explosion_player: AnimationPlayer = $ExplosionPlayer
@onready var pucca_audio_stream_player: AudioStreamPlayer = $PuccaAudioStreamPlayer


func set_click(clickable: bool) -> void:
	circle.clickable = clickable


func move_random():
	position.x = randf_range(limit_nw.position.x, limit_ne.position.x)
	position.y = randf_range(limit_nw.position.y, limit_sw.position.y)


func kill_pucca():
	var puccas: Array = get_tree().get_nodes_in_group("pucca")
	for pucca in puccas:
		pucca.set_click(false)
	cliked.emit()
	pucca_audio_stream_player.pitch_scale = randf_range(0.8, 1.2)
	explosion_player.play("Explode")
	await explosion_player.animation_finished
	for pucca in puccas:
		pucca.move_random()
		pucca.set_click(true)


func start_game() -> void:
	visible = true
	set_click(true)
	move_random()


func end_game() -> void:
	visible = false
	set_click(false)


func _on_circle_clicked() -> void:
	kill_pucca()
