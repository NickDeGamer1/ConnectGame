extends CharacterBody2D

@export var target : Node2D
var nav_agent : NavigationAgent2D
var nav_agent_radius = 50.0
@export var max_velocity := 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nav_agent = NavigationAgent2D.new()
	add_child(nav_agent)
	nav_agent.target_desired_distance = nav_agent_radius
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	retarget(target)
	pass


func retarget(thing:Node2D=target):
	target = thing
	if nav_agent != null and target != null:
		nav_agent.target_position = target.position
	else:
		print("thing not found? NPC lost.")


func _physics_process(delta):
	if nav_agent.is_target_reached():
		target = null
	
	if target == null or self.get_tree() != target.get_tree():
		print("Oh no!")
		return
	
	var direction = nav_agent.get_next_path_position() - self.position
	self.velocity = direction.normalized() * max_velocity
	print("velocity = ", velocity)
	move_and_slide()
