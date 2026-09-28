extends Node2D

@onready var level_container: Node2D = $level_container

const PERFECT_DIST: float = 12.0
const MAX_DIST: float = 120.0 

func _ready() -> void:
	load_level()

func next_level() -> void:
	pass

func menu() -> void:
	pass

func retry() -> void:
	pass

func load_level() -> void:
	var level: Node2D = load(Registry.levels[GameManager.level - 1]).instantiate()
	for c in level_container.get_children():
		c.queue_free()
	
	level_container.add_child(level)

func submit_layout() -> void:
	var anchors: Array = Util.get_group_nodes("object_anchor")
	var total_score: float = 0.0
	
	for anchor in anchors:
		var object: Node2D = anchor.object
		total_score += score_object(anchor, object)
	
	var final_score: float = total_score / max(anchors.size(), 1)
	
	# open end screen
	# set score
	
	# check if unlocked next level or not based on score

func score_object(anchor: Node2D, object: Node2D) -> float:
	var dist := object.global_position.distance_to(anchor.global_position)
	var pos_score := 1.0 - clampf(inverse_lerp(PERFECT_DIST, MAX_DIST, dist), 0.0, 1.0)
	
	return pos_score
