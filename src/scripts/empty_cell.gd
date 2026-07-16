extends Sprite2D

@onready var empty_cell: Sprite2D = $"."
@onready var price_panel :Control = $"../../../../UILayer/UIRoot/PricePanel"
@onready var economy: Node = $"../../../../Systems/Economy"
@onready var level: Node2D = $"../.."

var mouseInside :bool = false
var newCell

@onready var cell_group: Node2D = $".."

func _ready() -> void:
	newCell = preload("res://src/scenes/bee_and_cell.tscn").instantiate()
	price_panel.visible = false
	
func _process(_delta: float) -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	#empty_cell.texture = load("res://assets/img/cell/cell_sprite_locked_highlighted.png")
	material.set_shader_parameter("light", 0.5)
	price_panel.visible = true
	mouseInside = true

func _on_area_2d_mouse_exited() -> void:
	#empty_cell.texture = load("res://src/scenes/empty_cell.tscn::AtlasTexture_rjsee")
	material.set_shader_parameter("light", 1.0)
	price_panel.visible = false
	mouseInside = false
	


func replaceSelf() -> void:
	var bought :bool = economy.buyCell()
	if bought:
		cell_group.add_cell_count()
		newCell.position = empty_cell.position
		get_parent().add_child(newCell)
		price_panel.visible = false
		queue_free()
		
		if level.checkAllBees():
			get_tree().change_scene_to_file("res://src/scenes/end.tscn")
	else:
		return


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if mouseInside && event.is_action_released("Select"):
		replaceSelf()
