extends CharacterBody2D

@export var target : Node2D
var nav_agent : NavigationAgent2D
@export var max_velocity := 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nav_agent = NavigationAgent2D.new()
	add_child(nav_agent)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func retarget(thing:Node2D=target):
	target = thing
	if nav_agent != null:
		nav_agent.target_position = target.position

func _physics_process(delta):
	if target == null or self.get_tree() != target.get_tree():
		return
	
	var direction = nav_agent.get_next_path_position()
	self.velocity = direction.normalized() * max_velocity
	move_and_slide()
