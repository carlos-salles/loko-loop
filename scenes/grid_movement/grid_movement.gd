extends Node2D
class_name GridMovement

@onready var body: Node2D = get_parent()
@export var sprite: Node2D
@export var pushable: bool
@export var max_previous_body_count: int = 0

const tiles_per_second : int = 6
const move_duration_seconds := 1.0/(tiles_per_second-1)

const TILE_SIZE := Vector2i(16, 16)
var sprite_pos_tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func push(dir: Vector2, previous_body_count: int = 0) -> bool:	
	if sprite_pos_tween and sprite_pos_tween.is_running():
		return false
	
	if not pushable or previous_body_count > max_previous_body_count:
		return false

	
	var next_body = get_body_torwards(dir)
	if next_body == null:
		move(dir.normalized().ceil())
		return true
	
	var gm = next_body.get_node("GridMovement")
	if gm and (gm as GridMovement).push(dir, previous_body_count + 1):
		move(dir.normalized().ceil())
		return true

	return false


func get_body_torwards(dir: Vector2) -> CollisionObject2D:
	var global_pos = body.global_position
	dir = dir.normalized().ceil()

	var l = TILE_SIZE.x
	var a = global_pos + 0.6*l * dir
	var b = global_pos + 0.8*l * dir

	if dir == Vector2.RIGHT:
		return $Right.get_collider()
	if dir == Vector2.DOWN:
		return $Down.get_collider()
	if dir == Vector2.LEFT:
		return $Left.get_collider()
	if dir == Vector2.UP:
		return $Up.get_collider()
	return null




func move(tiles: Vector2) -> void:
	if sprite_pos_tween and sprite_pos_tween.is_running():
		print("running")
		return
		
	var movement = Vector2(tiles.x * TILE_SIZE.x, tiles.y * TILE_SIZE.y)
	body.global_position += movement
	if sprite:
		sprite.global_position -= movement
		if sprite_pos_tween:
			sprite_pos_tween.kill()
		sprite_pos_tween = create_tween()
		sprite_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		sprite_pos_tween.tween_property(sprite, "global_position", body.global_position, move_duration_seconds)
		sprite_pos_tween.set_trans(Tween.TRANS_SINE)
	
