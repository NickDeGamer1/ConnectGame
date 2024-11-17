extends CharacterBody2D
class_name Player

@export var Speed = 500
@export var Health = 150
enum PNum {KBM, C1, C2, C3, C4, ONL}#Enums
@export var ConType: PNum
enum WNum {Sword, Spear, Ax, Bow}
@export var WepType: WNum
var WhatConToUse:String = "PC"
var WepPath:String = "res://Scene/Sword.tscn"
var AnimPlay:bool = false
@onready var PosBuff = global_position
@onready var Cam = get_node("../Camera2D")
var LastPos:Vector2 = Vector2(0,0)
var Alive:bool = true

func _ready() -> void:
	
	UpdateCon(ConType)
	var Rand = RandomNumberGenerator.new()
	UpdateWep(Rand.randi_range(0,3))

func UpdateCon(CT):
	ConType = CT
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

func UpdateWep(WT):
	WepType = WT
	match WepType:
		0:
			WepPath = "res://Scene/Sword.tscn"
		1:
			WepPath = "res://Scene/Spear.tscn"
		2:
			WepPath = "res://Scene/Ax.tscn"
		_:
			WepPath = "res://Scene/Bow.tscn"
	var Wep = load(WepPath)
	$Weapon/ResourceTool/WeaponPos.add_child(Wep.instantiate())

func _physics_process(_delta: float) -> void:
	
	UpdateHealth()
	
	if Alive:
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
			
			$EyeHolder/Eyes.centered = false
			$Weapon.rotation =  atan2(CY, CX)
		
		
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
		
		
		if Input.is_action_pressed("Weapon" + WhatConToUse):
			$Weapon/ResourceTool/WeaponPos/Weapon.use()
		
		
		$EyeHolder/Eyes.Update(rad_to_deg($Weapon.rotation) + 90)
		
		if $AnimatedSprite2D.frame % 2 != 0:
			$EyeHolder.position.y = -2
		else:
			$EyeHolder.position.y = 0
		
		
		if Input.is_action_pressed("Move_down" + WhatConToUse) and Input.is_action_pressed("Move_up" + WhatConToUse) and Input.is_action_pressed("Move_left" + WhatConToUse) and Input.is_action_pressed("Move_right" + WhatConToUse):
			$AnimatedSprite2D.play(WhatConToUse)
		
		
		if ConType != 5:# and !$ShapeCast2D.is_colliding():
				#Movement
			if Input.is_action_pressed("Move_down" + WhatConToUse):
				velocity = Vector2(0,Speed)
				move_and_slide()
			if Input.is_action_pressed("Move_up" + WhatConToUse):
				velocity = Vector2(0,-Speed)
				move_and_slide()
			if Input.is_action_pressed("Move_left" + WhatConToUse):
				velocity = Vector2(-Speed,0)
				move_and_slide()
			if Input.is_action_pressed("Move_right" + WhatConToUse):
				velocity = Vector2(Speed,0)
				move_and_slide()
				
				if Input.is_action_pressed("Weapon" + WhatConToUse):
					$Weapon/ResourceTool/WeaponPos/Weapon.use()
			
	else:
		$AnimatedSprite2D.rotation = PI/2
		$AnimatedSprite2D.stop()
		$EyeHolder.visible = false

func UpdateHealth():
	$ProgressBar.value = Health
	if Health > 100:
		$ProgressBar.theme = load("res://themes/ThemeGood.tres")
	elif Health > 50:
		$ProgressBar.theme = load("res://themes/ThemeOK.tres")
	else:
		$ProgressBar.theme = load("res://themes/ThemeBad.tres")
