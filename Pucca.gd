extends Sprite

signal scored

onready var limit_nw: Position2D = get_node("../LimitNW")
onready var limit_ne: Position2D = get_node("../LimitNE")
onready var limit_se: Position2D = get_node("../LimitSE")
onready var limit_sw: Position2D = get_node("../LimitSW")


# Called when the node enters the scene tree for the first time.
func _ready():
	$Circle.clickable = true
	move_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func move_random():
	position.x = rand_range(limit_nw.position.x, limit_ne.position.x)
	position.y = rand_range(limit_nw.position.y, limit_sw.position.y)


func kill_pucca():
	$Circle.clickable = false
	emit_signal("scored")
	$ExplosionPlayer.play("Explode")
	yield($ExplosionPlayer, "animation_finished")
	move_random()
	$Circle.clickable = true


func _on_Circle_clicked() -> void:
	kill_pucca()
