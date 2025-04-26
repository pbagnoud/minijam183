#
# Give the component a class name so it can be instanced as a custom node
class_name ShakeComponent
extends Node

# Export the node that this component will be shaking
@export var node: Node2D
@export var max_shake_px: = 10.0
@export var shake_decrease_duration: = 0.6
@export var shake_increase_duration: = 0.6
@export var shake_x_axis: = true
@export var shake_y_axis: = true
var shake = 0

# This is the function that activates this component
func tween_shake():
	# Create a tween
	var tween = create_tween()
	
	# Tween the shake value from current down to 0 over the shake duration
	tween.tween_property(self, "shake",max_shake_px, shake_increase_duration)
	print('end increase')
	tween.tween_property(self, "shake", 0.0, shake_decrease_duration)
	print('end decrease')
func _physics_process(delta: float) -> void:
	# Manipulate the position of the node by the shake amount every physics frame
	# Use randf_range to pick a random x and y value using the shake value
	node.position = Vector2(randf_range(-shake, shake)*int(shake_x_axis), randf_range(-shake, shake)*int(shake_y_axis))
