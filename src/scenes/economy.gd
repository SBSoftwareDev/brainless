extends Node

var nectar :int = 0
var bees :int = 0

@onready var entities: Node2D = $"../../World/Entities"

func _ready() -> void:
	bees = entities.find_children("Bee*", "", false).size()

func addNectar(value :int) -> int:
	nectar += value
	return nectar
	
func getNectarAmount() -> int:
	return nectar
	
func getBeeAmount() -> int:
	return bees
