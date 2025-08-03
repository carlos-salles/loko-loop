extends Area2D

func _on_body_entered(body: Node2D) -> void:
	var lm = Global.loop_manager
	if body is Player and lm.root_node != get_parent():
		var current_camera = get_viewport().get_camera_2d()
		current_camera.transform = get_parent().transform
		lm.register_nodes(get_parent())
		lm.force_reset()
