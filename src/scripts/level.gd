extends Node2D

const OFFSET :float = 200.0

@onready var bee_hole: Sprite2D = %BeeHole

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var groups = find_children("CellGroup*","",false)
	
	#Start off with one bee in the first group
	groups[0].call_deferred("add_middle_bee")
	
	groups[0].global_position = Vector2(bee_hole.global_position.x + OFFSET, bee_hole.global_position.y)
	groups[1].global_position = Vector2(bee_hole.global_position.x, bee_hole.global_position.y + OFFSET)
	groups[2].global_position = Vector2(bee_hole.global_position.x - OFFSET, bee_hole.global_position.y)
	groups[3].global_position = Vector2(bee_hole.global_position.x, bee_hole.global_position.y - OFFSET)
