extends Area2D

@export var Speed = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += cos(global_rotation) * Speed
	position.y += sin(global_rotation) * Speed

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
