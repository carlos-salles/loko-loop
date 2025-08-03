extends AnimatableBody2D

@export var keep: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if keep:
		add_to_group("keep")
		$Effect.visible = true
	
	reset(false)
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func reset(is_full_reset: bool):
	pass
	
func start():
	pass
