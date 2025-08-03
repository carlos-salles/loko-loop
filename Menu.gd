extends Control

func _ready() -> void:
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(func(): on_button_pressed(button))
		button.mouse_exited.connect(func(): mouse_interaction(button, "exited"))
		button.mouse_entered.connect(func(): mouse_interaction(button, "entered"))
		
func on_button_pressed(button: Button) -> void:
	get_tree().set_meta("previous_scene", get_tree().current_scene.scene_file_path)
	match button.name:
		"Play":
			var _game: bool = get_tree().change_scene_to_file("res://scenes/levels/full_map.tscn")
		"Quit":
			if OS.has_feature("web"):
				OS.alert("Obrigado por jogar! Feche a aba para sair.", "Espero que você tenha gostado")
			else:
				get_tree().quit()
			
func mouse_interaction(button: Button, state: String) -> void:
	match state:
		"exited":
			button.modulate.a = 1.0
		"entered":
			button.modulate.a = 0.5
