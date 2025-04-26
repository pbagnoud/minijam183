extends PathFollow2D


@export var runspeed = 250
@onready var character_body_2d: CharacterBody2D = $CharacterBody2D
@export var color=0

func _ready() -> void:
	character_body_2d.color = color 

func next_position(futur):
	return position


func _process(delta: float) -> void:
		set_progress(progress + runspeed * delta)
		
		if progress_ratio == 1:
			queue_free()

	
	
