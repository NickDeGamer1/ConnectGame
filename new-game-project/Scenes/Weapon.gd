extends Node2D

@export var Damage = 10

func use():
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("Swing")