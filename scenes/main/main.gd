extends Node2D

@onready var submit_button: Button = $CanvasLayer/submit
@onready var level_container: Node2D = $level_container
@onready var tutorial: Control = $CanvasLayer/tutorial

@onready var end_screen: Control = $CanvasLayer/end_screen
@onready var end_screen_animation: AnimationPlayer = $CanvasLayer/end_screen/AnimationPlayer

@onready var photograph: Control = $CanvasLayer/photograph
@onready var photograph_animation: AnimationPlayer = $CanvasLayer/photograph/AnimationPlayer
@onready var timer_label: Label = $CanvasLayer/photograph/background/timer
@onready var photo: TextureRect = $CanvasLayer/photograph/background/photo

@onready var photo_timer: Timer = $CanvasLayer/photograph/photo_timer
@onready var next_button: Button = $CanvasLayer/end_screen/next_level

@onready var end_image: TextureRect = $CanvasLayer/end_screen/photo/image
@onready var end_photo: ColorRect = $CanvasLayer/end_screen/photo

@onready var menu_button: Button = $CanvasLayer/end_screen/menu
@onready var retry_button: Button = $CanvasLayer/end_screen/retry

const PERFECT_DIST: float = 12.0
const MAX_DIST: float = 120.0 
var submitted: bool = false

func _ready() -> void:
	load_level()
	
	if GameManager.level == 1:
		tutorial.show()
	else:
		tutorial.hide() 
		show_photograph()

func next_level() -> void:
	GameManager.level += 1

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
	if submitted: return
	submitted = true
	
	var anchors: Array = Util.get_group_nodes("object_anchor")
	var total_score: float = 0.0
	
	for anchor in anchors:
		var object: Node2D = anchor.object
		total_score += score_object(anchor, object)
	
	var final_score: int = int((total_score / max(anchors.size(), 1)) * 100)
	submit_button.hide()
	
	end_image.texture = load(Registry.UID["level_%d" % GameManager.level])
	end_screen.show()
	end_screen_animation.play("open")
	await end_screen_animation.animation_finished
	
	if final_score >= 75 and GameManager.level < 6:
		GameManager.locked_levels[GameManager.level + 1] = false
		next_button.show()

func score_object(anchor: Node2D, object: Node2D) -> float:
	var dist := object.global_position.distance_to(anchor.global_position)
	var pos_score := 1.0 - clampf(inverse_lerp(PERFECT_DIST, MAX_DIST, dist), 0.0, 1.0)
	
	return pos_score

func tutorial_continue() -> void:
	tutorial.hide()
	show_photograph()

func show_photograph() -> void:
	photo.texture = load(Registry.UID["level_%d" % GameManager.level])
	
	photograph.show()
	photograph_animation.play("show")
	await photograph_animation.animation_finished
	photo_timer.start()
	await photo_timer.timeout
	photograph_animation.play_backwards("show")
	await photograph_animation.animation_finished
	photograph.hide()

func _process(_delta: float) -> void:
	if not photo_timer.is_stopped():
		timer_label.text = str(int(photo_timer.time_left)) + " secs"
