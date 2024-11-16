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
