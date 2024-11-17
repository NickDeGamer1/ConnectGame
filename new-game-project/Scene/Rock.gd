extends Prop

func _on_area_entered(area: Area2D) -> void:
	if area.name.contains("Weapon"):
		if health <= 0:
			return
		health -= 20  #area.dmg
		CheckHealth()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("K"):
		_on_area_entered(null)
		print(health)


func addResource():
	PlayerShared.ResourceStone += 1
	print(PlayerShared.ResourceStone)
