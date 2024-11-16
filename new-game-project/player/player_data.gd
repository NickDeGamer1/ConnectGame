extends Node

@export var health_max = 10
@export var health = health_max

signal recovered_health(heal:float)
signal took_damage(damage:float)

"""
	Use this function for all healing/damage applied to players.
	This will be redirected to the relevant function 
"""
func apply_health_change( delta:float ):
	if delta < 0:
		_apply_damage( abs(delta) )
	else:
		_apply_healing( delta )
	
	pass


func _apply_damage( damage:float ):
	health -= damage
	took_damage.emit(damage)


func _apply_healing( heal:float ):
	health += heal
	pass
