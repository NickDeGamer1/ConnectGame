## This is an autoload!
extends Node



## This enum must not skip numbers! 
## It must start at index 0 and increment by 1!
enum TimeOfDay {
	DAY = 0,
	DUSK,
	NIGHT,
	DAWN,
}

const duration = {
	TimeOfDay.DAY : 20, #number is second counter
	TimeOfDay.DUSK : 40,
	TimeOfDay.NIGHT : 30,
	TimeOfDay.DAWN : 20,
}

var current_period := TimeOfDay.DAY
var timer := Timer.new()

signal period_changed(new_period:int)


func _start( period := TimeOfDay.DAY ):
	current_period = period
	
	timer.timeout.connect(_progress_period)
	add_child(timer)
	
	## Have the timer start on the current time period's duration
	timer.start( duration[current_period] ) 
	print("starting!")
	_start_period()


func _progress_period():
	current_period = (current_period + 1) % TimeOfDay.size()
	_start_period()


func _start_period():
	period_changed.emit(current_period)
	print("change to ", current_period)
