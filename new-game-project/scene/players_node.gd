extends Node2D

var Scene = "res://Scene/player.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var i = 0
	while i < Options.numPLayers:
		var Pla = load(Scene)
		var Child = Pla.instantiate()
		add_child(Child)
		Child.name = "Player" + str(i)
		if Options.IncludeKBM:
			Child.UpdateCon(i)
		else:
			Child.UpdateCon(i + 1)
		Child.add_to_group("Players")
		i+=1
