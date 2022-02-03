extends Sprite
class_name Pucca


enum PuccaType {
	PUCCA,
	NEGA_PUCCA,
}

signal cliked(pucca_type)

onready var limit_nw: Position2D = $Limits/LimitNW
onready var limit_ne: Position2D = $Limits/LimitNE
onready var limit_se: Position2D = $Limits/LimitSE
onready var limit_sw: Position2D = $Limits/LimitSW

onready var circle: Area2D = $Circle

onready var explosion_player: AnimationPlayer = $ExplosionPlayer

export var pucca_type := PuccaType.PUCCA


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func set_click(clickable: bool) -> void:
	circle.clickable = clickable


func move_random():
	position.x = rand_range(limit_nw.position.x, limit_ne.position.x)
	position.y = rand_range(limit_nw.position.y, limit_sw.position.y)


func kill_pucca():
	var puccas: Array = get_tree().get_nodes_in_group("pucca")
	for pucca in puccas:
		pucca.set_click(false)
	emit_signal("cliked", pucca_type)
	explosion_player.play("Explode")
	yield(explosion_player, "animation_finished")
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


func _on_Circle_clicked() -> void:
	kill_pucca()
