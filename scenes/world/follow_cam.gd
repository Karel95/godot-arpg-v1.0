extends Camera2D

@export var follow_node: Node2D

func _process(delta):
	global_position = follow_node.global_position
	
