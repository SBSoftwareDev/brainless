extends Sprite2D

@onready var empty_cell: Sprite2D = $"."
@onready var price_panel :Control = $"../../../UILayer/UIRoot/PricePanel"

func _ready() -> void:
	price_panel.visible = false

func _on_area_2d_mouse_entered() -> void:
	empty_cell.texture = load("res://assets/img/cell/cell_sprite_locked_highlighted.png")
	price_panel.visible = true

func _on_area_2d_mouse_exited() -> void:
	empty_cell.texture = load("res://assets/img/cell/cell_sprite_locked.png")
	price_panel.visible = false
