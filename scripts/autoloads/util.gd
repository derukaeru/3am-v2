extends Node

func get_player() -> Node3D:
	return get_tree().get_first_node_in_group("player")
	
func get_main() -> Node3D:
	return get_tree().current_scene

func get_group_node(group: String) -> Node:
	return get_tree().get_first_node_in_group(group)

func get_group_nodes(group: String) -> Array:
	return get_tree().get_nodes_in_group(group)
