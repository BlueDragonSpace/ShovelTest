extends CharacterBody2D

@onready var art = $art

var blowing_up = false
var hit_once = false #effectively has 2 hp, but only for player attack
var move_speed = 100 #base speed

@export var speed_modifier: float = randf_range(0.5, 1.25) # speed modifier

var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() # Random direction

func _ready() -> void:
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

func _process(delta: float) -> void:
    position += move_speed * direction * speed_modifier * delta

    if position.x < -800 or position.x > 800 or position.y < -800 or position.y > 800:
        queue_free() #if the asteroid is out of bounds, remove it from the scene tree

#collision layers: 1 = player, 2 = enemy, 3 = Player Attack, 6 = asteroid
#as a general rule, I let things that  do damage to another thing just decrease hp, and the reciever of the attack handles it's own queue_free among other effects

func _on_hitbox_body_entered(body: Node2D) -> void:
    match body.collision_layer:
        1: # Player
            GlobalVars.player_hit()
            blow_up()
            body.take_hit()
        2: # Enemy
            body.hp -= 1 # Decrease enemy HP
            blow_up()
            body.take_hit()
        3: # Player Attack
            if not hit_once:
                hit_once = true
                art.play("hit")
            else:
                blow_up()
                GlobalVars.SCORE += 50
        6: # Asteroid
            blow_up()
            body.blow_up() # Blow up the other asteroid
        

func blow_up() -> void:
    blowing_up = true
    art.play("blow_up") # Play the blow-up animation
    GlobalVars.SCORE += 50

func take_hit() -> void:
    pass
    #yeah lazy coding so what

func _on_art_animation_finished() -> void:
    if blowing_up:
        queue_free() # Free the asteroid instance
