extends Node2D

var centered:bool = false

func Update(Dir):
	if !centered:
		if Dir >= 0 and Dir <= 180:
			$LeftEye.flip_h = false
			$RightEye.flip_h = false
		else:
			$LeftEye.flip_h = true
			$RightEye.flip_h = true
			
		
		if Dir > 90 and Dir <= 270:
			position.y = 2
		else:
			position.y = 0
	else:
		$LeftEye.flip_h = false
		$RightEye.flip_h = true
	
