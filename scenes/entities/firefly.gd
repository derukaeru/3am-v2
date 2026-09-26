class_name Firefly extends Node2D

@onready var point_light: PointLight2D = $PointLight2D
@export var freq: float = 0.4
@export var min_scale: float = 0.3
@export var max_scale: float = 0.8
var noise := FastNoiseLite.new()

func _ready() -> void:
	noise.seed = randi()
	freq += randf_range(-0.2, 0.2)

func _process(_delta: float) -> void:
	var t := Time.get_ticks_msec() / 1000.0
	var s := sin(t * freq * TAU)
	var flicker := noise.get_noise_1d(t * 2.0)
	point_light.texture_scale = remap(s, -1.0, 1.0, min_scale, max_scale) + flicker * 0.1
