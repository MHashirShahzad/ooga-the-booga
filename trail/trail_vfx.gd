extends Line2D
class_name Trail2D

var queue : Array[Vector2]
@export var max_length : int

@export var can_spawn_new_points : bool = true:
	set(value):
		if value == true:
			if !can_spawn_new_points: # if wasnt true already
				queue = []
		
		can_spawn_new_points = value
	
var last_stored_position : Vector2


func _process(delta: float) -> void:
	if can_spawn_new_points:
		last_stored_position = get_parent().position
	
	queue.push_front(last_stored_position)
	
	if queue.size() > max_length:
		queue.pop_back()
	
	clear_points()
	
	for point in queue:
		add_point(point)
