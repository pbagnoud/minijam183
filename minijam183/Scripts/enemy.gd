extends CharacterBody2D

signal hit

@onready var enemy_sprite_2d: AnimatedSprite2D = $EnemySprite2D

var real_position: Vector2
var pv: int = 2
var color: int = 1:
	set(value):
		color=value
		change_color(value)

func _ready() -> void:
	change_color(color)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet") :
		if body.color == color:
			pv -= body.power * 2
		else:
			pv -= body.power
		body.hit_something()
		if body.has_color_change:
			change_color(body.color)
	if pv <= 0:
		get_parent().queue_free()
	
func _process(delta: float) -> void:
	pass

func on_hit() :
	hit.emit()
	pass

func change_color(new_color:int):
	enemy_sprite_2d.frame = new_color
