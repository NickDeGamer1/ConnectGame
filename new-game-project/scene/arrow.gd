extends Area2D


@export var Damage = 20
@export var damage_amount := 20

@export var Speed = 12

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += cos(global_rotation) * Speed
	position.y += sin(global_rotation) * Speed

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	queue_free()
