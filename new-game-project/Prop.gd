extends Area2D
class_name Prop

@export var max_health := 25
@export var health:int = 25

func CheckHealth():
	if health <= 0:
		visible = false
		addResource()

func _ready() -> void:
	health = max_health

func addResource():
	print("Prop.gd has no resource! overwrite me!")

func restore():
	visible = true
	health = max_health