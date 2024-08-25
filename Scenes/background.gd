extends Node2D

func _process(delta: float) -> void:
	translate(Vector2.LEFT * 30 * delta)


func _on_end_of_level_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Scenes/world2.tscn")
