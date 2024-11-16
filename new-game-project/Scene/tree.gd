extends Area2D

@export var health:int = 15


func _on_area_entered(area: Area2D) -> void:
	#if area.name.contains("resource tool"):
	health -= 20  #area.dmg
	CheckHealth()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("L"):
		_on_area_entered(null)
		print(health)
		

func CheckHealth():
	if health <= 0:
		queue_free()
