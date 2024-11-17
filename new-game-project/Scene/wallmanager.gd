extends Node

@onready var Walls = get_tree().get_nodes_in_group("Wall")
var i = 0

func UpdateWall():
	Walls[i].build_Wall()
	i+=1
	if i >= Walls.size():
		i=0
