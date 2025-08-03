extends Area2D

func snap_player():
	var p = Global.player
	p.global_position = p.global_position.snapped(Vector2(16, 16)) + Vector2(8, 8)
	
func _on_body_entered(body: Node2D) -> void:
	var lm = Global.loop_manager
	if body is Player and lm and lm.root_node != get_parent():
		print(get_parent().name + ": LEVEL CHANGED")
		snap_player()
		var current_camera = get_viewport().get_camera_2d()
		current_camera.transform = get_parent().transform
		lm.register_nodes(get_parent())
		lm.force_reset()
