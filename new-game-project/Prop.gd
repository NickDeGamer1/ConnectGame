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
	DayCycle.period_changed.connect(_on_period_changed)


func addResource():
	print("Prop.gd has no resource! overwrite me!")

func _on_period_changed(period):
	match period:
		DayCycle.TimeOfDay.DAY:
			restore()
		_:
			pass
	pass


func restore():
	visible = true
	health = max_health
