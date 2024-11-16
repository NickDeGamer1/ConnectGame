extends CanvasModulate


func _ready() -> void:
	DayCycle.period_changed.connect(whatever)


func whatever(period):
	match period:
		DayCycle.TimeOfDay.DAY:
			pass
		DayCycle.TimeOfDay.DUSK:
			pass
		_:
			pass
	pass
