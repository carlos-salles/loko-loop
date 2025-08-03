extends CharacterBody2D
class_name Player

@export var speed = 300.0
@onready var grid_movement : GridMovement = $GridMovement
@onready var animation_player:AnimationPlayer = $AnimationPlayer

var last_direction := Vector2.ZERO

func _ready() -> void:
	Global.player = self
	reset(false)
	start()

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	movement()

func reset(is_full_reset: bool):
	set_physics_process(false)
	
func start():
	set_physics_process(true)

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
		else: 
			animation_player.play("Idle")
			$Sprite2D.frame_coords.x = 0
		dir = Vector2(0, input_y)
		
	if dir != Vector2.ZERO:
		if grid_movement.sprite_pos_tween and grid_movement.sprite_pos_tween.is_running():
			return
			
		var body = grid_movement.get_body_torwards(dir)
		if body == null:
			grid_movement.move(dir)
		elif body.has_node("GridMovement"):
			var gm = body.get_node("GridMovement") as GridMovement
			if gm.push(dir):
				var audio = gm.get_parent().get_node("AudioStreamPlayer2D") as AudioStreamPlayer2D
				grid_movement.move(dir)
				var pos = audio.get_playback_position()
				if pos == 0 || pos > 0.25:
					audio.play()
