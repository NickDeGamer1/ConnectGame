extends Node2D

# References
@export var enemy_scene := preload("res://enemy.tscn")
@onready var tile_map: Node2D = self.find_child("TileMap")
@onready var tilelayer1 : TileMapLayer = tile_map.find_child("*Layer")

# Variables
var night_counter = 0
var enemies_spawned = []
var base_health = 100
var base_speed = 90
var base_spawn_count = 3

func _ready():
	# Connect to the day-night cycle
	DayCycle.period_changed.connect(_on_period_changed)

func _on_period_changed(new_period: int):
	if new_period == DayCycle.TimeOfDay.NIGHT:
		_spawn_enemies()
	elif new_period == DayCycle.TimeOfDay.DAY:
		_clear_enemies()

func _spawn_enemies():
	# Increment the night counter for scaling
	night_counter += 1

	# Calculate scaled properties
	var scaled_health = base_health + night_counter * 20
	var scaled_speed = base_speed + night_counter * 5
	var spawn_count = base_spawn_count + night_counter

	# spawn area 
	var spawn_min = Vector2(-11, -9)
	var spawn_max = Vector2(36, 21)

	# Calculate the edges of the rectangle
	var left_edge = spawn_min.x
	var right_edge = spawn_max.x
	var top_edge = spawn_min.y
	var bottom_edge = spawn_max.y

	# Spawn enemies along the edges
	for i in range(spawn_count):
		var enemy_instance = enemy_scene.instantiate()

		# Randomly pick an edge to spawn on
		var edge = randi() % 4
		match edge:
			0: 
				# Top edge
				enemy_instance.global_position = $SpawnN.global_position#tilelayer1.map_to_local(Vector2(randi_range(left_edge, right_edge), top_edge))
			1: 
				# Right edge
				enemy_instance.global_position = $SpawnE.global_position#tilelayer1.map_to_local(Vector2(right_edge, randi_range(top_edge, bottom_edge)))
			2: 
				# Bottom edge
				enemy_instance.global_position = $SpawnS.global_position#tilelayer1.map_to_local(Vector2(randi_range(left_edge, right_edge), bottom_edge))
			3: 
				# Left edge
				enemy_instance.global_position = $SpawnW.global_position#tilelayer1.map_to_local(Vector2(left_edge, randi_range(top_edge, bottom_edge)))

		# Set the scaled health and speed
		enemy_instance.health = scaled_health
		enemy_instance.speed = scaled_speed

		# Add to the scene and track spawned enemies
		add_child(enemy_instance)
		enemies_spawned.append(enemy_instance)

	# Debug output
	print("Spawned", spawn_count, "enemies with health:", scaled_health, "and speed:", scaled_speed)

func _clear_enemies():
	# Remove all spawned enemies from the scene
	for enemy in enemies_spawned:
		if enemy:
			enemy.queue_free()
	enemies_spawned.clear()
# r
