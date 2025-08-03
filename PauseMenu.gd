extends CanvasLayer

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if !visible:
			visible = true
			get_tree().paused = true

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menu.tscn")

func _on_restart_button_pressed() -> void:
	get_parent().get_node("LoopManager").force_reset()
	get_tree().paused = false
	visible = false
