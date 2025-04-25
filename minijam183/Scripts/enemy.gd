extends CharacterBody2D

signal hit

var real_position: Vector2

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet") :
		get_parent().queue_free()
	
func _process(delta: float) -> void:
	pass

func on_hit() :
	hit.emit()
	pass
