extends Sprite2D

@export var speed: int = 500
var velocity: Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2(1,0).rotated(rotation)
	global_position += (velocity * speed*delta)
	
	if not (global_position.x <= 1280 and global_position.x >= 0
		and global_position.y <= 720 and global_position.y >= 0):
		queue_free()
