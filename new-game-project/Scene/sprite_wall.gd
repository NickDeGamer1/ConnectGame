class_name Object_Health
extends Node

signal max_health_changed(diff: int)
signal health_depleted
signal health_changed(diff: int)

@export var max_health: int = 3
@onready var health:int = max_health

func object_damage(dmg):
	health -= dmg
	if health <= 0:
		health = 0
		if health == 0:
			health_depleted.emit()

func set_max_health(value: int):
	var clamped_value = 1 if value <= 0 else value
	
	if not clamped_value == max_health:
		var difference = clamped_value - max_health
		max_health = value
		max_health_changed.emit(difference)
		
		if  health > max_health:
			health = max_health

func get_max_health() -> int:
	return max_health

func set_health(value:int):
	if value < health:
		return
	
	var clamped_value = clampi(value, 0, max_health)
	
	#if 

func get_health() -> int:
	return health
