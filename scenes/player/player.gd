extends CharacterBody2D
class_name Player


@export var speed = 300.0

func _ready() -> void:
	Global.player = self

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if Input.is_action_just_pressed("interact"):
		InteractionManager.handle_interaction()
		
	var input_x := Input.get_axis("ui_left", "ui_right")
	var input_y := Input.get_axis("ui_up", "ui_down")
	
	var direction  = Vector2(input_x, input_y).normalized()
		
	velocity = direction * speed
	move_and_slide()
