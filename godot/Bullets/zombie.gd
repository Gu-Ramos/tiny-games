extends Sprite2D

@export var speed: int = 110
var velocity: Vector2 = Vector2(0,0)
var hp: int = 2
const blood_scene: PackedScene = preload("res://Blood.tscn")
const transparency: Color = Color(1,1,1,0)
@onready var Player = Global.main_node.get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2(1,0).rotated(get_angle_to(Player.global_position))
	global_position += velocity * speed*delta
	
	$Mask.modulate = lerp($Mask.modulate, transparency, delta*5)
	$Mask.self_modulate = lerp($Mask.self_modulate, transparency, delta*5)
	
	if Player.global_position.x < global_position.x:
		$Mask.flip_h = true
		flip_h = true
	else:
		$Mask.flip_h = false
		flip_h = false
	
	if hp <= 0:
		queue_free()
	

func _on_area_2d_area_entered(area):
	area.get_parent().queue_free()
	$Mask.modulate = Color(1,1,1,0.85)
	$Mask.self_modulate = Color(1,1,1,0.85)
	
	var blood = blood_scene.instantiate()
	blood.emitting = true
	blood.global_position = global_position
	Global.main_node.add_child(blood)
	
	hp -= 1
