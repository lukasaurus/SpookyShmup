extends CharacterBody2D
@export var health = 10
@export var speed = 100
const PROJECTILE = preload("res://Scenes/projectile.tscn")
@onready var progress_bar: ProgressBar = $CanvasLayer/ProgressBar

func _ready():
	progress_bar.max_value = health
	progress_bar.value = health
	
func _process(delta: float) -> void:
	var move = Input.get_vector("left","right","up","down")
	if move:
		velocity = move * speed
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()

	if Input.is_action_just_pressed("shoot"):
		var new_projectile = PROJECTILE.instantiate()
		new_projectile.global_position = global_position
		add_sibling(new_projectile)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		health-=1
		area.explode()
		progress_bar.value = health
		if health <= 0:
			get_tree().reload_current_scene()
			
	if area.is_in_group("EnemyBullet"):
		area.queue_free()
		health-=1

		progress_bar.value = health
		if health <= 0:
			get_tree().reload_current_scene()
			
	if area.is_in_group("HealthUp"):
		health+=3
		area.queue_free()
		if health > progress_bar.max_value:
			health = progress_bar.max_value
		progress_bar.value = health
		
			#later switch to game over screen
			#get_tree().change_scene_to_file("res://scene/gameover.tscn")
