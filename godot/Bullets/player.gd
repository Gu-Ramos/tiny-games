extends Sprite2D

@export var speed: int = 300
var velocity: Vector2 = Vector2(0,0)
var dead: bool = false
var can_shoot: bool = true
const bullet_scene: PackedScene = preload("res://Bullet.tscn")
const blood_scene: PackedScene = preload("res://Blood.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not dead:
		$Gun.look_at(get_global_mouse_position())
		velocity = Input.get_vector("move_left","move_right","move_up","move_down").normalized()
		if get_global_mouse_position().x < global_position.x:
			$Gun.flip_v = true
			flip_h = true
		else:
			$Gun.flip_v = false
			flip_h = false
		global_position += velocity * speed*delta
		
		global_position.x = clamp(global_position.x, 0,1280)
		global_position.y = clamp(global_position.y, 0,720)
		
		if Input.is_action_pressed("left_click") and can_shoot:
			$Shoot_timer.start()
			can_shoot = false
			var bullet = bullet_scene.instantiate()
			if flip_h:
				bullet.global_position = global_position + Vector2(24,4).rotated($Gun.rotation)
			else:
				bullet.global_position = global_position + Vector2(24,-4).rotated($Gun.rotation)
			bullet.look_at(get_global_mouse_position())
			Global.main_node.add_child(bullet)


func _on_area_2d_area_entered(area):
	if not dead:
		modulate = Color(1,0,0)
		$Death_timer.start()
		
		var blood = blood_scene.instantiate()
		blood.emitting = true
		blood.one_shot = false
		blood.global_position = global_position
		Global.main_node.add_child(blood)
		
	dead = true


func _on_death_timer_timeout():
	Global.restart()


func _on_shoot_timer_timeout():
	can_shoot = true
