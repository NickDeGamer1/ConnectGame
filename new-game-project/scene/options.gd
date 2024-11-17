extends Control


func _ready() -> void:
	$CenterContainer/HBoxContainer/CheckBox.button_pressed = Options.IncludeKBM
	$CenterContainer/HBoxContainer/SpinBox.value = Options.numPLayers

func _on_check_box_toggled(toggled_on: bool) -> void:
	Options.IncludeKBM = toggled_on
	if toggled_on:
		$CenterContainer/HBoxContainer/SpinBox.max_value = 5
	else:
		$CenterContainer/HBoxContainer/SpinBox.max_value = 4


func _on_spin_box_value_changed(value: float) -> void:
	Options.numPLayers = value


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://title_screen.tscn")
