class_name ObjectAnchor extends Node2D

var object: Node2D

func _ready() -> void:
	add_to_group("object_anchor", true)
	object = get_child(0)
