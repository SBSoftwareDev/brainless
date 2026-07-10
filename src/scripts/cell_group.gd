extends Node2D

const CELL_QUANTITY :int = 21
var cell_purchases :int = 0

@onready var queen_area: Node2D = $QueenArea

func _ready() -> void:
	cell_purchases = find_children("BeeAndCell*","",false).size()


func add_cell_count() -> void:
	cell_purchases += 1
	if cell_purchases >= CELL_QUANTITY:
		queen_area.find_child("Queen*").activate_queen()
		
