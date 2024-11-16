extends Node2D

func use():
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("Fire")
		var A = load("res://Scenes/arrow.tscn")
		var Ar = A.instantiate()
		$"../../../../..".add_child(Ar)
		Ar.global_rotation = global_rotation
		Ar.global_position = global_position