extends Area2D
class_name InteractArea

signal interacted
signal selected
signal unselected

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		InteractionManager.register_area(self)
	
func _on_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		InteractionManager.unregister_area(self)
	
func interact():
	interacted.emit()
