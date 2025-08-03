extends StaticBody2D

@export var required_buttons: Array[Node2D]
@export var start_raised: bool = true
var raised: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset(false)
	start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	set_state(not all_buttons_pressed())


func all_buttons_pressed():
	if required_buttons.size() == 0:
		return false
	for button in required_buttons:
		if not button.active:
			return false
	return true

func set_state(raised: bool):
	if self.raised != raised:
		if raised:
			raise_spikes()
		else:
			lower_spikes()
	self.raised = raised

func raise_spikes():
	$CollisionShape2D.set_deferred("disabled", false)
	$Sprite2D.frame = 0

func lower_spikes():
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.frame = 1
	
func reset(is_full_reset: bool):
	set_state(start_raised)
	
func start():
	pass
