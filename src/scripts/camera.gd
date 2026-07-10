extends Node2D

const SPEED :float = 1.5
const WORLD_MIN :Vector2 = Vector2(-750, -500)
const WORLD_MAX :Vector2 = Vector2(750, 500)

var screen_size :Vector2 = Vector2.ZERO

@onready var camera: Camera2D = $Camera2D
@onready var bee_hole: Sprite2D = %BeeHole
@onready var ui_root: Control = $"../../UILayer/UIRoot"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera.global_position = Vector2(bee_hole.global_position.x + ui_root.get_child(0).size.x / 2, bee_hole.global_position.y)
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = Input.get_vector("Camera Left", "Camera Right", "Camera Up", "Camera Down")
	position += direction * SPEED
	clamp_to_world()


func clamp_to_world() -> void:
	global_position.x = clamp(global_position.x, WORLD_MIN.x + (screen_size.x / 2), WORLD_MAX.x - (screen_size.x / 2))
	global_position.y = clamp(global_position.y, WORLD_MIN.y + (screen_size.y / 2), WORLD_MAX.y - (screen_size.y / 2))
