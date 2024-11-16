## This is an autoload!
extends Node



## This enum must not skip numbers! 
## It must start at index 0 and increment by 1!
enum TimeOfDay {
	MORNING = 0,
	AFTERNOON,
	NIGHT,
	DAWN,
}

const duration = {
	TimeOfDay.MORNING : 2.5,
	TimeOfDay.AFTERNOON : 2.5,
	TimeOfDay.NIGHT : 2.5,
	TimeOfDay.DAWN : 1.5,
}

var current_period := TimeOfDay.MORNING
var timer := Timer.new()

signal period_changed(new_period:int)


func _start( period := TimeOfDay.MORNING ):
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
