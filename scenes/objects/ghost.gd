class_name Ghost extends AnimatedSprite2D

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	anim.play("rise")
