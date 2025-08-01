extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var current_camera = get_viewport().get_camera_2d()
		current_camera.transform = get_parent().transform
