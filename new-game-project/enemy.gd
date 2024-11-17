extends CharacterBody2D

# Constants
const SPEED = 20
const ATTACK_RANGE = 32
const ATTACK_COOLDOWN = 1.0
const ATTACK_DAMAGE = 25

# References
@export var oakley: Node2D
@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D
@onready var animated_sprite := $AnimatedSprite2D
@onready var hitbox_area := $OrcHitboxArea

# Variables
var attack_timer = 0.0
var attacking = false

const damage_cooldown_reset := 0.25
var damage_cooldown = 0.0

# Health and speed
var health = 100  # Default health value
var speed = SPEED  # Speed of the enemy

func _ready():
	hitbox_area.connect("body_entered", Callable(self, "_on_body_entered"))
	make_path_to_oakley()

func _process(delta: float) -> void:
	if player == null:
		_reassign_player()
	if oakley == null:
		_reassign_oakley()
	pass
	
	if damage_cooldown > 0:
		damage_cooldown -= delta


func _reassign_player():
	var players = get_tree().get_nodes_in_group("Players")
	var test_pos = Vector2(-9999,-9999)
	if players.size() > 0:
		for _player in players:
			if (_player as Player).global_position.distance_squared_to( self.global_position ) < test_pos.distance_squared_to(self.global_position):
				test_pos = _player
				player = _player


func _reassign_oakley():
	var oaks = get_tree().get_nodes_in_group("Oakley")
	var test_pos = Vector2(-9999,-9999)
	if oaks.size() > 0:
		for oak in oaks:
			if oak.global_position.distance_squared_to( self.global_position ) < test_pos.distance_squared_to(self.global_position):
				test_pos = oak
				oakley = oak


func _physics_process(delta: float):
	# Pathfinding
	if player and player.position.distance_to(global_position) < ATTACK_RANGE:
		make_path_to_player()
	else:
		make_path_to_oakley()

	# Move towards the target
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()

	# Attack cooldown
	if attack_timer > 0:
		attack_timer -= delta

	# Update the animation state based on movement or attack
	update_animation(dir)

func make_path_to_oakley():
	if oakley == null:
		print("no path to Oakley")
		return
	nav_agent.target_position = oakley.global_position

func make_path_to_player():
	if player == null:
		print("no path to Player")
		return
	nav_agent.target_position = player.global_position

func update_animation(dir: Vector2):
	# Switch between idle, walking, and attacking animations
	if attacking:
		animated_sprite.play("orc_attack")
	elif dir.length() > 0:
		animated_sprite.play("orc_walk")
	else:
		animated_sprite.play("orc_idle")

func _on_body_entered(body: Node2D):
	# Check if the body is a player, oakley, or a wall
	if body.name.to_lower().contains("player") or body.name.to_lower().contains("oakley") or body.name.to_lower().contains("wall"):
		apply_damage_to_body(body)
	if body.is_in_group("Weapon") and damage_cooldown <= 0.0:
		damage_cooldown = damage_cooldown_reset
		health -= body.damage_amount

func apply_damage_to_body(body: Node2D):
	# Apply damage to the body
	if body.has_method("apply_damage"):
		body.apply_damage(ATTACK_DAMAGE)
