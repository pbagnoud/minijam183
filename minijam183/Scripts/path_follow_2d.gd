extends PathFollow2D

@export var runspeed = 250

func _process(delta: float) -> void:
		set_progress(progress + runspeed * delta)
		
		if progress_ratio == 1:
			queue_free()
