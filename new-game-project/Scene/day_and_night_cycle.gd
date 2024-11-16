extends CanvasModulate

@onready var anim_player = self.find_child("AnimationPlayer") as AnimationPlayer

func _ready() -> void:
	DayCycle.period_changed.connect(whatever)
	DayCycle._start()


func whatever(period):
	match period:
		DayCycle.TimeOfDay.DAY:
			pass
		DayCycle.TimeOfDay.DUSK:
			anim_player.play("Day to Night")
			pass
		DayCycle.TimeOfDay.NIGHT:
			pass
		DayCycle.TimeOfDay.DAWN:
			anim_player.play("Night to Day")
			pass
		_:
			pass
	pass
