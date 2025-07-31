extends Node

var selected_area: InteractArea
var registered_areas : Array[InteractArea] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if registered_areas.size() > 0:
		registered_areas.sort_custom(area_sorter)
		var nearest = registered_areas[0]
		if selected_area != nearest:
			if selected_area:
				selected_area.unselected.emit()
			nearest.selected.emit()
			selected_area = nearest
	else:
		selected_area = null
	
func register_area(area: InteractArea):
	registered_areas.append(area)
	
func unregister_area(area: InteractArea):
	registered_areas.erase(area)
	
func handle_interaction() -> void:
	if selected_area:
		selected_area.interact()
	
func area_sorter(area1: InteractArea, area2: InteractArea) -> bool:
	var pos = Global.player.global_position
	var distance1 = pos.distance_squared_to(area1.global_position)
	var distance2 = pos.distance_squared_to(area2.global_position)
	return distance1 < distance2
