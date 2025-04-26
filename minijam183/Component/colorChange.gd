extends Node
class_name ColorChange
signal twin_finished
@export var duration:= .3
@export var color:= Color(1,1,1,1)
@export var target: AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func color_tween():
	var tween = create_tween()
	tween.finished.connect(_on_tween_finished)
	tween.tween_property(target, "modulate",color, duration)
	print('end')

func _on_tween_finished():
	print('on twin f')
	emit_signal('twin_finished')
	color_reset()
	
func color_reset():
	print('in')
	var tween = create_tween()
	tween.tween_property(target, "modulate",Color(1,1,1,1), .1 )
	
