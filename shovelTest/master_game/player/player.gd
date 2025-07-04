extends Area2D

@onready var art = $Yoshi #change to real art later

func _ready() -> void:
	GlobalVars.connect("call_restart", _on_restart)

func _on_body_entered(body:Node2D) -> void:
	take_hit()
	print(body.name)

func take_hit():
	GlobalVars.player_hit()
	art.modulate = Color(1, 0.5, 0.5, 1.0) #change the color to red

func _on_restart():
	art.modulate = Color(1, 1, 1, 1) #reset color
