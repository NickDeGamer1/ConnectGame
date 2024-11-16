extends Node

@export var health_max = 10
@export var health = health_max

signal recovered_health(heal:float)
signal took_damage(damage:float)

"""
	Use this function for healing/damage applied to players.
	This will be redirected to the relevant function
	Those can also be used, but like...
"""
func apply_health_change( delta:float ):
	
	## If delta is 0, there's no point in sending a signal.
	if is_zero_approx(delta):
		return
	## If delta is negative, take damage.
	elif delta < 0:
		_apply_damage( abs(delta) )
	else:
		_apply_healing( delta )


func _apply_damage( damage:float ):
	health -= damage
	took_damage.emit(damage)


func _apply_healing( heal:float ):
	health += heal
	recovered_health.emit(heal)
