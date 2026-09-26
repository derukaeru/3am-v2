extends Sprite2D

func patch_up() -> void:
	texture = load(Registry.UID.gravedirt)
	
	var ghost: Ghost = load(Registry.UID.ghost).instantiate()
	add_child(ghost)
