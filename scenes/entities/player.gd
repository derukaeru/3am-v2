class_name Player extends CharacterBody2D

const SPEED = 120.0

func _physics_process(_delta: float) -> void:
	
	
	var direction = Input.get_axis("left", "right")
	if direction:
		direction = direction.normalized()
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 0.4)
	
	move_and_slide()
