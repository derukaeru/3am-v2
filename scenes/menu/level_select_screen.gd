extends Control

func _ready() -> void:
	for i in len(GameManager.locked_levels):
		var level_button: Button = get_node("levels_background/levels/level_%d" % (i + 1))
		level_button.disabled = GameManager.locked_levels[i]

func go_to_level(level: int) -> void:
	GameManager.level = level
	SceneChanger.change_scene("main")

func unlock_level(level: int) -> void:
	var level_button: Button = get_node("levels_background/levels/level_%d" % level)
	level_button.disabled = false
