extends Area2D

@export var Speed = 10
enum PNum {KBM, C1, C2, C3, C4, ONL}
@export var ConType: PNum
enum WNum {Sword, Spear, Ax, Bow}
@export var WepType: WNum
var WhatConToUse:String = "PC"
var WepPath:String = "res://Scenes/Sword.tscn"
var AnimPlay:bool = false
@onready var PosBuff = global_position
@onready var Cam = get_node("../Camera2D")

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
	$AnimatedSprite2D.play(WhatConToUse)
	match WepType:
		0:
			WepPath = "res://Scenes/Sword.tscn"
		1:
			WepPath = "res://Scenes/Spear.tscn"
		2:
			WepPath = "res://Scenes/Ax.tscn"
		3:
			WepPath = "res://Scenes/Bow.tscn"
	var c1 = load(WepPath)
	$Weapon/Area2D/WeaponPos.add_child(c1.instantiate())

func _physics_process(_delta: float) -> void:
	if ConType == 0:#On KBM
		var MP
		if Cam != null:
			MP = (get_viewport().get_mouse_position() - Vector2(960,540) + Cam.global_position)
		else:
			MP = get_viewport().get_mouse_position()
		$Weapon.rotation =  atan2(MP.y - global_position.y, MP.x - global_position.x)
	elif ConType != 5:#On cont
		var CX = Input.get_joy_axis(ConType-1, JOY_AXIS_RIGHT_X)
		var CY = Input.get_joy_axis(ConType-1, JOY_AXIS_RIGHT_Y)
		
		
		
		#if abs(CX) > 0.2 and abs(CY) > 0.3:
		$EyeHolder/Eyes.centered = false
		$Weapon.rotation =  atan2(CY, CX)
		#else:
			#$EyeHolder/Eyes.centered = true
	
	
	$EyeHolder/Eyes.Update(rad_to_deg($Weapon.rotation) + 90)
	
	if $AnimatedSprite2D.frame % 2 != 0:
		$EyeHolder.position.y = -2
	else:
		$EyeHolder.position.y = 0
	
	if PosBuff != global_position:
		$AnimatedSprite2D.play(WhatConToUse)
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 0
	PosBuff = global_position
	
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
			
		
		if Input.is_action_pressed("Weapon" + WhatConToUse):
			$Weapon/Area2D/WeaponPos/Weapon.use()
	
	#$Weapon/Sprite2D2.global_rotation = 0
	
