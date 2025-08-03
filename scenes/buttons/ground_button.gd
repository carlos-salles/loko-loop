extends Area2D

@export var active: bool
@export var keep: bool = false
var can_set_state: bool = true

signal activated
signal deactivated

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if keep:
		add_to_group("keep")
		$Effect.visible = true
	set_state(active)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_state(active: bool):
	self.active = active
	if active:
		$Sprite2D.frame = 5
		activated.emit()
		print("OK")
	else:
		$Sprite2D.frame = 6
		deactivated.emit() 

func _on_body_entered(body: Node2D) -> void:
	print("HI")
	if can_set_state and body.is_in_group("heavy"):
		set_state(true)


func _on_body_exited(body: Node2D) -> void:
	print("BYE")
	if can_set_state and body.is_in_group("heavy"):
		set_state(false)
		
func reset(is_full_reset: bool):
	set_state(active and keep)
	can_set_state = false
	
func start():
	can_set_state = true
