extends CharacterBody2D
class_name Player

@export var speed = 300.0
@onready var grid_movement : GridMovement = $GridMovement

var last_direction := Vector2.ZERO

func _ready() -> void:
	Global.player = self


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	movement()
	
	

func movement():
	var input_x := Input.get_axis("ui_left", "ui_right")
	var input_y := Input.get_axis("ui_up", "ui_down")
	
	var dir: Vector2
	if input_x != 0:
		dir = Vector2(input_x, 0)
	else:
		dir = Vector2(0, input_y)
		
	if dir != Vector2.ZERO:
		var body = grid_movement.get_body_torwards(dir)
		if body == null:
			grid_movement.move(dir)
		else:
			var gm = body.get_node("GridMovement")
			if gm and (gm as GridMovement).push(dir):
				grid_movement.move(dir)
	
	
