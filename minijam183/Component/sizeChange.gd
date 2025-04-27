extends Node
class_name SizeChange
signal twin_finished
@export var duration:= .3
@export var max_size:= Vector2(2,2)
@export var target: Node2D
@onready var size_change: SizeChange = $"."

# Called when the node enters the scene tree for the first time.
func size_tween():
	var tween = create_tween()
	#tween.finished.connect(_on_tween_finished)
	tween.tween_property(target, "scale",max_size, duration)
	print('end')

func _ready():
	#size_change.size_tween()
	pass
	
func _on_tween_finished():
	#print('on twin f')
	emit_signal('twin_finished')
	color_reset()
	
func color_reset():
	#print('in')
	var tween = create_tween()
	tween.tween_property(target, "scale",Vector2(1,1), .1 )
	

	
