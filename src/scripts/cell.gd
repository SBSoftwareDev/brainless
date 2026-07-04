extends Sprite2D

@onready var cell_cooldown: Timer = $"../Worker Bee/CellCooldown"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_parent() == get_parent():
		cell_cooldown.start()
