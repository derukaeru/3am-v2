class_name DraggableComponent extends Area2D

var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO

func _ready() -> void:
	input_event.connect(input)

func input(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				drag_offset = global_position - get_global_mouse_position()
			else:
				dragging = false

func _process(_delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position() + drag_offset
