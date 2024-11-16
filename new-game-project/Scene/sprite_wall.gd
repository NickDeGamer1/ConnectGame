class_name Object_Health
extends Sprite2D

signal max_health_changed(diff: int)
signal health_depleted
signal health_changed(diff: int)

@export var max_health: int = 3
