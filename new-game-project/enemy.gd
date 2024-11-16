extends CharacterBody2D

# Speed and other variables
const speed = 20  # Speed of enemy
const attack_range = 32  # The range which the enemy can attack players, oakley, or walls
const player_detection_radius = 150  # The radius in which the enemy will switch to attacking the player
const attack_cooldown = 1.0  # Cooldown time between attacks (in secs)

# Not currently added
@export var oakley: Node2D  # Oakley's node
@export var player: Node2D  # Player node

# References the nav agent for pathfinding
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

# Variable to manage attack cooldown time
var attack_timer = 0.0  # Time remaining on the attack cooldown

# Called when the enemy is initialized
func _ready() -> void:
	# Initially set the path to Oakley
	make_path_to_oakley()

# Called every frame to handle movement and attacks
func _physics_process(delta: float) -> void:
	# Check if the player is within detection radius
	if player.position.distance_to(global_position) < player_detection_radius:
		# If the player is close enough, pathfind towards the player
		make_path_to_player()
	else:
		# Else, pathfind towards Oakley
		make_path_to_oakley()

	# Get the next position in the path and move towards it
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed 
	move_and_slide()

	# Attack cooldown decreasing
	if attack_timer > 0:
		attack_timer -= delta

	# Check if the enemy should attack (collide with players, oakley, or walls)
	check_for_attack()

# Makes the enemy pathfind towards Oakley
func make_path_to_oakley() -> void:
	# Set Oakley as the target to pathfind towards
	nav_agent.target_position = oakley.global_position

# Makes the enemy pathfind towards the player
func make_path_to_player() -> void:
	# Set the player's position as the target for pathfinding
	nav_agent.target_position = player.global_position

# Check if the enemy is colliding with a player, oakley, wall, or anything else in the attack range
func check_for_attack() -> void:
	# If attack cooldown is finished
	if attack_timer <= 0:
		# Check if Oakley is within attack range
		if global_position.distance_to(oakley.global_position) <= attack_range:
			# Apply damage to Oakley if within range
			oakley.apply_damage(10)  # Call a method to damage Oakley
			attack_timer = attack_cooldown  # Reset attack timer after attacking

		# Check for overlapping bodies in attack area
		var attack_area = get_node("AttackArea")  # Assuming there's an AttackArea node as a child of the enemy
		var overlapping_bodies = attack_area.get_overlapping_bodies()  # Get all entities inside the attack area
		
		# Loop through all overlapping entities to see if it's a player or wall
		for body in overlapping_bodies:
			# If it's a player, apply damage to them
			if body.is_in_group("players"):  # Check if the body is in the players group
				# Apply damage (adjustable)
				body.apply_damage(103)  # Call a method to apply damage to the player
				attack_timer = attack_cooldown

			# If it's a wall, apply damage to the wall
			elif body.is_in_group("walls"):  # Check if the body is in the walls group
				# Apply damage to the wall (also adjustable)
				body.apply_damage(53912)  # Call a method to apply damage to the wall
				attack_timer = attack_cooldown

# Handle the collision detection when the enemy enters another player, oakley, or wall
func _on_body_entered(body: Node2D) -> void:
	# When the enemy collides with another body, check what it is
	if body.is_in_group("players"):  # If the enemy collides with a player
		# Apply damage to the player on collision (this is direct contact)
		body.apply_damage(10)
	elif body.is_in_group("walls"):  # If the enemy collides with a wall
		# Apply damage to the wall on collision (optional)
		body.apply_damage(5)
	elif body == oakley:  # If the enemy collides with Oakley
		# Apply damage to Oakley on collision
		oakley.apply_damage(10)
