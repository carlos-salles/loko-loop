extends Area2D

@export var active: bool

signal activated
signal deactivated

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_state(active)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_state(active: bool):
	self.active = active
	if active:
		$Sprite2D.frame = 5
		activated.emit()
	else:
		$Sprite2D.frame = 6
		deactivated.emit() 

func _on_body_entered(body: Node2D) -> void:
	print("HI")
	if body.is_in_group("heavy"):
		set_state(true)


func _on_body_exited(body: Node2D) -> void:
	print("BYE")
	if body.is_in_group("heavy"):
		set_state(false)
