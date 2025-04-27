extends PathFollow2D
signal new_virus(progress: float)

@export var runspeed = 250
@onready var character_body_2d: CharacterBody2D = $CharacterBody2D

var speed = runspeed
@export var color = 0

var pv = 1
		
var is_split:
	set(value): 
		is_split = value

const PATH_FOLLOW_2D = preload("res://Scenes/path_follow_2d.tscn")

func _init() -> void:
	pv = 1
	is_split = false


func _ready() -> void:
	character_body_2d.color = color
	character_body_2d.pv = pv  
	character_body_2d.is_split = is_split  
	if color == 1 :
		runspeed += 100

func set_pv(pv):
	character_body_2d.pv = pv  

func next_position(futur):
	var target = PathFollow2D.new()
	target.progress=progress+futur
	get_parent().add_child(target)
	return target.position


func _process(delta: float) -> void:
		set_progress(progress + speed * delta)
		
		if progress_ratio == 1:
			queue_free()

	
	


func _on_freeze(time) -> void:
	speed *=.8
	await get_tree().create_timer(time).timeout
	speed *= 1.25
	
func _on_push_back(amount):
	set_progress(progress - amount)
		


func _on_character_body_2d_split() -> void:
	var twin1 = PATH_FOLLOW_2D.instantiate()
	twin1.progress=progress-25
	twin1.color = 3
	twin1.is_split = true
	twin1.pv = 1
	twin1.scale = Vector2(0.7, 0.7)
	twin1.speed *= 0.6
	get_parent().add_child(twin1)
	var twin2 = PATH_FOLLOW_2D.instantiate()
	twin2.progress=progress+50
	twin2.color = 3
	twin2.is_split = true
	twin2.pv = 1
	twin2.scale = Vector2(0.7, 0.7)
	twin2.speed *= 0.6
	get_parent().add_child(twin2)
