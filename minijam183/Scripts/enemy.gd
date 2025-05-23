extends CharacterBody2D

signal hit
signal freeze(time)
signal dot(amount)
signal push_back(amount)
signal split(color: int)
@onready var dot_change: ColorChange = $DOT

@onready var blink_component: BlinkComponent = $BlinkComponent
@onready var shake_component: ShakeComponent = $ShakeComponent
@onready var color_change: ColorChange = $ColorChange
@onready var blink_dot: BlinkComponent = $BlinkDOT

@onready var enemy_sprite_2d: AnimatedSprite2D = $EnemySprite2D

@onready var vulnerable_timer: Timer = $vulnerableTimer
@onready var invincible_timer: Timer = $invincibleTimer
@onready var shield_sprite: Sprite2D = $ShieldSprite

@onready var is_invincible = false


#Sound assets
@onready var normal_hit: AudioStreamPlayer2D = $hit_sounds/normal_hit
@onready var color_hit: AudioStreamPlayer2D = $hit_sounds/color_hit
var c=['#00FFC3','#FF00D8','#FFB200','#96FF00','#FFFFFF']
const EXPLOSION = preload("res://Scenes/explosion.tscn")
var real_position: Vector2
var pv: int = 4:
	set(value):
		pv=value
		check_life()
		
var color: int = 1:
	set(value):
		if color<4:
			color=value
			change_color(value)
		
var is_split: bool

func _ready() -> void:
	change_color(color)

func get_dot(amount):
	if amount==0:
		return
	dot_change.color_tween()
	blink_dot.blink()
	await get_tree().create_timer(3).timeout
	pv -= amount*2
	shake_component.tween_shake()
	color_change.color_tween()
	
func get_hurt(body):
	if body.color == color:
		color_hit.playing = true
		pv -= body.power * 2 + body.color_power *3
		blink_component.blink()
		shake_component.tween_shake()
		color_change.color_tween()
	else:
		normal_hit.playing = true
		pv -= body.power
		shake_component.tween_shake()
		color_change.color_tween()

	
func apply_effect(body):
	if body.freeze_time>0:
		freeze.emit(body.freeze_time)
	if body.has_color_change:
		color=body.color
		
	print('dot',body.dot_damage)
	get_dot(body.dot_damage)
	push_back.emit(body.enemy_pushback_distance * 100)
	
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet") and not is_invincible :
		get_hurt(body)
		apply_effect(body)
		body.hit_something()

func check_life():
	if pv <= 0:
		# If the character is a Green virus, which is not already small, split it
		if color == 3 or color == 4:
			print(is_split)
			if not is_split:
				split.emit(color)
		var explosion = EXPLOSION.instantiate()
		explosion.color = c[color]
		explosion.position = get_parent().position
		get_tree().root.add_child(explosion)
		explosion.emitting=true
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
		vulnerable_timer.start()
	if new_color == 3:
		enemy_sprite_2d.play("green_enemy")
	if new_color == 4:
		enemy_sprite_2d.play("boss_enemy")
	if not new_color == 2:
		is_invincible = false
		shield_sprite.visible = false

### Gestion de l'invincibilité pour ennemis oranges

func _on_vulnerable_timer_timeout() -> void:
	if color == 2:
		is_invincible = true
		shield_sprite.visible = true
		invincible_timer.start()	

func _on_invincible_timer_timeout() -> void:
	is_invincible = false
	shield_sprite.visible = false
	if color == 2:
		vulnerable_timer.start()
