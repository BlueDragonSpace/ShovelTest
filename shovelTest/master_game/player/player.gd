extends Area2D

var can_shoot = true

@onready var art = $Art #change to real art later
@onready var bullet_holder: Node = $BulletHolder
@onready var Zap: AudioStreamPlayer = $Zap
@onready var ShotTimer: Timer = $ShotTimer

@onready var Death: AudioStreamPlayer = $Death


var Bullet = preload("res://master_game/player/bullet/bullet.tscn")

func _ready() -> void:
	GlobalVars.connect("call_restart", _on_restart)

func _on_body_entered(body:Node2D) -> void:
	take_hit()
	print(body.name)

func take_hit():
	GlobalVars.player_hit()
	Death.play()
	art.modulate = Color(1, 0.5, 0.5, 1.0) #change the color to red


func _on_restart():
	art.modulate = Color(1, 1, 1, 1) #reset color

	for child in bullet_holder.get_children():
		child.queue_free()

func _process(_delta: float) -> void:

	if GlobalVars.is_player_hit == false:

		#rotate towards mouse (since for some reason look_at() doesn't want to work)
		var mouse_position = get_global_mouse_position();
		var direction = (mouse_position  - self.position);
		direction = direction.normalized()
		var new_angle =  atan2(direction.y, direction.x)
		rotation = new_angle

		if Input.is_action_just_pressed("SHOOT") and can_shoot:
			var new_bullet = Bullet.instantiate()
			new_bullet.position = global_position + 32.0 * direction
			new_bullet.rotation = rotation
			bullet_holder.add_child(new_bullet)
			can_shoot = false
			ShotTimer.start()
			Zap.play()


func _on_shot_timer_timeout() -> void:
	can_shoot = true
