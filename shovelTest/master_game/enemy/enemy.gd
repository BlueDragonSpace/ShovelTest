extends CharacterBody2D

@export var placeholder_art = false
@export var speed : float = 1.0 # 1x speed, increased in spawn based on time
@export var enemy_type = "basic" #I think this is what enums are for, lol never got a formal education on programming
# comes in flavors of basic, bigBoi, and curve

var hp = 1

@onready var art = $art

func _ready():

	#choose a random side for enemy to spawn
	match(randi_range(0,3)):
		0:
			position.x = randf_range(-600,600)
			position.y = -600
		1:
			position.x = randf_range(-600,600)
			position.y = 600
		2:
			position.y = randf_range(-600,600)
			position.x = -600
		3:
			position.y  = randf_range(-600,600)
			position.x = 600

	#depending on angle to player, rotate the enemy (player is at the center))
	var angle = (atan2(position.y, position.x ))
	
	rotation = angle
	
	var move_speed = randi_range(int(speed * 75), int(speed * 150)) #moves between 75% and 150% of the base speed #base speed being 100, as these aren't decimals or properly formatted...

	match(enemy_type):
		"basic":
			hp = randi_range(1, 2)
			velocity = Vector2(-cos(angle), -sin(angle)) * move_speed
		"bigBoi":
			hp = randi_range(2, 4)
			velocity = Vector2(-cos(angle), -sin(angle)) * move_speed * 0.25
			scale = Vector2(1.5, 1.5) #make the enemy bigger
			art.modulate = Color(1, 0.5, 0.5) #change the color to red
		"curve":
			velocity = Vector2(-cos(angle), -sin(angle)) * move_speed * 0.5
			art.modulate = Color(0.5, 0.5, 1) #change the color to blue

func _physics_process(delta):

	#move_and_slide uses velocity and delta internally, and it also controls any collisions
	if not enemy_type == "curve":
		move_and_slide()
	else:
		position += velocity * delta
	
	if position.x < -800 or position.x > 800 or position.y < -800 or position.y > 800:
		queue_free() #if the enemy is out of bounds, remove it from the scene tree
