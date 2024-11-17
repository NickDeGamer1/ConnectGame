extends StaticBody2D
@export var max_health:int = 50
@export var health := 50


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		health -= 20  #area.dmg
		CheckHealth()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("the j"):
		_on_area_entered(null)
		print(health)
		

func CheckHealth():
	if health <= 0:
		queue_free()
		
func restore():
	$TileMapLayer.visible = true
	$CollisionShape2D.set_deferred("disabled", false)#.disabled = false
	health = max_health

func build_Wall():
	if PlayerShared.ResourceWood >= 3 or PlayerShared.ResourceStone >= 3:
		restore()
		if PlayerShared.ResourceWood >= 3:
			PlayerShared.ResourceWood -= 3
		else:
			PlayerShared.ResourceStone -= 3
