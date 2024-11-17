extends Control

var player_index := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_down"):
		pass
	pass


func _churn_and_continue():
	
	
	player_index += 1
	if player_index > Player.PNum.size():
		_move_on()
	pass


## TODO: needs to do something!
func _move_on():
	pass
