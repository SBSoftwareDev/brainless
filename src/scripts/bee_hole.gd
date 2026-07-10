extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_bee_hole_area_body_entered(body: Node2D) -> void:
	if body.name.begins_with("Worker"):
		body.enter_bee_hole()
