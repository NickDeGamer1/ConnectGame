extends StaticBody2D
@export var health:int = 250

func _on_area_entered(area: Area2D) -> void:
	#if area.name.contains("monster"):
	health -= 20  #area.dmg
	CheckHealth()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("the j"):
		_on_area_entered(null)
		print(health)
		

func CheckHealth():
	if health <= 0:
		get_tree().change_scene_to_file("res://lose_screen.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		health -= 20  #area.dmg
		CheckHealth()
