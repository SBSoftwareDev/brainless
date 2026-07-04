extends Sprite2D

@onready var empty_cell: Sprite2D = $"."

func _on_area_2d_mouse_entered() -> void:
	empty_cell.texture = load("res://assets/img/cell/cell_sprite_locked_highlighted.png")

func _on_area_2d_mouse_exited() -> void:
	empty_cell.texture = load("res://assets/img/cell/cell_sprite_locked.png")
