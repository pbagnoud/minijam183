extends CharacterBody2D

signal hit


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
	

func on_hit() :
	hit.emit()
	pass
