extends Area2D
class_name Prop


@export var health:int = 25
@export var ResourceStone:int = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func CheckHealth():
	if health <= 0:
		queue_free()
		addResource()

func addResource():
	print("eek! no resource! overwrite me!")
