class_name Explosion
extends CPUParticles2D

@export var target_object: PackedScene
@export var base_velocity: = 100
@export var nb_particule: = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	one_shot = true
	emitting = false
	explosiveness = .8
	gravity.y = 0
	spread = 180
	initial_velocity_min = base_velocity
	initial_velocity_max = base_velocity * 2
	amount = nb_particule

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
