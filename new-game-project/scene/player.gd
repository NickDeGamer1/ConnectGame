extends Area2D

@export var Speed = 10

func _physics_process(delta: float) -> void:
	
	var MP = get_viewport().get_mouse_position()
	
	$Weapon.rotation =  atan2(MP.y - global_position.y, MP.x - global_position.x)
	
	if Input.is_action_pressed("Move_downPC"):
		position.y+=Speed
	if Input.is_action_pressed("Move_upPC"):
		position.y-=Speed
	if Input.is_action_pressed("Move_leftPC"):
		position.x-=Speed
	if Input.is_action_pressed("Move_rightPC"):
		position.x+=Speed
	
	
	#$Weapon/Sprite2D2.global_rotation = 0
	
