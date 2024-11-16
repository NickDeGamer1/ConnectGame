extends Prop

func _init() -> void:
	max_health = 15

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("L"):
		_on_area_entered(null)
		print(health)
		
func _on_area_entered(area: Area2D) -> void:
	#if area.name.contains("resource tool"):
	if health <= 0:
		return
	health -= 20  #area.dmg
	CheckHealth()


func addResource():
	PlayerShared.ResourceWood += 1
	print(PlayerShared.ResourceWood)
