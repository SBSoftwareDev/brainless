extends Sprite2D

const SPEED :float = 150.0

var is_active :bool = false

@onready var path_follow_2d: PathFollow2D = $"../"

func _ready() -> void:
	visible = false

func activate_queen() -> void:
	is_active = true
	visible = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name.begins_with("Worker") && is_active:
		body.leave_cell()


func _process(delta: float) -> void:
	path_follow_2d.progress += delta * SPEED
