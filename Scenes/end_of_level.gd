extends Area2D
func _process(delta: float) -> void:
	translate(Vector2.LEFT * 200 * delta)
