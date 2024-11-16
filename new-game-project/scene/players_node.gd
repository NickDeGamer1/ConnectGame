extends Node2D

var Scene = "res://scene/player.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var i = 0
	while i < Options.numPLayers:
		var Pla = load(Scene)
		var Child = Pla.instantiate()
		add_child(Child)
		Child.name = "Player" + str(i)
		if Options.IncludeKBM:
			Child.ConType = i
		else:
			Child.ConType = i + 1
		i+=1
