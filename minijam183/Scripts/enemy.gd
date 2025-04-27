extends CharacterBody2D

signal hit
signal freeze(time)
signal dot(amount)
signal push_back(amount)
signal split

@onready var blink_component: BlinkComponent = $BlinkComponent
@onready var shake_component: ShakeComponent = $ShakeComponent
@onready var color_change: ColorChange = $ColorChange

@onready var enemy_sprite_2d: AnimatedSprite2D = $EnemySprite2D


var real_position: Vector2
var pv: int = 4:
	set(value):
		pv=value
		check_life()
		
var color: int = 1:
	set(value):
		color=value
		change_color(value)
		
var is_split: bool

func _ready() -> void:
	change_color(color)

func get_dot(amount):
	await get_tree().create_timer(10).timeout
	pv -= amount*2
func get_hurt(body):
	if body.color == color:
		pv -= body.power * 2 + body.color_power *3
		blink_component.blink()
		shake_component.tween_shake()
		color_change.color_tween()
	else:
		pv -= body.power
		shake_component.tween_shake()
		color_change.color_tween()

	
func apply_effect(body):
	if body.freeze_time>0:
		freeze.emit(body.freeze_time)
	if body.has_color_change:
		change_color(body.color)
	get_dot(body.dot_damage)
	push_back.emit(body.enemy_pushback_distance * 100)
	
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet") :
		get_hurt(body)
		apply_effect(body)
		body.hit_something()

func check_life():
	if pv <= 0:
		# If the character is a Green virus, which is not already small, split it
		if color == 3:
			print(is_split)
			if not is_split:
				split.emit()
		get_parent().queue_free()
	
func _process(delta: float) -> void:
	pass

func on_hit() :
	hit.emit()
	pass

func change_color(new_color:int):
	#enemy_sprite_2d.frame = new_color
	if new_color == 0:
		enemy_sprite_2d.play("blue_enemy")
	if new_color == 1:
		enemy_sprite_2d.play("red_enemy")
	if new_color == 2:
		enemy_sprite_2d.play("orange_enemy")
	if new_color == 3:
		enemy_sprite_2d.play("green_enemy")
