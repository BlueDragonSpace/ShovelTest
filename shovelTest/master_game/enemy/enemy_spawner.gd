extends Node2D

# # hi lol
# # In here, I control the enemy spawn patterns

# ENEMY VARIABLESSSSSsss
var time = 0
@export var spawn_rate = 3 # seconds between spawns, decreases over time
@export var decay_rate = 0.8 # how much to decrease the spawn rate by each time

var cycle_spawns = 0 #how many spawns in this cycle
var total_cycle_spawns = 5 #how many spawns for this cycle total

var spawn_rate_decimals = 0 #how many decimal places to round the time to for spawning
var has_spawned = false #has spawned during the spawn rate (not related to cycle)
var has_spawned_disable_time = 0 #the next time spawn can happen 

var ENEMY = preload("res://master_game/enemy/enemy.tscn")

@onready var CurveNode = $Curves

func spawn_enemy():
	var enemy_instance = ENEMY.instantiate() #initializes in code

	enemy_instance.speed = 1/(spawn_rate/5.0)  # Adjust speed based on spawn rate
	match (randi_range(0, 2)): # Randomly choose an enemy type
		0:
			enemy_instance.enemy_type = "basic"
			add_child(enemy_instance)# Add the enemy to the scene tree
		1:
			enemy_instance.enemy_type = "bigBoi"
			add_child(enemy_instance)# Add the enemy to the scene tree
		2:
			enemy_instance.enemy_type = "curve"
			CurveNode.add_child(enemy_instance) # Add the enemy to the CurveNode



	

func round_to_decimal_places(value: float, places: int) -> float:
	var factor = pow(10, places)
	return round(value * factor) / factor

	# round(time * 10) / 10.0 Rounds to 1 decimal place, for reference

func _process(delta: float) -> void:

	time += delta

	# Check if it's time to spawn a new enemy
	if not has_spawned:  
		spawn_enemy()
		has_spawned = true
		has_spawned_disable_time = time + spawn_rate # Set the next time spawn can happen

		print("Enemy spawned at time: ", time)

		cycle_spawns += 1

		if (cycle_spawns >= total_cycle_spawns):

			total_cycle_spawns += ceil(cycle_spawns / 5.0)

			cycle_spawns = 0

			# Reset the spawn rate to its initial value after a cycle
			spawn_rate *= decay_rate

			#Recalculate decimals of precision needed for spawn_enemy if statement
			
			var spawn_rate_str = str(spawn_rate)
			spawn_rate_decimals = 0
			if "." in spawn_rate_str:
				spawn_rate_decimals = spawn_rate_str.split(".")[1].length()

			# print("Spawn rate decimal places: ", spawn_rate_decimals)

			print("Spawn rate: ", spawn_rate)
	else:
		if time >= has_spawned_disable_time:
			has_spawned = false

	CurveNode.rotation += 0.01

#discarded code below

# #ENEMY VARIABLESSSSSSSSS


# func _process(delta: float) -> void:

# 	time += delta

# 	### lol I should explain
# 	# For everyone under 18, GitHub offers free Copilot (along with a whole lot of other cool stuff) for free for all students.
# 	# It's called the GitHub Student Developer Pack

# 	# I could probably figure out how to do this without Copilot, but it's far easier with its aid.
# 	# (I also checked its cool by Shovel to be using AI assistance, but only for code)

# 	#fmod is the same thing as the % operator, but for floats instead of integers
# 	if fmod(round_to_decimal_places(time, decimal_places), spawn_rate) == 0:
		
# 		spawn_enemy()
	
# 	if fmod(round_to_decimal_places(time,decimal_places), spawn_rate * 10):
# 		spawn_rate *= 0.9

# 		# Recalculate decimals of precision needed for spawn_enemy if statement
# 		# Get the number of decimal places in spawn_rate
# 		var spawn_rate_str = str(spawn_rate)
# 		decimal_places = 0
# 		if "." in spawn_rate_str:
# 			decimal_places = spawn_rate_str.split(".")[1].length()
# 		print("Spawn rate decimal places: ", decimal_places)



# func round_to_decimal_places(value: float, places: int) -> float:
# 	var factor = pow(10, places)
# 	return round(value * factor) / factor

# 	#time = round(time * 10) / 10.0
# 	# The above would round to 2 decimal places, as an example
