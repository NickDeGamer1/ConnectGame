extends Area2D

@export var Speed = 10
enum PNum {KBM, C1, C2, C3, C4, ONL}
@export var ConType: PNum
var WhatConToUse:String = "PC"

func _ready() -> void:
	match ConType:
		0:
			WhatConToUse = "PC"
		1:
			WhatConToUse = "C0"
		2:
			WhatConToUse = "C1"
		3:
			WhatConToUse = "C2"
		4:
			WhatConToUse = "C3"
		5:
			WhatConToUse = "ON"

func _physics_process(_delta: float) -> void:
	
	
	if ConType == 0:#On KBM
		var MP = get_viewport().get_mouse_position()
		$Weapon.rotation =  atan2(MP.y - global_position.y, MP.x - global_position.x)
	elif ConType != 5:#On cont
		var CX = Input.get_joy_axis(ConType-1, JOY_AXIS_RIGHT_X)
		var CY = Input.get_joy_axis(ConType-1, JOY_AXIS_RIGHT_Y)
		
		if abs(CX) > 0.2 and abs(CY) > 0.2:
			$Weapon.rotation =  atan2(CY, CX)
	
	if ConType != 5:
		#Movement
		if Input.is_action_pressed("Move_down" + WhatConToUse):
			position.y+=Speed
		if Input.is_action_pressed("Move_up" + WhatConToUse):
			position.y-=Speed
		if Input.is_action_pressed("Move_left" + WhatConToUse):
			position.x-=Speed
		if Input.is_action_pressed("Move_right" + WhatConToUse):
			position.x+=Speed
	
	
	#$Weapon/Sprite2D2.global_rotation = 0
	
