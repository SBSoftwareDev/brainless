extends Sprite2D

const SPEED :float = 150.0

@onready var path_follow_2d: PathFollow2D = $"../"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name.begins_with("Worker"):
		body.leave_cell()


func _process(delta: float) -> void:
	path_follow_2d.progress += delta * SPEED
