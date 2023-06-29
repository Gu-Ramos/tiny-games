extends Node

var main_node: Node2D = null
# Called when the node enters the scene tree for the first time.
func instance_node(node, pos, parent):
	var instance = node.instantiate()
	parent.add_child(instance)
	instance.global_position = pos
	
func restart():
	var enemies = get_tree().get_nodes_in_group("enemy")
	for e in enemies:
		e.queue_free()
	main_node.get_node("Player").global_position = Vector2(640,360)
	main_node.get_node("Player").dead = false
	main_node.get_node("Player").modulate = Color(1,1,1)
