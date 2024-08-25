extends Area2D

func _process(delta):
	translate(transform.x * 350 * delta)
