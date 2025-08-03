extends CharacterBody2D
class_name Player

@export var speed = 300.0
@onready var grid_movement : GridMovement = $GridMovement
@onready var animation_player:AnimationPlayer = $AnimationPlayer

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
		if input_x > 0: animation_player.play("Right")
		else: animation_player.play("Left")
		dir = Vector2(input_x, 0)
	else:
		if input_y > 0: animation_player.play("Down")
		elif input_y < 0: animation_player.play("Up")
		#else: animation_player.play("Idle")
		dir = Vector2(0, input_y)
		
	if dir != Vector2.ZERO:
		if grid_movement.sprite_pos_tween and grid_movement.sprite_pos_tween.is_running():
			return
			
		var body = grid_movement.get_body_torwards(dir)
		if body == null:
			grid_movement.move(dir)
		else:
			var gm = body.get_node("GridMovement")
			if gm and (gm as GridMovement).push(dir):
				print(gm.get_parent().name)
				grid_movement.move(dir)
	
	
