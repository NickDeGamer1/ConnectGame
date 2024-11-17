extends Control

func _on_title_pressed() -> void:
	get_tree().change_scene_to_file("res://title_screen.tscn")
