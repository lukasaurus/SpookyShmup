extends Area2D
var speed = 220
@onready var spin_timer: Timer = $SpinTimer
@onready var burst_timer: Timer = $BurstTimer
@onready var timer: Timer = $Timer
@onready var bullet_patterns = [spin_timer,burst_timer]
var max_bullets = 20
var current_bullets = 0
var burst_angle = -180
var spin_angle = 140
const ENEMY_BULLET = preload("res://Scenes/enemy_bullet.tscn")
var boss_y_position = 0
var health = 5
const EXPLOSION = preload("res://Scenes/explosion.tscn")


func _process(delta: float) -> void:
	translate(Vector2.LEFT * speed * delta)
	boss_y_position +=1
	position.y += sin(boss_y_position * delta-80)
	
	


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	speed = 0
	timer.start()


func _on_timer_timeout() -> void:
	current_bullets = 0
	bullet_patterns.pick_random().start()
	

func _on_burst_timer_timeout() -> void:
	if current_bullets > max_bullets:
		burst_timer.stop()
		return
	var bullet = ENEMY_BULLET.instantiate()
	bullet.global_position = global_position
	bullet.rotation_degrees = burst_angle + randi_range(-5,5)
	add_sibling(bullet)
	current_bullets +=1
	
	
func _on_spin_timer_timeout() -> void:
	if current_bullets > max_bullets:
		spin_timer.stop()
		spin_angle = 140
		return
	var bullet = ENEMY_BULLET.instantiate()
	bullet.global_position = global_position
	spin_angle+=5
	bullet.rotation_degrees= spin_angle
	add_sibling(bullet)
	current_bullets +=1


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile"):
		area.queue_free()
		health -=1
		if health <= 0: explode()
		
func explode():
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		add_sibling(explosion)
		queue_free()
		await get_tree().create_timer(2)
		#add the change to win screen here
		#get_tree().change_scene_to_file("win.tscn")
		
