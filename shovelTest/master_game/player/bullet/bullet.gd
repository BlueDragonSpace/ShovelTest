extends Area2D

@onready var sound = $Boom
@onready var Art = $Art

@export var SPD = 200.0

var dir = Vector2(0,0)

func _ready() -> void:
	dir = Vector2.RIGHT.rotated(rotation)

func _process(delta: float) -> void:
	position += dir * SPD * delta

func _on_body_entered(body:Node2D) -> void:
	body.take_hit()
	body.blow_up()
	sound.play()
	Art.visible = false

func _on_boom_finished() -> void:
	queue_free()
