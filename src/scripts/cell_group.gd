extends Node2D

const CELL_QUANTITY :int = 21
var cell_purchases :int = 0

var first_bee

@onready var queen_area: Node2D = $QueenArea
@onready var economy: Node = %Economy

func _ready() -> void:
	first_bee = preload("res://src/scenes/bee_and_cell.tscn").instantiate()
	
	global_position = Vector2.ZERO
	position = Vector2.ZERO
	cell_purchases = find_children("BeeAndCell*","",false).size()


func add_cell_count() -> void:
	cell_purchases += 1
	if cell_purchases >= CELL_QUANTITY:
		queen_area.find_child("Queen*").activate_queen()


func add_middle_bee() -> void:
	var middle_cell :Node2D = find_child("Empty Cell Middle")
	first_bee.position = middle_cell.position
	add_child(first_bee)
	economy.bees += 1
	cell_purchases += 1
	middle_cell.queue_free()
