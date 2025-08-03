extends Node

@export var loop_duration_seconds:= 8.0
@export var total_timers: int = 3
var finished_timers: int = 0


@export var root_node: Node
var reset_nodes: Array

var running_tween_count := 0

var remaining_timers: int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_nodes_in_group("reset")
	register_nodes(root_node)
	start_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func register_nodes(root_node: Node) -> void:
	self.root_node = root_node
	var f = func (node): return root_node.is_ancestor_of(node)
	var m1 = func (node: Node2D): return {"node": node, "pos": node.global_position, "keep": false} 
	var m2 = func (node: Node2D): return {"node": node, "pos": node.global_position, "keep": true}
	reset_nodes = get_tree().get_nodes_in_group("reset").filter(f).map(m1) as Array[Dictionary]
	var keep_nodes = get_tree().get_nodes_in_group("keep").filter(f).map(m2) as Array[Dictionary]
	
	reset_nodes.append_array(keep_nodes)

func reset_position(node: Node2D, pos: Vector2, tween: Tween):
	var current_pos = node.global_position
	var sprite = node.get_node("Sprite2D")
	
	node.global_position = pos
	sprite.global_position = current_pos
	

	tween.tween_property(sprite, "global_position", pos, 1)


func reset(is_full_reset: bool):
	var tween = create_tween()
	tween.pause()
	tween.set_parallel(true)
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_trans(Tween.TRANS_SINE)

	for x in reset_nodes:
		x.node.reset(is_full_reset)
		if is_full_reset or not x.keep:
			reset_position(x.node, x.pos, tween)
	tween.play()
	await tween.finished
	start()

func start():
	for x in reset_nodes:
		x.node.start()

func start_timer():
	var index = total_timers -1 - finished_timers
	var sprite = $HBoxContainer.get_child(index).get_node("AnimatedSprite2D") as AnimatedSprite2D
	sprite.play("running", 8 / loop_duration_seconds)
	$Timer.start()
	

func _on_timer_timeout() -> void:
	finished_timers += 1
	if (finished_timers == total_timers):
		for hourglass in $HBoxContainer.get_children():
			var sprite = get_node("AnimatedSprite2D") as AnimatedSprite2D
			sprite.play("spin", 1.0)
		reset(true)
	else:
		reset(false)
	
	sand_animation()

func sand_animation():
	var particles = $CPUParticles2D as CPUParticles2D
	particles.emitting = true
	await get_tree().create_timer(1.0).timeout
	particles.emitting = false
	
	
	
