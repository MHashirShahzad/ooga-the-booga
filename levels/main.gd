extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("[MainFPS] %s" % Engine.get_frames_per_second())


func _on_level_end_body_entered(body: Node2D) -> void:
	if body is Player2D:
		SFXManager.play_FX(SFXManager.level_end_sfx_array.pick_random(), 1, 1, 1)
		TransitionManager.transition_scene_file("res://levels/level0.tscn")
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
