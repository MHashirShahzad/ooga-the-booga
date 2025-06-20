extends Area2D

@export var next_level : PackedScene 

var player : Player2D

@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var polygon_2d_2: Polygon2D = $Polygon2D2


func _process(delta: float) -> void:
	polygon_2d.rotation_degrees += delta * 40
	polygon_2d_2.rotation_degrees -= delta * 40
	
	


func _on_body_entered(body: Node2D) -> void:
	if body is Player2D:
		if !next_level:
			return
		player = body
		player.can_take_input = false
		TransitionManager.transition_scene_packed(next_level)
		var new_diamond : Polygon2D = body.diamond_2d.duplicate()
		new_diamond.scale = Vector2(0,0)
		new_diamond.color = Color(0.916, 0.917, 0.58)
		body.sprite_2d.add_child(new_diamond)
		var tween : Tween = get_tree().create_tween()
	
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_QUAD)
		tween.set_parallel(true)
		tween.tween_property(new_diamond, "scale", Vector2(1,1), .2)
		await tween.finished
		tween.kill()

		
