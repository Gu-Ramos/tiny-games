extends Node2D

# Called when the node enters the scene tree for the first time.
@onready var spawn_location: PathFollow2D = get_node("spawn_zone/spawn_location")
const zombie_scene: PackedScene = preload("res://zombie.tscn")

func _ready():
	Global.main_node = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.dead:
		$Label.visible = true
	else:
		$Label.visible = false

func _on_spawn_timer_timeout():
	spawn_location.progress_ratio = randf()
	var zombie = zombie_scene.instantiate()
	zombie.global_position = spawn_location.position
	
	add_child(zombie)
