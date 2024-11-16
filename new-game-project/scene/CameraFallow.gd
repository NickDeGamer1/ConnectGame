extends Camera2D

@onready var Players = get_tree().get_nodes_in_group("Players")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	var AvgX = 0
	var AvgY = 0
	
	for i in Players:
		AvgX += i.global_position.x
		AvgY += i.global_position.y
		
	if Players.size() > 0:
		global_position = Vector2(AvgX/Players.size(), AvgY/Players.size())
