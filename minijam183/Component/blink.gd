extends Node
class_name BlinkComponent

@export var image: AnimatedSprite2D
@export var duration:= 1.5
@export var amount: = 3
signal reappear

func blink():
	var timer_duration = duration/amount/2
	print(timer_duration)
	for i in range(amount):
		image.visible = false
		await get_tree().create_timer(timer_duration).timeout
		image.visible = true
		reappear.emit
		await get_tree().create_timer(timer_duration).timeout
